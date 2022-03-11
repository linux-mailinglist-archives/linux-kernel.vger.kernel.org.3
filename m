Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE304D5AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbiCKF4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244465AbiCKFxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:19 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86575ECB28
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id t10-20020a17090a5d8a00b001bed9556134so7267449pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jXKfJEbRo4wgcpXR+nudnPrt2By/ukg4awgalUHtnrg=;
        b=bhWYddmf9OWMqOrfl7UD7PpBkwu9nCh+4kkkRvxNqaFwj7ccUqTLvNd6080ljVYYkP
         8V/f6uNYLp5EwkksvE5k7zeVjrbhmt2VzryqFQU6akcJ5fUVttQMOEiMRvr6xNVMGk7k
         zj/Lo3ehzfgCAylBsw8Z1fuQ/belomp2FcChByevUYiaZ5w3hBFg0rxX2mwLvOQiQF0u
         comAmm5xsonBb/Fz9F/2QRDdGW48ItwRAeqhORQtJIXyATbJP24GvLuq7CddeOEzSJQE
         EKlVZTAlFK9etSfx/L8HdDY7wYIk18Nm9LXIAVOBdGhy5HobyfLP/kFd/RLzvPFaH8mR
         +v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jXKfJEbRo4wgcpXR+nudnPrt2By/ukg4awgalUHtnrg=;
        b=2WNBr6sygdoFP1PArERwzyqGbTlx6t9AlecKLmlPWj1gmUasYCaObTLwvdJGQHm+lu
         uIZ3lKETakDlDg98sB1wK64/0UqqVqwEOkyODXa9+WlcZfiZa9lU0IdP+qNK71GtBN7n
         M7IKm0ocohOQpIHZR/SKKn8pl5++AvOm+WCH5OIB5R3WXdphegT47xWHw14l5krGszat
         fkdrxLZBbY+OJpKCsbWe/33W93bSqbKrT4SQ+QCLAkCiAk1B6SKJjZ4EaVPJSVzNbepz
         2y/WjHgVDyyWh8QlOyhDjwBcMuSdbadLAWtUDI4OfhdfQC9WiVM47xRlfKAYTYwbBgl1
         jLZA==
X-Gm-Message-State: AOAM532SJnHkIe7Yt+SKcYbgVrNLI+N+ruUWYHcWC7bnJxIJLNH9Oy3L
        +wI6a+T+EB22DwknF74nlIaSIfU4lNgRpi8Klgenmv/KD7Nv1qcS/4M8uydRRaVwiUrTytQAQy9
        OlHhEVewPvwWZGCcKAWac9aDij8nufdmUp1CjfgsXxQLk8mMBI+tkfMM156ApwZH2Tbb7Fw==
X-Google-Smtp-Source: ABdhPJwuo+Da6mL6saEdXjwnwLZBMSjMWdbMlTqygZ1zEQVREvbqR1KJ9h+YLNWDujFzTpg9uQV5T97L4sA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b906:b0:14f:76a0:ad48 with SMTP id
 bf6-20020a170902b90600b0014f76a0ad48mr8569396plb.79.1646977936875; Thu, 10
 Mar 2022 21:52:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:53 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-43-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 042/105] KVM: selftests: Convert svm_int_ctl_test away
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
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
index 30a81038df46..8e90e463895a 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -13,10 +13,6 @@
 #include "svm_util.h"
 #include "apic.h"
 
-#define VCPU_ID		0
-
-static struct kvm_vm *vm;
-
 bool vintr_irq_called;
 bool intr_irq_called;
 
@@ -88,31 +84,34 @@ static void l1_guest_code(struct svm_test_data *svm)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
 	vm_vaddr_t svm_gva;
+	struct kvm_vm *vm;
+	struct ucall uc;
 
 	nested_svm_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
 	vm_install_exception_handler(vm, VINTR_IRQ_NUMBER, vintr_irq_handler);
 	vm_install_exception_handler(vm, INTR_IRQ_NUMBER, intr_irq_handler);
 
 	vcpu_alloc_svm(vm, &svm_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, svm_gva);
+	vcpu_args_set(vm, vcpu->id, 1, svm_gva);
 
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
-	struct ucall uc;
+	run = vcpu->run;
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	switch (get_ucall(vm, vcpu->id, &uc)) {
 	case UCALL_ABORT:
 		TEST_FAIL("%s", (const char *)uc.args[0]);
 		break;
-- 
2.35.1.723.g4982287a31-goog

