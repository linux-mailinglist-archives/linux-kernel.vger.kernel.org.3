Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8905865DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiHAHtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiHAHth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:49:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63152CDD0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659340172; x=1690876172;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ihY/K8lYLFXlWPVqip40KkVy1hH37zfSBRGovsioUwg=;
  b=n91eO8dcD93/cQqINvUnmi4FaZhi6Dm2nTjOq1jK/dpYsU+LSpFCvf9H
   e1yE25nE6v1Hau9tNT52WCR8Yw88cTpx3Y7bVSqqgWB78I2YlYKj/2wYO
   vEhpjq7WxV+eL9VhB4Wo48DKmKGM7fDwMVagmYQaOtAP6qXgenQGllBtO
   sbmSxwi061ho93GaWv37NLNR7BrkxPNFXr1pJcXFz7hT3sK+ewYg/TQNk
   zeHvd2SjCUkLNWxOlb1g9zXWLFWMm4l++GIlNp1jslJC24qcVyrjYaype
   q63CEkQi3KDgJgAveeeJHFqMLsQPJK9VVGWx8YJ9Z5UisMnYPM437BOgp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="289100300"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="289100300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 00:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634806605"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2022 00:49:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 00:49:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 00:49:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 00:49:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 00:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQNLy1ejjEmwjJ5uvGWS6heJ2hpjrMloxX0vauykA+02y2/ntiANjDbrc4C9zhKLEM2JW4bKM2vbo8k4To0et/np+hfMBLkA0Z5ulQkkgk4jbSKNHSQ+k8/RqBrFDMrqfURWx/RwztN7WUGxq5G0Gd3B+eNHtbqkOeUflaBPImbUKpFffVzaCHVil8sN5m87t+6nMjHjUtIOUWqEcD0vWAO0f17FgyIwB13UxQ7I/R5oKLwy4hfdmk3OZQcORshuI7u2CG3NeTrYfrDdnXOq9azR9U7V7YyXus+bJri6Bvg8TiUs4BekeoKeTrNlSXa7Up+1tRV/LPYzK7AHe6bTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpaHzazLrXIaHn4Wo60aGUAuKvWyinoGtLEOMhuFzIc=;
 b=LU/56gHCq8+ucfqeRU3LIgzYGup1LBG49boVVT1d5rKn/+oZG6HNsCS1BPT2Mb9zoQel/S70teMehnkso2QUnWogEUGRV1FIsc6nniHOLeCDHRPhvxclHAUwOf82cRHmmACcREMRhsPv/uEPP20rjrYx3LvHcqdQzDpgOrMiVXf3JwxU4JLu43JE5vcAkM2cNfapMJgdg59s3BUVdkWGG5Q/oMbRq8stGoXAG1bupjoNnVQ+/WhTTfPV51XjoPMSLxxiNyV89yHtFYWX0Dm+Lmqwhj1esT638w2ZbpQdUAvhZzkYzL/HNWPYx5WeVJHB6ib1NdqiRCE7SY2Xea99DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB3967.namprd11.prod.outlook.com (2603:10b6:208:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 07:49:28 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Mon, 1 Aug 2022
 07:49:28 +0000
Date:   Mon, 1 Aug 2022 15:48:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Lameter" <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [mm/slub] 3616799128:
 BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
Message-ID: <YueFZm1JHDZOKVw/@feng-skl>
References: <20220727071042.8796-4-feng.tang@intel.com>
 <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl>
 <Yudw5ge/lJ26Hksk@feng-skl>
 <CACT4Y+Y5aTQMuUU3j60KbLrH_DoFWq1e7EEF5Ka0c1F9a3FniA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y5aTQMuUU3j60KbLrH_DoFWq1e7EEF5Ka0c1F9a3FniA@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 325743ef-09fd-4780-f701-08da73925c4e
X-MS-TrafficTypeDiagnostic: MN2PR11MB3967:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEi7GjQXce3g068HHue3OpAc87z/ys0xpQh0e3OyOJfN0tKuwEow51UWXpBLFn/P+r+MSNdtZQ2HM1b4Bx1wMUzCkHlp/FCS7WBzHR/j+cvlbGPLYq+lIcE2g02j0zCMULcAvy7aHvw0CVPrxd0dkCdVtJqLnNAu/G8kbtCW8mV8+zADykw39uFSBqLlT/sVEZp0kJa9XFErz5Xbofh4hsfh3ygju2/PFyUUS9ev4w3TwoGU+SV9mWmgG61+U9q1SfAh1HdHRtByWKA3Kdre1ioLb03cHVfQbfIFHyfRj+yZWYexkizu35ZMkyGK5oCLQ+EiqPQ3SgfklSeioxagMMWNHdL53p4uoc+E6jHcuB2SWd82+WwwFhqBXYvFuXyuN1xoKC3b0b+9RtJGSmPlw9+c94xtEPoQD3bB8crbxwidJFdfQ9z0/lvmGNfsCsxSBxckyDYuBEYVP/eg9vzCUBR2muE0EvFFnvm9KQLw0GiSL3aeon2MAAJahD+I3UM6QnqmwOK0ksA5VKU92Ge75yjxPwWlZRRgeJm9bdU7fo/pzmAOmUjmKG4eE15jYeQqD2bnuZ4JSWj+I1R9fhDP5/Jt5aEatlHkzvMGP0hvm36zukFT16PlvKqKTQ0hlXUWq5yXILkSeX+uAAbHSoMn79Uzmi6eibmETvlo4SGrqqnXnAuBVaon8h0crGdjKYXtbcXCRyRIETycYZ9lT/dnuDi2gKUCH/nI81ZSFxb5gPwoqgXleIriOy1n/oaLOyy1fKE1bZDOMkX6AFIqR75+7Hegsj1znTB7X8ZAMHG9bAcl8p6YTqVQQnyXrMKXdq5X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(66476007)(4326008)(66946007)(66556008)(8676002)(8936002)(966005)(6486002)(5660300002)(186003)(7416002)(44832011)(54906003)(316002)(6916009)(478600001)(6666004)(2906002)(41300700001)(38100700002)(26005)(9686003)(86362001)(6512007)(33716001)(83380400001)(6506007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7e/AHXM3iF5fJQ5SGlOHjQ27n8YHyO5GHMLmBb+H3ergx4vZ5O0wLdCKbrg?=
 =?us-ascii?Q?CuHEdEc6df1wyWey+UN66GKv7e9eiVC/rCfwn7PiPtbsbDhGZM2hYQAeF2I1?=
 =?us-ascii?Q?iYMEZjefCCXYChE8x8q9eLxMVjQW0RRGI+C5sFf7T8QAMVT52VCTNhqwf7io?=
 =?us-ascii?Q?4jQGW8fX19JRgmFwstntkZ8iF+Heo0/Moyugo6BCgZ5ieIQ8bD1WOiuO01Ny?=
 =?us-ascii?Q?HokOrOppuNhWiulxunxAXpU2gH/zuybRfNc5ADCN0/9s2MH5ePyDrB+i4/HP?=
 =?us-ascii?Q?QG94Pp3VTposK7lJb8R4AyTMpcrqYL7Z6bNLSPFGQnRyJL7LlEuVC1iaZUjL?=
 =?us-ascii?Q?pl2aCvAb0VwEl1jIroWvnUxR+9nZjVPiNbCpMJikZH0kiAGaFVJUOjTOcw49?=
 =?us-ascii?Q?KfVj4VdV0DRVYYp7UXkdn57oKfddKnq9fPbB9IRCr/VtmFV4AJOZIdKOC5JT?=
 =?us-ascii?Q?wpxb82ifSDJrjQI5XuNWDlI39GmGR5uTmDW1mLZP6F6TZMn32baWJ1DfanpM?=
 =?us-ascii?Q?nJoXwM364D3E3W/AcyU8MzP1ZCLr3TMn+IPsexNo3N/nT9WkltTZgd6e3Sgw?=
 =?us-ascii?Q?ZYARkHQ0W64ximKU2j5kKj7zuQOQjJtQ8yZfRVNV3qSucXht8haR79bIkEB3?=
 =?us-ascii?Q?Yj6MvJKyBmh4nA+uG3xVtvsOq/Ue4M42ban/60DMSkzsbwUml/pjdqAjqVPu?=
 =?us-ascii?Q?88UfrLA9+jZPn/mBbpY79XQnjY+tLs7x46rTKhd3FDPtOwj7nBsW59sIfvK8?=
 =?us-ascii?Q?1Niskuj3SqlG6EFLxxDzezHAMaT8nwwZs4Z2h8m3Uf3NEyaXhLB4lJhWTsIi?=
 =?us-ascii?Q?RCE+JouXjdQp67JdtvJqbMZdCR8+jTWtgSJu/NHbVX+LVbG6KLVpviE/0JjN?=
 =?us-ascii?Q?Ft0ohsVwYeK5LQL5tCwSJcskKz7g9yXI7JmcqJ9RyxW2RSUW06OOsOEG8vuU?=
 =?us-ascii?Q?SLEiMG+6YV4RZD6qrgWUxdc/t5W++2ZMxP/a4Dy7V2urj+i45S0teMvBXZ9+?=
 =?us-ascii?Q?kmAF+yKqNm062ACIUGrm0JPyBUZ0OctwXScgT5nNSb0O4Do/J5zA2FalLciF?=
 =?us-ascii?Q?yFuo4K0qTA6cILw4ZZPSqiAtW46QNKjs0ex2IouAMhH8GQUTujx2AkIHVMAq?=
 =?us-ascii?Q?EJ7Gs0HNJl4UTO0Lp1glVeYKwMc+/IxSWDZdXdpGOwROqU8x54dmzgsz0bPU?=
 =?us-ascii?Q?/8ikk7RnhImQeiU7H4P0mTbmp9wxKD0AoBHJ3HW7qpUr+VOcsFTg/G1pEKcv?=
 =?us-ascii?Q?LJn0VmqYuysqcvNa7AsA9kp6RExbf09qZ7yZcSDM478owzvxkBDM14o3rAaY?=
 =?us-ascii?Q?xus+ZIWkdZ8k/OEznEemLDVC9NZ911m3SLigwN3uJ6oWZ7etarV556FHZ24D?=
 =?us-ascii?Q?wv51oogXK/2O9D1Hv55HkE2Mv2OBlHFYkBMa5o4UGVSRdZuP83+5sxt2CRXn?=
 =?us-ascii?Q?t8PK4xtv4rchpmKFxIqt0vAxK9TJz9y6uBKvpabTMoFUmkPdeNgp+qEfySED?=
 =?us-ascii?Q?WhKKd0TyBmiM+QEgdSS4vXxiRAmwgnqHreY9nPHsepUP6VJ0YaOIH3pMCIXO?=
 =?us-ascii?Q?3tIHXQ10ADgz91cL1J/y+Bdyy7dZPGlRI14BJtPs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 325743ef-09fd-4780-f701-08da73925c4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 07:49:27.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHfSUAFr+WlOCZaLutKEgmhMvNaQbvolKSHFrv7oE3npACG9Szum3JSIfWBqCuNvJpdL/1eRRk1Nq9nTBAq0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 03:26:43PM +0800, Dmitry Vyukov wrote:
> On Mon, 1 Aug 2022 at 08:22, Feng Tang <feng.tang@intel.com> wrote:
> >
> > On Sun, Jul 31, 2022 at 04:16:53PM +0800, Tang, Feng wrote:
> > > Hi Oliver,
> > >
> > > On Sun, Jul 31, 2022 at 02:53:17PM +0800, Sang, Oliver wrote:
> > > >
> > > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed the following commit (built with gcc-11):
> > > >
> > > > commit: 3616799128612e04ed919579e2c7b0dccf6bcb00 ("[PATCH v3 3/3] mm/slub: extend redzone check to cover extra allocated kmalloc space than requested")
> > > > url: https://github.com/intel-lab-lkp/linux/commits/Feng-Tang/mm-slub-some-debug-enhancements/20220727-151318
> > > > base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
> > > > patch link: https://lore.kernel.org/linux-mm/20220727071042.8796-4-feng.tang@intel.com
> > > >
> > > > in testcase: boot
> > > >
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > >
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > >
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > >
> > > >
> > > > [   50.637839][  T154] =============================================================================
> > > > [   50.639937][  T154] BUG kmalloc-16 (Not tainted): kmalloc Redzone overwritten
> > > > [   50.641291][  T154] -----------------------------------------------------------------------------
> > > > [   50.641291][  T154]
> > > > [   50.643617][  T154] 0xffff88810018464c-0xffff88810018464f @offset=1612. First byte 0x7 instead of 0xcc
> > > > [   50.645311][  T154] Allocated in __sdt_alloc+0x258/0x457 age=14287 cpu=0 pid=1
> > > > [   50.646584][  T154]  ___slab_alloc+0x52b/0x5b6
> > > > [   50.647411][  T154]  __slab_alloc+0x1a/0x22
> > > > [   50.648374][  T154]  __kmalloc_node+0x10c/0x1e1
> > > > [   50.649237][  T154]  __sdt_alloc+0x258/0x457
> > > > [   50.650060][  T154]  build_sched_domains+0xae/0x10e8
> > > > [   50.650981][  T154]  sched_init_smp+0x30/0xa5
> > > > [   50.651805][  T154]  kernel_init_freeable+0x1c6/0x23b
> > > > [   50.652767][  T154]  kernel_init+0x14/0x127
> > > > [   50.653594][  T154]  ret_from_fork+0x1f/0x30
> > > > [   50.654414][  T154] Slab 0xffffea0004006100 objects=28 used=28 fp=0x0000000000000000 flags=0x1fffc0000000201(locked|slab|node=0|zone=1|lastcpupid=0x3fff)
> > > > [   50.656866][  T154] Object 0xffff888100184640 @offset=1600 fp=0xffff888100184520
> > > > [   50.656866][  T154]
> > > > [   50.658410][  T154] Redzone  ffff888100184630: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > > [   50.660047][  T154] Object   ffff888100184640: 00 32 80 00 81 88 ff ff 01 00 00 00 07 00 80 8a  .2..............
> > > > [   50.661837][  T154] Redzone  ffff888100184650: cc cc cc cc cc cc cc cc                          ........
> > > > [   50.663454][  T154] Padding  ffff8881001846b4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
> > > > [   50.665225][  T154] CPU: 0 PID: 154 Comm: systemd-udevd Not tainted 5.19.0-rc5-00010-g361679912861 #1
> > > > [   50.666861][  T154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > > > [   50.668694][  T154] Call Trace:
> > > > [   50.669331][  T154]  <TASK>
> > > > [   50.669832][  T154]  dump_stack_lvl+0x57/0x7d
> > > > [   50.670601][  T154]  check_bytes_and_report+0xca/0xfe
> > > > [   50.671436][  T154]  check_object+0xdc/0x24d
> > > > [   50.672163][  T154]  free_debug_processing+0x98/0x210
> > > > [   50.673904][  T154]  __slab_free+0x46/0x198
> > > > [   50.675746][  T154]  qlist_free_all+0xae/0xde
> > > > [   50.676552][  T154]  kasan_quarantine_reduce+0x10d/0x145
> > > > [   50.677507][  T154]  __kasan_slab_alloc+0x1c/0x5a
> > > > [   50.678327][  T154]  slab_post_alloc_hook+0x5a/0xa2
> > > > [   50.680069][  T154]  kmem_cache_alloc+0x102/0x135
> > > > [   50.680938][  T154]  getname_flags+0x4b/0x314
> > > > [   50.681781][  T154]  do_sys_openat2+0x7a/0x15c
> > > > [   50.706848][  T154] Disabling lock debugging due to kernel taint
> > > > [   50.707913][  T154] FIX kmalloc-16: Restoring kmalloc Redzone 0xffff88810018464c-0xffff88810018464f=0xcc
> > >
> > > Thanks for the report!
> > >
> > > From the log it happened when kasan is enabled, and my first guess is
> > > the data processing from kmalloc redzone handling had some conflict
> > > with kasan's in allocation path (though I tested some kernel config
> > > with KASAN enabled)
> > >
> > > Will study more about kasan and reproduce/debug this. thanks
> >
> > Cc kansan  mail list.
> >
> > This is really related with KASAN debug, that in free path, some
> > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > kasan to save free meta info.
> >
> > The callstack is:
> >
> >   kfree
> >     slab_free
> >       slab_free_freelist_hook
> >           slab_free_hook
> >             __kasan_slab_free
> >               ____kasan_slab_free
> >                 kasan_set_free_info
> >                   kasan_set_track
> >
> > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > tracks: alloc_track and free_track, for x86_64 test platform, most
> > of the slabs will reserve space for alloc_track, and reuse the
> > 'object' area for free_track.  The kasan free_track is 16 bytes
> > large, that it will occupy the whole 'kmalloc-16's object area,
> > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > error is triggered.
> >
> > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > conflict with kmalloc-redzone which stay in the latter part of
> > kmalloc area.
> >
> > So the solution I can think of is:
> > * skip the kmalloc-redzone for kmalloc-16 only, or
> > * skip kmalloc-redzone if kasan is enabled, or
> > * let kasan reserve the free meta (16 bytes) outside of object
> >   just like for alloc meta
> 
> /\/\/\
> 
> Please just not the last option. Memory consumption matters.
> 
> I would do whatever is the simplest, e.g. skip the check for
> kmalloc-16 when KASAN is enabled.

Thanks for giving the suggestion. I'm fine with all these options,
and will also wait for Vlastimil and other developers opinion.

> Or does it make sense to prohibit KASAN+SLUB_DEBUG combination? Does
> SLUB_DEBUG add anything on top of KASAN?

I did a quick glance, seems the KASAN will select SLUB_DEBUG in
many cases, as shown in the lib/Kconfig.kasan:

	config KASAN_GENERIC
		...
		select SLUB_DEBUG if SLUB
		
	config KASAN_SW_TAGS
		...
		select SLUB_DEBUG if SLUB

Thanks,
Feng

> 
> > I don't have way to test kasan's SW/HW tag configuration, which
> > is only enabled on arm64 now. And I don't know if there will
> > also be some conflict.
> >
> > Thanks,
> > Feng
> >
> 
