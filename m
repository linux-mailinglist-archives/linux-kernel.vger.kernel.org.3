Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A834D5B09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbiCKF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346685AbiCKFx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:56 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0201F24BD0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:47 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id bh9-20020a056a02020900b0036c0d29eb3eso4229250pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nUHZ1KA1ftEOMfEbikAYeJFQo8bEj6QMYdpYS9qK0NM=;
        b=Z0Q964YhE/4eI7sjNOXnSy4JgpCGRK68K2SXng9Zxoy3avE7ySYJ1cxXMO7qLV4bi0
         6TzfoTkyHkqIbmxIeZep9oDChHausUCjOLLpaQI1hORgfxlOkGcXjFRFp7fCtX/YltoC
         SLSXT2pyx+zsii7/bubGymCHnZvTfjzsj2qEwNmM0FEhaFP2l2/ym+sX8hMFGXT/Dt/h
         yooCnKpvdllukAs4wELb4r5+KJMrtQi/Xcw7DCdzJCTYCU4U2W9BaON8fN6ghRjHduM8
         lIrt2qMPFHn5CvoF9y2CoV0hP2MnTZ27ez7PxZ4CES5ZUgyOShYdNQh+R2K7HCXwqh91
         gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nUHZ1KA1ftEOMfEbikAYeJFQo8bEj6QMYdpYS9qK0NM=;
        b=3hbbhkER7dEy5mj0vb1/amyBC2KYeH9ZhevoAWDZT3ZYhHiohFQ7tgOW0rkqIPdTCb
         GjdZ/ed+nsBjw3H/gp9aQFEJY+iW9SvY4m4zkoZAPuQ71F3m07bQmCm4v+dcajMW55ai
         25s1mwfeTDZLqmRpVzuvmHsLdVQNWKFPDHyFhHh9M2cBm4hSXTaVJyuHCBAOSMdXUGuI
         LYb8Mr99xgYa9VEmZ7QxR10s+8itPbFRLpwtelUisrdpDdWwED31UYBh3dBLAJO+5r/m
         f7tUxRsbNv7NtKdvdX6XA4g5OrpvAlJrAkDKVFrGZTrpQMUbib4rF0kKfxr1DShthOYY
         lKbA==
X-Gm-Message-State: AOAM533G6+w0lMNW61HItDg3jopUQY+NskS/xuJj7uw+XWTO4oOOvBPW
        svBbj3pZ+SZ6Vgm99FnJjNxBKYUvVkKU1BoyI7+3cZ9MCosl624E3+d1ghUvIa8I/0RRoSn0DmZ
        WCA6v1+YV8sj2/L8dS7mnRGXJrSzfP4ZbjHfOPYokbjmz/UXziQFs7AxD4jRHLEBM6Yn1GQ==
X-Google-Smtp-Source: ABdhPJz0fXDVhF/jmxD1s70qnp6Oy4ARUe3EyBDOzyQFlw1uQ90B6FVEG0XLJg/D5rvQPnIMW+1d0SaTWYY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461518pjb.0.1646977966903; Thu, 10 Mar
 2022 21:52:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:11 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-61-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 060/105] KVM: selftests: Convert evmcs_test away from VCPU_ID
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
 .../testing/selftests/kvm/x86_64/evmcs_test.c | 51 ++++++++++---------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index f97049ab045f..dc7c1eb28fd4 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -18,7 +18,6 @@
 
 #include "vmx.h"
 
-#define VCPU_ID		5
 #define NMI_VECTOR	2
 
 static int ud_count;
@@ -160,55 +159,56 @@ void guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-void inject_nmi(struct kvm_vm *vm)
+void inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_events events;
 
-	vcpu_events_get(vm, VCPU_ID, &events);
+	vcpu_events_get(vcpu->vm, vcpu->id, &events);
 
 	events.nmi.pending = 1;
 	events.flags |= KVM_VCPUEVENT_VALID_NMI_PENDING;
 
-	vcpu_events_set(vm, VCPU_ID, &events);
+	vcpu_events_set(vcpu->vm, vcpu->id, &events);
 }
 
-static void save_restore_vm(struct kvm_vm *vm)
+static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
+					struct kvm_vcpu *vcpu)
 {
 	struct kvm_regs regs1, regs2;
 	struct kvm_x86_state *state;
 
-	state = vcpu_save_state(vm, VCPU_ID);
+	state = vcpu_save_state(vm, vcpu->id);
 	memset(&regs1, 0, sizeof(regs1));
-	vcpu_regs_get(vm, VCPU_ID, &regs1);
+	vcpu_regs_get(vm, vcpu->id, &regs1);
 
 	kvm_vm_release(vm);
 
 	/* Restore state in a new VM.  */
-	kvm_vm_restart(vm);
-	vm_vcpu_add(vm, VCPU_ID);
-	vcpu_set_hv_cpuid(vm, VCPU_ID);
-	vcpu_enable_evmcs(vm, VCPU_ID);
-	vcpu_load_state(vm, VCPU_ID, state);
+	vcpu = vm_recreate_with_one_vcpu(vm);
+	vcpu_set_hv_cpuid(vm, vcpu->id);
+	vcpu_enable_evmcs(vm, vcpu->id);
+	vcpu_load_state(vm, vcpu->id, state);
 	kvm_x86_state_cleanup(state);
 
 	memset(&regs2, 0, sizeof(regs2));
-	vcpu_regs_get(vm, VCPU_ID, &regs2);
+	vcpu_regs_get(vm, vcpu->id, &regs2);
 	TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 		    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 		    (ulong) regs2.rdi, (ulong) regs2.rsi);
+	return vcpu;
 }
 
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva = 0;
 
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
 	int stage;
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	if (!nested_vmx_supported() ||
 	    !kvm_check_cap(KVM_CAP_NESTED_STATE) ||
@@ -217,28 +217,29 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vcpu_set_hv_cpuid(vm, VCPU_ID);
-	vcpu_enable_evmcs(vm, VCPU_ID);
+	vcpu_set_hv_cpuid(vm, vcpu->id);
+	vcpu_enable_evmcs(vm, vcpu->id);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	pr_info("Running L1 which uses EVMCS to run L2\n");
 
 	for (stage = 1;; stage++) {
-		run = vcpu_state(vm, VCPU_ID);
-		_vcpu_run(vm, VCPU_ID);
+		run = vcpu->run;
+
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
@@ -256,12 +257,12 @@ int main(int argc, char *argv[])
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
 			    stage, (ulong)uc.args[1]);
 
-		save_restore_vm(vm);
+		vcpu = save_restore_vm(vm, vcpu);
 
 		/* Force immediate L2->L1 exit before resuming */
 		if (stage == 8) {
 			pr_info("Injecting NMI into L1 before L2 had a chance to run after restore\n");
-			inject_nmi(vm);
+			inject_nmi(vcpu);
 		}
 
 		/*
@@ -271,7 +272,7 @@ int main(int argc, char *argv[])
 		 */
 		if (stage == 9) {
 			pr_info("Trying extra KVM_GET_NESTED_STATE/KVM_SET_NESTED_STATE cycle\n");
-			save_restore_vm(vm);
+			vcpu = save_restore_vm(vm, vcpu);
 		}
 	}
 
-- 
2.35.1.723.g4982287a31-goog

