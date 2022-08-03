Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE6588931
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiHCJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiHCJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:16:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054C20BE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659518199; x=1691054199;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JIcVkKiII0pEhmJiVbFwZlDXEPQt8Z/Gp6FpZkD+56Q=;
  b=KWNnwWZVNNLZkytkZQoRP8SNhkCBkiSj+8y7td3BVYL/nBdIa73A5Bb+
   /sVdH1+YvztO23b3rMsL3/U3QN6Ek5A9fUxmhc1YcIfy2cQrJX4IYcqEW
   RjuqBNfOcTEo/bEqz7P5en2RVhthG7mTinwqI+LCIwEmL9d+9EnNN9zeY
   lqm4KMdwgCCZ/Rm1uf/kjZ+s5cEkagSAk2QyWtCSMIum988D2UO3cIl1u
   7efSd7S6IuaqFfheZJuYdQR6oopPPpxUXGx9gJMsz3hQdOklIqUsBW/mB
   YVXMRFl3s7hXfNcibfv7duIr9PietQEZO7p2R3Ed29j+YPsVHUphSMudl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315484694"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="315484694"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="553254039"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 02:16:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 02:16:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 02:16:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 02:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVAQu8Xc04gDGcF9gg+F8ztVZyVtLRPTbe8YFY6cNDyTM7+IXuxfl7QgyvVZ9dwM3kNKZBbaq0pGAYMZ3+VGqBqh/N3HPy3xfyug6bEfBeC+eI9l5MVtymWoAbJMswGXr7dD7+hQJzkY7sY2tEGdInfU5F1SNdGJ5m9V+6Dea676pePWinSqY52UqqK4m1uBOeSUC26JAeUglEzWwxLWZV6ONVYryxzfKcxQJcqLKHzTFZqL7ybycq6Y3ISskNcYeAW/lAvNctoY+EyMswFj6PDevMfSWLmiiyaGbhjZd9DLCZIXigABD8PlyvEP253kuMB5JNRtRReheG+890SAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KFTsNQeggYzWHgCfj0/6BVnhdF4sCVfGKObEryN1qg=;
 b=jxwX2L/i9KIC5qcfcT/S3OeWxbukk99zGTRI/ZW8ia0ai3e0qCc+juBqE2av7oi+bwXkiliRpabEVVufW3H01iflghxyKcd1bnshhSjl+adEWpn9yoJPjftkZA0WdMxRz512O7eGW9xibCYflAydyyDXJKH6z4YvJLmkckJ1VWY/UcKkxLsed4rT1L5IzeBiHb+lHEQ9FzNoW3ryCtQn3LfieThjd/H0vXSku1C/Uv7ponKKec8ksuXAu6SpbgplqCQMD35yLYLrKPulm/hbL4tphZeSbGhtx9vMX79PEPY9U98qWpq1wLzPf8+/YtdmPXdD3XYM6jNnmxEwE3fJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY4PR11MB1959.namprd11.prod.outlook.com (2603:10b6:903:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Wed, 3 Aug
 2022 09:16:36 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Wed, 3 Aug 2022
 09:16:36 +0000
Date:   Thu, 4 Aug 2022 01:14:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <Yuqs+BTpfh9/PjtP@feng-clx>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YuolieBmdaIzoS3t@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0506408b-66b0-4609-a429-08da7530dd91
X-MS-TrafficTypeDiagnostic: CY4PR11MB1959:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVHVfIntYu4qqarAz/OBt7LHy5qgAXbpY45f4i1oJgMNfUVIl87ZvmPNCC3CFt6YK1jU8IVUPbqYEiAHBMDeFYAOMbDBLJgwPopQSSxUh5aF+KkDaYBIME4bUxTJJUT8PeSVcHAuNKQjbObyFUTicDyHVLMY3spyryy9EUahtE4Phqk5TCuaxhRsMqWYp4kSfJRkdxojiGZNh7UhRSNx1xK2MPaBxMlhWl9a0koswcSI2Yi5tZ0KH1Ci8EEvrGzKFq2VLnStWlNZR9A+MIORBMiyqpj6IulVHNIFZ45dm0oBY9vDvfLhmaWS2FHM2TBihH+khJ4+d1f/CIUHEhwMucBnoWYESwuxCT61DvH+Efqop2/avHskpQRQFmzoa3m46pa/rwGx82XdC+00i9UBQUXpkWO4lAMOTUeIemklAYOXPls98DSFvrDX6OHMILn16qaQb3qikErTiTxMnaSH2iRF278X3Znfci9htxxlfYsHdbzBYKBftpATbIP+YtLvakf9YFVq8fTz7+uv9N8XKJWM3kqouCypKbim2bgZCyLky2UZ8qCzmem34Rzsb8cfPciYGV5M2N98emz7M0UHL8pdXDB+9DiepgKiAxd3Be0U+s++hYz1xWu9B5E3dggLy6JvTVk7aPO29Dq76EgMo76yOsYjyFmvxVpWfvU3W1WtdQMAdUElEforEpbPPqRgaFZyGArlz2FF0WWa8xe8AqTgqH09FdmT8L6cZhjQx2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(33716001)(54906003)(8936002)(44832011)(38100700002)(6916009)(26005)(9686003)(6512007)(86362001)(6506007)(186003)(8676002)(66556008)(66946007)(4326008)(66476007)(316002)(83380400001)(82960400001)(6666004)(41300700001)(2906002)(5660300002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4Zo9/lh3qeFroNafkkdvHFqMyMRHlRnfnB4JOtVz07VBVmdVozfB8UVgFjI?=
 =?us-ascii?Q?KZIObBsG1VJenWlvSrvkFLKAU/j9ic9yoZPLwBfi0PcACE9H0kB8pjaSHG0I?=
 =?us-ascii?Q?4k3lP7TKa7q4PL/Ic5dJ0RDn7FZNOaiZ614x2oQpbxmD3h7faP3ffDahF3Jc?=
 =?us-ascii?Q?rtR3DlxoylIaNjGUAVsqH0FaXXhA6DI2dxlfEAzXN/OZdCKFviOjGs1yofRK?=
 =?us-ascii?Q?bkB2CvWnV1MYulaZswhuuuHVYkqgY5JMxETLjy74ZpP4V6xA2qubye+C4lI5?=
 =?us-ascii?Q?VbiTdTHz2sQcZ+zGXyKrjQW91xliPnB2noz8HnWz2Dn0dnWJUxYqXMRyRQB7?=
 =?us-ascii?Q?WhVRq2pG5zDb6Zv7IGnHqGpz2W8RwX+Y9QbNHu7646IyRXJc+idvq/nUBXL5?=
 =?us-ascii?Q?8Wr85shU1lwDMciko17PS1ojxstSI7bTyy70yhBQlTunxko/CmyH6mNHF4hR?=
 =?us-ascii?Q?I9x3SpynPy1zy4mfryJvMzqBeLwdwGYMnKrD78QIqfOg+x/0Koz5HS/rAssx?=
 =?us-ascii?Q?x8KZGj1wQjmn64bf8KYj2p1AnvePzQ9muwD6AT89O+5kI7ZWUF1iQwq7Kqr/?=
 =?us-ascii?Q?jlyjMnQD/evZicbwpEfiPJ3GbigEwT6nbHKHohs+dlKwYXEkAdAWZcyjLjmX?=
 =?us-ascii?Q?/ePoh6i4d2lclotW6uuDVTiLDc3wUeDaKYrB0bT3wo6O08B+fI/G6T68TJv6?=
 =?us-ascii?Q?jqiGHYGWqYv95zqiwc6b/oZlnL8QSBPbswj/MQ/n/P4NXgIoOkjV324+r6E8?=
 =?us-ascii?Q?92/GVcEdtl+N9v0fmEhLWzvrrWY2ODdBIEUcz0PsIoTz+QYZ888nQqm2OEQ3?=
 =?us-ascii?Q?EZ86v4PNkOnwUiT5qGHu6JP8oHYpWKnNIAXEvjYeqqugM1R/+jwoKwoe5XSF?=
 =?us-ascii?Q?C/JFV7+1NFKdI2MaCUt6HEsQ5fe9MyLWXlCN+qDD91eWY2BtLLSdgmuYQ5M/?=
 =?us-ascii?Q?pod8J3swyvooL+/LNcBRNn8V6nXtex4Sz5UmXS7pYe/8OaGtcnxwRvFkQ6ut?=
 =?us-ascii?Q?+fbYNQ2wkG69nVTL404loOWTNIhc2TsH35zS2v1bLlmjxcz0pBnvstkrAG2O?=
 =?us-ascii?Q?TwOdgTRgZBxlFJqyhM15tJW4lJ56t0duD0T/z1mNDrsMk7pJc0OTZCLCXfuQ?=
 =?us-ascii?Q?Gfuiji9+d8p9EL8Z6cfk6FPvGHCb9z7YMkdtLIoAdsU6rvlY31R4GlXJtPoY?=
 =?us-ascii?Q?9Nc1MaSFJTibjY1EfJ2oxaT+nesD4RLxQmPPAJTPkiEhaqIi5fE9jTbp7tOF?=
 =?us-ascii?Q?wBP+p/lNsU45ihhuJ9HkoEXh4nCnrFKYcxvUp4VFP5ra2nJ/xPxaW5BkC7Ao?=
 =?us-ascii?Q?6ZMBFFnKpFrqz5JtBistkXSVz7T7ocy6qoE2YwJpkSbcNEOBVmi96VMHo2Or?=
 =?us-ascii?Q?iX6/Db0OpFc+4HLRam9VkzaoZ/247XBCheGZzYuA2KWH6WNvJPSXS5HyaeXG?=
 =?us-ascii?Q?o3YlWvBEELM0alO+ZlQ7Qq9D2r7nGIgfcKtCDQhwV7s4QdayIhrANy3ePMtg?=
 =?us-ascii?Q?+IpqnpSDrp0Jxr+vPpGBDZp4FD94si5Zi6vYFkLu/Felgxr+6vww8NjKwexS?=
 =?us-ascii?Q?+HZi6uZAlt4cjSqIC5dJy2+FEJ7x/H833PXIpUJC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0506408b-66b0-4609-a429-08da7530dd91
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 09:16:36.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKiyCKJG+tVVKfoO124RhooWaSKkOaTc/jMAcVFZgTTdee0oztjiBDoTmITLVYplYYdnO8+xGxx4kukjbAqecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 03:36:41PM +0800, Michal Hocko wrote:
> On Wed 03-08-22 14:41:20, Feng Tang wrote:
> > On Tue, Aug 02, 2022 at 05:02:37PM +0800, Michal Hocko wrote:
> > > Please make sure to CC Mike on hugetlb related changes.
> > 
> > OK.
> > 
> > > I didn't really get to grasp your proposed solution but it feels goind
> > > sideways. The real issue is that hugetlb uses a dedicated allocation
> > > scheme which is not fully MPOL_PREFERRED_MANY aware AFAICS. I do not
> > > think we should be tricking that by providing some fake nodemasks and
> > > what not.
> > > 
> > > The good news is that allocation from the pool is MPOL_PREFERRED_MANY
> > > aware because it first tries to allocation from the preffered node mask
> > > and then fall back to the full nodemask (dequeue_huge_page_vma).
> > > If the existing pools cannot really satisfy that allocation then it
> > > tries to allocate a new hugetlb page (alloc_fresh_huge_page) which also
> > > performs 2 stage allocation with the node mask and no node masks. But
> > > both of them might fail.
> > > 
> > > The bad news is that other allocation functions - including those that
> > > allocate to the pool are not fully MPOL_PREFERRED_MANY aware. E.g.
> > > __nr_hugepages_store_common paths which use the allocating process
> > > policy to fill up the pool so the pool could be under provisioned if
> > > that context is using MPOL_PREFERRED_MANY.
> > 
> > Thanks for the check!
> > 
> > So you mean if the prferred nodes don't have enough pages, we should
> > also fallback to all like dequeue_huge_page_vma() does?
> > 
> > Or we can user a policy API which return nodemask for MPOL_BIND and 
> > NULL for all other policies, like allowed_mems_nr() needs.
> > 
> > --- a/include/linux/mempolicy.h
> > +++ b/include/linux/mempolicy.h
> > @@ -158,6 +158,18 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> >  	return policy_nodemask(gfp, mpol);
> >  }
> >  
> > +#ifdef CONFIG_HUGETLB_FS
> > +static inline nodemask_t *strict_policy_nodemask_current(void)
> > +{
> > +	struct mempolicy *mpol = get_task_policy(current);
> > +
> > +	if (mpol->mode == MPOL_BIND)
> > +		return &mpol->nodes;
> > +
> > +	return NULL;
> > +}
> > +#endif
> 
> Yes something like this, except that I would also move this into hugetlb
> proper because this doesn't seem generally useful.
  

Ok, I change it as below:

---
 mm/hugetlb.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 14be38822cf8..ef1d4ffa733f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -91,6 +91,24 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
+/*
+ * Return nodemask of what is allowed by current process' memory
+ * policy, as MPOL_BIND is the only 'strict' policy, return NULL
+ * for all other policies
+ */
+static inline nodemask_t *allowed_policy_nodemask_current(void)
+{
+#ifdef CONFIG_NUMA
+	struct mempolicy *mpol = get_task_policy(current);
+
+	if (mpol->mode == MPOL_BIND)
+		return &mpol->nodes;
+	return NULL;
+#else
+	return NULL;
+#endif
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -3556,7 +3574,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 					   unsigned long count, size_t len)
 {
 	int err;
-	nodemask_t nodes_allowed, *n_mask;
+	nodemask_t nodes_allowed, *n_mask = NULL;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return -EINVAL;
@@ -3565,11 +3583,11 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 		/*
 		 * global hstate attribute
 		 */
-		if (!(obey_mempolicy &&
-				init_nodemask_of_mempolicy(&nodes_allowed)))
+		if (obey_mempolicy)
+			n_mask = allowed_policy_nodemask_current();
+
+		if (!n_mask)
 			n_mask = &node_states[N_MEMORY];
-		else
-			n_mask = &nodes_allowed;
 	} else {
 		/*
 		 * Node specific request.  count adjustment happens in
-- 
2.27.0

> > > Wrt. allowed_mems_nr (i.e. hugetlb_acct_memory) this is a reservation
> > > code and I have to admit I do not really remember details there. This is
> > > a subtle code and my best guess would be that policy_nodemask_current
> > > should be hugetlb specific and only care about MPOL_BIND.
> > 
> > The API needed by allowed_mem_nr() is a little different as it has gfp
> > flag and cpuset config to consider.
> 
> Why would gfp mask matter? 

I'm not very familiar with the old semantics (will check more), from current
code, it checks both the gfp flags and cpuset limit.

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
