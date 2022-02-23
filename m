Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD74C12A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiBWMUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiBWMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:20:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08115A0BD5;
        Wed, 23 Feb 2022 04:20:16 -0800 (PST)
Date:   Wed, 23 Feb 2022 12:20:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645618814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+ovXDEjRIotss8olO5mzadCwroAZ3N0npZMcH6ZRko=;
        b=BmX9cDL67x76XAtKW67KXghT3m/yJTMjnegV+BWcFGa/EMPY90HLXlU+YRRFjfxl3LVISC
        lI4f8Ron9ExCUZuzrms0EUktShopWuYA1TuvA+09x/Ir5sdKyXMgZ4Gug/MfZKtkpBzslF
        d9AUWCD6ya0+zbXUiQ2iuidC8ks3j4tco+4s56u65LpcBrXnVM9100zvHQxyyt0Qh5p21N
        5BNT1pYFzstijmEWpEKHJePk9GpdoQH18i+IwhrJc0LQvXiksMFEHqCs49H8zppYgDotX5
        SMvJbHD3Uerz2IcfURJJFKxfVlgBMSyyLilWOowMjiDxbeI0uelYmEhcQly2aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645618814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+ovXDEjRIotss8olO5mzadCwroAZ3N0npZMcH6ZRko=;
        b=b/v1lTPBMa9mGq1DnI/kpgz6abFVkI+BUWpkl093R0WuPZQfxkMYBwuqf4pQQPd1Y3j3zn
        /FHhTav464aGS1Ag==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove the tolerance level control
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e@zn.tnic>
References: <e@zn.tnic>
MIME-Version: 1.0
Message-ID: <164561881319.16921.1155727533188608508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     7f1b8e0d6360178e3527d4f14e6921c254a86035
Gitweb:        https://git.kernel.org/tip/7f1b8e0d6360178e3527d4f14e6921c254a86035
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 20 Dec 2021 21:43:28 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Feb 2022 11:09:25 +01:00

x86/mce: Remove the tolerance level control

This is pretty much unused and not really useful. What is more, all
relevant MCA hardware has recoverable machine checks support so there's
no real need to tweak MCA tolerance levels in order to *maybe* extend
machine lifetime.

So rip it out.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/YcDq8PxvKtTENl/e@zn.tnic
---
 Documentation/ABI/removed/sysfs-mce       | 37 +++++++++++++++-
 Documentation/ABI/testing/sysfs-mce       | 32 +-------------
 Documentation/vm/hwpoison.rst             |  2 +-
 Documentation/x86/x86_64/boot-options.rst |  9 +----
 arch/x86/kernel/cpu/mce/core.c            | 53 ++++++++--------------
 arch/x86/kernel/cpu/mce/internal.h        |  3 +-
 arch/x86/kernel/cpu/mce/severity.c        | 21 +++------
 7 files changed, 68 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-mce

diff --git a/Documentation/ABI/removed/sysfs-mce b/Documentation/ABI/removed/sysfs-mce
new file mode 100644
index 0000000..ef5dd2a
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-mce
@@ -0,0 +1,37 @@
+What:		/sys/devices/system/machinecheck/machinecheckX/tolerant
+Contact:	Borislav Petkov <bp@suse.de>
+Date:		Dec, 2021
+Description:
+		Unused and obsolete after the advent of recoverable machine
+		checks (see last sentence below) and those are present since
+		2010 (Nehalem).
+
+		Original description:
+
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		Tolerance level. When a machine check exception occurs for a
+		non corrected machine check the kernel can take different
+		actions.
+
+		Since machine check exceptions can happen any time it is
+		sometimes risky for the kernel to kill a process because it
+		defies normal kernel locking rules. The tolerance level
+		configures how hard the kernel tries to recover even at some
+		risk of	deadlock. Higher tolerant values trade potentially
+		better uptime with the risk of a crash or even corruption
+		(for tolerant >= 3).
+
+		==  ===========================================================
+		 0  always panic on uncorrected errors, log corrected errors
+		 1  panic or SIGBUS on uncorrected errors, log corrected errors
+		 2  SIGBUS or log uncorrected errors, log corrected errors
+		 3  never panic or SIGBUS, log all errors (for testing only)
+		==  ===========================================================
+
+		Default: 1
+
+		Note this only makes a difference if the CPU allows recovery
+		from a machine check exception. Current x86 CPUs generally
+		do not.
diff --git a/Documentation/ABI/testing/sysfs-mce b/Documentation/ABI/testing/sysfs-mce
index c8cd989..83172f5 100644
--- a/Documentation/ABI/testing/sysfs-mce
+++ b/Documentation/ABI/testing/sysfs-mce
@@ -53,38 +53,6 @@ Description:
 		(but some corrected errors might be still reported
 		in other ways)
 
