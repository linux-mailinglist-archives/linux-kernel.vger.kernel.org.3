Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80359F0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiHXBZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHXBZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:25:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57001D74
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:25:03 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MC7bw05sHzlWG1;
        Wed, 24 Aug 2022 09:21:48 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 09:25:01 +0800
Message-ID: <096cb71d-1001-0a78-73c8-bfef84868d96@huawei.com>
Date:   Wed, 24 Aug 2022 09:25:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] trace: wwnr: Make local symbol 'rv_wwnr' static
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>
References: <20220822063056.3890045-1-zengheng4@huawei.com>
 <378d61ab-8866-8026-d6ad-b8f6718ff345@kernel.org>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <378d61ab-8866-8026-d6ad-b8f6718ff345@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it, it's pleasure. And I will re-send the below patch series ASAP.


B.R.,

Zeng Heng


在 2022/8/23 22:05, Daniel Bristot de Oliveira 写道:
> On 8/22/22 08:30, Zeng Heng wrote:
>> The sparse tool complains as follows:
>>
>> kernel/trace/rv/monitors/wwnr/wwnr.c:18:19:
>> warning: symbol 'rv_wwnr' was not declared. Should it be static?
>>
>> The `rv_wwnr` symbol is not dereferenced by other exter files,
>> so add static qualifier for it.
> Would you mind re-sending this patch with some changes?
>
> - Use "rv/monitors:" as the subsystem
> - Do the same change for wip monitor
> - Add the fixes tags:
>    Fixes:	ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
>    Fixes:	8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
>
> Also, to fix this problem for new monitors, do another patch changing the dot2k
> templates files, adding the same 'static' attribute. The files are:
>
> - tools/verification/dot2/dot2k_templates/main_global.c
> - tools/verification/dot2/dot2k_templates/main_per_cpu.c
> - tools/verification/dot2/dot2k_templates/main_per_task.c
>
> In this second patch, add the subsystem as "rv/dot2k" and the following tags:
>
>    Fixes:	24bce201d798 ("tools/rv: Add dot2k")
>    Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>
> Thanks!
> -- Daniel
>
>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   kernel/trace/rv/monitors/wwnr/wwnr.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
>> index 599225d9cf38..a063b93c6a1d 100644
>> --- a/kernel/trace/rv/monitors/wwnr/wwnr.c
>> +++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
>> @@ -15,7 +15,7 @@
>>   
>>   #include "wwnr.h"
>>   
>> -struct rv_monitor rv_wwnr;
>> +static struct rv_monitor rv_wwnr;
>>   DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
>>   
>>   static void handle_switch(void *data, bool preempt, struct task_struct *p,
>> @@ -59,7 +59,7 @@ static void disable_wwnr(void)
>>   	da_monitor_destroy_wwnr();
>>   }
>>   
>> -struct rv_monitor rv_wwnr = {
>> +static struct rv_monitor rv_wwnr = {
>>   	.name = "wwnr",
>>   	.description = "wakeup while not running per-task testing model.",
>>   	.enable = enable_wwnr,
