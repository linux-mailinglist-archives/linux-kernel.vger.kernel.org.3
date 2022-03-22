Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3A4E39DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiCVHrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCVHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:47:06 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44248E62;
        Tue, 22 Mar 2022 00:44:05 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 22M7hfwg024030;
        Tue, 22 Mar 2022 16:43:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 22M7hfwg024030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647935022;
        bh=SxNJQMCFxMMS774Ea8L8kiMXQtPQJv6QAVqqcm0uVn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UEItilZiP+cUTpZNRVTdbVAD52FXU6NkWMlptDK9pT8xt9P+qfQ7KN4hA9mzTXhtA
         FKnDsCOillbU43IR2Zwy0g+mxMhlN9o14FXoGF4N4BYMCKsMoOBgHmHC18wPKdh0X2
         gfczEITCmPS841iU9jMaQ0TcAVb2Z3629S2/4r6i6aIGInwa5sQupbDld7X2TQXpzO
         EHDVGvC5lR+A5OBbgzDPy3zfDYVmM+ixdxi91DxU0m0i0CCyX8/zHnRELUQhubZF3S
         /YvIozqJlo3IOtbX8EjKcuMDtgColCffLWW7oOdADqDYo1+HIc5ZNjY3bDDeqIavil
         6SuY60ias7rIQ==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id t5so17519056pfg.4;
        Tue, 22 Mar 2022 00:43:42 -0700 (PDT)
X-Gm-Message-State: AOAM5319+bJihV1JYYGaK2qs1oy5+PgsgmqW/GJQ8v8FhbTIh/SHmYug
        e3R/+cP9WNjKJvOYXIyGRxgcLD5eGrcBsFsiUhM=
X-Google-Smtp-Source: ABdhPJxZ9zN4TLQP11Pq9u2qB1LjyeqixgQ28H3ffG4zL3mh7x0Vg0EhRvibe59lLMa6kYIH0QuRXzZSUyA15djKsoA=
X-Received: by 2002:a63:ec47:0:b0:382:692a:dc04 with SMTP id
 r7-20020a63ec47000000b00382692adc04mr9278053pgj.352.1647935021432; Tue, 22
 Mar 2022 00:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220306223016.2239094-1-ctshao@google.com> <CAKwvOdnmtRYnSx3VvG=PEnzpzWa8f=0bn1xDymjER5EShS2tmw@mail.gmail.com>
 <YiaMJCHOOuujHwiK@google.com> <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
 <YjFQvhv7I6w8xjbK@google.com>
In-Reply-To: <YjFQvhv7I6w8xjbK@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Mar 2022 16:42:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmPXs6f-Oe4XmfcZSRPsCsuexSebA=4-jyNsMYHu9cag@mail.gmail.com>
Message-ID: <CAK7LNATmPXs6f-Oe4XmfcZSRPsCsuexSebA=4-jyNsMYHu9cag@mail.gmail.com>
Subject: Re: [PATCH v4] config: Allow kernel installation packaging to
 override pkg-config
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org, DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:51 AM Chun-Tse Shao <ctshao@google.com> wrote:
>
> Tue, Mar 08, 2022 at 01:01:45PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 8, 2022 at 7:50 AM Chun-Tse Shao <ctshao@google.com> wrote:
> > >
> > > On Mon, Mar 07, 2022 at 10:17:17AM -0800, Nick Desaulniers wrote:
> > > > On Sun, Mar 6, 2022 at 2:39 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > >
> > > > > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > > > > what pkg-config and parameters are used.
> > > >
> > > > Sorry, kind a late thought here for v4, but we don't seem to prefix
> > > > many other host side tools with HOST_, i.e. LEX, YACC, AWK, PERL,
> > > > PYTHON3, etc.  Maybe just having the variable identifier be simply
> > > > PKGCONFIG rather than HOSTPKG_CONFIG then put it at the end of the
> > > > list in the top level Makefile after ZSTD (i.e. the list of host
> > > > tools)?  There's HOST_ prefixes when there's more than one tool
> > > > involved (i.e. host compiler vs target compiler), but I suspect
> > > > there's no such distinction for the existing uses of pkg-config?
> > > >
> > > Thanks for your suggestion, Nick! Yes I think it makes sense with PKGCONFIG
> > > instead of HOSTPKG_CONFIG since there is only one tool involved. I will
> > > work on it and submit a new patch.
> > >
> >
> > Please hold on.
> >
> > I was also wondering what to do with the "HOST" prefix.
> >
> > Libraries are usually arch-dependent.
> > (in other words, pkg-config should return different library paths
> > for $(CC) and $(HOSTCC) )
> >
> > You already understood this, so you added "HOST" prefix.
> >
> >
> > Please let me take time for further discussion.
> > I will come back to this when I get some time.
> >
> >
>
> Hi Mashiro,
>
> I was wondering if you were able to look more into this.
>
> Thank you!
>
> -CT
>
> > In the meantime,
> >   a8a5cd8b472ca20e5b8fa649c43b3756867322f8
> > as reference info if you have not seen it.
> >
> >
> > How many distros support something like
> > "aarch64-linux-gnu-pkg-config"  ?
> >
> > Ubuntu 18.04 and 20.04 seem to support it.
> > I do not know for others.
> >
> >
> >
> >



Sorry for the delay.
I am OK with the idea of allowing users to override the pkg-config command,
but I tend to take time before making a decision.




Does anybody have any insight / thoughts about the following points?






[Q1]   with/without "HOST" prefix


Apparently, "pkg-config" should return different libs/cflags
for $(CC) and $(HOSTCC).

I think the non-prefixed macro name "PKG_CONFIG" should be
reserved for $(CC)  (building for the target system).

"HOSTPKG_CONFIG" looks unbalanced
due to the underscore.

Perhaps, "HOST_PKG_CONFIG" might be better?




[Q2]    "pkg-config" vs "pkgconf"

The traditional pkg-config implementation [1] is not actively
maintained these days.
The last commit was more than one year ago.

The alternative one 'pkgconf' [2] is more active.

In fact, Fedora already switched to 'pkgconf' [3].
Now 'pkg-config' is just a wrapper of 'pkgconf'.
Many distributions already support pkgconf.


I considered the shorter macro name "HOSTPKGCONF" and

   HOSTPKGCONF  = pkgconf

but I am not sure if this is the right decision.
Maybe we should stick to "PKG_CONFIG" / "HOST_PKG_CONFIG"
for the macro names.


  [1]  https://gitlab.freedesktop.org/pkg-config/pkg-config.git
  [2]  https://github.com/pkgconf/pkgconf.git
  [3]  https://fedoraproject.org/wiki/Changes/pkgconf_as_system_pkg-config_implementation





[Q3] What is the trend of handling cross-compile by pkg-config (or pkgconf).


By default, pkg-config returns the libs/cflags for native builds.

For cross builds, the search paths for the *.pc files must be changed
via the "PKG_CONFIG_LIBDIR" environment variable.

To ease this, some distributions provide  <triplet>-pkg-config
(for example,   aarch64-linux-gnu-pkg-config).
This became the nationale for tools/build/feature/Makefile defining:

   PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config

But, this wrapper shell script is not always available.
I do not know how to do it with the LLVM tool suite.
I am not quite sure if this is the global solution.


These days, pkgconf supports another way, .personality file [4]
to specify the .pc search paths for cross builds.

Is it reasonable to use an option to distinguish native / cross builds
and use the same macro   "PKG_CONFIG = pkg-config" everywhere ?


[4] http://manpages.ubuntu.com/manpages/focal/en/man5/pkgconf-personality.5.html
