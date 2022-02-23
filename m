Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB94C0EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiBWJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiBWJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:11:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E47C80228;
        Wed, 23 Feb 2022 01:10:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF001042;
        Wed, 23 Feb 2022 01:10:38 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E59CC3F5A1;
        Wed, 23 Feb 2022 01:10:36 -0800 (PST)
Message-ID: <b13ece66-a1c0-439f-efaa-689ddfa530db@arm.com>
Date:   Wed, 23 Feb 2022 09:10:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <4e090ffe-c19b-8e2c-0396-72dc33361f35@arm.com>
 <211a3606-2f4c-227b-33aa-177ef68a49a3@arm.com>
 <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
 <27df4e4f-b6d7-9a58-f2dd-d6afa748e217@arm.com>
 <a5730ce7-a24c-0738-e76f-e06d56601408@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <a5730ce7-a24c-0738-e76f-e06d56601408@linaro.org>
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



On 2/22/22 22:10, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 22/02/2022 19:31, Lukasz Luba wrote:
>>
>>
>> On 2/22/22 18:12, Daniel Lezcano wrote:
>>>
>>> Hi Lukasz,
>>>
>>> I don't think it makes sense to remove the support of the energy 
>>> model if the units are abstracts.
>>>
>>> IIUC, regarding your previous answer, we don't really know what will 
>>> do the SoC vendor with these numbers and likely they will provide 
>>> consistent abstract values which won't prevent a correct behavior.
>>>
>>> What would be the benefit of giving inconsistent abstract values 
>>> which will be unusable except of giving a broken energy model?
>>
>> The power values in the EM which has abstract scale, would make sense 
>> to EAS, but not for IPA or DTPM. Those platforms which want to enable 
>> EAS,
>> but don't need IPA, would register such '<a_good_name_here>' EM.
> 
> Sorry, but I don't understand why DTPM can not deal with abstract values?

They will be totally meaningless/bogus.

> 
> 
>>> Your proposed changes would be acceptable if the energy model has a 
>>> broken flag IMO
>>
>> That is doable. I can add that flag, so we can call it 'artificial' EM
>> (when this new flag is set).
> 
> It is too soon IMO, I would like to see the numbers first so we can take 
> an enlighten decision. Right now, it is unclear what the numbers will be.

We are going to add new support from our roadmap for platforms which
don't have this power information but are going to use EAS.

I'm going to send some patches soon which create that support. Pierre
is going to send the platform code. I want to make sure that this
platform won't register power actors for IPA. Other thermal governors
will work, since they don't use EM for making a decision.
