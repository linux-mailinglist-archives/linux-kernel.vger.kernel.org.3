Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22452BE00
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiEROtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiEROtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:49:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6113C4CB;
        Wed, 18 May 2022 07:48:59 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IEIQTC013779;
        Wed, 18 May 2022 14:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jt2cx3T6o4GVw+0S0U7IGI7oEUQcl0Cv1eMS2EKyIdk=;
 b=MZwfOiK/R4FuFXwOqzaH2S853oPqYeL8fNQkoCvPXOyQ8pSJ2Wh1r0hfrZMf7SZXsGAY
 7FzCgfl0uhgYoiUbKpT2g+kF0ZtRN2QULSRWD0xdhgtak8z7N430ojU5ufHIhWS4o6Gd
 23lbabU8i6kkkf5qnNM9unMlUGxNZVpABC5ChetTjb9ngTsvjFVpOt9W3ubyPVYPCyBJ
 9FdrCMs8iKaCDb8UCZMcwsbBjVfUapJpgcyY1akwJEtTDgj/8bYO98VfJYPEzdBPRYGH
 oG+FOE3tP9fy71Lex55mTKC5Toq43XTBiXvhEJ4aP1msmlzoO8zkbuLldXq//wq4siLS Yw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g52ev0vgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:48:23 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IEcsx9017930;
        Wed, 18 May 2022 14:48:21 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3g4wp59tcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:48:21 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IEmLM032571848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 14:48:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 149D2BE054;
        Wed, 18 May 2022 14:48:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE16ABE053;
        Wed, 18 May 2022 14:48:20 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.6.139])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 14:48:20 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Wed, 18 May 2022 09:48:16 -0500
Message-Id: <20220518144818.12957-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7jhwYhC8B9pTwep4Tyuw2bWE-_vhiClH
X-Proofpoint-ORIG-GUID: 7jhwYhC8B9pTwep4Tyuw2bWE-_vhiClH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_05,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=670 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corruption of the MEAS_CFG register has been observed soon after
system boot. In order to recover this scenario, check MEAS_CFG if
measurement isn't ready, and if it's incorrect, reset the DPS310
and execute the startup procedure. Include a patch to move the
startup procedure into a function.

Changes since v1:
 - Separate into two patches
 - Rename 'dps310_verify_meas_cfg' to 'dps310_check_reset_meas_cfg'

Eddie James (2):
  iio: pressure: dps310: Refactor startup procedure
  iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt

 drivers/iio/pressure/dps310.c | 281 +++++++++++++++++++++-------------
 1 file changed, 174 insertions(+), 107 deletions(-)

-- 
2.27.0

