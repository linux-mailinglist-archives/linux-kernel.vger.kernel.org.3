Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2110A58E47B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiHJB0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHJB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:26:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F815FADD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:26:09 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M2XJz3RDFzmVcn;
        Wed, 10 Aug 2022 09:24:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 09:26:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 10 Aug
 2022 09:26:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <suzuki.poulose@arm.com>,
        <oliver.upton@linux.dev>
Subject: [PATCH v3] KVM: arm64: fix compile error because of shift overflow
Date:   Wed, 10 Aug 2022 09:34:35 +0800
Message-ID: <20220810013435.1525363-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using GENMASK() to generate the masks of device type and device id, it makes
code unambiguous, also it can fix the following fix compile error because of
shift overflow when using low verison gcc(mine version is 7.5):

In function ‘kvm_vm_ioctl_set_device_addr.isra.38’,
    inlined from ‘kvm_arch_vm_ioctl’ at arch/arm64/kvm/arm.c:1454:10:
././include/linux/compiler_types.h:354:38: error: call to ‘__compiletime_assert_599’ \
declared with attribute error: FIELD_GET: mask is not constant
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Fixes: 9f968c9266aa ("KVM: arm64: vgic-v2: Add helper for legacy dist/cpuif base address setting")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v3:
 replace '15/31' with 'SHIFT + 15' to make it more readable.
v2:
  Using GENMASK() to generate the masks.
---
 arch/arm64/include/uapi/asm/kvm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 3bb134355874..316917b98707 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -75,9 +75,11 @@ struct kvm_regs {
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
 #define KVM_ARM_DEVICE_TYPE_SHIFT	0
-#define KVM_ARM_DEVICE_TYPE_MASK	(0xffff << KVM_ARM_DEVICE_TYPE_SHIFT)
+#define KVM_ARM_DEVICE_TYPE_MASK	GENMASK(KVM_ARM_DEVICE_TYPE_SHIFT + 15, \
+						KVM_ARM_DEVICE_TYPE_SHIFT)
 #define KVM_ARM_DEVICE_ID_SHIFT		16
-#define KVM_ARM_DEVICE_ID_MASK		(0xffff << KVM_ARM_DEVICE_ID_SHIFT)
+#define KVM_ARM_DEVICE_ID_MASK		GENMASK(KVM_ARM_DEVICE_ID_SHIFT + 15, \
+						KVM_ARM_DEVICE_ID_SHIFT)
 
 /* Supported device IDs */
 #define KVM_ARM_DEVICE_VGIC_V2		0
-- 
2.25.1

