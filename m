Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B070E56660A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiGEJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiGEJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:26:53 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B94CEA;
        Tue,  5 Jul 2022 02:26:52 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A31A7200D8E;
        Tue,  5 Jul 2022 11:26:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 755BB200D85;
        Tue,  5 Jul 2022 11:26:50 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 162B1180222D;
        Tue,  5 Jul 2022 17:26:48 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com,
        zhengxunli@mxic.com.tw
Subject: [PATCH 03/11] spi: spi-nxp-fspi: add DTR mode support
Date:   Tue,  5 Jul 2022 17:11:35 +0800
Message-Id: <1657012303-6464-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

For LUT, add DTR command support.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 10e71e55d21a..c32a4f53fa2a 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -537,12 +537,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	int lutidx = 1, i;
 
 	/* cmd */
-	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
-			     op->cmd.opcode);
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0x00ff);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
 
 	/* addr bytes */
 	if (op->addr.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
+					      LUT_ADDR_DDR : LUT_ADDR,
 					      LUT_PAD(op->addr.buswidth),
 					      op->addr.nbytes * 8);
 		lutidx++;
@@ -550,7 +560,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 
 	/* dummy bytes, if needed */
 	if (op->dummy.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ?
+					      LUT_DUMMY_DDR : LUT_DUMMY,
 		/*
 		 * Due to FlexSPI controller limitation number of PAD for dummy
 		 * buswidth needs to be programmed as equal to data buswidth.
@@ -565,7 +576,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	if (op->data.nbytes) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx,
 					      op->data.dir == SPI_MEM_DATA_IN ?
-					      LUT_NXP_READ : LUT_NXP_WRITE,
+					      (op->data.dtr ? LUT_READ_DDR : LUT_NXP_READ) :
+					      (op->data.dtr ? LUT_WRITE_DDR : LUT_NXP_WRITE),
 					      LUT_PAD(op->data.buswidth),
 					      0);
 		lutidx++;
@@ -1090,6 +1102,10 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 	.get_name = nxp_fspi_get_name,
 };
 
+static struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+	.dtr = true,
+};
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1194,6 +1210,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
+	ctlr->mem_caps = &nxp_fspi_mem_caps;
 
 	nxp_fspi_default_setup(f);
 
-- 
2.25.1

