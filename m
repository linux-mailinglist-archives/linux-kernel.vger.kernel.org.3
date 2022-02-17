Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4774B9B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiBQItv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:49:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiBQItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:49:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF642A2282
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645087775; x=1676623775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NHYxaTfoFNMgBJV60yzIFKqR/jR1mOe2OYEk4pWdwxw=;
  b=Yr/s+B+2iSf4K22YacF56flxbkEwAJIk4R0tJnCvdErcIkmOFDkdJyn3
   HsRgp1PMPHVXSxTc2qDe3ZvLxrUhkomncwJDVmGzEVaOheLhYTe0trhEr
   wnKY19lUAKR5y/WVYT7ffyEoQv5fgZcLzSK4y2/cPGjLBqOOw4L+RAqP/
   G8bEmr6uHd0wyIDtUWg6+rFaG/3woN2qmngYywTRPKseiOOiLLANN632u
   UfsLJCBQsqpUCTuC+rFLNH9eiBznnGW6jg+PGKAfbal/Z+r2BZHvHQlgs
   YdkGOM4PYWVBdEzY8iS6lozz/jbQn2qzmzycweAoQiQYIse9RfxDGUiVy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311571383"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="311571383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="589200844"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2022 00:49:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 00:49:34 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 00:49:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 00:49:33 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 00:49:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huPusClqVUy7MnvSgGxWwHBBVZogjQ6IDPGORxF68v1A7umQ0XamAtR4eZkTEQQsy57ABzZwZa6jlMTLaGXBhgKofy2xDIPoNf8DhkTSylinKlGKZt2RF/Yy0FCZ+6fPjWswHbMyr3oJBnv+t+3DPtybrvAIAd0urV5C2r0mpy/tIQJbTCKc4+VAn4s8Ug6xZsZNCT9qFOebVthAVyl02znkJxkVdNGC9wsRww9i57m/3lXazSBwwexMH8giG007pEP75WVfRRvGpitz/bpArBjA8sAkhrrFzUoZn+XAzAhie9GhIq1vnVCCF9WUdqx+U6O2W0Sm4cJLscveapejHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upflFs31VGXOVpoFiFcTRMk5DrfesUaQiSfpjky1TgE=;
 b=dVMu3gEK72v2WoDIpJHxmrAgaHMYXAtBS+BYqkMpy3FWYoev/7BbDoom+DJlP0f5ZHupAGj50ct2RUxJ8h38uBCvsQimIfPt2Rf1XjgQqzCVxrmKTxaFMrZEZdRc/TCXI+WSR3zMj/L7QegbyKJts5PKwRqa+LZhest841J7xMgNmsHZ1uvvvggDzjuHiDgHhk7dJk1pEmcVaH52nrmmZ3UW2KpLrq1860mwxoy6KVC32hQipeS+SMjmDcRm6HHXbnVnG6/aEycoozsuNhyquizOs/s6RUMw6cSbDwyS7MnI5QAO8DsWBuiQqC+j/4eZiZ+if9U9iofn/hyhEMxLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 08:49:32 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 08:49:32 +0000
