Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B24C285A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiBXJo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiBXJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:44:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA0A627DF19;
        Thu, 24 Feb 2022 01:43:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9574AED1;
        Thu, 24 Feb 2022 01:43:55 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A57C23F70D;
        Thu, 24 Feb 2022 01:43:53 -0800 (PST)
Message-ID: <eb49beb7-584d-152d-0c61-bad66056505c@arm.com>
Date:   Thu, 24 Feb 2022 09:43:52 +0000
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
 <9c8f15a3-563f-3bed-61a4-2f72b0c20e89@arm.com>
 <20220224094216.mtxjjx65bbjzalqx@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224094216.mtxjjx65bbjzalqx@vireshk-i7>
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



On 2/24/22 09:42, Viresh Kumar wrote:
> On 24-02-22, 09:33, Lukasz Luba wrote:
>> On 2/24/22 09:13, Viresh Kumar wrote:
>>> On 24-02-22, 08:11, Lukasz Luba wrote:
>>>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> 
>>>> +static bool _of_has_opp_microwatt_property(struct device *dev)
>>>> +{
>>>> +	unsigned long power, freq = 0;
>>>> +	struct dev_pm_opp *opp;
>>>> +
>>>> +	/* Check if at least one OPP has needed property */
>>>> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>>>> +	if (IS_ERR(opp))
>>>> +		return false;
>>>> +
>>>> +	power = dev_pm_opp_get_power(opp);
>>>> +	dev_pm_opp_put(opp);
>>>> +	if (!power)
>>>
>>> Instead of this heavy stuff, just pick the first OPP from the opp
>>> table and see its power-value.
>>
>> It is the first opp: freq=0.
>> You mean by parsing the the DT node instead, like I had in v2 version?
> 
> No, I was thinking if you can simply do:
> 
> opp = list_first_entry(&opp_table->opp_list, struct dev_pm_opp, node);
> 
> But that requires locking, etc as well. So maybe this is fine.
>   

OK, so I'll leave it as is now.

Thank you for the comments. I'll work on v4
