Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4B577A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGRFim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRFil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:38:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF313DD6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYyqpAHgDbrWehmpEpLNuq58aEOvHc+ELTrY6w0RvX6X85sZ1oScUknQjAqRK3sMrmIirES1AOkKLNwf028IhKFuQKmjW/TM+rFJHr9GOkmLPZZO8AvZoqWNrp/C9OdIsgBE5E91QqWyvsrveyNAQtIJeDHvQiw/nmgk6a4AWtOYtllsgCPFwNAlXE6D/XQZb55xSEeVoW0oiDqcptpIx6heNOQ2pdwbaKD/n3XnQYohUF7lxB/qe/z8/28Qr9/QOHr8vAJCxNpV23QoRdzC0s616HyRPYW/5WTFusk0tL8Fm6G6P1R2LHa2V8ymynBTB3ajFzkD4tv88RZ75Sqgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuuWPGXRosU5nsORbnz2cF4DbfNo60VCLIdiNI9A8Vs=;
 b=YVwdssCzseYrCn4JLdk1fc+vPyQvy3EvFoPPCcphN8cPFwl80LFeVFeRTItFW6E2vrvUmkHuVMlNDNPJxceZyOVE0jK9+mYqHGCZ7Z1nTDHzwR8Z0i0Zo+wQfqXQjxavRowW7CPArHYMl21B6Uy71tpwcPRY2jH0Hwsa/WeujleZ/hgOtLxt/Qe+2Lh53mnwptuzaH29kwckKRkvMXbLaAi4dLA3J7iXnsp9vcqktJLz+oB/5nAl3IyIZfYIBpt4c6+p/SOfMSqBFcr/zIInNkwl6Spjf9pBF0kFZ15wHa4iX8cyA69WfGJJtS2NdwaXETKlBBLxEC9efrAlTKXW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuuWPGXRosU5nsORbnz2cF4DbfNo60VCLIdiNI9A8Vs=;
 b=K2BYqtumNOndrAzD9hUSLl9UDvy2UzP5GxeulzD26381aNctQNHXW5W3ABeItgjcsIzOmz0Gs2tcGqJMqK7VfFzCVYOLsgPwunAfeSP3AphdMyJ8nedXZZLlj0bJ02prD5uvkXD1LrJt5/aEZnPdkJpd0fc98ZfPSI8nSfd0sXtFYjDieGPRtjAMmnBv7+GU5tmDhw8+MsbDSlXeEfvehX4FbZxeC11vKzHn1G+u347wmTF1RkvfBJMhH7N5Bk/ZKWkCeU6ep4oN9xl9xFXTLxudbvfHlUUjStYbLMajLFc9jhlbJhR3FLaFKIUS5Lz7OXHRNZPRptYwwGYJa67hCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Mon, 18 Jul 2022 05:38:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 05:38:37 +0000
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-7-aneesh.kumar@linux.ibm.com>
 <878rouap2e.fsf@nvdebian.thelocal> <8735f2vo60.fsf@linux.ibm.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v9 6/8] mm/demotion: Add pg_data_t member to track node
 memory tier details
