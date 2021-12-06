Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91A546A16C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbhLFQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345924AbhLFQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:36:24 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1233C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:32:55 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id be32so22333776oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sfgp+Fzu90J2ESrAc1hGMPt/IEv7tpIqe4sIvD/5olo=;
        b=u79JgjLO4Q2q+oV14ehsEuy8wb/hXAWf2HVJcPGLMLOUuDvQJuYbWsTXDHW1k86epO
         H9lZxkYmuJCfG3Y15HvETTbLUnVX01naqcgeP+8qGAZkorNfwZFBunXxLjsM81MrQ9xN
         CEBJ93aR1ElHqj5i0gMcR+lq0r6LFCHji3RTNeKPPfvBPQOCpPFheE+wl1YdeuW/YE/A
         JCs5IqGnmAkYvGfaMh4BK0C3yIib6dgjpXGcOzuAdDnA1PotHi6eOYhIzu3fTRGo/wKJ
         5s3aOskoBkLcLeGVt4iLOKipxaI4nrfIXv+eKYhBINnuvwmPPP1KRJwW76y2n8cjMMhj
         5s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sfgp+Fzu90J2ESrAc1hGMPt/IEv7tpIqe4sIvD/5olo=;
        b=b73vP9i7NcSZpAJsmLNpO3IwhLCs6yfW55gqEJMaTPMZXRjiSTfmh1zrQ0eiIlh1vl
         IlHpQP/yctv0rVusMURBo+DNcRWDWXsW7U0ThTF5BHx3rMgKD3x+ImPI4TEYOCisgQ7i
         mbdOy/zUPTH5JTSxj+1CXPNmj4NhxX22kO4dg4G/ryJiYXr6o47GJG+Gs+QWBigpKqro
         EnGG8tPrsE7PSQIbbreqmKNgm/VUoqw2y9wAPGERLFbofRxzfVAIlseDN1/1GzvEeaGQ
         Wj98abbtBU2uE5NyGM9jG9vxLeyYGnxxIUQQ5e+xFZSZiAxvfJcItf8KEBdH2jazqmkI
         PQtg==
X-Gm-Message-State: AOAM530PWM6JHiK1nMw2afZ6qpYwd5dZS/mKbg2RHexVn+5xuMP5DK/s
        vXvK4IE+RN7qtXMuc/zj4Z+fYq/WgJpo7g==
X-Google-Smtp-Source: ABdhPJy41rIthToUAplwHDMF6jccequ0wGZkA3e4IH6TrLpN1TX5o1+cp7+qpeOlb9rsP4x/FPSVlg==
X-Received: by 2002:a05:6808:1185:: with SMTP id j5mr24520157oil.16.1638808375202;
        Mon, 06 Dec 2021 08:32:55 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h26sm2153764oor.17.2021.12.06.08.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:32:54 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:32:49 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: Re: [PATCH v4 3/5] pinctrl: qcom: Move chip specific functions to
 right files
Message-ID: <Ya47MbYqG2mvQW7g@builder.lan>
References: <1638531140-25899-1-git-send-email-srivasam@codeaurora.com>
 <1638531140-25899-4-git-send-email-srivasam@codeaurora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638531140-25899-4-git-send-email-srivasam@codeaurora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03 Dec 05:32 CST 2021, Srinivasa Rao Mandadapu wrote:

I don't see anything _wrong_ with the current filename, so this patch
isn't really moving chip function to the _right_ files.

May I suggest that you make $subject:

"pinctrl: qcom: Extract chip specific LPASS LPI code"

> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Update lpass lpi pin control driver to accommodate new lpass variant
> SoC specific drivers.

I also have a hard time parsing this sentence.

> Move sm8250 SoC specific functions to pinctrl-sm8250-lpass-lpi.c file
> and common declarations to pinctrl-lpass-lpi.h header file.

How about simply:

Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
to allow reusing the common code in the addition of subsequent
platforms.

> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/Kconfig                    |   8 +
>  drivers/pinctrl/qcom/Makefile                   |   1 +
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 250 +-----------------------
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  98 ++++++++++
>  drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c | 166 ++++++++++++++++
>  5 files changed, 280 insertions(+), 243 deletions(-)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 5ff4207..e750e10 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -320,4 +320,12 @@ config PINCTRL_LPASS_LPI
>  	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>  	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
>  
> +config PINCTRL_SM8250_LPASS_LPI
> +	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
> +	depends on PINCTRL_LPASS_LPI
> +	help
> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> +	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
> +
>  endif
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 7a12e8c..8bc877e 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -37,3 +37,4 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
>  obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>  obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>  obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
> +obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 2f19ab4..bcc12f6 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -4,237 +4,16 @@
>   * Copyright (c) 2020 Linaro Ltd.
>   */
>  
> -#include <linux/bitops.h>
> -#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/gpio/driver.h>
> -#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> -#include <linux/of.h>
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinmux.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
>  #include "../core.h"
>  #include "../pinctrl-utils.h"
> -
> -#define LPI_SLEW_RATE_CTL_REG		0xa000
> -#define LPI_TLMM_REG_OFFSET		0x1000
> -#define LPI_SLEW_RATE_MAX		0x03
> -#define LPI_SLEW_BITS_SIZE		0x02
> -#define LPI_SLEW_RATE_MASK		GENMASK(1, 0)
> -#define LPI_GPIO_CFG_REG		0x00
> -#define LPI_GPIO_PULL_MASK		GENMASK(1, 0)
> -#define LPI_GPIO_FUNCTION_MASK		GENMASK(5, 2)
> -#define LPI_GPIO_OUT_STRENGTH_MASK	GENMASK(8, 6)
> -#define LPI_GPIO_OE_MASK		BIT(9)
> -#define LPI_GPIO_VALUE_REG		0x04
> -#define LPI_GPIO_VALUE_IN_MASK		BIT(0)
> -#define LPI_GPIO_VALUE_OUT_MASK		BIT(1)
> -
> -#define LPI_GPIO_BIAS_DISABLE		0x0
> -#define LPI_GPIO_PULL_DOWN		0x1
> -#define LPI_GPIO_KEEPER			0x2
> -#define LPI_GPIO_PULL_UP		0x3
> -#define LPI_GPIO_DS_TO_VAL(v)		(v / 2 - 1)
> -#define NO_SLEW				-1
> -
> -#define LPI_FUNCTION(fname)			                \
> -	[LPI_MUX_##fname] = {		                \
> -		.name = #fname,				\
> -		.groups = fname##_groups,               \
> -		.ngroups = ARRAY_SIZE(fname##_groups),	\
> -	}
> -
> -#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
> -	{						\
> -		.name = "gpio" #id,			\
> -		.pins = gpio##id##_pins,		\
> -		.pin = id,				\
> -		.slew_offset = soff,			\
> -		.npins = ARRAY_SIZE(gpio##id##_pins),	\
> -		.funcs = (int[]){			\
> -			LPI_MUX_gpio,			\
> -			LPI_MUX_##f1,			\
> -			LPI_MUX_##f2,			\
> -			LPI_MUX_##f3,			\
> -			LPI_MUX_##f4,			\
> -		},					\
> -		.nfuncs = 5,				\
> -	}
> -
> -struct lpi_pingroup {
> -	const char *name;
> -	const unsigned int *pins;
> -	unsigned int npins;
> -	unsigned int pin;
> -	/* Bit offset in slew register for SoundWire pins only */
> -	int slew_offset;
> -	unsigned int *funcs;
> -	unsigned int nfuncs;
> -};
> -
> -struct lpi_function {
> -	const char *name;
> -	const char * const *groups;
> -	unsigned int ngroups;
> -};
> -
> -struct lpi_pinctrl_variant_data {
> -	const struct pinctrl_pin_desc *pins;
> -	int npins;
> -	const struct lpi_pingroup *groups;
> -	int ngroups;
> -	const struct lpi_function *functions;
> -	int nfunctions;
> -};
> -
> -#define MAX_LPI_NUM_CLKS	2
> -
> -struct lpi_pinctrl {
> -	struct device *dev;
> -	struct pinctrl_dev *ctrl;
> -	struct gpio_chip chip;
> -	struct pinctrl_desc desc;
> -	char __iomem *tlmm_base;
> -	char __iomem *slew_base;
> -	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
> -	struct mutex slew_access_lock;
> -	const struct lpi_pinctrl_variant_data *data;
> -};
> -
> -/* sm8250 variant specific data */
> -static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
> -	PINCTRL_PIN(0, "gpio0"),
> -	PINCTRL_PIN(1, "gpio1"),
> -	PINCTRL_PIN(2, "gpio2"),
> -	PINCTRL_PIN(3, "gpio3"),
> -	PINCTRL_PIN(4, "gpio4"),
> -	PINCTRL_PIN(5, "gpio5"),
> -	PINCTRL_PIN(6, "gpio6"),
> -	PINCTRL_PIN(7, "gpio7"),
> -	PINCTRL_PIN(8, "gpio8"),
> -	PINCTRL_PIN(9, "gpio9"),
> -	PINCTRL_PIN(10, "gpio10"),
> -	PINCTRL_PIN(11, "gpio11"),
> -	PINCTRL_PIN(12, "gpio12"),
> -	PINCTRL_PIN(13, "gpio13"),
> -};
> -
> -enum sm8250_lpi_functions {
> -	LPI_MUX_dmic1_clk,
> -	LPI_MUX_dmic1_data,
> -	LPI_MUX_dmic2_clk,
> -	LPI_MUX_dmic2_data,
> -	LPI_MUX_dmic3_clk,
> -	LPI_MUX_dmic3_data,
> -	LPI_MUX_i2s1_clk,
> -	LPI_MUX_i2s1_data,
> -	LPI_MUX_i2s1_ws,
> -	LPI_MUX_i2s2_clk,
> -	LPI_MUX_i2s2_data,
> -	LPI_MUX_i2s2_ws,
> -	LPI_MUX_qua_mi2s_data,
> -	LPI_MUX_qua_mi2s_sclk,
> -	LPI_MUX_qua_mi2s_ws,
> -	LPI_MUX_swr_rx_clk,
> -	LPI_MUX_swr_rx_data,
> -	LPI_MUX_swr_tx_clk,
> -	LPI_MUX_swr_tx_data,
> -	LPI_MUX_wsa_swr_clk,
> -	LPI_MUX_wsa_swr_data,
> -	LPI_MUX_gpio,
> -	LPI_MUX__,
> -};
> -
> -static const unsigned int gpio0_pins[] = { 0 };
> -static const unsigned int gpio1_pins[] = { 1 };
> -static const unsigned int gpio2_pins[] = { 2 };
> -static const unsigned int gpio3_pins[] = { 3 };
> -static const unsigned int gpio4_pins[] = { 4 };
> -static const unsigned int gpio5_pins[] = { 5 };
> -static const unsigned int gpio6_pins[] = { 6 };
> -static const unsigned int gpio7_pins[] = { 7 };
> -static const unsigned int gpio8_pins[] = { 8 };
> -static const unsigned int gpio9_pins[] = { 9 };
> -static const unsigned int gpio10_pins[] = { 10 };
> -static const unsigned int gpio11_pins[] = { 11 };
> -static const unsigned int gpio12_pins[] = { 12 };
> -static const unsigned int gpio13_pins[] = { 13 };
> -static const char * const swr_tx_clk_groups[] = { "gpio0" };
> -static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
> -static const char * const swr_rx_clk_groups[] = { "gpio3" };
> -static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
> -static const char * const dmic1_clk_groups[] = { "gpio6" };
> -static const char * const dmic1_data_groups[] = { "gpio7" };
> -static const char * const dmic2_clk_groups[] = { "gpio8" };
> -static const char * const dmic2_data_groups[] = { "gpio9" };
> -static const char * const i2s2_clk_groups[] = { "gpio10" };
> -static const char * const i2s2_ws_groups[] = { "gpio11" };
> -static const char * const dmic3_clk_groups[] = { "gpio12" };
> -static const char * const dmic3_data_groups[] = { "gpio13" };
> -static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
> -static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
> -static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
> -static const char * const i2s1_clk_groups[] = { "gpio6" };
> -static const char * const i2s1_ws_groups[] = { "gpio7" };
> -static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
> -static const char * const wsa_swr_clk_groups[] = { "gpio10" };
> -static const char * const wsa_swr_data_groups[] = { "gpio11" };
> -static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
> -
> -static const struct lpi_pingroup sm8250_groups[] = {
> -	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
> -	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
> -	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
> -	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
> -	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
> -	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
> -	LPI_PINGROUP(6, NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
> -	LPI_PINGROUP(7, NO_SLEW, dmic1_data, i2s1_ws, _, _),
> -	LPI_PINGROUP(8, NO_SLEW, dmic2_clk, i2s1_data, _, _),
> -	LPI_PINGROUP(9, NO_SLEW, dmic2_data, i2s1_data, _, _),
> -	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
> -	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
> -	LPI_PINGROUP(12, NO_SLEW, dmic3_clk, i2s2_data, _, _),
> -	LPI_PINGROUP(13, NO_SLEW, dmic3_data, i2s2_data, _, _),
> -};
> -
> -static const struct lpi_function sm8250_functions[] = {
> -	LPI_FUNCTION(dmic1_clk),
> -	LPI_FUNCTION(dmic1_data),
> -	LPI_FUNCTION(dmic2_clk),
> -	LPI_FUNCTION(dmic2_data),
> -	LPI_FUNCTION(dmic3_clk),
> -	LPI_FUNCTION(dmic3_data),
> -	LPI_FUNCTION(i2s1_clk),
> -	LPI_FUNCTION(i2s1_data),
> -	LPI_FUNCTION(i2s1_ws),
> -	LPI_FUNCTION(i2s2_clk),
> -	LPI_FUNCTION(i2s2_data),
> -	LPI_FUNCTION(i2s2_ws),
> -	LPI_FUNCTION(qua_mi2s_data),
> -	LPI_FUNCTION(qua_mi2s_sclk),
> -	LPI_FUNCTION(qua_mi2s_ws),
> -	LPI_FUNCTION(swr_rx_clk),
> -	LPI_FUNCTION(swr_rx_data),
> -	LPI_FUNCTION(swr_tx_clk),
> -	LPI_FUNCTION(swr_tx_data),
> -	LPI_FUNCTION(wsa_swr_clk),
> -	LPI_FUNCTION(wsa_swr_data),
> -};
> -
> -static struct lpi_pinctrl_variant_data sm8250_lpi_data = {
> -	.pins = sm8250_lpi_pins,
> -	.npins = ARRAY_SIZE(sm8250_lpi_pins),
> -	.groups = sm8250_groups,
> -	.ngroups = ARRAY_SIZE(sm8250_groups),
> -	.functions = sm8250_functions,
> -	.nfunctions = ARRAY_SIZE(sm8250_functions),
> -};
> +#include "pinctrl-lpass-lpi.h"
>  
>  static int lpi_gpio_read(struct lpi_pinctrl *state, unsigned int pin,
>  			 unsigned int addr)
> @@ -582,7 +361,7 @@ static const struct gpio_chip lpi_gpio_template = {
>  	.dbg_show		= lpi_gpio_dbg_show,
>  };
>  
> -static int lpi_pinctrl_probe(struct platform_device *pdev)
> +int lpi_pinctrl_probe(struct platform_device *pdev)
>  {
>  	const struct lpi_pinctrl_variant_data *data;
>  	struct device *dev = &pdev->dev;
> @@ -661,8 +440,10 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(lpi_pinctrl_probe);
>  
> -static int lpi_pinctrl_remove(struct platform_device *pdev)
> +
> +int lpi_pinctrl_remove(struct platform_device *pdev)
>  {
>  	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
>  
> @@ -671,25 +452,8 @@ static int lpi_pinctrl_remove(struct platform_device *pdev)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(lpi_pinctrl_remove);
>  
> -static const struct of_device_id lpi_pinctrl_of_match[] = {
> -	{
> -	       .compatible = "qcom,sm8250-lpass-lpi-pinctrl",
> -	       .data = &sm8250_lpi_data,
> -	},
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
> -
> -static struct platform_driver lpi_pinctrl_driver = {
> -	.driver = {
> -		   .name = "qcom-lpass-lpi-pinctrl",
> -		   .of_match_table = lpi_pinctrl_of_match,
> -	},
> -	.probe = lpi_pinctrl_probe,
> -	.remove = lpi_pinctrl_remove,
> -};
> -
> -module_platform_driver(lpi_pinctrl_driver);
>  MODULE_DESCRIPTION("QTI LPI GPIO pin control driver");
>  MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> new file mode 100644
> index 0000000..ad84565
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020 Linaro Ltd.
> + */
> +#ifndef __PINCTRL_LPASS_LPI_H__
> +#define __PINCTRL_LPASS_LPI_H__
> +
> +#define LPI_SLEW_RATE_CTL_REG	0xa000
> +#define LPI_TLMM_REG_OFFSET		0x1000
> +#define LPI_SLEW_RATE_MAX		0x03
> +#define LPI_SLEW_BITS_SIZE		0x02
> +#define LPI_SLEW_RATE_MASK		GENMASK(1, 0)
> +#define LPI_GPIO_CFG_REG		0x00
> +#define LPI_GPIO_PULL_MASK		GENMASK(1, 0)
> +#define LPI_GPIO_FUNCTION_MASK		GENMASK(5, 2)
> +#define LPI_GPIO_OUT_STRENGTH_MASK	GENMASK(8, 6)
> +#define LPI_GPIO_OE_MASK		BIT(9)
> +#define LPI_GPIO_VALUE_REG		0x04
> +#define LPI_GPIO_VALUE_IN_MASK		BIT(0)
> +#define LPI_GPIO_VALUE_OUT_MASK		BIT(1)
> +
> +#define LPI_GPIO_BIAS_DISABLE		0x0
> +#define LPI_GPIO_PULL_DOWN		0x1
> +#define LPI_GPIO_KEEPER			0x2
> +#define LPI_GPIO_PULL_UP		0x3
> +#define LPI_GPIO_DS_TO_VAL(v)		(v / 2 - 1)
> +#define NO_SLEW				-1
> +
> +#define LPI_FUNCTION(fname)			                \
> +	[LPI_MUX_##fname] = {		                \
> +		.name = #fname,				\
> +		.groups = fname##_groups,               \
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
> +	{						\
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.pin = id,				\
> +		.slew_offset = soff,			\
> +		.npins = ARRAY_SIZE(gpio##id##_pins),	\
> +		.funcs = (int[]){			\
> +			LPI_MUX_gpio,			\
> +			LPI_MUX_##f1,			\
> +			LPI_MUX_##f2,			\
> +			LPI_MUX_##f3,			\
> +			LPI_MUX_##f4,			\
> +		},					\
> +		.nfuncs = 5,				\
> +	}
> +
> +struct lpi_pingroup {
> +	const char *name;
> +	const unsigned int *pins;
> +	unsigned int npins;
> +	unsigned int pin;
> +	/* Bit offset in slew register for SoundWire pins only */
> +	int slew_offset;
> +	unsigned int *funcs;
> +	unsigned int nfuncs;
> +};
> +
> +struct lpi_function {
> +	const char *name;
> +	const char * const *groups;
> +	unsigned int ngroups;
> +};
> +
> +struct lpi_pinctrl_variant_data {
> +	const struct pinctrl_pin_desc *pins;
> +	int npins;
> +	const struct lpi_pingroup *groups;
> +	int ngroups;
> +	const struct lpi_function *functions;
> +	int nfunctions;
> +};
> +
> +#define MAX_LPI_NUM_CLKS	2
> +
> +struct lpi_pinctrl {

Afaict this is only used by the common code, if so there's no need to
expose it in the header file.

> +	struct device *dev;
> +	struct pinctrl_dev *ctrl;
> +	struct gpio_chip chip;
> +	struct pinctrl_desc desc;
> +	char __iomem *tlmm_base;
> +	char __iomem *slew_base;
> +	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
> +	struct mutex slew_access_lock;
> +	const struct lpi_pinctrl_variant_data *data;
> +};
> +
> +int lpi_pinctrl_probe(struct platform_device *pdev);
> +int lpi_pinctrl_remove(struct platform_device *pdev);
> +
> +#endif /*__PINCTRL_LPASS_LPI_H__*/
> +
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> new file mode 100644
> index 0000000..9a5db15
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020 Linaro Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "pinctrl-lpass-lpi.h"
> +
> +enum lpass_lpi_functions {
> +	LPI_MUX_dmic1_clk,
> +	LPI_MUX_dmic1_data,
> +	LPI_MUX_dmic2_clk,
> +	LPI_MUX_dmic2_data,
> +	LPI_MUX_dmic3_clk,
> +	LPI_MUX_dmic3_data,
> +	LPI_MUX_i2s1_clk,
> +	LPI_MUX_i2s1_data,
> +	LPI_MUX_i2s1_ws,
> +	LPI_MUX_i2s2_clk,
> +	LPI_MUX_i2s2_data,
> +	LPI_MUX_i2s2_ws,
> +	LPI_MUX_qua_mi2s_data,
> +	LPI_MUX_qua_mi2s_sclk,
> +	LPI_MUX_qua_mi2s_ws,
> +	LPI_MUX_swr_rx_clk,
> +	LPI_MUX_swr_rx_data,
> +	LPI_MUX_swr_tx_clk,
> +	LPI_MUX_swr_tx_data,
> +	LPI_MUX_wsa_swr_clk,
> +	LPI_MUX_wsa_swr_data,
> +	LPI_MUX_gpio,
> +	LPI_MUX__,
> +};
> +
> +static const unsigned int gpio0_pins[] = { 0 };
> +static const unsigned int gpio1_pins[] = { 1 };
> +static const unsigned int gpio2_pins[] = { 2 };
> +static const unsigned int gpio3_pins[] = { 3 };
> +static const unsigned int gpio4_pins[] = { 4 };
> +static const unsigned int gpio5_pins[] = { 5 };
> +static const unsigned int gpio6_pins[] = { 6 };
> +static const unsigned int gpio7_pins[] = { 7 };
> +static const unsigned int gpio8_pins[] = { 8 };
> +static const unsigned int gpio9_pins[] = { 9 };
> +static const unsigned int gpio10_pins[] = { 10 };
> +static const unsigned int gpio11_pins[] = { 11 };
> +static const unsigned int gpio12_pins[] = { 12 };
> +static const unsigned int gpio13_pins[] = { 13 };
> +
> +/* sm8250 variant specific data */
> +static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
> +	PINCTRL_PIN(0, "gpio0"),
> +	PINCTRL_PIN(1, "gpio1"),
> +	PINCTRL_PIN(2, "gpio2"),
> +	PINCTRL_PIN(3, "gpio3"),
> +	PINCTRL_PIN(4, "gpio4"),
> +	PINCTRL_PIN(5, "gpio5"),
> +	PINCTRL_PIN(6, "gpio6"),
> +	PINCTRL_PIN(7, "gpio7"),
> +	PINCTRL_PIN(8, "gpio8"),
> +	PINCTRL_PIN(9, "gpio9"),
> +	PINCTRL_PIN(10, "gpio10"),
> +	PINCTRL_PIN(11, "gpio11"),
> +	PINCTRL_PIN(12, "gpio12"),
> +	PINCTRL_PIN(13, "gpio13"),
> +};
> +
> +static const char * const swr_tx_clk_groups[] = { "gpio0" };
> +static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
> +static const char * const swr_rx_clk_groups[] = { "gpio3" };
> +static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
> +static const char * const dmic1_clk_groups[] = { "gpio6" };
> +static const char * const dmic1_data_groups[] = { "gpio7" };
> +static const char * const dmic2_clk_groups[] = { "gpio8" };
> +static const char * const dmic2_data_groups[] = { "gpio9" };
> +static const char * const i2s2_clk_groups[] = { "gpio10" };
> +static const char * const i2s2_ws_groups[] = { "gpio11" };
> +static const char * const dmic3_clk_groups[] = { "gpio12" };
> +static const char * const dmic3_data_groups[] = { "gpio13" };
> +static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
> +static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
> +static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
> +static const char * const i2s1_clk_groups[] = { "gpio6" };
> +static const char * const i2s1_ws_groups[] = { "gpio7" };
> +static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
> +static const char * const wsa_swr_clk_groups[] = { "gpio10" };
> +static const char * const wsa_swr_data_groups[] = { "gpio11" };
> +static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
> +
> +static const struct lpi_pingroup sm8250_groups[] = {
> +	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
> +	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
> +	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
> +	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
> +	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
> +	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
> +	LPI_PINGROUP(6, NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
> +	LPI_PINGROUP(7, NO_SLEW, dmic1_data, i2s1_ws, _, _),
> +	LPI_PINGROUP(8, NO_SLEW, dmic2_clk, i2s1_data, _, _),
> +	LPI_PINGROUP(9, NO_SLEW, dmic2_data, i2s1_data, _, _),
> +	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
> +	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
> +	LPI_PINGROUP(12, NO_SLEW, dmic3_clk, i2s2_data, _, _),
> +	LPI_PINGROUP(13, NO_SLEW, dmic3_data, i2s2_data, _, _),
> +};
> +
> +static const struct lpi_function sm8250_functions[] = {
> +	LPI_FUNCTION(dmic1_clk),
> +	LPI_FUNCTION(dmic1_data),
> +	LPI_FUNCTION(dmic2_clk),
> +	LPI_FUNCTION(dmic2_data),
> +	LPI_FUNCTION(dmic3_clk),
> +	LPI_FUNCTION(dmic3_data),
> +	LPI_FUNCTION(i2s1_clk),
> +	LPI_FUNCTION(i2s1_data),
> +	LPI_FUNCTION(i2s1_ws),
> +	LPI_FUNCTION(i2s2_clk),
> +	LPI_FUNCTION(i2s2_data),
> +	LPI_FUNCTION(i2s2_ws),
> +	LPI_FUNCTION(qua_mi2s_data),
> +	LPI_FUNCTION(qua_mi2s_sclk),
> +	LPI_FUNCTION(qua_mi2s_ws),
> +	LPI_FUNCTION(swr_rx_clk),
> +	LPI_FUNCTION(swr_rx_data),
> +	LPI_FUNCTION(swr_tx_clk),
> +	LPI_FUNCTION(swr_tx_data),
> +	LPI_FUNCTION(wsa_swr_clk),
> +	LPI_FUNCTION(wsa_swr_data),
> +};
> +
> +static struct lpi_pinctrl_variant_data sm8250_lpi_data = {
> +	.pins = sm8250_lpi_pins,
> +	.npins = ARRAY_SIZE(sm8250_lpi_pins),
> +	.groups = sm8250_groups,
> +	.ngroups = ARRAY_SIZE(sm8250_groups),
> +	.functions = sm8250_functions,
> +	.nfunctions = ARRAY_SIZE(sm8250_functions),
> +};
> +
> +static const struct of_device_id lpi_pinctrl_of_match[] = {
> +	{
> +	       .compatible = "qcom,sm8250-lpass-lpi-pinctrl",
> +	       .data = &sm8250_lpi_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
> +
> +static struct platform_driver lpi_pinctrl_driver = {
> +	.driver = {
> +		   .name = "qcom-sm8250-lpass-lpi-pinctrl",
> +		   .of_match_table = lpi_pinctrl_of_match,
> +	},
> +	.probe = lpi_pinctrl_probe,
> +	.remove = lpi_pinctrl_remove,
> +};
> +
> +module_platform_driver(lpi_pinctrl_driver);
> +MODULE_DESCRIPTION("QTI SM8250 LPI GPIO pin control driver");
> +MODULE_LICENSE("GPL");
> +

Unnecessary empty line.

Thanks,
Bjorn

> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
