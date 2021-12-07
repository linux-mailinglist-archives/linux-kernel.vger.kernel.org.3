Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB346B115
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhLGC4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:56:07 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230374AbhLGC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:56:06 -0500
X-UUID: 104e544aab1f490e92bf1caecb5089d5-20211207
X-UUID: 104e544aab1f490e92bf1caecb5089d5-20211207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1479917465; Tue, 07 Dec 2021 10:52:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 7 Dec 2021 10:52:31 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 10:52:30 +0800
From:   <yf.wang@mediatek.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Guangming Cao <Guangming.Cao@mediatek.com>,
        "Yunfei Wang" <yf.wang@mediatek.com>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Add error handle for page table allocation failure
Date:   Tue, 7 Dec 2021 10:47:22 +0800
Message-ID: <20211207024723.25751-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

In __arm_v7s_alloc_table function:
iommu call kmem_cache_alloc to allocate page table, this function
allocate memory may fail, when kmem_cache_alloc fails to allocate
table, call virt_to_phys will be abnomal and return unexpected phys
and goto out_free, then call kmem_cache_free to release table will
trigger KE, __get_free_pages and free_pages have similar problem,
so add error handle for page table allocation failure.

Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index bfb6acb651e5..d84240308f4b 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -246,6 +246,12 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
 		table = kmem_cache_zalloc(data->l2_tables, gfp);
+
+	if (!table) {
+		dev_err(dev, "Page table allocation failure lvl:%d\n", lvl);
+		return NULL;
+	}
+
 	phys = virt_to_phys(table);
 	if (phys != (arm_v7s_iopte)phys) {
 		/* Doesn't fit in PTE */
-- 
2.18.0

