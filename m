Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3E4B5BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiBNUx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:53:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiBNUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D091AE71
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644871801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnSI6GRwhiLVduAgjDq1s+p9mRa4u96HTUbVgulW5N0=;
        b=BouVRxr6iDtRCT7seyQUHUbw1bkK0nWe39t08pPrHUyF4vOwQ9RlfORZinxWvR+pMdYSPx
        EN3m7T4M+fMQskPkIFVZmGF3T9ZC/5S4+14ucK95+zgY2i0yOOPnxwH89FlkhA/9aHQu0s
        rO8+UkPwxYsoKkZDiAal86qJhWSIFN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-avBPzm4xMHOX4_tl_TEC2Q-1; Mon, 14 Feb 2022 15:08:11 -0500
X-MC-Unique: avBPzm4xMHOX4_tl_TEC2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015781091DA1;
        Mon, 14 Feb 2022 20:08:10 +0000 (UTC)
Received: from [10.22.12.21] (unknown [10.22.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B20452E2;
        Mon, 14 Feb 2022 20:08:09 +0000 (UTC)
Message-ID: <0b497f83-3a05-623e-e336-3efc5df59fa5@redhat.com>
Date:   Mon, 14 Feb 2022 15:08:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] locking/lockdep: Cleanup reinit_class()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220211035526.1329503-1-longman@redhat.com>
 <Ygo8HNXGNq6X4Jov@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Ygo8HNXGNq6X4Jov@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 06:25, Peter Zijlstra wrote:
> On Thu, Feb 10, 2022 at 10:55:25PM -0500, Waiman Long wrote:
>> Replace the duplicated WARN_ON_ONCE() tests in reinit_class() with
>> BUILD_BUG_ON().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/lockdep_types.h | 4 ++++
>>   kernel/locking/lockdep.c      | 6 +++---
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
>> index d22430840b53..446d981ae3a2 100644
>> --- a/include/linux/lockdep_types.h
>> +++ b/include/linux/lockdep_types.h
>> @@ -108,6 +108,10 @@ struct lock_class {
>>   	 */
>>   	struct list_head		locks_after, locks_before;
>>   
>> +	/*
>> +	 * All the fields that require re-initialization after being zapped
>> +	 * must be put after "key".
>> +	 */
>>   	const struct lockdep_subclass_key *key;
>>   	unsigned int			subclass;
>>   	unsigned int			dep_gen_id;
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index d4252b5c9863..77bbe557d48b 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -6015,10 +6015,10 @@ static void reinit_class(struct lock_class *class)
>>   	WARN_ON_ONCE(!class->lock_entry.next);
>>   	WARN_ON_ONCE(!list_empty(&class->locks_after));
>>   	WARN_ON_ONCE(!list_empty(&class->locks_before));
>> +	BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
>> +	BUILD_BUG_ON(offsetof(struct lock_class, locks_after) > offset);
>> +	BUILD_BUG_ON(offsetof(struct lock_class, locks_before) > offset);
>>   	memset(p + offset, 0, sizeof(*class) - offset);
>> -	WARN_ON_ONCE(!class->lock_entry.next);
>> -	WARN_ON_ONCE(!list_empty(&class->locks_after));
>> -	WARN_ON_ONCE(!list_empty(&class->locks_before));
>>   }
>>   
>>   static inline int within(const void *addr, void *start, unsigned long size)
>> -- 
>> 2.27.0
>>
> Yeah, except that this doesn't build because it conflicts with a
> previous patch you actually Acked:
>
>   https://lore.kernel.org/all/20211213132618.105737-1-xiujianfeng@huawei.com/T/#m0e9474a9204ec29fb2135135ce3134640a3f27b5
>
Sorry, my bad. I forgot to check tip.

I have just sent out a v2 that will work on tip.

Cheers,
Longman

