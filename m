Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C864BA044
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiBQMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:37:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiBQMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:37:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEDFBA8EE0;
        Thu, 17 Feb 2022 04:37:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A4AF113E;
        Thu, 17 Feb 2022 04:37:17 -0800 (PST)
Received: from [10.57.17.240] (unknown [10.57.17.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6706D3F66F;
        Thu, 17 Feb 2022 04:37:13 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com> <YgQ9XLcto9v0fyTf@google.com>
 <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
 <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org>
 <5b8ca53e-3595-85fd-5ae9-a5e8285e8513@arm.com>
 <53bc13ca-998f-ff83-d9f7-9a83d35b24fd@linaro.org>
 <97ecc29b-13a9-fa15-4e88-21c8612ebb7f@arm.com>
 <1812eadf-7924-5abd-857b-22b7dfdf8f7d@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <33bd6122-b4aa-1659-6063-95175a8748b3@arm.com>
Date:   Thu, 17 Feb 2022 12:37:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1812eadf-7924-5abd-857b-22b7dfdf8f7d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/22 12:33 PM, Daniel Lezcano wrote:
> On 17/02/2022 13:11, Lukasz Luba wrote:
> 
> [ ... ]
> 
>>> Why not make it more generic and replace the frequency by a 
>>> performance index, so it can be used by any kind of perf limiter?
>>
>> For that DT array, yes, it can be an index, so effectively it could be
>> a simple 1d array.
>>
>> something like:
>>
>> msm_gpu_energy_model: msm-gpu-energy-model {
>>      compatible = "energy-model"
>>      /* Values are sorted micro-Watts which correspond to each OPP
>>         or performance state. The total amount of them must match
>>         number of OPPs. */
>>      power-microwatt = <100000>,
>>              <230000>,
>>              <380000>,
>>              <600000>;
>> };
>>
>> then in gpu node instead of having 'dynamic-power-coefficient',
>> which is useless because voltage is missing, we would have
>> 'energy-model', like:
>>
>>      energy-model = <&msm_gpu_energy_model>;
>>
>>
>> If you agree to continue this topic. I will send an RFC so we could
>> further discuss this idea. This $subject doesn't fit well.
> 
> Yes, definitively I agree to continue on this topic.
> 
> 

Great! I'm going to craft something...
