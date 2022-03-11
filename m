Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721B4D5AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346880AbiCKF5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiCKFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:46 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6729828
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:29 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x205-20020a627cd6000000b004f6e1b97b45so4589926pfc.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=grb5a6vd5s389/PkvAcjoLVljHIGkLuaJsaIdEv33mY=;
        b=YFjKQa0E0JuYvS/yaq6ESb3DkJnZPMDL032gaFvp9UIIwFNfgfFJULVAKSga4rRMfF
         2NdoY73oUSUbbChOCEUb2Nd7YIfIvuPYVY2ze0h0yixtfKdRhPuWqTL3RBHdsB2KnbtP
         pMSP6fiP3GUt1K5xBLOVXq1GYGCEK3ssX82dGNIqXVCM0vQshKWKCFGfOZt3LeI0mTPp
         8TOpmGUJ/hG1NMLZfNaUZ8HySUhMCuNw2anzrG8vMVLf+7aeDnYPQfbx5i4LqTWVfaiY
         gt8yGnpI3BNGBlcDRESIf6JQp3o3/t7Nl7rY7BLHWlLGISnEy3a7jzL5ihAjqoHW9Krq
         oVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=grb5a6vd5s389/PkvAcjoLVljHIGkLuaJsaIdEv33mY=;
        b=KzRLxL2Wfk+2EgTTx1F7NQ6gtkfWaH0sqyvsXYYkoEkyQ524dP/19mx2Og/o4Yg/Cb
         yz8SEPNnqsaEnmYOLtYrWpSFqIckR5APUgEi4Hz61NcNmcJVyGwnEomypnTIdS+yi8Mb
         BkSo+eCTwPD0JliM6fs3jHEzfuEg/rgbTu2Q9M8FZeBI6NXiA626P+VcbYrfNPRt73VS
         lbm8ftqULKxN2zAs/nmGeO7TRt+DKyNmhc5HEyq5LMGZj8uRUcTdJNhekWdpBBTfvj5C
         vbZkF8IsBjjefa8M3pM4+VIqoUQHxcx2VtESuhnJFrNFdwB7qnVy5t0817T0L8MWT2yt
         RMKg==
X-Gm-Message-State: AOAM532OWiu/YMLWzvMwvQdkJMsvZcqmozG3qmINFVyv0ij0S8YXfOGE
        LcibFB/LjHy+eaZChnixrW71WP0fnZ8FgAIaJsKptJ1m+aE0rEO2NmYmIn+spBViTBLM/CeJOa3
        Yg3bMqjYiVdE9Jv94nkWR1B+JpWsF/uhoxoP6FTU4Fop3kH7DlxrNwgifRbm42zFaljeM2A==
X-Google-Smtp-Source: ABdhPJxp1BucRXL83iX9rBdt3M9lRLSk6MRY+TSzC7R8KusOHiCWrN3BzlkVMCq8ooUFdEjNp3t6/tqD/po=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460737pjb.1.1646977948789; Thu, 10 Mar
 2022 21:52:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:00 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-50-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 049/105] KVM: selftests: Convert set_sregs_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/set_sregs_test.c     | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 4dc7fd925023..2b3cae9a1d5b 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -22,9 +22,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID                  5
-
-static void test_cr4_feature_bit(struct kvm_vm *vm, struct kvm_sregs *orig,
+static void test_cr4_feature_bit(struct kvm_vcpu *vcpu, struct kvm_sregs *orig,
 				 uint64_t feature_bit)
 {
 	struct kvm_sregs sregs;
@@ -37,11 +35,11 @@ static void test_cr4_feature_bit(struct kvm_vm *vm, struct kvm_sregs *orig,
 	memcpy(&sregs, orig, sizeof(sregs));
 	sregs.cr4 |= feature_bit;
 
-	rc = _vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	rc = _vcpu_sregs_set(vcpu->vm, vcpu->id, &sregs);
 	TEST_ASSERT(rc, "KVM allowed unsupported CR4 bit (0x%lx)", feature_bit);
 
 	/* Sanity check that KVM didn't change anything. */
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
 	TEST_ASSERT(!memcmp(&sregs, orig, sizeof(sregs)), "KVM modified sregs");
 }
 
@@ -83,6 +81,7 @@ static uint64_t calc_cr4_feature_bits(struct kvm_vm *vm)
 int main(int argc, char *argv[])
 {
 	struct kvm_sregs sregs;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	uint64_t cr4;
 	int rc;
@@ -96,43 +95,43 @@ int main(int argc, char *argv[])
 	 * the vCPU model, i.e. without doing KVM_SET_CPUID2.
 	 */
 	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
-	vm_vcpu_add(vm, VCPU_ID);
+	vcpu = vm_vcpu_add(vm, 0);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 
 	sregs.cr4 |= calc_cr4_feature_bits(vm);
 	cr4 = sregs.cr4;
 
-	rc = _vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	rc = _vcpu_sregs_set(vm, vcpu->id, &sregs);
 	TEST_ASSERT(!rc, "Failed to set supported CR4 bits (0x%lx)", cr4);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	TEST_ASSERT(sregs.cr4 == cr4, "sregs.CR4 (0x%llx) != CR4 (0x%lx)",
 		    sregs.cr4, cr4);
 
 	/* Verify all unsupported features are rejected by KVM. */
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_UMIP);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_LA57);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_VMXE);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_SMXE);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_FSGSBASE);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_PCIDE);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_OSXSAVE);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_SMEP);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_SMAP);
-	test_cr4_feature_bit(vm, &sregs, X86_CR4_PKE);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_UMIP);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_LA57);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_VMXE);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_SMXE);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_FSGSBASE);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_PCIDE);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_OSXSAVE);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_SMEP);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_SMAP);
+	test_cr4_feature_bit(vcpu, &sregs, X86_CR4_PKE);
 	kvm_vm_free(vm);
 
 	/* Create a "real" VM and verify APIC_BASE can be set. */
-	vm = vm_create_default(VCPU_ID, 0, NULL);
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	sregs.apic_base = 1 << 10;
-	rc = _vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	rc = _vcpu_sregs_set(vm, vcpu->id, &sregs);
 	TEST_ASSERT(rc, "Set IA32_APIC_BASE to %llx (invalid)",
 		    sregs.apic_base);
 	sregs.apic_base = 1 << 11;
-	rc = _vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	rc = _vcpu_sregs_set(vm, vcpu->id, &sregs);
 	TEST_ASSERT(!rc, "Couldn't set IA32_APIC_BASE to %llx (valid)",
 		    sregs.apic_base);
 
-- 
2.35.1.723.g4982287a31-goog