Date:   Mon, 18 Jul 2022 15:22:38 +1000
In-reply-to: <8735f2vo60.fsf@linux.ibm.com>
Message-ID: <877d4bdlpk.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250f0f80-b351-4d5b-38d5-08da687fc30c
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpOIZuDi2Qy1IUEIvayJ34mB4kOQVrf2p1Z2Sxyazy9TOPsPQq8zWerMj78rZbSEy8YVoY8bCk6hfVm1gDTrIIodKIioYpxOGgZz7+P0h/9LcIUJeOYmXUbc0mrS6vS7dW+JBQR5yJ3cEqDC+vKu2AtEnkYOlbFdd18IdlY0Qk0UWS9ev5qm5Og1/OxKXvcgWgg5JhcAqxvOc4v3X7hSNixiYpI66qwyiOU0vcW74/4CE1EWEo4rGFzB10tYal+3emmlMd8KJbm2WrLnoxZFCWtCW/+su3N1ARl8w5iUiXal9JLeNW0kg1IgeAfJOpeB/FxWvlP71RyoaS865+79Xk4A72mES1qmdoPPhN3DmBa2qbkqiOPNjjIVZMgcNPo3LfJnEbG314O8lR/tGmIPwbcwYosJQRmRaImfT7/D0jZRgcW9cq+LncPQZ6ykHmmNXu/d6xCODxPPq+pm5DdJnQsy5BufgtQSyhBKKBK6nJb3YaPmk3NuKH3aaqVVXd3tfZHB7vpoIABGjQ+f1WRko9QWlA/ekmRZFH8d8grkRBOWTLrioimgvX9yYUeLa8/6F05xgGA/pMXwUFcDvFSkixSfPuKoEYNLeAMr1+YVUo5ruYtZQm5+VHeaANedOro8PmmVcBeo36jtlJPhZObKrxjGS51KiClwNkgfFoo0cI7m/5GwgId8isieDq49FD/iC4Rj4dpMHOZ8roQybPUBc5H9+ZOykU//aSZRBG1P3FFy0gzIyReI7VIvRnHnnits
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(41300700001)(26005)(6512007)(9686003)(6506007)(38100700002)(2906002)(186003)(83380400001)(6486002)(6916009)(54906003)(316002)(66476007)(8936002)(478600001)(86362001)(4326008)(8676002)(66946007)(66556008)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bHmV/7rKiLm1C4O7KflW4rc+duTMPxwvt/g1PBJmfPVqJHoXyMAW4XMMGxV?=
 =?us-ascii?Q?2t8Ufn/L9W/xT4iTOMRvDjmM/CeEVA7xibB1sFO0D0QHlGVb+mVE633gUgZk?=
 =?us-ascii?Q?3f9lE9M7YT9lK+lGr7BehxWSqIcwQWfoPb38hT1we+BJXeRD4z1zySri5czt?=
 =?us-ascii?Q?ubD2RdXSz1LSTc11Z8XO4Mt4aw5jzjjPcKarkUipBBvjGVHqfrGM1SPr69k9?=
 =?us-ascii?Q?2oLWSVEZ3GtiQwjeDhN9fVzcao7v8WysfccIZQ3vIvoK1CNbkIEKb1ddKXT8?=
 =?us-ascii?Q?0u7LUUmYEoSXTGl8TR2ni9Ty2v4D+QqhksjqvidMDg2P04c1hyGHgtN/wnoA?=
 =?us-ascii?Q?iddNzwCOSXUzXdV9qoIef+OnjCrO1N+bjfAALrebM7cKUPGWB9aVxHaOY4K8?=
 =?us-ascii?Q?0dTDQzlQfN8w6AhMBRaXDs9VdMzMeGBltQo2EQg32kreyRIET+KpstQ8ZI1E?=
 =?us-ascii?Q?s28HFiPOXwyfd+nzJePoCSjsuo/RpWFveD4qytdJ2UNKA63EaoQ/ZAn9K99o?=
 =?us-ascii?Q?IRr95K72T/52mIPgI6pxVnD8TL6jyRezjl7fDnLQoOSXCHf6/1+zUcBRj8dH?=
 =?us-ascii?Q?Cl+LbGATC9OLv8dRWV/I1CTTifV4kU40/BfT9/Y9IQOinLrLM7duh3z3pp8o?=
 =?us-ascii?Q?yfgocRCe0yjmhVb28Pa4GG/nafvxh6VjTEmqSY5BZ5wG6BpuLvGSzb2kwHSE?=
 =?us-ascii?Q?ilW2CKMJe6LK3qoJhJdtb2807trXn09FnWFPNyFSuMFh3DKFAPdKlQ20ViWM?=
 =?us-ascii?Q?TB8Z3ZRJp7SjphNFjQAc61fKOhvADe35vGI55YmLQyeVPkJ25zb6FmSRU/ox?=
 =?us-ascii?Q?MaFstak0EBGrrzyahSIaOhXGhS/7j3yrxTOErU43lIkxdUUhP4kPavxBtV2x?=
 =?us-ascii?Q?UOfsU9uOess2175pciKtohD17Pz/T7+vALd0JarkaDzoZJqW1mFJFcWCaa9r?=
 =?us-ascii?Q?00nGZHI3IQecevaTqLwInsCYGTxGUzodmd4nGKdulVJxfYn2JYk3oUgnC1if?=
 =?us-ascii?Q?w90j9Au0JtN3EYO0XFiqaOyx0I72vnKlUzk3cKvNAT8AWh6wgwO1XYmRdqoR?=
 =?us-ascii?Q?IL8bgR9v59fZTMY8osLPHaBjv0ThBxRvpUl2QeUF/7fGftHw+FnQetNsEdKi?=
 =?us-ascii?Q?m6+4HFvB9UKljlo9m2V/gGtijpaHbiu5L3DKwIoikXBlAn+EOKgMROhW0d0+?=
 =?us-ascii?Q?XHUusCyxgJQL9lJhCAzfNMSmllxbFLkXiCOtkxMCOeRpVtdkn5RWwWKG59dR?=
 =?us-ascii?Q?LnKrekSDMrscjvOF0gr/mZzqXJnMcDkuBBkttgChU+ozSdc5l50sPeaM0hre?=
 =?us-ascii?Q?hYDLKmyv5up2WTow+N6VAlLsCtYju54A7kAafFAbad97FCBVkDNmZ1am9qmz?=
 =?us-ascii?Q?XPFwStYKnnDj8Do2xy7Js04Z2Eutxa4jtonUGEHSbwMEEYb6kyiU81TYy+Ca?=
 =?us-ascii?Q?v/UGQmBxeqqy00TlOUg53ZeYyyeRFiha9ia6cbohJh+OsIkvLCrDPzXOK/st?=
 =?us-ascii?Q?EKkEC4cVXISUpuUqAR9HkVqD6HsQNLxBkeK5UVtsY3R8xWuTLqXIDEqxf2B4?=
 =?us-ascii?Q?M3/HL+qRJTJrqjUvdvBQh33XwWSFR0lkMBbLaV7m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f0f80-b351-4d5b-38d5-08da687fc30c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 05:38:37.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF0Nr/ckTkv6elIRMgRo7GNQsigTrpeLCBQJZ4oTZlmh98+96dF/0BQpV0JEwvTbWg5SJcQLxRMdgsR0znG+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>>> Also update different helpes to use NODE_DATA()->memtier. Since
