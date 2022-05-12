Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79D525383
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356992AbiELRYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbiELRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:24:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A826AD97;
        Thu, 12 May 2022 10:24:37 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHNnJO030267;
        Thu, 12 May 2022 17:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0EnPkjy04iUDHw51RwN6mlhwJWDq0hIMdChZ8ntgUmo=;
 b=gdrNhFROIUrL9YgeUvDPRsVAe2hlZ1hidRoP5VkbxUXYV934d21g/HBZj/WjtQam/8fZ
 ufuf8/1d0NgfRswa4HCC90BX+vhyeF3JCCTfV5c40HVYOGZKwuVbQmPLpm79IPj0+Ryx
 Bpmb5+lnv16ldFqPn0V44dYnTEPBdcI+Kxzx2VZKOc+ThVOzh4k2JDv7GWaHTOiMTW2L
 45N0OUB9W22FpqUPsAvpQYucn4LppEfx+mNllhIDROhEDYQ9mU/AZP30l5osZjkFw2Rv
 6QudBQBXCMD8MWNc9JLjYhJzSAI0dyyfscZqKJuLve83+O9ur/uXnOtHZtO4SYKEXrxL 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g16dy094e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:24:35 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CHOYdF031921;
        Thu, 12 May 2022 17:24:34 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g16dy093y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:24:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CHHZ4U028828;
        Thu, 12 May 2022 17:24:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk38tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:24:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CHOR0H45613342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:24:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAC98A405C;
        Thu, 12 May 2022 17:24:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED615A405B;
        Thu, 12 May 2022 17:24:26 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 17:24:26 +0000 (GMT)
Date:   Thu, 12 May 2022 19:24:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>
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
Subject: Re: [PATCH 4/8] s390/entry: workaround llvm's IAS limitations
Message-ID: <Yn1CyTcrZk1Kgvoq@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OMQVp_RV79RKXV7KXlYoqXnFDZ8vyD1k
X-Proofpoint-GUID: R12ejW5A8IwqXRFKmu1gs953MqA3hVsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=880
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:30:05AM -0700, Nathan Chancellor wrote:
> Hi Heiko,
> 
> On Wed, May 11, 2022 at 02:05:28PM +0200, Heiko Carstens wrote:
> > llvm's integrated assembler cannot handle immediate values which are
> > calculated with two local labels:
> > 
> > <instantiation>:3:13: error: invalid operand for instruction
> >  clgfi %r14,.Lsie_done - .Lsie_gmap
> > 
> > Workaround this by adding clang specific code which reads the specific
> > value from memory. Since this code is within the hot paths of the kernel
> > and adds an additional memory reference, keep the original code, and add
> > ifdef'ed code.
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/kernel/entry.S | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > index e1664b45090f..ff7a75078e93 100644
> > --- a/arch/s390/kernel/entry.S
> > +++ b/arch/s390/kernel/entry.S
> > @@ -171,8 +171,19 @@ _LPP_OFFSET	= __LC_LPP
> >  	.macro OUTSIDE reg,start,end,outside_label
> >  	larl	%r14,\start
> >  	slgrk	%r14,\reg,%r14
> > +#ifdef CONFIG_CC_IS_CLANG
> 
> I intend to put this series through my build and boot test matrix later
> today but one fly by comment in the meantime. Should this be
> CONFIG_AS_IS_LLVM if this is an integrated assembler limitation, rather
> than a clang one?

Yes, that makes a lot of sense. Considering that I will drop the
previous patch within this series, the new version looks like:

From fe4fb0b014378d84ae517deaea338577b2ea6ae0 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Sat, 7 May 2022 15:00:40 +0200
Subject: [PATCH 3/7] s390/entry: workaround llvm's IAS limitations

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
 arch/s390/kernel/entry.S | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index a6b45eaa3450..f2f30bfba1e9 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -172,9 +172,19 @@ _LPP_OFFSET	= __LC_LPP
 	lgr	%r14,\reg
 	larl	%r13,\start
 	slgr	%r14,%r13
-	lghi	%r13,\end - \start
-	clgr	%r14,%r13
+#ifdef CONFIG_AS_IS_LLVM
+	clgfrl	%r14,.Lrange_size\@
+#else
+	clgfi	%r14,\end - \start
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
