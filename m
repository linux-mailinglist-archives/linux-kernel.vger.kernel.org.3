Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D54D5B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbiCKF6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346689AbiCKFx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C936CE8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:49 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 127-20020a620685000000b004f6eaf868easo4595604pfg.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=aIlast7SeDZbSse0VHs2W97AenslyGPrXfgogBD650o=;
        b=l5e1cJZ2A16f8VzkpHEyqFaLmuGTwxG7ksmG5c7EhA582nRuBR8RoX7SiewjgaB286
         oaA8DOphbSm2bsq8s3739uz5ywbwPOjjkfot+16aGJ2fkBGqVezVFOfcZLWOHk3TG8jF
         adzbkVQi1N1I0OuzQFtiYj6g+VwzSdRbqDKfeeIe16l/xFTzTDd4QtAfRsUeX9HwtqEN
         bXxLLfQI6cZ2vr0flQ6ZGGcNyXOjzDhf1++6KGLrzDrdwADDHZ4Kq2fnNHmH5tv+Hkn9
         Y1K851Fmki7jsE/0OVjezbG/vMXFFtPtQkA4Z8Dn7KU1aY07RmWb0Pq0s3QxPZA2y4By
         HVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=aIlast7SeDZbSse0VHs2W97AenslyGPrXfgogBD650o=;
        b=WIYuSYLGQIucb3q3NCNisACyvshVU4sQtp19kU97UGQw73p7i6ufvkToL7qKpD6orm
         Z9UGbHGNm5lk4RM+nfXNNnZH5ik/NJS+J2aVLSqU2az6ksyC5E6++huf/oFXvQoP2uc8
         y1QIo/j5L2JB7Qljg+igcXizVu246PiRRNrSaQipX8rWwQ3tYNQqYTfiF2yZVOZ8kEsh
         QzxKs1gqveqlbQ8OXoXH5c49HJIEmt+/ES5PBZHMMiW5otW6bmWiXebkL76UCRfVI2lr
         z7jbzC/65Zh5/YIa0bNr/XF2HU9RqVAGTwucHvyXbZENc7bJHi4r3Ha1yXoyy0/Hi1/C
         D2fg==
X-Gm-Message-State: AOAM53199ba3B9Nk2Dr0Ap4EhJRK5ue0/ZGdVqnXokWpAq7x2svN7tjE
        o0VN3Mdb0Z3C9UgGQNKehyzqm0vA6mG5Ud9B9LQ40kn6G+KizUuuDl9CO/cF4lek0F2P6A7noRN
        h5o4+cO05tN/uwJk0FblrRo1JM0g3HXyVEkTxRFHV4sYhQJJNjvDKWhvxyUHSLDDvDmiBdw==
X-Google-Smtp-Source: ABdhPJy8o0ETLg681mQJQCWaYBK9eIREsoErKcp3JUOp39fbKsF1ljnAK4pZR7aGlEseDYr8M7ARTZY9Dns=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:7a10:0:b0:4f6:9396:ddde with SMTP id
 v16-20020a627a10000000b004f69396dddemr8404463pfc.82.1646977968753; Thu, 10
 Mar 2022 21:52:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:12 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-62-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 061/105] KVM: selftests: Convert emulator_error_test away
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
 .../kvm/x86_64/emulator_error_test.c          | 65 ++++++++-----------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
index f070ff0224fa..77b302f653a8 100644
--- a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
+++ b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
@@ -11,7 +11,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-#define VCPU_ID	   1
 #define PAGE_SIZE  4096
 #define MAXPHYADDR 36
 
@@ -28,14 +27,6 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static void run_guest(struct kvm_vm *vm)
-{
-	int rc;
-
-	rc = _vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(rc == 0, "vcpu_run failed: %d\n", rc);
-}
-
 /*
  * Accessors to get R/M, REG, and Mod bits described in the SDM vol 2,
  * figure 2-2 "Table Interpretation of ModR/M Byte (C8H)".
@@ -57,9 +48,9 @@ static bool is_flds(uint8_t *insn_bytes, uint8_t insn_size)
 	       GET_RM(insn_bytes[1]) != 0x5;
 }
 
-static void process_exit_on_emulation_error(struct kvm_vm *vm)
+static void process_exit_on_emulation_error(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 	struct kvm_regs regs;
 	uint8_t *insn_bytes;
 	uint8_t insn_size;
@@ -93,50 +84,49 @@ static void process_exit_on_emulation_error(struct kvm_vm *vm)
 			 * contained an flds instruction that is 2-bytes in
 			 * length (ie: no prefix, no SIB, no displacement).
 			 */