>>> node specific memtier can change based on the reassignment of
>>> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
>>> needs to happen under an rcu read lock or memory_tier_lock.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  include/linux/mmzone.h |  3 ++
>>>  mm/memory-tiers.c      | 64 +++++++++++++++++++++++++++++++-----------
>>>  2 files changed, 50 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index aab70355d64f..353812495a70 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>>>  	/* Per-node vmstats */
>>>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>>>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
>>> +#ifdef CONFIG_NUMA
>>> +	struct memory_tier __rcu *memtier;
>>> +#endif
>>>  } pg_data_t;
>>>
>>>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>> index e951f54ce56c..bab4700bf58d 100644
>>> --- a/mm/memory-tiers.c
>>> +++ b/mm/memory-tiers.c
>>> @@ -7,6 +7,7 @@
>>>  #include <linux/moduleparam.h>
>>>  #include <linux/memory.h>
>>>  #include <linux/random.h>
>>> +#include <linux/rcupdate.h>
>>>  #include <linux/memory-tiers.h>
>>>
>>>  #include "internal.h"
>>> @@ -124,18 +125,23 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
>>>  static void unregister_memory_tier(struct memory_tier *memtier)
>>>  {
>>>  	list_del(&memtier->list);
>>> -	kfree(memtier);
>>> +	kfree_rcu(memtier);
>>>  }
>>>
>>>  static struct memory_tier *__node_get_memory_tier(int node)
>>>  {
>>> -	struct memory_tier *memtier;
>>> +	pg_data_t *pgdat;
>>>
>>> -	list_for_each_entry(memtier, &memory_tiers, list) {
>>> -		if (node_isset(node, memtier->nodelist))
>>> -			return memtier;
>>> -	}
>>> -	return NULL;
>>> +	pgdat = NODE_DATA(node);
>>> +	if (!pgdat)
>>> +		return NULL;
>>> +	/*
>>> +	 * Since we hold memory_tier_lock, we can avoid
>>> +	 * RCU read locks when accessing the details. No
>>> +	 * parallel updates are possible here.
>>> +	 */
>>> +	return rcu_dereference_check(pgdat->memtier,
>>> +				     lockdep_is_held(&memory_tier_lock));
>>>  }
>>>
>>>  static struct memory_tier *__get_memory_tier_from_id(int id)
>>> @@ -149,6 +155,33 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
>>>  	return NULL;
>>>  }
>>>
>>> +/*
>>> + * Called with memory_tier_lock. Hence the device references cannot
>>> + * be dropped during this function.
>>> + */
>>> +static void memtier_node_set(int node, struct memory_tier *memtier)
>>> +{
>>> +	pg_data_t *pgdat;
>>> +	struct memory_tier *current_memtier;
>>> +
>>> +	pgdat = NODE_DATA(node);
>>> +	if (!pgdat)
>>> +		return;
>>> +	/*
>>> +	 * Make sure we mark the memtier NULL before we assign the new memory tier
>>> +	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
>>> +	 * finds a NULL memtier or the one which is still valid.
>>> +	 */
>>> +	current_memtier = rcu_dereference_check(pgdat->memtier,
>>> +						lockdep_is_held(&memory_tier_lock));
>>> +	rcu_assign_pointer(pgdat->memtier, NULL);
>>> +	if (current_memtier)
>>> +		node_clear(node, current_memtier->nodelist);
>>
>> It seems odd to me that you would update the current memtier prior to
>> the synchronize_rcu(). I suppose it's really memory_tier_lock that
>> protects the details like ->nodelist, but is there any reason not do the
>> update after anyway?
>
> The synchronize_rcu ensures that the lockless read of pgdat->memtier
> either see value NULL or a stable memtier which got current numa node in
> its nodelist. IIUC what you are suggesting is we should move the
> node_clear after synchronize_rcu?. I am also wondering whether I need
> a smp_wmb()?

rcu_assign_pointer() includes the appropriate barriers to ensure any
initialisation will be visible, so I don't believe you need smp_wmb().

> pgdat->memtier = NULL;
> synchronize_rcu
> remove node from memtier;
> set node in new memtier
> smp_wmb();
> pgdat->memtier = new memtier;

Yeah, that's what I was suggesting. Although to be clear I don't think
there was actually a correctness issue with what you had, because
memtier->nodelist is protected by memory_tier_lock anyway and not
accessed under the rcu_read_lock().

It just looked a little odd IMHO to be updating something that was still
potentially being used prior to synchronize_rcu() completing.

>>
>>> +	synchronize_rcu();
>>> +	node_set(node, memtier->nodelist);
>>> +	rcu_assign_pointer(pgdat->memtier, memtier);
>>> +}
>>> +
>>>  static int __node_create_and_set_memory_tier(int node, int tier)
>>>  {
>>>  	int ret = 0;
>>> @@ -162,7 +195,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
>>>  			goto out;
>>>  		}
>>>  	}
>>> -	node_set(node, memtier->nodelist);
>>> +	memtier_node_set(node, memtier);
>>>  out:
>>>  	return ret;
>>>  }
>>> @@ -184,14 +217,7 @@ int node_create_and_set_memory_tier(int node, int tier)
>>>  	if (current_tier->id == tier)
>>>  		goto out;
>>>
>>> -	node_clear(node, current_tier->nodelist);
>>> -
>>>  	ret = __node_create_and_set_memory_tier(node, tier);
>>> -	if (ret) {
>>> -		/* reset it back to older tier */
>>> -		node_set(node, current_tier->nodelist);
>>> -		goto out;
>>> -	}
>>>  	if (nodes_empty(current_tier->nodelist))
>>>  		unregister_memory_tier(current_tier);
>>>
>>> @@ -213,7 +239,7 @@ static int __node_set_memory_tier(int node, int tier)
>>>  		ret = -EINVAL;
>>>  		goto out;
>>>  	}
>>> -	node_set(node, memtier->nodelist);
>>> +	memtier_node_set(node, memtier);
>>>  out:
>>>  	return ret;
>>>  }
>>> @@ -428,6 +454,7 @@ static void __init migrate_on_reclaim_init(void)
>>>
>>>  static int __init memory_tier_init(void)
>>>  {
>>> +	int node;
>>>  	struct memory_tier *memtier;
>>>
>>>  	/*
>>> @@ -444,7 +471,10 @@ static int __init memory_tier_init(void)
>>>  		      __func__, PTR_ERR(memtier));
>>>
>>>  	/* CPU only nodes are not part of memory tiers. */
>>> -	memtier->nodelist = node_states[N_MEMORY];
>>> +	for_each_node_state(node, N_MEMORY) {
>>> +		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
>>> +		node_set(node, memtier->nodelist);
>>
>> Similar comment here - the order seems opposite to what I'd expect.
>> Shouldn't memtier->nodelist be fully initialised prior to making it
>> visible with rcu_assign_pointer()?
>
> Will fix this. This is early during boot. So the ordering won't impact
> correctness. Hence i can skip the smp_wmb()?

Yeah, rcu_assign_pointer() should include appropriate barriers anyway.

>>
>>> +	}
>>>  	mutex_unlock(&memory_tier_lock);
>>>
>>>  	migrate_on_reclaim_init();
