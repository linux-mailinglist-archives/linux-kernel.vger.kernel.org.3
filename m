Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597F457BE95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiGTTbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGTTa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:30:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEBF4C60F;
        Wed, 20 Jul 2022 12:30:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KJMOSF012466;
        Wed, 20 Jul 2022 19:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8I1liYipnBm8X00TE8ZtPGJuIps367Zc6U3dn39s7xI=;
 b=D0F/IfIaM0fZ9yWW4N7ZbuQYm1oXEnYChuiNlmGgdpkCpC33JgN6M3ocGxj5ztWcHO+Q
 HXWRswlKl49KdCtweOcaUsG8iGk9mIxiXDTB3KwrgpXE0id4fmpC2Y7BHhBP0KyhUVG4
 AuaGaJahlSWbb5Ou+/SQg+r8TKHleI/m5fOwhzRb+yymlgPoJP7U+iIy1xCQVQtUVnZi
 rW6W5Q88+8kvD/NyfXP00Qkk7ym36sDUZjutfPShm7xT7P/gVA4BTbEwN50YcSG4eNen
 qUS/g7ofhlm69QoVobbJbjMAGUTwZAj9Gnj6ZDNsLc0pJFOA+OeROam3ST2NYoo4BoEb 7g== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3heqt405u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 19:30:42 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26KJLUCt002505;
        Wed, 20 Jul 2022 19:30:41 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3hbmy9j9k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 19:30:41 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26KJUe0D37486988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 19:30:40 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD1CBC6055;
        Wed, 20 Jul 2022 19:30:40 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC7B9C605F;
        Wed, 20 Jul 2022 19:30:39 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.160.104.49])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 19:30:39 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon (occ): Fix response length in checksum retry
Date:   Wed, 20 Jul 2022 14:30:36 -0500
Message-Id: <20220720193036.8743-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AbXYQKAn4289Q6xPTDqnFl9qp8Uf5kVt
X-Proofpoint-ORIG-GUID: AbXYQKAn4289Q6xPTDqnFl9qp8Uf5kVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207200077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrying for checksum failure doesn't work since the response length
gets zeroed out in the submit function. Fix this by resetting the
response length to its original value before the retry.

Fixes: c27b98ca0edb ("hwmon (occ): Retry for checksum failure")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/p9_sbe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 4a1fe4ee8e2c..f3791a589b01 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -82,6 +82,7 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
 static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
 			       void *resp, size_t resp_len)
 {
+	size_t original_resp_len = resp_len;
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
 	int rc, i;
 
@@ -97,6 +98,7 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
 		}
 		if (rc != -EBADE)
 			return rc;
+		resp_len = original_resp_len;
 	}
 
 	switch (((struct occ_response *)resp)->return_status) {
-- 
2.31.1

