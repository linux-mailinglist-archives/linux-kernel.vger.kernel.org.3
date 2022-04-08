Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8104F91C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiDHJPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiDHJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF361E86BE;
        Fri,  8 Apr 2022 02:09:09 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zVJxZmTkeFBH8xY0eIsdhqZxrT9IdulUaaEJaYUEDg=;
        b=2bvgesqa0+GDb31z3s0KT4zVKyPobnJwMOXZGPAOq/m9XahnazPkk/ObHpLZ0/NWnA/ZOW
        0uVpmcwZlUXn1bjr0R4DU5svK/Ub9y/0OaA6OpbJ4iYlkXtbft1E+58xJso7Wio7zl6Ym1
        Cyam9yqJDyAjclF12om2bPepYAlbVEW9eC6JEL/wBeGK2YuEKIW3Unkc8PHOmWrl3Ywfdn
        RdIF1iU97XoxQlkwrK51Nc4TAImZpezZGHHFOOUhok9zT87nD7A0XEaA6JCIefctd4M/bl
        jHmbDWVLr93WiqEfChZY8wfat9JPR5oH5vdty9jOCCIiZv2d64DUWzNG3XJY2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zVJxZmTkeFBH8xY0eIsdhqZxrT9IdulUaaEJaYUEDg=;
        b=SJ8mrd+eptObALeWz1ajDTVfURlCvge22L66KlT+d4N2uc8a1NTWB19/jkK2gwBSa16Bud
        tFgfRMmpuK4s+IBA==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Check the VMPL level
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-15-brijesh.singh@amd.com>
References: <20220307213356.2797205-15-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894730.389.11280397008447131834.tip-bot2@tip-bot2>
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

Commit-ID:     81cc3df9a90e7817494421ecc48ede6bd5e8132b
Gitweb:        https://git.kernel.org/tip/81cc3df9a90e7817494421ecc48ede6bd5e8132b
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:08 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:10:34 +02:00

x86/sev: Check the VMPL level

The Virtual Machine Privilege Level (VMPL) feature in the SEV-SNP
architecture allows a guest VM to divide its address space into four
levels. The level can be used to provide hardware isolated abstraction
layers within a VM. VMPL0 is the highest privilege level, and VMPL3 is
the least privilege level. Certain operations must be done by the VMPL0
software, such as:

* Validate or invalidate memory range (PVALIDATE instruction)
* Allocate VMSA page (RMPADJUST instruction when VMSA=1)

The initial SNP support requires that the guest kernel is running at
VMPL0. Add such a check to verify the guest is running at level 0 before
continuing the boot. There is no easy method to query the current VMPL
level, so use the RMPADJUST instruction to determine whether the guest
is running at the VMPL0.

  [ bp: Massage commit message. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-15-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c    | 28 ++++++++++++++++++++++++++--
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        | 16 ++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5b38931..eb42178 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -199,6 +199,26 @@ finish:
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
+static void enforce_vmpl0(void)
+{
+	u64 attrs;
+	int err;
+
+	/*
+	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
+	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
+	 * GHCB page. If the guest is not running at VMPL0, this will fail.
+	 *
+	 * If the guest is running at VMPL0, it will succeed. Even if that operation
+	 * modifies permission bits, it is still ok to do so currently because Linux
+	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
+	 * changing is a don't-care.
+	 */
+	attrs = 1;
+	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+}
+
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -242,8 +262,12 @@ void sev_enable(struct boot_params *bp)
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features.
 	 */
-	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		enforce_vmpl0();
+	}
 
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 6f037c2..7ac5842 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -89,6 +89,7 @@
 #define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+#define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4ee9897..e374518 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -63,6 +63,9 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
+/* RMP page size */
+#define RMP_PG_SIZE_4K			0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -90,6 +93,18 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
+{
+	int rc;
+
+	/* "rmpadjust" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF3,0x0F,0x01,0xFE\n\t"
+		     : "=a"(rc)
+		     : "a"(vaddr), "c"(rmp_psize), "d"(attrs)
+		     : "memory", "cc");
+
+	return rc;
+}
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 {
 	bool no_rmpupdate;
@@ -114,6 +129,7 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
+static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 #endif
 
 #endif
