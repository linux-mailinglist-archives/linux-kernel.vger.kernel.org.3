Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9D55C73B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbiF1Hkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbiF1Hko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:40:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F92CE15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:40:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fi2so23895574ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v4aAjKeEqKxV1NZCwNURdwE5iyyJ3850e9bBA4IL6TE=;
        b=fZUVuR8MAnFt80lyGhLyLIoKAZ8EbaWnwlr6Dhqgnaz4qf8HDNGHcRaKlb+ffefFJF
         +cK56e2+AQUxXYRmZkJPs9Gqn4upLMX4hOm36+ieqy54hngUL7kVsqXI62DzUFXdXpTu
         bFIwTrnhyv1W1PB9ROoaFlzYiPc33SZesTzb87wFbCI41WzQZW124LjmMA+ilICi8hZ5
         W1VgALipzx2vfLrhDkgYkIxOAsWCOu7Ki3ZCe44lF8apBfbyuJDn2mIyZxXW9XiQgrkO
         3mxbj2T9gyOiNJeiKNwA5txvaY24VIS8tesvFf/gvUHlwo+G8y1RmTyqceXXzcOQcaIa
         aEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4aAjKeEqKxV1NZCwNURdwE5iyyJ3850e9bBA4IL6TE=;
        b=seXEjt72Xen+lnqhTyTZf43rNbcSXv6AGx4xktCMZWsWsMyManr2NC6AVFwf/sedDT
         ToB8QeeNFOwKuXvSwJbqOhbTxRyYxmeFcRMMjx5fFlg0znyW0OYh7mdXb4cHGLFO0LGm
         K9fF95xI7YOu9bGczmJqAelPa7P7naDXKE/byMlTVDcb8kbF3bm9HkEbfztzVU76FTPo
         qjVDARvs4yZBXhKNy631ln9gqv9pMtFR8q1HXB9ksCNSR49uymmON1tSZrukWlJ90/rl
         PZYnV/8gkn+/r7jZRolyrh5fPTIlsVzY24jOUV+V9JXrRSsTgxW0CFqthspezfRhsUpb
         IwvA==
X-Gm-Message-State: AJIora9Km6sGScHgAYpOTU/jKroHPZZime9IjX1yiJo6jjZ+xKG0zdRU
        SHTWp0NAfXr1vnhpMCkQjRWMHw==
X-Google-Smtp-Source: AGRyM1sJNF5OFItLhacBVarsuGoAnjScolptSzxQIcldwkpTgGDiPvm/BOZVSzA2WJLkg3Pl6IF0Cw==
X-Received: by 2002:a17:906:7394:b0:722:e9c5:8e82 with SMTP id f20-20020a170906739400b00722e9c58e82mr16543887ejl.239.1656402039481;
        Tue, 28 Jun 2022 00:40:39 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm9069835edb.29.2022.06.28.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:40:38 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:40:36 +0300
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
Message-ID: <YrqwdCsLgxJYPfOw@linaro.org>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
 <20220626064523.3683775-9-Mr.Bossman075@gmail.com>
 <YrmxdaSqHnEg28uG@linaro.org>
 <c8f13238-c927-4aab-e54d-3a1a5c031877@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f13238-c927-4aab-e54d-3a1a5c031877@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-27 12:11:31, Jesse Taube wrote:
