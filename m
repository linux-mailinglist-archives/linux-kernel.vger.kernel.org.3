Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F191D4D5B21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbiCKGAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346656AbiCKFyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1CFD4457
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gm17-20020a17090b101100b001c21939cad2so1836154pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=QAQlQyWYSCBoIkWO9Ed61vpRUsTVwhacM47gPSZkrDE=;
        b=WX2PLr57YODXi1mLgn1L1g+tLJjU5gm9zc8wcDs6Jsh9x/7TFkp930CPqm4I63DL/e
         WLUMX8ottPBt3qJx+TRsl/5B+oPbTLb8f7FN9AcDyPEwTGcDoCTfWP/F0xbiQ09XgnU0
         L7+NLuwsx4AATs7i3uoT1NBszGafTufPd77D1N9Qm5RNTzleCoVsqzM+bzhsiJePMgGw
         pJXZe6ktYZbwD/xtJ3zHBfu6mfoYL2bcY/oJ9XOZHfWHNLHDpB7xVy/FD9QBu8YrBn7d
         ypsrVohrLtQeMI4cz7lt/DZALhgvz+vg2s7FXTKmsCQzb+TIbMGpz3YIof+atjApC0Y/
         Jujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=QAQlQyWYSCBoIkWO9Ed61vpRUsTVwhacM47gPSZkrDE=;
        b=BF1odrv7WVaS4pl5KqiV2v1Ubrm2Q6XHQLuEAljhWtH7c0GrVkralbh821Cq6dUShc
         kcPkPKv88HoPDxh8Teq+Tico2wTWeo1HK6oNk6luAEH5FD87DTm2/iQ40/Jv+ekNdx+3
         6T+IkmHl7+pwPqtYFJSr9dV3ld3L5pNDVQEFMqP1VQTCmQ6G4XmkhNiC5bnFUCxof0C1
         QQa7AuCjoa9Acr4ymEHNHAeHRHI58rO2NdllDRtaDT23bGfJFIXtnq3eR4xC0FswTM/V
         C6uZhruS1BPmLE/QMRh439kyPRxJDU6mKb2RVh2PrOjfDmZBKw7dBW+D0d4OiAVWZhV5
         z0hg==
X-Gm-Message-State: AOAM533aGOZ04xaTJrFopJIDXtimECNAdz2zlmOMNsvr4gem9ji/EgU1
        a7mCn9lYfMhB1WO3ykKSLXncalPmmd+f97JYTy16qXPMo56+j6rw+OyS5Y7ZnOdn2V43TLQnoPd
        BWddHPFfQM9B6PYm4dsumrxYA25hKBoXZsYRsOfo1XeXLUv7c1Rzoh+pg+6tGA7k3bYw63A==
X-Google-Smtp-Source: ABdhPJwl1FhNL5DQfwYG0D379PrFWKBxxlvjf9yXX5UzoNDVB4KblDf2ttkoN1lIgCkEEn0OhfPzw94n0RI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:f88:b0:1bf:a7c5:501f with SMTP id
 ft8-20020a17090b0f8800b001bfa7c5501fmr13929243pjb.56.1646977987844; Thu, 10
 Mar 2022 21:53:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:23 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-73-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 072/105] KVM: selftests: Convert set_memory_region_test
 away from VCPU_ID
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
 .../selftests/kvm/set_memory_region_test.c    | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 482ae2ad662c..13859b37e28d 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -17,8 +17,6 @@
 #include <kvm_util.h>
 #include <processor.h>
 
-#define VCPU_ID 0
-
 /*
  * s390x needs at least 1MB alignment, and the x86_64 MOVE/DELETE tests need a
  * 2MB sized and aligned region so that the initial region corresponds to
@@ -54,8 +52,8 @@ static inline uint64_t guest_spin_on_val(uint64_t spin_val)
 
 static void *vcpu_worker(void *data)
 {
-	struct kvm_vm *vm = data;
-	struct kvm_run *run;
+	struct kvm_vcpu *vcpu = data;
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 	uint64_t cmd;
 
@@ -64,13 +62,11 @@ static void *vcpu_worker(void *data)
 	 * which will occur if the guest attempts to access a memslot after it
 	 * has been deleted or while it is being moved .
 	 */
