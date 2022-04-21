Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293B7509933
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385813AbiDUHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiDUHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:37:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F82B59
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650526495; x=1682062495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uv7XZsVYEeTMXndEQTjHTgi2SxFXCtVBzub9tUQUc4U=;
  b=ZEN9ummPbR8EjWsfArR05rGbKzOi4mMXwtGutqa0YJPKFhccOqpF5eWN
   GLhKh+HLcClEAcpx+chtQmado1R2gqlvJzXNu4LNIYydlsSrUMaWYKDso
   hqKronzwIh0qx4fA6uTYD3ElkWemMZwhzWzEkCo8AE1aA5mp/8iN8rUwS
   Y2UGorboLWxHjuu6L+9c1C0UxB9TKQYRADpyNZDCtuF9A3u7uKyCiYNVt
   pqHpu1/N6LcwE86K5ND+dM3I5jzSp2KhBCIxxi5Al8kekco3l64pnTuFr
   YTtgBuCACQ5eciR6HsQGWuBvIGcVaNwieq/iInfoq79TOi53amz7i8rvi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244849707"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244849707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="593534460"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 00:34:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 00:34:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 00:34:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 00:34:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 00:34:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3JVYdN36PHOOUMlZO5AWshSAXERjlZcBYIR5/2rlAFS7K8x110SO9ooHBKiM31MVj3rDg9JcZbHTwbgUThju0pLDOS0bf0cTqf/rCdaklFTvzbBKhecf5MPhESPGUNtoOi4kuKfrLylrvVw5DHGJlCrMQUZia918p4etPWZGLw58fQrokv+ha3PPDTSxnzNMdgOuowG8kbRA+MGxO5kMet0NDJKjHBG9E+SvNgDkTs92eZONxaVU1W/iY3glMmUfLTBq+obNsVZ2tS9aoMxqiPm1twjRWkudDMmzUm/d8Z8RMqgh6Z4qvhlzSeU9fYRayCn5495x8InTsIqBiJt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQIbyeWm1mR8NzH3UauShFuD4gQs7HGs4yzqihGTboM=;
 b=gCkKgeIQPf2Fc+/uwU+yfOuJQ2DpirNV+fAYjK1RYY4KjTFSCEbMnQTKHrRAycDeXXlh5a5uf2GYwfukl3taVFCFhzyk89oYCcjNh0ninIrklUlBCTCPHozPYXKprpkDsWkgkWRvxXrem9j9IlPw00fkJRxmqtygtQrnqko6qshxfoiRBtyH4g/op4We3SIcgY9mnaedgmRZgI6re5s9CLopG19dzArJz5a068Sok1SIzTWtP690eJK6Kg9zI7hybvOX7AVpcEa6y40DXwlLXFVUb/MNw42+qNAqGe1a1QZ8czubz7hVJGcX/uyB8wOO/vrmqMNm+ZGIVik9dsDWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN6PR11MB3536.namprd11.prod.outlook.com (2603:10b6:805:d4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 07:34:46 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977%6]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 07:34:46 +0000
