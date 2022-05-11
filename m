Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF505232A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiEKMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241942AbiEKMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:06:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876815721;
        Wed, 11 May 2022 05:05:49 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BBU3g4031186;
        Wed, 11 May 2022 12:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TExYozb6mygXwsguxxUT/z3UiHJ6Se3ufGdH6QQizqo=;
 b=AlU3J13JXDJ8wanEzDP1e3JcNEjpyq6ysEnGzpL2J+KnlsclxYozjn9kAU9UI4labIG4
 8fd96YIe809LYlHSIpigslXeApAG5mlvh+t6ukRdssr5R+vy7JvOWgieVAOnPX6ZHI6C
 GWhEtTHkTNjMn+1K6lJnT9BTVGb0iPt0yJVcLaemdTS9w0W6C0ojEeSvCJkMZ8w03ITI
 WgThOXmaf2yuI91vfTmOnvX2m3QWtFXvM58mwODOZ7Bz7xOxkb6TuJRUl8gkPzejmbBB
 JeeNP3KVR3O2PHwJe5bb4BIYdBQe74N9RgoCSvecPWYbhDoshH9caxbuv5G6RChja7lG kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g096y46qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:42 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BBsfvV019810;
        Wed, 11 May 2022 12:05:42 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g096y46ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:42 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC3cZe022265;
        Wed, 11 May 2022 12:05:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3fwgd8m7hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5ZjO39911736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A5AEA4040;
        Wed, 11 May 2022 12:05:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23C16A4051;
        Wed, 11 May 2022 12:05:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 12:05:35 +0000 (GMT)
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
Subject: [PATCH 5/8] s390/purgatory: workaround llvm's IAS limitations
Date:   Wed, 11 May 2022 14:05:29 +0200
Message-Id: <20220511120532.2228616-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: blPOUT8fxAgzGvo8RWHqcyGSfs0TQzYK
X-Proofpoint-ORIG-GUID: veuql7yuWG9Y9qKJzQkFtv-U05bKs9Mo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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

arch/s390/purgatory/head.S:139:11: error: invalid operand for instruction
 aghi %r8,-(.base_crash-purgatory_start)

Workaround this by partially rewriting the code.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/purgatory/head.S | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/s390/purgatory/head.S b/arch/s390/purgatory/head.S
index 3d1c31e0cf3d..ac1a27a20b66 100644
--- a/arch/s390/purgatory/head.S
+++ b/arch/s390/purgatory/head.S
@@ -44,11 +44,14 @@
 .endm
 
 .macro MEMSWAP dst,src,buf,len
-10:	cghi	\len,bufsz
+10:	larl	%r0,purgatory_end
+	larl	%r1,stack
+	slgr	%r0,%r1
+	cgr	\len,%r0
 	jh	11f
 	lgr	%r4,\len
 	j	12f
-11:	lghi	%r4,bufsz
+11:	lgr	%r4,%r0
 
 12:	MEMCPY	\buf,\dst,%r4
 	MEMCPY	\dst,\src,%r4
@@ -135,12 +138,18 @@ ENTRY(purgatory_start)
 
 .start_crash_kernel:
 	/* Location of purgatory_start in crash memory */
+	larl	%r0,.base_crash
+	larl	%r1,purgatory_start
+	slgr	%r0,%r1
 	lgr	%r8,%r13
-	aghi	%r8,-(.base_crash-purgatory_start)
+	sgr	%r8,%r0
 
 	/* Destination for this code i.e. end of memory to be swapped. */
+	larl	%r0,purgatory_end
+	larl	%r1,purgatory_start
+	slgr	%r0,%r1
 	lg	%r9,crash_size-.base_crash(%r13)
-	aghi	%r9,-(purgatory_end-purgatory_start)
+	sgr	%r9,%r0
 
 	/* Destination in crash memory, i.e. same as r9 but in crash memory. */
 	lg	%r10,crash_start-.base_crash(%r13)
@@ -149,15 +158,19 @@ ENTRY(purgatory_start)
 	/* Buffer location (in crash memory) and size. As the purgatory is
 	 * behind the point of no return it can re-use the stack as buffer.
 	 */
-	lghi	%r11,bufsz
+	larl	%r11,purgatory_end
 	larl	%r12,stack
+	slgr	%r11,%r12
 
 	MEMCPY	%r12,%r9,%r11	/* dst	-> (crash) buf */
 	MEMCPY	%r9,%r8,%r11	/* self -> dst */
 
 	/* Jump to new location. */
 	lgr	%r7,%r9
-	aghi	%r7,.jump_to_dst-purgatory_start
+	larl	%r0,.jump_to_dst
+	larl	%r1,purgatory_start
+	slgr	%r0,%r1
+	agr	%r7,%r0
 	br	%r7
 
 .jump_to_dst:
@@ -169,7 +182,9 @@ ENTRY(purgatory_start)
 
 	/* Load new buffer location after jump */
 	larl	%r7,stack
-	aghi	%r10,stack-purgatory_start
+	larl	%r0,purgatory_start
+	slgrk	%r0,%r7,%r0
+	agr	%r10,%r0
 	MEMCPY	%r10,%r7,%r11	/* (new) buf -> (crash) buf */
 
 	/* Now the code is set up to run from its designated location. Start
-- 
2.32.0

