Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90345ADD14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiIFBw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiIFBw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96766A47
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3235261188
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D06BC433D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662429175;
        bh=/noFKegj2r7vzm3Cg/KG54hJDZiJWhqqG0lF37CpoU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q/92qHk0oVRlpjP2Au9ov80Tlk8wWKVKuyenSnL4KtqEZ7P/MY2SSnm4GQ6WqvF/A
         BxrJHHTSz9eB7NvKGsuYicts7R4hFLe05iK3xoV5R5WNPizITp/IwKDEa8IRj5fBYY
         DQ4A3p67FwKq83XrXfHx15REYj7E3IEJd/LX3mrKwnGtAW99f3eSqzHW1+f3OfYWct
         +yU0ApiM3TMQ+21XgHrcYFJQwZYjvUiK1HSMNl7HT6P6Too6wZgoyVBqvZnJ6QkZhm
         +EaExevflgWoZl7uxO97QUyb/Mq2cPjvM0xtqLsKz+ZZDY/2ZVdrq0hFP1u4W4BTJn
         BQ4SM5c1uGA9w==
Received: by mail-vs1-f49.google.com with SMTP id 190so10270438vsz.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 18:52:55 -0700 (PDT)
X-Gm-Message-State: ACgBeo3OUnNjJKUFbelld0rLo2EjIoirF6YqTpaoyG+sWM/neAc2zDLy
        pVPNJbXxXJb3IohU+1uSa+cYrS8EPLKhRRfcUl0=
X-Google-Smtp-Source: AA6agR7qeY/5HvBKtkZKMekX+Bp/6eEv4hf6LFfnhf0LudEX5g+8uklAK/Uv3inYSIJmhftVARYp389xQ/7Jx6BxvyY=
X-Received: by 2002:a05:6102:30bc:b0:390:da09:3a8c with SMTP id
 y28-20020a05610230bc00b00390da093a8cmr13529685vsd.84.1662429174591; Mon, 05
 Sep 2022 18:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
 <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
 <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
 <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com> <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
In-Reply-To: <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Sep 2022 09:52:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com>
Message-ID: <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
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

Hi, Ruoyao,

On Tue, Sep 6, 2022 at 8:32 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Thu, 2022-09-01 at 10:17 +0800, Huacai Chen wrote:
>
> > Now all global variable accesses are via got, I think the performance
> > may be much worse than before when we didn't use explicit-relocs.
> > I don't know whether "a new code model" or your "(1)(2)(3)" is easier
> > to implement, but I think it is better to solve the performance issue
> > before 6.1-rc1.
>
> Hi Huacai,
>
> We've added a GCC option for this at https://gcc.gnu.org/r13-2433.  On
> the kernel side we need a one-line change:
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 92c4a52c4c3e..69b39ba3a09d 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -54,6 +54,7 @@ LDFLAGS_vmlinux                       += -G0 -static -n -nostdlib
>  # upgrade the compiler or downgrade the assembler.
>  ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
>  cflags-y                       += -mexplicit-relocs
> +KBUILD_CFLAGS_KERNEL           += -mdirect-extern-access
>  else
>  cflags-y                       += $(call cc-option,-mno-explicit-relocs)
>  KBUILD_AFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
>
> And we also need a one-line change in the EFI stub patch (under review):
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 8931ed24379e..8c1225b92492 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -27,7 +27,7 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fpic
>  cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> -                                  -fpic
> +                                  -fpie
>
>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>
> (Some explanation: -fpic does not only mean "generate position-
> independent code", but "generate position-independent code *suitable for
> use in a shared library*".  On LoongArch -mdirect-extern-access cannot
> work for a shared library so the "-fpic -mdirect-extern-access"
> combination is rejected deliberately.)
>
> Not sure how to submit these changes properly...  Do you prefer me to
> send V8 of this series or a single patch on top of your tree on GitHub?
Don't need V8, I will squash it into the previous patch myself. But
can we keep efistub as is?

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>
