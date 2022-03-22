Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA54E4602
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiCVSbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiCVSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:31:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FD8BE18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:29:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h11so25167547ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7fGS2THKosBu353nmhFTYnuK74oZhJix6ssyL7knBQ=;
        b=Q/ZAdDUNaeSeKURz7X4B2cBhM6bNXJWO2xu3e29wki3/WuCjnbZ82m1VywcC7gHSKD
         H9PkeROEneN6EmxZABVo727EtN9zLqdiAke3RVkes/bdmZ76eQ4mDBg23CtRHP7GBYTG
         20z98gmaXsaOS7HD7PH1Wzt9H+PEEaXY+7i5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7fGS2THKosBu353nmhFTYnuK74oZhJix6ssyL7knBQ=;
        b=Ey48LdqGOVu1UtTg2kL9NdcTOZK5lJr/8KNn2Q4IPsCdQF4dH/5Zir/Iu7Lda39f1L
         g9kl0Uy8EIg+hmtQ0boLg4WJUk6nIEAnQJHkZupGlCu/yAws5Gkh/ykCiu4J/FyhOjjn
         em/2h8ibXDSZ5PI84iPPvuzGwx0OFfwgHZYsKAwNg5eMTYrgNGKacVj02aosXuwrHUSj
         D3UHzJe5427rn9iLZxZpAxjctgpXt0jaYduF7v/kOqXD3yO4WQ/nYropK2rHMZp17Zt8
         9pkfJ5bcixDufP5+hx4izIGxCKaWEApaN9GtSKziKK1+05opLSw+D3+9CYKNAGvIKj58
         BDhA==
X-Gm-Message-State: AOAM533xGUpNKBbngUTFtqjvAVh62xJtJu3VhQcB5ebVX6XAkhteIRGB
        gziX9eTYBK6+dvuDidVQaH9QZvx7I6gv3tbU218=
X-Google-Smtp-Source: ABdhPJyMfr62sfxSNPI3JzAOnDYMSiF62iW7WHw5zk1+j8hfufaR3uX58EWAp8ADcCwZaZiwRhKYLg==
X-Received: by 2002:a05:651c:1404:b0:244:32ad:42e8 with SMTP id u4-20020a05651c140400b0024432ad42e8mr19769502lje.7.1647973778691;
        Tue, 22 Mar 2022 11:29:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id c4-20020a19e344000000b0044846bce74esm2265709lfk.283.2022.03.22.11.29.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:29:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id bn33so25155427ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:29:38 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr20248728lji.291.1647973777786; Tue, 22
 Mar 2022 11:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com> <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <YjoTJFRook+rGyDI@zx2c4.com>
In-Reply-To: <YjoTJFRook+rGyDI@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 11:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com>
Message-ID: <CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Tue, Mar 22, 2022 at 11:19 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The first point is why we had to revert this patch. But the second one
> is actually a bit dangerous: you might write in a perfectly good seed to
> /dev/urandom, but what you read out for the subsequent seed may be
> complete deterministic crap. This is because the call to write_pool()
> goes right into the input pool and doesn't touch any of the "fast init"
> stuff, where we immediately mutate the crng key during early boot.

Christ, how I hate the crazy "no entropy means that we can't use it".

It's a disease, I tell you.

And it seems to be the direct cause of this misfeature.

By all means the code can say "I can't credit this as entropy", but
the fact that it then doesn't even mix it into the fast pool is just
wrong, wrong, wrong.

I think *that* is what we should fix. The fact is, urandom has
long-standing semantics as "don't block", and that it shouldn't care
about the (often completely insane) entropy crediting rules.

But that "don't care about entropy rules" should then also mean "oh,
we'll mix things in even if we don't credit entropy".

I hope that's the easy fix you are thinking about.

              Linus
