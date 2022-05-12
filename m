Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0588525379
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356982AbiELRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356981AbiELRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:22:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2866AF6;
        Thu, 12 May 2022 10:22:02 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHKUCa011895;
        Thu, 12 May 2022 17:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bPdVCnCIWEacY7fSG/XOyHejYZbwJTakmHy8ZHlj6KQ=;
 b=sl5sAl+grzkLS/TtP37trAfs/O/bVjd6/xDCiIqd0b2ByQZDR5Jz1pZLzuv0zGIMpCAM
 w5X7TJ8Rc75DhFp/IXJsXoS9UHv7T8i/ElTAQJSFvNf+BqYrUFD50J/LQKRjm00gcTth
 7PxU/HNJOtKDgixWCkln3EGteKVMvm42zXRvRCX3rQAIBlHVgQtq5G3E9UuTyftEvAjl
 nPz/3jnM5Mu6ETZGD3IEOFNto/CfdUT1Zrzhs7+rEs3b3Lvf06PXXmx0EtSptHXuyeZE
 2Fuk0qudvFiBomz/+GRRe5+SjP1dpg0Jm+PErnp9hp2NcBOpL5z+fWXE3A7ySbNP8D46 aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g16af8b0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:21:59 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CHLxZt015470;
        Thu, 12 May 2022 17:21:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g16af8b08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:21:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CHIhAh005251;
        Thu, 12 May 2022 17:21:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8ycqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:21:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CHLUpY32506244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:21:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C99CBA4040;
        Thu, 12 May 2022 17:21:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53708A404D;
        Thu, 12 May 2022 17:21:51 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 17:21:51 +0000 (GMT)
Date:   Thu, 12 May 2022 19:21:49 +0200
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
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
Message-ID: <Yn1CLcsu9I0M8IEM@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-4-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nv5aANPpoAXu9r5rKH9n_HXnkoxomRFS
X-Proofpoint-ORIG-GUID: tWPU1_D1ocZkUH4-iG6iv5zAjWzFoWus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=630 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:05:27PM +0200, Heiko Carstens wrote:
> Since the minimum architecture level has been raised to z10 a shorter
> instruction sequence can be used to implement the OUTSIDE macro. This
> also reduces the number of used registers within that macro to one.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/entry.S | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index a6b45eaa3450..e1664b45090f 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -169,11 +169,9 @@ _LPP_OFFSET	= __LC_LPP
>  	 * @outside_label: jump here if @reg is outside of [@start..@end)
>  	 */
>  	.macro OUTSIDE reg,start,end,outside_label
> -	lgr	%r14,\reg
> -	larl	%r13,\start
> -	slgr	%r14,%r13
> -	lghi	%r13,\end - \start
> -	clgr	%r14,%r13
> +	larl	%r14,\start
> +	slgrk	%r14,\reg,%r14
> +	clgfi	%r14,\end - \start

Clever me.. slgrk was added with z196, and not z10.
So dropping this patch.
