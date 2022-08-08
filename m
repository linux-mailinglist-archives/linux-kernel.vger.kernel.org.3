Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8EF58CBB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiHHP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbiHHP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:58:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C61582E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:57:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so2707952wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vOkjUzQ8M7tJpkTS9Blpk8Y6i8UWVH/W/gV4IjTTtV4=;
        b=k+bkUAQnEsj5knND30n2tRWLXzzJZ1TCxGf+lAokpvpF0t8wPC8cU2E73k9yKeUX9I
         Jjf9KM+JNkM0WVl48i3f9VxjzN8umA9AZPQOL9BkzXQsmnj8F2/ImZnIb8rl9nZV6Bda
         TUEqXiG3EqtfVcLSxEU53E1rrwdFfjUD0TQAIXeFJP5xcPk1PEP0pxS9sLN1l1U6ioTm
         cvtaQYoCdnUKBmXNYwVcTMv4L+G3wNaiZm7PEle6uiLtoJ46OyBL5TgMMOVAW8Si62Y4
         cS3zDpeI6pqiNpNIwHk07ePfD97V6XJ6W5hhfIBkOWuuKYgxQsuYNbdi82A9T0Exg+f5
         n4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vOkjUzQ8M7tJpkTS9Blpk8Y6i8UWVH/W/gV4IjTTtV4=;
        b=TPxVvoGw6EX1x3W9IU30skj/5vSEIaicKsttlBsHY+a6/+feUhHEpMvpieJKIrKNYk
         8KpsJTjQDZqY7K3s+b18rmQHgp5ntkCrNCv96S+VplZimaMhmdBAJhZsV3c1x0VpXlNF
         t3fjnEmprO1KvsyDGvxB8UftPLfs0lCE13ODTw3MYXOsl6W5DYbFmfrh/N56qDuLUYRT
         aYVK0hgoJdGmw7ZVytBZoWZ7J92iUzgOdfnsjfXAXc09cH5s5YniIhrsBSFbGBZwiXH6
         oJxPgLBVo637GU+6aZpOLka/sXQV5ieBsabamnpPaUo56CohS09KjG0Bl8et/kXQQeye
         z66Q==
X-Gm-Message-State: ACgBeo2OFw1iawsMrFcedoAZUsr+vB0nfL6nlJ4TkaQXyJf4dTBM0rus
        X6GDQl0/CnsiTwaIpLM+Z9o8yg==
X-Google-Smtp-Source: AA6agR50wvAoJ+OphnR3E0eEOCaMfNnOv8m+laMq/Lc7C4mtEtGNLKZ3Vqr6m7S4rJioqWYR8/EMXg==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr13217564wmj.113.1659974275473;
        Mon, 08 Aug 2022 08:57:55 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p29-20020a1c545d000000b003a54f5fcc5dsm1514669wmi.10.2022.08.08.08.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:57:54 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:57:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, khilman@baylibre.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 07/11] mfd: drivers: Add interrupts support to TI
 TPS65219 PMIC
Message-ID: <YvEygQNmLMNV5CiV@google.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
 <20220726103355.17684-8-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726103355.17684-8-jneanne@baylibre.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022, Jerome Neanne wrote:

> Add TPS65219 support for interrupts through regmap_irq_chip

Why is this separate to the original patch?

> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  drivers/mfd/tps65219.c       | 217 ++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/tps65219.h | 113 ++++++++++++++++++
>  2 files changed, 328 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index c3bf975ea6c7..7366f251c21d 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -107,8 +107,73 @@ static void pmic_do_poweroff(void)
>  	tps65219_soft_shutdown(tps);
>  }
>  
> -static const struct mfd_cell tps65219_cells[] = {
> -	{ .name = "tps65219-regulator", },
> +static const struct resource tps65219_pwrbutton_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_RISING_EDGE_DETECT, "rising"),
> +};
> +
> +static const struct resource tps65219_regulator_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_SCG, "LDO3_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_OC, "LDO3_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_UV, "LDO3_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_SCG, "LDO4_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_OC, "LDO4_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_UV, "LDO4_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_SCG, "LDO1_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_OC, "LDO1_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_UV, "LDO1_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_SCG, "LDO2_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_OC, "LDO2_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_UV, "LDO2_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_SCG, "BUCK3_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_OC, "BUCK3_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_NEG_OC, "BUCK3_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_UV, "BUCK3_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_SCG, "BUCK1_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_OC, "BUCK1_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_NEG_OC, "BUCK1_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_UV, "BUCK1_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_SCG, "BUCK2_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_OC, "BUCK2_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_NEG_OC, "BUCK2_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_UV, "BUCK2_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV, "BUCK1_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV, "BUCK2_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV, "BUCK3_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV, "LDO1_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV, "LDO2_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV, "LDO3_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV, "LDO4_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV_SD, "BUCK1_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV_SD, "BUCK2_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV_SD, "BUCK3_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV_SD, "LDO1_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV_SD, "LDO2_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV_SD, "LDO3_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV_SD, "LDO4_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_TIMEOUT, "TIMEOUT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_WARM, "SENSOR_3_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_WARM, "SENSOR_2_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_WARM, "SENSOR_1_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_WARM, "SENSOR_0_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_HOT, "SENSOR_3_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_HOT, "SENSOR_2_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_HOT, "SENSOR_1_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_HOT, "SENSOR_0_HOT"),
> +};
> +
> +#define TPS65219_MAX_CELLS 2

Where is this even used?

