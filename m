Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10775A8EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiIAG56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIAG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD13120F8F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662015471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGBsp8/YfADsG+07MiqOBFMVvtF7ThPtdD2L04nbutQ=;
        b=U5obhlaKHwwSs+tBbUABighj/UtYPRRLghJ4b3/U9XOLMx29pZnB+Uavnzux4LdMIFPQHK
        6u1hSUi5wSmPZRsXl09+/R5tVNyOuKhFDMvzdCYUGw/gVBQtcsBR+Nnlq07ncjYHCsDVNu
        hu7o5Gl5C4XI4D8O7qCduWrbV8gZiek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-U8DWIaq7PO2OkgfPv9mfGA-1; Thu, 01 Sep 2022 02:57:49 -0400
X-MC-Unique: U8DWIaq7PO2OkgfPv9mfGA-1
Received: by mail-wr1-f72.google.com with SMTP id h16-20020adfaa90000000b00226e36cc014so1445723wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WGBsp8/YfADsG+07MiqOBFMVvtF7ThPtdD2L04nbutQ=;
        b=lgaa9bBsugahRGz3I/IyRXFMpQ+7w2eJTq7WochTNpSR5sjSOsF3VzsEEkyBbsNnXT
         YpOdXnAfVCpAz50Dcsgexn3ODNmgtT3yioqkC27/jSSl+4c/a8lFEL52BBUVqOHw1sed
         NXbI7SL3GE5OFAlpEIgmZm3cEt4XsOsK1cF9yw10BOOgJyT4p5ZrRj3Kjtjg7JGCiR7D
         Hcnq3hVPyrfvxdB3rWERxixw5OPQiJTdEvTheaJga3M+K6LuOQE8AZGS5SVoPrJsUyp6
         92Bc3DW8TQZIxIICj2Scvt3fwZoxnB05EQyxpHMYNqvrD1Hmg+BJjeOZ0ZUTZSJrINPo
         sZLA==
X-Gm-Message-State: ACgBeo3garZf2ACMIVmUUgqM87npgW91EzIJJuVUbhnF0VvISyvMYjDj
        azudKwbxN1GO/heHOD5DE2dzFyJA6Py0uxoWfxaEbEjct68HAOBdSQdgh7rMJMApz7mycbgYd8x
        yCE71TAqhU0t4ChIRFcAjyGDZ
X-Received: by 2002:a05:6000:1563:b0:222:c827:1a19 with SMTP id 3-20020a056000156300b00222c8271a19mr13328997wrz.705.1662015468678;
        Wed, 31 Aug 2022 23:57:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5mJHY5ht5hskPoGrlBOujfn7oZJGESLD9rrJV6B+HJOGJDhQH/AR12e1myIPVQZaDeiRqDyw==
X-Received: by 2002:a05:6000:1563:b0:222:c827:1a19 with SMTP id 3-20020a056000156300b00222c8271a19mr13328976wrz.705.1662015468281;
        Wed, 31 Aug 2022 23:57:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b003a6125562e1sm4787902wmq.46.2022.08.31.23.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 23:57:47 -0700 (PDT)
Message-ID: <a4275591-46bc-009b-c67d-8a474a57d2d6@redhat.com>
Date:   Thu, 1 Sep 2022 08:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, andi@firstfloor.org,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
References: <20220819080029.12241-1-songmuchun@bytedance.com>
 <60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com>
 <685F3238-D727-4C1F-9BA4-36651ABCD91A@linux.dev>
 <E4D5CD53-99A9-479E-AF4C-6653852D8A98@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RESEND] mm: hugetlb: simplify per-node sysfs creation and
 removal
