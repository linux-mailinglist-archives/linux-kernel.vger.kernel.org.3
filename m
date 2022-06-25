Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FCC55A90D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiFYKoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiFYKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:43:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA012A92;
        Sat, 25 Jun 2022 03:43:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e2so6692151edv.3;
        Sat, 25 Jun 2022 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aW4qIkW86Vdf1vFCbmOwdZe5y4/JqpNJsqdsqkmOSI=;
        b=FttiHQYp4hRHMayYQmDtQZVuq5SyEGV+6I0l3fN67WDHV1ACb5kbsHOeabSrjsNcvp
         rvGe/RR/s9uo7Bx5QHnnwfcz21CbRcx4mEF2mp1lmEKjraunMo9ZRwVZHueaMrIwSLiF
         359FmiIkPCfHrNCyn75Oob/zPPMIRROuxlbbr1K8YFtJgASNS0YQl99584r6XLkTy3LB
         wXpccWh93fAZxKQQwTmY3GmK7D0iZqs2dN5oglrmrYLe7cUWdtDBHzsPPa+fHnhuW7eA
         iR1aCQHcNe0OhJgAgQfpKnlzXZQ/wX9NPkZXEhRHDjLOnnW8GpyU0XhpnjkJYMbhuVo1
         glYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aW4qIkW86Vdf1vFCbmOwdZe5y4/JqpNJsqdsqkmOSI=;
        b=M7GfM6L+U7PNv1ln4uh8koGCcUAjUYWYjjTzS5ubJJEQEixliCZKpJQPwpyqntcU2d
         F15L6L5IfsELkFPm+bVfU9yWPCpM/7UTw83Cmr4/hIioxScXExdXCJV/Ck4YnfCbUhHq
         ng8h6lwDbH2vdSZE6U16JkQD8K/STfpSquBh5htDR7Re6k8Bwx9meJFDYchgCzamFkpb
         jTjk2WIwWRw6yfzJ/27fqjU5o0GCzUOFMuNS4y/KDWXCNi9HUXvpGFlwvbvNhc+olDIv
         v5npFIddjHxt0yU9MP2kDQZjXKxPgdmYENM8/DJNTUXA3axN+iG1cmOFgCFO1fuudURd
         +TBQ==
X-Gm-Message-State: AJIora9f1pobNZi8M09UBThp3K4uJgQWOP2w+kL8jxrCr66aiI58DnB9
        o7Sx7mn6sPVjE7OnLCEIjbk=
X-Google-Smtp-Source: AGRyM1vO6p+pwvghonjKX83gaxAyh9/RE44lFskiuPqOsUngK91OmnHFDnMwCUvdb2jGVMKo6Hp15w==
X-Received: by 2002:a05:6402:3594:b0:431:4cb8:c7b6 with SMTP id y20-20020a056402359400b004314cb8c7b6mr4295767edc.334.1656153837055;
        Sat, 25 Jun 2022 03:43:57 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm2518105ejl.98.2022.06.25.03.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:43:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     peron.clem@gmail.com, Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mripard@kernel.org,
        wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Sat, 25 Jun 2022 12:43:54 +0200
Message-ID: <1779483.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20220624165211.4318-1-r.stratiienko@gmail.com>
References: <20220624165211.4318-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Dne petek, 24. junij 2022 ob 18:52:11 CEST je Roman Stratiienko napisal(a):
> Using simple bash script it was discovered that not all CCU registers
> can be safely used for DFS, e.g.:
> 
>     while true
>     do
>         devmem 0x3001030 4 0xb0003e02
>         devmem 0x3001030 4 0xb0001e02
>     done
> 
> Script above changes the GPU_PLL multiplier register value. While the
> script is running, the user should interact with the user interface.
> 
> Using this method the following results were obtained:
> | Register  | Name           | Bits  | Values | Result |
> | --        | --             | --    | --     | --     |
> | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> 
> Once bits that caused system failure disabled (kept default 0),
> it was discovered that GPU_CLK.MUX was used during DFS for some
> reason and was causing the failure too.
> 
> After disabling GPU_PLL.OUTDIV the system started to fail during
> booting for some reason until the maximum frequency of GPU_PLL
> clock was limited to 756MHz.
> 
> After all the changes made DVFS started to work seamlessly.

I appreciate testing effort, but I don't think userspace approach is good way 
for testing DVFS. I see 2 issues:
- As name already suggest, voltage also plays crucial role for stability. You 
didn't say on which board you tested this, but I assume it has PMIC. Did you 
make sure GPU voltage regulator is always at 1.04 V, which is needed for 756 
MHz?
- Kernel clock driver always goes through proper procedure for clock rate 
change, which involves several steps. Bypassing them might also cause some 
stability problems.

I agree that GPU PLL should be limited to 756 MHz max. This seems to be 
maximum operating point specified at vendor DT. But I managed to extract some 
more information from vendor GPU driver. More specifically, from this snippet, 
located in modules/gpu/mali-midgard/kernel_mode/driver/drivers/gpu/arm/
midgard/platform/sunxi/mali_kbase_config_sunxi.c:

pll_freq = target->freq;
while (pll_freq < 288000000)
	pll_freq *= 2;

err = clk_set_rate(sunxi_mali->gpu_pll_clk, pll_freq);
<...>
err = clk_set_rate(kbdev->clock, target->freq);
<...>

Apparently, minimum stable PLL frequency is 288 MHz (this should be added) and 
divider in peripheral clock can really be used, although preferably not. 
Vendor GPU operating points specify only 2 lower than 288 MHz points - at 264 
MHz and 216 MHz. I'm fully aware that they may not be really stable and given 
that these two and next two all share minimum voltage of 810 mV, power and 
thermal savings are probably not that great, so we can skip them and pin 
peripheral divider to 1, as you already did.

Another discrepancy I see is that vendor DT has two operating points, at 336 
MHz and 384 MHz, which also use factor P (also known as d2 in vendor clock 
source). This can be again an oversight or alternatively, it can be that P 
factor can actually be used, but just with lower frequencies.

Can you please make another test with GPU operating points specified in DT and 
check if it works with P factor left in?

For reference, vendor DT has following operating points (kHz, uV):
756000 1040000
624000 950000
576000 930000
540000 910000
504000 890000
456000 870000
432000 860000
420000 850000
408000 840000
384000 830000
360000 820000
336000 810000
312000 810000
264000 810000
216000 810000

Best regards,
Jernej

> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..d941238cd178a
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk = {
>  	},
>  };
> 
> +/* For GPU PLL, using an output divider for DFS causes system to fail */
>  #define SUN50I_H6_PLL_GPU_REG		0x030
>  static struct ccu_nkmp pll_gpu_clk = {
>  	.enable		= BIT(31),
>  	.lock		= BIT(28),
>  	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
>  	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> -	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider 
*/
> +	.max_rate	= 756000000UL,
>  	.common		= {
>  		.reg		= 0x030,
>  		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
> @@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> 
> -static const char * const gpu_parents[] = { "pll-gpu" };
> -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> -				       0, 3,	/* M */
> -				       24, 1,	/* mux */
> -				       BIT(31),	/* gate */
> -				       CLK_SET_RATE_PARENT);
> +/* GPU_CLK divider kept disabled to avoid interferences with DFS */
> +static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
> +		      BIT(31), CLK_SET_RATE_PARENT);
> 
>  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
>  		      0x67c, BIT(0), 0);




