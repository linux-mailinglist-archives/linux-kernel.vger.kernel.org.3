Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A74DCD33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiCQSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiCQSKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829181AA8E4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:09:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nUuYz-0000We-3y; Thu, 17 Mar 2022 19:09:29 +0100
Message-ID: <cc130250-cf3b-b9a6-726c-dba091d56960@pengutronix.de>
Date:   Thu, 17 Mar 2022 19:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 1/2] clocksource/drivers/timer-imx-gpt: Support i.MX
 GPT input capture function
Content-Language: en-US
To:     Kane Jiang <jian.jiang@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220304015623.338645-1-jian.jiang@nxp.com>
 <20220304015623.338645-2-jian.jiang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org
In-Reply-To: <20220304015623.338645-2-jian.jiang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kane,

On 04.03.22 02:56, Kane Jiang wrote:
> From: Steve Longerbeam <slongerbeam@gmail.com>
> 
> This patch adds support for the input capture function in the i.MX GPT.
> Output compare and input capture functions are mixed in the same register
> block, so we need to modify the irq ack/enable/disable primitives to not
> stomp on the other function.
> 
> The input capture API is modelled after request/free irq:
> 
> typedef void (*mxc_icap_handler_t)(int, void *, ktime_t);
> 
> int mxc_request_input_capture(unsigned int chan,
> 			      mxc_icap_handler_t handler,
> 			      unsigned long capflags, void *dev_id);
> 
>     - chan: the channel number being requested (0 or 1).
> 
>     - handler: a callback when there is an input capture event. The
>       handler is given the channel number, the dev_id, and a ktime_t
>       marking the input capture event.
> 
>     - capflags: IRQF_TRIGGER_RISING and/or IRQF_TRIGGER_FALLING. If
>       both are specified, events will be triggered on both rising and
>       falling edges of the input capture signal.
> 
>     - dev_id: a context pointer given back to the handler.
> 
> void mxc_free_input_capture(unsigned int chan, void *dev_id);
> 
>     This disables the given input capture channel in the GPT.
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> Signed-off-by: Kane Jiang <jian.jiang@nxp.com>

Judging from the Copyright year, you've been carrying this patch for a while.

In the meantime, a counter subsystem has been merged into the kernel, which
is likely what you should interface with here, instead of bolting a new in-kernel
API onto a clocksource driver without any upstream users.

Cheers,
Ahmad

