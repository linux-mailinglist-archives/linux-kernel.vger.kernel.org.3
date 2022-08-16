Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49550595948
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiHPLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiHPLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:04:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27FCC32E;
        Tue, 16 Aug 2022 03:29:30 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G7q92n019081;
        Tue, 16 Aug 2022 06:29:21 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3hx5t7xf10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 06:29:21 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27GATJmF037539
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 06:29:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 16 Aug
 2022 06:29:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 16 Aug 2022 06:29:18 -0400
Received: from george-precision5560.ad.analog.com ([10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27GAT2AQ030411;
        Tue, 16 Aug 2022 06:29:14 -0400
From:   George Mois <george.mois@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lucas.p.stankus@gmail.com>, George Mois <george.mois@analog.com>
Subject: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Date:   Tue, 16 Aug 2022 13:28:28 +0300
Message-ID: <20220816102828.182345-3-george.mois@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816102828.182345-1-george.mois@analog.com>
References: <20220816102828.182345-1-george.mois@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TO3QiTF9Q0jaBzTJU2j1laW9JZbMB9kw
X-Proofpoint-GUID: TO3QiTF9Q0jaBzTJU2j1laW9JZbMB9kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160040
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
respectively.

Implement support for ADXL312 and ADXL314 by extending the ADXL313
driver.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL312.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL314.pdf

Signed-off-by: George Mois <george.mois@analog.com>
---
 drivers/iio/accel/adxl313.h      |  15 ++-
 drivers/iio/accel/adxl313_core.c | 164 +++++++++++++++++++++++--------
 drivers/iio/accel/adxl313_spi.c  |  40 +++++++-
 3 files changed, 173 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 4415f2fc07e1..7428b1f7768f 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -26,6 +26,7 @@
 #define ADXL313_REG_FIFO_STATUS		0x39
 
 #define ADXL313_DEVID0			0xAD
+#define ADXL313_DEVID0_ADXL312_314	0xE5
 #define ADXL313_DEVID1			0x1D
 #define ADXL313_PARTID			0xCB
 #define ADXL313_SOFT_RESET		0x52
@@ -37,18 +38,28 @@
 #define ADXL313_MEASUREMENT_MODE	BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
-#define ADXL313_RANGE_4G		3
+#define ADXL313_RANGE_MAX		3
 
 #define ADXL313_FULL_RES		BIT(3)
 #define ADXL313_SPI_3WIRE		BIT(6)
 #define ADXL313_I2C_DISABLE		BIT(6)
 
+extern const struct regmap_access_table adxl312_readable_regs_table;
 extern const struct regmap_access_table adxl313_readable_regs_table;
+extern const struct regmap_access_table adxl314_readable_regs_table;
 
+extern const struct regmap_access_table adxl312_writable_regs_table;
 extern const struct regmap_access_table adxl313_writable_regs_table;
+extern const struct regmap_access_table adxl314_writable_regs_table;
+
+enum adxl313_device_type {
+	ADXL312,
+	ADXL313,
+	ADXL314,
+};
 
 int adxl313_core_probe(struct device *dev,
 		       struct regmap *regmap,
-		       const char *name,
+		       const struct spi_device_id *id,
 		       int (*setup)(struct device *, struct regmap *));
 #endif /* _ADXL313_H_ */
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index afeef779e1d0..eea7d235950e 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -11,9 +11,17 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 
 #include "adxl313.h"
 
+static const struct regmap_range adxl312_readable_reg_range[] = {
+	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
+	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
+	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
+	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
+};
+
 static const struct regmap_range adxl313_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
 	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
@@ -22,12 +30,32 @@ static const struct regmap_range adxl313_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
 };
 
+const struct regmap_access_table adxl312_readable_regs_table = {
+	.yes_ranges = adxl312_readable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_readable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl312_readable_regs_table, IIO_ADXL312);
+
 const struct regmap_access_table adxl313_readable_regs_table = {
 	.yes_ranges = adxl313_readable_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range),
 };
 EXPORT_SYMBOL_NS_GPL(adxl313_readable_regs_table, IIO_ADXL313);
 
+const struct regmap_access_table adxl314_readable_regs_table = {
+	.yes_ranges = adxl312_readable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_readable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL314);
+
+static const struct regmap_range adxl312_writable_reg_range[] = {
+	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
+	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
+	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
+	regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
+	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
+};
+
 static const struct regmap_range adxl313_writable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -37,16 +65,30 @@ static const struct regmap_range adxl313_writable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
 };
 
