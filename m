Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD555DD82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiF0Pbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiF0Pb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:31:28 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C619C2E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:31:24 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id oFXH2700L4C55Sk01FXHYi; Mon, 27 Jun 2022 17:31:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qhp-0014yb-1K; Mon, 27 Jun 2022 17:31:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-004jEh-Gp; Mon, 27 Jun 2022 17:31:16 +0200
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
Subject: [PATCH 4/7] memory: renesas-rpc-if: Split-off private data from struct rpcif
Date:   Mon, 27 Jun 2022 17:31:11 +0200
Message-Id: <062510dcc46c8fefe7a18527d98398c6f4c2bb0f.1656341824.git.geert+renesas@glider.be>
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

The rpcif structure is used as a common data structure, shared by the
RPC-IF core driver and by the HyperBus and SPI child drivers.
This poses several problems:
  - Most structure members describe private core driver state, which
    should not be accessible by the child drivers,
  - The structure's lifetime is controlled by the child drivers,
    complicating use by the core driver.

Fix this by moving the private core driver state to its own structure,
managed by the RPC-IF core driver, and store it in the core driver's
private data field.  This requires absorbing the child's platform
device, as that was stored in the driver's private data field before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/renesas-rpc-if.c | 75 +++++++++++++++++++++++++--------
 include/memory/renesas-rpc-if.h | 16 -------
 2 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 55dbb3854b09ad43..78e10a7300411191 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -162,14 +162,36 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
 };
 
+struct rpcif_priv {
+	struct device *dev;
+	void __iomem *base;
+	void __iomem *dirmap;
+	struct regmap *regmap;
+	struct reset_control *rstc;
+	struct platform_device *vdev;
+	size_t size;
+	enum rpcif_type type;
+	enum rpcif_data_dir dir;
+	u8 bus_size;
+	u8 xfer_size;
+	void *buffer;
+	u32 xferlen;
+	u32 smcr;
+	u32 smadr;
+	u32 command;		/* DRCMR or SMCMR */
+	u32 option;		/* DROPR or SMOPR */
+	u32 enable;		/* DRENR or SMENR */
+	u32 dummy;		/* DRDMCR or SMDMCR */
+	u32 ddr;		/* DRDRENR or SMDRENR */
+};
 
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
- * proper width.  Requires rpcif.xfer_size to be correctly set before!
+ * proper width.  Requires rpcif_priv.xfer_size to be correctly set before!
  */
 static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
-	struct rpcif *rpc = context;
+	struct rpcif_priv *rpc = context;
 
 	switch (reg) {
 	case RPCIF_SMRDR0:
@@ -205,7 +227,7 @@ static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
 
 static int rpcif_reg_write(void *context, unsigned int reg, unsigned int val)
 {
-	struct rpcif *rpc = context;
+	struct rpcif_priv *rpc = context;
 
 	switch (reg) {
 	case RPCIF_SMWDR0:
@@ -252,13 +274,12 @@ static const struct regmap_config rpcif_regmap_config = {
 	.volatile_table	= &rpcif_volatile_table,
 };
 
-int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
+int rpcif_sw_init(struct rpcif *rpcif, struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	struct resource *res;
 
-	rpc->dev = dev;
-
 	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);
@@ -278,12 +299,17 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 
 	rpc->type = (uintptr_t)of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
 
-	return PTR_ERR_OR_ZERO(rpc->rstc);
+	rpcif->dev = dev;
+	rpcif->dirmap = rpc->dirmap;
+	rpcif->size = rpc->size;
+	return 0;
 }
 EXPORT_SYMBOL(rpcif_sw_init);
 
-static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
+static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif_priv *rpc)
 {
 	regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
@@ -297,8 +323,9 @@ static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
 }
 
-int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
+int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	u32 dummy;
 	int ret;
 
@@ -357,7 +384,7 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 }
 EXPORT_SYMBOL(rpcif_hw_init);
 
