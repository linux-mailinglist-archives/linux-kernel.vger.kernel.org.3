Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773A24B41D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiBNGLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:11:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiBNGLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:11:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B851E5E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:10:58 -0800 (PST)
X-UUID: cc29d99d1df042f4b8b8e27cdef4c160-20220214
X-UUID: cc29d99d1df042f4b8b8e27cdef4c160-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1930234839; Mon, 14 Feb 2022 14:10:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Feb 2022 14:10:56 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:10:54 +0800
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
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>
Subject: [PATCH 12/23] drm/sun4i: Make use of the helper component_compare_of
Date:   Mon, 14 Feb 2022 14:08:08 +0800
Message-ID: <20220214060819.7334-13-yong.wu@mediatek.com>
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

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-sunxi@lists.linux.dev
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index b630614b3d72..a3e3e51c600d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -201,15 +201,6 @@ static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
-static int compare_of(struct device *dev, void *data)
-{
-	DRM_DEBUG_DRIVER("Comparing of node %pOF with %pOF\n",
-			 dev->of_node,
-			 data);
-
-	return dev->of_node == data;
-}
-
 /*
  * The encoder drivers use drm_of_find_possible_crtcs to get upstream
  * crtcs from the device tree using of_graph. For the results to be
@@ -329,7 +320,7 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	     of_device_is_available(node))) {
 		/* Add current component */
 		DRM_DEBUG_DRIVER("Adding component %pOF\n", node);
-		drm_of_component_match_add(dev, match, compare_of, node);
+		drm_of_component_match_add(dev, match, component_compare_of, node);
 		count++;
 	}
 
-- 
2.18.0

