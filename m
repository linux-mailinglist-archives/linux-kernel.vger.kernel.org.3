Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68A47C9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhLUXXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:23:45 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30253 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhLUXXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:23:44 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 1BLNNHa4005092;
        Wed, 22 Dec 2021 08:23:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 1BLNNHa4005092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1640128998;
        bh=Mgwd2xi548VgomBDJet/kbCBxCGaN8Xhh3/n4lkHahM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LrWfPJoVZRGIhRU5n/jMRU1cqD1zm583R/R85ZTGbPuJg61VFgDLIANHHPGyk2ECf
         Exdwu1N7lnRl6QgkpfBx0n539cXjsCuvjDnGYLrRtfsd8W4M8Qt6rt18IQyuc5feS7
         aQyQJMvfOt7iR1MVUJT+rpgyY9iyJwyPkGatZJOJ0RQ+btwZSm9D2XY+EBbj5v62uI
         HFr311HllLcnf2Cs4p3uGXeL44cf+Du9oFgZWisNL2ygB9K33y4inQHazJMLQurifR
         MwAau89f9cr7JX2fHmQMv42R3loB5KBjNrKJlIPB4GLSBN2muyg+OAQOnzwc2hfpXP
         t+z4RpIQUx1jA==
X-Nifty-SrcIP: [209.85.210.170]
Received: by mail-pf1-f170.google.com with SMTP id t123so599800pfc.13;
        Tue, 21 Dec 2021 15:23:18 -0800 (PST)
X-Gm-Message-State: AOAM530xwl3K1GB23ZmNBHIsE1rhYJh49IisHAkq72zk1eSKemGWkiPK
        2Q968sqWAwsG/vkp0W0dHzg1uQbFeDKbqJ/2o6w=
X-Google-Smtp-Source: ABdhPJyGOHJM1AVFJy0VcI6dJ1gzmzrWkdpdnhYXzUwfdAqGc6KCiJHHC9WrMEso8fb5p6Xth3nknwHdEJXuywXLMpw=
X-Received: by 2002:a63:1947:: with SMTP id 7mr512348pgz.616.1640128997165;
 Tue, 21 Dec 2021 15:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20211210000910.3597609-1-keescook@chromium.org> <CAK8P3a3wOVdds2-qz365LoBNGtrx6ksCzCHp7T+qSev+R3ZRPQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3wOVdds2-qz365LoBNGtrx6ksCzCHp7T+qSev+R3ZRPQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Dec 2021 08:22:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6po1Zj0QnFkaKZbDw8P3YD7Z2-20zsp_HBrUfmeEaWw@mail.gmail.com>
Message-ID: <CAK7LNAS6po1Zj0QnFkaKZbDw8P3YD7Z2-20zsp_HBrUfmeEaWw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.debug: Make DEBUG_INFO selectable from a choice
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 6:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Dec 10, 2021 at 1:09 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Currently it's not possible to enable DEBUG_INFO for an all*config
> > build, since it is marked as "depends on !COMPILE_TEST". This generally
> > makes sense because a debug build of an all*config target ends up taking
> > much longer and the output is much larger. Having this be "default off"
> > makes sense. However, there are cases where enabling DEBUG_INFO for such
> > builds is useful for doing treewide A/B comparisons of build options,
> > etc.
> >
> > Make DEBUG_INFO selectable from any of the DWARF version choice options,
> > with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
> > exclusive relationship between DWARF5 and BTF must be inverted, but the
> > result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
> > up to the top of the menu because was enabling features _above_ it,
> > making it weird to navigate menuconfig.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Looks good to me,
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> One detail:
>
> > +choice
> > +       prompt "Debug information"
> > +       depends on DEBUG_KERNEL
> > +       default DEBUG_INFO_NONE if COMPILE_TEST
> > +       default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL
>
> I think this line should be simplified to
>
>           default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT

Indeed.

It can be simplified into:

           default DEBUG_INFO_NONE if COMPILE_TEST
           default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT

The first entry of the choice is the default.
So, it can be further simplified to:

          default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if !COMPILE_TEST



Another way is to move DEBUG_INFO_NONE to the last entry of the choice,
then

        default DEBUG_INFO_NONE if COMPILE_TEST





> since DEBUG_KERNEL is always enabled at this point. You can also consider
> turning the 'menu' into 'menuconfig DEBUG_KERNEL' and dropping the 'depends
> on DEBUG_KERNEL' in favor of the implied dependency.
>
>        Arnd



-- 
Best Regards
Masahiro Yamada
