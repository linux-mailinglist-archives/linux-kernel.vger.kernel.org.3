Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B577575B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiGOF5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 01:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:57:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F14F668
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 22:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW78V/HQv0TL55rprt08eOyg8vcxp74YngSRMd8CxtMhIfHmsJBBA2cblcTeubcfF7OiczPnP62hPmqza95UzXpSYnedzs5iJKMuUAKbxhX6M9irnJTXSywX8VesFU47m4kZkufMxItw8KPGai1DmMgTYAEFXI2jQbsKxNvVUJ6PEnceN7KRCwKV6+zsnYa3vp/NC9zZKqxGaijo6CXZQBMbXeS39kZO3w3i/b9EM06rtEEOJw8bU1xbKb655AjX0dAGHqROBdujDb8n3ZFPwt155hvO4bd7u0Bc3pwqp8nFSbX4TAOwVJzt8f2MP5GDcS9kX2+EI8oiBIptoVdLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a696pMQYvRSUk4fO5hzX2hjnPUvLB1n+mRt8BPdfZZg=;
 b=A+daJ/2tQEVjNVJDvCDivYtFXHimWgcKxiG7i0JdU6KZ5TXOlwHMa/vZPm31QgLDNSXIQ4OxFRTawvbpFCP9bsCsZWl52jySvvI8xIMT9mjDCP6BER++gnnADXHelp7DoCJwkI8mZgvGxk2rURKOMshVe8kvFy24PYki81Ygw97dhWwmImBgxIvgPQl7MI2NUoptUy/edKe+4Ry2f1lKyQkMEVL51ipXASEKTwgmZcc70iWwKF3RhFYMtStM2L1ppJGJN0sxjA084Z2SgZsRvksAhZGN8ALxtMsSQ5YUruvmnf42Fcx9NeCDeexD/7Gw9OyR9XXuEHTktICiwxuMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a696pMQYvRSUk4fO5hzX2hjnPUvLB1n+mRt8BPdfZZg=;
 b=oz3lbvVMFwB1ceDXqH9ZSi1yOV99LL8d02doQRxjjEqCzpCnt7LmZNCVMnK02Tk2k+bqnTFEHObWhVTYLs4lqZVwf/Dbmt6QS2PjGL8WghiyYdDzQ9eMPf/gB8fQ0Sd9uAE3Yc6i7yMLUXJlpB1aImb4bkOAbluQTCJ6djstSV/1UvfnfVuE0Lu2UHM3KkAYTcXQ7Ctt84GIBNaVaCyEJe/5lKNbJWRh+XrPDZMN2y/5r/oWOw8EiH/CwukrSwvi/iJfZfO9YJYd+Yj7KOW2va/vXHJ7L1GEjuN5mzpYiFcMT5K37oaXy4v4cjmaJXTzWOPQKUiQ9f7wWwDRaHixag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Fri, 15 Jul
 2022 05:57:05 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5417.020; Fri, 15 Jul 2022
 05:57:05 +0000
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-5-aneesh.kumar@linux.ibm.com>
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
Subject: Re: [PATCH v9 4/8] mm/demotion: Add hotplug callbacks to handle new
 numa node onlined
