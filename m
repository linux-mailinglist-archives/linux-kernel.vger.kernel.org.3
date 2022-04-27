Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A455122A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiD0T2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiD0T2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:28:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60927C49;
        Wed, 27 Apr 2022 12:24:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65936ED1;
        Wed, 27 Apr 2022 12:24:51 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6973F5A1;
        Wed, 27 Apr 2022 12:24:49 -0700 (PDT)
Date:   Wed, 27 Apr 2022 20:24:31 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 01/18] clk: sunxi-ng: h616-r: Add RTC gate clock
Message-ID: <20220427202248.42263b39@slackpad.lan>
In-Reply-To: <67675179-d25a-9154-b307-7168f87095db@sholland.org>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
        <20220211122643.1343315-2-andre.przywara@arm.com>
        <01e8d2a0-cdeb-ab64-42a7-48376b49c00e@sholland.org>
        <20220425003557.696c9de8@slackpad.lan>
        <67675179-d25a-9154-b307-7168f87095db@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 19:05:02 -0500
Samuel Holland <samuel@sholland.org> wrote:

> Hi Andre,
> 
> On 4/24/22 6:36 PM, Andre Przywara wrote:
> > On Tue, 22 Feb 2022 21:22:07 -0600
> > Samuel Holland <samuel@sholland.org> wrote:
> > 
> > Hi Samuel,
> >   
> >> On 2/11/22 6:26 AM, Andre Przywara wrote:  
> >>> The H616 features an (undocumented) bus clock gate for accessing the RTC
> >>> registers. This seems to be enabled at reset (or by the BootROM), but is
> >>> there anyway.
> >>> Since the new RTC clock binding for the H616 requires this "bus" clock
> >>> to be specified in the DT, add this to R_CCU clock driver and expose it
> >>> on the DT side with a new number.    
> >>
> >> It would be good to note why you didn't add this clock to H6, even though it
> >> exists in that hardware.  
> > 
> > What explanation do you prefer here? The main reason I expose this is
> > because of the H616 binding, so this is not required for the H6.
> > Plus is would break compatibility with older kernels, which is not so
> > much an issue for the H616.
> > Do you want to expose the clock on the H6 side as well, and mark it
> > as CLK_IS_CRITICAL there? I guess otherwise it would get turned off.
> > Or were you just after some kind of rationale as above, for the
> > commit log records?  
> 
> Today I found out that this commit breaks booting on H6 because the clock is not
> added there. clk_hw_onecell_data::hws is a flexible array member, so
> incrementing CLK_NUMBER doesn't actually make the array larger. That means .num
> gets interpreted as .hws[CLK_R_APB1_RTC], and that ends with a NULL dereference.

Ouch, sorry for that, and thanks for the report. But that's a fragile
feature of the sunxi clock driver in general, isn't it? I wonder if we
should always end those arrays with:
	[CLK_NUMBER]		= NULL,
to be on the safe side. This would increase the flexible array
be one element, but that doesn't really harm, since .num limits
the traversal.
Otherwise we would always rely on the last clock to be always
explicitly listed, while we are fine with clocks in the middle missing.
Or in this case we could also say:
	[CLK_R_APB1_RTC]	= NULL,

But I guess since this particular clock is actually there in the H6, you
prefer it to be listed properly?

> The easiest solution seems to be adding the clock on H6 as well. I think
> CLK_IGNORE_UNUSED is sufficient, but CLK_IS_CRITICAL would work as well.

CLK_IGNORE_UNUSED sounds better to me, in this case.

I will try and test this on an H6 as well, this time ;-)

Thanks,
Andre

> 
> The rationale I'm looking for is something along the lines of "the H6 binding
> prevents us from referencing this clock from the devicetree, and the way the
> driver is written prevents us from changing the binding."
> 
> >>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>> ---
> >>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 4 ++++
> >>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
> >>>  include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
> >>>  3 files changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> >>> index 712e103382d8..26fb092f6df6 100644
> >>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> >>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> >>> @@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
> >>>  		      0x1cc, BIT(0), 0);
> >>>  static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
> >>>  		      0x1ec, BIT(0), 0);
> >>> +static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
> >>> +		      0x20c, BIT(0), 0);    
> >>
> >> All of the documentation I have found (manuals, A100 driver, BSP D1 driver)
> >> points to this clock coming off of R_AHB, not R_APB1.  
> > 
> > Really, can you provide some pointer? In the H616 manual I see
> > AHBS->AHB2APB->APBS1BUS->RTC, next to the other R_ peripherals. Also
> > typically *register access* is done via APB busses, not AHB.
> > Is any of those documentation sources actually reliable? And
> > regardless, the AHB vs. APB parenthood is mostly academic, isn't it?  
> 
> You are right. I'm looking at the "RTC Application Diagram". For both H6 and
> H616, the diagram and the caption have register access via APB1. A100/R329/D1
> have register access via AHBS (and this matches the CCU bus tree diagram). So it
> looks like this was changed for A100.
> 
> Regards,
> Samuel
> 
> >>>  
> >>>  /* Information of IR(RX) mod clock is gathered from BSP source code */
> >>>  static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
> >>> @@ -147,6 +149,7 @@ static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
> >>>  	&r_apb2_i2c_clk.common,
> >>>  	&r_apb2_rsb_clk.common,
> >>>  	&r_apb1_ir_clk.common,
> >>> +	&r_apb1_rtc_clk.common,
> >>>  	&ir_clk.common,
> >>>  };
> >>>  
> >>> @@ -179,6 +182,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
> >>>  		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
> >>>  		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
> >>>  		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
> >>> +		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
> >>>  		[CLK_IR]		= &ir_clk.common.hw,
> >>>  	},
> >>>  	.num	= CLK_NUMBER,
> >>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> >>> index 7e290b840803..10e9b66afc6a 100644
> >>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> >>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> >>> @@ -14,6 +14,6 @@
> >>>  
> >>>  #define CLK_R_APB2	3
> >>>  
> >>> -#define CLK_NUMBER	(CLK_R_APB2_RSB + 1)
> >>> +#define CLK_NUMBER	(CLK_R_APB1_RTC + 1)
> >>>  
> >>>  #endif /* _CCU_SUN50I_H6_R_H */
> >>> diff --git a/include/dt-bindings/clock/sun50i-h6-r-ccu.h b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> >>> index 890368d252c4..a96087abc86f 100644
> >>> --- a/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> >>> +++ b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> >>> @@ -22,5 +22,6 @@
> >>>  #define CLK_W1			12
> >>>  
> >>>  #define CLK_R_APB2_RSB		13
> >>> +#define CLK_R_APB1_RTC		14
> >>>  
> >>>  #endif /* _DT_BINDINGS_CLK_SUN50I_H6_R_CCU_H_ */
> >>>     
> >>
> >>  
> >   
> 

