Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4552BE49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiEROtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiEROtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:49:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34B14041F;
        Wed, 18 May 2022 07:49:00 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IEgklD017414;
        Wed, 18 May 2022 14:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nS8D3m0qnTY32libStK8Li5Fg+hpem4T/K7bui0sFoE=;
 b=LAVK+5e5u+rFLxEkv2157ymojWBNmWKHPSUW9pj5rSEzyLWtaji0nmAyHTOcQvYf0rtJ
 Td+dqNzuy6WGhFvHC5FQ7dShuHnCCaOBYBlfghmfgm4fRSKvTri7vjmJXmgibi5D5JsY
 HwWokNV60DwLd9/jo908izzNCpmXdJpPqjwgQEfhdAkEg9bxEwWCtJTWcrt5CQddw3RB
 fgB658iH1uikRGEGJa8S8Q0XP/zMcdQfjGbuWEpZyZge2FIYJlDjxwjfyMg4g+M+8c+5
 lNefTdnkBD+u9b2eTi4Q0JEwgFtzaPva+lCT0quTnVsw3gAWtG8SXt2MoM0pdxDowCkw fw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g52t70500-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:48:25 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IEloM5014767;
        Wed, 18 May 2022 14:48:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3g242amemb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:48:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IEmNKU12845410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 14:48:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7D01BE054;
        Wed, 18 May 2022 14:48:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60F60BE051;
        Wed, 18 May 2022 14:48:23 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.6.139])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 14:48:23 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Wed, 18 May 2022 09:48:18 -0500
Message-Id: <20220518144818.12957-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518144818.12957-1-eajames@linux.ibm.com>
References: <20220518144818.12957-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ewn2x_d5IaGYUIhWUkRgYKkT3-ALCWfZ
X-Proofpoint-ORIG-GUID: Ewn2x_d5IaGYUIhWUkRgYKkT3-ALCWfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_05,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180087
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

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 89 ++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f79b274bb38d..c6d02679ef33 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -397,6 +397,39 @@ static int dps310_get_temp_k(struct dps310_data *data)
 	return scale_factors[ilog2(rc)];
 }
 
+/* Called with lock held */
+static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
+{
+	int en = DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND;
+	int meas_cfg;
+	int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
+
+	if (rc < 0)
+		return rc;
+
+	if (meas_cfg & ready_bit)
+		return 0;
+
+	if ((meas_cfg & en) != en) {
+		/* DPS310 register state corrupt, better start from scratch */
+		rc = regmap_write(data->regmap, DPS310_RESET,
+				  DPS310_RESET_MAGIC);
+		if (rc < 0)
+			return rc;
+
+		/* Wait for device chip access: 2.5ms in specification */
+		usleep_range(2500, 12000);
+		rc = dps310_startup(data);
+		if (rc)
+			return rc;
+
+		dev_info(&data->client->dev,
+			 "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
+	}
+
+	return 1;
+}
+
 static int dps310_read_pres_raw(struct dps310_data *data)
 {
 	int rc;
@@ -409,15 +442,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
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
-		goto done;
+	rc = dps310_check_reset_meas_cfg(data, DPS310_PRS_RDY);
+	if (rc) {
+		if (rc < 0)
+			goto done;
+
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
 
 	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (rc < 0)
@@ -458,15 +501,25 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rate = dps310_get_temp_samp_freq(data);
-	timeout = DPS310_POLL_TIMEOUT_US(rate);
-
-	/* Poll for sensor readiness; base the timeout upon the sample rate. */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_TMP_RDY,
-				      DPS310_POLL_SLEEP_US(timeout), timeout);
-	if (rc < 0)
-		goto done;
+	rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
+	if (rc) {
+		if (rc < 0)
+			goto done;
+
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
 
 	rc = dps310_read_temp_ready(data);
 
-- 
2.27.0

