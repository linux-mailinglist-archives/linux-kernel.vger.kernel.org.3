Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325555D841
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiF0Pbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiF0Pb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:31:28 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C819C38
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:31:24 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id oFXH2700P4C55Sk01FXHah; Mon, 27 Jun 2022 17:31:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-0014yc-VJ; Mon, 27 Jun 2022 17:31:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-004jEn-HZ; Mon, 27 Jun 2022 17:31:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/7] memory: renesas-rpc-if: Move resource acquisition to .probe()
Date:   Mon, 27 Jun 2022 17:31:12 +0200
Message-Id: <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1656341824.git.geert+renesas@glider.be>
References: <cover.1656341824.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the acquired resources are tied to the lifetime of the RPC-IF core
device (through the use of managed resource functions), the actual
resource acquisition is triggered from the HyperBus and SPI child
drivers.  Due to this mismatch, unbinding and rebinding the child
drivers manually fails with -EBUSY:

    # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
    # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
    rpc-if ee200000.spi: can't request region for resource [mem 0xee200000-0xee2001ff]
    rpc-if-hyperflash: probe of rpc-if-hyperflash failed with error -16

Fix this by moving all resource acquisition to the core driver's probe
routine.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/renesas-rpc-if.c | 47 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 78e10a7300411191..ef0336cbb4c196fb 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -276,31 +276,7 @@ static const struct regmap_config rpcif_regmap_config = {
 
 int rpcif_sw_init(struct rpcif *rpcif, struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct rpcif_priv *rpc = dev_get_drvdata(dev);
-	struct resource *res;
-
-	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
-	if (IS_ERR(rpc->base))
-		return PTR_ERR(rpc->base);
-
-	rpc->regmap = devm_regmap_init(dev, NULL, rpc, &rpcif_regmap_config);
-	if (IS_ERR(rpc->regmap)) {
-		dev_err(dev, "failed to init regmap for rpcif, error %ld\n",
-			PTR_ERR(rpc->regmap));
-		return	PTR_ERR(rpc->regmap);
-	}
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
-	rpc->dirmap = devm_ioremap_resource(dev, res);
-	if (IS_ERR(rpc->dirmap))
-		return PTR_ERR(rpc->dirmap);
-	rpc->size = resource_size(res);
-
-	rpc->type = (uintptr_t)of_device_get_match_data(dev);
-	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(rpc->rstc))
-		return PTR_ERR(rpc->rstc);
 
 	rpcif->dev = dev;
 	rpcif->dirmap = rpc->dirmap;
@@ -707,6 +683,7 @@ static int rpcif_probe(struct platform_device *pdev)
 	struct platform_device *vdev;
 	struct device_node *flash;
 	struct rpcif_priv *rpc;
+	struct resource *res;
 	const char *name;
 	int ret;
 
@@ -731,6 +708,28 @@ static int rpcif_probe(struct platform_device *pdev)
 	if (!rpc)
 		return -ENOMEM;
 
+	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
+	if (IS_ERR(rpc->base))
+		return PTR_ERR(rpc->base);
+
+	rpc->regmap = devm_regmap_init(dev, NULL, rpc, &rpcif_regmap_config);
+	if (IS_ERR(rpc->regmap)) {
+		dev_err(dev, "failed to init regmap for rpcif, error %ld\n",
+			PTR_ERR(rpc->regmap));
+		return	PTR_ERR(rpc->regmap);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
+	rpc->dirmap = devm_ioremap_resource(dev, res);
+	if (IS_ERR(rpc->dirmap))
+		return PTR_ERR(rpc->dirmap);
+	rpc->size = resource_size(res);
+
+	rpc->type = (uintptr_t)of_device_get_match_data(dev);
+	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
+
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
-- 
2.25.1

