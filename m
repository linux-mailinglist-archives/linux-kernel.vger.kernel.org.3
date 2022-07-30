Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC088585A48
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiG3LtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3LtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:49:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426B25E83
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:49:05 -0700 (PDT)
X-UUID: d4e95e81f5004808b70140b5086c7ad3-20220730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:f9710841-b696-4ed5-8479-505822299514,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:1badd0cf-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d4e95e81f5004808b70140b5086c7ad3-20220730
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1945181272; Sat, 30 Jul 2022 19:49:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 30 Jul 2022 19:49:00 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 30 Jul 2022 19:48:59 +0800
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
        Yunfei Wang <yf.wang@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>
Subject: [PATCH] dma-debug: Fix overflow issue in bucket_find_contain
Date:   Sat, 30 Jul 2022 19:41:45 +0800
Message-ID: <20220730114146.32669-1-yf.wang@mediatek.com>
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

There are two issue:
1. If max_rang is set to 0xFFFF_FFFF, and __hash_bucket_find always
returns NULL, the rang will be accumulated. When rang is accumulated
to 0xFFFF_E000, after executing rang += (1 << HASH_FN_SHIFT) again,
rang will overflow to 0, making it impossible to exit the while loop.
2. dev_addr reduce maybe overflow.

So, add range and dev_addr check to avoid overflow.

Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 kernel/dma/debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index ad731f7858c9..9d7d54cd4c63 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -352,6 +352,7 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
 
 	unsigned int max_range = dma_get_max_seg_size(ref->dev);
 	struct dma_debug_entry *entry, index = *ref;
+	unsigned int shift = (1 << HASH_FN_SHIFT);
 	unsigned int range = 0;
 
 	while (range <= max_range) {
@@ -360,12 +361,15 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
 		if (entry)
 			return entry;
 
+		if (max_range - range < shift || index.dev_addr < shift)
+			return NULL;
+
 		/*
 		 * Nothing found, go back a hash bucket
 		 */
 		put_hash_bucket(*bucket, *flags);
-		range          += (1 << HASH_FN_SHIFT);
-		index.dev_addr -= (1 << HASH_FN_SHIFT);
+		range          += shift;
+		index.dev_addr -= shift;
 		*bucket = get_hash_bucket(&index, flags);
 	}
 
-- 
2.18.0

