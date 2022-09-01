Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28E5A915F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiIAH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIAH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:57:58 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F16DACF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:57:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662019075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOLDyKdiPhFlh4WmkEarh53OzwSROxQP3WeBmB3H1FM=;
        b=Oei01HrunZV5olAERS8QDFBFvVlniefnQiREJ41unLrddclCjlyBWIAi0g2y9d9wfpZM/J
        XkRN2hqDQ7JeHjFk7Lu7+Ow+4fv54NA7rLYqXKGEVK99Wo3TqH1MyesgJNDHE7dIpGpCqg
        1mttfiTbcU6MS9T2W7mFH0uey6rHyD4=
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] mm: hugetlb: simplify per-node sysfs creation and
 removal
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <a4275591-46bc-009b-c67d-8a474a57d2d6@redhat.com>
Date:   Thu, 1 Sep 2022 15:57:22 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, andi@firstfloor.org,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <14561845-1C68-42FE-8E05-309FDC3E9D28@linux.dev>
References: <20220819080029.12241-1-songmuchun@bytedance.com>
 <60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com>
 <685F3238-D727-4C1F-9BA4-36651ABCD91A@linux.dev>
 <E4D5CD53-99A9-479E-AF4C-6653852D8A98@linux.dev>
 <a4275591-46bc-009b-c67d-8a474a57d2d6@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 1, 2022, at 14:57, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 01.09.22 08:35, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 24, 2022, at 11:23, Muchun Song <muchun.song@linux.dev> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On Aug 23, 2022, at 18:21, David Hildenbrand <david@redhat.com> =
