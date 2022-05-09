Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0351FA2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiEIKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiEIKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:47:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062452CFE8A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:42:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j6so25907907ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JivA9lag35NY9StRFNW9wke9LTJ6pmcL9zBt3wJOnU0=;
        b=ebaX/LiG6h3ghMGqzXvvTtDfpdIdzRUdMsxKFM94Yy8+E12Sr3DvvX192yCt7N9eaf
         Wo9pgDs/hq2TtDMw+I3gIbpC/iPByRUlD0nnpcj4K1aFZluap+o4rT1jKW+lRxQsY/lB
         YImjtFV5Y2N37SSLo40zlepq4inIK4viPucbc0ucPvd7yuhvC8VBxM/aIiJCdan0EQpi
         6z1b1qtItWLP5Qj6D5HtJCSXIcPHecK/zY6vkBDdaHTstIFF7DwctSp6Chp8sucFqYXG
         VMDK/pAURSFkWRz0RMVESZltCFl2iav0O54VA6a9Shnscry122w8SMGNoJAYQvVobcnx
         qpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JivA9lag35NY9StRFNW9wke9LTJ6pmcL9zBt3wJOnU0=;
        b=beAAxqAE8BBnpNZmqGcBdLPXmhJ7Vb4xR58EVWwFk3HU0kPJ6OJHzyNPDXsO9DQWEv
         knR2AlgFjbzR+VUB0HHUEIOostJzOm5uBebqWfDhfAwYharcrkCqVYHHbSCResX28J9r
         wrQ8nTCLJO4c0VaLy5B1JqIkN5cgJVaNZrOv00kCqLCl1SScWNe00372tG3F/2oYXM1Y
         wWC3UPgSmkWgDLjuphJyb3NonUGbQxpH/SwMmKrRxQqDrF32ELsYTtPfDlnnXIWlDW0M
         1UjvKnu5nkB/G5/OanS22WA0nVUjqsKTjmAPyDgQVR9RqBXAxkqUoab02Liry1WeYXLO
         s6ig==
X-Gm-Message-State: AOAM532t1+fzmrb3GMH1eZhFvPNYZ2YnRAaLBKQpzy9dOp3eQcaL5Jy1
        nJJM9aMoAtqC7jWpdeY6tGbMJA==
X-Google-Smtp-Source: ABdhPJyydy8/hiqqh2G8YhKauvC+LWx8dzSKJTUfCcLfOe3cv7c+z2fSoNuVxciYHs95+Iin63Zlig==
X-Received: by 2002:a17:906:559:b0:6f3:8ba6:39c8 with SMTP id k25-20020a170906055900b006f38ba639c8mr14043662eja.486.1652092684369;
        Mon, 09 May 2022 03:38:04 -0700 (PDT)
Received: from [192.168.0.243] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z12-20020a170906714c00b006f3ef214dfdsm4907874ejj.99.2022.05.09.03.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:38:03 -0700 (PDT)
Message-ID: <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
Date:   Mon, 9 May 2022 12:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 09:27, Viresh Kumar wrote:
> On 11-04-22, 17:43, Krzysztof Kozlowski wrote:
>> Devices might need to control several clocks when scaling the frequency
>> and voltage.  Example is the Universal Flash Storage (UFS) which scales
>> several independent clocks with change of performance levels.
>>
>> Add parsing of multiple clocks and clock names
> 
> This part is fine, the OPP core should be able to do this.

Sorry for late reply, I think I my filters archived it or I missed it.

> 
>> and scale all of them,
> 
> This is tricky as the OPP core can't really assume the order in which the clocks
> needs to be programmed. We had the same problem with multiple regulators and the
> same is left for drivers to do via the custom-api.
> 
> Either we can take the same route here, and let platforms add their own OPP
> drivers which can handle this, Or hide this all behind a basic device clock's
> driver, which you get with clk_get(dev, NULL).

For my use case, the order of scaling will be the same as in previous
implementation, because UFS drivers just got bunch of clocks with
freq-table-hz property and were scaling in DT order.

If drivers need something better, they can always provide custom-opp
thus replacing my method. My implementation here does not restrict them.

