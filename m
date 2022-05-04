Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45B51A222
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351271AbiEDO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiEDO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:27:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3A20BC8;
        Wed,  4 May 2022 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bytPlWllFbXUh+y4MCYGituXos4p9j3B01XAJo0H3+E=; b=TnYqUjICVRT/3N3eRKski13fzl
        LcW+I3scGMM0C8sU16Tc+Th7Aek/tXKoDBWy/s9BCs2KzsrvddBDH3nCcJH+mP2Bf2r2puR+TsogC
        fm3dL2IFMK7bhPLlRSyDc8jUXm8vvJb4oCb2nEufIXOB2h2PXy/24vYBIm9p3ImDKK+rI4/7fVdza
        XslmI0lyQzDIJVKOUFCxcT2tSqJiVr7ltebssvIIHyrOhMRfMvw8v1CRHu4ZC+3Sxr5gSkbPyTqdr
        pG7z57FdzzIBZIZhtAbUCK8/y9Ku804m92zmQopBhnkeM/VykNFZcP4N2aKYxhNdMqfseDdAy0BTy
        TnQLJ6lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmFuR-00B5lf-VS; Wed, 04 May 2022 14:23:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E627980E57; Wed,  4 May 2022 16:23:19 +0200 (CEST)
Date:   Wed, 4 May 2022 16:23:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [RFC PATCH] sched: only perform capability check on
 privileged operation
Message-ID: <20220504142319.GB2501@worktop.programming.kicks-ass.net>
References: <20200904160031.6444-1-cgzones@googlemail.com>
 <20220502152414.110922-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502152414.110922-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 05:24:14PM +0200, Christian Göttsche wrote:
> sched_setattr(2) issues via kernel/sched/core.c:__sched_setscheduler()
> a CAP_SYS_NICE audit event unconditionally, even when the requested
> operation does not require that capability / is unprivileged, i.e. for
> reducing niceness.
> This is relevant in connection with SELinux, where a capability check
> results in a policy decision and by default a denial message on
> insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to allow
>      the task the capability CAP_SYS_NICE, while it does not need it,
>      violating the principle of least privilege.
> 
> Conduct privilged/unprivileged categorization first and perform a
> capable test (and at most once) only if needed.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Does something like so on top work?

---
 kernel/sched/core.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ba5a9a1ce1e5..d3b5a2757c5f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6931,17 +6931,27 @@ void set_user_nice(struct task_struct *p, long nice)
 EXPORT_SYMBOL(set_user_nice);
 
 /*
- * can_nice - check if a task can reduce its nice value
+ * is_nice_reduction - check if nice value is an actual reduction
+ *
  * @p: task
  * @nice: nice value
  */
-int can_nice(const struct task_struct *p, const int nice)
+static bool is_nice_reduction(const struct task_struct *p, const int nice)
 {
 	/* Convert nice value [19,-20] to rlimit style value [1,40]: */
 	int nice_rlim = nice_to_rlimit(nice);
 
-	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
-		capable(CAP_SYS_NICE));
+	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE));
+}
+
+/*
+ * can_nice - check if a task can reduce its nice value
+ * @p: task
+ * @nice: nice value
+ */
+int can_nice(const struct task_struct *p, const int nice)
+{
+	return is_nice_reduction(p, nice) || capable(CAP_SYS_NICE);
 }
 
 #ifdef __ARCH_WANT_SYS_NICE
@@ -7220,22 +7230,6 @@ static bool check_same_owner(struct task_struct *p)
 	return match;
 }
 
-/*
- * is_nice_reduction - check if nice value is an actual reduction
- *
- * Similar to can_nice() but does not perform a capability check.
- *
- * @p: task
- * @nice: nice value
- */
-static bool is_nice_reduction(const struct task_struct *p, const int nice)
-{
-	/* Convert nice value [19,-20] to rlimit style value [1,40]: */
-	int nice_rlim = nice_to_rlimit(nice);
-
-	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE));
-}
-
 /*
  * Allow unprivileged RT tasks to decrease priority.
  * Only issue a capable test if needed and only once to avoid an audit
@@ -7247,13 +7241,12 @@ static int user_check_sched_setscheduler(struct task_struct *p,
 {
 	if (fair_policy(policy)) {
 		if (attr->sched_nice < task_nice(p) &&
-			!is_nice_reduction(p, attr->sched_nice))
+		    !is_nice_reduction(p, attr->sched_nice))
 			goto req_priv;
 	}
 
 	if (rt_policy(policy)) {
-		unsigned long rlim_rtprio =
-		task_rlimit(p, RLIMIT_RTPRIO);
+		unsigned long rlim_rtprio = task_rlimit(p, RLIMIT_RTPRIO);
 
 		/* Can't set/change the rt policy: */
 		if (policy != p->policy && !rlim_rtprio)
@@ -7261,7 +7254,7 @@ static int user_check_sched_setscheduler(struct task_struct *p,
 
 		/* Can't increase priority: */
 		if (attr->sched_priority > p->rt_priority &&
-			attr->sched_priority > rlim_rtprio)
+		    attr->sched_priority > rlim_rtprio)
 			goto req_priv;
 	}
 
