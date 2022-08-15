Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF421592CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiHOIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHOIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:54:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538F20BF5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:54:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so8280353wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=iidtuaE8s+DCGaLOdt5ZKpKtusZpSzaBfJPqYoME7mI=;
        b=UIl8fcznIabQRcconZq+r+VdCAMu5ynRV5wJw56zB6P8OflqhLPyyuLkzBWh3Aw54z
         AqXWK9SbrysFB8qbsSyQ6bN+EkJnaFnC+vC9pgVvZQcGvc6XsqocGWTXK2UmcICHX/1A
         wSSS1y/b64RblHHpj/qzpoc+Nforg0AzeBQ04wiyH/AYTx763jN3Mtf+Ea8rZTOcxUud
         gJkDE3fEyW78naqeAr0Eol/C9Z1zV2RmuAMvWeD+z6mVqXyjI05UReYGojWDsLYuuAK9
         H0QyFVyZL+9xwLRxO51/TiAPf4HjjInFGcJbJiwys03F0jg49eoq67b7X9EJYPCV7VwS
         V9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iidtuaE8s+DCGaLOdt5ZKpKtusZpSzaBfJPqYoME7mI=;
        b=RXKaZBXMS6YpyTEsza7khNnf5QnfNNcuTxKgopaHTWJ1C1Pvx1+cXvwJuLbOOpcx2t
         4rS4qtiR7nYyDD8fNLY8gxPY7bVSvJP2ViwxwAs++xISf0NPDZ007qjW0RiQia7l5rgD
         +zg5liY76CGb1gfyg0P7J1l+6gV66r0k1+g47t7nJE6mapbfelnOeMgEjeJbqodpdmen
         hSqpB8WpUynHaGLolH2Qk6zQLbNl2ouPUKFx1qT0JFCWueFHSaVVtNMYqi9JKB8QAPRM
         AS+4MhN23vKDXY1utoM+TMFk/W/lv80cDYGMccpDydgkQ4mFUulqighv1rxAv0qYdrzs
         6EHw==
X-Gm-Message-State: ACgBeo2AAYGmldGsOB/NaVO1jxwTe/vntD3gsszx96VvVZ+MfrW3LzY+
        7qz4NyY6sbkYUErjXRw6Zj43Jw==
X-Google-Smtp-Source: AA6agR6YiDuscaXokbybBjZAvFR/jtnraP/BMqaoEW68eHcfYMpWEyoDGJ/2ThjvAxYRi0M7YVM0Ew==
X-Received: by 2002:a5d:4705:0:b0:21f:3890:8619 with SMTP id y5-20020a5d4705000000b0021f38908619mr7976536wrq.104.1660553661190;
        Mon, 15 Aug 2022 01:54:21 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00223b8168b15sm6655136wrf.66.2022.08.15.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:54:20 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:54:18 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V2 3/8] clk: imx: clk-composite-93: check slice busy
