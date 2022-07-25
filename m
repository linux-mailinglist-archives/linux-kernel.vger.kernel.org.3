Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824DC580434
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiGYSta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:49:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C431D4B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:49:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va17so22299422ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAiruYU2YzJNdYlca4LZT5jIUn7wqFU4SB2mN4rLMjk=;
        b=M2D87eNsp6eYBd6ZAXOXe1tTm55yj7N2yIeXPn0pryPpXD6mneFXjwPaWNxUfEu+1P
         kLOcYsfmyNRcv4oT4EYym9CESBVlR8/luw/sPaNoZFojUPVsu7EVnrG/SL6EL026Y9wl
         tkVN8YM7B/q/EwErCw7ipNbAumPnsiEAhL900=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAiruYU2YzJNdYlca4LZT5jIUn7wqFU4SB2mN4rLMjk=;
        b=jO6MSaSe5zB3IjsUFJCC6o2EA3nIryOl9RCYdGvPMXt1fHAX67uckNUbZKCd6AhX4S
         pSXeKiYKkmbmdqhWO+S/1AUDN7VXwHfyxYOwp+H0AGimFDoQRQxr70OpdcjhJFQZxPLq
         d/f15zBruV63wBw6LBA7fjTmx0YLGijhezPUKNQTGIPRcs21MXdJEiymvzqxFhDwoR9p
         peHc4eOemU3QOV8kWkOL4ChsFbxN1U1dieUF5jf/x20JtBgOE0R50i+Go8dQLSr3HLEX
         wts4psOONQTWEB0DFaGa4MvGjF8ocaopXWCg/X45bGB465I6YqQvBlGtR+cvzG1sJrRQ
         Qejw==
X-Gm-Message-State: AJIora+1ecdyzAj8WMBugyHHjoGgTJBVi4Trkq2VPlEo0cN5feWKttgB
        0GvI9uYfGt/4ihcEs/TxOjIeemdKR4NT0mTq
X-Google-Smtp-Source: AGRyM1s8YA75HGbFDlFx3mp2LFEeQ8GQRWtr4yousD29litXGvE+ksRuH1DTlcPe9nnMTjJGH2FOUA==
X-Received: by 2002:a17:907:2c74:b0:72b:5ba7:d96f with SMTP id ib20-20020a1709072c7400b0072b5ba7d96fmr11518492ejc.33.1658774966529;
        Mon, 25 Jul 2022 11:49:26 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id ja12-20020a170907988c00b0072ee0976aa2sm5536655ejc.222.2022.07.25.11.49.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 11:49:25 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m17so16981667wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:49:25 -0700 (PDT)
X-Received: by 2002:a5d:59a4:0:b0:21e:8704:ea35 with SMTP id
 p4-20020a5d59a4000000b0021e8704ea35mr4400795wrr.442.1658774965332; Mon, 25
 Jul 2022 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net> <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
In-Reply-To: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jul 2022 11:49:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGrewyOqT7Cm-eHKp5W+8rJ=aL8iNtsbhRfc0YD2gbeA@mail.gmail.com>
Message-ID: <CAHk-=wgGrewyOqT7Cm-eHKp5W+8rJ=aL8iNtsbhRfc0YD2gbeA@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jul 25, 2022 at 10:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think the fix might be something like this:

Hmm. Maybe the fix is to just not have the arm architecture-specific
version at all.

The generic code handles the "small constant size bitmap that fits in
a word" case better than the ARM special case code does.

And the generic code handles the "scan large bitmap" case better than
the ARM code does too, in that it does things a word at a time, while
the ARM special case code does things one byte at a time.

The ARM code does have a few things going for it:

 (a) it's simple

 (b) it has separate routines for the little-endian case

Now, (a) is probably not too strong an argument, because it's arguably
*too* simple, and buggy as a result. And having looked a bit more,
it's not just _find_next_bit_le() that has this bug, it's all the
"next" versions (zero-bit and big-endian).

But (b) is actively better than what the generic "find bit" code has.
The generic code is kind of disgusting in this area, with code like

        if (le)
                tmp = swab(tmp);

in lib/find_bit.c and this is nasty for two reasons:

 (1) on little-endian, the "le" flag is mis-named: it's always zero,
and it never should swab, but the code was taken from some big-endian
generic case

 (2) even on big-endian, that "le" flag is basically a compile-time
constant, but the header file shenanigans have hidden that fact, so it
ends up being a "pass a constant to a function that then has to test
it dynamically" situation

So the generic code is in many ways better than the ARM special case
code, but it has a couple of unfortunate warts too. At least those
unfortunate warts aren't outright *bugs*, they are just ugly.

              Linus
