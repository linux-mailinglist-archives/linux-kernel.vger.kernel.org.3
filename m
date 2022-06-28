Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A655E797
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348129AbiF1PPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348066AbiF1POv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB722DD4B;
        Tue, 28 Jun 2022 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429291; x=1687965291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAXYAwZhToLKlFioytUapwk35HsjItBcFPm+VR8gqj8=;
  b=vioY+a2gmiEDmM+amu7geBlC07rSlPgyONHmoY0Y0AzQq0jkYzSSee2p
   v23Ti+XSYz4DeY9w0NQmlfuqcW1CNbE2gIO2LroEfQYIdmOCq72MSSB2J
   0aXhxt2j8lq0iIjx5Rm1/4ycBFh643HO0PtbK3Vl5GAGlmgDRS8bPHqzV
   fz1mtwcFjZCjGdA4nLQ5qs/Bobf/xPcpas4mJxcYyGRYQguYtm8jqqz0W
   LnjcLZ+k8SdLbmDA+KGR4rj8/e1YldVd33m4cNcqvag0TdklKd6yt7Y8x
   HvkUiETStbjQCbJY2tvrFUDLA6cKRzt0ap4QnECelKc5Ipz2Q+zsznRh1
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="162420900"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:44 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 09/19] iio: adc: at91-sama5d2_adc: add .read_avail() chan_info ops
Date:   Tue, 28 Jun 2022 18:16:21 +0300
Message-ID: <20220628151631.3116454-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add .read_avail() to chan_info ops which will retrieve the available
oversampling ratio.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 50 +++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 1dd64e1d999e..2242ee8dde68 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -319,6 +319,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
 				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_all_available =			\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = "CH"#num,				\
 		.indexed = 1,						\
 	}
@@ -340,6 +342,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
 				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_all_available =			\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = "CH"#num"-CH"#num2,			\
 		.indexed = 1,						\
 	}
@@ -359,6 +363,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
 				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_all_available =			\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = name,					\
 	}
 #define AT91_SAMA5D2_CHAN_PRESSURE(num, name)				\
@@ -374,6 +380,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
 				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_all_available =			\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.datasheet_name = name,					\
 	}
 
@@ -398,6 +406,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  *			than the total channel number)
  * @hw_trig_cnt:	number of possible hardware triggers
  * @osr_mask:		oversampling ratio bitmask on EMR register
+ * @oversampling_avail:	available oversampling values
+ * @oversampling_avail_no: number of available oversampling values
  */
 struct at91_adc_platform {
 	const struct at91_adc_reg_layout	*layout;
@@ -410,6 +420,8 @@ struct at91_adc_platform {
 	unsigned int				max_index;
 	unsigned int				hw_trig_cnt;
 	unsigned int				osr_mask;
+	unsigned int				oversampling_avail[3];
+	unsigned int				oversampling_avail_no;
 };
 
 /**
@@ -609,6 +621,8 @@ static const struct at91_adc_platform sama5d2_platform = {
 #define AT91_SAMA5D2_HW_TRIG_CNT	3
 	.hw_trig_cnt = AT91_SAMA5D2_HW_TRIG_CNT,
 	.osr_mask = GENMASK(17, 16),
+	.oversampling_avail = { 1, 4, 16, },
+	.oversampling_avail_no = 3,
 };
 
 static const struct at91_adc_platform sama7g5_platform = {
@@ -625,6 +639,8 @@ static const struct at91_adc_platform sama7g5_platform = {
 #define AT91_SAMA7G5_HW_TRIG_CNT	3
 	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
 	.osr_mask = GENMASK(18, 16),
+	.oversampling_avail = { 1, 4, 16, },
+	.oversampling_avail_no = 3,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -1682,6 +1698,24 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int at91_adc_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = (int *)st->soc_info.platform->oversampling_avail;
+		*type = IIO_VAL_INT;
+		*length = st->soc_info.platform->oversampling_avail_no;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static void at91_adc_dma_init(struct at91_adc_state *st)
 {
 	struct device *dev = &st->indio_dev->dev;
@@ -1869,20 +1903,6 @@ static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
 static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
 
-static IIO_CONST_ATTR(oversampling_ratio_available,
-		      __stringify(1) " "
-		      __stringify(4) " "
-		      __stringify(16));
-
-static struct attribute *at91_adc_attributes[] = {
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group at91_adc_attribute_group = {
-	.attrs = at91_adc_attributes,
-};
-
 static const struct attribute *at91_adc_fifo_attributes[] = {
 	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
 	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
@@ -1892,7 +1912,7 @@ static const struct attribute *at91_adc_fifo_attributes[] = {
 };
 
 static const struct iio_info at91_adc_info = {
-	.attrs = &at91_adc_attribute_group,
+	.read_avail = &at91_adc_read_avail,
 	.read_raw = &at91_adc_read_raw,
 	.write_raw = &at91_adc_write_raw,
 	.update_scan_mode = &at91_adc_update_scan_mode,
-- 
2.34.1