> ---
> V2:
>  - add a brief commit subject
> ---
>  drivers/clocksource/timer-imx-gpt.c | 479 +++++++++++++++++++++++++---
>  include/linux/mxc_icap.h            |  16 +
>  2 files changed, 445 insertions(+), 50 deletions(-)
>  create mode 100644 include/linux/mxc_icap.h
> 
> diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
> index 7b2c70f2f353..c6aa1462e441 100644
> --- a/drivers/clocksource/timer-imx-gpt.c
> +++ b/drivers/clocksource/timer-imx-gpt.c
> @@ -5,9 +5,11 @@
>  //  Copyright (C) 2006-2007 Pavel Pisa (ppisa@pikron.com)
>  //  Copyright (C) 2008 Juergen Beisert (kernel@pengutronix.de)
>  
> +#include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/clockchips.h>
> +#include <linux/timecounter.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -16,6 +18,8 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/mxc_icap.h>
>  #include <soc/imx/timer.h>
>  
>  /*
> @@ -49,16 +53,52 @@
>  #define V2_TCTL_CLK_PER		(2 << 6)
>  #define V2_TCTL_CLK_OSC_DIV8	(5 << 6)
>  #define V2_TCTL_FRR		(1 << 9)
> +#define V2_TCTL_IM1_BIT		16
> +#define V2_TCTL_IM2_BIT		18
> +#define V2_IM_DISABLE		0
> +#define V2_IM_RISING		1
> +#define V2_IM_FALLING		2
> +#define V2_IM_BOTH		3
>  #define V2_TCTL_24MEN		(1 << 10)
>  #define V2_TPRER_PRE24M		12
>  #define V2_IR			0x0c
> +#define V2_IR_OF1		(1 << 0)
> +#define V2_IR_IF1		(1 << 3)
> +#define V2_IR_IF2		(1 << 4)
>  #define V2_TSTAT		0x08
>  #define V2_TSTAT_OF1		(1 << 0)
> +#define V2_TSTAT_IF1		(1 << 3)
> +#define V2_TSTAT_IF2		(1 << 4)
>  #define V2_TCN			0x24
>  #define V2_TCMP			0x10
> +#define V2_TCAP1		0x1c
> +#define V2_TCAP2		0x20
>  
>  #define V2_TIMER_RATE_OSC_DIV8	3000000
>  
> +struct imx_timer;
> +
> +struct icap_channel {
> +	struct imx_timer *imxtm;
> +
> +	int chan;
> +
> +	u32 cnt_reg;
> +	u32 irqen_bit;
> +	u32 status_bit;
> +	u32 mode_bit;
> +
> +	mxc_icap_handler_t handler;
> +	void *dev_id;
> +
> +	struct cyclecounter cc;
> +	struct timecounter tc;
> +};
> +
> +/* FIXME, for now can't find icap unless it's statically allocated */
> +static struct icap_channel icap_channel[2];
> +static DEFINE_SPINLOCK(icap_lock);
> +
>  struct imx_timer {
>  	enum imx_gpt_type type;
>  	void __iomem *base;
> @@ -73,12 +113,20 @@ struct imx_gpt_data {
>  	int reg_tstat;
>  	int reg_tcn;
>  	int reg_tcmp;
> -	void (*gpt_setup_tctl)(struct imx_timer *imxtm);
> -	void (*gpt_irq_enable)(struct imx_timer *imxtm);
> -	void (*gpt_irq_disable)(struct imx_timer *imxtm);
> -	void (*gpt_irq_acknowledge)(struct imx_timer *imxtm);
> +	void (*gpt_oc_setup_tctl)(struct imx_timer *imxtm);
> +	void (*gpt_oc_irq_enable)(struct imx_timer *imxtm);
> +	void (*gpt_oc_irq_disable)(struct imx_timer *imxtm);
> +	void (*gpt_oc_irq_acknowledge)(struct imx_timer *imxtm);
> +	bool (*gpt_is_oc_irq)(struct imx_timer *imxtm, unsigned int tstat);
>  	int (*set_next_event)(unsigned long evt,
>  			      struct clock_event_device *ced);
> +
> +	void (*gpt_ic_irq_enable)(struct icap_channel *ic);
> +	void (*gpt_ic_irq_disable)(struct icap_channel *ic);
> +	void (*gpt_ic_irq_acknowledge)(struct icap_channel *ic);
> +	bool (*gpt_is_ic_irq)(struct icap_channel *ic, unsigned int tstat);
> +	void (*gpt_ic_enable)(struct icap_channel *ic, unsigned int mode);
> +	void (*gpt_ic_disable)(struct icap_channel *ic);
>  };
>  
>  static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
> @@ -86,52 +134,144 @@ static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
>  	return container_of(ced, struct imx_timer, ced);
>  }
>  
> -static void imx1_gpt_irq_disable(struct imx_timer *imxtm)
> +static void imx1_gpt_oc_irq_disable(struct imx_timer *imxtm)
>  {
>  	unsigned int tmp;
>  
>  	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
>  	writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
>  }
> -#define imx21_gpt_irq_disable imx1_gpt_irq_disable
> +#define imx21_gpt_oc_irq_disable imx1_gpt_oc_irq_disable
>  
> -static void imx31_gpt_irq_disable(struct imx_timer *imxtm)
> +static void imx31_gpt_oc_irq_disable(struct imx_timer *imxtm)
>  {
> -	writel_relaxed(0, imxtm->base + V2_IR);
> +	unsigned int tmp;
> +
> +	tmp = readl_relaxed(imxtm->base + V2_IR);
> +	writel_relaxed(tmp & ~V2_IR_OF1, imxtm->base + V2_IR);
>  }
> -#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
> +#define imx6dl_gpt_oc_irq_disable imx31_gpt_oc_irq_disable
>  
> -static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
> +static void imx1_gpt_oc_irq_enable(struct imx_timer *imxtm)
>  {
>  	unsigned int tmp;
>  
>  	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
>  	writel_relaxed(tmp | MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
>  }
> -#define imx21_gpt_irq_enable imx1_gpt_irq_enable
> +#define imx21_gpt_oc_irq_enable imx1_gpt_oc_irq_enable
>  
> -static void imx31_gpt_irq_enable(struct imx_timer *imxtm)
> +static void imx31_gpt_oc_irq_enable(struct imx_timer *imxtm)
>  {
> -	writel_relaxed(1<<0, imxtm->base + V2_IR);
> +	unsigned int tmp;
> +
> +	tmp = readl_relaxed(imxtm->base + V2_IR);
> +	writel_relaxed(tmp | V2_IR_OF1, imxtm->base + V2_IR);
>  }
> -#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
> +#define imx6dl_gpt_oc_irq_enable imx31_gpt_oc_irq_enable
>  
> -static void imx1_gpt_irq_acknowledge(struct imx_timer *imxtm)
> +static void imx1_gpt_oc_irq_acknowledge(struct imx_timer *imxtm)
>  {
>  	writel_relaxed(0, imxtm->base + MX1_2_TSTAT);
>  }
>  
> -static void imx21_gpt_irq_acknowledge(struct imx_timer *imxtm)
> +static void imx21_gpt_oc_irq_acknowledge(struct imx_timer *imxtm)
>  {
>  	writel_relaxed(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
>  				imxtm->base + MX1_2_TSTAT);
>  }
>  
> -static void imx31_gpt_irq_acknowledge(struct imx_timer *imxtm)
> +static bool imx1_gpt_is_oc_irq(struct imx_timer *imxtm, unsigned int tstat)
> +{
> +	return true;
> +}
> +
> +static bool imx21_gpt_is_oc_irq(struct imx_timer *imxtm, unsigned int tstat)
> +{
> +	return (tstat & MX2_TSTAT_COMP) != 0;
> +}
> +
> +static bool imx31_gpt_is_oc_irq(struct imx_timer *imxtm, unsigned int tstat)
> +{
> +	return (tstat & V2_TSTAT_OF1) != 0;
> +}
> +#define imx6dl_gpt_is_oc_irq imx31_gpt_is_oc_irq
> +
> +static void imx31_gpt_oc_irq_acknowledge(struct imx_timer *imxtm)
>  {
>  	writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
>  }
> -#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
> +#define imx6dl_gpt_oc_irq_acknowledge imx31_gpt_oc_irq_acknowledge
> +
> +static void imx31_gpt_ic_irq_disable(struct icap_channel *ic)
> +{
> +	struct imx_timer *imxtm = ic->imxtm;
> +	unsigned int tmp;
> +
> +	tmp = readl_relaxed(imxtm->base + V2_IR);
> +	tmp &= ~ic->irqen_bit;
> +	writel_relaxed(tmp, imxtm->base + V2_IR);
> +}
> +#define imx6dl_gpt_ic_irq_disable imx31_gpt_ic_irq_disable
> +
> +static void imx31_gpt_ic_irq_enable(struct icap_channel *ic)
> +{
> +	struct imx_timer *imxtm = ic->imxtm;
> +	unsigned int tmp;
> +
> +	tmp = readl_relaxed(imxtm->base + V2_IR);
> +	tmp |= ic->irqen_bit;
> +	writel_relaxed(tmp, imxtm->base + V2_IR);
> +}
> +#define imx6dl_gpt_ic_irq_enable imx31_gpt_ic_irq_enable
> +
> +static void imx31_gpt_ic_irq_acknowledge(struct icap_channel *ic)
> +{
> +	struct imx_timer *imxtm = ic->imxtm;
> +
> +	writel_relaxed(ic->status_bit, imxtm->base + V2_TSTAT);
> +}
> +#define imx6dl_gpt_ic_irq_acknowledge imx31_gpt_ic_irq_acknowledge
> +
> +static bool imx1_gpt_is_ic_irq(struct icap_channel *ic, unsigned int tstat)
> +{
> +	return false;
> +}
> +#define imx21_gpt_is_ic_irq imx1_gpt_is_ic_irq
> +
> +static bool imx31_gpt_is_ic_irq(struct icap_channel *ic, unsigned int tstat)
> +{
> +	return (tstat & ic->status_bit) != 0;
> +}
> +#define imx6dl_gpt_is_ic_irq imx31_gpt_is_ic_irq
> +
> +static void imx31_gpt_ic_enable(struct icap_channel *ic, unsigned int mode)
> +{
> +	struct imx_timer *imxtm = ic->imxtm;
> +	unsigned int tctl, mask;
> +
> +	mask = 0x3 << ic->mode_bit;
> +	mode <<= ic->mode_bit;
> +
> +	tctl = readl_relaxed(imxtm->base + MXC_TCTL);
> +	tctl &= ~mask;
> +	tctl |= mode;
> +	writel_relaxed(tctl, imxtm->base + MXC_TCTL);
> +}
> +#define imx6dl_gpt_ic_enable imx31_gpt_ic_enable
> +
> +static void imx31_gpt_ic_disable(struct icap_channel *ic)
> +{
> +	struct imx_timer *imxtm = ic->imxtm;
> +	unsigned int tctl, mask;
> +
> +	mask = 0x3 << ic->mode_bit;
> +
> +	tctl = readl_relaxed(imxtm->base + MXC_TCTL);
> +	tctl &= ~mask;
> +	writel_relaxed(tctl, imxtm->base + MXC_TCTL);
> +}
> +#define imx6dl_gpt_ic_disable imx31_gpt_ic_disable
>  
>  static void __iomem *sched_clock_reg;
>  
> @@ -149,6 +289,19 @@ static unsigned long imx_read_current_timer(void)
>  }
>  #endif
>  
> +static u64 mxc_clocksource_read(struct clocksource *cs)
> +{
> +	return mxc_read_sched_clock();
> +}
> +
> +static struct clocksource clocksource_mxc = {
> +	.name = "mxc_timer1",
> +	.rating = 200,
> +	.mask = CLOCKSOURCE_MASK(32),
> +	.read = mxc_clocksource_read,
> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
>  static int __init mxc_clocksource_init(struct imx_timer *imxtm)
>  {
>  	unsigned int c = clk_get_rate(imxtm->clk_per);
> @@ -163,8 +316,7 @@ static int __init mxc_clocksource_init(struct imx_timer *imxtm)
>  	sched_clock_reg = reg;
>  
>  	sched_clock_register(mxc_read_sched_clock, 32, c);
> -	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
> -			clocksource_mmio_readl_up);
> +	return clocksource_register_hz(&clocksource_mxc, c);
>  }
>  
>  /* clock event */
> @@ -204,14 +356,14 @@ static int mxc_shutdown(struct clock_event_device *ced)
>  	u32 tcn;
>  
>  	/* Disable interrupt in GPT module */
> -	imxtm->gpt->gpt_irq_disable(imxtm);
> +	imxtm->gpt->gpt_oc_irq_disable(imxtm);
>  
>  	tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
>  	/* Set event time into far-far future */
>  	writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
>  
>  	/* Clear pending interrupt */
> -	imxtm->gpt->gpt_irq_acknowledge(imxtm);
> +	imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
>  
>  #ifdef DEBUG
>  	printk(KERN_INFO "%s: changing mode\n", __func__);
> @@ -225,7 +377,7 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
>  	struct imx_timer *imxtm = to_imx_timer(ced);
>  
>  	/* Disable interrupt in GPT module */
> -	imxtm->gpt->gpt_irq_disable(imxtm);
> +	imxtm->gpt->gpt_oc_irq_disable(imxtm);
>  
>  	if (!clockevent_state_oneshot(ced)) {
>  		u32 tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
> @@ -233,7 +385,7 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
>  		writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
>  
>  		/* Clear pending interrupt */
> -		imxtm->gpt->gpt_irq_acknowledge(imxtm);
> +		imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
>  	}
>  
>  #ifdef DEBUG
> @@ -246,7 +398,7 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
>  	 * to call mxc_set_next_event() or shutdown clock after
>  	 * mode switching
>  	 */
> -	imxtm->gpt->gpt_irq_enable(imxtm);
> +	imxtm->gpt->gpt_oc_irq_enable(imxtm);
>  
>  	return 0;
>  }
> @@ -259,12 +411,29 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
>  	struct clock_event_device *ced = dev_id;
>  	struct imx_timer *imxtm = to_imx_timer(ced);
>  	uint32_t tstat;
> +	int i;
>  
>  	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
>  
> -	imxtm->gpt->gpt_irq_acknowledge(imxtm);
> +	for (i = 0; i < 2; i++) {
> +		struct icap_channel *ic = &icap_channel[i];
> +		ktime_t timestamp;
>  
> -	ced->event_handler(ced);
> +		if (!imxtm->gpt->gpt_is_ic_irq(ic, tstat))
> +			continue;
> +
> +		imxtm->gpt->gpt_ic_irq_acknowledge(ic);
> +
> +		timestamp = ns_to_ktime(timecounter_read(&ic->tc));
> +
> +		if (ic->handler)
> +			ic->handler(ic->chan, ic->dev_id, timestamp);
> +	}
> +
> +	if (imxtm->gpt->gpt_is_oc_irq(imxtm, tstat)) {
> +		imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
> +		ced->event_handler(ced);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -289,16 +458,16 @@ static int __init mxc_clockevent_init(struct imx_timer *imxtm)
>  			   IRQF_TIMER | IRQF_IRQPOLL, "i.MX Timer Tick", ced);
>  }
>  
> -static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
> +static void imx1_gpt_oc_setup_tctl(struct imx_timer *imxtm)
>  {
>  	u32 tctl_val;
>  
>  	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
>  	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
>  }
> -#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
> +#define imx21_gpt_oc_setup_tctl imx1_gpt_oc_setup_tctl
>  
> -static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
> +static void imx31_gpt_oc_setup_tctl(struct imx_timer *imxtm)
>  {
>  	u32 tctl_val;
>  
> @@ -311,7 +480,7 @@ static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
>  	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
>  }
>  
> -static void imx6dl_gpt_setup_tctl(struct imx_timer *imxtm)
> +static void imx6dl_gpt_oc_setup_tctl(struct imx_timer *imxtm)
>  {
>  	u32 tctl_val;
>  
> @@ -332,10 +501,12 @@ static const struct imx_gpt_data imx1_gpt_data = {
>  	.reg_tstat = MX1_2_TSTAT,
>  	.reg_tcn = MX1_2_TCN,
>  	.reg_tcmp = MX1_2_TCMP,
> -	.gpt_irq_enable = imx1_gpt_irq_enable,
> -	.gpt_irq_disable = imx1_gpt_irq_disable,
> -	.gpt_irq_acknowledge = imx1_gpt_irq_acknowledge,
> -	.gpt_setup_tctl = imx1_gpt_setup_tctl,
> +	.gpt_oc_irq_enable = imx1_gpt_oc_irq_enable,
> +	.gpt_oc_irq_disable = imx1_gpt_oc_irq_disable,
> +	.gpt_oc_irq_acknowledge = imx1_gpt_oc_irq_acknowledge,
> +	.gpt_is_oc_irq = imx1_gpt_is_oc_irq,
> +	.gpt_is_ic_irq = imx1_gpt_is_ic_irq,
> +	.gpt_oc_setup_tctl = imx1_gpt_oc_setup_tctl,
>  	.set_next_event = mx1_2_set_next_event,
>  };
>  
> @@ -343,10 +514,12 @@ static const struct imx_gpt_data imx21_gpt_data = {
>  	.reg_tstat = MX1_2_TSTAT,
>  	.reg_tcn = MX1_2_TCN,
>  	.reg_tcmp = MX1_2_TCMP,
> -	.gpt_irq_enable = imx21_gpt_irq_enable,
> -	.gpt_irq_disable = imx21_gpt_irq_disable,
> -	.gpt_irq_acknowledge = imx21_gpt_irq_acknowledge,
> -	.gpt_setup_tctl = imx21_gpt_setup_tctl,
> +	.gpt_oc_irq_enable = imx21_gpt_oc_irq_enable,
> +	.gpt_oc_irq_disable = imx21_gpt_oc_irq_disable,
> +	.gpt_oc_irq_acknowledge = imx21_gpt_oc_irq_acknowledge,
> +	.gpt_is_oc_irq = imx21_gpt_is_oc_irq,
> +	.gpt_is_ic_irq = imx21_gpt_is_ic_irq,
> +	.gpt_oc_setup_tctl = imx21_gpt_oc_setup_tctl,
>  	.set_next_event = mx1_2_set_next_event,
>  };
>  
> @@ -354,27 +527,160 @@ static const struct imx_gpt_data imx31_gpt_data = {
>  	.reg_tstat = V2_TSTAT,
>  	.reg_tcn = V2_TCN,
>  	.reg_tcmp = V2_TCMP,
> -	.gpt_irq_enable = imx31_gpt_irq_enable,
> -	.gpt_irq_disable = imx31_gpt_irq_disable,
> -	.gpt_irq_acknowledge = imx31_gpt_irq_acknowledge,
> -	.gpt_setup_tctl = imx31_gpt_setup_tctl,
> +	.gpt_oc_irq_enable = imx31_gpt_oc_irq_enable,
> +	.gpt_oc_irq_disable = imx31_gpt_oc_irq_disable,
> +	.gpt_oc_irq_acknowledge = imx31_gpt_oc_irq_acknowledge,
> +	.gpt_is_oc_irq = imx31_gpt_is_oc_irq,
> +	.gpt_oc_setup_tctl = imx31_gpt_oc_setup_tctl,
>  	.set_next_event = v2_set_next_event,
> +
> +	/* input capture methods */
> +	.gpt_ic_irq_enable = imx31_gpt_ic_irq_enable,
> +	.gpt_ic_irq_disable = imx31_gpt_ic_irq_disable,
> +	.gpt_ic_irq_acknowledge = imx31_gpt_ic_irq_acknowledge,
> +	.gpt_is_ic_irq = imx31_gpt_is_ic_irq,
> +	.gpt_ic_enable = imx31_gpt_ic_enable,
> +	.gpt_ic_disable = imx31_gpt_ic_disable,
>  };
>  
>  static const struct imx_gpt_data imx6dl_gpt_data = {
>  	.reg_tstat = V2_TSTAT,
>  	.reg_tcn = V2_TCN,
>  	.reg_tcmp = V2_TCMP,
> -	.gpt_irq_enable = imx6dl_gpt_irq_enable,
> -	.gpt_irq_disable = imx6dl_gpt_irq_disable,
> -	.gpt_irq_acknowledge = imx6dl_gpt_irq_acknowledge,
> -	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
> +	.gpt_oc_irq_enable = imx6dl_gpt_oc_irq_enable,
> +	.gpt_oc_irq_disable = imx6dl_gpt_oc_irq_disable,
> +	.gpt_oc_irq_acknowledge = imx6dl_gpt_oc_irq_acknowledge,
> +	.gpt_is_oc_irq = imx6dl_gpt_is_oc_irq,
> +	.gpt_oc_setup_tctl = imx6dl_gpt_oc_setup_tctl,
>  	.set_next_event = v2_set_next_event,
> +
> +	/* input capture methods */
> +	.gpt_ic_irq_enable = imx6dl_gpt_ic_irq_enable,
> +	.gpt_ic_irq_disable = imx6dl_gpt_ic_irq_disable,
> +	.gpt_ic_irq_acknowledge = imx6dl_gpt_ic_irq_acknowledge,
> +	.gpt_is_ic_irq = imx6dl_gpt_is_ic_irq,
> +	.gpt_ic_enable = imx6dl_gpt_ic_enable,
> +	.gpt_ic_disable = imx6dl_gpt_ic_disable,
>  };
>  
> +static u64 gpt_ic_read(const struct cyclecounter *cc)
> +{
> +	struct icap_channel *ic = container_of(cc, struct icap_channel, cc);
> +	struct imx_timer *imxtm = ic->imxtm;
> +
> +	return readl_relaxed(imxtm->base + ic->cnt_reg);
> +}
> +
> +int mxc_request_input_capture(unsigned int chan, mxc_icap_handler_t handler,
> +			      unsigned long capflags, void *dev_id)
> +{
> +	struct imx_timer *imxtm;
> +	struct icap_channel *ic;
> +	unsigned long flags;
> +	u64 start_cycles;
> +	int ret = 0;
> +	u32 mode;
> +
> +	/* we only care about rising and falling flags */
> +	capflags &= (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING);
> +
> +	if (chan > 1 || !handler || !capflags)
> +		return -EINVAL;
> +
> +	ic = &icap_channel[chan];
> +	imxtm = ic->imxtm;
> +
> +	if (!imxtm->gpt->gpt_ic_enable)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&icap_lock, flags);
> +
> +	if (ic->handler) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	ic->handler = handler;
> +	ic->dev_id = dev_id;
> +
> +	switch (capflags) {
> +	case IRQF_TRIGGER_RISING:
> +		mode = V2_IM_RISING;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		mode = V2_IM_FALLING;
> +		break;
> +	default:
> +		mode = V2_IM_BOTH;
> +		break;
> +	}
> +
> +	/* ack any pending input capture interrupt before enabling */
> +	imxtm->gpt->gpt_ic_irq_acknowledge(ic);
> +
> +	/*
> +	 * initialize the cyclecounter. The input capture is capturing
> +	 * from the mxc clocksource, so it has the same mask/shift/mult.
> +	 */
> +	memset(&ic->cc, 0, sizeof(ic->cc));
> +	ic->cc.read = gpt_ic_read;
> +	ic->cc.mask = clocksource_mxc.mask;
> +	ic->cc.shift = clocksource_mxc.shift;
> +	ic->cc.mult = clocksource_mxc.mult;
> +
> +	/* initialize a timecounter for the input capture */
> +	start_cycles = mxc_read_sched_clock();
> +	timecounter_init(&ic->tc, &ic->cc, ktime_get_ns());
> +	/*
> +	 * timecounter_init() read the last captured timer count, but
> +	 * that's not the start cycle counter, so update it with the
> +	 * real start cycles.
> +	 */
> +	ic->tc.cycle_last = start_cycles;
> +
> +	imxtm->gpt->gpt_ic_enable(ic, mode);
> +	imxtm->gpt->gpt_ic_irq_enable(ic);
> +
> +out:
> +	spin_unlock_irqrestore(&icap_lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mxc_request_input_capture);
> +
> +void mxc_free_input_capture(unsigned int chan, void *dev_id)
> +{
> +	struct imx_timer *imxtm;
> +	struct icap_channel *ic;
> +	unsigned long flags;
> +
> +	if (chan > 1)
> +		return;
> +
> +	ic = &icap_channel[chan];
> +	imxtm = ic->imxtm;
> +
> +	if (!imxtm->gpt->gpt_ic_disable)
> +		return;
> +
> +	spin_lock_irqsave(&icap_lock, flags);
> +
> +	if (!ic->handler || dev_id != ic->dev_id)
> +		goto out;
> +
> +	imxtm->gpt->gpt_ic_irq_disable(ic);
> +	imxtm->gpt->gpt_ic_disable(ic);
> +
> +	ic->handler = NULL;
> +	ic->dev_id = NULL;
> +out:
> +	spin_unlock_irqrestore(&icap_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(mxc_free_input_capture);
> +
>  static int __init _mxc_timer_init(struct imx_timer *imxtm)
>  {
> -	int ret;
> +	struct icap_channel *ic;
> +	int i, ret;
>  
>  	switch (imxtm->type) {
>  	case GPT_TYPE_IMX1:
> @@ -410,14 +716,23 @@ static int __init _mxc_timer_init(struct imx_timer *imxtm)
>  	writel_relaxed(0, imxtm->base + MXC_TCTL);
>  	writel_relaxed(0, imxtm->base + MXC_TPRER); /* see datasheet note */
>  
> -	imxtm->gpt->gpt_setup_tctl(imxtm);
> +	imxtm->gpt->gpt_oc_setup_tctl(imxtm);
>  
>  	/* init and register the timer to the framework */
>  	ret = mxc_clocksource_init(imxtm);
>  	if (ret)
>  		return ret;
>  
> -	return mxc_clockevent_init(imxtm);
> +	ret = mxc_clockevent_init(imxtm);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < 2; i++) {
> +		ic = &icap_channel[i];
> +		ic->imxtm = imxtm;
> +	}
> +
> +	return 0;
>  }
>  
>  void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
> @@ -439,6 +754,70 @@ void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
>  	_mxc_timer_init(imxtm);
>  }
>  
> +/*
> + * a platform driver is needed in order to acquire pinmux
> + * for input capture pins. The probe call is also useful
> + * for setting up the input capture channel structures.
> + */
> +static int mxc_timer_probe(struct platform_device *pdev)
> +{
> +	struct icap_channel *ic;
> +	int i;
> +
> +	/* setup the input capture channels */
> +	for (i = 0; i < 2; i++) {
> +		ic = &icap_channel[i];
> +		ic->chan = i;
> +		if (i == 0) {
> +			ic->cnt_reg = V2_TCAP1;
> +			ic->irqen_bit = V2_IR_IF1;
> +			ic->status_bit = V2_TSTAT_IF1;
> +			ic->mode_bit = V2_TCTL_IM1_BIT;
> +		} else {
> +			ic->cnt_reg = V2_TCAP2;
> +			ic->irqen_bit = V2_IR_IF2;
> +			ic->status_bit = V2_TSTAT_IF2;
> +			ic->mode_bit = V2_TCTL_IM2_BIT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxc_timer_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static const struct of_device_id timer_of_match[] = {
> +	{ .compatible = "fsl,imx1-gpt" },
> +	{ .compatible = "fsl,imx21-gpt" },
> +	{ .compatible = "fsl,imx27-gpt" },
> +	{ .compatible = "fsl,imx31-gpt" },
> +	{ .compatible = "fsl,imx25-gpt" },
> +	{ .compatible = "fsl,imx50-gpt" },
> +	{ .compatible = "fsl,imx51-gpt" },
> +	{ .compatible = "fsl,imx53-gpt" },
> +	{ .compatible = "fsl,imx6q-gpt" },
> +	{ .compatible = "fsl,imx6dl-gpt" },
> +	{ .compatible = "fsl,imx6sl-gpt" },
> +	{ .compatible = "fsl,imx6sx-gpt" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, timer_of_match);
> +
> +static struct platform_driver mxc_timer_pdrv = {
> +	.probe		= mxc_timer_probe,
> +	.remove		= mxc_timer_remove,
> +	.driver		= {
> +		.name	= "mxc-timer",
> +		.owner	= THIS_MODULE,
> +		.of_match_table	= timer_of_match,
> +	},
> +};
> +
> +module_platform_driver(mxc_timer_pdrv);
> +
>  static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type type)
>  {
>  	struct imx_timer *imxtm;
> diff --git a/include/linux/mxc_icap.h b/include/linux/mxc_icap.h
> new file mode 100644
> index 000000000000..fa5ffdf3b589
> --- /dev/null
> +++ b/include/linux/mxc_icap.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * i.MX GPT Input Capture support.
> + *
> + * Copyright (C) 2015 Mentor Graphics, Inc. All Rights Reserved.
> + */
> +#ifndef __MXC_ICAP_H__
> +#define __MXC_ICAP_H__
> +
> +typedef void (*mxc_icap_handler_t)(int, void *, ktime_t);
> +
> +int mxc_request_input_capture(unsigned int chan, mxc_icap_handler_t handler,
> +			      unsigned long capflags, void *dev_id);
> +void mxc_free_input_capture(unsigned int chan, void *dev_id);
> +
> +#endif


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
