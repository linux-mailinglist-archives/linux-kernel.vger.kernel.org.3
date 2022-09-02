Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1585AB858
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIBSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIBSfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:35:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427926AE1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:35:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1901395wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=niZAHKVh64gtpmzwpJTHnkg94O+WeGO3E9/49vCP0mA=;
        b=KGaF25aS6brzj8URuVZeFP9rO1UyJxrpOFwN9UA4rbWoaVH9qCwhIHdYWTZJW0oAIp
         xJBxiV2BIwxtaqraqmsYxbM26W3V0QZMaCfcl6tndme3rRpBW4CfQvCyM9L00UGZlAXb
         EE7ntVWHkhQ5AFTLs2OY6Wmf7Hkzgn6+IZBwamDWRojcHvRAmSpecNr0IR9SQeizodRd
         zEF0N8l+Eq2SX4pBHKxAuQHL/JCoNnCRIzavlId59NPkFXEuJ7dji93J4qJr8XvHuT2R
         H0nquuF4spF/wwUlUA94bSY/jkvplhwtI4Sg4jfLLyclQGqkhHBOSq86K91DqTHKNbYj
         uz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=niZAHKVh64gtpmzwpJTHnkg94O+WeGO3E9/49vCP0mA=;
        b=lUfpTvRLzVmATIhPQxgpwIJsRxQ/q5MfUvQ1k55LH/S2SPi3MjUnlLojZ+i9qf3O8n
         umUI5oq8o936H6ewl9Bm+RqZ2x/ga3uo6LhszVIHglEORmwt94uqG/tqbN9tTLmL0VI0
         Hpx8d0BegxzyAP0W3I6w90pO6IqqKRd1nDGUJBa89SRs/Grfjs/iZkWHpZ8QWDUUZEHF
         BH01iYqJ4j8tMWnmCcSQdeYoRrEKf90qMslyBzX7q6U+KTO+AMgGzu1jstmh6f6F5JmW
         TuRkJhlRw1xHL9ta212qH4ficaPPjtDRZYmjZx/2WE+iOi3j7576wDwt64MRUP3A5r2F
         VjlA==
X-Gm-Message-State: ACgBeo3Ni1kXMxzZu++/nhFRUnbtpH8P89S8R/TLmilF+ZvNNZ6yCb+C
        26nXKtwZLNEbDu+fTKzAvRTRXQ==
X-Google-Smtp-Source: AA6agR49lqN/61WJGMQqgdnr+8m4C2M0Bm2h9QER8PqOK2QKNltoy1SikmTcmNCAFPtPvWhSme52Zw==
X-Received: by 2002:a05:600c:3d05:b0:3a5:dd21:e201 with SMTP id bh5-20020a05600c3d0500b003a5dd21e201mr3773404wmb.132.1662143733350;
        Fri, 02 Sep 2022 11:35:33 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d56ce000000b00226d238be98sm2021494wrw.82.2022.09.02.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:35:32 -0700 (PDT)
Date:   Fri, 2 Sep 2022 21:35:28 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V3 5/8] clk: imx: add i.MX93 clk gate
Message-ID: <YxJM8GOMz8ngdnR2@linaro.org>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
 <20220830033137.4149542-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830033137.4149542-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-30 11:31:34, Peng Fan (OSS) wrote:
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

I'm OK with it.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

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