wrote:
>>>>=20
>>>> On 19.08.22 10:00, Muchun Song wrote:
>>>>> The following commit offload per-node sysfs creation and removal =
to a kworker and
>>>>> did not say why it is needed.  And it also said "I don't know that =
this is
>>>>> absolutely required".  It seems like the author was not sure as =
well.  Since it
>>>>> only complicates the code, this patch will revert the changes to =
simplify the code.
>>>>>=20
>>>>> 39da08cb074c ("hugetlb: offload per node attribute registrations")
>>>>>=20
>>>>> We could use memory hotplug notifier to do per-node sysfs creation =
and removal
>>>>> instead of inserting those operations to node registration and =
unregistration.
>>>>> Then, it can reduce the code coupling between node.c and =
hugetlb.c.  Also, it can
>>>>> simplify the code.
>>>>>=20
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>=20
>>>>=20
>>>> [...]
>>>>=20
>>>>> @@ -683,7 +626,6 @@ static int register_node(struct node *node, =
int num)
>>>>> void unregister_node(struct node *node)
>>>>> {
>>>>> 	compaction_unregister_node(node);
>>>>> -	hugetlb_unregister_node(node);		/* no-op, if memoryless =
node */
>>>>> 	node_remove_accesses(node);
>>>>> 	node_remove_caches(node);
>>>>> 	device_unregister(&node->dev);
>>>>> @@ -905,74 +847,8 @@ void register_memory_blocks_under_node(int =
nid, unsigned long start_pfn,
>>>>> 			   (void *)&nid, func);
>>>>> 	return;
>>>>> }
>>>>=20
>>>> [...]
>>>>=20
>>>>> 	/*
>>>>> 	 * Create all node devices, which will properly link the node
>>>>> 	 * to applicable memory block devices and already created cpu =
devices.
>>>>> diff --git a/include/linux/node.h b/include/linux/node.h
>>>>> index 40d641a8bfb0..ea817b507f54 100644
>>>>> --- a/include/linux/node.h
>>>>> +++ b/include/linux/node.h
>>>>> @@ -2,15 +2,15 @@
>>>>> /*
>>>>> * include/linux/node.h - generic node definition
>>>>> *
>>>>> - * This is mainly for topological representation. We define the=20=

>>>>> - * basic 'struct node' here, which can be embedded in per-arch=20
>>>>> + * This is mainly for topological representation. We define the
>>>>> + * basic 'struct node' here, which can be embedded in per-arch
>>>>> * definitions of processors.
>>>>> *
>>>>> * Basic handling of the devices is done in drivers/base/node.c
>>>>> - * and system devices are handled in drivers/base/sys.c.=20
>>>>> + * and system devices are handled in drivers/base/sys.c.
>>>>> *
>>>>> * Nodes are exported via driverfs in the class/node/devices/
>>>>> - * directory.=20
>>>>> + * directory.
>>>>=20
>>>> Unrelated changes.
>>>=20
>>> Yep, a minor cleanup BTW.
>>>=20
>>>>=20
>>>>> */
>>>>> #ifndef _LINUX_NODE_H_
>>>>> #define _LINUX_NODE_H_
>>>>> @@ -18,7 +18,6 @@
>>>>> #include <linux/device.h>
>>>>> #include <linux/cpumask.h>
>>>>> #include <linux/list.h>
>>>>> -#include <linux/workqueue.h>
>>>>>=20
>>>>> /**
>>>>> * struct node_hmem_attrs - heterogeneous memory performance =
attributes
>>>>> @@ -84,10 +83,6 @@ static inline void node_set_perf_attrs(unsigned =
int nid,
>>>>> struct node {
>>>>> 	struct device	dev;
>>>>> 	struct list_head access_list;
>>>>> -
>>>>> -#if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_HUGETLBFS)
>>>>> -	struct work_struct	node_work;
>>>>> -#endif
>>>>> #ifdef CONFIG_HMEM_REPORTING
>>>>> 	struct list_head cache_attrs;
>>>>> 	struct device *cache_dev;
>>>>> @@ -96,7 +91,6 @@ struct node {
>>>>>=20
>>>>> struct memory_block;
>>>>> extern struct node *node_devices[];
>>>>> -typedef  void (*node_registration_func_t)(struct node *);
>>>>>=20
>>>>> #if defined(CONFIG_MEMORY_HOTPLUG) && defined(CONFIG_NUMA)
>>>>> void register_memory_blocks_under_node(int nid, unsigned long =
start_pfn,
>>>>> @@ -144,11 +138,6 @@ extern void =
unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>>>>> extern int register_memory_node_under_compute_node(unsigned int =
mem_nid,
>>>>> 						   unsigned int cpu_nid,
>>>>> 						   unsigned access);
>>>>> -
>>>>> -#ifdef CONFIG_HUGETLBFS
>>>>> -extern void register_hugetlbfs_with_node(node_registration_func_t =
doregister,
>>>>> -					 node_registration_func_t =
unregister);
>>>>> -#endif
>>>>> #else
>>>>> static inline void node_dev_init(void)
>>>>> {
>>>>> @@ -176,11 +165,6 @@ static inline int =
unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>>>>> static inline void unregister_memory_block_under_nodes(struct =
memory_block *mem_blk)
>>>>> {
>>>>> }
>>>>> -
>>>>> -static inline void =
register_hugetlbfs_with_node(node_registration_func_t reg,
>>>>> -						node_registration_func_t =
unreg)
>>>>> -{
>>>>> -}
>>>>> #endif
>>>>>=20
>>>>> #define to_node(device) container_of(device, struct node, dev)
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 536a52c29035..9a72499486c1 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -33,6 +33,7 @@
>>>>> #include <linux/migrate.h>
>>>>> #include <linux/nospec.h>
>>>>> #include <linux/delayacct.h>
>>>>> +#include <linux/memory.h>
>>>>>=20
>>>>> #include <asm/page.h>
>>>>> #include <asm/pgalloc.h>
>>>>> @@ -3967,19 +3968,19 @@ static void hugetlb_unregister_node(struct =
node *node)
>>>>> * Register hstate attributes for a single node device.
>>>>> * No-op if attributes already registered.
>>>>> */
>>>>> -static void hugetlb_register_node(struct node *node)
>>>>> +static int hugetlb_register_node(struct node *node)
>>>>> {
>>>>> 	struct hstate *h;
>>>>> 	struct node_hstate *nhs =3D &node_hstates[node->dev.id];
>>>>> 	int err;
>>>>>=20
>>>>> 	if (nhs->hugepages_kobj)
>>>>> -		return;		/* already allocated */
>>>>> +		return 0;		/* already allocated */
>>>>>=20
>>>>> 	nhs->hugepages_kobj =3D kobject_create_and_add("hugepages",
>>>>> 							=
&node->dev.kobj);
>>>>> 	if (!nhs->hugepages_kobj)
>>>>> -		return;
>>>>> +		return -ENOMEM;
>>>>>=20
>>>>> 	for_each_hstate(h) {
>>>>> 		err =3D hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
>>>>> @@ -3989,9 +3990,28 @@ static void hugetlb_register_node(struct =
node *node)
>>>>> 			pr_err("HugeTLB: Unable to add hstate %s for =
node %d\n",
>>>>> 				h->name, node->dev.id);
>>>>> 			hugetlb_unregister_node(node);
>>>>> -			break;
>>>>> +			return -ENOMEM;
>>>>> 		}
>>>>> 	}
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int __meminit hugetlb_memory_callback(struct =
notifier_block *self,
>>>>> +					     unsigned long action, void =
*arg)
>>>>> +{
>>>>> +	int ret =3D 0;
>>>>> +	struct memory_notify *mnb =3D arg;
>>>>> +	int nid =3D mnb->status_change_nid;
>>>>> +
>>>>> +	if (nid =3D=3D NUMA_NO_NODE)
>>>>> +		return NOTIFY_DONE;
>>>>> +
>>>>> +	if (action =3D=3D MEM_GOING_ONLINE)
>>>>> +		ret =3D hugetlb_register_node(node_devices[nid]);
>>>>> +	else if (action =3D=3D MEM_CANCEL_ONLINE || action =3D=3D =
MEM_OFFLINE)
>>>>> +		hugetlb_unregister_node(node_devices[nid]);
>>>>> +
>>>>> +	return notifier_from_errno(ret);
>>>>> }
>>>>>=20
>>>>> /*
>>>>> @@ -4003,18 +4023,11 @@ static void __init =
hugetlb_register_all_nodes(void)
>>>>> {
>>>>> 	int nid;
>>>>>=20
>>>>> -	for_each_node_state(nid, N_MEMORY) {
>>>>> -		struct node *node =3D node_devices[nid];
>>>>> -		if (node->dev.id =3D=3D nid)
>>>>> -			hugetlb_register_node(node);
>>>>> -	}
>>>>> -
>>>>> -	/*
>>>>> -	 * Let the node device driver know we're here so it can
>>>>> -	 * [un]register hstate attributes on node hotplug.
>>>>> -	 */
>>>>> -	register_hugetlbfs_with_node(hugetlb_register_node,
>>>>> -				     hugetlb_unregister_node);
>>>>> +	get_online_mems();
>>>>> +	hotplug_memory_notifier(hugetlb_memory_callback, 0);
>>>>> +	for_each_node_state(nid, N_MEMORY)
>>>>> +		hugetlb_register_node(node_devices[nid]);
>>>>> +	put_online_mems();
>>>>> }
>>>>> #else	/* !CONFIG_NUMA */
>>>>=20
>>>> Do we really *need* the memory hotplug notifier and the added =
complexity
>>>> due for handling memory-less nodes?
>>=20
>> Hi David,
>>=20
>=20
> Hi,
>=20
> thanks for playing with the idea.
>=20
>> After some tries, I think it may not reduce the complexity. =
node_dev_init()
>> is called at early stage before hugetlb_register_all_nodes(). So we =
need to
>> add a mechanism to detect if the hugetlb subsystem finishes =
initialization
>> in node_dev_init() so that it can determine to help hugetlb create =
/sysfs
>> files, the mechanism is similar with the changes in =
drivers/base/node.c of
>> commit 9a30523066cd ("hugetlb: add per node hstate attributes=E2=80=9D)=
. This approach
>=20
> If I'm not wrong, all you need is a single call from node_dev_init()
> into hugetlb code.
>=20
> There, you create the hugetlb sysfs if hugetlb was already =
initialized,
> otherwise it's a NOP as you initialize when hugetlb gets initialized.

Thanks for your reminder, I know how to handle it now. I=E2=80=99ll send =
a new
patch later.

Thanks,
Muchun

>=20
> When initializing hugetlb, you go over all added nodes and create
> hugetlb sysfs.
>=20
> Testing/remembering if hugetlb was initialized should be easy, no?
>=20
> What's the complicated part I am missing?
>=20
>> may add more code than the memory-notify-based approach like this =
patch
>> implemented. And it also add the code coupling between node.c and =
hugetlb.c.
>> So I tend to use memory hotplug notifier. What=E2=80=99s your =
opinion?
>=20
> We have hugetlb special casing all over the place, it's an integral MM
> part -- not some random driver where we'd really want decoupling.
>=20
> So I don't see why the decouling would be beneficial here and how =
using
> the memory notifier is any better then a simple callback.
>=20
>=20
> But again, I did not look into the details of the necessary =
implementation.
>=20
> Thanks!
>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
>=20

