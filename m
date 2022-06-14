Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB8754AD60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiFNJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiFNJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:26:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EDC830F44
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:26:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0D6781E80D90;
        Tue, 14 Jun 2022 17:25:24 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3IqDa6VMt13U; Tue, 14 Jun 2022 17:25:21 +0800 (CST)
Received: from [172.30.24.122] (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B331C1E80D5E;
        Tue, 14 Jun 2022 17:25:20 +0800 (CST)
Subject: Re: [PATCH] mm: check the function kmalloc_slab return value
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        qixu@nfschina.com, hukun@nfschina.com, yuzhe@nfschina.com
References: <20220613102438.27723-1-renyu@nfschina.com>
 <20220614083939.13508-1-renyu@nfschina.com>
 <bb8d41fc-bd13-9563-7c54-2850f131e835@suse.cz>
From:   tury <renyu@nfschina.com>
Message-ID: <be9a1d54-0558-dbee-fcac-0f357ea32db9@nfschina.com>
Date:   Tue, 14 Jun 2022 17:26:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <bb8d41fc-bd13-9563-7c54-2850f131e835@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022年06月14日 16:48, Vlastimil Babka 写道:
> On 6/14/22 10:39, Ren Yu wrote:
>> As the possible failure of the kmalloc_slab,
>> it should be better to check it.
> AFAIK failure is not possible, kmalloc_slab() is not an allocation function,
> it just returns a member of kmalloc_caches array, which is initialized
> elsewhere and shouldn't contain NULLs. So the patch seems unnecessary to me.
>
>> Signed-off-by: Ren Yu <renyu@nfschina.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> v2:
>> - fix build waring integer from pointer without a cast
>> ---
>> ---
>>   mm/slab.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/slab.c b/mm/slab.c
>> index f8cd00f4ba13..72135e555827 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -2064,6 +2064,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>>   	if (OFF_SLAB(cachep)) {
>>   		cachep->freelist_cache =
>>   			kmalloc_slab(cachep->freelist_size, 0u);
>> +		if (unlikely(ZERO_OR_NULL_PTR(cachep->freelist_cache)))
> The usual way is "if (!cachep->freelist_cache)". Not sure why check for ZERO.
>
>> +			return cachep->freelist_cache;
> So in case of NULL this would return NULL, thus 0, but __kmem_cache_create()
> return 0 on success, so it's wrong. You would have to return e.g. -ENOMEM.
Thanks for the advice ,I'll be re-patching
>
>>   	}
>>   
>>   	err = setup_cpu_cache(cachep, gfp);
>