-What:		/sys/devices/system/machinecheck/machinecheckX/tolerant
-Contact:	Andi Kleen <ak@linux.intel.com>
-Date:		Feb, 2007
-Description:
-		The entries appear for each CPU, but they are truly shared
-		between all CPUs.
-
-		Tolerance level. When a machine check exception occurs for a
-		non corrected machine check the kernel can take different
-		actions.
-
-		Since machine check exceptions can happen any time it is
-		sometimes risky for the kernel to kill a process because it
-		defies normal kernel locking rules. The tolerance level
-		configures how hard the kernel tries to recover even at some
-		risk of	deadlock. Higher tolerant values trade potentially
-		better uptime with the risk of a crash or even corruption
-		(for tolerant >= 3).
-
-		==  ===========================================================
-		 0  always panic on uncorrected errors, log corrected errors
-		 1  panic or SIGBUS on uncorrected errors, log corrected errors
-		 2  SIGBUS or log uncorrected errors, log corrected errors
-		 3  never panic or SIGBUS, log all errors (for testing only)
-		==  ===========================================================
-
-		Default: 1
-
-		Note this only makes a difference if the CPU allows recovery
-		from a machine check exception. Current x86 CPUs generally
-		do not.
-
 What:		/sys/devices/system/machinecheck/machinecheckX/trigger
 Contact:	Andi Kleen <ak@linux.intel.com>
 Date:		Feb, 2007
diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index 89b5f7a..c742de1 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -60,8 +60,6 @@ There are two (actually three) modes memory failure recovery can be in:
 
 vm.memory_failure_recovery sysctl set to zero:
 	All memory failures cause a panic. Do not attempt recovery.
-	(on x86 this can be also affected by the tolerant level of the
-	MCE subsystem)
 
 early kill
 	(can be controlled globally and per process)
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index ccb7e86..07aa000 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -47,14 +47,7 @@ Please see Documentation/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
 		in a reboot. On Intel systems it is enabled by default.
    mce=nobootlog
 		Disable boot machine check logging.
-   mce=tolerancelevel[,monarchtimeout] (number,number)
-		tolerance levels:
-		0: always panic on uncorrected errors, log corrected errors
-		1: panic or SIGBUS on uncorrected errors, log corrected errors
-		2: SIGBUS or log uncorrected errors, log corrected errors
-		3: never panic or SIGBUS, log all errors (for testing only)
-		Default is 1
-		Can be also set using sysfs which is preferable.
+   mce=monarchtimeout (number)
 		monarchtimeout:
 		Sets the time in us to wait for other CPUs on machine checks. 0
 		to disable.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3d766e6..6c9b5da 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -86,14 +86,6 @@ struct mce_vendor_flags mce_flags __read_mostly;
 
 struct mca_config mca_cfg __read_mostly = {
 	.bootlog  = -1,
-	/*
-	 * Tolerant levels:
-	 * 0: always panic on uncorrected errors, log corrected errors
-	 * 1: panic or SIGBUS on uncorrected errors, log corrected errors
-	 * 2: SIGBUS or log uncorrected errors (if possible), log corr. errors
-	 * 3: never panic or SIGBUS, log all errors (for testing only)
-	 */
-	.tolerant = 1,
 	.monarch_timeout = -1
 };
 
@@ -753,7 +745,7 @@ log_it:
 			goto clear_it;
 
 		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, NULL, mca_cfg.tolerant, NULL, false);
+		m.severity = mce_severity(&m, NULL, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
@@ -887,7 +879,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 			quirk_sandybridge_ifu(i, m, regs);
 
 		m->bank = i;
-		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
@@ -935,12 +927,11 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1) {
-			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
-				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
-					 cpumask_pr_args(&mce_missing_cpus));
-			mce_panic(msg, NULL, NULL);
-		}
+		if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
+			pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
+				 cpumask_pr_args(&mce_missing_cpus));
+		mce_panic(msg, NULL, NULL);
+
 		ret = 1;
 		goto out;
 	}
@@ -1004,9 +995,9 @@ static void mce_reign(void)
 	 * This dumps all the mces in the log buffer and stops the
 	 * other CPUs.
 	 */
-	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, NULL, mca_cfg.tolerant, &msg, true);
+		mce_severity(m, NULL, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
 	}
 
@@ -1020,7 +1011,7 @@ static void mce_reign(void)
 	 * No machine check event found. Must be some external
 	 * source or one CPU is hung. Panic.
 	 */
-	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
+	if (global_worst <= MCE_KEEP_SEVERITY)
 		mce_panic("Fatal machine check from unknown source", NULL, NULL);
 
 	/*
@@ -1267,7 +1258,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		/* Set taint even when machine check was not enabled. */
 		taint++;
 
