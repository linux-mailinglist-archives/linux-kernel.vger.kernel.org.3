Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDED58F67B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiHKDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiHKDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:52:43 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123483BEC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:52:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VLxY2fF_1660189933;
Received: from 30.240.98.115(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VLxY2fF_1660189933)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 11:52:37 +0800
Message-ID: <66c5a94a-4e6d-7719-7b03-de77a3f18c1b@linux.alibaba.com>
Date:   Thu, 11 Aug 2022 11:52:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH] mm/slub: release kobject if kobject_init_and_add failed
 in sysfs_slab_add
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xhao@linux.alibaba.com
References: <20220811025258.68684-1-xhao@linux.alibaba.com>
 <YvR4GqAqykjUwBJn@ip-172-31-24-42.ap-northeast-1.compute.internal>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <YvR4GqAqykjUwBJn@ip-172-31-24-42.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/11 上午11:31, Hyeonggon Yoo 写道:
> On Thu, Aug 11, 2022 at 10:52:58AM +0800, Xin Hao wrote:
>> In kobject_init_and_add() function, the refcount is setted by calling
>> kobject_init() function, regardless of whether the return value is zero
>> or not, therefore, we must call kobject_del(&s->kobj) to prevent memory
> Hello and thanks!
>
> Should kobject_del() be called when kobject_add() failed?

Yes,  I'm afraid think so， you can see the comment about kobject_add()

* Return: If this function returns an error, kobject_put() must be
  *         called to properly clean up the memory associated with the
  *         object.  Under no instance should the kobject that is passed
  *         to this function be directly freed with a call to kfree(),
  *         that can leak memory.
  *
  *         If this function returns success, kobject_put() must also be 
called
  *         in order to properly clean up the memory associated with the 
object.
  *
  *         In short, once this function is called, kobject_put() MUST 
be called
  *         when the use of the object is finished in order to properly free
  *         everything.
  */
int kobject_add(struct kobject *kobj, struct kobject *parent,
                 const char *fmt, ...)

>
> its comments says:
>
>   597  * kobject_del() - Unlink kobject from hierarchy.
>   598  * @kobj: object.
>   599  *
>   600  * This is the function that should be called to delete an object
>   601  * successfully added via kobject_add().
>
> AFAIK kobject_put() is proper function to call when
> kobject_init_and_add() failed as stated in its comment:
>
>   417 /**
>   418  * kobject_init_and_add() - Initialize a kobject structure and add it to
>   419  *                          the kobject hierarchy.
>   420  * @kobj: pointer to the kobject to initialize
>   421  * @ktype: pointer to the ktype for this kobject.
>   422  * @parent: pointer to the parent of this kobject.
>   423  * @fmt: the name of the kobject.
>   424  *
>   425  * This function combines the call to kobject_init() and kobject_add().
>   426  *
>   427  * If this function returns an error, kobject_put() must be called to
>   428  * properly clean up the memory associated with the object.  This is the
>   429  * same type of error handling after a call to kobject_add() and kobject
>   430  * lifetime rules are the same here.
>
>> of s->kobj is leaked.
>>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/slub.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b1281b8654bd..63b0a8a3a71f 100644
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
>> -	return err;
>> -out_del_kobj:
>>   	kobject_del(&s->kobj);
Maybe there use kobject_put will be better.
>> -	goto out;
>> +	return err;
>>   }
>>   
>>   void sysfs_slab_unlink(struct kmem_cache *s)
>> -- 
>> 2.31.0
