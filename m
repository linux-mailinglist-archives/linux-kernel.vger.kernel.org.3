Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F05897BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiHDG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiHDG33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:29:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563A61B13
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659594568; x=1691130568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2B6nxZGTQr6Uuldl0yL5C2JI27hpu+ywE2/Ey+Tp8a8=;
  b=NtRsof72Y1LXDVZkukIiwZo+Cvo2gUKzNIz/qcflHzcjCfqOXec7i0vU
   Lg2vZToP8LEKrb9QFJmmrobtmOQ6zRUxvOP+fe4tk9lnWbx+BpL9uRr2b
   IIMudILbl7Atu4Imrw2Sb2BlxfxchdVwaoIPt3YZmd3FzDFthVkGl1kED
   GDMKS68TmqEn6aP7C4Y37WTSgicTruld76yGGcjmwyxev/dHWM/6rz8Dt
   FGiwuk4UeOIQKKr+kM/zt1LYgW4Mb2PxL7nupvFqDB52k78WiEON9qjcb
   Ih6lforpRA7yVmXQuWxLIJImks6B631qOadGX6+YEO3NTrwEMZxdZxTBD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351564935"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="351564935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 23:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="553603181"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 23:29:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 23:29:18 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 23:29:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 23:29:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 23:29:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nybAydER/wbQKXvkc/lWdfoP41WkM+tUYtJ9pYFJScICUQFlkT6EbnQ1KkWOxMttpAi9DEPtrwL9gD+M+sK8gOi8znyzCIutC9AguljmA74JA1uVsx0ieO3CcLAVwHiVEQAL/4xIDNRxfUabzrChrwwIbdud/7qKVTA+UhNSwnINDeJZAo9GWLVaKNuLec8FzYqX72ZrDacbrKSlxc3wMRdO1TPwDXCzBhtdco1lZSMuj+VQbXTX6DhMtDmq6a+O6WPix3gVhgFmTAfV81Qt1dicaUzVlboNG4dOU28Nkb+QPJu05Xs6fCMI5xomxCaS+rw6kfUrt9mGZYVYI9gg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb5w9W3RCq2YbRFDDXL2weQrrU3mvYyGZi/tnrK+9+E=;
 b=nelCsaJjLrJk/fIjSrnkquD9qT5C+ITHXf2WbNmE7JzmCOzQvApyVLD+Glr+TMIRB0upy2fP1XSRx3dH+Lt/a2RjxlXic2tPcbxtc/eQP8S6Ijg7HoEDBjhfgJ3mR1vtqgBtAu643MmFyw1SdgpRoXkFAHJLS7t9mOJJ1UpNDSFr8LLaFXsG1nwMMDoe7PcohZLzjyXhS/bhFHu/HPZy5+MGdLAm3btg5tvX//4pefIqutS1BfLOezHxHDOIvc0R4yfTzPHqto4rpe01kna/RG9CPxANFpDxIaAKSeJWAXZ4ieZtTTCG5QFp+gqZmiYxQ2SWQyckCFs/h+VPusmSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 06:29:16 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Thu, 4 Aug 2022
 06:29:16 +0000
