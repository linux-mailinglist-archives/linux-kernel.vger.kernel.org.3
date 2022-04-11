Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80734FBD19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbiDKNdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiDKNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C0EBD;
        Mon, 11 Apr 2022 06:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A729160FAF;
        Mon, 11 Apr 2022 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB6BC385A5;
        Mon, 11 Apr 2022 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649683845;
        bh=gUEFNz2ZvRfZ6XHal7LLowTMm6RR0s9wpCOWjkYj/78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btVkYfbeBEQVuTdjBp8B3BigqHcGf5HpRkLstQIBcH9LWLmRh5vsXIpGU0kALfJsg
         GsKeRk1/noyp4G95qkgYxpGqQZyUsBerE9nn97aTLhTMsaqwN79SSJcIB1fzwEnHQK
         ad7/sn5GWbzNqIHYmeloa6QFylpGlGN8QxgnfwG9IGl+8NpsxrUyqrP8cF71ycRJvm
         MzhlXcRErl7tMRQktqqQpLtY+WGszokeXTV6MBFutpTZ65mPWYkPO21USiXLMonxTN
         4Eop22Qa3dln+5zaDE4gLm2tcAKGlCDahEoKx8sNecU/r6E9be3t4Gi/dYSQP169BZ
         zNhTBxsrNnI6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndu7q-0005UC-MX; Mon, 11 Apr 2022 15:30:38 +0200
Date:   Mon, 11 Apr 2022 15:30:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] soc: qcom: rpmhpd: add sc8280xp rpmh power-domains
Message-ID: <YlQtfu5K9IeJLPcS@hovoldconsulting.com>
References: <20220225054345.2479565-1-bjorn.andersson@linaro.org>
 <20220225054345.2479565-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225054345.2479565-2-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:43:45PM -0800, Bjorn Andersson wrote:
> The Qualcomm sc8280xp platform has 8 power-domains. Add these, and their
> relevant active-only variants, to the RPMh power-domain driver.

As we discussed off-list, the sc8280xp apparently has 13 domains. Guess
the commit message should be updated even if you don't expose all of
these to Linux.

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/soc/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 58f1dc9b9cb7..71602eb824f7 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -180,6 +180,11 @@ static struct rpmhpd mxc_ao = {
>  	.res_name = "mxc.lvl",
>  };
>  
> +static struct rpmhpd nsp = {
> +	.pd = { .name = "nsp", },
> +	.res_name = "nsp.lvl",
> +};
> +
>  /* SDM845 RPMH powerdomains */
>  static struct rpmhpd *sdm845_rpmhpds[] = {
>  	[SDM845_CX] = &cx_w_mx_parent,
> @@ -363,10 +368,31 @@ static const struct rpmhpd_desc sc8180x_desc = {
>  	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
>  };
>  
> +/* SC8280xp RPMH powerdomains */
> +static struct rpmhpd *sc8280xp_rpmhpds[] = {
> +	[SC8280XP_CX] = &cx,
> +	[SC8280XP_CX_AO] = &cx_ao,
> +	[SC8280XP_MX] = &mx,
> +	[SC8280XP_MX_AO] = &mx_ao,
> +	[SC8280XP_EBI] = &ebi,
> +	[SC8280XP_LCX] = &lcx,
> +	[SC8280XP_LMX] = &lmx,
> +	[SC8280XP_GFX] = &gfx,
> +	[SC8280XP_MMCX] = &mmcx,
> +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> +	[SC8280XP_NSP] = &nsp,
> +};

Commit 90c74c1c2574 ("soc: qcom: rpmhpd: Sort power-domain definitions
and lists") recently sorted the other arrays. Sorting by address like
you've implicitly done here makes it easy to compare with the firmware
interface, but perhaps you want to sort alphabetically for consistency.

Since there apparently are no users for active-only domains in the tree,
perhaps they can also be added later.

> +
> +static const struct rpmhpd_desc sc8280xp_desc = {
> +	.rpmhpds = sc8280xp_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
> +};
> +
>  static const struct of_device_id rpmhpd_match_table[] = {
>  	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>  	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>  	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
>  	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>  	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
>  	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },

Johan