Date:   Fri, 15 Jul 2022 14:38:09 +1000
In-reply-to: <20220714045351.434957-5-aneesh.kumar@linux.ibm.com>
Message-ID: <87h73iapg1.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ef9eac-e6bc-4eec-bc41-08da6626d8a5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jY8n3eWGEQuObsWEzYNWudHbP1PDe83zVYX/Dm8tqZkwKZk8H8NfuRdz6hnPpaYwyikpaQ7yHmAEnEBakZpN7j7lVwhc9Yt8QYW2Y1JEfqhvK/VkCQXpkBRaEh7+jSXhAzYPucQVQtqMs0Z2sgbHya12H2dJailM9E7PZc7EUjuID+jkGJdGnyNG73Y8NOs7lhrlqnqphiId/Ibw0ZqoWNl769QO0g5KpEzYUqn1OD99jAvrZdPyK7RVAeNtJkDvqShlzDHWcBUjKHlwiDcU12I542jP/E2nE8PGQHY8okKgkiPWsMRNZav9hABvMziqSTFNRhSnQKZ5/NMZHGSesga6tQ4UKa9g7CvI4mItPf1bYZG4BVs2Ckcl2QcvbetbfmDjSjP+DksEHN3zLyJJlcwsSD0y4RtreQiitYolaLWj/dn83au8qpCfr6MK2TZbhr5qgkxVHIu4V/DRFykmLjJDE+MW8NgXUznF9ohuVIVyiqcBdbH1MyPe7/hidP5UeNdHKUqFwnENvtGr4E2P9znhbtNRY/HdTgr6OiBEjNvhlNzbMZ0H1A9y2wZ3cZkzPOVs3xZI8Lis6tWaGwgFDz8a1HQfk+u9CdbBbRKNF/l91y8GOAOgoIg8T99vO9gH5ox990CVMox19H69ko+dqpiUvLbrr0qHzBFR5W8zna+COBN6JD+h4Uyqbp0/FJg5NhWdC5MB2hREj78DnrTvu0u/eEaKTBwWV7H6vgewfVIPFtqfypD1pdW3LU2fjfBb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(66476007)(4326008)(6512007)(9686003)(6486002)(83380400001)(26005)(5660300002)(38100700002)(2906002)(186003)(86362001)(66946007)(8936002)(8676002)(66556008)(41300700001)(6506007)(478600001)(7416002)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPbou2kX3IxRq2tVOOY3dOVd5QNzL7B+XnrOdcsxLd9f9TIDdvXvwJYp3MV8?=
 =?us-ascii?Q?65mufVElSE7IJcwlCy9lvS6Si+OuD3SleS7bOofoWgkcFtVQUJ9zpLHu3XlP?=
 =?us-ascii?Q?1gHIry8Z/O61l+kyHRwRnGx15BzfNPa/Npm8rJtYBcwEjNVi/pzGB/F4nsn5?=
 =?us-ascii?Q?t0EM43y45IuLHjHfDEP/LWLodb/442Xo+6KG0yV5Y8HTOG/YzVPbUozkJHfm?=
 =?us-ascii?Q?ENc+9qOSKoj5hydpdjqRrKCVTIYTE2q6ykejLv/rAf5CSf5eSjGpdiyJtTyq?=
 =?us-ascii?Q?Ul5y/sFXCjWQOxRV6BFkGJbzAckihHT1cz9DPLQ1NGDEIeOsB+UQLSDXL0+b?=
 =?us-ascii?Q?y4kV09Hr5vY2xb3cf3M6GYDP4GEWwsc0Rva7ymAa8XoSiedv+Nw32kyk/764?=
 =?us-ascii?Q?E/6ljn1tC929CRZE+KZfhfzFfde5fhIg+Ikfpp6JfoDQu2go+S0HoCnn9sYR?=
 =?us-ascii?Q?1XVjs3DGPvLYCyhBCE17rP/tt73mawY6kzSVu0n3nqGiSLJNlVBM8udkrxZf?=
 =?us-ascii?Q?Sim/rdlJxD6ZAkRjaSYxScw/EUSFjR9b9nU4UC3SWwV8p+yC1efFPvuULW0T?=
 =?us-ascii?Q?HgET0mFl08x4AV+8MgcFCbDEGPJH+tO69OXecDTpG0R9wi8bRzvYH2R1zh6j?=
 =?us-ascii?Q?1D470SA5jIMVCzI0NhX1vW8qEgZtarCe7EqbmSydy3LhbIpk041eylVKBYwn?=
 =?us-ascii?Q?JPVr2mZcDLsoIJ6bLuViwIJWfvl65QO1TS3FlcpSTHeIzm/w/TkwZx0+23/y?=
 =?us-ascii?Q?12yBvtZEKv3LAvlK1dnng+cWer0bUT0O6sp4gj7vrsZywBjV11/wPQo2k5Tj?=
 =?us-ascii?Q?wjjM1Wl3O+1HiX6PFxlhLrkgeZ7SUK6m67Fj4+OctJjiUXm7CygbBwO1MU9H?=
 =?us-ascii?Q?CMdGeqSbrmlQGX2FBOGiSgqHvQNTxBTWtU+gpUv7gaDnvbbDffvlUOAl646O?=
 =?us-ascii?Q?X20mA4Xzvhbn9YG085P2tqFbkyBDfvP/WaskwDNqEYvwagnlFliiW62VVLpZ?=
 =?us-ascii?Q?9v+ITn4WtIoXssrIyYcZYUJUhKRnyQJFNx7I2nY9Oq/Yds3CX4U2UrKpy43Y?=
 =?us-ascii?Q?pQzbQa9TETeJQ/zw5+QLgkFzsxZMBKAx321RFWOh7etGMiu56s9efZICfEc7?=
 =?us-ascii?Q?PuBXXNodCtNxk1RYYlyb5NjrwR6xCCkv3Po9KIjA7Cpooxsv4En8VMdZBOXA?=
 =?us-ascii?Q?knYTwj0aLYsmGdr+bam9Njbjycxn8wLgV2H0iqSgdMMirJgC7DHgcDk5Q6/q?=
 =?us-ascii?Q?xDlZqsg7FUXcH+XC5IszyeyRZB/jlJum0xrtsNJcFosooiUUX0LdEVJUlR2t?=
 =?us-ascii?Q?0y5zz4f1LESbI4TimypIo7/OUlib9dcJ6fRwioD3qvvvBCbVay4qENjg31+g?=
 =?us-ascii?Q?BUu5luDNZ6gLQia8tZcHAj+p7rTXLve7zspExr/4pXwwXP3nonpolE9+KLiq?=
 =?us-ascii?Q?uLpXhTvb5c8k9zbe87zxbRGsSo0wUt1NpesReubby3/H8lb1MbW0HdQN3UuH?=
 =?us-ascii?Q?la6qvv+2nqjH8ksYeEA+P7SGbNUzlbaMHKmrr7h/vXtsOHIQHqxSnjBgTYPE?=
 =?us-ascii?Q?gC/Sd39A4VNywT5+LMsaMPl+Fwap26SiuNFHMJnc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef9eac-e6bc-4eec-bc41-08da6626d8a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 05:57:05.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKysqL6InQrhys5MlLuOCrmrdBmzKqWr5FvwGaIWe5dLFZoMD0w+WX55yFddKWPsZlI7ul8l8Y+Blw8pV1CuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
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

