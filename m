Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AE5A56E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiH2WPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiH2WPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:15:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110D13CC1;
        Mon, 29 Aug 2022 15:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D0CEB81210;
        Mon, 29 Aug 2022 22:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68904C433C1;
        Mon, 29 Aug 2022 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661811296;
        bh=hD9/oOubO72A6IWejdSa+W0oL3PGhm+37vSnUHsh6TA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ig6w8hJrubkCryPEKAdev0AcdZ59r9w5bUyJ/zYAfqmeJ+w37KVeCdLMImHWA0xzk
         cDsEquCXRYULZ96981UQxBvd3ihdFMbkoCeCu782QxbesCHg+oBgWXHqB3z51HMMlW
         QTKyDrRHrKrm11Ayo3nDztR+cgIjjakOyMvI57VdzmJKFTLqhzJxaEIaj7mGrOpyH8
         N++W8eoHYDq6gzx6tu/CPyr5kYrDHQVUnXWIFxaxLYccDRkk5BuZKwLuyGEpC1AQgu
         vqoM0rMTouXBTUyCGUSYgBcE8nuJx2ZWwm0N/D/qPvJPCAklc/cSz7QYHXOVH0y++g
         MuSuSRuDGQ/ew==
Date:   Mon, 29 Aug 2022 17:14:53 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v3 4/4] thermal: qcom: tsens: Add reinit quirk support
 for tsens v2 controllers
Message-ID: <20220829221453.6qexbhvsuqw5wmge@builder.lan>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
 <20220804054638.3197294-5-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804054638.3197294-5-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 11:16:38AM +0530, Bhupesh Sharma wrote:
> Some Qualcomm tsens v2 controllers like those present on
> sm8150 SoC might require re-initialization via trustzone
> [via scm call(s)] when it enters a 'bad state' causing
> sensor temperatures/interrupts status to be in an
> 'invalid' state.
> 
> Add hooks for the same in the qcom tsens driver.
> 
> Devices requiring the same can pass the relevant
> compatible string in dt and the driver hook can
> be used accordingly.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  drivers/thermal/qcom/tsens-v2.c | 12 ++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index f521e4479cc5..431f17f99d34 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -104,6 +104,18 @@ struct tsens_plat_data data_tsens_v2 = {
>  	.fields	= tsens_v2_regfields,
>  };
>  
> +/*
> + * For some tsens v2 controllers, its suggested to monitor the
> + * controller health periodically and in case an issue is detected
> + * to reinit tsens controller via trustzone.
> + */
> +struct tsens_plat_data data_tsens_v2_reinit = {
> +	.ops		= &ops_generic_v2,
> +	.feat		= &tsens_v2_feat,
> +	.needs_reinit_wa = true,
> +	.fields	= tsens_v2_regfields,
> +};
> +
>  /* Kept around for backward compatibility with old msm8996.dtsi */
>  struct tsens_plat_data data_8996 = {
>  	.num_sensors	= 13,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index c2d085fb5447..928b6a44fda8 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1145,6 +1145,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8996-tsens",
>  		.data = &data_8996,
> +	}, {
> +		.compatible = "qcom,sm8150-tsens",
> +		.data = &data_tsens_v2_reinit,
>  	}, {
>  		.compatible = "qcom,tsens-v1",
>  		.data = &data_tsens_v1,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 900d2a74d25e..03cc3a790972 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -607,6 +607,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
>  extern struct tsens_plat_data data_tsens_v1, data_8976;
>  
>  /* TSENS v2 targets */
> -extern struct tsens_plat_data data_8996, data_tsens_v2;
> +extern struct tsens_plat_data data_8996, data_tsens_v2_reinit, data_tsens_v2;
>  
>  #endif /* __QCOM_TSENS_H__ */
> -- 
> 2.35.3
> 
