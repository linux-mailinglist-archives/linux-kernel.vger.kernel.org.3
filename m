Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1969E4B9579
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiBQB1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:27:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiBQB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:27:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BC6C3304
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645061252; x=1676597252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2s852d69HKRu7KkCWF3s3N7SJOQDb8gU6rAyAVg4JKo=;
  b=jyOWnGQgxEQfak7Mlr0DbI3STWFVHH95FpwN41qABJEW7BCyg1fUi+xt
   5tdxIan65m1KQe+66+7J3AAo8UkAD4RAO7ora1P+OOXxwSHU2M/5nzc1f
   1qfMUUP2+weN3qUynNNJEsCDBjDOWqKBIpBzmkw8bQqFxDJrKIV97ngSZ
   6CQU+H/hF0wpkv6/k38QudtbROOnzS5ETpZPqjA6AIcU0PCljIIUGPDmE
   ZIO/w26W044eV9JOl7GGPLW5iRs7RBvVWhnu89zcHaLaL6ul0JZwL7veB
   JqunEkVOTdaVwH/Ry7dZv/gj19QkmkBep3OagbsvHwY8PSBriOk2mta+D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248362556"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="248362556"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 17:27:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="636813356"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 17:27:31 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/split_lock: Make life miserable for split lockers
Date:   Wed, 16 Feb 2022 17:27:21 -0800
Message-Id: <20220217012721.9694-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In https://lore.kernel.org/all/87y22uujkm.ffs@tglx/ Thomas
said:

  Its's simply wishful thinking that stuff gets fixed because of a
  WARN_ONCE(). This has never worked. The only thing which works is to
  make stuff fail hard or slow it down in a way which makes it annoying
  enough to users to complain.

He was talking about WBINVD. But it made me think about how we
use the split lock detection feature in Linux.

Existing code has three options for applications:
1) Don't enable split lock detection (allow arbitrary split locks)
2) Warn once when a process uses split lock, but let the process
   keep running with split lock detection disabled
3) Kill process that use split locks

Option 2 falls into the "wishful thinking" territory that Thomas
warns does nothing. But option 3 might not be viable in a situation
with legacy applications that need to run.

Hence a new option to "slow it down in a way which makes it annoying".

Primary reason for this change is to provide better quality of service
to the rest of the applications running on the system. Internal
testing shows that even with many processes splitting locks, performance
for the rest of the system is much more responsive.

Add a new choice to the existing "split_lock_detect" boot parameter
"sequential". In this mode split lock detection is enabled. When an
application tries to execute a bus lock the #AC handler.

1) Blocks (interruptibly) until it can get the semaphore
	If interrupted, just return. Assume the signal will either
	kill the task, or direct execution away from the instruction
	that is trying to get the bus lock.
2) Disables split lock detection for the current core
3) Schedules a work queue to re-enable split lock detect in 2 jiffies
4) Returns

The work queue that re-enables split lock detection also releases the
semaphore.

There is a corner case where a CPU may be taken offline while
split lock detection is disabled. A CPU hotplug handler handles
this case.

Questions for this RFC:

1) Does this need to be a new option? Maybe just update the
   existing "warn" mode to add this level of extra pain.
2) Under what circumstances will work a function scheduled with
   schedule_delayed_work() run on different CPU? I've covered
   the obvious case of the CPU being taken offline before the
   work is run. But are there other cases?
3) Should I add even more pain with an msleep() before even trying
   to get the semaphore?

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 67 ++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..a331c4a71847 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -7,10 +7,13 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/semaphore.h>
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 #include <linux/delay.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -43,6 +46,7 @@ enum split_lock_detect_state {
 	sld_warn,
 	sld_fatal,
 	sld_ratelimit,
+	sld_sequential,
 };
 
 /*
@@ -1002,10 +1006,13 @@ static const struct {
 	{ "warn",	sld_warn  },
 	{ "fatal",	sld_fatal },
 	{ "ratelimit:", sld_ratelimit },
+	{ "sequential", sld_sequential },
 };
 
 static struct ratelimit_state bld_ratelimit;
 
+static DEFINE_SEMAPHORE(buslock_sem);
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt), ratelimit;
@@ -1045,7 +1052,7 @@ static bool split_lock_verify_msr(bool on)
 
 static void __init sld_state_setup(void)
 {
-	enum split_lock_detect_state state = sld_warn;
+	enum split_lock_detect_state state = sld_sequential;
 	char arg[20];
 	int i, ret;
 
@@ -1116,23 +1123,60 @@ static void split_lock_init(void)
 		split_lock_verify_msr(sld_state != sld_off);
 }
 
+static void __split_lock_reenable(struct work_struct *work)
+{
+	sld_update_msr(true);
+	up(&buslock_sem);
+}
+
+/*
+ * If a CPU goes offline with pending delayed work to
+ * re-enable split lock detection then the delayed work
+ * will be executed on some other CPU. That handles releasing
+ * the buslock_sem, but because it executes on a different
+ * CPU probably won't re-enable split lock detection. This
+ * is a problem on HT systems since the sibling CPU on the
+ * same core may then be left running with split lock
+ * detection disabled.
+ *
+ * Unconditionally re-enable detection here.
+ */
+static int splitlock_cpu_offline(unsigned int cpu)
+{
+	sld_update_msr(true);
+
+	return 0;
+}
+
+static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
+
 static void split_lock_warn(unsigned long ip)
 {
 	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
 			    current->comm, current->pid, ip);
 
-	/*
-	 * Disable the split lock detection for this task so it can make
-	 * progress and set TIF_SLD so the detection is re-enabled via
-	 * switch_to_sld() when the task is scheduled out.
-	 */
+	switch (sld_state) {
+	case sld_warn:
+		/* This task will keep running with split lock disabled */
+		set_tsk_thread_flag(current, TIF_SLD);
+		break;
+	case sld_sequential:
+		/* Only allow one buslocked disabled core at a time */
+		if (down_interruptible(&buslock_sem) == -EINTR)
+			return;
+		schedule_delayed_work(&split_lock_reenable, 2);
+		break;
+	default:
+		break;
+	}
+
+	/* Disable split lock detection to make progress */
 	sld_update_msr(false);
-	set_tsk_thread_flag(current, TIF_SLD);
 }
 
 bool handle_guest_split_lock(unsigned long ip)
 {
-	if (sld_state == sld_warn) {
+	if (sld_state == sld_warn || sld_state == sld_sequential) {
 		split_lock_warn(ip);
 		return true;
 	}
@@ -1191,6 +1235,7 @@ void handle_bus_lock(struct pt_regs *regs)
 		/* Warn on the bus lock. */
 		fallthrough;
 	case sld_warn:
+	case sld_sequential:
 		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, regs->ip);
 		break;
@@ -1299,6 +1344,12 @@ static void sld_state_show(void)
 		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 			pr_info("#DB: setting system wide bus lock rate limit to %u/sec\n", bld_ratelimit.burst);
 		break;
+	case sld_sequential:
+		pr_info("#AC: crashing the kernel on kernel split_locks and forcing sequential access for user-space split locks\n");
+		if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				      "x86/splitlock", NULL, splitlock_cpu_offline) < 0)
+			pr_warn("No splitlock CPU offline handler\n");
+		break;
 	}
 }
 
-- 
2.35.1

