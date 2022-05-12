Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522D5255AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358013AbiELTZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352586AbiELTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:25:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FE2764F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:25:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c24so1347484lfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mcqHVCTOADxT4nWVQOUHhwOqrmkthTN0rJ4nqx8rlI=;
        b=fKCnjktwaZsXbw/hdsBSxLZqoXSDDmhQvbTlTr5AYZ8Oy9oDUyxGAllTgPTTqFT04O
         m3sldOJGdC7gWeyAiRqa6IJQGSutRiFPDgOfJHVXCK9s083fVPgxQPUY77Arc5Iw8i2M
         bzjk6gJ2wHqyIN4IC25rZeTcE6tYu32CyQFwUYh9yoERE+bORr/w4KbFaYi4udwHmUr1
         OV+KCPvty4O2N28zK2+oGjyyDLNkBRxkRphYt3yx6lcqqjQciRkriZ38J7/aLAmLkaWX
         TP3pdlbT3G+gvU7KLn0XzLasIlbneDcjX60j2vXak3HjF2T4saXxRHcBR7/nrnjawfyJ
         qNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mcqHVCTOADxT4nWVQOUHhwOqrmkthTN0rJ4nqx8rlI=;
        b=2rKO1+Mujy2HDkCkNg2pBCk6wKLwMhaBBSdJWSxYwj0glS5FXLXzTzNJHi5lXOTfnw
         lExvg0lJRxqZvrtQCEwCVw2GxeUzLeecUTa7yUHAJhY/a+gqR/U3tg9Wv6QjA6lo3Cw8
         havDznzh29ah0yOZ+YrGmDoa/Qc164qppAoTlk/EZsFXnIyutysbZ6oWaSiyywzv0A+R
         6V804RAkFJsni5zKnSiKEnP+zSTBnAQGY99ktCvLtV2QHv0Ibkea3rbcjIyOfKjBUK2i
         Rex0z4N41Ih/DykQoE2IWGjNQ50og7d8UhshFXlGqi/IGHJqkeryfdADqsH89s2IcB+T
         vudQ==
X-Gm-Message-State: AOAM532LToCxlFLA6hmgQIrxCkiZh4XkI870cruKpVEjvZgcnhzNUZLV
        Fat6C/qSOkJaq3RyXnf/P5Tb9y7X+ImhEunHGJ/XaQ==
X-Google-Smtp-Source: ABdhPJwheBuGcaGgIIU/pM/BIG++IJsDiYIDUzck0xktR1ebk4IiEg3VfSwDzPBi50vdfq6jUaJJBc2HMtWkYUaWDT4=
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr908856lfs.190.1652383512824; Thu, 12
 May 2022 12:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-4-hca@linux.ibm.com>
 <Yn1CLcsu9I0M8IEM@osiris> <CAKwvOdmSBNsA7C2ZCGDEmuxCituSQ=HPJx=9+AsBAOYfkSZRPA@mail.gmail.com>
 <Yn1ctPDjPaU2wsor@osiris>
In-Reply-To: <Yn1ctPDjPaU2wsor@osiris>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 May 2022 12:25:01 -0700
Message-ID: <CAKwvOdkwamvuCFkj-uFA_uT+gLNr8-v-zuGYLYb-pV8TOTxDSw@mail.gmail.com>
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
To:     Heiko Carstens <hca@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:15 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Thu, May 12, 2022 at 11:00:31AM -0700, Nick Desaulniers wrote:
> > On Thu, May 12, 2022 at 10:22 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> > >
> > > On Wed, May 11, 2022 at 02:05:27PM +0200, Heiko Carstens wrote:
> > > > Since the minimum architecture level has been raised to z10 a shorter
> > > > instruction sequence can be used to implement the OUTSIDE macro. This
> > > > also reduces the number of used registers within that macro to one.
> > > >
> > > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > > ---
> > > >  arch/s390/kernel/entry.S | 8 +++-----
> > > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > > > index a6b45eaa3450..e1664b45090f 100644
> > > > --- a/arch/s390/kernel/entry.S
> > > > +++ b/arch/s390/kernel/entry.S
> > > > @@ -169,11 +169,9 @@ _LPP_OFFSET      = __LC_LPP
> > > >        * @outside_label: jump here if @reg is outside of [@start..@end)
> > > >        */
> > > >       .macro OUTSIDE reg,start,end,outside_label
> > > > -     lgr     %r14,\reg
> > > > -     larl    %r13,\start
> > > > -     slgr    %r14,%r13
> > > > -     lghi    %r13,\end - \start
> > > > -     clgr    %r14,%r13
> > > > +     larl    %r14,\start
> > > > +     slgrk   %r14,\reg,%r14
> > > > +     clgfi   %r14,\end - \start
> > >
> > > Clever me.. slgrk was added with z196, and not z10.
> > > So dropping this patch.
> >
> > How do the version numbers work for SystemZ? Is there a list/reference
> > you could link me to?  If it's too deep a rabbit hole, then nevermind,
> > but I would like to learn a little more about the architecture.
>
> If it is only for the machine generations the following links might help:
>
> https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
> (see linked pdf for list of machine names)
>
> https://en.wikipedia.org/wiki/IBM_Z
>
> There might be better sources, but that's all I could find right now.

Interesting! Thanks for the links.
I'm guessing in our CI that we should probably pursue testing some of
the newer revisions. Wasn't defconfig updated from z10 to z12 not too
long ago?
So probably
CONFIG_MARCH_Z13
CONFIG_MARCH_Z14
CONFIG_MARCH_Z15
CONFIG_MARCH_Z16

All look like they're still "supported" (and I'm guessing
CONFIG_MARCH_Z10 and CONFIG_MARCH_Z196 are not too much burden to
continue to maintain kernel support for), with a higher emphasis
perhaps on z15+z16?
-- 
Thanks,
~Nick Desaulniers
