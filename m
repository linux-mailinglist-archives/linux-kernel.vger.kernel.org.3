Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD85A9266
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiIAIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiIAIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678773339
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662022252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mB7ezn0iyp9ChcftBk9oPegsbCSz+N0Ye/fVxbqIEk=;
        b=D25fZ1X44U/8161o2vfMinP9CuPLLK+M7UEznwJMeKWWTZfJTpIijoF9c86ud1A39FfHwZ
        YybJqqsC4/UUyLtYbvMEPHC35Q/H3fq+369tD4Cr9wv4CBoij5OdUg588qVkYA6ppYKzE0
        rjpv5CLGXWWPGsJy5b010o34BRpVjp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-BhCLvWp4NyqlBhhtZP3h6g-1; Thu, 01 Sep 2022 04:50:51 -0400
X-MC-Unique: BhCLvWp4NyqlBhhtZP3h6g-1
Received: by mail-wm1-f69.google.com with SMTP id n7-20020a1c2707000000b003a638356355so9550768wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=1mB7ezn0iyp9ChcftBk9oPegsbCSz+N0Ye/fVxbqIEk=;
        b=CtO93fzm9V5YaK1/2oIIa3n8L9BMvchtoRg25FCO3ANUnIlaYjnDwKu0ik4P2LHqBI
         s1CXHk9JOF74FwCwuJyFhHkW74hHTeFCq05SkELYwU9G7FZuxZr+zQq0+YZVN9PHCdMO
         psFz5tlCNUuHwqVobBpoKE5VfSdQVcjYDZvB4ntQZON3l2HVH/aYz1YFNg9MKaiJ6Z+0
         qWvxUFNddpruSoa4+KVdxZdQfTYH/goDnYqgvosGRTWzKOH3StDZ3GqW9S37IW1+q8Ya
         7vH99OGMlzfk6HpkRdNh6vi66O0ySVKubTyXGYLnVKK8rCEsQJh/gxDmcYEbBpSznLHf
         3tEg==
X-Gm-Message-State: ACgBeo1y+V++uzDBUKwf7q8GsVagYT6OSEC+DBko1Lww3OWsk1WNl1Fo
        VQu03GSaWRaFS8gFVNFsgfXMlyS4WsCUbkw3I079dAxjQgrxdEWL8ryS6xbHqVmUCFptxvADvfH
        Bc3YjxdbjcFsZ9YjnHGZ6UWWj
X-Received: by 2002:a05:6000:2aa:b0:225:63d0:83aa with SMTP id l10-20020a05600002aa00b0022563d083aamr14274060wry.499.1662022250201;
        Thu, 01 Sep 2022 01:50:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6CHrqsgTkQ9IMmDx49M4N8jRa/DKqcq/ceGU0tz49TF74mXtjCTBTiR37Dpgk60uCLAyzZTA==
X-Received: by 2002:a05:6000:2aa:b0:225:63d0:83aa with SMTP id l10-20020a05600002aa00b0022563d083aamr14274041wry.499.1662022249860;
        Thu, 01 Sep 2022 01:50:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4848000000b00226d01a4635sm13974535wrs.35.2022.09.01.01.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:50:49 -0700 (PDT)
Message-ID: <afc8e20c-0317-afe8-ced5-320a575980ea@redhat.com>
Date:   Thu, 1 Sep 2022 10:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220901083023.42319-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
In-Reply-To: <20220901083023.42319-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 10:30, Muchun Song wrote:
> The memory-notify-based approach aims to handle meory-less nodes, however, it just adds
> the complexity of code as pointed by David in thread [1].  The handling of memory-less
> nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory hot-plug events").
> From its commit message, we cannot find any necessity of handling this case. So, we can
> simply register/unregister sysfs entries in register_node/unregister_node to simlify the
> code.
> 
> https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/base/node.c  |  7 +++++--
>  include/linux/node.h |  5 +++++
>  mm/hugetlb.c         | 37 ++++++++++---------------------------
>  3 files changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ed391cb09999..cf115d5a9b8a 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -608,10 +608,12 @@ static int register_node(struct node *node, int num)
>  	node->dev.groups = node_dev_groups;
>  	error = device_register(&node->dev);
>  
> -	if (error)
> +	if (error) {
>  		put_device(&node->dev);
> -	else
> +	} else {
> +		hugetlb_register_node(node);
>  		compaction_register_node(node);
> +	}

Good, so this matches what other code does.