Date:   Thu, 17 Feb 2022 16:49:24 +0800
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
Message-ID: <Yg4MFMvFt43et6Ck@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efcaed43-f134-42ce-bb90-08d9f1f26a53
X-MS-TrafficTypeDiagnostic: PH7PR11MB5862:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB5862F756C8126B41993B50B08B369@PH7PR11MB5862.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gp/ZKJwFzkzoU9a5KlKpbH6zSljBSFXBwhmD62ZMqBIjRr1cyee92RxlYB+QeNVG6THOYUzIUub9IEZZcTXAgxjnlOungDip4hQJNg67psOBUjEuN5Hua9mM+fGppcklmhk4S0iGpy6Bqs29TPfr8MDM2YnJGZtt6qPJoR+L9vLgIx04LOCdNHUPBQEkuv8OkiNDUMU4lJit0nafyqfJmhzDTVkK3Xt24p/4xQGexe3IOky4l4pIl3BRYOTOMJFHqbUGp6MMa7/jSw0F631/XRyHn07/xbWYgz2Z99iOBkGBoHLpmkCe7Zthm3yWigeaGszuTD16H4dSXLHLVtChzbDsa0tFy0kfYAxyZm7gfA+kXH6ajJRgmD3fg+y+fXldri/JTpBDK5mzjgw3PjYUG/ZsuqiZ6OgsskrPb/EF50u9EwcDG8C/+4iZPUBua6n6RfFaFHvU6ZajzdBi4WcGnfMKTH4oMYqC6P4H85oDUuLh12W4eUyVK4eABBmwBzy7oviJaHCg6wMMrhQ9d6nnN3fsBThzvFk5SIVUIOoAiAuVnQZK6kpKcGtVW5KkYYFgIaktcP27yfe1ETJCFdF8LqfFFpPpjDELMgr8w/TA05KCBqCPU0LJLV9+Vp/VombZWvEzG7SFtMfCODtPZ2A8OoohH+LMfOfC9UvbvWaBdawHY2vfjtDL3IbbBrnLZEGz5WyVcELJH5bbU3SvpEo7vOHSrYOeiUM+6t7zi2vioh99HukRZ0BohnC3dnIijaifDIhlj/BM+RL3ih0ezsuJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(38100700002)(8936002)(8676002)(2906002)(66556008)(26005)(186003)(82960400001)(4326008)(44832011)(86362001)(66476007)(6916009)(33716001)(966005)(316002)(508600001)(66946007)(6506007)(9686003)(6512007)(83380400001)(54906003)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5aK8pwcLxzrjigYMiv6DfI8JMnDoZ5m4zbZJtAelLT4i1Ue6Y8lGoSTHFaUE?=
 =?us-ascii?Q?yVDmwCpxhzTKqcVALNaFsV4uMdSbk/0hIUYmG9KvfsW/pVczylqw3sEXXmZA?=
 =?us-ascii?Q?6j4j3uFeZMRyM4yfs7H85FcawEO1TpfEnfA0g6xD0+GhapZYWxbykk/teuQ5?=
 =?us-ascii?Q?9FHmD3JQzAWSFvYofxbcUJhB2XVD2F9NBGmaOiauTxHERZDcdX5VbvxYZq/W?=
 =?us-ascii?Q?Vid+Ws+3Wn3V1aT5353AfFGAGc9Zc4MrgzsrH/Sm9EmQT7uk26yPDnVA3T0w?=
 =?us-ascii?Q?EGez5xjzTrgZ0N5URAj9TfUPqaIZ1X5mbQ0r/Leqmu5o/tdkXify0yek6G5N?=
 =?us-ascii?Q?Vh0C0BCEp/zsnQAf3dNqDXcK1XGXDOASE7N2DwS+E0hHQiUeTtGARVUkTf5E?=
 =?us-ascii?Q?Nccnh24x8FU8sGd303IcRY/UAKO+hUvUGNhdy2pYat8erraG1zO5Yo6/Nssy?=
 =?us-ascii?Q?o+H40t/Q6KrtiBOwNO+Hg2afq4VW2m5Hbi1QN7w8JA8AO2awIwg4YCmI5mx5?=
 =?us-ascii?Q?ne/TqmM52ALwmuAzxHNzTs1R9ErGLl9IuJksF/WwEK6g+i3pGYygb0EvroMv?=
 =?us-ascii?Q?RqnPujymoNH2VXzMCu3712nkrcZ8/TsBRRNP4L/aAiFaZC5mlheDea7AKMog?=
 =?us-ascii?Q?4iAJmFahCtrG4DhRZ9QhNIaPxRrkQlUVVK5+Y6fbACwBu/LsHCa6razkzUrL?=
 =?us-ascii?Q?UyGistsZSpTaYualQp/VtY12N7qNKLl0K5bvCNkepxCic3d2euPvKQxPxIO1?=
 =?us-ascii?Q?mDwZcNpikr2jXEwAn6xCk7yG73Kj6NpANnG2eXqnU5DR3ixSVLKCdAueptIW?=
 =?us-ascii?Q?ZcsGsEWVLKWD0PtNp/XMPUJApi+mtDCMEkBg8HeyE2xji/t6drXTyx90/EZV?=
 =?us-ascii?Q?TQ5yWNsWhVPaylvd9m2MNRxT5KYQZaAgTNe64Uz/xjJgOYfPQomC3NsZwk+f?=
 =?us-ascii?Q?kKWfEVTaR9URKH+PihztjwXXYTJxOPIvSXi40dEyKCi0RzXnTcRB4bOiic6h?=
 =?us-ascii?Q?Qzf8ugzi49ANeJutR+kT3so+Dsouwe8Hb2MMYijpv0j6pITmm8Y3GdUm7J3C?=
 =?us-ascii?Q?E2BWoAQgqR8C7cfr+PAXtphciUwK6gn5cEDV8NHC5JohKmD+OkuaBTcibItR?=
 =?us-ascii?Q?CCqvnAAToSaASA9y3ZbrVQ52f2htsTTqhgKoo/h3XVPVWznpKnEWgMMbaK48?=
 =?us-ascii?Q?TZTUOCE1TW66cTtcUIkH6yvJHvuc18QJfJKlHsFCff/w+ibgVrij33icOB/e?=
 =?us-ascii?Q?H7TQpt3+eyAH6+eMXxXgdhUadS2SOaRBg8nze3ezxPfW7rhe2YsK1/KQtkrQ?=
 =?us-ascii?Q?dI9gVvL4+vJ7k8ahLaDyf/936DeJSSx2mavv6GTbs6HIOvMeS86dfwu6i+pb?=
 =?us-ascii?Q?a9TO6scHLQux4g96jy1y3ppQ9vDSOTveiC9ONCnFG4PVLndy+D74z4baseVe?=
 =?us-ascii?Q?K7uEAy9InVupRwH53TMk+LPkisf+i8UxoGqlXjOYzI7MPOtcJQ1hmp1WQX3p?=
 =?us-ascii?Q?epGWyOC9+6fJ8VCH/zXebKEVa94IkDvA2PbXNv/DVbJH/oyxGDUxWpixKhXc?=
 =?us-ascii?Q?6YfqDmZDYCIKjCc7HuTMtNNJSGApbpG64t3vySm1XJw5FqwIXFt3jyUYz+G1?=
 =?us-ascii?Q?VbHIJwTbZNIyg8zrUOOoOqE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efcaed43-f134-42ce-bb90-08d9f1f26a53
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 08:49:32.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCqPbcTwHiFq9tEAe/rUF6QlgjeC9ChqDrc/JZoAq5cp4p8Tobbwqax16yw7FDA17FT+TJ2eDXPEkr5DpOf/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:53:08AM +0800, Aaron Lu wrote:
> On Thu, Feb 17, 2022 at 12:22:26AM +0000, Mel Gorman wrote:
> > free_pcppages_bulk() has taken two passes through the pcp lists since
> > commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
> > pages to free") due to deferring the cost of selecting PCP lists until
> > the zone lock is held. Now that list selection is simplier, the main
> > cost during selection is bulkfree_pcp_prepare() which in the normal case
> > is a simple check and prefetching. As the list manipulations have cost
> > in itself, go back to freeing pages in a single pass.
> > 
> > The series up to this point was evaulated using a trunc microbenchmark
> > that is truncating sparse files stored in page cache (mmtests config
> > config-io-trunc). Sparse files were used to limit filesystem interaction.
> > The results versus a revert of storing high-order pages in the PCP lists is
> > 
> > 1-socket Skylake
> >                               5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
> >                                  vanilla      mm-reverthighpcp-v1     mm-highpcpopt-v2
> > Min       elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
> > Amean     elapsed      543.00 (   0.00%)      530.00 *   2.39%*      530.00 *   2.39%*
> > Stddev    elapsed        4.83 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
> > CoeffVar  elapsed        0.89 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
> > Max       elapsed      550.00 (   0.00%)      530.00 (   3.64%)      530.00 (   3.64%)
> > BAmean-50 elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
> > BAmean-95 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
> > BAmean-99 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
> > 
> > 2-socket CascadeLake
> >                               5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
> >                                  vanilla    mm-reverthighpcp-v1       mm-highpcpopt-v2
> > Min       elapsed      510.00 (   0.00%)      500.00 (   1.96%)      500.00 (   1.96%)
> > Amean     elapsed      529.00 (   0.00%)      521.00 (   1.51%)      510.00 *   3.59%*
> > Stddev    elapsed       16.63 (   0.00%)       12.87 (  22.64%)       11.55 (  30.58%)
> > CoeffVar  elapsed        3.14 (   0.00%)        2.47 (  21.46%)        2.26 (  27.99%)
> > Max       elapsed      550.00 (   0.00%)      540.00 (   1.82%)      530.00 (   3.64%)
> > BAmean-50 elapsed      516.00 (   0.00%)      512.00 (   0.78%)      500.00 (   3.10%)
> > BAmean-95 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      507.78 (   3.59%)
> > BAmean-99 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      507.78 (   3.59%)
> > 
> > The original motivation for multi-passes was will-it-scale page_fault1
> > using $nr_cpu processes.
> > 
> > 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
> >                                                     5.17.0-rc3                 5.17.0-rc3
> >                                                        vanilla           mm-highpcpopt-v2
> > Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> > Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> > Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> > Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> > Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> > Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> > Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> > Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> > Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> > Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> > Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> > Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> > Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> > Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> > Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> > Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> > 
> > The differences are mostly within the noise and the difference close to
> > $nr_cpus is negligible.
> 
> I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
> servers: CascadeLake and CooperLaker and will let you know the result
> once it's out.

