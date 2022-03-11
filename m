Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D064D5B39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbiCKGBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiCKFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6FDF7459
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id s12-20020a17090a13cc00b001bee1e1677fso4726431pjf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=iey8L3Z4CR9iUjbvcUtJbA1o/xGa5avmZpYhOaewg5k=;
        b=A1dmX2Sczyy/Iy0SXBak7gDNlvN06zb3uUAx0jkRGFZOS3tTeq6Z4zkNvd3Lbp7Yke
         nqOUT4TEB7Q7/27tXhQVtnYCigZYGb4CDNVMhiSTs7N9nZKdngYHNqj2T2Et7Zm4g6Of
         2ve1lg9Dl3gj/kfgPYqtCF3o3MSjp1zXE9cGzBV8DSxF2Fs9tfG9ScAaaZhMCTa3Cw2g
         /NBDuNtrS1uWxMPD0ZqaGlvoV+Vtck+ATb+LjrEV/LT4VNUyZxDT2/sFcNYyUYFIXIZz
         URAChJR6kPKIzvcDFK3Dl3w168eYRQtARb0AhKoBNBeO388YNXcjCmVjp2FI9Hy7n1CN
         VwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=iey8L3Z4CR9iUjbvcUtJbA1o/xGa5avmZpYhOaewg5k=;
        b=hYTsDMc9+P7AUJ41nFpkO/Xy+XSBBxb/syzwBuYVOyyJI4wo+yd+5FJRg8N3Hnp+gQ
         65NZ5nKfPGhGzD8IW5+wa01F/OC3N9fMeuquIL+NjXTZsGOSWgVmZB/13gUBr2TUxZ/M
         nMtyoiWBAoHdkk5S34LzEhfAbsQt2lTNjbp0mPT/xsUcXTedH77n+Ij0IW+985D9gZK5
         6fksaWNxWElOH/i/RawCVeWfGCcyvJvUxjkRCC4+1PvVlpRsKJ4z08IkIQFVDTzmJlVM
         ymORTjPTA0hI/2kKKk5nQiX9+y+fPJMJMAU+9zSsj5wvp5hkFajsFk3hfo6eZW2okQS1
         uHzw==
X-Gm-Message-State: AOAM530S3QpR6SaSpjDJoIx9bHaVn2+3uvwNzEDDXYIjrvkrg2ppWqWN
        bdIp1zDgJHKJHcrI8ypBPBllgb4aQZO6Alvl8d5zexnQPIzd+HrKyCUidEtDS/PF/ncXuvhlo+F
        LKPo2ADVyxREePeSz2DFrhJKjBz8dot63vqAqZK/RBLfkBJbMwImQpZc5tZ6cwV7FwIvE3A==
X-Google-Smtp-Source: ABdhPJxCL3Y6XTQqCNwxdfb9s98MT8i7whK+wve7UosLI538D9akwt09VmhT8uS3Xw6jYse2nXnxl9En3u8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461827pjb.0.1646978019527; Thu, 10 Mar
 2022 21:53:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:42 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-92-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 091/105] KVM: selftests: Convert resets away from VCPU_ID
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
 tools/testing/selftests/kvm/s390x/resets.c | 137 ++++++++++++---------
 1 file changed, 77 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index cc4b7c86d69f..37e375729a39 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -13,14 +13,12 @@
 #include "test_util.h"
 #include "kvm_util.h"
 
-#define VCPU_ID 3
 #define LOCAL_IRQS 32
 
-struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
+#define ARBITRARY_NON_ZERO_VCPU_ID 3
+
+struct kvm_s390_irq buf[ARBITRARY_NON_ZERO_VCPU_ID + LOCAL_IRQS];
 
-struct kvm_vm *vm;
-struct kvm_run *run;
-struct kvm_sync_regs *sync_regs;
 static uint8_t regs_null[512];
 
 static void guest_code_initial(void)
@@ -58,25 +56,25 @@ static void guest_code_initial(void)
 		);
 }
 
-static void test_one_reg(uint64_t id, uint64_t value)
+static void test_one_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t value)
 {
 	struct kvm_one_reg reg;
 	uint64_t eval_reg;
 
 	reg.addr = (uintptr_t)&eval_reg;
 	reg.id = id;
-	vcpu_get_reg(vm, VCPU_ID, &reg);
+	vcpu_get_reg(vcpu->vm, vcpu->id, &reg);
 	TEST_ASSERT(eval_reg == value, "value == 0x%lx", value);
 }
 
