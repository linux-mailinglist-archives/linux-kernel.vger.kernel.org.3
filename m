Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6D44F91B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiDHJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiDHJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0112B75B;
        Fri,  8 Apr 2022 02:08:58 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTRRiDOI0MfaPvfQCvT81OJcbi/L0DXG1TxpPTgSnCQ=;
        b=bNgK7jGoKSR2DkYNHYDxrE77RxfYYGkOpnwssL2R9jgPHAboreeQON/Ym/nu+iMTnWBSCN
        //9XANr0HOW04UGfDqc+uTiTo27RrvNMZgdzuAxBdMmI5jdwur/z7JnVSm4NyWmmY6dYql
        yMS7Aps+XLG8z4Sz0Rm5x71h5tPlypHD665m0WcmbSd6Vo4TR1IVPg1VpjHxCAwojLqd24
        2GKqpdEJJ8LQ/2NjcsWoxGul12b2Hq6PxAer9T0BPuLshB1gZDrednrZsK9kqSbnJsBSma
        pzyZxXmlF2fWYJoygtyTKkL2F+E+EIuZPRqfQYr/6zeCjI+25MaSOkC9dwyQ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTRRiDOI0MfaPvfQCvT81OJcbi/L0DXG1TxpPTgSnCQ=;
        b=0tS34syQ5WoXjgLuf7BOolFmkyTcUBRAK6lkWcozQSMnECLoNI7DilvehKrHlHNEsCUnuW
        XRd471Sn0r1Vh2BA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/acpi: Move EFI kexec handling into common code
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-29-brijesh.singh@amd.com>
References: <20220307213356.2797205-29-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893541.389.960600827252060270.tip-bot2@tip-bot2>
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

Commit-ID:     824f37783189a48db914488fb41eba36ec57ebb7
Gitweb:        https://git.kernel.org/tip/824f37783189a48db914488fb41eba36ec57ebb7
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:08 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 17:07:24 +02:00

x86/compressed/acpi: Move EFI kexec handling into common code

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

In this instance, the current acpi.c kexec handling is mainly used to
get the alternative EFI config table address provided by kexec via a
setup_data entry of type SETUP_EFI. If not present, the code then falls
back to normal EFI config table address provided by EFI system table.
This would need to be done by all call-sites attempting to access the
EFI config table, so just have efi_get_conf_table() handle that
automatically.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-29-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/acpi.c | 59 +--------------------------------
 arch/x86/boot/compressed/efi.c  | 46 ++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 60 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index b0c1dff..64b172d 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -47,57 +47,6 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 	return 0;
 }
 
-/* EFI/kexec support is 64-bit only. */
-#ifdef CONFIG_X86_64
-static struct efi_setup_data *get_kexec_setup_data_addr(void)
-{
-	struct setup_data *data;
-	u64 pa_data;
-
-	pa_data = boot_params->hdr.setup_data;
-	while (pa_data) {
-		data = (struct setup_data *)pa_data;
-		if (data->type == SETUP_EFI)
-			return (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
-
-		pa_data = data->next;
-	}
-	return NULL;
-}
-
-static acpi_physical_address kexec_get_rsdp_addr(void)
-{
-	efi_system_table_64_t *systab;
-	struct efi_setup_data *esd;
-	struct efi_info *ei;
-	enum efi_type et;
-
-	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
-	if (!esd)
-		return 0;
-
-	if (!esd->tables) {
-		debug_putstr("Wrong kexec SETUP_EFI data.\n");
-		return 0;
-	}
-
-	et = efi_get_type(boot_params);
-	if (et != EFI_TYPE_64) {
-		debug_putstr("Unexpected kexec EFI environment (expected 64-bit EFI).\n");
-		return 0;
-	}
-
-	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *)efi_get_system_table(boot_params);
-	if (!systab)
-		error("EFI system table not found in kexec boot_params.");
-
-	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables);
-}
-#else
-static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
-#endif /* CONFIG_X86_64 */
-
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
@@ -210,14 +159,6 @@ acpi_physical_address get_rsdp_addr(void)
 
 	pa = boot_params->acpi_rsdp_addr;
 
-	/*
-	 * Try to get EFI data from setup_data. This can happen when we're a
-	 * kexec'ed kernel and kexec(1) has passed all the required EFI info to
-	 * us.
-	 */
-	if (!pa)
-		pa = kexec_get_rsdp_addr();
-
 	if (!pa)
 		pa = efi_get_rsdp_addr();
 
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 4d363df..09fa3b5 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -78,6 +78,46 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 	return sys_tbl_pa;
 }
 
+/*
+ * EFI config table address changes to virtual address after boot, which may
+ * not be accessible for the kexec'd kernel. To address this, kexec provides
+ * the initial physical address via a struct setup_data entry, which is
+ * checked for here, along with some sanity checks.
+ */
+static struct efi_setup_data *get_kexec_setup_data(struct boot_params *bp,
+						   enum efi_type et)
+{
+#ifdef CONFIG_X86_64
+	struct efi_setup_data *esd = NULL;
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = bp->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *)pa_data;
+		if (data->type == SETUP_EFI) {
+			esd = (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
+			break;
+		}
+
+		pa_data = data->next;
+	}
+
+	/*
+	 * Original ACPI code falls back to attempting normal EFI boot in these
+	 * cases, so maintain existing behavior by indicating non-kexec
+	 * environment to the caller, but print them for debugging.
+	 */
+	if (esd && !esd->tables) {
+		debug_putstr("kexec EFI environment missing valid configuration table.\n");
+		return NULL;
+	}
+
+	return esd;
+#endif
+	return NULL;
+}
+
 /**
  * efi_get_conf_table - Given a pointer to boot_params, locate and return the physical
  *                      address of EFI configuration table.
@@ -106,8 +146,12 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 	et = efi_get_type(bp);
 	if (et == EFI_TYPE_64) {
 		efi_system_table_64_t *stbl = (efi_system_table_64_t *)sys_tbl_pa;
+		struct efi_setup_data *esd;
 
-		*cfg_tbl_pa = stbl->tables;
+		/* kexec provides an alternative EFI conf table, check for it. */
+		esd = get_kexec_setup_data(bp, et);
+
+		*cfg_tbl_pa = esd ? esd->tables : stbl->tables;
 		*cfg_tbl_len = stbl->nr_tables;
 	} else if (et == EFI_TYPE_32) {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)sys_tbl_pa;
