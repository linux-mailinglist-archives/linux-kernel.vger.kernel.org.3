Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778EB504775
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiDQKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiDQKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:01:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37125F2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 02:59:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650189557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dw5JDLvFXqwblqWKwJBDv6ELI+2tr0huh6h4ujFaa6c=;
        b=Hp7+4Z2TNdNsNeO9EFXFg5YFocAolTQgGaEMzn8pxtLZNgzXXXbOB0KbuDEh0OzUeh+x6K
        D8f3mqtIqUc9W/RUPHAf8wBnBFe0r/34RWsgj+FrsB4mYPZ/Om9xaMnN9Bdnaw9X9zac5Q
        dmPXS14RDRQKIW5shSka4ZDJ+XUfTL8BPkpdxlJZtAcY3uNiSsxuDj7d0IsOW+s+AWIBoO
        ZYNLdXK0RXYsTo0qjFiO88prTwOZYh6sRkTLR+SeUAfYHcKrz/A4TTC0AwoDsQcfPeRFNY
        IpGaaH845MibjS7qIZbfuJ16lqfGBQhm5Mz92cEb/f3c2x47XxHf6zduoj12uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650189557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dw5JDLvFXqwblqWKwJBDv6ELI+2tr0huh6h4ujFaa6c=;
        b=qDccs3S2yvmnnkLztiRCvrpJrpouPoZinl2QhBu0V39GZhQI/DaoPB+CTOMNFyb/vKdLfS
        Qkogvr6kQ/UsscCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.18-rc3
References: <165018953450.44773.6382828227632028472.tglx@xen13>
Message-ID: <165018953883.44773.12883227528447853271.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 17 Apr 2022 11:59:16 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
04-17

up to:  400331f8ffa3: x86/tsx: Disable TSX development mode at boot


Two x86 fixes related to TSX:

  - Use either MSR_TSX_FORCE_ABORT or MSR_IA32_TSX_CTRL to disable TSX to
    cover all CPUs which allow to disable it.

  - Disable TSX development mode at boot so that a microcode update which
    provides TSX development mode does not suddenly make the system
    vulnerable to TSX Asynchronous Abort.

   =20

Thanks,

	tglx

------------------>
Pawan Gupta (2):
      x86/tsx: Use MSR_TSX_CTRL to clear CPUID bits
      x86/tsx: Disable TSX development mode at boot


 arch/x86/include/asm/msr-index.h       |   4 +-
 arch/x86/kernel/cpu/common.c           |   2 +
 arch/x86/kernel/cpu/cpu.h              |   5 +-
 arch/x86/kernel/cpu/intel.c            |   7 ---
 arch/x86/kernel/cpu/tsx.c              | 104 +++++++++++++++++++++++++++++--=
--
 tools/arch/x86/include/asm/msr-index.h |   4 +-
 6 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 0eb90d21049e..ee15311b6be1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -128,9 +128,9 @@
 #define TSX_CTRL_RTM_DISABLE		BIT(0)	/* Disable RTM feature */
 #define TSX_CTRL_CPUID_CLEAR		BIT(1)	/* Disable TSX enumeration */
=20
-/* SRBDS support */
 #define MSR_IA32_MCU_OPT_CTRL		0x00000123
-#define RNGDS_MITG_DIS			BIT(0)
+#define RNGDS_MITG_DIS			BIT(0)	/* SRBDS support */
+#define RTM_ALLOW			BIT(1)	/* TSX development mode */
=20
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ed4417500700..e342ae4db3c4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1855,6 +1855,8 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
+
+	tsx_ap_init();
 }
