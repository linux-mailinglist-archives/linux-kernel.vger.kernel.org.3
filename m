Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029B54E82A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiFPQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiFPQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:56:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F83326E2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:56:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me5so3923622ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTCaV5JT6qTWfBercMWlEblUINgIroVSHoW1wsfqACA=;
        b=W/pKji3dzXG2dNNpq916uSWl5jFc93ncSgWCT1FLBNPdcdyU37WPots+mUlg8QFXpW
         x1HOB4tio+3irqKgHluIkU8EUtDH1JvErcIqEdlhfdLrDXbaMLfRZOty85GeVeZq3KSe
         eDrpQOdjX0+ps7jM6+FMhcEQ5Wk/D9zZWJ9KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTCaV5JT6qTWfBercMWlEblUINgIroVSHoW1wsfqACA=;
        b=m/RX47EIhNB3fbumnPO3HUt4YkOJdZwlto6GTfvl5gzXcCjgM0sJqOGp6d4rX8f6Rn
         FGJiwR5zOkpXXopfoyy/EQgetbW5Ynq4XidgLai5+mxzDks5gOZy/HlNhjYNM2VUhoo/
         lXfQDlK9IN4v2et8TOu50SzHRn/Hh+M7jHkC4V5p15s/haPzVYGYFQhPWAc97DDPH2TL
         JPL8hHnLmVWfmRj0r2MK+FSrppMIZ66lWAqldE+zTtIUcAnIF+OEZ/F5ra/0pwDy2c9x
         WApIRVUICcCZT8ho2sxkp/hijZEzOK0LshuI+3tFdktNH4gXped5xAnylGzmibR1yU5h
         FaZQ==
X-Gm-Message-State: AJIora8h8fbd2WnQHNfd5l0Z15199Iz5vPUq23dbIj2/l5PkLo/pA1wC
        mgqC3mBjh/FFWyBOjpiERubRhIeo0hlVK5VyvRE=
X-Google-Smtp-Source: AGRyM1uV8gwpsmUkGof7W+jzoWo//Fkn7LrCFGaWPUDYfOtbqRZ7dHVxjK0/R6HQ7UPeDQuTEwSPgw==
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id e21-20020a170906505500b006ff1dfb1e2cmr5424396ejk.200.1655398598904;
        Thu, 16 Jun 2022 09:56:38 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id b7-20020a056402278700b004335e08d6c9sm2231791ede.33.2022.06.16.09.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:56:38 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id g4so2633949wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:56:38 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr3516296wrs.97.1655398597730; Thu, 16 Jun
 2022 09:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com> <Yqtd6hTS52mbb9+q@casper.infradead.org>
In-Reply-To: <Yqtd6hTS52mbb9+q@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 09:56:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
Message-ID: <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 9:44 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I don't want to support an address space larger than word size.  I can't
> imagine any CPU vendor saying "So we have these larger registers that
> you can only use for pointers and then these smaller registers that you
> can use for data".  We haven't had A/D register splits since the m68k.
> Perhaps I haven't talked to enough crazy CPU people.  But if anyone does
> propose something that bad, we should laugh at them.

Yeah, the thing is, right now we have 'unsigned long' as the "wordsize".

And I want to point out that that is not about "pointers" at all, it's
about pretty much everything.

It shows up in some very core places like system call interface etc,
where "long" is in very real ways the expected register size.

So the 128-bit problem is actually much larger than just "uintptr_t",
and we have that "sizeof(long)" thing absolutely everywhere.

In fact, you can see it very much in things like this:

   #if BITS_PER_LONG == 64

which you'll find all over as the "is this a 64-bit architecture".

Out bitmaps and bit fields are also all about "long" - again, entirely
unrelated to pointers.

So I agree 100% that "we will have a problem with 128-bit words".

> So how do you think we should solve the 128-bit-word-size problem?
> Leave int at 32-bit, promote long to 128-bit and get the compiler to
> add __int64 to give us a 64-bit type?

That would likely be the least painful approach, but I'm not sure it's
necessarily the right one.

Maybe we might have to introduce a "word size" type.

> The only reason I like size_t is that it's good _documentation_.
> It says "This integer is a byte count of something that's in memory".
> As opposed to being a count of sectors, blocks, pages, pointers or
> turtles.

Yes.

And yes:

> extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
>                            unsigned int, unsigned int);

We should use a lot more explicit types for flags in particular.
Partly for documentation, partly for "we could type-check these".

And in declarations it might be good to encourage use of (helpful)
argument names, in case it really is just an offset or other integer
where a type makes no sense.

             Linus
