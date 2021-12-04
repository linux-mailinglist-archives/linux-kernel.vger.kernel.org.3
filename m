Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597754686D4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbhLDR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:58:31 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51281 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhLDR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:58:30 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 1B4HshGU007696;
        Sun, 5 Dec 2021 02:54:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1B4HshGU007696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638640483;
        bh=o7GC++yWEN8HKw/ffwwt/qH7JU8tT43ItqFd1nlqzaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G3v/omwpp4pdyk7EKkF+id7J+gxgDwZiQuU7HjuxxFr2JoOfWx+FfY77Snfd63izu
         /+Yyu8RwrucpQpOGLBFDYqIwoPkn7I7Aos/U4HgVtMsbbXgHcDw7LaTJ+NNe1aUv1k
         QAlHOwzNhiG5aK8efn7oEjuT3X75p91gk7+63uTEF4r3cDNng2gJKydoSebO/3okch
         wYmZa3YtLezN3Oqe1qVXHYMzrOqCmwuO6/7fGHHi0rqwMyX9SsIifRvcJA2UhRMsqY
         hm/ZvjbdevU60cKkmsNF7LJzUVHdI0FNXpYtYM/j1kJgDNughNYyqlvryUtg6mngvR
         cGk61H12NCBTg==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id p18so4289053plf.13;
        Sat, 04 Dec 2021 09:54:43 -0800 (PST)
X-Gm-Message-State: AOAM530liP/fMW07HxKyzKg0vo2NS4VjKJ9gZvt7lrNxNLL4u+HuoOAw
        q9bq67iTbYqmVgeY6REoAchJojBoRceOyrFvTc8=
X-Google-Smtp-Source: ABdhPJwfKs42p3AOfZfEkP0pTRjVHs3s5xdm6UxjRzm3FL2xZi7jhXNLcTuKy9+bHP051pmQ3nDmoWVppgKxFiWdcPU=
X-Received: by 2002:a17:90a:fb43:: with SMTP id iq3mr11480514pjb.144.1638640482675;
 Sat, 04 Dec 2021 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <YatpectAYsWnmPy2@eldamar.lan> <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
In-Reply-To: <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Dec 2021 02:54:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com>
Message-ID: <CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com>
Subject: Re: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to gcc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 1:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Dec 4, 2021 at 5:13 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> >
> > Andreas suggested to replace the
> >
> > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> >
> > with
> >
> > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))
>
> Ugh. I think the external build environment is a bit broken, but
> whatever. The above is ugly but I guess it works.
>
> Another alternative would be to make the Kconfig strings simply not
> have '"' as part of them.
>
> When you do
>
>     a = "hello"
>     print $a
>
> in any normal language, you generally wouldn't expect it to print the
> quotes, it should just print the bare word.
>
> But that's what the Kconfig string language basically does in this
> case. And I guess several users expect and take advantage of that ;(
>
> Masahiro? Comments?

Yes, you get to the point.

In fact, this is in my TODO list for a while
(and this is the reason I was doing prerequisite Kconfig refactoring
in the previous development cycle).
I will try to find some spare time to complete this work.



Kconfig generates two similar files,

 -   .config
 -   include/config/auto.conf

Changing the format of the .config is presumably problematic
since it is the saved user configuration as well.

It is possible (and more reasonable) to change include/config/auto.conf
so strings are not quoted.

In Makefiles, quotations are just normal characters; they have no
special functionality.

So, in Makefile context, it is more handy to do

     CONFIG_X=foo bar

instead of

    CONFIG_X="foo bar"



One problem is include/config/auto.conf is included not only by Makefiles
but also by shell scripts.


In shell context, the right hand side must be quoted
in case the value contains spaces.

   CONFIG_X="foo bar"



My plan is to fix
  scripts/link-vmlinux.sh
  scripts/gen_autoksyms.sh
etc. to not directly include the auto.conf.
Later, change Kconfig to generate the auto.conf without "".



In the meantime,

KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst
"%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))

 or if you prefer slightly shorter form,

KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)

will be a workaround.





>
>              Linus



-- 
Best Regards
Masahiro Yamada