-static void assert_noirq(void)
+static void assert_noirq(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_irq_state irq_state;
 	int irqs;
 
 	irq_state.len = sizeof(buf);
 	irq_state.buf = (unsigned long)buf;
-	irqs = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
+	irqs = __vcpu_ioctl(vcpu->vm, vcpu->id, KVM_S390_GET_IRQ_STATE, &irq_state);
 	/*
 	 * irqs contains the number of retrieved interrupts. Any interrupt
 	 * (notably, the emergency call interrupt we have injected) should
@@ -86,19 +84,20 @@ static void assert_noirq(void)
 	TEST_ASSERT(!irqs, "IRQ pending");
 }
 
-static void assert_clear(void)
+static void assert_clear(struct kvm_vcpu *vcpu)
 {
+	struct kvm_sync_regs *sync_regs = &vcpu->run->s.regs;
 	struct kvm_sregs sregs;
 	struct kvm_regs regs;
 	struct kvm_fpu fpu;
 
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vcpu->vm, vcpu->id, &regs);
 	TEST_ASSERT(!memcmp(&regs.gprs, regs_null, sizeof(regs.gprs)), "grs == 0");
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
 	TEST_ASSERT(!memcmp(&sregs.acrs, regs_null, sizeof(sregs.acrs)), "acrs == 0");
 
-	vcpu_fpu_get(vm, VCPU_ID, &fpu);
+	vcpu_fpu_get(vcpu->vm, vcpu->id, &fpu);
 	TEST_ASSERT(!memcmp(&fpu.fprs, regs_null, sizeof(fpu.fprs)), "fprs == 0");
 
 	/* sync regs */
@@ -112,8 +111,10 @@ static void assert_clear(void)
 		    "vrs0-15 == 0 (sync_regs)");
 }
 
