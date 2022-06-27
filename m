Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4455D3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiF0Pbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiF0Pb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:31:27 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F819C36
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:31:24 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id oFXH2700W4C55Sk01FXHal; Mon, 27 Jun 2022 17:31:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qhp-0014yY-2P; Mon, 27 Jun 2022 17:31:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-004jEM-El; Mon, 27 Jun 2022 17:31:16 +0200
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
Subject: [PATCH 1/7] memory: renesas-rpc-if: Always use dev in rpcif_sw_init()
Date:   Mon, 27 Jun 2022 17:31:08 +0200
Message-Id: <98924121e59ab3f389ddd413b6d252a8deb889cf.1656341824.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1656341824.git.geert+renesas@glider.be>
References: <cover.1656341824.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rpcif_sw_init() already has the "dev" parameter pointing to the right
device structure, so there is no need to take a detour through the
platform device.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/renesas-rpc-if.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 4316988d791a527f..829b962e8f034bdd 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -263,22 +263,21 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);
 
-	rpc->regmap = devm_regmap_init(&pdev->dev, NULL, rpc, &rpcif_regmap_config);
+	rpc->regmap = devm_regmap_init(dev, NULL, rpc, &rpcif_regmap_config);
 	if (IS_ERR(rpc->regmap)) {
-		dev_err(&pdev->dev,
-			"failed to init regmap for rpcif, error %ld\n",
+		dev_err(dev, "failed to init regmap for rpcif, error %ld\n",
 			PTR_ERR(rpc->regmap));
 		return	PTR_ERR(rpc->regmap);
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
-	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
+	rpc->dirmap = devm_ioremap_resource(dev, res);
 	if (IS_ERR(rpc->dirmap))
 		return PTR_ERR(rpc->dirmap);
 	rpc->size = resource_size(res);
 
 	rpc->type = (uintptr_t)of_device_get_match_data(dev);
-	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
 
 	return PTR_ERR_OR_ZERO(rpc->rstc);
 }
-- 
2.25.1

