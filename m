Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6053E525415
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357302AbiELRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357298AbiELRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:49:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E71FC7F3;
        Thu, 12 May 2022 10:49:52 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHR6VK004627;
        Thu, 12 May 2022 17:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bpeD2HFfkn9EV8kkYW+dcwfbSEJuOsOHuCZmm+RJp30=;
 b=HnLki8b/0C8RcG/0Tl1nLQFH9WFzQ/UBN5eIl5SLqfP7UON+JzXpzYFWFjJsJHYItpuv
 sllDVi1qMCUAg2i/ah9059O/voYRBR4s/sHAPqZsxJR6xuN5K4DgMyIMiMISnOVA6dyf
 nQu3oilBfqETU6Jmbs4O6rSo8dPGKMfB4nzscdqG9jnX11hTYb/QF2jJQj0NiJDYaWd0
 kLkD2FiUwd8CgeMnUFM2IeLeMtBY9+FZbdZ3HCDi/C+m1B78hnVtnYFzPmFzx1Agx+7e
 0zQrjiHm49j/D1MO8eG5lwa4SOgLjA/UTROXzGhKA/o+Nia0mzU2smLEPihzsxnE5DSw 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g12xyxtty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:49:49 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CHctVP010426;
        Thu, 12 May 2022 17:49:49 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g12xyxtt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:49:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CHI4sK017372;
        Thu, 12 May 2022 17:25:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3g0ma1h3tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:25:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CHPej059375960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:25:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 508B15204F;
        Thu, 12 May 2022 17:25:40 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D17EE5204E;
        Thu, 12 May 2022 17:25:39 +0000 (GMT)
Date:   Thu, 12 May 2022 19:25:38 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/8] s390/purgatory: workaround llvm's IAS limitations
Message-ID: <Yn1DEkfK0vxw8Ta8@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-6-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-6-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BKgVOrTk00M1wkzpD_i7KO6_sBD5f96I
X-Proofpoint-ORIG-GUID: ukOQ5NmzVerh34wRy9VErqmr7gqepddf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=984 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205120080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:05:29PM +0200, Heiko Carstens wrote:
> llvm's integrated assembler cannot handle immediate values which are
> calculated with two local labels:
> 
> arch/s390/purgatory/head.S:139:11: error: invalid operand for instruction
>  aghi %r8,-(.base_crash-purgatory_start)
> 
> Workaround this by partially rewriting the code.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/purgatory/head.S | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
...
> -	aghi	%r10,stack-purgatory_start
> +	larl	%r0,purgatory_start
> +	slgrk	%r0,%r7,%r0
> +	agr	%r10,%r0

Same problem here: slgrk does not work for MARCH=z10. So new version
looks like:

From 99e011fa48d9fe90f6d3d58cf89f738afddf394f Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Sat, 7 May 2022 20:08:55 +0200
Subject: [PATCH 4/7] s390/purgatory: workaround llvm's IAS limitations

llvm's integrated assembler cannot handle immediate values which are
calculated with two local labels:

arch/s390/purgatory/head.S:139:11: error: invalid operand for instruction
 aghi %r8,-(.base_crash-purgatory_start)

Workaround this by partially rewriting the code.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/purgatory/head.S | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/s390/purgatory/head.S b/arch/s390/purgatory/head.S
index 3d1c31e0cf3d..6f835124ee82 100644
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
@@ -169,7 +182,10 @@ ENTRY(purgatory_start)
 
 	/* Load new buffer location after jump */
 	larl	%r7,stack
-	aghi	%r10,stack-purgatory_start
+	lgr	%r0,%r7
+	larl	%r1,purgatory_start
+	slgr	%r0,%r1
+	agr	%r10,%r0
 	MEMCPY	%r10,%r7,%r11	/* (new) buf -> (crash) buf */
 
 	/* Now the code is set up to run from its designated location. Start
-- 
2.32.0

