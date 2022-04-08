Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474124F91AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiDHJOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiDHJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6898112C6E5;
        Fri,  8 Apr 2022 02:09:00 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcaLRom/FMvq4UNHDZUZumcs18g26rKK2UOqOBlTfn0=;
        b=36vI0gN+yRRJJVZalc+eh9s2XEHCrDCRDqHd0/m4raGfFKQTqd/lB1dGrfCaPkxu/Bknxu
        zYsGJ7nx4HC6mDjaRG0rEA481jCZrL+EbjmVLKb09p6FCeu4VHGsYUWG6KPeHSlkDazGUw
        WUk8E6THo3I72ID143ZVHOe48bcncglmMJpq7zTcasfb0ObsAiMHEloovgup81uApZrSNO
        0TEXGDsYpI+vBW33G/+2OvMH2o+ANl3ngPP+M0zceXSxU3nfaJoaijiw9679IN2ZkMN7W4
        EELKEjdzQnOaupM3hbxkwG/S3IjYI4s6hcD030qvTR0ggwiXxUacf8+8Je7xqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcaLRom/FMvq4UNHDZUZumcs18g26rKK2UOqOBlTfn0=;
        b=1x99IpwW8X8hLCEEioflF81nvD06LwGJ2dB3AbPtgsxaOJ+42BGgmEvND6r1/gQidTJx6p
        btjEG0HclldpNlCg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/acpi: Move EFI system table lookup to helper
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-26-brijesh.singh@amd.com>
References: <20220307213356.2797205-26-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893795.389.11308265644824500826.tip-bot2@tip-bot2>
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

Commit-ID:     58f3e6b71f42f99ab5d0ab26ddf6e7ee5631f5db
Gitweb:        https://git.kernel.org/tip/58f3e6b71f42f99ab5d0ab26ddf6e7ee5631f5db
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:05 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 17:07:09 +02:00

x86/compressed/acpi: Move EFI system table lookup to helper

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related
code into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-26-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/acpi.c | 21 +++++++--------------
 arch/x86/boot/compressed/efi.c  | 29 +++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  6 ++++++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index db6c561..58a3d3f 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -105,7 +105,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	}
 
 	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
+	systab = (efi_system_table_64_t *)efi_get_system_table(boot_params);
 	if (!systab)
 		error("EFI system table not found in kexec boot_params.");
 
@@ -118,9 +118,8 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab, config_tables;
+	unsigned long systab_pa, config_tables;
 	unsigned int nr_tables;
-	struct efi_info *ei;
 	enum efi_type et;
 	bool efi_64;
 
@@ -132,24 +131,18 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	else
 		return 0;
 
-	/* Get systab from boot params. */
-	ei = &boot_params->efi_info;
-#ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
-#else
-	systab = ei->efi_systab;
-#endif
-	if (!systab)
-		error("EFI system table not found.");
+	systab_pa = efi_get_system_table(boot_params);
+	if (!systab_pa)
+		error("EFI support advertised, but unable to locate system table.");
 
 	/* Handle EFI bitness properly */
 	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
 	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_pa;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index bad0ce3..72a81ba 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -48,3 +48,32 @@ enum efi_type efi_get_type(struct boot_params *bp)
 
 	return et;
 }
+
+/**
+ * efi_get_system_table - Given a pointer to boot_params, retrieve the physical address
+ *                        of the EFI system table.
+ *
+ * @bp:         pointer to boot_params
+ *
+ * Return: EFI system table address on success. On error, return 0.
+ */
+unsigned long efi_get_system_table(struct boot_params *bp)
+{
+	unsigned long sys_tbl_pa;
+	struct efi_info *ei;
+	enum efi_type et;
+
+	/* Get systab from boot params. */
+	ei = &bp->efi_info;
+#ifdef CONFIG_X86_64
+	sys_tbl_pa = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+#else
+	sys_tbl_pa = ei->efi_systab;
+#endif
+	if (!sys_tbl_pa) {
+		debug_putstr("EFI system table not found.");
+		return 0;
+	}
+
+	return sys_tbl_pa;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fede1af..b2acd3a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -185,11 +185,17 @@ enum efi_type {
 #ifdef CONFIG_EFI
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *bp);
+unsigned long efi_get_system_table(struct boot_params *bp);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
 	return EFI_TYPE_NONE;
 }
+
+static inline unsigned long efi_get_system_table(struct boot_params *bp)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
