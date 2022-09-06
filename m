Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C965AE520
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiIFKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiIFKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:16:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35939B9D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32ADFB81729
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0187C433B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662459400;
        bh=9/OqEY1AdGlYqFrskuBnDyzAXAsqqGEVaUN/RRhe4Ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WymsisIaz3vz6LLmtOOC+6uvrRVt/GXWVbZSpnpZSoDmvyfqWsVxCkdE31gaYzac9
         o2EEnu+x5hVNwqHY1f6wcX80IUKdyDUYFZFnuH1dafiI2RkqRYLWsXlXiySwnErflw
         saNrVf+hNX6PoZFNlDw8+lpqVYr1S/S9XCf9k84sT7ya7GWmXH/kUynUiPdiewtQ1W
         biHvU9MKULbLxegUO22LJ1Y90ZJIxxLv4Mjev+7dEirObDHpyEBELbaqUBXNT/m2cH
         mnRp/BPuFoDFJzqSN8MqeChSdC+5ppDIAfTlZZOLtk/0tBDCQGttx8kqefBjg5n6Mr
         9kPzLAsp5eBeg==
Received: by mail-lj1-f170.google.com with SMTP id k18so11688671lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:16:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo1EsiNXHgnm3ZBRTAFQDOWRfVHh3EOOGa3k5FQsls1waig45FVq
        ThyBCAdnESHbNhqdd71U84B3ebrGGo0bDJ0MmdE=
X-Google-Smtp-Source: AA6agR7bCqtA9wfF/56sHk4Ok8Qx0P49OGcib8dcCcQP+4sW8tVKtZCBaiELe69/YxRifVz8zNZDbFKCayASELZEYKw=
X-Received: by 2002:a2e:9b0e:0:b0:268:cb68:575b with SMTP id
 u14-20020a2e9b0e000000b00268cb68575bmr7059563lji.152.1662459398847; Tue, 06
 Sep 2022 03:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
 <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
 <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
 <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
 <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
 <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com>
 <8d0f96e2977c5c78f17bb410087f2aad986ef5a4.camel@xry111.site>
 <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
 <CAMj1kXE6YHCVj9DDbxLEZnS-ceZT__xe1XAcUcpXcd6eYb=UEw@mail.gmail.com>
 <CAAhV-H5NT-bq2jb3Kh-5wyCwVeG6t6pkLkPSRRC5XKrC33j1Nw@mail.gmail.com> <CAAhV-H6RqKT0OiVhZqJr9Tts-4JuH-oPNAc66q6fTcqdi7jAQw@mail.gmail.com>
In-Reply-To: <CAAhV-H6RqKT0OiVhZqJr9Tts-4JuH-oPNAc66q6fTcqdi7jAQw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Sep 2022 12:16:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGBevDYDxyb9_gDHLaQneydnXvGkAsPXD3o9kf0-BrNMQ@mail.gmail.com>
Message-ID: <CAMj1kXGBevDYDxyb9_gDHLaQneydnXvGkAsPXD3o9kf0-BrNMQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 10:59, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Tue, Sep 6, 2022 at 4:20 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Tue, Sep 6, 2022 at 3:18 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 6 Sept 2022 at 06:43, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > Hi, Ruoyao,
> > > >
> > > > On Tue, Sep 6, 2022 at 12:27 PM Xi Ruoyao <xry111@xry111.site> wrote:
> > > > >
> > > > > On Tue, 2022-09-06 at 09:52 +0800, Huacai Chen wrote:
> > > > > > >   cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > > > > -                                  -fpic
> > > > > > > +                                  -fpie
> > > > > > >
> > > > > > >   cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > > > > >
> > > > > > > (Some explanation: -fpic does not only mean "generate position-
> > > > > > > independent code", but "generate position-independent code *suitable for
> > > > > > > use in a shared library*".  On LoongArch -mdirect-extern-access cannot
> > > > > > > work for a shared library so the "-fpic -mdirect-extern-access"
> > > > > > > combination is rejected deliberately.)
> > > > > > >
> > > > > > > Not sure how to submit these changes properly...  Do you prefer me to
> > > > > > > send V8 of this series or a single patch on top of your tree on GitHub?
> > > > >
> > > > > > Don't need V8, I will squash it into the previous patch myself. But
> > > > > > can we keep efistub as is?
> > > > >
> > > > > No, we can't allow -mdirect-extern-access -fpic on LoongArch because
> > > > > without copy relocation such a combination just does not make sense (i.
> > > > > e. we cannot find a sensible way to handle such a combination in GCC).
> > > > > So such a combination will cause GCC refuse to run.
> > > > >
> > > > > Note that -fpic/-fPIC is "position-independent code *suitable for
> > > > > use in a shared library*", while -fpie/-fPIE is more like just
> > > > > "position-independent code".  The names of those options are confusing.
> > > > > (When -fpic was invented first time, people mostly believed "PIC had
> > > > > been only for shared libraries", so it's named -fpic instead of -shlib
> > > > > or something.)  IMO in the EFI stub for other ports, -fpie should be
> > > > > used instead of -fpic as well because the EFI stub is not similar to a
> > > > > shared library in any means.
> > > > You are right, but I guess that Ard doesn't want to squash the efistub
> > > > change into the LoongArch efistub support patch. :)
> > > >
> > >
> > > I don't mind changing the stable tag at this point - I don't have
> > > anything queued up on top of it at the moment.
> > >
> > > But I don't see the actual patch: please send me the delta patch that
> > > you want to apply, and I will update it. Then, you can rebase your
> > > v6.1 tree on top of it.
> > OK, Ruoyao, please send a patch to change the efistub cflags. Thank you.
> Oh, I think you needn't send, just showing the diff to Ard is OK. :)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile
> b/drivers/firmware/efi/libstub/Makefile
> index 8931ed24379e..8c1225b92492 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -27,7 +27,7 @@ cflags-$(CONFIG_ARM)          := $(subst
> $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  cflags-$(CONFIG_RISCV)         := $(subst
> $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fpic
>  cflags-$(CONFIG_LOONGARCH)     := $(subst
> $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> -                                  -fpic
> +                                  -fpie
>
>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>

I have merged this into the patch, and updated the tag

efi-loongarch-for-v6.1
ead384d956345681e1ddf97890d5e15ded015f07

It should be in linux-next tomorrow, you can merge the tag now from
git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
