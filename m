Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953F5AA7ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiIBGQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiIBGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:16:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57CB90823
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662099392; x=1693635392;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kG/Efe6GvBuZIMjT/i/T9hQ9g5rwoe3epmh38EDsU1A=;
  b=cemIBab1AjSq+cAD/GerwFTdb1J8htEmb4K44sLJ5x7TumOz099IwUUU
   yMnV8wLYloM5GjO/gHMqmFEe/VOMITqdmKm3HAY2lyCRfQi4RxhMpXbJb
   m2Y/Pkz/D/PwT60dRRzRzh1+1b3BppL8VPgTr1l6uJADhjHxYLsEoCzGm
   fK1U3VfqHR2R/rzHuinmEICiyMpVVrIBmnQLBuVnK9F+lsYd0FQ/Eba0f
   QX9Per5p1nxMwDGf1g2YKUqlXcsKL/h0IcBN3CFDYRV+0N9gAHd167w5f
   JPrUVnfqv5zXoh3zIiIpljHUxG3CcrN119zRbyk4u0QzHbCXRg8HwI6TL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="382203946"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382203946"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 23:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563852041"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 23:16:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 23:16:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 23:16:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 23:16:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 23:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrgaKNZk9Wh4tijEztZfhhLyqkCR1ELe+O5qb8KnDSeJjg4NEnk9+Ja7PDO+0N/itEtNzCoP57Y55ePEkvl9aNyncVoc5WcSIyJq60WJcGkUEQKl3QJxVWeM19OTvIhaWrdTlIuLhBa4K/umYzYfeAaWRhffw4siQGNuLhHlOE/5x5wfTEvmcIcW3x2xTu5z2IgZ0rEMd6cSMilOxUppUhQDZWmFHQmvqcJV91xsUQnC4FwKMshKhStKodhzra6w6zdVw/9Xhwj36Gq2j3b6z9qSeMf6vEb5hFvs58YO7HhifNlcm/9GBLVICVGYeRsFeLVH1+9JjY9F55tIjMmjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmusF8UMGSxeqQP2o8STrWF5PnMCg9kCU43E2ZhCw9k=;
 b=cSLASck6tIpISiZir1Tko1OLSVLTWWA+kz5TPTt2BaNefvZV4iMPKdHpMkeeuy3+KlxBGsYe9P8Vnu79I4zgaNdD2GfPcx40jszvB5kI1WarrmBX/nn6Yz9Kv28EqU+hGqWAcd9Qy0JVmTTYDZsNCAHpJot5bWmLZabhY4SldOz1DJElqFCJzPIbeG6Rx6luyp7xE9uhnM4kVW1oKIrdroIHJMOKmXNfW1gpUV0QTza2XboUpsVxP+uea6x9t+MQVSzzgw7I2EZTv7cnB6+ZdjlDC8LLZEnACWVmhKp8vAN7VlRhqcuv5frF/tFthu95Cv1VECT9WFr5e35g7JqB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN6PR11MB2893.namprd11.prod.outlook.com (2603:10b6:805:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 06:16:25 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8%5]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 06:16:25 +0000
