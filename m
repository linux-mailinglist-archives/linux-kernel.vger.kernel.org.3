Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E027528063
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiEPJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiEPJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:07:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4364E13CDD;
        Mon, 16 May 2022 02:07:56 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G7kGkK027609;
        Mon, 16 May 2022 09:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8fVya5SouKGDBotaRmB4/dF1qRiUasv0dXnWqkQaliQ=;
 b=kkqN6jXEE0slsnjugc96mUDPeWc3jmDpUu1AE4kgzVZm1CEcO1X57HLTQYPA/pTGNQ32
 IDGw8PSfmROQeHmOrlEIibigU1w+H7VMV5nGF/OXPJ2vJDIjxVayO7ZSquB7k9Njv2Ct
 LTPnADtuQ6yFCUYR8KwfbibuUx1Q0VB9KKNjD0aTIBhptQa9fxJVkmKPds/cPDFDQ9ty
 qNtFW9u38UbsvZiRGkBEnkqJBqJCG5zCjLqlSa5FPboUX3zSgy8ruw1LtSOXNA92vn4t
 Wt3dQHm2Rf7NGdoX1Wbh5UQkj+RD8rTv9WMeCfe9IC2e3636/zTITChvkWVAI2XdLiT2 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3jgtsg7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:07:53 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24G8i0bG017939;
        Mon, 16 May 2022 09:07:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3jgtsg6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:07:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24G95f9b013045;
        Mon, 16 May 2022 09:07:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3g23pj1trr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:07:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24G97iGT26935610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 09:07:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4BFC4C040;
        Mon, 16 May 2022 09:07:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48E954C04E;
        Mon, 16 May 2022 09:07:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 09:07:44 +0000 (GMT)
Date:   Mon, 16 May 2022 11:07:43 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
Message-ID: <YoIUX864ULCwu4pz@tuxmaker.boeblingen.de.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
 <Yn1CyTcrZk1Kgvoq@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn1CyTcrZk1Kgvoq@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MudZRC9NlkG1-HT2VIRnghBoTKpnAbix
X-Proofpoint-ORIG-GUID: pKNbuxM8qjndItLrPEl2nnX3wFIhDla9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=791 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 07:24:25PM +0200, Heiko Carstens wrote:
> From fe4fb0b014378d84ae517deaea338577b2ea6ae0 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Sat, 7 May 2022 15:00:40 +0200
> Subject: [PATCH 3/7] s390/entry: workaround llvm's IAS limitations
> 
> llvm's integrated assembler cannot handle immediate values which are
> calculated with two local labels:
> 
> <instantiation>:3:13: error: invalid operand for instruction
>  clgfi %r14,.Lsie_done - .Lsie_gmap
> 
> Workaround this by adding clang specific code which reads the specific
> value from memory. Since this code is within the hot paths of the kernel
> and adds an additional memory reference, keep the original code, and add
> ifdef'ed code.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/entry.S | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index a6b45eaa3450..f2f30bfba1e9 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -172,9 +172,19 @@ _LPP_OFFSET	= __LC_LPP
>  	lgr	%r14,\reg
>  	larl	%r13,\start
>  	slgr	%r14,%r13
> -	lghi	%r13,\end - \start
> -	clgr	%r14,%r13
> +#ifdef CONFIG_AS_IS_LLVM
> +	clgfrl	%r14,.Lrange_size\@




> +#else
> +	clgfi	%r14,\end - \start
> +#endif
>  	jhe	\outside_label
> +#ifdef CONFIG_CC_IS_CLANG
> +	.section .rodata, "a"
> +	.align 4
> +.Lrange_size\@:
> +	.long	\end - \start

Isn't the machine check handler refers to this memory before checking
unrecoverable storage errors (with CHKSTG macro) as result of this change?

> +	.previous
> +#endif
>  	.endm
>  
>  	.macro SIEEXIT
> -- 
> 2.32.0
