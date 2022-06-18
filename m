Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB9550406
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiFRKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 06:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFRKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 06:32:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEA021248;
        Sat, 18 Jun 2022 03:32:32 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LQBwP4pS9zBrJs;
        Sat, 18 Jun 2022 18:29:09 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 18:32:30 +0800
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 18:32:29 +0800
Subject: Re: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220521063534.138930-1-yiyang13@huawei.com>
 <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
 <CAJZ5v0jCx0v-Q2=aW4nSSAHHajUnLdVtQMe3w1cX1w-o=mSesg@mail.gmail.com>
 <CAJZ5v0g-rCSd+S4YPBR8Jv2PqePhjQd0K97Rj2+TX3OrWAP0NA@mail.gmail.com>
 <20220615045608.pwranz6b633xmymf@vireshk-i7>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <0af83072-9aef-14fd-f52f-a3230f6df148@huawei.com>
Date:   Sat, 18 Jun 2022 18:32:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220615045608.pwranz6b633xmymf@vireshk-i7>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/15 12:56, Viresh Kumar wrote:
> On 14-06-22, 15:48, Rafael J. Wysocki wrote:
>> On Tue, Jun 14, 2022 at 3:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Tue, May 24, 2022 at 9:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>> On 21-05-22, 14:35, Yi Yang wrote:
>>>>> Function scnprintf() would reserve space for the trailing '\0' and return
>>>>> value is the number of characters written into buf not including the
>>>>> trailing '\0'. internally meaning the next scnprintf() would write begin
>>>>> the trailing '\0'. The code specifying "PAGE_SIZE - i - 2" here is trying
>>>>> to reserve space for "\n\0" which would cause scnprintf() to reserve an
>>>>> additional byte making the tail of the buf looks like this: "\n\0\0".
>>>>> Thus. we should reserve only the space for one '\0'. passing in
>>>>> "PAGE_SIZE - i - 1".
>>>>>
>>>>> Additionally, each iteration would replace the trailing '\0' from the last
>>>>> iteration with a space, and append 4 additional bytes to the string making
>>>>> it a total of 5 additional bytes. That means we should stop printing into
>>>>> the buffer if the remaining size is less than 7 bytes(1 for the ' ', 4 for
>>>>> the %u and 2 for the tailing "\n\0")
>>>>>
>>>>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>>>>> ---
>>>>>   drivers/cpufreq/cpufreq.c | 6 +++---
>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>> index 1f6667ce43bd..60c005c9961e 100644
>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>> @@ -844,9 +844,9 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
>>>>>
>>>>>        for_each_cpu(cpu, mask) {
>>>>>                if (i)
>>>>> -                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
>>>>> -             i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
>>>>> -             if (i >= (PAGE_SIZE - 5))
>>>>> +                     i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), " ");
>>>>> +             i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), "%u", cpu);
>>>>> +             if (i >= (PAGE_SIZE - 6))
>>>>>                        break;
>>>>>        }
>>>>>        i += sprintf(&buf[i], "\n");
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> Applied as 5.20 material, thanks!
>>
>> And dropped, because it has been superseded by this one:
>>
>> https://patchwork.kernel.org/project/linux-pm/patch/b9fa08171c09343ace94a7343553a4bee4695c90.1653565641.git.viresh.kumar@linaro.org/
> 
> The $Subject patch is still required AFAICT, it is fixing a different problem.
> Though it needs to be rebased on top of your branch now.
> 

What can i do for this patch?

--
Yi
