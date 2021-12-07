Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A146B1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhLGEcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhLGEcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:32:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB335C061746;
        Mon,  6 Dec 2021 20:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CFBF6CE19C0;
        Tue,  7 Dec 2021 04:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A447C341C3;
        Tue,  7 Dec 2021 04:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638851328;
        bh=baR953xcu0rbWYXyxFKXRDvT2g5U7pX8hmGqm6E+cyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gc5wM0yh9ESbFyC07oNtW+2Do5mmMVet1+QUiljWH6zaeRHM9uTbwWvNjBOTGVS3t
         lAKpBQoY6zYAWwWU3yG+t9vnQ2hlkB2kss/9MtU4S1DenAz0nHKluaYnz9ywxdAngL
         N2NC/uh2IEKDLqf8QQDBX13/tuSf6yCJH+YmpkgLRXPdd1mdvek6SDn6ANbQG3EXQ/
         sNo6aMkvKnCTkDZv2ePS3aNk/s2OFh9XneWwbecSbZvdqbYNyhw3X0UkOkVKAAWT5j
         eDM3rDrPc9W1wvHYdSJbr1+PpCtyWBnfvDBJXzAtMFcox+K4tx8dPWpZEw1lX4oIhF
         yv2RT/h/CxRdA==
Date:   Tue, 7 Dec 2021 09:58:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: qcom: Add clock driver for SM8450
Message-ID: <Ya7i+zfHhuiHFlYX@matsya>
References: <20211201072310.3968679-1-vkoul@kernel.org>
 <20211201072310.3968679-4-vkoul@kernel.org>
 <2649eada-3e80-cec3-5dca-bded67fa5f80@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2649eada-3e80-cec3-5dca-bded67fa5f80@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 16:37, Konrad Dybcio wrote:
> On 01.12.2021 08:23, Vinod Koul wrote:

> > +static struct clk_alpha_pll gcc_gpll0 = {
> > +	.offset = 0x0,
> > +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> > +	.clkr = {
> > +		.enable_reg = 0x62018,
> > +		.enable_mask = BIT(0),
> > +		.hw.init = &(struct clk_init_data){
> > +			.name = "gcc_gpll0",
> > +			.parent_data = &(const struct clk_parent_data){
> > +				.fw_name = "bi_tcxo",
> > +				.name = "bi_tcxo",
> 
> I don't think we want .name for new drivers, as we do things cleanly
> 
> from the start and don't have DT incompatibility problems.

Yes we need only fw_name here, I missed to remove this

> > +static int gcc_sm8450_probe(struct platform_device *pdev)
> > +{
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	regmap = qcom_cc_map(pdev, &gcc_sm8450_desc);
> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(regmap);
> > +
> > +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> > +				       ARRAY_SIZE(gcc_dfs_clocks));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
> > +	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
> > +
> > +	/* Keep the critical clock always-On
> 
> I think the general style for multiline comments is to start with /* and then add a newline

Yes thanks for spotting, fixed

> > +	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
> > +	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
> > +	 * gcc_video_xo_clk
> > +	 */
> > +	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
> > +	regmap_update_bits(regmap, 0x36020, BIT(0), BIT(0));
> > +	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
> > +	regmap_update_bits(regmap, 0x3701c, BIT(0), BIT(0));
> > +	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
> > +	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
> > +	regmap_update_bits(regmap, 0x42028, BIT(0), BIT(0));
> > +
> > +	ret = qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to register GCC clocks\n");
> 
> That's a bad downstream leftover that we don't want..
> 
> 
> 
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "Registered GCC clocks\n");
> 
> And so is this.

true will remove these

> > +
> > +	return ret;
> 
> You can simply return qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);

right!

-- 
~Vinod
