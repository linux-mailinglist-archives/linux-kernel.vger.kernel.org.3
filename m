Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8C52A0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbiEQLrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEQLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:47:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E126121;
        Tue, 17 May 2022 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HIV4LYaBaZEzH3VbJpzxB26/QYZ19hr9VK8W0eYe864=; b=MkRwaucpwLpkBOY0CRtte0b0tH
        QGBJfD0wLVPelZze9XPHmhku/RdqYirRo89JT9KYU6/XgrCWHcGlAsN0dalWehMbVqy7yNsMaUVtb
        VBMBJ9VK6xrHv7zTPfUuy0vbxMwtxaLW5L4ei0OPCY37yXxlqBxg1zgJCyVNOUs9IQonvfVoNBdZe
        rsvhNGlMCqhbvkOIz7fgwSP6hgQdLHPbIDMiVDrAzfT+iPGB8DtKrlNCKO/9j4QtsoyE3C/TBJxm0
        uzSpIHUrzr4HsvbtmjgXWTAaV8MhSHlJNi5dzZbsNRghptVj9QTL5tXIHy3r/uCfnxzMEdhjDebqK
        Jnb7ERdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqvfE-00Aoxu-80; Tue, 17 May 2022 11:46:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B5A030031C;
        Tue, 17 May 2022 13:46:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B64A203BF9EE; Tue, 17 May 2022 13:46:54 +0200 (CEST)
Date:   Tue, 17 May 2022 13:46:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Message-ID: <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
References: <20220517030024.3388355-1-keescook@chromium.org>
 <202205162032.5161269A45@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205162032.5161269A45@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:33:25PM -0700, Kees Cook wrote:

> I just need to start today over.

:-)

Also, even with this sorted, there's a ton array bound things left.
Please don't just mangle the code until it stops complaining like in the
previous postings of these patches.

As such, I'm only barely ok with the below patch. Ideally I'd shoot GCC
in the head. Its *really* tedious you cannot just tell it to shut up
already.

---
Subject: sched: Reverse sched_class layout

Because GCC-12 is fully stupid about array bounds and it's just really
hard to get a solid array definition from a linker script, flip the
array order to avoid needing negative offsets :-/

This makes the whole relational pointer magic a little less obvious, but
alas.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++------
 kernel/sched/core.c               | 12 ++++++------
 kernel/sched/sched.h              | 15 ++++++++-------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 69138e9db787..7515a465ec03 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -126,13 +126,13 @@
  */
 #define SCHED_DATA				\
 	STRUCT_ALIGN();				\
-	__begin_sched_classes = .;		\
-	*(__idle_sched_class)			\
-	*(__fair_sched_class)			\
-	*(__rt_sched_class)			\
-	*(__dl_sched_class)			\
+	__sched_class_highest = .;		\
 	*(__stop_sched_class)			\
-	__end_sched_classes = .;
+	*(__dl_sched_class)			\
+	*(__rt_sched_class)			\
+	*(__fair_sched_class)			\
+	*(__idle_sched_class)			\
+	__sched_class_lowest = .;
 
 /* The actual configuration determine if the init/exit sections
  * are handled as text/data or they can be discarded (which
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95bac3b094b3..a247f8d9d417 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2193,7 +2193,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	else if (p->sched_class > rq->curr->sched_class)
+	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
 		resched_curr(rq);
 
 	/*
@@ -5692,7 +5692,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
-	if (likely(prev->sched_class <= &fair_sched_class &&
+	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
@@ -9472,11 +9472,11 @@ void __init sched_init(void)
 	int i;
 
 	/* Make sure the linker didn't screw up */
-	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
-	       &fair_sched_class + 1 != &rt_sched_class ||
-	       &rt_sched_class + 1   != &dl_sched_class);
+	BUG_ON(&idle_sched_class != &fair_sched_class + 1 ||
+	       &fair_sched_class != &rt_sched_class + 1 ||
+	       &rt_sched_class   != &dl_sched_class + 1);
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
+	BUG_ON(&dl_sched_class != &stop_sched_class + 1);
 #endif
 
 	wait_bit_init();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fe4d1acb7e38..2ce18584dca3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2177,6 +2177,8 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
  *
  *   include/asm-generic/vmlinux.lds.h
  *
+ * *CAREFUL* they are laid out in *REVERSE* order!!!
+ *
  * Also enforce alignment on the instance, not the type, to guarantee layout.
  */
 #define DEFINE_SCHED_CLASS(name) \
@@ -2185,17 +2187,16 @@ const struct sched_class name##_sched_class \
 	__section("__" #name "_sched_class")
 
 /* Defined in include/asm-generic/vmlinux.lds.h */
-extern struct sched_class __begin_sched_classes[];
-extern struct sched_class __end_sched_classes[];
-
-#define sched_class_highest (__end_sched_classes - 1)
-#define sched_class_lowest  (__begin_sched_classes - 1)
+extern struct sched_class __sched_class_highest[];
+extern struct sched_class __sched_class_lowest[];
 
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class--)
+	for (class = (_from); class < (_to); class++)
 
 #define for_each_class(class) \
-	for_class_range(class, sched_class_highest, sched_class_lowest)
+	for_class_range(class, __sched_class_highest, __sched_class_lowest)
+
+#define sched_class_above(_a, _b)	((_a) < (_b))
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
