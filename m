Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D375833F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiG0UJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiG0UJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:09:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733705B07D;
        Wed, 27 Jul 2022 13:09:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so3784410pjh.0;
        Wed, 27 Jul 2022 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=uTgIj8Jnc8C3glCkB43cHSprO89lcSZhvQFZjknzees=;
        b=AzsKzyQPHizvJrtoVSpr/gdZeMFt9JHEGyfdCkojbk9jJfQ59eJJKT+zwW7LG2yWme
         YdX/fZo8zRfrWIMA+4q5YA4/pejIKLkTKf4q4ktnHdS8zyn4STifIzvnaZxOaWGE+uAI
         tfyGNWBKT3UfWwRt6SthlhYlq1CMEmeebXq3jZ9cHo7faVsBapu0Ey1sM6bR0dk5W7yM
         vCM1q7vv/EUmP4w1IT8pGmsf5vQIcEqRqcdLoludpGDMAfrxrGt9/wmeMqgqG6rVehJm
         DFTpTJ4NfCC6zOvDheCsOe2tvUUSP/9cO0na8erqRqOXiq93TX3qCZdAh7wy4CoV+P3e
         KMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=uTgIj8Jnc8C3glCkB43cHSprO89lcSZhvQFZjknzees=;
        b=6P8v2VRapEBxNl83vucT3w6A4uHkAQg/yBHVAYwsjQy61n3q5S/QICzHpEUMFy0zZS
         6vfVJ4wa/WCUYK/wxfEnVp1iHDe6BbMTLF9/2cy33n2KtggDpKeXdqYNpX0u2OemqS31
         dRmHNUrggG1B9MpiRzozVCoEh0h7QKhALA+j1p5xFwS81G+F1cHlkcX1t8SD5xKRhxB3
         twortPvtnr72vAUdErga+HDgpBrJLZ6PCAewl/7LEp2o2FRt9ZZl/fImJozEqGD4w3Iz
         tup2i4SEiFAYFBh6pLNkFHOder8P4tp5AsQljNwY/sj2wxozuHXSmjArCyIJMBEbOPMr
         k66g==
X-Gm-Message-State: AJIora+UVRUZBYS1tuU6K680/zsCqZ9R66y6LBSv0BuqVnhIT/P7LUll
        vN0XeGSTQa4VFoe4cxni+Yc=
X-Google-Smtp-Source: AGRyM1tsyIO/AhW9fKtQba8m2hu1OXLwXQlpbUhsNujlVBrTo5I7kJI84PhuB0AKEH1mpJsizvGufQ==
X-Received: by 2002:a17:903:248:b0:168:cf03:eefe with SMTP id j8-20020a170903024800b00168cf03eefemr23226171plh.124.1658952546854;
        Wed, 27 Jul 2022 13:09:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902be1200b0016784c93f23sm13971244pls.197.2022.07.27.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 13:09:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 10:09:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Lukasz Luba <Lukasz.Luba@arm.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <YuGbYCfAG81mZBnN@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
 <Ys41ZF5TmSnLLNRB@slm.duckdns.org>
 <CAB8ipk-8cbur-m733py-cw4bXCt7gkd8gAOXtKO+-fV1B2EeZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk-8cbur-m733py-cw4bXCt7gkd8gAOXtKO+-fV1B2EeZw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 20, 2022 at 03:45:27PM +0800, Xuewen Yan wrote:
> Dear all
> 
> On Wed, Jul 13, 2022 at 11:20 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Tue, Jul 12, 2022 at 10:49:57PM -0400, Waiman Long wrote:
> > > > Well, the only thing I can think of is always grabbing cpus_read_lock()
> > > > before grabbing threadgroup_rwsem. Waiman, what do you think?
> > >
> > > That is a possible solution as cpus_read_lock() is rather lightweight. It is
> > > a good practice to acquire it first.
> >
> > On a similar note, I think we probably should re-enable percpu operations on
> > threadgroup_rwsem too by default and allow users who are affected by slower
> > write path operations to opt-in. After the new CLONE_INTO_CGROUP which
> > doesn't need the rwsem, we have far fewer write lockers after all.
> >
> 
>  If there's any patch for me to try? I would be very grateful.

Can youp please see whether the following patch fixes the problem?

Thanks.

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 13c8e91d78620..7caefc8af9127 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2345,6 +2345,38 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 }
 EXPORT_SYMBOL_GPL(task_cgroup_path);
 
+/**
+ * lock_threadgroup - Stabilize threadgroups
+ *
+ * cgroup migration operations need the threadgroups stabilized against forks
+ * and exits, which can be achieved by write-locking cgroup_threadgroup_rwsem.
+ *
+ * Note that write-locking threadgdroup_rwsem is nested inside CPU hotplug
+ * disable. This is because cpuset needs CPU hotplug disabled during ->attach()
+ * and bringing up a CPU may involve creating new tasks which can require
+ * read-locking threadgroup_rwsem. If we call cpuset's ->attach() with
+ * threadgroup_rwsem write-locked with hotplug enabled, we can deadlock by
+ * cpuset waiting for an on-going CPU hotplug operation which in turn is waiting
+ * for the threadgroup_rwsem to be released to create new tasks. See the
+ * following for more details:
+ *
+ * http://lkml.kernel.org/r/20220711174629.uehfmqegcwn2lqzu@wubuntu
+ */
+static void lock_threadgroup(void)
+{
+	cpus_read_lock();
+	percpu_down_write(&cgroup_threadgroup_rwsem);
+}
+
+/**
+ * lock_threadgroup - Undo lock_threadgroup
+ */
+static void unlock_threadgroup(void)
+{
+	percpu_up_write(&cgroup_threadgroup_rwsem);
+	cpus_read_unlock();
+}
+
 /**
  * cgroup_migrate_add_task - add a migration target task to a migration context
  * @task: target task
@@ -2822,7 +2854,6 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *locked)
-	__acquires(&cgroup_threadgroup_rwsem)
 {
 	struct task_struct *tsk;
 	pid_t pid;
@@ -2840,7 +2871,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 */
 	lockdep_assert_held(&cgroup_mutex);
 	if (pid || threadgroup) {
-		percpu_down_write(&cgroup_threadgroup_rwsem);
+		lock_threadgroup();
 		*locked = true;
 	} else {
 		*locked = false;
@@ -2876,7 +2907,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 
 out_unlock_threadgroup:
 	if (*locked) {
-		percpu_up_write(&cgroup_threadgroup_rwsem);
+		unlock_threadgroup();
 		*locked = false;
 	}
 out_unlock_rcu:
@@ -2885,7 +2916,6 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 }
 
 void cgroup_procs_write_finish(struct task_struct *task, bool locked)
-	__releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
@@ -2894,7 +2924,8 @@ void cgroup_procs_write_finish(struct task_struct *task, bool locked)
 	put_task_struct(task);
 
 	if (locked)
-		percpu_up_write(&cgroup_threadgroup_rwsem);
+		unlock_threadgroup();
+
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
 			ss->post_attach();
@@ -2953,7 +2984,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	lock_threadgroup();
 
 	/* look up all csses currently attached to @cgrp's subtree */
 	spin_lock_irq(&css_set_lock);
@@ -2984,7 +3015,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	unlock_threadgroup();
 	return ret;
 }
 
