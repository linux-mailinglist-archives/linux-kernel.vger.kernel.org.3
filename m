Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0245149D792
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiA0BoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:44:00 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32123 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiA0Bn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:43:58 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JkjwV3pGWz8wdn;
        Thu, 27 Jan 2022 09:40:58 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 09:43:56 +0800
Subject: Re: [PATCH] cpuidle: menu: Fix long delay issue when tick stopped
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Yang <guoyang2@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20220117081615.45449-1-zhangshaokun@hisilicon.com>
 <CAJZ5v0jBVX9H8d8g4v3W7x9MEKQpudr3NP+LGP57FioFvpq7Jg@mail.gmail.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <bcd3cadf-df4a-7d7a-e28a-adeb7b1a4c24@hisilicon.com>
Date:   Thu, 27 Jan 2022 09:43:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jBVX9H8d8g4v3W7x9MEKQpudr3NP+LGP57FioFvpq7Jg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Apologies that reply later.

On 2022/1/21 2:55, Rafael J. Wysocki wrote:
> On Mon, Jan 17, 2022 at 9:16 AM Shaokun Zhang
> <zhangshaokun@hisilicon.com> wrote:
>>

...<snip>...

>> [   37.083307] intervals = 35us
>> [   37.083320] target_residency_ns = 10000, predicted_ns = 35482140
>> [   37.083349] target_residency_ns = 600000, predicted_ns = 35482140
>>
>> Add idle tick wakeup judge before change predicted_ns.
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Guo Yang <guoyang2@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  drivers/cpuidle/governors/menu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index c492268..3f03843 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -313,7 +313,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>                                 get_typical_interval(data, predicted_us)) *
>>                                 NSEC_PER_USEC;
>>
>> -       if (tick_nohz_tick_stopped()) {
>> +       if (tick_nohz_tick_stopped() && data->tick_wakeup) {
> 
> data->tick_wakeup is only true if tick_nohz_idle_got_tick() has
> returned true, but I'm not sure how this can happen after stopping the
> tick.

In order to debug this, call trace is added and as follow:

if (predicted_us < TICK_USEC)
    predicted_us = ktime_to_us(delta_next);
    printk("predicted_us = %uus\n", predicted_us);
    dump_stack(); //add call trace print
}

When the issue came, the CPU was waken up by network interrupts
[ 1048.130033] intervals = 1us
[ 1048.130034] intervals = 1us
[ 1048.130035] intervals = 1us
[ 1048.130036] intervals = 1us
[ 1048.130037] intervals = 1us
[ 1048.130038] intervals = 1us
[ 1048.130039] intervals = 1us
[ 1048.130040] intervals = 1us
[ 1048.130041] predicted_us = 484143us
[ 1048.130043] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G           OE     5.3.0-rc6 #23
[ 1048.130044] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 0.39 12/01/2017
[ 1048.130045] Call Trace:
[ 1048.130048]  dump_stack+0x5a/0x73
[ 1048.130052]  menu_select+0x3b0/0x6c0
[ 1048.130058]  do_idle+0x1b4/0x290
[ 1048.130063]  cpu_startup_entry+0x19/0x20
[ 1048.130067]  start_secondary+0x155/0x1b0
[ 1048.130070]  secondary_startup_64+0xa4/0xb0
[ 1048.130078] intervals = 1us
[ 1048.130079] intervals = 1us
[ 1048.130080] intervals = 1us
[ 1048.130081] intervals = 1us
[ 1048.130081] intervals = 1us
[ 1048.130082] intervals = 1us
[ 1048.130083] intervals = 1us
[ 1048.130084] intervals = 1us
[ 1048.130085] predicted_us = 484097us
[ 1048.130087] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G           OE     5.3.0-rc6 #23
[ 1048.130088] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 0.39 12/01/2017
[ 1048.130089] Call Trace:
[ 1048.130093]  dump_stack+0x5a/0x73
[ 1048.130097]  menu_select+0x3b0/0x6c0
[ 1048.130102]  do_idle+0x1b4/0x290
[ 1048.130107]  cpu_startup_entry+0x19/0x20
[ 1048.130112]  start_secondary+0x155/0x1b0
[ 1048.130115]  secondary_startup_64+0xa4/0xb0
[ 1048.130123] intervals = 1us
[ 1048.130123] intervals = 1us
[ 1048.130124] intervals = 1us
[ 1048.130125] intervals = 1us
[ 1048.130126] intervals = 1us
[ 1048.130127] intervals = 1us
[ 1048.130128] intervals = 1us
[ 1048.130129] intervals = 1us
[ 1048.130130] predicted_us = 484053us
[ 1048.130132] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G           OE     5.3.0-rc6 #23
[ 1048.130133] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 0.39 12/01/2017
[ 1048.130134] Call Trace:
[ 1048.130137]  dump_stack+0x5a/0x73
[ 1048.130141]  menu_select+0x3b0/0x6c0
[ 1048.130147]  do_idle+0x1b4/0x290
[ 1048.130152]  cpu_startup_entry+0x19/0x20
[ 1048.130156]  start_secondary+0x155/0x1b0
[ 1048.130159]  secondary_startup_64+0xa4/0xb0

> 
> IOW, it looks like the change simply makes the condition be always false.
> 

Agree, any good feedback is welcome and we can try it.

Thanks,
Shaokun

>>                 /*
>>                  * If the tick is already stopped, the cost of possible short
>>                  * idle duration misprediction is much higher, because the CPU
>> --
>> 1.8.3.1
>>
> .
> 
