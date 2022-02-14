Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E24B41B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiBNGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:10:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiBNGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:09:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645EF5621A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:09:50 -0800 (PST)
X-UUID: 1cfe2e72faa841be882b6e2979c4cf28-20220214
X-UUID: 1cfe2e72faa841be882b6e2979c4cf28-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 23019940; Mon, 14 Feb 2022 14:09:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 14:09:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:09:42 +0800
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
        "Xinliang Liu" <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        "Chen Feng" <puck.chen@hisilicon.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Hao Fang" <fanghao11@huawei.com>
Subject: [PATCH 05/23] drm/hirin: Make use of the helper component_compare_of
Date:   Mon, 14 Feb 2022 14:08:01 +0800
Message-ID: <20220214060819.7334-6-yong.wu@mediatek.com>
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

Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hao Fang <fanghao11@huawei.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 98ae9a48f3fe..8041ec11bd48 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -203,11 +203,6 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	return ret;
 }
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
 	drm_kms_helper_poll_fini(dev);
@@ -278,7 +273,7 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	if (!remote)
 		return -ENODEV;
 
-	drm_of_component_match_add(dev, &match, compare_of, remote);
+	drm_of_component_match_add(dev, &match, component_compare_of, remote);
 	of_node_put(remote);
 
 	return component_master_add_with_match(dev, &kirin_drm_ops, match);
-- 
2.18.0

