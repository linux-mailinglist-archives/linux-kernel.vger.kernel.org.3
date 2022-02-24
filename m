Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76924C30FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiBXQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBXQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:09:17 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177D180D3F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:08:33 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso1581155oti.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JxRxbTHGWpM6LinUy2bx0RAfmxNnmv6jDVYuPv13Y+o=;
        b=TRzb7c0853MCln/5rUw7eWHXFWjqRLB76I/d2vospZtWGTEtK0SrGv0VIO+RgFw2p9
         /if2veVvLENpTgXEkAl/rYa6cOvAV816g6f576FUBhtj5Cx0Yxzkk14vgrxbBDh1Riud
         hJqQemJParbNuTYW/qgoN0ydKS82DxYqoWHZNN1sOOG+S1je4swCNCtWOB+vsb+M1rRX
         XgGsMamwPvifUO94cxs8uiEWXulBLATjXkb6COoZcXmvemBk0CnzyP/ej3+U8dbWkCyz
         QNxfI+SRN4Hjf8J4HqbWdmJ8Oz67v2+nt06XvgUeKByENdcudjuyNY2p0p4FfYKAvgDt
         T5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JxRxbTHGWpM6LinUy2bx0RAfmxNnmv6jDVYuPv13Y+o=;
        b=cIMtDOFIhSg2+ScuKXgSEy3xZwG4OYbmKCcLf9/IitHPLenoI0knLiEmiDzpv8c6TE
         NgdJDoNouFIL00bNbPvxl7+OuHurEZcbNOn8pwVgKdSt26xO5f39CEdYHrsWA12kt78B
         Cv8vVOLeNgbg9ZN6SqgI8YA5wdBqPVcbIfKYzWc5irbIpn3aiG/Q1pdAXp20ONXJYpMa
         yZlsxzQ83g0UxYu2Cc+GRuXJmSV3uSyi6fJJW58cIdtPGmyXS/ob3r0UM9Low4TDjwMS
         h/gbxiacy16D6e/aeu7svrV1uQTyMc2RBIomLzjkzThZJJ9PL0AVDT9+OHjO4C441tS0
         Vx4g==
X-Gm-Message-State: AOAM533WR1IPh0lcI6o/qr1iq+0sz3Vp/yKOCH08Va0S0l6zUQOtJ/JM
        4qGnF8XmUhFfbMbIrot5o9PlyQ==
X-Google-Smtp-Source: ABdhPJzDGApI0w+pifxCK8TLr/4Zs4P8LMKK2l+r4mEIpT7ZbRIx3k2WSHh9sW473rdKuSwPChmMRg==
X-Received: by 2002:a4a:2714:0:b0:31b:ffc2:cc53 with SMTP id l20-20020a4a2714000000b0031bffc2cc53mr1135382oof.13.1645718805575;
        Thu, 24 Feb 2022 08:06:45 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s9sm1212573ooq.28.2022.02.24.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:06:44 -0800 (PST)
Date:   Thu, 24 Feb 2022 08:08:43 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
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
Message-ID: <YhetizewLY5SqcJl@ripper>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-6-ansuelsmth@gmail.com>
 <YhcAHQdtvSeROhT+@builder.lan>
 <Yhen5cLB32wGmhxu@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhen5cLB32wGmhxu@Ansuel-xps.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Feb 07:45 PST 2022, Ansuel Smith wrote:

