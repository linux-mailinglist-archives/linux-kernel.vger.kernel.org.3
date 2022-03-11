Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8E4D5B58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbiCKGDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346751AbiCKFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:05 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F4FCB73
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:35 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u10-20020a63df0a000000b0037886b8707bso4197461pgg.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Z6V8RdmCSyTdblUoos+5ZwZ6zYh8wjDJReVbHcS70Jc=;
        b=KVStH9DBT9gdRdPXz9PoPrxXoSTwjAOirL63AgKrVXc3e6QpZ1xHOjat9qeMktGWkf
         QBMse04t6K63mWD3hyT7vI8wTakyKozjjggrRK9wAaLYg2fNWWM5VN1KszdHNWXLyOzZ
         scfjNnXhqztH6rPVS8nAwazxmYP32579aOoQWnDt9bbaSmHKYkxack/oRgWuZfk5vGgZ
         GidwQxVLoZIS5TGb3BuyQpOud3UBr5zr/KCpP/tVj3xE7h9SIQ4oymc/sbPqYFEZSERt
         558pa2Ii4RUjH0++PG/nnpS1PYS6YC4+zM92bsYhReTlP0F1qTk4NbrwTWfSgq7GZazL
         Qabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Z6V8RdmCSyTdblUoos+5ZwZ6zYh8wjDJReVbHcS70Jc=;
        b=mPzmBsEleEmFgN8kNWgbVu8AW7Fp3myY+SCUaiEx6oe5FvXe/IGgRD3NUFAIUkRlvD
         ayfXWz5300m6zkIxPJ1RBATGf+Jj0/CJMGcBpnAVXwWDP0IXutyGnzhpEczCCH0CORf8
         s5HdyE/+Qx+GL9Kf6ZHeba5J9PdUKmKS9lJ1NmuM+r+B1NPipVGFfrjd4bZ9HS4vmMMK
         GPebYboh6UHwukwlEOOweD7vS4wv/TiEDzYwcuwAwcTPFy0WzGug82Sw88yyfetdKcqp
         mwZIChtxREU+WX932r4YvBcWzcN5sP/9aGI5guwPr7S7JhTjZtjh6mJQBNl4w2lmMwfn
         McBw==
X-Gm-Message-State: AOAM533kkW1Khs0bGDN3wkIB9gnNEzp5tkUfrkaTEMEIKHtsuXC3Jqd6
        Nz0onFK+gXjNq8U9v9jzDhXihvcSAAsA261gFcmGuNsvdLlt49f85gt5f9rdQg6TzYck+hbKR0H
        cfWyBaFNyXF7z1zpX3n7I1Zpcgsqr2iyW5WleE3sxey6dGdALN2Lsq8ZmPDmBn2K2msC4nA==
X-Google-Smtp-Source: ABdhPJxe1h3t3KsJ0TFrw0i438CJY9gJvu6NuThT5ESkEgqPnrL2RnadG8/hff+/6eVkXQw2wOpnrGW7Ukk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:134c:b0:4f7:65a6:88b with SMTP id
 k12-20020a056a00134c00b004f765a6088bmr8395750pfu.79.1646978014574; Thu, 10
 Mar 2022 21:53:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:39 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-89-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 088/105] KVM: selftests: Convert vgic_init away from vm_create_default_with_vcpus()
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
 .../testing/selftests/kvm/aarch64/vgic_init.c | 79 ++++++++++++-------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index f8d41f12bdca..435c4b762335 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -49,19 +49,21 @@ static void guest_code(void)
 }
 
 /* we don't want to assert on run execution, hence that helper */
-static int run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+static int run_vcpu(struct kvm_vcpu *vcpu)
 {
-	ucall_init(vm, NULL);
+	ucall_init(vcpu->vm, NULL);
 
-	return __vcpu_run(vm, vcpuid) ? -errno : 0;
+	return __vcpu_run(vcpu->vm, vcpu->id) ? -errno : 0;
 }
 
