Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2004B7D46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiBPCOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:14:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiBPCOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:14:47 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB440E7F72
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:14:35 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so871294oos.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qs5Wv3pL+wFWfpiRhHn2AdJWY7PJclGJQXknrkKkS5Q=;
        b=DPHS3FA258EKnrCH+ke1TpLXySX6tU9Lt+zh4YgoJ9WdSvHN9o2N/qViFYXwenkbdA
         TRzVNQzOiApWxViOwGaNRA4yNodmKBX3tO7J4B9FrIAkSJPWCXgyEkE+qHhd9T78E6bj
         HBYdsc+mm/xiNTXFNd4DBY42XK/BhP4ZHY2UjZ0t2Fg2QR98DtwFeuOthNQCsv/mgXte
         63ZitVCjQaEJOogvzsp10p3xGGSw6EldbxNNpeKqSycGfH1HT1Xfcq/alSeYvBiFr72J
         NBJDtogM+uDxm1nAY/zPI7+WbL7sHoh4IM8uueJACVBnEFkTdqav8ks86k5lU/uBGwP5
         TTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qs5Wv3pL+wFWfpiRhHn2AdJWY7PJclGJQXknrkKkS5Q=;
        b=NzJEWDb7MPowRu9PVVzgX9DPcdutaBhhBbRv2b6UE0nPvK8xtHPeDrXZ+foO/YRQnH
         u/gg0ghwFOGZto/p5twfevMfQRK8FXB8xFOnNzAdcrwObPDnZmQmOHzK1fJBIY8x6x73
         D+7W2b2oUG+g4T+4m2IZjMnwxjUD0T7yMUKwa5Sc5yrPTllYA/Hax6d/iCxLDRhEq5St
         BZfU0vaDi7xdABHYXg2WYfreNflTTWQK7iVda4encmDecaxJFYjJL4CHzvwjrdgh5iPS
         sD5WXOwnKbWSR/pzmqV2xzBFfPNSXAJEvajFn4uWkZZD8HQ1zkSxfoZ+a2RdJMjaVmO5
         a/Bw==
X-Gm-Message-State: AOAM530dFPwIl1BfhnEY7Eek/AtLUX+BQvFbVSLjB5zIak+gtBPKEP7k
        KRacTrbUF5tREbJN9G1o4/VOw+gboVBrHA==
X-Google-Smtp-Source: ABdhPJyw8MHZ2eUchmz87xRT+ihExh1FY1306UMIXaLsKy270Z8smoUE5bHuN3hbumiSLC9Pkg43QA==
X-Received: by 2002:a05:6870:4994:b0:c4:7dc0:d74b with SMTP id ho20-20020a056870499400b000c47dc0d74bmr281884oab.286.1644977675001;
        Tue, 15 Feb 2022 18:14:35 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bj8sm15451410oib.20.2022.02.15.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 18:14:34 -0800 (PST)
Date:   Tue, 15 Feb 2022 20:14:32 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/msm/dpu: Add SC8180x to hw catalog
Message-ID: <YgxeCHi5AsYPTmeZ@builder.lan>
References: <20220215043353.1256754-1-bjorn.andersson@linaro.org>
 <20220215043353.1256754-2-bjorn.andersson@linaro.org>
 <be397e2e-05ab-5c18-8e2d-16c443f0a6d1@quicinc.com>
 <Ygvisfhi0SY6XdAz@builder.lan>
 <6a3ef247-b26b-d505-cd85-92fb277163dd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3ef247-b26b-d505-cd85-92fb277163dd@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Feb 11:42 CST 2022, Abhinav Kumar wrote:

