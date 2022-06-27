Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4855CB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiF0Pbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiF0Pb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:31:28 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0D19C3D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:31:25 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id oFXH2700S4C55Sk01FXHaj; Mon, 27 Jun 2022 17:31:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qhp-0014ye-0o; Mon, 27 Jun 2022 17:31:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-004jF0-J1; Mon, 27 Jun 2022 17:31:16 +0200
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
Subject: [PATCH 7/7] memory: renesas-rpc-if: Reinitialize registers during system resume
Date:   Mon, 27 Jun 2022 17:31:14 +0200
Message-Id: <923c057c77b146710a82d486f89ce3a8ebda7ccd.1656341824.git.geert+renesas@glider.be>
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

During PSCI system suspend, R-Car Gen3 SoCs may be powered down, and
thus the RPC-IF register state may be lost.  Consequently, when using
the RPC-IF after system resume, data corruption may happen.

Fix this by reinitializing the hardware state during system resume.
As this requires resuming the RPC-IF core device, this can only be done
when the device is under active control of the HyperBus or SPI child
driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/renesas-rpc-if.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index ec76e603ad24d214..2a49d4511c8296c5 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -757,6 +757,20 @@ static int rpcif_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int rpcif_resume(struct device *dev)
+{
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
+
+	if (!pm_runtime_enabled(dev)) {
+		/* Not yet activated or deactivated by child device */
+		return 0;
+	}
+
+	return rpcif_hw_init(dev, rpc->bus_size == 2);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rpcif_pm_ops, NULL, rpcif_resume);
+
 static const struct of_device_id rpcif_of_match[] = {
 	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
 	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
@@ -770,6 +784,7 @@ static struct platform_driver rpcif_driver = {
 	.driver = {
 		.name =	"rpc-if",
 		.of_match_table = rpcif_of_match,
+		.pm = pm_sleep_ptr(&rpcif_pm_ops),
 	},
 };
 module_platform_driver(rpcif_driver);
-- 
2.25.1

