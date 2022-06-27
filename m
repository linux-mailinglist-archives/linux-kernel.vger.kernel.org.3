Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24755CBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiF0NdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiF0Ncn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:32:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F8965EE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:32:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q6so19126597eji.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MOugzhFcAjO+If2z96kba/vfySD/CKxYnEQLAZDDWG8=;
        b=JlVP/Q8P2kDZ2Dj0GBc8YWFiJhJ0FEL+gAbkHJ84/Dtqa4qijiBspjfVN99losd6cS
         4rsKyepUjljwHPnqK4l87Uog2dVeNnZ9Bogixfx5qIcVPF02HEMhYKX7YSBEfakvbgLN
         1WuGPD0nYZ+AmSrgdBOanAFfloIltbml0IlF3hIrZUbLsZO+TaXEtZrSZakY8qzDGxxL
         1Mb/RI6ncBhq8FkFHDYMy24uQcv0kNU/cxD8Vq7LD6v0alfCxSFjYU/4N1pIRpIo936H
         H/jAwZa8tk/UMh0J/CZuociC/C2+5woT8bt4KE/h6xEH85IuNRjok8mZxHqA5iEPwmeA
         mg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MOugzhFcAjO+If2z96kba/vfySD/CKxYnEQLAZDDWG8=;
        b=MfQqHHlImz50kF2bW8JNx0VZMl4F3vsenZYNDRw5CHxOkyJ19QL4o0X29XoHW7X4N7
         LIj+sS6qGMAQe0Hpcqm4fXHYmk9z6bUTpCQdZT6O1j5hUWHjj42gvkqiOXQZY6VS6G/z
         l29LR06evRNH31OmCHLqMY/RACZHabcNjjouyUtDhCy1OaSqezTVLoOCs4POeGHKeIFH
         32KVo3BE+wyHxkwijH69QlBdbAvXbdNzG9mDERSwkOOJ+Yr2gYIG8EUevO5Sg5BcxDkO
         h57c2GcdAJROb3G3fYlienaTGiLTsxQttgIUR+g9xIknouN4YkyM7cI3Hff2Md5Pg0l0
         U+Uw==
X-Gm-Message-State: AJIora+ZVn+oR1ZcOp0WaAvijtYVP+RwUJFYBFZorRR62MghYCJwXEyw
        ZfW6LLvJhacCncpGyA7ycGghHg==
X-Google-Smtp-Source: AGRyM1u3dZOndJbMOz1PnEKgh/KohhYGA8SFXR6A6ZFn1gSCIFjMIKmB5NvYcDU9vjOqSiLDYTVQYw==
X-Received: by 2002:a17:907:97c9:b0:726:b4f8:f675 with SMTP id js9-20020a17090797c900b00726b4f8f675mr2718638ejc.427.1656336760410;
        Mon, 27 Jun 2022 06:32:40 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d25-20020a50fe99000000b004355998ec1asm7523587edt.14.2022.06.27.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:32:39 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:32:37 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, olof@lixom.net,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 08/13] clk: imx: Update pllv3 to support i.MXRT1170
Message-ID: <YrmxdaSqHnEg28uG@linaro.org>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
 <20220626064523.3683775-9-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626064523.3683775-9-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-26 02:45:18, Jesse Taube wrote:
