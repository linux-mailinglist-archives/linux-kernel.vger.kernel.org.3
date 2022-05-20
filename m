Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6452E816
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347253AbiETIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiETIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:54:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9518263505
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:54:03 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4L6d3Cm4zQkGR;
        Fri, 20 May 2022 16:51:05 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 16:54:00 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <yuehaibing@huawei.com>,
        <wupeng58@huawei.com>
Subject: [PATCH] KVM: arm64: cancel the return value check of kvm_arm_init_sve()
Date:   Fri, 20 May 2022 08:49:11 +0000
Message-ID: <20220520084911.44253-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kvm_arm_init_sve() has only a unique return value,
so change the return value type of kvm_arm_init_sve() to void.

Meanwhile, there's no need to check the return value of
kvm_arm_init_sve() in kvm_arch_init().

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 arch/arm64/kvm/arm.c   | 4 +---
 arch/arm64/kvm/reset.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 400bb0fe2745..5ec90991c68e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2206,9 +2206,7 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		return err;
 
-	err = kvm_arm_init_sve();
-	if (err)
-		return err;
+	kvm_arm_init_sve();
 
 	err = kvm_arm_vmid_alloc_init();
 	if (err) {
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 6c70c6f61c70..abae7b24eb8b 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -43,7 +43,7 @@ static u32 kvm_ipa_limit;
 
 unsigned int kvm_sve_max_vl;
 
-int kvm_arm_init_sve(void)
+void kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
 		kvm_sve_max_vl = sve_max_virtualisable_vl();
@@ -65,8 +65,6 @@ int kvm_arm_init_sve(void)
 			pr_warn("KVM: SVE vector length for guests limited to %u bytes\n",
 				kvm_sve_max_vl);
 	}
-
-	return 0;
 }
 
 static int kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
-- 
2.17.1

