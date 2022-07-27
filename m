Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B215828E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiG0OsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiG0OsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:48:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3D1F2D9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:48:18 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4fe3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4fe3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1991C1EC0324;
        Wed, 27 Jul 2022 16:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658933293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=ZQJuDIu+V5DnJc5E6Vhya5scBmu+Cng8PyFV8/OOp+k=;
        b=eeiQLHdXiSooE42rDTzuxSPOoZ2W38A4KuP+iXfsrOWa1MSIs0i5Z0sJkw7S4jBXoDdttf
        EA09pJlXcHchc71biMa3U0gXlM0NDyo2664WXn2NNWB4opGDFQfVd/Xj46iEFqvdkRqDce
        H3U0lrHDsAC/VuWkgKT3vRRG2OgyowY=
Date:   Wed, 27 Jul 2022 16:48:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "x86/sev: Expose sev_es_ghcb_hv_call() for use by
 HyperV"
Message-ID: <YuFQJ9ynRk4QwFjn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 007faec014cb5d26983c1f86fd08c6539b41392e.

Now that hyperv does its own protocol negotiation:

  49d6a3c062a1 ("x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM")

revert this exposure of the sev_es_ghcb_hv_call() helper.

Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220614014553.1915929-1-ltykernel@gmail.com
---

My plan is to queue this now and send it to Linus as an urgent fix so
that 5.19 gets released clean, without that export.

So if you folks see an issue, holler now pls.

Thx.

 arch/x86/include/asm/sev.h   |  7 +------
 arch/x86/kernel/sev-shared.c | 25 +++++++++----------------
 arch/x86/kernel/sev.c        | 17 ++++++++---------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 19514524f0f8..4a23e52fe0ee 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -72,7 +72,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 
 struct real_mode_header;
 enum stack_type;
-struct ghcb;
 
 /* Early IDT entry points for #VC handler */
 extern void vc_no_ghcb(void);
@@ -156,11 +155,7 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
-extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  bool set_ghcb_msr,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2);
+
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
 	int rc;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b478edf43bec..3a5b0c9c4fcc 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -219,9 +219,10 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
 
-enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
-				   struct es_em_ctxt *ctxt, u64 exit_code,
-				   u64 exit_info_1, u64 exit_info_2)
+static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
 	ghcb->protocol_version = ghcb_version;
@@ -231,14 +232,7 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
 	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
 
-	/*
-	 * Hyper-V unenlightened guests use a paravisor for communicating and
-	 * GHCB pages are being allocated and set up by that paravisor. Linux
-	 * should not change the GHCB page's physical address.
-	 */
-	if (set_ghcb_msr)
-		sev_es_wr_ghcb_msr(__pa(ghcb));
-
+	sev_es_wr_ghcb_msr(__pa(ghcb));
 	VMGEXIT();
 
 	return verify_exception_info(ghcb, ctxt);
@@ -795,7 +789,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 		 */
 		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
 		ghcb_set_sw_scratch(ghcb, sw_scratch);
-		ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_IOIO,
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
 					  exit_info_1, exit_info_2);
 		if (ret != ES_OK)
 			return ret;
@@ -837,8 +831,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 
 		ghcb_set_rax(ghcb, rax);
 
-		ret = sev_es_ghcb_hv_call(ghcb, true, ctxt,
-					  SVM_EXIT_IOIO, exit_info_1, 0);
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
 		if (ret != ES_OK)
 			return ret;
 
@@ -894,7 +887,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 		/* xgetbv will cause #GP - use reset value for xcr0 */
 		ghcb_set_xcr0(ghcb, 1);
 
-	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_CPUID, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -919,7 +912,7 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
-	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..63dc626627a0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -786,7 +786,7 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
 
 		/* This will advance the shared buffer data points to. */
-		ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
 
 		/*
 		 * Page State Change VMGEXIT can pass error code through
@@ -1212,8 +1212,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 		ghcb_set_rdx(ghcb, regs->dx);
 	}
 
-	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_MSR,
-				  exit_info_1, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
 
 	if ((ret == ES_OK) && (!exit_info_1)) {
 		regs->ax = ghcb->save.rax;
@@ -1452,7 +1451,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 
 	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
 
-	return sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, exit_info_1, exit_info_2);
+	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
 }
 
 /*
@@ -1628,7 +1627,7 @@ static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
 
 	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
 	ghcb_set_rax(ghcb, val);
-	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -1658,7 +1657,7 @@ static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
 static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
 				       struct es_em_ctxt *ctxt)
 {
-	return sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WBINVD, 0, 0);
+	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
 }
 
 static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
@@ -1667,7 +1666,7 @@ static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt
 
 	ghcb_set_rcx(ghcb, ctxt->regs->cx);
 
-	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_RDPMC, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -1708,7 +1707,7 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 	if (x86_platform.hyper.sev_es_hcall_prepare)
 		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
 
-	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_VMMCALL, 0, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
@@ -2197,7 +2196,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 		ghcb_set_rbx(ghcb, input->data_npages);
 	}
 
-	ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
+	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
 	if (ret)
 		goto e_put;
 
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
