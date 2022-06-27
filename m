Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE255CE78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiF0UnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0UnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:43:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248AB1;
        Mon, 27 Jun 2022 13:43:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ge10so21587475ejb.7;
        Mon, 27 Jun 2022 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pX8mkwuBJMDVUqI/3IJvGaMM4XSCal/s1gxF0ly7VUQ=;
        b=QoQQ4++P9s5DYrtw/AQwBYJLlNnFOBx7HzP+wYaYJH49psnaITjI7cPcPUnJeK1ujz
         b1q4KJW1CeS5qGyyr57esEE21cjZEfz96ZImaxSazJDwYPF8QXtiWWsqf2InGxDpHdV+
         2O2+2TxPVF3bTk+5addEEEC3ZhCzh+rtDfmt8qvBCgXqLV2EY/tP4Xs2xcAYb6XedBwM
         4gq0erZfP56o9ybZBGG7GoczY68lAwmKDpk9X0q9EEFnh+Y5/yWipr8uruwFM/YF3gEl
         N4+4B/VgTem7aR/yaFDlb+Y0EP5Rbi8XB+/yQ0ah39JLjLPq2jnbtRYeHiiR88KSh4kC
         HErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pX8mkwuBJMDVUqI/3IJvGaMM4XSCal/s1gxF0ly7VUQ=;
        b=pZ4dpgoj4epbdTn56+NhTuDw5zHv8fYfaeaxYicClryPXK0aynHe43erh97YgvegX5
         7Pl/Euyn/0G/l1DmZoO+xtgcQmX1sNYKImFjMlsy3voUXJAon5ytmrfMP2+BP9jQSbsk
         2HlLnbUmDi+98M+lHZ3iykakAFu7BQDLJeuLbKUe4DfxhQILndxUztO8cdxXKtI2ku5Q
         gLRHuN+LCvcek412+DvWQ1QVRx+dwjpQVjkHRHWK5w4+HV3IepROyXl7/IHfFndLcDnL
         j+XaCwXl/FCqKuwYkfXd02RFjIn4NYnlRNltGyEFi7yetUjCL0WYEHOttXVSJHNUQmAq
         L+Hg==
X-Gm-Message-State: AJIora/zqKRGenWGB61QAnw3VJE4xUZx6BlQpXDwNf/xRrK66Xm9jW7F
        1WroU9ajQ9Jc8dVhoCj8GKo=
X-Google-Smtp-Source: AGRyM1u/Qpe9FohRa7baqPeSJkc20W7Civ6KZPWzhFWn2Ly0AZVHfraXHNtUlW02PWiwx1Qp1JfYMA==
X-Received: by 2002:a17:907:3f9f:b0:726:39d8:4c8c with SMTP id hr31-20020a1709073f9f00b0072639d84c8cmr14083460ejc.241.1656362584143;
        Mon, 27 Jun 2022 13:43:04 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id dt16-20020a170906b79000b00704fa2748ffsm5528538ejb.99.2022.06.27.13.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:43:03 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/6] pinctrl: sunxi: Support the 2.5V I/O bias mode
Date:   Mon, 27 Jun 2022 22:43:02 +0200
Message-ID: <1818958.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20220626021148.56740-4-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org> <20220626021148.56740-4-samuel@sholland.org>
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

Dne nedelja, 26. junij 2022 ob 04:11:44 CEST je Samuel Holland napisal(a):
> H616 and newer SoCs feature a 2.5V I/O bias mode in addition to the
> 1.8V and 3.3V modes. This mode is entered by selecting the 3.3V level
> and disabling the "withstand function".
> 
> H616 supports this capability on its main PIO only. A100 supports this
> capability on both its PIO and R-PIO.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c |  1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |  2 +-
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  2 +-
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 10 ++++++++++
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h         |  7 +++++++
>  5 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
> b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c index
> 21054fcacd34..afc1f5df7545 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
> @@ -82,6 +82,7 @@ static const struct sunxi_pinctrl_desc a100_r_pinctrl_data
> = { .npins = ARRAY_SIZE(a100_r_pins),
>  	.pin_base = PL_BASE,
>  	.irq_banks = 1,
> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>  };
> 
>  static int a100_r_pinctrl_probe(struct platform_device *pdev)
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
> b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c index
> e69f6da40dc0..f682e0e4244d 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
> @@ -684,7 +684,7 @@ static const struct sunxi_pinctrl_desc a100_pinctrl_data
> = { .npins = ARRAY_SIZE(a100_pins),
>  	.irq_banks = 7,
>  	.irq_bank_map = a100_irq_bank_map,
> -	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>  };
> 
>  static int a100_pinctrl_probe(struct platform_device *pdev)
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c index
> 152b71226a80..d6ca720ee8d8 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> @@ -525,7 +525,7 @@ static const struct sunxi_pinctrl_desc h616_pinctrl_data
> = { .irq_banks = ARRAY_SIZE(h616_irq_bank_map),
>  	.irq_bank_map = h616_irq_bank_map,
>  	.irq_read_needs_mux = true,
> -	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>  };
> 
>  static int h616_pinctrl_probe(struct platform_device *pdev)
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c index 3c5e71359ca8..eb3d595f816a
> 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -662,6 +662,16 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct
> sunxi_pinctrl *pctl, reg &= ~IO_BIAS_MASK;
>  		writel(reg | val, pctl->membase + 
sunxi_grp_config_reg(pin));
>  		return 0;
> +	case BIAS_VOLTAGE_PIO_POW_MODE_CTL:
> +		val = uV > 1800000 && uV <= 2500000 ? BIT(bank) : 0;
> +
> +		raw_spin_lock_irqsave(&pctl->lock, flags);
> +		reg = readl(pctl->membase + PIO_POW_MOD_CTL_REG);
> +		reg &= ~BIT(bank);
> +		writel(reg | val, pctl->membase + PIO_POW_MOD_CTL_REG);
> +		raw_spin_unlock_irqrestore(&pctl->lock, flags);
> +
> +		fallthrough;

Would this set bit 12 as needed? According to documentation, it's a bit 
special case, since it covers VCC-IO, port F and port H, at least according to 
documentation. I guess BIAS_VOLTAGE_PIO_POW_MODE_SEL has same issue.

Best regards,
Jernej

>  	case BIAS_VOLTAGE_PIO_POW_MODE_SEL:
>  		val = uV <= 1800000 ? 1 : 0;
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> b/drivers/pinctrl/sunxi/pinctrl-sunxi.h index a32bb5bcb754..0f1aab58650c
> 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> @@ -98,6 +98,7 @@
>  #define PINCTRL_SUN8I_V3S	BIT(10)
> 
>  #define PIO_POW_MOD_SEL_REG	0x340
> +#define PIO_POW_MOD_CTL_REG	0x344
> 
>  enum sunxi_desc_bias_voltage {
>  	BIAS_VOLTAGE_NONE,
> @@ -111,6 +112,12 @@ enum sunxi_desc_bias_voltage {
>  	 * register, as seen on H6 SoC, for example.
>  	 */
>  	BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> +	/*
> +	 * Bias voltage is set through PIO_POW_MOD_SEL_REG
> +	 * and PIO_POW_MOD_CTL_REG register, as seen on
> +	 * A100 and D1 SoC, for example.
> +	 */
> +	BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>  };
> 
>  struct sunxi_desc_function {




