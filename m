Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F5526B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384085AbiEMURK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350826AbiEMURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:17:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E813F62;
        Fri, 13 May 2022 13:17:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a5so8973860wrp.7;
        Fri, 13 May 2022 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AH3Twv2cDKO4PnwItSWLy467GPyS13DYbuX6H4dtOfk=;
        b=gZ4GGp7LpiiHosXavOc8gQ/wUPUiQj9fbZZjdwD0cURk3Ze+2P9fWptU9fM9qyJjsg
         74yfGFR5mW5laQwboTv4At62yatCI0s56djwGszugjJp6wQbwFc9dQoYp/9sKJe45c82
         yHtV5VT+ajmDOd4S1LNp+9shkEDbvwkz3zYkF7Te7G/58AASlHJhMYFOnda+Vd1tCkF+
         1E2S5FUVl3My8VlUPVjb8cj1KQHZO6MhP6BatO7j7FIHTL2lQavWBuvAacW7RT2fH5Aw
         RUbMRN9ibXaufcqynaycNgjsDwASXyoDkvZG7hyDrcGhCMcBih0M2qdcVJBgozv25mp5
         SBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AH3Twv2cDKO4PnwItSWLy467GPyS13DYbuX6H4dtOfk=;
        b=WuEXDcG+0xbmROVKaJo6t8DtmT5TK2Jhvh6ML6kbeM820ZlQdfJNsE5bE/+nc0nvnZ
         /zkyBdK7kjfAEO6a8qc6nawkFzV3CGuGAAOPaVZxrU90A1IhVybcisajkbhsNGIVm2Bk
         GjdmQE7/rBNLg9zzhmdyHgrQMgyQcy60shl2caIhZ0tIGDF/C0jGboTbYmwnMCnzId46
         aBYCDvrhHtUIDMyzWq1P+DlgxDvwyG5TPdkKZHheUbT6y1iKCjHGfSxgT8X+N6OmskP8
         CaNwxo6LPzfzifswd8fUqn5fPWGWp7kIlGdhTmVeUJ2dtK5IvlyDFKUudPqsq4pnMT8M
         VS0w==
X-Gm-Message-State: AOAM5317x+YhUcAKKuL/SCXZdjmiz7U5pAoS/0iZHJP0cghW6rQdUpUL
        sDBN7nB3rqjAtGNH/SLDoz8=
X-Google-Smtp-Source: ABdhPJyG5Xx+Y28S93TTQKppba6xLMMvszgaMdDm4GqbQvAsQvT2sU2IJ4cKFUTCElb9JxcRPTEg6Q==
X-Received: by 2002:a05:6000:1e09:b0:20c:dbc7:e391 with SMTP id bj9-20020a0560001e0900b0020cdbc7e391mr5392412wrb.218.1652473025236;
        Fri, 13 May 2022 13:17:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:1670:c:db50:2f51:85b4:f668:c64f])
        by smtp.gmail.com with ESMTPSA id x15-20020adfcc0f000000b0020c5253d923sm3064224wrh.111.2022.05.13.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:17:04 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-mediatek: Implement CPUXGPT timers
Date:   Sat, 14 May 2022 00:14:42 +0400
Message-Id: <20220513201442.13569-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509210741.12020-3-angelogioacchino.delregno@collabora.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <yassine.oudjana@gmail.com>

On Mon,  9 May 2022 23:07:40 +0200, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> Some MediaTek platforms with a buggy TrustZone ATF firmware will not
> initialize the AArch64 System Timer correctly: in these cases, the
> System Timer address is correctly programmed, as well as the CNTFRQ_EL0
> register (reading 13MHz, as it should be), but the assigned hardware
> timers are never started before (or after) booting Linux.
> 
> In this condition, any call to function get_cycles() will be returning
> zero, as CNTVCT_EL0 will always read zero.

I spent a lot of time trying to figure out why the arch timer didn't
work on MT6737T and never got any results. Turns out this is why...

I ended up using the GPT (@ 0x10004000) as a system timer and it
worked fine.

With this patch the arch timer started to work finally. Thanks for
the fix! See below for one comment on this patch. 

