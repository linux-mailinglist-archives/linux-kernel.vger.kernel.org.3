Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3933E4D533A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbiCJUuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiCJUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:50:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29AA18646F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646945344; x=1678481344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrFDnEHjWGlNjQ0AvbIlRUCriIxyzYtQjLpxtio4/14=;
  b=J1yZ7uGj6cxDzpCJNw63Nk2Ln9mO/kRTNdK5+MfDUDihHXbj+6t6s5RI
   VmiFTFmqqi+vplNLq7+rHd4lHAp39AUIYVwGZF+aEXNrjrP2xAU1fZfEa
   8I8emyYZ7L3FVRrRMFexHmsGVETQrZC6WLlue+Z7+XCBoLat4v5xoj9ZU
   dyb7CNVu83UCYNarx3MhuSlO2pN401aJ2JQa5WBpuNP0c7fszdFZP3FE1
   TYLNbCWQo61kEymt3LFIkkPVChkCJeiOmVHjLoTFlmmFITHMOElUT46mC
   ANB8nTmNTCRW7SicpZicFWtv2OlRTEyObwFn1QwouYt9gMvangKPXZV4j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254205624"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254205624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 12:49:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554843294"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 12:49:03 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 1/2] x86/split_lock: Make life miserable for split lockers
Date:   Thu, 10 Mar 2022 12:48:53 -0800
Message-Id: <20220310204854.31752-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310204854.31752-1-tony.luck@intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Hence make option 2 much stricter to "slow it down in a way which makes
it annoying".

Primary reason for this change is to provide better quality of service
to the rest of the applications running on the system. Internal
testing shows that even with many processes splitting locks, performance
for the rest of the system is much more responsive.

The new "warn" mode operates like this.  When an application tries to
execute a bus lock the #AC handler.

1) Delays (interruptibly) 10 ms before moving to next step.
2) Blocks (interruptibly) until it can get the semaphore
	If interrupted, just return. Assume the signal will either
	kill the task, or direct execution away from the instruction
	that is trying to get the bus lock.
3) Disables split lock detection for the current core
4) Schedules a work queue to re-enable split lock detect in 2 jiffies
5) Returns

The work queue that re-enables split lock detection also releases the
semaphore.

There is a corner case where a CPU may be taken offline while
split lock detection is disabled. A CPU hotplug handler handles
this case.

Old behaviour was to only print the split lock warning on
the first occurrence of a split lock from a task. Preserve
that by adding a flag to the task structure that suppresses
subsequent split lock messages from that task.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 65 +++++++++++++++++++++++++++++++------
 include/linux/sched.h       |  3 ++
 kernel/fork.c               |  5 +++
 3 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..2536784511e3 100644
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
@@ -1006,6 +1009,8 @@ static const struct {
 
 static struct ratelimit_state bld_ratelimit;
 
+static DEFINE_SEMAPHORE(buslock_sem);
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt), ratelimit;
@@ -1116,18 +1121,54 @@ static void split_lock_init(void)
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
-	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-			    current->comm, current->pid, ip);
+	int cpu;
 
-	/*
-	 * Disable the split lock detection for this task so it can make
-	 * progress and set TIF_SLD so the detection is re-enabled via
-	 * switch_to_sld() when the task is scheduled out.
-	 */
+	if (!current->reported_split_lock)
+		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
+				    current->comm, current->pid, ip);
+	current->reported_split_lock = 1;
+
+	/* misery factor #1, sleep 10ms before trying to execute split lock */
+	if (msleep_interruptible(10) > 0)
+		return;
+	/* Misery factor #2, only allow one buslocked disabled core at a time */
+	if (down_interruptible(&buslock_sem) == -EINTR)
+		return;
+	cpu = get_cpu();
+	schedule_delayed_work_on(cpu, &split_lock_reenable, 2);
+
+	/* Disable split lock detection on this CPU to make progress */
 	sld_update_msr(false);
-	set_tsk_thread_flag(current, TIF_SLD);
+	put_cpu();
 }
 
 bool handle_guest_split_lock(unsigned long ip)
@@ -1281,10 +1322,14 @@ static void sld_state_show(void)
 		pr_info("disabled\n");
 		break;
 	case sld_warn:
-		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
 			pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
-		else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					      "x86/splitlock", NULL, splitlock_cpu_offline) < 0)
+				pr_warn("No splitlock CPU offline handler\n");
+		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
 			pr_info("#DB: warning on user-space bus_locks\n");
+		}
 		break;
 	case sld_fatal:
 		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..ffa7166e23d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -938,6 +938,9 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
 #endif
+#ifdef	CONFIG_CPU_SUP_INTEL
+	unsigned			reported_split_lock:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index f1e89007f228..085d68d143b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -970,6 +970,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_CPU_SUP_INTEL
+	tsk->reported_split_lock = 0;
+#endif
+
 	return tsk;
 
 free_stack:
-- 
2.35.1

