Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FFA53C27B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiFCA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiFCArt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:47:49 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E6E01B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j23-20020aa78017000000b005180c6e4ef2so3489678pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=FEBJwvYqAlLiF60mynTUCVgIxZLExe38puapSJIU/ak=;
        b=MVk93Q6ShQD0qflt2QebdYguqRkfX6WBmucALXpGpHxB4g6M7SyCeXjuKuTOgiPQvd
         8kBNQTISQM2bnmaByiLYHFV4tL2dQy26cWchlb9y9XWA81U+zeg3ravk+uYYC9/plqtz
         2BxgBWgVQqhPyQMJGW+gezpkO778FW+JDHAqd7LopEA976ZjyY6tKLKvztlHETihOy66
         ukaDWcy0XkDWMbLnNkw5NpMJhj8FobHAO7H9qBPXJQt0AuAvlMjr6ycFOhtXQUggHnPB
         BQ+ihUdnaP+ZMzJnip8ksgwQ0vX7mPZ8ulEumszSYFLKx19zkcKMC4UuL3rbnS1hfVqi
         UeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=FEBJwvYqAlLiF60mynTUCVgIxZLExe38puapSJIU/ak=;
        b=NcZQUu1ZVbglAxu7CGRkEqz7sW828vPF04L9IV+uc17oVaJAEDu35d5mwb4RXKDS4h
         mMW8WmHJa3WVavO8T+0z4eW9qf4ZoMDuDZeesVFa4YXfOhad5bCZFg0nONHcQ07Pg3IT
         2FCu3w/BukEoFIVEBdG/suJtBMuDEblK7lTT1BzEzHtWcxZia56c0sA7xxnGvF9791cE
         eXnz+a+7d2F55g7HWGMx0zfhGhqul4sFZohAOz/GvGgnhKTkmEKlZGvlAWymC/g2glSE
         76yK62sByqywNJGu88AwGGfLHhwd+7oVHetl/KxUJ8TAX1Wac8Tzeec1sK1BJYdufyEa
         KnUA==
X-Gm-Message-State: AOAM530jSJJBrFztGdrINU4YYCUVKsuecovy+1S/FAeJR9nq9uoQWfcP
        OlmmjxuQM5EISL1YVymQWo3naQ+fH2w=
X-Google-Smtp-Source: ABdhPJxZTZgawm1iBdLrP6Z23MXm7fqdEHBKVsNWTIBg6ycHTlJwtHvx4yH345FBYwv+IHlaQ9IjF7di02I=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1826:b0:518:4c8b:c5db with SMTP id
 y38-20020a056a00182600b005184c8bc5dbmr7793916pfa.22.1654217213473; Thu, 02
 Jun 2022 17:46:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:56 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-110-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 109/144] KVM: selftests: Convert svm_nested_soft_inject_test
 away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Convert svm_nested_soft_inject_test to use vm_create_with_one_vcpu() and
pull the vCPU's ID from 'struct kvm_vcpu'.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86_64/svm_nested_soft_inject_test.c     | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index f834b9a1a7fa..a337ab2ec101 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -18,7 +18,6 @@
 #include "svm_util.h"
 #include "test_util.h"
 
-#define VCPU_ID		0
 #define INT_NR			0x20
 #define X86_FEATURE_NRIPS	BIT(3)
 
@@ -135,6 +134,7 @@ static void l1_guest_code(struct svm_test_data *svm, uint64_t is_nmi, uint64_t i
 
 static void run_test(bool is_nmi)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	vm_vaddr_t svm_gva;
 	vm_vaddr_t idt_alt_vm;
@@ -142,10 +142,10 @@ static void run_test(bool is_nmi)
 
 	pr_info("Running %s test\n", is_nmi ? "NMI" : "soft int");
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 	vm_install_exception_handler(vm, BP_VECTOR, guest_bp_handler);
@@ -163,23 +163,23 @@ static void run_test(bool is_nmi)
 	} else {
 		idt_alt_vm = 0;
 	}
-	vcpu_args_set(vm, VCPU_ID, 3, svm_gva, (uint64_t)is_nmi, (uint64_t)idt_alt_vm);
+	vcpu_args_set(vm, vcpu->id, 3, svm_gva, (uint64_t)is_nmi, (uint64_t)idt_alt_vm);
 
 	memset(&debug, 0, sizeof(debug));
-	vcpu_guest_debug_set(vm, VCPU_ID, &debug);
+	vcpu_guest_debug_set(vm, vcpu->id, &debug);
 
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
 	alarm(2);
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 	alarm(0);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	switch (get_ucall(vm, vcpu->id, &uc)) {
 	case UCALL_ABORT:
 		TEST_FAIL("%s at %s:%ld, vals = 0x%lx 0x%lx 0x%lx", (const char *)uc.args[0],
 			  __FILE__, uc.args[1], uc.args[2], uc.args[3], uc.args[4]);
-- 
2.36.1.255.ge46751e96f-goog

