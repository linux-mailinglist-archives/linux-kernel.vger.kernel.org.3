Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D665468B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiFJOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiFJOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:45:35 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D43D5027;
        Fri, 10 Jun 2022 07:45:32 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 25AEj7vF012232;
        Fri, 10 Jun 2022 23:45:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25AEj7vF012232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654872309;
        bh=tL45FsW4eKbGNNLa/0p7aqGch8twZ/XVpRJA/UtujO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=glJ2xt6jw0Aywh+Nrp28pr/AMTGYOpqPp7Q/nVVRr7xuHgZ5QwoNjn4G26DRsFjk/
         8sjK1PkEmWwx7KY8HEj40qG7CPupzXUPKhXwU1FcFHx0OMQXno0Gw5r6RTgPLXXH/O
         z7E3ZIxtkXNTsM2zvwQGJVsTqTT4VxI7OiXqalUxX9lN82YB8gxbaLkCCBKczFVJ3x
         TULKiP8gerBd4kBlBIX+8rYJN3UiuUjIBEU8LOxX8EeUBHtT3JR5juYQK8jzCeWRnr
         fWK1PUzj4EqlLrJjREkeDq1rfAdgwLhM94Nvh+fhMe5oATW7fy9W7Xr0CVM4ucHbi+
         gOB8jQwF4hC0Q==
X-Nifty-SrcIP: [209.85.221.54]
Received: by mail-wr1-f54.google.com with SMTP id u8so32500031wrm.13;
        Fri, 10 Jun 2022 07:45:08 -0700 (PDT)
X-Gm-Message-State: AOAM532gH8jddRI/QWHRmYXh2/R0fCq8tzhGErlqqqntaOisQGmzDvEk
        /XDJXXfcVlavAyo6RAv3bjQ7JHjRnqqYwqWoLeM=
X-Google-Smtp-Source: ABdhPJy4rEtZGNizs9cioDHCkzviVYzHqlgzopG78W/tQLqeagMBmmKMUAJg+XM4KNs57kHvO2XXHLH71z6We3l7Bck=
X-Received: by 2002:adf:f948:0:b0:20f:f964:7621 with SMTP id
 q8-20020adff948000000b0020ff9647621mr45256511wrr.235.1654872306810; Fri, 10
 Jun 2022 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095456.27479-1-zev@bewilderbeest.net> <6d6d252d-79e9-4b4c-4a62-aa4018a6254c@infradead.org>
 <YqFtHfC59akYP9jB@hatter.bewilderbeest.net> <a4e7e2ce-8107-712c-1627-b3bb8646ed79@infradead.org>
 <CAK7LNARYnQyyQ-5MrH-7_c2HUM63UGuSJQNM5PAoaTaq-r1iug@mail.gmail.com> <YqHXS4IVPqfxl5ob@hatter.bewilderbeest.net>
