Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB74F91D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiDHJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiDHJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7071E86AF;
        Fri,  8 Apr 2022 02:09:09 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81Dl+NL4i86EUD/tDxKsulOhMJAcoi2yESqh2e3S44U=;
        b=xGsY6jF4wLeK5IozVrZG6lBbW/XFdUV/xMBbn0lfC0nh0ThSP2ajsJeOUmuaPpGtk3umAD
        2gcoUT19kXUBqz80SFZOLXiNsChKy/a1BxKh+vKLeuUuHF1RGwsaSHvODLWWOVcfiRXNng
        CpGWUpDGw1F72wX9S/hxKYaMLcyqXKu2x+xJMQl5GUMTpM6EQISj+TJFT39K+tk+tdI2v4
        qDirJheAKFIpa1VgsT7XazCGj1Ce6bV1owPfO853u5DlX7SabdUtu+gWzSW0MBGPLDgskl
        ZPc4L9JT6fPVedLZKHac1KVHZQQkRYAiGKoVFYkj6O1igf21JxnGDzUS7MP1VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81Dl+NL4i86EUD/tDxKsulOhMJAcoi2yESqh2e3S44U=;
        b=KH+U8nS5LWBUNs2gF3jb/qoG5EU5zWNZ4aAFrEYRmqp3FGGAZy8X8Wl/+wrXe0iFS9GHzG
        yCyZkeITFLDGbQCA==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed: Add helper for validating pages in the
 decompression stage
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-16-brijesh.singh@amd.com>
References: <20220307213356.2797205-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894646.389.17136891705750729768.tip-bot2@tip-bot2>
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

Commit-ID:     4f9c403e44e5e88feb27d5e617d1adc9cc7ef684
Gitweb:        https://git.kernel.org/tip/4f9c403e44e5e88feb27d5e617d1adc9cc7ef684
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:09 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:10:40 +02:00

x86/compressed: Add helper for validating pages in the decompression stage

Many of the integrity guarantees of SEV-SNP are enforced through the
Reverse Map Table (RMP). Each RMP entry contains the GPA at which a
particular page of DRAM should be mapped. The VMs can request the
hypervisor to add pages in the RMP table via the Page State Change
VMGEXIT defined in the GHCB specification.

Inside each RMP entry is a Validated flag; this flag is automatically
cleared to 0 by the CPU hardware when a new RMP entry is created for a
guest. Each VM page can be either validated or invalidated, as indicated
by the Validated flag in the RMP entry. Memory access to a private page
that is not validated generates a #VC. A VM must use the PVALIDATE
instruction to validate a private page before using it.

To maintain the security guarantee of SEV-SNP guests, when transitioning
pages from private to shared, the guest must invalidate the pages before
asking the hypervisor to change the page state to shared in the RMP table.

After the pages are mapped private in the page table, the guest must
issue a page state change VMGEXIT to mark the pages private in the RMP
table and validate them.

Upon boot, BIOS should have validated the entire system memory.
During the kernel decompression stage, early_setup_ghcb() uses
set_page_decrypted() to make the GHCB page shared (i.e. clear encryption
attribute). And while exiting from the decompression, it calls
set_page_encrypted() to make the page private.

Add snp_set_page_{private,shared}() helpers that are used by
set_page_{decrypted,encrypted}() to change the page state in the RMP
table.

  [ bp: Massage commit message and comments. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-16-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/ident_map_64.c | 18 ++++++++-
 arch/x86/boot/compressed/misc.h         |  4 ++-
 arch/x86/boot/compressed/sev.c          | 46 ++++++++++++++++++++++++-
 arch/x86/include/asm/sev-common.h       | 26 ++++++++++++++-
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0..613367e 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -275,15 +275,31 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	 * Changing encryption attributes of a page requires to flush it from
 	 * the caches.
 	 */
-	if ((set | clr) & _PAGE_ENC)
+	if ((set | clr) & _PAGE_ENC) {
 		clflush_page(address);
 
+		/*
+		 * If the encryption attribute is being cleared, change the page state
+		 * to shared in the RMP table.
+		 */
+		if (clr)
+			snp_set_page_shared(__pa(address & PAGE_MASK));
+	}
+
 	/* Update PTE */
 	pte = *ptep;
 	pte = pte_set_flags(pte, set);
 	pte = pte_clear_flags(pte, clr);
 	set_pte(ptep, pte);
 
+	/*
+	 * If the encryption attribute is being set, then change the page state to
+	 * private in the RMP entry. The page state change must be done after the PTE
+	 * is updated.
+	 */
+	if (set & _PAGE_ENC)
+		snp_set_page_private(__pa(address & PAGE_MASK));
+
 	/* Flush TLB after changing encryption attribute */
 	write_cr3(top_level_pgt);
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 23e0e39..01cc13c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -124,6 +124,8 @@ static inline void console_init(void)
 void sev_enable(struct boot_params *bp);
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
+void snp_set_page_private(unsigned long paddr);
+void snp_set_page_shared(unsigned long paddr);
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -131,6 +133,8 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
 	return false;
 }
+static inline void snp_set_page_private(unsigned long paddr) { }
+static inline void snp_set_page_shared(unsigned long paddr) { }
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index eb42178..5f2c268 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,6 +116,52 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static inline bool sev_snp_enabled(void)
+{
+	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
+static void __page_state_change(unsigned long paddr, enum psc_op op)
+{
+	u64 val;
+
+	if (!sev_snp_enabled())
+		return;
+
+	/*
+	 * If private -> shared then invalidate the page before requesting the
+	 * state change in the RMP table.
+	 */
+	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+
+	/* Issue VMGEXIT to change the page state in RMP table. */
+	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+	VMGEXIT();
+
+	/* Read the response of the VMGEXIT. */
+	val = sev_es_rd_ghcb_msr();
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	/*
+	 * Now that page state is changed in the RMP table, validate it so that it is
+	 * consistent with the RMP entry.
+	 */
+	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+void snp_set_page_private(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
+}
+
+void snp_set_page_shared(unsigned long paddr)
+{
+	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
+}
+
 static bool early_setup_ghcb(void)
 {
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 7ac5842..fe7fe16 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,32 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/*
+ * SNP Page State Change Operation
+ *
+ * GHCBData[55:52] - Page operation:
+ *   0x0001	Page assignment, Private
+ *   0x0002	Page assignment, Shared
+ */
+enum psc_op {
+	SNP_PAGE_STATE_PRIVATE = 1,
+	SNP_PAGE_STATE_SHARED,
+};
+
+#define GHCB_MSR_PSC_REQ		0x014
+#define GHCB_MSR_PSC_REQ_GFN(gfn, op)			\
+	/* GHCBData[55:52] */				\
+	(((u64)((op) & 0xf) << 52) |			\
+	/* GHCBData[51:12] */				\
+	((u64)((gfn) & GENMASK_ULL(39, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_PSC_REQ)
+
+#define GHCB_MSR_PSC_RESP		0x015
+#define GHCB_MSR_PSC_RESP_VAL(val)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
+
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
