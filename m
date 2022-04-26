Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D9510230
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352558AbiDZPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352551AbiDZPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:53:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FC215A06;
        Tue, 26 Apr 2022 08:50:23 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QEqHTQ028347;
        Tue, 26 Apr 2022 15:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HivLTjqbzBCBaikXt5AvUAAbmkuirudbNVPlx8Eq4x8=;
 b=XZ+siAM9tv/Bdph19f1pgIWJ0vxwfF2nWZw6QL0qyPlNxfOQxaEZi+X2HtHRVGWPwQDT
 RF0uYHf4dO2THJB1RPo8jTGN6J06IjsvXf4/jOvuGfj6p2wW0aY6KLCEpJAhRUcmmV04
 yXHJ4qOlGFahKkMbxXkwBsnd0l8g27OC233rFYwn/7pmgEEU3VOjipSNKu1XamUbcaqc
 YIGK//7CuMP67nkl8ZPJfS8UgWHrPEeee+jD6OIwQfLlHyNYGbr/Ou1xNd7Gx80J5MCj
 Fmr2G1UyqdRmeHIndt5rzQ4wJZ2mxGerINqx4sdCpXblThxGVade63FFJ+v29PYEGHrP 7w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpjvds9ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:50:00 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QFgVRB031583;
        Tue, 26 Apr 2022 15:49:59 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3fm939ufua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:49:59 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QFnw2T18809316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:49:58 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 437B6BE058;
        Tue, 26 Apr 2022 15:49:58 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBCD5BE05D;
        Tue, 26 Apr 2022 15:49:57 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.59])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 15:49:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        jk@ozlabs.org, David.Laight@ACULAB.COM
Subject: [PATCH v2 2/2] hwmon (occ): Retry for checksum failure
Date:   Tue, 26 Apr 2022 10:49:56 -0500
Message-Id: <20220426154956.27205-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220426154956.27205-1-eajames@linux.ibm.com>
References: <20220426154956.27205-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sBpmEXBON5v5jGGSv5NPsiFEPloPPrx2
X-Proofpoint-ORIG-GUID: sBpmEXBON5v5jGGSv5NPsiFEPloPPrx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_04,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the OCC communication design with a shared SRAM area,
checkum errors are expected due to corrupted buffer from OCC
communications with other system components. Therefore, retry
the command twice in the event of a checksum failure.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/occ/p9_sbe.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 49b13cc01073..e6ccef2af659 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -14,6 +14,8 @@
 
 #include "common.h"
 
+#define OCC_CHECKSUM_RETRIES	3
+
 struct p9_sbe_occ {
 	struct occ occ;
 	bool sbe_error;
@@ -83,17 +85,22 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	struct occ_response *resp = &occ->resp;
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
 	size_t resp_len = sizeof(*resp);
+	int i;
 	int rc;
 
-	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
-	if (rc < 0) {
+	for (i = 0; i < OCC_CHECKSUM_RETRIES; ++i) {
+		rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
+		if (rc >= 0)
+			break;
 		if (resp_len) {
 			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
 				sysfs_notify(&occ->bus_dev->kobj, NULL,
 					     bin_attr_ffdc.attr.name);
-		}
 
-		return rc;
+			return rc;
+		}
+		if (rc != -EBADE)
+			return rc;
 	}
 
 	switch (resp->return_status) {
-- 
2.27.0

