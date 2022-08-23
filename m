Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0959E5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiHWPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiHWPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C0CD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661250098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQgsmCPlb+zxinxjCoRmOdMYgNutUmbY+EPSFFWc23Q=;
        b=CZMjzp02fREgYFPGY5tlSfiMRziXd8VzJrN9bKdbLiQnbNBccwDAg4bMcx2OuuIuhpT8ml
        CBDDDtr1NUqHI5RThVM3Wbac2EEfLefBq7EkZoA+RQpRd7a/kF0wCt4Wg6Bf1ug60B4mno
        XqiPdEm0bGMWsIAONICua2WPfVnyVXQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-O0o1BMRhOM-NYi4o6WwSOw-1; Tue, 23 Aug 2022 06:21:37 -0400
X-MC-Unique: O0o1BMRhOM-NYi4o6WwSOw-1
Received: by mail-wr1-f72.google.com with SMTP id r23-20020adfa157000000b00225660d47b7so272452wrr.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=pQgsmCPlb+zxinxjCoRmOdMYgNutUmbY+EPSFFWc23Q=;
        b=aLF4flKUjrxYotzzSBazJhhbX6n4X0RURTem51BiGOEXm2QzkZdM/e8aq28NeB6jZq
         LjNbgjmcOcjpDGDYaAzQ2boa2uYveOn/mxeBZivv1CwtM2n6vfPxRMVPEPtKsuYQ3ZcI
         TjJzGelOpbesoJilSQnGZqnj0WnvVSgEql0X84mRWKzZabskood5ogoB8HkBisLl1oh3
         OjOh84nzvTDV4x4oWhSVVSlwjJqjs2LZwr7sbHW3fuWBDHIcPJVXuCzImUsm09tOGQt0
         y3QTl6nJ+9p7lFjGNE4vidK0eZTIfp7drxDVrH4CRKUG90zHwwST544bJEnkZHj3JrZd
         pKZw==
X-Gm-Message-State: ACgBeo2iySlaE25lMk0li2eCn/ZRcXPwnWu8e90PjIA7V6yc/aMakurb
        nyplV6igI0NWz6tabuP481oKP8oGH2ykV+h3NPCE9Dcar7+g+7vcG3KLj2nGRDkGCLhSXmTbHk3
        AxPfoJmeC4vAAcWrCYvNKFHL7
X-Received: by 2002:a1c:7c18:0:b0:3a5:aaae:d203 with SMTP id x24-20020a1c7c18000000b003a5aaaed203mr1753541wmc.2.1661250095732;
        Tue, 23 Aug 2022 03:21:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5jY1+l93jubKbrfBeLVufXcUK74eww7Bkgb5AljLD0KmIpk2K/goe1cipCs3utuQsv7ZHgIg==
X-Received: by 2002:a1c:7c18:0:b0:3a5:aaae:d203 with SMTP id x24-20020a1c7c18000000b003a5aaaed203mr1753517wmc.2.1661250095401;
        Tue, 23 Aug 2022 03:21:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id t185-20020a1c46c2000000b003a673055e68sm5361666wma.0.2022.08.23.03.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:21:34 -0700 (PDT)
Message-ID: <60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com>
Date:   Tue, 23 Aug 2022 12:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, andi@firstfloor.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
References: <20220819080029.12241-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RESEND] mm: hugetlb: simplify per-node sysfs creation and
 removal
In-Reply-To: <20220819080029.12241-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 10:00, Muchun Song wrote:
> The following commit offload per-node sysfs creation and removal to a kworker and
> did not say why it is needed.  And it also said "I don't know that this is
> absolutely required".  It seems like the author was not sure as well.  Since it
> only complicates the code, this patch will revert the changes to simplify the code.
> 
>   39da08cb074c ("hugetlb: offload per node attribute registrations")
> 
> We could use memory hotplug notifier to do per-node sysfs creation and removal
> instead of inserting those operations to node registration and unregistration.
> Then, it can reduce the code coupling between node.c and hugetlb.c.  Also, it can
> simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>


[...]

> @@ -683,7 +626,6 @@ static int register_node(struct node *node, int num)
>  void unregister_node(struct node *node)
>  {
>  	compaction_unregister_node(node);
> -	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
>  	node_remove_accesses(node);
>  	node_remove_caches(node);
>  	device_unregister(&node->dev);
> @@ -905,74 +847,8 @@ void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
>  			   (void *)&nid, func);
>  	return;
>  }

[...]

