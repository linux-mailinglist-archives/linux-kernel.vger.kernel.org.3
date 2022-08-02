Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A73587807
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiHBHki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiHBHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:40:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC132BFB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659426020; x=1690962020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p3vYTmaiIfKuFvxNpt+tNBr7OwEnnhZR8NqL157YhEI=;
  b=bdngiAqQqrvG8sjT3kecZEbTsxcx+OUfybgZOpHV911FfR2kuZDORG3W
   SsLCBCnysFm908887Z2vPp6YdUeQY7pA0tmm3L3G0knOgxOBwDfLZPcA9
   JGdjX3A0pv+cD8UNgIppaubRBdb5YOv/xdNHh6MKCzs5jYZddCcD4MaR2
   He3KLQxMjudFvF/Ff72J2egE6xhZIuzM4B4NHCIlBs8/R4Op4ZBne4Ncj
   Xw7gUpZo/nDhVzfMUVk/+T2zGy8a3i1tOJea02sTXZzeFQ8p44dvY6fi+
   YDKHv5HjewGY14Qad7IatMtqheaaMUb92/UnERjkbv6oyRXWjAuHmFHMO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288103910"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="288103910"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="929867533"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 00:40:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 00:40:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 00:40:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 00:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYPOPGoZcCg8iJ+2TEyAQqueTTTTkho3ZbimdJC2yagVYMuHcnfoE6uxCSOtR/S7L+fhtv3/adPDrZ9bEm3aHva7V5rt2nmiH3xneKR+CMaaBCAO9zsUALLpo4vaH67nN3fveEoPRZS0xhRtbeHZiWg1jvplo6+SsGBlLyLefQkYW15iixXDsZYGOMVfEmrLqczMugXBwgUCPxr2NGn6bKbawMWWyFPPRU/e7pEF6QDRxo8S5smXmUEatywM43DRM67iFuvUlZE6Enn7hls3UWeQMNIaqt4XWvIIZLJi7aTnKg+t8sjUZCL5o40JX3mrc4teN4xR2IE4nZWvuK5loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4VqLF05Ty0D5u3FpV0l4f/vbgvPrtpwwZI1IRnUWp8=;
 b=ax/zUGMm1uFSVhN7QNPBzEosQHW5BCM4mbP0/KTE7ZsNJxInHYRbBI7dTtHybK50UydX6ckAFOOayZdzCEhdUjwWrC/bAJN8P8AY9v2RDGiJL511FH1z+IWCr5f8cvW9DudH5XHwPdhhwhjWZXHaPRkYB8ffvC5Rg6x531RK7IUNwCL9PYbe4Sl6kf+JLXO9ILQqxIZslHt79esCsQu/meaalqrF+7pCoTaDnlzp0GsyydIZs96rIQKp8OffVDBQ0mYjk0MVFFpywiEJiPgmGZNqIEliKLyywbIkcD6AAgTiPbcl+Rmf2cUMoTpsF0zXG870Xh45/aWSIkE23NBLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6044.namprd11.prod.outlook.com (2603:10b6:8:63::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.16; Tue, 2 Aug 2022 07:40:17 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 07:40:17 +0000
Date:   Tue, 2 Aug 2022 15:39:52 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     "Hocko, Michal" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YujUyCIBjFj+FzX5@feng-skl>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bd49c62-48a8-44bb-13df-08da745a3e96
X-MS-TrafficTypeDiagnostic: DM4PR11MB6044:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFRBIwWFWZEucEPNZbgyRJ+ZohdJxIozAcHmMbrO2OtucNHWF6EfCLeiFk9sXIE3Tz3JEygGhKyvm/mywrtCFRa6VDKNNMiIToHZsoAv/EQttSAAeHA2reg+w6AQKU7jKjbPZDL4EWORLiA3CwMh75WjwYZlf6nbUNPBFblaW9XKJ0mNx3f0ru6HP6kk8bdWEu/u56Q2dEMdOk5439P+Vi9uTwjk1hrbgISbwKHTaIGFH6TRfB1nRRRyBFeuhJzH2RqwZFfdIFmYZy9ba68W5IEBvuVclWJ02ObBsCLRo+EJBgmX2kQr+g0vEmamalcXNNNNg9kbpjUztxtV9X3MIjPE/LgfZ24V0HL2o/UeW5Wtmh0fhTQxaciavUO+Tomk1sLS6yhajeqJzYsxiABmF2rNUXgHqS6RDzs05vIEviP6/+virsfrY60Ej8/4auJWnZznQb7fz0NEo2LIs2jyzkoEyH8KC3MzpsiQDJRGr9OpwENkxh79qR+ufPbZ8f0Z7cSG4ENW5MQU1T1jjzI2EVLMlapxmK5HE051gBcSCcLaHAvxSfZTrpKvWSMPQ9BdSSfFWYE2JXiKCxldnkPOQAnVUfR1OlFVPpqBtgVNzhahn7ImqZ9A/rrLhdurCP+0pDAJsUa6w90GYL/zsNT/AHT2Les+X7A09gRpnddcN2eqOX/uuZp+j1zMk+JZ447C2v9q/S6yl2n65aeAfQBHmDEjKq1tHrB5XKnfRKL6E+aj89xg+fO3sRbzHdTzbvby0/oh+tLml8/D8aN44LsA1n7rSnps3xh4ihw+a7w2snQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(6486002)(5660300002)(316002)(86362001)(66946007)(8676002)(66556008)(8936002)(66476007)(4326008)(82960400001)(33716001)(54906003)(6916009)(26005)(6512007)(9686003)(186003)(83380400001)(38100700002)(44832011)(478600001)(6666004)(41300700001)(6506007)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bEfr4XOGXmX/Eeqvj/kc3Bzyqapca/HkFoHXiDtwV5HfSdIbpy1ZYUkD6pb?=
 =?us-ascii?Q?ZecAs+AHoXkcpxylMLciQv+flYdvwrBbqXFgd8bGVd/vO4XWjqUlZ4ZiMy8G?=
 =?us-ascii?Q?kHxo41/ByZW2/7Z12Ql/wKnKLEtFXnOeoc9qdWZXj+lSOjJnwn7+4tIiaFF9?=
 =?us-ascii?Q?HTBuJUle8kwck4ulVXdHxv+kNgXReRI1oQbxLXOu6Hyzbu+jOmGdEkbXizdt?=
 =?us-ascii?Q?E7OyZZ8WpelHlDbVnHxX12//QIrJsHv2rVWiCxkSZTXRWO1J861G7dBx7+sz?=
 =?us-ascii?Q?5pJTpacq5QqpoZ7Hy9rxGw9setbIqjIFGP0ezFFxMM02nQtSiHqe8SkLDaqc?=
 =?us-ascii?Q?RoqWrKkmhXEsvcTG5bU9kG++/dgIoOEZowgx0MU1b/dSsOdVg5+56z9TzokG?=
 =?us-ascii?Q?bHmUC9RchB1TOy2Y8hLPzTQryVlFgpOH0Cgi1eU1mgrAf3w7erh/mrIuFSXs?=
 =?us-ascii?Q?Ppe0l7tc6om5+02MFLEq5RUJy3nsaOdiXILPdql2tgwcpUtmhgw3ZXLHmkQJ?=
 =?us-ascii?Q?fsq900nq28a8h6CpeTn93hsezr9sbROxSxfL3egHaA7GyiHAL1QGMfJ8nzQy?=
 =?us-ascii?Q?8OODGuUvDQjebfHWl7ewqOth3NI9yWFXS3odEvicCcUQqPyihPPuV+4BEP8f?=
 =?us-ascii?Q?QQ0GM+5qq3VYkuwsnkYOO0STpKasD0wBDtszdIr2j9qD6ktnY9js6ti+J720?=
 =?us-ascii?Q?MsY4e0QBVGzr9WIHcUqc4uRw6JtPqxfn7YAmOQJnaRqU0pXJiiAaBbLRqnCu?=
 =?us-ascii?Q?QmpAA2H1lM6CIUu7VUzaC+ZhuRsxic1bcJ704Tmpuxj1eLg0QBAft/V/6THG?=
 =?us-ascii?Q?ZYI6URwa2t0ZIK4Wo9t5HsiRquSyVeWo159dOXkOgM0zlKAAK7YBHrb5V7JO?=
 =?us-ascii?Q?nSt1GYIegenwOQDAMQKX3k+wcKJZt8hWTZMixGaY1NwCKwROCpIGSrHkFZ9Q?=
 =?us-ascii?Q?P5FQuZ3BXxc/dbXLZcwg1vVKNk9A6Ekf1tQcHIL5RTRzh/Dv0ij1+BlB/FnN?=
 =?us-ascii?Q?5ARQwdgUk/8xPxXpxdJSAZzTrBV9KHcPq0WPBxK0ZNepMDZf9sqfO+jszrhr?=
 =?us-ascii?Q?1L9qM38SLBANYsNBBSR973vzYQP+eAJrWvNgWV+zNHBsXjSD237amFJihNK0?=
 =?us-ascii?Q?F+QP8zBf70QnVIQSDIyaFMqGHNl8VBLln5mxNHNwnmrfOYY/mWNNIhlMr1Bk?=
 =?us-ascii?Q?uUu+ae2y23VaAfRrZF3eljcoorZKqO/IiaVvHn5kjMDF1TfPl3H0MKybSCwZ?=
 =?us-ascii?Q?/tEoWqgQLecEg24qFhdCFC7gvE41NMICJTF6cD2GWh7h1nIma/RgN3llrkS+?=
 =?us-ascii?Q?Fgi6nYfbwE8YFtr7wZVVQXek8rRtYI07vUBQQEi8yFSNjYFie1qZDL/17qiV?=
 =?us-ascii?Q?HRdeiC6Arb+KE8/FpW3hox+9fQL2K2XsJr4IvGgBmKEEUGtYpC6oCifpK9vV?=
 =?us-ascii?Q?6LQ/AWz/VHlavOpRuLXWIlasoFnbSb0zaUGzaGaCU78vd/ZYIL88SvxaDQnQ?=
 =?us-ascii?Q?8ZxXeCUks1O8/Tl/gin7LmHbbZNsRsWTTTHttMkfZuQazS4YB2wcsxm0xG1S?=
 =?us-ascii?Q?H4G94wcuSUVeZYSlYHBJYVpbj4GwQWB6sXSVpFe0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd49c62-48a8-44bb-13df-08da745a3e96
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 07:40:17.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byHmxj2Q34FZaWPFG42/1v51yPjj8UnjB0s6TwFeAWMtL/g+jq18Wgbw/OAg5z4whcsDtz+1/koRa3yTcb71sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 02:40:11PM +0800, Muchun Song wrote:
> On Tue, Aug 02, 2022 at 01:52:05PM +0800, Feng Tang wrote:
> > On Tue, Aug 02, 2022 at 11:42:52AM +0800, Muchun Song wrote:
> > > On Mon, Aug 01, 2022 at 05:26:23PM +0800, Feng Tang wrote:
> > > > On Mon, Aug 01, 2022 at 05:06:14PM +0800, Michal Hocko wrote:
> > > > > On Mon 01-08-22 16:42:07, Muchun Song wrote:
> > > > > > policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> > > > > > for filtering nodes for page allocation, which is a hard restriction (see the user
> > > > > > of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> > > > > > mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> > > > > > policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> > > > > > since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> > > > > > calling it.  BTW, it is found by code inspection.
> > > > > 
> > > > > I am not sure this is the right fix. It is quite true that
> > > > > policy_nodemask is a tricky function to use. It pretends to have a
> > > > > higher level logic but all existing users are expected to be policy
> > > > > aware and they special case allocation for each policy. That would mean
> > > > > that hugetlb should do the same.
> > > > 
> > > > Yes, when I worked on the MPOL_PREFERRED_MANY patches, I was also
> > > > confused about policy_nodemask(), as it is never a 'strict' one as
> > > > the old code is:
> > > > 
> > > > 	if (unlikely(mode == MPOL_BIND) &&
> > > > 		apply_policy_zone(policy, gfp_zone(gfp)) &&
> > > > 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > > > 		return &policy->nodes;
> > > > 
> > > > 	return NULL
> > > > 
> > > > Even when the MPOL_BIND's nodes is not allowed by cpuset, it will 
> > > > still return NULL (equals all nodes).
> > > >
> > > 
> > > Well, I agree policy_nodemask() is really confusing because of the
> > > shortage of comments and the weird logic.
> > > 
> > > > From the semantics of allowed_mems_nr(), I think it does get changed
> > > > a little by b27abaccf8e8. And to enforce the 'strict' semantic for
> > > > 'allowed', we may need a more strict nodemask API for it.
> > > >
> > > 
> > > Maybe this is a good idea to fix this, e.g. introducing a new helper
> > > to return the strict allowed nodemask.
> > 
> > Yep. 
> > 
> > I had another thought to add one global all-zero nodemask, for API like
> > policy_nodemask(), it has 2 types of return value:
> > * a nodemask with some bits set
> > * NULL (means all nodes)
> > 
> > Here a new type of zero nodemask (a gloabl variable)can be created to
> > indicate no qualified node.
> >
> 
> I know why you want to introduce a gloable zero nidemask. Since we already
> have a glable nodemask array, namely node_states, instead of returning NULL
> for the case of all nodes, how about returing node_states[N_ONLINE] for it?
> And make it return NULL for the case where no nodes are allowed. Any thought?

I think return node_states[N_ONLINE] can simplify the code in allowed_mems_nr(),
the empty zero nodes can simplify further.

Here is some draft patch (not tested) to show the idea

Thanks,
Feng

---
 include/linux/mempolicy.h |  8 ++++++++
 include/linux/nodemask.h  |  7 +++++++
 mm/hugetlb.c              |  7 ++++---
 mm/mempolicy.c            | 17 +++++++++++++++++
 mm/page_alloc.c           |  3 +++
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..b5451fef1620 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -150,6 +150,7 @@ extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
 extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
 				const nodemask_t *mask);
 extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
+extern nodemask_t *allowed_policy_nodemask(gfp_t gfp, struct mempolicy *policy);
 
 static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 {
@@ -158,6 +159,13 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 	return policy_nodemask(gfp, mpol);
 }
 
+static inline nodemask_t *allowed_policy_nodemask_current(gfp_t gfp)
+{
+	struct mempolicy *mpol = get_task_policy(current);
+
+	return allowed_policy_nodemask(gfp, mpol);
+}
+
 extern unsigned int mempolicy_slab_node(void);
 
 extern enum zone_type policy_zone;
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 0f233b76c9ce..dc5fab38e810 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -409,6 +409,13 @@ enum node_states {
 
 extern nodemask_t node_states[NR_NODE_STATES];
 
+extern nodemask_t zero_nodes;
+
+static inline bool is_empty_nodes(nodemask_t *pnodes)
+{
+	 return (pnodes == &zero_nodes || __nodes_empty(pnodes, MAX_NUMNODES));
+}
+
 #if MAX_NUMNODES > 1
 static inline int node_state(int node, enum node_states state)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a57e1be41401..dc9f4ed32909 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4340,10 +4340,11 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 
 	mpol_allowed = policy_nodemask_current(gfp_mask);
 
-	for_each_node_mask(node, cpuset_current_mems_allowed) {
-		if (!mpol_allowed || node_isset(node, *mpol_allowed))
+	if (is_empty_nodes(mpol_allowed))
+		return 0;
+
+	for_each_node_mask(node, mpol_allowed)
 			nr += array[node];
-	}
 
 	return nr;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..3e936b8ca9ea 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1845,6 +1845,23 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 	return NULL;
 }
 
+/*
+ * Return the allowed nodes mask for a mempolicy and page allocation,
+ * which is a 'stricter' semantic than policy_nodemsk()
+ */
+nodemask_t *allowed_policy_nodemask(gfp_t gfp, struct mempolicy *policy)
+{
+	if (unlikely(policy->mode == MPOL_BIND)) {
+		if (apply_policy_zone(policy, gfp_zone(gfp)) &&
+			cpuset_nodemask_valid_mems_allowed(&policy->nodes))
+			return &policy->nodes;
+		else
+			return &zero_nodes;
+	}
+
+	return NULL;
+}
+
 /*
  * Return the  preferred node id for 'prefer' mempolicy, and return
  * the given id for all other policies.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..3549ea037588 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -181,6 +181,9 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
+nodemask_t zero_nodes = NODE_MASK_NONE;
+EXPORT_SYMBOL(zero_nodes);
+
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
-- 
2.27.0


