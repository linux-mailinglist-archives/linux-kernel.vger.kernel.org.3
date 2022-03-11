Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19924D5B03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbiCKF5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbiCKFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:47 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E7C66
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:34 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x205-20020a627cd6000000b004f6e1b97b45so4590019pfc.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=e0XSYsFnw1sKQYkuuRvbhEksoxu4hcJVSS0NA+QiSNk=;
        b=IlCA/LVGlypWW34yYUxnmARSZ6o3y157dD8URQlwXOwnlZ/OjeIdNw9xfGqiBDY1sj
         ouWngEMAQXPf+dLbN1v+pOckQgnF1t9hb99uYZHCVwOdrMSR7E6vfCf2lePKUNsi/12s
         rwA9puJE+dCbuBrFs7YZQlzXfOHcg7qsMM/uCX+6YpAdL6OiOIzOx4mVvaTuuGiAjP22
         Zpc5h6Zy01wd475CMocPOPeW/gWsVv53IaQE8tY8qChRxvCJCUcvZde/rlDXnN87toNi
         lkiC70X70sImfQ809R3+cznQgFf5+HI+qNhKcEqNLx8bMDLWbK5HQsTj2nKfLSuDYYe8
         89gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=e0XSYsFnw1sKQYkuuRvbhEksoxu4hcJVSS0NA+QiSNk=;
        b=e1JVsUpx0Fa+EsArpIYCCo8cO2KslEjJeTTs1mZPS47FN8NqBIc9ZYqz2vgrCf6ctJ
         KR2D+Tt4+a/dXNegAW/sgV9R1eDM5xjVOdYzLdtWDQEMHVB1XAQ2oRPyY2jhJaWeXLYM
         qdHRywRmJcDS73LfSlzEaSsaN/1M5jTtlFsK482bN7peLAreKKBjbE7GpyFhVCW6aATw
         rzNpOnTWhS4r2iVMcL6oJnzt+z283qOQK1hq+fL70ZnZigj8/Q8ee6o1h3el9N5Ye2a2
         tB3HkPiphur4p6Yg39GBvX9MK5ikYhT5zTJxx85SihrtUBhISjJ6vLA/4REtWSB9RJUX
         dI5g==
X-Gm-Message-State: AOAM530VB4S5I+olQlESs4bbv6MFJy8M4ir3mbK1NMTEGIQXdUWPcpAK
        N8C11LwsPedFncQFAFb5ms9od6/mXPymQV9L3dHGoT/BkQBd2Z3ivjF5ZBvp02RUqWxwbwj7ZZV
        /8sXJfSV7yn7R8+QAQ5lc4hE8dr/lH/jlEYjvwY0Ez+g0e8Fweklj75R3kApsFB7JXov8wg==
X-Google-Smtp-Source: ABdhPJwcnOysE1aEEi/3tYnwDeL2d3stWnhYb6nj9lfKtZKsFge3QHrjR0nl+XBrr4Ps9Mm1j4dppZ4AORA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:6903:b0:151:6781:9397 with SMTP id
 j3-20020a170902690300b0015167819397mr9059514plk.137.1646977953618; Thu, 10
 Mar 2022 21:52:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:03 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-53-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 052/105] KVM: selftests: Convert vmx_apic_access_test away
 from VCPU_ID
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
 .../kvm/x86_64/vmx_apic_access_test.c          | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index d438c4d3228a..10f9c86029e6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -28,11 +28,6 @@
 
 #include "kselftest.h"
 
-#define VCPU_ID		0
-
-/* The virtual machine object. */
-static struct kvm_vm *vm;
-
 static void l2_guest_code(void)
 {
 	/* Exit to L1 */
@@ -84,9 +79,12 @@ int main(int argc, char *argv[])
 	struct vmx_pages *vmx;
 	bool done = false;
 
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	nested_vmx_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	kvm_get_cpu_address_width(&paddr_width, &vaddr_width);
 	high_gpa = (1ul << paddr_width) - getpagesize();
@@ -97,13 +95,13 @@ int main(int argc, char *argv[])
 
 	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	prepare_virtualize_apic_accesses(vmx, vm);
-	vcpu_args_set(vm, VCPU_ID, 2, vmx_pages_gva, high_gpa);
+	vcpu_args_set(vm, vcpu->id, 2, vmx_pages_gva, high_gpa);
 
 	while (!done) {
-		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		if (apic_access_addr == high_gpa) {
 			TEST_ASSERT(run->exit_reason ==
 				    KVM_EXIT_INTERNAL_ERROR,
@@ -121,7 +119,7 @@ int main(int argc, char *argv[])
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
-- 
2.35.1.723.g4982287a31-goog

