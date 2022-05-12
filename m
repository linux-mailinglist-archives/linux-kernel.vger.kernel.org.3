Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D452555D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357887AbiELTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357878AbiELTGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:06:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635FB3F32C;
        Thu, 12 May 2022 12:06:52 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIRWt3013301;
        Thu, 12 May 2022 19:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WXQORcdH4dsqLKEQq1CAxyPboU4WPCeRjlncygp/oZw=;
 b=MRjxXPYzOckLF0WFyxBEPwcF1aRfNE8aOymHpcG2SyTUXklsNYt3ZFFUjExmqNZmkBcI
 sWvAzcIcFER34bfHHi8CG7yxbpMe4jXl3JVLV8R/Yd8RXU9PcfkzYpp7swgIhYdirRxg
 PNmOuL/txvXBTTryvZkIsv6XxYBx9MP4sJskhxAbEjrDbpbEAy5ioLD9SjYhHcgiJ9oq
 oYhgRo7r/T2sZ7NwcbSB+mPTfvzhKK6ortFfm2QolymNf3mzusIrY3cIO57z13S791u4
 CJUzTtj4H5kV+943ItLVLLtmOqcQwu84rc4m4rPpR+tp0zE0dj9ICD5DL8NRjNLuSJvI 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g173b9cbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:06:46 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CIUii4031436;
        Thu, 12 May 2022 19:06:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g173b9cbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:06:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIvS5M022335;
        Thu, 12 May 2022 19:06:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk3bn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:06:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CJ6Hl334341284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 19:06:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E0B8AE051;
        Thu, 12 May 2022 19:06:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3B0AAE045;
        Thu, 12 May 2022 19:06:38 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 19:06:38 +0000 (GMT)
Date:   Thu, 12 May 2022 21:06:37 +0200
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
Subject: Re: [PATCH 8/8] scripts/min-tool-version.sh: raise minimum clang
 version to 14.0.0 for s390
Message-ID: <Yn1avbuIFdU87/Jj@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-9-hca@linux.ibm.com>
 <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
 <CAKwvOd=T5bd69-pduh8OnYdzGuBdJmF692VYP833ZG3BfGUA+A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=T5bd69-pduh8OnYdzGuBdJmF692VYP833ZG3BfGUA+A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YX5qN9dn6S3zoj9gnAkZCOXN2pHBIHob
X-Proofpoint-GUID: jmJUx8zmjiwk9Er2jItvWMIruAC1JQNY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=744 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
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

On Wed, May 11, 2022 at 12:56:27PM -0700, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 12:27 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> > >
> > > Before version 14.0.0 llvm's integrated assembler fails to handle some
> > > displacement variants:
> > >
> > > arch/s390/purgatory/head.S:108:10: error: invalid operand for instruction
> > >  lg %r11,kernel_type-.base_crash(%r13)
> > >
> > > Instead of working around this and given that this is already fixed
> > > raise the minimum clang version from 13.0.0 to 14.0.0.
> >
> > Do you have the commit in LLVM that fixed this? Might be nice to link
> 
> Maybe it's
> https://reviews.llvm.org/D113341?

Yes, looks like it.

> Also, these are the open issues we had for the integrated assembler.
> https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+s390%22+label%3A%22%5BTOOL%5D+integrated-as%22
> 
> Any chance you could include relevant Link tags on your commit
> messages for patches that address these? It makes it easier to track
> when/where things land if we ever intend to backport anything to
> stable.

Sure, will do.