-		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
+		severity = mce_severity(m, regs, NULL, true);
 
 		/*
 		 * When machine check was for corrected/deferred handler don't
@@ -1425,7 +1416,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
-	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
 
@@ -1447,7 +1437,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 	/*
 	 * If no_way_out gets set, there is no safe way to recover from this
-	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
+	 * MCE.
 	 */
 	no_way_out = 0;
 
@@ -1481,7 +1471,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_current_task = (cfg->tolerant == 3) ? 0 : 1;
+		kill_current_task = 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
@@ -1498,7 +1488,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * to see it will clear it.
 	 */
 	if (lmce) {
-		if (no_way_out && cfg->tolerant < 3)
+		if (no_way_out)
 			mce_panic("Fatal local machine check", &m, msg);
 	} else {
 		order = mce_start(&no_way_out);
@@ -1518,7 +1508,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			if (!no_way_out)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
 
-			if (no_way_out && cfg->tolerant < 3)
+			if (no_way_out)
 				mce_panic("Fatal machine check on current CPU", &m, msg);
 		}
 	} else {
@@ -1530,8 +1520,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * fatal error. We call "mce_severity()" again to
 		 * make sure we have the right "msg".
 		 */
-		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-			mce_severity(&m, regs, cfg->tolerant, &msg, true);
+		if (worst >= MCE_PANIC_SEVERITY) {
+			mce_severity(&m, regs, &msg, true);
 			mce_panic("Local fatal machine check!", &m, msg);
 		}
 	}
@@ -2267,10 +2257,9 @@ static int __init mcheck_enable(char *str)
 		cfg->bios_cmci_threshold = 1;
 	else if (!strcmp(str, "recovery"))
 		cfg->recovery = 1;
-	else if (isdigit(str[0])) {
-		if (get_option(&str, &cfg->tolerant) == 2)
-			get_option(&str, &(cfg->monarch_timeout));
-	} else {
+	else if (isdigit(str[0]))
+		get_option(&str, &(cfg->monarch_timeout));
+	else {
 		pr_info("mce argument %s ignored. Please use /sys\n", str);
 		return 0;
 	}
@@ -2520,7 +2509,6 @@ static ssize_t store_int_with_restart(struct device *s,
 	return ret;
 }
 
-static DEVICE_INT_ATTR(tolerant, 0644, mca_cfg.tolerant);
 static DEVICE_INT_ATTR(monarch_timeout, 0644, mca_cfg.monarch_timeout);
 static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
 static DEVICE_BOOL_ATTR(print_all, 0644, mca_cfg.print_all);
@@ -2541,7 +2529,6 @@ static struct dev_ext_attribute dev_attr_cmci_disabled = {
 };
 
 static struct device_attribute *mce_device_attrs[] = {
-	&dev_attr_tolerant.attr,
 	&dev_attr_check_interval.attr,
 #ifdef CONFIG_X86_MCELOG_LEGACY
 	&dev_attr_trigger,
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 3efb503..4ae0e60 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -35,7 +35,7 @@ int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
-int mce_severity(struct mce *a, struct pt_regs *regs, int tolerant, char **msg, bool is_excp);
+int mce_severity(struct mce *a, struct pt_regs *regs, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
@@ -127,7 +127,6 @@ struct mca_config {
 	bool ignore_ce;
 	bool print_all;
 
-	int tolerant;
 	int monarch_timeout;
 	int panic_timeout;
 	u32 rip_msr;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index ca0d775..1add869 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -330,8 +330,7 @@ static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err
  * See AMD Error Scope Hierarchy table in a newer BKDG. For example
  * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
  */
-static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
-				    char **msg, bool is_excp)
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	enum context ctx = error_context(m, regs);
 
@@ -383,8 +382,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tol
 	return MCE_KEEP_SEVERITY;
 }
 
-static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
-				      int tolerant, char **msg, bool is_excp)
+static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
 	enum context ctx = error_context(m, regs);
@@ -412,22 +410,21 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 		if (msg)
 			*msg = s->msg;
 		s->covered = 1;
-		if (s->sev >= MCE_UC_SEVERITY && ctx == IN_KERNEL) {
-			if (tolerant < 1)
-				return MCE_PANIC_SEVERITY;
-		}
+
+		if (s->sev >= MCE_UC_SEVERITY && ctx == IN_KERNEL)
+			return MCE_PANIC_SEVERITY;
+
 		return s->sev;
 	}
 }
 
-int noinstr mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
-			 bool is_excp)
+int noinstr mce_severity(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return mce_severity_amd(m, regs, tolerant, msg, is_excp);
+		return mce_severity_amd(m, regs, msg, is_excp);
 	else
-		return mce_severity_intel(m, regs, tolerant, msg, is_excp);
+		return mce_severity_intel(m, regs, msg, is_excp);
 }
 
 #ifdef CONFIG_DEBUG_FS
