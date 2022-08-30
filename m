Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648065A7190
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH3XRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiH3XQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949886B8FE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dd097f993so192159947b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=/leTTfx+tYGUV20b38Vn3CO6vARPbHwJ64uO0txcnTA=;
        b=WLC90H12sf6WqFQfaKUgHPqCVgt+zRiHUQdeDttwimVBeBarQp+yBSLUEaGiUFUR//
         +KsUCEknT8rhNqesVvp8PeQgjvnh8C3OpaQvnbqRwY/NqXNkB/u8iy+u4dDM9/4/e8Il
         fGNTiWDY/+dlovqp96EsGC/xZtDcGzDNQXckiYyMFSL14y1SAVm6iriu1N8+dC9f9ZLv
         ohbKHDDh9+vIjKBq3Vd7ebfFogGRFoUuExgre4AymuPvAF2VQEnjTqn9kZUXrKAv2+EB
         TqcRPgz/CsyDpxZYSQ8qkf3nuH/cRWImDtsuEPiypEwceQsWcBI7IReVBMWKjilI4UCI
         mTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=/leTTfx+tYGUV20b38Vn3CO6vARPbHwJ64uO0txcnTA=;
        b=WMQQHfRxqJGqOSTA00cFV2236I0XFXFqJ7TgV8h6WXj2bjwV6qBsOspkN2nWuInHbS
         MFUIjACGajuf9h46eNcpRFdc2EVoy2yiFh56i7H9CHYB8nJB/cHSeOy+W9pTZ+lemkcl
         tWkS90SbVzVGiwTKhRi5qilhJ63uW4+5HP5w1i3uecm4sioWRp++tzh2BZz+woNG1LwR
         7N/FF66bDtiHttVSmcTFWfGEPfuQTNh0yG66O/db3TpQnO4oIzO3sxkwIGkN25AEADxR
         9zvYgQVYxwRhng4XDsViUlE+Ucx2bmQ/AsHrDRGhPhxV4RvZ/qc8eOESyE+MoRW3TLZp
         WcZg==
X-Gm-Message-State: ACgBeo3hf4YhbhUWaTgO9B3DbkP9bX8rnimU3rPt/UKeNLKh2p28W6px
        hi8sGSjq1eCH2PSOY0ybFKruxYQL0mw=
X-Google-Smtp-Source: AA6agR7wTFF2kwxnrSHkfUK9uKFIyJtRm5OhD26Vk649tRzd9fsQh0QhSqCS0giw3BAfZUUAxB9jIt9pfp8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b71f:0:b0:340:eb70:54c2 with SMTP id
 v31-20020a81b71f000000b00340eb7054c2mr11812408ywh.404.1661901380159; Tue, 30
 Aug 2022 16:16:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:15:49 +0000
In-Reply-To: <20220830231614.3580124-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830231614.3580124-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-3-seanjc@google.com>
Subject: [PATCH v5 02/27] KVM: VMX: Drop bits 31:16 when shoving exception
 error code into VMCS
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deliberately truncate the exception error code when shoving it into the
VMCS (VM-Entry field for vmcs01 and vmcs02, VM-Exit field for vmcs12).
Intel CPUs are incapable of handling 32-bit error codes and will never
generate an error code with bits 31:16, but userspace can provide an
arbitrary error code via KVM_SET_VCPU_EVENTS.  Failure to drop the bits
on exception injection results in failed VM-Entry, as VMX disallows
setting bits 31:16.  Setting the bits on VM-Exit would at best confuse
L1, and at worse induce a nested VM-Entry failure, e.g. if L1 decided to
reinject the exception back into L2.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 11 ++++++++++-
 arch/x86/kvm/vmx/vmx.c    | 12 +++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ca07d4ce4383..2ca8f1ad9c59 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3827,7 +3827,16 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu,
 	u32 intr_info = nr | INTR_INFO_VALID_MASK;
 
 	if (vcpu->arch.exception.has_error_code) {
-		vmcs12->vm_exit_intr_error_code = vcpu->arch.exception.error_code;
+		/*
+		 * Intel CPUs do not generate error codes with bits 31:16 set,
+		 * and more importantly VMX disallows setting bits 31:16 in the
+		 * injected error code for VM-Entry.  Drop the bits to mimic
+		 * hardware and avoid inducing failure on nested VM-Entry if L1
+		 * chooses to inject the exception back to L2.  AMD CPUs _do_
+		 * generate "full" 32-bit error codes, so KVM allows userspace
+		 * to inject exception error codes with bits 31:16 set.
+		 */
+		vmcs12->vm_exit_intr_error_code = (u16)vcpu->arch.exception.error_code;
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c9b49a09e6b5..7f3581960eb5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1695,7 +1695,17 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 	kvm_deliver_exception_payload(vcpu);
 
 	if (has_error_code) {
-		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, error_code);
+		/*
+		 * Despite the error code being architecturally defined as 32
+		 * bits, and the VMCS field being 32 bits, Intel CPUs and thus
+		 * VMX don't actually supporting setting bits 31:16.  Hardware
+		 * will (should) never provide a bogus error code, but AMD CPUs
+		 * do generate error codes with bits 31:16 set, and so KVM's
+		 * ABI lets userspace shove in arbitrary 32-bit values.  Drop
+		 * the upper bits to avoid VM-Fail, losing information that
+		 * does't really exist is preferable to killing the VM.
+		 */
+		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, (u16)error_code);
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
 	}
 
-- 
2.37.2.672.g94769d06f0-goog

