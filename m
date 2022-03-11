Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669CB4D5B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbiCKF75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346703AbiCKFy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:29 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F1F94F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q8-20020a170902f78800b00151cc484688so3990506pln.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=n3s9d5PJ5CxB3J3mwvRAzn5Ka7HL6th0ys+7GPz8bVo=;
        b=LSujlnxYNWAJuDBKUliNb8AB9scPhTz4YYBeWuORJ2cbBSReeAVtn/WuNXav+lmPIF
         yjBXwOz20m9OZ3KY/c0GdhalthMss259C203EmxYT7vgTkxOZd72m9MHe+gL/pxGkLkF
         62pw2IyGlCLwZuny1AiIHNQ2l6S22J+6A1n0r0/lytt9gMlhQDqJFBiTkNi6mCwzvYsR
         DekKpw1CYDwgDnmJ6qqC4eFjIPhOBUGAYhXT07ETs0DE4y+7wKMLjFfkde3EijhfSOgP
         U07ipHAb+5th4mY4F3hzBvoEIGIjQrWhKUSEzW3rz5U5jDGasqZDnN2vf/9C7++Fq4E4
         t2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=n3s9d5PJ5CxB3J3mwvRAzn5Ka7HL6th0ys+7GPz8bVo=;
        b=5qoInRjB7u+OSeF3O2XfgpgMqHfvdbGx6yiNtc/5P3fVFNIPohh6M0SIr1Z1wFFs65
         eVqXyKo9GF3rgSgAXdYWDZK5gqt761YlwMRVlOoQNWgxpc3adRGg/Dax+rBSWsT7mi+X
         oKgviqaIj7k93pqntLMgT3U8a+cj6sjOr7Ol0HD8PnnwgPSSW/GnAUctZaH5YqyB1AhW
         itkKGzeHm/VeVaNQe2E7Uz2sln1rKnnnn1YsY7vQ4tOHsMVIEMORnvKQyjwDKLFXpoLq
         piDLuuDIk4EyHhr8Ms2oRb7kVL+ejil2Wm0Wn9/gwBebnP1FK0AvvI/7AYUu3qY9Ty3N
         aN/A==
X-Gm-Message-State: AOAM531jOiO3T2q65JsAJ0XERDb7v5OWPYIME4ZNiZ2q9Q2eegXyAyOO
        pXHpjV5FiWIvZ5fYOskCgmV5krX524Q54C8IITHOaua2Fi6pRFO+CMMOSMuFbGD429U15ompdYT
        dI9DVZsf99wNvQpckHbt+9r3s/lQbE3RQE52AynsYwczbann2riyjCVVb6RARKfPpnk+arQ==
X-Google-Smtp-Source: ABdhPJxGGYwbjuSOL+G6F+qLrwDJBmyEytWrYa+3IjKPMJ5KIdDHHlG9G6TfP6OyHmnXAiBNLcjoYimslEw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:bb10:b0:153:1b4b:d143 with SMTP id
 im16-20020a170902bb1000b001531b4bd143mr7654335plb.142.1646977999775; Thu, 10
 Mar 2022 21:53:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:30 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-80-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 079/105] KVM: selftests: Return created vcpu from vm_vcpu_add_default()
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
 .../selftests/kvm/include/aarch64/processor.h |  5 +++--
 .../selftests/kvm/include/kvm_util_base.h     | 10 ++++++----
 .../selftests/kvm/lib/aarch64/processor.c     | 20 +++++++++++--------
 .../selftests/kvm/lib/riscv/processor.c       | 18 ++++++++++-------
 .../selftests/kvm/lib/s390x/processor.c       | 18 ++++++++++-------
 .../selftests/kvm/lib/x86_64/processor.c      | 20 +++++++++++--------
 6 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 9a430980100e..5999e7ae7b29 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -64,8 +64,9 @@ static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint
 }
 
 void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init);
