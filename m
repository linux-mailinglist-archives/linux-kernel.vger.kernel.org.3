Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32245701F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiGKMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGKMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:25:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416694505E;
        Mon, 11 Jul 2022 05:25:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7589D6601A00;
        Mon, 11 Jul 2022 13:25:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657542310;
        bh=exs3pbqQsoOqcfyKmAZDPS7dHDfSgn805ug/IQkbTTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7Blw7mb+6iWeJXSpyTg5gsPCpZ/oX4nhA4AdPgZAyw+awSwz0ET4Ll4cPtJZpDIo
         Lv7oKYFzUH9IE4ju3x8FOMqVXoObiVHatljFjJZSRxl0NZjq7iQ1kU/TIyUXL90cNG
         HbzlewoWSCRBGTtqLlCAs+ysD0f8333Le6a97nMuvgIAaCL2zIW47oy9pqY+qH5e4L
         G8gg4OhCdmOvX1pcHsNcio6NEAvfX825BxFN2oGVuPnpJfcpzvbPUVU0NlzrE2UQtE
         Hk5elY06tC9y5w1tHfhrmLTcgojqTvqjre6uMuKKkmFPNgmrV+O06LApMeR+48V9nT
         50JUVuRTaPIIw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH 3/3] soc: mediatek: pm-domains: Grab SCPSYS registers from phandle to syscon
Date:   Mon, 11 Jul 2022 14:25:03 +0200
Message-Id: <20220711122503.286743-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of requiring nesting of the power-controller inside of a
"syscon", "simple-mfd" node, look for a phandle to SCPSYS in the
"syscon" property of the power controller node.

Compatibility with older devicetrees is retained by falling back
to looking for a parent node if no syscon phandle is found.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index a3dae391a38a..c5a1c766cd50 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -590,8 +590,7 @@ static int scpsys_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scpsys_soc_data *soc;
-	struct device_node *node;
-	struct device *parent;
+	struct device_node *node, *syscon;
 	struct scpsys *scpsys;
 	int ret;
 
@@ -611,13 +610,16 @@ static int scpsys_probe(struct platform_device *pdev)
 	scpsys->pd_data.domains = scpsys->domains;
 	scpsys->pd_data.num_domains = soc->num_domains;
 
-	parent = dev->parent;
-	if (!parent) {
-		dev_err(dev, "no parent for syscon devices\n");
-		return -ENODEV;
+	syscon = of_parse_phandle(dev->of_node, "syscon", 0);
+	if (!syscon) {
+		if (!dev->parent)
+			return -ENODEV;
+		scpsys->base = syscon_node_to_regmap(dev->parent->of_node);
+	} else {
+		scpsys->base = syscon_node_to_regmap(syscon);
+		of_node_put(syscon);
 	}
 
-	scpsys->base = syscon_node_to_regmap(parent->of_node);
 	if (IS_ERR(scpsys->base)) {
 		dev_err(dev, "no regmap available\n");
 		return PTR_ERR(scpsys->base);
-- 
2.35.1

