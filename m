Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C964BC4F7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiBSCmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:42:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiBSCmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:42:21 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303E6A054
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:42:01 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 13so5049816oiz.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BYr579noUa+v/EevgyiiBpBGftY8I6NvFfFqbmvgVPg=;
        b=lq9SttMKTQi+OIqSysXHp4QDH87Z08F6PT4TArsjISf7YMLs5kXrWPGh6XOqzyjSAI
         BpMR4Gu5f4F1u0h8pqZeEraTCyZVvdeCRrSdCgsdZS7zCu/jiJj9ue7Hx+hBSiYLyx0o
         zITutlI6jDwh9NeQ/FELd2/4y3YrobCg/v4ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BYr579noUa+v/EevgyiiBpBGftY8I6NvFfFqbmvgVPg=;
        b=y8lc/YERq/TJaLCVudPISDdXi7sDJUUwKWKwLZZicS6reMURcGBDVWj+nah9xVHHZa
         H8jjUBbr2kUoNZ9CPHNA0XMYE1dDNfbk7LkSryMfvWLq3ICz+oU4zyuXhIO//LrXYqrZ
         N3fE1Ox3Qy1y6HIRX/krIn+1CtorrM6rkNJoB4ZU63V+KuUisb6d2xjugnvc+wCMSaNU
         Rg7hRxzYLUlCzWypFJmMpoatuWQl8S7V/xWwuXzfWOiCYOSCJMP9hka8GCKVNgf4D+xG
         yyNfJB0PVJGnaVZValGWofrPsjoz/fv2N3AyHfQ2f9YvYehU/riKS2690IqBuER/TPV0
         GyGQ==
X-Gm-Message-State: AOAM5338CHg8XHezKQjSu4T2X5owbP1/b4NIvVRyrYT9gswJpYhoPAqX
        Nt91TaOHTriroszf7vDcmJ4IhMpY3IttG4CSlBXEbA==
X-Google-Smtp-Source: ABdhPJz3wTFfUooHNMBgbpJtCGjVTLtMQgGIzsDLA791qi/BpaTBHKMpt7dJlMBa3SAb6cuIZN0tB2/QvLkzyyKlH78=
X-Received: by 2002:a05:6808:f88:b0:2d4:c8c2:b898 with SMTP id
 o8-20020a0568080f8800b002d4c8c2b898mr603490oiw.112.1645238520857; Fri, 18 Feb
 2022 18:42:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 18:42:00 -0800
