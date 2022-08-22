Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45859BFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiHVMwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiHVMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:52:48 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A22E6B6;
        Mon, 22 Aug 2022 05:52:47 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M9dK0F005755;
        Mon, 22 Aug 2022 08:52:41 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j2whtnerp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:52:41 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 27MCqdYD048895
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 08:52:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 22 Aug 2022 08:52:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 22 Aug 2022 08:52:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 22 Aug 2022 08:52:38 -0400
Received: from debian.ad.analog.com ([10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27MCqBGW003358;
        Mon, 22 Aug 2022 08:52:31 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH 2/3] drivers: iio: adc: LTC2499 support
Date:   Mon, 22 Aug 2022 15:51:05 +0300
Message-ID: <20220822125106.1106798-3-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822125106.1106798-1-ciprian.regus@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: axY3pyGbMfrFqI522oJ130DgVVrMVs2L
X-Proofpoint-GUID: axY3pyGbMfrFqI522oJ130DgVVrMVs2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220054
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
 drivers/iio/adc/ltc2496.c      |  8 +++++++-
 drivers/iio/adc/ltc2497-core.c |  2 +-
 drivers/iio/adc/ltc2497.c      | 34 +++++++++++++++++++++++++++++-----
 drivers/iio/adc/ltc2497.h      | 13 ++++++++++++-
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index dfb3bb5997e5..98338104c24a 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -14,6 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 
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
 
+static struct chip_info ltc2496_info = {
+	.resolution = 16,
+};
+
 static const struct of_device_id ltc2496_of_match[] = {
-	{ .compatible = "lltc,ltc2496", },
+	{ .compatible = "lltc,ltc2496", .data = (void *)&ltc2496_info },
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
index f7c786f37ceb..bb5e0d4301e2 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -7,10 +7,14 @@
  * Datasheet: http://cds.linear.com/docs/en/datasheet/2497fd.pdf
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 
 #include "ltc2497.h"
@@ -19,6 +23,8 @@ struct ltc2497_driverdata {
 	/* this must be the first member */
 	struct ltc2497core_driverdata common_ddata;
 	struct i2c_client *client;
+	u32 recv_size;
+	u32 sub_lsb;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -34,13 +40,14 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 	int ret;
 
 	if (val) {
-		ret = i2c_master_recv(st->client, (char *)&st->buf, 3);
+		ret = i2c_master_recv(st->client, (char *)&st->buf, st->recv_size);
 		if (ret < 0) {
 			dev_err(&st->client->dev, "i2c_master_recv failed\n");
 			return ret;
 		}
 
-		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
+		*val = (be32_to_cpu(st->buf) >> st->sub_lsb) -
+			BIT(ddata->chip_info->resolution + 1);
 	}
 
 	ret = i2c_smbus_write_byte(st->client,
@@ -54,6 +61,7 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 static int ltc2497_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	u32 resolution;
 	struct iio_dev *indio_dev;
 	struct ltc2497_driverdata *st;
 	struct device *dev = &client->dev;
@@ -70,6 +78,11 @@ static int ltc2497_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	st->client = client;
 	st->common_ddata.result_and_measure = ltc2497_result_and_measure;
+	st->common_ddata.chip_info = device_get_match_data(dev);
+
+	resolution = st->common_ddata.chip_info->resolution;
+	st->sub_lsb = 31 - (resolution + 1);
+	st->recv_size = resolution / BITS_PER_BYTE + 1;
 
 	return ltc2497core_probe(dev, indio_dev);
 }
@@ -83,15 +96,26 @@ static int ltc2497_remove(struct i2c_client *client)
 	return 0;
 }
 
+static struct chip_info ltc2497_info[] = {
+	[TYPE_LTC2497] = {
+		.resolution = 16,
+	},
+	[TYPE_LTC2499] = {
+		.resolution = 24,
+	}
+};
+
 static const struct i2c_device_id ltc2497_id[] = {
-	{ "ltc2497", 0 },
+	{ "ltc2497", TYPE_LTC2497 },
+	{ "ltc2499", TYPE_LTC2499 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
-	{ .compatible = "lltc,ltc2497", },
-	{},
+	{ .compatible = "lltc,ltc2497", .data = (void *)&ltc2497_info[TYPE_LTC2497] },
+	{ .compatible = "lltc,ltc2499", .data = (void *)&ltc2497_info[TYPE_LTC2499] },
+	{}
 };
 MODULE_DEVICE_TABLE(of, ltc2497_of_match);
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index d0b42dd6b8ad..f4d939cfd48b 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -4,9 +4,20 @@
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
 #define LTC2497_CONVERSION_TIME_MS	150ULL
 
+enum chip_type {
+	TYPE_LTC2496,
+	TYPE_LTC2497,
+	TYPE_LTC2499
+};
+
+struct chip_info {
+	u32 resolution;
+};
+
 struct ltc2497core_driverdata {
 	struct regulator *ref;
-	ktime_t	time_prev;
+	ktime_t time_prev;
+	const struct chip_info *chip_info;
 	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
-- 
2.30.2

