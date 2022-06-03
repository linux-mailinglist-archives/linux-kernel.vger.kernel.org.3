Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670853C1A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiFCAyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbiFCAqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:46:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B337A0F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:45:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n8-20020a170902d2c800b001663868e2c2so2327183plc.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=db/YwVzyP7M0ykvs/zXmJv7krGvuQn65+mo4lvD3R8o=;
        b=MEVEdPy1u4Qhq4CqeeHHHLQcnPUMKubKnBaKkrZjvPrPG+hyR/bBsAZNqtpashxrq+
         MggNx39lmKp8NXu6uDmBayi/Zvo/Vqvh/IbOccxeGAdACl+FKWCo7Um35kS0GcfJodOy
         4/EO4b7F+P0RgJyXoofZ02R+3FhoDDT2KDuV80ZkOVx3vJHlyrQH9scpTP8Ez7PQ9mOQ
         NNif6RJbRtPm9/urStD9i5K7LA7Q+kNEW7GjugPaUGNZQdVOIG0w+ytkvfiVsk5zLxFj
         m8vfrZqPcuR0QPHkgKzC1ftmTWIqSWpCCNxmznh8AublBcm7XsobeAZaTtre3FpaiGFs
         Cakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=db/YwVzyP7M0ykvs/zXmJv7krGvuQn65+mo4lvD3R8o=;
        b=KzgAGojANnzZ020p17BUJY94K0Z53ofgtDx7aoR7FeFzfJtPUgUcrx/r9639feKFhd
         Uw1B4EechqQ6MDa9owDAZHNjiSs7QXEL8xIED5Sxe0lJkrgzJL/QCeTUMTfC+d1dw3q7
         3zoqbz/oEHDdB0VCttLL74nP5dAiKGp3ZlQUwAmdsvFD61ZN7qm4vH45UbaW82rWS1vm
         mTNwDdkoBJIPVKW+rTRREzNt0JVmDySV2O0stfBuPV9m0aNhzCmeJi9nz0sgfNbhpLTi
         R0HAxnkzZoWfRNgCBYOjlE272BHZj3h361IAxutt/DXKBa84kk3/lj4oc/sa8gycmecO
         LNtA==
X-Gm-Message-State: AOAM530lPxk3FI9D2p+TC9cTQ/PiFH2pY38HILbvPZQNIHoMFel3GGTi
        m0WQiw70b0QDgEKLtGQ+Ab0qgeU9DaI=
X-Google-Smtp-Source: ABdhPJzbNTrPmqeO+2C4UCGrQOO+LUWgjkpzWMInnpqeVZO3Z2kVcBYWIpqiBtlEqjh9fPaL7A8Eg2Xrnp4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:6411:0:b0:50a:81df:bfa6 with SMTP id
 y17-20020a626411000000b0050a81dfbfa6mr7928796pfb.26.1654217153332; Thu, 02
 Jun 2022 17:45:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:22 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-76-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 075/144] KVM: selftests: Convert kvm_clock_test away from VCPU_ID
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kvm_clock_test to use vm_create_with_one_vcpu() and pass around a
'struct kvm_vcpu' object instead of using a global VCPU_ID.

Opportunistically use vcpu_run() instead of _vcpu_run() with an open
coded assert that KVM_RUN succeeded.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/kvm_clock_test.c     | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
index 97731454f3f3..2c1f850c4053 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
@@ -16,8 +16,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 struct test_case {
 	uint64_t kvmclock_base;
 	int64_t realtime_offset;
@@ -105,29 +103,27 @@ static void setup_clock(struct kvm_vm *vm, struct test_case *test_case)
 	vm_ioctl(vm, KVM_SET_CLOCK, &data);
 }
 
-static void enter_guest(struct kvm_vm *vm)
+static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	struct kvm_clock_data start, end;
-	struct kvm_run *run;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vm *vm = vcpu->vm;
 	struct ucall uc;
-	int i, r;
-
-	run = vcpu_state(vm, VCPU_ID);
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		setup_clock(vm, &test_cases[i]);
 
 		vm_ioctl(vm, KVM_GET_CLOCK, &start);
 
-		r = _vcpu_run(vm, VCPU_ID);
+		vcpu_run(vcpu->vm, vcpu->id);
 		vm_ioctl(vm, KVM_GET_CLOCK, &end);
 
-		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			handle_sync(&uc, &start, &end);
 			break;
@@ -178,6 +174,7 @@ static void check_clocksource(void)
 
 int main(void)
 {
+	struct kvm_vcpu *vcpu;
 	vm_vaddr_t pvti_gva;
 	vm_paddr_t pvti_gpa;
 	struct kvm_vm *vm;
@@ -192,12 +189,12 @@ int main(void)
 
 	check_clocksource();
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
 	pvti_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
 	pvti_gpa = addr_gva2gpa(vm, pvti_gva);
-	vcpu_args_set(vm, VCPU_ID, 2, pvti_gpa, pvti_gva);
+	vcpu_args_set(vm, vcpu->id, 2, pvti_gpa, pvti_gva);
 
-	enter_guest(vm);
+	enter_guest(vcpu);
 	kvm_vm_free(vm);
 }
-- 
2.36.1.255.ge46751e96f-goog

