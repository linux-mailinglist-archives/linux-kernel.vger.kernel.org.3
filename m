Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C773751B2AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379831AbiEDXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379537AbiEDWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:55:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1A54BC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j187-20020a638bc4000000b003c1922b0f1bso1353729pge.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OyZawrHkB4Z1N2cxiek0my2DAY1E9NQHyY0gINLAZhw=;
        b=OtSny6q9CPRr97Jn/768DavVUouBNGMVjZRpUscVrG+5KoLy/r8xjYR1Un6VtrrgVa
         /gpweVLcC8w+etsaQG4CaXGuBqqtG49zHluS1T6yNgSXgxonBQura3UVeB0NugETiYI9
         /FwWASUxjb2t78lUTWPoEGs8lEc2vm7NbCPyPEhBBMqRoSRcAIX3ynEjDDGuylGYukuN
         VPmsoQgdrxcK9SEc9uzCF4UxJJ16elIzYaOYVeIUIqMIOuBE5HfCnR592j5NWIi/g0Sc
         ZF8R4d0G1Cbr/R/GII5VbcA/r3n/IjbudTNYWoloczykb5xDxtHY3SlF6fvbajeYwscx
         DS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OyZawrHkB4Z1N2cxiek0my2DAY1E9NQHyY0gINLAZhw=;
        b=TM+rmt1OgTEE04tLTVhdPx1rBqVIvNGOse2Q1+Sn5NDQtCYhqQiBDchChFGIcmA9Mj
         +GPCCuMSGBuSvYHHT36xVAjgTFt7WWOt7fDE0mnAunF854FJ/UWVkoVLzYpEbObjSaDw
         /5p7kRHZBDN4Lj1EMgwgxzGoPk5KgGHszXbL4XIW7QTbSX7EOI5TgenLLVLZHcJF7ElQ
         M/geVGDxxRUlFnwNtQC/xC8U0gFShOjJjw4CVBs7rtRptQR9JpQhy4EKyxn33H3DPBee
         8pjssLBX4VSSvEPPT5Fg8S7LqzZVI0N2uPGRz4lo8cCLkJGTDXrQN8HRs5SRq7zpFINH
         S3+w==
X-Gm-Message-State: AOAM530sNIbGPuSStDKwXRh1ZvpNuVzJrpLB2hwiNs9zlAY3EQHsWTRw
        yFi8By0H3S0uMbqCGyErfs3DaQJJQb0=
X-Google-Smtp-Source: ABdhPJxjHSM5iKU537POweSOw5OS/WhBTYMax96BB/QEERx4ih/jHAEBTKQ8DivcIZPZUjPYhRG9xosj1FE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b7ca:b0:15c:df6a:be86 with SMTP id
 v10-20020a170902b7ca00b0015cdf6abe86mr23607641plz.70.1651704687081; Wed, 04
 May 2022 15:51:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:13 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-68-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 067/128] KVM: selftests: Convert kvm_clock_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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
2.36.0.464.gb9c8b46e94-goog