In-Reply-To: <E4D5CD53-99A9-479E-AF4C-6653852D8A98@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 08:35, Muchun Song wrote:
> 
> 
>> On Aug 24, 2022, at 11:23, Muchun Song <muchun.song@linux.dev> wrote:
>>
>>
>>
>>> On Aug 23, 2022, at 18:21, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 19.08.22 10:00, Muchun Song wrote:
>>>> The following commit offload per-node sysfs creation and removal to a kworker and
>>>> did not say why it is needed.  And it also said "I don't know that this is
>>>> absolutely required".  It seems like the author was not sure as well.  Since it
>>>> only complicates the code, this patch will revert the changes to simplify the code.
>>>>
>>>> 39da08cb074c ("hugetlb: offload per node attribute registrations")
>>>>
>>>> We could use memory hotplug notifier to do per-node sysfs creation and removal
>>>> instead of inserting those operations to node registration and unregistration.
>>>> Then, it can reduce the code coupling between node.c and hugetlb.c.  Also, it can
>>>> simplify the code.
>>>>
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>
>>>
>>> [...]
>>>
>>>> @@ -683,7 +626,6 @@ static int register_node(struct node *node, int num)
>>>> void unregister_node(struct node *node)
>>>> {
>>>> 	compaction_unregister_node(node);
>>>> -	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
>>>> 	node_remove_accesses(node);
>>>> 	node_remove_caches(node);
>>>> 	device_unregister(&node->dev);
>>>> @@ -905,74 +847,8 @@ void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
>>>> 			   (void *)&nid, func);
>>>> 	return;
>>>> }
>>>
>>> [...]
>>>
>>>> 	/*
>>>> 	 * Create all node devices, which will properly link the node
>>>> 	 * to applicable memory block devices and already created cpu devices.
>>>> diff --git a/include/linux/node.h b/include/linux/node.h
>>>> index 40d641a8bfb0..ea817b507f54 100644
>>>> --- a/include/linux/node.h
>>>> +++ b/include/linux/node.h
>>>> @@ -2,15 +2,15 @@
>>>> /*
>>>> * include/linux/node.h - generic node definition
>>>> *
>>>> - * This is mainly for topological representation. We define the 
>>>> - * basic 'struct node' here, which can be embedded in per-arch 
>>>> + * This is mainly for topological representation. We define the
>>>> + * basic 'struct node' here, which can be embedded in per-arch
>>>> * definitions of processors.
>>>> *
>>>> * Basic handling of the devices is done in drivers/base/node.c
>>>> - * and system devices are handled in drivers/base/sys.c. 
>>>> + * and system devices are handled in drivers/base/sys.c.
>>>> *
>>>> * Nodes are exported via driverfs in the class/node/devices/
>>>> - * directory. 
>>>> + * directory.
>>>
>>> Unrelated changes.
>>
>> Yep, a minor cleanup BTW.
>>
>>>
>>>> */
>>>> #ifndef _LINUX_NODE_H_
>>>> #define _LINUX_NODE_H_
>>>> @@ -18,7 +18,6 @@
>>>> #include <linux/device.h>
>>>> #include <linux/cpumask.h>
>>>> #include <linux/list.h>
>>>> -#include <linux/workqueue.h>
>>>>
>>>> /**
>>>> * struct node_hmem_attrs - heterogeneous memory performance attributes
>>>> @@ -84,10 +83,6 @@ static inline void node_set_perf_attrs(unsigned int nid,
>>>> struct node {
>>>> 	struct device	dev;
>>>> 	struct list_head access_list;
>>>> -
>>>> -#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
>>>> -	struct work_struct	node_work;
>>>> -#endif
>>>> #ifdef CONFIG_HMEM_REPORTING
>>>> 	struct list_head cache_attrs;
>>>> 	struct device *cache_dev;
>>>> @@ -96,7 +91,6 @@ struct node {
>>>>
>>>> struct memory_block;
>>>> extern struct node *node_devices[];
>>>> -typedef  void (*node_registration_func_t)(struct node *);
>>>>
>>>> #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
>>>> void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
>>>> @@ -144,11 +138,6 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>>>> extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>>>> 						   unsigned int cpu_nid,
>>>> 						   unsigned access);
>>>> -
>>>> -#ifdef CONFIG_HUGETLBFS
>>>> -extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
>>>> -					 node_registration_func_t unregister);
>>>> -#endif
>>>> #else
>>>> static inline void node_dev_init(void)
>>>> {
>>>> @@ -176,11 +165,6 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>>>> static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>>>> {
>>>> }
>>>> -
>>>> -static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>>>> -						node_registration_func_t unreg)
>>>> -{
>>>> -}
>>>> #endif
>>>>
>>>> #define to_node(device) container_of(device, struct node, dev)
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 536a52c29035..9a72499486c1 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -33,6 +33,7 @@
>>>> #include <linux/migrate.h>
>>>> #include <linux/nospec.h>
>>>> #include <linux/delayacct.h>
>>>> +#include <linux/memory.h>
>>>>
>>>> #include <asm/page.h>
>>>> #include <asm/pgalloc.h>
>>>> @@ -3967,19 +3968,19 @@ static void hugetlb_unregister_node(struct node *node)
>>>> * Register hstate attributes for a single node device.
>>>> * No-op if attributes already registered.
>>>> */
>>>> -static void hugetlb_register_node(struct node *node)
>>>> +static int hugetlb_register_node(struct node *node)
>>>> {
>>>> 	struct hstate *h;
>>>> 	struct node_hstate *nhs = &node_hstates[node->dev.id];
>>>> 	int err;
>>>>
>>>> 	if (nhs->hugepages_kobj)
>>>> -		return;		/* already allocated */
>>>> +		return 0;		/* already allocated */
>>>>
>>>> 	nhs->hugepages_kobj = kobject_create_and_add("hugepages",
>>>> 							&node->dev.kobj);
>>>> 	if (!nhs->hugepages_kobj)
>>>> -		return;
>>>> +		return -ENOMEM;
>>>>
>>>> 	for_each_hstate(h) {
>>>> 		err = hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
>>>> @@ -3989,9 +3990,28 @@ static void hugetlb_register_node(struct node *node)
>>>> 			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
>>>> 				h->name, node->dev.id);
>>>> 			hugetlb_unregister_node(node);
>>>> -			break;
>>>> +			return -ENOMEM;
>>>> 		}
>>>> 	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int __meminit hugetlb_memory_callback(struct notifier_block *self,
>>>> +					     unsigned long action, void *arg)
>>>> +{
>>>> +	int ret = 0;
>>>> +	struct memory_notify *mnb = arg;
>>>> +	int nid = mnb->status_change_nid;
>>>> +
>>>> +	if (nid == NUMA_NO_NODE)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	if (action == MEM_GOING_ONLINE)
>>>> +		ret = hugetlb_register_node(node_devices[nid]);
>>>> +	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
>>>> +		hugetlb_unregister_node(node_devices[nid]);
>>>> +
>>>> +	return notifier_from_errno(ret);
>>>> }
>>>>
>>>> /*
>>>> @@ -4003,18 +4023,11 @@ static void __init hugetlb_register_all_nodes(void)
>>>> {
>>>> 	int nid;
>>>>
>>>> -	for_each_node_state(nid, N_MEMORY) {
>>>> -		struct node *node = node_devices[nid];
>>>> -		if (node->dev.id == nid)
>>>> -			hugetlb_register_node(node);
>>>> -	}
>>>> -
>>>> -	/*
>>>> -	 * Let the node device driver know we're here so it can
>>>> -	 * [un]register hstate attributes on node hotplug.
>>>> -	 */
>>>> -	register_hugetlbfs_with_node(hugetlb_register_node,
>>>> -				     hugetlb_unregister_node);
>>>> +	get_online_mems();
>>>> +	hotplug_memory_notifier(hugetlb_memory_callback, 0);
>>>> +	for_each_node_state(nid, N_MEMORY)
>>>> +		hugetlb_register_node(node_devices[nid]);
>>>> +	put_online_mems();
>>>> }
>>>> #else	/* !CONFIG_NUMA */
>>>
>>> Do we really *need* the memory hotplug notifier and the added complexity
>>> due for handling memory-less nodes?
> 
> Hi David,
> 

