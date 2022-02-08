Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CB4ADC70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379932AbiBHPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiBHPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:22:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D7EC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:22:52 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218FJr1k022571;
        Tue, 8 Feb 2022 15:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7Nd3Aqu5GSUc7ufPYdpXEDMVSBOTXTZdY/rvQNBskZM=;
 b=j1DzlaR7cOd6O0V0VcR5HJdHGIVD2Sx8vnPbeD5KjIarqNuAfFbJLA4m5Xur4PqHEtn8
 mc2v8ZNOYpBdrOeG6Cdi/VdsPV5bt/g2/0SowML/G7ODU5DSJ+yllXCRoEPn/MRyFs2t
 E16VxYwInn/WOMH14qGC41mQDrAAMC5EjPWNu1jlstHDyy2607hEshSDZEnCcF+HPYC+
 zo46D6N5bOhO2iYfdl7zmW/BhixfMeWnrQR/WRw0yirKcgEaMW4Vsacaa9UYDwf2i6If
 3eb6WMjt5NH3ZHwCeTqvQBBNvQc/eyk628GbTJRGE2Mbnk8NeMgorbzG8MiMdDfIRszZ BA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e23aptktm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:22:42 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218FKQbP017636;
        Tue, 8 Feb 2022 15:22:41 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3e3gpycyk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:22:41 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218FMdkm33358174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 15:22:40 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA901AC069;
        Tue,  8 Feb 2022 15:22:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4364AC059;
        Tue,  8 Feb 2022 15:22:38 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.31.52])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 15:22:38 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] fsi: occ: Improve response status checking
Date:   Tue,  8 Feb 2022 09:22:35 -0600
Message-Id: <20220208152235.19686-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pI-K0_EtWyj7FyGzhFWMjSKB9ONB-O_2
X-Proofpoint-ORIG-GUID: pI-K0_EtWyj7FyGzhFWMjSKB9ONB-O_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver sequence number coincidentally equals the previous
command response sequence number, the driver may proceed with
fetching the entire buffer before the OCC has processed the current
command. To be sure the correct response is obtained, check the
command type and also retry if any of the response parameters have
changed when the rest of the buffer is fetched. Also initialize the
driver with a random sequence number in order to reduce the chances
of this happening.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Refactor the retry into one loop
 - Add a comment about the pseudo-random number

 drivers/fsi/fsi-occ.c | 87 ++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 7eaab1be0aa4..c9cc75fbdfb9 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -451,6 +451,14 @@ static int occ_trigger_attn(struct occ *occ)
 	return rc;
 }
 
+static bool fsi_occ_response_not_ready(struct occ_response *resp, u8 seq_no,
+				       u8 cmd_type)
+{
+	return resp->return_status == OCC_RESP_CMD_IN_PRG ||
+		resp->return_status == OCC_RESP_CRIT_INIT ||
+		resp->seq_no != seq_no || resp->cmd_type != cmd_type;
+}
+
 int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		   void *response, size_t *resp_len)
 {
@@ -461,10 +469,11 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	struct occ_response *resp = response;
 	size_t user_resp_len = *resp_len;
 	u8 seq_no;
+	u8 cmd_type;
 	u16 checksum = 0;
 	u16 resp_data_length;
 	const u8 *byte_request = (const u8 *)request;
-	unsigned long start;
+	unsigned long end;
 	int rc;
 	size_t i;
 
@@ -478,6 +487,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		return -EINVAL;
 	}
 
+	cmd_type = byte_request[1];
+
 	/* Checksum the request, ignoring first byte (sequence number). */
 	for (i = 1; i < req_len - 2; ++i)
 		checksum += byte_request[i];
@@ -509,51 +520,61 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	if (rc)
 		goto done;
 
-	/* Read occ response header */
-	start = jiffies;
-	do {
+	end = jiffies + timeout;
+	while (true) {
+		/* Read occ response header */
 		rc = occ_getsram(occ, 0, resp, 8);
 		if (rc)
 			goto done;
 
-		if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
-		    resp->return_status == OCC_RESP_CRIT_INIT ||
-		    resp->seq_no != seq_no) {
-			rc = -ETIMEDOUT;
-
-			if (time_after(jiffies, start + timeout)) {
-				dev_err(occ->dev, "resp timeout status=%02x "
-					"resp seq_no=%d our seq_no=%d\n",
+		if (fsi_occ_response_not_ready(resp, seq_no, cmd_type)) {
+			if (time_after(jiffies, end)) {
+				dev_err(occ->dev,
+					"resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
 					resp->return_status, resp->seq_no,
-					seq_no);
+					resp->cmd_type, seq_no, cmd_type);
+				rc = -ETIMEDOUT;
 				goto done;
 			}
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(wait_time);
-		}
-	} while (rc);
-
-	/* Extract size of response data */
-	resp_data_length = get_unaligned_be16(&resp->data_length);
+		} else {
+			/* Extract size of response data */
+			resp_data_length =
+				get_unaligned_be16(&resp->data_length);
+
+			/*
+			 * Message size is data length + 5 bytes header + 2
+			 * bytes checksum
+			 */
+			if ((resp_data_length + 7) > user_resp_len) {
+				rc = -EMSGSIZE;
+				goto done;
+			}
 
-	/* Message size is data length + 5 bytes header + 2 bytes checksum */
-	if ((resp_data_length + 7) > user_resp_len) {
-		rc = -EMSGSIZE;
-		goto done;
+			/*
+			 * Get the entire response including the header again,
+			 * in case it changed
+			 */
+			if (resp_data_length > 1) {
+				rc = occ_getsram(occ, 0, resp,
+						 resp_data_length + 7);
+				if (rc)
+					goto done;
+
+				if (!fsi_occ_response_not_ready(resp, seq_no,
+								cmd_type))
+					break;
+			} else {
+				break;
+			}
+		}
 	}
 
 	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
 		resp->return_status, resp_data_length);
 
-	/* Grab the rest */
-	if (resp_data_length > 1) {
-		/* already got 3 bytes resp, also need 2 bytes checksum */
-		rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
-		if (rc)
-			goto done;
-	}
-
 	occ->client_response_size = resp_data_length + 7;
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
 
@@ -598,7 +619,11 @@ static int occ_probe(struct platform_device *pdev)
 	occ->version = (uintptr_t)of_device_get_match_data(dev);
 	occ->dev = dev;
 	occ->sbefifo = dev->parent;
-	occ->sequence_number = 1;
+	/*
+	 * Quickly derive a pseudo-random number from jiffies so that
+	 * re-probing the driver doesn't accidentally overlap sequence numbers.
+	 */
+	occ->sequence_number = (u8)((jiffies % 0xff) + 1);
 	mutex_init(&occ->occ_lock);
 
 	if (dev->of_node) {
-- 
2.27.0

