Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C85009C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbiDNJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiDNJ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EAD50E2A;
        Thu, 14 Apr 2022 02:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F56861CB7;
        Thu, 14 Apr 2022 09:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F941C385A1;
        Thu, 14 Apr 2022 09:27:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iCKw8U+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649928448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jitaCCQ2e/PpJGSBhLHWsevtZEgEekS1b3Wk73klyKA=;
        b=iCKw8U+BX0unZDHdCqu1WEQPpDnLVael4IDVYgWvfW7w0XcoPFz96Q+X7Oh/HXcBDfoQgf
        relkkKJiqLUs0hWWbJBeLDEdKmFO5iYlsrmp12SxDsveaByJUqA4gI9QfV6k/NrhryczGl
        YX1t4UDjk8/egPtL7ZCNgWMOfE4aDFg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff3c9dc5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 14 Apr 2022 09:27:27 +0000 (UTC)
Date:   Thu, 14 Apr 2022 11:27:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YlfoeGRM6w2O+eXA@zx2c4.com>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de>
 <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Thu, Apr 14, 2022 at 02:16:18AM +0100, Maciej W. Rozycki wrote:
>  Yes, for the relevant CPUs the range is 63-8 << 8 for R3k machines and 
> 47-0 (the lower bound can be higher if wired entries are used, which I 
> think we occasionally do) for R4k machines with a buggy CP0 counter.  So 
> there are either 56 or up to 48 distinct CP0 Random register values.

Ahh interesting, so it varies a bit, but it remains rather small.

>  It depends on the exact system.  Some have a 32-bit high-resolution 
> counter in the chipset (arch/mips/kernel/csrc-ioasic.c) giving like 25MHz 
> resolution, some have nothing but jiffies.

Alright, so there _are_ machines with no c0 cycles but with a good
clock. Yet, 25MHz is still less than the cpu cycle, so this c0 random
ORing trick remains useful perhaps.

>  It seems like a reasonable idea to me, but the details would have to be 
> sorted out, because where a chipset high-resolution counter is available 
> we want to factor it in, and otherwise we need to extract the right bits 
> from the CP0 Random register, either 13:8 for the R3k or 5:0 for the R4k.

One thing we could do here that would seemingly cover all the cases
without losing _that_ much would be:

    return (random_get_entropy_fallback() << 13) | ((1<<13) - read_c0_random());

Or in case the 13 turns out to be wrong on some hardware, we could
mitigate the effect with:

    return (random_get_entropy_fallback() << 13) ^ ((1<<13) - read_c0_random());

As mentioned in the 1/xx patch of this series,
random_get_entropy_fallback() should call the highest resolution thing.
We then shave off the least-changing bits and stuff in the
faster-changing bits from read_c0_random(). Then, in order to keep it
counting up instead of down, we do the subtraction there.

What do you think of this plan?

Jason
