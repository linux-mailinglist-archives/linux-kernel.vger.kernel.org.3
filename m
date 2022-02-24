Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299484C3047
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiBXPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiBXPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:47:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250D3898;
        Thu, 24 Feb 2022 07:46:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so5203224ejb.13;
        Thu, 24 Feb 2022 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JJAiWLQrFXlDmx+UpBe5eJbjYz72DoByQx7Ceo4j2A4=;
        b=SaTR6FoBuBvy6D2p5HHYee3OH96dLehh1J6Bwh4h8nw++mTKIeeh0Aj94MnIkaXWKF
         SR/dgCByTyNBaLf6X+dIlwagUbx2K2SQEHJRHSa/Tfmaf0LYwnP+A3VqtG8WatqYrNWI
         OJ8wSak3UtKD1+rshHKHuXrTuBNY/oaBz/izRXf4gJqwrPwKjeuXKK3naWdAKemKMvKH
         14wLfV58VZkXHr5QYsH8T41ccYBJPzqDGq3ognFO2XFBRl+zzvpPIQX5bBthbs2zAB6I
         eSeuHlcF4jhdzxRFXt1O2PNK0uN2Bw6/ws0IIDWk4aOHOQ0dBlzpsnJUAGYNoQgt8Lh4
         l/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JJAiWLQrFXlDmx+UpBe5eJbjYz72DoByQx7Ceo4j2A4=;
        b=ANck5WUlXOgu7OiazN4C3NH4p0lGLDdfUt4e3LOX+QUaVw0OQuBQAuqkiBtgTtyy+T
         JNncNMQPrpJpccPl4gcDQ5dH43Yog/4ybwyc5GGajO2xDlE2esvv7vFvE4ob2Sx4tcHa
         ksZu3t9p5GPUXh08eMYC+LXvdBdIKDM+cFzjHHctFD65CKMFtEAmuGn0j8bTpBd9tieG
         ikiNol7zDs3h50Btd/TdfS8TbS/Fc7+ikBfcuFGCKB8axOOUMi7oaKSSjJZURwhlG+VR
         u0w1KELBlh0FyI9NLTKgRf+qOzBouLEyAdqSLdDkzU47zsrSH1uQwpFGokLb/sA49B0p
         I7Hw==
X-Gm-Message-State: AOAM530nsObv331hdW3wv9fWrMqbTFFgYfCfYLHg9O/RYk4rfKqbf2lF
        UHBEYuc5e5pSGS7Xq4LT278=
X-Google-Smtp-Source: ABdhPJy2gg0nx7iiQjO3slJra64rjnRcnjm1JUDitId9FBNdH8rHyJi91Q7/Ne8d7EItbgdVFdIjqg==
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id z21-20020a1709063a1500b006cfea4ea1ccmr2731516eje.753.1645717602905;
        Thu, 24 Feb 2022 07:46:42 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.gmail.com with ESMTPSA id j1sm1497332ejx.123.2022.02.24.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:46:42 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:45:55 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/16] clk: qcom: gcc-ipq806x: convert parent_names to
 parent_data
Message-ID: <Yhen5cLB32wGmhxu@Ansuel-xps.localdomain>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-6-ansuelsmth@gmail.com>
 <YhcAHQdtvSeROhT+@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhcAHQdtvSeROhT+@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:48:45PM -0600, Bjorn Andersson wrote:
