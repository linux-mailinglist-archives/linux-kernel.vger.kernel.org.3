Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2F56495B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGCSny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGCSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:43:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EA2710;
        Sun,  3 Jul 2022 11:43:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so13072396ejj.12;
        Sun, 03 Jul 2022 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YNiliZWXNoSejurrkg/bZM1+hwajBnqHCSCntKvBUaI=;
        b=npbI1nD+znAoMU7pXRx5AAX2LM820YJ/YUybd49rlin0LVoZdUNVLe9DSUHETWBfh5
         LlBJioKkqM6GkY/WB0BE2keebr0ENUPFlCaQ3FQWJ9+n0kS8Nvu+u/fSUo4Sk59Rr0nG
         rSs4yJ9A9wIJzkjMqJU0nQ0PWemZJ593KwBvQ5pT5YmIshoS/123yM1iJsw+PvRGxReo
         lkiUH+q1nltWejKztICUVGfEWbJ72NTWGhuVnzs5LW7KY0e1Tuyf9SYxjN0AntHJRyxe
         yTzfcQVCLnrWqNtT/3BA7S7Xaz9PPg2stfswbBVVUpi30mxEpPNXFWawNED7W4cVugNr
         wwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YNiliZWXNoSejurrkg/bZM1+hwajBnqHCSCntKvBUaI=;
        b=lWtDBwb3duZ7a7ntf4mYy4M4rKMQMSqmFFg/dfc8/JtGr9lstFArjQwBP3gre2xqu+
         g8Xf7nKtRJl7be+Gp9nOD3EIy630LXoB7Wcfv3QtLu12NPZx4W/wBc7Rc+G4Lpk62rUZ
         i9NjhA4x362QR5DhVzjiW26UiebWhZziM08+AISjq3zewgfVC+AqQoQdSP5wKzvNiw/9
         4Qz0y7MjJXIZBuuuN1MUboJgMpi8RjiGMmmWeODxGe+xXYTWN7RRv4/uQbAx9LPCSEXZ
         LoKKOcb1dqCYFr72fTGiUQzWupqqVC8Xat/438+/31+0MmvaJ8nmvii+yCCMZKITqHXw
         xn1A==
X-Gm-Message-State: AJIora9VidFuJqojYpNF/oyTaA52PLINZCLP9gWQWdRK0T2U1C833GXM
        peQ/gByFodstyAP0T+aJsN8=
X-Google-Smtp-Source: AGRyM1uhjp+RgS2ynpA11LiieVXvsXwvY7y8TuIgmM3sQHxv0yU0hV6peQrIhc6stvF4D+KvPe7s3Q==
X-Received: by 2002:a17:907:3e8c:b0:726:41fa:2866 with SMTP id hs12-20020a1709073e8c00b0072641fa2866mr24122132ejc.562.1656873830342;
        Sun, 03 Jul 2022 11:43:50 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b0070beb9401d9sm13390726ejf.171.2022.07.03.11.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:43:49 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     peron.clem@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH v2] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Sun, 03 Jul 2022 20:43:48 +0200
Message-ID: <4748270.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20220703164514.308622-1-r.stratiienko@gmail.com>
References: <20220703164514.308622-1-r.stratiienko@gmail.com>
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

Dne nedelja, 03. julij 2022 ob 18:45:14 CEST je Roman Stratiienko napisal(a):
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
> DVFS started to work seamlessly once dividers which caused the
> glitches were set to fixed values.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> 
> ---
> 
> Changelog:
> 
> V2:
> - Drop changes related to mux
> - Drop frequency limiting
> - Add unused dividers initialization
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..1b0205ff24108
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk = {
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

Having minimum (288 MHz) as per vendor GPU driver and maximum, either max. opp 
or max. from datasheet is equally good. I know that both are basically limited 
with opp table, but people like to play with these, so it's good to have them 
in.

>  	.common		= {
>  		.reg		= 0x030,
>  		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
> @@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> 
> +/* Keep GPU_CLK divider const to avoid DFS instability. */
>  static const char * const gpu_parents[] = { "pll-gpu" };
> -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> -				       0, 3,	/* M */
> +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
>  				       24, 1,	/* mux */
>  				       BIT(31),	/* gate */
>  				       CLK_SET_RATE_PARENT);
> @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct platform_device
> *pdev) if (IS_ERR(reg))
>  		return PTR_ERR(reg);
> 
> +	/* Force PLL_GPU output divider to 0 */

Divider  0 here

> +	val = readl(reg + SUN50I_H6_PLL_GPU_REG);
> +	val &= ~BIT(0);
> +	writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> +
> +	/* Force GPU_CLK divider to 0 */

and here sounds wrong, since division by zero is not defined. Using 1 is more 
intuitive and correct, since that's what HW actually uses.

Patch looks good otherwise.

Best regards,
Jernej

> +	val = readl(reg + gpu_clk.common.reg);
> +	val &= ~GENMASK(3, 0);
> +	writel(val, reg + gpu_clk.common.reg);
> +
>  	/* Enable the lock bits on all PLLs */
>  	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
>  		val = readl(reg + pll_regs[i]);




