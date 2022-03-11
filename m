Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518BF4D5B19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiCKF7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiCKFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F674F9FA2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m22-20020a628c16000000b004f6f1b43114so4636906pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=uKYTBectaVm/Y0jJplfWszpZg0O+1WvZXscz8WnXDIM=;
        b=ZHbFKDCDY26RmxF2lrXLnuLUDaYy+NLYeDBlWkj5wnbwfO695LnXfvHGSXK8xXYfYw
         yYhIBIyiypbCoF0EhOqGka3/uW8QYRTnP0pGry77RHlsFGxukx35sQnvcUZ45UQvHSfT
         Cgwuqoyq19qnaItiQahN7UWBZQZAvECbeK3oZ/a6yiCriN3uUYEbHJybcnNdd92VDcA8
         f9lLwwETjCmNp/fQp1eC8d8aTTkRCI5XQZ0U/7vW/e658DO+R/mfyLXoIXsFeq+1pO7V
         KVmgfSAjVMeAaGnmGdisSqG+h45BCegK036SuOa4/U/rT0M7IJJSkBvXFAFLNtAisw4N
         ZFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=uKYTBectaVm/Y0jJplfWszpZg0O+1WvZXscz8WnXDIM=;
        b=xbx3Ql3mGscrEFdhdmnubdruvD6abpZEeTq/caPK7MlhNmm7KtS+CBf7iOC6TCASz3
         5UWUhmqIuppbZ/PUgixFaf7PgwAxWSzcNo5y6lrpSqLcmdINSHwlr67JHkrvB1mXaTnx
         rEVgSIylZZGz2TaxpdYj+nRJFrEJTX5j8d2+VIKLwWCO8nP36bWCWXNp3qfCsvyROIny
         fsODPubVTTGQ4Fa6dbtzWK3NSP3MLsI21f9CQtjb/ey6M9BRf+CMFFS9rm+naUWPitgg
         nliHQuZg3+N/R8Zgi9yYfR91orGl6KPrq9nX20Ko9DgzZDxmSNC4oWM08LgeCZtHgoOv
         2b4w==
X-Gm-Message-State: AOAM531uSy4qBhx0Q0pjc6D0gNX0mnyh/5k8jLd780E8QsqiCp9lxlfs
        dSlAGMayrLbFEdR6L3/F5cLmdzuO5zIPniLkyncW9Q8dQIwd/Untv+AAoD52jq2SL7DmLodK5+c
        VoIzF2trmZpQp/H+usir5PGx1MyeQ0zPsIDboGGuCfJM+mKF5bv7enoPmH2hjNivbRRTaqg==
X-Google-Smtp-Source: ABdhPJzip6Op8+MsNxuwfrUGKnTbwiwxz8v3Z1PXF9YqYQhW13p9DuT8Cjz1QTJ8eWLjNcJyi34AG5JduGY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:228f:b0:151:8379:9438 with SMTP id
 b15-20020a170903228f00b0015183799438mr8725123plh.51.1646978003298; Thu, 10
 Mar 2022 21:53:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:32 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-82-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 081/105] KVM: selftests: Convert set_boot_cpu_id away from VCPU_ID
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
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    | 85 ++++++++-----------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index b6a1dceb2be9..5b0c61127dd7 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -16,10 +16,6 @@
 #include "processor.h"
 #include "apic.h"
 
-#define N_VCPU 2
-#define VCPU_ID0 0
-#define VCPU_ID1 1
-
 static void guest_bsp_vcpu(void *arg)
 {
 	GUEST_SYNC(1);
@@ -38,31 +34,30 @@ static void guest_not_bsp_vcpu(void *arg)
 	GUEST_DONE();
 }
 
-static void test_set_boot_busy(struct kvm_vm *vm)
+static void test_set_bsp_busy(struct kvm_vcpu *vcpu, const char *msg)
 {
-	int res;
+	int r = __vm_ioctl(vcpu->vm, KVM_SET_BOOT_CPU_ID,
+			   (void *)(unsigned long)vcpu->id);
 
-	res = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID0);
-	TEST_ASSERT(res == -1 && errno == EBUSY,
-			"KVM_SET_BOOT_CPU_ID set while running vm");
+	TEST_ASSERT(r == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set %s", msg);
 }
 
