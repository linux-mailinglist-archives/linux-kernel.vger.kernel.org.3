Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC31653188D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiEWSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiEWStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:49:08 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFE4FC4B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:34:08 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24NIXKL6016597
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:33:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24NIXKL6016597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653330800;
        bh=mEvA1eX3bJSZ+pt/plIU65G3JFup7JCRs1BwqB8CVDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jMTcH4pxgiIlZAdUBW6QGBwTtDfogJ4e7Hczow6cq84tkOqOP7BTCdRS4Iy6vgJ4W
         3roU0sMzgOlOOoiFmnpnL6csXViU33dmGEflsa2rpSn5/uLL+mAMmxplueWTDV70/s
         WgXncJrvK8fru/Kj1/Cc66Ha2rdoNh8aLrFN9w5K0LmdEhgWurjehKLOGL3enKVyTB
         9sbBDqhdGiKr05sNCHFErpUfGyO2qwLCawQttD1w9GbtvZIiX7lLsxznRPuu2aw8nb
         i0guBILO9RyHmpFx3ygWI+23F3lfdV9G75jPbgWTi8oqmZeBq33RiG5pbNXTEKFdyA
         02/+7GBmpE04w==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id z11so4972042pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:33:20 -0700 (PDT)
X-Gm-Message-State: AOAM532gXzNHyNkXte/Jzg9XxBDnKSUHf/VgNJmzlQ1XsEgwa7Q1tkuQ
        Hj6oowFt70r1XYAqwfniSlGH7/kpNyUrJvwnFgc=
X-Google-Smtp-Source: ABdhPJxru3M8Ku70G812s3/SGLEsdLhF4/NHFlka3oiWwnuAx7XAVQBVlAPdvP4YWwxiRjUQ/9LmgkbJp5oOER0p5VM=
X-Received: by 2002:a17:90b:2318:b0:1df:40e6:6478 with SMTP id
 mt24-20020a17090b231800b001df40e66478mr311514pjb.77.1653330799638; Mon, 23
 May 2022 11:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
 <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com> <YmlYRMEzonSnwZ7q@kroah.com>
In-Reply-To: <YmlYRMEzonSnwZ7q@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 03:31:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUUOSd0-Q=bopr5q9J6xbtRAJsUKRGacf+vpuu8KJdxw@mail.gmail.com>
Message-ID: <CAK7LNARUUOSd0-Q=bopr5q9J6xbtRAJsUKRGacf+vpuu8KJdxw@mail.gmail.com>
Subject: Re: [PATCH v2] export: fix string handling of namespace in EXPORT_SYMBOL_NS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:50 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 27, 2022 at 11:29:19PM +0900, Masahiro Yamada wrote:
> > On Wed, Apr 27, 2022 at 6:06 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Commit c3a6cf19e695 ("export: avoid code duplication in
> > > include/linux/export.h") broke the ability for a defined string to be
> > > used as a namespace value.
> >
> > In hindsight, this was a bad idea.
> >
> >
> > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")
> >
> >    is much much better than:
> >
> > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
>
> I agree, but it's really not that big of a deal.  We could change it if
> you want.
>
> > ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> >
> > is also a bad idea.
>
> That's not such a bad idea as it lets you set a namespace for a
> directory and below easily.  What would you want to use instead?
>
> > When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
> > aware of the presence of the namespace.
>
> It's easy to tell when things do not link properly :)
>
> > Anyway, it is presumably too late to fix it.
>
> Not really, the number of in-kernel users are still small and can be
> changed if you like.  External users can update when they hit the change
> as well, not a big deal.


If I send a patch for global conversion,
will you be happy to pick it up?


I think this should be applied at the very last moment
of the MW.


I can convert tree-wide by sed.


Example of conversion:

EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
   -->
EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")







> Other than using a string for the namespace definition, what would you
> like to see done differently?
>
> > >  Fix this up by using stringify to properly
> > > encode the namespace name.
> > >
> > > Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
> > > Cc: Miroslav Benes <mbenes@suse.cz>
> > > Cc: Emil Velikov <emil.l.velikov@gmail.com>
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > Cc: Quentin Perret <qperret@google.com>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > This email is no longer valid.
>
> Ah, sorry about that.
>
> > Feel free to replace it with
> >
> > Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Will do, thanks!
>
> greg k-h



-- 
Best Regards
Masahiro Yamada
