Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15C591FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiHNNtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:49:06 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B61C124
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 06:49:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VM9mdW6_1660484934;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VM9mdW6_1660484934)
          by smtp.aliyun-inc.com;
          Sun, 14 Aug 2022 21:48:56 +0800
Message-ID: <6af16141-1f9d-d74c-1a76-c752417a4283@linux.alibaba.com>
Date:   Sun, 14 Aug 2022 21:48:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH V2 1/1] mm/slub: release kobject if kobject_init_and_add
 failed in sysfs_slab_add
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220811071844.74020-1-xhao@linux.alibaba.com>
 <20220811071844.74020-2-xhao@linux.alibaba.com> <Yvis1knnMomoeuAx@hyeyoo>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <Yvis1knnMomoeuAx@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/14 下午4:05, Hyeonggon Yoo 写道:
> On Thu, Aug 11, 2022 at 03:18:44PM +0800, Xin Hao wrote:
>> In kobject_init_and_add() function, the refcount is setted by calling
>> kobject_init() function, regardless of whether the return value is zero
>> or not, therefore, we must call kobject_del(&s->kobj) to prevent memory
>> of s->kobj is leaked.
> TL;DR: IIUC current code works just fine
>
> After thinking more, I don't think the memory leak you said exist.
> The space for s->kobj is freed in create_cache() when __kmem_cache_create() failed.

Yes, Agree what you explain,  but  in slab_sysfs_init() function, it 
also call slab_sysfs_add() and  there no other function to release it,  
so i think the memory leak still exist.

> The situation here is:
>
> create_cache() {
> 	s = kmem_cache_alloc(kmem_cache, GFP_KERNEL)
> 	err = __kmem_cache_create()
> 	if (err)
> 		goto out_free_cache;
> 	
> out_free_cache:
> 	kmem_cache_free(s) // s is freed here (including its kobject)
> 	[...]
> }
>
> __kmem_cache_create() {
> 	[...]
>
> 	err = sysfs_slab_add();
> 	if (err) {
> 		__kmem_cache_release(s);
> 		return err;
> 	}
> }
>
> The primary goal of kobject_put() is to call release() function
> of kobj_type (when reference becomes zero), which is kmem_cache_release().
>
> kmem_cache_release() {
> 	__kmem_cache_release(s)
> 	kfree_const(s->name)
> 	kmem_cache_free(s)
> }
>
> But when slab_sysfs_add() failed, __kmem_cache_release() and
> create_cache() releases resources related to the cache.
> (Also its name is freed in kmem_cache_create_usercopy().)
>
> So IIUC current code works just fine!
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/slub.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b1281b8654bd..940a3f52e07c 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5981,19 +5981,18 @@ static int sysfs_slab_add(struct kmem_cache *s)
>>   
>>   	err = sysfs_create_group(&s->kobj, &slab_attr_group);
>>   	if (err)
>> -		goto out_del_kobj;
>> +		goto out;
>>   
>>   	if (!unmergeable) {
>>   		/* Setup first alias */
>>   		sysfs_slab_alias(s, s->name);
>>   	}
>> +	return err;
>>   out:
>>   	if (!unmergeable)
>>   		kfree(name);
>> +	kobject_put(&s->kobj);
>>   	return err;
>> -out_del_kobj:
>> -	kobject_del(&s->kobj);
> So related resources are released in create_cache(), instead of by
> calling kobject_put().
>
> But kobject_del() is still needed because it should unlink kobject
> hierarchy when kobject_add() succeeded but sysfs_create_group() failed!
>
>> -	goto out;
>>   }
>>   
>>   void sysfs_slab_unlink(struct kmem_cache *s)
>> -- 
>> 2.31.0
>>
