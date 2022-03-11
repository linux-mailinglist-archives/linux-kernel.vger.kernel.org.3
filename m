Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA874D58EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiCKD33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbiCKD3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:29:12 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE162EBAD9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:09 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n11-20020a170902d2cb00b0015331a5d02fso819113plc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Q11tmqpRyohs0wxUo0y4r3aBzzijFQCBN8fS/7u/ul8=;
        b=NHbaWQh8IotH/IrJheJvNEMIYI3iNClIpD6pF7pYa4PxajGfFNw7H4VVrbMYpSPW53
         UaKM2vDuG07mwqwLS1qPpozBZFczUFXDbAL0vYIPnfVJlCbhnejjDtMkNl7a0iNnRl0q
         cK1EvfqLBmuyqiIby2Isu4DOMI0utlyadO7Ln0VSaawOD4SnCYPhvodrFl9RzUiyc09P
         r0AIxujLDr7NjYMg/SJIEhBIdr6iNtwxHc2wMkyMcyo4i0S/s6GX6HSVIppNLBppI7Yv
         dAKoKlFxUmp/dNBDXBO/NM+2GPgkUnVYeA8dg1lPcriAanFXLAsGuB86BALXSDQdSErZ
         N7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Q11tmqpRyohs0wxUo0y4r3aBzzijFQCBN8fS/7u/ul8=;
        b=60kpKZzmSCMEcjM5cLDGEGpFAeOtPuc331TQmeaLT1br5wbEbV1Nc2Ma2YNN0oE6mQ
         4Zi3uErGgSxwEDosFr1IumDmjnCU9XRquZQsCmKXEbpBxPsC30ufChUuc1/z3RElhf2e
         NasCURTRvqVrN1q5wrb58x+UjZoCbUogew9BSD96vY/eBWHaAeHU6JPOkn4sRpEHfTg6
         rTisNoH2iV0G1MUSQTQ5mmgGi4uG9Avc45cwfC8GYyTujRkyoWi5i1SFkk9euHz78f4k
         bQ9JKGQB75WI9p0k8wnEpw7bEKAafAkSPdjV1qkJMg5qx8xA1mGA7Ug2DPaRVpLGB7Dw
         CDyw==
X-Gm-Message-State: AOAM5318gZ7AUJSX9FXrpQcv1yU4qdrKcsguvyM0WVaX3eSEAGF6wTzg
        Wj+ciY/Wu27qmMAEkv+uFwrp2G1CF+8=
X-Google-Smtp-Source: ABdhPJx8m7u1JsrHVqes8stC/gTklmGIv5nAe2qeZV+KxBfHH86PkBaWKYnB9nvHLVdbfKw51+II8mHq1Do=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:7086:b0:14f:ee29:5ef0 with SMTP id
 z6-20020a170902708600b0014fee295ef0mr8155852plk.142.1646969288900; Thu, 10
 Mar 2022 19:28:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 03:27:43 +0000
In-Reply-To: <20220311032801.3467418-1-seanjc@google.com>
Message-Id: <20220311032801.3467418-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220311032801.3467418-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 03/21] KVM: VMX: Drop bits 31:16 when shoving exception error
 code into VMCS
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 arch/x86/kvm/vmx/nested.c |  9 ++++++++-
 arch/x86/kvm/vmx/vmx.c    | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f09c6eff7af9..7bdda9ef2828 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3808,7 +3808,14 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu,
 	u32 intr_info = nr | INTR_INFO_VALID_MASK;
 
 	if (vcpu->arch.exception.has_error_code) {
-		vmcs12->vm_exit_intr_error_code = vcpu->arch.exception.error_code;
+		/*
+		 * Intel CPUs will never generate an error code with bits 31:16
+		 * set, and more importantly VMX disallows setting bits 31:16
+		 * in the injected error code for VM-Entry.  Drop the bits to
+		 * mimic hardware and avoid inducing failure on nested VM-Entry
+		 * if L1 chooses to inject the exception back to L2.
+		 */
+		vmcs12->vm_exit_intr_error_code = (u16)vcpu->arch.exception.error_code;
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e8963f5af618..a8ebe91fe9a5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1613,7 +1613,16 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
 	kvm_deliver_exception_payload(vcpu);
 
 	if (has_error_code) {
-		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, error_code);
+		/*
+		 * Despite the error code being architecturally defined as 32
+		 * bits, and the VMCS field being 32 bits, Intel CPUs and thus
+		 * VMX don't actually supporting setting bits 31:16.  Hardware
+		 * will (should) never provide a bogus error code, but KVM's
+		 * ABI lets userspace shove in arbitrary 32-bit values.  Drop
+		 * the upper bits to avoid VM-Fail, losing information that
+		 * does't really exist is preferable to killing the VM.
+		 */
+		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, (u16)error_code);
 		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
 	}
 
-- 
2.35.1.723.g4982287a31-goog

