Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12B4D0E87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbiCHEDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiCHEDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:03:49 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D027FC5;
        Mon,  7 Mar 2022 20:02:50 -0800 (PST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 22842Rds024398;
        Tue, 8 Mar 2022 13:02:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 22842Rds024398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646712148;
        bh=uBfYQrw/aKlUHSJekd9nzEyMA5sjTFPIWvon8fzfgpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ohmFDh8uj4UCr9MeXOi/FzG5ezygIwWd1JY3tHOsySvUk2iMyynmjA4bTuEr4wPNL
         BQKqUCjyFEvRjreHFeIgHTjrz5V0nSWSlgKQDTtcM9lww5m+OY/2WOhY7Pkrv+mH/r
         iubT2gZa7yKRGtDX3k81OD8cMgakna/t/OIxLi56EHJfBF26ap0QXtB0SY6RYpaJ0w
         Ry0dVcv3NyYgTlcgLo7LQ5Vi4AMgsv1lzNTWzm3xEJjqbpB3ypCr39Hqvpuy9tKTbH
         WkCNAK1hsEsfIHNdn9Rh0MODVa5XG6l5d9QPHmIXdAYyyIbkeOq0hAlX1jOTvOE68I
         V5UN4N21wXgXg==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id e2so15924518pls.10;
        Mon, 07 Mar 2022 20:02:27 -0800 (PST)
X-Gm-Message-State: AOAM533YodHMDykUJKTXr0pZ0LBhVbLG/Lo7lOsrwY/DDxGdKKHdDput
        9tXU3kkoAhhFF9jjlmwzf1qsbFqYgXj9JVbhkps=
X-Google-Smtp-Source: ABdhPJxzVN2Su0RqJQcS7ZnoB3cYr/+k5uAZTqDNUvBHp6k9gsvzGxk2MXuefHuaR9L7IRwDUfiRndk0XeRRvHgurPo=
X-Received: by 2002:a17:90a:ab17:b0:1b9:b61a:aadb with SMTP id
 m23-20020a17090aab1700b001b9b61aaadbmr2555486pjq.77.1646712147134; Mon, 07
 Mar 2022 20:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20220306223016.2239094-1-ctshao@google.com> <CAKwvOdnmtRYnSx3VvG=PEnzpzWa8f=0bn1xDymjER5EShS2tmw@mail.gmail.com>
 <YiaMJCHOOuujHwiK@google.com>
In-Reply-To: <YiaMJCHOOuujHwiK@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Mar 2022 13:01:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
Message-ID: <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 7:50 AM Chun-Tse Shao <ctshao@google.com> wrote:
>
> On Mon, Mar 07, 2022 at 10:17:17AM -0800, Nick Desaulniers wrote:
> > On Sun, Mar 6, 2022 at 2:39 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > >
> > > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > > what pkg-config and parameters are used.
> >
> > Sorry, kind a late thought here for v4, but we don't seem to prefix
> > many other host side tools with HOST_, i.e. LEX, YACC, AWK, PERL,
> > PYTHON3, etc.  Maybe just having the variable identifier be simply
> > PKGCONFIG rather than HOSTPKG_CONFIG then put it at the end of the
> > list in the top level Makefile after ZSTD (i.e. the list of host
> > tools)?  There's HOST_ prefixes when there's more than one tool
> > involved (i.e. host compiler vs target compiler), but I suspect
> > there's no such distinction for the existing uses of pkg-config?
> >
> Thanks for your suggestion, Nick! Yes I think it makes sense with PKGCONFIG
> instead of HOSTPKG_CONFIG since there is only one tool involved. I will
> work on it and submit a new patch.
>

Please hold on.

I was also wondering what to do with the "HOST" prefix.

Libraries are usually arch-dependent.
(in other words, pkg-config should return different library paths
for $(CC) and $(HOSTCC) )

You already understood this, so you added "HOST" prefix.


Please let me take time for further discussion.
I will come back to this when I get some time.


In the meantime,
  a8a5cd8b472ca20e5b8fa649c43b3756867322f8
as reference info if you have not seen it.


How many distros support something like
"aarch64-linux-gnu-pkg-config"  ?

Ubuntu 18.04 and 20.04 seem to support it.
I do not know for others.





--
Best Regards

Masahiro Yamada
