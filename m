Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78DA4859F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbiAEUX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:23:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243981AbiAEUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:23:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205JnIdk023862;
        Wed, 5 Jan 2022 20:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U6KcrYf76CYBoxXJ2C50jdfzFdGQy4doODkR1eRg3mQ=;
 b=dGQouNd+lrshMLbrL8pfOkowE5G2AXz2pX47JdOUQcaweObQPfXHGB2078Fhy6349Jod
 K2xRUyGc+2sVoG5/mDuR0CzCxnm2NR0VCE1nbxuslhAa5UhPM1cZIw/+ytv3iylXRVYA
 G5598g4N+aa9xpRuwFOTKeFq+laxWCyfPQ4Uu2YFkrbah3k/15TEwN56O+/fO7aE8eun
 X0OcDq2aUsHL0ZL2Fq0obQgQlJZ4YK4kXhYeaz/R3R7R+fGvcJJ6BSqYgqdm5PNQAGgE
 UvgR1KlmfnWYtVGjS/SzN8X6QBQOOLTKc97i8ZW5uKNDbFP7rHkf8nW6fmseyck/JrqE BQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dck05twdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 20:23:16 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 205KJ7go029542;
        Wed, 5 Jan 2022 20:23:16 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3daekbe78m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 20:23:16 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 205KNE5r19792368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 20:23:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC331BE061;
        Wed,  5 Jan 2022 20:23:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 642DBBE054;
        Wed,  5 Jan 2022 20:23:14 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.73.224])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 20:23:14 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH] fsi: occ: Fetch OCC response header again to avoid checksum failure
Date:   Wed,  5 Jan 2022 14:23:13 -0600
Message-Id: <20220105202313.27510-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BwhVA-tj4LPKcsNkGKZ2N0wgGfn68tgJ
X-Proofpoint-GUID: BwhVA-tj4LPKcsNkGKZ2N0wgGfn68tgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_06,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that the driver state is reset, and the previous OCC
operation had a sequence number of 1, there is the possibility that
the SRAM buffer is updated in between fetching the OCC response header
and the rest of the data (since the sequence number match is really a
false positive). This results in a checksum failure. To avoid this
condition, simply fetch the whole response rather than skipping the
header when fetching the rest of the response.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 7eaab1be0aa4..660c3fc43be5 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -546,10 +546,15 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
 		resp->return_status, resp_data_length);
 
-	/* Grab the rest */
+	/*
+	 * Grab the rest, including the occ response header again, just in case
+	 * it changed in between our two getsram operations (this can happen
+	 * despite the sequence number check if the driver state is reset). The
+	 * data length shouldn't change at OCC runtime, and the response
+	 * status, which may have changed, has to be checked by users anyway.
+	 */
 	if (resp_data_length > 1) {
-		/* already got 3 bytes resp, also need 2 bytes checksum */
-		rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
+		rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
 		if (rc)
 			goto done;
 	}
-- 
2.27.0