-	run = vcpu_state(vm, VCPU_ID);
-
 	while (1) {
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vcpu->vm, vcpu->id);
 
 		if (run->exit_reason == KVM_EXIT_IO) {
-			cmd = get_ucall(vm, VCPU_ID, &uc);
+			cmd = get_ucall(vcpu->vm, vcpu->id, &uc);
 			if (cmd != UCALL_SYNC)
 				break;
 
@@ -113,13 +109,14 @@ static void wait_for_vcpu(void)
 	usleep(100000);
 }
 
-static struct kvm_vm *spawn_vm(pthread_t *vcpu_thread, void *guest_code)
+static struct kvm_vm *spawn_vm(struct kvm_vcpu **vcpu, pthread_t *vcpu_thread,
+			       void *guest_code)
 {
 	struct kvm_vm *vm;
 	uint64_t *hva;
 	uint64_t gpa;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(vcpu, guest_code);
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
 				    MEM_REGION_GPA, MEM_REGION_SLOT,
@@ -138,7 +135,7 @@ static struct kvm_vm *spawn_vm(pthread_t *vcpu_thread, void *guest_code)
 	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
 	memset(hva, 0, 2 * 4096);
 
-	pthread_create(vcpu_thread, NULL, vcpu_worker, vm);
+	pthread_create(vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	/* Ensure the guest thread is spun up. */
 	wait_for_vcpu();
@@ -180,10 +177,11 @@ static void guest_code_move_memory_region(void)
 static void test_move_memory_region(void)
 {
 	pthread_t vcpu_thread;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	uint64_t *hva;
 
-	vm = spawn_vm(&vcpu_thread, guest_code_move_memory_region);
+	vm = spawn_vm(&vcpu, &vcpu_thread, guest_code_move_memory_region);
 
 	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
 
@@ -258,11 +256,12 @@ static void guest_code_delete_memory_region(void)
 static void test_delete_memory_region(void)
 {
 	pthread_t vcpu_thread;
+	struct kvm_vcpu *vcpu;
 	struct kvm_regs regs;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 
-	vm = spawn_vm(&vcpu_thread, guest_code_delete_memory_region);
+	vm = spawn_vm(&vcpu, &vcpu_thread, guest_code_delete_memory_region);
 
 	/* Delete the memory region, the guest should not die. */
 	vm_mem_region_delete(vm, MEM_REGION_SLOT);
@@ -286,13 +285,13 @@ static void test_delete_memory_region(void)
 
 	pthread_join(vcpu_thread, NULL);
 
-	run = vcpu_state(vm, VCPU_ID);
+	run = vcpu->run;
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN ||
 		    run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
 		    "Unexpected exit reason = %d", run->exit_reason);
 
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 
 	/*
 	 * On AMD, after KVM_EXIT_SHUTDOWN the VMCB has been reinitialized already,
@@ -309,18 +308,19 @@ static void test_delete_memory_region(void)
 
 static void test_zero_memory_regions(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 
 	pr_info("Testing KVM_RUN with zero added memory regions\n");
 
 	vm = vm_create(0);
-	vm_vcpu_add(vm, VCPU_ID);
+	vcpu = vm_vcpu_add(vm, 0);
 
 	vm_ioctl(vm, KVM_SET_NR_MMU_PAGES, (void *)64ul);
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
-	run = vcpu_state(vm, VCPU_ID);
+	run = vcpu->run;
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
 		    "Unexpected exit_reason = %u\n", run->exit_reason);
 
-- 
2.35.1.723.g4982287a31-goog