>  
>  	return error;
>  }
> @@ -625,6 +627,7 @@ static int register_node(struct node *node, int num)
>   */
>  void unregister_node(struct node *node)
>  {
> +	hugetlb_unregister_node(node);
>  	compaction_unregister_node(node);
>  	node_remove_accesses(node);
>  	node_remove_caches(node);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 427a5975cf40..f5d41498c2bf 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -138,6 +138,11 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>  extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>  						   unsigned int cpu_nid,
>  						   unsigned access);
> +
> +#ifdef CONFIG_HUGETLBFS
> +void hugetlb_register_node(struct node *node);
> +void hugetlb_unregister_node(struct node *node);
> +#endif

compaction_register_node() resides in include/linux/compaction.h, so I
wonder if this should go into hugetlb.h (unless it causes trouble)

>  #else
>  static inline void node_dev_init(void)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..722e862bb6be 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3898,6 +3898,7 @@ static void __init hugetlb_sysfs_init(void)
>  }
>  
>  #ifdef CONFIG_NUMA
> +static bool hugetlb_initialized __ro_after_init;

We set it out of hugetlb_register_all_nodes(), so it conceptually not
correct. We either need a better name here or set it from generic init code.

You could call it hugetlb_sysfs_initialized() and set that from
hugetlb_sysfs_init(), which is called just before
hugetlb_register_all_nodes().

[ shouldn't hugetlb_register_all_nodes() get called from
hugetlb_sysfs_init() ? it's all about sysfs as well ... ]

>  
>  /*
>   * node_hstate/s - associate per node hstate attributes, via their kobjects,
> @@ -3953,7 +3954,7 @@ static struct hstate *kobj_to_node_hstate(struct kobject *kobj, int *nidp)
>   * Unregister hstate attributes from a single node device.
>   * No-op if no hstate attributes attached.
>   */
> -static void hugetlb_unregister_node(struct node *node)
> +void hugetlb_unregister_node(struct node *node)
>  {
>  	struct hstate *h;
>  	struct node_hstate *nhs = &node_hstates[node->dev.id];
> @@ -3983,19 +3984,22 @@ static void hugetlb_unregister_node(struct node *node)
>   * Register hstate attributes for a single node device.
>   * No-op if attributes already registered.
>   */
> -static int hugetlb_register_node(struct node *node)
> +void hugetlb_register_node(struct node *node)
>  {
>  	struct hstate *h;
>  	struct node_hstate *nhs = &node_hstates[node->dev.id];
>  	int err;
>  
> +	if (!hugetlb_initialized)
> +		return;
> +
>  	if (nhs->hugepages_kobj)
> -		return 0;		/* already allocated */
> +		return;		/* already allocated */
>  
>  	nhs->hugepages_kobj = kobject_create_and_add("hugepages",
>  							&node->dev.kobj);
>  	if (!nhs->hugepages_kobj)
> -		return -ENOMEM;
> +		return;
>  
>  	for_each_hstate(h) {
>  		err = hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
> @@ -4005,28 +4009,9 @@ static int hugetlb_register_node(struct node *node)
>  			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
>  				h->name, node->dev.id);
>  			hugetlb_unregister_node(node);
> -			return -ENOMEM;
> +			break;
>  		}
>  	}
> -	return 0;
> -}
> -
> -static int __meminit hugetlb_memory_callback(struct notifier_block *self,
> -					     unsigned long action, void *arg)
> -{
> -	int ret = 0;
> -	struct memory_notify *mnb = arg;
> -	int nid = mnb->status_change_nid;
> -
> -	if (nid == NUMA_NO_NODE)
> -		return NOTIFY_DONE;
> -
> -	if (action == MEM_GOING_ONLINE)
> -		ret = hugetlb_register_node(node_devices[nid]);
> -	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
> -		hugetlb_unregister_node(node_devices[nid]);
> -
> -	return notifier_from_errno(ret);
>  }
>  
>  /*
> @@ -4038,11 +4023,9 @@ static void __init hugetlb_register_all_nodes(void)
>  {
>  	int nid;
>  
> -	get_online_mems();
> -	hotplug_memory_notifier(hugetlb_memory_callback, 0);
> +	hugetlb_initialized = true;
>  	for_each_node_state(nid, N_MEMORY)
>  		hugetlb_register_node(node_devices[nid]);
> -	put_online_mems();
>  }
>  #else	/* !CONFIG_NUMA */
>  

Apart from the comments, looks good and clean to me. Thanks!

-- 
Thanks,

David / dhildenb

