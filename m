Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F125341D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiEYQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbiEYQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791A9CC98;
        Wed, 25 May 2022 09:59:04 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGwhlc027029;
        Wed, 25 May 2022 16:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s29TMMaPCeov6Umv4/RKkhW1ulUvZ0bFNKT+MfZefKc=;
 b=jEmQGXjx15Ng6AVbzjonQGKGmIUemdi4xQjoqcOj5gAd7pUAhrMHvcsUGxAQKXudHRud
 vbd/H4hgyiebV2jNXJ75l4YBfqQyCycmzDjL3gL1wVZdQL7lZGzThI12mjnw15cf5zxx
 ZSv/+KUoefOl0c2yRMzGOVioAZcb1eDDqW69005wnElYHa4UlSvBYPihniPMpL1Yz3DE
 qqlK88jB0IANFtqkJpBcPlquEmg3n2Ui2dKQ8Yw9IYrFkV4p/8Qtl1XmydxXld+mZc8J
 uwz2uIcp/auspVq8RiKbTd5M1ma8L32yi41MvJ4qOQZbdtvGkj2NVpZErEs+nOt9wYeu TQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9rewr063-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 16:59:01 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PGcUfD032753;
        Wed, 25 May 2022 16:59:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3g93uyqbb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 16:59:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PGx0nM27263316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 16:59:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5F9B112061;
        Wed, 25 May 2022 16:59:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 468C1112062;
        Wed, 25 May 2022 16:59:00 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.60.201])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 25 May 2022 16:59:00 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] spi: core: Display return code when failing to transfer message
Date:   Wed, 25 May 2022 11:58:52 -0500
Message-Id: <20220525165852.33167-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220525165852.33167-1-eajames@linux.ibm.com>
References: <20220525165852.33167-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: crbBxFRBBMklhPjWNlhgQ79uF7ygIQn4
X-Proofpoint-GUID: crbBxFRBBMklhPjWNlhgQ79uF7ygIQn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the other calls to the controller driver display the error
return code. The return code is helpful to understand what went
wrong, so include it when failing to transfer one message.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 481edea77c62..ea09d1b42bf6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1654,7 +1654,8 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	ret = ctlr->transfer_one_message(ctlr, msg);
 	if (ret) {
 		dev_err(&ctlr->dev,
-			"failed to transfer one message from queue\n");
+			"failed to transfer one message from queue: %d\n",
+			ret);
 		goto out;
 	}
 
-- 
2.27.0