MIME-Version: 1.0
In-Reply-To: <1644851994-22732-6-git-send-email-quic_srivasam@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com> <1644851994-22732-6-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 18:42:00 -0800
Message-ID: <CAE-0n521g=RMetskRmiz-QxTJWaewYxDSJ6UtvZuYDM5Hq-sHQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] pinctrl: qcom: Extract chip specific LPASS LPI code
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-14 07:19:52)
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index ca6f68a..8871451 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -357,4 +357,12 @@ config PINCTRL_LPASS_LPI
>           Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>           (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
>
> +config PINCTRL_SM8250_LPASS_LPI

Can this be sorted somehow? On Kconfig? Adding to the end of the file
causes conflicts more often than adding alphabetically.

> +       tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
> +       depends on PINCTRL_LPASS_LPI
> +       help
> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +         Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
> +         (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
> +
>  endif
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 709882f..c10d14d2 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>  obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>  obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
>  obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
> +obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o

Can this be sorted somehow? Either on Kconfig or file name?

> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 54750ba..8a82fd9 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -4,91 +4,15 @@
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
> -#include "../core.h"
>  #include "../pinctrl-utils.h"
> -
> -#define LPI_SLEW_RATE_CTL_REG          0xa000
> -#define LPI_TLMM_REG_OFFSET            0x1000
> -#define LPI_SLEW_RATE_MAX              0x03
> -#define LPI_SLEW_BITS_SIZE             0x02
> -#define LPI_SLEW_RATE_MASK             GENMASK(1, 0)
> -#define LPI_GPIO_CFG_REG               0x00
> -#define LPI_GPIO_PULL_MASK             GENMASK(1, 0)
> -#define LPI_GPIO_FUNCTION_MASK         GENMASK(5, 2)
> -#define LPI_GPIO_OUT_STRENGTH_MASK     GENMASK(8, 6)
> -#define LPI_GPIO_OE_MASK               BIT(9)
> -#define LPI_GPIO_VALUE_REG             0x04
> -#define LPI_GPIO_VALUE_IN_MASK         BIT(0)
> -#define LPI_GPIO_VALUE_OUT_MASK                BIT(1)
> -
> -#define LPI_GPIO_BIAS_DISABLE          0x0
> -#define LPI_GPIO_PULL_DOWN             0x1
> -#define LPI_GPIO_KEEPER                        0x2
> -#define LPI_GPIO_PULL_UP               0x3
> -#define LPI_GPIO_DS_TO_VAL(v)          (v / 2 - 1)
> -#define LPI_NO_SLEW                            -1
> -
> -#define LPI_FUNCTION(fname)                                    \
> -       [LPI_MUX_##fname] = {                           \
> -               .name = #fname,                         \
> -               .groups = fname##_groups,               \
> -               .ngroups = ARRAY_SIZE(fname##_groups),  \
> -       }
> -
> -#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)         \
> -       {                                               \
> -               .group.name = "gpio" #id,                       \
> -               .group.pins = gpio##id##_pins,          \
> -               .pin = id,                              \
> -               .slew_offset = soff,                    \
> -               .group.num_pins = ARRAY_SIZE(gpio##id##_pins),  \
> -               .funcs = (int[]){                       \
> -                       LPI_MUX_gpio,                   \
> -                       LPI_MUX_##f1,                   \
> -                       LPI_MUX_##f2,                   \
> -                       LPI_MUX_##f3,                   \
> -                       LPI_MUX_##f4,                   \
> -               },                                      \
> -               .nfuncs = 5,                            \
> -       }
> -
> -struct lpi_pingroup {
> -       struct group_desc group;
> -       unsigned int pin;
> -       /* Bit offset in slew register for SoundWire pins only */
> -       int slew_offset;
> -       unsigned int *funcs;
> -       unsigned int nfuncs;
> -};
> -
> -struct lpi_function {
> -       const char *name;
> -       const char * const *groups;
> -       unsigned int ngroups;
> -};
> -
> -struct lpi_pinctrl_variant_data {
> -       const struct pinctrl_pin_desc *pins;
> -       int npins;
> -       const struct lpi_pingroup *groups;
> -       int ngroups;
> -       const struct lpi_function *functions;
> -       int nfunctions;
> -};
> +#include "pinctrl-lpass-lpi.h"
>
>  #define MAX_LPI_NUM_CLKS       2
>
> @@ -104,136 +28,6 @@ struct lpi_pinctrl {
>         const struct lpi_pinctrl_variant_data *data;
>  };
>
> -/* sm8250 variant specific data */
> -static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
> -       PINCTRL_PIN(0, "gpio0"),
> -       PINCTRL_PIN(1, "gpio1"),
> -       PINCTRL_PIN(2, "gpio2"),
> -       PINCTRL_PIN(3, "gpio3"),
> -       PINCTRL_PIN(4, "gpio4"),
> -       PINCTRL_PIN(5, "gpio5"),
> -       PINCTRL_PIN(6, "gpio6"),
> -       PINCTRL_PIN(7, "gpio7"),
> -       PINCTRL_PIN(8, "gpio8"),
> -       PINCTRL_PIN(9, "gpio9"),
> -       PINCTRL_PIN(10, "gpio10"),
> -       PINCTRL_PIN(11, "gpio11"),
> -       PINCTRL_PIN(12, "gpio12"),
> -       PINCTRL_PIN(13, "gpio13"),
> -};
> -
> -enum sm8250_lpi_functions {
> -       LPI_MUX_dmic1_clk,
> -       LPI_MUX_dmic1_data,
> -       LPI_MUX_dmic2_clk,
> -       LPI_MUX_dmic2_data,
> -       LPI_MUX_dmic3_clk,
> -       LPI_MUX_dmic3_data,
> -       LPI_MUX_i2s1_clk,
> -       LPI_MUX_i2s1_data,
> -       LPI_MUX_i2s1_ws,
> -       LPI_MUX_i2s2_clk,
> -       LPI_MUX_i2s2_data,
> -       LPI_MUX_i2s2_ws,
> -       LPI_MUX_qua_mi2s_data,
> -       LPI_MUX_qua_mi2s_sclk,
> -       LPI_MUX_qua_mi2s_ws,
> -       LPI_MUX_swr_rx_clk,
> -       LPI_MUX_swr_rx_data,
> -       LPI_MUX_swr_tx_clk,
> -       LPI_MUX_swr_tx_data,
> -       LPI_MUX_wsa_swr_clk,
> -       LPI_MUX_wsa_swr_data,
> -       LPI_MUX_gpio,
> -       LPI_MUX__,
> -};
> -
> -static int gpio0_pins[] = { 0 };
> -static int gpio1_pins[] = { 1 };
> -static int gpio2_pins[] = { 2 };
> -static int gpio3_pins[] = { 3 };
> -static int gpio4_pins[] = { 4 };
> -static int gpio5_pins[] = { 5 };
> -static int gpio6_pins[] = { 6 };
> -static int gpio7_pins[] = { 7 };
> -static int gpio8_pins[] = { 8 };
> -static int gpio9_pins[] = { 9 };
> -static int gpio10_pins[] = { 10 };
> -static int gpio11_pins[] = { 11 };
> -static int gpio12_pins[] = { 12 };
> -static int gpio13_pins[] = { 13 };
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
> -       LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
> -       LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
> -       LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
> -       LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
> -       LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
> -       LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
> -       LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
> -       LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
> -       LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
> -       LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
> -       LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
> -       LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
> -       LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
> -       LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
> -};
> -
> -static const struct lpi_function sm8250_functions[] = {
> -       LPI_FUNCTION(dmic1_clk),
> -       LPI_FUNCTION(dmic1_data),
> -       LPI_FUNCTION(dmic2_clk),
> -       LPI_FUNCTION(dmic2_data),
> -       LPI_FUNCTION(dmic3_clk),
> -       LPI_FUNCTION(dmic3_data),
> -       LPI_FUNCTION(i2s1_clk),
> -       LPI_FUNCTION(i2s1_data),
> -       LPI_FUNCTION(i2s1_ws),
> -       LPI_FUNCTION(i2s2_clk),
> -       LPI_FUNCTION(i2s2_data),
> -       LPI_FUNCTION(i2s2_ws),
> -       LPI_FUNCTION(qua_mi2s_data),
> -       LPI_FUNCTION(qua_mi2s_sclk),
> -       LPI_FUNCTION(qua_mi2s_ws),
> -       LPI_FUNCTION(swr_rx_clk),
> -       LPI_FUNCTION(swr_rx_data),
> -       LPI_FUNCTION(swr_tx_clk),
> -       LPI_FUNCTION(swr_tx_data),
> -       LPI_FUNCTION(wsa_swr_clk),
> -       LPI_FUNCTION(wsa_swr_data),
> -};
> -
> -static struct lpi_pinctrl_variant_data sm8250_lpi_data = {
> -       .pins = sm8250_lpi_pins,
> -       .npins = ARRAY_SIZE(sm8250_lpi_pins),
> -       .groups = sm8250_groups,
> -       .ngroups = ARRAY_SIZE(sm8250_groups),
> -       .functions = sm8250_functions,
> -       .nfunctions = ARRAY_SIZE(sm8250_functions),
> -};
> -
>  static int lpi_gpio_read(struct lpi_pinctrl *state, unsigned int pin,
>                          unsigned int addr)
>  {
> @@ -580,7 +374,7 @@ static const struct gpio_chip lpi_gpio_template = {
>         .dbg_show               = lpi_gpio_dbg_show,
>  };
>
> -static int lpi_pinctrl_probe(struct platform_device *pdev)
> +int lpi_pinctrl_probe(struct platform_device *pdev)
>  {
>         const struct lpi_pinctrl_variant_data *data;
>         struct device *dev = &pdev->dev;
> @@ -659,8 +453,9 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
>
>         return ret;
>  }
> +EXPORT_SYMBOL(lpi_pinctrl_probe);

EXPORT_SYMBOL_GPL?

>
> -static int lpi_pinctrl_remove(struct platform_device *pdev)
> +int lpi_pinctrl_remove(struct platform_device *pdev)
>  {
>         struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
>
> @@ -669,25 +464,7 @@ static int lpi_pinctrl_remove(struct platform_device *pdev)
>
>         return 0;
>  }
> +EXPORT_SYMBOL(lpi_pinctrl_remove);

EXPORT_SYMBOL_GPL?

>
> -static const struct of_device_id lpi_pinctrl_of_match[] = {
> -       {
> -              .compatible = "qcom,sm8250-lpass-lpi-pinctrl",
> -              .data = &sm8250_lpi_data,
> -       },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> new file mode 100644
> index 0000000..a511d72
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020 Linaro Ltd.
> + */
> +#ifndef __PINCTRL_LPASS_LPI_H__
> +#define __PINCTRL_LPASS_LPI_H__
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include "../core.h"
> +
> +#define LPI_SLEW_RATE_CTL_REG  0xa000
> +#define LPI_TLMM_REG_OFFSET            0x1000
> +#define LPI_SLEW_RATE_MAX              0x03
> +#define LPI_SLEW_BITS_SIZE             0x02
> +#define LPI_SLEW_RATE_MASK             GENMASK(1, 0)
> +#define LPI_GPIO_CFG_REG               0x00
> +#define LPI_GPIO_PULL_MASK             GENMASK(1, 0)
> +#define LPI_GPIO_FUNCTION_MASK         GENMASK(5, 2)
> +#define LPI_GPIO_OUT_STRENGTH_MASK     GENMASK(8, 6)
> +#define LPI_GPIO_OE_MASK               BIT(9)
> +#define LPI_GPIO_VALUE_REG             0x04
> +#define LPI_GPIO_VALUE_IN_MASK         BIT(0)
> +#define LPI_GPIO_VALUE_OUT_MASK                BIT(1)
> +
> +#define LPI_GPIO_BIAS_DISABLE          0x0
> +#define LPI_GPIO_PULL_DOWN             0x1
> +#define LPI_GPIO_KEEPER                        0x2
> +#define LPI_GPIO_PULL_UP               0x3
> +#define LPI_GPIO_DS_TO_VAL(v)          (v / 2 - 1)
> +#define LPI_NO_SLEW                            -1
> +
> +#define LPI_FUNCTION(fname)                                    \
> +       [LPI_MUX_##fname] = {                           \
> +               .name = #fname,                         \
> +               .groups = fname##_groups,               \
> +               .ngroups = ARRAY_SIZE(fname##_groups),  \
> +       }
> +
> +#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)         \
> +       {                                               \
> +               .group.name = "gpio" #id,                       \
> +               .group.pins = gpio##id##_pins,          \
> +               .pin = id,                              \
> +               .slew_offset = soff,                    \
> +               .group.num_pins = ARRAY_SIZE(gpio##id##_pins),  \
> +               .funcs = (int[]){                       \
> +                       LPI_MUX_gpio,                   \
> +                       LPI_MUX_##f1,                   \
> +                       LPI_MUX_##f2,                   \
> +                       LPI_MUX_##f3,                   \
> +                       LPI_MUX_##f4,                   \
> +               },                                      \
> +               .nfuncs = 5,                            \
> +       }
> +
> +struct lpi_pingroup {
> +       struct group_desc group;
> +       unsigned int pin;
> +       /* Bit offset in slew register for SoundWire pins only */
> +       int slew_offset;
> +       unsigned int *funcs;
> +       unsigned int nfuncs;
> +};
> +
> +struct lpi_function {
> +       const char *name;
> +       const char * const *groups;
> +       unsigned int ngroups;
> +};
> +
> +struct lpi_pinctrl_variant_data {
> +       const struct pinctrl_pin_desc *pins;
> +       int npins;
> +       const struct lpi_pingroup *groups;
> +       int ngroups;
> +       const struct lpi_function *functions;
> +       int nfunctions;
> +};
> +
> +int lpi_pinctrl_probe(struct platform_device *pdev);
> +int lpi_pinctrl_remove(struct platform_device *pdev);
> +
> +#endif /*__PINCTRL_LPASS_LPI_H__*/
> +

Drop the extra newline on this file please.

> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> new file mode 100644
> index 0000000..27e358e
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

Drop unused include please.

> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "pinctrl-lpass-lpi.h"
> +
> +enum lpass_lpi_functions {
> +       LPI_MUX_dmic1_clk,
> +       LPI_MUX_dmic1_data,
> +       LPI_MUX_dmic2_clk,
> +       LPI_MUX_dmic2_data,
> +       LPI_MUX_dmic3_clk,
> +       LPI_MUX_dmic3_data,
> +       LPI_MUX_i2s1_clk,
> +       LPI_MUX_i2s1_data,
> +       LPI_MUX_i2s1_ws,
> +       LPI_MUX_i2s2_clk,
> +       LPI_MUX_i2s2_data,
> +       LPI_MUX_i2s2_ws,
> +       LPI_MUX_qua_mi2s_data,
> +       LPI_MUX_qua_mi2s_sclk,
> +       LPI_MUX_qua_mi2s_ws,
> +       LPI_MUX_swr_rx_clk,
> +       LPI_MUX_swr_rx_data,
> +       LPI_MUX_swr_tx_clk,
> +       LPI_MUX_swr_tx_data,
> +       LPI_MUX_wsa_swr_clk,
> +       LPI_MUX_wsa_swr_data,
> +       LPI_MUX_gpio,
> +       LPI_MUX__,
> +};
> +
> +static int gpio0_pins[] = { 0 };

Why not const?

> +static int gpio1_pins[] = { 1 };
> +static int gpio2_pins[] = { 2 };
> +static int gpio3_pins[] = { 3 };
> +static int gpio4_pins[] = { 4 };
> +static int gpio5_pins[] = { 5 };
> +static int gpio6_pins[] = { 6 };
> +static int gpio7_pins[] = { 7 };
> +static int gpio8_pins[] = { 8 };
> +static int gpio9_pins[] = { 9 };
> +static int gpio10_pins[] = { 10 };
> +static int gpio11_pins[] = { 11 };
> +static int gpio12_pins[] = { 12 };
> +static int gpio13_pins[] = { 13 };
> +
> +
> +/* sm8250 variant specific data */
> +static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
> +       PINCTRL_PIN(0, "gpio0"),
> +       PINCTRL_PIN(1, "gpio1"),
> +       PINCTRL_PIN(2, "gpio2"),
> +       PINCTRL_PIN(3, "gpio3"),
> +       PINCTRL_PIN(4, "gpio4"),
> +       PINCTRL_PIN(5, "gpio5"),
> +       PINCTRL_PIN(6, "gpio6"),
> +       PINCTRL_PIN(7, "gpio7"),
> +       PINCTRL_PIN(8, "gpio8"),
> +       PINCTRL_PIN(9, "gpio9"),
> +       PINCTRL_PIN(10, "gpio10"),
> +       PINCTRL_PIN(11, "gpio11"),
> +       PINCTRL_PIN(12, "gpio12"),
> +       PINCTRL_PIN(13, "gpio13"),
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
> +       LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
> +       LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
> +       LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
> +       LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
> +       LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
> +       LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
> +       LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
> +       LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
> +       LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
> +       LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
> +       LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
> +       LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
> +       LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
> +       LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
> +};
> +
> +static const struct lpi_function sm8250_functions[] = {
> +       LPI_FUNCTION(dmic1_clk),
> +       LPI_FUNCTION(dmic1_data),
> +       LPI_FUNCTION(dmic2_clk),
> +       LPI_FUNCTION(dmic2_data),
> +       LPI_FUNCTION(dmic3_clk),
> +       LPI_FUNCTION(dmic3_data),
> +       LPI_FUNCTION(i2s1_clk),
> +       LPI_FUNCTION(i2s1_data),
> +       LPI_FUNCTION(i2s1_ws),
> +       LPI_FUNCTION(i2s2_clk),
> +       LPI_FUNCTION(i2s2_data),
> +       LPI_FUNCTION(i2s2_ws),
> +       LPI_FUNCTION(qua_mi2s_data),
> +       LPI_FUNCTION(qua_mi2s_sclk),
> +       LPI_FUNCTION(qua_mi2s_ws),
> +       LPI_FUNCTION(swr_rx_clk),
> +       LPI_FUNCTION(swr_rx_data),
> +       LPI_FUNCTION(swr_tx_clk),
> +       LPI_FUNCTION(swr_tx_data),
> +       LPI_FUNCTION(wsa_swr_clk),
> +       LPI_FUNCTION(wsa_swr_data),
> +};
> +
> +static struct lpi_pinctrl_variant_data sm8250_lpi_data = {

It would be great if this could be const.

> +       .pins = sm8250_lpi_pins,
> +       .npins = ARRAY_SIZE(sm8250_lpi_pins),
> +       .groups = sm8250_groups,
> +       .ngroups = ARRAY_SIZE(sm8250_groups),
> +       .functions = sm8250_functions,
> +       .nfunctions = ARRAY_SIZE(sm8250_functions),
> +};
> +
