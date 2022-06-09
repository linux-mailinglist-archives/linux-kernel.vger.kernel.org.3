Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8540D54434A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiFIFsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFIFsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:48:04 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998EE1A0049;
        Wed,  8 Jun 2022 22:48:02 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2595ljbS024219;
        Thu, 9 Jun 2022 14:47:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2595ljbS024219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654753666;
        bh=THMhz6Wceyy6ZCLdJWjybc0DlI0gGoaA/DiX+ijqRnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xVsbK57w0uyaXCVEiIg3LjorSv75JV75jldT2Sr6vYP3B3sLDTUgBsCG3hgj0mWEC
         GRK552F0KqYYKDQHiakuCuMxIA8VvDSwpUs5lYhGy2NVLp9QIcUB8VAE1bsG54CE49
         KsAPx9rdWKQ3OZiYF+zcvAVTj9yDpCh7iNXwokvXcLnfjyYUd54wWtASA2/H2nVciw
         lzVVPTs++WAKEXD/stBTXGJIMw1mxzzpRaX8pbnuGP7lE9MdoNNAW/HORmm/CLL/ac
         VQed7H0xl37xJU7C83jvz9+as9SOnirEZs6Z6yHpgXVaLikrGHu3j2mkiqTDig7+cB
         r88ngE4jqyXfQ==
X-Nifty-SrcIP: [209.85.221.45]
Received: by mail-wr1-f45.google.com with SMTP id q15so22810837wrc.11;
        Wed, 08 Jun 2022 22:47:46 -0700 (PDT)
X-Gm-Message-State: AOAM5301nBBZfmtKIUe9uWEeTXGM+4BnxeZCxsk5QYNOcgFaPCWjc9Bt
        OoaEPpmWazbH6OiOFnWRG7H7XBI0WEhx2R8iESQ=
X-Google-Smtp-Source: ABdhPJwrJ2qTe89uEqhh0NQ25s6EGxU7xHHovAW9On194IJT/l/TeJzmuh7jBTEqA1epiwaKhUtVMbrt7RBXFIGnhFs=
X-Received: by 2002:adf:f948:0:b0:20f:f964:7621 with SMTP id
 q8-20020adff948000000b0020ff9647621mr37345257wrr.235.1654753664612; Wed, 08
 Jun 2022 22:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095456.27479-1-zev@bewilderbeest.net> <6d6d252d-79e9-4b4c-4a62-aa4018a6254c@infradead.org>
 <YqFtHfC59akYP9jB@hatter.bewilderbeest.net> <a4e7e2ce-8107-712c-1627-b3bb8646ed79@infradead.org>
In-Reply-To: <a4e7e2ce-8107-712c-1627-b3bb8646ed79@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 9 Jun 2022 14:47:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYnQyyQ-5MrH-7_c2HUM63UGuSJQNM5PAoaTaq-r1iug@mail.gmail.com>
Message-ID: <CAK7LNARYnQyyQ-5MrH-7_c2HUM63UGuSJQNM5PAoaTaq-r1iug@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add findconf script and helper program
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
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

On Thu, Jun 9, 2022 at 12:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/8/22 20:46, Zev Weiss wrote:
> > On Wed, Jun 08, 2022 at 07:48:44PM PDT, Randy Dunlap wrote:
> >> Hi--
> >>
> >> On 6/8/22 02:54, Zev Weiss wrote:
> >>> scripts/findconf provides menuconfig's search functionality as a
> >>> standalone, non-interactive command, somewhat in the spirit of
> >>> scripts/config.  It is meant to be useful for tasks like getting a
> >>> quick overview of symbol dependencies or determining which Kconfig
> >>> file to edit for a given symbol, without having to fire up one of the
> >>> interactive config programs.
> >>>
> >>> It accepts a single command-line flag, '-v', which causes it to also
> >>> print the help text of each matching result.
> >>>
> >>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> >>> ---
> >>
> >> I can see how this could be useful.
> >> It's a little easier to use than what I currently do:
> >>
> >> $ findconfig  DRM_HISI_HIBMC
> >> ./drivers/gpu/drm/hisilicon/hibmc/Kconfig:2:config DRM_HISI_HIBMC
> >
> > I'm guessing 'findconfig' here is some personal shell
> > alias/function/script?  (I can't see any references to it in the kernel
> > source tree.)
> >
>
> Yes, it's just local.
>
> >>
> >> then $EDITOR that_Kconfig_file
> >>
> >>
> >> In testing, I am seeing this:
> >>
> >> #
> >> # using defaults found in /boot/config-5.3.18-150300.59.63-default
> >> #
> >> .config:421:warning: symbol value 'm' invalid for I8K
> >> .config:2335:warning: symbol value 'm' invalid for
> >> MTD_NAND_ECC_SW_HAMMING
> >> .config:2484:warning: symbol value 'm' invalid for PVPANIC
> >> .config:8671:warning: symbol value 'm' invalid for INTERCONNECT
> >> .config:9369:warning: symbol value 'm' invalid for
> >> CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> >> .config:9370:warning: symbol value 'm' invalid for
> >> CRYPTO_LIB_BLAKE2S_GENERIC
> >> .config:9653:warning: symbol value '1' invalid for KASAN_STACK
> >>
> >
> > This I assume is just due to the contents of your .config file relative
> > to the current Kconfig definitions and not a problem with anything in
> > this patch?
>
> There is no .config file in the linux/ source tree at the top level.
> I use O=build_dir for all builds.
>
> >
> >> How do I specify/choose a .config file to be used?
> >>
> >> Oh, use KCONFIG_CONFIG=filename
> >>
> >
> > Ah, I guess that'd be a nice thing to add a flag for to the wrapper
> > script -- I'll include that in v2.
> >
> >>
> >> Please update (add) usage/help text in scripts/kconfig/Makefile.
> >>
> >
> > Ack, will do.
> >
> >
> > Thanks for the review!
> >
> >
> > Zev
> >








Another idea might be to add the following to
scripts/kconfig/Makefile:



@@ -77,7 +76,13 @@ PHONY += $(simple-targets)
 $(simple-targets): $(obj)/conf
        $(Q)$< $(silent) --$@ $(Kconfig)

-PHONY += savedefconfig defconfig
+PHONY += findconfig savedefconfig defconfig
+
+findconfig: $(obj)/conf
+       $(Q)$< $(silent) --$@=$(KCONFIG_FIND) $(Kconfig)
+
+%_findconfig: $(obj)/conf
+       $(Q)$< $(silent) --findconfig=$* $(Kconfig)

 savedefconfig: $(obj)/conf
        $(Q)$< $(silent) --$@=defconfig $(Kconfig)





Instead of adding a separate program for this,
you can modify scripts/kconfig/conf.c

 - add 'findconfig' to enum input_mode
 - add 'findconfig' to long_opts[]
 - add 'case findconfig' to main() function



Then, you can do

$ make findconfig KCONFIG_FIND=DRM_HISI_HIBMC

   or

$ make DRM_HISI_HIBMC_findconfig

  as a shorthand.


scripts/findconf is unneeded
but you can put your own script in ~/bin
if you want to save your typing even more.




-- 
Best Regards
Masahiro Yamada
