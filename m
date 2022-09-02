Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8735AA67B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiIBDmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiIBDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:42:48 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC5B14F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:42:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662090162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rphHZCXlHUubQjamw80gazwJtM/3au0/Xd3ezUEQ7QI=;
        b=MSdHtCuW91G8A5yAuYu2dghsgcz15Vz7GuMHAjxz/jAOpsrIGsogZNJG2Pb8iv6+j2p54X
        za6ikPLSH9gTfDGw2tE1iOf0yNC3y0FXA2zZfjFTZpj8ai90nPIFjsU8mmE7wQMSqxzDSN
        YC/DAuFFi8BmzUev6LPiGQ/2OP/YAvQ=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <c39c6ed2-4766-71d2-d459-6bb39f09943a@linux.ibm.com>
Date:   Fri, 2 Sep 2022 11:42:13 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, david@redhat.com, ying.huang@intel.com,
        rientjes@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E1AF7F4-B904-40F0-A194-1735BEC41668@linux.dev>
References: <20220901083023.42319-1-songmuchun@bytedance.com>
 <c39c6ed2-4766-71d2-d459-6bb39f09943a@linux.ibm.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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



> On Sep 1, 2022, at 17:00, Aneesh Kumar K V =
<aneesh.kumar@linux.ibm.com> wrote:
>=20
> On 9/1/22 2:00 PM, Muchun Song wrote:
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
>=20
> Isn't that hotplug callback added because in =
hugetlb_register_all_nodes() we register
> sysfs nodes only for N_MEMORY nodes?=20

I think you might right. I have looked at the commit 9a30523066cd which =
introduces the sysfs
creation. I saw it create the sysfs for every possible node.

	for (nid =3D 0; nid < nr_node_ids; nid++)
		hugetlb_register_node(node);

And then I checked the commit 9b5e5d0fdc91, which said it was a =
preparation for handling
memory-less nodes via memory hotplug.

>=20
>=20
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
>>=20
>=20
>=20
> I guess this will handle register of sysfs hugetlb files for new NUMA =
nodes
> after hugetlb_initialized =3D true;

Yes.

>=20
> But what about N_CPU that can get memory added later. Do we need to =
update
> hugetlb_register_all_nodes() to handle N_ONLINE?=20

I think we should.

>=20
>=20
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
>=20
>=20
> Should this be for_each_online_node() ?

So, yes.

Thanks for your review.

Muchun.

>=20
>> 		hugetlb_register_node(node_devices[nid]);
>> -	put_online_mems();
>> }
>> #else	/* !CONFIG_NUMA */

