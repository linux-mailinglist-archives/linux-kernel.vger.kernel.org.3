Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C479E4D5B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347532AbiCKF6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346673AbiCKFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AA6344
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:37 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q8-20020a170902f78800b00151cc484688so3989346pln.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EG76RmjpT36oc/OYWnIelI/676foWe9jWdF9au7Hu10=;
        b=Js+NAHJdk6Ux7fMRiJFASq0FtWxMG4ry18aV8wwU00YK06PiDx5ZN4HLOGk2cN+XjP
         KxymBtCzRfUVkd4FEzePBr2hVSA3wLjSxueXeE8HbOw1VJVH0VJjglAwMYhOZhy5dSFq
         1z8/2aPFfWZhRNiTojvhbHis+az276ZQL3fpvFMYo0lspobg4bKcFfH1s++RZleo4xFM
         N9wdrsQ59lfCJIUyLH6tmLK8ISXp1pRVmHuIdfkLSbBvdMiMHg8DwT8ENyDS/qO3Nc3c
         O39WZpxX+JQpW7FIaI8X/RyM5nLQ9ltNDO+e/7M9w4t6gej2dx3VX1yx3CVDcPoOxNhy
         dzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EG76RmjpT36oc/OYWnIelI/676foWe9jWdF9au7Hu10=;
        b=o3C+0wdfTwcezyzJyJ6ARiyPRoTycJqc62NUNqTwzLnLHQ2z4aOJOuLsCrWyy6U4/v
         tlA/u/YfiV6KVxHCOz0DY7PfYwjdjKtjExfmRnbM4eu+2FpsZaI9fuBYG+TVhvontlbg
         58I2dFKC5Ktxxwc9e4wMf274WaKbsuH+r2dmAAKL8TOfJJ6Eer+RKfj0AtOFY/GmQ43k
         HEaQLuM+E789yHD+T00sAYf+mF1xr4z06CTVVPRYeRAIu/HCGitYvOMcos50A/nshTYA
         A4qK3qFmKKv7Jl3qYsZlyo4HdYvCk0P4rdySdJKRaYrlJ0R882EVFOF0F5lc9H7F8+8B
         rcrQ==
X-Gm-Message-State: AOAM531lmaB1n73KpS7OW+xETWQK09jyFwt4wrwjSAPlHai4shbmQa/5
        iqaW4U4o1JvY0cE4HrAy+MgAEuqv5L0QX2AqpvZwZ3zuPVPk5xBDfE+uAb6MzBPocgH3xGID8bY
        F8G/+4Tit5uxAN1WTaWGq1SywInWthY0MRguNm3CNyTaspaD3FPTKbcFJHCx5vBC3O/6hTA==
X-Google-Smtp-Source: ABdhPJxr/GvkFCYLQqvtdJqyR+cAjzBSQVwxHqBpvFxx1Zl5wUtYShVzOhZeH8qLlxoAlRU2gSSkU2ermug=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461471pjb.0.1646977956785; Thu, 10 Mar
 2022 21:52:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:05 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-55-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 054/105] KVM: selftests: Convert vmx_exception_with_invalid_guest_state
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
 .../vmx_exception_with_invalid_guest_state.c  | 62 +++++++++++--------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 27a850f3d7ce..70b30583e50d 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -10,10 +10,6 @@
 
 #include "kselftest.h"
 
-#define VCPU_ID	0
-
-static struct kvm_vm *vm;
-
 static void guest_ud_handler(struct ex_regs *regs)
 {
 	/* Loop on the ud2 until guest state is made invalid. */
@@ -24,11 +20,11 @@ static void guest_code(void)
 	asm volatile("ud2");
 }
 
-static void __run_vcpu_with_invalid_state(void)
+static void __run_vcpu_with_invalid_state(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vcpu->vm, vcpu->id);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
 		    "Expected KVM_EXIT_INTERNAL_ERROR, got %d (%s)\n",
@@ -38,15 +34,15 @@ static void __run_vcpu_with_invalid_state(void)
 		    run->emulation_failure.suberror);
 }
 
