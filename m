Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A844F919F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiDHJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiDHJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D4120D8C;
        Fri,  8 Apr 2022 02:08:47 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWqzvi/1ICvll5JWYNjjw5mF7X1leiO6Sw4Rdg/KcGQ=;
        b=B4eAViZag/Ar17/wZ2qzJ3op55/eYCWV8/89VhN1RVOeVnBJzd0L1JfhBqVpEZ66XbYI1r
        grbw6E846ZUd4Gwd95WHnH1CnEEo+x8YI2q8ek5yFAwu1f9YvpqU1MXWZKt4aJqMwziiGC
        44S9Z2UaARg6QHCujJnvkOCTftUehDIbPWariohqR2kM8sfTSmfXn97IgbLzqtxpRKC5Zb
        qt/HPvRLKksJIMuEzbJ6UNwq2Dq5jRIq2UFzGg5J7jpcSJ1KS3qxIHHMVkSxy/gt73r+qm
        GhyB0PX6nmdmAJ7CkrZKNuXtLVAcPKiWe5gR9GwRdQ5vHgRq3OA6Vaky+2Lfrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWqzvi/1ICvll5JWYNjjw5mF7X1leiO6Sw4Rdg/KcGQ=;
        b=6iDElN38zvvzevpfVbJu1hEYCJIvyx1VTdPwAdFjiKeAW5oZqaAV5e6U8UfDmphL5tzT4V
        WPcE2nxp3Q4Q7dCg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add SEV-SNP feature detection/setup
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-39-brijesh.singh@amd.com>
References: <20220307213356.2797205-39-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892473.389.1913619871609226576.tip-bot2@tip-bot2>
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

Commit-ID:     b190a043c49af4587f5e157053f909192820522a
Gitweb:        https://git.kernel.org/tip/b190a043c49af4587f5e157053f909192820522a
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:18 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

x86/sev: Add SEV-SNP feature detection/setup

Initial/preliminary detection of SEV-SNP is done via the Confidential
Computing blob. Check for it prior to the normal SEV/SME feature
initialization, and add some sanity checks to confirm it agrees with
SEV-SNP CPUID/MSR bits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-39-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c     | 27 +------------
 arch/x86/include/asm/sev.h         |  2 +-
 arch/x86/kernel/sev-shared.c       | 27 ++++++++++++-
 arch/x86/kernel/sev.c              | 64 +++++++++++++++++++++++++++++-
 arch/x86/mm/mem_encrypt_identity.c |  8 ++++-
 5 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 1e4930c..82079ce 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -352,33 +352,6 @@ static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
 								EFI_CC_BLOB_GUID);
 }
 
-struct cc_setup_data {
-	struct setup_data header;
-	u32 cc_blob_address;
-};
-
-/*
- * Search for a Confidential Computing blob passed in as a setup_data entry
- * via the Linux Boot Protocol.
- */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
-{
-	struct cc_setup_data *sd = NULL;
-	struct setup_data *hdr;
-
-	hdr = (struct setup_data *)bp->hdr.setup_data;
-
-	while (hdr) {
-		if (hdr->type == SETUP_CC_BLOB) {
-			sd = (struct cc_setup_data *)hdr;
-			return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
-		}
-		hdr = (struct setup_data *)hdr->next;
-	}
-
-	return NULL;
-}
-
 /*
  * Initial set up of SNP relies on information provided by the
  * Confidential Computing blob, which can be passed to the boot kernel
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 31b3b10..84d3d51 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -153,6 +153,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
+void snp_abort(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -171,6 +172,7 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
+static inline void snp_abort(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 0f13751..a7a1c0f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -937,3 +937,30 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
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
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0c2bf39..692da7b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1974,3 +1974,67 @@ fail:
 	while (true)
 		halt();
 }
+
+/*
+ * Initial set up of SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the kernel
+ * in the following ways, depending on how it is booted:
+ *
+ * - when booted via the boot/decompress kernel:
+ *   - via boot_params
+ *
+ * - when booted directly by firmware/bootloader (e.g. CONFIG_PVH):
+ *   - via a setup_data entry, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	/* Boot kernel would have passed the CC blob via boot_params. */
+	if (bp->cc_blob_address) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
+		goto found_cc_info;
+	}
+
+	/*
+	 * If kernel was booted directly, without the use of the
+	 * boot/decompression kernel, the CC blob may have been passed via
+	 * setup_data instead.
+	 */
+	cc_info = find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		snp_abort();
+
+	return cc_info;
+}
+
+bool __init snp_init(struct boot_params *bp)
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
+	 * The CC blob will be used later to access the secrets page. Cache
+	 * it here like the boot kernel does.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
+
+void __init snp_abort(void)
+{
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+}
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index b43bc24..f415498 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -45,6 +45,7 @@
 #include <asm/sections.h>
 #include <asm/cmdline.h>
 #include <asm/coco.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -509,8 +510,11 @@ void __init sme_enable(struct boot_params *bp)
 	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
+	bool snp;
 	u64 msr;
 
+	snp = snp_init(bp);
+
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
@@ -542,6 +546,10 @@ void __init sme_enable(struct boot_params *bp)
 	sev_status   = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
+	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		snp_abort();
+
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
 		/*
