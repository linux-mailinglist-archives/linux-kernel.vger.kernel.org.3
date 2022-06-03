Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087953C1EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiFCA4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbiFCAr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:47:28 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64B38195
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z11-20020a17090a468b00b001dc792e8660so3413920pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kvUs1ol0OvtNdzt/b17TZtfFYSzSfQ+X1tNIPk/V+/I=;
        b=Y2rk59j+DHWsGPdwoepLIqrYAZe0WO4F0ydN5ZvnGLrgGwmkqwmLZAOJ+NzyyLSklo
         1xMA2WEDwFIIflW0EVgqq+VYq2PSEpu0osImp3ZGUyNtzHJvwqRIo9eLrT/5TD/x4pgF
         hwOtISSloQ8w6Txyi1AZJpeuMBCvP+uZxryqf55gC0haM9CXi2OoM0J8rTrzG6Rl3kSr
         P6FhdOjFcDmrOO7x1YH2w6F3MOpPvepypkPuvEpBzuYA40uQ0aCvWCq0jv0rCayB6KgY
         GYmxDr5mDsbvoRy806W0/eqwKEjanWB9XhH6qXgAhmsCKOwoqlGaP3j5XKHhg1Fspkuv
         vE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kvUs1ol0OvtNdzt/b17TZtfFYSzSfQ+X1tNIPk/V+/I=;
        b=xIBei7ELObCSGpOBMezrWuaNx7fg+iTtmmDt2oAC5ff0Mgb0RdzgO5RFnrdmnqhkWS
         3p97LEQRYeBhRktRvGmSmPm22LT2gjt9YBsYsWy4kmCElBibqV4rkY3FvCgnromkrQH6
         qXeNWSHX32xSidgxJHusEzd3ryh5HAGmjGmhTQmLgp/yOpElsLOMlAkzd39bnTMy3Cai
         k2nQYzFAVx56kAyEK128mbBKixI85RtPqmVDKdsXs2M/MIjtTUOVPWZgxOggNIxvNGPi
         vwgLFJQlYWYOKI4U/w8mUZaRdXMTQfF7jqgLBMhd9ntIG0oYbgLSdHupbc8PtalleZ+A
         X3ug==
X-Gm-Message-State: AOAM530gA8Eqemn5Yj0mvF5jqfEL0SuG5GN22IycasaES2K6iu3yoDcz
        M4YLL93yVsUbXpgtmfftjG306YEumZg=
X-Google-Smtp-Source: ABdhPJxwCO1qzFB2I3HAQE0ihPaO72veeNOHEDZTjmoYznkJOcudgD0SNIvpWB4PWZGrpU6+EDNIaYHYbCM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4f4a:b0:1e3:49c9:aab0 with SMTP id
 pj10-20020a17090b4f4a00b001e349c9aab0mr16032411pjb.223.1654217203017; Thu, 02
 Jun 2022 17:46:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:50 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-104-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 103/144] KVM: selftests: Convert set_boot_cpu_id away from
 global VCPU_IDs
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

Rework set_boot_cpu_id to pass around 'struct kvm_vcpu' objects instead
of relying on global VCPU_IDs.  The test is still ugly, but that's
unavoidable since the point of the test is to verify that KVM correctly
assigns VCPU_ID==0 to be the BSP by default.  This is literally one of
two KVM selftests that legitimately needs to care about the exact vCPU
IDs of the vCPUs it creates.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    | 86 ++++++++-----------
 1 file changed, 36 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index e63709894030..b11f12888fad 100644
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
@@ -75,65 +70,56 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
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
-	uint64_t vcpu_pages = (DEFAULT_STACK_PGS) * 2;
-	uint64_t extra_pg_pages = vcpu_pages / PTES_PER_MIN_PAGE * N_VCPU;
+	uint64_t vcpu_pages = (DEFAULT_STACK_PGS) * nr_vcpus;
+	uint64_t extra_pg_pages = vcpu_pages / PTES_PER_MIN_PAGE * nr_vcpus;
 	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
+	struct kvm_vm *vm;
+	uint32_t i;
 
-	return vm_create(pages);
-}
+	vm = vm_create(pages);
 
-static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, bool bsp_code)
-{
-	if (bsp_code)
-		vm_vcpu_add(vm, vcpuid, guest_bsp_vcpu);
-	else
-		vm_vcpu_add(vm, vcpuid, guest_not_bsp_vcpu);
+	vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)(unsigned long)bsp_vcpu_id);
+
+	for (i = 0; i < nr_vcpus; i++)
+		vcpus[i] = vm_vcpu_add(vm, i, i == bsp_vcpu_id ? guest_bsp_vcpu :
+								 guest_not_bsp_vcpu);
+	return vm;
 }
 
-static void run_vm_bsp(uint32_t bsp_vcpu)
+static void run_vm_bsp(uint32_t bsp_vcpu_id)
 {
+	struct kvm_vcpu *vcpus[2];
 	struct kvm_vm *vm;
-	bool is_bsp_vcpu1 = bsp_vcpu == VCPU_ID1;
-
-	vm = create_vm();
-
-	if (is_bsp_vcpu1)
-		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
 
-	add_x86_vcpu(vm, VCPU_ID0, !is_bsp_vcpu1);
-	add_x86_vcpu(vm, VCPU_ID1, is_bsp_vcpu1);
+	vm = create_vm(ARRAY_SIZE(vcpus), bsp_vcpu_id, vcpus);
 
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
@@ -145,9 +131,9 @@ int main(int argc, char *argv[])
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
2.36.1.255.ge46751e96f-goog

