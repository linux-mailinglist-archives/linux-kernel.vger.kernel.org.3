Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A84F91EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiDHJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDHJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A1924CED2;
        Fri,  8 Apr 2022 02:09:20 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwCOX5fUHQ5tTn6fa+guZMZo63hiycly+JF0Q9p/eE0=;
        b=QtKBmBEm6djXcUbh3EWYoZxJGSaWNxVfMA9gdqMcIp1DKaetDK+dDUSqQUoMuy1ygmSIDm
        rzO2DNy+lra+O6aaMJHHougyyI8Zvqj/xlJr/48D3Uktun4IUnbCnjdQBJX9d50XDdWpLH
        CBkyAolA0v/0xGxeVx9cvKJSLVQK4BtD+i5gJA1LoRslE1x6kzCJrCPnY5kqMfwapHJbxs
        Bp4hgtHNt9XXBAseQyFXmywOuCL9Rz9m7jxxqGy/sNP1hXw09UV5MTF148CyWAIfzuZA6m
        i4y+YI5DeZmgeA6mxSnLscFniXKdYU2ydAt+UVdwJ4umFqMp2k6x4mjVu+j4Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwCOX5fUHQ5tTn6fa+guZMZo63hiycly+JF0Q9p/eE0=;
        b=Qe2YC4nDHzH6oxNewZa5nlXaEq5g4aOl17z6SA/U1r55WIvo08JZYbJsyNQcv3rKBKwO7k
        /rAVe0MhcUqRK4BA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] KVM: SVM: Create a separate mapping for the SEV-ES save area
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405182743.308853-1-brijesh.singh@amd.com>
References: <20220405182743.308853-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940895786.389.7287520453383179506.tip-bot2@tip-bot2>
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

Commit-ID:     3dd2775b74c9b1b01d19805877ab45bc47c4a5a5
Gitweb:        https://git.kernel.org/tip/3dd2775b74c9b1b01d19805877ab45bc47c4a5a5
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Tue, 05 Apr 2022 13:27:43 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 12:08:40 +02:00

KVM: SVM: Create a separate mapping for the SEV-ES save area

The save area for SEV-ES/SEV-SNP guests, as used by the hardware, is
different from the save area of a non SEV-ES/SEV-SNP guest.

This is the first step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Create an SEV-ES/SEV-SNP save area and adjust usage to the new
save area definition where needed.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Link: https://lore.kernel.org/r/20220405182743.308853-1-brijesh.singh@amd.com
---
 arch/x86/include/asm/svm.h | 87 ++++++++++++++++++++++++++++---------
 arch/x86/kvm/svm/sev.c     | 22 ++++-----
 arch/x86/kvm/svm/svm.c     |  4 +-
 arch/x86/kvm/svm/svm.h     |  4 +-
 4 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f2d01f3..788a43f 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -271,6 +271,7 @@ struct vmcb_seg {
 	u64 base;
 } __packed;
 
+/* Save area definition for legacy and SEV-MEM guests */
 struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
