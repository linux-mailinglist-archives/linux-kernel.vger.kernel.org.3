Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669134F91D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiDHJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiDHJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E591E95E1;
        Fri,  8 Apr 2022 02:09:11 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6BbRaW/uSvLscYBsOnZuEO87siDzNKmlEzTIZmqJXk=;
        b=C77iKNgEWIBmGP2Qx1Cme761D4rdwcTDm79cPSqFOfi4lRNuJSOiQamUWgTNDjIDVyq5A5
        UGdOnJOC0s8RNZaP+14Y66lvhAEdghgcf5bT69gZ6TeBLRDfKhHIm15pmN/uKuk9fuQ5hV
        e1wArbXTBw/wEDt+SoGhC5Jhf4C3D7q15XcHKi8fNyWqff2ZRWUvhMT4Dj+KxtZxgYWSW9
        ZbVGzrctzPs22Gjnr+KjaRnMk3GTbJAnScSi7wbgBVKr9s71EoBy70AyBEf9JwKb89OmoP
        h5hKeSlncabFtxlLB+3QO5Jyk9OQOuoKnin9zp/PpOmeBKQfUc06GYfwR+f0Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6BbRaW/uSvLscYBsOnZuEO87siDzNKmlEzTIZmqJXk=;
        b=2L7j8e47EQcbmC5/1k6m+tZP0zm+lPpiXin3V7Uji8A/t0s07KkMkkFczozgi0iMms3FGB
        m0rQCteqoFnKtZAw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Check SEV-SNP features support
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-13-brijesh.singh@amd.com>
References: <20220307213356.2797205-13-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894898.389.17627611818379551536.tip-bot2@tip-bot2>
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

Commit-ID:     cbd3d4f7c4e5a93edae68e5142a269368fde77d6
Gitweb:        https://git.kernel.org/tip/cbd3d4f7c4e5a93edae68e5142a269368fde77d6
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:06 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:10:23 +02:00

x86/sev: Check SEV-SNP features support

Version 2 of the GHCB specification added the advertisement of features
that are supported by the hypervisor. If the hypervisor supports SEV-SNP
then it must set the SEV-SNP features bit to indicate that the base
functionality is supported.

Check that feature bit while establishing the GHCB; if failed, terminate
the guest.

Version 2 of the GHCB specification adds several new Non-Automatic Exits
(NAEs), most of them are optional except the hypervisor feature. Now
that the hypervisor feature NAE is implemented, bump the GHCB maximum
supported protocol version.

While at it, move the GHCB protocol negotiation check from the #VC
exception handler to sev_enable() so that all feature detection happens
before the first #VC exception.

While at it, document why the GHCB page cannot be setup from
load_stage2_idt().

  [ bp: Massage commit message. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-13-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/idt_64.c | 18 +++++++++++++++++-
 arch/x86/boot/compressed/sev.c    | 20 +++++++++++++++-----
 arch/x86/include/asm/sev-common.h |  6 ++++++
 arch/x86/include/asm/sev.h        |  2 +-
 arch/x86/include/uapi/asm/svm.h   |  2 ++
 arch/x86/kernel/sev-shared.c      | 20 ++++++++++++++++++++
 arch/x86/kernel/sev.c             | 14 ++++++++++++++
 7 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 9b93567..6debb81 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -39,7 +39,23 @@ void load_stage1_idt(void)
 	load_boot_idt(&boot_idt_desc);
 }
 
-/* Setup IDT after kernel jumping to  .Lrelocated */
+/*
+ * Setup IDT after kernel jumping to  .Lrelocated.
+ *
+ * initialize_identity_maps() needs a #PF handler to be setup
+ * in order to be able to fault-in identity mapping ranges; see
+ * do_boot_page_fault().
+ *
+ * This #PF handler setup needs to happen in load_stage2_idt() where the
+ * IDT is loaded and there the #VC IDT entry gets setup too.
+ *
+ * In order to be able to handle #VCs, one needs a GHCB which
+ * gets setup with an already set up pagetable, which is done in
+ * initialize_identity_maps(). And there's the catch 22: the boot #VC
+ * handler do_boot_stage2_vc() needs to call early_setup_ghcb() itself
+ * (and, especially set_page_decrypted()) because the SEV-ES setup code
+ * cannot initialize a GHCB as there's no #PF handler yet...
+ */
 void load_stage2_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 56e941d..5b38931 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,11 +116,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static bool early_setup_sev_es(void)
+static bool early_setup_ghcb(void)
 {
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
-
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
@@ -171,7 +168,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_sev_es())
+	if (!boot_ghcb && !early_setup_ghcb())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
@@ -235,5 +232,18 @@ void sev_enable(struct boot_params *bp)
 	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
 		return;
 
+	/* Negotiate the GHCB protocol version. */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
+		if (!sev_es_negotiate_protocol())
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
+	}
+
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 94f0ea5..6f037c2 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -60,6 +60,11 @@
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
+#define GHCB_MSR_HV_FT_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
+#define GHCB_HV_FT_SNP			BIT_ULL(0)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
@@ -77,6 +82,7 @@
 #define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
+#define GHCB_SNP_UNSUPPORTED		2
 
 /* Linux-specific reason codes (used with reason set 1) */
 #define SEV_TERM_SET_LINUX		1
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9b9c190..17b75f6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,7 @@
 #include <asm/sev-common.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
-#define GHCB_PROTOCOL_MAX	1ULL
+#define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index efa9693..b0ad00f 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 /* Exit code reserved for hypervisor/software use */
@@ -218,6 +219,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 91105f5..4a876e6 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -48,6 +48,26 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+/*
+ * The hypervisor features are available from GHCB version 2 onward.
+ */
+static u64 get_hv_features(void)
+{
+	u64 val;
+
+	if (ghcb_version < 2)
+		return 0;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
+		return 0;
+
+	return GHCB_MSR_HV_FT_RESP_VAL(val);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 19ad097..cb20fb0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -43,6 +43,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+/* Bitmap of SEV features supported by the hypervisor */
+static u64 sev_hv_features __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -766,6 +769,17 @@ void __init sev_es_init_vc_handling(void)
 	if (!sev_es_check_cpu_features())
 		panic("SEV-ES CPU Features missing");
 
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		sev_hv_features = get_hv_features();
+
+		if (!(sev_hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	}
+
 	/* Enable SEV-ES special handling */
 	static_branch_enable(&sev_es_enable_key);
 
