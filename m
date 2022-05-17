Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F540529D88
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbiEQJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244151AbiEQJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:10:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F94B86F;
        Tue, 17 May 2022 02:08:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2Vct2Mtjz1JCB9;
        Tue, 17 May 2022 17:07:26 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 17:08:46 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 17:08:45 +0800
Message-ID: <0db235d3-7aa8-7b4d-af99-c6e3364738de@huawei.com>
Date:   Tue, 17 May 2022 17:08:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall
 trigger
To:     Alex Shi <seakeel@gmail.com>, <linux-kernel@vger.kernel.org>,
        <hannes@cmpxchg.org>, <surenb@google.com>, <alexs@kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/16 14:20, Alex Shi 写道:
>
> On 5/16/22 11:35, Chen Wandun wrote:
>> Nowadays, psi events are triggered when stall time exceed
>> stall threshold, but no any different between these events.
>>
>> Actually, events can be divide into multi level, each level
>> represent a different stall pressure, that is help to identify
>> pressure information more accurately.
>>
>> echo "some 150000 350000 1000000" > /proc/pressure/memory would
> This breaks the old ABI. And why you need this new function?
We want to do different measures according to different stall levels,

In small stall case, maybe only low level warning is needed,  In big

stall case, maybe aggressive memory reclaim is needed.

so it is necessary to distinguish different levels.
>
> Thanks
>
>> add [150ms, 350ms) threshold for partial memory stall measured
>> within 1sec time window.
>>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   include/linux/psi_types.h |  3 ++-
>>   kernel/sched/psi.c        | 19 +++++++++++++------
>>   2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
>> index c7fe7c089718..2b1393c8bf90 100644
>> --- a/include/linux/psi_types.h
>> +++ b/include/linux/psi_types.h
>> @@ -119,7 +119,8 @@ struct psi_trigger {
>>   	enum psi_states state;
>>   
>>   	/* User-spacified threshold in ns */
>> -	u64 threshold;
>> +	u64 min_threshold;
>> +	u64 max_threshold;
>>   
>>   	/* List node inside triggers list */
>>   	struct list_head node;
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 6f9533c95b0a..17dd233b533a 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -541,7 +541,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>>   
>>   			/* Calculate growth since last update */
>>   			growth = window_update(&t->win, now, total[t->state]);
>> -			if (growth < t->threshold)
>> +			if (growth < t->min_threshold || growth >= t->max_threshold)
>>   				continue;
>>   
>>   			t->pending_event = true;
>> @@ -1087,15 +1087,18 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>>   {
>>   	struct psi_trigger *t;
>>   	enum psi_states state;
>> -	u32 threshold_us;
>> +	u32 min_threshold_us;
>> +	u32 max_threshold_us;
>>   	u32 window_us;
>>   
>>   	if (static_branch_likely(&psi_disabled))
>>   		return ERR_PTR(-EOPNOTSUPP);
>>   
>> -	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
>> +	if (sscanf(buf, "some %u %u %u", &min_threshold_us,
>> +				&max_threshold_us, &window_us) == 3)
>>   		state = PSI_IO_SOME + res * 2;
>> -	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
>> +	else if (sscanf(buf, "full %u %u %u", &min_threshold_us,
>> +				&max_threshold_us, &window_us) == 3)
>>   		state = PSI_IO_FULL + res * 2;
>>   	else
>>   		return ERR_PTR(-EINVAL);
>> @@ -1107,8 +1110,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>>   		window_us > WINDOW_MAX_US)
>>   		return ERR_PTR(-EINVAL);
>>   
>> +	if (min_threshold_us >= max_threshold_us)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	/* Check threshold */
>> -	if (threshold_us == 0 || threshold_us > window_us)
>> +	if (max_threshold_us > window_us)
>>   		return ERR_PTR(-EINVAL);
>>   
>>   	t = kmalloc(sizeof(*t), GFP_KERNEL);
>> @@ -1117,7 +1123,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>>   
>>   	t->group = group;
>>   	t->state = state;
>> -	t->threshold = threshold_us * NSEC_PER_USEC;
>> +	t->min_threshold = min_threshold_us * NSEC_PER_USEC;
>> +	t->max_threshold = max_threshold_us * NSEC_PER_USEC;
>>   	t->win.size = window_us * NSEC_PER_USEC;
>>   	window_reset(&t->win, 0, 0, 0);
>>   
> .

