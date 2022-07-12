Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8857179C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiGLKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGLKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:52:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1912AE38E;
        Tue, 12 Jul 2022 03:52:27 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAcFAN009941;
        Tue, 12 Jul 2022 10:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ReAbKcZn4yk51jPY+r2lXNrvwg6xxXAaYrf3rfv4ErU=;
 b=RhaX1nV3ZieZUzZmw/MBl36fcJ1GIDLK4USBGDvPvxY+soI/rOD60If649B6m//gzTq7
 +Iqs2N8VFAECian8YV5rpG8IvoTslywOFhA160izr3+USQN7PX85GK25L0TlKcq2JcK3
 s77bSZWYYBPj/h8l8y1odvTos54FTMUu89Uh87sBcHP2DBujoeuntuGv56Fz7mGNdo5r
 BA1docJe1Mw6HzHnuix7RwNogEoqpc/UHu01x59Ww1umbXq7sP+qPXulP9nf6h07eSaB
 U8XAQdGJcfAG15Z66+XsyCusPlTx39r36QCZ4WU6pwQIRLYA0dJXJQ8rMOW5E3YkWE3C vw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qf94sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:52:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CAnxpw012848;
        Tue, 12 Jul 2022 10:52:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8v1rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:52:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CAqLTi24904004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 10:52:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3261611C04A;
        Tue, 12 Jul 2022 10:52:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCEE111C050;
        Tue, 12 Jul 2022 10:52:20 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 10:52:20 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH 0/3] s390/cpufeature: rework to allow different types of cpufeatures
Date:   Tue, 12 Jul 2022 12:52:17 +0200
Message-Id: <20220712105220.325010-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ati-tQQEUKc7_tSGsiuIMFKkN7fK6p2q
X-Proofpoint-GUID: Ati-tQQEUKc7_tSGsiuIMFKkN7fK6p2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=909 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120039
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

Heiko Carstens (1):
  s390/cpufeature: allow for facility bits

Steffen Eiden (2):
  s390/cpufeature: rework to allow more than only hwcap bits
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
 arch/s390/include/asm/cpufeature.h | 44 +++++++++++++-------
 arch/s390/kernel/Makefile          |  2 +-
 arch/s390/kernel/cpufeature.c      | 66 ++++++++++++++++++++++++++++++
 arch/s390/kernel/processor.c       | 10 -----
 drivers/char/hw_random/s390-trng.c |  2 +-
 drivers/s390/char/uvdevice.c       |  5 +--
 drivers/s390/crypto/pkey_api.c     |  2 +-
 18 files changed, 111 insertions(+), 42 deletions(-)
 create mode 100644 arch/s390/kernel/cpufeature.c

-- 
2.35.3

