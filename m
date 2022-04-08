Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEBC4F9187
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiDHJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiDHJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B303100764;
        Fri,  8 Apr 2022 02:08:51 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96QTTS7mLZ3+s/LblEr7rpg0URocDDiOKOjGn7csk/c=;
        b=pxPyLVUNhy5ayhtyZu7/lH5NPbjz818n+b1ca3FrDgar9JI98zQxJxVzaQjzfz7E5/nKoC
        fz/BS6UUHogCXx2l54AqY0fS0AX3hVgQbGSxShfy2qmZBPeQtiaCn4jesgqYgUsKFBt2DD
        4nqVQZVrtiS3Em7nSbH3Idd0IxsWrrn9+T5IDJAKZO3gib6nwk1ov4nvhAUXiechIRd7nR
        XTlES92a8hroNh+Clt+SGlxC8m0+i1Ms0H0LHTmZ5EHly8oiRyqUU6xSPUUwVNxwa9PQwR
        R+ajmNdLV6IGoqvrh25WoBxL/cNMRJWjey6s3dIE0+QVIkWlpq/DsUYxx4k2Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96QTTS7mLZ3+s/LblEr7rpg0URocDDiOKOjGn7csk/c=;
        b=S57LF9/nU8Y4xhznJ4AGqMRjJwHNj1Sme3jeMGyGx47mJJIAmxA9+wiwwb8SWus1hInAFR
        N0phLon3H3OsrpCw==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed: Add SEV-SNP feature detection/setup
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-35-brijesh.singh@amd.com>
References: <20220307213356.2797205-35-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892885.389.7131493838332728001.tip-bot2@tip-bot2>
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

Commit-ID:     c01fce9cef8491974f7f007f90281f1608400768
Gitweb:        https://git.kernel.org/tip/c01fce9cef8491974f7f007f90281f1608400768
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:14 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

x86/compressed: Add SEV-SNP feature detection/setup

Initial/preliminary detection of SEV-SNP is done via the Confidential
Computing blob. Check for it prior to the normal SEV/SME feature
initialization, and add some sanity checks to confirm it agrees with
SEV-SNP CPUID/MSR bits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-35-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c | 112 +++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h     |   3 +-
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 7a9cfbc..2a94bb7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -274,6 +274,13 @@ void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	struct msr m;
+	bool snp;
+
+	/*
+	 * Setup/preliminary detection of SNP. This will be sanity-checked
+	 * against CPUID/MSR values later.
+	 */
+	snp = snp_init(bp);
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
@@ -294,8 +301,11 @@ void sev_enable(struct boot_params *bp)
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	/* Check whether SEV is supported */
-	if (!(eax & BIT(1)))
+	if (!(eax & BIT(1))) {
+		if (snp)
+			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
+	}
 
 	/* Set the SME mask if this is an SEV guest. */
 	boot_rdmsr(MSR_AMD64_SEV, &m);
@@ -320,5 +330,105 @@ void sev_enable(struct boot_params *bp)
 		enforce_vmpl0();
 	}
 
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
+
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
+
+/* Search for Confidential Computing blob in the EFI config table. */
+static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
+{
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	int ret;
+
+	ret = efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
+	if (ret)
+		return NULL;
+
+	return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_table_pa,
+								cfg_table_len,
+								EFI_CC_BLOB_GUID);
+}
+
+struct cc_setup_data {
+	struct setup_data header;
+	u32 cc_blob_address;
+};
+
+/*
+ * Search for a Confidential Computing blob passed in as a setup_data entry
+ * via the Linux Boot Protocol.
+ */
+static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+{
+	struct cc_setup_data *sd = NULL;
+	struct setup_data *hdr;
+
+	hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB) {
+			sd = (struct cc_setup_data *)hdr;
+			return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+		}
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * Initial set up of SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the boot kernel
+ * by firmware/bootloader in the following ways:
+ *
+ * - via an entry in the EFI config table
+ * - via a setup_data structure, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	cc_info = find_cc_blob_efi(bp);
+	if (cc_info)
+		goto found_cc_info;
+
+	cc_info = find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+
+/*
+ * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
+ * will verify the SNP CPUID/MSR bits.
+ */
+bool snp_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		return false;
+
+	cc_info = find_cc_blob(bp);
+	if (!cc_info)
+		return false;
+
+	/*
+	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
+	 * config table doesn't need to be searched again during early startup
+	 * phase.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 8c934bd..31b3b10 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -151,6 +152,7 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+bool snp_init(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -168,6 +170,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, 
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
+static inline bool snp_init(struct boot_params *bp) { return false; }
 #endif
 
 #endif