>
>
> On 6/27/22 09:32, Abel Vesa wrote:
> > On 22-06-26 02:45:18, Jesse Taube wrote:
> > > The i.MXRT1170 has a pll that has the multiplier bits inverted and
> > > cannot be changed add IMX_PLLV3_GENERICV2.
> > >
> > > The i.MXRT1170 also has the lock bit moved as well as the
> > > power bit inverted the power bit also is in different locations on each
> > > pll control register.
> > >
> > > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > > ---
> > > V1 -> V2:
> > >   - Nothing done
> > > V2 -> V3:
> > >   - Nothing done
> > > V3 -> V4:
> > >   - Nothing done
> > > ---
> > >   drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++++--
> > >   drivers/clk/imx/clk.h       |  4 +++
> > >   2 files changed, 59 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> > > index eea32f87c60a..740412ea2f7e 100644
> > > --- a/drivers/clk/imx/clk-pllv3.c
> > > +++ b/drivers/clk/imx/clk-pllv3.c
> > > @@ -23,6 +23,7 @@
> > >
> > >   #define BM_PLL_POWER		(0x1 << 12)
> > >   #define BM_PLL_LOCK		(0x1 << 31)
> > > +#define BM_PLL_LOCK_V2		(0x1 << 29)
> > >   #define IMX7_ENET_PLL_POWER	(0x1 << 5)
> > >   #define IMX7_DDR_PLL_POWER	(0x1 << 20)
> > >
> > > @@ -34,6 +35,7 @@
> > >    * @base:	 base address of PLL registers
> > >    * @power_bit:	 pll power bit mask
> > >    * @powerup_set: set power_bit to power up the PLL
> > > + * @lock_bit:	 pll lock bit mask
> > >    * @div_mask:	 mask of divider bits
> > >    * @div_shift:	 shift of divider bits
> > >    * @ref_clock:	reference clock rate
> > > @@ -48,6 +50,7 @@ struct clk_pllv3 {
> > >   	void __iomem	*base;
> > >   	u32		power_bit;
> > >   	bool		powerup_set;
> > > +	u32		lock_bit;
> > >   	u32		div_mask;
> > >   	u32		div_shift;
> > >   	unsigned long	ref_clock;
> > > @@ -65,7 +68,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
> > >   	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
> > >   		return 0;
> > >
> > > -	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
> > > +	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
> > >   					  500, PLL_LOCK_TIMEOUT);
> > >   }
> > >
> > > @@ -101,7 +104,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
> > >   {
> > >   	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> > >
> > > -	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> > > +	if (readl_relaxed(pll->base) & pll->lock_bit)
> > >   		return 1;
> > >
> > >   	return 0;
> > > @@ -155,6 +158,39 @@ static const struct clk_ops clk_pllv3_ops = {
> > >   	.set_rate	= clk_pllv3_set_rate,
> > >   };
> > >
> > > +static int clk_pllv3_genericv2_set_rate(struct clk_hw *hw, unsigned long rate,
> > > +		unsigned long parent_rate)
> > > +{
> > > +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> > > +	u32 val, div;
> > > +
> > > +	div = (readl_relaxed(pll->base) >> pll->div_shift) & pll->div_mask;
> > > +	val = (div == 0) ? parent_rate * 22 : parent_rate * 20;
> > > +
> > > +	if (rate == val)
> > > +		return 0;
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static unsigned long clk_pllv3_genericv2_recalc_rate(struct clk_hw *hw,
> > > +					   unsigned long parent_rate)
> > > +{
> > > +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> > > +	u32 div = (readl_relaxed(pll->base) >> pll->div_shift)  & pll->div_mask;
> > > +
> > > +	return (div == 0) ? parent_rate * 22 : parent_rate * 20;
> > > +}
> > > +
> > > +static const struct clk_ops clk_pllv3_genericv2_ops = {
> > > +	.prepare	= clk_pllv3_prepare,
> > > +	.unprepare	= clk_pllv3_unprepare,
> > > +	.is_prepared	= clk_pllv3_is_prepared,
> > > +	.recalc_rate	= clk_pllv3_genericv2_recalc_rate,
> > > +	.round_rate	= clk_pllv3_round_rate,
> > > +	.set_rate	= clk_pllv3_genericv2_set_rate,
> > > +};
> > > +
> > >   static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
> > >   					       unsigned long parent_rate)
> > >   {
> > > @@ -407,6 +443,13 @@ static const struct clk_ops clk_pllv3_enet_ops = {
> > >   	.recalc_rate	= clk_pllv3_enet_recalc_rate,
> > >   };
> > >
> > > +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift)
> > > +{
> > > +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> > > +
> > > +	pll->power_bit = shift;
> > > +}
> > > +
> >
> > I can see why you need this, but I think the approach is not quite
> > right.
>
> I wasn't sure if modifying the function like that was appropriate for this,
> but sense it is I will do like you said.
>
> > I suggest we rename the imx_clk_hw_pllv3 to __imx_clk_hw_pllv3 and add
> > the power_bit parameter to it (and set it accordingly inside).
> >
> > Then we should do the following in imx/clk.h:
> >
> > #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,	\
> > 				bypass1, bypass2, base, flags)		\
> > 	__imx_clk_hw_pllv3(name, parent_names, num_parents, parent,	\
> > 				bypass1, bypass2, base, flags, BM_PLL_POWER)
>
> One problem BM_PLL_POWER will have to be in imx/clk.h, but then it will be
> the only macro like it in the file, is line 9 ok for it.
> I could also make a function instead of a macro.
>

Line 9 is OK. #define will do.

There are macros like that for the composite clocks too.

> thanks,
> Jesse Taube
> > And then, the i.MXRT1170 can use the __imx_clk_hw_pllv3 and pass the
> > right power_bit shift.
> >
> > >   struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
> > >   			  const char *parent_name, void __iomem *base,
> > >   			  u32 div_mask)
> > > @@ -422,10 +465,20 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
> > >   		return ERR_PTR(-ENOMEM);
> > >
> > >   	pll->power_bit = BM_PLL_POWER;
> > > +	pll->lock_bit = BM_PLL_LOCK;
> > >   	pll->num_offset = PLL_NUM_OFFSET;
> > >   	pll->denom_offset = PLL_DENOM_OFFSET;
> > >
> > >   	switch (type) {
> > > +	case IMX_PLLV3_GENERICV2:
> > > +		pll->lock_bit = BM_PLL_LOCK_V2;
> > > +		pll->powerup_set = true;
> > > +		ops = &clk_pllv3_genericv2_ops;
> > > +		break;
> > > +	case IMX_PLLV3_SYSV2:
> > > +		pll->lock_bit = BM_PLL_LOCK_V2;
> > > +		pll->powerup_set = true;
> > > +		fallthrough;
> > >   	case IMX_PLLV3_SYS:
> > >   		ops = &clk_pllv3_sys_ops;
> > >   		break;
> > > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> > > index 5061a06468df..31e017248602 100644
> > > --- a/drivers/clk/imx/clk.h
> > > +++ b/drivers/clk/imx/clk.h
> > > @@ -242,6 +242,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
> > >
> > >   enum imx_pllv3_type {
> > >   	IMX_PLLV3_GENERIC,
> > > +	IMX_PLLV3_GENERICV2,
> > > +	IMX_PLLV3_SYSV2,
> > >   	IMX_PLLV3_SYS,
> > >   	IMX_PLLV3_USB,
> > >   	IMX_PLLV3_USB_VF610,
> > > @@ -253,6 +255,8 @@ enum imx_pllv3_type {
> > >   	IMX_PLLV3_AV_IMX7,
> > >   };
> > >
> > > +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift);
> > > +
> > >   struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
> > >   		const char *parent_name, void __iomem *base, u32 div_mask);
> > >
> > > --
> > > 2.36.1
> > >