> If the new NUMA node onlined doesn't have a memory tier assigned,
> the kernel adds the NUMA node to default memory tier.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memory-tiers.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 79347d4ab05e..5706ad647136 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -5,6 +5,7 @@
>  #include <linux/slab.h>
>  #include <linux/lockdep.h>
>  #include <linux/moduleparam.h>
> +#include <linux/memory.h>
>  #include <linux/memory-tiers.h>
>
>  struct memory_tier {
> @@ -130,8 +131,73 @@ int node_create_and_set_memory_tier(int node, int tier)
>  }
>  EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
>
> +static int __node_set_memory_tier(int node, int tier)
> +{
> +	int ret = 0;
> +	struct memory_tier *memtier;
> +
> +	memtier = __get_memory_tier_from_id(tier);
> +	if (!memtier) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	node_set(node, memtier->nodelist);
> +out:
> +	return ret;
> +}
> +
> +static int node_set_memory_tier(int node, int tier)

Minor comment, but I don't like the name of this function as it doesn't
always set the node to the given tier.

Something like this would make it clearer the tier value is only used if
the node isn't already assigned to a tier:

static int init_node_memory_tier(int node, int default_tier)

> +{
> +	struct memory_tier *memtier;
> +	int ret = 0;
> +
> +	mutex_lock(&memory_tier_lock);
> +	memtier = __node_get_memory_tier(node);
> +	if (!memtier)
> +		ret = __node_set_memory_tier(node, tier);
> +
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return ret;
> +}
> +
>  static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
>  core_param(default_memory_tier, default_memtier, uint, 0644);
> +/*
> + * This runs whether reclaim-based migration is enabled or not,
> + * which ensures that the user can turn reclaim-based migration
> + * at any time without needing to recalculate migration targets.
> + */
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *_arg)
> +{
> +	struct memory_notify *arg = _arg;
> +
> +	/*
> +	 * Only update the node migration order when a node is
> +	 * changing status, like online->offline.
> +	 */
> +	if (arg->status_change_nid < 0)
> +		return notifier_from_errno(0);
> +
> +	switch (action) {
> +	case MEM_ONLINE:
> +		/*
> +		 * We ignore the error here, if the node already have the tier
> +		 * registered, we will continue to use that for the new memory
> +		 * we are adding here.
> +		 */
> +		node_set_memory_tier(arg->status_change_nid, default_memtier);
> +		break;
> +	}
> +
> +	return notifier_from_errno(0);
> +}
> +
> +static void __init migrate_on_reclaim_init(void)
> +{
> +	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> +}
>
>  static int __init memory_tier_init(void)
>  {
> @@ -153,6 +219,8 @@ static int __init memory_tier_init(void)
>  	/* CPU only nodes are not part of memory tiers. */
>  	memtier->nodelist = node_states[N_MEMORY];
>  	mutex_unlock(&memory_tier_lock);
> +
> +	migrate_on_reclaim_init();
>  	return 0;
>  }
>  subsys_initcall(memory_tier_init);
