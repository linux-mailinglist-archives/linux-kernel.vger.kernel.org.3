Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B34AD643
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbiBHLXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355593AbiBHJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:47:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D56FAC03FEC1;
        Tue,  8 Feb 2022 01:47:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DBCC11D4;
        Tue,  8 Feb 2022 01:47:39 -0800 (PST)
Received: from [10.57.15.144] (unknown [10.57.15.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB873F718;
        Tue,  8 Feb 2022 01:47:35 -0800 (PST)
Subject: Re: [PATCH 0/2] Ignore Energy Model with abstract scale in IPA and
 DTPM
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <0d2217e0-44f7-8587-3e1f-a73d301ab166@linaro.org>
 <616307f7-b419-8e36-6879-6cf6f4e02d5a@arm.com>
 <f63be987-a1a5-cf7e-8302-4ae6e87b6699@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <eed90b35-4556-963d-f6c2-8c645896c158@arm.com>
Date:   Tue, 8 Feb 2022 09:47:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f63be987-a1a5-cf7e-8302-4ae6e87b6699@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/22 7:39 AM, Daniel Lezcano wrote:
> On 07/02/2022 12:44, Lukasz Luba wrote:
>>
>>
>> On 2/7/22 10:41 AM, Daniel Lezcano wrote:
>>> On 07/02/2022 08:30, Lukasz Luba wrote:
>>>> Hi all,
>>>>
>>>> The Energy Model supports abstract scale power values. This might cause
>>>> issues for some mechanisms like thermal governor IPA or DTPM, which
>>>> expect that all devices provide sane power values. This patch set 
>>>> prevents
>>>> from registering such devices for IPA and DTPM.
>>>
>>>
>>> Does it mean for example big and little have both 0-100 ?
>>>
>>>
>>
>> Unfortunately, these can be any numbers. I hope at least the CPUs
>> Big and Little power have sense: Little power is not higher
>> than Big power. The purpose of EM is to enable EAS, so this power
>> relation between Big and Little should have sense. Someone
>> who is not willing to or cannot expose real power values, still
>> wants the EAS to operate (my assumption and hope). The SCMI FW can
>> provide abstract power values. It's in the SCMI spec. Thus,
>> creating these abstract scale power values for big.LITTLE the right
>> way should result in properly working EAS.
>>
>> I can also have hope for GPU vs. Big power, but it is a weaker hope.
>> The second is more tricky to distinguish even if you have a domain
>> knowledge, but not the real measurements with you. The GPU power
>> values is also a 'sensitive' knowledge to share. Open source guys can do
>> that (after measurements), but some vendor's engineers probably can't.
> 
> So basically, we don't know, right ?

Well, we know - power is not in milli-Watts.
The PowerCap and DTPM have this sysfs contract of providing micro-Watts.
Don't we break this if we know for sure that the power values in EM
are not in milli-Watts?

> 
> At this point the different subsystems (cpufreq cooling device and dtpm) 
> disabled by these patches can deal with abstract scale values, like they 
> do today with the very approximate power numbers we have defined in the DT.
> 
> Let's wait and see how the different SoC vendors implement the SCMI spec.
> 

I'm not sure if that would be visible to us. The current path to feed
abstract power values from SCMI cpufreq already exists and is based
on protocol response. The DT is not involved in this configuration.
