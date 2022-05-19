Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663852CAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiESEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiESEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC634506FB;
        Wed, 18 May 2022 21:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B27B6198B;
        Thu, 19 May 2022 04:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AACC385B8;
        Thu, 19 May 2022 04:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652934195;
        bh=6ta6aaI6tZYd4czjbXO9LuG4HfvGWt2Y/Ts7jlbhP/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j16VJIovr/SGv3ZmRNnW+P/VjcCm3XxU8S+Q2r7Is31qpQ7HK7uFdFMjj8HCFi/3o
         vcKDWB1ojUKaatdsHkBTngatO1oglaywdWX91smvl6wqZeGenURDV0wO6jYpJg700A
         CsyO2bgguOOYbqsNJlRCjLGtx/rIN6/CFCgZtzqecDKPwUwtsEnhncXG54lpgUpqiw
         TsGppih04cBPrElfBzM3OU99RG5JF445YX3QTAPlqF3v9ThQ6hcV2F5Ngs2ktgx+l1
         7vkSwnTHp5pEm99S1Vxa6KgpF71ahYnh+Mle9yR6HGuJU2wKS37EOzH7dxmRTUd/Z9
         PYPT/fckxC7AA==
Date:   Thu, 19 May 2022 09:53:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] phy/qualcomm: add regulator_set_load to dp phy
Message-ID: <YoXGL908lcypSaQc@matsya>
References: <1652909790-16245-1-git-send-email-quic_khsieh@quicinc.com>
 <1652909790-16245-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652909790-16245-3-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-22, 14:36, Kuogee Hsieh wrote:
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.

sigh! still wrong tags!

> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..20ac446 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3130,6 +3130,7 @@ struct qmp_phy_cfg {
>  	int num_resets;
>  	/* regulators to be requested */
>  	const char * const *vreg_list;
> +	const unsigned int *vreg_enable_load;
>  	int num_vregs;
>  
>  	/* array of registers with different offsets */
> @@ -3346,6 +3347,10 @@ static const char * const qmp_phy_vreg_l[] = {
>  	"vdda-phy", "vdda-pll",
>  };
>  
> +static const unsigned int qmp_phy_vreg_enable_load[] = {
> +	21800, 36000
> +};
> +
>  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>  	.type			= PHY_TYPE_USB3,
>  	.nlanes			= 1,
> @@ -4072,6 +4077,7 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>  	.reset_list		= msm8996_usb3phy_reset_l,
>  	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> +	.vreg_enable_load	= qmp_phy_vreg_enable_load,
>  	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>  	.regs			= qmp_v4_usb3phy_regs_layout,
>  
> @@ -4139,6 +4145,7 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
>  	.reset_list		= msm8996_usb3phy_reset_l,
>  	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> +	.vreg_enable_load	= qmp_phy_vreg_enable_load,
>  	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>  	.regs			= qmp_v4_usb3phy_regs_layout,
>  
> @@ -5008,6 +5015,11 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>  		return 0;
>  	}
>  
> +	if (cfg->vreg_enable_load) {
> +		for (i = cfg->num_vregs - 1; i >= 0; --i)
> +			regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_enable_load[i]);
> +	}
> +
>  	/* turn on regulator supplies */
>  	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
>  	if (ret) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
~Vinod
