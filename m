Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01240557D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiFWOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiFWOGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:06:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235723617E;
        Thu, 23 Jun 2022 07:06:03 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NDX0RA022616;
        Thu, 23 Jun 2022 14:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Mw1yMl/fD0Zq4j57ePRRUlJo/uPSNz1EziavS2iH/jc=;
 b=jJ2bidPwp9R2ANaPIbPe8VXRMM9WytY8XUbVMZiF/eSoKE56k0iUenCEZMWWQV9Cy8QL
 a9FVmP3yWkOcHv/6OBAoxuBxdqIi8tBJaVZnSFwv1VrWxl+tqKizYO2SnIOrFAZ2tNwc
 LCc4hl4gHi+NayeZNWkwTQtERTwFg8uXaUxxwMjZeCNb00Wl9+mjj5+FMku6l7caElbh
 MS2e1MxMQ3ydS/+Q7lXdesEMgK2NJIhC77hl2HbjJCEbC3FaQUDB60fiDFwhW32tfO3N
 jev6CgMOIL0cflPqrmlD96EoifrEL9fwbp5BahNZHL36e2E5qX9jFLs43o0yj/xDMr4I pw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvs5grv3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 14:05:53 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25NDo2N8010852;
        Thu, 23 Jun 2022 14:05:53 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3gs6badqxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 14:05:52 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25NE5qir40305066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:05:52 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2384F124055;
        Thu, 23 Jun 2022 14:05:52 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C0BD124052;
        Thu, 23 Jun 2022 14:05:51 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.65.248.89])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jun 2022 14:05:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: fsi: Increase timeout and ensure status is checked
Date:   Thu, 23 Jun 2022 09:05:47 -0500
Message-Id: <20220623140547.71762-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6rgb2-LiSM2YP9eR6IkVWYVYufM7ExEH
X-Proofpoint-ORIG-GUID: 6rgb2-LiSM2YP9eR6IkVWYVYufM7ExEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_05,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only timeout after at least one iteration of checking the
status registers. In addition, increase the transfer timeout
to 1 second.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 72ab066ce552..cf1e4f9ebd72 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -24,8 +24,7 @@
 #define FSI2SPI_IRQ			0x20
 
 #define SPI_FSI_BASE			0x70000
-#define SPI_FSI_INIT_TIMEOUT_MS		1000
-#define SPI_FSI_STATUS_TIMEOUT_MS	100
+#define SPI_FSI_TIMEOUT_MS		1000
 #define SPI_FSI_MAX_RX_SIZE		8
 #define SPI_FSI_MAX_TX_SIZE		40
 
@@ -299,6 +298,7 @@ static void fsi_spi_sequence_init(struct fsi_spi_sequence *seq)
 static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 				 struct spi_transfer *transfer)
 {
+	int loops;
 	int rc = 0;
 	unsigned long end;
 	u64 status = 0ULL;
@@ -317,9 +317,10 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 			if (rc)
 				return rc;
 
-			end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
+			loops = 0;
+			end = jiffies + msecs_to_jiffies(SPI_FSI_TIMEOUT_MS);
 			do {
-				if (time_after(jiffies, end))
+				if (loops++ && time_after(jiffies, end))
 					return -ETIMEDOUT;
 
 				rc = fsi_spi_status(ctx, &status, "TX");
@@ -335,9 +336,10 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 		u8 *rx = transfer->rx_buf;
 
 		while (transfer->len > recv) {
-			end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
+			loops = 0;
+			end = jiffies + msecs_to_jiffies(SPI_FSI_TIMEOUT_MS);
 			do {
-				if (time_after(jiffies, end))
+				if (loops++ && time_after(jiffies, end))
 					return -ETIMEDOUT;
 
 				rc = fsi_spi_status(ctx, &status, "RX");
@@ -359,6 +361,7 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 
 static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 {
+	int loops = 0;
 	int rc;
 	bool reset = false;
 	unsigned long end;
@@ -369,9 +372,9 @@ static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 		SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
 		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 19);
 
-	end = jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
+	end = jiffies + msecs_to_jiffies(SPI_FSI_TIMEOUT_MS);
 	do {
-		if (time_after(jiffies, end))
+		if (loops++ && time_after(jiffies, end))
 			return -ETIMEDOUT;
 
 		rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
-- 
2.31.1