+const struct regmap_access_table adxl312_writable_regs_table = {
+	.yes_ranges = adxl312_writable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_writable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl312_writable_regs_table, IIO_ADXL312);
+
 const struct regmap_access_table adxl313_writable_regs_table = {
 	.yes_ranges = adxl313_writable_reg_range,
 	.n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range),
 };
 EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, IIO_ADXL313);
 
+const struct regmap_access_table adxl314_writable_regs_table = {
+	.yes_ranges = adxl312_writable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl312_writable_reg_range),
+};
+EXPORT_SYMBOL_NS_GPL(adxl314_writable_regs_table, IIO_ADXL314);
+
 struct adxl313_data {
 	struct regmap	*regmap;
+	const struct spi_device_id *id;
+	int scale_factor;
 	struct mutex	lock; /* lock to protect transf_buf */
-	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
+	__le16		transf_buf ____cacheline_aligned;
 };
 
 static const int adxl313_odr_freqs[][2] = {
@@ -156,12 +198,10 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		/*
-		 * Scale for any g range is given in datasheet as
-		 * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
-		 */
 		*val = 0;
-		*val2 = 9576806;
+
+		*val2 = data->scale_factor;
+
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(data->regmap,
@@ -170,7 +210,7 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		/*
-		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
+		 * 8-bit resolution at minimum range, that is 4x accel data scale
 		 * factor at full resolution
 		 */
 		*val = sign_extend32(regval, 7) * 4;
@@ -198,7 +238,7 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		/*
-		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
+		 * 8-bit resolution at minimum range, that is 4x accel data scale
 		 * factor at full resolution
 		 */
 		if (clamp_val(val, -128 * 4, 127 * 4) != val)
@@ -223,14 +263,17 @@ static const struct iio_info adxl313_info = {
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 			 int (*setup)(struct device *, struct regmap *))
 {
+	enum adxl313_device_type dev_type = data->id->driver_data;
 	unsigned int regval;
 	int ret;
 
-	/* Ensures the device is in a consistent state after start up */
-	ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
-			   ADXL313_SOFT_RESET);
-	if (ret)
-		return ret;
+	/* If ADXL313, ensures the device is in a consistent state after start up */
+	if (dev_type == ADXL313) {
+		ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
+				   ADXL313_SOFT_RESET);
+		if (ret)
+			return ret;
+	}
 
 	if (setup) {
 		ret = setup(dev, data->regmap);
@@ -242,41 +285,54 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	if (ret)
 		return ret;
 
-	if (regval != ADXL313_DEVID0) {
+	if (dev_type == ADXL313 && regval != ADXL313_DEVID0) {
 		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
 		return -ENODEV;
 	}
 
-	ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
-	if (ret)
-		return ret;
+	/* If ADXL313, check DEVID1 and PARTID */
+	if (regval == ADXL313_DEVID0) {
+		ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
+		if (ret)
+			return ret;
 
-	if (regval != ADXL313_DEVID1) {
-		dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
-		return -ENODEV;
-	}
+		if (regval != ADXL313_DEVID1) {
+			dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
+			return -ENODEV;
+		}
 
-	ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
-	if (ret)
-		return ret;
+		ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
+		if (ret)
+			return ret;
 
-	if (regval != ADXL313_PARTID) {
-		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
+		if (regval != ADXL313_PARTID) {
+			dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
+			return -ENODEV;
+		}
+	}
+
+	/* If ADXL312 or ADXL314 device, check DEVID0 */
+	if (dev_type != ADXL313 && regval != ADXL313_DEVID0_ADXL312_314) {
+		dev_err(dev, "Invalid manufacturer ID: %#02x\n", regval);
 		return -ENODEV;
 	}
 
-	/* Sets the range to +/- 4g */
-	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
-				 ADXL313_RANGE_MSK,
-				 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_4G));
-	if (ret)
-		return ret;
+	dev_info(dev, "%s detected.\n", data->id->name);
 
-	/* Enables full resolution */
-	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
-				 ADXL313_FULL_RES, ADXL313_FULL_RES);
-	if (ret)
-		return ret;
+	/* Sets the range to maximum, full resolution, for ADXL312 and ADXL313 */
+	if (dev_type == ADXL312 || dev_type == ADXL313) {
+		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+					 ADXL313_RANGE_MSK,
+					 FIELD_PREP(ADXL313_RANGE_MSK, 0x02));
+		if (ret)
+			return ret;
+
+		/* Enables full resolution */
+		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+					 ADXL313_FULL_RES, 0);
+		if (ret)
+			return ret;
+	}
 
 	/* Enables measurement mode */
 	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
