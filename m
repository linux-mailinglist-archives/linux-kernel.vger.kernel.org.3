Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50934BB0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiBREUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:20:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiBREUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:20:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821DF1AE902
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645158018; x=1676694018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qky01f7kF5VxSUg6RW2sunQeQq6g7tFOiRVP1i/0OyY=;
  b=P0oKeK6L0ZtAWv+cNNkZnmBWvow5LqXrNnVe0HyOf21EIGcJJPmAQZ4v
   h4JKuZ6d/Feth4+jWiLC62TIsvrkT4rXi+rgKLJX30JqHlogv+Ne45tpv
   jbbWrnV+q4cEXneD3YEFiUFeO34qhREUFkkJ3HzD1iyR268YdG+Ql9Pu9
   LVsBUBWrf/JlvMZUsy4PfWpntUzim0hux6MYLr72lJ3REpV+56GbHX1i7
   BAHC+5b+sUa6qtLFeGT5dDlF3BDAi55MOy3oULqTFIKHsF8bXpz/yUfea
   KXffdHGbYbsX/AA6KYJlk+IH6kGJFjX0tXkricOfWxQJHE2436/8SC62y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238452170"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="238452170"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="504558462"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2022 20:20:16 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 20:20:15 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 20:20:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 20:20:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 20:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frhXx/CDOEfWlIzmEC1Y2Rt4QH8xF4fmTRrW5FiXLnvRtnj3DxRHw0FyKWvScyCvP+9OoEbngd1FMV65ousW+Gp54aoK0unSjupfkZvrHxqOi1b2Ztfig+vECiqO08//NEwTiccE6PHEFpWGf5Pqx/rMs/zLVIKqJXxUdylzJgGVOGZapTKzbvIGvC43IFmPsYq4da1ObJg55Rewa9D+rILsPzqQ5UKubnE7CvNmG+TvOEASbNHN6HZMtXRP/RMzxKvF7AP8sfajQUoflazIe+mkDcNrBpeipHd+rQBjHRnAioI8Qb8olMVtE/Eaunh1TXQvBPQa6HcrZnL5/B+xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw1mJwrM0pCRCkMiuiMsf7S9KCRlozdb3xlFJFfBet4=;
 b=k5fJEgkjdsoX2KJLsUk/hRb/x+/Ux7N7i78OWmgKLm6B3irUqnchGOsrl03gif3IyPtuohKyVqR3hMF/VshLLNQEjsMMG0h38vKdn8k/u6Exfu+pejEnf2KPt4Z3nS6pOAOG9RCqJXsyRJP8Z+9TTeLaa5tHnjR5SYuxAeHWsBCAHDM/4JrnvLtehIIaoeLPH/498ohz5vof3g/yteq12JmjRcKAhDndzeP9k2z5CdKCsABi4ILcnGmAgmmSkWmbLxN4OWnC35HDTm+B0Xyv3jM0Aq+o945iQwr3HLE6Sa/EC21m4vXlaJ+Y0xAlXfTxp6pmP7ZRzdMj5LctL40Hzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by BL3PR11MB5697.namprd11.prod.outlook.com (2603:10b6:208:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 04:20:12 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::2477:ce52:e1c4:387]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::2477:ce52:e1c4:387%5]) with mapi id 15.20.4995.015; Fri, 18 Feb 2022
 04:20:12 +0000
