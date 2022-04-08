Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE34F91A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiDHJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiDHJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB61960B1;
        Fri,  8 Apr 2022 02:09:01 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7P6jwAthNgvKI/av1jxqDocX2PVFAR0PfermJLNNVcE=;
        b=FYrPLnfzcTMbrUdEmqt3qwMtZ1EAjwo5HytdAs8laVOU2giygGFvrS9lU2B5iNw/wOgCMM
        cuceExBzl6HmcMzmtP0qsoAL9uSARpPY8nOIzCjCeEwKHYzqisaU4LDHRTigFsXHKt9J0Q
        SDJ/tvV6aDGyLaGt3UEjxtASDkhkkEC/rdVwgVA79HukSmbYMF9GXuSUSg1WGE3CmZbm15
        Yi+J6PDSq6//7lmnw06B87RCkoLe6lRCJ0yjT0akrsQXAdYmoVHGetYXzl76HxurUk2cru
        cUBUHTgNa55B0qK16Aulfj0DPaSTj4Xrwq+81RWoa0rk7yqV3LdTcl4SEshzZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7P6jwAthNgvKI/av1jxqDocX2PVFAR0PfermJLNNVcE=;
        b=/VdO258eGS7VTa3QlNaLybOUF+0HTJ4072SHcB0nlV69B8XRtAdrzj0r7VqkXCKIZz88Me
        ZoqLz2v/Cyp6bmDA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/acpi: Move EFI detection to helper
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-25-brijesh.singh@amd.com>
References: <20220307213356.2797205-25-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893880.389.10219939367701401345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     7c4146e8885512719a50b641e9277a1712e052ff
Gitweb:        https://git.kernel.org/tip/7c4146e8885512719a50b641e9277a1712e052ff
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:18 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 17:07:02 +02:00

x86/compressed/acpi: Move EFI detection to helper

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

First, carve out the functionality which determines the EFI environment
type the machine is booting on.

  [ bp: Massage commit message. ]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-25-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/Makefile |  1 +-
 arch/x86/boot/compressed/acpi.c   | 28 ++++++-----------
 arch/x86/boot/compressed/efi.c    | 50 ++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.h   | 16 ++++++++++-
 4 files changed, 77 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6115274..e69c3d2 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -103,6 +103,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee..db6c561 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -87,7 +87,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	efi_system_table_64_t *systab;
 	struct efi_setup_data *esd;
 	struct efi_info *ei;
-	char *sig;
+	enum efi_type et;
 
 	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
 	if (!esd)
@@ -98,10 +98,9 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 		return 0;
 	}
 
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
-		debug_putstr("Wrong kexec EFI loader signature.\n");
+	et = efi_get_type(boot_params);
+	if (et != EFI_TYPE_64) {
+		debug_putstr("Unexpected kexec EFI environment (expected 64-bit EFI).\n");
 		return 0;
 	}
 
@@ -122,29 +121,22 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long systab, config_tables;
 	unsigned int nr_tables;
 	struct efi_info *ei;
+	enum efi_type et;
 	bool efi_64;
-	char *sig;
-
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
 
-	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_64)
 		efi_64 = true;
-	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+	else if (et == EFI_TYPE_32)
 		efi_64 = false;
-	} else {
-		debug_putstr("Wrong EFI loader signature.\n");
+	else
 		return 0;
-	}
 
 	/* Get systab from boot params. */
+	ei = &boot_params->efi_info;
 #ifdef CONFIG_X86_64
 	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
 #else
-	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
-		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
-		return 0;
-	}
 	systab = ei->efi_systab;
 #endif
 	if (!systab)
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
new file mode 100644
index 0000000..bad0ce3
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for early access to EFI configuration table.
+ *
+ * Originally derived from arch/x86/boot/compressed/acpi.c
+ */
+
+#include "misc.h"
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+/**
+ * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
+ *
+ * @bp:         pointer to boot_params
+ *
+ * Return: EFI_TYPE_{32,64} for valid EFI environments, EFI_TYPE_NONE otherwise.
+ */
+enum efi_type efi_get_type(struct boot_params *bp)
+{
+	struct efi_info *ei;
+	enum efi_type et;
+	const char *sig;
+
+	ei = &bp->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		et = EFI_TYPE_64;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		et = EFI_TYPE_32;
+	} else {
+		debug_putstr("No EFI environment detected.\n");
+		et = EFI_TYPE_NONE;
+	}
+
+#ifndef CONFIG_X86_64
+	/*
+	 * Existing callers like acpi.c treat this case as an indicator to
+	 * fall-through to non-EFI, rather than an error, so maintain that
+	 * functionality here as well.
+	 */
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("EFI system table is located above 4GB and cannot be accessed.\n");
+		et = EFI_TYPE_NONE;
+	}
+#endif
+
+	return et;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 01cc13c..fede1af 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -176,4 +176,20 @@ void boot_stage2_vc(void);
 
 unsigned long sev_verify_cbit(unsigned long cr3);
 
+enum efi_type {
+	EFI_TYPE_64,
+	EFI_TYPE_32,
+	EFI_TYPE_NONE,
+};
+
+#ifdef CONFIG_EFI
+/* helpers for early EFI config table access */
+enum efi_type efi_get_type(struct boot_params *bp);
+#else
+static inline enum efi_type efi_get_type(struct boot_params *bp)
+{
+	return EFI_TYPE_NONE;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