-static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 	int stage;
 
 	for (stage = 0; stage < 2; stage++) {
 
-		vcpu_run(vm, vcpuid);
+		vcpu_run(vcpu->vm, vcpu->id);
 
-		switch (get_ucall(vm, vcpuid, &uc)) {
+		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 					uc.args[1] == stage + 1,
 					"Stage %d: Unexpected register values vmexit, got %lx",
 					stage + 1, (ulong)uc.args[1]);
-			test_set_boot_busy(vm);
+			test_set_bsp_busy(vcpu, "while running vm");
 			break;
 		case UCALL_DONE:
 			TEST_ASSERT(stage == 1,
@@ -75,17 +70,19 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
 						uc.args[1], uc.args[2], uc.args[3]);
 		default:
 			TEST_ASSERT(false, "Unexpected exit: %s",
-					exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+				    exit_reason_str(vcpu->run->exit_reason));
 		}
 	}
 }
 
-static struct kvm_vm *create_vm(void)
+static struct kvm_vm *create_vm(uint32_t nr_vcpus, uint32_t bsp_vcpu_id,
+				struct kvm_vcpu *vcpus[])
 {
-	struct kvm_vm *vm;
-	uint64_t vcpu_pages = (DEFAULT_STACK_PGS) * 2;
-	uint64_t extra_pg_pages = vcpu_pages / PTES_PER_MIN_PAGE * N_VCPU;
+	uint64_t vcpu_pages = (DEFAULT_STACK_PGS) * nr_vcpus;
+	uint64_t extra_pg_pages = vcpu_pages / PTES_PER_MIN_PAGE * nr_vcpus;
 	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
+	struct kvm_vm *vm;
+	uint32_t i;
 
 	pages = vm_adjust_num_guest_pages(VM_MODE_DEFAULT, pages);
 	vm = vm_create(pages);
@@ -93,54 +90,40 @@ static struct kvm_vm *create_vm(void)
 	kvm_vm_elf_load(vm, program_invocation_name);
 	vm_create_irqchip(vm);
 
+	vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)(unsigned long)bsp_vcpu_id);
+
+	for (i = 0; i < nr_vcpus; i++)
+		vcpus[i] = vm_vcpu_add(vm, i, i == bsp_vcpu_id ? guest_bsp_vcpu :
+								 guest_not_bsp_vcpu);
 	return vm;
 }
 
-static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, bool bsp_code)
-{
-	if (bsp_code)
-		vm_vcpu_add(vm, vcpuid, guest_bsp_vcpu);
-	else
-		vm_vcpu_add(vm, vcpuid, guest_not_bsp_vcpu);
-}
-
-static void run_vm_bsp(uint32_t bsp_vcpu)
+static void run_vm_bsp(uint32_t bsp_vcpu_id)
 {
+	struct kvm_vcpu *vcpus[2];
 	struct kvm_vm *vm;
-	bool is_bsp_vcpu1 = bsp_vcpu == VCPU_ID1;
 
-	vm = create_vm();
+	vm = create_vm(ARRAY_SIZE(vcpus), bsp_vcpu_id, vcpus);
 
-	if (is_bsp_vcpu1)
-		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
-
-	add_x86_vcpu(vm, VCPU_ID0, !is_bsp_vcpu1);
-	add_x86_vcpu(vm, VCPU_ID1, is_bsp_vcpu1);
-
-	run_vcpu(vm, VCPU_ID0);
-	run_vcpu(vm, VCPU_ID1);
+	run_vcpu(vcpus[0]);
+	run_vcpu(vcpus[1]);
 
 	kvm_vm_free(vm);
 }
 
 static void check_set_bsp_busy(void)
 {
+	struct kvm_vcpu *vcpus[2];
 	struct kvm_vm *vm;
-	int res;
 
-	vm = create_vm();
+	vm = create_vm(ARRAY_SIZE(vcpus), 0, vcpus);
 
-	add_x86_vcpu(vm, VCPU_ID0, true);
-	add_x86_vcpu(vm, VCPU_ID1, false);
+	test_set_bsp_busy(vcpus[1], "after adding vcpu");
 
-	res = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
-	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set after adding vcpu");
+	run_vcpu(vcpus[0]);
+	run_vcpu(vcpus[1]);
 
-	run_vcpu(vm, VCPU_ID0);
-	run_vcpu(vm, VCPU_ID1);
-
-	res = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
-	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set to a terminated vcpu");
+	test_set_bsp_busy(vcpus[1], "to a terminated vcpu");
 
 	kvm_vm_free(vm);
 }
@@ -152,9 +135,9 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
-	run_vm_bsp(VCPU_ID0);
-	run_vm_bsp(VCPU_ID1);
-	run_vm_bsp(VCPU_ID0);
+	run_vm_bsp(0);
+	run_vm_bsp(1);
+	run_vm_bsp(0);
 
 	check_set_bsp_busy();
 }
-- 
2.35.1.723.g4982287a31-goog

