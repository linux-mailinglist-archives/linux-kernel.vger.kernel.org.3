Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73E50DFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbiDYMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiDYMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:20:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E61A04A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:17:53 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PBOmv6014869;
        Mon, 25 Apr 2022 12:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0fQofL+Nh6ecyqJy3F0BkquCKDrLmSC80AJwgsKVCFQ=;
 b=hJSeUxr9fZvsu+8zarZmW7nTcxHsIZSvPQCkbl10IVy8C8BGXVQIJPH3k49I8dJHiFp9
 bUS0N+fHa02uCfoN3YsyC/NpQLVkZMYqInNoPnMkaz5RYBUntaKNxtVch4Q/lQofNnqF
 WbBcq9vQdeN7lAuFoJa8FNuI8prn1fH5FSevMBT07XOqUcLYO/0jQYYeqQ/bZEAqvy2g
 ye6qc148a5MC+ZP2SfCw8LvjHEWnNoE6XfDGYVvVxVM9eS7rEJPiGtfI+bDNTUHdrFCv
 W7Tz5ihIbJeyL8rl4AHBVVvjdVIftfKtm+yQYxuHpNdkYJx40idd+YVdI9egfdxsyrHh Kw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fntreh58a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 12:17:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PCAPXU000626;
        Mon, 25 Apr 2022 12:17:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938tcaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 12:17:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PC4laK50790748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 12:04:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E2A242041;
        Mon, 25 Apr 2022 12:17:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CA344203F;
        Mon, 25 Apr 2022 12:17:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 12:17:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 146E8E040D; Mon, 25 Apr 2022 14:17:46 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] s390: disable -Warray-bounds
Date:   Mon, 25 Apr 2022 14:17:42 +0200
Message-Id: <20220425121742.3222133-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7D_le1BaN6pu_gKhqY0oDqWDhraLQgmI
X-Proofpoint-GUID: 7D_le1BaN6pu_gKhqY0oDqWDhraLQgmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=708 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250054
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
s390 when gcc-12 is used until there is a better real solution.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
Changes in v2:
- only remove -Warray-bounds for gcc-12

 arch/s390/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e441b60b1812..df325eacf62d 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -30,6 +30,16 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
+
+ifdef CONFIG_CC_IS_GCC
+	ifeq ($(call cc-ifversion, -ge, 1200, y), y)
+		ifeq ($(call cc-ifversion, -lt, 1300, y), y)
+			KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+			KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, array-bounds)
+		endif
+	endif
+endif
+
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,16384)
 CHECKFLAGS	+= -D__s390__ -D__s390x__
-- 
2.35.1