Hi,

thanks for playing with the idea.

> After some tries, I think it may not reduce the complexity. node_dev_init()
> is called at early stage before hugetlb_register_all_nodes(). So we need to
> add a mechanism to detect if the hugetlb subsystem finishes initialization
> in node_dev_init() so that it can determine to help hugetlb create /sysfs
> files, the mechanism is similar with the changes in drivers/base/node.c of
> commit 9a30523066cd ("hugetlb: add per node hstate attributes”). This approach

If I'm not wrong, all you need is a single call from node_dev_init()
into hugetlb code.

There, you create the hugetlb sysfs if hugetlb was already initialized,
otherwise it's a NOP as you initialize when hugetlb gets initialized.

When initializing hugetlb, you go over all added nodes and create
hugetlb sysfs.

Testing/remembering if hugetlb was initialized should be easy, no?

What's the complicated part I am missing?

> may add more code than the memory-notify-based approach like this patch
> implemented. And it also add the code coupling between node.c and hugetlb.c.
> So I tend to use memory hotplug notifier. What’s your opinion?

We have hugetlb special casing all over the place, it's an integral MM
part -- not some random driver where we'd really want decoupling.

So I don't see why the decouling would be beneficial here and how using
the memory notifier is any better then a simple callback.


But again, I did not look into the details of the necessary implementation.

Thanks!


-- 
Thanks,

David / dhildenb

