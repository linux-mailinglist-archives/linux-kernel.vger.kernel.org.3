Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54454CDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbiFOQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiFOQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D35D21209F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655309260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOHCvIKVzCA/+PXZllmmH2BoXPXS8bGvjyl5jD0CoBQ=;
        b=A2OloeNO0Dbber8CQ5TeodtjvKC4hVS6OLwL4wCKha86kEHVcQa/yDXNmOErjS8OKAbGVX
        Kqgd/0eceYdZ6WT/a6ZYZgvFyMOW7ZZ8J1WLHloh9p8z7nhFqhhaelP5ANuny6bD5YOrs4
        MKN6rjNXgU2ODOj3lHad/e2dj71sbNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-6wxi91VfPrmdwvZyWyJb_g-1; Wed, 15 Jun 2022 12:07:35 -0400
X-MC-Unique: 6wxi91VfPrmdwvZyWyJb_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6CAF185A7BA;
        Wed, 15 Jun 2022 16:07:34 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7B5492C3B;
        Wed, 15 Jun 2022 16:07:34 +0000 (UTC)
Message-ID: <92dd6f80-5124-0b7a-32ed-7703dc9e34ca@redhat.com>
Date:   Wed, 15 Jun 2022 12:07:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] mm/kmemleak: Prevent soft lockup in first object
 iteration loop of kmemleak_scan()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220614220359.59282-1-longman@redhat.com>
 <20220614220359.59282-4-longman@redhat.com> <Yqn2jxZhk5Neomu7@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yqn2jxZhk5Neomu7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 11:11, Catalin Marinas wrote:
> On Tue, Jun 14, 2022 at 06:03:59PM -0400, Waiman Long wrote:
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 7dd64139a7c7..abba063ae5ee 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1417,12 +1417,16 @@ static void kmemleak_scan(void)
>>   	struct zone *zone;
>>   	int __maybe_unused i;
>>   	int new_leaks = 0;
>> +	int loop1_cnt = 0;
>>   
>>   	jiffies_last_scan = jiffies;
>>   
>>   	/* prepare the kmemleak_object's */
>>   	rcu_read_lock();
>>   	list_for_each_entry_rcu(object, &object_list, object_list) {
>> +		bool obj_pinned = false;
>> +
>> +		loop1_cnt++;
>>   		raw_spin_lock_irq(&object->lock);
>>   #ifdef DEBUG
>>   		/*
>> @@ -1437,10 +1441,32 @@ static void kmemleak_scan(void)
>>   #endif
>>   		/* reset the reference count (whiten the object) */
>>   		object->count = 0;
>> -		if (color_gray(object) && get_object(object))
>> +		if (color_gray(object) && get_object(object)) {
>>   			list_add_tail(&object->gray_list, &gray_list);
>> +			obj_pinned = true;
>> +		}
>>   
>>   		raw_spin_unlock_irq(&object->lock);
>> +
>> +		/*
>> +		 * Do a cond_resched() to avoid soft lockup every 64k objects.
>> +		 * Make sure a reference has been taken so that the object
>> +		 * won't go away without RCU read lock.
>> +		 */
>> +		if (!(loop1_cnt & 0xffff)) {
>> +			if (!obj_pinned && !get_object(object)) {
>> +				/* Try the next object instead */
>> +				loop1_cnt--;
>> +				continue;
>> +			}
> With this trick we could probably get rid of rcu_read_lock() and take
> the kmemleak_lock instead. But that's for another patch.
rcu_read_lock() is cheap unless we use a preempt kernel.

>
>> +
>> +			rcu_read_unlock();
>> +			cond_resched();
>> +			rcu_read_lock();
> cond_resched_rcu() to save a couple of lines?
I am not aware of such helper function. Yes, I should have used that 
instead in case I need to update this patch again. Thanks!
>
>> +
>> +			if (!obj_pinned)
>> +				put_object(object);
>> +		}
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Thanks,

Longman