@@ -296,7 +352,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
  */
 int adxl313_core_probe(struct device *dev,
 		       struct regmap *regmap,
-		       const char *name,
+		       const struct spi_device_id *id,
 		       int (*setup)(struct device *, struct regmap *))
 {
 	struct adxl313_data *data;
@@ -309,9 +365,35 @@ int adxl313_core_probe(struct device *dev,
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
+	data->id = id;
+
+	if (id->driver_data == ADXL312)
+		/*
+		 * ADXL312
+		 * Scale for any g range (full range) is given in datasheet as
+		 * 345 LSB/g = 0.0028985507 * 9.80665 = 0.028425072222155 m/s^2
+		 */
+		data->scale_factor = 28425072;
+
+	if (id->driver_data == ADXL313)
+		/*
+		 * * ADXL313
+		 * Scale for any g range is given in datasheet as
+		 * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
+		 */
+		data->scale_factor = 9576806;
+
+	if (id->driver_data == ADXL314)
+		/*
+		 * ADXL314
+		 * At +/-200g with 13-bit resolution, scale factor is given in datasheet as
+		 * 48.83 mg/LSB = 0.0488300 * 9.80665 = 0.4788587195 m/s^2.
+		 */
+		data->scale_factor = 478858719;
+
 	mutex_init(&data->lock);
 
-	indio_dev->name = name;
+	indio_dev->name = id->name;
 	indio_dev->info = &adxl313_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
@@ -319,13 +401,13 @@ int adxl313_core_probe(struct device *dev,
 
 	ret = adxl313_setup(dev, data, setup);
 	if (ret) {
-		dev_err(dev, "ADXL313 setup failed\n");
+		dev_err(dev, "Device %s setup failed\n", id->name);
 		return ret;
 	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_NS_GPL(adxl313_core_probe, IIO_ADXL313);
+EXPORT_SYMBOL_GPL(adxl313_core_probe);
 
 MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
 MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver");
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index a3c6d553462d..19cd096373b0 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -14,6 +14,16 @@
 
 #include "adxl313.h"
 
+static const struct regmap_config adxl312_spi_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.rd_table	= &adxl312_readable_regs_table,
+	.wr_table	= &adxl312_writable_regs_table,
+	.max_register	= 0x39,
+	 /* Setting bits 7 and 6 enables multiple-byte read */
+	.read_flag_mask	= BIT(7) | BIT(6),
+};
+
 static const struct regmap_config adxl313_spi_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -24,6 +34,22 @@ static const struct regmap_config adxl313_spi_regmap_config = {
 	.read_flag_mask	= BIT(7) | BIT(6),
 };
 
+static const struct regmap_config adxl314_spi_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.rd_table	= &adxl314_readable_regs_table,
+	.wr_table	= &adxl314_writable_regs_table,
+	.max_register	= 0x39,
+	 /* Setting bits 7 and 6 enables multiple-byte read */
+	.read_flag_mask	= BIT(7) | BIT(6),
+};
+
+static const struct regmap_config adxl31x_spi_regmap_config[] = {
+	adxl312_spi_regmap_config,
+	adxl313_spi_regmap_config,
+	adxl314_spi_regmap_config
+};
+
 static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
 {
 	struct spi_device *spi = container_of(dev, struct spi_device, dev);
@@ -51,26 +77,32 @@ static int adxl313_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
+	regmap = devm_regmap_init_spi(spi,
+				      &adxl31x_spi_regmap_config[id->driver_data]);
+
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
 			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-	return adxl313_core_probe(&spi->dev, regmap, id->name,
+	return adxl313_core_probe(&spi->dev, regmap, id,
 				  &adxl313_spi_setup);
 }
 
 static const struct spi_device_id adxl313_spi_id[] = {
-	{ "adxl313" },
+	{ "adxl312", ADXL312 },
+	{ "adxl313", ADXL313 },
+	{ "adxl314", ADXL314 },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
 
 static const struct of_device_id adxl313_of_match[] = {
+	{ .compatible = "adi,adxl312" },
 	{ .compatible = "adi,adxl313" },
+	{ .compatible = "adi,adxl314" },
 	{ }
 };
 
@@ -90,4 +122,6 @@ module_spi_driver(adxl313_spi_driver);
 MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
 MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ADXL312);
 MODULE_IMPORT_NS(IIO_ADXL313);
+MODULE_IMPORT_NS(IIO_ADXL314);
-- 
2.30.2

