Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C2538F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbiEaKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiEaKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:37:41 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD8A996AF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:37:40 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24VAbOYi015894
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:37:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24VAbOYi015894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653993444;
        bh=IcnjmaJpaUAIyvVn2bKgs7HHM+EB5swJSjUTow8XP0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UuuV25nT+/Oy1LgFB+nfquduc6BYZXu+T8aQCSmLpeyrwMosAL+G/6yQensSzNniO
         KoqMU995KImST10XoA4SV4yc9uoqEBtgrEW8P0z9XxoSIbrBejhhcU0IRX3uNnS/e0
         zlgdogdjmy7zD/4ublTKeaHuyWWElJYa+lkbsY+P5Ojab/JWKiECOCIPg8YsZe9FkN
         VRKoZb9vNfWJ27e7pk5itF0Ge9nN7a8wTcUuUw2cmOSU/t/Rm7gPWxkLYUMdpzIHEj
         IvMx8DdXZ/ZkuuHw3NL6Uc9zuvytGyb/CUiRrwXY36TyOClL6BRa2baawSuQPSY1mi
         bO94hOZ77GHUA==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1863230pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:37:24 -0700 (PDT)
X-Gm-Message-State: AOAM53135BeOpMgNGDiMaleZtkkHjxTicNwA+cabtffiOp8ITzXqKwTm
        EXAUSns37RI6rgFzfZSj0L3nOXTuuRdJpRpRANg=
X-Google-Smtp-Source: ABdhPJxcYs5nnT0LRM/TU7R3W7KlAgudzO5qsE+RjkHbmhsySUxkv2jsUk9+N5bpWtFylIgvJ+r2fx2gADKce8OKRqU=
X-Received: by 2002:a17:90b:1d83:b0:1e2:f63e:bc37 with SMTP id
 pf3-20020a17090b1d8300b001e2f63ebc37mr11027825pjb.119.1653993443523; Tue, 31
 May 2022 03:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220427090442.2105905-1-gregkh@linuxfoundation.org>
 <CAK7LNASFK3z8Y=L1Q6uG3YZ2GBffBAASkc4tWfnPF__qeYh3SA@mail.gmail.com>
 <YmlYRMEzonSnwZ7q@kroah.com> <CAK7LNARUUOSd0-Q=bopr5q9J6xbtRAJsUKRGacf+vpuu8KJdxw@mail.gmail.com>
 <YoyTDCbELrpCZ3eC@kroah.com> <CAK7LNASMi3MHPf4aOMhWbPgDiWnNBU-MEdMs0UV1qf=1GW-i_A@mail.gmail.com>
In-Reply-To: <CAK7LNASMi3MHPf4aOMhWbPgDiWnNBU-MEdMs0UV1qf=1GW-i_A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 May 2022 19:36:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDmjCSWXD106Gdf0BJPw8Vg8YAMupzcEbPtkWOALdXrQ@mail.gmail.com>
Message-ID: <CAK7LNASDmjCSWXD106Gdf0BJPw8Vg8YAMupzcEbPtkWOALdXrQ@mail.gmail.com>
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

