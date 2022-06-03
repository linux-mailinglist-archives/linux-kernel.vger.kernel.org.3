Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43C53C1B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiFCA7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiFCAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:48:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431614029
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q13-20020a65624d000000b003fa74c57243so3043024pgv.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7dc3HqyuMGK8qgSKSCWDwfmMXDxJCIfPjLQ6e9F1Yb0=;
        b=Kvs4taKqu1HcXZQrqca/HDlZcB+YJeVXuK3EOiehfJjolnDXIevnTEH1gKf2TpnpDi
         JuYVuRC1/raBRF+l2SCecE7T3H+MAK9mursgAaOdoOQ6SD+1hx2JENgnWWaD21mAlDsm
         wCDsRaeayh8sDoZ/PSVbMKf2+E0lrJXldLKhguM8OK4iI+rg+B3d7ZS2vNKxELkg9QBs
         gfuCz6TkVKIq9lRut/ngIi1Fiollsx+iBRbBELhPZgBrXui89RaqxYKTyWTnHxlptBEW
         Pw/SNRL2hc6t26dVaLK0djPIiBr5ezKeDd4D2zXXeugTjdaztAfIywCwkmcesESBdJly
         PEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7dc3HqyuMGK8qgSKSCWDwfmMXDxJCIfPjLQ6e9F1Yb0=;
        b=H7NhN3zjxs+QhueS3fNHIqgjR2BTRlKLIqF135n4t34QUBSGyniOmM4gzvjeg39Ans
         PZl+clr6vt+AUtG/kCcx3ikz2Rgo92L8Uq+fF6g3tpV8pViSkzNIjY+crxfQktqSGn4y
         U8HeBVAhE3MvbGhEh9AtIj2X72MmptsF2fpvx6e7bZiq/sK4J3IHAaIUOKu7DjHp1t6K
         fVlJfXMitGCfdyQuzQLB8QY2zS4WE3ge001B29XHssMgjGM7EIpA8tEfXtmexFpVb56U
         n8nLQV65i15TDnWIQIUc1D7EIyin2v/nHCsV9Z9bNvPLHuQn776l1/KOZN0JbYC3rtjh
         tShQ==
X-Gm-Message-State: AOAM531m/neBLMXWCrAdXIUMxBYVg/NScLbcgHscdxhNlaflL2KfJRKb
        fJ+Ybpz5QH6VLuCmyspd6eNeEhPqcwY=
X-Google-Smtp-Source: ABdhPJywV0gg2xR/672RAW4+8iflCLTylEXrqgZp0xhE/I2h1ewOIinraL7eepbnVhx2NL7ktc8vNYiDxEs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec8a:b0:161:7ca5:ece7 with SMTP id
 x10-20020a170902ec8a00b001617ca5ece7mr7638022plg.141.1654217216571; Thu, 02
 Jun 2022 17:46:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:58 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-112-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 111/144] KVM: selftests: Convert vgic_init away from vm_create_default_with_vcpus()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a combination of vm_create(), vm_create_with_vcpus(), and
vm_vcpu_add() to convert vgic_init from vm_create_default_with_vcpus(),
and away from referncing vCPUs by ID.

Thus continues the march toward total annihilation of "default" helpers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/aarch64/vgic_init.c | 79 ++++++++++++-------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index f8d41f12bdca..f93e9fa6ecd4 100644
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
@@ -398,21 +403,22 @@ static void test_v3_typer_accesses(void)
 	uint32_t val;
 	int ret, i;
 
-	v.vm = vm_create_default(0, 0, guest_code);
+	v.vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
+	(void)vm_vcpu_add(v.vm, 0, guest_code);
 
 	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
-	vm_vcpu_add(v.vm, 3, guest_code);
+	(void)vm_vcpu_add(v.vm, 3, guest_code);
 
 	ret = v3_redist_reg_get(v.gic_fd, 1, GICR_TYPER, &val);
 	TEST_ASSERT(ret && errno == EINVAL, "attempting to read GICR_TYPER of non created vcpu");
 
-	vm_vcpu_add(v.vm, 1, guest_code);
+	(void)vm_vcpu_add(v.vm, 1, guest_code);
 
 	ret = v3_redist_reg_get(v.gic_fd, 1, GICR_TYPER, &val);
 	TEST_ASSERT(ret && errno == EBUSY, "read GICR_TYPER before GIC initialized");
 
-	vm_vcpu_add(v.vm, 2, guest_code);
+	(void)vm_vcpu_add(v.vm, 2, guest_code);
 
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
+	v.vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
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
2.36.1.255.ge46751e96f-goog

