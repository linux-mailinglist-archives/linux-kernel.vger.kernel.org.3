Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B67A4F91B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiDHJP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiDHJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533B1947B4;
        Fri,  8 Apr 2022 02:08:58 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BQztWhy4XT/p0rlLhukJlIiCwhBWxz9r9gt/kXqJjU=;
        b=0LxPVtClwEntKE7/VobC86DOQ28zopCydZOxa3hF37AiR2cBiZOsXVDQekDNW9XOaLLgvz
        wXfo5jSsfBqRHrmNBqCOb+RzyWkpCe3/A+iIqKN7Yg9TvGnPu/3m5OAqo0m4S/KMcQu2Ow
        pikfNfABV011Xv0g2K8l+8LW0DmfI8iTeqwheQ/6bGcFArAQN1NUqUAO4IS/LXDFbA/jp/
        DHM+nWKdVbUp3v1sqD5hFl1tDGPS1i+fUcCfPI5mLZOV0+y5UUubiVtXIYWgXFhUKcWfhY
        8R6FLE56oJ2R4jqG6yOrkErOPpQEGjRlHwaSn19jkq9Rgl507iEMbwQTbQN7iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BQztWhy4XT/p0rlLhukJlIiCwhBWxz9r9gt/kXqJjU=;
        b=adKD9HM2DRCJf2+02StOtQbyqNy9Nny60tr/ckhL9s1Uh+orQ9GeEMYjnwfXdZAo2b+AEI
        2ruQ3Zq4teEyIhBA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/acpi: Move EFI vendor table lookup to helper
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-28-brijesh.singh@amd.com>
References: <20220307213356.2797205-28-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893623.389.8376155297904980976.tip-bot2@tip-bot2>
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

Commit-ID:     dee602dd5d1489b5aa4651c561dfbe90eaee1589
Gitweb:        https://git.kernel.org/tip/dee602dd5d1489b5aa4651c561dfbe90eaee1589
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:07 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 17:07:19 +02:00

x86/compressed/acpi: Move EFI vendor table lookup to helper

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

  [ bp: Unbreak unnecessarily broken lines. ]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-28-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/acpi.c | 68 ++++++++++---------------------
 arch/x86/boot/compressed/efi.c  | 70 ++++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.h | 13 ++++++-
 3 files changed, 106 insertions(+), 45 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9a824af..b0c1dff 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -20,48 +20,31 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
-/*
- * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
- * ACPI_TABLE_GUID are found, take the former, which has more features.
- */
 static acpi_physical_address
-__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
-		    bool efi_64)
+__efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 {
-	acpi_physical_address rsdp_addr = 0;
-
 #ifdef CONFIG_EFI
-	int i;
-
-	/* Get EFI tables from systab. */
-	for (i = 0; i < nr_tables; i++) {
-		acpi_physical_address table;
-		efi_guid_t guid;
-
-		if (efi_64) {
-			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-
-			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
-				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
-				return 0;
-			}
-		} else {
-			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-		}
+	unsigned long rsdp_addr;
+	int ret;
 
-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
-			rsdp_addr = table;
-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
-			return table;
-	}
+	/*
+	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
+	 * ACPI_TABLE_GUID because it has more features.
+	 */
+	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+					  ACPI_20_TABLE_GUID);
+	if (rsdp_addr)
+		return (acpi_physical_address)rsdp_addr;
+
+	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
+	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+					  ACPI_TABLE_GUID);
+	if (rsdp_addr)
+		return (acpi_physical_address)rsdp_addr;
+
+	debug_putstr("Error getting RSDP address.\n");
 #endif
-	return rsdp_addr;
+	return 0;
 }
 
 /* EFI/kexec support is 64-bit only. */
@@ -109,7 +92,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 	if (!systab)
 		error("EFI system table not found in kexec boot_params.");
 
-	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
+	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables);
 }
 #else
 static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
@@ -123,15 +106,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long systab_pa;
 	unsigned int nr_tables;
 	enum efi_type et;
