Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C158F364
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiHJUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHJUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:01:57 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D682753
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:01:55 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Lrtkotjn0KOP1LrtkofYFJ; Wed, 10 Aug 2022 22:01:52 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 10 Aug 2022 22:01:52 +0200
X-ME-IP: 90.11.190.129
Message-ID: <abad1a2b-f483-e7ae-19d1-13ead5e5148e@wanadoo.fr>
Date:   Wed, 10 Aug 2022 22:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] perf/arm_pmu_platform: Fix an error message related to
 dev_err_probe() usage
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <aaeba9c12ccdb29f48fe19137cb5abeea85fbb24.1659732652.git.christophe.jaillet@wanadoo.fr>
 <14029916-6037-9248-ddd1-24199e3d3ede@arm.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <14029916-6037-9248-ddd1-24199e3d3ede@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/08/2022 à 16:57, Robin Murphy a écrit :
> On 2022-08-05 21:55, Christophe JAILLET wrote:
>> dev_err() is a macro that expand dev_fmt, but dev_err_probe() is a
>> function and cannot perform this macro expansion.
>>
>> So hard code the "hw perfevents: " prefix and dd a comment explaining 
>> why.
>>
>> Fixes: 11fa1dc8020a ("perf/arm_pmu_platform: Use dev_err_probe() for 
>> IRQ errors")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Untested, but I can't see how it could work.
>>
>> v1 --> v2
>>    - fix a typo in the comment
>> ---
>>   drivers/perf/arm_pmu_platform.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu_platform.c 
>> b/drivers/perf/arm_pmu_platform.c
>> index 513de1f54e2d..02cca4b8f0fd 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -101,8 +101,11 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>>       struct device *dev = &pdev->dev;
>>       num_irqs = platform_irq_count(pdev);
>> -    if (num_irqs < 0)
>> -        return dev_err_probe(dev, num_irqs, "unable to count PMU 
>> IRQs\n");
>> +    if (num_irqs < 0) {
>> +        /* dev_err_probe() does not handle dev_fmt, so hard-code the 
>> prefix */
>> +        return dev_err_probe(dev, num_irqs,
>> +                     "hw perfevents: unable to count PMU IRQs\n");
> 
> Why not use dev_fmt directly? But even better, is there any practical 
> reason why this couldn't be fixed at the source by indirecting 
> dev_err_probe() through a macro wrapper just like all its friends:
> 
> #define dev_err_probe(dev, err, fmt, ...) \
>      _dev_err_probe(dev, err, dev_fmt(fmt), ##__VA_ARGS__)
> 
> ?

Looks nice.

I'll propose it in a week or so, unless s.o. does it in the mean-time.

CJ

> 
> Thanks,
> Robin.
> 
>> +    }
>>       /*
>>        * In this case we have no idea which CPUs are covered by the PMU.
> 

