Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA64D5ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbiCKFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346614AbiCKFwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:44 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C2FCB58
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:39 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j5-20020a63e745000000b00378c359fac3so4232690pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=WmfQbrzgNF+V3yMmoSkqjh6GRSot3cwrASCe7AJKUjc=;
        b=NZCsyXWiAU5FsQpC8rhMNOvPGhWGKQi+iTqZ67BnV3QZ5hUL8WlbtKz+nVA/uud3FD
         utNisnnoIPiKpmzTNVJv1HFOrzm6JydI18mNquajPh/iYIRTcpjTqBK3WLNCd3ynES2P
         QUmfNC5sYaMW/dPiisFvIuMhE17MMK+DPiZJH5O8iUQeHVy0lg5SGQwwzhx1DRzwoG8X
         zwTNNQt3jF4beIEG5erX70eQs68ovhCUMKqSx57eTa9lmYKDnnapIEcJ6zS6mWEBuJPa
         d3+Q688LbuTlxgTxil7Jf/3TaPiCjHnJZ+zHJt83dbHc/wSevq/QT/QClw19URMsnMQ6
         CoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=WmfQbrzgNF+V3yMmoSkqjh6GRSot3cwrASCe7AJKUjc=;
        b=Xxb7BlTKE5D8o5c9oAzUkpwsQJc8Q/1bprEs+ZTSRL6OP7bOgecslsuUGjXri1Wq9n
         +rLqsQSTjJLBeC31nsXvvTlupszBJyYvF5g6yi+ZKEC5i8Ynyph/PoCn3c0xAxkLIsnR
         +0gdv645RyudVOSYUOJbUd2SIEo2nNs2KpA6Dn+xsNFWp6m7ZpvKMycNG3Rw3AXP0r6t
         zZPv2JAE1sCg+G85Y0ok3UMf1QVZ+oQw8blPFLmB2FJwQecHn9R0ZqVQuu3moXHPNQSr
         qgW+oKlVe+qwiOjz8BWsoJLsnD/zjlI2peENZRN7zxa7idwlCcJfswy1AmhxjrUszqGq
         8e1Q==
X-Gm-Message-State: AOAM5319+4eYbuI5MphZDYZLXLQmWpgO75C4580buJwQLTFly/17sl9q
        /HLEVFfNJ3RJyW7cmhupoYq0uQ4y6JDoPptHivqRSaXL20uF6IlvOwf7u2K/K0fxkosA4akmZCG
        dN3YJAMxCSm6mxoyxCxtpROtqOLplszVnXV3taaB2VqN7lblEwdEzybze7PxJHRVoLRNIQw==
X-Google-Smtp-Source: ABdhPJyQ2scgZUvwiMTgKI72v5D5CcVYmN0damF6aLUUFqcL6qzDKGXFyxdI4RJFXwGh5+qI9hTXVZJKll0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460444pjb.1.1646977898870; Thu, 10 Mar
 2022 21:51:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:31 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-21-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 020/105] KVM: selftests: Drop @test param from kvm_create_device()
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
 tools/testing/selftests/kvm/aarch64/vgic_init.c    | 14 ++++++--------
 .../testing/selftests/kvm/include/kvm_util_base.h  |  2 +-
 tools/testing/selftests/kvm/lib/aarch64/vgic.c     |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 12 ++++--------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 9a153b2ea3de..9cd58f22f5bd 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -65,7 +65,7 @@ static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type, uint32_t nr
 
 	v.gic_dev_type = gic_dev_type;
 	v.vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
-	v.gic_fd = kvm_create_device(v.vm, gic_dev_type, false);
+	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
 	return v;
 }
@@ -406,7 +406,7 @@ static void test_v3_typer_accesses(void)
 
 	v.vm = vm_create_default(0, 0, guest_code);
 
-	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
 	vm_vcpu_add_default(v.vm, 3, guest_code);
 
@@ -486,7 +486,7 @@ static void test_v3_last_bit_redist_regions(void)
 
 	v.vm = vm_create_default_with_vcpus(6, 0, 0, guest_code, vcpuids);
 
-	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
@@ -535,7 +535,7 @@ static void test_v3_last_bit_single_rdist(void)
 
 	v.vm = vm_create_default_with_vcpus(6, 0, 0, guest_code, vcpuids);
 
-	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
@@ -602,7 +602,7 @@ static void test_v3_its_region(void)
 	int its_fd, ret;
 
 	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
-	its_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_ITS, false);
+	its_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_ITS);
 
 	addr = 0x401000;
 	ret = _kvm_device_access(its_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
@@ -655,13 +655,11 @@ int test_kvm_device(uint32_t gic_dev_type)
 	ret = _kvm_create_device(v.vm, gic_dev_type, true, &fd);
 	if (ret)
 		return ret;
-	v.gic_fd = kvm_create_device(v.vm, gic_dev_type, false);
+	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
 	ret = _kvm_create_device(v.vm, gic_dev_type, false, &fd);
 	TEST_ASSERT(ret && errno == EEXIST, "create GIC device twice");
 
-	kvm_create_device(v.vm, gic_dev_type, true);
-
 	/* try to create the other gic_dev_type */
 	other = VGIC_DEV_IS_V2(gic_dev_type) ? KVM_DEV_TYPE_ARM_VGIC_V3
 					     : KVM_DEV_TYPE_ARM_VGIC_V2;
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index d2550c6e82c1..03575063ee13 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -480,7 +480,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
 int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd);
-int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test);
+int kvm_create_device(struct kvm_vm *vm, uint64_t type);
 int _kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 		       void *val, bool write);
 int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index a169e662d6ae..f0ef9530fefe 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -51,7 +51,7 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
 			nr_vcpus, nr_vcpus_created);
 
 	/* Distributor setup */
-	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
 	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
 			0, &nr_irqs, true);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c6fee457735b..bfa7174a7892 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1613,18 +1613,14 @@ int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd)
 	return ret;
 }
 
-int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test)
+int kvm_create_device(struct kvm_vm *vm, uint64_t type)
 {
 	int fd, ret;
 
-	ret = _kvm_create_device(vm, type, test, &fd);
+	ret = _kvm_create_device(vm, type, false, &fd);
 
-	if (!test) {
-		TEST_ASSERT(!ret,
-			    "KVM_CREATE_DEVICE IOCTL failed, rc: %i errno: %i", ret, errno);
-		return fd;
-	}
-	return ret;
+	TEST_ASSERT(!ret, "KVM_CREATE_DEVICE IOCTL failed, rc: %i errno: %i", ret, errno);
+	return fd;
 }
 
 int _kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
-- 
2.35.1.723.g4982287a31-goog

