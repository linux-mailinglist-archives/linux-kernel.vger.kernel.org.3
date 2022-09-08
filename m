Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFF5B1CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiIHMVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiIHMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512C1316C1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662639698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1bOOozDQ+6EDEHi9rJz7Dh4D3HKy76AxnObw13WaRU=;
        b=WNwUBq/LDwEEZgKMu5jDN8ei4g+3PkNJhxH5HGtr5w59acEveMaQ5KfTcU6U1qYIUMwQSv
        PkT6n5W0j65MWmzP9B6HABCM6ygHqCtbIC8WsDqd/ci9Jo0y/Mtew9qX8keqIlckPrlVdP
        3HmThGsP1hsZ3xiFy1Cc1Zx8Pvu4qeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-U2HKYwDKPniI7sMA9wpmyg-1; Thu, 08 Sep 2022 08:21:37 -0400
X-MC-Unique: U2HKYwDKPniI7sMA9wpmyg-1
Received: by mail-wm1-f69.google.com with SMTP id bg2-20020a05600c3c8200b003b33080cff8so307239wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=c1bOOozDQ+6EDEHi9rJz7Dh4D3HKy76AxnObw13WaRU=;
        b=tnMQcENLsaTKNK+vHepfMsdcc7TpvgaFOkCIjvM9An0recFraxH/6Agb3Wsm6z0v5l
         4hemTlCSSpv+fNof0OYnlHejzDUI8/kpemCoujE6T9QVVy135KmAWioaR+Xu9DXJlRov
         IkHizUienDT2ndZThK5cwY7Sjnf3eynNlRZulQsXRie8+Lkze8l2H3fm8c8gDm+OiSaX
         A9sHQXBat8pgVxLT6Wo8Um9QpsDV7+P5ZIicrTYiysC/7ttlj73DO0tRqFzKs3aauo5F
         r2ou/u9r5dgTs+Y+fjMzzrtEWHTJFf+e5PtgnLjvafZ8Dmonrq9epnbjwz36OHjyehdy
         TI8w==
X-Gm-Message-State: ACgBeo3VPVzm62EGXxdFxAYkvGDh0ja5RgU2NZV+DcKE5qXgUgSx1POa
        irceeBIZDcp8LlwCGTroN09IT05Guu0G6/JsAqKVweGbBIsQUIJPhbOb24xIMNyILHyfy2d5lrC
        rqFNzaZVAoLScs3vPhDh+sGig
X-Received: by 2002:a05:6000:1564:b0:226:dece:5630 with SMTP id 4-20020a056000156400b00226dece5630mr5182615wrz.294.1662639695866;
        Thu, 08 Sep 2022 05:21:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4qTefM7C3hOHDgloIGu2LGoG5IyZ+iOfAi4b8sZRRTGe5uPr30mRtiOdC5OIy+Gk9Cj4U/Yg==
X-Received: by 2002:a05:6000:1564:b0:226:dece:5630 with SMTP id 4-20020a056000156400b00226dece5630mr5182595wrz.294.1662639695579;
        Thu, 08 Sep 2022 05:21:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id m18-20020adff392000000b00228b3ff1f5dsm16175779wro.117.2022.09.08.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:21:35 -0700 (PDT)
Message-ID: <b8d2fe17-93e6-743a-73c4-e8b22964704b@redhat.com>
Date:   Thu, 8 Sep 2022 14:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
References: <20220908075826.37094-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm: hugetlb: eliminate memory-less nodes handling
In-Reply-To: <20220908075826.37094-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.22 09:58, Muchun Song wrote:
> The memory-notify-based approach aims to handle meory-less nodes, however, it just adds
> the complexity of code as pointed by David in thread [1].  The handling of memory-less
> nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory hot-plug events").
>  From its commit message, we cannot find any necessity of handling this case. So, we can
> simply register/unregister sysfs entries in register_node/unregister_node to simlify the
> code.
> 
> BTW, hotplug callback added because in hugetlb_register_all_nodes() we register sysfs
> nodes only for N_MEMORY nodes, seeing commit 9b5e5d0fdc91, which said it was a preparation
> for handling memory-less nodes via memory hotplug. Since we want to remove memory hotplug,
> so make sure we only register per-node sysfs for online (N_ONLINE) nodes in
> hugetlb_register_all_nodes().
> 
> https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v3:
>   - Fix 'struct node' is not declared reported by LTP.
> 
> v2:
>   - Move declaration of function related to hugetlb to hugetlb.h (David).
>   - Introduce hugetlb_sysfs_initialized() and call it from hugetlb_sysfs_init() (David).
>   - Move hugetlb_register_all_nodes() into hugetlb_sysfs_init() (David).
>   - Fix implicit-function-declaration reported by LKP.
>   - Register per-node sysfs for online (N_ONLINE) nodes instead of N_MEMORY (Aneesh).
> 
>   drivers/base/node.c     |  8 +++--
>   include/linux/hugetlb.h | 14 +++++++++
>   mm/hugetlb.c            | 81 ++++++++++++++++++++++---------------------------
>   3 files changed, 57 insertions(+), 46 deletions(-)



> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3880,24 +3880,14 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>   	return 0;
>   }
>   
> -static void __init hugetlb_sysfs_init(void)
> -{
> -	struct hstate *h;
> -	int err;
> -
> -	hugepages_kobj = kobject_create_and_add("hugepages", mm_kobj);
> -	if (!hugepages_kobj)
> -		return;
> +#ifdef CONFIG_NUMA
> +static bool hugetlb_sysfs_initialized __ro_after_init;
>   
> -	for_each_hstate(h) {
> -		err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
> -					 hstate_kobjs, &hstate_attr_group);
> -		if (err)
> -			pr_err("HugeTLB: Unable to add hstate %s", h->name);
> -	}
> +static inline void hugetlb_mark_sysfs_initialized(void)
> +{
> +	hugetlb_sysfs_initialized = true;
>   }

Do we really need a separate function for this? Why not simply always 
set that from hugetlb_sysfs_init() ?

I'm also not sure if we really want to optimize out one variable for 
!CONFIG_NUMA.



Anyhow, in general

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