In-Reply-To: <YqHXS4IVPqfxl5ob@hatter.bewilderbeest.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jun 2022 23:44:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLEV2=yYhpYWxUycCxC-BLb+xcV5tKhQQ+a5bJytiwkw@mail.gmail.com>
Message-ID: <CAK7LNATLEV2=yYhpYWxUycCxC-BLb+xcV5tKhQQ+a5bJytiwkw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add findconf script and helper program
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 8:19 PM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Wed, Jun 08, 2022 at 10:47:08PM PDT, Masahiro Yamada wrote:
> >On Thu, Jun 9, 2022 at 12:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >>
> >>
> >> On 6/8/22 20:46, Zev Weiss wrote:
> >> > On Wed, Jun 08, 2022 at 07:48:44PM PDT, Randy Dunlap wrote:
> >> >> Hi--
> >> >>
> >> >> On 6/8/22 02:54, Zev Weiss wrote:
> >> >>> scripts/findconf provides menuconfig's search functionality as a
> >> >>> standalone, non-interactive command, somewhat in the spirit of
> >> >>> scripts/config.  It is meant to be useful for tasks like getting a
> >> >>> quick overview of symbol dependencies or determining which Kconfig
> >> >>> file to edit for a given symbol, without having to fire up one of the
> >> >>> interactive config programs.
> >> >>>
> >> >>> It accepts a single command-line flag, '-v', which causes it to also
> >> >>> print the help text of each matching result.
> >> >>>
> >> >>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> >> >>> ---
> >> >>
> >> >> I can see how this could be useful.
> >> >> It's a little easier to use than what I currently do:
> >> >>
> >> >> $ findconfig  DRM_HISI_HIBMC
> >> >> ./drivers/gpu/drm/hisilicon/hibmc/Kconfig:2:config DRM_HISI_HIBMC
> >> >
> >> > I'm guessing 'findconfig' here is some personal shell
> >> > alias/function/script?  (I can't see any references to it in the kernel
> >> > source tree.)
> >> >
> >>
> >> Yes, it's just local.
> >>
> >> >>
> >> >> then $EDITOR that_Kconfig_file
> >> >>
> >> >>
> >> >> In testing, I am seeing this:
> >> >>
> >> >> #
> >> >> # using defaults found in /boot/config-5.3.18-150300.59.63-default
> >> >> #
> >> >> .config:421:warning: symbol value 'm' invalid for I8K
> >> >> .config:2335:warning: symbol value 'm' invalid for
> >> >> MTD_NAND_ECC_SW_HAMMING
> >> >> .config:2484:warning: symbol value 'm' invalid for PVPANIC
> >> >> .config:8671:warning: symbol value 'm' invalid for INTERCONNECT
> >> >> .config:9369:warning: symbol value 'm' invalid for
> >> >> CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> >> >> .config:9370:warning: symbol value 'm' invalid for
> >> >> CRYPTO_LIB_BLAKE2S_GENERIC
> >> >> .config:9653:warning: symbol value '1' invalid for KASAN_STACK
> >> >>
> >> >
> >> > This I assume is just due to the contents of your .config file relative
> >> > to the current Kconfig definitions and not a problem with anything in
> >> > this patch?
> >>
> >> There is no .config file in the linux/ source tree at the top level.
> >> I use O=build_dir for all builds.
> >>
> >> >
> >> >> How do I specify/choose a .config file to be used?
> >> >>
> >> >> Oh, use KCONFIG_CONFIG=filename
> >> >>
> >> >
> >> > Ah, I guess that'd be a nice thing to add a flag for to the wrapper
> >> > script -- I'll include that in v2.
> >> >
> >> >>
> >> >> Please update (add) usage/help text in scripts/kconfig/Makefile.
> >> >>
> >> >
> >> > Ack, will do.
> >> >
> >> >
> >> > Thanks for the review!
> >> >
> >> >
> >> > Zev
> >> >
> >
> >
> >
> >
> >
> >
> >
> >
> >Another idea might be to add the following to
> >scripts/kconfig/Makefile:
> >
> >
> >
> >@@ -77,7 +76,13 @@ PHONY += $(simple-targets)
> > $(simple-targets): $(obj)/conf
> >        $(Q)$< $(silent) --$@ $(Kconfig)
> >
> >-PHONY += savedefconfig defconfig
> >+PHONY += findconfig savedefconfig defconfig
> >+
> >+findconfig: $(obj)/conf
> >+       $(Q)$< $(silent) --$@=$(KCONFIG_FIND) $(Kconfig)
> >+
> >+%_findconfig: $(obj)/conf
> >+       $(Q)$< $(silent) --findconfig=$* $(Kconfig)
> >
> > savedefconfig: $(obj)/conf
> >        $(Q)$< $(silent) --$@=defconfig $(Kconfig)
> >
> >
> >
> >
> >
> >Instead of adding a separate program for this,
> >you can modify scripts/kconfig/conf.c
> >
> > - add 'findconfig' to enum input_mode
> > - add 'findconfig' to long_opts[]
> > - add 'case findconfig' to main() function
> >
> >
> >
> >Then, you can do
> >
> >$ make findconfig KCONFIG_FIND=DRM_HISI_HIBMC
> >
> >   or
> >
> >$ make DRM_HISI_HIBMC_findconfig
> >
> >  as a shorthand.
> >
> >
> >scripts/findconf is unneeded
> >but you can put your own script in ~/bin
> >if you want to save your typing even more.
> >
>
> Hmm, interesting idea -- it seems a bit more awkward to use though, and
> if everyone who makes much use of it is likely to be writing their own
> little ad-hoc wrapper script anyway, it seems like we might as well do
> that once and check it in?
>
> The current approach also provides support for multi-query searches,
> which while it isn't critical is slightly more convenient than running
> it multiple times or cramming everything into a single combined regex
> (analogous to grep's '-e' flag).
>
> That said, if you and/or others have a strong preference for doing it
> via a make target I could rearrange it to work that way instead.
>


Hmm, OK. Then, let's keep scripts/findconfig.

But, I'd like to pass the regex pattern via the --findconfig=
option.

In the shell script, can you do some conversion?





> Thanks,
> Zev
>


-- 
Best Regards
Masahiro Yamada