> 
> 
> On 2/15/2022 9:28 AM, Bjorn Andersson wrote:
> > On Tue 15 Feb 11:14 CST 2022, Abhinav Kumar wrote:
> > 
> > > 
> > > 
> > > On 2/14/2022 8:33 PM, Bjorn Andersson wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > > 
> > > > Add SC8180x to the hardware catalog, for initial support for the
> > > > platform. Due to limitations in the DP driver only one of the four DP
> > > > interfaces is left enabled.
> > > > 
> > > > The SC8180x platform supports the newly added DPU_INTF_WIDEBUS flag and
> > > > the Windows-on-Snapdragon bootloader leaves the widebus bit set, so this
> > > > is flagged appropriately to ensure widebus is disabled - for now.
> > > > 
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > [bjorn: Reworked intf and irq definitions]
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > > 
> > > > Changes since v1:
> > > > - Dropped widebus flag
> > > > 
> > > >    .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 129 ++++++++++++++++++
> > > >    .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
> > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
> > > >    drivers/gpu/drm/msm/msm_drv.c                 |   1 +
> > > >    4 files changed, 132 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > > > index aa75991903a6..7ac0fe32df49 100644
> > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > > > @@ -90,6 +90,17 @@
> > > >    			 BIT(MDP_INTF3_INTR) | \
> > > >    			 BIT(MDP_INTF4_INTR))
> > > > +#define IRQ_SC8180X_MASK (BIT(MDP_SSPP_TOP0_INTR) | \
> > > > +			  BIT(MDP_SSPP_TOP0_INTR2) | \
> > > > +			  BIT(MDP_SSPP_TOP0_HIST_INTR) | \
> > > > +			  BIT(MDP_INTF0_INTR) | \
> > > > +			  BIT(MDP_INTF1_INTR) | \
> > > > +			  BIT(MDP_INTF2_INTR) | \
> > > > +			  BIT(MDP_INTF3_INTR) | \
> > > > +			  BIT(MDP_INTF4_INTR) | \
> > > > +			  BIT(MDP_INTF5_INTR) | \
> > > > +			  BIT(MDP_AD4_0_INTR) | \
> > > > +			  BIT(MDP_AD4_1_INTR))
> > > >    #define DEFAULT_PIXEL_RAM_SIZE		(50 * 1024)
> > > >    #define DEFAULT_DPU_LINE_WIDTH		2048
> > > > @@ -225,6 +236,22 @@ static const struct dpu_caps sm8150_dpu_caps = {
> > > >    	.max_vdeci_exp = MAX_VERT_DECIMATION,
> > > >    };
> > > > +static const struct dpu_caps sc8180x_dpu_caps = {
> > > > +	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> > > > +	.max_mixer_blendstages = 0xb,
> > > > +	.qseed_type = DPU_SSPP_SCALER_QSEED3,
> > > > +	.smart_dma_rev = DPU_SSPP_SMART_DMA_V2, /* TODO: v2.5 */
> > > > +	.ubwc_version = DPU_HW_UBWC_VER_30,
> > > > +	.has_src_split = true,
> > > > +	.has_dim_layer = true,
> > > > +	.has_idle_pc = true,
> > > > +	.has_3d_merge = true,
> > > > +	.max_linewidth = 4096,
> > > > +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> > > > +	.max_hdeci_exp = MAX_HORZ_DECIMATION,
> > > > +	.max_vdeci_exp = MAX_VERT_DECIMATION,
> > > > +};
> > > > +
> > > >    static const struct dpu_caps sm8250_dpu_caps = {
> > > >    	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> > > >    	.max_mixer_blendstages = 0xb,
> > > > @@ -293,6 +320,31 @@ static const struct dpu_mdp_cfg sc7180_mdp[] = {
> > > >    	},
> > > >    };
> > > > +static const struct dpu_mdp_cfg sc8180x_mdp[] = {
> > > > +	{
> > > > +	.name = "top_0", .id = MDP_TOP,
> > > > +	.base = 0x0, .len = 0x45C,
> > > > +	.features = 0,
> > > > +	.highest_bank_bit = 0x3,
> > > > +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> > > > +			.reg_off = 0x2AC, .bit_off = 0},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_VIG1] = {
> > > > +			.reg_off = 0x2B4, .bit_off = 0},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_VIG2] = {
> > > > +			.reg_off = 0x2BC, .bit_off = 0},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_VIG3] = {
> > > > +			.reg_off = 0x2C4, .bit_off = 0},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = {
> > > > +			.reg_off = 0x2AC, .bit_off = 8},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_DMA1] = {
> > > > +			.reg_off = 0x2B4, .bit_off = 8},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_CURSOR0] = {
> > > > +			.reg_off = 0x2BC, .bit_off = 8},
> > > > +	.clk_ctrls[DPU_CLK_CTRL_CURSOR1] = {
> > > > +			.reg_off = 0x2C4, .bit_off = 8},
> > > > +	},
> > > > +};
> > > > +
> > > >    static const struct dpu_mdp_cfg sm8250_mdp[] = {
> > > >    	{
> > > >    	.name = "top_0", .id = MDP_TOP,
> > > > @@ -861,6 +913,16 @@ static const struct dpu_intf_cfg sc7280_intf[] = {
> > > >    	INTF_BLK("intf_5", INTF_5, 0x39000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
> > > >    };
> > > > +static const struct dpu_intf_cfg sc8180x_intf[] = {
> > > > +	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> > > > +	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> > > > +	INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
> > > > +	/* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this is supported */
> > > > +	INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 999, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
> > > > +	INTF_BLK("intf_4", INTF_4, 0x6C000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
> > > > +	INTF_BLK("intf_5", INTF_5, 0x6C800, INTF_DP, MSM_DP_CONTROLLER_2, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
> > > 
> > > This is a continued discussion from
> > > https://patchwork.freedesktop.org/patch/474179/.
> > > 
> > > Shouldnt INTF_5 be marked as INTF_eDP?
> > > 
> > 
> > Might be, I didn't even know we had an INTF_EDP define...
> > 
> > Is there any reason to distinguish DP and EDP in the DPU?  I see sc7280
> > doesn't distinguish the DP and EDP interfaces.
> > 
> > Regards,
> > Bjorn
> > 
> 
> Like I have mentioned in the other patch, I think we have enough confusion
> between eDP and DP with the common driver. Since DPU does have separate
> interfaces I think we should fix that.
> 
> Regarding sc7280 using INTF_DP, I synced up with Sankeerth. He referred to
> your change
> https://patchwork.freedesktop.org/patch/457776/?series=92992&rev=5 as it was
> posted earlier and ended up using the same INTF_DP macro. So its turning out
> to be a cyclical error.
> 

That made me take a second look at the HPG, and sure enough INTF_5 on
SC7280 is connected to a eDP/DP Combo PHY. We have the same setup in
SC8280XP.

In SC8180X, INTF_5 is documented as being connected to a eDP (only) PHY,
so perhaps it makes sense to do it there, but for the others its wrong.

Regards,
Bjorn