On Tue, May 31, 2022 at 4:44 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 5:10 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 24, 2022 at 03:31:59AM +0900, Masahiro Yamada wrote:
> > > On Wed, Apr 27, 2022 at 11:50 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Apr 27, 2022 at 11:29:19PM +0900, Masahiro Yamada wrote:
> > > > > On Wed, Apr 27, 2022 at 6:06 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > Commit c3a6cf19e695 ("export: avoid code duplication in
> > > > > > include/linux/export.h") broke the ability for a defined string to be
> > > > > > used as a namespace value.
> > > > >
> > > > > In hindsight, this was a bad idea.
> > > > >
> > > > >
> > > > > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")
> > > > >
> > > > >    is much much better than:
> > > > >
> > > > > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
> > > >
> > > > I agree, but it's really not that big of a deal.  We could change it if
> > > > you want.
> > > >
> > > > > ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> > > > >
> > > > > is also a bad idea.
> > > >
> > > > That's not such a bad idea as it lets you set a namespace for a
> > > > directory and below easily.  What would you want to use instead?
> > > >
> > > > > When you look at EXPORT_SYMBOL_GPL() in C files, you will not be
> > > > > aware of the presence of the namespace.
> > > >
> > > > It's easy to tell when things do not link properly :)
> > > >
> > > > > Anyway, it is presumably too late to fix it.
> > > >
> > > > Not really, the number of in-kernel users are still small and can be
> > > > changed if you like.  External users can update when they hit the change
> > > > as well, not a big deal.
> > >
> > >
> > > If I send a patch for global conversion,
> > > will you be happy to pick it up?
> > >
> > >
> > > I think this should be applied at the very last moment
> > > of the MW.
> >
> > Make up a patch right after -rc1 to get into -rc2 as that's usually the
> > best time for tree-wide changes like this.
> >
> > > I can convert tree-wide by sed.
> > >
> > >
> > > Example of conversion:
> > >
> > > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE)
> > >    -->
> > > EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, "SPI_DW_CORE")
> >
> > Ah, but then this breaks my use case where I did in the Android tree:
> >
> >         EXPORT_SYMBOL_NS_GPL(symbol_name, ANDROID_GKI_VFS_EXPORT_ONLY);
> >
> > and then in the makefile I did:
> >         subdir-ccflags-y += -DANDROID_GKI_VFS_EXPORT_ONLY=VFS_internal_I_am_really_a_filesystem_and_am_NOT_a_driver
> >
> > That saved me typing a lot of "VFS_internal_I_am..." in the .c files.
>
>
> Kbuild provides a macro "stringify"
>
> It shall be converted to:
>
>     subdir-ccflags-y += -DANDROID_GKI_VFS_EXPORT_ONLY=$(call
> stringify,VFS_internal_I_am_really_a_filesystem_and_am_NOT_a_driver)
>
>
> >
> > I know out-of-tree stuff does not matter, but a simple way to make this
> > work would be nice.
> >
> > I could just do:
> >         #define ANDROID_GKI_VFS_EXPORT_ONLY     "VFS_internal_I_am..."
> > in a .c file which would handle this, right?
>
> Yes, that is an alternative.
>
>
> > Ok, so maybe that isn't an issue, nevermind...
> >
> > But, if we have a string here, what happens if someone puts a space in
> > it:
> >         EXPORT_SYMBOL_NS_GPL(symbol_name, "MY DRIVER NAMESPACE");
> > that will not break the build but will cause the tools to really
> > complain, right?  Or do the wrong thing and put them in the "MY"
> > namespace?
>
> Right, the compiler does not complain about a space in the namespace.
> We can check it in modpost if we like.
>
>
>
>
>
>
> BTW, do we need EXPORT_SYMBOL_NS() in the first place?
>
> If you think DEFAULT_SYMBOL_NAMESPACE is useful,
> you have already noticed that the per-module namespace is
> more convenient than the per-symbol namespace.
>
>
>
>
> For example, if you look at drivers/hwmon/pmbus/pmbus_core.c,
> all symbols are exported by EXPORT_SYMBOL_NS_GPL(... , PMBUS).
> I do not see any module that exports multiple namespaces.
>
> So, I think per-module namespace control is enough.
>
>
> [Deprecate]
>     EXPORT_SYMBOL_NS(<symbol>, <namespace>)
>     EXPORT_SYMBOL_NS_GPL(<symbol>, <namespace>)
>
> [Add]
>     MODULE_NAMESPACE(<namespace>)
>
>
> If MODULE_NAMESPACE(<namespace>) is added to a module,
> all symbols exported from that module belong to <namespace>.


Sorry, this does not work for built-in objects.
I take back this comment. Sorry for the noise.




-- 
Best Regards
Masahiro Yamada
