Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5584FE69F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbiDLRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiDLRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:15:39 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB660CC1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:13:20 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e2442907a1so21070401fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TDPbcSp/vDTixVI6qzYrMBMUYnORkP5HblVB6RjbSwM=;
        b=r0SjzZOBYNqLp6nRCKLDf8cy3mSN1YDPUqcvXb/qYRZMDOcLrLiyzOd25flwgCl3Jz
         w+ewN48LvT8QrAYQTcAryJzLLdsDU4VhEk0xa+xeqn4tA5olHz/Irmqw6wowx5d49PGp
         uLytBhUEF2EyN4b364eb7jvp6zxqPxlFzEetCZC8+fwnbq3HIstDQApbRZ8rBKCOGt2D
         AuojgPgEZFXxHxJOhm6q0Lhs+UjmEyUwtVm8ixwgB0uetUPgwpybq3i/ZOWZn76lWkfN
         rkBwMDsEbVWE7wpGisL/Dzg3Si+usBnvAupPSrjmglLn9Uz4kkNOKLtazFTjhBQ+R07l
         u68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDPbcSp/vDTixVI6qzYrMBMUYnORkP5HblVB6RjbSwM=;
        b=23KuCSpfA9rWeo7bcZAnukEpkd4FVUHvdMueNB4YBYsTgViwWbrGe5YdfIuq0zOIyQ
         537C3JCrF/rFmIfxsB0/2YFW3QY76P9dIJKw1/QpxHXuUIJX1UgML3evXAk/yv8BewGo
         X4Ui1BezbkHU/n5Cg0VnGiXEph/HYgGu5SfCNKqyORWllKMMfncve4dY7ikW4GhP6Frw
         Y4ykhgt0jrJwBdAfak2DQcNE5idr5hlsf/5VSIDDfj0DDFhJVxiSDFvcbyoQgXSCO4zV
         7Jvd7oIs51VVpXVrn+/p4aeLzYq9j2p3XEg/tGv1O/0LL4LE1vJzi4JWLJKg7JM3CKWV
         MZ6Q==
X-Gm-Message-State: AOAM531rcxLFbge5X1K0vdzpAUI1Zz3oxgxe4FMGni11voQ52jmqTp5e
        tYIT2Wib+uP9rVy4ShtUWdgx1w==
X-Google-Smtp-Source: ABdhPJwpxs1FgqJej6N6Ii8DouynWEV8uS72s+flB0CU1W3DfVPueaybQVWOAV+BCWqU0iB/5DfddA==
X-Received: by 2002:a05:6870:738a:b0:de:e1b7:2371 with SMTP id z10-20020a056870738a00b000dee1b72371mr2586315oam.176.1649783599875;
        Tue, 12 Apr 2022 10:13:19 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id c30-20020a056830349e00b005b272587f47sm13824595otu.38.2022.04.12.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:13:19 -0700 (PDT)
Date:   Tue, 12 Apr 2022 10:15:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
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
Message-ID: <YlWztZknl4OBmekp@ripper>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Apr 08:43 PDT 2022, Krzysztof Kozlowski wrote:

> Devices might need to control several clocks when scaling the frequency
> and voltage.  Example is the Universal Flash Storage (UFS) which scales
> several independent clocks with change of performance levels.
> 
> Add parsing of multiple clocks and clock names and scale all of them,
> when needed.  If only one clock is provided, the code should behave the
> same as before.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/opp/core.c     | 205 ++++++++++++++++++++++++++++++++---------
>  drivers/opp/of.c       |  48 ++++++++++
>  drivers/opp/opp.h      |   9 +-
>  include/linux/pm_opp.h |  23 +++++
>  4 files changed, 242 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
[..]
> @@ -1295,21 +1344,32 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>  	 * Return early if we don't need to get clk or we have already tried it
>  	 * earlier.
>  	 */
> -	if (!getclk || IS_ERR(opp_table) || opp_table->clk)
> +	if (!getclk || IS_ERR(opp_table) || opp_table->clks)
>  		return opp_table;
>  
> +	opp_table->clks = kmalloc_array(1, sizeof(*opp_table->clks),
> +					GFP_KERNEL);

