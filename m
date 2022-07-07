Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025C6569865
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiGGCxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGGCxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:53:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB922E9FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:53:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i126so22006635oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f4gaIJzDqBtSQKdyRb4t4FRZSvTpNHgxc06VwJFCJAs=;
        b=Vb9qqr0pPGtHzU++ok/knruEFhsnCHW0Qb+VtlleGiMOcXFwk1s5K0QVkmOC7TgX5+
         lTJlFpiGLm9oqhfUYgFHkGAD9DAm8JfHyZ6fdllezSHyxoopNETQ4vlhpx8atXQPqaEW
         arraTAUcOGYzdBB52FQ6ANzdcFxLeNWdA1/WpSV+xAam34kv/iRHkByIs1joKQJ5CsLE
         +AbTk+0wIVZCMFwh0T2+LGpzPxwjMGVafogxno2IL/P/cMbFa6QR33AXZaZYjBI+01Fk
         TTe41DWfUk5tnPZ8fnefR04310nvHPBZqIsHgYCq56BJIoNEADadGFqyn4xHpVC727aD
         Pmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f4gaIJzDqBtSQKdyRb4t4FRZSvTpNHgxc06VwJFCJAs=;
        b=Z/0iuwKPeCidzqV1isS++u5c4FeWx5Z3vPQ7otmS+n8/ZTx85cxti3qQrXm5NU4Wj5
         3fi3sF4gyAOwZDeGbVZII+XB3HaEs+9JkwqCCQ4UVzvTecAUxAHpwFC4OXubAsx2garR
         jwQfrRAVTeKYqAfRFIxVx0Dy0iEXvZ58gQoGJ4vdbd1DaywCbOIIgwqxcVndvtKHVlYN
         Vn3kXM/nKB3IWxjWg3//apefObpLBiEu4Fb0/JTXs6hDCjLo2wKVPH390TgBd7XWxsdP
         g1J8/OI5XE8ofkZP1TdTGg9Vo8fp8QtkYQzcOkZPdoTmVMzAA624qW6KNBznJKxNC7ib
         n8Yg==
X-Gm-Message-State: AJIora8xv8p6sxe+kwinafqCOTgNR1ZNnCNLEyeqQWnpK1kdNHX0JsoA
        DXLj/eAgH9WUXLLggLQjiiq0TQ==
X-Google-Smtp-Source: AGRyM1svAYUXqzvpRaXYAeKIXNDjL2uNhdgk3jFmzNDfwIYkLys7rdcETxbCrhpx2JKvEfFTixdjDg==
X-Received: by 2002:a05:6808:170c:b0:335:1d14:f99d with SMTP id bc12-20020a056808170c00b003351d14f99dmr1039582oib.243.1657162427267;
        Wed, 06 Jul 2022 19:53:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u13-20020a056870f28d00b001048b819e13sm21166966oap.8.2022.07.06.19.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:53:46 -0700 (PDT)
Date:   Wed, 6 Jul 2022 21:53:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] hwspinlock: qcom: Add support for mmio usage to
 sfpb-mutex
Message-ID: <YsZKuUAc2iHWg9kN@builder.lan>
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707013017.26654-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Jul 20:30 CDT 2022, Christian Marangi wrote:

> Allow sfpb-mutex to use mmio in addition to syscon.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/hwspinlock/qcom_hwspinlock.c | 32 ++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
> index 364710966665..23c913095bd0 100644
> --- a/drivers/hwspinlock/qcom_hwspinlock.c
> +++ b/drivers/hwspinlock/qcom_hwspinlock.c
> @@ -19,6 +19,11 @@
>  #define QCOM_MUTEX_APPS_PROC_ID	1
>  #define QCOM_MUTEX_NUM_LOCKS	32
>  
> +struct qcom_hwspinlock_of_data {
> +	u32 offset;
> +	u32 stride;
> +};
> +
>  static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
>  {
>  	struct regmap_field *field = lock->priv;
> @@ -63,9 +68,20 @@ static const struct hwspinlock_ops qcom_hwspinlock_ops = {
>  	.unlock		= qcom_hwspinlock_unlock,
>  };
>  
> +static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
> +	.offset = 0x4,
> +	.stride = 0x4,
> +};
> +
> +/* All modern platform has offset 0 and stride of 4k */
> +static const struct qcom_hwspinlock_of_data of_tcsr_mutex = {
> +	.offset = 0,
> +	.stride = 0x1000,
> +};
> +
>  static const struct of_device_id qcom_hwspinlock_of_match[] = {
> -	{ .compatible = "qcom,sfpb-mutex" },
> -	{ .compatible = "qcom,tcsr-mutex" },
> +	{ .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
> +	{ .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
> @@ -101,7 +117,7 @@ static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
>  	return regmap;
>  }
>  
> -static const struct regmap_config tcsr_mutex_config = {
> +static const struct regmap_config qcom_hwspinlock_mmio_config = {

Any objections against me skipping this rename when applying the patch?
Just to keep the patch to the point?

Regards,
Bjorn

>  	.reg_bits		= 32,
>  	.reg_stride		= 4,
>  	.val_bits		= 32,
> @@ -112,18 +128,20 @@ static const struct regmap_config tcsr_mutex_config = {
>  static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
>  						 u32 *offset, u32 *stride)
>  {
> +	const struct qcom_hwspinlock_of_data *data;
>  	struct device *dev = &pdev->dev;
>  	void __iomem *base;
>  
> -	/* All modern platform has offset 0 and stride of 4k */
> -	*offset = 0;
> -	*stride = 0x1000;
> +	data = of_device_get_match_data(dev);
> +
> +	*offset = data->offset;
> +	*stride = data->stride;
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return ERR_CAST(base);
>  
> -	return devm_regmap_init_mmio(dev, base, &tcsr_mutex_config);
> +	return devm_regmap_init_mmio(dev, base, &qcom_hwspinlock_mmio_config);
>  }
>  
>  static int qcom_hwspinlock_probe(struct platform_device *pdev)
> -- 
> 2.36.1
> 
