Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2A49A8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320442AbiAYDMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415746AbiAYC45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:56:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7665C058C95
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:49:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu18so53068695lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4FKVaUGrauEO19bQNy974TXmzxVW9J7iYHTfxlUUe0=;
        b=Ltf96k/D+fF5Pb2mwKK5EKdbvYpuHA9dhhZngLNsHVyqwx3/ZC3rSa1wmbL/OgvTmY
         jCCwm5pscq/cY+kvjhdSb+LlmzCvymvDrMLY2+sqyd37kssgaUQw447XmlXWyIYTHk/L
         3Wdbt2i5bjkeVNtZ6X8i3PEAqirvbrOker/pZBsaeDqzWD17KRtnOwNkatWQDNjiLa41
         qWcoBn3z8ahMLD2/yrk/AvrSYH7VTiouD9zozEZsHJgAUqQTYx7mNZK24a+t9rsragcQ
         lROAyYD8W4LF3SpZ+DgSV00PUMTIBkzWcblKEh7QdxBuNvoXAjBf/J7z68z49B5j4/0g
         toXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4FKVaUGrauEO19bQNy974TXmzxVW9J7iYHTfxlUUe0=;
        b=N+/ID+BgM3cEEqWCrlJgF8ab7Aj4QrGBgTB56qfXAdsxgiM0+cwBAUr3gb1PZyY5ny
         aJxKPRctAAwE/degOXBWHZmj5nUsb+trF7vgiXMW/MTNHuyI/sdbDhO4ZCa0gjxWqcbA
         hG81Ve6W/wUqZfQnj951sOd2Ds+mbTqSqhyZ0RXaYDFfmgWl3h0+ubQiqZs7TEltIa9B
         DdyXgiTMR5T/p9WaefHa+n94N9VSJsSpBxfh6YrGP3tDAq4R1y8i7uIDAragNgiaJSva
         VKQUl+BqJWkurz9duCpHgaXVRhPJmbAhzMw/c+bU1G039FpE7G9BQloqH4da6Oq6r5gG
         YB8w==
X-Gm-Message-State: AOAM5333rffU0UM2ZeiHuTqbMJes/OwFBbOU5w01mjs9ePZK68k6OMoa
        yJFrtUH7/Rd71S/dssdijc1ai+0uhxXBRCm0xBakMw==
X-Google-Smtp-Source: ABdhPJzfAi0qCoM2ShuPeiANPpPDrqkZkG/Ae5xDdnF8I0qIxBXdDONOKVcQiGcNFCiWRx0rY3TrIrt5rQPZp9v4qAY=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr14721099lfu.240.1643064581970;
 Mon, 24 Jan 2022 14:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120214001.1879469-1-nathan@kernel.org> <20220120214001.1879469-2-nathan@kernel.org>
 <CAKwvOdmTBUcre5+=kopcyAv3q=55=Z5O65QHmvy3Ra2JqgLNHw@mail.gmail.com> <Ye8qOloosgFyY8v8@archlinux-ax161>
In-Reply-To: <Ye8qOloosgFyY8v8@archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 14:49:29 -0800
Message-ID: <CAKwvOdmri9H_yCkN=Rr26UqZgFoXoGPM+41gBS15X1=zGSg_3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Wrap -mno-branch-likely with cc-option
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 2:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 12:40:58PM -0800, Nick Desaulniers wrote:
> > On Thu, Jan 20, 2022 at 1:40 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > This flag is not supported by clang, which results in a warning:
> > >
> > >   clang-14: warning: argument unused during compilation: '-mno-branch-likely' [-Wunused-command-line-argument]
> > >
> > > This breaks cc-option, which adds -Werror to make this warning fatal and
> > > catch flags that are not supported. Wrap the flag in cc-option so that
> > > it does not cause cc-option to fail, which can cause randconfigs to be
> > > really noisy.
> > >
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > We should convert more of these tests to Kconfig checks that run once
> > per configuration, rather than multiple times for a build. IIRC Linus
> > mentioned this somewhere...yeah, the -Wimplicit-fallthrough patches.
> > See
> > dee2b702bcf06 ("kconfig: Add support for -Wimplicit-fallthrough")
> >
> > I wonder if we can check ARCH or SUBARCH in Kconfig to limit invoking
> > the tool under test for certain arch specific command line flags?
> >
> > I'll take this patch over such a larger change, but I think towards
> > the goal of speeding up already configured builds, we eventually want
> > to be migrating cc-option and ld-option checks to Kconfig.
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Something like this appears to work, if that is more preferrable?
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 058446f01487..a27a3ade810e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3232,3 +3232,9 @@ endmenu
>  source "arch/mips/kvm/Kconfig"
>
>  source "arch/mips/vdso/Kconfig"
> +
> +config CC_MNO_BRANCH_LIKELY
> +       string
> +       default "-mno-branch-likely"
> +       depends on MACH_LOONGSON64 || MACH_LOONGSON2EF
> +       depends on $(cc-option,-mno-branch-likely)
> diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
> index 50e659aca543..66ed09581417 100644
> --- a/arch/mips/loongson2ef/Platform
> +++ b/arch/mips/loongson2ef/Platform
> @@ -41,6 +41,6 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
>  # Loongson Machines' Support
>  #
>
> -cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef -mno-branch-likely
> +cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef $(CONFIG_CC_MNO_BRANCH_LIKELY)

Does that allow someone to modify the value for CC_MNO_BRANCH_LIKELY
in menuconfig?

If so, I'd rather the Makefiles have:

cflags-$(CONFIG_CC_MNO_BRANCH_LIKELY) += -mno-branch-likely

and CONFIG_CC_MNO_BRANCH_LIKELY be a bool rather than an editable
string.  I think that makes the Makefile more readable; you don't have
to see what CONFIG_CC_MNO_BRANCH_LIKELY expands to in a different
file.

See also CC_HAS_ASM_GOTO and CC_HAS_ASM_GOTO_OUTPUT in init/Kconfig.

>  load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
>  load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> index 3e660d6d3c2b..88fbdfe9ffcc 100644
> --- a/arch/mips/loongson64/Platform
> +++ b/arch/mips/loongson64/Platform
> @@ -33,5 +33,5 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
>  # Loongson Machines' Support
>  #
>
> -cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
> +cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 $(CONFIG_CC_MNO_BRANCH_LIKELY)
>  load-$(CONFIG_CPU_LOONGSON64) += 0xffffffff80200000
>
> > > ---
> > >  arch/mips/loongson64/Platform | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> > > index 981d3abc150e..acf9edc9b15d 100644
> > > --- a/arch/mips/loongson64/Platform
> > > +++ b/arch/mips/loongson64/Platform
> > > @@ -26,5 +26,6 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
> > >  # Loongson Machines' Support
> > >  #
> > >
> > > -cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
> > > +cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64
> > > +cflags-$(CONFIG_MACH_LOONGSON64) += $(call cc-option,-mno-branch-likely)
> > >  load-$(CONFIG_CPU_LOONGSON64) += 0xffffffff80200000
> > > --
> > > 2.34.1
> > >
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>


-- 
Thanks,
~Nick Desaulniers
