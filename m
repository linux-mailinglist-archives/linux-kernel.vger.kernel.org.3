Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B87536B59
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349321AbiE1HMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiE1HMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:12:12 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDBF2DE8;
        Sat, 28 May 2022 00:12:09 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24S7Bllt002344;
        Sat, 28 May 2022 16:11:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24S7Bllt002344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653721908;
        bh=Ke5jHo8VtsnIBuHnKcTafO9UNs8CqmDY9CjC7LoWcyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SvcSdFCEKE8RRXBMIA7XpimKe+J6UWfLaXXEF+jpQfgdH3GrR8iY9q+ZsIV8xpUKG
         St5ue4XgFERGiF+RT4A6EvCeqUvsstIYFgPOqpteV32R21Bjx2ckbRlHWHpo47vG/u
         I88KuEAfS8feRvZ1Zeu6e8/TF4z9c0qR3/CeLnvYu1SNlyr0FGFXmOg9qe8kTiydNj
         XOVejqH6RrgBpRp8OhPPt43V0mzC7828XWYpqPtFLDDVU5P4JWiXvfNQNb71p9BZqb
         gtsgVUBMyYe+u8aEOVKUYCS6ptlP6MLeS0ATaUDDjS8saLcJzCjLZSIqfyqyfzvrf5
         uzrCpOzyd8HEA==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id c10-20020a17090a4d0a00b001e283823a00so2764637pjg.0;
        Sat, 28 May 2022 00:11:48 -0700 (PDT)
X-Gm-Message-State: AOAM531zQaVWxXBQqYCASmimnbBy+RekmmU/IR17+KK2VGxCk/LQZG+4
        pzucTx50/0ztqOSeHxet2oVIXgtpbU9sW/8gtuE=
X-Google-Smtp-Source: ABdhPJxIgcs0jv5kYFRTIFUI+PolCz13bwvjdRWJmELBANgzVLOZHuuZI+qAblhvtkFaI4hepCODALq+NqXohlAZTOc=
X-Received: by 2002:a17:90a:9b08:b0:1e2:837f:bcce with SMTP id
 f8-20020a17090a9b0800b001e2837fbccemr5889109pjp.144.1653721907307; Sat, 28
 May 2022 00:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220527100155.1996314-1-masahiroy@kernel.org>
 <20220527100155.1996314-2-masahiroy@kernel.org> <CA+icZUX_xeZ8k-3YZppGbuYzeypU8f_iz_-tuMJ1bg0dhikH8A@mail.gmail.com>
In-Reply-To: <CA+icZUX_xeZ8k-3YZppGbuYzeypU8f_iz_-tuMJ1bg0dhikH8A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 May 2022 16:10:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyyomaAS1FK6CMbXKB69RzZMA-hDHL1wzLsuHtCkckyw@mail.gmail.com>
Message-ID: <CAK7LNARyyomaAS1FK6CMbXKB69RzZMA-hDHL1wzLsuHtCkckyw@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] kbuild: replace $(linked-object) with CONFIG options
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 11:32 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, May 27, 2022 at 1:56 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > *.prelink.o is created when CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT
> > is enabled.
> >
> > Replace $(linked-object) with $(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)
> > so you will get better idea when the --link option is passed.
> >
> > No functional change is intended.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Hi Masahiroy,
>
> I was not CCed on the cover-letter and only on some patches in this series.
>
> So, I have re-tested this series by pulling from kbuild.git#kbuild
> (saw later you renewed the parisc/nm patch).
>
> While testing my selfmade LLVM version 14.0.4 (PGO + ThinLTO
> optimized) toolchain I included this series.
>
> Just built fine and I was able to boot on bare metal.
>
> -Sedat -
>

Thanks for your testing!

I added your Tested-by tag.





> > ---
> >
> > Changes in v7:
> >   - New patch
> >
> >  scripts/Makefile.build | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 06400504150b..f80196eef03a 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -219,7 +219,7 @@ objtool_args =                                                              \
> >         $(if $(CONFIG_STACK_VALIDATION), --stackval)                    \
> >         $(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)          \
> >         --uaccess                                                       \
> > -       $(if $(linked-object), --link)                                  \
> > +       $(if $($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)), --link)    \
> >         $(if $(part-of-module), --module)                               \
> >         $(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
> >
> > @@ -284,7 +284,6 @@ quiet_cmd_cc_prelink_modules = LD [M]  $@
> >  # modules into native code
> >  $(obj)/%.prelink.o: objtool-enabled = y
> >  $(obj)/%.prelink.o: part-of-module := y
> > -$(obj)/%.prelink.o: linked-object := y
> >
> >  $(obj)/%.prelink.o: $(obj)/%.o FORCE
> >         $(call if_changed,cc_prelink_modules)
> > --
> > 2.32.0
> >



-- 
Best Regards
Masahiro Yamada
