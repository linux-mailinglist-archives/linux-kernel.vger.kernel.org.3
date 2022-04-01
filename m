Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007244EEDE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbiDANNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346351AbiDANNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:13:18 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C261D66DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:11:27 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 231DB4ub028016
        for <linux-kernel@vger.kernel.org>; Fri, 1 Apr 2022 22:11:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 231DB4ub028016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648818665;
        bh=/kI3lQPTgEygcI7vmBN005HvGRQcbjUBTIDFX8fCsok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vlVvQCkO5HP+kKJ2zs9SP8MYR167xK8MnHYtRrF8iD825i5ZfWXP5RezshrudtHAV
         ekNu4WL0lCFYRrEgYQEJeIxhAcgstnWdT9D9JoO1wOrJuNKjkOsfXvX3+ERh+ReWR5
         HQ6BMJ7JIXAWqsB8Yykil5Ju8sWVTrjS5e0MguhbWdw1vpXoHDwmu1P+gdVoBe5E5s
         0KGsc1Of/ErmaSOaQXa9+bic1VtjolCwhJx7rPrHAI4Pk7TUadqCdN87UPnCV04gVq
         p7QtxVnt43izdvv7CyDDopnwkCa2mkAlsq7wwOzgO+BjeLvZ0oQUmZtjdBYXoDiCm6
         Lms+rHpPPX9YA==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id y16so2368717pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:11:04 -0700 (PDT)
X-Gm-Message-State: AOAM532TAH5Pgr0P/SI+uQ9jDItEExr0x0Rqd2JFBl1NvGlwJgLkNIZS
        XC029v9Q46hiuuGM6dta0E0QmbIK5uDxZmyD+Ug=
X-Google-Smtp-Source: ABdhPJxIay5Z8UU92lADQCkERH4RVzsDhwr+Hx1SjiWIoiMOqBVc5jaSrmPEqdxc4cMxCGnuhdAN/qfPy2s6hzVNF1M=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr10211008plp.162.1648818664197; Fri, 01
 Apr 2022 06:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220322173547.677760-1-nathan@kernel.org> <CAK7LNAT8TcDy=iKaWZ7_+MbT84vOVEBzHxJY8Bx54Ju5fur8-w@mail.gmail.com>
 <Yj9wyNwZWkilNbJM@dev-arch.thelio-3990X>
In-Reply-To: <Yj9wyNwZWkilNbJM@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Apr 2022 22:10:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKg87aZTTF7heXnh1sWFm9Stxsu5unRw_rSbKB=jCr9g@mail.gmail.com>
Message-ID: <CAK7LNASKg87aZTTF7heXnh1sWFm9Stxsu5unRw_rSbKB=jCr9g@mail.gmail.com>
Subject: Re: [PATCH] um: Fix filtering '-mno-global-merge'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 5:00 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, Mar 26, 2022 at 12:29:55PM +0900, Masahiro Yamada wrote:
> > On Wed, Mar 23, 2022 at 2:39 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > When booting a clang compiled UML kernel, the kernel panics when trying
> > > to run init:
> > >
> > >   wait_stub_done : failed to wait for SIGTRAP, pid = 651294, n = 651294, errno = 0, status = 0xb7f
> > >   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > >
> > > After the commit in Fixes, many flags from KBUILD_CFLAGS do not appear
> > > in USER_CFLAGS, likely due to USER_CFLAGS initially being a recursive
> > > variable ("VAR =") then being switched to a simple ("VAR :=") variable.
> > > For example, diffing arch/x86/um/.ptrace_user.o.cmd shows flags such as
> > > '-Os' and '-fno-delete-null-pointer-checks' getting dropped, which both
> > > impact code generation.
> > >
> > > Rework the filtering to use filter-out instead of patsubst, which allows
> > > all the patterns that USER_CFLAGS cares about to be excluded in one
> > > command and ensures all flags from KBUILD_CFLAGS are transferred over to
> > > USER_CFLAGS properly, which resolves the boot issue noted above.
> > >
> > > Fixes: 6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> >
> >
> > Can we remove -mno-global-merge entirely?
> >
> >
> > 61163efae02040f66a95 was a very old commit,
> > without enough explanation.
> >
> > Shall we remove  -mno-global-merge, and do compile-tests.
> > If we are hit by problems for arm/arm64, we can re-add it.
>
> Yes, I think that was the conversation that we had on the commit that
> this fixes:
>
> https://lore.kernel.org/r/YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X/
>
> I can test that on my Raspberry Pi 3 and 4 on Monday, although I would
> like for this patch to be picked up in the meantime so that it is
> possible to test UML on -next with clang. We can remove
> -mno-global-merge in a follow up change, if you do not have any
> objections?
>
> Cheers,
> Nathano


This patch is unneeded now
because I picked up the alternative:

https://lore.kernel.org/all/CAK7LNAS6C6Uj9cCQ0o=bYF1F-EVD=VgdR8YYx-1PJc9toX_HZA@mail.gmail.com/



-- 
Best Regards
Masahiro Yamada
