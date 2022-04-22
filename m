Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6450B8E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448126AbiDVNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448124AbiDVNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:46:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E858E68
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:43:23 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MDbXoN020787;
        Fri, 22 Apr 2022 13:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=EA5Dvtyc9OF9mDEGvXc65P+qnZTNWtINBFUEbIsPcf8=;
 b=VVY0P2pcp3CPR1jVpJ50wb46gCkgpLmHtyqV2jxFdswSENL6B1/ss0VLtWpdex8chtSE
 e5B2p0WB6wgDkloTx/iHj29uwTgMC9NWrw4XK9S4T4ddai+vEErF0pXgPFTvgFaFLn5K
 n/vnYflj+UqXKyhN/4mbgU61GM7QPMyfFJGoNpBvZ0h9ctvLFX2u8vekmH6+mxja/bTn
 Ir0CsRyMxPOtvibjOLXpfHVg4RKS9bvnKnqJBYFFcl3nzfzKVparwJZzAxlTTpH83GR0
 ZPKpq1Hr8HvkXF6/IQWdufvuIiEnzS98kKKNZf7ohY9kRPDdTZ7cTkpY3h9BWSEIOau+ ig== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkrbbph0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:43:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDeR0G025053;
        Fri, 22 Apr 2022 13:43:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2j1fn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:43:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDUOxb42467734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:30:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D772C52051;
        Fri, 22 Apr 2022 13:43:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C6EEA5204F;
        Fri, 22 Apr 2022 13:43:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 9755DE1367; Fri, 22 Apr 2022 15:43:16 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390: disable -Warray-bounds
Date:   Fri, 22 Apr 2022 15:43:08 +0200
Message-Id: <20220422134308.1613610-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q2RQPZkQg0NSng7cV7GSIA0HW4ugw5Uo
X-Proofpoint-GUID: q2RQPZkQg0NSng7cV7GSIA0HW4ugw5Uo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=697
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-12 shows a lot of array bound warnings on s390. This is caused
by our S390_lowcore macro:

which uses an hardcoded address of 0. Wrapping that with
absolute_pointer() works, but gcc no longer knows that a 12 bit
instruction is sufficient to access lowcore. So it emits instructions
like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a single load/store
instruction. As s390 stores variables often read/written in lowcore,
this is considered problematic. Therefore disable -Warray-bounds on
s390 for now until there is a better real solution.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e441b60b1812..aff0f66e25fb 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -14,6 +14,7 @@ KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
 KBUILD_CFLAGS	+= -m64
+KBUILD_CFLAGS	+= $(call cc-disable-warning, array-bounds)
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS	+= -fPIE
 LDFLAGS_vmlinux	:= -pie
@@ -28,6 +29,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
+KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, array-bounds)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 UTS_MACHINE	:= s390x
-- 
2.35.1