-			vcpu_regs_get(vm, VCPU_ID, &regs);
+			vcpu_regs_get(vcpu->vm, vcpu->id, &regs);
 			regs.rip += 2;
-			vcpu_regs_set(vm, VCPU_ID, &regs);
+			vcpu_regs_set(vcpu->vm, vcpu->id, &regs);
 		}
 	}
 }
 
-static void do_guest_assert(struct kvm_vm *vm, struct ucall *uc)
+static void do_guest_assert(struct ucall *uc)
 {
 	TEST_FAIL("%s at %s:%ld", (const char *)uc->args[0], __FILE__,
 		  uc->args[1]);
 }
 
-static void check_for_guest_assert(struct kvm_vm *vm)
+static void check_for_guest_assert(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
 	struct ucall uc;
 
-	if (run->exit_reason == KVM_EXIT_IO &&
-	    get_ucall(vm, VCPU_ID, &uc) == UCALL_ABORT) {
-		do_guest_assert(vm, &uc);
+	if (vcpu->run->exit_reason == KVM_EXIT_IO &&
+	    get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_ABORT) {
+		do_guest_assert(&uc);
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
 	struct ucall uc;
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
@@ -144,14 +134,14 @@ static uint64_t process_ucall(struct kvm_vm *vm)
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 		break;
 	case UCALL_ABORT:
-		do_guest_assert(vm, &uc);
+		do_guest_assert(&uc);
 		break;
 	case UCALL_DONE:
-		process_ucall_done(vm);
+		process_ucall_done(vcpu);
 		break;
 	default:
 		TEST_ASSERT(false, "Unexpected ucall");
@@ -168,6 +158,7 @@ int main(int argc, char *argv[])
 	};
 	struct kvm_cpuid_entry2 *entry;
 	struct kvm_cpuid2 *cpuid;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	uint64_t gpa, pte;
 	uint64_t *hva;
@@ -176,20 +167,20 @@ int main(int argc, char *argv[])
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-
 	if (!kvm_check_cap(KVM_CAP_SMALLER_MAXPHYADDR)) {
 		printf("module parameter 'allow_smaller_maxphyaddr' is not set.  Skipping test.\n");
 		return 0;
 	}
 
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
 	cpuid = kvm_get_supported_cpuid();
 
 	entry = kvm_get_supported_cpuid_index(0x80000008, 0);
 	entry->eax = (entry->eax & 0xffffff00) | MAXPHYADDR;
 	set_cpuid(cpuid, entry);
 
-	vcpu_set_cpuid(vm, VCPU_ID, cpuid);
+	vcpu_set_cpuid(vm, vcpu->id, cpuid);
 
 	rc = kvm_check_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE);
 	TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable");
@@ -204,14 +195,14 @@ int main(int argc, char *argv[])
 	virt_map(vm, MEM_REGION_GVA, MEM_REGION_GPA, 1);
 	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
 	memset(hva, 0, PAGE_SIZE);
-	pte = vm_get_page_table_entry(vm, VCPU_ID, MEM_REGION_GVA);
-	vm_set_page_table_entry(vm, VCPU_ID, MEM_REGION_GVA, pte | (1ull << 36));
+	pte = vm_get_page_table_entry(vm, vcpu->id, MEM_REGION_GVA);
+	vm_set_page_table_entry(vm, vcpu->id, MEM_REGION_GVA, pte | (1ull << 36));
 
-	run_guest(vm);
-	process_exit_on_emulation_error(vm);
-	run_guest(vm);
+	vcpu_run(vm, vcpu->id);
+	process_exit_on_emulation_error(vcpu);
+	vcpu_run(vm, vcpu->id);
 
-	TEST_ASSERT(process_ucall(vm) == UCALL_DONE, "Expected UCALL_DONE");
+	TEST_ASSERT(process_ucall(vcpu) == UCALL_DONE, "Expected UCALL_DONE");
 
 	kvm_vm_free(vm);
 
-- 
2.35.1.723.g4982287a31-goog

