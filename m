Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27CB5A9698
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiIAMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiIAMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:19:29 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF0E1195F4;
        Thu,  1 Sep 2022 05:19:26 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2818wsF5016725;
        Thu, 1 Sep 2022 08:19:24 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3japt6247d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 08:19:24 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 281CJNIn031428
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 08:19:23 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 1 Sep 2022 08:19:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 1 Sep 2022 08:19:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 1 Sep 2022 08:19:21 -0400
Received: from debian.ad.analog.com ([10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 281CJ1FR010547;
        Thu, 1 Sep 2022 08:19:12 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Date:   Thu, 1 Sep 2022 15:16:59 +0300
Message-ID: <20220901121700.1325733-4-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901121700.1325733-1-ciprian.regus@analog.com>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: B_blqKJevBA6-qQQVFvD_6lA2A6v6eZ1
X-Proofpoint-ORIG-GUID: B_blqKJevBA6-qQQVFvD_6lA2A6v6eZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTC2499 is a 16-channel (eight differential), 24-bit,
ADC with Easy Drive technology and a 2-wire, I2C interface.

Implement support for the LTC2499 ADC by extending the LTC2497
driver. A new chip_info struct is added to differentiate between
chip types and resolutions when reading data from the device.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
changes in v2:
 - removed the bitfield.h and bitops.h includes, since they were not needed.
 - removed a blank line.
 - replaced the data buffer for the ltc2497_driverdata with a union.
 - depending on frame size, i2c transfers use either 3 or 4 byte buffers, instead
   of always using a __be32.
 - added a comment which explains the output data format and how does sign extension.
   happen.
 - added the const modifier for the chip_info structs.
 - renamed the chip_info struct to ltc2497_chip_info.
 - renamed the chip_type enum to ltc2497_chip_type
 - added probe fallback to using i2c_device_id in case OF fails.
 - used BITS_TO_BYTES() instead of dividing by 8.
 - used a tab instead of a space in a struct field declaration, which in v1 appeared as
   if the line was deleted and added back.
 - added back a trailing comma.
 - rearranged variable declaration lines so that longer ones would be first.
 - used pointers to a chip info struct in the i2c_device_id table, instead of enums. 
 drivers/iio/adc/ltc2496.c      |  8 ++++-
 drivers/iio/adc/ltc2497-core.c |  2 +-
 drivers/iio/adc/ltc2497.c      | 56 +++++++++++++++++++++++++++++++---
 drivers/iio/adc/ltc2497.h      | 11 +++++++
 4 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index dfb3bb5997e5..bf89d5ae19af 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -15,6 +15,7 @@
 #include <linux/iio/driver.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include "ltc2497.h"
 
@@ -74,6 +75,7 @@ static int ltc2496_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
+	st->common_ddata.chip_info = device_get_match_data(dev);
 
 	return ltc2497core_probe(dev, indio_dev);
 }
@@ -85,8 +87,12 @@ static void ltc2496_remove(struct spi_device *spi)
 	ltc2497core_remove(indio_dev);
 }
 
+static const struct ltc2497_chip_info ltc2496_info = {
+	.resolution = 16,
+};
+
 static const struct of_device_id ltc2496_of_match[] = {
-	{ .compatible = "lltc,ltc2496", },
+	{ .compatible = "lltc,ltc2496", .data = &ltc2496_info, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltc2496_of_match);
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2a485c8a1940..b2752399402c 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -95,7 +95,7 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		*val = ret / 1000;
-		*val2 = 17;
+		*val2 = ddata->chip_info->resolution + 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index f7c786f37ceb..2f660015f34b 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -12,6 +12,7 @@
 #include <linux/iio/driver.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include "ltc2497.h"
 
@@ -19,11 +20,16 @@ struct ltc2497_driverdata {
 	/* this must be the first member */
 	struct ltc2497core_driverdata common_ddata;
 	struct i2c_client *client;
+	u32 recv_size;
+	u32 sub_lsb;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	__be32 buf __aligned(IIO_DMA_MINALIGN);
+	union {
+		__be32 d32;
+		u8 d8[3];
+	} data __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
@@ -34,13 +40,29 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 	int ret;
 
 	if (val) {
-		ret = i2c_master_recv(st->client, (char *)&st->buf, 3);
+		if (st->recv_size == 3)
+			ret = i2c_master_recv(st->client, (char *)&st->data.d8, st->recv_size);
+		else
+			ret = i2c_master_recv(st->client, (char *)&st->data.d32, st->recv_size);
+
 		if (ret < 0) {
 			dev_err(&st->client->dev, "i2c_master_recv failed\n");
 			return ret;
 		}
 
-		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
+		/*
+		 * The data format is 16/24 bit 2s complement, but with an upper sign bit on the
+		 * resolution + 1 position, which is set for positive values only. Given this
+		 * bit's value, subtracting BIT(resolution + 1) from the ADC's result is
+		 * equivalent to a sign extension.
+		 */
+		if (st->recv_size == 3) {
+			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
+				- BIT(ddata->chip_info->resolution + 1);
+		} else {
+			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
+				- BIT(ddata->chip_info->resolution + 1);
+		}
 	}
 
 	ret = i2c_smbus_write_byte(st->client,
@@ -54,9 +76,11 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 static int ltc2497_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	const struct ltc2497_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct ltc2497_driverdata *st;
 	struct device *dev = &client->dev;
+	u32 resolution;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
 				     I2C_FUNC_SMBUS_WRITE_BYTE))
@@ -71,6 +95,15 @@ static int ltc2497_probe(struct i2c_client *client,
 	st->client = client;
 	st->common_ddata.result_and_measure = ltc2497_result_and_measure;
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		chip_info = (const struct ltc2497_chip_info *)id->driver_data;
+	st->common_ddata.chip_info = chip_info;
+
+	resolution = chip_info->resolution;
+	st->sub_lsb = 31 - (resolution + 1);
+	st->recv_size = BITS_TO_BYTES(resolution) + 1;
+
 	return ltc2497core_probe(dev, indio_dev);
 }
 
@@ -83,14 +116,27 @@ static int ltc2497_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2497] = {
+		.resolution = 16,
+		.name = NULL,
+	},
+	[TYPE_LTC2499] = {
+		.resolution = 24,
+		.name = "ltc2499",
+	},
+};
+
 static const struct i2c_device_id ltc2497_id[] = {
-	{ "ltc2497", 0 },
+	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
+	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
-	{ .compatible = "lltc,ltc2497", },
+	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
+	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltc2497_of_match);
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index d0b42dd6b8ad..95f6a5f4d4a6 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -4,9 +4,20 @@
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
 #define LTC2497_CONVERSION_TIME_MS	150ULL
 
+enum ltc2497_chip_type {
+	TYPE_LTC2496,
+	TYPE_LTC2497,
+	TYPE_LTC2499,
+};
+
+struct ltc2497_chip_info {
+	u32 resolution;
+};
+
 struct ltc2497core_driverdata {
 	struct regulator *ref;
 	ktime_t	time_prev;
+	const struct ltc2497_chip_info	*chip_info;
 	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
-- 
2.30.2