> On Wed, Feb 23, 2022 at 09:48:45PM -0600, Bjorn Andersson wrote:
> > On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:
> > 
> > > Convert parent_names to parent_data to modernize the driver.
> > > Where possible use parent_hws directly.
> > > 
> > 
> > Really nice to see this kind of cleanup. Unfortunately I have two
> > comments below.
> > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/clk/qcom/gcc-ipq806x.c | 286 ++++++++++++++++++++-------------
> > >  1 file changed, 173 insertions(+), 113 deletions(-)
> > > 
> > > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > > index 34cddf461dba..828383c30322 100644
> > > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > > @@ -25,6 +25,10 @@
> > >  #include "clk-hfpll.h"
> > >  #include "reset.h"
> > >  
> > > +static const struct clk_parent_data gcc_pxo[] = {
> > > +	{ .fw_name = "pxo" },
> > 
> > I expect that this will break booting these boards with existing dtb,
> > because there's not yet a clocks <&pxo_board> in the gcc node.
> >
> 
> Considering the lack of device using ipq806x in the kernel and the fact
> that we add the clocks to the global dtsi should we care? The breakage
> will be present on boards that use custom kernel anyway so in theory
> shouldn't be that hard to refresh the dtsi.
> 
> > If you also add .name = "pxo" here that it should still fall back to map
> > to the board clock registered in gcc_ipq806x_probe() and once we have
> > passed 1-2 kernel releases we can clean out the old mapping.
> > 
> 
> Just to make sure, you are suggesting to put 2 entry (fw_name AND name)
> or replace the fw_name with the generic name variable? 
> 

What you have (.fw_name = "pxo") is perfect looking forward, but if
nothing else the clock and dts drivers are merged through different
paths up to Torvalds so merging the set as is in a single go might
actually break things for a while, even for you.

So if we go { .fw_name = "pxo", .name = "pxo" } we should handle both
the new and old dts. And I'm fine with saying that as soon as we see the
dts change landed in a release we drop the .name - if there aren't users
mixing and matching kernel and dtbs.

> Anyway thanks for the review!
> 

Thank you for the nice work!

Regards,
Bjorn

> > > +};
> > > +
> > >  static struct clk_pll pll0 = {
> > >  	.l_reg = 0x30c4,
> > >  	.m_reg = 0x30c8,
> > > @@ -35,7 +39,7 @@ static struct clk_pll pll0 = {
> > >  	.status_bit = 16,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > >  		.name = "pll0",
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_ops,
> > >  	},
> > > @@ -46,7 +50,9 @@ static struct clk_regmap pll0_vote = {
> > >  	.enable_mask = BIT(0),
> > >  	.hw.init = &(struct clk_init_data){
> > >  		.name = "pll0_vote",
> > > -		.parent_names = (const char *[]){ "pll0" },
> > > +		.parent_hws = (const struct clk_hw*[]){
> > > +			&pll0.clkr.hw,
> > > +		},
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_vote_ops,
> > >  	},
> > > @@ -62,7 +68,7 @@ static struct clk_pll pll3 = {
> > >  	.status_bit = 16,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > >  		.name = "pll3",
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_ops,
> > >  	},
> > > @@ -89,7 +95,7 @@ static struct clk_pll pll8 = {
> > >  	.status_bit = 16,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > >  		.name = "pll8",
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_ops,
> > >  	},
> > > @@ -100,7 +106,9 @@ static struct clk_regmap pll8_vote = {
> > >  	.enable_mask = BIT(8),
> > >  	.hw.init = &(struct clk_init_data){
> > >  		.name = "pll8_vote",
> > > -		.parent_names = (const char *[]){ "pll8" },
> > > +		.parent_hws = (const struct clk_hw*[]){
> > > +			&pll8.clkr.hw,
> > > +		},
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_vote_ops,
> > >  	},
> > > @@ -123,7 +131,7 @@ static struct hfpll_data hfpll0_data = {
> > >  static struct clk_hfpll hfpll0 = {
> > >  	.d = &hfpll0_data,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.name = "hfpll0",
> > >  		.ops = &clk_ops_hfpll,
> > > @@ -149,7 +157,7 @@ static struct hfpll_data hfpll1_data = {
> > >  static struct clk_hfpll hfpll1 = {
> > >  	.d = &hfpll1_data,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.name = "hfpll1",
> > >  		.ops = &clk_ops_hfpll,
> > > @@ -175,7 +183,7 @@ static struct hfpll_data hfpll_l2_data = {
> > >  static struct clk_hfpll hfpll_l2 = {
> > >  	.d = &hfpll_l2_data,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.name = "hfpll_l2",
> > >  		.ops = &clk_ops_hfpll,
> > > @@ -194,7 +202,7 @@ static struct clk_pll pll14 = {
> > >  	.status_bit = 16,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > >  		.name = "pll14",
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_ops,
> > >  	},
> > > @@ -205,7 +213,9 @@ static struct clk_regmap pll14_vote = {
> > >  	.enable_mask = BIT(14),
> > >  	.hw.init = &(struct clk_init_data){
> > >  		.name = "pll14_vote",
> > > -		.parent_names = (const char *[]){ "pll14" },
> > > +		.parent_hws = (const struct clk_hw*[]){
> > > +			&pll14.clkr.hw,
> > > +		},
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_vote_ops,
> > >  	},
> > > @@ -238,7 +248,7 @@ static struct clk_pll pll18 = {
> > >  	.freq_tbl = pll18_freq_tbl,
> > >  	.clkr.hw.init = &(struct clk_init_data){
> > >  		.name = "pll18",
> > > -		.parent_names = (const char *[]){ "pxo" },
> > > +		.parent_data = gcc_pxo,
> > >  		.num_parents = 1,
> > >  		.ops = &clk_pll_ops,
> > >  	},
> > > @@ -259,9 +269,9 @@ static const struct parent_map gcc_pxo_pll8_map[] = {
> > >  	{ P_PLL8, 3 }
> > >  };
> > >  
> > > -static const char * const gcc_pxo_pll8[] = {
> > > -	"pxo",
> > > -	"pll8_vote",
> > > +static const struct clk_parent_data gcc_pxo_pll8[] = {
> > > +	{ .fw_name = "pxo" },
> > > +	{ .hw = &pll8_vote.hw },
> > >  };
> > >  
> > >  static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
> > > @@ -270,10 +280,10 @@ static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
> > >  	{ P_CXO, 5 }
> > >  };
> > >  
> > > -static const char * const gcc_pxo_pll8_cxo[] = {
> > > -	"pxo",
> > > -	"pll8_vote",
> > > -	"cxo",
> > > +static const struct clk_parent_data gcc_pxo_pll8_cxo[] = {
> > > +	{ .fw_name = "pxo" },
> > > +	{ .hw = &pll8_vote.hw },
> > > +	{ .fw_name = "cxo" },
> > 
> > As with "pxo", I think you need a .name = "cxo" here as well.
> > 
> > Regards,
> > Bjorn
> 
> -- 
> 	Ansuel
