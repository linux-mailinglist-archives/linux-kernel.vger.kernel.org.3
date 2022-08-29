Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED75A461D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiH2Jbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiH2Jbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:31:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7673C5B051;
        Mon, 29 Aug 2022 02:31:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1249723A;
        Mon, 29 Aug 2022 02:31:47 -0700 (PDT)
Received: from [10.57.14.18] (unknown [10.57.14.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290933F766;
        Mon, 29 Aug 2022 02:31:40 -0700 (PDT)
Message-ID: <0a029776-6052-b034-9431-fc180fb2e502@arm.com>
Date:   Mon, 29 Aug 2022 10:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] cpufreq: check only freq_table in __resolve_freq()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220816120157.24455-1-lukasz.luba@arm.com>
 <CAJZ5v0jQpEL7SMjj83fbm-Afz7D7Wj41g5AFa2-8zoeehnRppg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jQpEL7SMjj83fbm-Afz7D7Wj41g5AFa2-8zoeehnRppg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/22 19:02, Rafael J. Wysocki wrote:
> On Tue, Aug 16, 2022 at 2:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> There is no need to check if the cpufreq driver implements callback
>> cpufreq_driver::target_index. The logic in the __resolve_freq uses
>> the frequency table available in the policy. It doesn't matter if the
>> driver provides 'target_index' or 'target' callback. It just has to
>> populate the 'policy->freq_table'.
>>
>> Thus, check only frequency table during the frequency resolving call.
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> Changes:
>> v2:
>> - collected ACK from Viresh
>> - corrected patch description (Viresh)
>>
>>
>>   drivers/cpufreq/cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 7820c4e74289..69b3d61852ac 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>
>>          target_freq = clamp_val(target_freq, policy->min, policy->max);
>>
>> -       if (!cpufreq_driver->target_index)
>> +       if (!policy->freq_table)
>>                  return target_freq;
>>
>>          idx = cpufreq_frequency_table_target(policy, target_freq, relation);
>> --
> 
> Applied as 6.0-rc material, thanks!

Thanks Rafael!