-static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type, uint32_t nr_vcpus)
+static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type,
+					      uint32_t nr_vcpus,
+					      struct kvm_vcpu *vcpus[])
 {
 	struct vm_gic v;
 
 	v.gic_dev_type = gic_dev_type;
-	v.vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
+	v.vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
 	return v;
@@ -305,10 +307,11 @@ static void subtest_v3_redist_regions(struct vm_gic *v)
  */
 static void test_vgic_then_vcpus(uint32_t gic_dev_type)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct vm_gic v;
 	int ret, i;
 
-	v = vm_gic_create_with_vcpus(gic_dev_type, 1);
+	v = vm_gic_create_with_vcpus(gic_dev_type, 1, vcpus);
 
 	subtest_dist_rdist(&v);
 
@@ -316,7 +319,7 @@ static void test_vgic_then_vcpus(uint32_t gic_dev_type)
 	for (i = 1; i < NR_VCPUS; ++i)
 		vm_vcpu_add(v.vm, i, guest_code);
 
-	ret = run_vcpu(v.vm, 3);
+	ret = run_vcpu(vcpus[3]);
 	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
 
 	vm_gic_destroy(&v);
@@ -325,14 +328,15 @@ static void test_vgic_then_vcpus(uint32_t gic_dev_type)
 /* All the VCPUs are created before the VGIC KVM device gets initialized */
 static void test_vcpus_then_vgic(uint32_t gic_dev_type)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct vm_gic v;
 	int ret;
 
-	v = vm_gic_create_with_vcpus(gic_dev_type, NR_VCPUS);
+	v = vm_gic_create_with_vcpus(gic_dev_type, NR_VCPUS, vcpus);
 
 	subtest_dist_rdist(&v);
 
-	ret = run_vcpu(v.vm, 3);
+	ret = run_vcpu(vcpus[3]);
 	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
 
 	vm_gic_destroy(&v);
@@ -340,37 +344,38 @@ static void test_vcpus_then_vgic(uint32_t gic_dev_type)
 
 static void test_v3_new_redist_regions(void)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	void *dummy = NULL;
 	struct vm_gic v;
 	uint64_t addr;
 	int ret;
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
 	subtest_v3_redist_regions(&v);
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
 
-	ret = run_vcpu(v.vm, 3);
+	ret = run_vcpu(vcpus[3]);
 	TEST_ASSERT(ret == -ENXIO, "running without sufficient number of rdists");
 	vm_gic_destroy(&v);
 
 	/* step2 */
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
 	subtest_v3_redist_regions(&v);
 
 	addr = REDIST_REGION_ATTR_ADDR(1, 0x280000, 0, 2);
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 			    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr);
 
-	ret = run_vcpu(v.vm, 3);
+	ret = run_vcpu(vcpus[3]);
 	TEST_ASSERT(ret == -EBUSY, "running without vgic explicit init");
 
 	vm_gic_destroy(&v);
 
 	/* step 3 */
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
 	subtest_v3_redist_regions(&v);
 
 	ret = __kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
@@ -385,7 +390,7 @@ static void test_v3_new_redist_regions(void)
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
 
-	ret = run_vcpu(v.vm, 3);
+	ret = run_vcpu(vcpus[3]);
 	TEST_ASSERT(!ret, "vcpu run");
 
 	vm_gic_destroy(&v);
@@ -393,26 +398,27 @@ static void test_v3_new_redist_regions(void)
 
 static void test_v3_typer_accesses(void)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct vm_gic v;
 	uint64_t addr;
 	uint32_t val;
 	int ret, i;
 
-	v.vm = vm_create_default(0, 0, guest_code);
+	v.vm = vm_create_with_one_vcpu(&vcpus[0], guest_code);
 
 	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
-	vm_vcpu_add(v.vm, 3, guest_code);
+	vcpus[3] = vm_vcpu_add(v.vm, 3, guest_code);
 
 	ret = v3_redist_reg_get(v.gic_fd, 1, GICR_TYPER, &val);
 	TEST_ASSERT(ret && errno == EINVAL, "attempting to read GICR_TYPER of non created vcpu");
 
