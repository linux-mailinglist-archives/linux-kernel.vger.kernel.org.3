Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75914F91A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiDHJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiDHJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A366104A77;
        Fri,  8 Apr 2022 02:08:46 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXM7pF8EYdzUeNPON4Uz0K/2KPT91m82OfdwuPgDEUU=;
        b=AmE6Pru6abHQxX00hz9YBLC8w2Q7uzRYZFaHTAjwJTl64djMXvFL0pHmpZ82Blwl2ZAcy4
        DcYl40zP6p+R6Tc/KK886uo7coxeQsOKAFfnLcsXl7nUdW8reMznBu4QNY4xMzzlLd3/J1
        KUuPjMN008iGzB8nsT7DWlpPG4OjjrXcPg/tK4ZJqtlKI4jOSFPIKyTO5Clx6OwfR10M6m
        BxNIQRjCRgfN2TD0tOX6IHK5N9dxYInXOgRuF94INOPxK+qOD5TlIKQITenb7236i3pEK+
        Bx9aXVqN6Cqa4h4WhoaQeZ6XhbCTxF0L5lgfaF7OZLwdqe7Yh2zGkKsLKvAmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXM7pF8EYdzUeNPON4Uz0K/2KPT91m82OfdwuPgDEUU=;
        b=1oAFT5my9fuYN/g/6Mn5J67B8H7H9UqH1db/W8h3OZ59VaoFOiJ1wUUyI9I0u8eW8YdS58
        xjXl6e8UtbEJN0Bg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Use firmware-validated CPUID for SEV-SNP guests
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-40-brijesh.singh@amd.com>
References: <20220307213356.2797205-40-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892371.389.11665481653675221516.tip-bot2@tip-bot2>
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

Commit-ID:     30612045e69d088f1effd748048ebb0e282984ec
Gitweb:        https://git.kernel.org/tip/30612045e69d088f1effd748048ebb0e282984ec
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Mon, 07 Mar 2022 15:33:49 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:12 +02:00

x86/sev: Use firmware-validated CPUID for SEV-SNP guests

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the run-time kernel either through a boot_params field that
was initialized by the boot/compressed kernel, or via a setup_data
structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing blob from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
run-time kernel will use when servicing CPUID instructions via a #VC
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-40-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c | 37 +---------------------------------
 arch/x86/kernel/sev-shared.c   | 37 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          | 24 +++++++++++++++++++++-
 3 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 82079ce..52f989f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -382,43 +382,6 @@ found_cc_info:
 }
 
 /*
- * Initialize the kernel's copy of the SNP CPUID table, and set up the
- * pointer that will be used to access it.
- *
- * Maintaining a direct mapping of the SNP CPUID table used by firmware would
- * be possible as an alternative, but the approach is brittle since the
- * mapping needs to be updated in sync with all the changes to virtual memory
- * layout and related mapping facilities throughout the boot process.
- */
-static void setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
-{
-	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
-	int i;
-
-	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
-	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_table = snp_cpuid_get_table();
-	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
-
-	/* Initialize CPUID ranges for range-checking. */
-	for (i = 0; i < cpuid_table->count; i++) {
-		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
-
-		if (fn->eax_in == 0x0)
-			cpuid_std_range_max = fn->eax;
-		else if (fn->eax_in == 0x40000000)
-			cpuid_hyp_range_max = fn->eax;
-		else if (fn->eax_in == 0x80000000)
-			cpuid_ext_range_max = fn->eax;
-	}
-}
-
-/*
  * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
  * will verify the SNP CPUID/MSR bits.
  */
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index a7a1c0f..2b4270d 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -964,3 +964,40 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 
 	return NULL;
 }
+
+/*
+ * Initialize the kernel's copy of the SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SNP CPUID table used by firmware would
+ * be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
+	int i;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
+	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table = snp_cpuid_get_table();
+	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
+
+	/* Initialize CPUID ranges for range-checking. */
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x0)
+			cpuid_std_range_max = fn->eax;
+		else if (fn->eax_in == 0x40000000)
+			cpuid_hyp_range_max = fn->eax;
+		else if (fn->eax_in == 0x80000000)
+			cpuid_ext_range_max = fn->eax;
+	}
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 692da7b..c873372 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -34,6 +34,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid.h>
+#include <asm/cmdline.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -2025,6 +2026,8 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	setup_cpuid_table(cc_info);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
@@ -2038,3 +2041,24 @@ void __init snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it,
+ * so do it here.
+ */
+static int __init report_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+
+	if (!cpuid_table->count)
+		return 0;
+
+	pr_info("Using SNP CPUID table, %d entries present.\n",
+		cpuid_table->count);
+
+	return 0;
+}
+arch_initcall(report_cpuid_table);
