Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2ED4BDEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359231AbiBUNiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:38:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359160AbiBUNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:38:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BB13E22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645450710; x=1676986710;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vWlMJQmoSHlg6/w9hPs57m/o+kNKSJRl+9eWOdpSN3c=;
  b=fnUsyad80HzqqqtNS2d/9vcV63ZwjzU65UGqJitANQoSKouPtiUaeFkH
   f1AZCwTwgmxS68Oj6G557awIPyvt8KRUui0AZDHZqaItRpWwbjIgQBdXM
   IXp41nF+ZmbWA64OWa4p1UpgDVYr5xdddGggC1Cevdsq5zR/Vuh3K3vYK
   dBvjRxyrM8iJpRiK4O0uI4KhhtE9XRJ9T7QFndA4MbVcP+E8wGzaJu0OP
   wv4CmaeYN4rZMu2X7HENHSJoED4NIER6WCOJgrwK+R47T0Qn21WTanAA9
   6z7oFadqmk66ftDr/E5Kz/R1m9iEnicaFkFyeqgCzsMShCQTD4jyxJ2cZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="231477973"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="231477973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:38:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="606390018"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2022 05:38:30 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 05:38:29 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 05:38:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 21 Feb 2022 05:38:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 21 Feb 2022 05:38:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK1lRM1w1JQ9vZUHXT1RsLgBlIfVUoXohYU9IXDcU3ugyCgtXQjYCD/nFpMh4mP8CwfQLRIbsKZffNvY+oQoeSHMgQsmpJ1vTkv9F13bytHL1SWMcdEhY37oOflLbcWa74/pz4J4HmG1tt8p9/f8+/icJaZH6dF4yoMpopa3yoqyyAXjfP4AxrxIxrFjYuMHB5EOE1vcVFedxTVRK6KY+p6tXynU8KHBLkNLxMIvBm803jFcW+u0eJtSlRO6yx0QYoSjFMhksdyU7MgjIcnYOMUtFc1hLbPeqg/KipHD6bYJZQ1n5M/ngiBFGF6KtOzZGfcFkDZxeLcN6/fCYIsnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAzKoKop7DnI9ZWySEuiWV46WELLIPWZNpzZTM01WoI=;
 b=UE4tZ2kzTCJGpd2xavJ1W+aaxDNeB658kor8605/XZRTeIXjMhr0BBPxHBjp908bFi7SncHz9sXHy5VPTkjCA3HumOg8r/iR6pb7RKw0Gn+uE6a9tdD220k0Fut28YEw/dGFObmWZ352V9r+Q1tTCTC8RTP/H2BjFdn7RMgENSw8/ws41TlkOUrcS/bpAeMA37rRxuCPq5Cqy2xB630EFXBswszFmBJA0cI9nL7SufEXnoXsuB1Mmvm6Mf2AwJ23Og5cgs7aZckv53lMoVEU+TvrJz7RrYuvcr2HK2L9MeXqGHM6bpJlSqziwHkFShWIktLt0cuhjsXPbWqcmoAMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 13:38:27 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:38:27 +0000
