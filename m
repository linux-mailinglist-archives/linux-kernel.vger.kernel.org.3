Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B824D5B06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347246AbiCKF6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiCKFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:51 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D89109A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:35 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x6-20020a17090aa38600b001c227fbfbc5so1418974pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5wCOP2Gugq2tkSCgx55n1Cw37znPo8KpXeaNkhMh15g=;
        b=d5oV3MmwpnwMxhDCroU79fbweIIBFUoLG/XHf4oWIM6W0uSRWgUED04Ajhl3hdsQIW
         2+BQ+i/qplMj9uA6JWyx4Uv7knSM/6XaI5JkyT11D53QyiWtIJXDBtvuQNIULa3ESwM7
         R4Nq3bfIVct7ntowNzNa1naqJRr94qVbQRPRYvMcqnibPy6Qn9ORJ5ysnIB2xb9nAjYY
         TXaTTQmF03IGgXhrbLvhm7nug8r6uwvWCVEX6a4S/xFImcADpBSotzasZbx9m8XUApeQ
         Vb+6F+27t8fRkLMWZKbQDa9m2AhWxw6R+yyChWICaWIhaTgGHa0Fs9HrJmgcwSFyDWhP
         IG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5wCOP2Gugq2tkSCgx55n1Cw37znPo8KpXeaNkhMh15g=;
        b=3doYlHfZ59QFniV2DHB5AYoyVM1ZhJFu1VAyEbMcTW2DmXvOptI9OaLJj1bKs4CgaY
         54wQeWZn2ISMBjgrXQ4STzjW3KbMp/i+KGc++aAdSfV5GaKWbsDTXw4bMtQBgb2vF6xo
         GimkwXUjJDUGfXWCH1Uq2ct2MvZ58royNNsGQ+nMMB7LUh3/1j9adNrud2AS89QvEXo1
         SMXIh8H0oEJfE080JAz3QAbOi5YkFZbu2ijOarPkC963QCKLxJaIo8S9Dd323Fsn6zbP
         AlO4jF1/LaWTO/GADwh59NtJqUY4gmMQ2dq7r+NBWVh2S2lKKVhzQ4Q6VogZieU6SPkz
         dEcw==
X-Gm-Message-State: AOAM531nboQ6FAQPnRcWbfEZKajTJyT4pwvyfB4PkN3npxCs0AbcbxkY
        8aGVZMBeuisR6xc7ME26rFJjr1Z7vHaL/6S+WGUmAcmwkQKMcwdr3L0RVPyom18wgqGsjfZaDhZ
        V4A2gJNDAi43Y7qlzgsZF6mbKqV0AwVMyRw47bNTtM0BMylTZo5/E0h0GbDxXoOXXr2kRkQ==
X-Google-Smtp-Source: ABdhPJzkAM7Vqde/zpDpBrOABg8G/QVtdsUkDguou7ech8kpOs7HlPTDkbxJ3BWDNd+PDEbGhPDZlUwAetE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:918f:0:b0:4cc:3c00:b2dd with SMTP id
 x15-20020aa7918f000000b004cc3c00b2ddmr8755772pfa.77.1646977955091; Thu, 10
 Mar 2022 21:52:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:04 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-54-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 053/105] KVM: selftests: Convert userspace_msr_exit_test
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
 .../kvm/x86_64/userspace_msr_exit_test.c      | 165 +++++++++---------
 1 file changed, 78 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index e3e20e8848d0..e261c50fac5c 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -17,7 +17,6 @@
 #define KVM_FEP_LENGTH 5
 static int fep_available = 1;
 
-#define VCPU_ID	      1
 #define MSR_NON_EXISTENT 0x474f4f00
 
 static u64 deny_bits = 0;
@@ -395,31 +394,22 @@ static void guest_ud_handler(struct ex_regs *regs)
 	regs->rip += KVM_FEP_LENGTH;
 }
 
