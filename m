Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892CB489CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiAJP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:58:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42228 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236654AbiAJP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:58:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AEU7PE022345;
        Mon, 10 Jan 2022 15:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=THGngHhs1M5ZvMB70ZlRu3N+NV0yEyMSs/YfoHRMWZQ=;
 b=eSSq6YFKwA8dVfUg7wilpTfcUd2+2EUB9aUL9t7Ui7vihw9AJ+uKvrHiHwDxZ9pv5juO
 Nyil/gcGoyBZuD3JEdcXlsMJiFBmzbmI+zOFFx0b6RLXvJRi2GP+w0LxliY0x2J/Pi8x
 cBFv4HgnQ94qGw3lNHNg24TJcYed7/8W5M8zqDuhlwUhgSYYtbUXuRMEoNAZRo3RxiMp
 Y3qKwOuXaYCYzZezKSHKG+fYBM35L3Ce8R2tF5cpL+qR1OHjHW5Dc5XabU7HJJUKtu2c
 mhNWJ+QLFyrS7/PpC5hjVvVXYCbUw6htCTtOReUG9u0+Q0i3NqTDZxDJEobClV4U1SBY tg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm8jnsn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 15:58:32 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20AFvxOk004779;
        Mon, 10 Jan 2022 15:58:32 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 3df289qxee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 15:58:31 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20AFwUB624248666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:58:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D13386E05B;
        Mon, 10 Jan 2022 15:58:29 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 853E96E060;
        Mon, 10 Jan 2022 15:58:29 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.155.103])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 15:58:29 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: occ: Improve response status checking
Date:   Mon, 10 Jan 2022 09:58:27 -0600
Message-Id: <20220110155827.13976-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O_-li6IGjSP_5bOPM7ne6r5JAXrqp04S
X-Proofpoint-GUID: O_-li6IGjSP_5bOPM7ne6r5JAXrqp04S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_06,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver sequence number coincidentally equals the previous
command response sequence number, the driver may proceed with
fetching the entire buffer before the OCC has processed the current
command. To be sure the correct response is obtained, check the
command type and also retry if any of the response parameters have
changed when the rest of the buffer is fetched.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 63 ++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 7eaab1be0aa4..67569282dd69 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -451,6 +451,15 @@ static int occ_trigger_attn(struct occ *occ)
 	return rc;
 }
 
+static void fsi_occ_print_timeout(struct occ *occ, struct occ_response *resp,
+				  u8 seq_no, u8 cmd_type)
+{
+	dev_err(occ->dev,
+		"resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
+		resp->return_status, resp->seq_no, resp->cmd_type, seq_no,
+		cmd_type);
+}
+
 int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		   void *response, size_t *resp_len)
 {
@@ -461,12 +470,14 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
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
+	bool retried = false;
 
 	*resp_len = 0;
 
@@ -478,6 +489,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		return -EINVAL;
 	}
 
+	cmd_type = byte_request[1];
+
 	/* Checksum the request, ignoring first byte (sequence number). */
 	for (i = 1; i < req_len - 2; ++i)
 		checksum += byte_request[i];
@@ -509,30 +522,30 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	if (rc)
 		goto done;
 
-	/* Read occ response header */
-	start = jiffies;
+retry:
+	end = jiffies + timeout;
 	do {
+		/* Read occ response header */
 		rc = occ_getsram(occ, 0, resp, 8);
 		if (rc)
 			goto done;
 
 		if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
 		    resp->return_status == OCC_RESP_CRIT_INIT ||
-		    resp->seq_no != seq_no) {
-			rc = -ETIMEDOUT;
-
-			if (time_after(jiffies, start + timeout)) {
-				dev_err(occ->dev, "resp timeout status=%02x "
-					"resp seq_no=%d our seq_no=%d\n",
-					resp->return_status, resp->seq_no,
-					seq_no);
+		    resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
+			if (time_after(jiffies, end)) {
+				fsi_occ_print_timeout(occ, resp, seq_no,
+						      cmd_type);
+				rc = -ETIMEDOUT;
 				goto done;
 			}
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(wait_time);
+		} else {
+			break;
 		}
-	} while (rc);
+	} while (true);
 
 	/* Extract size of response data */
 	resp_data_length = get_unaligned_be16(&resp->data_length);
@@ -543,17 +556,29 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		goto done;
 	}
 
-	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
-		resp->return_status, resp_data_length);
-
-	/* Grab the rest */
+	/* Now get the entire response; get header again in case it changed */
 	if (resp_data_length > 1) {
-		/* already got 3 bytes resp, also need 2 bytes checksum */
-		rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
+		rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
 		if (rc)
 			goto done;
+
+		if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
+		    resp->return_status == OCC_RESP_CRIT_INIT ||
+		    resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
+			if (!retried) {
+				retried = true;
+				goto retry;
+			}
+
+			fsi_occ_print_timeout(occ, resp, seq_no, cmd_type);
+			rc = -ETIMEDOUT;
+			goto done;
+		}
 	}
 
+	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
+		resp->return_status, resp_data_length);
+
 	occ->client_response_size = resp_data_length + 7;
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
 
@@ -598,7 +623,7 @@ static int occ_probe(struct platform_device *pdev)
 	occ->version = (uintptr_t)of_device_get_match_data(dev);
 	occ->dev = dev;
 	occ->sbefifo = dev->parent;
-	occ->sequence_number = 1;
+	occ->sequence_number = (u8)((jiffies % 0xff) + 1);
 	mutex_init(&occ->occ_lock);
 
 	if (dev->of_node) {
-- 
2.27.0

