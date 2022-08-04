Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9386B58994B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiHDI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiHDI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:28:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87365839
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659601724; x=1691137724;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zkkJnmO/5aJRtpgLIgUlxjwLqUlhEF7MRZsMGboXuHI=;
  b=e04E3p9Xr+XOPJFi+ePJlqIL4eXlUzkf5OhVaah+KnJcUQOwo9+vfUej
   jamYGSEPEuxbjgxZdvE03OpmbWSYgs0JJLJnPFygbseVN921RrrUyWmOc
   7kE5n1cXZ0ULHVmpXG8RVPnUJ0XKosonfSlYsJA2Tg2LFWRr0raJQwGrB
   +vxHUcwhERU/IIlykxxI8XtAKbZdCywQ5yykw9iVfh+xIz7mEo7hXBYsQ
   LINYGiFZjgJVb+zNmmmbbeRUKC3P/MltfgMFpsuUzbexMyEEk5cCUUK5x
   Cd1S3ak3A3LwRbhM1bvyG1+Vr2GPq9bHMZOII3aICZKD3ATqxF6O1b/ir
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="353872738"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="353872738"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 01:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="745379783"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2022 01:28:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 01:28:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 01:28:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 01:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2sv019TZnC8CjTYs5EkYf1XkYMSVMpFY5KKdvRZAPTAXYFmG6SzMugad0D9zUvCrPWTqD+fF63OXi+uToAGaJAJ70LpVk6wew2QYwRYAYzlcLysaPtCJx54aLtoWul703ymWD4rin9i3qZSwrOVy+bOEGazs9nSKntMdiXT2/Ms0LbYEIQ0gEmWxvyEAem8UFytVzgkc2+LKKl/dxoADRhyv61VYhhy0PIt5ydPCh0z2X+BaifXp3jTUY6B7Y3Sj2OqTPbeICs8Ax20VyGlaOuHLtV29UZyfluNBInP4Yi0Z1qOqrhZ0XZEp+3R2ZqClh+AkVhIK2N3EUd0xgJ3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwIkzJ7LT6o0Ey0It6oEkyxNbPV/lcUB8AU9kRHWkY8=;
 b=CS5JuFyV77EBJzZ4C1BqpwW6Gee4Y65XynFZp3thHC5ZU//MpnrvVJ+nRbphnpNVRnjBs4GH8metl1Pcj93Xq/QBhofBXM68bfTanuXh8EQnFYAWo2H6hFrKc8LNmoG5SXMxItiAIKKj9YKnOF5NDVHXur6AeoYwfQnLwPxqJXqWEunV5I351AeuXcF9rV5eSyloSTPgp4JZa1U0vfnNGlteAiiK6Il47TflwM3jP8ytr+4GKTWtjHRmplyHBedVr7NjBWhYny+EWOtt6i+DAoKvHwQ9xXWBrYRkwjmaLyeQfUejCzHihGsPoBNzP+gANRzALZZRMerQIppDtDnlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6381.namprd11.prod.outlook.com (2603:10b6:8:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 08:28:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Thu, 4 Aug 2022
 08:28:34 +0000
Date:   Thu, 4 Aug 2022 16:27:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YuuC7MBQ1bX3jA0j@feng-clx>
References: <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
 <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
 <Yurd2iYp4XMIYM7T@feng-clx>
 <YupwjN6K6e6V3y+Q@dhcp22.suse.cz>
 <Yurj0sOXgGf40AJE@feng-clx>
 <Yup2UimZJgbgFb3S@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yup2UimZJgbgFb3S@dhcp22.suse.cz>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922ce0b8-134f-44d6-2a0e-08da75f35208
