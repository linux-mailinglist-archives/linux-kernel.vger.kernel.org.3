Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC135AA5FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiIBCkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBCkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:40:16 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4273727FDD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:40:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662086412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6wdkRhjc9iYV2njR6KuVlOYRkAcZLzkJah2ZBOWbZo=;
        b=cyKfwwWWmgqnMyjM9a6BSzjd+UUtLt2jiP8ESHUPjwYa7HUMJnJ2YjQtaeMVWhzwIrYxFX
        xsgf1avC00FO76EZgzNO2IjBfemevkNM+wTwiIWNr2I7owWuSWDrrdDHsKF3FlsmI4E6od
        CGtTwGe80ce6Ah6ekS16gIAKgIxYO2k=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afc8e20c-0317-afe8-ced5-320a575980ea@redhat.com>
Date:   Fri, 2 Sep 2022 10:39:33 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <72294FF8-A09D-4121-80A2-539F6D40942D@linux.dev>
References: <20220901083023.42319-1-songmuchun@bytedance.com>
 <afc8e20c-0317-afe8-ced5-320a575980ea@redhat.com>
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



> On Sep 1, 2022, at 16:50, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 01.09.22 10:30, Muchun Song wrote:
>> The memory-notify-based approach aims to handle meory-less nodes, =
however, it just adds
>> the complexity of code as pointed by David in thread [1].  The =
handling of memory-less
>> nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory =
hot-plug events").
>> =46rom its commit message, we cannot find any necessity of handling =
this case. So, we can
>> simply register/unregister sysfs entries in =
register_node/unregister_node to simlify the
>> code.
>>=20
>> =
https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redh=
at.com/ [1]
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> drivers/base/node.c  |  7 +++++--
>> include/linux/node.h |  5 +++++
>> mm/hugetlb.c         | 37 ++++++++++---------------------------
>> 3 files changed, 20 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index ed391cb09999..cf115d5a9b8a 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -608,10 +608,12 @@ static int register_node(struct node *node, int =
num)
>> 	node->dev.groups =3D node_dev_groups;
>> 	error =3D device_register(&node->dev);
>>=20
>> -	if (error)
>> +	if (error) {
>> 		put_device(&node->dev);
>> -	else
>> +	} else {
>> +		hugetlb_register_node(node);
>> 		compaction_register_node(node);
>> +	}
>=20
> Good, so this matches what other code does.
>=20
>>=20
>> 	return error;
>> }
>> @@ -625,6 +627,7 @@ static int register_node(struct node *node, int =
num)
>>  */
>> void unregister_node(struct node *node)
>> {
>> +	hugetlb_unregister_node(node);
>> 	compaction_unregister_node(node);
>> 	node_remove_accesses(node);
>> 	node_remove_caches(node);
>> diff --git a/include/linux/node.h b/include/linux/node.h
>> index 427a5975cf40..f5d41498c2bf 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -138,6 +138,11 @@ extern void =
unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>> extern int register_memory_node_under_compute_node(unsigned int =
mem_nid,
>> 						   unsigned int cpu_nid,
>> 						   unsigned access);
>> +
>> +#ifdef CONFIG_HUGETLBFS
>> +void hugetlb_register_node(struct node *node);
>> +void hugetlb_unregister_node(struct node *node);
>> +#endif
>=20
> compaction_register_node() resides in include/linux/compaction.h, so I
> wonder if this should go into hugetlb.h (unless it causes trouble)

I think yes. Will update in next version.

>=20
>> #else
>> static inline void node_dev_init(void)
>> {
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d0617d64d718..722e862bb6be 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3898,6 +3898,7 @@ static void __init hugetlb_sysfs_init(void)
>> }
>>=20
>> #ifdef CONFIG_NUMA
>> +static bool hugetlb_initialized __ro_after_init;
>=20
> We set it out of hugetlb_register_all_nodes(), so it conceptually not
> correct. We either need a better name here or set it from generic init =
code.
>=20
> You could call it hugetlb_sysfs_initialized() and set that from
> hugetlb_sysfs_init(), which is called just before
> hugetlb_register_all_nodes().

Make sense.

>=20
> [ shouldn't hugetlb_register_all_nodes() get called from
> hugetlb_sysfs_init() ? it's all about sysfs as well ... ]

Yep, we can call hugetlb_register_all_nodes() in hugetlb_sysfs_init().

>=20
>>=20
>> /*
>>  * node_hstate/s - associate per node hstate attributes, via their =
kobjects,
>> @@ -3953,7 +3954,7 @@ static struct hstate =
*kobj_to_node_hstate(struct kobject *kobj, int *nidp)
>>  * Unregister hstate attributes from a single node device.
>>  * No-op if no hstate attributes attached.
>>  */
>> -static void hugetlb_unregister_node(struct node *node)
>> +void hugetlb_unregister_node(struct node *node)
>> {
>> 	struct hstate *h;
>> 	struct node_hstate *nhs =3D &node_hstates[node->dev.id];
>> @@ -3983,19 +3984,22 @@ static void hugetlb_unregister_node(struct =
node *node)
>>  * Register hstate attributes for a single node device.
>>  * No-op if attributes already registered.
>>  */
>> -static int hugetlb_register_node(struct node *node)
>> +void hugetlb_register_node(struct node *node)
>> {
>> 	struct hstate *h;
>> 	struct node_hstate *nhs =3D &node_hstates[node->dev.id];
>> 	int err;
>>=20
>> +	if (!hugetlb_initialized)
>> +		return;
>> +
>> 	if (nhs->hugepages_kobj)
>> -		return 0;		/* already allocated */
>> +		return;		/* already allocated */
>>=20
>> 	nhs->hugepages_kobj =3D kobject_create_and_add("hugepages",
>> 							=
&node->dev.kobj);
>> 	if (!nhs->hugepages_kobj)
>> -		return -ENOMEM;
>> +		return;
>>=20
>> 	for_each_hstate(h) {
>> 		err =3D hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
>> @@ -4005,28 +4009,9 @@ static int hugetlb_register_node(struct node =
*node)
>> 			pr_err("HugeTLB: Unable to add hstate %s for =
node %d\n",
>> 				h->name, node->dev.id);
>> 			hugetlb_unregister_node(node);
>> -			return -ENOMEM;
>> +			break;
>> 		}
>> 	}
>> -	return 0;
>> -}
>> -
>> -static int __meminit hugetlb_memory_callback(struct notifier_block =
*self,
>> -					     unsigned long action, void =
*arg)
>> -{
>> -	int ret =3D 0;
>> -	struct memory_notify *mnb =3D arg;
>> -	int nid =3D mnb->status_change_nid;
>> -
>> -	if (nid =3D=3D NUMA_NO_NODE)
>> -		return NOTIFY_DONE;
>> -
>> -	if (action =3D=3D MEM_GOING_ONLINE)
>> -		ret =3D hugetlb_register_node(node_devices[nid]);
>> -	else if (action =3D=3D MEM_CANCEL_ONLINE || action =3D=3D =
MEM_OFFLINE)
>> -		hugetlb_unregister_node(node_devices[nid]);
>> -
>> -	return notifier_from_errno(ret);
>> }
>>=20
>> /*
>> @@ -4038,11 +4023,9 @@ static void __init =
hugetlb_register_all_nodes(void)
>> {
>> 	int nid;
>>=20
>> -	get_online_mems();
>> -	hotplug_memory_notifier(hugetlb_memory_callback, 0);
>> +	hugetlb_initialized =3D true;
>> 	for_each_node_state(nid, N_MEMORY)
>> 		hugetlb_register_node(node_devices[nid]);
>> -	put_online_mems();
>> }
>> #else	/* !CONFIG_NUMA */
>>=20
>=20
> Apart from the comments, looks good and clean to me. Thanks!

Thanks for your suggestions and review.

Muchun

>=20
> --=20
> Thanks,
>=20
> David / dhildenb

