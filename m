Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826CE590996
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiHLAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 20:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiHLAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 20:33:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE45A1A45;
        Thu, 11 Aug 2022 17:33:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j3so13707341ljo.0;
        Thu, 11 Aug 2022 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IrNePwAmUbPGIxoMdJKUK7HaguAbEt3pXuMHsN2hXg0=;
        b=UBr9TSUUVT9jOEfJ2YbX6mdjLPRiIoioYTumb/RNoQwPzwZP7fb68npj4dXCzEL0id
         jTOLKa3WY30/r/BeGjDqWeuaSnbZjAB3tJiPp4ekhASOoid8vBrhvFbXl2X9HPb9gjXW
         KXjqiV9oxAVT4/BDEeLFkQeu0vyanJptfcx64uEVotOQ2XMcS1UeJNIsPMDOJrl1noh6
         iiqlDJCFtpGiULIq2nrJKhztM3VGsiWKk67UNiPz0+EXsgxz4+iUJiiiuT4LV1jHBOTb
         MoRVVd1CxDWKI5ilkCOt93lqm6ZkmHYVDRDe+bQ23SVzVHaSLO2JAeUY8onotHdt2d5O
         7DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IrNePwAmUbPGIxoMdJKUK7HaguAbEt3pXuMHsN2hXg0=;
        b=AB/a0jGzVg1NWX/3CgkozCx/EFAuJBMuyPbtbNCyoXw9mWR80bcZdL5YrXODgFGi6n
         JNxILTop6zMzbYRxCKJixfD83s6jBGiYOO7RcQj47CphYPdXQVNrCacZIkNUemk8t6mf
         3VQWFUt48dC4YD5vSAnvhZ88oBUiyi6r33Bs31p41fySncC7dE02joRLErdXA/SMbUr6
         lgzFEVzgGVBRSbWCN/8wJnCa4oTULNZ5qUcMiT9QxfjePLFwnPrPAmzCNLKvVQf8mCKQ
         PpR0zI4IV+5J5j/wHCy7CETO6Kxeso3io6ZwiC83syqdQT7MexFxz7+8cAWgRd8bb54J
         170g==
X-Gm-Message-State: ACgBeo0VFYWdZEs/EqtC151rft5Z1MKkV5itua4YntHtiqtgIK+SD4o6
        1OvN5Xt50tH7UYsB3AupMhTIgQcff4CK9EdpggE=
X-Google-Smtp-Source: AA6agR4yLToWIg9wIetfbbKCrmly99qf772m+ExTXPKWFk8eRFrAL7k8/Wg+aRK92UTDPp57lKL4zR96JZua+SPrhy0=
X-Received: by 2002:a2e:b88f:0:b0:25f:efa1:a966 with SMTP id
 r15-20020a2eb88f000000b0025fefa1a966mr434505ljp.67.1660264420743; Thu, 11 Aug
 2022 17:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220804223504.4739-1-dmitrii.bundin.a@gmail.com> <20220811145828.89b64e663a18fbb8d7fdea06@linux-foundation.org>
In-Reply-To: <20220811145828.89b64e663a18fbb8d7fdea06@linux-foundation.org>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Fri, 12 Aug 2022 03:33:29 +0300
Message-ID: <CANXV_XwZBov-QHxcbFqt9y4dwQyZ_umjzZep=RbZmE8RRz9Bag@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add option to set max level of debug info
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, nathan@kernel.org, peterz@infradead.org,
        keescook@chromium.org, jpoimboe@kernel.org,
        dan.j.williams@intel.com, isabbasso@riseup.net,
        edumazet@google.com, vbabka@suse.cz, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In other words, can we make this a Kconfig-selectable level, with the
> default `1'?

Thanks for pointing this out.

Here is a little note from my side. According to the GCC documentation
the default level is 2. So I would propose to set the default Kconfig
option value to 2 as well to not change the build behavior.

Does this sound reasonable?

Regards,
Dmitrii
On Fri, Aug 12, 2022 at 12:58 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri,  5 Aug 2022 01:35:04 +0300 Dmitrii Bundin <dmitrii.bundin.a@gmail.com> wrote:
>
> > When compiling with -g3 option and debugging with gdb it provides some
> > extra abilities like macro expand, info macro etc... It's sometimes
> > useful to unerstand behavior of complicated macros.
> >
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -304,6 +304,15 @@ config DEBUG_INFO_REDUCED
> >         DEBUG_INFO build and compile times are reduced too.
> >         Only works with newer gcc versions.
> >
> > +config DEBUG_INFO_MAXLEVEL
> > +     bool "Maximum debug information level"
> > +     depends on !DEBUG_INFO_REDUCED
> > +     default n
> > +     help
> > +       Sets the maximum level of debug information compilers may generate
> > +       (-g3). Enabling this option will require significantly more disk space
> > +       and increase built time, but it's useful for debugging purposes.
> > +
> >  config DEBUG_INFO_COMPRESSED
> >       bool "Compressed debugging information"
> >       depends on $(cc-option,-gz=zlib)
> > diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> > index 9f39b0130551..7e1d8beecfc4 100644
> > --- a/scripts/Makefile.debug
> > +++ b/scripts/Makefile.debug
> > @@ -2,6 +2,8 @@ DEBUG_CFLAGS  :=
> >
> >  ifdef CONFIG_DEBUG_INFO_SPLIT
> >  DEBUG_CFLAGS += -gsplit-dwarf
> > +else ifdef CONFIG_DEBUG_INFO_MAXLEVEL
> > +DEBUG_CFLAGS += -g3
> >  else
> >  DEBUG_CFLAGS += -g
> >  endif
>
> What happens when the gcc developers add -g4?  Or if a user wants -g2?
>
> In other words, can we make this a Kconfig-selectable level, with the
> default `1'?
