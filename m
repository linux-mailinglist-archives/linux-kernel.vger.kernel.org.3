Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB851197B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiD0Nwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiD0Nwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:52:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7C2DABB;
        Wed, 27 Apr 2022 06:49:26 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WNipq/rNre4I0v09xw0R0I5DPKRx6iqSu8lBxcyam4=;
        b=tghio2v/KxNHs3tNdKz0gu3L2IS70cYBf59zQ1g0BeFNXRvDCxyWli/+HvZ2+4SIBeKo6I
        rjv2PfW6I+i5nmWuxc7j4XLf9HCLvCXsQKs1SO6tCx8HqnzhuCt/UUVYo+bEBpbKU48Ren
        HzM59m2C11oF9+zrW9tZgQ4UCeKBeSOHo7yOtms/41A0bSXoMdxgfB9Hpyew7bLPk5E7kQ
        OUurod8Ck+/l1C/IKOXRc7/5TXe2l+QHlOO5XjhzHnprwH1N6djV/hMAwn6q6GPeTlLQd3
        U6ZZES1hDcV6amN82foj88OnROZMcpXBLsaFyD53MOfrfIBDN5ITxinb3zdwbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WNipq/rNre4I0v09xw0R0I5DPKRx6iqSu8lBxcyam4=;
        b=xZ9Z8CiO0HAL3Oe/hzM5Kr7+a19mGVAixnp3rybQ/XPJcizMkvLXWt+tSbaJ0/d5baT4kt
        UkyJ1soj5xiaYKAw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/split_lock: Make life miserable for split lockers
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220310204854.31752-2-tony.luck@intel.com>
References: <20220310204854.31752-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <165106736419.4207.14598895272506250551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     b041b525dab95352fbd666b14dc73ab898df465f
Gitweb:        https://git.kernel.org/tip/b041b525dab95352fbd666b14dc73ab898df465f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 10 Mar 2022 12:48:53 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:43:38 +02:00

x86/split_lock: Make life miserable for split lockers

In https://lore.kernel.org/all/87y22uujkm.ffs@tglx/ Thomas
said:

  Its's simply wishful thinking that stuff gets fixed because of a
  WARN_ONCE(). This has never worked. The only thing which works is to
  make stuff fail hard or slow it down in a way which makes it annoying
  enough to users to complain.

He was talking about WBINVD. But it made me think about how we use the
split lock detection feature in Linux.

Existing code has three options for applications:

 1) Don't enable split lock detection (allow arbitrary split locks)
 2) Warn once when a process uses split lock, but let the process
    keep running with split lock detection disabled
 3) Kill process that use split locks

Option 2 falls into the "wishful thinking" territory that Thomas warns does
nothing. But option 3 might not be viable in a situation with legacy
applications that need to run.

Hence make option 2 much stricter to "slow it down in a way which makes
it annoying".

Primary reason for this change is to provide better quality of service to
the rest of the applications running on the system. Internal testing shows
that even with many processes splitting locks, performance for the rest of
the system is much more responsive.

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

There is a corner case where a CPU may be taken offline while split lock
detection is disabled. A CPU hotplug handler handles this case.

Old behaviour was to only print the split lock warning on the first
occurrence of a split lock from a task. Preserve that by adding a flag to
the task structure that suppresses subsequent split lock messages from that
task.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220310204854.31752-2-tony.luck@intel.com

---
 arch/x86/kernel/cpu/intel.c | 63 ++++++++++++++++++++++++++++++------
 include/linux/sched.h       |  3 ++-
 kernel/fork.c               |  5 +++-
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f7a5370..be2a0bd 100644
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
@@ -999,6 +1002,8 @@ static const struct {
 
 static struct ratelimit_state bld_ratelimit;
 
+static DEFINE_SEMAPHORE(buslock_sem);
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt), ratelimit;
@@ -1109,18 +1114,52 @@ static void split_lock_init(void)
 		split_lock_verify_msr(sld_state != sld_off);
 }
 
+static void __split_lock_reenable(struct work_struct *work)
+{
+	sld_update_msr(true);
+	up(&buslock_sem);
+}
+
+/*
+ * If a CPU goes offline with pending delayed work to re-enable split lock
+ * detection then the delayed work will be executed on some other CPU. That
+ * handles releasing the buslock_sem, but because it executes on a
+ * different CPU probably won't re-enable split lock detection. This is a
+ * problem on HT systems since the sibling CPU on the same core may then be
+ * left running with split lock detection disabled.
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
@@ -1274,10 +1313,14 @@ static void sld_state_show(void)
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
index a8911b1..23e03c7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -941,6 +941,9 @@ struct task_struct {
 #ifdef CONFIG_IOMMU_SVA
 	unsigned			pasid_activated:1;
 #endif
+#ifdef	CONFIG_CPU_SUP_INTEL
+	unsigned			reported_split_lock:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897..f39795f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1045,6 +1045,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
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