X-MS-TrafficTypeDiagnostic: DM4PR11MB6381:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9MFgb8wVuE4OFqjjJRFwWBLuFXS4cbe2Uf/WO589dQ6zBbBu0Fl03LuA8Lnj5yAh7HTNAP9D4l7FFw/2ylnSmS6EbKEJdNBHEXQzukL9PMnRByV6l6eTWbRdWARmZD82anjgeWgQED4CIgm8tK38kI9KDS3KrekU+ANKD0Q+BenX9LzwCJ4ZMtpmFYOMbcAwBPDu6t67ukUkp/KmXsJbOC9cGz2LJf/tmABeOx01uKFFz220VVREfEHiAryDfevXQgF+z3IMlVBYjhhp2SKu8dpDrzdO4c2EA6i7upHayhY/YGG5diizAMviyl8kmicUi/VGWWB5vI36OhoCkxbWKRK7+P8johr4LYG5EEHu5BqjwLx0FLkz2wgRBR4U1HsnQ6Lv5O9QmvRj91T9N3FUeHpPEWAxu8FWYqxO9lGYs/Q9ztlYa/peTKpaefAVnyY02rdNoTnwl0f8L+JAcyUp74/AH+aDbPG/TSnH3ZngpqkO/FbCAbBzP8S4qqQWyABGltq8RXMesbckOB1AaQaEtbJE50/Esg49CoXcZh2+G0CrzQEwaYgcP2Xz80h+gLRIm2SgmG8IIWQ6tCdcOoIN1nnUVoV9HS6cVbiq8/AA5KQxEZyuQtTaovIBu0v5bESTyhEW/LcU4rpHT19dENIwqfBit8odIQUybIOuTkd/RZ8MJl8FL+1Aohf4ddQHEY0FxRIcu1opCE2athB4G2Zij3nhz5m0BiEMteeH2TYQ2juZ6G0dDFCLJcyAWL7RNrqS5/AEwXuO/RzbAEk2YiHSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(39860400002)(366004)(136003)(110136005)(54906003)(316002)(8676002)(4326008)(66476007)(66556008)(66946007)(83380400001)(478600001)(8936002)(86362001)(966005)(6486002)(186003)(38100700002)(82960400001)(44832011)(2906002)(33716001)(41300700001)(6666004)(5660300002)(9686003)(6512007)(26005)(53546011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3NKeaeURZjLPQhB3eXVzHKWEVAeaFuTBMCvx8ZHJ6nh8V8YGwJ5goTWvPPV?=
 =?us-ascii?Q?egQoX9wQYG/eJ1TcGDef22QyhX09zs7MQhMh2bIjvnJsJyVpDwQxQ4S06gUg?=
 =?us-ascii?Q?D8UcgZHMKEDFaZGEzaS047oOSOWT6kNuXTdpSF3zEMKc2qyiRYQNzqjjN1co?=
 =?us-ascii?Q?x1u1oV2Diry6SXc996oFkvbg1MPP8oSEim+ThXKj6wkfEyhc2qqZdZMXvDrt?=
 =?us-ascii?Q?e2kq4l4Rs+VgBoWF4R2xAMxrJZpIbtmyg+CAve0FyZm/25FRnTrjDR320KJW?=
 =?us-ascii?Q?fmT3Ltdr/R+vDccPcv0J0fjJHav3Tlqr4/A/8oA3hAe1KFL+lmq1jVfBRXZK?=
 =?us-ascii?Q?BzwLBuxG3i/AfTBT0av7f7ppYltYk4UGv0B/qzWyQ+Uj9EbreXtyGeOjFMLX?=
 =?us-ascii?Q?uzcfMIV3DkVMsmrzxFTkbP9YiFduy2g1c0RkiIwdD1vQT2TaaBIj/dK/clFG?=
 =?us-ascii?Q?rGcH8nX/YICU/fxw+RQ4nNc8G7QgXpzpAVZVOptCwao6M5qRGWyFUCvu45Jr?=
 =?us-ascii?Q?TSF2cZ0EC4DMX8//KoIVYnU6P7kw4QLvk2lSx8L/6UlP4BZvyp7KlQYbF0wQ?=
 =?us-ascii?Q?aR4ZaCdbrUa74u7sw5SlP02c0rtjQ7/hgbSEvTkY9ssRgCbT/7WSGRjywhqh?=
 =?us-ascii?Q?IQ4T92TolMqJvkZp0xxiTam76IQjs5fZdRO3dJMnHaTgPpQqNzwV8HD/Zs6h?=
 =?us-ascii?Q?oAooEPg/5nEtvN/Uj3KWLy1o6heKOpuoyYxY9MjyBaQaXLqX7l84bvkts8yU?=
 =?us-ascii?Q?BGZveeg+rxIBnJu5OAlfwMij72zd6WZXMO6crOzt3xmUkKxnySOl+/SFIcml?=
 =?us-ascii?Q?0kiT2wKd3LVtXxQATIU/qtnSsCZTk992CL081IM7g31FeyHRq0e2qICjUW92?=
 =?us-ascii?Q?AYyIthMenBfsChJ6h5w1J6lEhV/dwkYsPZSIVhv8RVZitKPbDroWTNKGCJtu?=
 =?us-ascii?Q?XSNGAjQsg5GNlXYexOInakAAolIyXNyzw3s4NRnlWiZfg1A7dliVZ7vc+wFI?=
 =?us-ascii?Q?eelw5N1/J8Ccj4lXDfWq4+hF9QDvtag2gLLVVOmJE4eARHUpg3bM/N4oXVOw?=
 =?us-ascii?Q?p7LyWVgGwac4RHQz7sWhVzqjTSSkOH1glVf3fbEzHP/xU6T44ONo4hll4p3z?=
 =?us-ascii?Q?ayoHPfmGyF7z7d+27HHyzQTSwKd7u+3Dr07X3hffJfjfPZhlJIpBov6JHqIY?=
 =?us-ascii?Q?cZvVVLLiK9kR+NG/4QUzzV9n0ASI/nUj4v8Lp8sB6Rey+1OTwkbCVzEedHZE?=
 =?us-ascii?Q?jex7jmaUe2RhWAJiFtonzcKMHxuKvJKVohs3+Y7e4rGLcNzmeZaICNdtZnBw?=
 =?us-ascii?Q?5g57Vv/8eMqtW1Y8StSoJ3eRPbWiOq0jLoyKmXaI8v4a/lMrEbLU5LBmoEfX?=
 =?us-ascii?Q?jrCrwTIfKxOOaADwrdoo1aN67EMGH1M37dLjjAIda4V8KQWAHek6wWWgyTj6?=
 =?us-ascii?Q?WvZwOqLKWZiJ+HQpvxlRr+ZwWblA8I2yv/ww4texsDPYjTHHdiqkREqe3DyO?=
 =?us-ascii?Q?HAU+Oq1J/UYCTlr6zgESWJPyuNGFOm042jmLyKLoqtg5Iq643OkNEJW/XDoP?=
 =?us-ascii?Q?OW98WwTcYv6O2yJt5VHXtDwXoO05ij2hOyG3uKj/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 922ce0b8-134f-44d6-2a0e-08da75f35208
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 08:28:34.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmeDKDrdUMn9m8nUYwiIzzBzpadDgQzNCI2BuM+9g+ek2zhCiCbpLGXaZSPt2fGa4dUN3JT8pOxWnvXUtbaYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:21:22PM +0800, Michal Hocko wrote:
> On Thu 04-08-22 05:08:34, Feng Tang wrote:
> [...]
> > Do we still need the other nodemask API I proposed earlier which has
> > no parameter of gfp_flag, and used for __nr_hugepages_store_common?
> 
> I would touch as little code as possible.

OK.

Please review the following patch, thanks! - Feng

---
From a2db9a57da616bb3ea21e48a4a9ceb5c2cf4f7a2 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Thu, 4 Aug 2022 09:39:24 +0800
Subject: [PATCH RFC] mm/hugetlb: add dedicated func to get 'allowed' nodemask for
 current process

Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
[1], the policy_nodemask_current()'s semantics for this new policy
has been changed, which returns 'preferred' nodes instead of 'allowed'
nodes, and could hurt the usage of its caller in hugetlb:
allowed_mems_nr().

Michal found the policy_nodemask_current() is only used by hugetlb,
and suggested to move it to hugetlb code with more explicit name to
enforce the 'allowed' semantics for which only MPOL_BIND policy
matters.

One note for the new policy_mbind_nodemask() is, the cross check
from MPOL_BIND, gfp flags and cpuset configuration can lead to
a no available node case, which is considered to be broken
configuration and 'NULL' (equals all nodes) is returned.

[1]. https://lore.kernel.org/lkml/20220801084207.39086-1-songmuchun@bytedance.com/t/
Reported-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mempolicy.h | 32 ++++++++++++++++++++------------
 mm/hugetlb.c              | 24 ++++++++++++++++++++----
 mm/mempolicy.c            | 20 --------------------
 3 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..ea0168fffb4c 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -151,13 +151,6 @@ extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
 				const nodemask_t *mask);
 extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
 
