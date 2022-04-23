Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7E50CE0D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiDWXgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 19:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiDWXgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 19:36:46 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF34A16FAFE;
        Sat, 23 Apr 2022 16:33:46 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AD45492009C; Sun, 24 Apr 2022 01:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9D31992009B;
        Sun, 24 Apr 2022 00:33:44 +0100 (BST)
Date:   Sun, 24 Apr 2022 00:33:44 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
In-Reply-To: <20220418071005.GA4075@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2204220029590.9383@angie.orcam.me.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com> <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk> <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk> <YlfoeGRM6w2O+eXA@zx2c4.com> <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk> <20220418071005.GA4075@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022, Thomas Bogendoerfer wrote:

> >  Also the systems I have in mind and that lack a counter in the chipset 
> > actually can make use of the buggy CP0 timer, because it's only when CP0 
> > timer interrupts are used that the erratum matters, but they use a DS1287 
> > RTC interrupt instead unconditionally as the clock event (see the comment 
> > at the bottom of arch/mips/dec/time.c).  But this has not been factored in 
> > with `can_use_mips_counter' (should it just check for `mips_hpt_frequency' 
> > being zero perhaps, meaning the timer interrupt not being used?).
> > 
> >  Thomas, do you happen to know if any of the SGI systems that we support 
> > had buggy early R4k chips?
> 
> IP22 has probably seen all buggy MIPS chips produced, so yes I even own
> Indy/Indigo2 CPU boards with early R4k chips.

 Do they actually use the CP0 timer as a clock event device?  Do they have 
an alternative high-precision timer available?

 In the course of verifying this change I have noticed my DECstation
5000/260, which has a high-precision timer in the chipset available as a 
clock source device, does register the CP0 timer as a clock source device 
regardless.  Upon a closer inspection I have noticed that the CP0 timer 
interrupt is non-functional in this machine, which I have then confirmed 
as a valid CPU hardware configuration via the TimIntDis/TimerIntDis (the 
R4k CPU manual is inconsistent in naming here) boot-mode bit.  It allows 
IP7 to be used as an external interrupt source instead.  I used not to be 
aware of the presence of this boot-mode bit.

 I find this arrangement odd, because IP7 used to be wired internally as 
the FPU interrupt with the 5000/240's CPU module, so it's not usable as an 
external interrupt anyway with this system's mainboard.

 That means however that this machine (and possibly the 5000/150 as well, 
but I'll have to verify that once I get at the KN04 CPU module I have in a 
drawer at my other place) can use the CP0 timer as a clock source device 
unconditionally.  I think this discovery asks for code optimisation, which 
I'll try to cook up sometime.

 I don't expect the IP22 to have a similar arrangement with the CP0 timer 
interrupt given that the CPU was an in-house design at SGI, but who knows?  
Do you?

  Maciej
