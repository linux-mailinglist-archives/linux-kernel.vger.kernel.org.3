Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E2577D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiGRIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGRIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:12:43 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC68512767;
        Mon, 18 Jul 2022 01:12:42 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id BE51A1C811C8;
        Mon, 18 Jul 2022 16:12:41 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 18
 Jul 2022 16:12:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 18 Jul
 2022 16:12:41 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 18 Jul 2022 16:12:41 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 58E7563A20; Mon, 18 Jul 2022 11:12:40 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 3/3] spi: npcm-fiu: Add NPCM8XX support
Date:   Mon, 18 Jul 2022 11:11:46 +0300
Message-ID: <20220718081146.256070-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718081146.256070-1-tmaimon77@gmail.com>
References: <20220718081146.256070-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding FIU NPCM8XX support to NPCM FIU driver.
NPCM8XX FIU supports four controllers.

As part of adding NPCM8XX support:
- Add NPCM8XX specific compatible string.
- Using an internal burst configuration register instead of a GCR
  register.
- Support FIU1 controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-fiu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index d5b4fe7b9b62..49f6424e35af 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -36,6 +36,7 @@
 #define NPCM_FIU_UMA_DR1		0x34
 #define NPCM_FIU_UMA_DR2		0x38
 #define NPCM_FIU_UMA_DR3		0x3C
+#define NPCM_FIU_CFG			0x78
 #define NPCM_FIU_MAX_REG_LIMIT		0x80
 
 /* FIU Direct Read Configuration Register */
@@ -151,6 +152,9 @@
 #define NPCM_FIU_UMA_DR3_RB13		GENMASK(15, 8)
 #define NPCM_FIU_UMA_DR3_RB12		GENMASK(7, 0)
 
+/* FIU Configuration Register */
+#define NPCM_FIU_CFG_FIU_FIX		BIT(31)
+
 /* FIU Read Mode */
 enum {
 	DRD_SINGLE_WIRE_MODE	= 0,
@@ -187,6 +191,7 @@ enum {
 	FIU0 = 0,
 	FIU3,
 	FIUX,
+	FIU1,
 };
 
 struct npcm_fiu_info {
@@ -214,6 +219,21 @@ static const struct fiu_data npcm7xx_fiu_data = {
 	.fiu_max = 3,
 };
 
+static const struct npcm_fiu_info npxm8xx_fiu_info[] = {
+	{.name = "FIU0", .fiu_id = FIU0,
+		.max_map_size = MAP_SIZE_128MB, .max_cs = 2},
+	{.name = "FIU3", .fiu_id = FIU3,
+		.max_map_size = MAP_SIZE_128MB, .max_cs = 4},
+	{.name = "FIUX", .fiu_id = FIUX,
+		.max_map_size = MAP_SIZE_16MB, .max_cs = 2},
+	{.name = "FIU1", .fiu_id = FIU1,
+		.max_map_size = MAP_SIZE_16MB, .max_cs = 4} };
+
+static const struct fiu_data npxm8xx_fiu_data = {
+	.npcm_fiu_data_info = npxm8xx_fiu_info,
+	.fiu_max = 4,
+};
+
 struct npcm_fiu_spi;
 
 struct npcm_fiu_chip {
@@ -624,6 +644,10 @@ static int npcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		regmap_update_bits(gcr_regmap, NPCM7XX_INTCR3_OFFSET,
 				   NPCM7XX_INTCR3_FIU_FIX,
 				   NPCM7XX_INTCR3_FIU_FIX);
+	} else {
+		regmap_update_bits(fiu->regmap, NPCM_FIU_CFG,
+				   NPCM_FIU_CFG_FIU_FIX,
+				   NPCM_FIU_CFG_FIU_FIX);
 	}
 
 	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN) {
@@ -664,6 +688,7 @@ static const struct spi_controller_mem_ops npcm_fiu_mem_ops = {
 
 static const struct of_device_id npcm_fiu_dt_ids[] = {
 	{ .compatible = "nuvoton,npcm750-fiu", .data = &npcm7xx_fiu_data  },
+	{ .compatible = "nuvoton,npcm845-fiu", .data = &npxm8xx_fiu_data  },
 	{ /* sentinel */ }
 };
 
-- 
2.33.0

