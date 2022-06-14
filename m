Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9226454B795
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiFNRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbiFNRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:24:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB92F652
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:24:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gl15so18527714ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/6xhGEka14EhmNYBcjokvD2zSqU3Xwlx7Q9rhofiz0=;
        b=KnokTr992DXuOPS9Teep5EV6LW2xDhhGlitnPajQjqYUHFihcTkQXxqebZCWkGCMTL
         HZvj1Ok0uXUs/QU7KNonnZ/nTQttgau2SlssY5QSXVbrsJ4vJ4t7N1K+ZAIFEJfes3Nl
         ac9lonEf2uNNKttQnZstFggHmZUpkly+8pjj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/6xhGEka14EhmNYBcjokvD2zSqU3Xwlx7Q9rhofiz0=;
        b=VpCYh9LFV5RlsktrmLiRH8SAHEhEuobWzPaz1Cswxa2fp9FSfUH7p5LxCgbSBSw1Yl
         cVHcLJZ8dEAiGCQ/WN6LHI5Qe3IJpqPrztVeBaXEH6JnS79wh1pYpzBcSzxi/pRDXSu0
         7uw4TE6owaSq3jB7Xqn6M3Lwf06EFiqsN7zW6ftru2AbDOJ9zrdwbR+eqIRpdaHjQtE3
         Dk8Ig/H+O1sWH38YLFDkSEShrjEMP7hJWEHDn91o+IguY0rMKgE0HSkD2pkZdH7RlPbK
         LihdhXuhh/yWwui9vrQ8igiqIVJy/ad1dUe/U14F5bxiapz/druV7IZU8qo7JJL1LcuP
         qAZg==
X-Gm-Message-State: AOAM5317jdVLN27ciCBvgkuqeMt9CoefhOVuBeHO+x2H2HRTqSxazxNC
        djW6mJEcsygtHsA9VMTxPdhRH7YuQS/qQmck
X-Google-Smtp-Source: AGRyM1uOhUaVPQJ8Soet1Bx5arCG51QRsXSg49oJeWu/LQXIDrbkxVtmzfHJfINmSKvqLP5/P/IEog==
X-Received: by 2002:a17:907:8a08:b0:711:d26d:71d with SMTP id sc8-20020a1709078a0800b00711d26d071dmr5370102ejc.622.1655227471799;
        Tue, 14 Jun 2022 10:24:31 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id e3-20020a50fb83000000b0042e309906desm7323356edq.58.2022.06.14.10.24.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:24:31 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id w17so4678480wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:24:31 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr5727466wrq.97.1655227470894; Tue, 14
 Jun 2022 10:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAKwvOd=SotrVcZshzGzsMprkORkVXFwYc-3mREkJSDCQ1nvbFw@mail.gmail.com>
In-Reply-To: <CAKwvOd=SotrVcZshzGzsMprkORkVXFwYc-3mREkJSDCQ1nvbFw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jun 2022 10:24:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmezfDP_b93_Hw090vUd-TKb-odZNPhB9L_2vL5pn6kQ@mail.gmail.com>
Message-ID: <CAHk-=wgmezfDP_b93_Hw090vUd-TKb-odZNPhB9L_2vL5pn6kQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:11 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Maybe a new function parameter attribute would be nice?

Right, exactly something like this seems reasonable.

> #define __must_init __attribute__((must_init))
> int init (int * __must_init x) {
> // ^ warning: function parameter x marked '__attribute__((must_init))'
> not unconditionally initialized
>   if (stars_dont_align) {
>     return -42;
>   }
>   *x = 42;
>   return 0;
> }
> void foo (void) {  int x; init(&x); /* use of x without fear */ }

Yeah. So for this pattern of uninitialized pass-by-reference
arguments, we'd get the warning in the callee if it's __must_init, and
in the caller if it's not.

Now, I suspect that we have a lot of cases where the initializing
function returns an error, and we currently don't initialize the
pass-by-ref argument in that case.

In a perfect world, we'd have some way to annotate that case too, but
I suspect it gets too complicated both for users and for the compiler.

Error handling in C is ugly, but it's also why we in the kernel have
that ERR_PTR() model that solves the "return *both* an error *and* a
pointer" case. Which is one of the most common cases we have for this
situation.

I suspect that the simple "__must_init" model would work well enough
for us in practice. Yes, it might make us then initialize things
"unnecessarily" in error cases, but that doesn't sound too onerous.

And I think the "__must_init" model makes conceptual sense, in ways
that the "caller has to initialize things even if it is literally
asking another function to initialize the value" model does *not* make
sense.

But hey, I didn't look at just how painful it would really be. This is
all "I _think_ that would work really well for the kernel" without any
actual data to back it up with.

                Linus
