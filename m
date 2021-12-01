Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4B46474A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhLAGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:42:47 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28201 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhLAGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:42:43 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3qBn3qWHz8vgK;
        Wed,  1 Dec 2021 14:37:21 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 14:39:19 +0800
Received: from [10.174.177.232] (10.174.177.232) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 14:39:19 +0800
Subject: Re: [PATCH 1/2] cpufreq: Fix a comment in cpufreq_policy_free
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211130151526.949-1-tangyizhou@huawei.com>
 <20211130151526.949-2-tangyizhou@huawei.com>
 <20211201042245.amxgyevar6gjbkfb@vireshk-i7>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <5a895a87-4eee-3dfd-5b86-af436929a068@huawei.com>
Date:   Wed, 1 Dec 2021 14:39:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20211201042245.amxgyevar6gjbkfb@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.232]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/1 12:22, Viresh Kumar wrote:
> On 30-11-21, 23:15, Tang Yizhou wrote:
>> The comment is inconsistent with the block_notifier_call_chain() call,
>> so fix it.
>>
>> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index e338d2f010fe..8f753675e4a2 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1296,7 +1296,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>  
>>  	if (policy->max_freq_req) {
>>  		/*
>> -		 * CPUFREQ_CREATE_POLICY notification is sent only after
>> +		 * CPUFREQ_REMOVE_POLICY notification is sent only after
> 
> No, the earlier comment is correct. It says when the CREATE notification was
> sent and so we need to do the remove here before removing max_freq_req.

I see. I was confused at the first time. Perhaps it is better to both comment when
CPUFREQ_CREATE_POLICY and CPUFREQ_REMOVE_POLICY notification is sent.

> 
>>  		 * successfully adding max_freq_req request.
>>  		 */
>>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>> -- 
>> 2.17.1
> 

Tang