For the drivers where the order does not matter, why forcing each driver
to provide its own implementation of clock scaling? Isn't shared generic
PM OPP code a way to remove code duplication?

> 
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> 
>> +static int _generic_set_opp_clks_only(struct device *dev,
>> +				      struct opp_table *opp_table,
>> +				      struct dev_pm_opp *opp)
>> +{
>> +	int i, ret;
>> +
>> +	if (!opp_table->clks)
>> +		return 0;
>> +
>> +	for (i = 0; i < opp_table->clk_count; i++) {
>> +		if (opp->rates[i]) {
> 
> This should mean that we can disable that clock and it isn't required.

No, it does not mean that. The DT might provide several clocks which
only some are important for frequency scaling. All others just need to
be enabled.

Maybe you prefer to skip getting such clocks in PM OPP?

> 
>> +			ret = _generic_set_opp_clk_only(dev, opp_table->clks[i],
>> +							opp->rates[i]);
>> +			if (ret) {
>> +				dev_err(dev, "%s: failed to set clock %pC rate: %d\n",
>> +					__func__, opp_table->clks[i], ret);
>> +				return ret;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> As said earlier, this won't work in the core.
> 
>> +
>>  static int _generic_set_opp_regulator(struct opp_table *opp_table,
>>  				      struct device *dev,
>>  				      struct dev_pm_opp *opp,
>> @@ -796,7 +835,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
>>  	}
>>  
>>  	/* Change frequency */
>> -	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
>> +	ret = _generic_set_opp_clks_only(dev, opp_table, opp);
>>  	if (ret)
>>  		goto restore_voltage;
>>  
>> @@ -820,7 +859,7 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
>>  	return 0;
>>  
>>  restore_freq:
>> -	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_opp->rate))
>> +	if (_generic_set_opp_clks_only(dev, opp_table, old_opp))
>>  		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
>>  			__func__, old_opp->rate);
>>  restore_voltage:
>> @@ -880,7 +919,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
> 
> This is where we can handle it in your case, if you don't want to hide it behind
> a clk driver.
> 
>>  	}
>>  
>>  	data->regulators = opp_table->regulators;
>> -	data->clk = opp_table->clk;
>> +	data->clk = (opp_table->clks ? opp_table->clks[0] : NULL);
>>  	data->dev = dev;
>>  	data->old_opp.rate = old_opp->rate;
>>  	data->new_opp.rate = freq;
>> @@ -969,8 +1008,8 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
> 
> I think this routine breaks as soon as we add support for multiple clocks.
> clks[0]'s frequency can be same for multiple OPPs and this won't get you the
> right OPP then.

I don't think so and this was raised also by Stephen - only the first
clock is considered the one used for all PM OPP frequency operations,
like get ceil/floor.

The assumption (which might need better documentation) is that first
clock frequency is the main one:
1. It is still in opp->rate field, so it is used everywhere when OPPs
are compared/checked for rates.
1. Usually is used also in opp-table nodes names.

The logical explanation is that devices has some main operating
frequency, e.g. the core clock, and this determines the performance. In
the same time such device might not be able to scale this one core clock
independently from others, therefore this set of patches.

> 
>>  	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
>>  	unsigned long freq;
>>  
>> -	if (!IS_ERR(opp_table->clk)) {
>> -		freq = clk_get_rate(opp_table->clk);
>> +	if (opp_table->clks && !IS_ERR(opp_table->clks[0])) {
>> +		freq = clk_get_rate(opp_table->clks[0]);
>>  		opp = _find_freq_ceil(opp_table, &freq);
>>  	}
>>  
>> @@ -1070,7 +1109,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>>  						 scaling_down);
>>  	} else {
>>  		/* Only frequency scaling */
>> -		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
>> +		ret = _generic_set_opp_clks_only(dev, opp_table, opp);
>>  	}
>>  
>>  	if (ret)
>> @@ -1135,11 +1174,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> 
> This should have a BUG or WARN _ON() now if clock count is more than one. This
> routine can't be called unless custom handler is available.
> 
> I skipped rest of the code as we need to work/decide on the design first.



Best regards,
Krzysztof