-	bool efi_64;
 	int ret;
 
 	et = efi_get_type(boot_params);
-	if (et == EFI_TYPE_64)
-		efi_64 = true;
-	else if (et == EFI_TYPE_32)
-		efi_64 = false;
-	else
+	if (et == EFI_TYPE_NONE)
 		return 0;
 
 	systab_pa = efi_get_system_table(boot_params);
@@ -142,7 +120,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 350838e..4d363df 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -120,3 +120,73 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 
 	return 0;
 }
+
+/* Get vendor table address/guid from EFI config table at the given index */
+static int get_vendor_table(void *cfg_tbl, unsigned int idx,
+			    unsigned long *vendor_tbl_pa,
+			    efi_guid_t *vendor_tbl_guid,
+			    enum efi_type et)
+{
+	if (et == EFI_TYPE_64) {
+		efi_config_table_64_t *tbl_entry = (efi_config_table_64_t *)cfg_tbl + idx;
+
+		if (!IS_ENABLED(CONFIG_X86_64) && tbl_entry->table >> 32) {
+			debug_putstr("Error: EFI config table entry located above 4GB.\n");
+			return -EINVAL;
+		}
+
+		*vendor_tbl_pa = tbl_entry->table;
+		*vendor_tbl_guid = tbl_entry->guid;
+
+	} else if (et == EFI_TYPE_32) {
+		efi_config_table_32_t *tbl_entry = (efi_config_table_32_t *)cfg_tbl + idx;
+
+		*vendor_tbl_pa = tbl_entry->table;
+		*vendor_tbl_guid = tbl_entry->guid;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * efi_find_vendor_table - Given EFI config table, search it for the physical
+ *                         address of the vendor table associated with GUID.
+ *
+ * @bp:                pointer to boot_params
+ * @cfg_tbl_pa:        pointer to EFI configuration table
+ * @cfg_tbl_len:       number of entries in EFI configuration table
+ * @guid:              GUID of vendor table
+ *
+ * Return: vendor table address on success. On error, return 0.
+ */
+unsigned long efi_find_vendor_table(struct boot_params *bp,
+				    unsigned long cfg_tbl_pa,
+				    unsigned int cfg_tbl_len,
+				    efi_guid_t guid)
+{
+	enum efi_type et;
+	unsigned int i;
+
+	et = efi_get_type(bp);
+	if (et == EFI_TYPE_NONE)
+		return 0;
+
+	for (i = 0; i < cfg_tbl_len; i++) {
+		unsigned long vendor_tbl_pa;
+		efi_guid_t vendor_tbl_guid;
+		int ret;
+
+		ret = get_vendor_table((void *)cfg_tbl_pa, i,
+				       &vendor_tbl_pa,
+				       &vendor_tbl_guid, et);
+		if (ret)
+			return 0;
+
+		if (!efi_guidcmp(guid, vendor_tbl_guid))
+			return vendor_tbl_pa;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 8815af0..ba538af 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,6 +23,7 @@
 #include <linux/screen_info.h>
 #include <linux/elf.h>
 #include <linux/io.h>
+#include <linux/efi.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
@@ -188,6 +189,10 @@ enum efi_type efi_get_type(struct boot_params *bp);
 unsigned long efi_get_system_table(struct boot_params *bp);
 int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 		       unsigned int *cfg_tbl_len);
+unsigned long efi_find_vendor_table(struct boot_params *bp,
+				    unsigned long cfg_tbl_pa,
+				    unsigned int cfg_tbl_len,
+				    efi_guid_t guid);
 #else
 static inline enum efi_type efi_get_type(struct boot_params *bp)
 {
@@ -205,6 +210,14 @@ static inline int efi_get_conf_table(struct boot_params *bp,
 {
 	return -ENOENT;
 }
+
+static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
+						  unsigned long cfg_tbl_pa,
+						  unsigned int cfg_tbl_len,
+						  efi_guid_t guid)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* BOOT_COMPRESSED_MISC_H */