Date:   Thu, 4 Aug 2022 14:28:24 +0800
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
Message-ID: <YutnCD5dPie/yoIk@feng-clx>
References: <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl>
 <Yudw5ge/lJ26Hksk@feng-skl>
 <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
 <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
 <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
 <YukoZEm4Q6CSEKKj@feng-skl>
 <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38f40df-ffef-41d2-ee71-08da75e2a75a
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6202:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCaeifSWGsGtw6V32zVIhVlccwR/De88HNNVR8hGTy7Hr9NsAK+zzmiHL9lPJhQiR+GdHvMrKJHrAoIh5MaDjmvUkbb8VenMuv2W2Y4ZhoqMXC6qZ5YAqzOcEwwAmSbuxupuFR4CGkYWqUpclRarb5qfFC6gRAS9H02PJjOP/5+nPkxj6tCSnMpd9s88aGasWqk26pJB3EJZIqcRnrt65zpncXdKImsg7RC/raS46S8C/UP+jeAe8/A5l4B6nLHqdo7xCe2aKIhBVD9ocx09r4T0qjxGRTjGOVzYxTTe31UrpKZDzm1Pqaul1iRR43Jmpwm6T3VKYRfpINXTVwtcSR99rrmC4BB32TObFipMBU2Q02zNC37n062HJqzIqE9/GHLCrvDaZBHzv+bl+pZl+Brag8NMAqtWHN2V+aHAKplszQdGhZbSvx2pH5vnJm1PFdlikIY+X/PSMKZ48crSW1hLnw939W09MXSCynYOyofVJtXirXO+uY/RJB+zymbMDXdIo19gKvBniH5BpC5L4e73M+T//Qpyg1DJOa5WptjBPgbd2/l+sHzJF7BI+uv1x0e5yH9plC04avBPaKG1U/GGC3cAcUfSyYY42JN8C++KAUSkWUK3p9xAzgI9mgdq8zwqY4b8NlhK66Scrd4qm2gkieC5TG8zX2iEmQflKD5sUFBVRos6zNpzifMBbKnKGKtUKeguWhrVQ9kDjNLWGUd8bEHx87KhjvJMKRQkv9HOuAFT23lk+wC8vr4Q42wJ26uCJ+8uBanLAEh5CVCw9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(6506007)(53546011)(86362001)(2906002)(41300700001)(9686003)(26005)(6512007)(6666004)(186003)(33716001)(83380400001)(82960400001)(38100700002)(5660300002)(478600001)(6486002)(66946007)(8676002)(6916009)(8936002)(7416002)(4326008)(66556008)(54906003)(66476007)(966005)(44832011)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSkyhPp6i64UvUVbXSfe+lKlnAEkxKs2bCdtMczwd3fsG8sXPyOguPkz03Mp?=
 =?us-ascii?Q?LtCtV99//JTFxztE67GOP1WOppAR4dKftvDySHyXZGxk+EVhfQ1ErKpM4/LV?=
 =?us-ascii?Q?Y2khyMkJCMqD5wRMsNYO3kfmdCSLVjIfogftVJLZUag6sI8kPMMsND8SRI5Y?=
 =?us-ascii?Q?JHDbx8UyCd1RsXq+xD+nkrhm4l4HMwpsNO02/CqpagznbNZOFuFanutJxG85?=
 =?us-ascii?Q?0MS3ksOYf3kZTMt5jAGeSkz2OHbckd8q4tiW4xwhB+4R8/d4LTjnWTEE+LLr?=
 =?us-ascii?Q?n2nwaxqFW4HNJHnU+qiV7jsyy2cqQa+pPtC+U/CWX+wMEQ7hhnpzgB0falCf?=
 =?us-ascii?Q?09JALVh1HdZwy9Hlz2lZBI+5xKd1RRgnLQlAlcL167P5X/a3yIUIOyUw8/8T?=
 =?us-ascii?Q?gUXhgyMI69vFnSsF6zI9yfP/s3/l2gSJjQpaYfr//EyzUSkn5nuZnCvee0xm?=
 =?us-ascii?Q?TsHkra6OPy50+Wp+nJ+7TJzck5DbVctGCfUMwvTcI+qzpHQIj1sCH7x2n1zd?=
 =?us-ascii?Q?CjlZwQ7AobccQozb4FkLkRaNGmIcWd93X6sQp+XvFGZByugJn7UIJCcfmr8E?=
 =?us-ascii?Q?agcKCgc1LXCIV/JXw8L51UPq0/2FKC33qP32PY9L4B8p4hw2myBfRtr7Dk5H?=
 =?us-ascii?Q?z+g/wtoNf6RoljqsnVd32gM+Nxx3ExI3vyEdGlbMWiXRNO4c01EwwucNamkO?=
 =?us-ascii?Q?7FjpS0DZqr699sThAXdUthww8TSmdMesjQ9NOm6n3llDjVYSOMZUxJu6/U/J?=
 =?us-ascii?Q?ELIXCKXtZ2rKWSZK75+S7rm0urbF0syf33WIQJ2fO2053p2onjKvZXVdKQuT?=
 =?us-ascii?Q?5e7G1pXxn//b9sVGlKosuycgrZ8LAfu9mTUYC8B9WVhYpUmsC0AWFICZgZxT?=
 =?us-ascii?Q?1u9LmZQkstZ3kGDv7AkKpmntObX+n7hHv6WrC01QC82pnXqbQx8uONvcElBf?=
 =?us-ascii?Q?DB5BNoCDs8Ks7Ed+EQSjvkgf+pPyNJRjPDLpLCiO/eF2yTjxRqXeV8A4JwwA?=
 =?us-ascii?Q?vkKNloym8F1eyfMR/zW0C0o7t2TOS/liZwKegtaVctoMud3bXn/k+0rbjzxU?=
 =?us-ascii?Q?OjiZ4AoMxHY+/fb8WoVzA3hxhp7IuFYWBDvDWS/zD84QAF9vpMjRPQHg/Rht?=
 =?us-ascii?Q?raFvQ2ul5iMbiiT0ONADPbI7TjTII66KYFXKDFj/6C0qEfeMZUqygLE2IfHw?=
 =?us-ascii?Q?zlCIM1iFhOeEAIU6J11PH8DHo87B56mNjMB0DsTyi2lQ2ElRRD2fNfHmHYoM?=
 =?us-ascii?Q?ygPdEWqiT04znM0ViGWgfXuEsTd+lvf0jNQQ6ldZaI98SbrxkyDqUXpdlK/q?=
 =?us-ascii?Q?9nyo+pJws4nULYO0eCsBkeP6tkFPNs5Y6BW3h/PUMrVA61pqwFOwLsd55MZ1?=
 =?us-ascii?Q?8fp9utciBTa6mdzWSh/l9slJsFXP1B596vM/KcjqXvQeeMSNUr89P+ta4rUF?=
 =?us-ascii?Q?9pJEXdqLodGy7geijMddXdXz3yuinxCO+JE1izWjGXS9dYHAXDyNV8pqwdFz?=
 =?us-ascii?Q?5n3lmVIIymJk/h9NxMk1R+gB+n1njswu/6K+wz8tCFTsHiB58w9Muk7wAAED?=
 =?us-ascii?Q?PA9b9880CSNRRQc3089voLFWtJRY1ZdmSsvVmpq/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b38f40df-ffef-41d2-ee71-08da75e2a75a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 06:29:16.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEJlNtZsMEGam5srxCPqe+kk7Ya/3hK/d8jltnC1rj1azwqKF1uWsRa7HN9dMiC17CjuJWx9KAjbKGKJCBuu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:38:59PM +0800, Dmitry Vyukov wrote:
