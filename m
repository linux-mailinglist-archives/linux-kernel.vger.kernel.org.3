Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE84D5AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbiCKF5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346592AbiCKFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ADDED94F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:44 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z13-20020a1709027e8d00b001518de7a06cso3996286pla.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=prrVE6x5Q8AN6EtWUnqTXgKIWeuTvNDjFFQx2X65E3I=;
        b=AB0KHeGTT/fqNVqIkBgbtB8FbX21kpJVaL8CXVGaiY93sMJjdHjcvzQvPmx4DMsLXr
         S49zFCXNbZpQJ7A4G020OIE10mz4vYA1bAq62/UgtGFVBAoy+4gbXbizvjnGxqnAWA1S
         /Fr78+qL07JH4A6bsOa66DFNyn6O1FekcEH//F6VSfwsNXoLWuiwUg30vgI8SwNI0Vov
         AeoFF/+vvlZh1c7bwv5UDFQ7xGUoxo7ojAzt0NJem72d2wnkSi3a7GkXhCsFXG5HFCoy
         mRZ2qwRJEgmmsyfu/OG3YOtCg6bqr1uQPtVmWowBhvHMQ9bARkT3Fu84fZ4rvMbG06hQ
         u/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=prrVE6x5Q8AN6EtWUnqTXgKIWeuTvNDjFFQx2X65E3I=;
        b=AZem8ZmjRGal/GKXCCL02UZ9EPhM0r+cHg0J26xrEzowNNNLhhCbhPPf54sISe6Gtu
         6/wV/RAAxrkbQPqa54hzwrEUHq0cSXNUdwP35Y9oltMAmQYlhpIWbFZZUoPNJmmEZG4t
         YTdPM1BXUEznQQecNB9on7K5xJpsCyYrwohmkf5ldjmEdVcbPET+s0IHYPxoZB6pSOcA
         60mWFyjJSxICAX0mDUOv961i3Uk+hNYD3OBeYuA8b+1luwxiRV/5TI4/EwusuCdq8jCA
         wk1kRbCMVZjjXniOEFPtHAA/8L0ape9bkv/hKZ8ChT3Bu9quB84bw0CCkzTdCoW9X64y
         oSxg==
X-Gm-Message-State: AOAM533ApR2nBxaC2Cn0JZahAyOviaQYw5mKUQlu3OZrLJUI6Up6NT90
        wpagxAmeqwa/z+J/UR+WaPcNdXxW1NII0OQ4O2Ccb3TkZHB4DQrhfGxVOy+OwEQ/imgc6nMrv7/
        1Cyjbh/GVhksdGRNTb4fae5NH+4YpSPwUGhrLumo6NaF32nakjxrXQU680ZbtgHuomotnrQ==
X-Google-Smtp-Source: ABdhPJyo9Jc8M5eLvDPKh+hpYxrQEdMCAVjiyaoxij+lz9YJl9+xTMBOSEMQgmtM2YvJsn7Lidtw17ppXl0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ced0:b0:151:a5fa:6b44 with SMTP id
 d16-20020a170902ced000b00151a5fa6b44mr8681190plg.31.1646977903985; Thu, 10
 Mar 2022 21:51:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:34 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-24-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 023/105] KVM: selftests: Rename KVM_HAS_DEVICE_ATTR
 helpers for consistency
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
 tools/testing/selftests/kvm/aarch64/vgic_init.c      | 12 +++++-------
 tools/testing/selftests/kvm/include/kvm_util_base.h  |  6 +++---
 tools/testing/selftests/kvm/lib/kvm_util.c           | 12 ++++++------
 .../selftests/kvm/system_counter_offset_test.c       |  2 +-
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 1015f6fc352c..223fef4c1f62 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -127,14 +127,12 @@ static void subtest_dist_rdist(struct vm_gic *v)
 						: gic_v2_dist_region;
 
 	/* Check existing group/attributes */
-	kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			      dist.attr);
+	kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, dist.attr);
 
-	kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			      rdist.attr);
+	kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, rdist.attr);
 
 	/* check non existing attribute */
-	ret = _kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, -1);
+	ret = __kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, -1);
 	TEST_ASSERT(ret && errno == ENXIO, "attribute not supported");
 
 	/* misaligned DIST and REDIST address settings */
@@ -176,7 +174,7 @@ static void subtest_dist_rdist(struct vm_gic *v)
 				 rdist.attr, &addr, true);
 	TEST_ASSERT(ret && errno == EEXIST, "GIC redist base set again");
 
-	ret = _kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+	ret = __kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 				     KVM_VGIC_V3_ADDR_TYPE_REDIST);
 	if (!ret) {
 		/* Attempt to mix legacy and new redistributor regions */
@@ -203,7 +201,7 @@ static void subtest_v3_redist_regions(struct vm_gic *v)
 	uint64_t addr, expected_addr;
 	int ret;
 
-	ret = kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+	ret = kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 				     KVM_VGIC_V3_ADDR_TYPE_REDIST);
 	TEST_ASSERT(!ret, "Multiple redist regions advertised");
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index df1202bacc04..97cdeeac4db6 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -477,8 +477,8 @@ void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
  */
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
 
-int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
-int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
+int __kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr);
+int kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr);
 int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type);
 int __kvm_create_device(struct kvm_vm *vm, uint64_t type);
 int kvm_create_device(struct kvm_vm *vm, uint64_t type);
@@ -489,7 +489,7 @@ int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 
-int _vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
+int __vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			  uint64_t attr);
 int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			 uint64_t attr);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e10894cc2bc1..f9547edb30ad 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1581,7 +1581,7 @@ void _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, const char *name, void *arg
  * Device Ioctl
  */
 
-int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
+int __kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr)
 {
 	struct kvm_device_attr attribute = {
 		.group = group,
@@ -1592,9 +1592,9 @@ int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
 	return ioctl(dev_fd, KVM_HAS_DEVICE_ATTR, &attribute);
 }
 
-int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
+int kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr)
 {
-	int ret = _kvm_device_check_attr(dev_fd, group, attr);
+	int ret = __kvm_has_device_attr(dev_fd, group, attr);
 
 	TEST_ASSERT(!ret, "KVM_HAS_DEVICE_ATTR failed, rc: %i errno: %i", ret, errno);
 	return ret;
@@ -1657,18 +1657,18 @@ int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 	return ret;
 }
 
-int _vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
+int __vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			  uint64_t attr)
 {
 	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
-	return _kvm_device_check_attr(vcpu->fd, group, attr);
+	return __kvm_has_device_attr(vcpu->fd, group, attr);
 }
 
 int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 				 uint64_t attr)
 {
-	int ret = _vcpu_has_device_attr(vm, vcpuid, group, attr);
+	int ret = __vcpu_has_device_attr(vm, vcpuid, group, attr);
 
 	TEST_ASSERT(!ret, "KVM_HAS_DEVICE_ATTR IOCTL failed, rc: %i errno: %i", ret, errno);
 	return ret;
diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
index b337bbbfa41f..2b10c53abf4f 100644
--- a/tools/testing/selftests/kvm/system_counter_offset_test.c
+++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
@@ -30,7 +30,7 @@ static struct test_case test_cases[] = {
 
 static void check_preconditions(struct kvm_vm *vm)
 {
-	if (!_vcpu_has_device_attr(vm, VCPU_ID, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET))
+	if (!__vcpu_has_device_attr(vm, VCPU_ID, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET))
 		return;
 
 	print_skip("KVM_VCPU_TSC_OFFSET not supported; skipping test");
-- 
2.35.1.723.g4982287a31-goog

