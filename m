Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96955ACE29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiIEIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiIEIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:45:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D79EB874;
        Mon,  5 Sep 2022 01:45:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A44CED1;
        Mon,  5 Sep 2022 01:45:44 -0700 (PDT)
Received: from [10.57.17.6] (unknown [10.57.17.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93A73F534;
        Mon,  5 Sep 2022 01:45:34 -0700 (PDT)
Message-ID: <31b205ad-6ce9-df41-85fc-d8fee8e26f20@arm.com>
Date:   Mon, 5 Sep 2022 09:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] powercap: arm_scmi: Add SCMI Powercap based driver
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20220817105424.3124006-1-cristian.marussi@arm.com>
 <20220817105424.3124006-2-cristian.marussi@arm.com>
 <9ee42d60-1bdd-c1e8-ec6e-38d0e1fcf4d8@arm.com> <YxTHQ9PRU8spf5x2@e120937-lin>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <YxTHQ9PRU8spf5x2@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/22 16:41, Cristian Marussi wrote:
> On Tue, Aug 30, 2022 at 02:16:42PM +0100, Lukasz Luba wrote:
>> Hi Cristian,
>>
> 
> Hi Lukasz,
> 

[snip]

>>> +static int scmi_powercap_get_max_power_range_uw(struct powercap_zone *pz,
>>> +						u64 *max_power_range_uw)
>>> +{
>>> +	*max_power_range_uw = U32_MAX;
>>
>> Shouldn't be calculated based on pai info from the platform FW?
>> e.g.
>> *max_power_range_uw = spz->info->max_power_cap - spz->info->min_power_cap
>>
>> (but with uW conversion in mind if needed)
>>
> 
> I double checked this and in include/linux/powercap.h these
> powercap_zone_ops are defined as:
> 
>   * @get_max_power_range_uw:	Get maximum range of power counter in
>   *				micro-watts.
>   * @get_power_uw:		Get current power counter in micro-watts.
> 
> so these are really data related to average power consumed, i.e. in SCMI
> parlance, info counters I can retrieve for a powercapping domain with
> POWERCAP_MEASUREMENTS_GET, which returns a uint32 representing the
> "average power consumption of the powercapping domain in the last PAI"
> 
> It seemed to me that this was unrelated to min/max powercap but more
> something used to report actual powercap domain consumption, so I use
> UINT32_MAX to represent the max range...on the other side in Linux these
> powercap ops may seem more to expect to report a sort of progressive
> accumulated comsuption value while I can only expose the average consumption
> as calculated and reported by fw across the last PAI. (SCMI 4.10.3.10)
> 
> Looking again at this, I'm not sure really if this is ok for the powercap
> Linux framework or should I instead try to keep a running accumulated value
> inside this driver (built from the values I get from
> POWERCAP_MEASUREMENTS_GET) and expose that....
> 
> ... so thanks for pointing this out because it triggered more doubts :D
> ...any hint about this welcome.

I recalled this code in DTPM [1]. Although, I have checked the
documentation of Powercap sysfs for this file [2]. This 'range'
for power (or energy) describes the values for related: 'power_uw'
or 'energy_uj'. Which means the 'power_uw' value can be actually
lower that setting in 'min_power_cap' (e.g. due to lightly loaded CPU).
I'm not sure for the upper bound: 'max_power_cap'. In real world
we can get a power spike which is bigger than that, so probably
your original U32_MAX is OK.

Therefore, probably the DTPM [1] could be adjusted not your aproach.


[snip]

>>> +	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
>>> +		/*
>>> +		 * Powercap domains are validate by the protocol layer, i.e.
>>> +		 * when only non-NULL domains are returned here, whose
>>> +		 * parent_id is assured to point to another valid domain.
>>> +		 */
>>> +		spz->info = powercap_ops->info_get(ph, i);
>>> +
>>> +		spz->dev = dev;
>>> +		spz->ph = ph;
>>> +		spz->spzones = pr->spzones;
>>> +		INIT_LIST_HEAD(&spz->node);
>>> +		INIT_LIST_HEAD(&pr->registered_zones[i]);
>>> +
>>> +		/*
>>> +		 * Forcibly skip powercap domains using an abstract scale.
>>> +		 * Note that only leaves domains can be skipped, so this could
>>> +		 * lead later to a global failure.
>>> +		 */
>>> +		if (!spz->info->powercap_scale_uw &&
>>> +		    !spz->info->powercap_scale_mw) {
>>> +			dev_warn(dev,
>>> +				 "Abstract power scale not supported. Skip %s.\n",
>>> +				 spz->info->name);
>>> +			spz->info = NULL;
>>> +			continue;
>>> +		}
>>
>> We can say that the power scale should be consistent in
>> a platform. Then we can bail out when abstract scale has
>> been found. This could also simplify code by a bit.
>>
> 
> I do NOT agree on this since I do NOT think from the SCMI spec we can
> assume this semplification: Linux powercap has indeed this limitation on
> scales BUT other non-Linux agents could indeed support abstract scales and
> the SCMI server could advertise a well built hierarchy of powercap domains
> including some abstract scale ones tha, if placed as leaves of the hierarchy,
> could be ignored by Linux but used instead by other agents...or in the future
> used by Linux too ?

This diversity makes me a headache ;) I would hope the SCMI spec would
restrict the span of variety. Although, I cannot find in the spec that
all powercap domains must use the same power scale...

It looks like, you will have to implement it this way.

> 
> I'll double check with Archs since I had already an internal exchange on
> this and seemed to me that the current approach (of only bailing out when
> non-leaves abstract scale domains are found) was fine, i.e. that I could
> not just assume to receive only uw/mv scale domains.
> 
>> Can we also validate here some those lines, which are
>> checked in many callback funcitons?
>>
> 
> Partially yes....see below...
> 
>> These are the lines, which could be then removed if we bail
>> out here earlier:
>> 	if (!spz->info)
>> 		return -ENODEV;
> 
> I can remove this surely from everywhere since I really never register a
> zone with NULL spx->info, this check all-around, my bad, is redundant.
> 
>> 	if (!spz->info->powercap_pai_config)
>> 		return -EINVAL;
>> 	if (!spz->info->powercap_monitoring)
>> 		return -EINVAL;
>>
> 
> Instead I cannot see why a powercap domain missing this capabilities
> (PAI configuration and power consumption monitoring) should be
> excluded as a whole...for this reason (if valid from the scale
> perspective as said above) I currently register these powercap SCMI
> zones even if lacking these supports and then return -EINVAL only for
> the related Powercap unsupported callbacks...while still supporting as
> an example setting min/max powercaps.

It's a bit more complicated than I thought. We cannot simplify too much
and make weak assumption. You're right, please keep your approach.



[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/powercap/dtpm.c#L54
[2] 
https://elixir.bootlin.com/linux/latest/source/Documentation/power/powercap/powercap.rst#L206
