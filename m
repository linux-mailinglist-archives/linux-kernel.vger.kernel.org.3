Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5C58E191
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiHIVNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHIVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:13:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06631606B5;
        Tue,  9 Aug 2022 14:13:04 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JWIDh018307;
        Tue, 9 Aug 2022 21:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=351BzqKDUhe+LZKnnWVDBkrHijm84Tf1yyG2CK0rOAs=;
 b=LwMUMA61fMirJGUN52t8SPHJRv/2mhscH0vK4z9ATa8F43fg3SGZQtow9NY+Um/Nv1ep
 5msWXbegxMM0qek6mSCF+dJnDmaebpLMNw4SOzf0PZoh4CLe20hiHakAyrQ3/iNN5q48
 FsdJfGfl/dVDPlmN32ZXcLN2sgeFX2Kw0dlp4vLKsnLiP3ETin3juyMLvdmXuuaFQtUC
 x5MPDevxUrM7NcC0z1e7vanurD2e/XlihrnzE0wAr4Gh/YWs84vJbhG+PlOdnz82tZ7c
 0J2hvnUKEjLZImMpuFpEHX5YLjB6eF6+9upMNchx7Aaqadva4QoM8Bfm4ciXeDDWWfDo 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwtyavmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 21:12:50 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 279KqEDv023798;
        Tue, 9 Aug 2022 21:12:50 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwtyavma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 21:12:50 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279L5rhP001224;
        Tue, 9 Aug 2022 21:12:49 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3huwvw0knr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 21:12:49 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279LCmtu1180350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 21:12:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A3FB2066;
        Tue,  9 Aug 2022 21:12:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F39C0B2065;
        Tue,  9 Aug 2022 21:12:47 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 21:12:47 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, joel@jms.id.au, eajames@linux.ibm.com
Subject: [PATCH v4 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Tue,  9 Aug 2022 16:12:46 -0500
Message-Id: <20220809211246.251006-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809211246.251006-1-eajames@linux.ibm.com>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -yynYTX6f6bM2jTepjhcsehB1LjmQf0Q
X-Proofpoint-GUID: ja_sKYht4ot6FHq7nMIcye2_8i0vD-wP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208090078
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
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/iio/pressure/dps310.c | 88 +++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c706a8b423b5..3a1aeeea3cdd 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -393,6 +393,44 @@ static int dps310_get_temp_k(struct dps310_data *data)
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
@@ -405,16 +443,26 @@ static int dps310_read_pres_raw(struct dps310_data *data)
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
@@ -454,16 +502,26 @@ static int dps310_read_temp_raw(struct dps310_data *data)
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
2.31.1

