Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAED4E2C55
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbiCUPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiCUPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:33:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19012169798;
        Mon, 21 Mar 2022 08:31:47 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LE8t3V009572;
        Mon, 21 Mar 2022 15:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KI5N6+PYpu61hG9fQctRxXILuP78+G0I85VQgAon75g=;
 b=E5+Njvmf9ReSDFt66di+E2tZD4L1IYXEEkcL5frqta75RADeGnBr1LeNNZEKChq9MMYV
 1raqAXa3KoRPZOIV7yKyUOfquTrwXl3Fc2bFMICzWG1LBWL4q9Ny1EqtYRhQLkEGp3Hw
 1zrsmyVn1tK608x6tpQ676teW8b9mXuXnpE6lF/COmbWtSyFNfm9Lqqy8Rfvol1roh+f
 +VsXiSuWDQtkPdGU/fZ0+7Tes9bteLkWxu9blJO4mOax9JyDBpXIeWOLcczR1igp9cQH
 jb7OYBfX1U9qgn6j7LOcM4Tl10rwmXXzamY2u+VLtNFOXKJD4DRvVcqVzj5eYs4tWm3c 1A== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3exb60td6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 15:31:23 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LFRReq028368;
        Mon, 21 Mar 2022 15:31:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3ew6t8p7t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 15:31:22 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LFVKko16646514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 15:31:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6CD7C6067;
        Mon, 21 Mar 2022 15:31:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49405C605B;
        Mon, 21 Mar 2022 15:31:20 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.47.134])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 15:31:20 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        jk@ozlabs.org, alistair@popple.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] fsi: occ: Fix checksum failure mode
Date:   Mon, 21 Mar 2022 10:31:11 -0500
Message-Id: <20220321153112.12199-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220321153112.12199-1-eajames@linux.ibm.com>
References: <20220321153112.12199-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MdSehqn6b5dG2CyXhHBPDP7YUzc_w0oJ
X-Proofpoint-GUID: MdSehqn6b5dG2CyXhHBPDP7YUzc_w0oJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_06,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
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

Change the checksum errno to something different than the errno
used for a bad SBE message. In addition, don't set the user's
response length to the data length in this case, since it's not
SBE FFDC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index c9cc75fbdfb9..3d04e8baecbb 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -246,7 +246,7 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 	if (checksum != checksum_resp) {
 		dev_err(occ->dev, "Bad checksum: %04x!=%04x\n", checksum,
 			checksum_resp);
-		return -EBADMSG;
+		return -EBADE;
 	}
 
 	return 0;
@@ -575,8 +575,11 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
 		resp->return_status, resp_data_length);
 
-	occ->client_response_size = resp_data_length + 7;
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
+	if (rc)
+		goto done;
+
+	occ->client_response_size = resp_data_length + 7;
 
  done:
 	*resp_len = occ->client_response_size;
-- 
2.27.0

