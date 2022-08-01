Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38C5866D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiHAJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHAJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:26:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1BF3A48F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659346014; x=1690882014;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cootwbKYjsITIQgvIlqsdEaE1LodlByS9smyMaXBHWg=;
  b=RlpAyEnTRI+0VyGeslu9UJnu1K6K+xXwtunJk461Uq1c+WPxAMGGZiTW
   o/COBOtLGaSA26FY59PsjIi0AzApUR9LLGWHKCDQqKyEh+1U0M9UJwcH7
   U1ipPmRcJ7B13ir8+rGWDtZzNqEzxCR/IoHMIyPPU2LOdJVMRdEbKke2R
   iT8ei1MEepxZ+Jzm19LZ08QT3T4sXbB+icJ9DH8aF6iVIJZAzZQNjacn4
   rQjcNc+4DZkTTItbmABYrhfSO1gV7fTAtJl7ZjBN40zNcStcXQ0jvbUdp
   OmGAP4roS8Imk/W6UrrTWfcSgHt4g5zJ839B3ef2nj918kWxNXBSp4L1q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="269484566"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269484566"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 02:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="929483016"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2022 02:26:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 02:26:53 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 02:26:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 02:26:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 02:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga1YYjlPi3W9VkLRpO2GydMDwKYaNfEUYAuD5mssOn6MCKdSK1OvFQDDM5OSkkAtgRuT9xvIQC8649vdclO8u7jYOckVmQpLDB81f6oGSFoga+ftdUm7aRIV5ZbaQgFzyXbmzW4YfeahucmMZStYAQZTF0gk3s9hqIjtGL1BUYUHxZ/+N9ONovQeUSd4LUvvniDDv6R+1SrEMLa1Y2MEg3f5NvFc+HUVSyrGV3qbeTetWMTxjuGOKAkMFjAs8XNnExaNnoZ/vNk+ZmJlQqdNBCDAEHNmbia8WwVOSUyH1ncysR2mc6uoLp/wsTgRqgrpgWbn92x4DsGUIv+fyRSxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm7NBIVtF35V7QZR7hoDNMRwysI24/G5F8+CbCJHWgo=;
 b=kFWWtY1MCN7gFFK2Fu8flZGNXg9KEa4JOHUw3sp1lBPGJJc8uqquDJOqxk6hlHFKAbxy6B02eb0UJjnQv/UqTrVDiqCDLscIJaywfLHJn0I+omT9+bBsBS0gEi8zyPN0Vw487hGOD91OqHLzPCqQVXqPv+VW0xLCs1fsXE27Y8fl+9HqOZXJTUNFjIt36buGpSTlZgqxytO+3tszuPtFDcJgPXiZ8vZsLzsyqaOppNfBgYZeww5XMfz/DKdKtxsM8gjGXJg6rVXwLJAG12RiCmYXj4dkbaazAyAJei84ExmGoO0AFe8E6fnEA0GcJqsbsUZQjzyvU31tXG7DKosl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BYAPR11MB2566.namprd11.prod.outlook.com (2603:10b6:a02:be::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 09:26:50 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Mon, 1 Aug 2022
 09:26:50 +0000
Date:   Mon, 1 Aug 2022 17:26:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YuecP/RKXWz7QAs0@feng-skl>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b97fef15-2e70-493d-616a-08da739ff6c6
X-MS-TrafficTypeDiagnostic: BYAPR11MB2566:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94njKwjFharCv4y2bOxyq/ylvHj6txVmhTn0rUNWSYqARWg9c6VP8peIYB0sFiVju4t84/BvC99hb0ueyQrMD4MakGWh+4JWXMY8nqv4GIkp+uGsI3z8s5pVwvfCdc74WCZky0WRz2BUd1+rTdXJ5cOHu4Dbun8q0qon8iOPSFt+TEvt9tNN9CaOdQamLJrgaDaueIPIZMAZY7Gzm8G2I4Ady/IEf1sMBOXwAOoOsL6dAPEO9tGKE0sJXs0g8z22A2u9QZbcDRRyt+qpeLkQVdPO9FltkwaiItRs43J9ln984rkj38+o21Y9WI1UJsbRSw/OuDqO1GMiP6eemE4lrl65qIoNSVOfLla5A52uduUA88PMUVHr/hcIX2aAiazknESVkuZ1Moj5gvd11EUG0Ormokj1RcSlc97V9OvgKr6hIc7ISgRdYmrfIWVlcQc+1OXXxjfDIxBavluLH6c69RabVzOD6SBcCPdZrFEUR0iUzbrQ/GxkDU9FadXcl7v7d8HndKmNENp1JSGwywCCsNtqBtFvMRzl9+RV6yJxqZNlW8uhaNjx7zXAhNgcACsKMKshEHsv41F++XQb7p74BqkBYkPWUGXtTCSf9lE+eVmCwISeVMhhhtCnzxOX7EnKTT3s++eCJrzYBw8jmZ6EnECXq8zaKLsdCejObU5wC2uib+ESv9bmyl4nkbeIvKzolb9pUYVAhXs/iXzY4fpGJIDoWHYj2eWuJjACP5VjQiqAUqOFRN6s91T6CHOss6hq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(39860400002)(346002)(136003)(82960400001)(38100700002)(9686003)(6512007)(83380400001)(26005)(86362001)(186003)(2906002)(6916009)(54906003)(6666004)(478600001)(41300700001)(6486002)(316002)(6506007)(44832011)(66946007)(66476007)(8936002)(5660300002)(8676002)(4326008)(66556008)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3cDYOFUbb0yzwmc+NOxpK+nTWyy0gn4XyuuR82Gbgr5nwVmauexVSlMTA/1?=
 =?us-ascii?Q?V9JUPRcgNw4GJbAEBKOVA/RqHT/RkBhIwvCdrweaxMb/3zMSZYN1Lz6wTff+?=
 =?us-ascii?Q?VA9vSQB1fxVWYhKpSm4IcS8wtb6GRWkL3A7itNDOnWgsboUGBBlZTUwYKXuZ?=
 =?us-ascii?Q?2HM1GjWBZuBLJpIYm0iRu9yWz0RIYaw5M0HUJk/vhmqUwQrvMULn/I8NWKiw?=
 =?us-ascii?Q?7SNrL/GQWlF+ZdJtJ7gnu+kce5tbdN1z0U3HkbEDKKByxJsfghcGhGFwtr3c?=
 =?us-ascii?Q?mQ6g0hmgvNFGaljONjyBQZrX+Fqbh0Z5Y78yRhtMgxoW5b39UZQhV7ayRLyM?=
 =?us-ascii?Q?5N/i5rBTOT9r1TNfzdZ+n1pFlVu7sHQ8l4eQBksYjdhBuyvKle5FvyiRR5LK?=
 =?us-ascii?Q?Z8+7VLSCwYx/kpKGt3al/XdT2Q96a2hAKjzdMhgAqu36OEUbfcg6BObyGEqp?=
 =?us-ascii?Q?aQgj3W55iaoPyQUMjOJIWJtgxKJsOfYwtAj/04BD+iVsTTxBkBKACHJ0OPPA?=
 =?us-ascii?Q?iq+GOuLEJ5kSrkA7k3GgDimQ545idl+2doMKpL5/OSV5KJDWI8cNmml+16cm?=
 =?us-ascii?Q?kpWGw1ySGKhp0+zBID1aWqbCjFP+AxmTLYgvh0eJeDnAjzyDIZ/3OdLwyBas?=
 =?us-ascii?Q?AKPnsqrEW6eDupNWAdmqTYEY0WhTdc9ny3FQqXfF7HZ+iNxAQkBbGVvSjvXG?=
 =?us-ascii?Q?iYsZKhbFyQrgQyHeY3ZyAtP6ZZC1IIoS78TEYGEsRZ/uurTSP9GmVTN0sU+Y?=
 =?us-ascii?Q?yZeoOH5eQbsY2GRAmUsSx652FTeSNm9xgU3vKAq8EA5CizCJoagalTG8BTAT?=
 =?us-ascii?Q?QGpQKk2hcrsUSgpz+VW4kMgxQ1vJvcFhU1bBXx2ahcU2lWX2X+3GMxq3DlY4?=
 =?us-ascii?Q?HhWbxezRakvWTs9CTenYq77DexTvgpyu0HEUQJjArLrelt5nn6djlMSfcZBS?=
 =?us-ascii?Q?1vUXGGekVHqPOAtj/qsqlCrRgoQFDkEGrtZtCzpKiGTC/9p8RiKWIcW0P87l?=
 =?us-ascii?Q?rNRhxUqwN6ep9iD92XuddkuSrisY5q66hTRUz9miNFeGWvx9Jyw0tyBuFhOa?=
 =?us-ascii?Q?qG5De7A8a80SC98cTe+3tzkin+RpfBG2SxaxW6WID/CRC4fgr4eJDzRiu185?=
 =?us-ascii?Q?c9iQPnVgjvIgtorhrqnA+BjQzx6Of5c/OLxTJ04IR3XkbFSAngenEyGIkD+X?=
 =?us-ascii?Q?Rkm/C0WKlxtLf+1k/A+WSWGZIJ+/JdOxZlVJQ+t+Gs6p5yWdrZJntSyHrele?=
 =?us-ascii?Q?WbB58ttD19iwxsNS+tXpnVutbzcX44NEyIzvMLXR8SOZ2abONkp9v2m9KPHX?=
 =?us-ascii?Q?lMQoUJEfj7P3zdngNMZpJ2sXw9ImRY80UHjJpMSX7QQ7GjzqwMOiJHUo9xd6?=
 =?us-ascii?Q?vaW2mZOIlg4+is8I5gzT7wbFLKKbmQ6Oujb2QtOXbxRH3Y2F4mXCRF8RqN4+?=
 =?us-ascii?Q?iEfRsNovDbuixlgXza3FYNwDpjgiG4tnluQMBCyPybunKBBXPjguLYoPUvYi?=
 =?us-ascii?Q?uQNCCFlsyrMrkRfbgLQeBI5C+XXueqdh1n/7H/crP6zgwOFM9AkvV02rXmxg?=
 =?us-ascii?Q?aRf69n6yEjU2+tHs5zSyUclW45LcOmWePwp9xmp7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b97fef15-2e70-493d-616a-08da739ff6c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 09:26:50.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATFHruSJ7cXMO+eLxOumh1hgTDEXT+cHCq3CCxID788G4Lm144LGGPHiypFkqkMlkMeJBM7VgAMUXCOXSXmNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 05:06:14PM +0800, Michal Hocko wrote:
> On Mon 01-08-22 16:42:07, Muchun Song wrote:
> > policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> > for filtering nodes for page allocation, which is a hard restriction (see the user
> > of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> > mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> > policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> > since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> > calling it.  BTW, it is found by code inspection.
> 
> I am not sure this is the right fix. It is quite true that
> policy_nodemask is a tricky function to use. It pretends to have a
> higher level logic but all existing users are expected to be policy
> aware and they special case allocation for each policy. That would mean
> that hugetlb should do the same.

Yes, when I worked on the MPOL_PREFERRED_MANY patches, I was also
confused about policy_nodemask(), as it is never a 'strict' one as
the old code is:

	if (unlikely(mode == MPOL_BIND) &&
		apply_policy_zone(policy, gfp_zone(gfp)) &&
		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
		return &policy->nodes;

	return NULL

Even when the MPOL_BIND's nodes is not allowed by cpuset, it will 
still return NULL (equals all nodes).

From the semantics of allowed_mems_nr(), I think it does get changed
a little by b27abaccf8e8. And to enforce the 'strict' semantic for
'allowed', we may need a more strict nodemask API for it.

> I haven't checked the actual behavior implications for hugetlb here. Is
> MPOL_PREFERRED_MANY even supported for hugetlb? Does this change make it
> work? From a quick look this just ignores MPOL_PREFERRED_MANY
> completely.

IIRC, the hugetlb will hornor MPOL_PREFERRED_MANY. And I can double
check and report back if otherwise.

> > Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/mempolicy.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 6c27acb6cd63..4deec7e598c6 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1845,9 +1845,6 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> >  		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> >  		return &policy->nodes;
> >  
> > -	if (mode == MPOL_PREFERRED_MANY)
> > -		return &policy->nodes;

I think it will make MPOL_PREFERRED_MANY not usable.

Thanks,
Feng

> > -
> >  	return NULL;
> >  }
> >  
> > -- 
> > 2.11.0
> 
> -- 
> Michal Hocko
> SUSE Labs
