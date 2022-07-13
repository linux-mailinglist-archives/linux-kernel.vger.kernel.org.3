Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469D5736BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiGMM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGMM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C857393D;
        Wed, 13 Jul 2022 05:56:53 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DCfhba003346;
        Wed, 13 Jul 2022 12:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6EmDx4KHfWJHSESEM/+TnkRSjEThsLZnSTW530azPfs=;
 b=GmXcEtitMOU8mMDrk/2S9TCwbFG51e5Sc7RjDb7P30NYt7/ZBH7Hkm9ohjSyEFlpEHn+
 Gu+xwE9OVU2dpbxN8wiPCFbSkKmmBPffhMS7n3A4gkeHt5a1BiGVLZTwjdbYE7euJwPa
 qnKXw+NAANdtUybjRLh01Px997JB+Ip8YXzNpDdapoL9EAMhiSsr25rWZTAuHx5Z2MZ3
 k6fRX1Ko+MMmUm/fdhyVLo6zNbcNv/tTMsJ0ZTm2an4dZ3S6GKsYGWktNpG+0DF3vfCt
 VnD8ODlhvmZWA/m79jXSuVQuYtuM8tZUgIpCamZy1udhINZNoF3+klNgcYjhiHQc8t1z 1w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9x9e8dar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DCoGmk015124;
        Wed, 13 Jul 2022 12:56:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8wp5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DCuiM113173002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 12:56:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AF18A405B;
        Wed, 13 Jul 2022 12:56:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487F2A405C;
        Wed, 13 Jul 2022 12:56:44 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 12:56:44 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH v2 0/3] s390/cpufeature: rework to allow different types of cpufeatures
Date:   Wed, 13 Jul 2022 14:56:41 +0200
Message-Id: <20220713125644.16121-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u9dHQVIALGAApagrDseHR4KJXHmVj0Wa
X-Proofpoint-ORIG-GUID: u9dHQVIALGAApagrDseHR4KJXHmVj0Wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_01,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the s390 implementaion of cpufeature is limited to elf_hwcap
bits. Using these to automatically load modules also exposes this
cpufeature to userspace which, sometimes is not intended.

Therefore, rework the s390-cpufeature implementation to allow for
various cpu feature indications, which is not only limited to hwcap bits.

Add a new type to allow facilities to be a cpufeature without using
hwcap bits that expose this feature to userspace.

Load uvdevice when facility 158 is present.

since v1:
	* add r-bs from Claudio
	* worked in comments

Heiko Carstens (2):
  s390/cpufeature: rework to allow more than only hwcap bits
  s390/cpufeature: allow for facility bits

Steffen Eiden (1):
  s390/uvdevice: autoload module based on CPU facility

 arch/s390/crypto/aes_s390.c        |  2 +-
 arch/s390/crypto/chacha-glue.c     |  2 +-
 arch/s390/crypto/crc32-vx.c        |  2 +-
 arch/s390/crypto/des_s390.c        |  2 +-
 arch/s390/crypto/ghash_s390.c      |  2 +-
 arch/s390/crypto/prng.c            |  2 +-
 arch/s390/crypto/sha1_s390.c       |  2 +-
 arch/s390/crypto/sha256_s390.c     |  2 +-
 arch/s390/crypto/sha3_256_s390.c   |  2 +-
 arch/s390/crypto/sha3_512_s390.c   |  2 +-
 arch/s390/crypto/sha512_s390.c     |  2 +-
 arch/s390/include/asm/cpufeature.h | 23 ++++++---------
 arch/s390/kernel/Makefile          |  2 +-
 arch/s390/kernel/cpufeature.c      | 46 ++++++++++++++++++++++++++++++
 arch/s390/kernel/processor.c       | 10 -------
 drivers/char/hw_random/s390-trng.c |  2 +-
 drivers/s390/char/uvdevice.c       |  5 ++--
 drivers/s390/crypto/pkey_api.c     |  2 +-
 18 files changed, 70 insertions(+), 42 deletions(-)
 create mode 100644 arch/s390/kernel/cpufeature.c

-- 
2.35.3

