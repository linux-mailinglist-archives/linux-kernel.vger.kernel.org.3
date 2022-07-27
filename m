Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89220582A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiG0QLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiG0QLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:11:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F64B0DB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:11:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bn9so14271620wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqYi5X2yo783BFRgi9t3Lq2OB3oZyehlF1akigEWMFM=;
        b=JeyV8Jeqx+OjY0t5dp8PITysUxIUwFbkS03W3FO1Ihy2bRjEPOnJy2aEgRWPWNcDKY
         R9hFyqswJa8s5bD9Um4FPjuFamCi8DkFn47dgN/IDR8bWe1JIg8c4AZYOsJ4JMamv/uY
         WKXP2ZlwHiCs57UJmQdT121crS081lNumEA0yzJ4f66ZhGGi3HHpGzUQE1nO6aSkEO7Q
         YCYNrYVFs5ykFagQUVNItXt3TMnQ+ic34iCZ7jbkGOXrfYY2UculBX7kbKUAbEeMGyTv
         gPR4Yxlf2AwdwsC9Q3C9GUj+Ic9DFZ+sjlO7IyiyN5TZD/RfOwG8bQ4Io+MSNMBqhdV4
         e5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqYi5X2yo783BFRgi9t3Lq2OB3oZyehlF1akigEWMFM=;
        b=CoiXGjoZPpnvkBP91qgYVhc7bD6JmDRwFd2hObiu9Ky6O9QiYBosvX9QtmnkFn6+Zj
         mX9/03wEowZFj7AYUQMDaPZpZp7qLz5DZ+IzI4HuvBPrFaDx69qMaPr6MIfW2ruTTtLx
         QNCre6iZuKkqGmw4EsMS4oKdCzWNjNWClCbDhHc2q6X7tuFq7kPKtma74wuUuymlPrnx
         f4dHMPNHzYA/IMDQt4Ah5a+OZnkHWBH1+Nd9n2lQuRsuKLxluC2KUJBY2jVcPAM3SFuN
         URp1SotyLdNXyyCo2ayXWIDN0nwsgQWPQQLO8+GVLMV/lLWITzugcTyh9eAZDF0SeRsL
         Q1bg==
X-Gm-Message-State: AJIora/pWwqfj9u9f7Qg0V0sPPAZ0tP4Ns2PqQXMMjJgPFsLSx8VQ/zh
        4zFASeJN11EWhws2kYq1Aq/TSA==
X-Google-Smtp-Source: AGRyM1tpiUyBuIj5H0IMjzf/5LtCK37SykOA7EQ1w1RDklep062eb/PoNqI0+AE1QMHjtk4P4raQAA==
X-Received: by 2002:a5d:5984:0:b0:21e:6350:1477 with SMTP id n4-20020a5d5984000000b0021e63501477mr14028638wri.587.1658938287991;
        Wed, 27 Jul 2022 09:11:27 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j2-20020a05600c1c0200b003a30c3d0c9csm3063563wms.8.2022.07.27.09.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:11:26 -0700 (PDT)
Date:   Wed, 27 Jul 2022 19:11:23 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 07/12] clk: imx: Update pllv3 to support i.MXRT1170
Message-ID: <20220727161123.nxmtv4t5oeetow32@linaro.org>
References: <202207270909.VypZ4wfI-lkp@intel.com>
 <20220727031541.227335-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727031541.227335-1-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-26 23:15:41, Jesse Taube wrote:
> The i.MXRT1170 has a pll that has the multiplier bits inverted and
> cannot be changed add IMX_PLLV3_GENERICV2.
>
> The i.MXRT1170 also has the lock bit moved as well as the
> power bit inverted the power bit also is in different locations on each
> pll control register.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Please do not send the new version as a reply to the old patch.

