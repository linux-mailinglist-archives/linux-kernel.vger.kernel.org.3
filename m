Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2385AF57F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIFULq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiIFULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:11:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89ABD296;
        Tue,  6 Sep 2022 13:05:55 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JuuPC017359;
        Tue, 6 Sep 2022 20:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VVBWBjxd8R8chMmF9p2W/z0k6Cry+a7sL/3ImeWyCP0=;
 b=GolfMr5ApuMFHGJdcopL35jmobM1YXEoJNJAxAu7Zo0INsF6N1ucj73Uso/lJloCLwBQ
 omdXCPeIGzQsoPCecAQMD8iNa2dBR5rg6VFVz0dt5kJTHz5bDBRnHxfmfq8oTNcaoTli
 Qgr5NOXNWCIahz/LcEAgG0tIwpoxK+E2WteZRXrpLda/WvUMTxcnvyvdUEw7R6IXOyOI
 TT+GMWdyJkLzajvXpZN8/hoXzmpaNXr6Fu4+vtj1sRS/lR4PEA0bj9AIfVBLGWrZgu29
 VdZOjaAopsBu/TcQpbKq9rwQtN7x5JYno+GcVAvddl+Ml52SbnlZw8p3hgjNL6XHFCkK Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecthg8jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:05:40 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286Jvg3o019245;
        Tue, 6 Sep 2022 20:05:40 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecthg8jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:05:40 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JoHlS000994;
        Tue, 6 Sep 2022 20:05:39 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 3jbxj9wm2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:05:39 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286K5dhQ27525542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 20:05:39 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CFA76E054;
        Tue,  6 Sep 2022 20:05:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C79886E04E;
        Tue,  6 Sep 2022 20:05:37 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.74.237])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 20:05:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au,
        andy.shevchenko@gmail.com, eajames@linux.ibm.com
Subject: [PATCH v6 2/2] iio: pressure: dps310: Reset chip after timeout
Date:   Tue,  6 Sep 2022 15:05:35 -0500
Message-Id: <20220906200535.1919398-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906200535.1919398-1-eajames@linux.ibm.com>
References: <20220906200535.1919398-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LUyv-CQ9LiDaGPI9iCeX-MIb_rT8s-oa
X-Proofpoint-GUID: VNtokSlpoOk_40kCEeVHUWLbza-Mkmfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPS310 chip has been observed to get "stuck" such that pressure
and temperature measurements are never indicated as "ready" in the
MEAS_CFG register. The only solution is to reset the device and try
again. In order to avoid continual failures, use a boolean flag to
only try the reset after timeout once if errors persist.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/pressure/dps310.c | 78 ++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c706a8b423b5..58571007a24f 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -89,6 +89,7 @@ struct dps310_data {
 	s32 c00, c10, c20, c30, c01, c11, c21;
 	s32 pressure_raw;
 	s32 temp_raw;
+	bool timeout_recovery_failed;
 };
 
 static const struct iio_chan_spec dps310_channels[] = {
@@ -393,11 +394,73 @@ static int dps310_get_temp_k(struct dps310_data *data)
 	return scale_factors[ilog2(rc)];
 }
 
+static int dps310_reset_wait(struct dps310_data *data)
+{
+	int rc;
+
+	rc = regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
+	if (rc)
+		return rc;
+
+	/* Wait for device chip access: 2.5ms in specification */
+	usleep_range(2500, 12000);
+	return 0;
+}
+
+static int dps310_reset_reinit(struct dps310_data *data)
+{
+	int rc;
+
+	rc = dps310_reset_wait(data);
+	if (rc)
+		return rc;
+
+	rc = dps310_startup(data);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
+{
+	int rc;
+	int ready;
+	int sleep = DPS310_POLL_SLEEP_US(timeout);
+
+	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready, ready & ready_bit,
+				      sleep, timeout);
+	if (rc) {
+		if (rc == -ETIMEDOUT && !data->timeout_recovery_failed) {
+			int rc2;
+
+			/* Reset and reinitialize the chip. */
+			rc2 = dps310_reset_reinit(data);
+			if (rc2) {
+				data->timeout_recovery_failed = true;
+			} else {
+				/* Try again to get sensor ready status. */
+				rc2 = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
+							       ready, ready & ready_bit, sleep,
+							       timeout);
+				if (rc2)
+					data->timeout_recovery_failed = true;
+				else
+					return 0;
+			}
+		}
+
+		return rc;
+	}
+
+	data->timeout_recovery_failed = false;
+	return 0;
+}
+
 static int dps310_read_pres_raw(struct dps310_data *data)
 {
 	int rc;
 	int rate;
-	int ready;
 	int timeout;
 	s32 raw;
 	u8 val[3];
@@ -409,9 +472,7 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_PRS_RDY,
-				      DPS310_POLL_SLEEP_US(timeout), timeout);
+	rc = dps310_ready(data, DPS310_PRS_RDY, timeout);
 	if (rc)
 		goto done;
 
@@ -448,7 +509,6 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 {
 	int rc;
 	int rate;
-	int ready;
 	int timeout;
 
 	if (mutex_lock_interruptible(&data->lock))
@@ -458,10 +518,8 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_TMP_RDY,
-				      DPS310_POLL_SLEEP_US(timeout), timeout);
-	if (rc < 0)
+	rc = dps310_ready(data, DPS310_TMP_RDY, timeout);
+	if (rc)
 		goto done;
 
 	rc = dps310_read_temp_ready(data);
@@ -756,7 +814,7 @@ static void dps310_reset(void *action_data)
 {
 	struct dps310_data *data = action_data;
 
-	regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
+	dps310_reset_wait(data);
 }
 
 static const struct regmap_config dps310_regmap_config = {
-- 
2.31.1