This seems to be 81 chars long, perhaps worth not line breaking?

> +	if (!opp_table->clks)
> +		return ERR_PTR(-ENOMEM);
> +
>  	/* Find clk for the device */
> -	opp_table->clk = clk_get(dev, NULL);
> +	opp_table->clks[0] = clk_get(dev, NULL);
>  
> -	ret = PTR_ERR_OR_ZERO(opp_table->clk);
> -	if (!ret)
> +	ret = PTR_ERR_OR_ZERO(opp_table->clks[0]);
> +	if (!ret) {
> +		opp_table->clk_count = 1;
>  		return opp_table;
> +	}
[..]
> +struct opp_table *dev_pm_opp_set_clknames(struct device *dev,
> +					  const char * const names[],
> +					  unsigned int count)
>  {
>  	struct opp_table *opp_table;
> -	int ret;
> +	struct clk *clk;
> +	int ret, i;
>  
>  	opp_table = _add_opp_table(dev, false);
>  	if (IS_ERR(opp_table))
> @@ -2159,70 +2259,92 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
>  	}
>  
>  	/* clk shouldn't be initialized at this point */
> -	if (WARN_ON(opp_table->clk)) {
> +	if (WARN_ON(opp_table->clks)) {
>  		ret = -EBUSY;
>  		goto err;
>  	}
>  
> -	/* Find clk for the device */
> -	opp_table->clk = clk_get(dev, name);
> -	if (IS_ERR(opp_table->clk)) {
> -		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
> -				    "%s: Couldn't find clock\n", __func__);
> +	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
> +					GFP_KERNEL);
> +	if (!opp_table->clks) {
> +		ret = -ENOMEM;
>  		goto err;
>  	}
>  
> +	for (i = 0; i < count; i++) {
> +		clk = clk_get(dev, names[i]);
> +		if (IS_ERR(clk)) {
> +			ret =  dev_err_probe(dev, PTR_ERR(clk),
> +					     "%s: Couldn't find clock %s\n",
> +					     __func__, names[i]);
> +			goto free_clks;
> +		}
> +
> +		opp_table->clks[i] = clk;
> +	}

Wouldn't it be convenient to make clks a struct clk_bulk_data array
and use clk_bulk_get()/clk_bulk_put() instead?

> +
> +	opp_table->clk_count = count;
> +
>  	return opp_table;
>  
> +free_clks:
> +	while (i != 0)
> +		clk_put(opp_table->clks[--i]);
> +
> +	kfree(opp_table->clks);
> +	opp_table->clks = NULL;
> +	opp_table->clk_count = -1;
>  err:
>  	dev_pm_opp_put_opp_table(opp_table);
>  
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_clknames);
[..]
> +static int _read_clocks(struct dev_pm_opp *opp, struct opp_table *opp_table,
> +			struct device_node *np)
> +{
> +	int count, ret;
> +	u64 *freq;
> +
> +	count = of_property_count_u64_elems(np, "opp-hz");
> +	if (count < 0) {
> +		pr_err("%s: Invalid %s property (%d)\n",
> +			__func__, of_node_full_name(np), count);

Wouldn't %pOF be convenient to use here, seems like it becomes short
enough that you don't have to wrap this line then.

> +		return count;
> +	}
> +
> +	if (count != opp_table->clk_count) {
> +		pr_err("%s: number of rates %d does not match number of clocks %d in %s\n",
> +		       __func__, count, opp_table->clk_count,
> +		       of_node_full_name(np));
> +		return -EINVAL;
> +	}
> +
> +	freq = kmalloc_array(count, sizeof(*freq), GFP_KERNEL);
> +	if (!freq)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u64_array(np, "opp-hz", freq, count);
> +	if (ret) {
> +		pr_err("%s: error parsing %s: %d\n", __func__,
> +		       of_node_full_name(np), ret);
> +		ret = -EINVAL;
> +		goto free_freq;
> +	}

Regards,
Bjorn
