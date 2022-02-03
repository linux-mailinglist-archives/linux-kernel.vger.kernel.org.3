Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B14A869D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351721AbiBCOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351332AbiBCOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF5EC06173B;
        Thu,  3 Feb 2022 06:33:43 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAyphi8GUVcsIw21fZnBuks9vuLeVomTTfPBNxbLeHY=;
        b=lsfySTsNKJ8p1VQ2gTYq1rAYW1XMpR1SEct1f0XtYzvzPkZrjqLCqxNWVy4gZIQiHcvXAA
        t1N3rVYgRSOhwWh1D/AF5Baz85dn/+QOsjWbGi0715LcBzyTW4FYNkJvKrv/avLJ57XN3G
        qrADqSkdv3pJV788EOhwZOfSnSse8ey49++4AKHwWRwaz6IwiPc4K2biCs3CSmsCsIGSg1
        7zwvBJoKKdWkdWHA1WH5Xynb1qFzc9vBqPX2NFgarcycEOIQLxZHTpEpgoq86Tl5qBKfnW
        5gTsMfSLCE2E4TZIcC4scwUyBKbiR3diWUkL2Fp88fsIpOKG8JxAAt9QPuAxEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAyphi8GUVcsIw21fZnBuks9vuLeVomTTfPBNxbLeHY=;
        b=QDph10v0n/dixK6OMMBBR6gBN0pBTZiCvuyND3hITD58NFDx3H1pI/DiT16EDapNzRHCeG
        HKr/xoqUrlBm1ABw==
From:   "tip-bot2 for Zhen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: move autogroup sysctls into its own file
Cc:     Zhen Ni <nizhen@uniontech.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220128095025.8745-1-nizhen@uniontech.com>
References: <20220128095025.8745-1-nizhen@uniontech.com>
MIME-Version: 1.0
Message-ID: <164389882096.16921.11832456621387796894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c8eaf6ac76f40f6c59fc7d056e2e08c4a57ea9c7
Gitweb:        https://git.kernel.org/tip/c8eaf6ac76f40f6c59fc7d056e2e08c4a57ea9c7
Author:        Zhen Ni <nizhen@uniontech.com>
AuthorDate:    Fri, 28 Jan 2022 17:50:25 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:37 +01:00

sched: move autogroup sysctls into its own file

move autogroup sysctls to autogroup.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220128095025.8745-1-nizhen@uniontech.com
---
 include/linux/sched/sysctl.h |  4 ----
 kernel/sched/autogroup.c     | 23 +++++++++++++++++++++++
 kernel/sched/autogroup.h     |  1 +
 kernel/sysctl.c              | 11 -----------
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a..3f2b70f 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -45,10 +45,6 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
 
-#ifdef CONFIG_SCHED_AUTOGROUP
-extern unsigned int sysctl_sched_autogroup_enabled;
-#endif
-
 extern int sysctl_sched_rr_timeslice;
 extern int sched_rr_timeslice;
 
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 8629b37..31dd259 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -9,6 +9,28 @@ unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
 static atomic_t autogroup_seq_nr;
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_autogroup_sysctls[] = {
+	{
+		.procname       = "sched_autogroup_enabled",
+		.data           = &sysctl_sched_autogroup_enabled,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static void __init sched_autogroup_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_autogroup_sysctls);
+}
+#else
+#define sched_autogroup_sysctl_init() do { } while (0)
+#endif
+
 void __init autogroup_init(struct task_struct *init_task)
 {
 	autogroup_default.tg = &root_task_group;
@@ -198,6 +220,7 @@ void sched_autogroup_exit(struct signal_struct *sig)
 static int __init setup_autogroup(char *str)
 {
 	sysctl_sched_autogroup_enabled = 0;
+	sched_autogroup_sysctl_init();
 
 	return 1;
 }
diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index b964199..90fcbfd 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -27,6 +27,7 @@ extern bool task_wants_autogroup(struct task_struct *p, struct task_group *tg);
 static inline struct task_group *
 autogroup_task_group(struct task_struct *p, struct task_group *tg)
 {
+	extern unsigned int sysctl_sched_autogroup_enabled;
 	int enabled = READ_ONCE(sysctl_sched_autogroup_enabled);
 
 	if (enabled && task_wants_autogroup(p, tg))
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b..1cb7ca6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1750,17 +1750,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
 #endif
-#ifdef CONFIG_SCHED_AUTOGROUP
-	{
-		.procname	= "sched_autogroup_enabled",
-		.data		= &sysctl_sched_autogroup_enabled,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.procname	= "sched_cfs_bandwidth_slice_us",