-static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
-{
-	struct mempolicy *mpol = get_task_policy(current);
-
-	return policy_nodemask(gfp, mpol);
-}
-
 extern unsigned int mempolicy_slab_node(void);
 
 extern enum zone_type policy_zone;
@@ -189,6 +182,26 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 	return  (pol->mode == MPOL_PREFERRED_MANY);
 }
 
+static inline int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
+{
+	enum zone_type dynamic_policy_zone = policy_zone;
+
+	BUG_ON(dynamic_policy_zone == ZONE_MOVABLE);
+
+	/*
+	 * if policy->nodes has movable memory only,
+	 * we apply policy when gfp_zone(gfp) = ZONE_MOVABLE only.
+	 *
+	 * policy->nodes is intersect with node_states[N_MEMORY].
+	 * so if the following test fails, it implies
+	 * policy->nodes has movable memory only.
+	 */
+	if (!nodes_intersects(policy->nodes, node_states[N_HIGH_MEMORY]))
+		dynamic_policy_zone = ZONE_MOVABLE;
+
+	return zone >= dynamic_policy_zone;
+}
+
 
 #else
 
@@ -294,11 +307,6 @@ static inline void mpol_put_task_policy(struct task_struct *task)
 {
 }
 
-static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
-{
-	return NULL;
-}
-
 static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 {
 	return  false;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a18c071c294e..ad84bb85b6de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4330,18 +4330,34 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
+static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
+{
+#ifdef CONFIG_NUMA
+	struct mempolicy *mpol = get_task_policy(current);
+
+	/*
+	 * Only enforce MPOL_BIND policy which overlaps with cpuset policy
+	 * (from policy_nodemask) specifically for hugetlb case
+	 */
+	if (mpol->mode == MPOL_BIND &&
+		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
+		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
+		return &mpol->nodes;
+#endif
+	return NULL;
+}
+
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
 	unsigned int nr = 0;
-	nodemask_t *mpol_allowed;
+	nodemask_t *mbind_nodemask;
 	unsigned int *array = h->free_huge_pages_node;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 
-	mpol_allowed = policy_nodemask_current(gfp_mask);
-
+	mbind_nodemask = policy_mbind_nodemask(gfp_mask);
 	for_each_node_mask(node, cpuset_current_mems_allowed) {
-		if (!mpol_allowed || node_isset(node, *mpol_allowed))
+		if (!mbind_nodemask || node_isset(node, *mbind_nodemask))
 			nr += array[node];
 	}
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..5553bd53927f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1805,26 +1805,6 @@ bool vma_policy_mof(struct vm_area_struct *vma)
 	return pol->flags & MPOL_F_MOF;
 }
 
-static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
-{
-	enum zone_type dynamic_policy_zone = policy_zone;
-
-	BUG_ON(dynamic_policy_zone == ZONE_MOVABLE);
-
-	/*
-	 * if policy->nodes has movable memory only,
-	 * we apply policy when gfp_zone(gfp) = ZONE_MOVABLE only.
-	 *
-	 * policy->nodes is intersect with node_states[N_MEMORY].
-	 * so if the following test fails, it implies
-	 * policy->nodes has movable memory only.
-	 */
-	if (!nodes_intersects(policy->nodes, node_states[N_HIGH_MEMORY]))
-		dynamic_policy_zone = ZONE_MOVABLE;
-
-	return zone >= dynamic_policy_zone;
-}
-
 /*
  * Return a nodemask representing a mempolicy for filtering nodes for
  * page allocation
-- 
2.27.0

