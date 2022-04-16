Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270D503727
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiDPOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiDPOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:47:28 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6E1516598;
        Sat, 16 Apr 2022 07:44:55 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id EDBF792009E; Sat, 16 Apr 2022 16:44:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E02D092009C;
        Sat, 16 Apr 2022 15:44:53 +0100 (BST)
Date:   Sat, 16 Apr 2022 15:44:53 +0100 (BST)
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
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
In-Reply-To: <CAHmME9qzkZqkGntLn--XfMKzyR=tYiCaZu1uFpoQBzAzCipZ-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204161533420.9383@angie.orcam.me.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com> <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk> <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk> <YlfoeGRM6w2O+eXA@zx2c4.com> <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk> <CAHmME9qzkZqkGntLn--XfMKzyR=tYiCaZu1uFpoQBzAzCipZ-A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> >  There are two variants only of the CP0 Random register that we can ever
> > encounter, as it's been de-facto standardised in early 1990s already and
> > then written down in the MIPSr1 architecture specification ~2000.  So I
> > think it may make sense to actually handle them both explictitly with
> > individual calculations, possibly conditionalised on a CONFIG setting or
> > `cpu_has_3kex', because kernels that support the two variants of the MMU
> > architecture are mutually incompatible.
> 
> Okay, I can give this a shot, but this certainly isn't my forté. It
> may ultimately wind up being simpler for you to just send some code of
> what you envision for this, but if I understand your idea correctly,
> what you're saying is something like:
> 
> static inline unsigned long random_get_entropy(void)
> {
>         unsigned int prid = read_c0_prid();
>         unsigned int imp = prid & PRID_IMP_MASK;
>         unsigned int c0_random;
> 
>         if (can_use_mips_counter(prid))
>                 return read_c0_count();
> 
>         if (cpu_has_3kex)
>                 c0_random = (read_c0_random() >> 8) & 0x3f;
>         else
>                 c0_random = read_c0_random() & 0x3f;
>         return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
> }
> 
> What do you think of that? Some tweak I'm missing?

 It certainly looks good to me.  Do you have a way I could verify how this 
function performs?  If so, then I could put it through my systems as I can 
cover all the cases handled here.

 Any improvements I previously discussed can then be made locally in the 
MIPS port as follow-up changes.

> >  Isn't it going to be an issue for an entropy source that the distribution
> > of values obtained from the CP0 Random bit-field is not even, that is some
> > values from the 6-bit range will never appear?
> 
> It's the same situation without inverting the order: instead of some
> bits on the top never happening, some bits on the bottom never happen
> instead. In general, counters don't form uniform distributions anyway,
> since the lower bits change faster, and neither are they independent,
> since one sample in large part depends on the previous. This is just
> sort of the nature of the beast, and the code that calls
> random_get_entropy() deals with this appropriately (by, at the moment,
> just hashing all the bits).

 OK then, thanks for your clarification.

  Maciej
