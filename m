Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85682533255
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbiEXUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEXURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:17:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2002873E;
        Tue, 24 May 2022 13:17:51 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OHW4xT030512;
        Tue, 24 May 2022 20:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tqQvznJHnixV34lW3If3Q9AzE7WRwCghaqqRp7ZtiIM=;
 b=VRcHc3pEqqWhL44ZT8R4cgXBRgF6YvAzGExe8im3eWQocU6839NbqAQO25KY+oPuppFD
 qrkCS8YW3cqeXunO2807XuBNTH8QXeaNzDrjY5W4k3UEkmunXS3LZxrFdf9u0RJ3XIoS
 HaYYHVHF3vwWbma/7EoX5TEbLbl+EonnFuIQk/PSVT/T3279qxo81P+yf1LpAxkz0BhH
 Py10bL3bnMCRt9dEJFkTEBk1gyeDz1ho0rOKeV8Y6Lzw+1APscrzFcGdYJOAoJ9inpBf
 R7JKWUoRHwzpyiyB6w7mclglxtnV98kr+gFDoQ6JI3wFAS+UbhXrTnVPqjFKyLHhypAp Zg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g93uk35kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 20:17:38 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OKA6TM005485;
        Tue, 24 May 2022 20:17:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3g93uu90ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 20:17:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OKHaFR34406886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 20:17:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C2C06E058;
        Tue, 24 May 2022 20:17:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2031E6E056;
        Tue, 24 May 2022 20:17:36 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.60])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 20:17:36 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Tue, 24 May 2022 15:17:29 -0500
Message-Id: <20220524201729.39503-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220524201729.39503-1-eajames@linux.ibm.com>
References: <20220524201729.39503-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c79zHKUUpyQ9kASUV9Y0TrvNOGf6ssuD
X-Proofpoint-ORIG-GUID: c79zHKUUpyQ9kASUV9Y0TrvNOGf6ssuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_10,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205240100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corruption of the MEAS_CFG register has been observed soon after
system boot. In order to recover this scenario, check MEAS_CFG if
measurement isn't ready, and if it's incorrect, reset the DPS310
and execute the startup procedure.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 88 +++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f79b274bb38d..fbceaa2cd71c 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -397,6 +397,44 @@ static int dps310_get_temp_k(struct dps310_data *data)
 	return scale_factors[ilog2(rc)];
 }
 
+/*
+ * Called with lock held. Returns a negative value on error, a positive value
+ * when the device is not ready, and zero when the device is ready.
+ */
+static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
+{
+	int meas_cfg;
+	int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
+
+	if (rc < 0)
+		return rc;
+
+	/* Device is ready, proceed to measurement */
+	if (meas_cfg & ready_bit)
+		return 0;
+
+	/* Device is OK, just not ready */
+	if (meas_cfg & (DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND))
+		return 1;
+
+	/* DPS310 register state corrupt, better start from scratch */
+	rc = regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
+	if (rc < 0)
+		return rc;
+
+	/* Wait for device chip access: 2.5ms in specification */
+	usleep_range(2500, 12000);
+
+	/* Reinitialize the chip */
+	rc = dps310_startup(data);
+	if (rc)
+		return rc;
+
+	dev_info(&data->client->dev,
+		 "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
+	return 1;
+}
+
 static int dps310_read_pres_raw(struct dps310_data *data)
 {
 	int rc;
@@ -409,16 +447,26 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rate = dps310_get_pres_samp_freq(data);
-	timeout = DPS310_POLL_TIMEOUT_US(rate);
-
-	/* Poll for sensor readiness; base the timeout upon the sample rate. */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_PRS_RDY,
-				      DPS310_POLL_SLEEP_US(timeout), timeout);
-	if (rc)
+	rc = dps310_check_reset_meas_cfg(data, DPS310_PRS_RDY);
+	if (rc < 0)
 		goto done;
 
+	if (rc > 0) {
+		rate = dps310_get_pres_samp_freq(data);
+		timeout = DPS310_POLL_TIMEOUT_US(rate);
+
+		/*
+		 * Poll for sensor readiness; base the timeout upon the sample
+		 * rate.
+		 */
+		rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
+					      ready, ready & DPS310_PRS_RDY,
+					      DPS310_POLL_SLEEP_US(timeout),
+					      timeout);
+		if (rc)
+			goto done;
+	}
+
 	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (rc < 0)
 		goto done;
@@ -458,16 +506,26 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rate = dps310_get_temp_samp_freq(data);
-	timeout = DPS310_POLL_TIMEOUT_US(rate);
-
-	/* Poll for sensor readiness; base the timeout upon the sample rate. */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_TMP_RDY,
-				      DPS310_POLL_SLEEP_US(timeout), timeout);
+	rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
 	if (rc < 0)
 		goto done;
 
+	if (rc > 0) {
+		rate = dps310_get_temp_samp_freq(data);
+		timeout = DPS310_POLL_TIMEOUT_US(rate);
+
+		/*
+		 * Poll for sensor readiness; base the timeout upon the sample
+		 * rate.
+		 */
+		rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
+					      ready, ready & DPS310_TMP_RDY,
+					      DPS310_POLL_SLEEP_US(timeout),
+					      timeout);
+		if (rc < 0)
+			goto done;
+	}
+
 	rc = dps310_read_temp_ready(data);
 
 done:
-- 
2.27.0

