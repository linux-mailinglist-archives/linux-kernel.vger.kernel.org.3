Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E450B5341DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiEYQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbiEYQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:59:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0970A502C;
        Wed, 25 May 2022 09:59:05 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PFpQB8017100;
        Wed, 25 May 2022 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PskLGdI9JIgYggRegGXFky41jIqj4v59+3Z8Hb7wQr8=;
 b=rPcUgnvQb+4Ee6ntSk/BejaXX+Y7tX5uRNoFuo2om22OtM+vVj1nVxCRVWTI+s1MJTrf
 Q/W4dSNIaMmhKkv/YANORHUWKKrNm4wanWodEt1GR56rriDvh1+cFjfez0KvrEzUo47l
 fna3+VJaLJgct95n5IGttEcflBMyqNIwTC1S53ij91d/N9MFh+GtYPUYtirdo9kOCxGS
 k2yB03RnY5eYKxsBfFDnomyIv6s3oMKwh49SPYpUL4ZdF3xusyZEZQ+ISySkMvbhgUtW
 1Gsm55zVkl/vwZQhfHBwGGkI5nKYoy2w1z42sMwAFHb4t7DYqKUGkniN7LeFsHfNYWJ8 fQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9pwka7sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 16:59:00 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PGd0BS010050;
        Wed, 25 May 2022 16:59:00 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3g93v895bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 16:59:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PGwxDL5046828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 16:58:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4E4112064;
        Wed, 25 May 2022 16:58:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBEBA112062;
        Wed, 25 May 2022 16:58:58 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.60.201])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 25 May 2022 16:58:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] spi: fsi: Fix spurious timeout
Date:   Wed, 25 May 2022 11:58:51 -0500
Message-Id: <20220525165852.33167-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220525165852.33167-1-eajames@linux.ibm.com>
References: <20220525165852.33167-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0WGKjuUraLEgBZ5lvoe6BQHdSdHgZCl2
X-Proofpoint-ORIG-GUID: 0WGKjuUraLEgBZ5lvoe6BQHdSdHgZCl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may return a timeout error even if the status register
indicates that the transfer may proceed. Fix this by restructuring
the polling loop.

Fixes: 89b35e3f2851 ("spi: fsi: Implement a timeout for polling status")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 I have one concern still, that if the kernel is very busy, it may
 schedule other work for the entire timeout period between assigning
 "end" and checking if timed out in the do/while loop... Is it worth
 worrying about this case?

 drivers/spi/spi-fsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index d403a7a3021d..72ab066ce552 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -319,12 +319,12 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 
 			end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
 			do {
+				if (time_after(jiffies, end))
+					return -ETIMEDOUT;
+
 				rc = fsi_spi_status(ctx, &status, "TX");
 				if (rc)
 					return rc;
-
-				if (time_after(jiffies, end))
-					return -ETIMEDOUT;
 			} while (status & SPI_FSI_STATUS_TDR_FULL);
 
 			sent += nb;
@@ -337,12 +337,12 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 		while (transfer->len > recv) {
 			end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
 			do {
+				if (time_after(jiffies, end))
+					return -ETIMEDOUT;
+
 				rc = fsi_spi_status(ctx, &status, "RX");
 				if (rc)
 					return rc;
-
-				if (time_after(jiffies, end))
-					return -ETIMEDOUT;
 			} while (!(status & SPI_FSI_STATUS_RDR_FULL));
 
 			rc = fsi_spi_read_reg(ctx, SPI_FSI_DATA_RX, &in);
-- 
2.27.0

