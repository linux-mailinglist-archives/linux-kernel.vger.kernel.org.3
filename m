Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02404592D65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbiHOJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiHOJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:07:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A5186CD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:07:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l4so8321920wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XR/wsXfmXCzg8r3+S4lhj+Z3S8I7VI56MjEGVvb4cQo=;
        b=RBURkCXHFL+msu3OORzAILJzna663BOYF7Kjsm6W4PRdkavbzJRjCgLER1LsstyvN2
         Kv15WLb7imTdJySPKekhqC4lNf9sQ8AeztQVM3izBGHMyqAPEk2Lr82blemHL/+lP5qL
         m3+lHDywOgOxIO12c62594AAsGJzfYoNEg95pPNrULl0YlxvfkASjkVdQRjI7gqKfU+9
         /PWerd6mKP9B0pMVXX2fWQ9QWKAOMbJ+WQ3fdbpfZmw0L1ab6UK3BeNwMCLNveqy5WkE
         idkQNYNr67rhXszRXyWTWaUtDB9jsLIrHfphm/kpoV8Vi01+hrrifrJRcKHWap0ItSoa
         pPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XR/wsXfmXCzg8r3+S4lhj+Z3S8I7VI56MjEGVvb4cQo=;
        b=s89QlboRHFNEgnIeoBWqRaFVdYWZKrLbvyjIHLL+dB11MpaGY+U+6rH89riCpyFiql
         +oNVjvBE0fmJGFtg8yZW2NxtplUsPfeo16axlmkPTDPoldkBVgEFXOmSp4Q2+oN01K8J
         3mC4PB2kueT5TkBPYDUaTSLQ/ZlXiGzPU/eGniJALWUq+HipsY/I/nCDc6J9tjVqoSE9
         27P0GcSX5QJ4K95X88dPVycUDXgdWh8kAo/FBoniOOits7LrijZ06gjZZCfzjmjAZFqj
         LJQm1KywUumokuzB7i/Q6hbgoUeh+IcE9djbjrbPnNP1WsRTj78fB1HwllX0cd5zuCBM
         juuA==
X-Gm-Message-State: ACgBeo08O9VlbNbJXKjw4Q56iQfSegceECIwkbT+nN7DgAMZdiu4/Ms0
        x6KEz2FRMEXT0RxaAwgb6MxTIxWDCBicpA==
X-Google-Smtp-Source: AA6agR5CpA+ZSzIrXHPV7hGREh1CCtUSMrJOerPkDDUdPxR9lIhr6pmoAk7SMvD9KZPNkf9mJN/tow==
X-Received: by 2002:a05:6000:1ac8:b0:220:8168:126b with SMTP id i8-20020a0560001ac800b002208168126bmr8199662wry.288.1660554474174;
        Mon, 15 Aug 2022 02:07:54 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t16-20020adfdc10000000b0021e5f32ade7sm6690502wri.68.2022.08.15.02.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:07:53 -0700 (PDT)
Date:   Mon, 15 Aug 2022 12:07:51 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V2 5/8] clk: imx: add i.MX93 clk gate
Message-ID: <YvoM5/6mR5MtGxuk@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013039.474970-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:30:36, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 LPCG is different from i.MX8M CCGR. Although imx_clk_hw_gate4_flags
> is used here, it not strictly match i.MX93. i.MX93 has such design:
>  - LPCG_DIRECT use BIT0 as on/off gate when LPCG_AUTHEN CPU_LPM is 0
>  - LPCG_LPM_CUR use BIT[2:0] as on/off gate when LPCG_AUTHEN CPU_LPM is 1
> 
> The current implementation suppose CPU_LPM is 0, and use LPCG_DIRECT
> BIT[1:0] as on/off gate. Although BIT1 is touched, actually BIT1 is
> reserved.
> 
> And imx_clk_hw_gate4_flags use mask 0x3 to determine whether the clk
> is enabled or not, but i.MX93 LPCG only use BIT0 to control when CPU_LPM
> is 0. So clk disabled unused during kernel boot not able to gate off
> the unused clocks.
> 
> To match i.MX93 LPCG, introduce imx93_clk_gate.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  drivers/clk/imx/Makefile      |   2 +-
>  drivers/clk/imx/clk-gate-93.c | 199 ++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h         |   4 +
>  3 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-gate-93.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 88b9b9285d22..89fe72327788 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -28,7 +28,7 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
>  obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
>  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>  
> -obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
> +obj-$(CONFIG_CLK_IMX93) += clk-imx93.o clk-gate-93.o
>  
>  obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
>  clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
> diff --git a/drivers/clk/imx/clk-gate-93.c b/drivers/clk/imx/clk-gate-93.c
> new file mode 100644
> index 000000000000..ceb56b290394
> --- /dev/null
> +++ b/drivers/clk/imx/clk-gate-93.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 NXP
> + *
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define DIRECT_OFFSET		0x0
> +
> +/*
> + * 0b000 - LPCG will be OFF in any CPU mode.
> + * 0b100 - LPCG will be ON in any CPU mode.
> + */
> +#define LPM_SETTING_OFF		0x0
> +#define LPM_SETTING_ON		0x4
> +
> +#define LPM_CUR_OFFSET		0x1c
> +
> +#define AUTHEN_OFFSET		0x30
> +#define CPULPM_EN		BIT(2)
> +#define TZ_NS_SHIFT		9
> +#define TZ_NS_MASK		BIT(9)
> +
> +#define WHITE_LIST_SHIFT	16
> +
> +struct imx93_clk_gate {
> +	struct clk_hw hw;
> +	void __iomem	*reg;
> +	u32		bit_idx;
> +	u32		val;
> +	u32		mask;
> +	spinlock_t	*lock;
> +	unsigned int	*share_count;
> +};
> +
> +#define to_imx93_clk_gate(_hw) container_of(_hw, struct imx93_clk_gate, hw)
> +
> +static void imx93_clk_gate_do_hardware(struct clk_hw *hw, bool enable)
> +{
> +	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
> +	u32 val;
> +
> +	val = readl(gate->reg + AUTHEN_OFFSET);
> +	if (val & CPULPM_EN) {
> +		val = enable ? LPM_SETTING_ON : LPM_SETTING_OFF;
> +		writel(val, gate->reg + LPM_CUR_OFFSET);
> +	} else {
> +		val = readl(gate->reg + DIRECT_OFFSET);
> +		val &= ~(gate->mask << gate->bit_idx);
> +		if (enable)
> +			val |= (gate->val & gate->mask) << gate->bit_idx;
> +		writel(val, gate->reg + DIRECT_OFFSET);
> +	}
> +}
> +
> +static int imx93_clk_gate_enable(struct clk_hw *hw)
> +{
> +	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	if (gate->share_count && (*gate->share_count)++ > 0)
> +		goto out;
> +
> +	imx93_clk_gate_do_hardware(hw, true);
> +out:
> +	spin_unlock_irqrestore(gate->lock, flags);
> +
> +	return 0;
> +}