-	vm_vcpu_add(v.vm, 1, guest_code);
+	vcpus[1] = vm_vcpu_add(v.vm, 1, guest_code);
 
 	ret = v3_redist_reg_get(v.gic_fd, 1, GICR_TYPER, &val);
 	TEST_ASSERT(ret && errno == EBUSY, "read GICR_TYPER before GIC initialized");
 
-	vm_vcpu_add(v.vm, 2, guest_code);
+	vcpus[2] = vm_vcpu_add(v.vm, 2, guest_code);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
@@ -460,6 +466,21 @@ static void test_v3_typer_accesses(void)
 	vm_gic_destroy(&v);
 }
 
+static struct vm_gic vm_gic_v3_create_with_vcpuids(int nr_vcpus,
+						   uint32_t vcpuids[])
+{
+	struct vm_gic v;
+	int i;
+
+	v.vm = vm_create_with_vcpus(0, NULL, NULL);
+	for (i = 0; i < nr_vcpus; i++)
+		vm_vcpu_add(v.vm, vcpuids[i], guest_code);
+
+	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
+
+	return v;
+}
+
 /**
  * Test GICR_TYPER last bit with new redist regions
  * rdist regions #1 and #2 are contiguous
@@ -478,9 +499,7 @@ static void test_v3_last_bit_redist_regions(void)
 	uint32_t val;
 	int ret;
 
-	v.vm = vm_create_default_with_vcpus(6, 0, 0, guest_code, vcpuids);
-
-	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
+	v = vm_gic_v3_create_with_vcpuids(ARRAY_SIZE(vcpuids), vcpuids);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
@@ -527,9 +546,7 @@ static void test_v3_last_bit_single_rdist(void)
 	uint32_t val;
 	int ret;
 
-	v.vm = vm_create_default_with_vcpus(6, 0, 0, guest_code, vcpuids);
-
-	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
+	v = vm_gic_v3_create_with_vcpuids(ARRAY_SIZE(vcpuids), vcpuids);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
@@ -559,11 +576,12 @@ static void test_v3_last_bit_single_rdist(void)
 /* Uses the legacy REDIST region API. */
 static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct vm_gic v;
 	int ret, i;
 	uint64_t addr;
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, 1);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, 1, vcpus);
 
 	/* Set space for 3 redists, we have 1 vcpu, so this succeeds. */
 	addr = max_phys_size - (3 * 2 * 0x10000);
@@ -576,13 +594,13 @@ static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 
 	/* Add the rest of the VCPUs */
 	for (i = 1; i < NR_VCPUS; ++i)
-		vm_vcpu_add(v.vm, i, guest_code);
+		vcpus[i] = vm_vcpu_add(v.vm, i, guest_code);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
 
 	/* Attempt to run a vcpu without enough redist space. */
-	ret = run_vcpu(v.vm, 2);
+	ret = run_vcpu(vcpus[2]);
 	TEST_ASSERT(ret && errno == EINVAL,
 		"redist base+size above PA range detected on 1st vcpu run");
 
@@ -591,11 +609,12 @@ static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 
 static void test_v3_its_region(void)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct vm_gic v;
 	uint64_t addr;
 	int its_fd, ret;
 
-	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
+	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
 	its_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_ITS);
 
 	addr = 0x401000;
@@ -639,7 +658,7 @@ int test_kvm_device(uint32_t gic_dev_type)
 	uint32_t other;
 	int ret;
 
-	v.vm = vm_create_default_with_vcpus(NR_VCPUS, 0, 0, guest_code, NULL);
+	v.vm = vm_create_with_vcpus(NR_VCPUS, guest_code, NULL);
 
 	/* try to create a non existing KVM device */
 	ret = __kvm_test_create_device(v.vm, 0);
-- 
2.35.1.723.g4982287a31-goog

