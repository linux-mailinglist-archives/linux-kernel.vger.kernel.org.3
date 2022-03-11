Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB594D5B07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbiCKF6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbiCKFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:55 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925A12AC3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q8-20020a170902f78800b00151cc484688so3989683pln.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZSUJTP9gEU1+SswDMGWGFfMC4wNzBrqEY1Iu8k+gKjY=;
        b=hgEdaubvD3SsWpIASY+NVnipCf7Mu1m914vVk1hqcmTx3KZPtQt+A7y3HP7DAsPyRG
         ZOe8s5jDNu6S503osvtsNhOjrprmN2qCVQv84a/RAYurJ8RBomLL3ovg2hl3V/p7a2IE
         BdwEnjpI1a2zR3an5y5nlxpcyAaSL9VB5trjh2JE5vrw9BeQbqF0aeFn19jaEeWaoeHU
         ln/iWpage12gfjRJXGGssHSLmHhZ2VI4QH14vSW190J0P4XUlezSjfv0IjIxIJ+IIkPv
         AS5oRUoW6X/fMImNIEpPACTzQXFFFuKZ67pbbLb2n2aILNoz3zlRMJ4jxBVCK9Nh1e5n
         7VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZSUJTP9gEU1+SswDMGWGFfMC4wNzBrqEY1Iu8k+gKjY=;
        b=4x7LJuUsAvtbY8rCTtyyQd+JW9Eqrus+8APRFter2aviQtil5rE3IDmZ2vJVRfCgT/
         tiuYsJ02bHvZofwwWSPIiBklLipBmX5Kfwxdw8Omd7XTpw4K/S2xTE6X1FiXWXv2JoJ7
         PNeuMOph3RtFFKxRGc7KtBsmoHgHRKqQOt1Svr0nJl2+fBJJxW3ql+Ggc2pZQFWe+5s5
         dYJ3OQj9mIQIG1paTpiV5SiJJzbyGC0rE8m7qKyJoqWox02BrRCVta3FLHYIhUujlBx+
         Br2mgNSa+Yq3plNqxy23oO/WU1U2MMR9cysack8B8oSgc1jtLIovQ4QFxzMx0kiboV7d
         fBWw==
X-Gm-Message-State: AOAM533GjlgPScuvMJSgK/2lYB+u7FTxIa5zQpWuQwfrlbVVHKb1blbn
        0x1/dd0HlNdMuUDjKKDweEQ6pRBrztWYaJJNSqbQOC2xvo0wy9Bf+2GO1UFA/VCc2exzM8lvcGz
        apBHnWNrn1NDOEtNFlNXDKH8PcmsmM7O5z2cs8g7cVsEMxwBoTcRCoAS/g1Zi9sQEq0DhYQ==
X-Google-Smtp-Source: ABdhPJy/IXC/H9MQzrSF7hzAq19c0hLy837X3JEIS27c+6W2dG/JInIC8tjWuL4+Gxqfze3nKwWyrhYSmw8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c2:b0:151:d590:a13d with SMTP id
 o2-20020a170902d4c200b00151d590a13dmr8627765plg.85.1646977963753; Thu, 10 Mar
 2022 21:52:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:09 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-59-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 058/105] KVM: selftests: Convert hyperv_features away from VCPU_ID
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
 .../selftests/kvm/x86_64/hyperv_features.c    | 51 +++++++++----------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 672915ce73d8..52686e2f8d53 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -13,7 +13,6 @@
 #include "processor.h"
 #include "hyperv.h"
 
-#define VCPU_ID 0
 #define LINUX_OS_ID ((u64)0x8100 << 48)
 
 extern unsigned char rdmsr_start;
@@ -151,7 +150,7 @@ static void guest_hcall(vm_vaddr_t pgs_gpa, struct hcall_data *hcall)
 	GUEST_DONE();
 }
 
-static void hv_set_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid,
+static void hv_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			 struct kvm_cpuid_entry2 *feat,
 			 struct kvm_cpuid_entry2 *recomm,
 			 struct kvm_cpuid_entry2 *dbg)
@@ -162,15 +161,16 @@ static void hv_set_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid,
 		    "failed to set HYPERV_CPUID_ENLIGHTMENT_INFO leaf");
 	TEST_ASSERT(set_cpuid(cpuid, dbg),
 		    "failed to set HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES leaf");
