Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4455EFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiF1Uau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiF1Uas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:30:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE00564FB;
        Tue, 28 Jun 2022 13:30:46 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SKRU1P021107;
        Tue, 28 Jun 2022 20:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=B7ZsdCmzeX1AEGJ4+n9A1QiMbSEWdy0D1odXDHOtNDw=;
 b=YvYq7/pk6SYlCUiCCAhmJ9bNBUYt3KdSffmZBZ/IL603kpj5zdkA7em3m+daE1s9qtvp
 goauyOCqyKmy4jNXB/CaILIcS1HN+nN3gOLLl3BrIuf2sRjYXbVMwP+LUHqL4IgrAV5U
 RxOIYlElzH4UkLwZIHR6dpLdDr5xcBTZ0Yu36QQYiFYI5eVGgAnOp0Cefm+mnyKA7pNi
 f+12LLWZd+JT29beFTj8fSFJPcvtivrjDHazEavAZK0qY3aj6436SIlz2wW7s6x1V2LK
 zqUQ/B8jvxfozOB/F6kRi7R0j3IyILruWLROBU7Uf/czMxonYY/9iURLPajjRbftw9+g Jw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h08pv01fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 20:30:32 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SKKiXc030459;
        Tue, 28 Jun 2022 20:30:31 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 3gwt09rvc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 20:30:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SKUVT428705192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:30:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AFA5AC059;
        Tue, 28 Jun 2022 20:30:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0EE1AC05B;
        Tue, 28 Jun 2022 20:30:30 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.160.43.21])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 20:30:30 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon: (occ) Prevent power cap command overwriting poll response
Date:   Tue, 28 Jun 2022 15:30:29 -0500
Message-Id: <20220628203029.51747-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RelTZ5-5zkQYxJC3a6jTVhEC1etL7LA7
X-Proofpoint-ORIG-GUID: RelTZ5-5zkQYxJC3a6jTVhEC1etL7LA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the response to the power cap command overwrites the
first eight bytes of the poll response, since the commands use
the same buffer. This means that user's get the wrong data between
the time of sending the power cap and the next poll response update.
Fix this by specifying a different buffer for the power cap command
response.

Fixes: 5b5513b88002 ("hwmon: Add On-Chip Controller (OCC) hwmon driver")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c |  5 +++--
 drivers/hwmon/occ/common.h |  3 ++-
 drivers/hwmon/occ/p8_i2c.c | 13 +++++++------
 drivers/hwmon/occ/p9_sbe.c |  7 +++----
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index ea070b91e5b9..157b73a3da29 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -145,7 +145,7 @@ static int occ_poll(struct occ *occ)
 	cmd[6] = 0;			/* checksum lsb */
 
 	/* mutex should already be locked if necessary */
-	rc = occ->send_cmd(occ, cmd, sizeof(cmd));
+	rc = occ->send_cmd(occ, cmd, sizeof(cmd), &occ->resp, sizeof(occ->resp));
 	if (rc) {
 		occ->last_error = rc;
 		if (occ->error_count++ > OCC_ERROR_COUNT_THRESHOLD)
@@ -182,6 +182,7 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
 {
 	int rc;
 	u8 cmd[8];
+	u8 resp[8];
 	__be16 user_power_cap_be = cpu_to_be16(user_power_cap);
 
 	cmd[0] = 0;	/* sequence number */
@@ -198,7 +199,7 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
 	if (rc)
 		return rc;
 
-	rc = occ->send_cmd(occ, cmd, sizeof(cmd));
+	rc = occ->send_cmd(occ, cmd, sizeof(cmd), resp, sizeof(resp));
 
 	mutex_unlock(&occ->lock);
 
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 64d5ec7e169b..7ac4b2febce6 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -96,7 +96,8 @@ struct occ {
 
 	int powr_sample_time_us;	/* average power sample time */
 	u8 poll_cmd_data;		/* to perform OCC poll command */
-	int (*send_cmd)(struct occ *occ, u8 *cmd, size_t len);
+	int (*send_cmd)(struct occ *occ, u8 *cmd, size_t len, void *resp,
+			size_t resp_len);
 
 	unsigned long next_update;
 	struct mutex lock;		/* lock OCC access */
diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
index da39ea28df31..b221be1f35f3 100644
--- a/drivers/hwmon/occ/p8_i2c.c
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -111,7 +111,8 @@ static int p8_i2c_occ_putscom_be(struct i2c_client *client, u32 address,
 				      be32_to_cpu(data1));
 }
 
-static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
+static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
+			       void *resp, size_t resp_len)
 {
 	int i, rc;
 	unsigned long start;
@@ -120,7 +121,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	const long wait_time = msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
 	struct p8_i2c_occ *ctx = to_p8_i2c_occ(occ);
 	struct i2c_client *client = ctx->client;
-	struct occ_response *resp = &occ->resp;
+	struct occ_response *or = (struct occ_response *)resp;
 
 	start = jiffies;
 
@@ -151,7 +152,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 			return rc;
 
 		/* wait for OCC */
-		if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
+		if (or->return_status == OCC_RESP_CMD_IN_PRG) {
 			rc = -EALREADY;
 
 			if (time_after(jiffies, start + timeout))
@@ -163,7 +164,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	} while (rc);
 
 	/* check the OCC response */
-	switch (resp->return_status) {
+	switch (or->return_status) {
 	case OCC_RESP_CMD_IN_PRG:
 		rc = -ETIMEDOUT;
 		break;
@@ -192,8 +193,8 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	if (rc < 0)
 		return rc;
 
-	data_length = get_unaligned_be16(&resp->data_length);
-	if (data_length > OCC_RESP_DATA_BYTES)
+	data_length = get_unaligned_be16(&or->data_length);
+	if ((data_length + 7) > resp_len)
 		return -EMSGSIZE;
 
 	/* fetch the rest of the response data */
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 01405ae2f9bd..c1e0a1d96cd4 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -77,11 +77,10 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
 	return notify;
 }
 
-static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
+static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
+			       void *resp, size_t resp_len)
 {
-	struct occ_response *resp = &occ->resp;
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
-	size_t resp_len = sizeof(*resp);
 	int rc;
 
 	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
@@ -95,7 +94,7 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 		return rc;
 	}
 
-	switch (resp->return_status) {
+	switch (((struct occ_response *)resp)->return_status) {
 	case OCC_RESP_CMD_IN_PRG:
 		rc = -ETIMEDOUT;
 		break;
-- 
2.31.1

