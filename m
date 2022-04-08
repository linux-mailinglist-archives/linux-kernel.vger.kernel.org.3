Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF84F9E18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiDHUSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiDHUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:18:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD83852D5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:16:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a30so12820191ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hi6N/3Gfly/aeQxX3MNYeA6tcKASZ5qO4cZ7KqJIS/I=;
        b=V0ukmsZGOjGOJiK2b7BnIWsCcnQz90DZY0k0Ghi1mnlZjFg4vYu+WVtOBKplk0aPNb
         xSGPQdBQhqDhDebvMNWrLmYSy5rpw3uCbI5QPDvDX6Kow7dr5eZIKOjXuM7UbjVGt0Zx
         S2Zw9t/zTMIieUJbua+eXbgDDgUvbjFuvCWzHSdSLGQTZq8lwr1unU2LghD0WiCIDEnI
         rJE0PEDvgKb597saf9fl2Xaws1w8ty1pn1TNAPpD0e7tYwekQWJy3BhEwXX+KpOqonaz
         dlsyTLjJFzKuzHKY5eCC7Q6KTahmxRskQHmglGk/DuHMe2vlLsvZpXe0eb5vq74jj6W4
         ZhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi6N/3Gfly/aeQxX3MNYeA6tcKASZ5qO4cZ7KqJIS/I=;
        b=qvsX6UusFeBXXdxOAg+/3gMxLxRlSflViUGZhPQXI5I6A1aCXCjLZcLFOk8NL09uhb
         hlj/oxKjRG9yVgWhROZtyFYgCR12ljWW3JF3a1ZSMMBXYHr/KqANHxxWmOIMWENe4rWn
         Mn4tGuscIjlzub5b++FVdGnCD2a+V/RKFTvfI7vkQ3PoDOrBNYeDjA47k5n83fJUvLFO
         MVtTt9IF0uyB0At+rzbFbvHMWljP3dN3zymO6+fkgvi+TSA+bDg4FF/TbLML+cmKgMKu
         gmuTwMDYvNLqXvA3j0DetbCQZzVDC/1nIjTCaQ3/pHqcHNZA1TtNaatw1G0lVu8ydbVc
         wTSQ==
X-Gm-Message-State: AOAM531p0B6GMC+jNKOg/PMEWRfiVQK9KwFW25TieoN+ESlzLLwaAPaU
        JJghKTISe/DOOtcZGlbMnLBq+67BU1tT0Kfm5wj7ow==
X-Google-Smtp-Source: ABdhPJxXE2J6V1LtwHStnWObudn7sZJkA3RyGvTh47b5fBJtNaOCCD2wLzJjsH7fCMEEf13m5ow672e7a9MeMnNyfTQ=
X-Received: by 2002:a05:651c:555:b0:24b:15b7:74ad with SMTP id
 q21-20020a05651c055500b0024b15b774admr12420671ljp.239.1649449006497; Fri, 08
 Apr 2022 13:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
 <YlCJm8iQBPSOWIT5@hirez.programming.kicks-ass.net> <CAKwvOd=2xeZOg+0HosLPgCegKZxe7F-Cprw0MjOiWf2q=AbNDQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=2xeZOg+0HosLPgCegKZxe7F-Cprw0MjOiWf2q=AbNDQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Apr 2022 13:16:35 -0700
Message-ID: <CAKwvOdkKx2vjJc5zxBicYSvSgKKFdpd_HsS-2k9Vwfpni_WNvA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
To:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 1:08 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Lore thread start for newly cc'ed ML readers:
> https://lore.kernel.org/lkml/7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com/
>
> On Fri, Apr 8, 2022 at 12:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > This weird option is having us upgrade quite a few 'inline' to
> > '__always_inline'.
>
> As is, the assumption that __init functions only call other __init
> functions or __always_inline is a brittle house of cards that leads to
> a "what color is your function" [0] scenario, and leads to code that
> happens to not emit warnings for compiler X (or compiler X version Y).
> There's also curious exceptions in modpost that look like memory leaks
> to me.

These assumptions perhaps made more sense in a world prior to
commit 889b3c1245de ("compiler: remove CONFIG_OPTIMIZE_INLINING entirely")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=889b3c1245de48ed0cacf7aebb25c489d3e4a3e9

(I view 889b3c1245de favorably; perhaps this whole thread is just
fallout from that change though.  It's also interesting to note that
CONFIG_OPTIMIZE_INLINING was enabled in the i386 and x86_64
defconfigs. That might color some folk's experience with the use of
`inline` in the kernel sources and whether "inline means
__attribute__((always_inline))").
-- 
Thanks,
~Nick Desaulniers
