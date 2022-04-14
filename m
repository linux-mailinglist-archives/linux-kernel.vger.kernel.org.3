Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60326500385
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiDNBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiDNBSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:18:43 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48DF74E38E;
        Wed, 13 Apr 2022 18:16:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D411B92009C; Thu, 14 Apr 2022 03:16:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C508F92009B;
        Thu, 14 Apr 2022 02:16:18 +0100 (BST)
Date:   Thu, 14 Apr 2022 02:16:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
In-Reply-To: <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com> <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> However, one thing that I've been thinking about is that the c0 random
> register is actually kind of garbage. In my fuzzy decade-old memory of
> MIPS, I believe the c0 random register starts at the maximum number of
> TLB entries (16?), and then counts down cyclically, decrementing once
> per CPU cycle. Is that right?

 Yes, for the relevant CPUs the range is 63-8 << 8 for R3k machines and 
47-0 (the lower bound can be higher if wired entries are used, which I 
think we occasionally do) for R4k machines with a buggy CP0 counter.  So 
there are either 56 or up to 48 distinct CP0 Random register values.

> If it is, there are some real pros and cons here to consider:
> - Pro: decrementing each CPU cycle means pretty good granularity
> - Con: wrapping at, like, 16 or something really is very limited, to
> the point of being almost bad
> 
> Meanwhile, on systems without the c0 cycles counter, what is the
> actual resolution of random_get_entropy_fallback()? Is this just
> falling back to jiffies?

 It depends on the exact system.  Some have a 32-bit high-resolution 
counter in the chipset (arch/mips/kernel/csrc-ioasic.c) giving like 25MHz 
resolution, some have nothing but jiffies.

> IF (a) the fallback is jiffies AND (b) c0 wraps at 16, then actually,
> what would be really nice would be something like:
> 
>     return (jiffies << 4) | read_c0_random();
> 
> It seems like that would give us something somewhat more ideal than
> the status quo. Still crap, of course, but undoubtedly better.

 It seems like a reasonable idea to me, but the details would have to be 
sorted out, because where a chipset high-resolution counter is available 
we want to factor it in, and otherwise we need to extract the right bits 
from the CP0 Random register, either 13:8 for the R3k or 5:0 for the R4k.

  Maciej
