Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8CA4D60B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348322AbiCKLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348289AbiCKLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:49 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D82186BA9;
        Fri, 11 Mar 2022 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646998546;
  x=1678534546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ePdSlJGdNO1CPKcwOdopJLY1Ek3GzVO2ZQn/333Vrac=;
  b=Kl4AO5TjZEN8rmyxtfrSoX1SaiFGiIUqiEibbWFjcy3tP/1NXIdbuYIv
   rM8Bj50mBOwwMg5ZFkg6On2zeOdooo+pqIMiuGYqha4qR+5qbrdXk8io8
   0Hmg6HLrZr3FxaVQXZ0IVKDLx2sTDd37PVVxz7COqHBwZyjJFppvZu8iE
   uYvTWIofQh16Mp/yDY5JKpqAx+65jlKau+p23YZcccxiaf5WO2wQI/JYH
   UdRi5InFZdtJi+Vu8SUuTXhc5Mv/xCAhbBViTbTqrWmbe8vzi7mQQ6WoJ
   EuacI3uGO+oTkJRv8/+pxBjcxAkuy9tt2U2OP/XXkimVFjhiRdg1yImuG
   A==;
Date:   Fri, 11 Mar 2022 12:35:43 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support
 local-timer-index property
Message-ID: <20220311113543.GA17877@axis.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-4-vincent.whitchurch@axis.com>
 <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
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

On Tue, Mar 08, 2022 at 03:57:55PM +0100, Krzysztof Kozlowski wrote:
> On 08/03/2022 15:24, Vincent Whitchurch wrote:
> > diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> > index f29c812b70c9..5f8b516614eb 100644
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
> > @@ -75,6 +75,7 @@ enum {
> >  static void __iomem *reg_base;
> >  static unsigned long clk_rate;
> >  static unsigned int mct_int_type;
> > +static unsigned int mct_local_idx;
> 
> No more static variables. This was wrong design, happens, but let's not
> grow the list.
> 
> I propose to conditionally (depending on property samsung,frc-shared)
> assign .resume callback to NULL or exynos4_frc_resume. The init can
> receive an argument whether to call frc_start().

Could we just add the skip-write-register-if-already-started change in
exynos4_mct_frc_start() uncondtionally?  Perhaps it could be in a
separate patch too?  I was probably being over-cautious when I did it
conditionally on mct_local_idx.  Doing it uncondtionally would make it
easier to remove the global variable.

On my system the FRC is actually started long before Linux, and I assume
it's similar on other chips.

> 
> >  static int mct_irqs[MCT_NR_IRQS];
> >  
> >  struct mct_clock_event_device {
> > @@ -157,6 +158,17 @@ static void exynos4_mct_frc_start(void)
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
> 
> This contradicts your intentions in commit #2 msg, where you described
> that A53 will be started first.

Yes, you're right.  The case of the FRC not being running when the A5
starts up is only ever hit in our simulation environment where we are
able to start Linux on the A5 directly, without having to go via the
A53.

> 1. If A53 is always started first, is it possible to be here from A5?
> 2. If above is possible, how do you handle locking? For example:
> a. A53 started with some delay, entered exynos4_mct_frc_start() pass
> this check;
> b. A5 gets to exynos4_mct_frc_start(), check is still false, so A5
> enables the FRC,
> c. A53 also enables the FRC.

The A5 is normally started from Linux on the A53 (using the remoteproc
framework).  This is long after exynos4_mct_frc_start() has been called
on the A53.
