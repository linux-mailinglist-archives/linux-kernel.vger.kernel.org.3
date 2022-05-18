Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5B52BEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbiEROtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbiEROtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:49:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202391339ED;
        Wed, 18 May 2022 07:49:00 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IEM1T5030026;
        Wed, 18 May 2022 14:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SeJ64ex+8mlCmScFezbVIsrxG7SvqcCr/Utg5n0dsmA=;
 b=hZIfOicjtefjkyvlL2n2g8569GR0DvHTO5BLS5jwjCtYSUkfuLO3LQKOMYpUPzJKa0/o
 /6yIeGKnMvrYjvUYk2L4IjmsFhV9oME2FsiOZIbpi5FEgTOJZXqZj+CtbyNCd13lVcrK
 z0p/OQHrB9VL7f3G606GfkSTi/iAx7TZ17it2kI0P6w40n4B6JDpXSQJSXQJEltgZGha
 rFFCqsk7zRW2HQbVpG5EcQcSXVssYUOZW+xCbQvB+t1Yfi4tEaSY/V0sjXIWzoZr7WdF
 zEzgOUczf8Tyd5sU/Y7MWjw1p0NWq172TRCgLG0bRWyZPolTD4x+1PV98t4XwBIFLG06 GQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g52gh8q3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:48:23 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IEce60017704;
        Wed, 18 May 2022 14:48:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3g4wp59td2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:48:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IEmM7736307432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 14:48:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2ECBE053;
        Wed, 18 May 2022 14:48:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314D4BE056;
        Wed, 18 May 2022 14:48:22 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.6.139])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 14:48:22 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 1/2] iio: pressure: dps310: Refactor startup procedure
Date:   Wed, 18 May 2022 09:48:17 -0500
Message-Id: <20220518144818.12957-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518144818.12957-1-eajames@linux.ibm.com>
References: <20220518144818.12957-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kFQlD-vwcGh_T1QXlqI92fV_JiyHpkxF
X-Proofpoint-GUID: kFQlD-vwcGh_T1QXlqI92fV_JiyHpkxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_05,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the startup procedure into a function, and correct a missing
check on the return code for writing the PRS_CFG register.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 192 ++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 89 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 36fb7ae0d0a9..f79b274bb38d 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -159,6 +159,106 @@ static int dps310_get_coefs(struct dps310_data *data)
 	return 0;
 }
 
+/*
+ * Some verions of chip will read temperatures in the ~60C range when
+ * its actually ~20C. This is the manufacturer recommended workaround
+ * to correct the issue. The registers used below are undocumented.
+ */
+static int dps310_temp_workaround(struct dps310_data *data)
+{
+	int rc;
+	int reg;
+
+	rc = regmap_read(data->regmap, 0x32, &reg);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * If bit 1 is set then the device is okay, and the workaround does not
+	 * need to be applied
+	 */
+	if (reg & BIT(1))
+		return 0;
+
+	rc = regmap_write(data->regmap, 0x0e, 0xA5);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_write(data->regmap, 0x0f, 0x96);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_write(data->regmap, 0x62, 0x02);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_write(data->regmap, 0x0e, 0x00);
+	if (rc < 0)
+		return rc;
+
+	return regmap_write(data->regmap, 0x0f, 0x00);
+}
+
+static int dps310_startup(struct dps310_data *data)
+{
+	int rc;
+	int ready;
+
+	/*
+	 * Set up pressure sensor in single sample, one measurement per second
+	 * mode
+	 */
+	rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * Set up external (MEMS) temperature sensor in single sample, one
+	 * measurement per second mode
+	 */
+	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
+	if (rc < 0)
+		return rc;
+
+	/* Temp and pressure shifts are disabled when PRC <= 8 */
+	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
+	if (rc < 0)
+		return rc;
+
+	/* MEAS_CFG doesn't update correctly unless first written with 0 */
+	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			       DPS310_MEAS_CTRL_BITS, 0);
+	if (rc < 0)
+		return rc;
+
+	/* Turn on temperature and pressure measurement in the background */
+	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
+			       DPS310_TEMP_EN | DPS310_BACKGROUND);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * Calibration coefficients required for reporting temperature.
+	 * They are available 40ms after the device has started
+	 */
+	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
+				      ready & DPS310_COEF_RDY, 10000, 40000);
+	if (rc < 0)
+		return rc;
+
+	rc = dps310_get_coefs(data);
+	if (rc < 0)
+		return rc;
+
+	rc = dps310_temp_workaround(data);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
 static int dps310_get_pres_precision(struct dps310_data *data)
 {
 	int rc;
@@ -677,52 +777,12 @@ static const struct iio_info dps310_info = {
 	.write_raw = dps310_write_raw,
 };
 
-/*
- * Some verions of chip will read temperatures in the ~60C range when
- * its actually ~20C. This is the manufacturer recommended workaround
- * to correct the issue. The registers used below are undocumented.
- */
-static int dps310_temp_workaround(struct dps310_data *data)
-{
-	int rc;
-	int reg;
-
-	rc = regmap_read(data->regmap, 0x32, &reg);
-	if (rc < 0)
-		return rc;
-
-	/*
-	 * If bit 1 is set then the device is okay, and the workaround does not
-	 * need to be applied
-	 */
-	if (reg & BIT(1))
-		return 0;
-
-	rc = regmap_write(data->regmap, 0x0e, 0xA5);
-	if (rc < 0)
-		return rc;
-
-	rc = regmap_write(data->regmap, 0x0f, 0x96);
-	if (rc < 0)
-		return rc;
-
-	rc = regmap_write(data->regmap, 0x62, 0x02);
-	if (rc < 0)
-		return rc;
-
-	rc = regmap_write(data->regmap, 0x0e, 0x00);
-	if (rc < 0)
-		return rc;
-
-	return regmap_write(data->regmap, 0x0f, 0x00);
-}
-
 static int dps310_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct dps310_data *data;
 	struct iio_dev *iio;
-	int rc, ready;
+	int rc;
 
 	iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
 	if (!iio)
@@ -747,54 +807,8 @@ static int dps310_probe(struct i2c_client *client,
 	if (rc)
 		return rc;
 
-	/*
-	 * Set up pressure sensor in single sample, one measurement per second
-	 * mode
-	 */
-	rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
-
-	/*
-	 * Set up external (MEMS) temperature sensor in single sample, one
-	 * measurement per second mode
-	 */
-	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
-	if (rc < 0)
-		return rc;
-
-	/* Temp and pressure shifts are disabled when PRC <= 8 */
-	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
-	if (rc < 0)
-		return rc;
-
-	/* MEAS_CFG doesn't update correctly unless first written with 0 */
-	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
-			       DPS310_MEAS_CTRL_BITS, 0);
-	if (rc < 0)
-		return rc;
-
-	/* Turn on temperature and pressure measurement in the background */
-	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
-			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
-			       DPS310_TEMP_EN | DPS310_BACKGROUND);
-	if (rc < 0)
-		return rc;
-
-	/*
-	 * Calibration coefficients required for reporting temperature.
-	 * They are available 40ms after the device has started
-	 */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_COEF_RDY, 10000, 40000);
-	if (rc < 0)
-		return rc;
-
-	rc = dps310_get_coefs(data);
-	if (rc < 0)
-		return rc;
-
-	rc = dps310_temp_workaround(data);
-	if (rc < 0)
+	rc = dps310_startup(data);
+	if (rc)
 		return rc;
 
 	rc = devm_iio_device_register(&client->dev, iio);
-- 
2.27.0

