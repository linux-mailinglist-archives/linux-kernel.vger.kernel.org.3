Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD2537A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiE3MOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiE3MOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:14:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8613E04
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:14:36 -0700 (PDT)
X-UUID: 22fd0f51a2e848de9f119297234c6976-20220530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f08fdcd2-853f-44dd-ba56-f596366d4959,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:acf30548-4fb1-496b-8f1d-39e733fed1ea,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 22fd0f51a2e848de9f119297234c6976-20220530
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 527559544; Mon, 30 May 2022 20:14:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 30 May 2022 20:14:30 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 May 2022 20:14:29 +0800
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
        "Miles Chen" <miles.chen@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Subject: [PATCH] iommu/dma: Fix race condition during iova_domain initialization
Date:   Mon, 30 May 2022 20:07:45 +0800
Message-ID: <20220530120748.31733-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

When many devices share the same iova domain, iommu_dma_init_domain()
may be called at the same time. The checking of iovad->start_pfn will
all get false in iommu_dma_init_domain() and both enter init_iova_domain()
to do iovad initialization.

Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.

Exception backtrace:
rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
init_iova_domain() + 180
iommu_setup_dma_ops() + 260
arch_setup_dma_ops() + 132
of_dma_configure_id() + 468
platform_dma_configure() + 32
really_probe() + 1168
driver_probe_device() + 268
__device_attach_driver() + 524
__device_attach() + 524
bus_probe_device() + 64
deferred_probe_work_func() + 260
process_one_work() + 580
worker_thread() + 1076
kthread() + 332
ret_from_fork() + 16

Signed-off-by: Ning Li <ning.li@mediatek.com>
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/dma-iommu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..b38c5041eeab 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -63,6 +63,7 @@ struct iommu_dma_cookie {
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
+	struct mutex			mutex;
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
@@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 	if (!domain->iova_cookie)
 		return -ENOMEM;
 
+	mutex_init(&domain->iova_cookie->mutex);
 	return 0;
 }
 
@@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	/* start_pfn is always nonzero for an already-initialised domain */
+	mutex_lock(&cookie->mutex);
 	if (iovad->start_pfn) {
 		if (1UL << order != iovad->granule ||
 		    base_pfn != iovad->start_pfn) {
 			pr_warn("Incompatible range for DMA domain\n");
-			return -EFAULT;
+			ret = -EFAULT;
+			goto done_unlock;
 		}
 
-		return 0;
+		ret = 0;
+		goto done_unlock;
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 	ret = iova_domain_init_rcaches(iovad);
 	if (ret)
-		return ret;
+		goto done_unlock;
 
 	/* If the FQ fails we can simply fall back to strict mode */
 	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
 		domain->type = IOMMU_DOMAIN_DMA;
 
-	return iova_reserve_iommu_regions(dev, domain);
+	ret = iova_reserve_iommu_regions(dev, domain);
+
+done_unlock:
+	mutex_unlock(&cookie->mutex);
+	return ret;
 }
 
 /**
-- 
2.18.0

