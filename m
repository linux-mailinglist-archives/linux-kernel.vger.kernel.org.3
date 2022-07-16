Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A7576C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiGPHGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 03:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 03:06:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18552FFE3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 00:06:37 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LlK3r5rqKzlVld;
        Sat, 16 Jul 2022 15:04:56 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 15:06:34 +0800
Received: from localhost.localdomain (10.28.77.120) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 15:06:34 +0800
From:   wangwudi <wangwudi@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     wangwudi <wangwudi@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] drivers: irqchip: Allocate alignment addr by ITS_BASER.Page_size
Date:   Sat, 16 Jul 2022 15:05:36 +0800
Message-ID: <1657955136-6622-1-git-send-email-wangwudi@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.77.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of the ITS_BASER.Physical_Address field in the ARM GIC spec is as 
follows:
"The address must be aligned to the size specified in the Page Size field."
The Page_Size field in ITS_BASER might be RO.

Currently, the address is aligned based on the system page_size, not the HW 
Page_Size field. In some case, this is in contradiction with the spec.

For example:
ITS_BASER.Page_Size indicate 16K, and kernel page size is 4K.
If HW need 4K-size memory, the driver may alloc a 4K aligned address.
This has been proven in hardware.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: wangwudi <wangwudi@hisilicon.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de6c48f..0e25e887d45c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2310,6 +2310,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
+	if ((psz > PAGE_SIZE) && (PAGE_ORDER_TO_SIZE(order) < psz)) {
+		order = get_order(psz);
+	}
 	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, order);
 	if (!page)
 		return -ENOMEM;
-- 
2.7.4

