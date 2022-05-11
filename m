Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2152329B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiEKMGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbiEKMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FA9DEC4;
        Wed, 11 May 2022 05:05:45 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BBYQl6023083;
        Wed, 11 May 2022 12:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DwNvTh+bVahDGcGd4X1DSt38yGLzM4NUeFQ/D+10cFQ=;
 b=IKjKgRMBao7Cjmp9t01bsidYHRfobR+X2loZvUhF/OJ19I99OPrpLqa2QmZxc/D/ZYiA
 gD4VuRE+d5yoKCq+kXT7i0agVScNwrIYk03cUOPMdfr3eWjNApsgyU+ta7trHkDkcYjp
 8ZaLRpBVRuX8ItXuWQ6N/efDZpGP7sY1qBeSVFUbJb3pG2NeGbCYVP2cTWE4+mkOhb0P
 KiZrbrZLuZwMkJ3g4dDj0VXHHP5rw0F1w/x0k9FlziUooJ4WJkMR5jdiOTt0Vg/a8vE/
 G5KeSz+5kgbPPqDTQBbBj8Fvo13Tx5NNbZrSW/PuOvrEem5QNh86G9Dit/8cdRRbIhAr 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0br6h9tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BC0GPX024650;
        Wed, 11 May 2022 12:05:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0br6h9st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC3cQI031900;
        Wed, 11 May 2022 12:05:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk1awn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5ZJw39911734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E2CA4040;
        Wed, 11 May 2022 12:05:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9D8A404D;
        Wed, 11 May 2022 12:05:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 12:05:34 +0000 (GMT)
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
Subject: [PATCH 4/8] s390/entry: workaround llvm's IAS limitations
Date:   Wed, 11 May 2022 14:05:28 +0200
Message-Id: <20220511120532.2228616-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z7GfmYcSIPgQwUFOpM_8gDRGyQVNJLQ8
X-Proofpoint-GUID: mJvAuwBKtdzRS4VW4wLPEgj5dK_Ltt1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=872 clxscore=1015 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm's integrated assembler cannot handle immediate values which are
calculated with two local labels:

<instantiation>:3:13: error: invalid operand for instruction
 clgfi %r14,.Lsie_done - .Lsie_gmap

Workaround this by adding clang specific code which reads the specific
value from memory. Since this code is within the hot paths of the kernel
and adds an additional memory reference, keep the original code, and add
ifdef'ed code.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index e1664b45090f..ff7a75078e93 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -171,8 +171,19 @@ _LPP_OFFSET	= __LC_LPP
 	.macro OUTSIDE reg,start,end,outside_label
 	larl	%r14,\start
 	slgrk	%r14,\reg,%r14
+#ifdef CONFIG_CC_IS_CLANG
+	clgfrl	%r14,.Lrange_size\@
+#else
 	clgfi	%r14,\end - \start
+#endif
 	jhe	\outside_label
+#ifdef CONFIG_CC_IS_CLANG
+	.section .rodata, "a"
+	.align 4
+.Lrange_size\@:
+	.long	\end - \start
+	.previous
+#endif
 	.endm
 
 	.macro SIEEXIT
-- 
2.32.0