> On Tue, 2 Aug 2022 at 15:37, Feng Tang <feng.tang@intel.com> wrote:
> >
> > On Tue, Aug 02, 2022 at 06:30:44PM +0800, Dmitry Vyukov wrote:
> > > .On Tue, 2 Aug 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
> > > >
> > > > On 8/2/22 09:06, Dmitry Vyukov wrote:
> > > > > On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
> > > > >>
> > > > >> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > > > >> > On 8/1/22 08:21, Feng Tang wrote:
> > > > >> [snip]
> > > > >> > > Cc kansan  mail list.
> > > > >> > >
> > > > >> > > This is really related with KASAN debug, that in free path, some
> > > > >> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > > > >> > > kasan to save free meta info.
> > > > >> > >
> > > > >> > > The callstack is:
> > > > >> > >
> > > > >> > >   kfree
> > > > >> > >     slab_free
> > > > >> > >       slab_free_freelist_hook
> > > > >> > >           slab_free_hook
> > > > >> > >             __kasan_slab_free
> > > > >> > >               ____kasan_slab_free
> > > > >> > >                 kasan_set_free_info
> > > > >> > >                   kasan_set_track
> > > > >> > >
> > > > >> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > > > >> > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > > > >> > > of the slabs will reserve space for alloc_track, and reuse the
> > > > >> > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > > > >> > > large, that it will occupy the whole 'kmalloc-16's object area,
> > > > >> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > > > >> > > error is triggered.
> > > > >> > >
> > > > >> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > > > >> > > conflict with kmalloc-redzone which stay in the latter part of
> > > > >> > > kmalloc area.
> > > > >> > >
> > > > >> > > So the solution I can think of is:
> > > > >> > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > > > >> > > * skip kmalloc-redzone if kasan is enabled, or
> > > > >> > > * let kasan reserve the free meta (16 bytes) outside of object
> > > > >> > >   just like for alloc meta
> > > > >> >
> > > > >> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > > > >> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > > > >> > __ksize() does.
> > > > >>
> > > > >> How about the following patch:
> > > > >>
> > > > >> ---
> > > > >> diff --git a/mm/slub.c b/mm/slub.c
> > > > >> index added2653bb0..33bbac2afaef 100644
> > > > >> --- a/mm/slub.c
> > > > >> +++ b/mm/slub.c
> > > > >> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> > > > >>         if (!slub_debug_orig_size(s))
> > > > >>                 return;
> > > > >>
> > > > >> +#ifdef CONFIG_KASAN
> > > > >> +       /*
> > > > >> +        * When kasan is enabled, it could save its free meta data in the
> > > > >> +        * start part of object area, so skip the kmalloc redzone check
> > > > >> +        * for small kmalloc slabs to avoid the data conflict.
> > > > >> +        */
> > > > >> +       if (s->object_size <= 32)
> > > > >> +               orig_size = s->object_size;
> > > > >> +#endif
> > > > >> +
> > > > >>         p += get_info_end(s);
> > > > >>         p += sizeof(struct track) * 2;
> > > > >>
> > > > >> I extend the size to 32 for potential's kasan meta data size increase.
> > > > >> This is tested locally, if people are OK with it, I can ask for 0Day's
> > > > >> help to verify this.
> > > >
> > > > Is there maybe some KASAN macro we can use instead of hardcoding 32?
> > >
> > > kasan_free_meta is placed in the object data after freeing, so it can
> > > be sizeof(kasan_free_meta)
> >
> > 'kasan_free_meta' is defined in mm/kasan/kasan.h, to use it we need to
> > include "../kasan/kasan.h" in slub.c, or move its definition to
> > "include/linux/kasan.h"
> >
> > Another idea is to save the info in kasan_info, like:
> >
> > ---
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index b092277bf48d..97e899948d0b 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -100,6 +100,7 @@ static inline bool kasan_has_integrated_init(void)
> >  struct kasan_cache {
> >         int alloc_meta_offset;
> >         int free_meta_offset;
> > +       int free_meta_size;
> 
> Storing it here looks fine to me.
> But I would name it based on the meaning for external users (i.e. that
> many bytes are occupied by kasan in freed objects). For some caches
> KASAN does not store anything in freed objects at all.

OK, please review the below patch, thanks!

- Feng

---8<---
From c4fc739ea4d5222f0aba4b42b59668d64a010082 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Thu, 4 Aug 2022 13:25:35 +0800
Subject: [PATCH] mm: kasan: Add free_meta size info in struct kasan_cache

When kasan is enabled for slab/slub, it may save kasan' free_meta
data in the former part of slab object data area in slab object
free path, which works fine.

There is ongoing effort to extend slub's debug function which will
redzone the latter part of kmalloc object area, and when both of
the debug are enabled, there is possible conflict, especially when
the kmalloc object has small size, as caught by 0Day bot [1]

For better information for slab/slub, add free_meta's data size
info 'kasan_cache', so that its users can take right action to
avoid data conflict.

[1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/kasan.h | 2 ++
 mm/kasan/common.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b092277bf48d..293bdaa0ba09 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
 struct kasan_cache {
 	int alloc_meta_offset;
 	int free_meta_offset;
+	/* size of free_meta data saved in object's data area */
+	int free_meta_size_in_object;
 	bool is_kmalloc;
 };
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 78be2beb7453..a627efa267d1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
 			*size = ok_size;
 		}
+	} else {
+		cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
 	}
 
 	/* Calculate size with optimal redzone. */
-- 
2.27.0

