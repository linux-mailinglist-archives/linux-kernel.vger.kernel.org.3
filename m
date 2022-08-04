Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5F589BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiHDMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiHDMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:23:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0043E44
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659615812; x=1691151812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ix6wlf3bFH+B6ZznsBcAdNgiOUOzj3b0e5KSY4J8dzM=;
  b=ArF9nnMn0W0k0PdwU3hDmMcp89qCIjgiIQooT0gvos8//zdsDVVDFqyq
   17Tub9Ju1QQvgffTjZtZI50MpT1w2yO6Bf2w7PyYKQ2HYgyvqzuOAdyti
   Xt28x+5Ip2vznDtgixM0CNvX4nF3GsDmfTIe4gxJ/nxUc2PiCWoRye8A6
   2EqozGlMrTaCVR7tTY7LFQ6C1b99DNOsvIFrb4yXPTC2tyqsIPh8BGYeJ
   qJuqHVoIICu+rGh+OsgEzFyOv3SI2sv47ThHs30Mq6Vt1TxrFdyfWtYxs
   kWQrlfxyDcEoKIs2rnmOEunsu9DGt1zeSTgzS+C+50H1vLCbIPItj7ouY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="353917153"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="353917153"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 05:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="706173909"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2022 05:23:31 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 05:23:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 05:23:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 05:23:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 05:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/Bvc6klqa9lNfZ4P8MU2JEAMyipMYiqPo/qazZAuyHXR1nAQWqxwURUuzoG9TZKaVZwPMuTvapEDpyJqG/xOMJGSLqwW2H+uh0GhqITFPckxARG0jFPV5yJ300BM7vpgV8VKeTGvtgxioRQeVvAuhae7EjWXdlRyZHtuRVtzof69khIwYmE0Wetxe7b+uVC2pb2n3oM2ubPIZ9l3KXwqOcZqxAzNPeM96z6BIGuq4Mg3PKcSTWPvzpL7hp7F+3JSEYCrlWXwvEQEaEsi1Jd/MuGJd+KD+nRTfXJowjPZ/MpCmLmwQmSZ57mgAfvRPHK8Wb66NiXoRDZuYfZleNnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FNHmsx9DXQYkm1eIAYOST2Qndo4Byj2ubg8Xb/M1VA=;
 b=JJR4XfPxbihZNK8nxYwxrHxNjtGCAuEXxauMRnznQzvicuy9+88eCBU8BDJC4KTlkqLXrowJwFj647xkcYCzhfnBWqXDJX1YP8ashEEKojWyVbtXp8bD5PFx3BEk42nxAoDUnQCbqX1jzJqqUcFehttxEfgYZO+985115Q0N0GkbStCWv3XSYmokMmqeDBN+LDe5ly77OtpCCggQDkuD8dbB58SjyVXDQ46OyfxvrH/Q5f7P0uUa0xGIDcvUPwnYynLpr2Bfagum5Lju2MghHv3LCU333v5Z2jL44RTFGsW7wiQ9mUMb6QGiuA9ZZECvIicgWqGGJb3YRqMI8KL+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6042.namprd11.prod.outlook.com (2603:10b6:8:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 12:23:23 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Thu, 4 Aug 2022
 12:23:23 +0000
Date:   Thu, 4 Aug 2022 20:22:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>, lkp <lkp@intel.com>,
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
Message-ID: <Yuu6B0vUuXvtEG8b@feng-clx>
References: <Yudw5ge/lJ26Hksk@feng-skl>
 <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
 <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
 <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
 <YukoZEm4Q6CSEKKj@feng-skl>
 <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
 <YutnCD5dPie/yoIk@feng-clx>
 <CACT4Y+Zzzj7+LwUwyMoBketXFBHRksnx148B1aLATZ48AU9o3w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zzzj7+LwUwyMoBketXFBHRksnx148B1aLATZ48AU9o3w@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16a4faa3-41a5-4e1c-77c5-08da76141ff0
X-MS-TrafficTypeDiagnostic: DM4PR11MB6042:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaE8au5+Z5Sc0nZUvcLiDwMQ9+boXPpdYM4mAKlfjjO7ucPCvIITkPMDz0o5LXompybW4rzaQcGIV91NmNfQS5Uo1Fko81gf1q3oCF8djuOjwlZzfFEGRXTkHJ6/UZDhqDBVlvuxdcO/5ySfOouTG7cEYxlC1P08Su3sKsLUqhrAoycjDo5WRruZJp97/T/9FC9ULuZScfaLiKaQ8o3EwvzBAsKPJ20JLv+/cy2oYijboiO09QMAYVz3DeJhP3jVLlYjFlgKUBVAmKdnBhumjUIgxSl+bLHJzIA1bCbQDU2UPFPk86vtq2lRQh/BWvO5Fw7zcVcg+ow8Bpf4Bho0IgJXkynlnUJvvqMrOTlFXHxahxITn5ljgWmRqGBlC1cFItewnZhM/Nhyt4vN9FBtvQPHMUTPn0rglAXPvHAv9bKMsOqxMj/1WlUzxgrI7MiRHpZaEVrjhSwl9XWeyOpuy1TSkeUUdXXA2umo1l4vQF9WrWy35/n9w5rSWX6cD3sNM74xFzW8iP5b7vvXS5j5ORZl5gLwSHqu8wLUjh4JptcGQ+JHG11MCZdTbbxOe7nXKSDqJaqnByeimEDdl6bxgLTJ3YE9TeXHeL7vS6r2QHINOQ+m6dD1vP8foLVw/sBPdmYgh3t8l+SwhOwJICAttudYSVaUYvCmz7ioA5OM9ZP8TyWlEIlaWdIwCj5uRrQ4XpAOXnDXxBf0HMl60FcCcZPJv9ZzDRmea+YRnTDEUS7pKRoBXxlo6WA1rAXN6Jg6kvwtAduxpc1LPXfiexmizA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(5660300002)(82960400001)(7416002)(44832011)(8936002)(86362001)(2906002)(478600001)(6486002)(966005)(38100700002)(6506007)(33716001)(53546011)(41300700001)(6666004)(316002)(6916009)(54906003)(66476007)(8676002)(66946007)(4326008)(6512007)(26005)(9686003)(66556008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yv2sXUp5tC9H8TZtP1gvDIG+CdU3Eb3mAWa/LBF2S9GgvFw0E74fTDQBskwM?=
 =?us-ascii?Q?qxZAc1XXt5wAojMzRyo79X/+VLEEPrkZON+SSCMFgWHWTseG8tU3y2zFytRM?=
 =?us-ascii?Q?/ofeUZ8MdRzA6IDl/UeUbZIh+b74CM33XIJvaHNz+fjvcgb/E1/NLdq3aDFf?=
 =?us-ascii?Q?D6SY7oSpWFGPSYz/YHyKq57sgiuOcc0LBxOv637Xxk+rIYCjEb9yegG45K19?=
 =?us-ascii?Q?/g0iO4FaaqW9GOnK2Rp4PfEFYS+SHHnkitBAjHT0vJzIIKbrnVS8umCsKzir?=
 =?us-ascii?Q?cL6fsy0UuJqGhsnVZ3v35Y4bab8quzcf5CJXONxGUfdHdXp7ttmjCxa1/xIu?=
 =?us-ascii?Q?zN53phQVjHZPg0ZeuRenuFzZeYn0ljNKpybfEXJZ/aDN44+0RMrD3ZL92sv6?=
 =?us-ascii?Q?zB8BWVAdO0KA6kT+eomv+usZ0bwKnSvVx3dqNt0csEPJKmVpC6+R836HvDl8?=
 =?us-ascii?Q?l5jTw0XoFed1Bz6ia1CVYdVmrhGTNyI/yrkBx1a+KE+ebvMXjlmI+1F8fxKo?=
 =?us-ascii?Q?9t2crs+xl2tgCGKL2mx7ZxFS+MZCV1phPO/eOtHgFgVKzx9VkZukHUpwT4X9?=
 =?us-ascii?Q?/cm46nf4bfwiNIjeoOhVE4Hn9WKRTOCzUWtv4LNmyv3wvZwz7etynhqDFbN/?=
 =?us-ascii?Q?eH0qU/Btpgqgqp8GXs3Cfhe7mw18WbJI+vDLABGGLl73bhoM+30VFfO5+c50?=
 =?us-ascii?Q?1EhGVl1JRAcmXSnpqPQd4gwF2zscraHsM57uQ5ZRVG1I2QUv+j4kKqH2Bpoi?=
 =?us-ascii?Q?NHsQpoVIV9TzIKprbVksRBz0VDvreuJA3jt29fgU5P8FHw0pdq+iFRpjM1pG?=
 =?us-ascii?Q?GHng1EhiRVjxCD5fNXAaMfBIOuuSoAzd+Jh7fJgx3iCvbPZLMTKrZqKVCtXj?=
 =?us-ascii?Q?oGcmJtIXP0/TZtS3ht1/r6DqzC1qEvlTGCHtrZcJy26qjYXXUG1bIwK6bq5Z?=
 =?us-ascii?Q?PUUFeR2gEKfGul5oSZDWvggfqrRcnaj6zPPaesLZYkjccWA7avStDVjJ+yZB?=
 =?us-ascii?Q?vnDjL184G5j54bw6Xqo1MXGx3CitPMXIvbRan1OUZ7KEqwrDOn1LaMiSxfPN?=
 =?us-ascii?Q?emVpZ9SAoFwyiAAi6eqjLgAQY3oky47F86R2xXeyYpim38caONvt/xxj8CGj?=
 =?us-ascii?Q?3+O4zFL/fTFZNs9tDUdlfrdSiChQyGd4+kvaSLiX2HEJgYgakAAs61RQgD7k?=
 =?us-ascii?Q?Hj5jPhxxc/NFBQ/2U5/Om0us+AkwwK4Ua3gz3ngo1skmKEM9ZpE5JZl1AcUL?=
 =?us-ascii?Q?FS6NLIP1a58OqSPKF7n35VOxOcSG84RRRvUB9CXuN/W93DF1n+B5IksvmehN?=
 =?us-ascii?Q?lC6y5lLbh8zBh3IRzxp3QUZJy56GVXLuNAWe6av+zsCeV3CMIzeSu28yh4YO?=
 =?us-ascii?Q?usiDUJaGSZJTAlda+Zci7VxKm3V9Po2YuZwD3EW5f5UQXL/AJqULgqYY+ALL?=
 =?us-ascii?Q?eafuoXdsL0CInvWVNs5dB+sbucdiiKXXdCxmF2aCGv1Rp9ej2zmyaUMprKi4?=
 =?us-ascii?Q?ZUbn7P5aBBEug3cNWFRQM1sfZvmf2r5NkEXVT02iHwo0qCEy6U1Yji92dh/c?=
 =?us-ascii?Q?td1Tyr+CZ2cHhJXfu0x1VQO3ObwGAd3qJ6EMYkCQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a4faa3-41a5-4e1c-77c5-08da76141ff0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 12:23:23.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXpi1Rqb39/saqNQeFDkN56gvvFtVHJNCqpgthmn+qvx+MUz+aktcVXKpx3qjnFdwSaLRUpXII5Mbf0mwZwiNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 06:47:58PM +0800, Dmitry Vyukov wrote:
>  On Thu, 4 Aug 2022 at 08:29, Feng Tang <feng.tang@intel.com> wrote:
[...]
> >
> > ---8<---
> > From c4fc739ea4d5222f0aba4b42b59668d64a010082 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Thu, 4 Aug 2022 13:25:35 +0800
> > Subject: [PATCH] mm: kasan: Add free_meta size info in struct kasan_cache
> >
> > When kasan is enabled for slab/slub, it may save kasan' free_meta
> > data in the former part of slab object data area in slab object
> > free path, which works fine.
> >
> > There is ongoing effort to extend slub's debug function which will
> > redzone the latter part of kmalloc object area, and when both of
> > the debug are enabled, there is possible conflict, especially when
> > the kmalloc object has small size, as caught by 0Day bot [1]
> >
> > For better information for slab/slub, add free_meta's data size
> > info 'kasan_cache', so that its users can take right action to
> > avoid data conflict.
> >
> > [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
 
Thanks for your suggestion and review!

> I assume there will be a second patch that uses
> free_meta_size_in_object  in slub debug code.
 
Yes, it will be called in the slub kmalloc object redzone debug code.

Thanks,
Feng

> > ---
> >  include/linux/kasan.h | 2 ++
> >  mm/kasan/common.c     | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index b092277bf48d..293bdaa0ba09 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
> >  struct kasan_cache {
> >         int alloc_meta_offset;
> >         int free_meta_offset;
> > +       /* size of free_meta data saved in object's data area */
> > +       int free_meta_size_in_object;
> >         bool is_kmalloc;
> >  };
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 78be2beb7453..a627efa267d1 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >                         cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
> >                         *size = ok_size;
> >                 }
> > +       } else {
> > +               cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
> >         }
> >
> >         /* Calculate size with optimal redzone. */
> > --
> > 2.27.0
> 
