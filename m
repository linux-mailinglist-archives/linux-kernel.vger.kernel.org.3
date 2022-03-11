Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3061C4D5AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbiCKFy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346560AbiCKFwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7643F11A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:42 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q21-20020a17090a2e1500b001c44f70fd38so338911pjd.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ObE4vFks/3TzFTIWtkMMXGOjctmkoD0LvkElMb+vMzk=;
        b=S1nS1658yfcQ53QosCnNh+vzGFFMhwmzYTFgLeCx2wARYRO2JnljUgQI+VcbSj4p1i
         BEyDre+/u31X7K3vWS1AAYZVrngXE3HnmSVWjusCa1teBUednQI0IgS3kIdCFHg5zXr1
         /55G67M6+vBvehyZYByAchQzjPvRJEE4r+iAp132F1coVPCsQ8CCesXU4VQCHIzlu4ec
         SX4IanV1jEtL5xrZi0+XRTKVEn42zJFsOjhDrSs5GJdgqhtwiwsKBSXZ+rPN7CjgwhGl
         AbWgWDOAe+7hXK/UzuRsXVjkLlmh5squCKWQacm4pyhQJFvFom535HHyuNr96wxcagDq
         UN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ObE4vFks/3TzFTIWtkMMXGOjctmkoD0LvkElMb+vMzk=;
        b=OfbAPeTTChmvLgA3fGQU3CGHTylEOC+yDc4e4eS5XdIToJns1awyptkUfoj2/sJ+Jx
         /9PyT8ydeQdIVYF8obRgcRvXNdAox6Aiy1DFVg6BAvkuLJ5qFL+5LPtSA4YkfagMskQr
         TwOHa7ChxfSyPSnQT6wE7zmMhgnw/eqFIlpI3hK90WxdZ9++ZPXfbBbe+2QN7kCnCNE4
         cMnBnODnQxEBz6n9jqtHK8WvOh0MEfZA8oeN3Ph6lKJ7UHrPSfypMk++0NftlRp7q3Bj
         sPmDF+sBTnxYIr1SxTcB5BkImVj27V1y6qwQNzy92jbwbM4Zyv7XBzbonJeOsOGCQmyi
         iwBA==
X-Gm-Message-State: AOAM532cZfR7SDm1R/tfvS8G6s/K+pjs2HGm+Uy7kpzATJhj375q48Vg
        RnjzT+nMKCPGxmvI1aaAtRvrHAA8u1VViv7V06GH4XmMINTVJIckMBdUwXpxyfQuJrbUvPR4R6j
        EG7B3Jki9tq9GeE498J6FY+q3FMtq0lxzqUglx859cvrIlr7Qbco/kqWgypMO8xM6VqL/vg==
X-Google-Smtp-Source: ABdhPJwgdUy/YJX0CA1VmDzsMYQJXRf9kV83UuZZXvbnfQlKNVpskQWtpae90LJ93LV7bkGYFYsuiuLPHdw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a8b:b0:4f7:595c:b900 with SMTP id
 e11-20020a056a001a8b00b004f7595cb900mr8627237pfv.62.1646977902211; Thu, 10
 Mar 2022 21:51:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:33 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-23-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 022/105] KVM: selftests: Multiplex return code and fd in __kvm_create_device()
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
 tools/testing/selftests/kvm/aarch64/vgic_init.c  |  6 +++---
 .../selftests/kvm/include/kvm_util_base.h        |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c       | 16 +++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 18d1d0335108..1015f6fc352c 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -642,8 +642,8 @@ static void test_v3_its_region(void)
 int test_kvm_device(uint32_t gic_dev_type)
 {
 	struct vm_gic v;
-	int ret, fd;
 	uint32_t other;
+	int ret;
 
 	v.vm = vm_create_default_with_vcpus(NR_VCPUS, 0, 0, guest_code, NULL);
 
@@ -657,8 +657,8 @@ int test_kvm_device(uint32_t gic_dev_type)
 		return ret;
 	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
-	ret = __kvm_create_device(v.vm, gic_dev_type, &fd);
-	TEST_ASSERT(ret && errno == EEXIST, "create GIC device twice");
+	ret = __kvm_create_device(v.vm, gic_dev_type);
+	TEST_ASSERT(ret < 0 && errno == EEXIST, "create GIC device twice");
 
 	/* try to create the other gic_dev_type */
 	other = VGIC_DEV_IS_V2(gic_dev_type) ? KVM_DEV_TYPE_ARM_VGIC_V3
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 081ba04e5df3..df1202bacc04 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -480,7 +480,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
 int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type);
-int __kvm_create_device(struct kvm_vm *vm, uint64_t type, int *fd);
+int __kvm_create_device(struct kvm_vm *vm, uint64_t type);
 int kvm_create_device(struct kvm_vm *vm, uint64_t type);
 int _kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 		       void *val, bool write);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f0a08de67f0f..e10894cc2bc1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1610,27 +1610,25 @@ int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type)
 	return __vm_ioctl(vm, KVM_CREATE_DEVICE, &create_dev);
 }
 
-int __kvm_create_device(struct kvm_vm *vm, uint64_t type, int *fd)
+int __kvm_create_device(struct kvm_vm *vm, uint64_t type)
 {
 	struct kvm_create_device create_dev = {
 		.type = type,
 		.fd = -1,
 		.flags = 0,
 	};
-	int ret;
+	int err;
 
-	ret = __vm_ioctl(vm, KVM_CREATE_DEVICE, &create_dev);
-	*fd = create_dev.fd;
-	return ret;
+	err = __vm_ioctl(vm, KVM_CREATE_DEVICE, &create_dev);
+	TEST_ASSERT(err <= 0, "KVM_CREATE_DEVICE shouldn't return a positive value");
+	return err ? : create_dev.fd;
 }
 
 int kvm_create_device(struct kvm_vm *vm, uint64_t type)
 {
-	int fd, ret;
+	int fd = __kvm_create_device(vm, type);
 
-	ret = __kvm_create_device(vm, type, &fd);
-
-	TEST_ASSERT(!ret, "KVM_CREATE_DEVICE IOCTL failed, rc: %i errno: %i", ret, errno);
+	TEST_ASSERT(fd >= 0, "KVM_CREATE_DEVICE IOCTL failed, rc: %i errno: %i", fd, errno);
 	return fd;
 }
 
-- 
2.35.1.723.g4982287a31-goog

