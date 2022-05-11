Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE352329E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbiEKMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiEKMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A36272;
        Wed, 11 May 2022 05:05:44 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BBVHob032182;
        Wed, 11 May 2022 12:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U7NFeBmX7FK4+C84wOKVbyY9H6yd8lJcEAKg+19/HCk=;
 b=BFOOMEGyn+4l/z8bTH8eb4DhB4HQvA0e5jT/wx+Ixq2oa6NH7kPYSSc4hUbAxCGv3oDj
 5bzdGtqS+ngnUJBEYFD1OWa3uXoQZEANYfpOD0U4pZWQ0oMKmQykzDCFOa1ZXDGgJPlL
 R8+TmgKmXHcQx+nfjz/40laRQUHaVbUcPrbSWtELmVRR4r1bxUyQGul0YOBHQ0ZNvNqs
 Z27tStVInzKGgR/OAbzzY/Bk6pITkxgeWsYNtzIuXJ+abxj8ukBInD2NgkqOHnssZUSA
 v+AhfsP9DxVQSrEB1HTf9BmT7BI9KLEONsQGPdpy/Wiq1nwFvbV2pcM47w7o7ZJLm1YM ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g099tv6e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:40 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BC5eGS019242;
        Wed, 11 May 2022 12:05:40 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g099tv6dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC2c3M007177;
        Wed, 11 May 2022 12:05:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8wenv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5XOc57737574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3224A404D;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CE43A4055;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
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
Subject: [PATCH 1/8] s390/alternatives: provide identical sized orginal/alternative sequences
Date:   Wed, 11 May 2022 14:05:25 +0200
Message-Id: <20220511120532.2228616-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yye6i8Osi44w3H-rZcEV292eiibaz72a
X-Proofpoint-GUID: K6BmfBmemPbjrZUpI6TQm7TNQJnM-XNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=357
 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly provide identical sized original/alternative instruction
sequences. This way there is no need for the s390 specific alternatives
infrastructure to generate padding sequences.
The code which generates such sequences will be removed with a follow on
patch.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/spinlock.h |  2 +-
 arch/s390/kernel/entry.S         | 20 ++++++++++----------
 arch/s390/lib/spinlock.c         |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 10a460762e94..37127cd7749e 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -79,7 +79,7 @@ static inline void arch_spin_unlock(arch_spinlock_t *lp)
 	typecheck(int, lp->lock);
 	kcsan_release();
 	asm_inline volatile(
-		ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49)	/* NIAI 7 */
+		ALTERNATIVE("nop", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
 		"	sth	%1,%0\n"
 		: "=R" (((unsigned short *) &lp->lock)[1])
 		: "d" (0) : "cc", "memory");
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 685ccec02a27..a6b45eaa3450 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -53,19 +53,19 @@ STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
 _LPP_OFFSET	= __LC_LPP
 
 	.macro STBEAR address
-	ALTERNATIVE "", ".insn	s,0xb2010000,\address", 193
+	ALTERNATIVE "nop", ".insn s,0xb2010000,\address", 193
 	.endm
 
 	.macro LBEAR address
-	ALTERNATIVE "", ".insn	s,0xb2000000,\address", 193
+	ALTERNATIVE "nop", ".insn s,0xb2000000,\address", 193
 	.endm
 
 	.macro LPSWEY address,lpswe
-	ALTERNATIVE "b \lpswe", ".insn siy,0xeb0000000071,\address,0", 193
+	ALTERNATIVE "b \lpswe; nopr", ".insn siy,0xeb0000000071,\address,0", 193
 	.endm
 
 	.macro MBEAR reg
-	ALTERNATIVE "", __stringify(mvc __PT_LAST_BREAK(8,\reg),__LC_LAST_BREAK), 193
+	ALTERNATIVE "brcl 0,0", __stringify(mvc __PT_LAST_BREAK(8,\reg),__LC_LAST_BREAK), 193
 	.endm
 
 	.macro	CHECK_STACK savearea
