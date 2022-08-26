Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6B5A23C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbiHZJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHZJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:10:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D42D1FF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:10:01 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDYrV4hWYzmVdX;
        Fri, 26 Aug 2022 17:07:38 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:09:59 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:09:58 +0800
Message-ID: <f9a637ac-2146-d430-cffc-f8ec956abfff@huawei.com>
Date:   Fri, 26 Aug 2022 17:09:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] sched/deadline: Add start_new_instance helper
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220826031521.13391-1-shangxiaojing@huawei.com>
 <651dbb96-8d6e-53e9-a99f-0bb12f5b2723@redhat.com>
 <893836a5-0aaa-e5e6-81ba-cc9570b9a026@huawei.com>
 <7927ac6e-7738-822a-59ce-09992947f3b4@redhat.com>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <7927ac6e-7738-822a-59ce-09992947f3b4@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/26 16:57, Daniel Bristot de Oliveira wrote:
> On 8/26/22 09:40, shangxiaojing wrote:
>>> again, this is not a good function name. Maybe, dl_replenish_new_period() ?
>> right, i have thought like replenish_new_instance, but when i'm making
>> patch,  i was worried that "replenish" is only for ENQUEUE_REPLENISH.
> I see, but that is a flag, not the action.
>
>> what about dl_start_new_period? which means a new deadline will be set, rather than
> The thing it is doing is replenishing...
>
>>      dl_se->deadline += pi_of(dl_se)->dl_period;
>>
>> in replenish_dl_entity.
> that is why I added "new_period"....  so replenish_dl_new_period() to keep the consistency.

ok, i'll use replenish_dl_new_period in v2.

>>>> +static inline void start_new_instance(struct sched_dl_entity *dl_se, struct rq *rq)
>>>>
>>>> +{
>>>> +    /* for non-boosted task, pi_of(dl_se) == dl_se */
>>>> +    dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
>>>> +    dl_se->runtime = pi_of(dl_se)->dl_runtime;
>>>> +}
>>>> +
>>> -- Daniel
> -- Daniel

Thanks,

Shang XiaoJing