=20
 static __init int setup_noclflush(char *arg)
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index ee6f23f7587d..2a8e584fc991 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -55,11 +55,10 @@ enum tsx_ctrl_states {
 extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
=20
 extern void __init tsx_init(void);
-extern void tsx_enable(void);
-extern void tsx_disable(void);
-extern void tsx_clear_cpuid(void);
+void tsx_ap_init(void);
 #else
 static inline void tsx_init(void) { }
+static inline void tsx_ap_init(void) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
=20
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..f7a5370a9b3b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -717,13 +717,6 @@ static void init_intel(struct cpuinfo_x86 *c)
=20
 	init_intel_misc_features(c);
=20
-	if (tsx_ctrl_state =3D=3D TSX_CTRL_ENABLE)
-		tsx_enable();
-	else if (tsx_ctrl_state =3D=3D TSX_CTRL_DISABLE)
-		tsx_disable();
-	else if (tsx_ctrl_state =3D=3D TSX_CTRL_RTM_ALWAYS_ABORT)
-		tsx_clear_cpuid();
-
 	split_lock_init();
 	bus_lock_init();
=20
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 9c7a5f049292..ec7bbac3a9f2 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -19,7 +19,7 @@
=20
 enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =3D TSX_CTRL_NOT_SUPPORT=
ED;
=20
-void tsx_disable(void)
+static void tsx_disable(void)
 {
 	u64 tsx;
=20
@@ -39,7 +39,7 @@ void tsx_disable(void)
 	wrmsrl(MSR_IA32_TSX_CTRL, tsx);
 }
=20
-void tsx_enable(void)
+static void tsx_enable(void)
 {
 	u64 tsx;
=20
@@ -58,7 +58,7 @@ void tsx_enable(void)
 	wrmsrl(MSR_IA32_TSX_CTRL, tsx);
 }
=20
-static bool __init tsx_ctrl_is_supported(void)
+static bool tsx_ctrl_is_supported(void)
 {
 	u64 ia32_cap =3D x86_read_arch_cap_msr();
=20
@@ -84,7 +84,45 @@ static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
 	return TSX_CTRL_ENABLE;
 }
=20
-void tsx_clear_cpuid(void)
+/*
+ * Disabling TSX is not a trivial business.
+ *
+ * First of all, there's a CPUID bit: X86_FEATURE_RTM_ALWAYS_ABORT
+ * which says that TSX is practically disabled (all transactions are
+ * aborted by default). When that bit is set, the kernel unconditionally
+ * disables TSX.
+ *
+ * In order to do that, however, it needs to dance a bit:
+ *
+ * 1. The first method to disable it is through MSR_TSX_FORCE_ABORT and
+ * the MSR is present only when *two* CPUID bits are set:
+ *
+ * - X86_FEATURE_RTM_ALWAYS_ABORT
+ * - X86_FEATURE_TSX_FORCE_ABORT
+ *
+ * 2. The second method is for CPUs which do not have the above-mentioned
+ * MSR: those use a different MSR - MSR_IA32_TSX_CTRL and disable TSX
+ * through that one. Those CPUs can also have the initially mentioned
+ * CPUID bit X86_FEATURE_RTM_ALWAYS_ABORT set and for those the same strategy
+ * applies: TSX gets disabled unconditionally.
+ *
+ * When either of the two methods are present, the kernel disables TSX and
+ * clears the respective RTM and HLE feature flags.
+ *
+ * An additional twist in the whole thing presents late microcode loading
+ * which, when done, may cause for the X86_FEATURE_RTM_ALWAYS_ABORT CPUID
+ * bit to be set after the update.
+ *
+ * A subsequent hotplug operation on any logical CPU except the BSP will
+ * cause for the supported CPUID feature bits to get re-detected and, if
+ * RTM and HLE get cleared all of a sudden, but, userspace did consult
+ * them before the update, then funny explosions will happen. Long story
+ * short: the kernel doesn't modify CPUID feature bits after booting.
+ *
+ * That's why, this function's call in init_intel() doesn't clear the
+ * feature flags.
+ */
+static void tsx_clear_cpuid(void)
 {
 	u64 msr;
=20
@@ -97,6 +135,39 @@ void tsx_clear_cpuid(void)
 		rdmsrl(MSR_TSX_FORCE_ABORT, msr);
 		msr |=3D MSR_TFA_TSX_CPUID_CLEAR;
 		wrmsrl(MSR_TSX_FORCE_ABORT, msr);
+	} else if (tsx_ctrl_is_supported()) {
+		rdmsrl(MSR_IA32_TSX_CTRL, msr);
+		msr |=3D TSX_CTRL_CPUID_CLEAR;
+		wrmsrl(MSR_IA32_TSX_CTRL, msr);
+	}
+}
+
+/*
+ * Disable TSX development mode
+ *
+ * When the microcode released in Feb 2022 is applied, TSX will be disabled =
by
+ * default on some processors. MSR 0x122 (TSX_CTRL) and MSR 0x123
+ * (IA32_MCU_OPT_CTRL) can be used to re-enable TSX for development, doing s=
o is
+ * not recommended for production deployments. In particular, applying MD_CL=
EAR
+ * flows for mitigation of the Intel TSX Asynchronous Abort (TAA) transient
+ * execution attack may not be effective on these processors when Intel TSX =
is
+ * enabled with updated microcode.
+ */
+static void tsx_dev_mode_disable(void)
+{
+	u64 mcu_opt_ctrl;
+
+	/* Check if RTM_ALLOW exists */
+	if (!boot_cpu_has_bug(X86_BUG_TAA) || !tsx_ctrl_is_supported() ||
+	    !cpu_feature_enabled(X86_FEATURE_SRBDS_CTRL))
+		return;
+
+	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_opt_ctrl);
+
+	if (mcu_opt_ctrl & RTM_ALLOW) {
+		mcu_opt_ctrl &=3D ~RTM_ALLOW;
+		wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_opt_ctrl);
+		setup_force_cpu_cap(X86_FEATURE_RTM_ALWAYS_ABORT);
 	}
 }
