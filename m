Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A10524132
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349474AbiEKXsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349468AbiEKXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:48:50 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE506D94B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:48:49 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id i38so6787487ybj.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx909cyDSz1kOHBajJFffqLizYo8FoW6mi/SsXv4eI8=;
        b=5HBX81ARLl1JQyEuibxDY1L+9ag8C191xh5Hfk2PolkC8ynt7vzU230cvn1+rRrqfb
         kZnDXGTnmKYz4I2GdVKQFygN35ozFrxQ8YgS4MqiOnrc+NVSe9Pi+vj+iP4VH0UyIfub
         z3JAGuY6rwuZYYFOHUxS6NeMNCxUVDRfACJ4ugla8DqBd4hKA6JSm/wFjDgXEfiIrMmj
         3nsZe+RYm/mJeJJvhB/vd5VkvCtyEgFVpBDRQS2IOVkDgLdrMruOP7kHd2LclOpOk2Ae
         3U6AvbS8Q0a6gN3nRX8NZGfNyDC44dQ4ZdSJL3S6vxUTrOiNLpaUsoUCMAN+R9tOaf6X
         7f9w==
X-Gm-Message-State: AOAM533I+3DJY4B3RLGxdqHZtjsAmYLNpnY5VRmQVXyLLxwfy5IwudmW
        gDHLH4xp7sGx22RoFSbEu+MOIaSTUhAful0YBpk=
X-Google-Smtp-Source: ABdhPJwhjev8MxEiGT4pCSdx09sa2oBOZQ3xaqEP2HwK5AwmnzmPp6GdMVyoTNBwJsQijA5by8ol+xmQ7dnBzi488+E=
X-Received: by 2002:a25:6906:0:b0:64a:8266:cedd with SMTP id
 e6-20020a256906000000b0064a8266ceddmr24520607ybc.151.1652312929069; Wed, 11
 May 2022 16:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220511160319.1045812-2-mailhol.vincent@wanadoo.fr> <CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com>
In-Reply-To: <CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 12 May 2022 08:48:37 +0900
Message-ID: <CAMZ6RqL-CPzvmbUvgp4W+nATvCu8c=6xe9j4+ALP7=nt2h+dMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate
 constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 12 May 2022 at 06:35, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Wed, May 11, 2022 at 9:03 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > For x86_64, the current ffs() implementation does not produce
> > optimized code when called with a constant expression. On the
> > contrary, the __builtin_ffs() function of both GCC and clang is able
> > to simplify the expression into a single instruction.
> >
> > * Example *
> >
> > Let's consider two dummy functions foo() and bar() as below:
> >
> > | #include <linux/bitops.h>
> > | #define CONST 0x01000000
> > |
> > | unsigned int foo(void)
> > | {
> > |       return ffs(CONST);
> > | }
> > |
> > | unsigned int bar(void)
> > | {
> > |       return __builtin_ffs(CONST);
> > | }
> >
> > GCC would produce below assembly code:
>
> Thanks for the patch! LGTM.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > | 0000000000000000 <foo>:
> > |    0: ba 00 00 00 01          mov    $0x1000000,%edx
> > |    5: b8 ff ff ff ff          mov    $0xffffffff,%eax
> > |    a: 0f bc c2                bsf    %edx,%eax
> > |    d: 83 c0 01                add    $0x1,%eax
> > |   10: c3                      ret
>
> This should be the end of foo.  I...actually don't know what's at the
> end here. But I don't think the region from here...
>
> > |   11: 66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
> > |   18: 00 00 00 00
> > |   1c: 0f 1f 40 00             nopl   0x0(%rax)
>
> ...to here is relevant.

I do not know either. I was hesitating to redact this part but finally
sent it to be verbatim.

I will redact this in v3.

> > |
> > | 0000000000000020 <bar>:
> > |   20: b8 19 00 00 00          mov    $0x19,%eax
> > |   25: c3                      ret
> >
> > And clang would produce:
> >
> > | 0000000000000000 <foo>:
> > |    0: b8 ff ff ff ff          mov    $0xffffffff,%eax
> > |    5: 0f bc 05 00 00 00 00    bsf    0x0(%rip),%eax        # c <foo+0xc>
> > |    c: 83 c0 01                add    $0x1,%eax
> > |    f: c3                      ret
>
> Weird, so I just tried this:
> ```
> $ cat /tmp/x.c
> #define CONST 0x01000000
>
> unsigned ffs (int x) {
>   int r;
>   asm("bsfl %1,%0"
>       : "=r" (r)
>       : "rm" (x), "0" (-1));
>   return r;
> }
>
> unsigned int foo(void) {
>   return ffs(CONST);
> }
>
> unsigned int bar(void) {
>   return __builtin_ffs(CONST);
> }
> $ clang /tmp/x.c -O2 -o /tmp/x.o -c && llvm-objdump -dr /tmp/x.o
> --disassemble-symbols=foo
> ...
> 0000000000000010 <foo>:
>       10: b8 19 00 00 00                movl    $25, %eax
>       15: c3                            retq
>       16: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:(%rax,%rax)
> ```
> but if we make `ffs` `static`, we get:
> ```
> 0000000000000000 <foo>:
>        0: b8 ff ff ff ff                movl    $4294967295, %eax
>  # imm = 0xFFFFFFFF
>        5: 0f bc 05 00 00 00 00          bsfl    (%rip), %eax
>  # 0xc <foo+0xc>
>                 0000000000000008:  R_X86_64_PC32        .LCPI0_0-0x4
>        c: c3                            retq
>        d: 0f 1f 00                      nopl    (%rax)
> ```
> Which is very interesting to me; it looks like constant propagation
> actually hurt optimization, we lost that this was a libcall which we
> could have optimized.
>
> As in LLVM does:
> 1. sink CONST into ffs; it's static and has one caller
> 2. delete x parameter; it's unused
> 3. now libcall optimization just sees a call to ffs with no params,
> that doesn't match the signature of libc.
>
> Your change should fix that since we don't even call a function named
> ffs if we have a constant (explicitly, or via optimization). Filed
> https://github.com/llvm/llvm-project/issues/55394

Great! Didn't realize my patch had so many side benefits.
Will add a one sentence remark in v3 and point to your message.

Thanks!
