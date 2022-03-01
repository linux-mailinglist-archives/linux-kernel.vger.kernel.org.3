Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C134C835D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiCAFil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiCAFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:38:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A6338BB;
        Mon, 28 Feb 2022 21:37:48 -0800 (PST)
X-UUID: 6af4009e071d454b92612b6b52404fe1-20220301
X-UUID: 6af4009e071d454b92612b6b52404fe1-20220301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 32079050; Tue, 01 Mar 2022 13:37:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 1 Mar 2022 13:37:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 13:37:35 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 3/3] watchdog: mediatek: mt8186: add wdt support
Date:   Tue, 1 Mar 2022 13:37:33 +0800
Message-ID: <20220301053733.24755-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220301053733.24755-1-rex-bc.chen@mediatek.com>
References: <20220301053733.24755-1-rex-bc.chen@mediatek.com>
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

From: Runyang Chen <runyang.chen@mediatek.com>

Support MT8186 watchdog device.

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mtk_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 4577a76dd464..fe5a2ecba97a 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/reset/mt2712-resets.h>
 #include <dt-bindings/reset/mt8183-resets.h>
+#include <dt-bindings/reset/mt8186-resets.h>
 #include <dt-bindings/reset/mt8192-resets.h>
 #include <dt-bindings/reset/mt8195-resets.h>
 #include <linux/delay.h>
@@ -80,6 +81,10 @@ static const struct mtk_wdt_data mt8183_data = {
 	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
 };
 
+static const struct mtk_wdt_data mt8186_data = {
+	.toprgu_sw_rst_num = MT8186_TOPRGU_SW_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt8192_data = {
 	.toprgu_sw_rst_num = MT8192_TOPRGU_SW_RST_NUM,
 };
@@ -419,6 +424,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
 	{ .compatible = "mediatek,mt6589-wdt" },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
+	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
 	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
 	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
 	{ /* sentinel */ }
-- 
2.18.0