-static void run_guest(struct kvm_vm *vm)
+static void check_for_guest_assert(struct kvm_vcpu *vcpu)
 {
-	int rc;
-
-	rc = _vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(rc == 0, "vcpu_run failed: %d\n", rc);
-}
-
-static void check_for_guest_assert(struct kvm_vm *vm)
-{
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
 	struct ucall uc;
 
-	if (run->exit_reason == KVM_EXIT_IO &&
-		get_ucall(vm, VCPU_ID, &uc) == UCALL_ABORT) {
-			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
-				__FILE__, uc.args[1]);
+	if (vcpu->run->exit_reason == KVM_EXIT_IO &&
+	    get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_ABORT) {
+		TEST_FAIL("%s at %s:%ld",
+			  (const char *)uc.args[0], __FILE__, uc.args[1]);
 	}
 }
 
-static void process_rdmsr(struct kvm_vm *vm, uint32_t msr_index)
+static void process_rdmsr(struct kvm_vcpu *vcpu, uint32_t msr_index)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
-	check_for_guest_assert(vm);
+	check_for_guest_assert(vcpu);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_X86_RDMSR,
 		    "Unexpected exit reason: %u (%s),\n",
@@ -450,11 +440,11 @@ static void process_rdmsr(struct kvm_vm *vm, uint32_t msr_index)
 	}
 }
 
-static void process_wrmsr(struct kvm_vm *vm, uint32_t msr_index)
+static void process_wrmsr(struct kvm_vcpu *vcpu, uint32_t msr_index)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
-	check_for_guest_assert(vm);
+	check_for_guest_assert(vcpu);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_X86_WRMSR,
 		    "Unexpected exit reason: %u (%s),\n",
@@ -481,43 +471,43 @@ static void process_wrmsr(struct kvm_vm *vm, uint32_t msr_index)
 	}
 }
 
-static void process_ucall_done(struct kvm_vm *vm)
+static void process_ucall_done(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	check_for_guest_assert(vm);
+	check_for_guest_assert(vcpu);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s)",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	TEST_ASSERT(get_ucall(vm, VCPU_ID, &uc) == UCALL_DONE,
+	TEST_ASSERT(get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_DONE,
 		    "Unexpected ucall command: %lu, expected UCALL_DONE (%d)",
 		    uc.cmd, UCALL_DONE);
 }
 
-static uint64_t process_ucall(struct kvm_vm *vm)
+static uint64_t process_ucall(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc = {};
 
-	check_for_guest_assert(vm);
+	check_for_guest_assert(vcpu);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s)",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 		break;
 	case UCALL_ABORT:
-		check_for_guest_assert(vm);
+		check_for_guest_assert(vcpu);
 		break;
 	case UCALL_DONE:
-		process_ucall_done(vm);
+		process_ucall_done(vcpu);
 		break;
 	default:
 		TEST_ASSERT(false, "Unexpected ucall");
@@ -526,41 +516,43 @@ static uint64_t process_ucall(struct kvm_vm *vm)
 	return uc.cmd;
 }
 
-static void run_guest_then_process_rdmsr(struct kvm_vm *vm, uint32_t msr_index)
+static void run_guest_then_process_rdmsr(struct kvm_vcpu *vcpu,
+					 uint32_t msr_index)
 {
-	run_guest(vm);
-	process_rdmsr(vm, msr_index);
+	vcpu_run(vcpu->vm, vcpu->id);
+	process_rdmsr(vcpu, msr_index);
 }
 
-static void run_guest_then_process_wrmsr(struct kvm_vm *vm, uint32_t msr_index)
+static void run_guest_then_process_wrmsr(struct kvm_vcpu *vcpu,
+					 uint32_t msr_index)
 {
-	run_guest(vm);
-	process_wrmsr(vm, msr_index);
+	vcpu_run(vcpu->vm, vcpu->id);
+	process_wrmsr(vcpu, msr_index);
 }
 
-static uint64_t run_guest_then_process_ucall(struct kvm_vm *vm)
+static uint64_t run_guest_then_process_ucall(struct kvm_vcpu *vcpu)
 {
-	run_guest(vm);
-	return process_ucall(vm);
+	vcpu_run(vcpu->vm, vcpu->id);
+	return process_ucall(vcpu);
 }
 
