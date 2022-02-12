Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4344B363D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiBLQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:10:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiBLQKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:10:38 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC5B9;
        Sat, 12 Feb 2022 08:10:34 -0800 (PST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 21CGAKx7014814;
        Sun, 13 Feb 2022 01:10:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 21CGAKx7014814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644682221;
        bh=hskrob/LwwnZTTYDdiKAwM9nwUbNCozMVYrJE5Yq09o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qh/1P+Gs5ptqJ9GAuK2XVYs3GqHUDHa4UF4ol1jltLhCtX2xIEzC0Q7ZimS8fsmKT
         NweopOmyve6EngU6imZitMn0QmDsdq1uGiaQh4d52FKwytd0ATj2tgTDiyBjpTrMZu
         5v4XWlU3oWqZFPtIl/2MC41pka1ESufRIHSIbDcKR5G288OAYOMZ1AOCtWa9bd+e4W
         ovfTlQ2Qv8QV0E46QJtCbX5Dslr4wK52ruAI61OKnn6DQTjghv21H5RARYJUpIkCF/
         3FlldBEXpPucaWmW7lKGfDX82TjSRDIbQr3xfAnG4UssKYvqZfmpu28aRr9GxuSXOL
         F4EunJRAvpURQ==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id j4so7063872plj.8;
        Sat, 12 Feb 2022 08:10:21 -0800 (PST)
X-Gm-Message-State: AOAM533MjO7hMMgy95ebATFjjjntXbJu3O50hCoK25IRYiD90hL0zon7
        +4ZKxrchvUHwNDi7lGkAiufpMsSpLwp2DUUVjHY=
X-Google-Smtp-Source: ABdhPJznGEDx8faq6saaYfWibBHIYHB/fmCWjBtc1STqObIEdNlh9y/BZLdEsbUC3+JPL1ZG9TejPDmQhxE2pYH7j1k=
X-Received: by 2002:a17:902:e782:: with SMTP id cp2mr6291839plb.162.1644682220091;
 Sat, 12 Feb 2022 08:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20220208062618.1869210-1-masahiroy@kernel.org>
 <CAK7LNASojfnOaAmgwwCsA9J-nhYtRzJx8AKmy8OpRm50uWfegQ@mail.gmail.com> <37efb2079f5443feaf4f0b10e15a57db@AcuMS.aculab.com>
In-Reply-To: <37efb2079f5443feaf4f0b10e15a57db@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Feb 2022 01:09:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASK7O6aVfk57v5gsO2J6TPvdno6dqECme0+_NRj4si7LQ@mail.gmail.com>
Message-ID: <CAK7LNASK7O6aVfk57v5gsO2J6TPvdno6dqECme0+_NRj4si7LQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix missing fclose() on error paths
To:     David Laight <David.Laight@aculab.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ryan Cai <ycaibb@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 8:47 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Masahiro Yamada
> > Sent: 10 February 2022 00:54
> > >
> > > The file is not closed when ferror() fails.
> > >
> > > Fixes: 00d674cb3536 ("kconfig: refactor conf_write_dep()")
> > > Fixes: 57ddd07c4560 ("kconfig: refactor conf_write_autoconf()")
> > > Reported-by: Ryan Cai <ycaibb@gmail.com>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> >
> >
> > Applied to linux-kbuild/fixes.
> >
> >
> > >
> > >  scripts/kconfig/confdata.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> > > index 59717be31210..16897cb8cefd 100644
> > > --- a/scripts/kconfig/confdata.c
> > > +++ b/scripts/kconfig/confdata.c
> > > @@ -979,10 +979,10 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
> > >
> > >         fprintf(out, "\n$(deps_config): ;\n");
> > >
> > > -       if (ferror(out)) /* error check for all fprintf() calls */
> > > -               return -1;
> > > -
> > > +       ret = ferror(out); /* error check for all fprintf() calls */
> > >         fclose(out);
> > > +       if (ret)
> > > +               return -1;
>
> There's not much point calling ferror() unless you call fflush() first.
>
> Similarly there's about zero point in checking the return from fprintf().
> At least I've never found any distro adding 'must_check' to fprintf().
> ('must_not_check' would be more appropriate!)


Thanks for pointing it out. You are right.

I assume you are not opposed to this patch itself.

I will insert fflush() before ferror()
as a separate patch.





>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Best Regards
Masahiro Yamada