-static void assert_initial_noclear(void)
+static void assert_initial_noclear(struct kvm_vcpu *vcpu)
 {
+	struct kvm_sync_regs *sync_regs = &vcpu->run->s.regs;
+
 	TEST_ASSERT(sync_regs->gprs[0] == 0xffff000000000000UL,
 		    "gpr0 == 0xffff000000000000 (sync_regs)");
 	TEST_ASSERT(sync_regs->gprs[1] == 0x0000555500000000UL,
@@ -127,13 +128,14 @@ static void assert_initial_noclear(void)
 	TEST_ASSERT(sync_regs->acrs[9] == 1, "ar9 == 1 (sync_regs)");
 }
 
-static void assert_initial(void)
+static void assert_initial(struct kvm_vcpu *vcpu)
 {
+	struct kvm_sync_regs *sync_regs = &vcpu->run->s.regs;
 	struct kvm_sregs sregs;
 	struct kvm_fpu fpu;
 
 	/* KVM_GET_SREGS */
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
 	TEST_ASSERT(sregs.crs[0] == 0xE0UL, "cr0 == 0xE0 (KVM_GET_SREGS)");
 	TEST_ASSERT(sregs.crs[14] == 0xC2000000UL,
 		    "cr14 == 0xC2000000 (KVM_GET_SREGS)");
@@ -156,36 +158,38 @@ static void assert_initial(void)
 	TEST_ASSERT(sync_regs->gbea == 1, "gbea == 1 (sync_regs)");
 
 	/* kvm_run */
-	TEST_ASSERT(run->psw_addr == 0, "psw_addr == 0 (kvm_run)");
-	TEST_ASSERT(run->psw_mask == 0, "psw_mask == 0 (kvm_run)");
+	TEST_ASSERT(vcpu->run->psw_addr == 0, "psw_addr == 0 (kvm_run)");
+	TEST_ASSERT(vcpu->run->psw_mask == 0, "psw_mask == 0 (kvm_run)");
 
-	vcpu_fpu_get(vm, VCPU_ID, &fpu);
+	vcpu_fpu_get(vcpu->vm, vcpu->id, &fpu);
 	TEST_ASSERT(!fpu.fpc, "fpc == 0");
 
-	test_one_reg(KVM_REG_S390_GBEA, 1);
-	test_one_reg(KVM_REG_S390_PP, 0);
-	test_one_reg(KVM_REG_S390_TODPR, 0);
-	test_one_reg(KVM_REG_S390_CPU_TIMER, 0);
-	test_one_reg(KVM_REG_S390_CLOCK_COMP, 0);
+	test_one_reg(vcpu, KVM_REG_S390_GBEA, 1);
+	test_one_reg(vcpu, KVM_REG_S390_PP, 0);
+	test_one_reg(vcpu, KVM_REG_S390_TODPR, 0);
+	test_one_reg(vcpu, KVM_REG_S390_CPU_TIMER, 0);
+	test_one_reg(vcpu, KVM_REG_S390_CLOCK_COMP, 0);
 }
 
-static void assert_normal_noclear(void)
+static void assert_normal_noclear(struct kvm_vcpu *vcpu)
 {
+	struct kvm_sync_regs *sync_regs = &vcpu->run->s.regs;
+
 	TEST_ASSERT(sync_regs->crs[2] == 0x10, "cr2 == 10 (sync_regs)");
 	TEST_ASSERT(sync_regs->crs[8] == 1, "cr10 == 1 (sync_regs)");
 	TEST_ASSERT(sync_regs->crs[10] == 1, "cr10 == 1 (sync_regs)");
 	TEST_ASSERT(sync_regs->crs[11] == -1, "cr11 == -1 (sync_regs)");
 }
 
-static void assert_normal(void)
+static void assert_normal(struct kvm_vcpu *vcpu)
 {
-	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
-	TEST_ASSERT(sync_regs->pft == KVM_S390_PFAULT_TOKEN_INVALID,
+	test_one_reg(vcpu, KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
+	TEST_ASSERT(vcpu->run->s.regs.pft == KVM_S390_PFAULT_TOKEN_INVALID,
 			"pft == 0xff.....  (sync_regs)");
-	assert_noirq();
+	assert_noirq(vcpu);
 }
 
-static void inject_irq(int cpu_id)
+static void inject_irq(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_irq_state irq_state;
 	struct kvm_s390_irq *irq = &buf[0];
@@ -195,73 +199,86 @@ static void inject_irq(int cpu_id)
 	irq_state.len = sizeof(struct kvm_s390_irq);
 	irq_state.buf = (unsigned long)buf;
 	irq->type = KVM_S390_INT_EMERGENCY;
-	irq->u.emerg.code = cpu_id;
-	irqs = __vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
+	irq->u.emerg.code = vcpu->id;
+	irqs = __vcpu_ioctl(vcpu->vm, vcpu->id, KVM_S390_SET_IRQ_STATE, &irq_state);
 	TEST_ASSERT(irqs >= 0, "Error injecting EMERGENCY IRQ errno %d\n", errno);
 }
 
+static struct kvm_vm *create_vm(struct kvm_vcpu **vcpu)
+{
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_vcpus(0, NULL, NULL);
+
+	*vcpu = vm_vcpu_add(vm, ARBITRARY_NON_ZERO_VCPU_ID, guest_code_initial);
+
+	return vm;
+}
+
 static void test_normal(void)
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	pr_info("Testing normal reset\n");
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
-	run = vcpu_state(vm, VCPU_ID);
-	sync_regs = &run->s.regs;
+	vm = create_vm(&vcpu);
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
-	inject_irq(VCPU_ID);
+	inject_irq(vcpu);
 
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
+	vcpu_ioctl(vm, vcpu->id, KVM_S390_NORMAL_RESET, 0);
 
 	/* must clears */
-	assert_normal();
+	assert_normal(vcpu);
 	/* must not clears */
-	assert_normal_noclear();
-	assert_initial_noclear();
+	assert_normal_noclear(vcpu);
+	assert_initial_noclear(vcpu);
 
 	kvm_vm_free(vm);
 }
 
 static void test_initial(void)
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	pr_info("Testing initial reset\n");
-	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
-	run = vcpu_state(vm, VCPU_ID);
-	sync_regs = &run->s.regs;
+	vm = create_vm(&vcpu);
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
-	inject_irq(VCPU_ID);
+	inject_irq(vcpu);
 
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
+	vcpu_ioctl(vm, vcpu->id, KVM_S390_INITIAL_RESET, 0);
 
 	/* must clears */
-	assert_normal();
-	assert_initial();
+	assert_normal(vcpu);
+	assert_initial(vcpu);
 	/* must not clears */
-	assert_initial_noclear();
+	assert_initial_noclear(vcpu);
 
 	kvm_vm_free(vm);
 }
 
 static void test_clear(void)
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	pr_info("Testing clear reset\n");
-	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
-	run = vcpu_state(vm, VCPU_ID);
-	sync_regs = &run->s.regs;
+	vm = create_vm(&vcpu);
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
-	inject_irq(VCPU_ID);
+	inject_irq(vcpu);
 
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
+	vcpu_ioctl(vm, vcpu->id, KVM_S390_CLEAR_RESET, 0);
 
 	/* must clears */
-	assert_normal();
-	assert_initial();
-	assert_clear();
+	assert_normal(vcpu);
+	assert_initial(vcpu);
+	assert_clear(vcpu);
 
 	kvm_vm_free(vm);
 }
-- 
2.35.1.723.g4982287a31-goog