Date:   Fri, 18 Feb 2022 12:20:03 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Message-ID: <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
 <20220217093113.GU3366@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217093113.GU3366@techsingularity.net>
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d2b4f98-5b90-40dc-a6c3-08d9f295f429
X-MS-TrafficTypeDiagnostic: BL3PR11MB5697:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL3PR11MB56978DC94191C66E8B4B088F8B379@BL3PR11MB5697.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0xnH9cdx1tbLCDJPMwU2qbiLkr9G4bW4MDBDj36cQwl0EqrGnds+axDjU7X0uybclxe/bexL6yo7y9vdp+N4YITLR1kYFUyCbcNmoolSJN2oI1hLsss3kEaIKnlWCvYLUKQXT8/a0iNhzeavx55vc69GBel//qmTX8yapes+/50wO/NQnqXIPyOOH+6TT8Y0nZVEb5jmGfmMhl8IwfejvCyZI7XZYorGg7ihJC3z07lWf3Hq9H/BIs0jbNVzLNQfD46Iurk4Io3xPUEq4WWEJphiIwI/rMczoO+HXSihn/XjFEttMJc3Dv6V48uPrRlx91vxLJew1w5nRz7cIX+cQeX8ibCCl1sqhnijmMktQp84vALE0KsIcU8EsfaMqgCQsPxoeKzMmJk8XeW/Sjh7KbHcojaFVjv75bv+HDMPxplJnkmCheyQMBgXGkVzTBxxtydcdD3rWrWakvquMZlQjXKrTHshD4Rh2nBZ4+73KWZALjK6uvbDxWwF/WOiowr7TeEh4ZLODSXTKYrsG05uFV7pt+IzWNK0bPhqLONVGdJtxTZTEMjYSt3FKq9NucUM5gKR+1n9lZfPCIG4+nukem/88FR9nY/8UpaSyuwbn9SBvzxuGqdAWRSkHi65Zf+2+E32vZAKdqTK2nvwj8mam2kbVpARZ+u4Aul0yN6Lu0RArU666ZZfM0LejnI4RMVOL4hu613Kt1O8+IcMlad+wiWGnuIaMk+Yex1ysMPWXlzfAvpdSD2ffontXiOLSHvkGaP9P76oETy2pclWSIJMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(44832011)(8936002)(38100700002)(5660300002)(82960400001)(86362001)(316002)(66556008)(66476007)(66946007)(4326008)(6666004)(54906003)(9686003)(6916009)(83380400001)(6486002)(966005)(186003)(8676002)(26005)(6506007)(508600001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OKSVn2jzzgQPnwqw/VW5Surq062mfLGnDHaBHmKqJKBk/WQBkphcEr6NAZan?=
 =?us-ascii?Q?vrek7COB90tL/qlSTzELX/ZPjNe6elTeKUKSzMLoU5ID+6yHQL42il2kCwjg?=
 =?us-ascii?Q?XbF5WrQfq7SAXD527h+/GT3XPZ1jhcpeekbiFfnzDmwWmjMAPeHn9LQ0VDYb?=
 =?us-ascii?Q?4Iok9GxAHDgqLW1VvCqULl6fg8NNOvJjmrxy4WiH8zJUngK4J9/OulaAVm8+?=
 =?us-ascii?Q?ez6wi4NTdjCTjeedw7njP0Ul1TmHghcu8sbiouTAU/GZveyOvfus2yv3GrZ0?=
 =?us-ascii?Q?M1buzcXbDbuMmjzQ1GP9siSqvTwY5SPkED11nvYGZwq1lRNCn4p1etaNTvCP?=
 =?us-ascii?Q?CQCP/SdNTzGyuPiSLSDvrmcQSA4VKwUaiveIIyBJ3ebe6cwRm/CoqCuojJqU?=
 =?us-ascii?Q?qGUHE08Vwms7tpGkIQmsX+WVvIyIx/H+ba1QW4Kr16AFzdGishjAQJ/+paeP?=
 =?us-ascii?Q?3VgiK3atvhpUanjGux7Np1/WXgHmq43pTqYXe2hlN2uZIStiwq6hdb6YonPA?=
 =?us-ascii?Q?XuvtoNAQp84sd88ILTqPglQRJOSj+lOPGy3hx1Ck5Fnwc/d/hmpBcTLaC5Nk?=
 =?us-ascii?Q?bDJqPy5dnqzgy+mG1mcnz3xGNgQxhkkXqRNAtnVwtCeNlKxsUEAoyh1YD53b?=
 =?us-ascii?Q?ASry/g2RqsIN5iC60OsZZx5HIqrwXiVmnyHMpDl83VPkubStUN/bBwmUQG8S?=
 =?us-ascii?Q?mZLjwlzMce/IgOneYY497xsua+7IlWX+8fq7RloIulpj1j7UWbkZsfCd6/9Q?=
 =?us-ascii?Q?ldh8KidboYRUm0tAoJkPYCp9m8su03pnUk183MJfw7rV6cvd0ET/sAdV4JiH?=
 =?us-ascii?Q?+huvz52pFDrqkzfw2rp//T4MpMxsIUtt7SnGzsGUskJgGy70BC5hZMWxnQU5?=
 =?us-ascii?Q?WC/ajpGfQZdZsXAUnqUrR5+B5LcM0yIzdnDHrDBlbT9P3YhwTlhb/gQdARAZ?=
 =?us-ascii?Q?Mla0o/jT+Opzxap7rCEUHLFXO8h1XngG+9C8YXdOErcJ3aO6Jw43TIh9s+16?=
 =?us-ascii?Q?CmZ7Zhbbd7wzQF/2LXnxxCHET/R547dL9Y7Ara0PZPICWo+hzezOAyNvwrD3?=
 =?us-ascii?Q?vwBlrSWcAmov/oSoyzq056jmZxVlgFB694VmwwiKgVWY/kHDLi2vag+/eHL8?=
 =?us-ascii?Q?hGEqfCuc/HxpzO7iAwESeyeOfinnvrEWNMOCtXUmteQAnQ0yAipPpl0gnXZ2?=
 =?us-ascii?Q?yh4jblvLLX3CgPgnwtRdNzahHhLulXu+OgDt7Ah+jcwd/5O1zX/gzQSiLUA7?=
 =?us-ascii?Q?sd3bUyyke8vhx4hcDKBO96HJTzmY8/fsxIyMy+4s6xPhFuEhxAliznb4YrB4?=
 =?us-ascii?Q?BQm+U4MU5nFyDX+S2o05mksikm5g5W7/0Q0Q+b2dSLYnDr5CJaZZYY3NyZpd?=
 =?us-ascii?Q?FZ24J2Y75MKpcHmyx7rRZpyhVVkK2JltSHiOx6y2lfP/2K86sSeK+nOqSSvA?=
 =?us-ascii?Q?TWARuDggaJCS380XYPLsY6lzVH66BfIkJ/4vXVnKut0HL0hHvHYaStut67L2?=
 =?us-ascii?Q?beCaZySJQjutGPHyKbXAxxZXrTdSo7r1kQ67FE84cENOFUyn6i1WugpAHpbs?=
 =?us-ascii?Q?/+vxSPRNwTRxEcIhItyeQdZxKBXF2JH4xJ9z0kxvrra+n8Ns3vNie/X8G59E?=
 =?us-ascii?Q?YWwWTzFvsNBXTZJy6KdM1XY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2b4f98-5b90-40dc-a6c3-08d9f295f429
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 04:20:12.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfY+Eyl2TnXnKEo/uhaw9sgu2ogd/fr/PVbZjTcAuDsEP2rxf2H2wT+wcCqjwwgoNHv07drWf6rubO8TZRulzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:31:13AM +0000, Mel Gorman wrote:
> On Thu, Feb 17, 2022 at 09:53:08AM +0800, Aaron Lu wrote:
> > > 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
> > >                                                     5.17.0-rc3                 5.17.0-rc3
> > >                                                        vanilla           mm-highpcpopt-v2
> > > Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> > > Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> > > Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> > > Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> > > Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> > > Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> > > Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> > > Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> > > Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> > > Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> > > Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> > > Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> > > Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> > > Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> > > Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> > > Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> > > 
> > > The differences are mostly within the noise and the difference close to
> > > $nr_cpus is negligible.
> > 
> > I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
> > servers: CascadeLake and CooperLaker and will let you know the result
> > once it's out.
> > 
> 
> Thanks, 4 sockets and a later generation would be nice to cover.
> 
> > I'm using 'https://github.com/hnaz/linux-mm master' and doing the
> > comparison with commit c000d687ce22("mm/page_alloc: simplify how many
> > pages are selected per pcp list during bulk free") and commit 8391e0a7e172
> > ("mm/page_alloc: free pages in a single pass during bulk free") there.
> > 
> 
> The baseline looks fine. It's different to what I used but the page_alloc
> shouldn't have much impact.
> 
> When looking at will-it-scale, please pay attention to lower CPU counts
> as well and take account changes in standard deviation. Looking at the

I'll also test nr_task=4/16/64 on the 4sockets CooperLake(nr_cpu=144) then.

> old commit (which I acked so I've no excuse), I think it's important to
> look at cases other than the fully utilised case because it's the best
> case for something like will-it-scale pf but it's also an unlikely case
> (all CPUs all faulting continuously).

I see.

> 
> I expect there will be different good/bad points based on looking at
> Zen1 results (8 nodes, varying distances, 64 cores with 128 CPUs HT
> enabled)
> 
>                                                     5.17.0-rc3                 5.17.0-rc3                 5.17.0-rc3
>                                                        vanilla        mm-reverthighpcp-v1           mm-highpcpopt-v2
> Hmean     page_fault1-threads-2          2985366.46 (   0.00%)      2984649.41 (  -0.02%)      3028407.35 (   1.44%)
> Hmean     page_fault1-threads-5          3491833.63 (   0.00%)      3500237.35 (   0.24%)      3489971.99 (  -0.05%)
> Hmean     page_fault1-threads-8          3254335.58 (   0.00%)      3277515.51 *   0.71%*      3234275.28 *  -0.62%*
> Hmean     page_fault1-threads-12         5101504.72 (   0.00%)      5390649.46 *   5.67%*      5162047.68 (   1.19%)
> Hmean     page_fault1-threads-21         7714265.64 (   0.00%)      7714763.10 (   0.01%)      7854367.65 *   1.82%*
> Hmean     page_fault1-threads-30        10034561.94 (   0.00%)      9865446.68 (  -1.69%)      9746368.76 *  -2.87%*
> Hmean     page_fault1-threads-48        12571351.99 (   0.00%)     13257508.23 *   5.46%*     12160897.07 *  -3.27%*
> Hmean     page_fault1-threads-79        11124387.46 (   0.00%)     10641145.82 *  -4.34%*     10677656.39 *  -4.02%*
> Hmean     page_fault1-threads-110       11980424.12 (   0.00%)     10778220.84 * -10.03%*     10354249.62 * -13.57%* <-- close to nr_cpus
> Hmean     page_fault1-threads-141        9727528.73 (   0.00%)      9966965.70 (   2.46%)      9656148.13 (  -0.73%) <-- close to nr_cpus

I have never tested thread mode, because I think the heavy loaded
thread mode is more about testing the mmap_sem contention than page
allocator's performance? It's surprising this patch caused a
performance change.

> Hmean     page_fault1-threads-172       11807964.92 (   0.00%)     10335576.64 * -12.47%*     10443310.45 * -11.56%*
> Hmean     page_fault1-threads-203        9471961.29 (   0.00%)      9749857.24 *   2.93%*     11890019.87 *  25.53%*
> Hmean     page_fault1-threads-234       11322381.78 (   0.00%)      9163162.66 ( -19.07%)      9141561.16 ( -19.26%)
> Hmean     page_fault1-threads-265        7956982.52 (   0.00%)      7774650.20 (  -2.29%)      8292405.57 *   4.22%*
> Hmean     page_fault1-threads-296        7892153.88 (   0.00%)      8272671.84 *   4.82%*      7907026.20 (   0.19%)
> Hmean     page_fault1-threads-327        7957124.50 (   0.00%)      8078297.34 (   1.52%)      8129776.79 (   2.17%)
> Hmean     page_fault1-threads-358        7847563.90 (   0.00%)      8202303.36 (   4.52%)      8139027.38 (   3.71%)
> Hmean     page_fault1-threads-389        7928386.47 (   0.00%)      8104732.41 (   2.22%)      8022002.73 (   1.18%)
> Hmean     page_fault1-threads-420        7690107.89 (   0.00%)      7587821.54 (  -1.33%)      7783777.95 (   1.22%)
> Hmean     page_fault1-threads-451        7683132.29 (   0.00%)      7979578.21 (   3.86%)      7693067.13 (   0.13%)
> Hmean     page_fault1-threads-482        7720646.31 (   0.00%)      7597453.65 (  -1.60%)      7870063.90 (   1.94%)
> Hmean     page_fault1-threads-512        7353458.45 (   0.00%)      7584407.14 (   3.14%)      8119539.24 (  10.42%)
> Stddev    page_fault1-processes-2           4086.39 (   0.00%)         1698.11 (  58.44%)         1488.13 (  63.58%)
> Stddev    page_fault1-processes-5           1448.69 (   0.00%)         1616.59 ( -11.59%)         1567.37 (  -8.19%)
> Stddev    page_fault1-processes-8           1828.29 (   0.00%)         2628.59 ( -43.77%)         2701.96 ( -47.79%)
> Stddev    page_fault1-processes-12         14073.12 (   0.00%)         1575.18 (  88.81%)         4880.93 (  65.32%)
> Stddev    page_fault1-processes-21          4368.35 (   0.00%)         7865.27 ( -80.05%)         3778.03 (  13.51%)
> Stddev    page_fault1-processes-30          5348.13 (   0.00%)        11751.43 (-119.73%)         3240.22 (  39.41%)
> Stddev    page_fault1-processes-48         23687.16 (   0.00%)         7803.01 (  67.06%)         2635.85 (  88.87%)
> Stddev    page_fault1-processes-79         12779.16 (   0.00%)         4311.60 (  66.26%)        22539.03 ( -76.37%)
> Stddev    page_fault1-processes-110        21031.04 (   0.00%)        15115.36 (  28.13%)        12136.54 (  42.29%)
> Stddev    page_fault1-processes-141       589804.99 (   0.00%)      1335519.71 (-126.43%)        19560.01 (  96.68%)
> Stddev    page_fault1-processes-172         7033.94 (   0.00%)         7147.71 (  -1.62%)        11366.64 ( -61.60%)
> Stddev    page_fault1-processes-203         6322.20 (   0.00%)         5035.55 (  20.35%)         4043.45 (  36.04%)
> Stddev    page_fault1-processes-234        12046.53 (   0.00%)        24208.37 (-100.96%)         9159.91 (  23.96%)
> Stddev    page_fault1-processes-265        11869.43 (   0.00%)        13528.26 ( -13.98%)         8943.99 (  24.65%)
> Stddev    page_fault1-processes-296         8918.50 (   0.00%)        16130.54 ( -80.87%)         5211.80 (  41.56%)
> Stddev    page_fault1-processes-327       101102.64 (   0.00%)       845864.70 (-736.64%)        16238.99 (  83.94%)
> Stddev    page_fault1-processes-358      2102190.38 (   0.00%)        11316.00 (  99.46%)         7508.57 (  99.64%)
> Stddev    page_fault1-processes-389        61012.79 (   0.00%)       121446.55 ( -99.05%)        18279.64 (  70.04%)
> Stddev    page_fault1-processes-420      2305208.40 (   0.00%)      2347564.71 (  -1.84%)         3202.77 (  99.86%)
> Stddev    page_fault1-processes-451        20214.37 (   0.00%)       173800.17 (-759.79%)       492258.35 (-2335.19%)
> Stddev    page_fault1-processes-482       236881.21 (   0.00%)       330501.32 ( -39.52%)        15307.31 (  93.54%)
> Stddev    page_fault1-processes-512       201354.82 (   0.00%)       207019.93 (  -2.81%)      4900536.90 (-2333.78%)
> 
> This is showing there was a impact around the nr_cpus (110 and 141
> processes measured) but the standard deviation around 141 was particularly
  ~~~~~~~~~

  Did you mean threads?

> high in the baseline case taking two passes through lists. It's also
> interesting to note that in most cases that standard deviation is reduced
> by the series even though it's not universally true.
> 
> As a side-note, there is also a fair amount of NUMA balancing that takes
> place during this test which further muddies the waters. This is a slightly
> surprising result and I suspect what's happening is that processes are
> getting migrated cross-node as the number of processes exceed a local
> nodes capacity due to load balancing. It might be highlighting a weakness
> in the test itself where it ends up measuring more than one thing (not
> just fault capacity but load balancing effects as individual nodes CPU
> capacity approaches fully busy).

Makes sense.

> 
> My main concern when writing this patch was the basic case of one CPU doing
> a lot of frees (exiting, large truncate, large unmap, anything hammering
> on release_pages for a large region etc) suffered from taking two loops
> through lists with all the associated cost of the list manipulations. I
> worried that by trying to optimise for a corner case (all CPUs allocating
> simultaneously), we missed a basic case (one CPU doing a large amount
> of allocating/freeing).

I see.

> 
> If possible, it would be nice if you could add something like
> configs/config-io-trunc from mmtests to lkp if it doesn't exist already
> to consider the simple case. As its most basic, all it's doing is
> 
> ---8<---
> #!/bin/bash
> 
> for i in {1..10}; do
>         dd if=/dev/zero of=sparse_file-$i bs=1 count=0 seek=1G &>/dev/null
>         cat sparse_file-$i > /dev/null
> done
> sync
> 
> # Primary metric
> time rm sparse_file*
> ---8<---
> 
> The main difference is that the mmtests will report the time to fault the
> sparse files (bulk simple allocate inserting into page cache) as well as
> the bulk truncate (bulk simple release of page cache).

Thanks for the suggestion.

vm-scalability has a similar test called case-truncate which LKP already uses:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-truncate
except in case-truncate, the rm is done concurrently and only the
truncate time is reported. I'll modify the case to make it do the rm in
sequential mode and also report the fault time.

Regards,
Aaron
