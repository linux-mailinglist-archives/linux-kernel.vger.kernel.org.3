Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DA56C5E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGICAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGICAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:00:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA34E87E;
        Fri,  8 Jul 2022 19:00:32 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LftbN5TqQzkWnW;
        Sat,  9 Jul 2022 09:58:24 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 10:00:30 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 10:00:29 +0800
Subject: Re: [PATCH v2] perf/core: Fix data race between perf_event_set_output
 and perf_mmap_close
From:   Yang Jihong <yangjihong1@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220704120006.98141-1-yangjihong1@huawei.com>
 <YsMGixSL4CDPTTZs@worktop.programming.kicks-ass.net>
 <YsQ3jm2GR38SW7uD@worktop.programming.kicks-ass.net>
 <1e28533a-33ed-cae3-0389-c68e7c52cead@huawei.com>
Message-ID: <3ba262b0-a92f-e57d-af31-baccca765ac3@huawei.com>
Date:   Sat, 9 Jul 2022 10:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1e28533a-33ed-cae3-0389-c68e7c52cead@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/7/6 20:29, Yang Jihong wrote:
> Hello,
> 
> On 2022/7/5 21:07, Peter Zijlstra wrote:
>> On Mon, Jul 04, 2022 at 05:26:04PM +0200, Peter Zijlstra wrote:
>>> On Mon, Jul 04, 2022 at 08:00:06PM +0800, Yang Jihong wrote:
>>>> Data race exists between perf_event_set_output and perf_mmap_close.
>>>> The scenario is as follows:
>>>>
>>>>                    
>>>> CPU1                                                       CPU2
>>>>                                                                      
>>>> perf_mmap_close(event2)
>>>>                                                                        
>>>> if (atomic_dec_and_test(&event2->rb->mmap_count)  // mmap_count 1 -> 0
>>>>                                                                          
>>>> detach_rest = true;
>>>> ioctl(event1, PERF_EVENT_IOC_SET_OUTPUT, event2)
>>>>    perf_event_set_output(event1, event2)
>>>>                                                                        
>>>> if (!detach_rest)
>>>>                                                                          
>>>> goto out_put;
>>>>                                                                        
>>>> list_for_each_entry_rcu(event, &event2->rb->event_list, rb_entry)
>>>>                                                                          
>>>> ring_buffer_attach(event, NULL)
>>>>                                                                        
>>>> // because event1 has not been added to event2->rb->event_list,
>>>>                                                                        
>>>> // event1->rb is not set to NULL in these loops
>>>>
>>>>      ring_buffer_attach(event1, event2->rb)
>>>>        list_add_rcu(&event1->rb_entry, &event2->rb->event_list)
>>>>
>>>> The above data race causes a problem, that is, event1->rb is not 
>>>> NULL, but event1->rb->mmap_count is 0.
>>>> If the perf_mmap interface is invoked for the fd of event1, the 
>>>> kernel keeps in the perf_mmap infinite loop:
>>>>
>>>> again:
>>>>          mutex_lock(&event->mmap_mutex);
>>>>          if (event->rb) {
>>>> <SNIP>
>>>>                  if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
>>>>                          /*
>>>>                           * Raced against perf_mmap_close() through
>>>>                           * perf_event_set_output(). Try again, hope 
>>>> for better
>>>>                           * luck.
>>>>                           */
>>>>                          mutex_unlock(&event->mmap_mutex);
>>>>                          goto again;
>>>>                  }
>>>> <SNIP>
>>>
>>> Too tired, must look again tomorrow, little feeback below.
>>
>> With brain more awake I ended up with the below. Does that work?
I have verified that this patch can solve the problem.

Do I submit this patch? Or do you submit it?

Thanks,
Yang

> 
> Yes, I apply the patch on kernel versions 5.10 and mainline,
> and it could fixed the problem.
> 
> Tested-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Thanks,
> Yang
> .
