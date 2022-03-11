Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F534D5AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiCKF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346699AbiCKFxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:16 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71359ECB30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id cl16-20020a17090af69000b001beea61ada4so4702178pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BXhZ32UeZA2N9sp+HsqAw39sp2L4IX0xoHyzHMKPW7w=;
        b=eibMyiMXeqZdSvzj+yxzBb0DhJhXftgt/wmm3arKwyi1tKVLXWQiohdisujNn++QKU
         Ct6XcnQP9iBSXd9HmifA04IbwykwbJyeMsRzSh5F6uZYgR/6NM2ESUncupMM9aCL3hz8
         k+D/qS/FrnAK+e+A0h5Lxz7ns0fEUhPQpTh6b0yvwTwHmpOysCwp8w2ifnYmQnX52XJu
         6XuxYzIxjBGeHnZpf6OIkuPa6bs4/KUJvJvzCZ/4KiIcmSpqYHC/D2IeuopnEY8vWMxe
         YDgqWJxys9RqhvjNAX2JT75k81C66NkAX2dVcww5jafV49DSVUJVAsjqvvoyLJUyeMGo
         VDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BXhZ32UeZA2N9sp+HsqAw39sp2L4IX0xoHyzHMKPW7w=;
        b=cuATIgCmea1cbvevIYPcu5nWvwp1E53DkEuaqnENg0zW5xwKxcsNj0mdVNYvCl+Ezw
         +N5veCx+kQPnkxhniASwID8ajixcsE0CC9pINzfsKJD3qBeY0XqG7L1Y4F2m5fuEX6jx
         Qcv1q6zn+07ixmrZ5IKEKSiWcxHxB3uO2E0MsjOTSDUPSudDSbXJI/x3Sbe6WO8EngWR
         v5MW3m7rhmH2uXBFc2jcp7WhEnDL2Bz/ibrfNxNFD1/3MYIILfpvJuC3YYWZQ7HwwWM3
         DTCM1SKSRCFMw9znn3AiDhaijqA47zJRaDXIcRH/QJQsR3dxNcOhaAsPATYVq1wsjVyR
         zEOQ==
X-Gm-Message-State: AOAM530i9PQykx7wh698IGm2t/GRjqeVyiMpjnZI7qxP0xiwmZrbEP7N
        uw9CKZTr2jaut2HpLskXY6RwbJmVSwrdNf8I9tBTUp1krkGh2hB+OuffSspDiYFdSFnGzQk+U1J
        CSq4zEM0HUiNjyjXg4bLmsD9NkX8LO8Tx6ur3BG3rf5nwyUhIkE1X6aPWWT84mfSqSP8Vlg==
X-Google-Smtp-Source: ABdhPJwzHwH0cO/li+QfVKcvwAUCDjzet/Mfy3LUSmTzawys+63ZWY7GdHWPDQ7t6jQtjDwGzWJoQqu8fMU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:c407:b0:152:fd74:8a5 with SMTP id
 k7-20020a170902c40700b00152fd7408a5mr8756864plk.1.1646977933779; Thu, 10 Mar
 2022 21:52:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:51 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-41-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 040/105] KVM: selftests: Convert smm_test away from VCPU_ID
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
 tools/testing/selftests/kvm/x86_64/smm_test.c | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 9757c45575ff..dfb2e92e8e12 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -19,8 +19,6 @@
 #include "vmx.h"
 #include "svm_util.h"
 
-#define VCPU_ID	      1
-
 #define PAGE_SIZE  4096
 
 #define SMRAM_SIZE 65536
@@ -118,22 +116,23 @@ static void guest_code(void *arg)
 	sync_with_host(DONE);
 }
 
-void inject_smi(struct kvm_vm *vm)
+void inject_smi(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_events events;
 
-	vcpu_events_get(vm, VCPU_ID, &events);
+	vcpu_events_get(vcpu->vm, vcpu->id, &events);
 
 	events.smi.pending = 1;
 	events.flags |= KVM_VCPUEVENT_VALID_SMM;
 
-	vcpu_events_set(vm, VCPU_ID, &events);
+	vcpu_events_set(vcpu->vm, vcpu->id, &events);
 }
 
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
+	struct kvm_vcpu *vcpu;
 	struct kvm_regs regs;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
@@ -141,9 +140,9 @@ int main(int argc, char *argv[])
 	int stage, stage_reported;
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	run = vcpu_state(vm, VCPU_ID);
+	run = vcpu->run;
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, SMRAM_GPA,
 				    SMRAM_MEMSLOT, SMRAM_PAGES, 0);
@@ -154,7 +153,7 @@ int main(int argc, char *argv[])
 	memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler,
 	       sizeof(smi_handler));
 
-	vcpu_set_msr(vm, VCPU_ID, MSR_IA32_SMBASE, SMRAM_GPA);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_SMBASE, SMRAM_GPA);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
 		if (nested_svm_supported())
@@ -166,17 +165,17 @@ int main(int argc, char *argv[])
 	if (!nested_gva)
 		pr_info("will skip SMM test with VMX enabled\n");
 
-	vcpu_args_set(vm, VCPU_ID, 1, nested_gva);
+	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
-		_vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
 		memset(&regs, 0, sizeof(regs));
-		vcpu_regs_get(vm, VCPU_ID, &regs);
+		vcpu_regs_get(vm, vcpu->id, &regs);
 
 		stage_reported = regs.rax & 0xff;
 
@@ -193,7 +192,7 @@ int main(int argc, char *argv[])
 		 * return from it. Do not perform save/restore while in SMM yet.
 		 */
 		if (stage == 8) {
-			inject_smi(vm);
+			inject_smi(vcpu);
 			continue;
 		}
 
@@ -202,15 +201,15 @@ int main(int argc, char *argv[])
 		 * during L2 execution.
 		 */
 		if (stage == 10)
-			inject_smi(vm);
+			inject_smi(vcpu);
 
-		state = vcpu_save_state(vm, VCPU_ID);
+		state = vcpu_save_state(vm, vcpu->id);
 		kvm_vm_release(vm);
-		kvm_vm_restart(vm);
-		vm_vcpu_add(vm, VCPU_ID);
-		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, VCPU_ID, state);
-		run = vcpu_state(vm, VCPU_ID);
+
+		vcpu = vm_recreate_with_one_vcpu(vm);
+		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
+		vcpu_load_state(vm, vcpu->id, state);
+		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 	}
 
-- 
2.35.1.723.g4982287a31-goog

