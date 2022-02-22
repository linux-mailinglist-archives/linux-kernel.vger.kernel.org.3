Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8766B4BFC58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiBVPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiBVPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:22:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B7585AEF3;
        Tue, 22 Feb 2022 07:21:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E21CED1;
        Tue, 22 Feb 2022 07:21:36 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6C23F5A1;
        Tue, 22 Feb 2022 07:21:33 -0800 (PST)
Message-ID: <9cfe84b0-01bf-6e20-9839-5f597e7fa588@arm.com>
Date:   Tue, 22 Feb 2022 15:21:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com> <YhT6EBzSE/7S3QqT@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <YhT6EBzSE/7S3QqT@google.com>
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

Hi Matthias,

On 2/22/22 14:58, Matthias Kaehlcke wrote:
> On Tue, Feb 22, 2022 at 02:07:46PM +0000, Lukasz Luba wrote:

[snip]

>> +static int __maybe_unused
>> +_get_dt_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
> 
> nit: the device is usually the first parameter. It's also the only true input
> parameter of this function, most code puts input parameters first.

Good point. I have internal patch set under review changing this. It's
going to be changed and the 'dev' would be the 1st arg. I'll send this
patch set as soon as this one gets queued into pm tree.

> 
>> +{
>> +	struct dev_pm_opp *opp;
>> +	unsigned long opp_freq;
>> +	u32 opp_power;
>> +	int ret;
>> +
>> +	/* Find the right frequency and related OPP */
>> +	opp_freq = *kHz * 1000;
>> +	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
>> +	if (IS_ERR(opp))
>> +		return -EINVAL;
>> +
>> +	ret = of_property_read_u32(opp->np, "opp-microwatt", &opp_power);
>> +	dev_pm_opp_put(opp);
>> +	if (ret)
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
>> @@ -1445,6 +1479,33 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
>>   	return 0;
>>   }
>>   
>> +static int _of_find_opp_microwatt_property(struct device *dev)
> 
> this function doesn't retrurn the property like of_find_property() does,
> _of_has_opp_microwatt_property() would be a be a better name IMO. I'd
> also suggest to change the return type to bool, since callers don't
> really care about the specific error (which with the current code is
> -EINVAL) in all cases.

Agree, I'll change the name and return type.

> 
> 
>> +{
>> +	unsigned long freq = 0;
> 
> Does the compiler complain when the initialization is skipped? The
> value of the variable is never read, only it's address is passed to
> dev_pm_opp_find_freq_ceil().

It has to be 0, since under the hood the dev_pm_opp_find_freq_ceil()
is going to find first freq which is equal or bigger than this one.
We actually use that ptr value in the _find_freq_ceil().

> 
>> +	struct dev_pm_opp *opp;
>> +	struct device_node *np;
>> +	struct property *prop;
>> +
>> +	/* We only support "operating-points-v2" */
>> +	np = dev_pm_opp_of_get_opp_desc_node(dev);
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	of_node_put(np);
>> +
>> +	/* Check if an OPP has needed property */
> 
> The comment doesn't add much value IMO

Well, it just stress the 'an' as in this case it's the 1st OPP,
due to the fact freq = 0 and finding the 'ceiling' on it.
I'll remove it.

> 
>> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>> +	if (IS_ERR(opp))
>> +		return -EINVAL;
>> +
>> +	prop = of_find_property(opp->np, "opp-microwatt", NULL);
>> +	dev_pm_opp_put(opp);
>> +	if (!prop)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
>>    * @dev		: Device for which an Energy Model has to be registered
>> @@ -1474,6 +1535,15 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>>   		goto failed;
>>   	}
>>   
>> +	/* First, try to find more precised Energy Model in DT */
>> +	if (!_of_find_opp_microwatt_property(dev)) {
>> +		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_dt_power);
>> +
>> +		ret = em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb,
>> +						  cpus, true);
>> +		return ret;
> 
> just 'return em_dev_register_perf_domain(...);'?

true

Thanks for the review! I'll address these comments in v3 if Viresh
agrees with this new approach.

Regards,
Lukasz
