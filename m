Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7D462CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhK3Glz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:41:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:30759 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233463AbhK3Gly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:41:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216849236"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="216849236"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="676710225"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2021 22:38:34 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     ebiggers@kernel.org
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH v3-fix 08/15] x86/power/keylocker: Restore internal wrapping key from the ACPI S3/4 sleep states
Date:   Mon, 29 Nov 2021 22:31:22 -0800
Message-Id: <20211130063122.6709-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YaWa2+2eVSFXY1U3@sol.localdomain>
References: <YaWa2+2eVSFXY1U3@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system state switches to these sleep states, the internal
wrapping key gets reset in the CPU state.

The primary use case for the feature is bare metal dm-crypt. The key needs
to be restored properly on wakeup, as dm-crypt does not prompt for the key
on resume from suspend. Even the prompt it does perform for unlocking
the volume where the hibernation image is stored, it still expects to reuse
the key handles within the hibernation image once it is loaded. So it is
motivated to meet dm-crypt's expectation that the key handles in the
suspend-image remain valid after resume from an S-state.

Key Locker provides a mechanism to back up the internal wrapping key in
non-volatile storage. The kernel requests a backup right after the key is
loaded at boot time. It is copied back to each CPU upon wakeup.

While the backup may be maintained in NVM across S5 and G3 "off"
states it is not architecturally guaranteed, nor is it expected by dm-crypt
which expects to prompt for the key each time the volume is started.

The entirety of Key Locker needs to be disabled if the backup mechanism is
not available unless CONFIG_SUSPEND=n, otherwise dm-crypt requires the
backup to be available.

In the event of a key restore failure the kernel proceeds with an
initialized IWKey state. This has the effect of invalidating any key
handles that might be present in a suspend-image. When this happens
dm-crypt will see I/O errors resulting from error returns from
crypto_skcipher_{en,de}crypt(). While this will disrupt operations in the
current boot, data is not at risk and access is restored at the next reboot
to create new handles relative to the current IWKey.

Manage a feature-specific flag to communicate with the crypto
implementation. This ensures to stop using the AES instructions upon the
key restore failure while not turning off the feature.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
Changes from v3:
* Fix the build error. (Eric Biggers) 

Changes from RFC v2:
* Change the backup key failure handling. (Dan Williams)

Changes from RFC v1:
* Folded the warning message into the if condition check. (Rafael Wysocki)
* Rebased on the changes of the previous patches.
* Added error code for key restoration failures.
* Moved the restore helper.
* Added function descriptions.
---
 arch/x86/include/asm/keylocker.h |   4 +
 arch/x86/kernel/keylocker.c      | 124 ++++++++++++++++++++++++++++++-
 arch/x86/power/cpu.c             |   2 +
 3 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 820ac29c06d9..4000a5eed2c2 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -32,9 +32,13 @@ struct iwkey {
 #ifdef CONFIG_X86_KEYLOCKER
 void setup_keylocker(struct cpuinfo_x86 *c);
 void destroy_keylocker_data(void);
+void restore_keylocker(void);
+extern bool valid_keylocker(void);
 #else
 #define setup_keylocker(c) do { } while (0)
 #define destroy_keylocker_data() do { } while (0)
+#define restore_keylocker() do { } while (0)
+static inline bool valid_keylocker() { return false; }
 #endif
 
 #endif /*__ASSEMBLY__ */
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 87d775a65716..ff0e012e3dd5 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -11,11 +11,26 @@
 #include <asm/fpu/api.h>
 #include <asm/keylocker.h>
 #include <asm/tlbflush.h>
+#include <asm/msr.h>
 
 static __initdata struct keylocker_setup_data {
+	bool initialized;
 	struct iwkey key;
 } kl_setup;
 
+/*
+ * This flag is set with IWKey load. When the key restore fails, it is
+ * reset. This restore state is exported to the crypto library, then AES-KL
+ * will not be used there. So, the feature is soft-disabled with this flag.
+ */
+static bool valid_kl;
+
+bool valid_keylocker(void)
+{
+	return valid_kl;
+}
+EXPORT_SYMBOL_GPL(valid_keylocker);
+
 static void __init generate_keylocker_data(void)
 {
 	get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
@@ -25,6 +40,8 @@ static void __init generate_keylocker_data(void)
 void __init destroy_keylocker_data(void)
 {
 	memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
+	kl_setup.initialized = true;
+	valid_kl = true;
 }
 
 static void __init load_keylocker(void)
@@ -34,6 +51,27 @@ static void __init load_keylocker(void)
 	kernel_fpu_end();
 }
 
+/**
+ * copy_keylocker - Copy the internal wrapping key from the backup.
+ *
+ * Request hardware to copy the key in non-volatile storage to the CPU
+ * state.
+ *
+ * Returns:	-EBUSY if the copy fails, 0 if successful.
+ */
+static int copy_keylocker(void)
+{
+	u64 status;
+
+	wrmsrl(MSR_IA32_COPY_IWKEY_TO_LOCAL, 1);
+
+	rdmsrl(MSR_IA32_IWKEY_COPY_STATUS, status);
+	if (status & BIT(0))
+		return 0;
+	else
+		return -EBUSY;
+}
+
 /**
  * setup_keylocker - Enable the feature.
  * @c:		A pointer to struct cpuinfo_x86
@@ -49,6 +87,7 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 
 	if (c == &boot_cpu_data) {
 		u32 eax, ebx, ecx, edx;
+		bool backup_available;
 
 		cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
 		/*
@@ -62,10 +101,49 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 			goto disable;
 		}
 
+		backup_available = (ebx & KEYLOCKER_CPUID_EBX_BACKUP) ? true : false;
+		/*
+		 * The internal wrapping key in CPU state is volatile in
+		 * S3/4 states. So ensure the backup capability along with
+		 * S-states.
+		 */
+		if (!backup_available && IS_ENABLED(CONFIG_SUSPEND)) {
+			pr_debug("x86/keylocker: No key backup support with possible S3/4.\n");
+			goto disable;
+		}
+
 		generate_keylocker_data();
-	}
+		load_keylocker();
 
