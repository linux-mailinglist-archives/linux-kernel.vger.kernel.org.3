Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB751678C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352249AbiEATqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiEATqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:46:43 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715D167F7;
        Sun,  1 May 2022 12:43:17 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 000593F62D;
        Sun,  1 May 2022 21:43:14 +0200 (CEST)
Date:   Sun, 1 May 2022 21:43:13 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH] clk: qcom: smd: Update MSM8976 RPM clocks.
Message-ID: <20220501194313.zu4dmmlggiksi6ce@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Adam Skladowski <a39.skl@gmail.com>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
References: <20220426090226.27293-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426090226.27293-1-a39.skl@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-26 11:02:17, Adam Skladowski wrote:
> MSM8976 does not have rpm clock named mmssnoc,
> instead it's called sysmmnoc, drop define and reuse.
> While we are at it add XO clock to list.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

This patch should have had a Fixes: tag, not in the least to allow
backporting but also to have get_maintainer.pl add the original author
in CC for additional review and sign-off.

In any case the omission of the XO clock here is intentional: the clock
might be stopped whereas none of the platform is configured to support
XO shutdown yet, which is why a "fixed-clock" is used in DT for now.

With that in mind both changes should have been split into separate
patches, so that the clock rename can be safely annoted with a Fixes:
tag.  Presuming the application of this patch to `for-next` isn't final,
Bjorn is this something we can get worked through?  I've validated the
rename with my downstream sources, and for that:

    Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

But for the XO addition I'm wary of platform lockups.

- Marijn

> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index afc6dc930011..10b4e6d8d10f 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -563,17 +563,19 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
>  	.num_clks = ARRAY_SIZE(msm8974_clks),
>  };
>  
> -DEFINE_CLK_SMD_RPM(msm8976, mmssnoc_ahb_clk, mmssnoc_ahb_a_clk,
> -		   QCOM_SMD_RPM_BUS_CLK, 2);
>  DEFINE_CLK_SMD_RPM(msm8976, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
>  
>  static struct clk_smd_rpm *msm8976_clks[] = {
> +	[RPM_SMD_XO_CLK_SRC] = &sdm660_bi_tcxo,
> +	[RPM_SMD_XO_A_CLK_SRC] = &sdm660_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK] = &msm8916_pcnoc_clk,
>  	[RPM_SMD_PCNOC_A_CLK] = &msm8916_pcnoc_a_clk,
>  	[RPM_SMD_SNOC_CLK] = &msm8916_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK] = &msm8916_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK] = &msm8916_bimc_clk,
>  	[RPM_SMD_BIMC_A_CLK] = &msm8916_bimc_a_clk,
> +	[RPM_SMD_SYSMMNOC_CLK]	= &msm8936_sysmmnoc_clk,
> +	[RPM_SMD_SYSMMNOC_A_CLK] = &msm8936_sysmmnoc_a_clk,
>  	[RPM_SMD_QDSS_CLK] = &msm8916_qdss_clk,
>  	[RPM_SMD_QDSS_A_CLK] = &msm8916_qdss_a_clk,
>  	[RPM_SMD_BB_CLK1] = &msm8916_bb_clk1,
> @@ -586,8 +588,6 @@ static struct clk_smd_rpm *msm8976_clks[] = {
>  	[RPM_SMD_BB_CLK1_A_PIN] = &msm8916_bb_clk1_a_pin,
>  	[RPM_SMD_BB_CLK2_PIN] = &msm8916_bb_clk2_pin,
>  	[RPM_SMD_BB_CLK2_A_PIN] = &msm8916_bb_clk2_a_pin,
> -	[RPM_SMD_MMSSNOC_AHB_CLK] = &msm8976_mmssnoc_ahb_clk,
> -	[RPM_SMD_MMSSNOC_AHB_A_CLK] = &msm8976_mmssnoc_ahb_a_clk,
>  	[RPM_SMD_DIV_CLK2] = &msm8974_div_clk2,
>  	[RPM_SMD_DIV_A_CLK2] = &msm8974_div_a_clk2,
>  	[RPM_SMD_IPA_CLK] = &msm8976_ipa_clk,
> -- 
> 2.25.1
> 
