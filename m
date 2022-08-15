Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE259312D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiHOO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiHOO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:57:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7671D0E2;
        Mon, 15 Aug 2022 07:57:25 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FEOq3K010791;
        Mon, 15 Aug 2022 14:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OvlQmTVemG8EiyWu0yU7RSGgTkAK6+cyFaZlq4Pif14=;
 b=kp+LstZm9FQh6AKzparnStKWEunea4bKHlByN3UOuKCK3VSfdBsYniWj2hGk+xfRzwxp
 hZun/T9dS3OmJXnth3BSEtwiOoBsoOYkNGoUVvtNubcn7Ae1La75ihi13WvzGpvfK8IO
 iDpeGJ+4BS4szhv9CrVQ7b2BItfBWFZ3JwtQ1XBmuE5P/hLjGR159R7GWa8S+fKHFojq
 +4i/BgfwxA9+x7+AKrIFsa7dBCfTBTUcBb/nEHYzG5aah5OGJ03wDOanl8/3TURil4KS
 HmQ67C44l42gdDXiy8Zn6JjwUHz3L73M2LQgzHU6MpVdvz8XrxbmJovjTUEH4YAIIGW5 WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyqvtgtkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:57:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27FEv4fA013401;
        Mon, 15 Aug 2022 14:57:11 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyqvtgtjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:57:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27FEoIN7018080;
        Mon, 15 Aug 2022 14:57:10 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3hx3k94jas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:57:10 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27FEv9NQ2294400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 14:57:09 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50A31136051;
        Mon, 15 Aug 2022 14:57:09 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A91613604F;
        Mon, 15 Aug 2022 14:57:08 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.146.160])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Aug 2022 14:57:08 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, eajames@linux.ibm.com,
        andy.shevchenko@gmail.com, joel@jms.id.au
Subject: [PATCH v5 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Mon, 15 Aug 2022 09:57:05 -0500
Message-Id: <20220815145705.203017-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220815145705.203017-1-eajames@linux.ibm.com>
References: <20220815145705.203017-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p2d5rfkBPMceb7wf9FAXzPwN6vNY5AaJ
X-Proofpoint-ORIG-GUID: c1KLPz-_6lUu6MSaGWcFDSpSpofrcSCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150056
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
 drivers/iio/pressure/dps310.c | 89 +++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c706a8b423b5..bbeb2f3bcc8a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -393,6 +393,45 @@ static int dps310_get_temp_k(struct dps310_data *data)
 	return scale_factors[ilog2(rc)];
 }
 
+/*
+ * Called with lock held. Returns a negative value on error, a positive value
+ * when the device is not ready, and zero when the device is ready.
+ */
+static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
+{
+	int rc;
+	int meas_cfg;
+
+	rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
+	if (rc)
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
+	if (rc)
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
@@ -405,16 +444,26 @@ static int dps310_read_pres_raw(struct dps310_data *data)
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
@@ -454,16 +503,26 @@ static int dps310_read_temp_raw(struct dps310_data *data)
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
+		if (rc)
+			goto done;
+	}
+
 	rc = dps310_read_temp_ready(data);
 
 done:
-- 
2.31.1

