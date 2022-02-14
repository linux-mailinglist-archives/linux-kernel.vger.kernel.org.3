Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33E4B41B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiBNGKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:10:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiBNGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:10:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F205622D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:10:35 -0800 (PST)
X-UUID: 0e22c8da32ae4185afea2ff75874c9f9-20220214
X-UUID: 0e22c8da32ae4185afea2ff75874c9f9-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1208782719; Mon, 14 Feb 2022 14:10:32 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Feb 2022 14:10:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 14:10:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:10:28 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
CC:     James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        <iommu@lists.linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-kernel@vger.kernel.org>, "Joerg Roedel" <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        Kevin Tang <kevin3.tang@gmail.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 10/23] drm/sprd: Make use of the helper component_compare_of
Date:   Mon, 14 Feb 2022 14:08:06 +0800
Message-ID: <20220214060819.7334-11-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common compare helper from component.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Kevin Tang <kevin3.tang@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/sprd/sprd_drm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d721..5d534a8db913 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -134,14 +134,9 @@ static const struct component_master_ops drm_component_ops = {
 	.unbind = sprd_drm_unbind,
 };
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int sprd_drm_probe(struct platform_device *pdev)
 {
-	return drm_of_component_probe(&pdev->dev, compare_of, &drm_component_ops);
+	return drm_of_component_probe(&pdev->dev, component_compare_of, &drm_component_ops);
 }
 
 static int sprd_drm_remove(struct platform_device *pdev)
-- 
2.18.0

