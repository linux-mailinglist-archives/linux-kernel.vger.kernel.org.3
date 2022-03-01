Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAE4C8080
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiCABuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiCABti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:49:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B85BD3A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:48:56 -0800 (PST)
X-UUID: 71c0d92509264925bc3dadf911b7d004-20220301
X-UUID: 71c0d92509264925bc3dadf911b7d004-20220301
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1344401544; Tue, 01 Mar 2022 09:48:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 09:48:47 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 09:48:46 +0800
From:   <yf.wang@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>
Subject: [PATCH] iommu/iova: Reset max32_alloc_size after cleaning rcache in the fail path
Date:   Tue, 1 Mar 2022 09:42:43 +0800
Message-ID: <20220301014246.5011-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

In alloc_iova_fast function, if __alloc_and_insert_iova_range fail,
alloc_iova_fast will try flushing rcache and retry alloc iova, but
this has an issue:

Since __alloc_and_insert_iova_range fail will set the current alloc
iova size to max32_alloc_size (iovad->max32_alloc_size = size),
when the retry is executed into the __alloc_and_insert_iova_range
function, the retry action will be blocked by the check condition
(size >= iovad->max32_alloc_size) and goto iova32_full directly,
causes the action of retry regular alloc iova in
__alloc_and_insert_iova_range to not actually be executed.

Based on the above, so need reset max32_alloc_size before retry alloc
iova when alloc iova fail, that is set the initial dma_32bit_pfn value
of iovad to max32_alloc_size, so that the action of retry alloc iova
in __alloc_and_insert_iova_range can be executed.

Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/iova.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b28c9435b898..0c085ae8293f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -453,6 +453,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 retry:
 	new_iova = alloc_iova(iovad, size, limit_pfn, true);
 	if (!new_iova) {
+		unsigned long flags;
 		unsigned int cpu;
 
 		if (!flush_rcache)
@@ -463,6 +464,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
 		free_global_cached_iovas(iovad);
+
+		/* Reset max32_alloc_size after flushing rcache for retry */
+		spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+
 		goto retry;
 	}
 
-- 
2.18.0

