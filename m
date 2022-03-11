Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2754D5AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbiCKFzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbiCKFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE52F65FE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:46 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d81518795fso60976507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7H8ID3PArWSAJFJ6fYpFi7ULZbBg9B4ckFvVp1ij2d0=;
        b=HdpVEkn5gh7Y7pXFm/yfiLjrtEeWne7M5t+WTVmJB8OFpy4Bzgv/djJCldP+qjB8wR
         l0BsPv1hZviV6gcYyWD+Eb5yghuejzuUOMjMV3xKSnLH1oz77UaQvzu9bizjInbt7nxA
         o/+fYhWIdL/rg90ppDV8/oJiuvxOefrSBSzPom6t0ywcBzWitHtzm51lub8jpwXiWqEk
         5rHvjkaxjdXP8j7yp23LFNAhByKAXn5E27KXNT7P1mHFsLH3AWzUGYz1q6iJx5zVdV5l
         yqV8bDGYzgYwigFDTThI7s2N6uxKdJAK1B6v5IF0JS6985sH/wbLyQdijowHDTC5zoUF
         WGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7H8ID3PArWSAJFJ6fYpFi7ULZbBg9B4ckFvVp1ij2d0=;
        b=la2I0V5eT1jjfY7HrsAlY3PYA7YSwcsmYSiOsymilGhoUHAZX/ggxWLMFV3PijLz5W
         8vUicDlRhmykxsU1WKjxNrAlJSdCd9HTWj+hfdV/T8y345vABMoQItVA7yiB8IomCc+H
         NqZTFijZqPDyN0PKEQ7c4Wxr4CcLwy+7kquPA2f6O2ZMqcSADz9xGaAaGPmDV4y19i8w
         OnC/nQIKWEHBCwec8SUl53iw3M68A96l4kPYNnbwINDWEPELQJjRFWROHFGmQl8iA668
         FKbqJ3EPx5Ab7gAMm5dV3WETIOsZU8upQntXGEXZB/RbMwuWx2xeEA6wPAelDt/Nyjb/
         OyIA==
X-Gm-Message-State: AOAM532XVNblY2pe4ST5MrL1DWdcsSKjO8qruknTjpEGxAR2XQCHJwaa
        jXjz3yDeSZo7Mqt8+Kx5BthM1Ye0K038EOurRl4KQjSZ9BGuoD1UfM6tgZCWR9LPwBfEvxAeXTc
        NZo5RMBvTNkgrfjgT1NmdTDeVpt59iF8Llg7na3Olym3X8QdF4cGYtzIqalV/LpjNgZ/7Nw==
X-Google-Smtp-Source: ABdhPJwYQjKdg5iUSKA4CBJzxuMoPO6ZIaxgAnDNH18z9Dz9Yt0ZY9Nao1hESo1NsjmIUIKJs4TSgyjoNfU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a0d:ca16:0:b0:2dc:40af:d431 with SMTP id
 m22-20020a0dca16000000b002dc40afd431mr7014149ywd.206.1646977905744; Thu, 10
 Mar 2022 21:51:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:35 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-25-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 024/105] KVM: selftests: Drop 'int' return from asserting *_device_has_attr()
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
 .../testing/selftests/kvm/aarch64/vgic_init.c |  4 ++--
 .../selftests/kvm/include/kvm_util_base.h     | 20 ++++++++++++++++---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 17 ----------------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 223fef4c1f62..2425894b3775 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -201,8 +201,8 @@ static void subtest_v3_redist_regions(struct vm_gic *v)
 	uint64_t addr, expected_addr;
 	int ret;
 
-	ret = kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-				     KVM_VGIC_V3_ADDR_TYPE_REDIST);
+	ret = __kvm_has_device_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				    KVM_VGIC_V3_ADDR_TYPE_REDIST);
 	TEST_ASSERT(!ret, "Multiple redist regions advertised");
 
 	addr = REDIST_REGION_ATTR_ADDR(NR_VCPUS, 0x100000, 2, 0);
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 97cdeeac4db6..4cc2553887f7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -478,7 +478,14 @@ void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
 
 int __kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr);
-int kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr);
+
+static inline void kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr)
+{
+	int ret = __kvm_has_device_attr(dev_fd, group, attr);
+
+	TEST_ASSERT(!ret, "KVM_HAS_DEVICE_ATTR failed, rc: %i errno: %i", ret, errno);
+}
+
 int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type);
 int __kvm_create_device(struct kvm_vm *vm, uint64_t type);
 int kvm_create_device(struct kvm_vm *vm, uint64_t type);
@@ -491,8 +498,15 @@ int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 
 int __vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			  uint64_t attr);
-int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			 uint64_t attr);
+
+static inline void vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid,
+					uint32_t group, uint64_t attr)
+{
+	int ret = __vcpu_has_device_attr(vm, vcpuid, group, attr);
+
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_HAS_DEVICE_ATTR, ret));
+}
+
 int _vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			  uint64_t attr, void *val, bool write);
 int vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f9547edb30ad..e635241e3ee5 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1592,14 +1592,6 @@ int __kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr)
 	return ioctl(dev_fd, KVM_HAS_DEVICE_ATTR, &attribute);
 }
 
-int kvm_has_device_attr(int dev_fd, uint32_t group, uint64_t attr)
-{
-	int ret = __kvm_has_device_attr(dev_fd, group, attr);
-
-	TEST_ASSERT(!ret, "KVM_HAS_DEVICE_ATTR failed, rc: %i errno: %i", ret, errno);
-	return ret;
-}
-
 int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type)
 {
 	struct kvm_create_device create_dev = {
@@ -1665,15 +1657,6 @@ int __vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 	return __kvm_has_device_attr(vcpu->fd, group, attr);
 }
 
-int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-				 uint64_t attr)
-{
-	int ret = __vcpu_has_device_attr(vm, vcpuid, group, attr);
-
-	TEST_ASSERT(!ret, "KVM_HAS_DEVICE_ATTR IOCTL failed, rc: %i errno: %i", ret, errno);
-	return ret;
-}
-
 int _vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			     uint64_t attr, void *val, bool write)
 {
-- 
2.35.1.723.g4982287a31-goog

