Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5D511B52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiD0OCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiD0OCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:02:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C894457A7;
        Wed, 27 Apr 2022 06:58:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19431ED1;
        Wed, 27 Apr 2022 06:58:11 -0700 (PDT)
Received: from [10.57.7.196] (unknown [10.57.7.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E013F5A1;
        Wed, 27 Apr 2022 06:58:09 -0700 (PDT)
Message-ID: <a29bc181-0c06-c7de-4070-e5aa86cf7ffc@arm.com>
Date:   Wed, 27 Apr 2022 14:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v3 2/5] cpuidle: Add Cpufreq Active Stats calls
 tracking idle entry/exit
Content-Language: en-US
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406220809.22555-1-lukasz.luba@arm.com>
 <20220406220809.22555-3-lukasz.luba@arm.com>
 <97e7e3f5110702fab727b4df7d53511aef5c60b1.camel@gmail.com>
 <36852629-f803-5ac9-bef5-bcfae3ed947d@arm.com>
 <47cbbe94b061d8d7b7c222a42fa80b7b4cd4b7e5.camel@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <47cbbe94b061d8d7b7c222a42fa80b7b4cd4b7e5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/22 17:29, Artem Bityutskiy wrote:
> On Tue, 2022-04-26 at 16:01 +0100, Lukasz Luba wrote:
>>> I am worried about adding more stuff here.
>>>
>>> Please, consider getting the stats after interrupts are re-enabled. You may
>>> lose
>>> some "precision" because of that, but it is probably overall better that
>>> adding
>>> to idle interrupt latency.
>>
>> Definitely. I don't need such precision, so later when interrupts are
>> re-enabled is OK for me.
> 
> Thanks. That is preferable in general: we do not do things with interrupts
> disabled unless there is a very good reason to.
> 
>>
>> This new call might be empty for your x86 kernels, since probably
>> you set the CONFIG_CPU_FREQ_STAT.I can add additional config
>> so platforms might still have CONFIG_CPU_FREQ_STAT but avoid this
>> new feature and additional overhead in idle exit when e.g.
>> CONFIG_CPU_FREQ_ACTIVE_STAT is not set.
>>
>> The x86 platforms won't use IPA governor, so it's reasonable to
>> do this way.
>>
>> Does this sounds good?
> 
> I did not thoroughly read your patches so can't comment on the details.
> 
> Just pointing that in general idle path is to be considered the critical path,
> especially the part before interrupts are re-enabled. Not only on x86,
> but on all platforms using cpuidle. This does not mean we can't read more
> statistics there, but it does mean that we should be very careful about added
> overhead, keep it under control, etc.

I totally agree with you. I didn't know that the interrupts were not
enabled at that moment. I'll address it.

Regards,
Lukasz