Date:   Mon, 21 Feb 2022 21:38:22 +0800
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
Message-ID: <YhOVzktqtWIJFjiJ@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
 <20220217093113.GU3366@techsingularity.net>
 <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17324960-8450-4e0b-20e8-08d9f53f7068
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5136:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5136A5DB45A42B75984DE3F68B3A9@SJ0PR11MB5136.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuOCfRhXUdMsC8FFLoAj/EpjlViKthINVmvh9iINkaX0Kq5FGEmo+W2ot/9HWm5/CBolj/mLvhkP5OaY5yU4NDeTx8spmRkjpwAVeBbLzQWy7fYX8JlepJ+PdbLtsCgiut+ut+RBksj3DwEt+8xX3Ke4HhLMJ19KlCsdYF2M+kIVlF80Jb8rvHX4KjwG9jrLbPZiyMLngymSSzeVrYNnGQvgnONQmfUMzjSlN+Lr7lS8RLPXra7y6oipYB3Fp8KmJKQPeaAOdinXw3WdxFDtUrmgC392+WZrY+KtMxXmbCYIYqpcefLhOZ674fmIiHdsrR56SKJox+3pjRHnXo2mLHRTw+3z/K+eWqXr0/qFzi34q6EvT2gduohqJjy3vqutg/TpC2g1rrM2gKpSRIedgccVACpgoMg0WyEvelfSeuwWJavx0xLCi2NVhUS8j7CtSEBFqsB/1JJCutEHXR0HM4xgTFOGjJy9asgH87Px3ItsJSelwu3pw09v8ujLT73BNin2O1ji+NBkKVJphUt8WOKrfkd/vJ1GgBp7rtrnD2xhlG+zuvGShabEiE/Sj/3cKTQmoe9GAZ3o7uaBfrNYws/FPKX6BMX4RBHG8WcK67KS2O3VNY7+kC8PCAh0rMWngpptgAT9vJ1/3JA3rTcTj0dlR9JlHnDP6Lav1sH+1uthZOOosRpimHegXlg0Rie+raRdKyUBELflRy09K/RWbGon5pTp45FYmz0ZWfDck04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(38100700002)(83380400001)(44832011)(5660300002)(2906002)(8936002)(6916009)(54906003)(6486002)(186003)(6512007)(66946007)(9686003)(26005)(66556008)(6506007)(82960400001)(6666004)(508600001)(316002)(8676002)(33716001)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00paiSic7MzAbplldBnpe94YvkS78ZgImRqnjGvx+uW2jhAbs2Z8SXd5+mez?=
 =?us-ascii?Q?gRRxFpG/NvPhpxHIoK53WvM2V5B3zuI47fnvOZJpt4WEB4lw2XQ8dXRIZClY?=
 =?us-ascii?Q?cS7OWXPJEH5TE98fPhbZC3PWVKn4VSOU2ZsqDa0mL++TTeHKA2WjHNFd/REl?=
 =?us-ascii?Q?38Fb0Bv7dz/kS8I8jXXtDLJl9fCb4tymFiyd7yZ6I3iQ5anjd9T5KqaRuZxI?=
 =?us-ascii?Q?/hzTFeD2rav7WW09S/B3lIiHgpAkJZiKbf7HeSoFkJl5nvRZpgOz8VvncfWT?=
 =?us-ascii?Q?nxTAR2c4gLGFbQDqKacq9IXcdySl4CFitEkOBKhBb41OGAInWKKJUrIH5yNf?=
 =?us-ascii?Q?t3p2LMXK6U8tffZuRN+6jZv6DtrxJf5axLSyq78wo41t3RM0Ss8KcNfseNKZ?=
 =?us-ascii?Q?2kolTPACdqysxANEGdRHnYS//v0HNV3hSyC8vJRq6IJuWulzQHe/KLvHCUH5?=
 =?us-ascii?Q?Kr6jt6+6Oj0OtN+Cwbr9G+hfWy4CnEXSSFu2Fp0GDouCL0Of0jWxilYtp43B?=
 =?us-ascii?Q?jCPuTp5O9iD2LeYrpmgI6uT6U6sqWUUEj+vneFE0XBuO+rPLWrawtf9ItJ6T?=
 =?us-ascii?Q?MoRT1r5QADFq3ejIu91KiOX3aKSV9NzaZYo7DVmlif5L+vR5FPpuerx8LDt/?=
 =?us-ascii?Q?Ck+YWpw3QtJd5mBn9rOye2sggd1ZEXd29E8iNWH8QBKmHo5WzKZvZ2ecHHze?=
 =?us-ascii?Q?0B5EWPY6XQTgZDxknKq8buN8K435LAFRSpbZZQY+HdZI3biLaCXYARvEqLIB?=
 =?us-ascii?Q?5hAcvGoKGatni5z3jkc9yzQ1Ns92Pd+29lbp2puo2SyDM/PDQ8+/pt78fLme?=
 =?us-ascii?Q?AlQtRJdcBw84G/3w61ru9+XzPFOP2Dc5JaO8MvJsQpeXaA5OKakNTrEzAsBS?=
 =?us-ascii?Q?jpFUOV5QRxcpIT3jWg7bNepNzRaRdhOe8557dVKvGpNGGzrEacGcohblSUPS?=
 =?us-ascii?Q?5YZMHP+NTAimwuZEb4DYgh557A41a5S0kRNXorsq2cyXPKoEzmyiYSj4CUxs?=
 =?us-ascii?Q?delTBk+/ioxDspMEzbqO80GHz7zFotAlTCMtWobQky7IXglsAYVwvYJSHCcK?=
 =?us-ascii?Q?BBQQbV6QPiETF+rHnhtwUIdeMJqwFaMuwq4W7wqAtxL2UBh2iipTX5JADx5g?=
 =?us-ascii?Q?eeef9J6mYtecHm+ZdFsDnECDJXszgbkzNN2UvZ8DYB7MlIJXEKJDihGcwG1r?=
 =?us-ascii?Q?SmmSxlE/l04eR2lMsVgk3hm3TBahjwWBGTH2tvDd1feOR8QMqLnsBJE27+0P?=
 =?us-ascii?Q?sgoaZgiA+srFiQpEGVZrjROSnCV1nQKqQIeSBuf8Lm+AjRF0yhlU482itE2E?=
 =?us-ascii?Q?KdO6Mt1yTVMW17s0lhaKTm2TxMdswxBZ06v+gUzvmy/I95F3DZzgVlYqIaRZ?=
 =?us-ascii?Q?PzlOOR+MM3scLol08SBIcaANW8Uk2qIAwMcXjAPiEgu8I3mO35iv2u6q3gt3?=
 =?us-ascii?Q?PZg6e56lkUZMLhYHGhyGhlRJ0oBwzgjMCJscATcG6kW810RiRg4rR3SoSOFv?=
 =?us-ascii?Q?zyq67SkvtG58i6LK27g+/80ZTnKPJQBJ+zRoQZ3kOTW6hUkpCsKf/GirI1HK?=
 =?us-ascii?Q?xmXqlnx6NRYW/HoLcev27uTMchD7puIBVImnbZa1+L2R3RjJDxqzCC4wZFc3?=
 =?us-ascii?Q?ZB+i7CM7TFEOBoqNZyQSHBk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17324960-8450-4e0b-20e8-08d9f53f7068
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:38:26.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WUy5Ln1nZecc4MtyoWi9D5hUXJTRBPIDxSGm6tDjlKGFblm+3ETHRx8o7NQRcenmULZEhZRchL2NcolNCNbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:20:03PM +0800, Aaron Lu wrote:
> On Thu, Feb 17, 2022 at 09:31:13AM +0000, Mel Gorman wrote:
> > On Thu, Feb 17, 2022 at 09:53:08AM +0800, Aaron Lu wrote:
> > > > 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
> > > >                                                     5.17.0-rc3                 5.17.0-rc3
> > > >                                                        vanilla           mm-highpcpopt-v2
> > > > Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> > > > Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> > > > Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> > > > Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> > > > Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> > > > Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> > > > Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> > > > Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> > > > Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> > > > Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> > > > Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> > > > Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> > > > Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> > > > Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> > > > Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> > > > Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> > > > 
> > > > The differences are mostly within the noise and the difference close to
> > > > $nr_cpus is negligible.
> > > 
> > > I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
> > > servers: CascadeLake and CooperLaker and will let you know the result
> > > once it's out.
> > > 
> > 
> > Thanks, 4 sockets and a later generation would be nice to cover.
> > 
> > > I'm using 'https://github.com/hnaz/linux-mm master' and doing the
> > > comparison with commit c000d687ce22("mm/page_alloc: simplify how many
> > > pages are selected per pcp list during bulk free") and commit 8391e0a7e172
> > > ("mm/page_alloc: free pages in a single pass during bulk free") there.
> > > 
> > 
> > The baseline looks fine. It's different to what I used but the page_alloc
> > shouldn't have much impact.
> > 
> > When looking at will-it-scale, please pay attention to lower CPU counts
> > as well and take account changes in standard deviation. Looking at the
> 
> I'll also test nr_task=4/16/64 on the 4sockets CooperLake(nr_cpu=144) then.
> 

For the record, these tests don't show any visible performance changes
on CooperLake.
