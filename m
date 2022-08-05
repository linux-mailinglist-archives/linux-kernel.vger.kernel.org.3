Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38E58A411
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiHEAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiHEAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:07:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB31A052
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659658042; x=1691194042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W5f59a5+G2VmJnQEwtnQ4umsim0WY9c3t+6/uqkkcUQ=;
  b=eJKhwrl+qH/2sum17h8mcCeFsF9AWzuQTPhqSBRjb8XWIf7lwo4Dnyws
   Szv/BIsz8TKhworTpvk3oLD8fK+uuD0yqdlmxoNiOdHIuEMXdWHOhEVml
   Iw0V6QWyIoxJNmWIy/TUPHdZt5umTp3k9AB09QpE64OjI7qeqhsLKCdtQ
   ZcuYE0XrtpkaOlCB9N8/D00plDhStm9XJiCar/ORCFcECuFAYD5/mf0xC
   X/zSShkuT7K1RSdOWNvpZ7terQvInEjt/KCKNKJpTOYU7lX1oAy1SNMIA
   fZZwkyiqczaj2wEGIfPWWjPIHPuFz6+t0LavhUz3zQZaOjGl43GP1rE1m
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="273129725"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="273129725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 17:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706406014"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2022 17:07:21 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 17:07:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 17:07:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 17:07:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp5GF1+9LyWe3dDk/lRFATdj8hn2yMmdzJBoAQBgzmrJOh/5y/Tw1NJQn3ORxkNQHiU5hGXJLD+zJYG3dovLuB7n0HznFul6QnmHsfyJOh1meIbkU6cRb8vBGXyvwc7V++IJCyAvNQMH5exCCzpItzj9AHUnXpYPGpojAS2S3GlW/fdClJH4spFz6FUfHrvwvgnig1cAF2cxaTxty6CG0/RZHL4LPA8CuhCVknuotV3EmndlbX4k5dfj1Bsu2SGFpwiQ0dnWS6Wb/9MNtE1tw2wdR9xkeZxBHjNuCAdcKKowYA8nrHfymA7uABqWbSt4NZHig9veDFkTf1BIjnhbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJrR4rIBrrEhZbhXABsc5+G/eSn48kRVDaftVnVK04s=;
 b=KNX+VZNwKmq1QkjOy746HQuFDHVJKomozUZPua22eg8+osAML0Idg2RiPcDq+gaXQZiUIqtxGMI+e2EHGoNLqptaqyJyDzGXGIngm0WZxXA0D9rXkS8++YKoB/kZLYcNtiwdU84RCFORvO47NNgTLGNfeZuMmOMLQpx/+ask5Ds2xO9/GgjGKJTEoXpr9zOrdSJSRlwDJsL9kyw5fFL30ynh8Tp+TM7yOXAniCssUMsTZFFE+Spi4UqFaQYZLdImm2PCB2m45XttK8uK/3U5HFjdsAFZOo3iHwHSayAVCJshqWlLnzI+y/KV/6Yf9ixYLZXwVsbbuL8ex1qYL9h/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM5PR1101MB2233.namprd11.prod.outlook.com (2603:10b6:4:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 00:07:18 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Fri, 5 Aug 2022
 00:07:18 +0000
Date:   Fri, 5 Aug 2022 08:06:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "Hocko, Michal" <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: add dedicated func to get 'allowed' nodemask
 for current process
Message-ID: <YuxfBnf1Dw3HH2g0@feng-clx>
References: <YuuitMLOYqBcXMR3@dhcp22.suse.cz>
 <20220804130342.63355-1-feng.tang@intel.com>
 <YuvLcBp34Ac6Pd7a@dhcp22.suse.cz>
 <20220804153717.eea592a171accd245a0cc7d8@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220804153717.eea592a171accd245a0cc7d8@linux-foundation.org>
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 469bcddc-f461-4b39-2305-08da767675ce
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2233:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cj/d/6HBGalt+uRln+AcRwtgrjhQY3Pcei84kEn+v3YvNa9X4WgxOZKHArthNHG8f8Lt1FbOpGaqeFi6kDUzLN9X8ypb2Cg+GukiqdznZufBPRCvp5oqUhH4jXFQ1LsPZN+0JQFM3FVljsnLVHaJDC6Xb00cpC1H5yWEljcMoPA2HKGMdOjefGWfUT5wYIDuQttohsigJJ7BTPYu+975HDguxnRiwR+xjmunqdQgIhmLUnXjsL60YbTg56JZfNpG0FE1vQKWmoA4VBU5ytfrVy6U1kXebthxqTsUSDFsXE4etuEGtXWqhLlzTJnAEb2v8/in4ETd3SwJ1XGqV9zdkEzP0tfKtJ85crhekstLefpaGntqtdOn1Ktj9MDUqDOlcvOI0u49xQ68g13EAHEcXfaV3EUFuMElqjnnn0i2eeWAl4hS/d6JwLUxLN44DEJ9FhZZmkLzAnJ+gBE/r0bmCbYTfupANRtDejauYwu0qJUwNlcpvPW8IVq8n0eex+Kgg2SLpIPeoO+WRCKWfgu1nEvzBnmVwzV7EZ098PduwodwynOsZ3dXwtUjSeqpb6fKWbWCwSdY3N04v0syy1kNO51jA6/DDHgVNnEDm1qrowf52oSGEHvdvsJM/xCS0SpOvA91sLR5ysXgeGQP3RRGSUeHKpg7VqavzFANW8NdmwsM+t6IDnizmCoIcxp6MEDpchMuDYItXSlOJCVHq4Z3/OkWec2FFucXkDjRB6CEZno4S75bKGTx70tCulME5Uti
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(186003)(6506007)(2906002)(6666004)(41300700001)(26005)(9686003)(6512007)(86362001)(38100700002)(83380400001)(82960400001)(33716001)(478600001)(5660300002)(6486002)(6916009)(54906003)(316002)(66556008)(8936002)(8676002)(4326008)(66476007)(66946007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8szU/Y5ZdWly6j7vBAnX8HXSdg2VJFZXbEjopn1nHG0Y0HHqrsrTtcIyHck?=
 =?us-ascii?Q?HyGuADln72LYc5/rbhgBqKEWOe/eRzip0hAx/MpNv18666LhcO3VIG2tN8ty?=
 =?us-ascii?Q?Z6NuyPSXPMDsnjwg/UxBXYkdJNePgMW9U4s0+YGcGo/Xzq30l/Jd3EAAZe5H?=
 =?us-ascii?Q?Ot/d2ydMTQT8kJ2QUZ0/d7+ohPiwEOF6Vmn3MPaAuqGjSbfnN4PDs0US/0+F?=
 =?us-ascii?Q?7JV3u6oVN5NZIHIhGe+250o/1rp82sgJO/OjTbGsd8zAOEr0pon0kBU26A40?=
 =?us-ascii?Q?Ou8VvVegAeXk5b5liX6TmumdoD4IMT9mVXspQSTvtub0ke4E/CBrY69OsjLu?=
 =?us-ascii?Q?ECV3AR6dyppvE7Lfqj9BLQ/udEyfVMCY+wndHfEvkz+17pu/LabNleoB/VUc?=
 =?us-ascii?Q?Qf5SDLs/9Gpui6GWtCTNAcDQINjA4jZDSSBMElyUZsqLmJBQKZ/0Rcwyt/rM?=
 =?us-ascii?Q?8kS/jME9QFd5wcV4JmDRMYKgQeyVHQBSS2t1BeDuvWL3V6nIEdcl0HCuww3+?=
 =?us-ascii?Q?t1osBwxpQqyes7+U8rIFExtTUPbkyGhH3ww89DmqDXiAn8lH8Spn0kzjSD+f?=
 =?us-ascii?Q?I1Ycg5KVLxPhFz+0VStuUrgZIL5OiUa7f3c4TbxljNd28/s7N4S5ZbgxrtXz?=
 =?us-ascii?Q?rSWQvZTIMYMLNMeuAsq9Ow6dSqq8umuqzGQMmqgMwjUtu21Dr3GrtLr6RAqC?=
 =?us-ascii?Q?oYkTVrvWyNJ7HrL20KcdK+wXZvo2UX3isHZ3shJQyh0f0r2CFlcuJ0tmxoSj?=
 =?us-ascii?Q?5Pz2N2lO//EKtVTnZt2YU8yO8EeXN8CosYUUXhNc0jJszoOWWqRZ60/YwaAp?=
 =?us-ascii?Q?i56QFYueA+Fgkp3x8l5dhKAZ+dmS+8ZluFQYTS57VOLglNELLqvq0CZ1HN3k?=
 =?us-ascii?Q?orCD08eL0kWMla2inSx5ZSkVbq696MCbDt/5qRgyxRRnYQxJHs3MPKpLutWl?=
 =?us-ascii?Q?p4im5zcfn2hjKJfe/V8dunehuNF9NXsRAbKacyfJ0hAMhYPiu9D/x636vSBG?=
 =?us-ascii?Q?18UzVbxJ2AoxUXurcZZ3LkirBD92N8+MVv5YvbPuEYYqbCfk5yCPLmKpdZP8?=
 =?us-ascii?Q?GVWU1sAoIyyUcQAwg2HmVacRaDV+BvXrdvfFXM7AvOUdjxWQjAFduyez1bT9?=
 =?us-ascii?Q?kDzBYxhWO8ON04UEfWkPL7fXx5wIpN1hqSYTtlVV2mdHgGfWQUdysygk2Spm?=
 =?us-ascii?Q?1PWns8T/qvW9N7+O27npuaVZJlII3Ij4h0pPkpRPxEBberClZ47mP+GLn7lA?=
 =?us-ascii?Q?nfPuhzn/pDAunqfW5ymVs9HwcEGJff6DR2LXV71tSwekZbz2Ht8eQd17nvV7?=
 =?us-ascii?Q?b4n0bGAvx6Q44mRCk7/63rq73RNwUkKZTwFS5cl0B8i5JWiMzDDWIPTyQk0J?=
 =?us-ascii?Q?Lc4HQzOyxR+eWHZv8HU9H4b4Ase4vzX4y0MutvOTAcQsFNAuIIZfwU8prvo2?=
 =?us-ascii?Q?o0p5zqij5nUde91D3ojtQZl1Sr30PN0S2CEGX2pm3SCV5A4IVoGBEVkViHrt?=
 =?us-ascii?Q?bDpnOc7GU2F3SunCCMbamD1mmpRdzet3/MV4lzT4Q7s4kGJwch5aHMpQxSkQ?=
 =?us-ascii?Q?lZOBrieD/U8V4Dlce2MvYIiusQnvTvSL5osSYccK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 469bcddc-f461-4b39-2305-08da767675ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 00:07:18.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmLi/z5FNaXDIHqk3JDd3Qu6Nw5HXLNZZJvDSs1sMiquMkwvI4o5KsOfIbaeRIOz1hhA5Pfg6baqGIZQBBCzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:37:17AM +0800, Andrew Morton wrote:
> On Thu, 4 Aug 2022 15:36:48 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 04-08-22 21:03:42, Feng Tang wrote:
> > > Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
> > > in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> > > [1], the policy_nodemask_current()'s semantics for this new policy
> > > has been changed, which returns 'preferred' nodes instead of 'allowed'
> > > nodes, and could hurt the usage of its caller in hugetlb:
> > > allowed_mems_nr().
> > 
> > The acutal user visible effect description is missing here. AFAIU it
> > would be this.
> > 
> > With the changed semantic of policy_nodemask_current a taks with
> > MPOL_PREFERRED_MANY policy could fail to get its reservation even though
> > it can fall back to other nodes (either defined by cpusets or all online
> > nodes) for that reservation failing mmap calles unnecessarily early.
> > 
> > The fix is to not consider MPOL_PREFERRED_MANY for reservations at all
> > because they, unlike MPOL_MBIND, do not pose any actual hard constrain.
> 
> And is this Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY
> for multiple preferred nodes")?

Yes. Will add it in the next version, thanks.

- Feng
