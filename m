Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BE54E9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377496AbiFPTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346431AbiFPTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:14:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB594B869
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:14:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gl15so4542688ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbV08iBwGfkxmXYoA1VIJvlV2UmK3YzJ41yofRdZyLU=;
        b=dcdkMcHTJVnxoroJQQyOSQ2hvO4JsUyL9A8pgzbQH+EYSDrJYCrkrswzLz3irfA2j7
         efMBNu5K1vFadai8pD+FNsVf+1jorrZW261NR6AFq2WVl/6gy2247A+GRqmGxI/sKIAy
         Edk+iURnurHyyEsKgmgu6hsjFw1Nfh+9lfQlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbV08iBwGfkxmXYoA1VIJvlV2UmK3YzJ41yofRdZyLU=;
        b=TqQl7HC8OZQXOqXxgWCqIroVJFnER4N9D4h5FqGyWA9YyBivr1d6Rzdk+dwhuReOz0
         j8PDodlHSyTpGHEYTsEyBrUTEPO1+LGy2dKZImmtsJ4AUiAhZF7OMYMhVDDqq9yHYup+
         b/hEmKWMhbcCxxFVzilsE3HCd+MQaVZPHKv7OFlZN8Z7HEDd8KosttEOHzV4UyBj7aeK
         SzARI0ldHdhoNAtIKCDcLD2vnyESUO0Fmc0Dw1R1B61mX4IO01SIz85jusHH5mGZfO/l
         W0458+bNTjaypzutcTZ2xo+VFz1F7/n/OyYZRYxQFXjodAxX1DLc3GIOqe3xupNa9L1v
         FM1g==
X-Gm-Message-State: AJIora85MsoGoKjFCMvNfICCN/stHGDmKDok5tB7/GbBDycpooYgS5H+
        XU24LRipnkwZDNIyuqiinu0QGddMPHywiiKv
X-Google-Smtp-Source: AGRyM1sOKP8QezeQqc3KoCmbl7/lpJRzciobZ5mjHOyB+uQDY+XUfoz8MTVs38eIvN1BUxMQcnJBFQ==
X-Received: by 2002:a17:906:c302:b0:6fe:a216:20a4 with SMTP id s2-20020a170906c30200b006fea21620a4mr5920707ejz.556.1655406883603;
        Thu, 16 Jun 2022 12:14:43 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0070d9aad64a1sm1063035eja.208.2022.06.16.12.14.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:14:41 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id n1so2799513wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:14:41 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr3982140wrs.97.1655406881201; Thu, 16 Jun
 2022 12:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org> <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
In-Reply-To: <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 12:14:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
Message-ID: <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
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

On Thu, Jun 16, 2022 at 9:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Out bitmaps and bit fields are also all about "long" - again, entirely
> unrelated to pointers.

That, btw, has probably been a mistake. It's entirely historical. We
would have been better off had our bitmap types been defined in terms
of 32-bit chunks, because now we have the odd situation that 32-bit
and 64-bit architectures get very different sizes for some flag
fields.

It does have a technical reason: it's often better to traverse bitmaps
in maximally sized chunks (ie scanning for bits set or clear), and in
that sense defining bitmaps to always act as arrays of "long" has been
a good thing.

But it then causes pointless problems when people can't really rely on
more than 32 bits for atomic bit operations, and on 64-bit
architectures we unnecessarily use "long" and waste the upper bits.

In some places we then take advantage of that ugly difference (ie "we
have more page flags on 64-bit architectures"), but on the whole it
has probably been more of a pain than the technical gain. The bitmap
scanning is probably not worth it, and could have been done
differently.

And continuing that for some 128-bit architecture is likely just
making the same mistake even worse.

So I think we have a *lot* of things we should look at, if people
really get serious about 128-bit computing.

But I personally think it's several decades away, if ever. Looking at
historical workload growth is probably _very_ misleading - Moore's law
is dying or dead. We're not that many shrinks away from some very
fundamental physical limits.

I do expect people will want to do academic test architectures,
though. It's not clear it's going to be a "double all the widths" kind
of thing, though, and I don't think there is a lot of sense in
designing for a future architecture that is very hazy.

It's not entirely unlikely that we'll end up with a situation where we
do have access to 128-bit operations (because ALU and register width
is relatively "cheap", and it helps some loads - extended precision
arithmetic, crypto, integer vectors), but the address space will be
64-bit (because big pointers are bad for memory and cache use).

In that situation, we'd probably just see "long long" being 128-bit
("I32LP64LL128").

That's obviously what people thought back in the ILP32/LL64 data
model. They were wrong back then, and I may well be wrong now. But
Moore's law limits are fairly undisputable, and a 64-bit address space
is a *lot* bigger than a 32-bit address space was.

So I personally will take a "let's wait for reality to catch up a bit
more" approach, because it's not clear what the actual future will
hold.

                 Linus
