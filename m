Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237158DB02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbiHIPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiHIPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:21:15 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D9201B0;
        Tue,  9 Aug 2022 08:21:11 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 279FKsRH030769;
        Wed, 10 Aug 2022 00:20:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 279FKsRH030769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660058456;
        bh=ehY71FsW601x63CPvQxCDEV9npZMmiq6LrR++w99gUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLGudliSNeG9Nc0FoTKiVDAu8sncXeUiRS06KvvArcDOwbr7L5QMJCexOQjQMcLbK
         ZarPoq8eETKY2ZpKN0kt/IAgTzzytLPwj91kMDINFTpVuUd6d7xusTksGMSsZEa4QA
         +nUdKV0btTPlkMPthPd6l3sMIttoA77FODvlZre9XopAsJY7u/Dpx9bUttvvxIbTEM
         EZavvf8BADbYdDY2M53RmjeSsrE4Fagu8hW+d10KfrkRBaLx+sDrUVWv6J8fuMeDTu
         OuzSu2USI7XWy6wrInEhnqT5q0OTfyRkAmMHluJf6fBsmBDpwFMSRufTHp+BBiVobu
         4rzbwvNdl8gjA==
X-Nifty-SrcIP: [209.85.221.46]
Received: by mail-wr1-f46.google.com with SMTP id q30so14656810wra.11;
        Tue, 09 Aug 2022 08:20:55 -0700 (PDT)
X-Gm-Message-State: ACgBeo3rhEiykvngggdzBVhY8m7/xnEhp/8A/klI9MzwkbGtUoJwTUM7
        sfGg1z2xgkpsnOuazc59y1BBTbpN+djifHsuABE=
X-Google-Smtp-Source: AA6agR45uaVj3oXaxHlj5+fMWTKPWeF0jBcj5Tb6P2TOZfXqs2wTkF3S5mzwUFGqv5PmDLDsxkjjWUPTy93NqkrARws=
X-Received: by 2002:a05:6000:168f:b0:220:748e:82c0 with SMTP id
 y15-20020a056000168f00b00220748e82c0mr14432497wrd.477.1660058453881; Tue, 09
 Aug 2022 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk> <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
 <38a9853e59db8946999316ce3a6b4621@matoro.tk> <CAK7LNATa1fdwQsuC3LOkzhr1SaR6ipJqe1b0fAC1pk3LX9wDhA@mail.gmail.com>
 <d4f30a7313f1ff43d0c919fc556f08fe@matoro.tk>
In-Reply-To: <d4f30a7313f1ff43d0c919fc556f08fe@matoro.tk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Aug 2022 00:20:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGewXa8bHy1SZNzTi+V5aoHdV6OysY0z76SQNs92iB9Q@mail.gmail.com>
Message-ID: <CAK7LNASGewXa8bHy1SZNzTi+V5aoHdV6OysY0z76SQNs92iB9Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Tue, Aug 9, 2022 at 3:42 AM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
>
> That patch doesn't apply to the v5.19 stable tag, so I just manually
> edited and it worked perfect!  Thank you!!
>
> Sorry I didn't mention that warning - I did see it, but it still showed
> up even on the old kernel, so I thought it was irrelevant.  Much
> appreciated!
>
> -------- Original Message --------
> Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups
> (modpost, LTO, MODULE_REL_CRCS, export.h)
> Date: 2022-08-08 13:36
>  From: Masahiro Yamada <masahiroy@kernel.org>
> To: matoro <matoro_mailinglist_kernel@matoro.tk>
>
> On Mon, Aug 8, 2022 at 10:27 PM matoro
> <matoro_mailinglist_kernel@matoro.tk> wrote:
> >
> > I have real hardware for all these arches in my collection.  I use it
> > for testing the latest kernel and toolchains on as many of the
> > less-popular arches as possible, exactly to find issues like this one
> > :)
> >
> > Specifically we support all of these in Gentoo.  To double-check this
> > wasn't a config issue, I asked another user who also runs sparc to try
> > building 5.19 with his config (not copying mine), and he observed the
> > same problem.  You can reach us in #gentoo-sparc on Libera.
> >
> > As for testing, I make all this hardware available on an as-needed
> > basis.  So if you can't or don't want to fiddle with qemu, just let me
> > know (email or IRC, same username on Libera), and I will get you direct
> > access to my hardware.  Thanks!!
>
>
> I found the root cause.
>
> When I build the sparc kernel, I see a warning
>
> WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation
> failed, symbol will not be versioned.
>
>
> Then, modpost missed to write out the entry.
>
> With the following patch, you will be able to load the module.
>
> I will send a patch with a proper commit log tomorrow. I need some sleep
> now.



I posted a patch:


https://patchwork.kernel.org/project/linux-kbuild/patch/20220809141117.641543-1-masahiroy@kernel.org/


If you want me to record your full name in Reported/Tested-by,
please let me know.





-- 
Best Regards
Masahiro Yamada