@@ -121,16 +121,16 @@ _LPP_OFFSET	= __LC_LPP
 	.endm
 
 	.macro BPOFF
-	ALTERNATIVE "", ".insn rrf,0xb2e80000,0,0,12,0", 82
+	ALTERNATIVE "nop", ".insn rrf,0xb2e80000,0,0,12,0", 82
 	.endm
 
 	.macro BPON
-	ALTERNATIVE "", ".insn rrf,0xb2e80000,0,0,13,0", 82
+	ALTERNATIVE "nop", ".insn rrf,0xb2e80000,0,0,13,0", 82
 	.endm
 
 	.macro BPENTER tif_ptr,tif_mask
 	ALTERNATIVE "TSTMSK \tif_ptr,\tif_mask; jz .+8; .insn rrf,0xb2e80000,0,0,13,0", \
-		    "", 82
+		    "j .+12; nop; nop", 82
 	.endm
 
 	.macro BPEXIT tif_ptr,tif_mask
@@ -226,7 +226,7 @@ ENTRY(__switch_to)
 	aghi	%r3,__TASK_pid
 	mvc	__LC_CURRENT_PID(4,%r0),0(%r3)	# store pid of next
 	lmg	%r6,%r15,__SF_GPRS(%r15)	# load gprs of next task
-	ALTERNATIVE "", "lpp _LPP_OFFSET", 40
+	ALTERNATIVE "nop", "lpp _LPP_OFFSET", 40
 	BR_EX	%r14
 ENDPROC(__switch_to)
 
@@ -610,7 +610,7 @@ ENTRY(mcck_int_handler)
 	jno	0f
 	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 	stpt	__LC_EXIT_TIMER
-0:	ALTERNATIVE "", __stringify(lghi %r12,__LC_LAST_BREAK_SAVE_AREA),193
+0:	ALTERNATIVE "nop", __stringify(lghi %r12,__LC_LAST_BREAK_SAVE_AREA),193
 	LBEAR	0(%r12)
 	lmg	%r11,%r15,__PT_R11(%r11)
 	LPSWEY	__LC_RETURN_MCCK_PSW,__LC_RETURN_MCCK_LPSWE
@@ -646,7 +646,7 @@ ENTRY(mcck_int_handler)
 ENDPROC(mcck_int_handler)
 
 ENTRY(restart_int_handler)
-	ALTERNATIVE "", "lpp _LPP_OFFSET", 40
+	ALTERNATIVE "nop", "lpp _LPP_OFFSET", 40
 	stg	%r15,__LC_SAVE_AREA_RESTART
 	TSTMSK	__LC_RESTART_FLAGS,RESTART_FLAG_CTLREGS,4
 	jz	0f
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index 5e7ea8b111e8..04d4c6cf898e 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -75,7 +75,7 @@ static inline int arch_load_niai4(int *lock)
 	int owner;
 
 	asm_inline volatile(
-		ALTERNATIVE("", ".insn rre,0xb2fa0000,4,0", 49)	/* NIAI 4 */
+		ALTERNATIVE("nop", ".insn rre,0xb2fa0000,4,0", 49) /* NIAI 4 */
 		"	l	%0,%1\n"
 		: "=d" (owner) : "Q" (*lock) : "memory");
 	return owner;
@@ -86,7 +86,7 @@ static inline int arch_cmpxchg_niai8(int *lock, int old, int new)
 	int expected = old;
 
 	asm_inline volatile(
-		ALTERNATIVE("", ".insn rre,0xb2fa0000,8,0", 49)	/* NIAI 8 */
+		ALTERNATIVE("nop", ".insn rre,0xb2fa0000,8,0", 49) /* NIAI 8 */
 		"	cs	%0,%3,%1\n"
 		: "=d" (old), "=Q" (*lock)
 		: "0" (old), "d" (new), "Q" (*lock)
-- 
2.32.0

