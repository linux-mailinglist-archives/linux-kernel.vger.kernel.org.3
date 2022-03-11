Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31874D5B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiCKGAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346704AbiCKFyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE4A9A5F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d14-20020a170902654e00b001518cc774d3so4020912pln.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ioX6wfUpsndkJitzTAba4Po2XVWDeKDX7eMlmBuk4/U=;
        b=hWaiXpifwkAbjvK2QfpoZjFDqWEDdchT0SsvW7lNrok4lVkY1JoVKus+/k90+iaUri
         JvM0qM9gcn99UuRPUxs1WegGGxw7+xTXbKfs1f1k1t0svyIUTW+sHkCFPf738XBP7K95
         9NTi+HAPXgsLY3rbU1drz5OPDIVjWv5Z6ex2kNZaFjt7I57KpGt4BKdqiJH9xIJdXwVk
         TU0tD1F7YzqvBRQpZ4K0j6lotXlqjbLf59gCsAqZ9qfE8EOSADkz9bIZnKqcQWi7o6vH
         JblyMRXPLNMSFBAR3YClvQ4FgNGqRgCmrjPBRHLGQ8t/QvPE3hGlTq9PRtDAtuapL1+V
         xJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ioX6wfUpsndkJitzTAba4Po2XVWDeKDX7eMlmBuk4/U=;
        b=53QeHmPAukrS8WcXXjgjXpRPjS4Cksm+iiZAybxAyPfTTDHlNc3WLiPR02bNA8Xcmu
         +1MUEYBKV02gcQ1tIdI+oOdNxkJO1ahACSkSiZYOClhGVU0x4BzzV5DF/CE5dVaXy/Sa
         N7FqeYSu3etUTbwRyOb9W4FxkVPruKqAFMYbo5ip3MQIcpssdG7TO4eljBWyGRVghGPE
         XnRdgVdQx+HLmmmPr1Is9fSrJSSfxQ3NaMFLPHMzfA3N4Z+zN5aoeveJexB6Q6JjzsI8
         wfnta7/kdx+9nbI/h5R21elgjctYZe2rIkOUBWmF3XhXChVPE2ub9YpMIBF5lz+8iT1R
         8KbQ==
X-Gm-Message-State: AOAM530mIil1vzw1dV1n8knvbxG+Uxph0W4634HOm7xWNOyEzukSYkTq
        8lidiY83SJjZZAd353qOck7W8RBXVNbMwqfI07zdXVTbuT0/gku9s+yX++e45Gd97fyW4naLxQt
        pegHWhLvfN5RrEcmdiHAmXdu1qMK/I6YzDBzaZa1Yb1fCaTGNC3BlD8ONIfYv1DLf+VdRrw==
X-Google-Smtp-Source: ABdhPJxPazRvto6tq3PYS/5Jcbouuu+cpUD0PwviXHFqAeZkuzTKYldRniByqYim1DnqqYfYXGLaRJeRMoc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d501:b0:1bf:381a:c851 with SMTP id
 t1-20020a17090ad50100b001bf381ac851mr19912416pju.124.1646978005095; Thu, 10
 Mar 2022 21:53:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:33 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-83-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 082/105] KVM: selftests: Convert psci_cpu_on_test away
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
 .../selftests/kvm/aarch64/psci_cpu_on_test.c  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
index 3677cb2df19c..226603597917 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
@@ -17,9 +17,6 @@
 #include "processor.h"
 #include "test_util.h"
 
-#define VCPU_ID_SOURCE 0
-#define VCPU_ID_TARGET 1
-
 #define CPU_ON_ENTRY_ADDR 0xfeedf00dul
 #define CPU_ON_CONTEXT_ID 0xdeadc0deul
 
@@ -72,6 +69,7 @@ static void guest_main(uint64_t target_cpu)
 int main(void)
 {
 	uint64_t target_mpidr, obs_pc, obs_x0;
+	struct kvm_vcpu *vcpu0, *vcpu1;
 	struct kvm_vcpu_init init;
 	struct kvm_vm *vm;
 	struct ucall uc;
@@ -83,19 +81,19 @@ int main(void)
 	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
 	init.features[0] |= (1 << KVM_ARM_VCPU_PSCI_0_2);
 
-	aarch64_vcpu_add(vm, VCPU_ID_SOURCE, &init, guest_main);
+	vcpu0 = aarch64_vcpu_add(vm, 0, &init, guest_main);
 
 	/*
 	 * make sure the target is already off when executing the test.
 	 */
 	init.features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
-	aarch64_vcpu_add(vm, VCPU_ID_TARGET, &init, guest_main);
+	vcpu1 = aarch64_vcpu_add(vm, 1, &init, guest_main);
 
-	get_reg(vm, VCPU_ID_TARGET, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &target_mpidr);
-	vcpu_args_set(vm, VCPU_ID_SOURCE, 1, target_mpidr & MPIDR_HWID_BITMASK);
-	vcpu_run(vm, VCPU_ID_SOURCE);
+	get_reg(vm, vcpu1->id, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &target_mpidr);
+	vcpu_args_set(vm, vcpu0->id, 1, target_mpidr & MPIDR_HWID_BITMASK);
+	vcpu_run(vm, vcpu0->id);
 
-	switch (get_ucall(vm, VCPU_ID_SOURCE, &uc)) {
+	switch (get_ucall(vm, vcpu0->id, &uc)) {
 	case UCALL_DONE:
 		break;
 	case UCALL_ABORT:
@@ -106,8 +104,8 @@ int main(void)
 		TEST_FAIL("Unhandled ucall: %lu", uc.cmd);
 	}
 
-	get_reg(vm, VCPU_ID_TARGET, ARM64_CORE_REG(regs.pc), &obs_pc);
-	get_reg(vm, VCPU_ID_TARGET, ARM64_CORE_REG(regs.regs[0]), &obs_x0);
+	get_reg(vm, vcpu1->id, ARM64_CORE_REG(regs.pc), &obs_pc);
+	get_reg(vm, vcpu1->id, ARM64_CORE_REG(regs.regs[0]), &obs_x0);
 
 	TEST_ASSERT(obs_pc == CPU_ON_ENTRY_ADDR,
 		    "unexpected target cpu pc: %lx (expected: %lx)",
-- 
2.35.1.723.g4982287a31-goog

