Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE18583737
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiG1Cz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiG1Cz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:55:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDF8352FF1;
        Wed, 27 Jul 2022 19:55:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 938A71E80D72;
        Thu, 28 Jul 2022 10:55:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OSCnpdWb7c-9; Thu, 28 Jul 2022 10:55:55 +0800 (CST)
Received: from [172.30.18.178] (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7818B1E80CF5;
        Thu, 28 Jul 2022 10:55:55 +0800 (CST)
Subject: Re: [PATCH] x86/aperfmperf: use time_is_before_jiffies(a + b) to
 replace "jiffies - a > b"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
References: <20220727031405.26892-1-yuzhe@nfschina.com>
 <YuFhIgsUgNJ+o9xG@worktop.programming.kicks-ass.net>
From:   Yu Zhe <yuzhe@nfschina.com>
Message-ID: <ecd4dcc3-321c-e228-96a3-bac08c56794a@nfschina.com>
Date:   Thu, 28 Jul 2022 10:55:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <YuFhIgsUgNJ+o9xG@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022年07月28日 00:00, Peter Zijlstra 写道:

> On Wed, Jul 27, 2022 at 11:14:05AM +0800, Yu Zhe wrote:
>> time_is_before_jiffies deals with timer wrapping correctly.
> Please explain how the current code does not.

1. If the timer wrap changes in the future you won't have to alter your code.

2. unsigned long ut;

    ut = ULONG_MAX + 4;

    printf("time_after(ut, ULONG_MAX), ut:%d, %d --> %d\n", ut,
              time_after(ut, ULONG_MAX), (ULONG_MAX - ut) < 0);

     

    In this case, time_after returns true, it's correct.

>> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
>> ---
>>   arch/x86/kernel/cpu/aperfmperf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
>> index 1f60a2b27936..22e0bac3fffe 100644
>> --- a/arch/x86/kernel/cpu/aperfmperf.c
>> +++ b/arch/x86/kernel/cpu/aperfmperf.c
>> @@ -423,7 +423,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>>   	 * Bail on invalid count and when the last update was too long ago,
>>   	 * which covers idle and NOHZ full CPUs.
>>   	 */
>> -	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
>> +	if (!mcnt || time_is_before_jiffies(last + MAX_SAMPLE_AGE))
>>   		goto fallback;
>>   
>>   	return div64_u64((cpu_khz * acnt), mcnt);
>> -- 
>> 2.11.0
>>
>
