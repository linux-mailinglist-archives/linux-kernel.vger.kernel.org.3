Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0229450DA17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiDYHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiDYHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:30:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B67767D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:27:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q8so1899078plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxyP1rA1NVCKi+Fqd9RTEgWTAs6MpVuSe+By3MBiK+g=;
        b=uhHdnNiHGlo6+p+WxcM0C9NfBcZ1yMZ4ZL8lPJjCqFO59XftyiBXmxLnJ4x/8IHesk
         Iz/e+72c+hpYYtSkpN9st79ktLRdF9ucEIcsSZFrJz8zW/33b/zII36XFlgftlgRt/Rn
         NcV0nn+GcFItTljdcQkhhruORyaimT8Hcjdf+33DifIdLTWHRc7f4BBjOpmEow9TxUAk
         H3AoQBVj8pg7peGOZ40pMWJPb4v77MByQ/hq2wnaWxWmitojdTlAcivhdbQ8eALivIcc
         CxsiobTeJA1GwrggCLqf/tliVYwpbUOcyyC+5xohbYhPGazYOIMkwv+sGtPOlvneNaO1
         ub6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxyP1rA1NVCKi+Fqd9RTEgWTAs6MpVuSe+By3MBiK+g=;
        b=QRv7FMQS9nvA03GXabUGUN+r2UrN49dpeHpSET1gHoZTHekJDWEX+BnbFK9gQx1fWA
         5eM0GGhzIUJxATXQuU7dBRvNaXyn8/YMDgBRuY13a2S3xgVpoETOvinrbauL+G9RBuhX
         IfR9NabAN+u97K11VNbQZ5kaB3fufxeRvdIEmkANsEKEPaCwCxT6MYJhA1oXZ7q/T7U2
         DqWV407i+rlS/p1ir8HFoTk/hbogYSxSFRXMSfETKQ2iKFC69Dsph9o9ZyybM+rBd47S
         K+36CPxu7uzJkamN8YIARnHvXuPyfwHfm4hO0LC9ulvRyGUDug3/XJ0nls9dzFyOElow
         uGHA==
X-Gm-Message-State: AOAM533baGVUZXrh14TLIXbZ7dcVd6XnSNdjuZ9hZuBmFfYSqqnkGyOp
        XwFLsjHvAEJ+1pzeWnGqD0qP7Q==
X-Google-Smtp-Source: ABdhPJxE5RcvTjEYwI71Iu772xtRFctxCEAFvy9tKFHoG9lHlSKr+lSmvTHqmcMFobuMjeZomF3jKA==
X-Received: by 2002:a17:90b:3b46:b0:1c7:9ca8:a19e with SMTP id ot6-20020a17090b3b4600b001c79ca8a19emr29586651pjb.245.1650871632716;
        Mon, 25 Apr 2022 00:27:12 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm8596664pgc.91.2022.04.25.00.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:27:12 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:57:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Message-ID: <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-22, 17:43, Krzysztof Kozlowski wrote:
> Devices might need to control several clocks when scaling the frequency
> and voltage.  Example is the Universal Flash Storage (UFS) which scales
> several independent clocks with change of performance levels.
> 
> Add parsing of multiple clocks and clock names

This part is fine, the OPP core should be able to do this.

> and scale all of them,

This is tricky as the OPP core can't really assume the order in which the clocks
needs to be programmed. We had the same problem with multiple regulators and the
same is left for drivers to do via the custom-api.

Either we can take the same route here, and let platforms add their own OPP
drivers which can handle this, Or hide this all behind a basic device clock's
driver, which you get with clk_get(dev, NULL).

> diff --git a/drivers/opp/core.c b/drivers/opp/core.c

> +static int _generic_set_opp_clks_only(struct device *dev,
> +				      struct opp_table *opp_table,
> +				      struct dev_pm_opp *opp)
> +{
> +	int i, ret;
> +
> +	if (!opp_table->clks)
> +		return 0;
> +
> +	for (i = 0; i < opp_table->clk_count; i++) {
> +		if (opp->rates[i]) {

This should mean that we can disable that clock and it isn't required.

> +			ret = _generic_set_opp_clk_only(dev, opp_table->clks[i],
> +							opp->rates[i]);
> +			if (ret) {
> +				dev_err(dev, "%s: failed to set clock %pC rate: %d\n",
> +					__func__, opp_table->clks[i], ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

As said earlier, this won't work in the core.

> +
>  static int _generic_set_opp_regulator(struct opp_table *opp_table,
>  				      struct device *dev,
>  				      struct dev_pm_opp *opp,
> @@ -796,7 +835,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
>  	}
>  
>  	/* Change frequency */
> -	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
> +	ret = _generic_set_opp_clks_only(dev, opp_table, opp);
>  	if (ret)
>  		goto restore_voltage;
>  
> @@ -820,7 +859,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
>  	return 0;
>  
>  restore_freq:
> -	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_opp->rate))
> +	if (_generic_set_opp_clks_only(dev, opp_table, old_opp))
>  		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
>  			__func__, old_opp->rate);
>  restore_voltage:
> @@ -880,7 +919,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,

This is where we can handle it in your case, if you don't want to hide it behind
a clk driver.

>  	}
>  
>  	data->regulators = opp_table->regulators;
> -	data->clk = opp_table->clk;
> +	data->clk = (opp_table->clks ? opp_table->clks[0] : NULL);
>  	data->dev = dev;
>  	data->old_opp.rate = old_opp->rate;
>  	data->new_opp.rate = freq;
> @@ -969,8 +1008,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)

I think this routine breaks as soon as we add support for multiple clocks.
clks[0]'s frequency can be same for multiple OPPs and this won't get you the
right OPP then.

>  	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
>  	unsigned long freq;
>  
> -	if (!IS_ERR(opp_table->clk)) {
> -		freq = clk_get_rate(opp_table->clk);
> +	if (opp_table->clks && !IS_ERR(opp_table->clks[0])) {
> +		freq = clk_get_rate(opp_table->clks[0]);
>  		opp = _find_freq_ceil(opp_table, &freq);
>  	}
>  
> @@ -1070,7 +1109,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  						 scaling_down);
>  	} else {
>  		/* Only frequency scaling */
> -		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
> +		ret = _generic_set_opp_clks_only(dev, opp_table, opp);
>  	}
>  
>  	if (ret)
> @@ -1135,11 +1174,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)

This should have a BUG or WARN _ON() now if clock count is more than one. This
routine can't be called unless custom handler is available.

I skipped rest of the code as we need to work/decide on the design first.

Thanks.

-- 
viresh