Message-ID: <YvoJuo5pJ0KFvFHK@linaro.org>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013039.474970-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:30:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 CCM ROOT STAT register has a SLICE_BUSY bit:
> indication for clock generation logic is applying new setting.
> 0b - Clock generation logic is not busy.
> 1b - Clock generation logic is applying new setting.
> 
> So when set parent/rate/gate, need check this bit.
> 
> Introduce specific ops to do the work.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-composite-93.c | 163 ++++++++++++++++++++++++++++-
>  1 file changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
> index b44619aa5ca5..19f4037e6cca 100644
> --- a/drivers/clk/imx/clk-composite-93.c
> +++ b/drivers/clk/imx/clk-composite-93.c
> @@ -9,20 +9,176 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/slab.h>
>  
>  #include "clk.h"
>  
> +#define TIMEOUT_US	500U
> +
>  #define CCM_DIV_SHIFT	0
>  #define CCM_DIV_WIDTH	8
>  #define CCM_MUX_SHIFT	8
>  #define CCM_MUX_MASK	3
>  #define CCM_OFF_SHIFT	24
> +#define CCM_BUSY_SHIFT	28
>  
> +#define STAT_OFFSET	0x4
>  #define AUTHEN_OFFSET	0x30
>  #define TZ_NS_SHIFT	9
>  #define TZ_NS_MASK	BIT(9)
>  
> +static int imx93_clk_composite_wait_ready(struct clk_hw *hw, void __iomem *reg)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = readl_poll_timeout_atomic(reg + STAT_OFFSET, val, !(val & BIT(CCM_BUSY_SHIFT)),
> +					0, TIMEOUT_US);
> +	if (ret)
> +		pr_err("Slice[%s] busy timeout\n", clk_hw_get_name(hw));
> +
> +	return ret;
> +}
> +
> +static void imx93_clk_composite_gate_endisable(struct clk_hw *hw, int enable)
> +{
> +	struct clk_gate *gate = to_clk_gate(hw);
> +	unsigned long flags;
> +	u32 reg;
> +
> +	if (gate->lock)
> +		spin_lock_irqsave(gate->lock, flags);
> +
> +	reg = readl(gate->reg);
> +
> +	if (enable)
> +		reg &= ~BIT(gate->bit_idx);
> +	else
> +		reg |= BIT(gate->bit_idx);
> +
> +	writel(reg, gate->reg);
> +
> +	imx93_clk_composite_wait_ready(hw, gate->reg);
> +
> +	if (gate->lock)
> +		spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static int imx93_clk_composite_gate_enable(struct clk_hw *hw)
> +{
> +	imx93_clk_composite_gate_endisable(hw, 1);
> +
> +	return 0;
> +}
> +
> +static void imx93_clk_composite_gate_disable(struct clk_hw *hw)
> +{
> +	imx93_clk_composite_gate_endisable(hw, 0);
> +}
> +
> +static const struct clk_ops imx93_clk_composite_gate_ops = {
> +	.enable = imx93_clk_composite_gate_enable,
> +	.disable = imx93_clk_composite_gate_disable,
> +	.is_enabled = clk_gate_is_enabled,
> +};
> +
> +static unsigned long
> +imx93_clk_composite_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	return clk_divider_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static long
> +imx93_clk_composite_divider_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
> +{
> +	return clk_divider_ops.round_rate(hw, rate, prate);
> +}
> +
> +static int
> +imx93_clk_composite_divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	return clk_divider_ops.determine_rate(hw, req);
> +}
> +
> +static int imx93_clk_composite_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> +						unsigned long parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	int value;
> +	unsigned long flags = 0;
> +	u32 val;
> +	int ret;
> +
> +	value = divider_get_val(rate, parent_rate, divider->table, divider->width, divider->flags);
> +	if (value < 0)
> +		return value;
> +
> +	if (divider->lock)
> +		spin_lock_irqsave(divider->lock, flags);
> +
> +	val = readl(divider->reg);
> +	val &= ~(clk_div_mask(divider->width) << divider->shift);
> +	val |= (u32)value << divider->shift;
> +	writel(val, divider->reg);
> +
> +	ret = imx93_clk_composite_wait_ready(hw, divider->reg);
> +
> +	if (divider->lock)
> +		spin_unlock_irqrestore(divider->lock, flags);
> +
> +	return ret;
> +}
> +
> +static const struct clk_ops imx93_clk_composite_divider_ops = {
> +	.recalc_rate = imx93_clk_composite_divider_recalc_rate,
> +	.round_rate = imx93_clk_composite_divider_round_rate,
> +	.determine_rate = imx93_clk_composite_divider_determine_rate,
> +	.set_rate = imx93_clk_composite_divider_set_rate,
> +};
> +
> +static u8 imx93_clk_composite_mux_get_parent(struct clk_hw *hw)
> +{
> +	return clk_mux_ops.get_parent(hw);
> +}
> +
> +static int imx93_clk_composite_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_mux *mux = to_clk_mux(hw);
> +	u32 val = clk_mux_index_to_val(mux->table, mux->flags, index);
> +	unsigned long flags = 0;
> +	u32 reg;
> +	int ret;
> +
> +	if (mux->lock)
> +		spin_lock_irqsave(mux->lock, flags);
> +
> +	reg = readl(mux->reg);
> +	reg &= ~(mux->mask << mux->shift);
> +	val = val << mux->shift;
> +	reg |= val;
> +	writel(reg, mux->reg);
> +
> +	ret = imx93_clk_composite_wait_ready(hw, mux->reg);
> +
> +	if (mux->lock)
> +		spin_unlock_irqrestore(mux->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int
> +imx93_clk_composite_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	return clk_mux_ops.determine_rate(hw, req);
> +}
> +
> +static const struct clk_ops imx93_clk_composite_mux_ops = {
> +	.get_parent = imx93_clk_composite_mux_get_parent,
> +	.set_parent = imx93_clk_composite_mux_set_parent,
> +	.determine_rate = imx93_clk_composite_mux_determine_rate,
> +};
> +
>  struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *parent_names,
>  					 int num_parents, void __iomem *reg,
>  					 unsigned long flags)
> @@ -74,9 +230,10 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
>  		gate->flags = CLK_GATE_SET_TO_DISABLE;
>  
>  		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> -					       mux_hw, &clk_mux_ops, div_hw,
> -					       &clk_divider_ops, gate_hw,
> -					       &clk_gate_ops, flags | CLK_SET_RATE_NO_REPARENT);
> +					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
> +					       &imx93_clk_composite_divider_ops, gate_hw,
> +					       &imx93_clk_composite_gate_ops,
> +					       flags | CLK_SET_RATE_NO_REPARENT);
>  	}
>  
>  	if (IS_ERR(hw))
> -- 
> 2.37.1
> 
