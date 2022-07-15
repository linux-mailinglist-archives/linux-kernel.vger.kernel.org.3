Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E1575B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiGOGFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiGOGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:05:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0748C91
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSznLMLae73FuniZMIfG/rxg8SyLTH4vNSjDoQB+0juYA6fUZd+64Dzu73N35rqZOXyE26/pUpVynHZMFG8fHiRMEMHybFfQvGN187+DIXZEU7vVZIToAYRJzKTsHOg/AfyPvxDyLJagXHCsCMBGd0gSIypLqA2qwLD0pF9T0K1z/WZMfv8zosnjG8b8dD7L+Vv9dVkslBraclGkQrz96w8eJjgNNKiSlXSxHkPk5wC96IVut8aDF9UVSNXxzwIWv05FDexMQihHAx6Zp4IeXj4GBZrnmSvqf4Sp9z9Vpa1AB2qzEgvgRnWY0pTwNVXHsgjafdxo6egXgWjxlq+ZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GDFdPN9OF52+LIFQHaVd5VRmKLWd8aw+FJYMO0CmYo=;
 b=VcY7e6f/9CvVg3EG+0+9p1SItkVkHces3Gt0feacc/iiHcOR0a8DU8hnphy5/IxOGFrwVUhQrHpz0NlqXCisr9L6ta4JCcKNQfOR6weT7+7YjGwQ3ML9y0eImVzvFwpNMDnTR87tccVvDb2yrImiJ1bKdFunz+PJOfK80lznkdpMquP9luGVTyUq3mfdpzVm31MA+r+crtQY/GLOlJ6HvqMWozNAj9B6cKCpTo7MB4umoXTkIFBRmkreRljs9xeP8iKkdYEmwzYJoXhyOBrVs4QsTDKpp+l1z559L2qBByV1FSVbzLmFQon5FZgdQ6w9dU5M4z05dIY0jTgtKtWoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GDFdPN9OF52+LIFQHaVd5VRmKLWd8aw+FJYMO0CmYo=;
 b=B2fCYoS85i4SnmDRAtiYVNV0RX5mhieAvRCV3WaXLsp0YJPXGqtu+sHQ7q5gV+Zk8+T3DCC4xsCdBuLCe8qqSTD4TpGmzQkBZDEaQUNhQ4KGO+bwGfdcxGKOLo2DBmuuOTQuSi88s5K/YWtLcgYudhL7L4PODAd17rHat6AmzGuXn13fuZpBWQuQ+23MbCNcARYoN9P28vEHLSwSF/t7u2ov5iyl9YfXfDwYKGDVJo67tWmmZxNwjNu62+qjLgZ6IOAbUKyOjpU3YbwBj/Q6em+Z+QmOjzflrQY6ar1RQ6hgCZyUqSbWLDgLEf/vb1mjg2jslodZMWOLLjqpqzCTFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 06:05:16 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5417.020; Fri, 15 Jul 2022
 06:05:16 +0000
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-7-aneesh.kumar@linux.ibm.com>
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
Date:   Fri, 15 Jul 2022 15:49:00 +1000
In-reply-to: <20220714045351.434957-7-aneesh.kumar@linux.ibm.com>
Message-ID: <878rouap2e.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2aec3d5-9e63-4d81-ff82-08da6627fced
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nuj0mjx2VEeWdogw8uwRt6poM8VUJ2zPWRhNpAeS8utNRANIOLPww1JZAi2zQcEAIkrn6HtGyo0m8Xvj8GzhHDHUqI8Ql3VzsMzNi5hcOk5zzYtyNMvJMvOnLXS2+FXNXyq1RrvVL+eXE4EyulV3lUu1J1NaFIQEvCSIHKep8cbWc+DHOz4vXlvby27BlWXI3WFZYL2adguIybROVrLxGy5Qe1JKI13yGsi007JewH6rpbRjLMYizirEFfZE8BmpyOyr2mBotNVGG0WdduBlf2wuVO4Q2qxcCEV/qib6Kn3AgLDdqcQJECJFjd2yyXYXawrD121KKvnlbwUDX4cIR7L2wiL0zhjNAKhyUqQy3oBm8pkAyLfDaGhv9WOIPrDV0obthwmZMNd7AYp3BAJI9aPjbOOSGcyMBmZF2Dqs/IaH/Fz3Hxeax/NDgE1ocaeTbyImkhnRvKmQ8Epj8KElqwKU8JGda4+Gl5VBqpwj8r333M3dxaUwWfDk0LZwgtTNDCOGkIY9NpXHSuVdXhfWYsqI3V+ws2WbLrHyLc1qpGT6yqE35cgDZ40X1PLMsC6GsascnW/xe67Uh9Ylx28qdsENyFErUEoLC0EXn3Q230Ocggi7HJJQp8PQIXYlFJfiPaScjnjsum4tkmlDqMnAXZ7DhLBMp6bmgHSpjKqjOoRFLv76t4HCG7P+i7ypMUoAYzJx9bWf8LD7NrtFeHzol2LakznB6/Q5JXqmxfAYgBObuthpTicpR9Jlc5c+12pZt8pVryCcuVf4U1Ks+gkBjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(6916009)(316002)(83380400001)(86362001)(54906003)(66946007)(6486002)(41300700001)(478600001)(6666004)(186003)(6512007)(26005)(4326008)(7416002)(66556008)(66476007)(6506007)(5660300002)(8676002)(8936002)(2906002)(38100700002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oddLV339NhQVmoomA8NzvnsdWcApUdfQw7XoRqbhrZwOnJ9gKKReeMQ6UHIa?=
 =?us-ascii?Q?MuwwzCXXCIygZKVBIk42r+BfOCweOVdeiXnI2rprx6QolWjM1GKVLjEsCnhA?=
 =?us-ascii?Q?2c+7ecEodA9/PxfXCNXdTo5o+bsAtAvpXXCUXJHGhQk4LcOepX34g0KYO8Lj?=
 =?us-ascii?Q?Xo6BzzX45lGS4s1WUhT5T8s3TJJisCa5nsx1liIuWbdrmR5QPZdwlaoSuCs2?=
 =?us-ascii?Q?cWY86kpj04d9dZ1hC8nhGepXUJ9L1/TUznDw4R6vP0IeOf4Ml+0Fvn+Yagkp?=
 =?us-ascii?Q?qQIiXYbRchzfuAkIbh/Wse/X8utR1sNjFPiWSrrFsigILilZB2YTzE1eAZgW?=
 =?us-ascii?Q?K/VrXUDiBfVvseUtLBWdoZPrrjrA6i0FeS/uZlVp9PRgSSm1y7kAtkFaZZr8?=
 =?us-ascii?Q?F7K2RYl9AoPMSjIzaPwYipnVwXjorec/fsiGkY2OnKXEH3DW1yLT21Va/p0R?=
 =?us-ascii?Q?dXiJmHe+H0rnYnDMzO3q9v3f81PyETbPFl7pJ3fMOOgpxb04h1QgE7zemnTO?=
 =?us-ascii?Q?IdjAZKOu4L12yHa6M61Rexdr6ScxW47ceVk9kuN9td6X8pYmx/N2DEJGfu7G?=
 =?us-ascii?Q?wE5ozrFMEFNBqLSnMCmY+bb82QMrtFmRv0ujImdHs2C0/4cElMMeWJTSCf/H?=
 =?us-ascii?Q?KREc3Yhg8nD/Z8CFSANa7MmPh7sCOqbdD7dItVo1MnQA0pH6rWsTh2IbQa+7?=
 =?us-ascii?Q?gCxsHfKd5oKIVCfs+Pd7PtLKJirNj5Pu7IqVy2yT9oXozRI+Iy+bCe+tMckK?=
 =?us-ascii?Q?y2qT1MeQ5u+bIA2Rw/xPUx8wbqkSLpjwV08jy3QiMH/RZEQilsp0yVRshJRV?=
 =?us-ascii?Q?dzQEvNQunhwJq2/r3ZdpCDJxyrIAWu7y+7zaYEeJ7/ILhOuNTF2KvyUnutm/?=
 =?us-ascii?Q?iKuLfQJp/dYv0DdR6FdiER4nDwgfo32JG2RViDxbTwf2GOVW0sZk4/jKr9fM?=
 =?us-ascii?Q?zenw30AZ1LAmDq148oHWPhz8IbjyM7Nk5i5ZRwuZFqLi5bxQHxWdH00no+8a?=
 =?us-ascii?Q?0LI1883d81s2tTV/HeGLdW1DBc2wI3N7Azzj5kpA4e8OjRMShhEglwNkUM4C?=
 =?us-ascii?Q?dSd6ltQcKTucANmIuyQ9eS7J5Av4pfsWigFGsFcoklXp/bFTkA47dAFTNLgs?=
 =?us-ascii?Q?dhaUCDanCSOOVw0e7fol88ck48JNXOo8xwBGEfhkHkIyQMHuC3QmMq/ECIR4?=
 =?us-ascii?Q?Tr+nKttYuDopct5Pc5yU+FU7W2NgS9MqqOUMyNBq3vCkvZI6XJ6OikwzADRB?=
 =?us-ascii?Q?w6koRCZiBm7g+aqr81hVQHvr557eUTznDvhoinjDnVs1nGzZ99bShWiO6SlK?=
 =?us-ascii?Q?Et7CiqSH5VjIbvRPX1VmNkT/wYkp4jh4PWZJkmR59AlnEPsZ7hLRH4pSGBCo?=
 =?us-ascii?Q?wbQ/5BH7B8HX+nnx6zZeekSpk4gcDpPXiD12DiYHDtmu7WMI+xhx/EPeyWaW?=
 =?us-ascii?Q?5CbpzV/Ld9ra+oMnEdiTCbYH8eq7wGi5PKCRuSozMnnnGZucSGpIZMP6teI2?=
 =?us-ascii?Q?/hfVt53/nu2WCZJKiOx847WLtGQh43/BHNq2yFEQJJW2/SzX7SND1C7RrmpA?=
 =?us-ascii?Q?EfWsDqIQLxI1+NXLPg/4dVNkzgHS7Xa+5PyAj9nf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aec3d5-9e63-4d81-ff82-08da6627fced
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 06:05:16.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH4SpNsxPrHm+JmCVyhPrTYGqFUSIQMpWs5VbKS6KnfyD7sDrIs+vwPBKpHZzSNbe7xFkRjR/wJUnNXwosG6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Also update different helpes to use NODE_DATA()->memtier. Since
> node specific memtier can change based on the reassignment of
> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
> needs to happen under an rcu read lock or memory_tier_lock.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/mmzone.h |  3 ++
>  mm/memory-tiers.c      | 64 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 50 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..353812495a70 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>  	/* Per-node vmstats */
>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
> +#ifdef CONFIG_NUMA
> +	struct memory_tier __rcu *memtier;
> +#endif
>  } pg_data_t;
>
>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index e951f54ce56c..bab4700bf58d 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -7,6 +7,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/memory.h>
>  #include <linux/random.h>
> +#include <linux/rcupdate.h>
>  #include <linux/memory-tiers.h>
>
>  #include "internal.h"
> @@ -124,18 +125,23 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
>  static void unregister_memory_tier(struct memory_tier *memtier)
>  {
>  	list_del(&memtier->list);
> -	kfree(memtier);
> +	kfree_rcu(memtier);
>  }
>
>  static struct memory_tier *__node_get_memory_tier(int node)
>  {
> -	struct memory_tier *memtier;
> +	pg_data_t *pgdat;
>
> -	list_for_each_entry(memtier, &memory_tiers, list) {
> -		if (node_isset(node, memtier->nodelist))
> -			return memtier;
> -	}
> -	return NULL;
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return NULL;
> +	/*
> +	 * Since we hold memory_tier_lock, we can avoid
> +	 * RCU read locks when accessing the details. No
> +	 * parallel updates are possible here.
> +	 */
> +	return rcu_dereference_check(pgdat->memtier,
> +				     lockdep_is_held(&memory_tier_lock));
>  }
>
>  static struct memory_tier *__get_memory_tier_from_id(int id)
> @@ -149,6 +155,33 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
>  	return NULL;
>  }
>
> +/*
> + * Called with memory_tier_lock. Hence the device references cannot
> + * be dropped during this function.
> + */
> +static void memtier_node_set(int node, struct memory_tier *memtier)
> +{
> +	pg_data_t *pgdat;
> +	struct memory_tier *current_memtier;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return;
> +	/*
> +	 * Make sure we mark the memtier NULL before we assign the new memory tier
> +	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
> +	 * finds a NULL memtier or the one which is still valid.
> +	 */
> +	current_memtier = rcu_dereference_check(pgdat->memtier,
> +						lockdep_is_held(&memory_tier_lock));
> +	rcu_assign_pointer(pgdat->memtier, NULL);
> +	if (current_memtier)
> +		node_clear(node, current_memtier->nodelist);

It seems odd to me that you would update the current memtier prior to
the synchronize_rcu(). I suppose it's really memory_tier_lock that
protects the details like ->nodelist, but is there any reason not do the
update after anyway?

> +	synchronize_rcu();
> +	node_set(node, memtier->nodelist);
> +	rcu_assign_pointer(pgdat->memtier, memtier);
> +}
> +
>  static int __node_create_and_set_memory_tier(int node, int tier)
>  {
>  	int ret = 0;
> @@ -162,7 +195,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
>  			goto out;
>  		}
>  	}
> -	node_set(node, memtier->nodelist);
> +	memtier_node_set(node, memtier);
>  out:
>  	return ret;
>  }
> @@ -184,14 +217,7 @@ int node_create_and_set_memory_tier(int node, int tier)
>  	if (current_tier->id == tier)
>  		goto out;
>
> -	node_clear(node, current_tier->nodelist);
> -
>  	ret = __node_create_and_set_memory_tier(node, tier);
> -	if (ret) {
> -		/* reset it back to older tier */
> -		node_set(node, current_tier->nodelist);
> -		goto out;
> -	}
>  	if (nodes_empty(current_tier->nodelist))
>  		unregister_memory_tier(current_tier);
>
> @@ -213,7 +239,7 @@ static int __node_set_memory_tier(int node, int tier)
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	node_set(node, memtier->nodelist);
> +	memtier_node_set(node, memtier);
>  out:
>  	return ret;
>  }
> @@ -428,6 +454,7 @@ static void __init migrate_on_reclaim_init(void)
>
>  static int __init memory_tier_init(void)
>  {
> +	int node;
>  	struct memory_tier *memtier;
>
>  	/*
> @@ -444,7 +471,10 @@ static int __init memory_tier_init(void)
>  		      __func__, PTR_ERR(memtier));
>
>  	/* CPU only nodes are not part of memory tiers. */
> -	memtier->nodelist = node_states[N_MEMORY];
> +	for_each_node_state(node, N_MEMORY) {
> +		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
> +		node_set(node, memtier->nodelist);

Similar comment here - the order seems opposite to what I'd expect.
Shouldn't memtier->nodelist be fully initialised prior to making it
visible with rcu_assign_pointer()?

> +	}
>  	mutex_unlock(&memory_tier_lock);
>
>  	migrate_on_reclaim_init();