-static void run_guest_then_process_ucall_done(struct kvm_vm *vm)
+static void run_guest_then_process_ucall_done(struct kvm_vcpu *vcpu)
 {
-	run_guest(vm);
-	process_ucall_done(vm);
+	vcpu_run(vcpu->vm, vcpu->id);
+	process_ucall_done(vcpu);
 }
 
-static void test_msr_filter_allow(void) {
+static void test_msr_filter_allow(void)
+{
 	struct kvm_enable_cap cap = {
 		.cap = KVM_CAP_X86_USER_SPACE_MSR,
 		.args[0] = KVM_MSR_EXIT_REASON_FILTER,
 	};
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int rc;
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code_filter_allow);
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_filter_allow);
 
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
@@ -572,43 +564,43 @@ static void test_msr_filter_allow(void) {
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_allow);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
 	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
 	/* Process guest code userspace exits. */
-	run_guest_then_process_rdmsr(vm, MSR_IA32_XSS);
-	run_guest_then_process_wrmsr(vm, MSR_IA32_XSS);
-	run_guest_then_process_wrmsr(vm, MSR_IA32_XSS);
+	run_guest_then_process_rdmsr(vcpu, MSR_IA32_XSS);
+	run_guest_then_process_wrmsr(vcpu, MSR_IA32_XSS);
+	run_guest_then_process_wrmsr(vcpu, MSR_IA32_XSS);
 
-	run_guest_then_process_rdmsr(vm, MSR_IA32_FLUSH_CMD);
-	run_guest_then_process_wrmsr(vm, MSR_IA32_FLUSH_CMD);
-	run_guest_then_process_wrmsr(vm, MSR_IA32_FLUSH_CMD);
+	run_guest_then_process_rdmsr(vcpu, MSR_IA32_FLUSH_CMD);
+	run_guest_then_process_wrmsr(vcpu, MSR_IA32_FLUSH_CMD);
+	run_guest_then_process_wrmsr(vcpu, MSR_IA32_FLUSH_CMD);
 
-	run_guest_then_process_wrmsr(vm, MSR_NON_EXISTENT);
-	run_guest_then_process_rdmsr(vm, MSR_NON_EXISTENT);
+	run_guest_then_process_wrmsr(vcpu, MSR_NON_EXISTENT);
+	run_guest_then_process_rdmsr(vcpu, MSR_NON_EXISTENT);
 
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
-	run_guest(vm);
+	vcpu_run(vm, vcpu->id);
 	vm_install_exception_handler(vm, UD_VECTOR, NULL);
 
-	if (process_ucall(vm) != UCALL_DONE) {
+	if (process_ucall(vcpu) != UCALL_DONE) {
 		vm_install_exception_handler(vm, GP_VECTOR, guest_fep_gp_handler);
 
 		/* Process emulated rdmsr and wrmsr instructions. */
-		run_guest_then_process_rdmsr(vm, MSR_IA32_XSS);
-		run_guest_then_process_wrmsr(vm, MSR_IA32_XSS);
-		run_guest_then_process_wrmsr(vm, MSR_IA32_XSS);
+		run_guest_then_process_rdmsr(vcpu, MSR_IA32_XSS);
+		run_guest_then_process_wrmsr(vcpu, MSR_IA32_XSS);
+		run_guest_then_process_wrmsr(vcpu, MSR_IA32_XSS);
 
-		run_guest_then_process_rdmsr(vm, MSR_IA32_FLUSH_CMD);
-		run_guest_then_process_wrmsr(vm, MSR_IA32_FLUSH_CMD);
-		run_guest_then_process_wrmsr(vm, MSR_IA32_FLUSH_CMD);
+		run_guest_then_process_rdmsr(vcpu, MSR_IA32_FLUSH_CMD);
+		run_guest_then_process_wrmsr(vcpu, MSR_IA32_FLUSH_CMD);
+		run_guest_then_process_wrmsr(vcpu, MSR_IA32_FLUSH_CMD);
 
-		run_guest_then_process_wrmsr(vm, MSR_NON_EXISTENT);
-		run_guest_then_process_rdmsr(vm, MSR_NON_EXISTENT);
+		run_guest_then_process_wrmsr(vcpu, MSR_NON_EXISTENT);
+		run_guest_then_process_rdmsr(vcpu, MSR_NON_EXISTENT);
 
 		/* Confirm the guest completed without issues. */
-		run_guest_then_process_ucall_done(vm);
+		run_guest_then_process_ucall_done(vcpu);
 	} else {
 		printf("To run the instruction emulated tests set the module parameter 'kvm.force_emulation_prefix=1'\n");
 	}
@@ -616,16 +608,16 @@ static void test_msr_filter_allow(void) {
 	kvm_vm_free(vm);
 }
 
-static int handle_ucall(struct kvm_vm *vm)
+static int handle_ucall(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_ABORT:
 		TEST_FAIL("Guest assertion not met");
 		break;
 	case UCALL_SYNC:
-		vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &no_filter_deny);
+		vm_ioctl(vcpu->vm, KVM_X86_SET_MSR_FILTER, &no_filter_deny);
 		break;
 	case UCALL_DONE:
 		return 1;
@@ -673,21 +665,21 @@ static void handle_wrmsr(struct kvm_run *run)
 	}
 }
 
