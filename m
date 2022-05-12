Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCDF5256D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358625AbiELVBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358599AbiELVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:00:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D982558B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:00:57 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CKuFUZ030686;
        Thu, 12 May 2022 21:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1KwfhkldnBNAglWnX9p2UAFz4cu4GJ4dugWpMyEm/YU=;
 b=M+Aq3G8xD2cr+Z0cpB3tIs9aRkoK4gcspKMbSZKV2OEBMU+gXTo8T4sbojYMj4FCT7ux
 UK0rOUrmPNp66pqFaa8rGBv0C3QiHh2yvIhZUIzpGxCza9XTKDIl5Di7XP5C3/8O+oV4
 g+NtI5i1p42FbHqOHbspJUJn6gDmgy0sK3IQH1Kh4Ghrf/pX6QfHtYcvAL0sRLvbD2BD
 WBOhZaLqxZjPINDAiuezMXD5/B9ICCwTqKy+PGamGHx3w/nXxsSoKkCKNCQKxl5+TKyd
 LvJRIzlpsdZzn4sg6aDCVB4x3oEVIyWvuG/0hm+JO3XzHjhjmwwGD+x1sUNc1X7h4g/J uQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g19q6g2ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 21:00:45 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CKwSOW017618;
        Thu, 12 May 2022 21:00:45 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3fwgday76c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 21:00:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CL0iDk32768334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:00:44 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED2F313605D;
        Thu, 12 May 2022 21:00:43 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A11FD136055;
        Thu, 12 May 2022 21:00:43 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.56.168])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 21:00:43 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au,
        alistair@popple.id.au, jk@ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: occ: Prevent use after free
Date:   Thu, 12 May 2022 16:00:34 -0500
Message-Id: <20220512210034.59907-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j2hZuXqg4k_jRswtDikHsB2aCBsJaAvY
X-Proofpoint-ORIG-GUID: j2hZuXqg4k_jRswtDikHsB2aCBsJaAvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_17,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120087
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

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index c9cc75fbdfb9..9e48dc62b1c5 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -82,6 +82,9 @@ static int occ_open(struct inode *inode, struct file *file)
 	struct miscdevice *mdev = file->private_data;
 	struct occ *occ = to_occ(mdev);
 
+	if (!occ->buffer)
+		return -ENOENT;
+
 	if (!client)
 		return -ENOMEM;
 
@@ -94,6 +97,7 @@ static int occ_open(struct inode *inode, struct file *file)
 	client->occ = occ;
 	mutex_init(&client->lock);
 	file->private_data = client;
+	get_device(occ->dev);
 
 	/* We allocate a 1-page buffer, make sure it all fits */
 	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
@@ -143,7 +147,7 @@ static ssize_t occ_write(struct file *file, const char __user *buf,
 	ssize_t rc;
 	u8 *cmd;
 
-	if (!client)
+	if (!client || !client->occ->buffer)
 		return -ENODEV;
 
 	if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
@@ -197,6 +201,7 @@ static int occ_release(struct inode *inode, struct file *file)
 {
 	struct occ_client *client = file->private_data;
 
+	put_device(client->occ->dev);
 	free_page((unsigned long)client->buffer);
 	kfree(client);
 
@@ -672,6 +677,7 @@ static int occ_remove(struct platform_device *pdev)
 	struct occ *occ = platform_get_drvdata(pdev);
 
 	kvfree(occ->buffer);
+	occ->buffer = NULL;
 
 	misc_deregister(&occ->mdev);
 
-- 
2.27.0

