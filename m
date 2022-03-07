Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336E04CF64F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiCGJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiCGJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:27:44 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B75A085;
        Mon,  7 Mar 2022 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646645089;
  x=1678181089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CmVi/4Nf+c+fLXTqFUvrIaFiJk/ULe4N6+IxCPq3IQ=;
  b=GC2kH2F+Y2dJTEEI/0VeXF1PrM/7q65pYGHW+mOxqBG5cP9C/3cSKl8c
   tCmu3/bWfntMP2eNYBv1Zildq1NfifIa/6RzVs6/CKaLtjXdbWfpv+1aM
   iwL8E5hwb60pu8na6qBbnzDz+xBHcRsXzNPmYSo9dF5YWGch5Oo6EaW1K
   cXqRHk3nDuAqSeQN+8ueevQ59OO/LHEWi0b+4jLZgfegpwGBr7xXAYiNf
   oHoU8sq19TBn5DLrMFkWJUoiluZYTj1JYyV1Io9kT9Zm/22I0xrpv0i6h
   EqylWszECzVtbo7xVt+t2126rtOBa7wmKfPmWAirj3xKUMdAkQGLvBViL
   w==;
Date:   Mon, 7 Mar 2022 10:24:37 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel <kernel@axis.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Support using only local
 timer
Message-ID: <20220307092437.GA32457@axis.com>
References: <20220307083255.1577365-1-vincent.whitchurch@axis.com>
 <08992f48-6cb6-8dc0-33d2-f18f942d2bee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08992f48-6cb6-8dc0-33d2-f18f942d2bee@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:06:26AM +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 09:32, Vincent Whitchurch wrote:
> > The ARTPEC-8 SoC has a quad-core Cortex-A53 and a single-core Cortex-A5
> > which share one MCT with one global and eight local timers.
> > 
> > The Cortex-A53 boots first and starts the global FRC and also registers
> > a clock events device using the global timer.  (This global timer clock
> > events is usually replaced by arch timer clock events for each of the
> > cores.)
> > 
> > When the A5 boots, we should not use the global timer interrupts or
> > write to the global timer registers.  This is because even if there are
> > four global comparators, the control bits for all four are in the same
> > registers, and we would need to synchronize between the cpus.  Instead,
> > the global timer FRC (already started by the A53) should be used as the
> > clock source, and one of the local timers which are not used by the A53
> > can be used for clock events on the A5.
> > 
> > To support this, add a module param to set the local timer starting
> > index.  If this parameter is non-zero, the global timer clock events
> > device is not registered and we don't write to the global FRC if it is
> > already started.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  drivers/clocksource/exynos_mct.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> This should not be send separately from the previous patch.

OK, I will put it in a series.

> 
> > 
> > diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> > index f29c812b70c9..7ea2919b1808 100644
> > --- a/drivers/clocksource/exynos_mct.c
> > +++ b/drivers/clocksource/exynos_mct.c
> > @@ -33,7 +33,7 @@
> >  #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
> >  #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
> >  #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
> > -#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
> > +#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
> >  #define EXYNOS4_MCT_L_MASK		(0xffffff00)
> >  
> >  #define MCT_L_TCNTB_OFFSET		(0x00)
> > @@ -77,6 +77,13 @@ static unsigned long clk_rate;
> >  static unsigned int mct_int_type;
> >  static int mct_irqs[MCT_NR_IRQS];
> >  
> > +/*
> > + * First local timer index to use.  If non-zero, global
> > + * timer is not written to.
> > + */
> > +static unsigned int mct_local_idx;
> > +module_param_named(local_idx, mct_local_idx, int, 0);
> 
> No, it's a no go. Please use dedicated compatible if you need specific
> quirks.

I could add a compatible, but please note that the hardware itself does
not have any quirks, it's only the usage of the hardware from one of the
Linux kernels (see the explanation below) which is different.  Is it
correct to use a compatible to distinguish between these kind of
software-determined usage differences?

> 
> > +
> >  struct mct_clock_event_device {
> >  	struct clock_event_device evt;
> >  	unsigned long base;
> > @@ -157,6 +164,17 @@ static void exynos4_mct_frc_start(void)
> >  	u32 reg;
> >  
> >  	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
> > +
> > +	/*
> > +	 * If the FRC is already running, we don't need to start it again.  We
> > +	 * could probably just do this on all systems, but, to avoid any risk
> > +	 * for regressions, we only do it on systems where it's absolutely
> > +	 * necessary (i.e., on systems where writes to the global registers
> > +	 * need to be avoided).
> > +	 */
> > +	if (mct_local_idx && (reg & MCT_G_TCON_START))
> > +		return;
> 
> I don't get it. exynos4_mct_frc_start() is called exactly only once in
> the system - during init. Not once per every CPU or cluster (I
> understood you have two clusters, right?).

Not quite.  The Cortex-A53 and the Cortex-A5 do not have cache-coherency
between them, so they are not run in an SMP configuration.  From the
Cortex-A53's perspective, the Cortex-A5 looks like any other hardware
block.  The Cortex-A5 could just as well have run some other operating
system, but I run Linux on it.  So there are two separate, independent
Linux kernels running on the SoC.
