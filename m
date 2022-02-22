Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7314BFB55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiBVO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiBVO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:58:55 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F094410CF35
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:58:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ay3so6989034plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4CEE+0wKb8UfUqoMrShAMBWjFMiHTZ3cV+ajAGhF8ag=;
        b=mQ78OQp7q1EpCQGFj8mbg/lCYMtasAf0LLvNfQ5Rvv4rjzY3hj+45RihibZGQeNuiB
         CUeWl7w5ohrcgdij+wz4EVt+h5hVD9FIgCY+Z6cw7Ew5jXnnlVpKuTqRiNLAmcht1Ztp
         +iZvCpkQgvIAvsBr0a3VNHzfJO+/cefrYTpvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4CEE+0wKb8UfUqoMrShAMBWjFMiHTZ3cV+ajAGhF8ag=;
        b=WTTWv/HOwE59lTMuRanX96cqv6O12onPJyGAXklc52c+IPLTkSm+FzUpUCeilcqcTF
         nyjSN4usaf7nSyQqVoFAkucJOIm54SMsAuH78XYnq5qAqKB/Rma5hCaYk6K3h64jUKOg
         qqpG44lsZcvcoM6vjv7kCI5nj4jFWH4jwCnp3ZMKEBrUcgZNvNMw1LfLx4BOelcnjk9s
         s+f3bxRH30q7Ib4gjfVTjjnDYc1TCVCleOXBeF4YaOxcuhQfyA5excVko8NVDJeniJ1q
         WE4ceGY54Ri6EOzrbFdRajVxJuYtTfc9CxsrxQZS3/IIU3lg7UekBViXu5bZbVadDQaK
         g6wA==
X-Gm-Message-State: AOAM531Sw4Pqi358lrYkHFT0wDHrI8bW9DRQrtfHDnpC+vx+ihLibUNp
        YehUcCwArd+FInxGJZi9MaEx+A==
X-Google-Smtp-Source: ABdhPJxX/Jsf0NvECwznifqIjeh7gPk4Ia+g+5e+p+1HjYk9t74XaLOH+ylaKGBq1LSGtM24LwWcFg==
X-Received: by 2002:a17:902:7205:b0:14c:9586:f9d5 with SMTP id ba5-20020a170902720500b0014c9586f9d5mr23494696plb.77.1645541907460;
        Tue, 22 Feb 2022 06:58:27 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f3fd:51e4:a1f4:e1a6])
        by smtp.gmail.com with UTF8SMTPSA id g11sm18022397pfj.83.2022.02.22.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:58:27 -0800 (PST)
Date:   Tue, 22 Feb 2022 06:58:24 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Message-ID: <YhT6EBzSE/7S3QqT@google.com>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222140746.12293-3-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:07:46PM +0000, Lukasz Luba wrote:
> The Energy Model (EM) can be created based on DT entry:
> 'dynamic-power-coefficient'. It's a 'simple' EM which is limited to the
> dynamic power. It has to fit into the math formula which requires also
> information about voltage. Some of the platforms don't expose voltage
> information, thus it's not possible to use EM registration using DT.
> 
> This patch aims to fix it. It introduces new implementation of the EM
> registration callback. The new mechanism parses OPP node in DT which
> contains the power expressed in micro-Watts. It also allows to register
> 'advanced' EM, which models total power (static + dynamic), so better
> reflects real HW.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/opp/of.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2f40afa4e65c..94059408fa39 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1395,6 +1395,40 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
>  
> +/*
> + * Callback function provided to the Energy Model framework upon registration.
> + * It provides the power based on DT by @dev at @kHz if it is the frequency
> + * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
> + * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
> + * frequency and @mW to the associated power.
> + *
> + * Returns 0 on success or a proper -EINVAL value in case of error.
> + */
> +static int __maybe_unused
> +_get_dt_power(unsigned long *mW, unsigned long *kHz, struct device *dev)

nit: the device is usually the first parameter. It's also the only true input
parameter of this function, most code puts input parameters first.

> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long opp_freq;
> +	u32 opp_power;
> +	int ret;
> +
> +	/* Find the right frequency and related OPP */
> +	opp_freq = *kHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(opp->np, "opp-microwatt", &opp_power);
> +	dev_pm_opp_put(opp);
> +	if (ret)
> +		return -EINVAL;
> +
> +	*kHz = opp_freq / 1000;
> +	*mW = opp_power / 1000;
> +
> +	return 0;
> +}
> +
>  /*
>   * Callback function provided to the Energy Model framework upon registration.
>   * This computes the power estimated by @dev at @kHz if it is the frequency
> @@ -1445,6 +1479,33 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
>  	return 0;
>  }
>  
> +static int _of_find_opp_microwatt_property(struct device *dev)

this function doesn't retrurn the property like of_find_property() does,
_of_has_opp_microwatt_property() would be a be a better name IMO. I'd
also suggest to change the return type to bool, since callers don't
really care about the specific error (which with the current code is
-EINVAL) in all cases.


> +{
> +	unsigned long freq = 0;

Does the compiler complain when the initialization is skipped? The
value of the variable is never read, only it's address is passed to
dev_pm_opp_find_freq_ceil().

> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	struct property *prop;
> +
> +	/* We only support "operating-points-v2" */
> +	np = dev_pm_opp_of_get_opp_desc_node(dev);
> +	if (!np)
> +		return -EINVAL;
> +
> +	of_node_put(np);
> +
> +	/* Check if an OPP has needed property */

The comment doesn't add much value IMO

> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	prop = of_find_property(opp->np, "opp-microwatt", NULL);
> +	dev_pm_opp_put(opp);
> +	if (!prop)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /**
>   * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
>   * @dev		: Device for which an Energy Model has to be registered
> @@ -1474,6 +1535,15 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>  		goto failed;
>  	}
>  
> +	/* First, try to find more precised Energy Model in DT */
> +	if (!_of_find_opp_microwatt_property(dev)) {
> +		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_dt_power);
> +
> +		ret = em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb,
> +						  cpus, true);
> +		return ret;

just 'return em_dev_register_perf_domain(...);'?

> +	}
> +
>  	np = of_node_get(dev->of_node);
>  	if (!np) {
>  		ret = -EINVAL;
> -- 
> 2.17.1
> 