-static void run_vcpu_with_invalid_state(void)
+static void run_vcpu_with_invalid_state(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * Always run twice to verify KVM handles the case where _KVM_ queues
 	 * an exception with invalid state and then exits to userspace, i.e.
 	 * that KVM doesn't explode if userspace ignores the initial error.
 	 */
-	__run_vcpu_with_invalid_state();
-	__run_vcpu_with_invalid_state();
+	__run_vcpu_with_invalid_state(vcpu);
+	__run_vcpu_with_invalid_state(vcpu);
 }
 
 static void set_timer(void)
@@ -59,33 +55,43 @@ static void set_timer(void)
 	ASSERT_EQ(setitimer(ITIMER_REAL, &timer, NULL), 0);
 }
 
-static void set_or_clear_invalid_guest_state(bool set)
+static void set_or_clear_invalid_guest_state(struct kvm_vcpu *vcpu, bool set)
 {
 	static struct kvm_sregs sregs;
 
 	if (!sregs.cr0)
-		vcpu_sregs_get(vm, VCPU_ID, &sregs);
+		vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
 	sregs.tr.unusable = !!set;
-	vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	vcpu_sregs_set(vcpu->vm, vcpu->id, &sregs);
 }
 
-static void set_invalid_guest_state(void)
+static void set_invalid_guest_state(struct kvm_vcpu *vcpu)
 {
-	set_or_clear_invalid_guest_state(true);
+	set_or_clear_invalid_guest_state(vcpu, true);
 }
 
-static void clear_invalid_guest_state(void)
+static void clear_invalid_guest_state(struct kvm_vcpu *vcpu)
 {
-	set_or_clear_invalid_guest_state(false);
+	set_or_clear_invalid_guest_state(vcpu, false);
+}
+
+static struct kvm_vcpu *get_set_sigalrm_vcpu(struct kvm_vcpu *__vcpu)
+{
+	static struct kvm_vcpu *vcpu = NULL;
+
+	if (__vcpu)
+		vcpu = __vcpu;
+	return vcpu;
 }
 
 static void sigalrm_handler(int sig)
 {
+	struct kvm_vcpu *vcpu = get_set_sigalrm_vcpu(NULL);
 	struct kvm_vcpu_events events;
 
 	TEST_ASSERT(sig == SIGALRM, "Unexpected signal = %d", sig);
 
-	vcpu_events_get(vm, VCPU_ID, &events);
+	vcpu_events_get(vcpu->vm, vcpu->id, &events);
 
 	/*
 	 * If an exception is pending, attempt KVM_RUN with invalid guest,
@@ -93,8 +99,8 @@ static void sigalrm_handler(int sig)
 	 * between KVM queueing an exception and re-entering the guest.
 	 */
 	if (events.exception.pending) {
-		set_invalid_guest_state();
-		run_vcpu_with_invalid_state();
+		set_invalid_guest_state(vcpu);
+		run_vcpu_with_invalid_state(vcpu);
 	} else {
 		set_timer();
 	}
@@ -102,15 +108,19 @@ static void sigalrm_handler(int sig)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	if (!is_intel_cpu() || vm_is_unrestricted_guest(NULL)) {
 		print_skip("Must be run with kvm_intel.unrestricted_guest=0");
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, (void *)guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	get_set_sigalrm_vcpu(vcpu);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 
@@ -119,8 +129,8 @@ int main(int argc, char *argv[])
 	 * KVM_RUN should induce a TRIPLE_FAULT in L2 as KVM doesn't support
 	 * emulating invalid guest state for L2.
 	 */
-	set_invalid_guest_state();
-	run_vcpu_with_invalid_state();
+	set_invalid_guest_state(vcpu);
+	run_vcpu_with_invalid_state(vcpu);
 
 	/*
 	 * Verify KVM also handles the case where userspace gains control while
@@ -129,11 +139,11 @@ int main(int argc, char *argv[])
 	 * guest with invalid state when the handler interrupts KVM with an
 	 * exception pending.
 	 */
-	clear_invalid_guest_state();
+	clear_invalid_guest_state(vcpu);
 	TEST_ASSERT(signal(SIGALRM, sigalrm_handler) != SIG_ERR,
 		    "Failed to register SIGALRM handler, errno = %d (%s)",
 		    errno, strerror(errno));
 
 	set_timer();
-	run_vcpu_with_invalid_state();
+	run_vcpu_with_invalid_state(vcpu);
 }
-- 
2.35.1.723.g4982287a31-goog

