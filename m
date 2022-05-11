Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30209523299
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiEKMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbiEKMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570B925F8;
        Wed, 11 May 2022 05:05:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B9oNfS021457;
        Wed, 11 May 2022 12:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=C6tAtBA3iPnLXQVvTRHZCp8q/p7mVHJtFt4mMQ7BOCA=;
 b=sJ4q0BN2JGS8JEYqs2+KSDYTIXVFIcgbmr+32EhAvu2baCzjwvDoD2N5HU4cqAV4Lyen
 +jIq66n534+C/Glh7DKJpwoI8x9191d04Od6jXDoQYsp7yn21YlNqw0PPZxBYgw1n/wG
 dzom8SvFg2I330gDz3U6YR4aIhGNMKciOSRJQEpcmoy6tIrBeKgOomvettHU/6iMmSsv
 DLqPwSPY3FPr+CyHrBPBAF0/AvR9fxrUossSnoXEfw2nIjObnweZwX2GyNxfO49C3Gnt
 7IBtDwRMLrpA5EUjn7DI4+/hf3WxurpuGv6jeu9iQdWZjEF2T+IIUaF/ND62T2lDF4aN Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0av72bwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:41 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BBgHnG013345;
        Wed, 11 May 2022 12:05:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0av72bw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC3bad030199;
        Wed, 11 May 2022 12:05:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3fwgd8v7rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5XvF51904952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61DC3A4053;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A7FDA4040;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 12:05:32 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/8] s390: allow to build with llvm's integrated assembler
Date:   Wed, 11 May 2022 14:05:24 +0200
Message-Id: <20220511120532.2228616-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dIarlgyRj465RF_1oPmpJrHrT1GM3m9g
X-Proofpoint-ORIG-GUID: qrhnh10eMKY94UPvYR4jrgy1hbDReClj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=816
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches which in result make it finally possible to build the
kernel for s390 with llvm's integrated assembler. Several configs build
without errors or warnings, and the kernel also works as expected.

Note that patch 6 ("s390/boot: workaround llvm IAS bug") reveals a
miscompile. This looks like a bug in the instruction definitions of the mvc
and clc instructions(?). I'd like to ask people to look into this, since
this silently generated broken code.

This patch series is based on linux-next, which contains two additional
required s390 specific patches to make llvm's IAS work.

Thanks,
Heiko

Heiko Carstens (8):
  s390/alternatives: provide identical sized orginal/alternative sequences
  s390/alternatives: remove padding generation code
  s390/entry: shorten OUTSIDE macro
  s390/entry: workaround llvm's IAS limitations
  s390/purgatory: workaround llvm's IAS limitations
  s390/boot: workaround llvm IAS bug
  s390/boot: do not emit debug info for assembly with llvm's IAS
  scripts/min-tool-version.sh: raise minimum clang version to 14.0.0 for s390

 arch/s390/Makefile                      |  2 +
 arch/s390/boot/head.S                   | 34 +++++----
 arch/s390/include/asm/alternative-asm.h | 76 +++-----------------
 arch/s390/include/asm/alternative.h     | 93 ++++++-------------------
 arch/s390/include/asm/spinlock.h        |  2 +-
 arch/s390/kernel/alternative.c          | 61 +---------------
 arch/s390/kernel/entry.S                | 39 +++++++----
 arch/s390/lib/spinlock.c                |  4 +-
 arch/s390/purgatory/head.S              | 29 ++++++--
 scripts/min-tool-version.sh             |  3 +-
 10 files changed, 104 insertions(+), 239 deletions(-)

-- 
2.32.0