> ---
> V1 -> V2:
>  - Nothing done
> V2 -> V3:
>  - Nothing done
> V3 -> V4:
>  - Nothing done
> V4 -> V5:
>  - Add __imx_clk_hw_pllv3 to change power bit
>  - Add BM_PLL_POWER and imx_clk_hw_pllv3 to header
>  - Remove imx_clk_hw_pll3_powerbit
> ---
>  drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++----
>  drivers/clk/imx/clk.h       | 11 +++++--
>  2 files changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index eea32f87c60a..68b1498cafe1 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -21,8 +21,8 @@
>  #define PLL_VF610_NUM_OFFSET	0x20
>  #define PLL_VF610_DENOM_OFFSET	0x30
>
> -#define BM_PLL_POWER		(0x1 << 12)
>  #define BM_PLL_LOCK		(0x1 << 31)
> +#define BM_PLL_LOCK_V2		(0x1 << 29)
>  #define IMX7_ENET_PLL_POWER	(0x1 << 5)
>  #define IMX7_DDR_PLL_POWER	(0x1 << 20)
>
> @@ -34,6 +34,7 @@
>   * @base:	 base address of PLL registers
>   * @power_bit:	 pll power bit mask
>   * @powerup_set: set power_bit to power up the PLL
> + * @lock_bit:	 pll lock bit mask
>   * @div_mask:	 mask of divider bits
>   * @div_shift:	 shift of divider bits
>   * @ref_clock:	reference clock rate
> @@ -48,6 +49,7 @@ struct clk_pllv3 {
>  	void __iomem	*base;
>  	u32		power_bit;
>  	bool		powerup_set;
> +	u32		lock_bit;
>  	u32		div_mask;
>  	u32		div_shift;
>  	unsigned long	ref_clock;
> @@ -65,7 +67,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
>  		return 0;
>
> -	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
> +	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
>  					  500, PLL_LOCK_TIMEOUT);
>  }
>
> @@ -101,7 +103,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
>  {
>  	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>
> -	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> +	if (readl_relaxed(pll->base) & pll->lock_bit)
>  		return 1;
>
>  	return 0;
> @@ -155,6 +157,39 @@ static const struct clk_ops clk_pllv3_ops = {
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
> @@ -407,9 +442,9 @@ static const struct clk_ops clk_pllv3_enet_ops = {
>  	.recalc_rate	= clk_pllv3_enet_recalc_rate,
>  };
>
> -struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
> +struct clk_hw *__imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  			  const char *parent_name, void __iomem *base,
> -			  u32 div_mask)
> +			  u32 div_mask, u8 pwr_bit)
>  {
>  	struct clk_pllv3 *pll;
>  	const struct clk_ops *ops;
> @@ -421,11 +456,21 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  	if (!pll)
>  		return ERR_PTR(-ENOMEM);
>
> -	pll->power_bit = BM_PLL_POWER;
> +	pll->power_bit = pwr_bit;
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
> index 5061a06468df..2bf50c92fdfa 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -6,6 +6,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/clk-provider.h>
>
> +#define BM_PLL_POWER		BIT(12)
> +
>  extern spinlock_t imx_ccm_lock;
>  extern bool mcore_booted;
>
> @@ -102,6 +104,9 @@ extern struct imx_fracn_gppll_clk imx_fracn_gppll;
>  	to_clk(clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
>  				cgr_val, cgr_mask, clk_gate_flags, lock, share_count))
>
> +#define imx_clk_hw_pllv3(type, name, parent_name, base, div_mask) \
> +	__imx_clk_hw_pllv3(type, name, parent_name, base, div_mask, 1)
> +
>  #define imx_clk_pllv3(type, name, parent_name, base, div_mask) \
>  	to_clk(imx_clk_hw_pllv3(type, name, parent_name, base, div_mask))
>
> @@ -242,6 +247,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
>
>  enum imx_pllv3_type {
>  	IMX_PLLV3_GENERIC,
> +	IMX_PLLV3_GENERICV2,
> +	IMX_PLLV3_SYSV2,
>  	IMX_PLLV3_SYS,
>  	IMX_PLLV3_USB,
>  	IMX_PLLV3_USB_VF610,
> @@ -253,8 +260,8 @@ enum imx_pllv3_type {
>  	IMX_PLLV3_AV_IMX7,
>  };
>
> -struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
> -		const char *parent_name, void __iomem *base, u32 div_mask);
> +struct clk_hw *__imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
> +		const char *parent_name, void __iomem *base, u32 div_mask, u8 pwr_bit);
>
>  #define PLL_1416X_RATE(_rate, _m, _p, _s)		\
>  	{						\
> --
> 2.36.1
>