=20
@@ -105,14 +176,14 @@ void __init tsx_init(void)
 	char arg[5] =3D {};
 	int ret;
=20
+	tsx_dev_mode_disable();
+
 	/*
-	 * Hardware will always abort a TSX transaction if both CPUID bits
-	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are set. In this case, it is
-	 * better not to enumerate CPUID.RTM and CPUID.HLE bits. Clear them
-	 * here.
+	 * Hardware will always abort a TSX transaction when the CPUID bit
+	 * RTM_ALWAYS_ABORT is set. In this case, it is better not to enumerate
+	 * CPUID.RTM and CPUID.HLE bits. Clear them here.
 	 */
-	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
-	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT)) {
 		tsx_ctrl_state =3D TSX_CTRL_RTM_ALWAYS_ABORT;
 		tsx_clear_cpuid();
 		setup_clear_cpu_cap(X86_FEATURE_RTM);
@@ -175,3 +246,16 @@ void __init tsx_init(void)
 		setup_force_cpu_cap(X86_FEATURE_HLE);
 	}
 }
+
+void tsx_ap_init(void)
+{
+	tsx_dev_mode_disable();
+
+	if (tsx_ctrl_state =3D=3D TSX_CTRL_ENABLE)
+		tsx_enable();
+	else if (tsx_ctrl_state =3D=3D TSX_CTRL_DISABLE)
+		tsx_disable();
+	else if (tsx_ctrl_state =3D=3D TSX_CTRL_RTM_ALWAYS_ABORT)
+		/* See comment over that function for more details. */
+		tsx_clear_cpuid();
+}
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/=
asm/msr-index.h
index 0eb90d21049e..ee15311b6be1 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -128,9 +128,9 @@
 #define TSX_CTRL_RTM_DISABLE		BIT(0)	/* Disable RTM feature */
 #define TSX_CTRL_CPUID_CLEAR		BIT(1)	/* Disable TSX enumeration */
=20
-/* SRBDS support */
 #define MSR_IA32_MCU_OPT_CTRL		0x00000123
-#define RNGDS_MITG_DIS			BIT(0)
+#define RNGDS_MITG_DIS			BIT(0)	/* SRBDS support */
+#define RTM_ALLOW			BIT(1)	/* TSX development mode */
=20
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175

