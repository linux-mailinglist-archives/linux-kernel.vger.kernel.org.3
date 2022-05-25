Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC125341D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245535AbiEYQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiEYQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:59:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C9A5024;
        Wed, 25 May 2022 09:58:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PFvtZw007028;
        Wed, 25 May 2022 16:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ivnDzru3W+L/H7gXDFZPc4sJzdfH57kHnvIccc2ZI4U=;
 b=IMiO6rzt4+2mwttb4gBSTh7wzFIb1VbhQgJRvggcvca4OAWPoReJmCcMhcE4OXXJQKks
 k5osub6SI8vLATLQouWDfl9Wzqp2BeskRbPVC0bb63f6bkNmkK8bTRacHSSPfK/nYxQT
 4j/ehg46yllvmzdvcDLz/7KNYStm0F08+zofcNiPdiWytBtLj6KIGxMhT/N2fULAt2Tz
 mckAp3wOdD1Oi4h83b54TOCWf+W0DivaFTy2zSCyDG13lv9HcTXH1SFPsX8pPxemOBYf
 QHbpFKRATUZvlNet4/W7r3pv4PLx4kbJtBE5JcuFKF1ocH4Xoy/rkMvcN7VMAptBhpim KA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9pmmtfxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 16:58:57 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PGcDJn005155;
        Wed, 25 May 2022 16:58:56 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3g955vxrb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 16:58:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PGwuWx21365114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 16:58:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 160E3112061;
        Wed, 25 May 2022 16:58:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7619E112062;
        Wed, 25 May 2022 16:58:55 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.60.201])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 25 May 2022 16:58:55 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] spi: fsi: Fix spurious timeout
Date:   Wed, 25 May 2022 11:58:50 -0500
Message-Id: <20220525165852.33167-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AzIWN9JkyYv2rvlGVCckOz4cWYWIXkd9
X-Proofpoint-ORIG-GUID: AzIWN9JkyYv2rvlGVCckOz4cWYWIXkd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=814
 phishscore=0 suspectscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250085
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
Also include a patch to display the error return code when failing
to transfer one message, which would have been very helpful in
debugging this issue.

Eddie James (2):
  spi: fsi: Fix spurious timeout
  spi: core: Display return code when failing to transfer message

 drivers/spi/spi-fsi.c | 12 ++++++------
 drivers/spi/spi.c     |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.27.0

