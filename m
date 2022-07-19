Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3D157910F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiGSC4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiGSC4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:56:01 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5809EB7F1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:55:59 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id u13-20020a4aa34d000000b00435ac6c3b52so183991ool.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JZenFhv1aOXYTh2/Bv9f0vJQurXwBe6cV14Ssoc5sEo=;
        b=ge+hSvVFk+3D3Rb63qtTAhGplDhTkFq2PDa9yCKqZUwiqsugKAU6ffdnBeOp0E8gB1
         Hvcm6Z2NZALFLidPJWmzpZ8o3IPEp4AfedPvh5YFfKaZHSDQkTwgzT5qKaQw3VLFCEjs
         Yq4H1LCy434GO9IcuMDfVdo2hzKfS4vipEWP9kDPsD8/iQtVBmFxxvk9FZqiC8bH6A6e
         dP1/nLDF98YEw+ZBEgOxw64seHitmBjwvg+iyJoa7vNWPGZvsuJn01+xyTIWteSNv4Eu
         qrH4AqR3pctGcyIWLOpcA0a5euJ+ckrlG/CKOiZBWufI3n5w1BleWVrd2sWlqfQceIs2
         69ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JZenFhv1aOXYTh2/Bv9f0vJQurXwBe6cV14Ssoc5sEo=;
        b=judoJlUfxVPs9kROuBWgWKeRHsjMjEDqh1GeFV4SlGFOmGPSeIgMftTqLzYoIekZB/
         /Zm9EVk1d9NQpCt6y6LRYnFWWvE50vTddl0ztu7FRo4kJYM+eEQwLeaFNQ8oAfb5nI1C
         WdlrJSmeC9B86cjIF4ttYiFVaj0axYkxYgOFpMgGGSORXHnGKOiyumu+jwUHz3kGFjLY
         /1+NIlQoIB5t9r/+T+Vu7FGIzIC3OLs6sERe5SOv0+8+AHT67GkzpCJJT6LsEdCAn7uR
         LxzTaRBEyCAblKqBDi9Xvh8Vz/2cEaR9iIhVppTcaIMmdnuY0jGdVa8Of1wzZ9GuX2ZG
         bhHg==
X-Gm-Message-State: AJIora9bKQ+B4EhjPMVAl4I68nl8w1MKS8kcJ43t0uIyBW22D9GNx7I2
        Ca1u9pJLs10P9HCDbBI/SUXJ1A==
X-Google-Smtp-Source: AGRyM1vDFv9tVXUuo+9gtJ1ugmQxWjgC0LSkd6ELQ1+Z5hjk1L/Wy1vDcnaS6h3U/EgI2cTWKth0Ig==
X-Received: by 2002:a4a:d482:0:b0:435:4bf9:3f30 with SMTP id o2-20020a4ad482000000b004354bf93f30mr10570666oos.64.1658199358625;
        Mon, 18 Jul 2022 19:55:58 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n45-20020a4a9570000000b0042313f42b26sm5577231ooi.39.2022.07.18.19.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 19:55:58 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:55:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: qcom: tsens: Add support for
 'needs_reinit_wa' for sm8150
Message-ID: <YtYdPG8ofmmiVe4P@builder.lan>
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701145815.2037993-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Jul 09:58 CDT 2022, Bhupesh Sharma wrote:

> QCoM sm8150 tsens controller might require re-initialization

Please spell out Qualcomm.

> via trustzone [via scm call(s)] when it enters a 'bad state'
> causing sensor temperatures/interrupts status to be in an
> 'invalid' state.
> 
> Add hooks for the same in the qcom tsens driver which
> can be used by followup patch(es).
> 

This patch enables needs_reinit_wa, which is actually implemented in
patch 3, wouldn't it make more sense to flip them around; to first
implement the feature and then enable it in this patch?

> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 11 +++++++++++
>  drivers/thermal/qcom/tsens.c    |  4 ++++
>  drivers/thermal/qcom/tsens.h    |  6 +++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b..61d38a56d29a 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -101,6 +101,17 @@ struct tsens_plat_data data_tsens_v2 = {
>  	.fields	= tsens_v2_regfields,
>  };
>  
> +/* For sm8150 tsens, its suggested to monitor the controller health

/*
 * Outside the network stack, the first line should be left empty in
 * multiline comments.
 */

> + * periodically and in case an issue is detected to reinit tsens
> + * controller via trustzone.
> + */
> +struct tsens_plat_data data_tsens_sm8150 = {

I doubt this is sm8150-specific, so the first question is if this should
be attempted on all data_tsens_v2 platforms. Otherwise, how about naming
this data_tsens_v2_reinit?

Regards,
Bjorn

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
> index 7963ee33bf75..97f4d4454f20 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -991,6 +991,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8996-tsens",
>  		.data = &data_8996,
> +	}, {
> +		.compatible = "qcom,sm8150-tsens",
> +		.data = &data_tsens_sm8150,
>  	}, {
>  		.compatible = "qcom,tsens-v1",
>  		.data = &data_tsens_v1,
> @@ -1135,6 +1138,7 @@ static int tsens_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  	priv->num_sensors = num_sensors;
> +	priv->needs_reinit_wa = data->needs_reinit_wa;
>  	priv->ops = data->ops;
>  	for (i = 0;  i < priv->num_sensors; i++) {
>  		if (data->hw_ids)
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 1471a2c00f15..48a7bda902c1 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -515,6 +515,7 @@ struct tsens_features {
>   * @num_sensors: Number of sensors supported by platform
>   * @ops: operations the tsens instance supports
>   * @hw_ids: Subset of sensors ids supported by platform, if not the first n
> + * @needs_reinit_wa: tsens controller might need reinit via trustzone
>   * @feat: features of the IP
>   * @fields: bitfield locations
>   */
> @@ -522,6 +523,7 @@ struct tsens_plat_data {
>  	const u32		num_sensors;
>  	const struct tsens_ops	*ops;
>  	unsigned int		*hw_ids;
> +	bool			needs_reinit_wa;
>  	struct tsens_features	*feat;
>  	const struct reg_field		*fields;
>  };
> @@ -544,6 +546,7 @@ struct tsens_context {
>   * @srot_map: pointer to SROT register address space
>   * @tm_offset: deal with old device trees that don't address TM and SROT
>   *             address space separately
> + * @needs_reinit_wa: tsens controller might need reinit via trustzone
>   * @ul_lock: lock while processing upper/lower threshold interrupts
>   * @crit_lock: lock while processing critical threshold interrupts
>   * @rf: array of regmap_fields used to store value of the field
> @@ -561,6 +564,7 @@ struct tsens_priv {
>  	struct regmap			*tm_map;
>  	struct regmap			*srot_map;
>  	u32				tm_offset;
> +	bool				needs_reinit_wa;
>  
>  	/* lock for upper/lower threshold interrupts */
>  	spinlock_t			ul_lock;
> @@ -593,6 +597,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
>  extern struct tsens_plat_data data_tsens_v1, data_8976;
>  
>  /* TSENS v2 targets */
> -extern struct tsens_plat_data data_8996, data_tsens_v2;
> +extern struct tsens_plat_data data_8996, data_tsens_sm8150, data_tsens_v2;
>  
>  #endif /* __QCOM_TSENS_H__ */
> -- 
> 2.35.3
> 
