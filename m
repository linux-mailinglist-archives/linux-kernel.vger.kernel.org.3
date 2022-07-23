Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748EC57EACB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiGWAwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiGWAwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:52:11 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46897A37
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:51:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i191-20020a6387c8000000b00419ffb2bb90so3004471pge.14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=64xZYpakxCJygEkjp2mVBRUvoCiAstWPQbss8n4nWQQ=;
        b=lD6PrwKpPBjyRkCVqSHLPud1g5OSqjgEDHaV7xZjneDM444GsAN05jigdCvSELw/Xj
         0GFlfbXNINvLzye4WSMI6K1qvyMhD3x3ft9mSkDSkuSaKS1UedTyhr8SSgMAN1BYaD/S
         0NK/Xo9K4QR84G3AASKMl/WUzsUGbcDrF1D1pwe36B+dXG5nsyxtDyfwz3q8Tl9qgTsv
         OmUgwCyoCDWJj/fgsgtHc73tUJvuGPLW903Of4Fi6VeH4ei0bK1zzZ5YiV8LyMrKz99u
         /RCZ2d8VwYZaj1K5IWYiw92Go0xngDmaWfJvmMotq0DZimiI0Dk+JeQgZpMKe1uKdjTZ
         +E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=64xZYpakxCJygEkjp2mVBRUvoCiAstWPQbss8n4nWQQ=;
        b=498JjEqdrtnuZklgfoIQUgSN46EZxmbftP56D7dF9oBHduZqYybXH05iemhghZSfPO
         RjdmfMHvUqeLtf3rffe09QWKbDjvxw6Xw/CGZaTzsHKaTf+BkbVMggQphwxTw3N4NZ2z
         ygcaCv0a02Tfxu7hjPLSC9Bv3u438DhiVt97MfyawI3b0RUJD3g4Pf/82e7r+tYfTA+U
         0rE3CM9EqY6FX+EObPBlT9g7dW5DYYv4fhW0Oc7kFSC+gtjDxQ8ofOB5H92SyYcpB6KD
         i5ezhO4Svgd3cQikfWKDPQHJYCAyTvWrFvLKVB431fCDzw3ZTMYZaIUgIwtNrGPSzaxS
         J2cQ==
X-Gm-Message-State: AJIora+bzVEgIN1lNBcevYd16Je3fcTm1sWjCxX8jMlplW+Q6y2FTl6D
        qjjob3P/8Da0uyOl+F6i21xydAzyk3g=
X-Google-Smtp-Source: AGRyM1vVZtVjOA7RgzIXwL/6Lnd83J/KU3pLnEqZ90Yg45eGPWngP27LdiXPsg3m09SAE0osu/mQ8oq3QJg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b70a:b0:16c:f62c:43aa with SMTP id
 d10-20020a170902b70a00b0016cf62c43aamr2359950pls.8.1658537516739; Fri, 22 Jul
 2022 17:51:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:22 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-10-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 09/24] KVM: nVMX: Unconditionally clear mtf_pending on
 nested VM-Exit
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear mtf_pending on nested VM-Exit instead of handling the clear on a
case-by-case basis in vmx_check_nested_events().  The pending MTF should
never survive nested VM-Exit, as it is a property of KVM's run of the
current L2, i.e. should never affect the next L2 run by L1.  In practice,
this is likely a nop as getting to L1 with nested_run_pending is
impossible, and KVM doesn't correctly handle morphing a pending exception
that occurs on a prior injected exception (need for re-injected exception
being the other case where MTF isn't cleared).  However, KVM will
hopefully soon correctly deal with a pending exception on top of an
injected exception.

Add a TODO to document that KVM has an inversion priority bug between
SMIs and MTF (and trap-like #DBS), and that KVM also doesn't properly
save/restore MTF across SMI/RSM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 46ea7740bb9e..17df0c31f0b5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3905,16 +3905,8 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	unsigned long exit_qual;
 	bool block_nested_events =
 	    vmx->nested.nested_run_pending || kvm_event_needs_reinjection(vcpu);
-	bool mtf_pending = vmx->nested.mtf_pending;
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	/*
-	 * Clear the MTF state. If a higher priority VM-exit is delivered first,
-	 * this state is discarded.
-	 */
-	if (!block_nested_events)
-		vmx->nested.mtf_pending = false;
-
 	if (lapic_in_kernel(vcpu) &&
 		test_bit(KVM_APIC_INIT, &apic->pending_events)) {
 		if (block_nested_events)
@@ -3923,6 +3915,9 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		clear_bit(KVM_APIC_INIT, &apic->pending_events);
 		if (vcpu->arch.mp_state != KVM_MP_STATE_INIT_RECEIVED)
 			nested_vmx_vmexit(vcpu, EXIT_REASON_INIT_SIGNAL, 0, 0);
+
+		/* MTF is discarded if the vCPU is in WFS. */
+		vmx->nested.mtf_pending = false;
 		return 0;
 	}
 
@@ -3945,6 +3940,11 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 * fault-like exceptions, TSS T flag #DB (not emulated by KVM, but
 	 * could theoretically come in from userspace), and ICEBP (INT1).
 	 *
+	 * TODO: SMIs have higher priority than MTF and trap-like #DBs (except
+	 * for TSS T flag #DBs).  KVM also doesn't save/restore pending MTF
+	 * across SMI/RSM as it should; that needs to be addressed in order to
+	 * prioritize SMI over MTF and trap-like #DBs.
+	 *
 	 * Note that only a pending nested run can block a pending exception.
 	 * Otherwise an injected NMI/interrupt should either be
 	 * lost or delivered to the nested hypervisor in the IDT_VECTORING_INFO,
@@ -3960,7 +3960,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (mtf_pending) {
+	if (vmx->nested.mtf_pending) {
 		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_update_pending_dbg(vcpu);
@@ -4557,6 +4557,9 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
+	/* Pending MTF traps are discarded on VM-Exit. */
+	vmx->nested.mtf_pending = false;
+
 	/* trying to cancel vmlaunch/vmresume is a bug */
 	WARN_ON_ONCE(vmx->nested.nested_run_pending);
 
-- 
2.37.1.359.gd136c6c3e2-goog

