Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3C510F72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354149AbiD0DXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348805AbiD0DXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:23:36 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FC112A;
        Tue, 26 Apr 2022 20:20:23 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 23R3K1Qm008071;
        Wed, 27 Apr 2022 12:20:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 23R3K1Qm008071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651029602;
        bh=m05V59uJysQY8vaTGqm7leyhJ6TqZcufOqEfqvArsLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gnY1P8RvKDujIDOUMYSseZtlP8LPglPDlvSzzU+5Oabj09LfLfxhSr6c3t8Ymf+ex
         ymb18YX6aRCHNi+0zxm7Y6MwMvI4pVnWyjhvh1r2IaZfkdWoNMNHDQm99ZW42O8Ofp
         vYaz7AXsUvWJJp2KmB3VynjIzUwDNl2k4egVxVmY8wCcm1Ru9H9oCzDYIxyOoIaTeX
         lEIRE0aL4Cwm5LUJTCWi3+wpBiumH+uGIlwrnzxMAoZClQBl9WRKbZuaeldb2K4F6u
         PO1+v2FaCi2HhuKhtludmYh/uEb04H1XqEBFastCK+d2Y/j54ABfQsqQxPCxa3IR/W
         mzW/TqosevnAA==
X-Nifty-SrcIP: [209.85.214.178]
Received: by mail-pl1-f178.google.com with SMTP id n18so470768plg.5;
        Tue, 26 Apr 2022 20:20:01 -0700 (PDT)
X-Gm-Message-State: AOAM53178XjwsVXTvoVZxbwAtXvMpdVJ86ekUr4D0b4KXVmGG/fZnUkt
        2meHK7fIQZX0tM27D2g9lyCcnMj0fEg4hhiKZMs=
X-Google-Smtp-Source: ABdhPJwk2QM2M3F1GBnYSDFbhuv7muAUvszgecWqtx6ceNyrVLGEHLvVXb91Em0JDXmIWLatqtFiesHnM9c3O6MIqro=
X-Received: by 2002:a17:90a:e7d1:b0:1da:30d0:9327 with SMTP id
 kb17-20020a17090ae7d100b001da30d09327mr2119874pjb.144.1651029601047; Tue, 26
 Apr 2022 20:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <YmhRz1SEjpEU8Nty@fjasle.eu>
In-Reply-To: <YmhRz1SEjpEU8Nty@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 27 Apr 2022 12:18:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4X2d+7JgRSMizMsKFAKmF1OLXyJ0YAvzdgBuSB+UnfQ@mail.gmail.com>
Message-ID: <CAK7LNAS4X2d+7JgRSMizMsKFAKmF1OLXyJ0YAvzdgBuSB+UnfQ@mail.gmail.com>
Subject: Re: [PATCH 00/27] kbuild: yet another series of cleanups (modpost and LTO)
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 5:11 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Mon, Apr 25, 2022 at 04:07:44AM +0900 Masahiro Yamada wrote:
> > This is the third batch of cleanups in this development cycle.
> >
> > This weekend, I wrote up the code I have been planning.
> >
> > After a bunch of modpost refactoring, I got rid of the ugly code
> > in Makefiles.
> >
> > With this, Kbuild will get back much simpler and cleaner.
> >
>
> Hi Masahiro,
>
> I tried applying the patch set onto your kbuild and
> kbuild-fixes-v5.18, but it didn't apply.  Can you give me
> a hint on your commit base?


This series is based on  linux-kbuild/kbuild branch
7c39c50dcb74 ("scripts: dummy-tools, add pahole")


Anyway, this series is too big.
For convenience, I pushed this to a topic branch.

Please try:

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 lto-cleanup





> Kind regards,
> Nicolas
>
> >
> > Masahiro Yamada (27):
> >   modpost: use snprintf() instead of sprintf() for safety
> >   modpost: do not write out any file when error occurred
> >   modpost: remove stale comment about sym_add_exported()
> >   modpost: add a separate error for exported symbols without definition
> >   modpost: retrieve the module dependency and CRCs in check_exports()
> >   modpost: use bool type where appropriate
> >   modpost: import include/linux/list.h
> >   modpost: traverse modules in order
> >   modpost: add sym_add_unresolved() helper
> >   modpost: traverse unresolved symbols in order
> >   modpost: use doubly linked list for dump_lists
> >   modpost: move struct namespace_list to modpost.c
> >   modpost: traverse the namespace_list in order
> >   modpost: dump Module.symvers in the same order of modules.order
> >   modpost: move static EXPORT_SYMBOL check to check_exports()
> >   modpost: make multiple export error
> >   modpost: make sym_add_exported() always allocate a new symbol
> >   modpost: make sym_add_exported() a void function
> >   modpost: use hlist for hash table implementation
> >   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
> >   kbuild: record symbol versions in *.cmd files
> >   kbuild: generate a list of objects in vmlinux
> >   modpost: retrieve symbol versions by parsing *.cmd files
> >   modpost: generate linker script to collect symbol versions
> >   kbuild: embed symbol versions at final link of vmlinux or modules
> >   kbuild: stop generating *.symversions
> >   kbuild: do not create *.prelink.o for Clang LTO or IBT
> >
> >  .gitignore                |   1 +
> >  Makefile                  |   1 +
> >  scripts/Kbuild.include    |   4 +
> >  scripts/Makefile.build    | 107 ++------
> >  scripts/Makefile.lib      |   7 -
> >  scripts/Makefile.modfinal |   6 +-
> >  scripts/Makefile.modpost  |   9 +-
> >  scripts/link-vmlinux.sh   |  38 ++-
> >  scripts/mod/file2alias.c  |   2 -
> >  scripts/mod/list.h        | 336 ++++++++++++++++++++++++
> >  scripts/mod/modpost.c     | 529 +++++++++++++++++++++++---------------
> >  scripts/mod/modpost.h     |  27 +-
> >  12 files changed, 731 insertions(+), 336 deletions(-)
> >  create mode 100644 scripts/mod/list.h
> >
> > --
> > 2.32.0
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