Date:   Thu, 21 Apr 2022 15:34:38 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Huang Ying <ying.huang@intel.com>, Michal Hocko <mhocko@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <YmEJDqXB6ijYQmww@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <CAHbLzkobQ4pn57LPe8neo-TUeVHcueSpEC1hm_9DZ0yaKgc41w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkobQ4pn57LPe8neo-TUeVHcueSpEC1hm_9DZ0yaKgc41w@mail.gmail.com>
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f06382af-63a4-4148-bdc1-08da236968a8
X-MS-TrafficTypeDiagnostic: SN6PR11MB3536:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB35361F551D7CEB2DC7070A158BF49@SN6PR11MB3536.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uD6Lyosh9ZquINLEr1eY51Ebu0ZzD3AaL9MMaLwdiaKP/daXXo4U8qraQs86+M3rJyI7B0ZSHuqXOnVODZ321Gn1a8yqSaX/bGRArfiyLRZwNdo9KBk72oW0qfQDTx/1K7SFf2/1lPvP7wZaYXbiaU4QpIoxcTxRaTO6g7cf/HdzCAj6nM48sLczLJ31Zo+0MyajioJK/P8R/469SkPDmexRYt0Gw7vOaX2YnD7Gdma3MLIKhmDfNWuSkhTsIANQ2GsY92PNw/5/IDgdGcF6OuM5yKzsf1x2vd/artFiOeyWMaVqSkXn1mnHm37NZ/eyW2/VjLKqcidGD4VRMendgx9YknWHIQIuI8nI3aQHJQmhBWoL+fb1/bFDWNvMCP7siV9JV0UDqoi4FZlqB6Ezqu7JCFYUzlQhPx68fh4JBUOfS7BW5TF1/6M8HOoxPtxb+tMPkLZBJE7cqOiTjgQw5R8upj7LW8vTWOraQHI0HUvVEZuVpKrAK8C+dMyl5MA7GqbHDdSUq70fZ0Cy+zftOWo9UAqeRD+FTqee8nBFe2NdMKghLuPe2frPfGTqc3eMcRN2aUbN5gPWIIoqglFGBwpf/IwmP9MvAWhNMpif7jHqx3PAxyZfKqCTjBXyTfzOXxLsxNR9K99/X5spf+sl8nNSJAFCbUftZ80kQZjaEHLDC+7h07lEmY4YVcEpd957ZB7auoHw/CmDVixURugLrhP7pTjnOK47ZiLPv3P3t/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(53546011)(6506007)(33716001)(86362001)(6666004)(8936002)(508600001)(82960400001)(66476007)(6486002)(966005)(66556008)(66946007)(4326008)(8676002)(83380400001)(54906003)(6916009)(316002)(38100700002)(186003)(2906002)(26005)(6512007)(9686003)(44832011)(30864003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DwJeqHjA6MH+maYTsqk8qU6cq7Dx6gzvqEFu4mCRkVbOOOC6CQ5gRozS2mpR?=
 =?us-ascii?Q?AJYnLXcfROiHUOomIXQnTh0TCRAW4d2Av7DJVutDgz4TW8O1Kem9VOMw3ZZK?=
 =?us-ascii?Q?aXCIfX8SJs35mnYe/jTGEKGokyQxf3rprQfaUyJ02VWS9Jt+eyQGkmGePcL1?=
 =?us-ascii?Q?bhXdRiU5kEbJwCx7ef2XdIx+9fTj9BZ9uiZaXMXRWhto221Bw4sz9rl3vCgO?=
 =?us-ascii?Q?mfHsRXrtqlq6Ep3SM8B9lLcje5R7ayorOWuE9QXIF/gEx36UOFgAeTH+U3JO?=
 =?us-ascii?Q?9RgoH53Hk+b0f2/ECwohR+hqNlISrDJE+H7fho2sQAZ55ukuZ66jWGMb6qQs?=
 =?us-ascii?Q?l53XehHdjTbunj5WZoQjIjI5aeZEsXsESViyhSaQy7OCIn8dz3JFlxQxUxwZ?=
 =?us-ascii?Q?BE1TNnpIU5cCgK2uF/hqo3a2WOHdffWMWznql3VIVEPAGn49KTLsNKtLHrcT?=
 =?us-ascii?Q?D2iEs7or7IJGktiiAFUQ7iXa8Zo+ghdJZFd+MfJozogrZN83yaMdfkEv0DLf?=
 =?us-ascii?Q?3Vg9BrQ17usaJQ6ZCtoHXW3dZ+ty72/5TPd84agqP74AM0YgcZ3EzzH6aGIO?=
 =?us-ascii?Q?rm/Q+b6tE+a9PqHBsxeh+sRRNZrJLKwCT6M/cqAOS92TcYtXc1vqZ76acfCR?=
 =?us-ascii?Q?c3i1Yew/HnZbT60Gs06QZpIXv9ZCCgS7a0IcadLDx9Vsr7/cZReCaVoXO9lp?=
 =?us-ascii?Q?9ENza+5YGoQ763s7uPaIfg3FZi5yGS8rZE+m3ZJd54bHuynjMTX5Hb5BjIXv?=
 =?us-ascii?Q?ndpUAXVne27ljnjXVN+8hHO9aP3VToFxfqfyjXCeEJrl3g7DT/bNjHhiCktq?=
 =?us-ascii?Q?uxGcaX0VvVoZJjyg2iSt9BGoMbNx9DmhjOb1rhV0sXAgnjKzWclat/o+dgKe?=
 =?us-ascii?Q?RIaV5rcjYApussHXybp9xzW8H94gamN82FewjofwROyhW+d8amuemC2yFpm8?=
 =?us-ascii?Q?LY1GiN7eeMXt7np2Vf1hLy2toh5CiU+QO37uhwX9VXhCdMemsAx/mRVlFrid?=
 =?us-ascii?Q?N1H90T4WMmkBWCNvztdcpTjHbut/c6gTKHNjY0IJx7v54T7MUNydSj9G8pgr?=
 =?us-ascii?Q?CRL1soT1DaLEPoQZFHqM7M/p6Xzm0+PaYm1YmVwYVl7HsW5JByuHFQE40vBy?=
 =?us-ascii?Q?6ZJq/0Vq+l/EtIUZ7Eh0IXG8YIB5TG3w/5tHSaDX6HLynFfNhBXpNFEjy8kT?=
 =?us-ascii?Q?u7htLO6FERXWoNGKCJNwrRKqtZt1wV6JdQ5C5UyzuMA2/EZO9t77PCDRV60f?=
 =?us-ascii?Q?KkhUNBXnarweHwo1OTHcTi2x5/bjTpw1HebrKmeu/gfUq1vpIi8hWEfvWi3Z?=
 =?us-ascii?Q?iRHBO8hJynRoH2iV3Kq+DvmtYX/UlT+pmSqdc+pWkwRaDaCNyEI665ppuu4e?=
 =?us-ascii?Q?ZtIHWehzZ/5xgdMpKPauMcZvsTlbNDxIZk/XEYBk1Saj72//3Z+UlwOig9+g?=
 =?us-ascii?Q?QWy0vLZAxn4NLyCVT6eZciM0BhlrjwpFQLrqXS2YvREHlbUPS2Oak+jsjI3E?=
 =?us-ascii?Q?yF31TXqLRBM9VaOHQA9h1sfiZ8kvbhl1dctPRhJeJKJF1Hs2L6508yGbAiWA?=
 =?us-ascii?Q?JWLJvYjiOGIzUxNdQxichWUt5VIE5yU+4M+OWPNlb8HRw/VLvFlSCI/HuymD?=
 =?us-ascii?Q?kra5JLVeDEW2OK4tIleZCx63K8dvpOBrkLhQUoBnMWKXZdJQr5bdeRH/VjiN?=
 =?us-ascii?Q?iRI54CY/pqz0JZTO7q6ppptVA5RwoFN+fLtYcOdn97SuTt8xd5hzKnoQv+tD?=
 =?us-ascii?Q?6c/fUbjRjg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f06382af-63a4-4148-bdc1-08da236968a8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 07:34:46.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX7ErdNAXhcE7D4A/QhpEbMdTBg7kIREV+arn09LQsm/mf8t2IqXrhZJXHV0yEke5YV18IKe1Y9wP/qeuyM13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3536
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:21:25PM -0700, Yang Shi wrote:
> On Wed, Apr 20, 2022 at 1:33 AM Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > >
> > > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > > The swap devices are linked to per node priority lists, the swap device
> > > > > closer to the node has higher priority on that node's priority list.
> > > > > This is supposed to improve I/O latency, particularly for some fast
> > > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > > actually returns the nid that the reclaimer is running on instead of the
> > > > > nid that the page belongs to.
> > > > >
> > > >
> > > > Right.
> > > >
> > > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > > the page's node, but it may be overkilling. So keep using the current
> > > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > > so it is not sure how much improvement could be achieved due to lack of
> > > > > suitable testing device.  But anyway the current code does violate the
> > > > > design.
> > > > >
> > > >
> > > > I intentionally used the reclaimer's nid because I think when swapping
> > > > out to a device, it is faster when the device is on the same node as
> > > > the cpu.
> > >
> > > OK, the offline discussion with Huang Ying showed the design was to
> > > have page's nid in order to achieve better I/O performance (more
> > > noticeable on faster devices) since the reclaimer may be running on a
> > > different node from the reclaimed page.
> > >
> > > >
> > > > Anyway, I think I can make a test case where the workload allocates all
> > > > its memory on the remote node and its workingset memory is larger then
> > > > the available memory so swap is triggered, then we can see which way
> > > > achieves better performance. Sounds reasonable to you?
> > >
> > > Yeah, definitely, thank you so much. I don't have a fast enough device
> > > by hand to show the difference right now. If you could get some data
> > > it would be perfect.
> > >
> >
> > Failed to find a test box that has two NVMe disks attached to different
> > nodes and since Shanghai is locked down right now, we couldn't install
> > another NVMe on the box so I figured it might be OK to test on a box that
> > has a single NVMe attached to node 0 like this:
> >
> > 1) restrict the test processes to run on node 0 and allocate on node 1;
> > 2) restrict the test processes to run on node 1 and allocate on node 0.
> >
> > In case 1), the reclaimer's node id is the same as the swap device's so
> > it's the same as current behaviour and in case 2), the page's node id is
> > the same as the swap device's so it's what your patch proposed.
> >
> > The test I used is vm-scalability/case-swap-w-rand:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> > which spawns $nr_task processes and each will mmap $size and then
> > randomly write to that area. I set nr_task=32 and $size=4G, so a total
> > of 128G memory will be needed and I used memory.limit_in_bytes to
> > restrict the available memory to 64G, to make sure swap is triggered.
> >
> > The reason why cgroup is used is to avoid waking up the per-node kswapd
> > which can trigger swapping with reclaimer/page/swap device all having the
> > same node id.
> >
> > And I don't see a measuable difference from the result:
> > case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> > case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
> >
> > My interpretation of the result is, when reclaiming a remote page, it
> > doesn't matter much which swap device to use if the swap device is a IO
> > device.
> >
> > Later Ying reminded me we have test box that has optane installed on
> > different nodes so I also tested there: Icelake 2 sockets server with 2
> > optane installed on each node. I did the test there like this:
> > 1) restrict the test processes to run on node 0 and allocate on node 1
> >    and only swapon pmem0, which is the optane backed swap device on node 0;
> > 2) restrict the test processes to run on node 0 and allocate on node 1
> >    and only swapon pmem1, which is the optane backed swap device on node 1.
> >
> > So case 1) is current behaviour and case 2) is what your patch proposed.
> >
> > With the same test and the same nr_task/size, the result is:
> > case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> > case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
> >
> > The result suggested when using a memory like device as swap device,
> > it's better to use the reclaimer's node id when swapping.
> >
> > What do you think of these tests and results?
> 
> Thanks, Aaron. Since you are using PMEM so I'm supposed case #2
> actually has 1 more cross node memory copy than case #1. Swapping
> doesn't incur the block I/O (DMA) but memory copy in this
> configuration.
> 

