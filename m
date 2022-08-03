Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC58588A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiHCK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiHCK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:27:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D13F31A;
        Wed,  3 Aug 2022 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522428; x=1691058428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9cakn4tlvPI+qogjOzCeScbPuMLwF4m8+0rQKisSsCQ=;
  b=BDdyRGsgLqjfnUNOW8An+dGeBVUeYtjF04G0cm+4PReowcvmDA3ZGIKq
   bvkNVC9JnHPIpSp1kkiTW3FCIxRmBblRO//Rf13rt1nftguziPuju6gvG
   SUX1umrJJVZlsSvwlvWAiEtNsna5ewgjri4ggVTmuex76CwbIWo/g5uqE
   3JUvNDGt3WnqR3dVJbdTP+4s8KFXVJ9McWXtFaOts0RpU6m2TXoFQKLxi
   JM7WMF2fmpcCtpzG4I9ZoSzJQwP7v+ET95jKEBk0cwoQe6Swi4pBNKMj8
   LlkkU6KOiA1A+WxxR/tb8BeYVej4LqMSb9j2QlYUcLZFjS0Dm93LCp4i6
   A==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="107364746"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 09/19] iio: adc: at91-sama5d2_adc: add .read_avail() chan_info ops
Date:   Wed, 3 Aug 2022 13:28:45 +0300
Message-ID: <20220803102855.2191070-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
References: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fe4bec03bea9..47caaf271fae 100644
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