-void aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid,
-			      struct kvm_vcpu_init *init, void *guest_code);
+struct kvm_vcpu *aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpu_id,
+					  struct kvm_vcpu_init *init,
+					  void *guest_code);
 
 struct ex_regs {
 	u64 regs[31];
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index aa2e68bca741..19a7e507b8e7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -637,12 +637,14 @@ static inline void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
  *   vcpuid - The id of the VCPU to add to the VM.
  *   guest_code - The vCPU's entry point
  */
-void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code);
 
-static inline void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid,
-				       void *guest_code)
+static inline struct kvm_vcpu *vm_vcpu_add_default(struct kvm_vm *vm,
+						   uint32_t vcpu_id,
+						   void *guest_code)
 {
-	vm_arch_vcpu_add(vm, vcpuid, guest_code);
+	return vm_arch_vcpu_add(vm, vcpu_id, guest_code);
 }
 
 void virt_arch_pgd_alloc(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 653e740c46b1..089e6de2160c 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -314,25 +314,29 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t in
 		indent, "", pstate, pc);
 }
 
-void aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid,
-			      struct kvm_vcpu_init *init, void *guest_code)
+struct kvm_vcpu *aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpu_id,
+					  struct kvm_vcpu_init *init,
+					  void *guest_code)
 {
 	size_t stack_size = vm->page_size == 4096 ?
 					DEFAULT_STACK_PGS * vm->page_size :
 					vm->page_size;
 	uint64_t stack_vaddr = vm_vaddr_alloc(vm, stack_size,
 					      DEFAULT_ARM64_GUEST_STACK_VADDR_MIN);
+	struct kvm_vcpu *vcpu = vm_vcpu_add(vm, vcpu_id);
 
-	vm_vcpu_add(vm, vcpuid);
-	aarch64_vcpu_setup(vm, vcpuid, init);
+	aarch64_vcpu_setup(vm, vcpu_id, init);
 
-	set_reg(vm, vcpuid, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
-	set_reg(vm, vcpuid, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code);
+	set_reg(vm, vcpu_id, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
+	set_reg(vm, vcpu_id, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code);
+
+	return vcpu;
 }
 
-void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
 {
-	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
+	return aarch64_vcpu_add_default(vm, vcpu_id, NULL, guest_code);
 }
 
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 8f415633ed12..34a9f0cf05ba 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -273,7 +273,8 @@ static void guest_hang(void)
 		;
 }
 
-void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
 {
 	int r;
 	size_t stack_size = vm->page_size == 4096 ?
@@ -283,8 +284,9 @@ void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 					DEFAULT_RISCV_GUEST_STACK_VADDR_MIN);
 	unsigned long current_gp = 0;
 	struct kvm_mp_state mps;
+	struct kvm_vcpu *vcpu;
 
-	vm_vcpu_add(vm, vcpuid);
+	vcpu = vm_vcpu_add(vm, vcpuid);
 	riscv_vcpu_mmu_setup(vm, vcpuid);
 
 	/*
@@ -293,23 +295,25 @@ void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 	 * are powered-on using KVM_SET_MP_STATE ioctl().
 	 */
 	mps.mp_state = KVM_MP_STATE_RUNNABLE;
-	r = __vcpu_ioctl(vm, vcpuid, KVM_SET_MP_STATE, &mps);
+	r = __vcpu_ioctl(vm, vcpu_id, KVM_SET_MP_STATE, &mps);
 	TEST_ASSERT(!r, "IOCTL KVM_SET_MP_STATE failed (error %d)", r);
 
 	/* Setup global pointer of guest to be same as the host */
 	asm volatile (
 		"add %0, gp, zero" : "=r" (current_gp) : : "memory");
-	set_reg(vm, vcpuid, RISCV_CORE_REG(regs.gp), current_gp);
+	set_reg(vm, vcpu_id, RISCV_CORE_REG(regs.gp), current_gp);
 
 	/* Setup stack pointer and program counter of guest */
-	set_reg(vm, vcpuid, RISCV_CORE_REG(regs.sp),
+	set_reg(vm, vcpu_id, RISCV_CORE_REG(regs.sp),
 		stack_vaddr + stack_size);
-	set_reg(vm, vcpuid, RISCV_CORE_REG(regs.pc),
+	set_reg(vm, vcpu_id, RISCV_CORE_REG(regs.pc),
 		(unsigned long)guest_code);
 
 	/* Setup default exception vector of guest */
-	set_reg(vm, vcpuid, RISCV_CSR_REG(stvec),
+	set_reg(vm, vcpu_id, RISCV_CSR_REG(stvec),
 		(unsigned long)guest_hang);
+
+	return vcpu;
 }
 
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index c2fe56a3fb74..5c59a1d7ec6d 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -154,12 +154,14 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	virt_dump_region(stream, vm, indent, vm->pgd);
 }
 
-void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
 {
 	size_t stack_size =  DEFAULT_STACK_PGS * getpagesize();
 	uint64_t stack_vaddr;
 	struct kvm_regs regs;
 	struct kvm_sregs sregs;
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 
 	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
@@ -168,21 +170,23 @@ void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 	stack_vaddr = vm_vaddr_alloc(vm, stack_size,
 				     DEFAULT_GUEST_STACK_VADDR_MIN);
 
-	vm_vcpu_add(vm, vcpuid);
+	vcpu = vm_vcpu_add(vm, vcpuid);
 
 	/* Setup guest registers */
-	vcpu_regs_get(vm, vcpuid, &regs);
+	vcpu_regs_get(vm, vcpu_id, &regs);
 	regs.gprs[15] = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize()) - 160;
-	vcpu_regs_set(vm, vcpuid, &regs);
+	vcpu_regs_set(vm, vcpu_id, &regs);
 
-	vcpu_sregs_get(vm, vcpuid, &sregs);
+	vcpu_sregs_get(vm, vcpu_id, &sregs);
 	sregs.crs[0] |= 0x00040000;		/* Enable floating point regs */
 	sregs.crs[1] = vm->pgd | 0xf;		/* Primary region table */
-	vcpu_sregs_set(vm, vcpuid, &sregs);
+	vcpu_sregs_set(vm, vcpu_id, &sregs);
 
-	run = vcpu_state(vm, vcpuid);
+	run = vcpu_state(vm, vcpu_id);
 	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
 	run->psw_addr = (uintptr_t)guest_code;
+
+	return vcpu;
 }
 
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index fd14351a3835..24ec376c5d6d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -671,29 +671,33 @@ void vm_xsave_req_perm(int bit)
 		    bitmask);
 }
 
-void vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  void *guest_code)
 {
 	struct kvm_mp_state mp_state;
 	struct kvm_regs regs;
 	vm_vaddr_t stack_vaddr;
+	struct kvm_vcpu *vcpu;
+
 	stack_vaddr = vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
 				     DEFAULT_GUEST_STACK_VADDR_MIN);
 
-	/* Create VCPU */
-	vm_vcpu_add(vm, vcpuid);
-	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
-	vcpu_setup(vm, vcpuid);
+	vcpu = vm_vcpu_add(vm, vcpu_id);
+	vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
+	vcpu_setup(vm, vcpu_id);
 
 	/* Setup guest general purpose registers */
-	vcpu_regs_get(vm, vcpuid, &regs);
+	vcpu_regs_get(vm, vcpu_id, &regs);
 	regs.rflags = regs.rflags | 0x2;
 	regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
 	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vm, vcpuid, &regs);
+	vcpu_regs_set(vm, vcpu_id, &regs);
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
-	vcpu_set_mp_state(vm, vcpuid, &mp_state);
+	vcpu_set_mp_state(vm, vcpu_id, &mp_state);
+
+	return vcpu;
 }
 
 /*
-- 
2.35.1.723.g4982287a31-goog

