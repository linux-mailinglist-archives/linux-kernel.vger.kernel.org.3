Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9540B51B366
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381767AbiEDXF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379755AbiEDW6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:58:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041B554A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:52:07 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y17-20020a637d11000000b003ab06870074so1336730pgc.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VZbSQxn2Y662dXnhVG6459Fi3EyZ+qYww5u80HyOjBM=;
        b=dp+Wp6i8czCgkdFPl78kNqUGdemM1A6AJjQsjR+yeelmf48ZFVj3+vTb6SbjJ5LRjl
         it4+ASF0h0xjNqMFcZcXr8Mh3Z8g5rMgxZZd9gHzN122qwUb2o55AeCewHDAAanjDeZI
         F6J7knN7SoocwGlZ4obZ7jfRrmWxxP3SvqkkLYpUWDINZY+dN7QwPntxxcvx6E0fChgU
         zKlUVK8nIuf2mJAUP4jULBbQEcuZQwbempVhXvVMUITNxy5RayC0bNXPWD001VCoj7Tx
         aOsnYEPqz31YuIkt5nIlmACbHNJHiVw98WK3vnz+//UlMUlFxdOkKa8Vi5TnK4EOVaKz
         Vtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VZbSQxn2Y662dXnhVG6459Fi3EyZ+qYww5u80HyOjBM=;
        b=DiTUvvVnLGSYbGK+8Pd1CHFlJjEh6Iz6OXSU8i7GgCBeUHlYmL2Y72sb6N2avdF2SQ
         xUO5+V/4SKh9w9SFVZGZI/oCNq5MT31jA65uIp02hzsvTNF72oBsBbz60N9L98ri8bT7
         QVoteGOsk1cA4joXWcMfygCIalPZ9u7n2H1oKYUj4rJlT21TtqDzkA3hCAgUBvlExMhM
         aFX3trHPTYC9va0TWzq4/qBu2l3KbvSa8OzJYHWvAFrUCF1oa7ljmLonZOjatB6L3w7i
         vKdA2h8TCZKd8Ns2hj7xmY1wa59TeKCzAc4jCOMeljknbksKekPPaYIgqFVsXNw4Oe2s
         ALQA==
X-Gm-Message-State: AOAM531nJIiq7YoU3QD+7mJVkV3/qkzXgZp12gTWHF7dhhrvRQguT/M/
        oHvddqQ+66QvLdjkNDCrCcvNylH6QdU=
X-Google-Smtp-Source: ABdhPJwCheLbiybAQZnIcuCqxToD3V+umI6qVXqe139wtjr3RzT9xI7BSNbtBVEFh0yKA0GtMdmNGL8OVgc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce02:b0:151:a86d:dc2b with SMTP id
 k2-20020a170902ce0200b00151a86ddc2bmr24295737plg.57.1651704722582; Wed, 04
 May 2022 15:52:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:34 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-89-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 088/128] KVM: selftests: Convert fix_hypercall_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert fix_hypercall_test to use vm_create_with_one_vcpu() and pass
around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 34 +++++++++----------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 1f5c32146f3d..565c4ab8dbb7 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -14,8 +14,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 static bool ud_expected;
 
 static void guest_ud_handler(struct ex_regs *regs)
@@ -94,22 +92,20 @@ static void guest_main(void)
 	GUEST_DONE();
 }
 
-static void setup_ud_vector(struct kvm_vm *vm)
+static void setup_ud_vector(struct kvm_vcpu *vcpu)
 {
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
-	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
+	vm_init_descriptor_tables(vcpu->vm);
+	vcpu_init_descriptor_tables(vcpu->vm, vcpu->id);
+	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
 }
 
-static void enter_guest(struct kvm_vm *vm)
+static void enter_guest(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run;
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	run = vcpu_state(vm, VCPU_ID);
-
-	vcpu_run(vm, VCPU_ID);
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	vcpu_run(vcpu->vm, vcpu->id);
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 		pr_info("%s: %016lx\n", (const char *)uc.args[2], uc.args[3]);
 		break;
@@ -125,26 +121,28 @@ static void enter_guest(struct kvm_vm *vm)
 
 static void test_fix_hypercall(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
-	setup_ud_vector(vm);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	setup_ud_vector(vcpu);
 
 	ud_expected = false;
 	sync_global_to_guest(vm, ud_expected);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
-	enter_guest(vm);
+	enter_guest(vcpu);
 }
 
 static void test_fix_hypercall_disabled(void)
 {
 	struct kvm_enable_cap cap = {0};
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
-	setup_ud_vector(vm);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	setup_ud_vector(vcpu);
 
 	cap.cap = KVM_CAP_DISABLE_QUIRKS2;
 	cap.args[0] = KVM_X86_QUIRK_FIX_HYPERCALL_INSN;
@@ -155,7 +153,7 @@ static void test_fix_hypercall_disabled(void)
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
-	enter_guest(vm);
+	enter_guest(vcpu);
 }
 
 int main(void)
-- 
2.36.0.464.gb9c8b46e94-goog

