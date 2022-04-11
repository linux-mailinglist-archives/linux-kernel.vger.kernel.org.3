Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFE4FC767
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350267AbiDKWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiDKWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B49162E8;
        Mon, 11 Apr 2022 15:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97EE76173E;
        Mon, 11 Apr 2022 22:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C231C385A3;
        Mon, 11 Apr 2022 22:13:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KybX01zY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649715191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSudnh1FVwn/cRuaWERLZCgg6VCPqB/kIypq5KjigTQ=;
        b=KybX01zYWKByBGHHcfMAmavnP7L0p3jg7aV2fmW50XiFpz7B1LAEyJXHq3V4iRh7NnrsVG
        WlIHJ9f0wTZy8WOOgmyYrCIi8QNK9nY17FyQTt9LA8IcFXu4dkJkUI/J2c7LyuJha0Ot6K
        tj5LHYp+jIpnZFZ/H9s4FciDdH7BJ7o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43c1faab (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 11 Apr 2022 22:13:10 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id p65so11704866ybp.9;
        Mon, 11 Apr 2022 15:13:10 -0700 (PDT)
X-Gm-Message-State: AOAM531o3aMtHXCKOjNg5ZH62+QRpI2yDLO1zJgtX3N5nGdsMGVgt6jA
        1CxTuqgqwJRJjIifKG5V2sqCHa2KYEntwdUMm64=
X-Google-Smtp-Source: ABdhPJyrbHcZ7X1J23rQnANqA3RR06u0ZM3R7CT8etsKwGDR+r4LAk7JuXL3JmvpUSxPvBr0OEr8z3kykwSI+XeJazE=
X-Received: by 2002:a5b:6cf:0:b0:61e:1371:3cda with SMTP id
 r15-20020a5b06cf000000b0061e13713cdamr24066153ybq.235.1649714889427; Mon, 11
 Apr 2022 15:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220410214951.55294-1-Jason@zx2c4.com> <20220410214951.55294-4-Jason@zx2c4.com>
 <87sfqkf2y1.ffs@tglx>
In-Reply-To: <87sfqkf2y1.ffs@tglx>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 12 Apr 2022 00:07:58 +0200
X-Gmail-Original-Message-ID: <CAHmME9qU7x3=KsjfH0qDW=isdcGxTweHbssvshYxkV5iHpamGw@mail.gmail.com>
Message-ID: <CAHmME9qU7x3=KsjfH0qDW=isdcGxTweHbssvshYxkV5iHpamGw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] m68k: use ktime_read_raw_clock() for
 random_get_entropy() instead of zero
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Apr 11, 2022 at 10:18 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
> > index 6a21d9358280..5351b10e1b18 100644
> > --- a/arch/m68k/include/asm/timex.h
> > +++ b/arch/m68k/include/asm/timex.h
> > @@ -35,7 +35,7 @@ static inline unsigned long random_get_entropy(void)
> >  {
> >       if (mach_random_get_entropy)
> >               return mach_random_get_entropy();
> > -     return 0;
> > +     return ktime_read_raw_clock();
>
> I'd rather do something like this in a common header:
>
> unsigned long random_get_entropy_fallback(void);
>
> and use random_get_entropy_fallback() in the architecture specific
> files.
>
> That way you can encapsulate the fallback implementation in the random
> code and if it turns out that ktime_read_raw_clock() is a stupid idea or
> someone has a better idea then you have to change exactly one place and
> not patch the whole tree again.

Absolutely. That's a good idea. I'll do that for v3.

Jason
