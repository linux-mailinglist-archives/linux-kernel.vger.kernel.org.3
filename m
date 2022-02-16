Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316414B8C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiBPPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:35:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiBPPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:35:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85B9A2838E3;
        Wed, 16 Feb 2022 07:35:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E25FD6E;
        Wed, 16 Feb 2022 07:35:44 -0800 (PST)
Received: from [10.57.13.141] (unknown [10.57.13.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDF8F3F70D;
        Wed, 16 Feb 2022 07:35:41 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com> <YgQ9XLcto9v0fyTf@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
Date:   Wed, 16 Feb 2022 15:35:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgQ9XLcto9v0fyTf@google.com>
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

Hi Matthias,

On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
> On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
>>
>>
>> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
>>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
>>>>
>>>>

[snip]

>>>> Could you point me to those devices please?
>>>
>>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
>>>
>>> Though as per above they shouldn't be impacted by your change, since the
>>> CPUs always pretend to use milli-Watts.
>>>
>>> [skipped some questions/answers since sc7180 isn't actually impacted by
>>>    the change]
>>
>> Thank you Matthias. I will investigate your setup to get better
>> understanding.
> 
> Thanks!
> 

I've checked those DT files and related code.
As you already said, this patch is safe for them.
So we can apply it IMO.


-------------Off-topic------------------
Not in $subject comments:

AFAICS based on two files which define thermal zones:
sc7180-trogdor-homestar.dtsi
sc7180-trogdor-coachz.dtsi

only the 'big' cores are used as cooling devices in the
'skin_temp_thermal' - the CPU6 and CPU7.

I assume you don't want to model at all the power usage
from the Little cluster (which is quite big: 6 CPUs), do you?
I can see that the Little CPUs have small dyn-power-coeff
~30% of the big and lower max freq, but still might be worth
to add them to IPA. You might give them more 'weight', to
make sure they receive more power during power split.

You also don't have GPU cooling device in that thermal zone.
Based on my experience if your GPU is a power hungry one,
e.g. 2-4Watts, you might get better results when you model
this 'hot' device (which impacts your temp sensor reported value).

Regards,
Lukasz

