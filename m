Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990DA566619
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiGEJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGEJ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:26:59 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BCDE02B;
        Tue,  5 Jul 2022 02:26:58 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A587A200CA7;
        Tue,  5 Jul 2022 11:26:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 442E6200E2B;
        Tue,  5 Jul 2022 11:26:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D8BFF180222D;
        Tue,  5 Jul 2022 17:26:53 +0800 (+08)
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
Subject: [PATCH 06/11] spi: spi-nxp-fspi: enable octal ddr for iMX8QM/QXP/DXL
Date:   Tue,  5 Jul 2022 17:11:38 +0800
Message-Id: <1657012303-6464-6-git-send-email-haibo.chen@nxp.com>
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

From: Han Xu <han.xu@nxp.com>

To enable the octal ddr for iMX8QM/QXP/DXL, need to set the proper
slave line delay to get the correct sample points. So add one entry
in dts to set it.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 61cf1b82c0d7..cfc2600e3b6d 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -218,9 +218,13 @@
 
 #define FSPI_DLLACR			0xC0
 #define FSPI_DLLACR_OVRDEN		BIT(8)
+#define FSPI_DLLACR_SLVDLY(x)          ((x) << 3)
+#define FSPI_DLLACR_DLLEN              BIT(0)
 
 #define FSPI_DLLBCR			0xC4
 #define FSPI_DLLBCR_OVRDEN		BIT(8)
+#define FSPI_DLLBCR_SLVDLY(x)          ((x) << 3)
+#define FSPI_DLLBCR_DLLEN              BIT(0)
 
 #define FSPI_STS0			0xE0
 #define FSPI_STS0_DLPHB(x)		((x) << 8)
@@ -375,6 +379,7 @@ struct nxp_fspi {
 	u32 memmap_phy_size;
 	u32 memmap_start;
 	u32 memmap_len;
+	u32 dll_slvdly;
 	struct clk *clk, *clk_en;
 	struct device *dev;
 	struct completion c;
@@ -1081,6 +1086,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_DLLACR_OVRDEN, base + FSPI_DLLACR);
 	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
 
+	if (f->dll_slvdly) {
+		fspi_writel(f, FSPI_DLLACR_DLLEN | FSPI_DLLACR_SLVDLY(f->dll_slvdly),
+			    base + FSPI_DLLACR);
+		fspi_writel(f, FSPI_DLLBCR_DLLEN | FSPI_DLLBCR_SLVDLY(f->dll_slvdly),
+			    base + FSPI_DLLBCR);
+	}
+
 	/* enable module */
 	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) |
 		    FSPI_MCR0_IP_TIMEOUT(0xFF) | (u32) FSPI_MCR0_OCTCOMB_EN,
@@ -1259,6 +1271,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	/* check if need to set the slave delay line */
+	of_property_read_u32(np, "nxp,fspi-dll-slvdly", &f->dll_slvdly);
+
 	mutex_init(&f->lock);
 
 	ctlr->bus_num = -1;
-- 
2.25.1

