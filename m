Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74110525590
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357958AbiELTPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbiELTPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:15:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9E4B1D4;
        Thu, 12 May 2022 12:15:11 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIbTjs023926;
        Thu, 12 May 2022 19:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=YpEO0KdiA/rXhe3VuVyVp2j9z7kZOz1bpeUtoucmd2g=;
 b=YFKgavX009gDXEaujZUJTsX2WSrwUP+dj+DzAcWyPAGNiLTdz5ue58U0HQCszae6bdiR
 dsshVafnVw84KI59n5nwMwCqNPeAJjcWcGH90TLhCsDyESLwor21KU+mNLDxGgOmrANg
 XUWVKdtOAYHoMTIErZUSNwOfc10cjIxCzRFHSDL+EIenDVS00KHxDRVUpoZAzVWKJznl
 lX7lhQrlP1KuRscMHEuRYSSBI9YLjD0VX1EFqiF+f/qUYUkBrb7EUHt4qISayQQ9p7cY
 mTM8Y5fXThBoWnbcXJ7431txWawH61YwrbsJLDs7i5vs6Mwh67jVAGs2pphY23ESCAMi 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g17p1gpdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:15:09 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CItDNE003787;
        Thu, 12 May 2022 19:15:09 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g17p1gpcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:15:09 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIvSuR009557;
        Thu, 12 May 2022 19:15:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fwg1hwu9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:15:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CJEeJr34931054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 19:14:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5C1552050;
        Thu, 12 May 2022 19:15:01 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 770F65204E;
        Thu, 12 May 2022 19:15:01 +0000 (GMT)
Date:   Thu, 12 May 2022 21:15:00 +0200
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
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
Message-ID: <Yn1ctPDjPaU2wsor@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-4-hca@linux.ibm.com>
 <Yn1CLcsu9I0M8IEM@osiris>
 <CAKwvOdmSBNsA7C2ZCGDEmuxCituSQ=HPJx=9+AsBAOYfkSZRPA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmSBNsA7C2ZCGDEmuxCituSQ=HPJx=9+AsBAOYfkSZRPA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7OLpGdtH-g-YMC9-2ucKkslZ-gRX8Zfk
X-Proofpoint-ORIG-GUID: _BROzOz5rNXd1WRHJ7_m_1bHe8nISl_E
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:00:31AM -0700, Nick Desaulniers wrote:
> On Thu, May 12, 2022 at 10:22 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > On Wed, May 11, 2022 at 02:05:27PM +0200, Heiko Carstens wrote:
> > > Since the minimum architecture level has been raised to z10 a shorter
> > > instruction sequence can be used to implement the OUTSIDE macro. This
> > > also reduces the number of used registers within that macro to one.
> > >
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > ---
> > >  arch/s390/kernel/entry.S | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > > index a6b45eaa3450..e1664b45090f 100644
> > > --- a/arch/s390/kernel/entry.S
> > > +++ b/arch/s390/kernel/entry.S
> > > @@ -169,11 +169,9 @@ _LPP_OFFSET      = __LC_LPP
> > >        * @outside_label: jump here if @reg is outside of [@start..@end)
> > >        */
> > >       .macro OUTSIDE reg,start,end,outside_label
> > > -     lgr     %r14,\reg
> > > -     larl    %r13,\start
> > > -     slgr    %r14,%r13
> > > -     lghi    %r13,\end - \start
> > > -     clgr    %r14,%r13
> > > +     larl    %r14,\start
> > > +     slgrk   %r14,\reg,%r14
> > > +     clgfi   %r14,\end - \start
> >
> > Clever me.. slgrk was added with z196, and not z10.
> > So dropping this patch.
> 
> How do the version numbers work for SystemZ? Is there a list/reference
> you could link me to?  If it's too deep a rabbit hole, then nevermind,
> but I would like to learn a little more about the architecture.

If it is only for the machine generations the following links might help:

https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
(see linked pdf for list of machine names)

https://en.wikipedia.org/wiki/IBM_Z

There might be better sources, but that's all I could find right now.