> The i.MXRT1170 has a pll that has the multiplier bits inverted and
> cannot be changed add IMX_PLLV3_GENERICV2.
>
> The i.MXRT1170 also has the lock bit moved as well as the
> power bit inverted the power bit also is in different locations on each
> pll control register.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Nothing done
> V2 -> V3:
>  - Nothing done
> V3 -> V4:
>  - Nothing done
> ---
>  drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++++--
>  drivers/clk/imx/clk.h       |  4 +++
>  2 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index eea32f87c60a..740412ea2f7e 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -23,6 +23,7 @@
>
>  #define BM_PLL_POWER		(0x1 << 12)
>  #define BM_PLL_LOCK		(0x1 << 31)
> +#define BM_PLL_LOCK_V2		(0x1 << 29)
>  #define IMX7_ENET_PLL_POWER	(0x1 << 5)
>  #define IMX7_DDR_PLL_POWER	(0x1 << 20)
>
> @@ -34,6 +35,7 @@
>   * @base:	 base address of PLL registers
>   * @power_bit:	 pll power bit mask
>   * @powerup_set: set power_bit to power up the PLL
> + * @lock_bit:	 pll lock bit mask
>   * @div_mask:	 mask of divider bits
>   * @div_shift:	 shift of divider bits
>   * @ref_clock:	reference clock rate
> @@ -48,6 +50,7 @@ struct clk_pllv3 {
>  	void __iomem	*base;
>  	u32		power_bit;
>  	bool		powerup_set;
> +	u32		lock_bit;
>  	u32		div_mask;
>  	u32		div_shift;
>  	unsigned long	ref_clock;
> @@ -65,7 +68,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
>  		return 0;
>
> -	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
> +	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
>  					  500, PLL_LOCK_TIMEOUT);
>  }
>
> @@ -101,7 +104,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
>  {
>  	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>
> -	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> +	if (readl_relaxed(pll->base) & pll->lock_bit)
>  		return 1;
>
>  	return 0;
> @@ -155,6 +158,39 @@ static const struct clk_ops clk_pllv3_ops = {
>  	.set_rate	= clk_pllv3_set_rate,
>  };
>
> +static int clk_pllv3_genericv2_set_rate(struct clk_hw *hw, unsigned long rate,
> +		unsigned long parent_rate)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +	u32 val, div;
> +
> +	div = (readl_relaxed(pll->base) >> pll->div_shift) & pll->div_mask;
> +	val = (div == 0) ? parent_rate * 22 : parent_rate * 20;
> +
> +	if (rate == val)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static unsigned long clk_pllv3_genericv2_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +	u32 div = (readl_relaxed(pll->base) >> pll->div_shift)  & pll->div_mask;
> +
> +	return (div == 0) ? parent_rate * 22 : parent_rate * 20;
> +}
> +
> +static const struct clk_ops clk_pllv3_genericv2_ops = {
> +	.prepare	= clk_pllv3_prepare,
> +	.unprepare	= clk_pllv3_unprepare,
> +	.is_prepared	= clk_pllv3_is_prepared,
> +	.recalc_rate	= clk_pllv3_genericv2_recalc_rate,
> +	.round_rate	= clk_pllv3_round_rate,
> +	.set_rate	= clk_pllv3_genericv2_set_rate,
> +};
> +
>  static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
>  					       unsigned long parent_rate)
>  {
> @@ -407,6 +443,13 @@ static const struct clk_ops clk_pllv3_enet_ops = {
>  	.recalc_rate	= clk_pllv3_enet_recalc_rate,
>  };
>
> +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +
> +	pll->power_bit = shift;
> +}
> +

I can see why you need this, but I think the approach is not quite
right.

I suggest we rename the imx_clk_hw_pllv3 to __imx_clk_hw_pllv3 and add
the power_bit parameter to it (and set it accordingly inside).

Then we should do the following in imx/clk.h:

#define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,	\
				bypass1, bypass2, base, flags)		\
	__imx_clk_hw_pllv3(name, parent_names, num_parents, parent,	\
				bypass1, bypass2, base, flags, BM_PLL_POWER)

And then, the i.MXRT1170 can use the __imx_clk_hw_pllv3 and pass the
right power_bit shift.

>  struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  			  const char *parent_name, void __iomem *base,
>  			  u32 div_mask)
> @@ -422,10 +465,20 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  		return ERR_PTR(-ENOMEM);
>
>  	pll->power_bit = BM_PLL_POWER;
> +	pll->lock_bit = BM_PLL_LOCK;
>  	pll->num_offset = PLL_NUM_OFFSET;
>  	pll->denom_offset = PLL_DENOM_OFFSET;
>
>  	switch (type) {
> +	case IMX_PLLV3_GENERICV2:
> +		pll->lock_bit = BM_PLL_LOCK_V2;
> +		pll->powerup_set = true;
> +		ops = &clk_pllv3_genericv2_ops;
> +		break;
> +	case IMX_PLLV3_SYSV2:
> +		pll->lock_bit = BM_PLL_LOCK_V2;
> +		pll->powerup_set = true;
> +		fallthrough;
>  	case IMX_PLLV3_SYS:
>  		ops = &clk_pllv3_sys_ops;
>  		break;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 5061a06468df..31e017248602 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -242,6 +242,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
>
>  enum imx_pllv3_type {
>  	IMX_PLLV3_GENERIC,
> +	IMX_PLLV3_GENERICV2,
> +	IMX_PLLV3_SYSV2,
>  	IMX_PLLV3_SYS,
>  	IMX_PLLV3_USB,
>  	IMX_PLLV3_USB_VF610,
> @@ -253,6 +255,8 @@ enum imx_pllv3_type {
>  	IMX_PLLV3_AV_IMX7,
>  };
>
> +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift);
> +
>  struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  		const char *parent_name, void __iomem *base, u32 div_mask);
>
> --
> 2.36.1
>