> +static const struct mfd_cell tps65219_regulator_cell = {
> +	.name = "tps65219-regulator",
> +	.resources = tps65219_regulator_resources,
> +	.num_resources = ARRAY_SIZE(tps65219_regulator_resources),
> +};
> +
> +static const struct mfd_cell tps65219_pwrbutton_cell = {
> +	.name = "tps65219-pwrbutton",
> +	.resources = tps65219_pwrbutton_resources,
> +	.num_resources = ARRAY_SIZE(tps65219_pwrbutton_resources),
>  };
>  
>  static const struct regmap_config tps65219_regmap_config = {
> @@ -117,6 +182,147 @@ static const struct regmap_config tps65219_regmap_config = {
>  	.max_register = TPS65219_REG_FACTORY_CONFIG_2,
>  };
>  
> +/*
> + * Mapping of main IRQ register bits to sub-IRQ register offsets so that we can
> + * access corect sub-IRQ registers based on bits that are set in main IRQ
> + * register.
> + */
> +/* Timeout Residual Voltage Shutdown */
> +static unsigned int bit0_offsets[] = {TPS65219_TO_RV_POS};
> +static unsigned int bit1_offsets[] = {TPS65219_RV_POS};	/* Residual Voltage */
> +static unsigned int bit2_offsets[] = {TPS65219_SYS_POS};	/* System */
> +static unsigned int bit3_offsets[] = {TPS65219_BUCK_1_2_POS};	/* Buck 1-2 */
> +static unsigned int bit4_offsets[] = {TPS65219_BUCK_3_POS};	/* Buck 3 */
> +static unsigned int bit5_offsets[] = {TPS65219_LDO_1_2_POS};	/* LDO 1-2 */
> +static unsigned int bit6_offsets[] = {TPS65219_LDO_3_4_POS};	/* LDO 3-4 */
> +static unsigned int bit7_offsets[] = {TPS65219_PB_POS};	/* Power Button */

Well this is a pretty miserable interface.

You probably need spaces after { and before }.

> +static struct regmap_irq_sub_irq_map tps65219_sub_irq_offsets[] = {
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
> +};
> +
> +static struct regmap_irq tps65219_irqs[] = {
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO3_SCG, TPS65219_LDO_3_4_POS,
> +		       TPS65219_INT_LDO3_SCG_MASK),

One line please.

> +	REGMAP_IRQ_REG(TPS65219_INT_LDO3_OC,
> +		       TPS65219_LDO_3_4_POS, TPS65219_INT_LDO3_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO3_UV, TPS65219_LDO_3_4_POS,
> +		       TPS65219_INT_LDO3_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO4_SCG, TPS65219_LDO_3_4_POS,
> +		       TPS65219_INT_LDO4_SCG_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO4_OC, TPS65219_LDO_3_4_POS,
> +		       TPS65219_INT_LDO4_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO4_UV, TPS65219_LDO_3_4_POS,
> +		       TPS65219_INT_LDO4_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO1_SCG,
> +		       TPS65219_LDO_1_2_POS, TPS65219_INT_LDO1_SCG_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO1_OC, TPS65219_LDO_1_2_POS,
> +		       TPS65219_INT_LDO1_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO1_UV, TPS65219_LDO_1_2_POS,
> +		       TPS65219_INT_LDO1_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO2_SCG, TPS65219_LDO_1_2_POS,
> +		       TPS65219_INT_LDO2_SCG_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO2_OC, TPS65219_LDO_1_2_POS,
> +		       TPS65219_INT_LDO2_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO2_UV, TPS65219_LDO_1_2_POS,
> +		       TPS65219_INT_LDO2_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_SCG, TPS65219_BUCK_3_POS,
> +		       TPS65219_INT_BUCK3_SCG_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_OC, TPS65219_BUCK_3_POS,
> +		       TPS65219_INT_BUCK3_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_NEG_OC, TPS65219_BUCK_3_POS,
> +		       TPS65219_INT_BUCK3_NEG_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_UV, TPS65219_BUCK_3_POS,
> +		       TPS65219_INT_BUCK3_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_SCG, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK2_SCG_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_OC, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK2_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_NEG_OC, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK2_NEG_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_UV, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK2_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_SCG, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK1_SCG_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_OC, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK1_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_NEG_OC, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK1_NEG_OC_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_UV, TPS65219_BUCK_1_2_POS,
> +		       TPS65219_INT_BUCK1_UV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_WARM,
> +		       TPS65219_SYS_POS, TPS65219_INT_SENSOR_3_WARM_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_WARM, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_2_WARM_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_WARM, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_1_WARM_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_WARM, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_0_WARM_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_HOT, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_3_HOT_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_HOT, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_2_HOT_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_HOT, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_1_HOT_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_HOT, TPS65219_SYS_POS,
> +		       TPS65219_INT_SENSOR_0_HOT_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_BUCK1_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_BUCK2_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_BUCK3_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_LDO1_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_LDO2_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_LDO3_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV, TPS65219_RV_POS,
> +		       TPS65219_INT_LDO4_RV_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV_SD,
> +		       TPS65219_TO_RV_POS, TPS65219_INT_BUCK1_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV_SD,
> +		       TPS65219_TO_RV_POS, TPS65219_INT_BUCK2_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV_SD, TPS65219_TO_RV_POS,
> +		       TPS65219_INT_BUCK3_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV_SD, TPS65219_TO_RV_POS,
> +		       TPS65219_INT_LDO1_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV_SD, TPS65219_TO_RV_POS,
> +		       TPS65219_INT_LDO2_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV_SD,
> +		       TPS65219_TO_RV_POS, TPS65219_INT_LDO3_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV_SD, TPS65219_TO_RV_POS,
> +		       TPS65219_INT_LDO4_RV_SD_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_TIMEOUT, TPS65219_TO_RV_POS,
> +		       TPS65219_INT_TIMEOUT_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_PB_FALLING_EDGE_DETECT,
> +		       TPS65219_PB_POS, TPS65219_INT_PB_FALLING_EDGE_DET_MASK),
> +	REGMAP_IRQ_REG(TPS65219_INT_PB_RISING_EDGE_DETECT, TPS65219_PB_POS,
> +		       TPS65219_INT_PB_RISING_EDGE_DET_MASK),
> +};
> +
> +static struct regmap_irq_chip tps65219_irq_chip = {
> +	.name = "tps65219_irq",
> +	.main_status = TPS65219_REG_INT_SOURCE,
> +	.num_main_regs = 1,
> +	.num_main_status_bits = 8,
> +	.irqs = tps65219_irqs,
> +	.num_irqs = ARRAY_SIZE(tps65219_irqs),
> +	.status_base = TPS65219_REG_INT_LDO_3_4,
> +	.ack_base = TPS65219_REG_INT_LDO_3_4,
> +	.clear_ack = 1,
> +	.num_regs = 8,
> +	.sub_reg_offsets = &tps65219_sub_irq_offsets[0],
> +};
> +
>  static const struct of_device_id of_tps65219_match_table[] = {
>  	{ .compatible = "ti,tps65219", },
>  	{}
> @@ -137,6 +343,7 @@ static int tps65219_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, tps);
>  	tps->dev = &client->dev;
> +	tps->irq = client->irq;

