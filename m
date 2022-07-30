Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35458594E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiG3JEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiG3JE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:04:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C6140C5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:04:23 -0700 (PDT)
X-UUID: 17148b0f8e4746e59f3a41ae76fc8d76-20220730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:53619742-418e-4633-8c7d-e43f82956eba,OB:10,L
        OB:10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:53619742-418e-4633-8c7d-e43f82956eba,OB:10,LOB
        :10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:006acfcf-a6cf-4fb6-be1b-c60094821ca2,C
        OID:3194848f210a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 17148b0f8e4746e59f3a41ae76fc8d76-20220730
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2069013212; Sat, 30 Jul 2022 17:04:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 30 Jul 2022 17:04:10 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 30 Jul 2022 17:04:10 +0800
From:   <yf.wang@mediatek.com>
To:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>
Subject: [PATCH] dma-debug: Remove warning in dma_debug_entry
Date:   Sat, 30 Jul 2022 16:56:55 +0800
Message-ID: <20220730085657.31977-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

The same physical address can be mapped multiple times, and it is not
required to have attributes such as DMA_ATTR_SKIP_CPU_SYNC, but
dma_debug_entry will report an warning if active_cacheline_insert
returns -EEXIST, which can cause a lot of trouble.

For example, if two dma engine share the same dma-buf, the two dma
engine drivers will call the DMA API to map their own dma address
respectively, which is normal follow, but dma_debug_entry will
report an warning.

In addition, if active_cacheline_insert returns -EEXIST, the
active_cacheline_inc_overlap function already has the logic to
check overlapping mappings counter, if it exceeded
ACTIVE_CACHELINE_MAX_OVERLAP overlapping mappings, it already
has a warning.
And also, if warning as panic is turned on, it will cause KE.

So, dma_debug_entry does not need report warning.

Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 kernel/dma/debug.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2caafd13f8aa..ad731f7858c9 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -566,9 +566,6 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		err_printk(entry->dev, entry,
-			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
 }
 
-- 
2.18.0

