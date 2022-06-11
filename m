Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5A5471B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 06:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiFKEEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 00:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiFKEEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 00:04:32 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB89BA8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:04:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VG0hM-B_1654920263;
Received: from 30.30.67.86(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VG0hM-B_1654920263)
          by smtp.aliyun-inc.com;
          Sat, 11 Jun 2022 12:04:25 +0800
Message-ID: <02298c0e-3293-9deb-f1ed-6d8862f7c349@linux.alibaba.com>
Date:   Sat, 11 Jun 2022 12:04:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
To:     Christoph Lameter <cl@gentwo.de>
Cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
 <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
 <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 8:23 PM, Christoph Lameter wrote:
> On Wed, 8 Jun 2022, Rongwei Wang wrote:
> 
>> If available, I think document the issue and warn this incorrect behavior is
>> OK. But it still prints a large amount of confusing messages, and disturbs us?
> 
> Correct it would be great if you could fix this in a way that does not
> impact performance.
> 
>>> are current operations on the slab being validated.
>> And I am trying to fix it in following way. In a short, these changes only
>> works under the slub debug mode, and not affects the normal mode (I'm not
>> sure). It looks not elegant enough. And if all approve of this way, I can
>> submit the next version.
> 
> 
>>
>> Anyway, thanks for your time:).
>> -wrw
>>
>> @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s,
> struct
>> slab *slab,
>>
>>   {
>>          void *prior;
>> -       int was_frozen;
>> +       int was_frozen, to_take_off = 0;
>>          struct slab new;
> 
> to_take_off has the role of !n ? Why is that needed?
> 
>> -       do {
>> -               if (unlikely(n)) {
>> +               spin_lock_irqsave(&n->list_lock, flags);
>> +               ret = free_debug_processing(s, slab, head, tail, cnt, addr);
> 
> Ok so the idea is to take the lock only if kmem_cache_debug. That looks
> ok. But it still adds a number of new branches etc to the free loop.
> 
> Some performance tests would be useful.
Hi Christoph

Thanks for your time!
Do you have some advice in benchmarks that need me to test? And I find 
that hackbench and lkp was used frequently in mm/slub.c commits[1,2]. 
But I have no idea how to use these two benchmarks test to cover the 
above changes. Can you give some examples? Thanks very much!

Sorry for late reply!

[1]https://lore.kernel.org/lkml/20210301080404.GF12822@xsang-OptiPlex-9020/
[2]https://lore.kernel.org/linux-mm/20210128134512.GF3592@techsingularity.net/
