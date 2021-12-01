Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3630464DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbhLAMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349323AbhLAMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:13:13 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44903C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:09:49 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u22so47707124lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 04:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WgVnAy4PaVSjL+4eGkdCy1MSurSmINPE/moDhmd7OEY=;
        b=fGHuBiNONaIQcCEGqZ933n0z5CLNjyxitYLpdM95CqtoZrjDnnf0049EceiUDdzlCi
         DLeM5kgtHk65Swl2mOqvlO7sPdM6RPowjQyC0NBilqGF+V/QgS6zS12MXQ6ECmSf5G/i
         7LtMTeWWVFrSDdV5UhuoWUMN3ATxuD9U+XYKc76j+D6Wf6nIBqbPqZ15m/ub5iNILJDn
         39QES/jHh+jaODfaMRpsroySad0MXtN24HC9ukBKijzXYQnRv9Gi856wLmwxJTlqRCUE
         q36xud4TFp/n98IqYrLlIOC/3s3S2Xu+nSslMQPnlyCaub3e1ThOSXITn1DCV9GRF5XO
         iWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgVnAy4PaVSjL+4eGkdCy1MSurSmINPE/moDhmd7OEY=;
        b=0ikcjBieZJgrDc/3ZSqAP5DgZ+LF7o+3QewBaPaBPr0tl4bE6Vi5LSCGdlXmUGlxZF
         hf5KyJ2AkHBG/FUHIgHvpxH0SWFrL5j8MOHYWXNH8oiypjcGp6rDXjbkkLzDauiZAMbr
         RoTYg2mhhax60NWn1eRcGgsy4NaMkyxkRmeERNWVuZZ4fE8s/+RaVw+YnkCi2BshdvZg
         Sx8pUXyzB/OouAN8s/UIDIuFHDIFtrUAHAP9U8vHyukJVw6WANtT1t8I/AesNjYsFX5i
         lkrr5ue8EZVtY1M39lN3r6Gpdsox5BZaExbdQUb10CdS/OnOmOh0ZIzOjX0rW5w2WWVS
         7Irg==
X-Gm-Message-State: AOAM532lB/9doMobxM9uQoTOkuf5t+weRoM1n6RN1lXqe3GLrSoL4MkW
        bz0kzOc/9Ly142N8lN0MS/47h7JPSB6Whw==
X-Google-Smtp-Source: ABdhPJwwMeZ23XuP5iUvcy/R/g0hpL/lUNgAh0ERVoZdcnMwCE7QDvXIpDSH/0/XU1A+sboOaZ3U0A==
X-Received: by 2002:a2e:b1cf:: with SMTP id e15mr5267678lja.368.1638360587351;
        Wed, 01 Dec 2021 04:09:47 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f10sm2078642lfu.122.2021.12.01.04.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 04:09:46 -0800 (PST)
Subject: Re: [PATCH 4/4] clk: qcom: rpmh: add support for SM8450 rpmh clocks
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072310.3968679-1-vkoul@kernel.org>
 <20211201072310.3968679-5-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <ef6e0041-0e99-d169-d9af-9fa4d4ad5960@linaro.org>
Date:   Wed, 1 Dec 2021 15:09:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201072310.3968679-5-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 10:23, Vinod Koul wrote:
> This adds the RPMH clocks present in SM8450 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/clk/qcom/clk-rpmh.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 441d7a20e6f3..0403cff6c230 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -515,6 +515,32 @@ static const struct clk_rpmh_desc clk_rpmh_sm8350 = {
>   /* Resource name must match resource id present in cmd-db */
>   DEFINE_CLK_RPMH_ARC(sc7280, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 4);
>   
> +DEFINE_CLK_RPMH_VRM(sm8450, ln_bb_clk1, ln_bb_clk1_ao, "lnbclka1", 4);
> +DEFINE_CLK_RPMH_VRM(sm8450, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 4);
> +
> +static struct clk_hw *sm8450_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]		= &sc7280_bi_tcxo.hw,
> +	[RPMH_CXO_CLK_A]	= &sc7280_bi_tcxo_ao.hw,
> +	[RPMH_LN_BB_CLK1]	= &sm8450_ln_bb_clk1.hw,
> +	[RPMH_LN_BB_CLK1_A]	= &sm8450_ln_bb_clk1_ao.hw,
> +	[RPMH_LN_BB_CLK2]	= &sm8450_ln_bb_clk2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &sm8450_ln_bb_clk2_ao.hw,
> +	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
> +	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
> +	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
> +	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
> +	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
> +	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
> +	[RPMH_RF_CLK4]		= &sm8350_rf_clk4.hw,
> +	[RPMH_RF_CLK4_A]	= &sm8350_rf_clk4_ao.hw,
> +	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
> +	.clks = sm8450_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
> +};
> +
>   static struct clk_hw *sc7280_rpmh_clocks[] = {
>   	[RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
>   	[RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
> @@ -647,6 +673,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>   	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
>   	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
>   	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
> +	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
>   	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>   	{ }
>   };
> 


-- 
With best wishes
Dmitry
