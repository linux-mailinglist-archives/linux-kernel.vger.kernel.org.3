Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC4526AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbiEMToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiEMTov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE544A28
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:44:50 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DJgJkF022348;
        Fri, 13 May 2022 19:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=O47frTHQfxW9j3bbLvoV3G6Z4Y1yD1/DbijZ8vEkL0c=;
 b=EzVEGH/58MP81kCs1KXmWDyAEGJyZjG0BbR/wdY4Yboz6QE5ly2C6mO+oJOasal15Thg
 fw9Mg7R+jGnkAgtcnmub1KCwDKDwXSSXUFQCSxZ+8alQugHOUNXgJGEieZbAWNUAhRM/
 Gktcw5g8Zz6FTsTKOz/13OyKxaChassxEqyxt3AXzUDulu8Fm4VjwOdRZiZ07fm1KIKO
 mMMdKFwIbqkYC0aBIIv282hsIC0cdnE4NRqDWePXwyw/3F6AASwbVQeyeqGrK+tDY1Up
 YH/v2HDGlHxYCWKwwOzKFRtyZ1+UEkgvuUEYa2C0aOJ8hys1UMCVQu0RX60LXaHos1qU cQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1wqc013k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 19:44:30 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DJbtfq009516;
        Fri, 13 May 2022 19:44:28 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3fwgdach91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 19:44:28 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DJiSC130999016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 19:44:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F0C0BE053;
        Fri, 13 May 2022 19:44:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5DB2BE04F;
        Fri, 13 May 2022 19:44:27 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.1.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 19:44:27 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, linux@roeck-us.net,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] fsi: occ: Prevent use after free
Date:   Fri, 13 May 2022 14:44:24 -0500
Message-Id: <20220513194424.53468-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XRHAc22MB7Sv4PkP3GS4e-8Iu_ef3jlw
X-Proofpoint-GUID: XRHAc22MB7Sv4PkP3GS4e-8Iu_ef3jlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use get_device and put_device in the open and close functions to
make sure the device doesn't get freed while a file descriptor is
open.
Also, lock around the freeing of the device buffer and check the
buffer before using it in the submit function.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Add lock around freeing/nulling the buffer in occ_remove
 - Don't bother checking the buffer in open or in write, only in submit

 drivers/fsi/fsi-occ.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index c9cc75fbdfb9..28c176d038a2 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -94,6 +94,7 @@ static int occ_open(struct inode *inode, struct file *file)
 	client->occ = occ;
 	mutex_init(&client->lock);
 	file->private_data = client;
+	get_device(occ->dev);
 
 	/* We allocate a 1-page buffer, make sure it all fits */
 	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
@@ -197,6 +198,7 @@ static int occ_release(struct inode *inode, struct file *file)
 {
 	struct occ_client *client = file->private_data;
 
+	put_device(client->occ->dev);
 	free_page((unsigned long)client->buffer);
 	kfree(client);
 
@@ -493,12 +495,19 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	for (i = 1; i < req_len - 2; ++i)
 		checksum += byte_request[i];
 
-	mutex_lock(&occ->occ_lock);
+	rc = mutex_lock_interruptible(&occ->occ_lock);
+	if (rc)
+		return rc;
 
 	occ->client_buffer = response;
 	occ->client_buffer_size = user_resp_len;
 	occ->client_response_size = 0;
 
+	if (!occ->buffer) {
+		rc = -ENOENT;
+		goto done;
+	}
+
 	/*
 	 * Get a sequence number and update the counter. Avoid a sequence
 	 * number of 0 which would pass the response check below even if the
@@ -671,10 +680,13 @@ static int occ_remove(struct platform_device *pdev)
 {
 	struct occ *occ = platform_get_drvdata(pdev);
 
-	kvfree(occ->buffer);
-
 	misc_deregister(&occ->mdev);
 
+	mutex_lock(&occ->occ_lock);
+	kvfree(occ->buffer);
+	occ->buffer = NULL;
+	mutex_unlock(&occ->occ_lock);
+
 	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
 
 	ida_simple_remove(&occ_ida, occ->idx);
-- 
2.27.0