Date:   Fri, 2 Sep 2022 14:15:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxGfkdvJcNJma/88@feng-clx>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxC7Kda5g/aEqarm@hyeyoo>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985a9e25-9450-4526-af86-08da8caaa9f9
X-MS-TrafficTypeDiagnostic: SN6PR11MB2893:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWrjrszdlwuZOpNN8lrXdyhoqSUEux3ahw6xXqpwDwvcSBkWY/MNEmVFCAKo5Ilv7bdw59qZPYr0N/CzEsRsdretxotJvnqbVU92rsmFObCjDM2ytjR8FCyuh5tR6Y4SVJIvxXa4zMPKU1zpyHbbpBUm7IPmBVmU6Lef26p8nAxrHsQKDsWLpb2eePDW5zJHtYVgiAlp3r0hautjnDtJXKT+1FAJzlQZlZkMvuqSBPtONn1lRw4/V7hbE9tnZjcCH65MPi4p30FaseKQh0GbJGvalQ90QexjFdprlLm5lUmoxS5cvbJ/G6G0ckfdil2vKr5RUOja8LpV5HOdN7GhUTfjN+nbA7nHTbF9FkE+TRN0w0pJ2EIflOYkBiE0xHZirwOdMTWaW/UfwH4ogfGu+o61RYU/XWBqUTJ1noJyHqytQN9WOq+5h/m32H44DvXpAkHaf85+6xo3/1WeGyvYbeqUgYc985gC2Cg0SPsLoYGOgu2T8PkyCLar63Lu4rbgVhKawIC6qOu0+YBiOjwHEySRocCZesQMHba0s6PEKLWQ0bH5PkFCOD050o7+8NeR/RVxFgtqGVfOOK9ySXZA94/TNGA0Op9BjA+NNb3OSIn/+oLzX0yEtiJfcK5CaGNwUyBGtNMTdGbGGno7z8VD3mAWC+wsdutE344K47zkNM0AXyHJyOs4VIOQk2YJDXtymCoeXmkwcMxBcmf8Ggypzi5PRa50l4AKmIcFfHaRw8llIYb6w6YcCanQ6msUoTss2vdukRYLev/4bVJ2Mh1CnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(8936002)(2906002)(44832011)(7416002)(5660300002)(82960400001)(966005)(38100700002)(6486002)(478600001)(6506007)(6666004)(41300700001)(316002)(54906003)(6916009)(8676002)(66946007)(66556008)(66476007)(4326008)(83380400001)(26005)(9686003)(86362001)(186003)(6512007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w01BKZLSBC/iVy8C45PKFr8xKdiPckxIhXa8juohiUqxUpm+RXSgBBlvpnsG?=
 =?us-ascii?Q?YQYOjUBgKairPQbixAgGlZQ8I1S+AsfDMU13NLU/bf7AlriWBf1psBX+ZgeD?=
 =?us-ascii?Q?wL/TWrGjCaicFBvxVy4NwlnuDY8kVzMEGpd147+wg0ZPY6mndgRRQVDYC22+?=
 =?us-ascii?Q?B9CiC8AIj0MbSsa+25XV8/dHee2cGDGdev/ZIXZplHvgxeyHGoRF1mZ94SIx?=
 =?us-ascii?Q?diG+F+jv74VOxk6PrqGhjzbc2tCNmClDWIrjrYI/S2jCcwyOQvfFTEYcFjY2?=
 =?us-ascii?Q?LTEgGpgEAhmgWBr2SN4cT9W4JUxjCQur4sMYVnOZ0QJWyZYOfc/8AX/REo+y?=
 =?us-ascii?Q?5mg5f9+oKktARLyUmUsGM5O6NOe1UOCWPvZGCOF8sn3Q1EjO1o87rLDg3H5Q?=
 =?us-ascii?Q?0socZ6nbktM5ViG3+iQr+LmnvPcKW7ETLgw3SqJd2X6+cVJYQ65+i6xF535T?=
 =?us-ascii?Q?acq4xuJNcM5tXccq3gcxUz4/8kWOkQ00KI6TpEllTUHhoI7tsmmZuJ/ZXPj5?=
 =?us-ascii?Q?DLSYuElcho/arly1KCo+p03Z3BovlM7BSwOiG/PZyKQ8z7rEO4KkZIiqogjJ?=
 =?us-ascii?Q?lwOuo3G5948NoUcnZucXiHN7hArU7qz7n0MWQT5+me8DNUu/ZHP2Y3W4sVpL?=
 =?us-ascii?Q?mvItNvqGDzEsnkapGQbF5gCK4xNRnCNswEE5xBmdKkLfQRRIjmDAOEHkQEfB?=
 =?us-ascii?Q?Mk9O7M5eiwbQciQtX7vjxj1p2et0Oft1ET+pi9Rxg0RG3g8Y4pX4BJrMHAEp?=
 =?us-ascii?Q?jaXZcIVZlKeuVLiBJ3kf4ITiITSj5MRdX9XNFvorvhE2Rrx4MLF7l+QyJbdN?=
 =?us-ascii?Q?tCK6frVKjQd05Ray0i0sZ9FuRn04eu0ofvxPC1/Pl2xIEbiJJpsG0zl+PLVu?=
 =?us-ascii?Q?R74So1c0KbMpYk4teVzR+tRoWRo1LVq3lbivPZXQ297tiFD55PhYdm0JEoWq?=
 =?us-ascii?Q?9VAM/j5u80qVwOWakh/r/rPXq+67lyAB1HRjGrzBMEEDMht2IjnqNG5UAAbV?=
 =?us-ascii?Q?Eo+aXFB5JhLe4pd0ybOGQZR3h7fB1gio8grJPcctpglX/71O5uSJ48AuT/nv?=
 =?us-ascii?Q?cjJWXprRZ7zWRvN7nITsZSNgf/0hMUrjyQhwfHYcprtO/i7AycSgBHwDg0HN?=
 =?us-ascii?Q?Tc8FrOSYPAzMjIc1DBVk4pCbqETTeToVpaBauvl4+lnpc1nDp4/NgDssvAjk?=
 =?us-ascii?Q?R8R2KL+/TXUPeqNaIYpY2zAf00BdvoMxwWJdJckwASCgj0vraEeJHNX493Vz?=
 =?us-ascii?Q?qAu1RE4Ha7iyK6cbuCiMLw1nH8nlLzN/HK1BKm4drnvvf1LsTf3WaaCnrb22?=
 =?us-ascii?Q?NW8bGnONsLWKZgh75GRBfaHsfC0PO1ouQLL40k6UKgkrefQizakP3zaId3NV?=
 =?us-ascii?Q?N2B0ZsaE6fW9nagBD2IatgaYNiAEV1GcRKfouTJxFpNOgUljy1B65P0adXB6?=
 =?us-ascii?Q?8QQoGWdoPLSdt6I8EEa5kJYTrV7Z3PFfgcnypM1DMjNuDBgRtELzX2AL7dWh?=
 =?us-ascii?Q?lpIO1zfqSNdBHq5bXwrfLITYqu8qgaFTFZCO2EsKuer6o5boPm9xSVjbpllN?=
 =?us-ascii?Q?BoZ88xjrcAPjp7SCJ8EssRvVCp0rDL4XuRfigBIH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a9e25-9450-4526-af86-08da8caaa9f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 06:16:25.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //ZPmRRlPxQFlUfrjxcqvA4tZjioTFkJrTW0+wlyfD4k13WNSh4NvgLPb8rn+c7cb+I+0tdXOO9nodyKLD3EfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:01:13PM +0800, Hyeonggon Yoo wrote:
> On Mon, Aug 29, 2022 at 03:56:15PM +0800, Feng Tang wrote:
> > kmalloc's API family is critical for mm, with one nature that it will
> > round up the request size to a fixed one (mostly power of 2). Say
> > when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> > could be allocated, so in worst case, there is around 50% memory
> > space waste.
> > 
> > The wastage is not a big issue for requests that get allocated/freed
> > quickly, but may cause problems with objects that have longer life
> > time.
> > 
> > We've met a kernel boot OOM panic (v5.10), and from the dumped slab
> > info:
> > 
> >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > 
> > From debug we found there are huge number of 'struct iova_magazine',
> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > 1016 bytes. Though the issue was solved by giving the right (bigger)
> > size of RAM, it is still nice to optimize the size (either use a
> > kmalloc friendly size or create a dedicated slab for it).
> > 
> > And from lkml archive, there was another crash kernel OOM case [1]
> > back in 2019, which seems to be related with the similar slab waste
> > situation, as the log is similar:
> > 
> >     [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
> >     [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
> >     ...
> >     [    4.857565] kmalloc-2048           59164KB      59164KB
> > 
> > The crash kernel only has 256M memory, and 59M is pretty big here.
> > (Note: the related code has been changed and optimised in recent
> > kernel [2], these logs are just picked to demo the problem, also
> > a patch changing its size to 1024 bytes has been merged)
> > 
> > So add an way to track each kmalloc's memory waste info, and
> > leverage the existing SLUB debug framework (specifically
> > SLUB_STORE_USER) to show its call stack of original allocation,
> > so that user can evaluate the waste situation, identify some hot
> > spots and optimize accordingly, for a better utilization of memory.
> > 
> > The waste info is integrated into existing interface:
> > '/sys/kernel/debug/slab/kmalloc-xx/alloc_traces', one example of
> > 'kmalloc-4k' after boot is:
> > 
> > 126 ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe] waste=233856/1856 age=1493302/1493830/1494358 pid=1284 cpus=32 nodes=1
> >         __slab_alloc.isra.86+0x52/0x80
> >         __kmalloc_node+0x143/0x350
> >         ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe]
> >         ixgbe_init_interrupt_scheme+0x1a6/0x730 [ixgbe]
> >         ixgbe_probe+0xc8e/0x10d0 [ixgbe]
> >         local_pci_probe+0x42/0x80
> >         work_for_cpu_fn+0x13/0x20
> >         process_one_work+0x1c5/0x390
> > 
> > which means in 'kmalloc-4k' slab, there are 126 requests of
> > 2240 bytes which got a 4KB space (wasting 1856 bytes each
> > and 233856 bytes in total). And when system starts some real
> > workload like multiple docker instances, there are more
> > severe waste.
> > 
> > [1]. https://lkml.org/lkml/2019/8/12/266
> > [2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/
> > 
> > [Thanks Hyeonggon for pointing out several bugs about sorting/format]
> > [Thanks Vlastimil for suggesting way to reduce memory usage of
> >  orig_size and keep it only for kmalloc objects]
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  include/linux/slab.h |  2 +
> >  mm/slub.c            | 94 +++++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 81 insertions(+), 15 deletions(-)
> 
> 
> Would you update Documentation/mm/slub.rst as well?
> (alloc_traces part)
 
Sure, will do.

> [...]
> 
> >   */
> >  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> >  	void *freelist;
> >  	struct slab *slab;
> > @@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  
> >  		if (s->flags & SLAB_STORE_USER)
> >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > +		set_orig_size(s, freelist, orig_size);
> >  
> >  		return freelist;
> >  	}
> > @@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  		 */
> >  		if (s->flags & SLAB_STORE_USER)
> >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > +		set_orig_size(s, freelist, orig_size);
> > +
> >  		return freelist;
> >  	}
> 
> 
> This patch is okay but with patch 4, init_object() initializes redzone/poison area
> using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
> Why not do it in init_object() in the first time?
> 
> Also, updating redzone/poison area after alloc_single_from_new_slab()
> (outside list_lock, after adding slab to list) will introduce races with validation.
> 
> So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.

Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
done in alloc_debug_processing() (through init_object()). When
rebasing to v4, I met the classical problem: how to pass 'orig_size'
parameter :)

In latest 'for-next' branch, one call path for alloc_debug_processing()
is
  ___slab_alloc
    get_partial
      get_any_partial
        get_partial_node
          alloc_debug_processing

Adding 'orig_size' paramter to all these function looks horrible, and
I couldn't figure out a good way and chosed to put those ops after
'set_track()'

Thanks,
Feng

> I can miss something, please kindly let me know if I did ;)
> 
> Anything else looks good to me.
> Thanks!
> 
> -- 
> Thanks,
> Hyeonggon
