Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C0517BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiECCGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiECCGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:06:49 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472563A73F;
        Mon,  2 May 2022 19:03:18 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 243235RR024149;
        Tue, 3 May 2022 11:03:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 243235RR024149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651543385;
        bh=xjOYr6omwY+Qzfpy1fAsMIIAC1MzOb2s83hA5zKDTrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bss1hGRlBeW/D1ryasZhvq0Rb1Wcpqf+Ka2dsaw3lnInZjMUlf0uRw2sXaz1yJbec
         ptGkFVATZb1a4+vzLKqycumfOq7+w/r6iHaGoZ0AZ9YDCh5t6yvPJ2VMgMsdPgcLpy
         C3qbKMqqQHFl7f0DQZHjw7/3x67X+EveMeJS+5K81Ntq9+KQjpfQJQ/rTiLnEVPO8b
         uxHb/jBpqgoI62ONWVph64uaQy0uU19531Rsz4VvU/hwSrj9DoGavw9qj1QrbD1BnH
         l9IyB3GewfQD4Fga2GXvqHYbCjr7Tgrkf7lw3CeUBFIXKLTy6WHenV/E9oTnSNayY4
         Jv9K9GWeGCIPg==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id j6so13639807pfe.13;
        Mon, 02 May 2022 19:03:05 -0700 (PDT)
X-Gm-Message-State: AOAM533XoMdyH/+r2VPp88jugXmcXEd+3Ke/Un+k1rMNOzyFnlqBzKsC
        0NKKypoCijbYyoxL+w+nxLcyR6zA9flGxN4d1lo=
X-Google-Smtp-Source: ABdhPJybuWEMOUVTbNe+mLw8tJxZLLEX8d0sEpIfFwiuGG78gUczd0ZkwWPhzhHA7Dj3mTHn6HCyJ+v54nTnxuIuLD8=
X-Received: by 2002:a63:6989:0:b0:3c2:3c19:d661 with SMTP id
 e131-20020a636989000000b003c23c19d661mr3878546pgc.352.1651543384634; Mon, 02
 May 2022 19:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220430110409.256858-1-masahiroy@kernel.org> <871qxda2jf.fsf@mpe.ellerman.id.au>
In-Reply-To: <871qxda2jf.fsf@mpe.ellerman.id.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 May 2022 11:01:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARk=eNUfTuC7_nnUnCCbQCvdy7=PNkMSt6QYZvW_zKUyQ@mail.gmail.com>
Message-ID: <CAK7LNARk=eNUfTuC7_nnUnCCbQCvdy7=PNkMSt6QYZvW_zKUyQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: drop $(objtree)/ prefix support for clean-files
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 8:57 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
> > I think this hack is a bad idea. arch/powerpc/boot/Makefile is the
> > only user. Let's stop doing this.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/powerpc/boot/Makefile | 4 ++--
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> cheers
>

Applied to linux-kbuild.



> >  scripts/Makefile.clean     | 8 +-------
> >  2 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index 4b4827c475c6..008bf0bff186 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -453,8 +453,8 @@ clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
> >  clean-kernel-base := vmlinux.strip vmlinux.bin
> >  clean-kernel := $(addsuffix .gz,$(clean-kernel-base))
> >  clean-kernel += $(addsuffix .xz,$(clean-kernel-base))
> > -# If not absolute clean-files are relative to $(obj).
> > -clean-files += $(addprefix $(objtree)/, $(clean-kernel))
> > +# clean-files are relative to $(obj).
> > +clean-files += $(addprefix ../../../, $(clean-kernel))
> >
> >  WRAPPER_OBJDIR := /usr/lib/kernel-wrapper
> >  WRAPPER_DTSDIR := /usr/lib/kernel-wrapper/dts
> > diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> > index 74cb1c5c3658..878cec648959 100644
> > --- a/scripts/Makefile.clean
> > +++ b/scripts/Makefile.clean
> > @@ -36,13 +36,7 @@ __clean-files      := \
> >
> >  __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
> >
> > -# clean-files is given relative to the current directory, unless it
> > -# starts with $(objtree)/ (which means "./", so do not add "./" unless
> > -# you want to delete a file from the toplevel object directory).
> > -
> > -__clean-files   := $(wildcard                                               \
> > -                $(addprefix $(obj)/, $(filter-out $(objtree)/%, $(__clean-files))) \
> > -                $(filter $(objtree)/%, $(__clean-files)))
> > +__clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
> >
> >  # ==========================================================================
> >
> > --
> > 2.32.0



-- 
Best Regards
Masahiro Yamada