Is this used again beyond devm_regmap_add_irq_chip()?

>  	tps->regmap = devm_regmap_init_i2c(client, &tps65219_regmap_config);
>  	if (IS_ERR(tps->regmap)) {
>  		ret = PTR_ERR(tps->regmap);
> @@ -145,6 +352,12 @@ static int tps65219_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
> +				       IRQF_ONESHOT, 0, &tps65219_irq_chip,
> +				       &tps->irq_data);

2 lines.

> +	if (ret)
> +		return ret;
> +
>  	ret = regmap_read(tps->regmap, TPS65219_REG_TI_DEV_ID, &chipid);
>  	if (ret) {
>  		dev_err(tps->dev, "Failed to read device ID: %d\n", ret);
> diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
> index e9197ab8bc75..8cecaf9bc682 100644
> --- a/include/linux/mfd/tps65219.h
> +++ b/include/linux/mfd/tps65219.h
> @@ -214,6 +214,104 @@
>  #define TPS65219_INT_PB_RISING_EDGE_DET_MASK		BIT(1)
>  #define TPS65219_INT_PB_REAL_TIME_STATUS_MASK		BIT(2)
>  
> +/* Masks for main IRQ register bits */
> +enum {
> +	TPS65219_INT_TIMEOUT_RV_SD,
> +#define TPS65219_INT_TIMEOUT_RV_SD_MASK BIT(TPS65219_INT_TIMEOUT_RV_SD)
> +	TPS65219_INT_RV,
> +#define TPS65219_INT_RV_MASK BIT(TPS65219_INT_RV)
> +	TPS65219_INT_SYSTEM,
> +#define TPS65219_INT_SYSTEM_MASK BIT(TPS65219_INT_SYSTEM)
> +	TPS65219_INT_BUCK_1_2,
> +#define TPS65219_INT_BUCK_1_2_MASK BIT(TPS65219_INT_BUCK_1_2)
> +	TPS65219_INT_BUCK_3,
> +#define TPS65219_INT_BUCK_3_MASK BIT(TPS65219_INT_BUCK_3)
> +	TPS65219_INT_LDO_1_2,
> +#define TPS65219_INT_LDO_1_2_MASK BIT(TPS65219_INT_LDO_1_2)
> +	TPS65219_INT_LDO_3_4,
> +#define TPS65219_INT_LDO_3_4_MASK BIT(TPS65219_LDO_3_4)
> +	TPS65219_INT_PB,
> +#define TPS65219_INT_PB_MASK BIT(TPS65219_INT_PB)

Where are these horrid defines used?

Can't you just use the BIT() macros.  We know what they mean.

> +};
> +
> +/* Timeout Residual Voltage Shutdown */

If you used nice nomenclature, you wouldn't need the comments.

> +#define TPS65219_TO_RV_POS 6
> +/* Residual Voltage */
> +#define TPS65219_RV_POS 5
> +/* System */
> +#define TPS65219_SYS_POS 4
> +/* Buck 1-2 */
> +#define TPS65219_BUCK_1_2_POS 3
> +/* Buck 3 */
> +#define TPS65219_BUCK_3_POS 2
> +/* LDO 1-2 */
> +#define TPS65219_LDO_1_2_POS 1
> +/* LDO 3-4 */
> +#define TPS65219_LDO_3_4_POS 0
> +/* Power Button */
> +#define TPS65219_PB_POS 7
> +
> +/* IRQs */
> +enum {
> +	/* LDO3-4 register IRQs */
> +	TPS65219_INT_LDO3_SCG,
> +	TPS65219_INT_LDO3_OC,
> +	TPS65219_INT_LDO3_UV,
> +	TPS65219_INT_LDO4_SCG,
> +	TPS65219_INT_LDO4_OC,
> +	TPS65219_INT_LDO4_UV,
> +	/* LDO1-2 */
> +	TPS65219_INT_LDO1_SCG,
> +	TPS65219_INT_LDO1_OC,
> +	TPS65219_INT_LDO1_UV,
> +	TPS65219_INT_LDO2_SCG,
> +	TPS65219_INT_LDO2_OC,
> +	TPS65219_INT_LDO2_UV,
> +	/* BUCK3 */
> +	TPS65219_INT_BUCK3_SCG,
> +	TPS65219_INT_BUCK3_OC,
> +	TPS65219_INT_BUCK3_NEG_OC,
> +	TPS65219_INT_BUCK3_UV,
> +	/* BUCK1-2 */
> +	TPS65219_INT_BUCK1_SCG,
> +	TPS65219_INT_BUCK1_OC,
> +	TPS65219_INT_BUCK1_NEG_OC,
> +	TPS65219_INT_BUCK1_UV,
> +	TPS65219_INT_BUCK2_SCG,
> +	TPS65219_INT_BUCK2_OC,
> +	TPS65219_INT_BUCK2_NEG_OC,
> +	TPS65219_INT_BUCK2_UV,
> +	/* Thermal Sensor  */
> +	TPS65219_INT_SENSOR_3_WARM,
> +	TPS65219_INT_SENSOR_2_WARM,
> +	TPS65219_INT_SENSOR_1_WARM,
> +	TPS65219_INT_SENSOR_0_WARM,
> +	TPS65219_INT_SENSOR_3_HOT,
> +	TPS65219_INT_SENSOR_2_HOT,
> +	TPS65219_INT_SENSOR_1_HOT,
> +	TPS65219_INT_SENSOR_0_HOT,
> +	/* Residual Voltage */
> +	TPS65219_INT_BUCK1_RV,
> +	TPS65219_INT_BUCK2_RV,
> +	TPS65219_INT_BUCK3_RV,
> +	TPS65219_INT_LDO1_RV,
> +	TPS65219_INT_LDO2_RV,
> +	TPS65219_INT_LDO3_RV,
> +	TPS65219_INT_LDO4_RV,
> +	/* Residual Voltage ShutDown */
> +	TPS65219_INT_BUCK1_RV_SD,
> +	TPS65219_INT_BUCK2_RV_SD,
> +	TPS65219_INT_BUCK3_RV_SD,
> +	TPS65219_INT_LDO1_RV_SD,
> +	TPS65219_INT_LDO2_RV_SD,
> +	TPS65219_INT_LDO3_RV_SD,
> +	TPS65219_INT_LDO4_RV_SD,
> +	TPS65219_INT_TIMEOUT,
> +	/* Power Button */
> +	TPS65219_INT_PB_FALLING_EDGE_DETECT,
> +	TPS65219_INT_PB_RISING_EDGE_DETECT,
> +};
> +
>  enum tps65219_regulator_id {
>  	/* DCDC's */
>  	TPS65219_BUCK_1,
> @@ -235,6 +333,19 @@ enum tps65219_regulator_id {
>  /* Number of total regulators available */
>  #define TPS65219_NUM_REGULATOR		(TPS65219_NUM_DCDC + TPS65219_NUM_LDO)
>  
> +/* Define the TPS65219 IRQ numbers */
> +enum tps65219_irqs {
> +	/* INT source registers */
> +	TPS65219_TO_RV_SD_SET_IRQ,
> +	TPS65219_RV_SET_IRQ,
> +	TPS65219_SYS_SET_IRQ,
> +	TPS65219_BUCK_1_2_SET_IRQ,
> +	TPS65219_BUCK_3_SET_IRQ,
> +	TPS65219_LDO_1_2_SET_IRQ,
> +	TPS65219_LDO_3_4_SET_IRQ,
> +	TPS65219_PB_SET_IRQ,
> +};
> +
>  /**
>   * struct tps65219 - tps65219 sub-driver chip access routines
>   *
> @@ -243,6 +354,8 @@ enum tps65219_regulator_id {
>  struct tps65219 {
>  	struct device *dev;
>  	unsigned int id;
> +	int irq;
> +	struct regmap_irq_chip_data *irq_data;
>  	struct regulator_desc desc[TPS65219_NUM_REGULATOR];
>  	struct regmap *regmap;
>  	struct notifier_block nb;

-- 
DEPRECATED: Please use lee@kernel.org
