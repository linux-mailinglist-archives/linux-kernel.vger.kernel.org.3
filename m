Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48209578DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiGRW4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiGRW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:56:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE961C920
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:56:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz17so23988330ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NG3iefGii64YvAHaqT9Gl2cXR0OyawcZjQPtQ480mA=;
        b=Gw/FjPF8Ur/vqmfSNWpe6ZDtwcSnfqg2tbke8spsSGZlJ7x2utphweVTjsB8WHOMjz
         p6g7G5FO5hU63p44BJkbSE0k+uBFvhbNpROGCudhA9t8TYokwLkoL3sUwcj3gOSpoPdm
         CaFniujP7FZBaTXIsrNxkqbX+X5r9AmD9U3EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NG3iefGii64YvAHaqT9Gl2cXR0OyawcZjQPtQ480mA=;
        b=JIrxN5PTgkXkoF9qrdgo4mXHaYKHf3Jqpdk4IpjOahgLMsjGJrWiutoEX/FfvzfKQ7
         o2REjNfxXhPNOHrHsVVKm3Uwr8L04KJF6r6IqWV0QfGAWD9L/46+uJT4vHdMkVNjzFeO
         Zb2q3nPgQQeGyVRwE0fx6inW8hqHJHxr/YmWrNn6uexCL1yfWhiWOpoKvdT/soQ6tuYj
         AWojmpkgZcfuw1ypBZgeG43iOTXBwr/XEmVfwjVCRyf/D2KNvmTaae9TDFJ6Bhfjct/5
         Hf+2q9w+nchcVIWWREJSAOTQ4QSzu1sinKtxXHEONowr+VG7ejLI0NHy9hlSr+z+bEAC
         GuBA==
X-Gm-Message-State: AJIora9/EwMN+ngT4Qx4MRh9ltt0hwGuvw8wXrhMnw0/5dC6hB6xlo11
        8rumEAPc38azQgki63/3FLV3hu3gZ5+ydxrColc=
X-Google-Smtp-Source: AGRyM1vyNpdlV53sl5guN0LsEsWxEbiG/IWJRGwO6CK4pC4BrwtbgdAsixqxEE3r9rjp7UH/Ynchzg==
X-Received: by 2002:a17:907:1608:b0:72e:e254:7baa with SMTP id hb8-20020a170907160800b0072ee2547baamr21878744ejc.672.1658184969003;
        Mon, 18 Jul 2022 15:56:09 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906329200b0072b2eab813fsm5733030ejw.75.2022.07.18.15.56.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 15:56:08 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h17so19186109wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:56:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr24939012wry.97.1658184967334; Mon, 18
 Jul 2022 15:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <87cze3docs.fsf@mpe.ellerman.id.au> <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
 <20220718220839.GF25951@gate.crashing.org>
In-Reply-To: <20220718220839.GF25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 15:55:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWez4jFa1sbkhMqGktFPDMvd3kojibwFyTkGOL2xrp5w@mail.gmail.com>
Message-ID: <CAHk-=wjWez4jFa1sbkhMqGktFPDMvd3kojibwFyTkGOL2xrp5w@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 3:12 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Assembler language is unforgiving.  It isn't easy to write, and most
> mistakes will not be diagnosed.  If the assmbler language makes it
> easier to read the code, that makes it more likely correct code will be
> written, and that correct code will be written in less time.

What's your argument? That it's unforgiving, so it has to be
unreadable and easy to make mistakes in too?

You can get the order of operands wrong, and it will still build -
just to completely the wrong thing.

> > Oddities, yes ("$" as a prefix for register? Alpha asm is also very
> > odd), but nothing *quite* as broken as "simple constants have entirely
> > different meanings depending on the exact instruction and argument
> > position".
>
> What is broken about that?  It makes everything very consistent, and
> very readable.  Sigils are just nasty, and having the register names the
> same as valid symbol names is also problematic.

Oh, I agree that sigils are good to make the type clear. So '%r4' is
better than 'r4' because the latter could be ambiguous and you could
have a symbol 'r4'.

But just '4' is plain garbage.  There's no "could be ambiguous" about it.

Type checking matters. Not just in C. In asm too.

The reason '$0' is odd because it's *just* a sigil and a number.

Which certainly is not unusual in itself, but it reads like it's a
number to me. Not just because of x86 gas ('$' means 'immediate'), but
Z80 ('$' means HEX), or at least 'Nth argument' (shell).

And yeah, alpha got it from MIPS, afaik.

And presumably MIPS got it from "we're hacking up the simplest
assembler we can".

> > The human-written asm files have those #define's in headers just to
> > make things slightly more legible, because apparently the assembler
> > doesn't even *accept* the sane names.
>
> That was true a long time ago.  And the "#define r0 0" thing caused
> quite a few bugs itself btw.

Those #define's still exist. Look it up.

And yes, they are horrible, and they are wrong, and they shouldn't exist.

               Linus