Just wondering if we could use the existing clk-gate2 since we would
only have to implement the ops that are different there.

Also, would the next i.MX9 platforms also use this? Or will we have one
similar driver for each new platform?

> +
> +static void imx93_clk_gate_disable(struct clk_hw *hw)
> +{
> +	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	if (gate->share_count) {
> +		if (WARN_ON(*gate->share_count == 0))
> +			goto out;
> +		else if (--(*gate->share_count) > 0)
> +			goto out;
> +	}
> +
> +	imx93_clk_gate_do_hardware(hw, false);
> +out:
> +	spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static int imx93_clk_gate_reg_is_enabled(struct imx93_clk_gate *gate)
> +{
> +	u32 val = readl(gate->reg + AUTHEN_OFFSET);
> +
> +	if (val & CPULPM_EN) {
> +		val = readl(gate->reg + LPM_CUR_OFFSET);
> +		if (val == LPM_SETTING_ON)
> +			return 1;
> +	} else {
> +		val = readl(gate->reg);
> +		if (((val >> gate->bit_idx) & gate->mask) == gate->val)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx93_clk_gate_is_enabled(struct clk_hw *hw)
> +{
> +	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	ret = imx93_clk_gate_reg_is_enabled(gate);
> +
> +	spin_unlock_irqrestore(gate->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void imx93_clk_gate_disable_unused(struct clk_hw *hw)
> +{
> +	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	if (!gate->share_count || *gate->share_count == 0)
> +		imx93_clk_gate_do_hardware(hw, false);
> +
> +	spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static const struct clk_ops imx93_clk_gate_ops = {
> +	.enable = imx93_clk_gate_enable,
> +	.disable = imx93_clk_gate_disable,
> +	.disable_unused = imx93_clk_gate_disable_unused,
> +	.is_enabled = imx93_clk_gate_is_enabled,
> +};
> +
> +static const struct clk_ops imx93_clk_gate_ro_ops = {
> +	.is_enabled = imx93_clk_gate_is_enabled,
> +};
> +
> +struct clk_hw *imx93_clk_gate(struct device *dev, const char *name, const char *parent_name,
> +			      unsigned long flags, void __iomem *reg, u32 bit_idx, u32 val,
> +			      u32 mask, u32 domain_id, unsigned int *share_count)
> +{
> +	struct imx93_clk_gate *gate;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret;
> +	u32 authen;
> +
> +	gate = kzalloc(sizeof(struct imx93_clk_gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	gate->reg = reg;
> +	gate->lock = &imx_ccm_lock;
> +	gate->bit_idx = bit_idx;
> +	gate->val = val;
> +	gate->mask = mask;
> +	gate->share_count = share_count;
> +
> +	init.name = name;
> +	init.ops = &imx93_clk_gate_ops;
> +	init.flags = flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE;
> +	init.parent_names = parent_name ? &parent_name : NULL;
> +	init.num_parents = parent_name ? 1 : 0;
> +
> +	gate->hw.init = &init;
> +	hw = &gate->hw;
> +
> +	authen = readl(reg + AUTHEN_OFFSET);
> +	if (!(authen & TZ_NS_MASK) || !(authen & BIT(WHITE_LIST_SHIFT + domain_id)))
> +		init.ops = &imx93_clk_gate_ro_ops;
> +
> +	ret = clk_hw_register(dev, hw);
> +	if (ret) {
> +		kfree(gate);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +EXPORT_SYMBOL_GPL(imx93_clk_gate);
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 396a5ea75083..dd49f90110e8 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -451,6 +451,10 @@ struct clk_hw *imx93_clk_composite_flags(const char *name,
>  	imx93_clk_composite_flags(name, parent_names, num_parents, reg, domain_id \
>  				  CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
>  
> +struct clk_hw *imx93_clk_gate(struct device *dev, const char *name, const char *parent_name,
> +			      unsigned long flags, void __iomem *reg, u32 bit_idx, u32 val,
> +			      u32 mask, u32 domain_id, unsigned int *share_count);
> +
>  struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
>  		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_divider_flags, const struct clk_div_table *table,
> -- 
> 2.37.1
> 
