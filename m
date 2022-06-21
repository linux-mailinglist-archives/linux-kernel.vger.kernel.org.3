Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90289552D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiFUImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbiFUImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:42:19 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44E26117;
        Tue, 21 Jun 2022 01:42:17 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 25L8ft8O031713;
        Tue, 21 Jun 2022 17:41:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 25L8ft8O031713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655800917;
        bh=EKHBbDTCPyvGCAQJZpjv49SkvfU2WO9PSidvTkgkPa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aJDmBgZYFDboHTyeZYL28qU2jAxDDsIlWeQi0Hl+uBvrc9PT1q4476UfA/R97wWbV
         nqHqW6fr+3+mtHNCppsS/KHEjmJxkQ8zWPEm4LEbR/aJrjjOidwU2QHywYSFPL5ODZ
         Cn72cFbENj1oXXzVNGcBslQhxQnohc4bWs14gK1ezrqtrtS9KfsqDLSp8+8Kr+HsLQ
         SvEtpi/UebRNiwz8vuWriUB0lQBM6Q2Pawmt/g4O6d2lWWl0ap6Eprzj0Oa0ElFYNu
         F2ezpQOksaCdjHE66MuFOZquc5kZimQoUxohTjDU9vQ0FZ3+34VbwSlqfVTjWTLP4A
         diw3zCMb7gOQQ==
X-Nifty-SrcIP: [209.85.128.51]
Received: by mail-wm1-f51.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so8943205wmq.0;
        Tue, 21 Jun 2022 01:41:56 -0700 (PDT)
X-Gm-Message-State: AOAM531oPk0CmPjl8ACilEhnbDpfZ2ILr8c7/c03/hwxo++FeSU2ufeK
        9EAwvZRhtxDBjVdTzcO76ZXCRSvB2veWY9j/bgg=
X-Google-Smtp-Source: ABdhPJzT56CBfFVMiC4fKwNOaeVVeGLbDxCuY2eZLPHge0iXXEIqIJIzyJsOyqSr7xxF9EPh6fyQIIXjd0V9tmmLoRc=
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id
 c2-20020a05600c0a4200b0039c90868a34mr38779379wmq.169.1655800915172; Tue, 21
 Jun 2022 01:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
 <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com> <14c9839b-c015-69c1-84f0-a99d03877005@suse.cz>
In-Reply-To: <14c9839b-c015-69c1-84f0-a99d03877005@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Jun 2022 17:41:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS46hrVh3FNiHHL8_Hqp85VgWnsHyjQ4t-TFH_H344NOg@mail.gmail.com>
Message-ID: <CAK7LNAS46hrVh3FNiHHL8_Hqp85VgWnsHyjQ4t-TFH_H344NOg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 4:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 17. 06. 22, 18:32, Nick Desaulniers wrote:
> > On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>
> >> On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>
> >>> On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>
> >>>> On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> >>>>>
> >>>>> Until the link-vmlinux.sh split (cf. the commit below), the linker was
> >>>>> run with jobserver set in MAKEFLAGS. After the split, the command in
> >>>>> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> >>>>> is lost.
> >>>>>
> >>>>> Restore it as linkers working in parallel (esp. the LTO ones) make a use
> >>>>> of it.
> >
> > TBH, I agree with Masahiro. I didn't understand this comment "esp. the
> > LTO ones."  Jiri, can you clarify what you mean here?
>
> Sure. clang is not the only compiler/linker that can handle kernel ;).
> So while rebasing gcc-LTO-kernel-patches to 5.19-rc (to upstream them
> later), this broke. See:
> https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/lto-wrapper.cc;h=26e06e77be4e0afb2bc3e913062a9c51cab5d205;hb=HEAD#l1336
>
> gcc really parses MAKEFLAGS and looks for "--jobserver-auth=" there, if
> one passes specifies -flto=jobserver.
>
> thanks,
> --
> js
> suse labs



Then, this patch should go together (or after) the GCC LTO upstreaming.




I still do not understand why you are patching the pre-modpost linking, though.

In my understanding, Clang LTO and GCC LTO are implemented
in different layers.

Clang LTO is implemented in the linker (i.e. lld).

In contrast,  GCC LTO is implemented in the compiler (i.e. gcc itself)
The linker (i.e. BFD linker or Gold from GNU binutils project)
is agnostic about LTO.


Your are patching the relocatable link ($(LD) -r),
but I could not find the code parsing jobserver-auth
in the binutils-gdb repository.





-- 
Best Regards
Masahiro Yamada
