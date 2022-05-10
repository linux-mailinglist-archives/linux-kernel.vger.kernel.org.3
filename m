Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B7521C87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiEJOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbiEJOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:35:50 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33923176;
        Tue, 10 May 2022 06:55:23 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24ADsqFH021437;
        Tue, 10 May 2022 22:54:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24ADsqFH021437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652190892;
        bh=GhyJd382a/wS1zL1PdRPTSc5dz0OmScabiVrpCKaIOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UauZq89LrkM/cBmL1IrYEN9SfUuhjvaGe24+hHUTCr6S1DeVhg6gB6xE3NmQVWVBj
         6DbqE9knamXjVI5te5FZFczDJTT7rQh6QEpZGNweYCbuimKgjSP/aGE47BFaaWV7QP
         nWQxXCsVVeDV23zU0WTiLibA+WIGOjBJTHCjF4SPElVzM4LAreMHLGulclrOMvYw5E
         qm1qnxBibkRLJhddDsUy2bW1mf7U3O4hZWjTWyZEgCdTAJ2UZWyhO6iXkwbD01KF5z
         Z5XKrZ5vubGXCeK8VoNsMtnTLZZswrdolQP0koNBf4Nj8MTqic3HFt8425yBdlzD20
         yW/2Fl9yu/nuQ==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id i17so16800307pla.10;
        Tue, 10 May 2022 06:54:52 -0700 (PDT)
X-Gm-Message-State: AOAM532NTcpjBtDK34EPiQZlMkC0euoAT2hkOfRsfRlwirrLz8tkJuZT
        mvr0v6LnSSBlIPozH2J8+7PXuUvYU47N4t8vHw4=
X-Google-Smtp-Source: ABdhPJzh5Xg40qnHgjRxAy+2yZ4xm+X8+in8r4zEytwaErju3Iipi+xTG2cJwA+7X0E5U7wpLUUa0KgN+U0NnVHMv0g=
X-Received: by 2002:a17:902:7891:b0:15e:cae9:7620 with SMTP id
 q17-20020a170902789100b0015ecae97620mr21001207pll.136.1652190891612; Tue, 10
 May 2022 06:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org>
 <20220508190631.2386038-11-masahiroy@kernel.org> <CAKwvOdkhcJB8Bnrt51siRefWe+ZSvHagCs2G011PzkkrD3cxQw@mail.gmail.com>
In-Reply-To: <CAKwvOdkhcJB8Bnrt51siRefWe+ZSvHagCs2G011PzkkrD3cxQw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 10 May 2022 22:53:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMaW34NP+=0UF=aJ=Z7h0QSuzV2F1QjYjru9nFooG9tQ@mail.gmail.com>
Message-ID: <CAK7LNATMaW34NP+=0UF=aJ=Z7h0QSuzV2F1QjYjru9nFooG9tQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] kbuild: check static EXPORT_SYMBOL* by script
 instead of modpost
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
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

On Tue, May 10, 2022 at 3:05 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > diff --git a/scripts/check-local-export b/scripts/check-local-export
> > new file mode 100755
> > index 000000000000..d1721fa63057
> > --- /dev/null
> > +++ b/scripts/check-local-export
> > @@ -0,0 +1,48 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (C) 2022 Masahiro Yamada
> > +
> > +set -e
> > +set -o pipefail
> > +
> > +declare -A symbol_types
> > +declare -a export_symbols
> > +
> > +exit_code=0
> > +
> > +while read value type name
> > +do
> > +       # to avoid error for clang LTO; $name may be empty
> > +       if [[ $value = -* && -z $name ]]; then
> > +               continue
> > +       fi
> > +
> > +       # The first field (value) may be empty. If so, fix it up.
> > +       if [[ -z $name ]]; then
> > +          name=${type}
> > +          type=${value}
> > +       fi
>
> Consider adding examples of output from NM as comments where you're
> handling special cases.
>
> Aren't BOTH from LTO?  The first case is:
>
> ---------------- T strncpy


For LTO, I see

---------------- t

in the llvm-nm output.



>
> while the second is
>
>                  U strncpy

Right, this happens for all unresolved symbols.
The address part is empty.


I will add the output example in the comment block.





> IIUC?
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdkhcJB8Bnrt51siRefWe%2BZSvHagCs2G011PzkkrD3cxQw%40mail.gmail.com.



-- 
Best Regards
Masahiro Yamada