-	load_keylocker();
+		/* Backup an internal wrapping key in non-volatile media. */
+		if (backup_available)
+			wrmsrl(MSR_IA32_BACKUP_IWKEY_TO_PLATFORM, 1);
+	} else {
+		int rc;
+
+		/*
+		 * Load the internal wrapping key directly when available
+		 * in memory, which is only possible at boot-time.
+		 *
+		 * NB: When system wakes up, this path also recovers the
+		 * internal wrapping key.
+		 */
+		if (!kl_setup.initialized) {
+			load_keylocker();
+		} else if (valid_kl) {
+			rc = copy_keylocker();
+			/*
+			 * The boot CPU was successful but the key copy
+			 * fails here. Then, the subsequent feature use
+			 * will have inconsistent keys and failures. So,
+			 * invalidate the feature via the flag.
+			 */
+			if (rc) {
+				valid_kl = false;
+				pr_err_once("x86/keylocker: Invalid copy status (rc: %d).\n", rc);
+			}
+		}
+	}
 
 	pr_info_once("x86/keylocker: Enabled.\n");
 	return;
@@ -77,3 +155,45 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 	/* Make sure the feature disabled for kexec-reboot. */
 	cr4_clear_bits(X86_CR4_KEYLOCKER);
 }
+
+/**
+ * restore_keylocker - Restore the internal wrapping key.
+ *
+ * The boot CPU executes this while other CPUs restore it through the setup
+ * function.
+ */
+void restore_keylocker(void)
+{
+	u64 backup_status;
+	int rc;
+
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER) || !valid_kl)
+		return;
+
+	/*
+	 * The IA32_IWKEYBACKUP_STATUS MSR contains a bitmap that indicates
+	 * an invalid backup if bit 0 is set and a read (or write) error if
+	 * bit 2 is set.
+	 */
+	rdmsrl(MSR_IA32_IWKEY_BACKUP_STATUS, backup_status);
+	if (backup_status & BIT(0)) {
+		rc = copy_keylocker();
+		if (rc)
+			pr_err("x86/keylocker: Invalid copy state (rc: %d).\n", rc);
+		else
+			return;
+	} else {
+		pr_err("x86/keylocker: The key backup access failed with %s.\n",
+		       (backup_status & BIT(2)) ? "read error" : "invalid status");
+	}
+
+	/*
+	 * Now the backup key is not available. Invalidate the feature via
+	 * the flag to avoid any subsequent use. But keep the feature with
+	 * zero IWKeys instead of disabling it. The current users will see
+	 * key handle integrity failure but that's because of the internal
+	 * key change.
+	 */
+	pr_err("x86/keylocker: Failed to restore internal wrapping key.\n");
+	valid_kl = false;
+}
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 9f2b251e83c5..1a290f529c73 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -25,6 +25,7 @@
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
+#include <asm/keylocker.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -262,6 +263,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	mtrr_bp_restore();
 	perf_restore_debug_store();
 	msr_restore_context(ctxt);
+	restore_keylocker();
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
-- 
2.17.1

