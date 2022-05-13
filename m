Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5E5260E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379859AbiEMLVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378094AbiEMLV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:21:26 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D226A4BBAE;
        Fri, 13 May 2022 04:21:23 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24DBL5eI005328;
        Fri, 13 May 2022 20:21:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24DBL5eI005328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652440865;
        bh=3tI3D7hiyyyIzHnssR6gH32RhQ9iCi1PmX8JTdAAbK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FNrcSNRu/H684rp9bSyXcSEnsqIndi8Cc+unqqxlbC7K9oAomCj4cnGTQVJCd/2hb
         9b7OaMJaaCAbcQKX2fpCrN9YCw8jQm6B6TZmSALO51hED9MfPLMmduJM0EUnQHsoRl
         ONJgfvVH2S9SCQYJQksfftzTxHsAVsWbiAkR4Q+tDzWnt4JbGxar/zBxVyVj1MYChI
         jLj6Aaaf+ChkvzBHJl2MPIYDHGT8rkQe6KbYCmXDRrCJ0Xm/c7Zp2eGsylOP4vpzKu
         bLP5744eETFsrwCANFrkgSRlssSu5FDzb9gc/Z2J6nScOgzqrEqJnd/jEpxs7Cs/Vr
         sHWLM3BbBKCJQ==
X-Nifty-SrcIP: [209.85.214.178]
Received: by mail-pl1-f178.google.com with SMTP id d22so7624019plr.9;
        Fri, 13 May 2022 04:21:05 -0700 (PDT)
X-Gm-Message-State: AOAM531Cv4DmWzHbE/EcXOsMojZl4ibMnXjVomWDXqJdRhq/98L19sEL
        nrKeSVN19CGxbbi8Ema/979uF04DU7pf3RNBNn8=
X-Google-Smtp-Source: ABdhPJxrUzvKeAz23KKcJoGYoRhEsRSXGPu3aS7Qu2aL1nDGTyhJ/9/U10A4dP5fZ0eKdHZhvjye16kS7LpfUh26AlI=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr4333904plp.162.1652440864645; Fri, 13
 May 2022 04:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org>
 <YnwWsYdL2khCikSY@dev-arch.thelio-3990X> <CAK7LNATs67zGL7JohD-79Nxig25XCC=T9Dih4Z8iwdhoiWai8w@mail.gmail.com>
In-Reply-To: <CAK7LNATs67zGL7JohD-79Nxig25XCC=T9Dih4Z8iwdhoiWai8w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 20:19:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7qHFjoSKhRQC0cAzAu3aD5i_z+tdnv7Hf0VYZ7mJbDw@mail.gmail.com>
Message-ID: <CAK7LNAQ7qHFjoSKhRQC0cAzAu3aD5i_z+tdnv7Hf0VYZ7mJbDw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
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

On Fri, May 13, 2022 at 8:18 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 5:04 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Masahiro,
> >
> > On Thu, May 12, 2022 at 01:45:02AM +0900, Masahiro Yamada wrote:
> > >
> > > This is the third batch of cleanups in this development cycle.
> > >
> > > Major changes in v5:
> > >  - Fix build errors
> > >  - More cleanups
> > >
> > > Major changes in v4:
> > >  - Move static EXPORT_SYMBOL check to a script
> > >  - Some refactoring
> > >
> > > Major changes in v3:
> > >
> > >  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
> > >
> > > Major changes in v2:
> > >
> > >  - V1 did not work with CONFIG_MODULE_REL_CRCS.
> > >    I fixed this for v2.
> > >
> > >  - Reflect some review comments in v1
> > >
> > >  - Refactor the code more
> > >
> > >  - Avoid too long argument error
> > >
> > >
> > >
> > > Masahiro Yamada (12):
> > >   modpost: split the section mismatch checks into section-check.c
> > >   modpost: add sym_find_with_module() helper
> > >   modpost: extract symbol versions from *.cmd files
> > >   kbuild: link symbol CRCs at final link, removing
> > >     CONFIG_MODULE_REL_CRCS
> > >   kbuild: stop merging *.symversions
> > >   genksyms: adjust the output format to modpost
> > >   kbuild: do not create *.prelink.o for Clang LTO or IBT
> > >   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
> > >   kbuild: make built-in.a rule robust against too long argument error
> > >   kbuild: make *.mod rule robust against too long argument error
> > >   kbuild: add cmd_and_savecmd macro
> > >   kbuild: rebuild multi-object modules when objtool is updated
> >

The first two applied.

I will send v6 for the rest.






-- 
Best Regards
Masahiro Yamada
