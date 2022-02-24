Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924F84C2823
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiBXJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBXJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8633C26A3AC;
        Thu, 24 Feb 2022 01:33:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52667ED1;
        Thu, 24 Feb 2022 01:33:21 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7F13F70D;
        Thu, 24 Feb 2022 01:33:19 -0800 (PST)
Message-ID: <9c8f15a3-563f-3bed-61a4-2f72b0c20e89@arm.com>
Date:   Thu, 24 Feb 2022 09:33:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-4-lukasz.luba@arm.com>
 <20220224091346.xmnpj27vllpa4cuy@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224091346.xmnpj27vllpa4cuy@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 09:13, Viresh Kumar wrote:
> On 24-02-22, 08:11, Lukasz Luba wrote:
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>>   
>> +/*
>> + * Callback function provided to the Energy Model framework upon registration.
>> + * It provides the power used by @dev at @kHz if it is the frequency of an
>> + * existing OPP, or at the frequency of the first OPP above @kHz otherwise
>> + * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
>> + * frequency and @mW to the associated power.
>> + *
>> + * Returns 0 on success or a proper -EINVAL value in case of error.
>> + */
>> +static int __maybe_unused
>> +_get_opp_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
> 
> Lets call it _get_dt_opp_power() or _get_dt_power() ?

OK, I'll return to _get_dt_power()

> 
>> +{
>> +	struct dev_pm_opp *opp;
>> +	unsigned long opp_freq, opp_power;
>> +
>> +	/* Find the right frequency and related OPP */
>> +	opp_freq = *kHz * 1000;
>> +	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
>> +	if (IS_ERR(opp))
>> +		return -EINVAL;
>> +
>> +	opp_power = dev_pm_opp_get_power(opp);
> 
> As I said in 2/4, this should really give the total instead.

make sense

> 
>> +	dev_pm_opp_put(opp);
>> +	if (!opp_power)
>> +		return -EINVAL;
>> +
>> +	*kHz = opp_freq / 1000;
>> +	*mW = opp_power / 1000;
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Callback function provided to the Energy Model framework upon registration.
>>    * This computes the power estimated by @dev at @kHz if it is the frequency
>> @@ -1488,6 +1520,24 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
>>   	return 0;
>>   }
>>   
>> +static bool _of_has_opp_microwatt_property(struct device *dev)
>> +{
>> +	unsigned long power, freq = 0;
>> +	struct dev_pm_opp *opp;
>> +
>> +	/* Check if at least one OPP has needed property */
>> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>> +	if (IS_ERR(opp))
>> +		return false;
>> +
>> +	power = dev_pm_opp_get_power(opp);
>> +	dev_pm_opp_put(opp);
>> +	if (!power)
> 
> What if this particular frequency has 0 power mentioned for some
> reason :)

If that power 0 would be allowed here, then in next step when EM
calls active_power() we check !power and report dev_err().
IPA design would also not accept the power=0

> 
> Instead of this heavy stuff, just pick the first OPP from the opp
> table and see its power-value.

It is the first opp: freq=0.
You mean by parsing the the DT node instead, like I had in v2 version?

> 
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   /**
>>    * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
>>    * @dev		: Device for which an Energy Model has to be registered
>> @@ -1517,6 +1567,14 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>>   		goto failed;
>>   	}
>>   
>> +	/* First, try to find more precised Energy Model in DT */
>> +	if (_of_has_opp_microwatt_property(dev)) {
>> +		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_opp_power);
>> +
>> +		return em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb,
>> +						   cpus, true);
>> +	}
>> +
> 
> We have another em_dev_register_perf_domain() down the line, lets keep
> only one such call and get it a callback that should be set in an
> if/else loop.

OK
