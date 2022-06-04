Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F4953D46C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347920AbiFDBV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349955AbiFDBVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:21:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272556744
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h11-20020a65638b000000b003fad8e1cc9bso4577517pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LPv7oBU6RNJoN5QvwpKNebafNcFCPuc5KjEJfxiNbCo=;
        b=lhVfUjEenKVM1DQzzVSzeGKdnF74DLtq6X3Sa8cHIyM65TtbEluU83ObJiYlxvM7qq
         yJzpjmB7EnFhU6Am63zXWI6170S9fzgrcmDg/Bg0yGhzykYl3BNrc9ZuQomdpFRPodo/
         9Y6ncjnES3taOQkA4kOrFxvya6YHK9IaJcoVVZiUp2/NuHCLqT0RDoOoVVV7wGwNxCvy
         pKL5uHzlVQyicjzqocPKxA736a4X6wRzI0bLuRSdFvsKV55vp46arzmCzUFPO66ifuPf
         vZmV9BGNPe9MC+oTbFZ8cJlwc9h0nD5iDamcAyA7112rlIJPLO+mSW7JTi92JjdW+73f
         +Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LPv7oBU6RNJoN5QvwpKNebafNcFCPuc5KjEJfxiNbCo=;
        b=bZT8AYz5pE8LE1pDQtOjs5zxpBU3y3NrdprVpEp+uIIE9cwIfqmbtX9vyCBNo0qqpa
         uRqAe9eMQz+QUfEhzlqPhl7MQyIzfExGm2GWbTl3uqE9s2UMU7xOIT36yWHiKQUFnYOy
         1oezOOsM/6w+xUTFJbTJJXmDZ4hPzQoBo76y9dZNrEIBpEQoFYOMtFBR1KNcs2V3TYQW
         3mKzVR4ejH6DduCTBawBdFsdtPcc2SbiGmyn8PPip4wDLXTWRJG+l/HetXZ0+vnb3GXz
         KEBP7R/ZTJDVX+ab0vkzTbbA1Ls9urQ3gY336P/FprrRt0mhjQGeikY1aKmdcwv8KTk4
         5Ahw==
X-Gm-Message-State: AOAM532wmbo4Wlh6CbWsgVxoENwxkascfRlschCyJ2STHfd5SfXvc+I/
        o7YO5Go2pM7cCL4TUQPTWo5dpkQxON4=
X-Google-Smtp-Source: ABdhPJyOrThN4h2bxAD3aYKHXCFrO9u67esXjrR5pW51yppYVXUUWF4zPPLGwPQw6Dn2mvoFK4DRAlkrUVw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2187:b0:50c:ef4d:ef3b with SMTP id
 h7-20020a056a00218700b0050cef4def3bmr12510879pfi.83.1654305669056; Fri, 03
 Jun 2022 18:21:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:21 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 05/42] KVM: selftests: Use kvm_cpu_has() for nested SVM checks
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Use kvm_cpu_has() to check for nested SVM support, and drop the helpers
now that their functionality is trivial to implement.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/svm_util.h |  2 --
 tools/testing/selftests/kvm/lib/x86_64/svm.c        | 13 -------------
 .../testing/selftests/kvm/x86_64/hyperv_svm_test.c  |  2 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c       |  2 +-
 tools/testing/selftests/kvm/x86_64/state_test.c     |  2 +-
 .../testing/selftests/kvm/x86_64/svm_int_ctl_test.c |  2 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c        |  2 +-
 .../testing/selftests/kvm/x86_64/svm_vmcall_test.c  |  2 +-
 8 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index 136ba6a5d027..f48806d26989 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -51,8 +51,6 @@ struct svm_test_data {
 struct svm_test_data *vcpu_alloc_svm(struct kvm_vm *vm, vm_vaddr_t *p_svm_gva);
 void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_rsp);
 void run_guest(struct vmcb *vmcb, uint64_t vmcb_gpa);
-bool nested_svm_supported(void);
-void nested_svm_check_supported(void);
 
 static inline bool cpu_has_svm(void)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/svm.c b/tools/testing/selftests/kvm/lib/x86_64/svm.c
index 37e9c0a923e0..6d445886e16c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/svm.c
@@ -164,19 +164,6 @@ void run_guest(struct vmcb *vmcb, uint64_t vmcb_gpa)
 		: "r15", "memory");
 }
 
-bool nested_svm_supported(void)
-{
-	struct kvm_cpuid_entry2 *entry =
-		kvm_get_supported_cpuid_entry(0x80000001);
-
-	return entry->ecx & CPUID_SVM;
-}
-
-void nested_svm_check_supported(void)
-{
-	TEST_REQUIRE(nested_svm_supported());
-}
-
 /*
  * Open SEV_DEV_PATH if available, otherwise exit the entire program.
  *
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index c5cd9835dbd6..ea507510a62f 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -127,7 +127,7 @@ int main(int argc, char *argv[])
 	struct ucall uc;
 	int stage;
 
-	TEST_REQUIRE(nested_svm_supported());
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index e89139ce68dd..6b8108bdcead 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -154,7 +154,7 @@ int main(int argc, char *argv[])
 	vcpu_set_msr(vcpu, MSR_IA32_SMBASE, SMRAM_GPA);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
-		if (nested_svm_supported())
+		if (kvm_cpu_has(X86_FEATURE_SVM))
 			vcpu_alloc_svm(vm, &nested_gva);
 		else if (nested_vmx_supported())
 			vcpu_alloc_vmx(vm, &nested_gva);
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index ea878c963065..fe110ce31106 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -170,7 +170,7 @@ int main(int argc, char *argv[])
 	vcpu_regs_get(vcpu, &regs1);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
-		if (nested_svm_supported())
+		if (kvm_cpu_has(X86_FEATURE_SVM))
 			vcpu_alloc_svm(vm, &nested_gva);
 		else if (nested_vmx_supported())
 			vcpu_alloc_vmx(vm, &nested_gva);
diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
index 9c68a47b69e1..dc32c347281a 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -90,7 +90,7 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	nested_svm_check_supported();
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index 051f70167074..3c21b997fe3a 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -200,7 +200,7 @@ int main(int argc, char *argv[])
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
-	nested_svm_check_supported();
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	cpuid = kvm_get_supported_cpuid_entry(0x8000000a);
 	TEST_ASSERT(cpuid->edx & CPUID_NRIPS,
diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
index e6d7191866a5..46ce1bda6599 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
@@ -39,7 +39,7 @@ int main(int argc, char *argv[])
 	vm_vaddr_t svm_gva;
 	struct kvm_vm *vm;
 
-	nested_svm_check_supported();
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
-- 
2.36.1.255.ge46751e96f-goog

