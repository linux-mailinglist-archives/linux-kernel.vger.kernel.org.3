Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422AF571C85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiGLO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiGLO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:28:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDCAC2AF3;
        Tue, 12 Jul 2022 07:28:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0B51596;
        Tue, 12 Jul 2022 07:28:37 -0700 (PDT)
Received: from [10.57.13.42] (unknown [10.57.13.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C6E13F73D;
        Tue, 12 Jul 2022 07:28:35 -0700 (PDT)
Message-ID: <4ee2e1fb-89e4-698c-525a-71a4423a245b@arm.com>
Date:   Tue, 12 Jul 2022 15:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] thermal/core: Fix thermal trip cross point
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
 <20220708183210.1334839-3-daniel.lezcano@linaro.org>
 <6ce87fbb-1460-503b-f1f1-8cf53e702cdf@arm.com>
 <2d680cd9-9e97-e06c-55c2-2a3a1504488e@linaro.org>
 <5d513646-a917-b969-b2d2-9d5f4e0e6f4d@arm.com>
 <af074493-d342-9439-8d78-c07c5df82203@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <af074493-d342-9439-8d78-c07c5df82203@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 14:06, Daniel Lezcano wrote:
> On 12/07/2022 14:40, Lukasz Luba wrote:
>>
>>
>> On 7/12/22 13:30, Daniel Lezcano wrote:
>>> On 12/07/2022 13:29, Lukasz Luba wrote:
>>>
>>> [ ... ]
>>>
>>>>> @@ -511,8 +528,13 @@ void thermal_zone_device_update(struct 
>>>>> thermal_zone_device *tz,
>>>>>       tz->notify_event = event;
>>>>> -    for (count = 0; count < tz->trips; count++)
>>>>> -        handle_thermal_trip(tz, count);
>>>>> +    if (tz->last_temperature <= tz->temperature) {
>>>>> +        for (count = 0; count < tz->trips; count++)
>>>>> +            handle_thermal_trip(tz, count);
>>>>> +    } else {
>>>>> +        for (count = tz->prev_trip; count >= 0; count--)
>>>>> +            handle_thermal_trip(tz, count);
>>>>> +    }
>>>>
>>>> In general the code look good. I have one question, though:
>>>> Is it always true that these trip points coming from the DT
>>>> and parsed in thermal_of_build_thermal_zone() populated by
>>>>      for_each_child_of_node(child, gchild) {
>>>>           thermal_of_populate_trip(gchild, &tz->trips[i++]);
>>>>
>>>> are always defined in right order in DT?
>>>
>>> Hmm, that is a good question. Even if the convention is to put the 
>>> trip point in the ascending order, I don't find any documentation 
>>> telling it is mandatory. Given that I don't feel particularly 
>>> comfortable to assume that is the case.
>>>
>>> Perhaps, it would make more sense to build a map of indexes telling 
>>> the order in the trip points and work with it instead.
>>>
>>>
>>
>> Sounds a reliable way to move forward. Maybe you could just sort in the
>> right order those trip points in the thermal_of_build_thermal_zone()
>> in an additional patch to this series?
>> Than this patch could stay as is, because it looks go
> 
> Unfortunately, there is the manual setup as well as the ACPI.
> 
> 
> 

I see. OK, so continue to solve it completely. I can review your next
version.

Regards,
Lukasz
