Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784755371EB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiE2ReB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiE2ReA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:34:00 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A2120A9;
        Sun, 29 May 2022 10:33:58 -0700 (PDT)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24THXW2X027467;
        Mon, 30 May 2022 02:33:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24THXW2X027467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653845613;
        bh=hkQNvF7+Ex9SCmIwT/F2wkriYtxT9dXhU2/6AT55FWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBDKZ/Cbqar31u2MK689ElxxfE+gU91JXCdRKOCTnlbCXTZkCMxeyD+Pe+1BJsyu5
         sFaxrC72xewRnmbL5y2nJ2JZjDky0E/ssKuUZQLfCrmR1e898uPcqlmVsy+oaZuAvf
         nSfqWJjV1CH2dVz+wqaLCO3p7l7plHkGmTOAT9xKMK8X+Nji+h0BRkTlA+jDd9Bqvd
         N4VavnV3QjsS7/d9Ouyu2AXhRe039cFdLUi44BEmkdfYfK3/eJFiqEcjrLNpJukKCi
         J5K04yliFBGo4RdiymJseB8cFA3GVNb242Z+rHTNnfckq+nV3IiBhdOIVCNUCfNgI8
         4bd7sWlPMIrIA==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id g67so636952pfb.2;
        Sun, 29 May 2022 10:33:32 -0700 (PDT)
X-Gm-Message-State: AOAM532Cq71tHhEwU0apSfRXKiIUCVzzTPPwkxGCDk0BaXYdGI2GDnJP
        DoONDA5lIHpR+E9CE02NahsaRUAPagKGJUZjiNA=
X-Google-Smtp-Source: ABdhPJzrmR6z62EbQHRlyzezk+yCEZxKLnnOUxK30N50EXmdYALhtLEiR36Ukh+pp+OSajX66LcQ/qPvIfY3/m2ie1Q=
X-Received: by 2002:a05:6a00:a01:b0:51b:51d8:3c2a with SMTP id
 p1-20020a056a000a0100b0051b51d83c2amr1158974pfh.68.1653845611969; Sun, 29 May
 2022 10:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <20220528154704.2576290-2-masahiroy@kernel.org> <CA+icZUX2k6eB_JfRJ3X3te44nV0CZycpWX5cT1YMPGR1_VrXjg@mail.gmail.com>
In-Reply-To: <CA+icZUX2k6eB_JfRJ3X3te44nV0CZycpWX5cT1YMPGR1_VrXjg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 May 2022 02:32:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQMx8ACUK6xTQrCtscTECZhM2zZhLSGaL5F6x304T77A@mail.gmail.com>
Message-ID: <CAK7LNARQMx8ACUK6xTQrCtscTECZhM2zZhLSGaL5F6x304T77A@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: clean .tmp_* pattern by make clean
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 11:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, May 28, 2022 at 9:43 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Change the "make clean" rule to remove all the .tmp_* files.
> >
> > .tmp_objdiff is the only exception, which should be removed by
> > "make mrproper".
> >
> > Rename the record directory of objdiff, .tmp_objdiff to .objdiff to
> > avoid the removal by "make clean".
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> When does someone see .objdiff file(s)?

It is created when you run scripts/objdiff



>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
> ( Never seen here. )
>
> -Sedat-
>
> > ---
> >
> >  Makefile                | 4 ++--
> >  scripts/link-vmlinux.sh | 3 ---
> >  scripts/objdiff         | 2 +-
> >  3 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index edc3f44cd96c..7011d43dff35 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1490,7 +1490,7 @@ CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
> >
> >  # Directories & files removed with 'make mrproper'
> >  MRPROPER_FILES += include/config include/generated          \
> > -                 arch/$(SRCARCH)/include/generated .tmp_objdiff \
> > +                 arch/$(SRCARCH)/include/generated .objdiff \
> >                   debian snap tar-install \
> >                   .config .config.old .version \
> >                   Module.symvers \
> > @@ -1857,7 +1857,7 @@ clean: $(clean-dirs)
> >                 -o -name '*.lex.c' -o -name '*.tab.[ch]' \
> >                 -o -name '*.asn1.[ch]' \
> >                 -o -name '*.symtypes' -o -name 'modules.order' \
> > -               -o -name '.tmp_*.o.*' \
> > +               -o -name '.tmp_*' \
> >                 -o -name '*.c.[012]*.*' \
> >                 -o -name '*.ll' \
> >                 -o -name '*.gcno' \
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 844fc0125d72..b593cb1a8137 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -303,9 +303,6 @@ sorttable()
> >  cleanup()
> >  {
> >         rm -f .btf.*
> > -       rm -f .tmp_System.map
> > -       rm -f .tmp_initcalls.lds
> > -       rm -f .tmp_vmlinux*
> >         rm -f System.map
> >         rm -f vmlinux
> >         rm -f vmlinux.map
> > diff --git a/scripts/objdiff b/scripts/objdiff
> > index 72b0b63c3fe1..68b8d74e5c6f 100755
> > --- a/scripts/objdiff
> > +++ b/scripts/objdiff
> > @@ -32,7 +32,7 @@ if [ -z "$SRCTREE" ]; then
> >         exit 1
> >  fi
> >
> > -TMPD=$SRCTREE/.tmp_objdiff
> > +TMPD=$SRCTREE/.objdiff
> >
> >  usage() {
> >         echo >&2 "Usage: $0 <command> <args>"
> > --
> > 2.32.0
> >



-- 
Best Regards
Masahiro Yamada