-static int wait_msg_xfer_end(struct rpcif *rpc)
+static int wait_msg_xfer_end(struct rpcif_priv *rpc)
 {
 	u32 sts;
 
@@ -366,7 +393,7 @@ static int wait_msg_xfer_end(struct rpcif *rpc)
 					USEC_PER_SEC);
 }
 
-static u8 rpcif_bits_set(struct rpcif *rpc, u32 nbytes)
+static u8 rpcif_bits_set(struct rpcif_priv *rpc, u32 nbytes)
 {
 	if (rpc->bus_size == 2)
 		nbytes /= 2;
@@ -379,9 +406,11 @@ static u8 rpcif_bit_size(u8 buswidth)
 	return buswidth > 4 ? 2 : ilog2(buswidth);
 }
 
-void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
+void rpcif_prepare(struct rpcif *rpcif, const struct rpcif_op *op, u64 *offs,
 		   size_t *len)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+
 	rpc->smcr = 0;
 	rpc->smadr = 0;
 	rpc->enable = 0;
@@ -465,8 +494,9 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 }
 EXPORT_SYMBOL(rpcif_prepare);
 
-int rpcif_manual_xfer(struct rpcif *rpc)
+int rpcif_manual_xfer(struct rpcif *rpcif)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
 	int ret = 0;
 
@@ -588,7 +618,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 err_out:
 	if (reset_control_reset(rpc->rstc))
 		dev_err(rpc->dev, "Failed to reset HW\n");
-	rpcif_hw_init(rpc, rpc->bus_size == 2);
+	rpcif_hw_init(rpcif, rpc->bus_size == 2);
 	goto exit;
 }
 EXPORT_SYMBOL(rpcif_manual_xfer);
@@ -635,8 +665,9 @@ static void memcpy_fromio_readw(void *to,
 	}
 }
 
-ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
+ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	loff_t from = offs & (rpc->size - 1);
 	size_t size = rpc->size - from;
 	int ret;
@@ -675,6 +706,7 @@ static int rpcif_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct platform_device *vdev;
 	struct device_node *flash;
+	struct rpcif_priv *rpc;
 	const char *name;
 	int ret;
 
@@ -695,11 +727,18 @@ static int rpcif_probe(struct platform_device *pdev)
 	}
 	of_node_put(flash);
 
+	rpc = devm_kzalloc(dev, sizeof(*rpc), GFP_KERNEL);
+	if (!rpc)
+		return -ENOMEM;
+
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
 	vdev->dev.parent = dev;
-	platform_set_drvdata(pdev, vdev);
+
+	rpc->dev = dev;
+	rpc->vdev = vdev;
+	platform_set_drvdata(pdev, rpc);
 
 	ret = platform_device_add(vdev);
 	if (ret) {
@@ -712,9 +751,9 @@ static int rpcif_probe(struct platform_device *pdev)
 
 static int rpcif_remove(struct platform_device *pdev)
 {
-	struct platform_device *vdev = platform_get_drvdata(pdev);
+	struct rpcif_priv *rpc = platform_get_drvdata(pdev);
 
-	platform_device_unregister(vdev);
+	platform_device_unregister(rpc->vdev);
 
 	return 0;
 }
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 9c0ad64b8d292d49..ddf94356752d3315 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -64,24 +64,8 @@ enum rpcif_type {
 
 struct rpcif {
 	struct device *dev;
-	void __iomem *base;
 	void __iomem *dirmap;
-	struct regmap *regmap;
-	struct reset_control *rstc;
 	size_t size;
-	enum rpcif_type type;
-	enum rpcif_data_dir dir;
-	u8 bus_size;
-	u8 xfer_size;
-	void *buffer;
-	u32 xferlen;
-	u32 smcr;
-	u32 smadr;
-	u32 command;		/* DRCMR or SMCMR */
-	u32 option;		/* DROPR or SMOPR */
-	u32 enable;		/* DRENR or SMENR */
-	u32 dummy;		/* DRDMCR or SMDMCR */
-	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
 int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
-- 
2.25.1

