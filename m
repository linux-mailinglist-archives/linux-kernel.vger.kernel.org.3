Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4810154FA27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382489AbiFQPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382444AbiFQPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:22:41 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DBC1014;
        Fri, 17 Jun 2022 08:22:37 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 25HFM6XE030155;
        Sat, 18 Jun 2022 00:22:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 25HFM6XE030155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655479327;
        bh=vvgHqTh1wXE7hKhLuY8TbWdkyuEIhZfbEWS5VwgPLWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cOhw7EC0b08gudg9umyob1bJwEpW/9gwNi19r2R3h6ee2+O0VOh2ZikmOyg93iBNw
         4JApVO9XsOOkgnMMjxCowcJ3hkoCvIjWXEBaccZDpXgoJauYp9TywX0OIjQ2E1tkhp
         2MXfPqpc1t41FUF6HuTzyvvskXjjBAKGgmYXIx691NQinh+X15JMOw6CB3cUNOYNnm
         F7K1xY/eLP0ysPIgbhLFVOzRpv5EIyzfTz1U5Uzwb/Z0W9MkVLHvRAjhKrh1hcMcFg
         LK/xSRD6xfZUYW2ljpr+0U5pwXhpQwuSNxXE8Hgl+25jN9TcR2gXf3jfm2e4oohwCm
         ZfUiGipTAAJCg==
X-Nifty-SrcIP: [209.85.128.52]
Received: by mail-wm1-f52.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so4549592wma.1;
        Fri, 17 Jun 2022 08:22:06 -0700 (PDT)
X-Gm-Message-State: AOAM531oQaBYN7QPzcs4x2AScm2Q0sm/pwUOYGcemnetMnZfZebfhny2
        OeGidtWfNmcMFa3Z0YzAvcjBYrroLnBzVpCHZBY=
X-Google-Smtp-Source: ABdhPJyH38D6N7CsO2MxwY1ptWXxzTktDOO0nHF1abeRdJfr3gtU2ythFA8M74KbgUO0c9L6WDiXK9Sv7m5KAspRB1o=
X-Received: by 2002:a7b:c346:0:b0:397:626d:d2c4 with SMTP id
 l6-20020a7bc346000000b00397626dd2c4mr21355129wmj.172.1655479325296; Fri, 17
 Jun 2022 08:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com> <CA+icZUXDGdPrPKUnevt99LUpTRPe=ogqF33uHQRYrQ6Kh-iTAw@mail.gmail.com>
In-Reply-To: <CA+icZUXDGdPrPKUnevt99LUpTRPe=ogqF33uHQRYrQ6Kh-iTAw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 18 Jun 2022 00:21:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHY88PbJ_=A6g7v8NMQnBcQ9g06k1+SCe+NM+xd5dLwA@mail.gmail.com>
Message-ID: <CAK7LNATHY88PbJ_=A6g7v8NMQnBcQ9g06k1+SCe+NM+xd5dLwA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+LLVM list, Fangrui Song)

On Fri, Jun 17, 2022 at 7:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jun 17, 2022 at 12:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> > > > >
> > > > > Until the link-vmlinux.sh split (cf. the commit below), the linker was
> > > > > run with jobserver set in MAKEFLAGS. After the split, the command in
> > > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> > > > > is lost.
> > > > >
> > > > > Restore it as linkers working in parallel (esp. the LTO ones) make a use
> > > > > of i

Hi Jiri,

Please let me clarify first.

Here, is it OK to assume you are talking about Clang LTO
instead of GCC LTO because the latter is not upstreamed ?





I tested this patch but I did not see any performance change for Clang LTO.


[1] CONFIG_CLANG_LTO_FULL

   lld always runs sequential.
   It never runs in parallel even if you pass -j option to Make


[2] CONFIG_CLANG_LTO_THIN

   lld always runs in parallel even if you do not pass -j option

   In my machine, lld always allocated 12 threads.
   This is irrespective of the Make parallelisms.




One more thing, if a program wants to participate in
Make's jobserver, it must parse MAKEFLAGS, and extract
file descriptors to be used to communicate to the jobserver.

As a code example in the kernel tree,
scripts/jobserver-exec parses "MAKEFLAGS" and "--jobserver".




I grepped the lld source code, but it does not contain
"MAKEFLAGS" or "jobserver".


masahiro@oscar:~/ref/lld$ git remote  show origin
* remote origin
  Fetch URL: https://github.com/llvm-mirror/lld.git
  Push  URL: https://github.com/llvm-mirror/lld.git
  HEAD branch: master
  Remote branches:
    master     tracked
    release_36 tracked
    release_37 tracked
    release_38 tracked
    release_39 tracked
    release_40 tracked
    release_50 tracked
    release_60 tracked
    release_70 tracked
    release_80 tracked
    release_90 tracked
  Local branch configured for 'git pull':
    master merges with remote master
  Local ref configured for 'git push':
    master pushes to master (up to date)
masahiro@oscar:~/ref/lld$ git grep MAKEFLAGS
masahiro@oscar:~/ref/lld$ git grep jobserver


So, in my research, LLD does not seem to support the jobserver.





If you are talking about GCC LTO, yes, the code
tries to parse "--jobserver-auth=" from the MAKEFLAGS
environment variable.  [1]

[1]:  https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/lto-wrapper.cc#L1341


But, as you may know, GCC LTO works in a different way,
at least, we cannot do it before modpost.


-- 
Best Regards
Masahiro Yamada
