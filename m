Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254895AFE13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiIGHut convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Sep 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIGHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:50:23 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77A7EFD0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:50:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id a67so8651038ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CBvemt91QSwjWpSOvmqvp3ctyqgTCTMhNhU8MmRcjWA=;
        b=BwlilT49Kmi9m3lkYqn9ClUoFV5FeMOc6jWT396Up2Qt0XqYAOTXRKWXV1ingY/Jp2
         vW6lNCeEDvM7SlWrcfiWFmQ34cQhDDXDnueZLp9/chW3ekn+c12EKkh+lfuN3/lG83jC
         9A/rKCX4k1NIw6d+kMIXtx21rd/vt0gUGZAbmSJaa9rAn6ho7G0pxANUAYQ5O0GhRZGy
         Kr//6pii2PlXbdFoAAycTH0Uw1izTvaViBYdOfY+pUjeEqWLXj7tSJGe8Pu02qSuc7Hr
         DAMTRQRCEV34q7a9viyv+XHPkul3scrSRjr/X9iRrFE1JJVy2q7B/R3On7KLZEwSu0p0
         HX8Q==
X-Gm-Message-State: ACgBeo19Eb1pZYeViy6ZbKrVx9IFJTs3WMZNNX4p5/i9JAVgZuZH0oQw
        U7+DttswuT7PdiKz2fqIaMcOuwCPaL5KphTmGUI=
X-Google-Smtp-Source: AA6agR4aARSM5i/xWu7bbxL/mjmN7rxXVksnsFxFXvu8DW8Olq1Vwb1jbBuDUDtUM9KzGJmKuCwfwEomKrICNikDIVg=
X-Received: by 2002:a25:3b17:0:b0:6a9:1d5f:4573 with SMTP id
 i23-20020a253b17000000b006a91d5f4573mr1834315yba.423.1662537006417; Wed, 07
 Sep 2022 00:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220905003732.752-1-mailhol.vincent@wanadoo.fr> <CAKwvOdnr_F9-voPj4cp2HG8=U32a8Hp1aLpynSQiKOrwe4txpQ@mail.gmail.com>
 <CAKwvOd=PgVtCwjS=Z_iqqmWsQ=+HsnEnHX2LOjRPCYFoVhAZhA@mail.gmail.com>
In-Reply-To: <CAKwvOd=PgVtCwjS=Z_iqqmWsQ=+HsnEnHX2LOjRPCYFoVhAZhA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 7 Sep 2022 16:49:55 +0900
Message-ID: <CAMZ6RqLH3MdcRdxDFFmy_gbepJ-tU-mqFxBg+jS8=niR4xu71A@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 7 Sep. 2022 at 16:04, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Tue, Sep 6, 2022 at 11:26 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, Sep 4, 2022 at 5:38 PM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > The compilers provide some builtin expression equivalent to the ffs(),
> > > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > > assembly which produces better code than the builtin
> > > functions. However, such assembly code can not be folded when used
> > > with constant expressions.
> >
> > Another tact which may help additional sources other than just the
> > Linux kernel; it seems that compilers should be able to fold this.

Initially, I thought that you were suggesting folding the asm code
(which doesn’t seem trivial at all).

> > Vincent, if you're interested in making such an optimization in LLVM,
> > we'd welcome the contribution, and I'd be happy to show you where to
> > make such changes within LLVM; please let me know off thread.
>
> Oh right, it already does.
> https://github.com/llvm/llvm-project/blob/ea953b9d9a65c202985a79f1f95da115829baef6/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp#L2635
> I see what's happening. Constant propagation sinks constants into a
> specialized version of ffs when there's only 1 callsite in a given
> translation unit (or multiple call sites with the same constant).
> Then dead argument elimination removes the argument, so libcall
> optimization thinks this isn't the ffs(int) you're looking for, and
> skips it.

Isn’t it a wise decision to skip it? How should the optimization be
able to decide that the redefined ffs() is equivalent to
__builtin_ffs()?

More generally, if I write my own foo() which shadows a
__builtin_foo() function, the two functions might do something totally
different and I would be pissed off if the compiler decided to
constant-fold my foo().

Dummy example:

===================
char *s;

/* ffs: fast forward string
 * @i: how many bytes to move forward
 *
 * Move forward the global s pointer by @i or strlen(s) (whoever is smaller).
 *
 * Return: how many bytes we move forward.
 */
int ffs(int i)
{
        int len = strlen(s);
        int forward = i < len ? i : len;

        s += forward;
        return forward;
}
===================

How would you instruct the compiler to constant-fold the kernel’s
ffs() but not fold above dummy ffs()?

> Nice.
> https://github.com/llvm/llvm-project/issues/57599
> I guess ffs() is usually forward declared in strings.h, so we don't
> have such a static inline definition available to constant
> prop/specialize in normal C code.