-static void test_msr_filter_deny(void) {
+static void test_msr_filter_deny(void)
+{
 	struct kvm_enable_cap cap = {
 		.cap = KVM_CAP_X86_USER_SPACE_MSR,
 		.args[0] = KVM_MSR_EXIT_REASON_INVAL |
 			   KVM_MSR_EXIT_REASON_UNKNOWN |
 			   KVM_MSR_EXIT_REASON_FILTER,
 	};
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	int rc;
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code_filter_deny);
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_filter_deny);
+	run = vcpu->run;
 
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
@@ -700,9 +692,7 @@ static void test_msr_filter_deny(void) {
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_deny);
 
 	while (1) {
-		rc = _vcpu_run(vm, VCPU_ID);
-
-		TEST_ASSERT(rc == 0, "vcpu_run failed: %d\n", rc);
+		vcpu_run(vm, vcpu->id);
 
 		switch (run->exit_reason) {
 		case KVM_EXIT_X86_RDMSR:
@@ -712,7 +702,7 @@ static void test_msr_filter_deny(void) {
 			handle_wrmsr(run);
 			break;
 		case KVM_EXIT_IO:
-			if (handle_ucall(vm))
+			if (handle_ucall(vcpu))
 				goto done;
 			break;
 		}
@@ -726,17 +716,17 @@ static void test_msr_filter_deny(void) {
 	kvm_vm_free(vm);
 }
 
-static void test_msr_permission_bitmap(void) {
+static void test_msr_permission_bitmap(void)
+{
 	struct kvm_enable_cap cap = {
 		.cap = KVM_CAP_X86_USER_SPACE_MSR,
 		.args[0] = KVM_MSR_EXIT_REASON_FILTER,
 	};
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int rc;
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code_permission_bitmap);
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_permission_bitmap);
 
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
@@ -746,11 +736,12 @@ static void test_msr_permission_bitmap(void) {
 	TEST_ASSERT(rc, "KVM_CAP_X86_MSR_FILTER is available");
 
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_fs);
-	run_guest_then_process_rdmsr(vm, MSR_FS_BASE);
-	TEST_ASSERT(run_guest_then_process_ucall(vm) == UCALL_SYNC, "Expected ucall state to be UCALL_SYNC.");
+	run_guest_then_process_rdmsr(vcpu, MSR_FS_BASE);
+	TEST_ASSERT(run_guest_then_process_ucall(vcpu) == UCALL_SYNC,
+		    "Expected ucall state to be UCALL_SYNC.");
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_gs);
-	run_guest_then_process_rdmsr(vm, MSR_GS_BASE);
-	run_guest_then_process_ucall_done(vm);
+	run_guest_then_process_rdmsr(vcpu, MSR_GS_BASE);
+	run_guest_then_process_ucall_done(vcpu);
 
 	kvm_vm_free(vm);
 }
-- 
2.35.1.723.g4982287a31-goog