-	vcpu_set_cpuid(vm, VCPU_ID, cpuid);
+	vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
 }
 
 static void guest_test_msrs_access(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
-	int stage = 0, r;
+	int stage = 0;
 	struct kvm_cpuid_entry2 feat = {
 		.function = HYPERV_CPUID_FEATURES
 	};
@@ -189,24 +189,24 @@ static void guest_test_msrs_access(void)
 	struct msr_data *msr;
 
 	while (true) {
-		vm = vm_create_default(VCPU_ID, 0, guest_msr);
+		vm = vm_create_with_one_vcpu(&vcpu, guest_msr);
 
 		msr_gva = vm_vaddr_alloc_page(vm);
 		memset(addr_gva2hva(vm, msr_gva), 0x0, getpagesize());
 		msr = addr_gva2hva(vm, msr_gva);
 
-		vcpu_args_set(vm, VCPU_ID, 1, msr_gva);
-		vcpu_enable_cap(vm, VCPU_ID, &cap);
+		vcpu_args_set(vm, vcpu->id, 1, msr_gva);
+		vcpu_enable_cap(vm, vcpu->id, &cap);
 
-		vcpu_set_hv_cpuid(vm, VCPU_ID);
+		vcpu_set_hv_cpuid(vm, vcpu->id);
 
 		best = kvm_get_supported_hv_cpuid();
 
 		vm_init_descriptor_tables(vm);
-		vcpu_init_descriptor_tables(vm, VCPU_ID);
+		vcpu_init_descriptor_tables(vm, vcpu->id);
 		vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
-		run = vcpu_state(vm, VCPU_ID);
+		run = vcpu->run;
 
 		switch (stage) {
 		case 0:
@@ -339,7 +339,7 @@ static void guest_test_msrs_access(void)
 			 */
 			cap.cap = KVM_CAP_HYPERV_SYNIC2;
 			cap.args[0] = 0;
-			vcpu_enable_cap(vm, VCPU_ID, &cap);
+			vcpu_enable_cap(vm, vcpu->id, &cap);
 			break;
 		case 22:
 			feat.eax |= HV_MSR_SYNIC_AVAILABLE;
@@ -469,7 +469,7 @@ static void guest_test_msrs_access(void)
 			break;
 		}
 
-		hv_set_cpuid(vm, best, &feat, &recomm, &dbg);
+		hv_set_cpuid(vcpu, best, &feat, &recomm, &dbg);
 
 		if (msr->idx)
 			pr_debug("Stage %d: testing msr: 0x%x for %s\n", stage,
@@ -477,13 +477,12 @@ static void guest_test_msrs_access(void)
 		else
 			pr_debug("Stage %d: finish\n", stage);
 
-		r = _vcpu_run(vm, VCPU_ID);
-		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				    "Unexpected stage: %ld (0 expected)\n",
@@ -504,10 +503,11 @@ static void guest_test_msrs_access(void)
 
 static void guest_test_hcalls_access(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
-	int stage = 0, r;
+	int stage = 0;
 	struct kvm_cpuid_entry2 feat = {
 		.function = HYPERV_CPUID_FEATURES,
 		.eax = HV_MSR_HYPERCALL_AVAILABLE
@@ -527,10 +527,10 @@ static void guest_test_hcalls_access(void)
 	struct kvm_cpuid2 *best;
 
 	while (true) {
-		vm = vm_create_default(VCPU_ID, 0, guest_hcall);
+		vm = vm_create_with_one_vcpu(&vcpu, guest_hcall);
 
 		vm_init_descriptor_tables(vm);
-		vcpu_init_descriptor_tables(vm, VCPU_ID);
+		vcpu_init_descriptor_tables(vm, vcpu->id);
 		vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 
 		/* Hypercall input/output */
@@ -541,14 +541,14 @@ static void guest_test_hcalls_access(void)
 		hcall_params = vm_vaddr_alloc_page(vm);
 		memset(addr_gva2hva(vm, hcall_params), 0x0, getpagesize());
 
-		vcpu_args_set(vm, VCPU_ID, 2, addr_gva2gpa(vm, hcall_page), hcall_params);
-		vcpu_enable_cap(vm, VCPU_ID, &cap);
+		vcpu_args_set(vm, vcpu->id, 2, addr_gva2gpa(vm, hcall_page), hcall_params);
+		vcpu_enable_cap(vm, vcpu->id, &cap);
 
-		vcpu_set_hv_cpuid(vm, VCPU_ID);
+		vcpu_set_hv_cpuid(vm, vcpu->id);
 
 		best = kvm_get_supported_hv_cpuid();
 
-		run = vcpu_state(vm, VCPU_ID);
+		run = vcpu->run;
 
 		switch (stage) {
 		case 0:
@@ -643,7 +643,7 @@ static void guest_test_hcalls_access(void)
 			break;
 		}
 
-		hv_set_cpuid(vm, best, &feat, &recomm, &dbg);
+		hv_set_cpuid(vcpu, best, &feat, &recomm, &dbg);
 
 		if (hcall->control)
 			pr_debug("Stage %d: testing hcall: 0x%lx\n", stage,
@@ -651,13 +651,12 @@ static void guest_test_hcalls_access(void)
 		else
 			pr_debug("Stage %d: finish\n", stage);
 
-		r = _vcpu_run(vm, VCPU_ID);
-		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				    "Unexpected stage: %ld (0 expected)\n",
-- 
2.35.1.723.g4982287a31-goog

