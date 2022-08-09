Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A758E109
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbiHIU0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiHIUZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:25:50 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07591263A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:25:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10dc1b16c12so15360898fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=oyLlRoOfhFin1nY24GxzTdq3Zzne1Rl50dg/CrRO5/Y=;
        b=fFZMVXdeVQyp2EGRuSwBMRW2bUYDLnH4BmR3ZGIpeibfJo59JEpUyvDjMlBucUGkJb
         zjRm8Z9cFHPvy9HDk2JFzNaEvYZ+5qtk21cKhVTrKGKZI1nceKJV1fLm9aBX5660oAm0
         huhH0bzv7QeFOqD4UFd7AOryRqEBl6kJa641zvcp2OKZcVZHw/Tl43gHDqgTQBphpKdJ
         lMwEtq29Flya17u3JjOmgh6+6FFjz6fxng93Y6mQt48mwhE/y664U9cTjUv8DxOllX9T
         ep8jGl+I2QShxiuq1cztBVjUgZuQF1tMvicoh+op8gn5jKHUJbhalA4c196EQ37QWpVv
         s92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=oyLlRoOfhFin1nY24GxzTdq3Zzne1Rl50dg/CrRO5/Y=;
        b=4AjIYRDapjEQP8xOGvYcV4tTkpLcIuXrw/9YEZosdGoyT+cIOERAgCHdoxePPsVag9
         ALuL/pBFP3xZ8AYADxSia08lMscjPbsW1/N0uthJmh6uyObsm4LsWyA9tRSRv0AeMtg4
         VZQ9eMqCjeF7m5VKgcvx6mlNheFaRKGl57AgWXceBR8UjbtoskOgTQLDbX+jCw5SL5bh
         CsJeWeRNW87FUIVcL2UaXInRQBYrjjkvTohf6oChs74dxRZdEaG5B5N8mFanG1B4dSTw
         U3aLsWS7MC2WKaH4B6YUrnAWe5sw4dtvx/QyGbHLIm5D+WvyVj/GkdVbYR4waci/UByF
         NSAQ==
X-Gm-Message-State: ACgBeo0ukc0UsFTJEbJxCgnvPxNavtyHjU785sGhXBZbSrDTOg3baHTy
        9fS6cxyi+s/NIKNtFABDa6id4A==
X-Google-Smtp-Source: AA6agR69qi0ar9dNZiz8nbBAL+WcOiF9myeniXMJEDJi/MvH7cKYz+/kMm0Zmfjao3RfRlWpPq+3IQ==
X-Received: by 2002:a05:6870:5494:b0:10e:63c7:2a0c with SMTP id f20-20020a056870549400b0010e63c72a0cmr95029oan.85.1660076748315;
        Tue, 09 Aug 2022 13:25:48 -0700 (PDT)
Received: from baldur ([2600:380:785a:7aa8:200:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id fo34-20020a0568709a2200b0010e47737471sm3341706oab.49.2022.08.09.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:25:47 -0700 (PDT)
Date:   Tue, 9 Aug 2022 15:25:39 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/9] clk: qcom: qcc-sdm845: Collapse gdsc structs into
 macros
Message-ID: <YvLCwyB9rBWXmfZt@baldur>
References: <20220726142303.4126434-1-abel.vesa@linaro.org>
 <20220726142303.4126434-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142303.4126434-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Jul 09:22 CDT 2022, Abel Vesa wrote:

> Collapse gdsc structs definitions into macros to make them
> more compact visually.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sdm845.c | 129 ++++------------------------------
>  drivers/clk/qcom/gdsc.h       |  10 +++
>  2 files changed, 23 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 58aa3ec9a7fc..8529e9c8c90c 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3191,122 +3191,19 @@ static struct clk_branch gcc_lpass_sway_clk = {
>  };
>  #endif
>  
> -static struct gdsc pcie_0_gdsc = {
> -	.gdscr = 0x6b004,
> -	.pd = {
> -		.name = "pcie_0_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc pcie_1_gdsc = {
> -	.gdscr = 0x8d004,
> -	.pd = {
> -		.name = "pcie_1_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc ufs_card_gdsc = {
> -	.gdscr = 0x75004,
> -	.pd = {
> -		.name = "ufs_card_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc ufs_phy_gdsc = {
> -	.gdscr = 0x77004,
> -	.pd = {
> -		.name = "ufs_phy_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc usb30_prim_gdsc = {
> -	.gdscr = 0xf004,
> -	.pd = {
> -		.name = "usb30_prim_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc usb30_sec_gdsc = {
> -	.gdscr = 0x10004,
> -	.pd = {
> -		.name = "usb30_sec_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc = {
> -	.gdscr = 0x7d030,
> -	.pd = {
> -		.name = "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc = {
> -	.gdscr = 0x7d03c,
> -	.pd = {
> -		.name = "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_tbu1_gdsc = {
> -	.gdscr = 0x7d034,
> -	.pd = {
> -		.name = "hlos1_vote_aggre_noc_mmu_tbu1_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_tbu2_gdsc = {
> -	.gdscr = 0x7d038,
> -	.pd = {
> -		.name = "hlos1_vote_aggre_noc_mmu_tbu2_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
> -	.gdscr = 0x7d040,
> -	.pd = {
> -		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
> -	.gdscr = 0x7d048,
> -	.pd = {
> -		.name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
> -	.gdscr = 0x7d044,
> -	.pd = {
> -		.name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
> -	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> -};
> +DEFINE_QCOM_CC_GDSC(pcie_0_gdsc, 0x6b004, "pcie_0_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(pcie_1_gdsc, 0x8d004, "pcie_1_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(ufs_card_gdsc, 0x75004, "ufs_card_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(ufs_phy_gdsc, 0x77004, "ufs_phy_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(usb30_prim_gdsc, 0xf004, "usb30_prim_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(usb30_sec_gdsc, 0x10004, "usb30_sec_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc, 0x7d030, "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc, 0x7d03c, "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu1_gdsc, 0x7d034, "hlos1_vote_aggre_noc_mmu_tbu1_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu2_gdsc, 0x7d038, "hlos1_vote_aggre_noc_mmu_tbu2_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc, 0x7d040, "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc, 0x7d048, "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_sf_gdsc, 0x7d044, "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc", PWRSTS_OFF_ON, VOTABLE);

Personally I have a really hard time looking at such a compact chunk of
text and hence this is harder for me to spot mistakes and differences
in.

While I like the effort of making things easier to maintain this made me
further appreciate the change we've done in the interconnect providers,
where we're doing the exact opposite - and remove magical macros.

Regards,
Bjorn

>  
>  static struct clk_regmap *gcc_sdm845_clocks[] = {
>  	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 5de48c9439b2..c0e616b49dee 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -78,6 +78,16 @@ struct gdsc_desc {
>  	size_t num;
>  };
>  
> +#define DEFINE_QCOM_CC_GDSC(_name, _gdscr, _pd_name, _pwrsts, _flags) \
> +	static struct gdsc _name = {			\
> +		.gdscr = _gdscr,		\
> +		.pd = {				\
> +			.name = _pd_name,	\
> +		},				\
> +		.pwrsts = _pwrsts,		\
> +		.flags = _flags,		\
> +	}
> +
>  #ifdef CONFIG_QCOM_GDSC
>  int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
>  		  struct regmap *);
> -- 
> 2.34.3
> 
