Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E74D5AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbiCKFz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346663AbiCKFxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE809ECB30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d13-20020a170902b70d00b0015317d9f08bso2687945pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2u0xd0WcowKvmISsLBh9KyoTA6pAMwWdV2GBKIgUrbo=;
        b=pOUYZZCshqTXfQrSZFVmAf4rn78F8RsYlHJfnxQVU5d4HBhCgopz1vDHEpnckZrw9K
         QrHZhYyPWszPCMVLfhDBy/y/ZAhY5Ru019vjD93misUktnORHOAKuuixJcrLzR32Ji5I
         rQ3XbbubzduLdJ9y/2kalTtFn8SdHT7d7/ektpze50TTr8gXkJ2Cefhdv7oAHPcgfOMs
         P7LsgZHMu7fsx+ZRJvMEJRolNie5YLfdXm6HbxayEHLcQli3Eb8XD734VkoKDZiNfKYc
         14qEJNSg2IRV5BYZb03ujSsEhDO2uKWjQcjvwv0vv1In1Qc+8g9Q5qVwLu0WvVMQ1DxU
         y+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2u0xd0WcowKvmISsLBh9KyoTA6pAMwWdV2GBKIgUrbo=;
        b=ycwaPVSZfexe+LN/8xgZjYQMjqmYp9xiFMwiXcOKJplL0OJijGAiVkWVRtN+ePHbom
         HKjn5jFozhXkZKPwfAeS4ZOHEO+H6mpNJ4aEUbilF2dtRHMrNGP03TMcN6muq/yF1cYe
         VzOvxTsNC/RxBbZ/oPxmFPd6EGvG8TwJAL5K6QeqzF0KGDEKnovAmRFhe1mlO65Hy5Hl
         1JzKKhktLVzPXOsfZ6Mm4/CUhLSf0AXXrTut+CUT+1cABu7MtAnxydmVDGdlYgnZFLai
         LkbEID9Ya5tEs9udc7n7Ucfz1CwQ/1S5ba2u9ZrbYtQS61ttA6mclFbOp7PkIVN3R7rJ
         1XVA==
X-Gm-Message-State: AOAM531uWU/mr2EG37An+uONR+GzveuhjGqFqWdzzsqjRn83qvjGClOR
        DKGOoQ+wZ+nYXpYYBaMNyqj1NBNtaveFAM7NeBjLXca9uVTwNInQV0qTM5WYWmfeueHqee0FWAD
        o0F+zhwUpYFjALy2JV07sc+h1Kq/j+QRm/FEPSuAYEiowhRen43qVu5q8+VdDcltX02ds4g==
X-Google-Smtp-Source: ABdhPJz9MPMo5uQwiaUROKw8oy+BpdG6vOyBaXXyEKbqec18KmT+bOo9I3kBBMWm0K4JR9tQfrPNsrVKew0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:2a95:0:b0:37c:46b0:2088 with SMTP id
 q143-20020a632a95000000b0037c46b02088mr7222162pgq.150.1646977923323; Thu, 10
 Mar 2022 21:52:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:45 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-35-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 034/105] KVM: selftests: Convert vmx_preemption_timer_test
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
 .../kvm/x86_64/vmx_preemption_timer_test.c    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index f5b4ae914131..168adc5b2272 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -22,7 +22,6 @@
 #include "processor.h"
 #include "vmx.h"
 
-#define VCPU_ID		5
 #define PREEMPTION_TIMER_VALUE			100000000ull
 #define PREEMPTION_TIMER_VALUE_THRESHOLD1	 80000000ull
 
@@ -159,6 +158,7 @@ int main(int argc, char *argv[])
 	struct kvm_regs regs1, regs2;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
+	struct kvm_vcpu *vcpu;
 	struct kvm_x86_state *state;
 	struct ucall uc;
 	int stage;
@@ -175,22 +175,22 @@ int main(int argc, char *argv[])
 	}
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
-	vcpu_regs_get(vm, VCPU_ID, &regs1);
+	vcpu_regs_get(vm, vcpu->id, &regs1);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
 
 	for (stage = 1;; stage++) {
-		_vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
@@ -232,22 +232,22 @@ int main(int argc, char *argv[])
 				stage, uc.args[4], uc.args[5]);
 		}
 
-		state = vcpu_save_state(vm, VCPU_ID);
+		state = vcpu_save_state(vm, vcpu->id);
 		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, VCPU_ID, &regs1);
+		vcpu_regs_get(vm, vcpu->id, &regs1);
 
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
-		kvm_vm_restart(vm);
-		vm_vcpu_add(vm, VCPU_ID);
-		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, VCPU_ID, state);
-		run = vcpu_state(vm, VCPU_ID);
+		vcpu = vm_recreate_with_one_vcpu(vm);
+
+		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
+		vcpu_load_state(vm, vcpu->id, state);
+		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
-		vcpu_regs_get(vm, VCPU_ID, &regs2);
+		vcpu_regs_get(vm, vcpu->id, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 			    (ulong) regs2.rdi, (ulong) regs2.rsi);
-- 
2.35.1.723.g4982287a31-goog

