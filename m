Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D984BAFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiBRCwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:52:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiBRCwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:52:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD8F0F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:51:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F189161D58
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A8BC340E8;
        Fri, 18 Feb 2022 02:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645152709;
        bh=Jm3w12VcfuG2PcElJQ1zfIEWf0Ug/A1q4/IfTczCWto=;
        h=Date:To:From:Subject:From;
        b=U98jao0NwfMHHs3OFoXa0x4QTWwheTbcXHDbqreG5xukQ/3Lsq0Kce4miMEqceBMO
         pccJxyunXHmRwM3wiQIW/tVVul+nwA9GVbknCdHgjEqQxY084v5YGqldMubTIom+7p
         WIBz++Kc1MdpBPX1+bTrGfc1REq+Dsntouq9O67c=
Date:   Thu, 17 Feb 2022 18:51:48 -0800
To:     yzaikin@google.com, sfr@canb.auug.org.au, mhocko@suse.com,
        keescook@chromium.org, sujiaxun@uniontech.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/2] mm: move oom_kill sysctls to their own file
Message-Id: <20220218025149.40A8BC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sujiaxun <sujiaxun@uniontech.com>
Subject: mm: move oom_kill sysctls to their own file

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we just
care about the core logic.

So move the oom_kill sysctls to their own file, mm/oom_kill.c

[sfr@canb.auug.org.au: null-terminate the array]
  Link: https://lkml.kernel.org/r/20220216193202.28838626@canb.auug.org.au
Link: https://lkml.kernel.org/r/20220215093203.31032-1-sujiaxun@uniontech.com
Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kees Cook <keescook@chromium.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/oom.h |    4 ----
 kernel/sysctl.c     |   23 -----------------------
 mm/oom_kill.c       |   38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 30 deletions(-)

--- a/include/linux/oom.h~mm-move-oom_kill-sysctls-to-their-own-file
+++ a/include/linux/oom.h
@@ -123,8 +123,4 @@ extern void oom_killer_enable(void);
 
 extern struct task_struct *find_lock_task_mm(struct task_struct *p);
 
-/* sysctls */
-extern int sysctl_oom_dump_tasks;
-extern int sysctl_oom_kill_allocating_task;
-extern int sysctl_panic_on_oom;
 #endif /* _INCLUDE_LINUX_OOM_H */
--- a/kernel/sysctl.c~mm-move-oom_kill-sysctls-to-their-own-file
+++ a/kernel/sysctl.c
@@ -2355,29 +2355,6 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_TWO,
 	},
 	{
-		.procname	= "panic_on_oom",
-		.data		= &sysctl_panic_on_oom,
-		.maxlen		= sizeof(sysctl_panic_on_oom),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "oom_kill_allocating_task",
-		.data		= &sysctl_oom_kill_allocating_task,
-		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "oom_dump_tasks",
-		.data		= &sysctl_oom_dump_tasks,
-		.maxlen		= sizeof(sysctl_oom_dump_tasks),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
 		.procname	= "overcommit_ratio",
 		.data		= &sysctl_overcommit_ratio,
 		.maxlen		= sizeof(sysctl_overcommit_ratio),
--- a/mm/oom_kill.c~mm-move-oom_kill-sysctls-to-their-own-file
+++ a/mm/oom_kill.c
@@ -52,9 +52,38 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/oom.h>
 
-int sysctl_panic_on_oom;
-int sysctl_oom_kill_allocating_task;
-int sysctl_oom_dump_tasks = 1;
+static int sysctl_panic_on_oom;
+static int sysctl_oom_kill_allocating_task;
+static int sysctl_oom_dump_tasks = 1;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_oom_kill_table[] = {
+	{
+		.procname	= "panic_on_oom",
+		.data		= &sysctl_panic_on_oom,
+		.maxlen		= sizeof(sysctl_panic_on_oom),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{
+		.procname	= "oom_kill_allocating_task",
+		.data		= &sysctl_oom_kill_allocating_task,
+		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "oom_dump_tasks",
+		.data		= &sysctl_oom_dump_tasks,
+		.maxlen		= sizeof(sysctl_oom_dump_tasks),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{}
+};
+#endif
 
 /*
  * Serializes oom killer invocations (out_of_memory()) from all contexts to
@@ -680,6 +709,9 @@ static void wake_oom_reaper(struct task_
 static int __init oom_init(void)
 {
 	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", vm_oom_kill_table);
+#endif
 	return 0;
 }
 subsys_initcall(oom_init)
_
