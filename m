Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936A581DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiG0DNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiG0DNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:13:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9B3CBF7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:13:09 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LszJn2mGwzWft9;
        Wed, 27 Jul 2022 11:09:13 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 11:13:06 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <linux@armlinux.org.uk>, <robh@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <kirill.shtuemov@linux.intel.com>,
        <akpm@linux-foundation.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <austindh.kim@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <weiyongjun1@huawei.com>,
        <guohanjun@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next 2/3] ARM: 6953/1: DT: remove dt_virt parameter double check
Date:   Wed, 27 Jul 2022 03:10:59 +0000
Message-ID: <20220727031100.112919-2-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220727031100.112919-1-xuqiang36@huawei.com>
References: <20220727031100.112919-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_init_dt_verify() can handle NULL dt_virt as its argument,
and return NULL when dt_virt is NULL. So remove NULL
check before early_init_dt_verify operation.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 arch/arm/kernel/devtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 02839d8b6202..182a59b23b09 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -203,7 +203,7 @@ const struct machine_desc * __init setup_machine_fdt(void *dt_virt)
 	mdesc_best = &__mach_desc_GENERIC_DT;
 #endif
 
-	if (!dt_virt || !early_init_dt_verify(dt_virt))
+	if (!early_init_dt_verify(dt_virt))
 		return NULL;
 
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
-- 
2.17.1

