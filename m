Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A654B4E85
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbiBNLeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:34:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351885AbiBNLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:33:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB366F8B;
        Mon, 14 Feb 2022 03:19:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B45B01F43669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644837550;
        bh=/yHhoGENnp5DfoA0yF/nUh7Mr9NPuMCSmEyusu4kgtU=;
        h=From:To:Cc:Subject:Date:From;
        b=K2W0/12Y8kOeoV2TERja1cvvfaN0KlIkfleL8X5BjzFguAx6YDhkDwqELmUFhjtLI
         MZJDiACq4O7v2rhXDmMIiVGdvThbpe1k2nuYz5DqbFeqUBOuLGCdDW5R9+nq60FA+K
         cUvKWgJAzlV9YUvGTOjGB//MB4v4LFrlKz0t/cV0BkRVhiYEhetMW3W3lo/zo664uI
         WM0IvxY+JQKPO1V932VQ6LwHqocInM6EiIO2QhQeoAuB0lJa3momVeIaE9yQgPIfcs
         BBAU7O74zn9E46R7UXhUOS71px58s2Hdxn7rPpmLrpVeg7G1KDTAh9WXXM1RK2hnga
         IIKcFl8/1SSSA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunfeng.yun@mediatek.com
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        matthias.bgg@gmail.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] usb: host: xhci-mtk: Simplify supplies handling with regulator_bulk
Date:   Mon, 14 Feb 2022 12:19:05 +0100
Message-Id: <20220214111905.77903-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the custom functions xhci_mtk_ldos_{enable,disable}() by
switching to using regulator_bulk to perform the very same thing,
as the regulators are always either both enabled or both disabled.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

v2: Change dynamic vregs array to static definition with new xhci_mtk_vregs_get()
    helper as requested by Chunfeng

 drivers/usb/host/xhci-mtk.c | 44 ++++++++++---------------------------
 drivers/usb/host/xhci-mtk.h |  5 +++--
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index e25bad0894cf..b89b4f159a4d 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -401,29 +401,14 @@ static int xhci_mtk_clks_get(struct xhci_hcd_mtk *mtk)
 	return devm_clk_bulk_get_optional(mtk->dev, BULK_CLKS_NUM, clks);
 }
 
-static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
+static int xhci_mtk_vregs_get(struct xhci_hcd_mtk *mtk)
 {
-	int ret;
+	struct regulator_bulk_data *supplies = mtk->supplies;
 
-	ret = regulator_enable(mtk->vbus);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable vbus\n");
-		return ret;
-	}
-
-	ret = regulator_enable(mtk->vusb33);
-	if (ret) {
-		dev_err(mtk->dev, "failed to enable vusb33\n");
-		regulator_disable(mtk->vbus);
-		return ret;
-	}
-	return 0;
-}
+	supplies[0].supply = "vbus";
+	supplies[1].supply = "vusb33";
 
-static void xhci_mtk_ldos_disable(struct xhci_hcd_mtk *mtk)
-{
-	regulator_disable(mtk->vbus);
-	regulator_disable(mtk->vusb33);
+	return devm_regulator_bulk_get(mtk->dev, BULK_VREGS_NUM, supplies);
 }
 
 static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
@@ -513,17 +498,10 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk->dev = dev;
-	mtk->vbus = devm_regulator_get(dev, "vbus");
-	if (IS_ERR(mtk->vbus)) {
-		dev_err(dev, "fail to get vbus\n");
-		return PTR_ERR(mtk->vbus);
-	}
 
-	mtk->vusb33 = devm_regulator_get(dev, "vusb33");
-	if (IS_ERR(mtk->vusb33)) {
-		dev_err(dev, "fail to get vusb33\n");
-		return PTR_ERR(mtk->vusb33);
-	}
+	ret = xhci_mtk_vregs_get(mtk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
 
 	ret = xhci_mtk_clks_get(mtk);
 	if (ret)
@@ -564,7 +542,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ret = xhci_mtk_ldos_enable(mtk);
+	ret = regulator_bulk_enable(BULK_VREGS_NUM, mtk->supplies);
 	if (ret)
 		goto disable_pm;
 
@@ -673,7 +651,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
 
 disable_ldos:
-	xhci_mtk_ldos_disable(mtk);
+	regulator_bulk_disable(BULK_VREGS_NUM, mtk->supplies);
 
 disable_pm:
 	pm_runtime_put_noidle(dev);
@@ -701,7 +679,7 @@ static int xhci_mtk_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 	xhci_mtk_sch_exit(mtk);
 	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
-	xhci_mtk_ldos_disable(mtk);
+	regulator_bulk_disable(BULK_VREGS_NUM, mtk->supplies);
 
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 4b1ea89f959a..ffd4b493b4ba 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -11,10 +11,12 @@
 
 #include <linux/clk.h>
 #include <linux/hashtable.h>
+#include <linux/regulator/consumer.h>
 
 #include "xhci.h"
 
 #define BULK_CLKS_NUM	5
+#define BULK_VREGS_NUM	2
 
 /* support at most 64 ep, use 32 size hash table */
 #define SCH_EP_HASH_BITS	5
@@ -150,9 +152,8 @@ struct xhci_hcd_mtk {
 	int num_u3_ports;
 	int u2p_dis_msk;
 	int u3p_dis_msk;
-	struct regulator *vusb33;
-	struct regulator *vbus;
 	struct clk_bulk_data clks[BULK_CLKS_NUM];
+	struct regulator_bulk_data supplies[BULK_VREGS_NUM];
 	unsigned int has_ippc:1;
 	unsigned int lpm_support:1;
 	unsigned int u2_lpm_disable:1;
-- 
2.33.1

