Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172C5281B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiEPKUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242121AbiEPKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:19:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276BDEB2;
        Mon, 16 May 2022 03:19:57 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GA1aNm024218;
        Mon, 16 May 2022 10:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=heA/a/Vjq9adtkbXdF/L8qMvf1DUOfGrfsS8FQ2zZDc=;
 b=gVm50wPawJR11DVSSRTatPRmWXy+XpXRmEMmK9vGFVWjd4ltKL/kiTu4/1VmY9bCO37/
 vnd4XCbenOu0EazjPc6avyBdTfyjnka0vBDZXcw5j2sIggixjJxO6eC/JmPCASzU+ZOU
 PTGtzipgXNea838u3HeeI2rsylaaRKqvFda8ZOqOdpqhn54tuqLmUBUXN7/9IBg2YXju
 6+lJJ8H5l4P+S1NMakjNnjaS1Lyjve0n3sFoMWpDOIP//fuIWvKMUc9vgR6UWT5+4SgU
 GNT5m5LH1REQQtHcq5XTi2SmfSkaWkfihcTejbqFgi7rox313iJsChlULULvIMdJ7g4T bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mgdrata-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:19:55 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GA4b9M030636;
        Mon, 16 May 2022 10:19:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mgdrasm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:19:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GAJUUs011291;
        Mon, 16 May 2022 10:19:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429af31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:19:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GAJluw36766110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 10:19:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66389A405B;
        Mon, 16 May 2022 10:19:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2D53A4054;
        Mon, 16 May 2022 10:19:46 +0000 (GMT)
Received: from osiris (unknown [9.145.19.162])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 10:19:46 +0000 (GMT)
Date:   Mon, 16 May 2022 12:19:45 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
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
Message-ID: <YoIlQaWNy1wu39ak@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
 <Yn1CyTcrZk1Kgvoq@osiris>
 <YoIUX864ULCwu4pz@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoIUX864ULCwu4pz@tuxmaker.boeblingen.de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cznqW8sqX3mDTXjT8lDsfJQaXmNJw4vi
X-Proofpoint-ORIG-GUID: Nm32b99yoNjb8327YiYrJNcuP-aiU3Q-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:07:43AM +0200, Alexander Gordeev wrote:
> > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > index a6b45eaa3450..f2f30bfba1e9 100644
> > --- a/arch/s390/kernel/entry.S
> > +++ b/arch/s390/kernel/entry.S
> > @@ -172,9 +172,19 @@ _LPP_OFFSET	= __LC_LPP
> >  	lgr	%r14,\reg
> >  	larl	%r13,\start
> >  	slgr	%r14,%r13
> > -	lghi	%r13,\end - \start
> > -	clgr	%r14,%r13
> > +#ifdef CONFIG_AS_IS_LLVM
> > +	clgfrl	%r14,.Lrange_size\@
> > +#else
> > +	clgfi	%r14,\end - \start
> > +#endif
> >  	jhe	\outside_label
> > +#ifdef CONFIG_CC_IS_CLANG
> > +	.section .rodata, "a"
> > +	.align 4
> > +.Lrange_size\@:
> > +	.long	\end - \start
> 
> Isn't the machine check handler refers to this memory before checking
> unrecoverable storage errors (with CHKSTG macro) as result of this change?

Yes, indeed. However implementing this without another register will
be quite of a challenge. So what I would prefer in any case: just
assume that this minimal set of memory accesses work. Actually I'd
seriously like to go a bit further, and even move the checks for
storage errors back to C for two reasons:

- this would make the machine check handler entry code easier again
- it would also allow to enter the machine check handler with DAT on

After all we rely anyway on the fact that at least the local lowcore +
the page(s) which contain text are still accessible. Assuming that a
couple of page tables also work won't make this much worse, but the
code much easier.

So I'd suggest: leave this code as is, and at some later point move
"rework" the early machine check handler code.

What do you think?
