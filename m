Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37F5583C26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiG1KhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiG1KhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:37:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6B54AF2;
        Thu, 28 Jul 2022 03:36:57 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:36:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659004615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKWFdh0GpFFUHuTvQ9GEPomIG9+iTguHV+F5CaijCKo=;
        b=nagZzuUult3l6huf3c2KDpIX2ttCKXHcAkRSKHRBmIHe+JB6rw64qD/HHBeq30VYjibvD/
        wXXXmf/aDTcFpI8aL9kgggxcHFe62ITzZtMToEBj4blcIuCF8YK1mb+OxbX/94IPTValF8
        qMpgCjS/WdW4aGkTQ2uConigDXcWYswIex5QOeab7zeOtpTduBaa8WVbcOJoAQE+khPPZu
        MmyCrX3dMeeljV+zk54drQumBmbTQUHPDeASlxrC6xCFJgRWCBgwyvpywfDIzhIxiSwpTO
        Crn7FMl014OcAusdbdSkJmxNRMB+NDiwKbCD/pvPZwdARXBdLdwctdnzSRTxww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659004615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKWFdh0GpFFUHuTvQ9GEPomIG9+iTguHV+F5CaijCKo=;
        b=dTr2WiKA3hPYYE7jZrdVO4ExHiIzFqcyadAkA9q/fHUWLFccCwSzbDHFjhXcbLppfpZaCZ
        2Bf8KF7nKOD4DFDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "x86/sev: Expose sev_es_ghcb_hv_call() for
 use by HyperV"
Cc:     Wei Liu <wei.liu@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220614014553.1915929-1-ltykernel@gmail.com>
References: <20220614014553.1915929-1-ltykernel@gmail.com>
MIME-Version: 1.0
Message-ID: <165900461383.15455.13650039333382269684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5bb6c1d1126ebcbcd6314f80d82f50b021a9e351
Gitweb:        https://git.kernel.org/tip/5bb6c1d1126ebcbcd6314f80d82f50b021a=
9e351
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 27 Jul 2022 13:24:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Jul 2022 18:09:13 +02:00

Revert "x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV"

This reverts commit 007faec014cb5d26983c1f86fd08c6539b41392e.

Now that hyperv does its own protocol negotiation:

  49d6a3c062a1 ("x86/Hyper-V: Add SEV negotiate protocol support in Isolation=
 VM")

revert this exposure of the sev_es_ghcb_hv_call() helper.

Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by=EF=BC=9ATianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/r/20220614014553.1915929-1-ltykernel@gmail.com
---
 arch/x86/include/asm/sev.h   |  7 +------
 arch/x86/kernel/sev-shared.c | 25 +++++++++----------------
 arch/x86/kernel/sev.c        | 17 ++++++++---------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1951452..4a23e52 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -72,7 +72,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
=20
 struct real_mode_header;
 enum stack_type;
-struct ghcb;
=20
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
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned lo=
ng attrs)
 {
 	int rc;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b478edf..3a5b0c9 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -219,9 +219,10 @@ static enum es_result verify_exception_info(struct ghcb =
*ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
=20
-enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
-				   struct es_em_ctxt *ctxt, u64 exit_code,
-				   u64 exit_info_1, u64 exit_info_2)
+static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
 	ghcb->protocol_version =3D ghcb_version;
@@ -231,14 +232,7 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bo=
ol set_ghcb_msr,
 	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
 	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
=20
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
=20
 	return verify_exception_info(ghcb, ctxt);
@@ -795,7 +789,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, s=
truct es_em_ctxt *ctxt)
 		 */
 		sw_scratch =3D __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
 		ghcb_set_sw_scratch(ghcb, sw_scratch);
-		ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_IOIO,
+		ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
 					  exit_info_1, exit_info_2);
 		if (ret !=3D ES_OK)
 			return ret;
@@ -837,8 +831,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, s=
truct es_em_ctxt *ctxt)
=20
 		ghcb_set_rax(ghcb, rax);
=20
-		ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt,
-					  SVM_EXIT_IOIO, exit_info_1, 0);
+		ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
 		if (ret !=3D ES_OK)
 			return ret;
=20
@@ -894,7 +887,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 		/* xgetbv will cause #GP - use reset value for xcr0 */
 		ghcb_set_xcr0(ghcb, 1);
=20
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_CPUID, 0, 0);
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
 	if (ret !=3D ES_OK)
 		return ret;
=20
@@ -919,7 +912,7 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp =3D (exit_code =3D=3D SVM_EXIT_RDTSCP);
 	enum es_result ret;
=20
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, 0, 0);
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret !=3D ES_OK)
 		return ret;
=20
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f012..63dc626 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -786,7 +786,7 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
=20
 		/* This will advance the shared buffer data points to. */
-		ret =3D sev_es_ghcb_hv_call(ghcb, true, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+		ret =3D sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
=20
 		/*
 		 * Page State Change VMGEXIT can pass error code through
@@ -1212,8 +1212,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, =
struct es_em_ctxt *ctxt)
 		ghcb_set_rdx(ghcb, regs->dx);
 	}
=20
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_MSR,
-				  exit_info_1, 0);
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
=20
 	if ((ret =3D=3D ES_OK) && (!exit_info_1)) {
 		regs->ax =3D ghcb->save.rax;
@@ -1452,7 +1451,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, str=
uct es_em_ctxt *ctxt,
=20
 	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
=20
-	return sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, exit_info_1, exit_i=
nfo_2);
+	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
 }
=20
 /*
@@ -1628,7 +1627,7 @@ static enum es_result vc_handle_dr7_write(struct ghcb *=
ghcb,
=20
 	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
 	ghcb_set_rax(ghcb, val);
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
 	if (ret !=3D ES_OK)
 		return ret;
=20
@@ -1658,7 +1657,7 @@ static enum es_result vc_handle_dr7_read(struct ghcb *g=
hcb,
 static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
 				       struct es_em_ctxt *ctxt)
 {
-	return sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WBINVD, 0, 0);
+	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
 }
=20
 static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt)
@@ -1667,7 +1666,7 @@ static enum es_result vc_handle_rdpmc(struct ghcb *ghcb=
, struct es_em_ctxt *ctxt
=20
 	ghcb_set_rcx(ghcb, ctxt->regs->cx);
=20
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_RDPMC, 0, 0);
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
 	if (ret !=3D ES_OK)
 		return ret;
=20
@@ -1708,7 +1707,7 @@ static enum es_result vc_handle_vmmcall(struct ghcb *gh=
cb,
 	if (x86_platform.hyper.sev_es_hcall_prepare)
 		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
=20
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_VMMCALL, 0, 0);
+	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
 	if (ret !=3D ES_OK)
 		return ret;
=20
@@ -2197,7 +2196,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_r=
eq_data *input, unsigned=20
 		ghcb_set_rbx(ghcb, input->data_npages);
 	}
=20
-	ret =3D sev_es_ghcb_hv_call(ghcb, true, &ctxt, exit_code, input->req_gpa, i=
nput->resp_gpa);
+	ret =3D sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->=
resp_gpa);
 	if (ret)
 		goto e_put;
=20