The test on CooperLake has finished and the result is in noise range,
i.e. no obvious performance change due to this patch. Feel free to add
my tested-by tag.

There is a problem with the CascadeLake server, I can't test there. But
I don't expect a surprising result either :-)

BTW, the lock contention on the 4s CooperLake is only 46%, with 14% from
page allocator allocation path and 4% from the free path, others are on
LRU path. I remember the lock contention used to be in the 80% percent
in my previous testing, and I found this old mail where page_fault1 test
on 2s skylake saw 80% lock contention:
https://lore.kernel.org/linux-mm/20180205053139.GC16980@intel.com/

So I also did the test on a 2s CascadeLake(failed to find a skylake server)
and found that the lock contention is about 70%, with 12% coming from page
allocator allocation path and 1.6% from free path, others are on LRU path.
I guess something has happend in the page allocator and zone lock contention
is much better now, I don't know what exactly, I'll take a look at this later.

And since free path's lock contention is small,  I wonder how much
value of the prefetch_done_on_free_path still has. I'll also give it a
test later.

Regards,
Aaron

> 
> I'm using 'https://github.com/hnaz/linux-mm master' and doing the
> comparison with commit c000d687ce22("mm/page_alloc: simplify how many
> pages are selected per pcp list during bulk free") and commit 8391e0a7e172
> ("mm/page_alloc: free pages in a single pass during bulk free") there.
> 
> The kernel for each commit will have to be fetched and built and then
> the job will be run for 3 times for each commit. These servers are also
> busy with other jobs so it may take a while.
> 
> Regards,
> Aaron
