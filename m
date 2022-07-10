Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7756D1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiGJWzx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Jul 2022 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJWzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 18:55:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D66255B2;
        Sun, 10 Jul 2022 15:55:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D81023A;
        Sun, 10 Jul 2022 15:55:49 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7E73F73D;
        Sun, 10 Jul 2022 15:55:47 -0700 (PDT)
Date:   Sun, 10 Jul 2022 23:54:40 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     samuel@sholland.org, Roman Stratiienko <r.stratiienko@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, mripard@kernel.org,
        wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] ccu-sun50i-h6: Bump-up DDR0 PLL to 1800MHz
Message-ID: <20220710235440.0b34d8cb@slackpad.lan>
In-Reply-To: <1917526.jZfb76A358@kista>
References: <20220710175214.544748-1-r.stratiienko@gmail.com>
        <1917526.jZfb76A358@kista>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2022 20:47:55 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Roman,

> Dne nedelja, 10. julij 2022 ob 19:52:14 CEST je Roman Stratiienko napisal(a):
> > While debugging complex animated composition cases  I noticed a glitch
> > which as it turned-out eventually was caused by lack of memory bandwidth.
> > 
> > I can't find a DRAMC manual to check what input frequency must be
> > supplied to avoid exceeding the 800MHz LPDDR3 which is installed on
> > my orangepi3 board. But the system is running stable so far.  

Well, most recent Allwinner boards indeed have capable LPDDR3 (800 MHz)
or DDR3-1600 (or even higher) chips, but we never got them running at the
full clock speed, and lowering the DRAM frequency is a common kludge to
improve system stability (as in: actually reaching the login prompt).
And we figured that those "more aggressive" timings are quite board
specific, so while 800 MHz might work on your particular board, your
friend's OPi3 might not be as lucky.

> this is hard topic. Generally, max. supported DRAM frequency is board specific 
> and is set by SPL (part of U-Boot), so we can't assume every board supports 
> max. frequency for its memory type.

Yes, while we run most H6 boards at 744 MHz, the Tanix TX6 requires no
more than 648 MHz, for instance, partly because it has DDR3 (not LPDDR3)
DRAM. Another H6 TV box I have needs an even lower frequency (at least
with the current timing settings).

> In fact, this assumption was proven wrong. 
> Some boards were unstable until DRAM frequency was lowered. So in short, Linux 
> clock driver certainly shouldn't set DRAM frequency.

Yes, and on top of that, also keep in mind that many DRAM controller
registers take timing parameters in terms of clock cycles, but the
actual DDR chips are specified in terms of pico- or nanoseconds. This
means the register values must be calculated and programmed based on
the clock frequency, see [1] for examples in all those ns_to_t()
calls. And just increasing the PLL frequency might now lead to exceeded
specifications, and thus subtle instabilities.

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c

> There is, however, Linux 
> MBUS driver for H5 and A64, which can throttle DRAM frequency when system is 
> idle, but max. frequency is still that one which was programmed by SPL.
> 
> There is no definitive DRAM documentation, because Allwinner usually tries to 
> hide all details. DRAM drivers are, except in rare cases, all reverse 
> engineered by community. Register values (mostly) match those produced by 
> vendor driver. Fortunately, at least H6 DRAM controller matches pretty good 
> with one other memory controller (one in Zynq UltraScale+ MPSoC), which is 
> fully documented (see comments in U-Boot driver). MBUS is also pretty standard 
> and it's not a mystery.
> 
> Note that it's hard to convince maintainers to either lower or increase DRAM 
> frequency as it was common issue in the past. You have to do a lot of memory 
> intensive tests, both CPU and GPU, running at the same time for extended 
> period of time. Initial board bring ups usually just use same frequency as in 
> BSP based images.

Yes, this DDR3 controller logic is mostly undocumented rocket science,
see [2] in our wiki for just *some* (old!) pieces of information and
the complexity it involved in the past to come to a set of timing
parameters (including the clock frequency) that works stably across
all boards.

[2] https://linux-sunxi.org/A10_DRAM_Controller_Calibration

> If I understand procedure correctly, boards are sent to 
> Allwinner, so their engineers determine max. DRAM frequency and timings, so 
> these values are pretty trustwothy.
> There is other possibility. Along with DRAM controller and PHY, there is MBUS 
> core, which is memory arbiter and responsible for bandwidth allocation. You 
> can change DE priority and bandwith there (again, in U-Boot DRAM driver).

That's indeed an interesting topic to explore, though the DE seems to
be already in the top tier in our settings:
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-sunxi/dram_sun50i_h6.c#L135-151

Cheers,
Andre

> I hope this explains why things are the way they are.
> 
> Best regards,
> Jernej
> 
> > 
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 750368a86b8b6..abdde80307993
> > 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > @@ -1203,6 +1203,17 @@ static int sun50i_h6_ccu_probe(struct platform_device
> > *pdev) val &= ~GENMASK(3, 0);
> >  	writel(val, reg + gpu_clk.common.reg);
> > 
> > +	/*
> > +	 * Increase DDR0 PLL from 1488(default) to 1800MHz.
> > +	 * (DE3.0 require higher memory bandwidth while displaying
> > +	 * complex composition at 1920x1080@60FPS)
> > +	 */
> > +
> > +	val = readl(reg + SUN50I_H6_PLL_DDR0_REG);
> > +	val &= ~GENMASK(15, 0);
> > +	val |= 74 << 8;
> > +	writel(val, reg + SUN50I_H6_PLL_DDR0_REG);
> > +
> >  	/* Enable the lock bits on all PLLs */
> >  	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
> >  		val = readl(reg + pll_regs[i]);
> > --
> > 2.34.1  
> 
> 
> 