@@ -287,8 +288,58 @@ struct vmcb_save_area {
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
+	u8 reserved_3[112];
+	u64 cr4;
+	u64 cr3;
+	u64 cr0;
+	u64 dr7;
+	u64 dr6;
+	u64 rflags;
+	u64 rip;
+	u8 reserved_4[88];
+	u64 rsp;
+	u64 s_cet;
+	u64 ssp;
+	u64 isst_addr;
+	u64 rax;
+	u64 star;
+	u64 lstar;
+	u64 cstar;
+	u64 sfmask;
+	u64 kernel_gs_base;
+	u64 sysenter_cs;
+	u64 sysenter_esp;
+	u64 sysenter_eip;
+	u64 cr2;
+	u8 reserved_5[32];
+	u64 g_pat;
+	u64 dbgctl;
+	u64 br_from;
+	u64 br_to;
+	u64 last_excp_from;
+	u64 last_excp_to;
+	u8 reserved_6[72];
+	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+} __packed;
+
+/* Save area definition for SEV-ES and SEV-SNP guests */
+struct sev_es_save_area {
+	struct vmcb_seg es;
+	struct vmcb_seg cs;
+	struct vmcb_seg ss;
+	struct vmcb_seg ds;
+	struct vmcb_seg fs;
+	struct vmcb_seg gs;
+	struct vmcb_seg gdtr;
+	struct vmcb_seg ldtr;
+	struct vmcb_seg idtr;
+	struct vmcb_seg tr;
+	u8 reserved_1[43];
+	u8 cpl;
+	u8 reserved_2[4];
+	u64 efer;
 	u8 reserved_3[104];
-	u64 xss;		/* Valid for SEV-ES only */
+	u64 xss;
 	u64 cr4;
 	u64 cr3;
 	u64 cr0;
@@ -316,22 +367,14 @@ struct vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
-
-	/*
-	 * The following part of the save area is valid only for
-	 * SEV-ES guests when referenced through the GHCB or for
-	 * saving to the host save area.
-	 */
-	u8 reserved_7[72];
-	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
-	u8 reserved_7b[4];
+	u8 reserved_7[80];
 	u32 pkru;
-	u8 reserved_7a[20];
-	u64 reserved_8;		/* rax already available at 0x01f8 */
+	u8 reserved_9[20];
+	u64 reserved_10;	/* rax already available at 0x01f8 */
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
-	u64 reserved_9;		/* rsp already available at 0x01d8 */
+	u64 reserved_11;	/* rsp already available at 0x01d8 */
 	u64 rbp;
 	u64 rsi;
 	u64 rdi;
@@ -343,23 +386,25 @@ struct vmcb_save_area {
 	u64 r13;
 	u64 r14;
 	u64 r15;
-	u8 reserved_10[16];
+	u8 reserved_12[16];
 	u64 sw_exit_code;
 	u64 sw_exit_info_1;
 	u64 sw_exit_info_2;
 	u64 sw_scratch;
 	u64 sev_features;
-	u8 reserved_11[48];
+	u8 reserved_13[48];
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
 } __packed;
 
+#define GHCB_SHARED_BUF_SIZE	2032
+
 struct ghcb {
-	struct vmcb_save_area save;
-	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
+	struct sev_es_save_area save;
+	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
 
-	u8 shared_buffer[2032];
+	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
 
 	u8 reserved_1[10];
 	u16 protocol_version;	/* negotiated SEV-ES/GHCB protocol version */
@@ -367,13 +412,15 @@ struct ghcb {
 } __packed;
 
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		1032
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 }
@@ -443,7 +490,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75fa6dd..6e18ec1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -559,12 +559,20 @@ e_unpin:
 
 static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
-	struct vmcb_save_area *save = &svm->vmcb->save;
+	struct sev_es_save_area *save = svm->sev_es.vmsa;
 
 	/* Check some debug related fields before encrypting the VMSA */
-	if (svm->vcpu.guest_debug || (save->dr7 & ~DR7_FIXED_1))
+	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
 
+	/*
+	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
+	 * the traditional VMSA that is part of the VMCB. Copy the
+	 * traditional VMSA as it has been built so far (in prep
+	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
+	 */
+	memcpy(save, &svm->vmcb->save, sizeof(svm->vmcb->save));
+
 	/* Sync registgers */
 	save->rax = svm->vcpu.arch.regs[VCPU_REGS_RAX];
 	save->rbx = svm->vcpu.arch.regs[VCPU_REGS_RBX];
@@ -592,14 +600,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
 
-	/*
-	 * SEV-ES will use a VMSA that is pointed to by the VMCB, not
-	 * the traditional VMSA that is part of the VMCB. Copy the
-	 * traditional VMSA as it has been built so far (in prep
-	 * for LAUNCH_UPDATE_VMSA) to be the initial SEV-ES state.
-	 */
-	memcpy(svm->sev_es.vmsa, save, sizeof(*save));
-
 	return 0;
 }
 
@@ -2932,7 +2932,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
 					    sev_enc_bit));
 }
 
-void sev_es_prepare_switch_to_guest(struct vmcb_save_area *hostsa)
+void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa)
 {
 	/*
 	 * As an SEV-ES guest, hardware will restore the host state on VMEXIT,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 81cb518..6ff595f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1270,8 +1270,8 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	 */
 	vmsave(__sme_page_pa(sd->save_area));
 	if (sev_es_guest(vcpu->kvm)) {
-		struct vmcb_save_area *hostsa;
-		hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
+		struct sev_es_save_area *hostsa;
+		hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
 
 		sev_es_prepare_switch_to_guest(hostsa);
 	}
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f77a7d2..cc857de 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -181,7 +181,7 @@ struct svm_nested_state {
 
 struct vcpu_sev_es_state {
 	/* SEV-ES support */
-	struct vmcb_save_area *vmsa;
+	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
@@ -620,7 +620,7 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
 void sev_es_init_vmcb(struct vcpu_svm *svm);
 void sev_es_vcpu_reset(struct vcpu_svm *svm);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
-void sev_es_prepare_switch_to_guest(struct vmcb_save_area *hostsa);
+void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 
 /* vmenter.S */
