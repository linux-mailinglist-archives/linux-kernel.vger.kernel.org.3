Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0849AF25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454752AbiAYJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:00:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1454175AbiAYI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:57:58 -0500
X-UUID: 62db39b6e7844cd9b6e3a7573406f297-20220125
X-UUID: 62db39b6e7844cd9b6e3a7573406f297-20220125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 271611354; Tue, 25 Jan 2022 16:57:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 25 Jan 2022 16:57:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:57:49 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v4 07/35] iommu/mediatek: Add mutex for data in the mtk_iommu_domain
Date:   Tue, 25 Jan 2022 16:56:06 +0800
Message-ID: <20220125085634.17972-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same with the previous patch, add a mutex for the "data" in the
mtk_iommu_domain. Just improve the safety for multi devices
enter attach_device at the same time. We don't get the real issue
for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 095736bfb7b4..e6e4ee471867 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -128,6 +128,8 @@ struct mtk_iommu_domain {
 
 	struct mtk_iommu_data		*data;
 	struct iommu_domain		domain;
+
+	struct mutex			mutex; /* Protect "data" in this structure */
 };
 
 static const struct iommu_ops mtk_iommu_ops;
@@ -434,6 +436,7 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
 	if (!dom)
 		return NULL;
+	mutex_init(&dom->mutex);
 
 	return &dom->domain;
 }
@@ -455,14 +458,19 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	if (domid < 0)
 		return domid;
 
+	mutex_lock(&dom->mutex);
 	if (!dom->data) {
 		/* Data is in the frstdata in sharing pgtable case. */
 		frstdata = mtk_iommu_get_m4u_data();
 
-		if (mtk_iommu_domain_finalise(dom, frstdata, domid))
+		ret = mtk_iommu_domain_finalise(dom, frstdata, domid);
+		if (ret) {
+			mutex_unlock(&dom->mutex);
 			return -ENODEV;
+		}
 		dom->data = data;
 	}
+	mutex_unlock(&dom->mutex);
 
 	mutex_lock(&data->mutex);
 	if (!data->m4u_dom) { /* Initialize the M4U HW */
-- 
2.18.0

