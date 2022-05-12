Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA215253B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357072AbiELRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351619AbiELRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:30:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0805109D;
        Thu, 12 May 2022 10:30:41 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHRp7a011280;
        Thu, 12 May 2022 17:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=12Vomm7rfRWXq7hx4VWQjYxycMVePLS4XFiektWNuiA=;
 b=F5SnwWttT1ozSEaRcy7dP9v7bnsigqPNlHynGVTypdma84CehaAzGIZu+sAqVgyYCJr7
 XpzF70QY+QPbs/o8CA18nmt803ArbVuu0K6TlApZB8QK5Gf4aXZvXSuPtd3accH1y6Pm
 lJwoXUSBxBpS8XZiFLkSXGszm77cLIa8JGCkxWRlW/ul8Ws3tzocuQ739UXmXIEl0f7Y
 WEezBb0MMLIeFdUvIvDa0njCGi2WWpmw/WOYF9Db1AqlgZDjJedMdNdCb89Du0ipOnwg
 3NhBX40csjQQK1atFiadv2HwOsk6Vk+8X6aD/BCJoBq2uAjJWDi/HEDknzNfdYQzdxMI Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g16af8hcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:30:38 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CHSieR014855;
        Thu, 12 May 2022 17:30:38 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g16af8hbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:30:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CHHx8W017330;
        Thu, 12 May 2022 17:30:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3g0ma1h3xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:30:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CHUWGn35324210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:30:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2F38AE04D;
        Thu, 12 May 2022 17:30:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85631AE053;
        Thu, 12 May 2022 17:30:31 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 17:30:31 +0000 (GMT)
Date:   Thu, 12 May 2022 19:30:30 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 7/8] s390/boot: do not emit debug info for assembly with
 llvm's IAS
Message-ID: <Yn1ENkc1EhHob6+x@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-8-hca@linux.ibm.com>
 <CAKwvOdn3Mdn9ek-7EotHmd6Wb7C5rzZnOxAQVtbQEd2LBBZGRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn3Mdn9ek-7EotHmd6Wb7C5rzZnOxAQVtbQEd2LBBZGRg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9r0CY21jMeVAH1bAfy1VTpl15ioUyYvM
X-Proofpoint-ORIG-GUID: mrGTfFF7mxrbq85IbDp0Fzwor2Xl6DPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 malwarescore=0
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

On Wed, May 11, 2022 at 12:40:07PM -0700, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > Commit ee6d777d3e93 ("s390/decompressor: support extra debug flags")
> > added extra debug flags, in particular debug info is created,
> > depending on config options.
> >
> > With llvm's IAS this causes this compile warning:
> >
> > arch/s390/boot/head.S:38:1: warning: DWARF2 only supports one section per compilation unit
> > .section ".head.text","ax"
> > ^
> >
> > This is a known problem and was addressed with a commit b8a9092330da
> > ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1").
> > Just do the same for s390 to get rid of this warning.
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> > index c59efc83f020..d73611b35164 100644
> > --- a/arch/s390/Makefile
> > +++ b/arch/s390/Makefile
> > @@ -20,7 +20,9 @@ LDFLAGS_vmlinux       := -pie
> >  endif
> >  aflags_dwarf   := -Wa,-gdwarf-2
> 
> ^ or can we use a more modern variant of dwarf, like at least dwarf-4?

For now I would like that this works the same like what you introduced
with commit b8a9092330da ("Kbuild: do not emit debug info for assembly
with LLVM_IAS=1").

I wouldn't like to have dwarf-4 enabled only for this single file, and
disabled for all other asm files (assuming that dwarf-4 works).
