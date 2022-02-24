Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48E4C27CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiBXJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBXJOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:14:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B719CCF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:13:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m22so1491729pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SEB2HcIZlaGJONkY26HdM82R7VoeFOHxdC+7YcIMHpk=;
        b=BozESD3z7jrdcobIG336ckDeZAT5h9x7FcX4J+gwosdJzTR8yZqS1S/PUUodNTnmxn
         dyxz8PwnhXIC+ujervLPrq18f+p3TtMW8TTtbQOjJHKoOJuoQzkcflu7DNBZq5iFQzPK
         21szHHPjvyarIuX6e6MuWTJ00EeARxT4k4tHBLoGVwGW556uS4lR8abVXCW0hfnwf4d8
         mg2XW1gQst95Dh0Le4fb6ToJ24EQhK/nlPQ0wdSGMKk4SlQMcDWN4pb4Og5Rc1h/0mQ4
         M53vftWWm0vTX2c7e7odMBjVUKc6mhkcTioASNMGsBCUtDADfM/p+PZfL6LwCGFIi3ci
         97MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SEB2HcIZlaGJONkY26HdM82R7VoeFOHxdC+7YcIMHpk=;
        b=niTbf7OdXzOfDdqU6mPx+v15jaDI5OLkKHVvhMt875P8b/4sWtTXjNmPlhLXjHUVST
         XcUGSdcMGvnYcajvsbDtJH+1ByczMI5IguF1EsDNqyysSRqeQyiA3G6GEgNtZNIkeROc
         TA7CZauuYUhbpuR1xBAXsfp0/bATFgXz5GDJJcoOpsec745y40n8P+nBgnJWXZt3hRBt
         9Syqqg0ybF/KQrQmrK3uyT/3P5kk9zW5jGYq0wWLPmjIfheWSLhvrCLJv1KiENTI7CkX
         YRM6JZ51BE6CY9NqK/GM0pZdZ21yIZb5ceKVrh9amWO4CWSUsTB2GdL0uQUy1Zh62Hgl
         JGgw==
X-Gm-Message-State: AOAM530JchMKdr/YlPNcNKsseYZgCQx3Yzm1dREGwIQvonbMD6E/d7Ll
        u8qsxQ9JGlu0UtARt/B8eiCgfA==
X-Google-Smtp-Source: ABdhPJzJ0XhbfmmZjCWBnzEZ/9O3RcQUX+ygX8jRUUsuH0fqSmXlcsrJDkdhqfym7YwV5f4zR6L2Ww==
X-Received: by 2002:a17:903:1252:b0:14d:ca16:2b8 with SMTP id u18-20020a170903125200b0014dca1602b8mr1759819plh.142.1645694028619;
        Thu, 24 Feb 2022 01:13:48 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id s3-20020a17090a5d0300b001bc2b469051sm5406635pji.29.2022.02.24.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:13:47 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:43:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Message-ID: <20220224091346.xmnpj27vllpa4cuy@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-4-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 08:11, Lukasz Luba wrote:
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>  
> +/*
> + * Callback function provided to the Energy Model framework upon registration.
> + * It provides the power used by @dev at @kHz if it is the frequency of an
> + * existing OPP, or at the frequency of the first OPP above @kHz otherwise
> + * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
> + * frequency and @mW to the associated power.
> + *
> + * Returns 0 on success or a proper -EINVAL value in case of error.
> + */
> +static int __maybe_unused
> +_get_opp_power(unsigned long *mW, unsigned long *kHz, struct device *dev)

Lets call it _get_dt_opp_power() or _get_dt_power() ?

> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long opp_freq, opp_power;
> +
> +	/* Find the right frequency and related OPP */
> +	opp_freq = *kHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	opp_power = dev_pm_opp_get_power(opp);

As I said in 2/4, this should really give the total instead.

> +	dev_pm_opp_put(opp);
> +	if (!opp_power)
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
> @@ -1488,6 +1520,24 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
>  	return 0;
>  }
>  
> +static bool _of_has_opp_microwatt_property(struct device *dev)
> +{
> +	unsigned long power, freq = 0;
> +	struct dev_pm_opp *opp;
> +
> +	/* Check if at least one OPP has needed property */
> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp))
> +		return false;
> +
> +	power = dev_pm_opp_get_power(opp);
> +	dev_pm_opp_put(opp);
> +	if (!power)

What if this particular frequency has 0 power mentioned for some
reason :)

Instead of this heavy stuff, just pick the first OPP from the opp
table and see its power-value.

> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
>   * @dev		: Device for which an Energy Model has to be registered
> @@ -1517,6 +1567,14 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>  		goto failed;
>  	}
>  
> +	/* First, try to find more precised Energy Model in DT */
> +	if (_of_has_opp_microwatt_property(dev)) {
> +		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_opp_power);
> +
> +		return em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb,
> +						   cpus, true);
> +	}
> +

We have another em_dev_register_perf_domain() down the line, lets keep
only one such call and get it a callback that should be set in an
if/else loop.

>  	np = of_node_get(dev->of_node);
>  	if (!np) {
>  		ret = -EINVAL;
> -- 
> 2.17.1

-- 
viresh
