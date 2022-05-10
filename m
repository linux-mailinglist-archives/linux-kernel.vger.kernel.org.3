Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54319521D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbiEJPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiEJPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:06:46 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F931937
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:33:26 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id i11so9018922ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mx7jkXBBdOIkJsGSW9sVzyIselbqrtRZw2WUonRIsCM=;
        b=sT1jp4rCdLtP0oStePP6Vp5MUtS+Y4Tuj3TUHO63hUCsDuH+LIss6UNQP5gafSuuiq
         Qu8lzWWmSNdd7NlzTjhvZT1BBIVP9PcVG4SgL7cv+1paOq0CQDgXDlanFKHwAPtrBKzG
         oE3NNyvrBvMJVmuXvkebo9o8XGfgxO1ltmUsWzdpe+3G96oSvNmFTmeP38TfPQylXgRY
         wvRk9of/sf2JJNYY5TIaMP6RKBsoICO/XQOS1KPWOvTaqsxV9D/u8gahf+Q1cavWINGx
         N+2BsI0EUObt986G3zq5vBSphgAQW8EqnaaYsWe1siGWcsv5CUI9O6x+K5pPrhpGCVrl
         cDCw==
X-Gm-Message-State: AOAM5339N7qnZ30Mcjs1i1WcyGZnJ3FsXA45MPXa+RWh5xsZSfVVc0bN
        nY+luOMfVN0frVHyxC8OenJl+tH6DUrEQYZjtVCRnMv0iERgTw==
X-Google-Smtp-Source: ABdhPJy3Uvp+D2AneUT5l7gTpn9VYrLB+IUai+5w9pwWufj0Ww56cSOPIr2Y94RdD35Oxp6LTgqxmzGrtKOiRNWq+7o=
X-Received: by 2002:a5b:491:0:b0:64a:f42f:6973 with SMTP id
 n17-20020a5b0491000000b0064af42f6973mr6000334ybp.20.1652193205241; Tue, 10
 May 2022 07:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr> <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
 <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
 <YnhXgzhghfi17vMX@dev-arch.thelio-3990X> <CAMZ6RqL7543LFU7ywbr-FV9A3n+m7zNy-J00j=ZrNMkDonq2aw@mail.gmail.com>
 <CAKwvOdniSVMOwkBke2EcgONn_Vmv88M+B2FTYL_BKtWawCSLAw@mail.gmail.com>
 <CAMZ6Rq+q44vAeqa7HN8mfoNXzv9GndnQDm1e4_kyMXf_+oADdQ@mail.gmail.com>
 <CAKwvOdnf5f_eNz0FTiYfUf=TtEqWTZTFNN7UpmH3qCcKQGkkHg@mail.gmail.com> <CAMZ6RqLp86ca6s-dO-Zre=PzOLr6JK9qu-8uAxfMym+X0a19yQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqLp86ca6s-dO-Zre=PzOLr6JK9qu-8uAxfMym+X0a19yQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 10 May 2022 23:33:13 +0900
Message-ID: <CAMZ6RqKZOtHiQB4edYaXMUw7SMTKnvFGcisX0edx1om7NR+g7g@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 10 May 2022 at 10:10, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Tue. 10 May 2022 at 08:26, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Mon, May 9, 2022 at 4:12 PM Vincent MAILHOL
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > Hi Nick,
> > >
> > > On Tue. 10 May 2022 at 04:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > On Mon, May 9, 2022 at 8:01 AM Vincent MAILHOL
> > > > <mailhol.vincent@wanadoo.fr> wrote:
> > > > >
> > > > > Instead, I am thinking of just using -fno-builtin-ffs to remove
> > > > > the annoying -Wshadow warning. Would that make more sense?
> > > >
> > > > Perhaps a pragma would be the best tool to silence this instance of
> > > > -Wshadow?  I understand what GCC is trying to express, but the kernel
> > > > does straddle a weird place between -ffreestanding and a "hosted" env.
> > >
> > > I was a bit reluctant to propose the use of pragma because I received
> > > negative feedback in another patch for using the __diag_ignore()
> > > c.f.:
> > > https://lore.kernel.org/all/YmhZSZWg9YZZLRHA@yury-laptop/
> > >
> > > But the context here is a bit different, I guess. If I receive your support, I
> > > am fully OK to silence this with some #pragma.
> > >
> > > The patch would look as below (I just need to test with clang
> > > before submitting).
> >
> > Do you have a sense for how many other functions trigger -Wshadow?
>
> I only witnessed such -Wshadow warnings for ffs().
>
> > For
> > example, one question I have is:
> > Why does ffs() trigger this, but not any of the functions defined in
> > lib/string.c (or declared in include/linux/string.h) which surely also
> > shadow existing builtins?  I can't see your example being sprinkled
> > all over include/linux/string.h as being ok.
>
> Thanks, you are touching on a really interesting point.
>
> After checking, the other builtin functions declare the function with
> two leading underscores (e.g. __foo(...)) and then do:
>
> #define foo(...) __foo(...)
>
> Or alternatively, if using the builtin function:
>
> #define foo(...) __builtin_foo(...)
>
> Compilers do not trigger the -Wshadow for such patterns.
>
> Example with memcpy():
> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/string_64.h#L75
>
> So, in light of your comment doing this would be more consistent:
>
> #define ffs(x) _ffs(x)

I created this patch:
https://lore.kernel.org/all/20220510142550.1686866-1-mailhol.vincent@wanadoo.fr/T/#m55da229f67d2c84470a55df32e71d8600c581024

This solves the -Wshadow and also adds some optimizations for when
ffs() is called with constant variables.


Yours sincerely,
Vincent Mailhol
