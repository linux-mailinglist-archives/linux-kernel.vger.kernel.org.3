Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2D570490
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiGKNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiGKNnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:43:22 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60684D809;
        Mon, 11 Jul 2022 06:43:21 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id E21CC1C80CA9;
        Mon, 11 Jul 2022 21:43:20 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Jul
 2022 21:43:20 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 11 Jul 2022 21:43:20 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 81BDA63A23; Mon, 11 Jul 2022 16:43:19 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <j.neuschaefer@gmx.net>, <zhengbin13@huawei.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] iio: adc: npcm: Add NPCM8XX support
Date:   Mon, 11 Jul 2022 16:43:11 +0300
Message-ID: <20220711134312.234268-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220711134312.234268-1-tmaimon77@gmail.com>
References: <20220711134312.234268-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ADC NPCM8XX support to NPCM ADC driver.
ADC NPCM8XX uses a different resolution and voltage reference.

As part of adding NPCM8XX support:
- Add NPCM8XX specific compatible string.
- Add data to handle architecture-specific ADC parameters.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/iio/adc/npcm_adc.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index f7bc0bb7f112..efacba256056 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -16,6 +16,12 @@
 #include <linux/uaccess.h>
 #include <linux/reset.h>
 
+struct npcm_adc_info {
+	u32 data_mask;
+	u32 internal_vref;
+	u32 res_bits;
+};
+
 struct npcm_adc {
 	bool int_status;
 	u32 adc_sample_hz;
@@ -34,6 +40,7 @@ struct npcm_adc {
 	 * has finished.
 	 */
 	struct mutex lock;
+	struct npcm_adc_info *data;
 };
 
 /* ADC registers */
@@ -52,13 +59,21 @@ struct npcm_adc {
 #define NPCM_ADCCON_CH(x)		((x) << 24)
 #define NPCM_ADCCON_DIV_SHIFT		1
 #define NPCM_ADCCON_DIV_MASK		GENMASK(8, 1)
-#define NPCM_ADC_DATA_MASK(x)		((x) & GENMASK(9, 0))
 
 #define NPCM_ADC_ENABLE		(NPCM_ADCCON_ADC_EN | NPCM_ADCCON_ADC_INT_EN)
 
 /* ADC General Definition */
-#define NPCM_RESOLUTION_BITS		10
-#define NPCM_INT_VREF_MV		2000
+static const struct npcm_adc_info npxm7xx_adc_info = {
+	.data_mask = GENMASK(9, 0),
+	.internal_vref = 2048,
+	.res_bits = 10,
+};
+
+static const struct npcm_adc_info npxm8xx_adc_info = {
+	.data_mask = GENMASK(11, 0),
+	.internal_vref = 1229,
+	.res_bits = 12,
+};
 
 #define NPCM_ADC_CHAN(ch) {					\
 	.type = IIO_VOLTAGE,					\
@@ -129,7 +144,8 @@ static int npcm_adc_read(struct npcm_adc *info, int *val, u8 channel)
 	if (ret < 0)
 		return ret;
 
-	*val = NPCM_ADC_DATA_MASK(ioread32(info->regs + NPCM_ADCDATA));
+	*val = ioread32(info->regs + NPCM_ADCDATA);
+	*val &= info->data->data_mask;
 
 	return 0;
 }
@@ -157,9 +173,9 @@ static int npcm_adc_read_raw(struct iio_dev *indio_dev,
 			vref_uv = regulator_get_voltage(info->vref);
 			*val = vref_uv / 1000;
 		} else {
-			*val = NPCM_INT_VREF_MV;
+			*val = info->data->internal_vref;
 		}
-		*val2 = NPCM_RESOLUTION_BITS;
+		*val2 = info->data->res_bits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = info->adc_sample_hz;
@@ -176,7 +192,8 @@ static const struct iio_info npcm_adc_iio_info = {
 };
 
 static const struct of_device_id npcm_adc_match[] = {
-	{ .compatible = "nuvoton,npcm750-adc", },
+	{ .compatible = "nuvoton,npcm750-adc", .data = &npxm7xx_adc_info},
+	{ .compatible = "nuvoton,npcm845-adc", .data = &npxm8xx_adc_info},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, npcm_adc_match);
@@ -190,14 +207,20 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	struct npcm_adc *info;
 	struct iio_dev *indio_dev;
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
 	if (!indio_dev)
 		return -ENOMEM;
 	info = iio_priv(indio_dev);
 
-	mutex_init(&info->lock);
+	match = of_match_node(npcm_adc_match, pdev->dev.of_node);
+	if (!match || !match->data) {
+		dev_err(dev, "Failed getting npcm_adc_data\n");
+		return -ENODEV;
+	}
 
+	info->data = (struct npcm_adc_info *)match->data;
 	info->dev = &pdev->dev;
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
-- 
2.33.0

