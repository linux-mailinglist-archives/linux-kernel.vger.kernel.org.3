Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95548CDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiALVVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:21:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:1425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbiALVUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642022442; x=1673558442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PUVOfiEgenDq0QqeDBmAxAFi7wQqyzFcXNXbCk1CQWo=;
  b=ZCZ94KuF5BCIAaWvYCd9JFT2Sl0HCdU+JlOGf/Wajl7gxi+3OnJbrMsy
   xN0zWYsxIYONaA4pj+HlEzEnD+tE+EKAZNk6NyFsPHgKdVaSQjCNVNDj7
   hcrt1n/oRHukCk2ikHHyh3EWTmOF2SR4h0u6Rtfq3cMFySguSJt1R3ZKD
   Y+vz1DbXXzthi7ncSTalbHQUqntrxf7pODYHcEnH8uLOatboJdEzHW5pU
   69oG68/DULFY/4HKTsk/vMghbpLDlxIp9LGDPaZbFYp3ZcIJ3DXg6sZfk
   q9cXldAjWdU7giSs+hMHsuEYmE4saBzrxKCVIYCjriNtEuqS+EZRuTjmb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243810793"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243810793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529378259"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 13:20:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key at boot-time
Date:   Wed, 12 Jan 2022 13:12:53 -0800
Message-Id: <20220112211258.21115-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112211258.21115-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Internal Wrapping Key (IWKey) is an entity of Key Locker to encode a
clear text key into a key handle. This key is a pivot in protecting user
keys. So the value has to be randomized before being loaded in the
software-invisible CPU state.

IWKey needs to be established before the first user. Given that the only
proposed Linux use case for Key Locker is dm-crypt, the feature could be
lazily enabled when the first dm-crypt user arrives, but there is no
precedent for late enabling of CPU features and it adds maintenance burden
without demonstrative benefit outside of minimizing the visibility of
Key Locker to userspace.

The kernel generates random bytes and load them at boot time. These bytes
are flushed out immediately.

Setting the CR4.KL bit does not always enable the feature so ensure the
dynamic CPU bit (CPUID.AESKLE) is set before loading the key.

Given that the Linux Key Locker support is only intended for bare metal
dm-crypt consumption, and that switching IWKey per VM is untenable,
explicitly skip Key Locker setup in the X86_FEATURE_HYPERVISOR case.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Make bare metal only.
* Clean up the code (e.g. dynamically allocate the key cache).
  (Dan Williams)
* Massage the changelog.
* Move out the LOADIWKEY wrapper and the Key Locker CPUID defines.

Note, Dan wonders that given that the only proposed Linux use case for
Key Locker is dm-crypt, the feature could be lazily enabled when the
first dm-crypt user arrives, but as Dave notes there is no precedent
for late enabling of CPU features and it adds maintenance burden
without demonstrative benefit outside of minimizing the visibility of
Key Locker to userspace.
---
 arch/x86/include/asm/keylocker.h |  9 ++++
 arch/x86/kernel/Makefile         |  1 +
 arch/x86/kernel/cpu/common.c     |  5 +-
 arch/x86/kernel/keylocker.c      | 79 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c        |  2 +
 5 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/keylocker.c

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index e85dfb6c1524..820ac29c06d9 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/processor.h>
 #include <linux/bits.h>
 #include <asm/fpu/types.h>
 
@@ -28,5 +29,13 @@ struct iwkey {
 #define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
 #define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
 
+#ifdef CONFIG_X86_KEYLOCKER
+void setup_keylocker(struct cpuinfo_x86 *c);
+void destroy_keylocker_data(void);
+#else
+#define setup_keylocker(c) do { } while (0)
+#define destroy_keylocker_data() do { } while (0)
+#endif
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..e15efa238497 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -144,6 +144,7 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
+obj-$(CONFIG_X86_KEYLOCKER)		+= keylocker.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464de5e3..23b4aa437c1e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -57,6 +57,8 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/keylocker.h>
+
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
 
@@ -1595,10 +1597,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
+	/* Setup various Intel-specific CPU security features */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_keylocker(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
new file mode 100644
index 000000000000..87d775a65716
--- /dev/null
+++ b/arch/x86/kernel/keylocker.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Setup Key Locker feature and support internal wrapping key
+ * management.
+ */
+
+#include <linux/random.h>
+#include <linux/poison.h>
+
+#include <asm/fpu/api.h>
+#include <asm/keylocker.h>
+#include <asm/tlbflush.h>
+
+static __initdata struct keylocker_setup_data {
+	struct iwkey key;
+} kl_setup;
+
+static void __init generate_keylocker_data(void)
+{
+	get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
+	get_random_bytes(&kl_setup.key.encryption_key, sizeof(kl_setup.key.encryption_key));
+}
+
+void __init destroy_keylocker_data(void)
+{
+	memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
+}
+
+static void __init load_keylocker(void)
+{
+	kernel_fpu_begin();
+	load_xmm_iwkey(&kl_setup.key);
+	kernel_fpu_end();
+}
+
+/**
+ * setup_keylocker - Enable the feature.
+ * @c:		A pointer to struct cpuinfo_x86
+ */
+void __ref setup_keylocker(struct cpuinfo_x86 *c)
+{
+	/* This feature is not compatible with a hypervisor. */
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER) ||
+	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		goto out;
+
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	if (c == &boot_cpu_data) {
+		u32 eax, ebx, ecx, edx;
+
+		cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+		/*
+		 * Check the feature readiness via CPUID. Note that the
+		 * CPUID AESKLE bit is conditionally set only when CR4.KL
+		 * is set.
+		 */
+		if (!(ebx & KEYLOCKER_CPUID_EBX_AESKLE) ||
+		    !(eax & KEYLOCKER_CPUID_EAX_SUPERVISOR)) {
+			pr_debug("x86/keylocker: Not fully supported.\n");
+			goto disable;
+		}
+
+		generate_keylocker_data();
+	}
+
+	load_keylocker();
+
+	pr_info_once("x86/keylocker: Enabled.\n");
+	return;
+
+disable:
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	pr_info_once("x86/keylocker: Disabled.\n");
+out:
+	/* Make sure the feature disabled for kexec-reboot. */
+	cr4_clear_bits(X86_CR4_KEYLOCKER);
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 617012f4619f..00cfa64948f5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/keylocker.h>
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
@@ -1489,6 +1490,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	nmi_selftest();
 	impress_friends();
 	mtrr_aps_init();
+	destroy_keylocker_data();
 }
 
 static int __initdata setup_possible_cpus = -1;
-- 
2.17.1