> On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:
> 
> > Convert parent_names to parent_data to modernize the driver.
> > Where possible use parent_hws directly.
> > 
> 
> Really nice to see this kind of cleanup. Unfortunately I have two
> comments below.
> 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq806x.c | 286 ++++++++++++++++++++-------------
> >  1 file changed, 173 insertions(+), 113 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > index 34cddf461dba..828383c30322 100644
> > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > @@ -25,6 +25,10 @@
> >  #include "clk-hfpll.h"
> >  #include "reset.h"
> >  
> > +static const struct clk_parent_data gcc_pxo[] = {
> > +	{ .fw_name = "pxo" },
> 
> I expect that this will break booting these boards with existing dtb,
> because there's not yet a clocks <&pxo_board> in the gcc node.
>

Considering the lack of device using ipq806x in the kernel and the fact
that we add the clocks to the global dtsi should we care? The breakage
will be present on boards that use custom kernel anyway so in theory
shouldn't be that hard to refresh the dtsi.

> If you also add .name = "pxo" here that it should still fall back to map
> to the board clock registered in gcc_ipq806x_probe() and once we have
> passed 1-2 kernel releases we can clean out the old mapping.
> 

Just to make sure, you are suggesting to put 2 entry (fw_name AND name)
or replace the fw_name with the generic name variable? 

Anyway thanks for the review!

> > +};
> > +
> >  static struct clk_pll pll0 = {
> >  	.l_reg = 0x30c4,
> >  	.m_reg = 0x30c8,
> > @@ -35,7 +39,7 @@ static struct clk_pll pll0 = {
> >  	.status_bit = 16,
> >  	.clkr.hw.init = &(struct clk_init_data){
> >  		.name = "pll0",
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_ops,
> >  	},
> > @@ -46,7 +50,9 @@ static struct clk_regmap pll0_vote = {
> >  	.enable_mask = BIT(0),
> >  	.hw.init = &(struct clk_init_data){
> >  		.name = "pll0_vote",
> > -		.parent_names = (const char *[]){ "pll0" },
> > +		.parent_hws = (const struct clk_hw*[]){
> > +			&pll0.clkr.hw,
> > +		},
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_vote_ops,
> >  	},
> > @@ -62,7 +68,7 @@ static struct clk_pll pll3 = {
> >  	.status_bit = 16,
> >  	.clkr.hw.init = &(struct clk_init_data){
> >  		.name = "pll3",
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_ops,
> >  	},
> > @@ -89,7 +95,7 @@ static struct clk_pll pll8 = {
> >  	.status_bit = 16,
> >  	.clkr.hw.init = &(struct clk_init_data){
> >  		.name = "pll8",
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_ops,
> >  	},
> > @@ -100,7 +106,9 @@ static struct clk_regmap pll8_vote = {
> >  	.enable_mask = BIT(8),
> >  	.hw.init = &(struct clk_init_data){
> >  		.name = "pll8_vote",
> > -		.parent_names = (const char *[]){ "pll8" },
> > +		.parent_hws = (const struct clk_hw*[]){
> > +			&pll8.clkr.hw,
> > +		},
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_vote_ops,
> >  	},
> > @@ -123,7 +131,7 @@ static struct hfpll_data hfpll0_data = {
> >  static struct clk_hfpll hfpll0 = {
> >  	.d = &hfpll0_data,
> >  	.clkr.hw.init = &(struct clk_init_data){
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.name = "hfpll0",
> >  		.ops = &clk_ops_hfpll,
> > @@ -149,7 +157,7 @@ static struct hfpll_data hfpll1_data = {
> >  static struct clk_hfpll hfpll1 = {
> >  	.d = &hfpll1_data,
> >  	.clkr.hw.init = &(struct clk_init_data){
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.name = "hfpll1",
> >  		.ops = &clk_ops_hfpll,
> > @@ -175,7 +183,7 @@ static struct hfpll_data hfpll_l2_data = {
> >  static struct clk_hfpll hfpll_l2 = {
> >  	.d = &hfpll_l2_data,
> >  	.clkr.hw.init = &(struct clk_init_data){
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.name = "hfpll_l2",
> >  		.ops = &clk_ops_hfpll,
> > @@ -194,7 +202,7 @@ static struct clk_pll pll14 = {
> >  	.status_bit = 16,
> >  	.clkr.hw.init = &(struct clk_init_data){
> >  		.name = "pll14",
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_ops,
> >  	},
> > @@ -205,7 +213,9 @@ static struct clk_regmap pll14_vote = {
> >  	.enable_mask = BIT(14),
> >  	.hw.init = &(struct clk_init_data){
> >  		.name = "pll14_vote",
> > -		.parent_names = (const char *[]){ "pll14" },
> > +		.parent_hws = (const struct clk_hw*[]){
> > +			&pll14.clkr.hw,
> > +		},
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_vote_ops,
> >  	},
> > @@ -238,7 +248,7 @@ static struct clk_pll pll18 = {
> >  	.freq_tbl = pll18_freq_tbl,
> >  	.clkr.hw.init = &(struct clk_init_data){
> >  		.name = "pll18",
> > -		.parent_names = (const char *[]){ "pxo" },
> > +		.parent_data = gcc_pxo,
> >  		.num_parents = 1,
> >  		.ops = &clk_pll_ops,
> >  	},
> > @@ -259,9 +269,9 @@ static const struct parent_map gcc_pxo_pll8_map[] = {
> >  	{ P_PLL8, 3 }
> >  };
> >  
> > -static const char * const gcc_pxo_pll8[] = {
> > -	"pxo",
> > -	"pll8_vote",
> > +static const struct clk_parent_data gcc_pxo_pll8[] = {
> > +	{ .fw_name = "pxo" },
> > +	{ .hw = &pll8_vote.hw },
> >  };
> >  
> >  static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
> > @@ -270,10 +280,10 @@ static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
> >  	{ P_CXO, 5 }
> >  };
> >  
> > -static const char * const gcc_pxo_pll8_cxo[] = {
> > -	"pxo",
> > -	"pll8_vote",
> > -	"cxo",
> > +static const struct clk_parent_data gcc_pxo_pll8_cxo[] = {
> > +	{ .fw_name = "pxo" },
> > +	{ .hw = &pll8_vote.hw },
> > +	{ .fw_name = "cxo" },
> 
> As with "pxo", I think you need a .name = "cxo" here as well.
> 
> Regards,
> Bjorn

-- 
	Ansuel