>  	/*
>  	 * Create all node devices, which will properly link the node
>  	 * to applicable memory block devices and already created cpu devices.
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 40d641a8bfb0..ea817b507f54 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -2,15 +2,15 @@
>  /*
>   * include/linux/node.h - generic node definition
>   *
> - * This is mainly for topological representation. We define the 
> - * basic 'struct node' here, which can be embedded in per-arch 
> + * This is mainly for topological representation. We define the
> + * basic 'struct node' here, which can be embedded in per-arch
>   * definitions of processors.
>   *
>   * Basic handling of the devices is done in drivers/base/node.c
> - * and system devices are handled in drivers/base/sys.c. 
> + * and system devices are handled in drivers/base/sys.c.
>   *
>   * Nodes are exported via driverfs in the class/node/devices/
> - * directory. 
> + * directory.

Unrelated changes.

>   */
>  #ifndef _LINUX_NODE_H_
>  #define _LINUX_NODE_H_
> @@ -18,7 +18,6 @@
>  #include <linux/device.h>
>  #include <linux/cpumask.h>
>  #include <linux/list.h>
> -#include <linux/workqueue.h>
>  
>  /**
>   * struct node_hmem_attrs - heterogeneous memory performance attributes
> @@ -84,10 +83,6 @@ static inline void node_set_perf_attrs(unsigned int nid,
>  struct node {
>  	struct device	dev;
>  	struct list_head access_list;
> -
> -#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
> -	struct work_struct	node_work;
> -#endif
>  #ifdef CONFIG_HMEM_REPORTING
>  	struct list_head cache_attrs;
>  	struct device *cache_dev;
> @@ -96,7 +91,6 @@ struct node {
>  
>  struct memory_block;
>  extern struct node *node_devices[];
> -typedef  void (*node_registration_func_t)(struct node *);
>  
>  #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
>  void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
> @@ -144,11 +138,6 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>  extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>  						   unsigned int cpu_nid,
>  						   unsigned access);
> -
> -#ifdef CONFIG_HUGETLBFS
> -extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
> -					 node_registration_func_t unregister);
> -#endif
>  #else
>  static inline void node_dev_init(void)
>  {
> @@ -176,11 +165,6 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
>  }
> -
> -static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
> -						node_registration_func_t unreg)
> -{
> -}
>  #endif
>  
>  #define to_node(device) container_of(device, struct node, dev)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 536a52c29035..9a72499486c1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -33,6 +33,7 @@
>  #include <linux/migrate.h>
>  #include <linux/nospec.h>
>  #include <linux/delayacct.h>
> +#include <linux/memory.h>
>  
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
> @@ -3967,19 +3968,19 @@ static void hugetlb_unregister_node(struct node *node)
>   * Register hstate attributes for a single node device.
>   * No-op if attributes already registered.
>   */
> -static void hugetlb_register_node(struct node *node)
> +static int hugetlb_register_node(struct node *node)
>  {
>  	struct hstate *h;
>  	struct node_hstate *nhs = &node_hstates[node->dev.id];
>  	int err;
>  
>  	if (nhs->hugepages_kobj)
> -		return;		/* already allocated */
> +		return 0;		/* already allocated */
>  
>  	nhs->hugepages_kobj = kobject_create_and_add("hugepages",
>  							&node->dev.kobj);
>  	if (!nhs->hugepages_kobj)
> -		return;
> +		return -ENOMEM;
>  
>  	for_each_hstate(h) {
>  		err = hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
> @@ -3989,9 +3990,28 @@ static void hugetlb_register_node(struct node *node)
>  			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
>  				h->name, node->dev.id);
>  			hugetlb_unregister_node(node);
> -			break;
> +			return -ENOMEM;
>  		}
>  	}
> +	return 0;
> +}
> +
> +static int __meminit hugetlb_memory_callback(struct notifier_block *self,
> +					     unsigned long action, void *arg)
> +{
> +	int ret = 0;
> +	struct memory_notify *mnb = arg;
> +	int nid = mnb->status_change_nid;
> +
> +	if (nid == NUMA_NO_NODE)
> +		return NOTIFY_DONE;
> +
> +	if (action == MEM_GOING_ONLINE)
> +		ret = hugetlb_register_node(node_devices[nid]);
> +	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
> +		hugetlb_unregister_node(node_devices[nid]);
> +
> +	return notifier_from_errno(ret);
>  }
>  
>  /*
> @@ -4003,18 +4023,11 @@ static void __init hugetlb_register_all_nodes(void)
>  {
>  	int nid;
>  
> -	for_each_node_state(nid, N_MEMORY) {
> -		struct node *node = node_devices[nid];
> -		if (node->dev.id == nid)
> -			hugetlb_register_node(node);
> -	}
> -
> -	/*
> -	 * Let the node device driver know we're here so it can
> -	 * [un]register hstate attributes on node hotplug.
> -	 */
> -	register_hugetlbfs_with_node(hugetlb_register_node,
> -				     hugetlb_unregister_node);
> +	get_online_mems();
> +	hotplug_memory_notifier(hugetlb_memory_callback, 0);
> +	for_each_node_state(nid, N_MEMORY)
> +		hugetlb_register_node(node_devices[nid]);
> +	put_online_mems();
>  }
>  #else	/* !CONFIG_NUMA */

Do we really *need* the memory hotplug notifier and the added complexity
due for handling memory-less nodes?

Why can't we simply register/unregister sysfs entries in
register_node/unregister_node and call it a day?

TBH, we should just have sysfs entries for memory-less nodes and not
care about such (corner) cases.


-- 
Thanks,

David / dhildenb