> One common critical symptom of that is trying to use the udelay()
> function (calling __delay()), which executes the following loop:
> 
>             start = get_cycles();
>             while ((get_cycles() - start) < cycles)
>                     cpu_relax();
> 
> which, when CNTVCT_EL0 always reads zero, translates to:
> 
>             while((0 - 0) < 0)  ==> while(0 < 0)
> 
> ... generating an infinite loop, even though zero is never less
> than zero, but always equal to it (this has to be researched,
> but it's out of the scope of this commit).
> 
> To fix this issue on the affected MediaTek platforms, the solution
> is to simply start the timers that are designed to be System Timer(s).
> These timers, downstream, are called "CPUXGPT" and there is one
> timer per CPU core; luckily, it is not necessary to set a start bit
> on each CPUX General Purpose Timer, but it's conveniently enough to:
>  - Set the clock divider (input = 26MHz, divider = 2, output = 13MHz);
>  - Set the ENABLE bit on a global register (starts all CPUX timers).
> 
> The only small hurdle with this setup is that it's all done through
> the MCUSYS wrapper, where it is needed, for each read or write, to
> select a register address (by writing it to an index register) and
> then to perform any R/W on a "CON" register.
> 
> For example, writing "0x1" to the CPUXGPT register offset 0x4:
> - Write 0x4 to mcusys INDEX register
> - Write 0x1 to mcusys CON register
> 
> Reading from CPUXGPT register offset 0x4:
> - Write 0x4 to mcusys INDEX register
> - Read mcusys CON register.
> 
> Finally, starting this timer makes platforms affected by this issue
> to work correctly.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clocksource/timer-mediatek.c | 119 +++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 7bcb4a3f26fb..a3e90047f9ac 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -22,6 +22,19 @@
>  
>  #define TIMER_SYNC_TICKS        (3)
>  
> +/* cpux mcusys wrapper */
> +#define CPUX_CON_REG		0x0
> +#define CPUX_IDX_REG		0x4
> +
> +/* cpux */
> +#define CPUX_IDX_GLOBAL_CTRL	0x0
> + #define CPUX_ENABLE		BIT(0)
> + #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
> + #define CPUX_CLK_DIV1		BIT(8)
> + #define CPUX_CLK_DIV2		BIT(9)
> + #define CPUX_CLK_DIV4		BIT(10)
> +#define CPUX_IDX_GLOBAL_IRQ	0x30
> +
>  /* gpt */
>  #define GPT_IRQ_EN_REG          0x00
>  #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
> @@ -72,6 +85,57 @@
>  
>  static void __iomem *gpt_sched_reg __read_mostly;
>  
> +static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
> +{
> +	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
> +	return readl(timer_of_base(to) + CPUX_CON_REG);
> +}
> +
> +static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
> +{
> +	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
> +	writel(val, timer_of_base(to) + CPUX_CON_REG);
> +}
> +
> +static void mtk_cpux_disable_irq(struct timer_of *to)
> +{
> +	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
> +	u32 val;
> +
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
> +	val &= ~(*irq_mask);
> +	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
> +}
> +
> +static void mtk_cpux_enable_irq(struct timer_of *to)
> +{
> +	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
> +	u32 val;
> +
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
> +	val |= *irq_mask;
> +	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
> +}
> +
> +static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
> +{
> +	/* Clear any irq */
> +	mtk_cpux_disable_irq(to_timer_of(clkevt));
> +
> +	/*
> +	 * Disabling CPUXGPT timer will crash the platform, especially
> +	 * if Trusted Firmware is using it (usually, for sleep states),
> +	 * so we only mask the IRQ and call it a day.
> +	 */
> +	return 0;
> +}
> +
> +static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
> +{
> +	mtk_cpux_enable_irq(to_timer_of(clkevt));
> +	return 0;
> +}
> +
>  static void mtk_syst_ack_irq(struct timer_of *to)
>  {
>  	/* Clear and disable interrupt */
> @@ -281,6 +345,60 @@ static struct timer_of to = {
>  	},
>  };
>  
> +static int __init mtk_cpux_init(struct device_node *node)
> +{
> +	static struct timer_of to_cpux;
> +	u32 freq, val;
> +	int ret;
> +
> +	/*
> +	 * There are per-cpu interrupts for the CPUX General Purpose Timer
> +	 * but since this timer feeds the AArch64 System Timer we can rely
> +	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
> +	 */
> +	to_cpux.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
> +	to_cpux.clkevt.name = "mtk-cpuxgpt";
> +	to_cpux.clkevt.rating = 10;
> +	to_cpux.clkevt.cpumask = cpu_possible_mask;
> +	to_cpux.clkevt.set_state_shutdown = mtk_cpux_clkevt_shutdown;
> +	to_cpux.clkevt.tick_resume = mtk_cpux_clkevt_resume;
> +
> +	/* If this fails, bad things are about to happen... */
> +	ret = timer_of_init(node, &to_cpux);
> +	if (ret) {
> +		WARN(1, "Cannot start CPUX timers.\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Check if we're given a clock with the right frequency for this
> +	 * timer, otherwise warn but keep going with the setup anyway, as
> +	 * that makes it possible to still boot the kernel, even though
> +	 * it may not work correctly (random lockups, etc).
> +	 * The reason behind this is that having an early UART may not be
> +	 * possible for everyone and this gives a chance to retrieve kmsg
> +	 * for eventual debugging even on consumer devices.
> +	 */
> +	freq = timer_of_rate(&to_cpux);
> +	if (freq > 13000000)

Input clock is 26MHz and is then divided by 2 in CPUXGPT, so shouldn't
this be 26000000 instead? I get a warning here with 26MHz system clock
supplied:

clocks {
	...
	clk26m: clk26m {
		compatible = "fixed-clock";
		clock-frequency = <26000000>;
		#clock-cells = <0>;
	};
	...
};
...
soc {
	...
	cpuxgpt: timer@10200670 {
		compatible = "mediatek,mt6795-systimer";
		reg = <0 0x10200670 0 0x8>;
		clocks = <&clk26m>;
	};
	...
};

> +		WARN(1, "Requested unsupported timer frequency %u\n", freq);
> +
> +	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +	val &= ~CPUX_CLK_DIV_MASK;
> +	val |= CPUX_CLK_DIV2;
> +	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +
> +	/* Enable all CPUXGPT timers */
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +
> +	clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
> +	return 0;
> +}
> +
>  static int __init mtk_syst_init(struct device_node *node)
>  {
>  	int ret;
> @@ -339,3 +457,4 @@ static int __init mtk_gpt_init(struct device_node *node)
>  }
>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>  TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> +TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
> -- 
> 2.35.1
