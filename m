Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728014D5AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbiCKFyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbiCKFwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C9FCB63
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:41 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mt1-20020a17090b230100b001beef010919so7268619pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZrVDE6mEcY5E3SWlXhRtIq5EGnZtg/5TxJ+2uaelnxs=;
        b=fwoMk9stqQumCkI+juM15MEBjcVi3SEB6oSKXwMIaPC50YCJdKIfRGwHfDd4nSDC6i
         uMBKYguPm0f+Q+Fx6h0XcOd5+G0o5o6osSWPXweh0KYrQk4pwNckfpBETQ0nlfrFal4y
         m53IYRIhx5jwNpMjJls8iYkaiCFzrD0Ov5lJxYe1m6tNaMcylrOfh856O6cm/7vRzk+B
         ZbhHIOm8V2scU3fhKHbSl7v1Zrjrg0mh755pbs0wLv1pwVDwm+zLXLM+3hZgwexd87JL
         nCOJ3kip0CYqY5iPv0/hj7AF9EjVkGrWrth99PkUqGz1EV3aVA+Gd2K2jlnL88dFzJ1j
         i54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZrVDE6mEcY5E3SWlXhRtIq5EGnZtg/5TxJ+2uaelnxs=;
        b=Ky5LtU1e0eDks4M+ri+oJnmO48An/1FD0bayL/n0CLtsipCj8sGq1IU6owjy96nBjr
         gkqbq/74QbVbMW3ao7VXGzjBf09o9ysX++slLp/43wHthY4V/lvKjwz8UaFRR8hqKxBt
         xTZiO43YulCio2sYAE8cq+C09fJ5n2pADPvm85ejecdwaULRI8WmMHtZxyVxwISU2AeU
         N2hcKrg6ILuvFGv4QNvOCAO5dOXLtDFMBgZaHa22Th5UXeYVJfIYwG/KGfTdgpNxJA00
         F4CTjIp8u+w/A5MIYSK8PK6bPhx8h8SFVwE5rFVOV0auYkvZycCkXe5Zp1/wR+VtF7rd
         X5OQ==
X-Gm-Message-State: AOAM533x2WCIyhtOp8w06lgiX15+DzrO4JIxgWcu2sh4jVpJQl5fNKyz
        IleFdpMejeq5bf/ZYSYuGpx5u+NNsKDNn3dVkVnEmwFPg32M8ZOcA2X9+3Au209Y9386h/lVG47
        36gjLqiq+inCNrTEGUaPoyqXNp6COBV4l3yAUTMaHu/ICCCqSq3E45n7Q5eMFi/UkWmDnEQ==
X-Google-Smtp-Source: ABdhPJwdIkxRqtj3kkMNwbeAXfiETEAI8TZ92ZvPp+I0aLcWl4ed0nE+VmzSt0+ed79k4Sziy7IRUJTh6c4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7883:b0:1bd:2372:c990 with SMTP id
 x3-20020a17090a788300b001bd2372c990mr19863533pjk.55.1646977900532; Thu, 10
 Mar 2022 21:51:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:32 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-22-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 021/105] KVM: selftests: Move KVM_CREATE_DEVICE_TEST code
 to separate helper
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
 .../testing/selftests/kvm/aarch64/vgic_init.c | 10 ++++----
 .../selftests/kvm/include/kvm_util_base.h     |  3 ++-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 ++++++++++++++-----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 9cd58f22f5bd..18d1d0335108 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -648,24 +648,24 @@ int test_kvm_device(uint32_t gic_dev_type)
 	v.vm = vm_create_default_with_vcpus(NR_VCPUS, 0, 0, guest_code, NULL);
 
 	/* try to create a non existing KVM device */
-	ret = _kvm_create_device(v.vm, 0, true, &fd);
+	ret = __kvm_test_create_device(v.vm, 0);
 	TEST_ASSERT(ret && errno == ENODEV, "unsupported device");
 
 	/* trial mode */
-	ret = _kvm_create_device(v.vm, gic_dev_type, true, &fd);
+	ret = __kvm_test_create_device(v.vm, gic_dev_type);
 	if (ret)
 		return ret;
 	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
-	ret = _kvm_create_device(v.vm, gic_dev_type, false, &fd);
+	ret = __kvm_create_device(v.vm, gic_dev_type, &fd);
 	TEST_ASSERT(ret && errno == EEXIST, "create GIC device twice");
 
 	/* try to create the other gic_dev_type */
 	other = VGIC_DEV_IS_V2(gic_dev_type) ? KVM_DEV_TYPE_ARM_VGIC_V3
 					     : KVM_DEV_TYPE_ARM_VGIC_V2;
 
-	if (!_kvm_create_device(v.vm, other, true, &fd)) {
-		ret = _kvm_create_device(v.vm, other, false, &fd);
+	if (!__kvm_test_create_device(v.vm, other)) {
+		ret = __kvm_test_create_device(v.vm, other);
 		TEST_ASSERT(ret && errno == EINVAL,
 				"create GIC device while other version exists");
 	}
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 03575063ee13..081ba04e5df3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -479,7 +479,8 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
 
 int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
-int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd);
+int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type);
+int __kvm_create_device(struct kvm_vm *vm, uint64_t type, int *fd);
 int kvm_create_device(struct kvm_vm *vm, uint64_t type);
 int _kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 		       void *val, bool write);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index bfa7174a7892..f0a08de67f0f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1600,14 +1600,25 @@ int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
 	return ret;
 }
 
-int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd)
+int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type)
 {
-	struct kvm_create_device create_dev;
+	struct kvm_create_device create_dev = {
+		.type = type,
+		.flags = KVM_CREATE_DEVICE_TEST,
+	};
+
+	return __vm_ioctl(vm, KVM_CREATE_DEVICE, &create_dev);
+}
+
+int __kvm_create_device(struct kvm_vm *vm, uint64_t type, int *fd)
+{
+	struct kvm_create_device create_dev = {
+		.type = type,
+		.fd = -1,
+		.flags = 0,
+	};
 	int ret;
 
-	create_dev.type = type;
-	create_dev.fd = -1;
-	create_dev.flags = test ? KVM_CREATE_DEVICE_TEST : 0;
 	ret = __vm_ioctl(vm, KVM_CREATE_DEVICE, &create_dev);
 	*fd = create_dev.fd;
 	return ret;
@@ -1617,7 +1628,7 @@ int kvm_create_device(struct kvm_vm *vm, uint64_t type)
 {
 	int fd, ret;
 
-	ret = _kvm_create_device(vm, type, false, &fd);
+	ret = __kvm_create_device(vm, type, &fd);
 
 	TEST_ASSERT(!ret, "KVM_CREATE_DEVICE IOCTL failed, rc: %i errno: %i", ret, errno);
 	return fd;
-- 
2.35.1.723.g4982287a31-goog

