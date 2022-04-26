Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F851023D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352583AbiDZPxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352552AbiDZPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:53:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C3A1572F;
        Tue, 26 Apr 2022 08:50:23 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QEC92k013343;
        Tue, 26 Apr 2022 15:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KI5N6+PYpu61hG9fQctRxXILuP78+G0I85VQgAon75g=;
 b=X/5L4p4Gk3blHJrIdHi7kVjGjO8EXb1XcnFQ/Xk1HpQTVklYGRUDDSSrKsQtKomD4MOR
 jFMZ1k4JEupluPMhmebrk1DHGHXiHS90QcU1tUiGwmS4eSRP+1QBMLo83fEdp5z/2gzb
 KV5eQHBtUrvCufddMExtixgzou8RKil9w1Q++gpr33cGu66BmvY6rRdHvvw6xYnVwBi/
 A5j8Ui10lV3nRJfAEoTg6p085+6/7pL5XGf7h/9RCRc2j0vjhl1N61809l7utVKEcU93
 pWuu7qtPDlhRlVJvN+iHWAVAmg7EIp1QhCSis88siK/+sVtVUq0CBHQSL0CGtgp5ZDkW Vw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj9rjb4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:49:59 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QFgQSA002403;
        Tue, 26 Apr 2022 15:49:59 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3fm93a3fx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:49:58 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QFnvDb18809158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:49:57 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB50ABE059;
        Tue, 26 Apr 2022 15:49:57 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6324DBE061;
        Tue, 26 Apr 2022 15:49:57 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.59])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 15:49:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        jk@ozlabs.org, David.Laight@ACULAB.COM
Subject: [PATCH v2 1/2] fsi: occ: Fix checksum failure mode
Date:   Tue, 26 Apr 2022 10:49:55 -0500
Message-Id: <20220426154956.27205-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220426154956.27205-1-eajames@linux.ibm.com>
References: <20220426154956.27205-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d0Ps6vKalp90tN-sNaKjus9ifR3ytqQu
X-Proofpoint-ORIG-GUID: d0Ps6vKalp90tN-sNaKjus9ifR3ytqQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_04,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

