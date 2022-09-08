Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C475B1E0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiIHNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiIHNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8FB959D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:09:19 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MNfVv31CBz14QPc;
        Thu,  8 Sep 2022 21:05:27 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 21:09:17 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 21:09:15 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <suzuki.poulose@arm.com>,
        <oliver.upton@linux.dev>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm64: Use kmemleak_free_part_phys() to unregister hyp_mem_base
Date:   Thu, 8 Sep 2022 21:06:59 +0800
Message-ID: <20220908130659.2021-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 0c24e061196c ("mm: kmemleak: add rbtree and store physical
address for objects allocated with PA"), kmemleak started to put the
objects allocated with physical address onto object_phys_tree_root tree.
The kmemleak_free_part() therefore no longer worked as expected on
physically allocated objects (hyp_mem_base in this case) as it attempted to
search and remove things in object_tree_root tree.

Fix it by using kmemleak_free_part_phys() to unregister hyp_mem_base. This
fixes an immediate crash when booting a KVM host in protected mode with
kmemleak enabled.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 09e726711631..951070c4831d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2114,7 +2114,7 @@ static int finalize_hyp_mode(void)
 	 * at, which would end badly once inaccessible.
 	 */
 	kmemleak_free_part(__hyp_bss_start, __hyp_bss_end - __hyp_bss_start);
-	kmemleak_free_part(__va(hyp_mem_base), hyp_mem_size);
+	kmemleak_free_part_phys(hyp_mem_base, hyp_mem_size);
 	return pkvm_drop_host_privileges();
 }
 
-- 
2.33.0

