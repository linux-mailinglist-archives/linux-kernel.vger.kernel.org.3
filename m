Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3074AD794
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358083AbiBHLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiBHLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:20:41 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8E0C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:20:39 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JtL6x4JJbz1FCwd;
        Tue,  8 Feb 2022 19:16:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 19:20:36 +0800
Subject: Re: [PATCH] mm/memory_hotplug: fix kfree() of bootmem memory
To:     David Hildenbrand <david@redhat.com>
CC:     <isimatu.yasuaki@jp.fujitsu.com>, <toshi.kani@hp.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220207135618.17231-1-linmiaohe@huawei.com>
 <6d4ab70e-b944-5f7d-e9a3-979ac66c70f7@redhat.com>
 <828c9b16-6ff0-abb7-3a16-277d2d60de81@huawei.com>
 <72ae5d5b-512e-4dd4-4bb0-d867fb788f60@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9fa3f18e-dccb-4dc1-7fdb-ba169e042246@huawei.com>
Date:   Tue, 8 Feb 2022 19:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <72ae5d5b-512e-4dd4-4bb0-d867fb788f60@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/8 17:19, David Hildenbrand wrote:
> On 08.02.22 02:59, Miaohe Lin wrote:
>> Hi:
>> On 2022/2/7 22:33, David Hildenbrand wrote:
>>> On 07.02.22 14:56, Miaohe Lin wrote:
>>>> We can't use kfree() to release the resource as it might come from bootmem.
>>>> Use release_mem_region() instead.
>>>
>>> How can this happen? release_mem_region() is called either from
>>> __add_memory() or from add_memory_driver_managed(), where we allocated
>>> the region via register_memory_resource(). Both functions shouldn't ever
>>> be called before the buddy is up an running.
>>>
>>> Do you have a backtrace of an actual instance of this issue? Or was this
>>> identified as possibly broken by code inspection?
>>>
>>
>> This is identified as possibly broken by code inspection. IIUC, alloc_resource
>> is always used to allocate the resource. It has the below logic:
>>
>>   if (bootmem_resource_free) {
>> 	res = bootmem_resource_free;
>> 	bootmem_resource_free = res->sibling;
>>   }
>>
>> where bootmem_resource_free is used to reusing the resource entries allocated by boot
>> mem after the system is up:
>>
>> /*
>>  * For memory hotplug, there is no way to free resource entries allocated
>>  * by boot mem after the system is up. So for reusing the resource entry
>>  * we need to remember the resource.
>>  */
>> static struct resource *bootmem_resource_free;
>>
>> So I think register_memory_resource() can reuse the resource allocated by bootmem.
>> Or am I miss anything?
> 
> I think you're right, if we did a previous free_resource() of a resource allocated
> during boot we could end up reusing that here. My best guess is that this never
> really happens.
> 

Agree with you. This reusing mechanism is introduced since 2013 and this possible
issue never happens.

> Wow, that's ugly. It affects essentially anybody reserving+freeing a resource.
> 
> E.g., dax/kmem.c similarly does a release_resource(res)+kfree(res)
> 
> 
> We could either
> 
> a) Expose free_resource() and replace all kfree(res) instances by it
> 
> b) Just simplify that. I don't think we care about saving a couple of 
>    bytes in corner cases. I might be wrong (IIRC primarily ppc64 really 
>    succeeds in unplugging boot memory)
> 

I prefer this one or there will be a huge change if we choose a.
I will drop my patch and below patch looks good to me.

Many thanks!

> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 9c08d6e9eef2..fe91a72fd951 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -56,14 +56,6 @@ struct resource_constraint {
>  
>  static DEFINE_RWLOCK(resource_lock);
>  
> -/*
> - * For memory hotplug, there is no way to free resource entries allocated
> - * by boot mem after the system is up. So for reusing the resource entry
> - * we need to remember the resource.
> - */
> -static struct resource *bootmem_resource_free;
> -static DEFINE_SPINLOCK(bootmem_resource_lock);
> -
>  static struct resource *next_resource(struct resource *p)
>  {
>         if (p->child)
> @@ -160,36 +152,19 @@ __initcall(ioresources_init);
>  
>  static void free_resource(struct resource *res)
>  {
> -       if (!res)
> -               return;
> -
> -       if (!PageSlab(virt_to_head_page(res))) {
> -               spin_lock(&bootmem_resource_lock);
> -               res->sibling = bootmem_resource_free;
> -               bootmem_resource_free = res;
> -               spin_unlock(&bootmem_resource_lock);
> -       } else {
> +       /*
> +        * If the resource was allocated using memblock early during boot
> +        * we'll leak it here: we can only return full pages back to the
> +        * buddy and trying to be smart and reusing them eventually in
> +        * alloc_resource() overcomplicates resource handling.
> +        */
> +       if (res && PageSlab(virt_to_head_page(res)))
>                 kfree(res);
> -       }
>  }
>  
>  static struct resource *alloc_resource(gfp_t flags)
>  {
> -       struct resource *res = NULL;
> -
> -       spin_lock(&bootmem_resource_lock);
> -       if (bootmem_resource_free) {
> -               res = bootmem_resource_free;
> -               bootmem_resource_free = res->sibling;
> -       }
> -       spin_unlock(&bootmem_resource_lock);
> -
> -       if (res)
> -               memset(res, 0, sizeof(struct resource));
> -       else
> -               res = kzalloc(sizeof(struct resource), flags);
> -
> -       return res;
> +       return kzalloc(sizeof(struct resource), flags);
>  }
>  
>  /* Return the conflict entry if you can't request it */
> 
> 

