Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0984E2C63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350334AbiCUPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbiCUPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:36:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207C713F81;
        Mon, 21 Mar 2022 08:34:47 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LEdOp4008394;
        Mon, 21 Mar 2022 15:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yr7yLQm9scEdzY7wQQyoJTPo0UfjlE+sSQAPPp/a8fw=;
 b=ZpOCXXdZ4rIt2jAcbuLyZlpf/eLo5f0N5xXAdvXxnjYCZed4DrTZ2ANb+B9LpEvHFGmg
 aPVfxVuulZl3X5HWxzhfdcPuVttlGxel0bnmhU1JM/H+LhNC69ncsKCQbPXy32pEVSSM
 Qij5FjutYH219Ey64vqPGMqhE9a+k6SeYZu2g8wQd0fhhCUlEtBcCMzEcniGYKxH6fyr
 CJZrPgVHDV1Nq77luH6o51xwWCoI3PjyDJeJG7CgeYWFfxa7wc0XgXfzZ/95iwBMVHiz
 fZt9v8cq2abG78CfSq9rZ98V/qL1p9U4bSic5V2Mcc3unKp3dluLW+2hy1frOqYU7IZw Pw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3exnpg8tcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 15:34:25 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LFRUS1019189;
        Mon, 21 Mar 2022 15:31:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3ew6t96813-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 15:31:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LFVMBc19136868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 15:31:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A9AC6065;
        Mon, 21 Mar 2022 15:31:22 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B694C605A;
        Mon, 21 Mar 2022 15:31:22 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.47.134])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 15:31:22 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        jk@ozlabs.org, alistair@popple.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] hwmon (occ): Retry for checksum failure
Date:   Mon, 21 Mar 2022 10:31:12 -0500
Message-Id: <20220321153112.12199-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220321153112.12199-1-eajames@linux.ibm.com>
References: <20220321153112.12199-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: knGPd2jvmsSTxrCFUpXgVDsa3JXbRDiW
X-Proofpoint-GUID: knGPd2jvmsSTxrCFUpXgVDsa3JXbRDiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_06,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203210098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---
 drivers/hwmon/occ/p9_sbe.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 49b13cc01073..7f4c3f979c54 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -84,17 +84,25 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
 	size_t resp_len = sizeof(*resp);
 	int rc;
-
-	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
-	if (rc < 0) {
-		if (resp_len) {
-			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
-				sysfs_notify(&occ->bus_dev->kobj, NULL,
-					     bin_attr_ffdc.attr.name);
+	int tries = 0;
+
+	do {
+		rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
+		if (rc < 0) {
+			if (resp_len) {
+				if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
+					sysfs_notify(&occ->bus_dev->kobj, NULL,
+						     bin_attr_ffdc.attr.name);
+
+				return rc;
+			} else if (rc != -EBADE) {
+				return rc;
+			}
+			/* retry twice for checksum failures */
+		} else {
+			break;
 		}
-
-		return rc;
-	}
+	} while (++tries < 3);
 
 	switch (resp->return_status) {
 	case OCC_RESP_CMD_IN_PRG:
-- 
2.27.0

