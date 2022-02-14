Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300834B41D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiBNGLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:11:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiBNGLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:11:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C355495
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:11:09 -0800 (PST)
X-UUID: 79f8bf93bdf34329bdac0499ae51a473-20220214
X-UUID: 79f8bf93bdf34329bdac0499ae51a473-20220214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 43978453; Mon, 14 Feb 2022 14:11:07 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 14:11:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 14:11:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:11:03 +0800
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
        "Sandy Huang" <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C2=A8=C2=B9bner?= <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>
Subject: [PATCH 13/23] drm/rockchip: Make use of the helper component_compare_dev
Date:   Mon, 14 Feb 2022 14:08:09 +0800
Message-ID: <20220214060819.7334-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko St¨¹bner" <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index bec207de4544..3c2f2d6ecc36 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -290,11 +290,6 @@ int rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
 	return false;
 }
 
-static int compare_dev(struct device *dev, void *data)
-{
-	return dev == (struct device *)data;
-}
-
 static void rockchip_drm_match_remove(struct device *dev)
 {
 	struct device_link *link;
@@ -321,7 +316,7 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 				break;
 
 			device_link_add(dev, d, DL_FLAG_STATELESS);
-			component_match_add(dev, &match, compare_dev, d);
+			component_match_add(dev, &match, component_compare_dev, d);
 		} while (true);
 	}
 
-- 
2.18.0

