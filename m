Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E555232A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiEKMGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiEKMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86704120AA;
        Wed, 11 May 2022 05:05:45 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BC3vnI025472;
        Wed, 11 May 2022 12:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VHOW8NsiZj1aWpVHD/c0AT0LEY97DtlrpaN6FSHbEOo=;
 b=snGu+VdbqzojemEUdNXE80MJPeoCtl9HwPUpK/K4vK32dKAUqueo5rcCWbPt5Zocw8UW
 WcmvtncgOdyTk7xLPOLK1r9BD3CxomxhN0bqUKDymyYNtf5IAgYe9f2F5krtqIPOLv7Y
 J+d3iD7i0rule1ZtE9pCGEUmRjwQOhmINxjJsDWwd3JehfDCIS6ZNxrGLooXd/RNa5eG
 sCXdcseONc97e5+exuGQr9J1jskhD5WWuSTYUWU61X1y9qL00S79Xg7X4uZW7Ynr5n9h
 +3AsMdMP6+X4OzlWNEfUVrT0PzslvIclR7MPyS+k+SxFLnG6RyGxERVJVaZ5Vy72/4Sl Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g09yfubxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:42 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BBsNv4028335;
        Wed, 11 May 2022 12:05:42 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g09yfubws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:42 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC3Jgd030168;
        Wed, 11 May 2022 12:05:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3fwgd8v7re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5ZdH39911738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC8A3A4051;
        Wed, 11 May 2022 12:05:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8588BA404D;
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
Subject: [PATCH 6/8] s390/boot: workaround llvm IAS bug
Date:   Wed, 11 May 2022 14:05:30 +0200
Message-Id: <20220511120532.2228616-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tS06FrqPhuw5_lrVhBe0Wd3_mndOWJpk
X-Proofpoint-ORIG-GUID: Ia9f7gvb59OIUG5DhvO8itAU-JpNcqcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=788 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For at least the mvc and clc instructions llvm's integrated assembler can
generate incorrect code. In particular this happens with decompressor boot
code. The reason seems to be that relocations for the second displacement
of each instruction are at incorrect locations (-/+: gas vs llvm IAS):

mvc     __LC_IO_NEW_PSW(16),.Lnewpsw

results in

        4:      d2 0f 01 f0 00 00       mvc     496(16,%r0),0
-                       8: R_390_12     .head.text+0x10
+                       6: R_390_12     .head.text+0x10

and
clc     0(3,%r4),.L_hdr
results in

      258:      d5 02 40 00 00 00       clc     0(3,%r4),0
-                       25c: R_390_12   .head.text+0x324
+                       25a: R_390_12   .head.text+0x324

Workaround this by writing the code in a different way.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/head.S | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
index 2ced90172680..8402e1cd133b 100644
--- a/arch/s390/boot/head.S
+++ b/arch/s390/boot/head.S
@@ -42,7 +42,8 @@ ipl_start:
 # subroutine to wait for end I/O
 #
 .Lirqwait:
-	mvc	__LC_IO_NEW_PSW(16),.Lnewpsw	# set up IO interrupt psw
+	larl	%r13,.Lnewpsw		# set up IO interrupt psw
+	mvc	__LC_IO_NEW_PSW(16),0(%r13)
 	lpsw	.Lwaitpsw
 .Lioint:
 	br	%r14
@@ -155,9 +156,11 @@ ipl_start:
 	lr	%r2,%r3
 .Lnotrunc:
 	l	%r4,.Linitrd
-	clc	0(3,%r4),.L_hdr		# if it is HDRx
+	larl	%r13,.L_hdr
+	clc	0(3,%r4),0(%r13)	# if it is HDRx
 	bz	.Lagain1		# skip dataset header
-	clc	0(3,%r4),.L_eof		# if it is EOFx
+	larl	%r13,.L_eof
+	clc	0(3,%r4),0(%r13)	# if it is EOFx
 	bz	.Lagain1		# skip dateset trailer
 
 	lr	%r5,%r2
@@ -181,9 +184,11 @@ ipl_start:
 .Lrdcont:
 	l	%r2,.Linitrd
 
-	clc	0(3,%r2),.L_hdr		# skip HDRx and EOFx
+	larl	%r13,.L_hdr		# skip HDRx and EOFx
+	clc	0(3,%r2),0(%r13)
 	bz	.Lagain2
-	clc	0(3,%r2),.L_eof
+	larl	%r13,.L_eof
+	clc	0(3,%r2),0(%r13)
 	bz	.Lagain2
 
 #
@@ -260,20 +265,23 @@ SYM_CODE_START_LOCAL(startup_normal)
 	.fill	16,4,0x0
 0:	lmh	%r0,%r15,0(%r13)	# clear high-order half of gprs
 	sam64				# switch to 64 bit addressing mode
-	basr	%r13,0			# get base
-.LPG0:
-	mvc	__LC_EXT_NEW_PSW(16),.Lext_new_psw-.LPG0(%r13)
-	mvc	__LC_PGM_NEW_PSW(16),.Lpgm_new_psw-.LPG0(%r13)
-	mvc	__LC_IO_NEW_PSW(16),.Lio_new_psw-.LPG0(%r13)
+	larl	%r13,.Lext_new_psw
+	mvc	__LC_EXT_NEW_PSW(16),0(%r13)
+	larl	%r13,.Lpgm_new_psw
+	mvc	__LC_PGM_NEW_PSW(16),0(%r13)
+	larl	%r13,.Lio_new_psw
+	mvc	__LC_IO_NEW_PSW(16),0(%r13)
 	xc	0x200(256),0x200	# partially clear lowcore
 	xc	0x300(256),0x300
 	xc	0xe00(256),0xe00
 	xc	0xf00(256),0xf00
-	lctlg	%c0,%c15,.Lctl-.LPG0(%r13)	# load control registers
+	larl	%r13,.Lctl
+	lctlg	%c0,%c15,0(%r13)	# load control registers
 	stcke	__LC_BOOT_CLOCK
 	mvc	__LC_LAST_UPDATE_CLOCK(8),__LC_BOOT_CLOCK+1
-	spt	6f-.LPG0(%r13)
-	mvc	__LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
+	larl	%r13,6f
+	spt	0(%r13)
+	mvc	__LC_LAST_UPDATE_TIMER(8),0(%r13)
 	larl	%r15,_stack_end-STACK_FRAME_OVERHEAD
 	brasl	%r14,sclp_early_setup_buffer
 	brasl	%r14,verify_facilities
-- 
2.32.0

