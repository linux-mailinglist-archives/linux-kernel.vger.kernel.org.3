Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B683153C26A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiFCAxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiFCApp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:45:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F482251B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:45:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k92-20020a17090a4ce500b001e69e8a98a4so933891pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GyDX4O/6d/Nb30Dg2f4P6cZBhtA0aHN1z4aPRcwABRY=;
        b=i3goulk49aQ1ospT/IOnSeTvjRur9/T/AYbRdCLnB58CVCIY7/qmjTy5LCOC59enFs
         rkxbh3803ywkdaTzJxTNng7/CGEIOZ+RWEkaO4+FbcHKHO20zFa8cKnLeWHiacrFqDSF
         7w2Xl+Xm4vFkCs6oT1bEfF6ooTakqtpACJtB/x4Wc9AM56z+bz9CnJizoovbPTfNjYZq
         bvwUpNm3K+0mY1kRw3o2GPUpp+HIkk7XUUMK5QRwNazcCD7aYmvdGMBEP8bHHQHQr5Aj
         /lxZNcpEbTGWDUHvMhtmLPhLsQ7KJeB1M/4Vh7Siuwgp97nejJcxafLetAGaZ+bPOIN1
         qQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GyDX4O/6d/Nb30Dg2f4P6cZBhtA0aHN1z4aPRcwABRY=;
        b=EAy8qvFfHZoM7HNypcFS10wOzgKmB0xlSfXTqNoZdIPi5lk60F+76R8CYCsh0zCvER
         DoNAqXuOk5xQB3nxOnOZJ7ICeMQqkF69RxXm0ZoeJ4Cske08sVh1msTJYACnG3/SJpkI
         44g31wTunymoWRyyfrDCxShA9Ct/hQHzxTXxvUfBqdZQ1lhLXavpwLvC+MWu9oiZVixf
         L/G750s+clzzYHNlV7+6DdXax/MGejxapGvT6eUoIiUvrIt9lsSTJ74Ehp3kNw9dpuIR
         VVhCWjWl+1v12pF6PT3Wh1f/TRneaZUyILDx2mtAISiQm7vRByNtWH4qsFd0PAdvUokj
         GnbQ==
X-Gm-Message-State: AOAM533tegPaYPFc/uW0a7crEsn4qCc53XaAiXGW4FDcTmnaEa5XreVU
        x+AsOC9fMr2L6E6ZeyPlvZBewwtXGR8=
X-Google-Smtp-Source: ABdhPJwB1ZOzhB3dSu9uRdPc/Hz0iAkA6twfaI7ombSSpKggyuBEgNwV56ubG1xTeOfFMnJrkA03an4ulcU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:7d4a:0:b0:398:dad:6963 with SMTP id
 m10-20020a637d4a000000b003980dad6963mr6447957pgn.329.1654217141042; Thu, 02
 Jun 2022 17:45:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:15 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-69-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 068/144] KVM: selftests: Convert set_sregs_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Convert set_sregs_test to use vm_create_with_one_vcpu() and pass around
a 'struct kvm_vcpu' object instead of using a global VCPU_ID.  Note, this
is a "functional" change in the sense that the test now creates a vCPU
with vcpu_id==0 instead of vcpu_id==5.  The non-zero VCPU_ID was 100%
arbitrary and added little to no validation coverage.  If testing
non-zero vCPU IDs is desirable for generic tests, that can be
done in the future by tweaking the VM creation helpers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/set_sregs_test.c     | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index f5e65db9f451..8a5c1f76287c 100644
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
 	vm = vm_create_barebones();
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
2.36.1.255.ge46751e96f-goog