Right.

> IIUC, case #1 would do node1 -> node0 -> pmem0, but case #2 would do
> node1 -> node0 -> pmem1.
> 

I think so.

> Actually I was thinking about Optane SSD instead of PMEM when
> discussing this with Ying offline. Not sure if Optane SSD would have
> any measurable difference or not. But anyway if PMEM is used as swap
> device the current implementation does make more sense.
> 

LKP lab doesn't have any machine with Optane SSD, will let you know if
I managed to find one elsewhere and get some results.

In the meantime, I think testing on Optane SSD might make more sense
since there is the memory tiering support for Optane DIMM and swap may
not be used there but for the SSD, it has a higher chance of being used
as swap.

Thanks,
Aaron

> > > BTW, this patch doesn't change the node for swap slots cache, so it
> > > may still use the swap device on a remote node if swap slots cache is
> > > used.
> > >
> > > >
> > > > > Cc: Huang Ying <ying.huang@intel.com>
> > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > ---
> > > > >  include/linux/swap.h | 3 ++-
> > > > >  mm/swap_slots.c      | 7 ++++---
> > > > >  mm/swapfile.c        | 5 ++---
> > > > >  3 files changed, 8 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > index 27093b477c5f..e442cf6b61ea 100644
> > > > > --- a/include/linux/swap.h
> > > > > +++ b/include/linux/swap.h
> > > > > @@ -497,7 +497,8 @@ extern void si_swapinfo(struct sysinfo *);
> > > > >  extern swp_entry_t get_swap_page(struct page *page);
> > > > >  extern void put_swap_page(struct page *page, swp_entry_t entry);
> > > > >  extern swp_entry_t get_swap_page_of_type(int);
> > > > > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
> > > > > +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size,
> > > > > +                       int node);
> > > > >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> > > > >  extern void swap_shmem_alloc(swp_entry_t);
> > > > >  extern int swap_duplicate(swp_entry_t);
> > > > > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > > > > index 2b5531840583..a1c5cf6a4302 100644
> > > > > --- a/mm/swap_slots.c
> > > > > +++ b/mm/swap_slots.c
> > > > > @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
> > > > >       cache->cur = 0;
> > > > >       if (swap_slot_cache_active)
> > > > >               cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> > > > > -                                        cache->slots, 1);
> > > > > +                                        cache->slots, 1, numa_node_id());
> > > > >
> > > > >       return cache->nr;
> > > > >  }
> > > > > @@ -305,12 +305,13 @@ swp_entry_t get_swap_page(struct page *page)
> > > > >  {
> > > > >       swp_entry_t entry;
> > > > >       struct swap_slots_cache *cache;
> > > > > +     int nid = page_to_nid(page);
> > > > >
> > > > >       entry.val = 0;
> > > > >
> > > > >       if (PageTransHuge(page)) {
> > > > >               if (IS_ENABLED(CONFIG_THP_SWAP))
> > > > > -                     get_swap_pages(1, &entry, HPAGE_PMD_NR);
> > > > > +                     get_swap_pages(1, &entry, HPAGE_PMD_NR, nid);
> > > > >               goto out;
> > > > >       }
> > > > >
> > > > > @@ -342,7 +343,7 @@ swp_entry_t get_swap_page(struct page *page)
> > > > >                       goto out;
> > > > >       }
> > > > >
> > > > > -     get_swap_pages(1, &entry, 1);
> > > > > +     get_swap_pages(1, &entry, 1, nid);
> > > > >  out:
> > > > >       if (mem_cgroup_try_charge_swap(page, entry)) {
> > > > >               put_swap_page(page, entry);
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > index 63c61f8b2611..151fffe0fd60 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -1036,13 +1036,13 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
> > > > >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> > > > >  }
> > > > >
> > > > > -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> > > > > +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size,
> > > > > +                int node)
> > > > >  {
> > > > >       unsigned long size = swap_entry_size(entry_size);
> > > > >       struct swap_info_struct *si, *next;
> > > > >       long avail_pgs;
> > > > >       int n_ret = 0;
> > > > > -     int node;
> > > > >
> > > > >       /* Only single cluster request supported */
> > > > >       WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
> > > > > @@ -1060,7 +1060,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> > > > >       atomic_long_sub(n_goal * size, &nr_swap_pages);
> > > > >
> > > > >  start_over:
> > > > > -     node = numa_node_id();
> > > > >       plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> > > > >               /* requeue si to after same-priority siblings */
> > > > >               plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
> > > > > --
> > > > > 2.26.3
> > > > >
> > > > >
> > >
