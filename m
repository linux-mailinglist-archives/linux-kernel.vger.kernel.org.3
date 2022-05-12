Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27E525455
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357330AbiELSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357212AbiELSAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:00:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B94C74
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:00:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i10so10407949lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIUIK3/vvssf4wL4R4yeMIIg3nsvqklAR/DEjJ1CAm4=;
        b=ccasTpHZqLRg0Dkgl8Ihu4LaomzXbUhwYSh1fwRbe5hvyv4gVY5MRM6btJfuT2HkgD
         Yfi29F8Xw/4nJhGRIxPC7ziiFvTkipDqhk8NfYiUg6jk+ewv+1gk0EonjuGtuVANyW8h
         vP6to6PHdIMhqQ/8akSnGCCvG0Bf1mX88xHMGhC6oqXD1/bi/NFoYXkXLRRtEHoxoYEm
         sxgVee4bXilSSl6hpnr1z3ahGsqGv/qGqmqpW3c/48bJj8sBZ+AwMgVVIMQ1h+8lBiXT
         msJz6LS8qOAWudNX7tX3gdjeEzGOZPg/LmNbdtS0fpr9orjDAUfFWBeKzwHfTEFNFx8l
         DLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIUIK3/vvssf4wL4R4yeMIIg3nsvqklAR/DEjJ1CAm4=;
        b=7yu6DBXOByLqXDJWzsFcrafBsRiz65TEy4UGMlqWD3Pg7JLmANNeWEmHom6KozVzS0
         lsI5VY/3QJ2TDzMEcNZnEFpBKVlHA3nEuhTQ2sQFOZTE5DekiHcOAm735/FqGTzfHmdF
         YHr6t8KIPDsxusbbN/kFT89ysNPPgRfJS8PWkLNybyjASlwZ3urtedZnK4yFh/4ibcua
         TvQmdVL8yyDD49LSSamlCOwMfwMsoFKvS69YkiVpao1OyE9R8VHLW4qPaKW8SLjHiTKv
         e5CKU8ZR1KyQxGo+96+RI5S4p4kejghf2F3S8vKeL0UKIWd1jWwcSlHU2YIwG7+S3NeU
         D+cg==
X-Gm-Message-State: AOAM53297fOgRVPj7G2/YJM8f7EBfkabLBmjWCzOZbMF1Rr91gWF1ykI
        bd1zr2WkusxkqGGLeIk19xe7psIQu2t1/99vbAnx8Q==
X-Google-Smtp-Source: ABdhPJxOG/NkXFVV6nAx9ClTAlKcpWSaUzyjdt+9an0VWAbc3h3vB+4ksHhR80k/qq0QPRjiAIdB7WGAx6fvI2/ho1A=
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id
 b6-20020ac25e86000000b00473d04460f5mr667320lfq.87.1652378443079; Thu, 12 May
 2022 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-4-hca@linux.ibm.com>
 <Yn1CLcsu9I0M8IEM@osiris>
In-Reply-To: <Yn1CLcsu9I0M8IEM@osiris>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 May 2022 11:00:31 -0700
Message-ID: <CAKwvOdmSBNsA7C2ZCGDEmuxCituSQ=HPJx=9+AsBAOYfkSZRPA@mail.gmail.com>
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
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
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:22 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Wed, May 11, 2022 at 02:05:27PM +0200, Heiko Carstens wrote:
> > Since the minimum architecture level has been raised to z10 a shorter
> > instruction sequence can be used to implement the OUTSIDE macro. This
> > also reduces the number of used registers within that macro to one.
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/kernel/entry.S | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > index a6b45eaa3450..e1664b45090f 100644
> > --- a/arch/s390/kernel/entry.S
> > +++ b/arch/s390/kernel/entry.S
> > @@ -169,11 +169,9 @@ _LPP_OFFSET      = __LC_LPP
> >        * @outside_label: jump here if @reg is outside of [@start..@end)
> >        */
> >       .macro OUTSIDE reg,start,end,outside_label
> > -     lgr     %r14,\reg
> > -     larl    %r13,\start
> > -     slgr    %r14,%r13
> > -     lghi    %r13,\end - \start
> > -     clgr    %r14,%r13
> > +     larl    %r14,\start
> > +     slgrk   %r14,\reg,%r14
> > +     clgfi   %r14,\end - \start
>
> Clever me.. slgrk was added with z196, and not z10.
> So dropping this patch.

How do the version numbers work for SystemZ? Is there a list/reference
you could link me to?  If it's too deep a rabbit hole, then nevermind,
but I would like to learn a little more about the architecture.
-- 
Thanks,
~Nick Desaulniers
