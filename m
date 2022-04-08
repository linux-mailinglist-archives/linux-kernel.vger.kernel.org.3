Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EEB4F9183
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiDHJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiDHJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E807123BEB;
        Fri,  8 Apr 2022 02:08:59 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9jCO3p6xutb8rjY+JEcPtGuO3+tIJTi06d1jGXlgr0=;
        b=sUFAmjlWOoTOVRuNoMfD6uY6bG7WFqTy4sheMAvCEhVqkqGmc1BiH4NrlyDPhL2qY7Q/cL
        8grUmuCeS40S+MMM832f1eVp0iyOI6/vgnaucJPxxCeC6itQ5LSHp8rUsJmiMeGYpK7dhS
        hiO26iIlHAcXhm5IythKcoqtueVVx6j/a6EGZiKjAi8jM4s8k3jBThcuiU8foCmBICiJSv
        Gjfjlw1Q5bj1BOnGEFOKi9nYJP48DupSf5F7lKNNXfR9sSAFiwHZwN4IiU6R6+YH/JhesM
        zgDCDHTHjGtVVnxsFSldGZ9Tvd8aDwnimICXmFHEmtBchyN4hhE6cZ8EGntzWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9jCO3p6xutb8rjY+JEcPtGuO3+tIJTi06d1jGXlgr0=;
        b=EZkacLhA/1svcdXgqofy9UC+BaqtzmG86237F6eTomR9huQUn7+Cf9i7E9i37y66xoQ9Wp
        HDAcml7OYOsdriAw==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/acpi: Move EFI config table lookup to helper
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-27-brijesh.singh@amd.com>
References: <20220307213356.2797205-27-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893710.389.12756087061780626317.tip-bot2@tip-bot2>
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

Commit-ID:     61c14ceda8405f37545a0983d6b9bc45c6236793
Gitweb:        https://git.kernel.org/tip/61c14ceda8405f37545a0983d6b9bc45c6236793
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:06 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 17:07:15 +02:00

x86/compressed/acpi: Move EFI config table lookup to helper

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

  [ bp: Remove superfluous zeroing of a stack variable. ]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-27-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/acpi.c | 25 ++++++-------------
 arch/x86/boot/compressed/efi.c  | 43 ++++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.h |  9 +++++++-
 3 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 58a3d3f..9a824af 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -118,10 +118,13 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long systab_pa, config_tables;
+	unsigned long cfg_tbl_pa = 0;
+	unsigned int cfg_tbl_len;
+	unsigned long systab_pa;
 	unsigned int nr_tables;
 	enum efi_type et;
 	bool efi_64;
+	int ret;
 
 	et = efi_get_type(boot_params);
 	if (et == EFI_TYPE_64)
@@ -135,23 +138,11 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (!systab_pa)
 		error("EFI support advertised, but unable to locate system table.");
 
-	/* Handle EFI bitness properly */
-	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab_pa;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab_pa;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-	}
-
-	if (!config_tables)
-		error("EFI config tables not found.");
+	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len);
+	if (ret || !cfg_tbl_pa)
+		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 72a81ba..350838e 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -77,3 +77,46 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 
 	return sys_tbl_pa;
 }
+
+/**
+ * efi_get_conf_table - Given a pointer to boot_params, locate and return the physical
+ *                      address of EFI configuration table.
+ *
+ * @bp:                 pointer to boot_params
+ * @cfg_tbl_pa:         location to store physical address of config table
+ * @cfg_tbl_len:        location to store number of config table entries
+ *
+ * Return: 0 on success. On error, return params are left unchanged.
+ */
+int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len)
+{
+	unsigned long sys_tbl_pa;
+	enum efi_type et;
+	int ret;
+
+	if (!cfg_tbl_pa || !cfg_tbl_len)
+		return -EINVAL;
+
+	sys_tbl_pa = efi_get_system_table(bp);
+	if (!sys_tbl_pa)
+		return -EINVAL;
+
+	/* Handle EFI bitness properly */
+	et = efi_get_type(bp);
+	if (et == EFI_TYPE_64) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa = stbl->tables;
+		*cfg_tbl_len = stbl->nr_tables;
+	} else if (et == EFI_TYPE_32) {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)sys_tbl_pa;
+
+		*cfg_tbl_pa = stbl->tables;
+		*cfg_tbl_len = stbl->nr_tables;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b2acd3a..8815af0 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -186,6 +186,8 @@ enum efi_type {
 /* helpers for early EFI config table access */
 enum efi_type efi_get_type(struct boot_params *bp);
 unsigned long efi_get_system_table(struct boot_params *bp);
+int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
@@ -196,6 +198,13 @@ static inline unsigned long efi_get_system_table(struct boot_params *bp)
 {
 	return 0;
 }
+
+static inline int efi_get_conf_table(struct boot_params *bp,
+				     unsigned long *cfg_tbl_pa,
+				     unsigned int *cfg_tbl_len)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
