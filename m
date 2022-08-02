Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF102587D41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiHBNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbiHBNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:37:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC021274
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659447436; x=1690983436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v5CU1kdJcITfGO6FMTEldlKNp0iRYNhg2+qxP0VBjKY=;
  b=baIu1403r7vJMcsVeOgjuLZwEOyGMI3o8OPxQ8ukolDrKpRfbu7NEZKF
   yNRAg0/wudwBVh3IEXyVbr8Nhp2OUbtyd4jrQHOwWuoJgmlqPZIuKl5j2
   Elk1nq3mx8VMXhAnE8ozfJtAfkOzKdSClmIcRbqJOsj6RXADF0YMCgyfu
   6MnApPiv4gnr/dcMge8B9/hin3yctjZbJZ9V5ulN3cgQhrjqJKOdM+Ev6
   OSYicoIFyhhrwwAnF8N8uKL3IEZNhWencwh3ZgwAh1xL1EbLOtaCAF1oK
   RcI5BBp+AWmHMz4lScWz2qFJz+GAYIT7LreyD01W8fxcfEAiUzHbrLZfW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272454370"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="272454370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 06:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="661626031"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2022 06:37:14 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 06:37:14 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 06:37:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 06:37:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 06:37:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR5IGlWduA8WPLYR1N7km/OuebVA2bnpozK7iRb1OJs02++qdOwSqmlbQAhkZlBUIAe8FA+lFW4asu6LjE00vMAhFqnks8AlokYVxsOnGDFHdk7+w6U0Usgy6g4U1RqpB2PODRa6R3w8ZIcnHXZNe/aHzK1VDfGY0SiIO4ILyHaPfrYJwya4+nOi23afHY1WwjYqvVhk+RX9lnRmyzB3wfkcREb9aIa5QAhFqYD/OUC8RUsQqZq9dXFKqG0Xg3jlxU/kevkME5BDC1/vBzurKIYhZgg4IbGyNriYtR60IocFbCXt2YwD1/M9yxeCWP9hrDuuhjGObhG9PfX8a2ZJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nvIwKZ1Hik+X+sSu/tUZmvnLz252t1ZKQDPz/OLOAQ=;
 b=AoWMB5NjvwCgfIRz6BguPhhGw5rfREOWtXkOmYAXkcABssGIgP3JVno+E7kNqrMrEdK74Fxu6I/y7ULPEjpjhthatXwOFaDDCMikL3XbEitO4WzG8RokCD4iRpICjtUCmntKHcLhIzrt750C8B/4eZSKLgnytv1XXlOlnM5hYZrWPqARId1HozYQvFWFyvyK2MhlwHEi8yYU7Acvlej0aAV4R1Pz9nBhaiuiB7SfW7nfCdKUCivzc+w84F+KFai3pfaaFU6nMEzNtPAIbVyjKM5a3AhKP4azQ5NqGOExOBkN3rG7VKXOgK06ZIvB86weF6hXT+PyYHuUIg8+9pWKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 13:37:10 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 13:37:10 +0000
Date:   Tue, 2 Aug 2022 21:36:36 +0800
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
Message-ID: <YukoZEm4Q6CSEKKj@feng-skl>
References: <20220727071042.8796-4-feng.tang@intel.com>
 <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl>
 <Yudw5ge/lJ26Hksk@feng-skl>
 <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
 <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
 <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d695832-4efe-4533-d452-08da748c19dc
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6156:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04DN5C4mz9YmAjKa7Y0kDIHQWji8n/XZO7B9dzzKsV6WLyXVyVjgsbsCOM3sdYEHfg9+oDflbK9iRvmpm1qovQa5NZU56aOrH2c82OpHyHEPAoYjPfMhUnxjOQZWWDdcdTm0k8eQqZiS3PnfKb5+SQG1G9p8CNyvTlQLsXkvyVoRFjRDL7dyNe+5EAGClMVoa6ywf6VMzK3WtDRfaaQfQ5w2QIMFEjvZgxO24UHsfS4QWj1BPJMk11Lp2Tzbw54EQWYkalkBlvaCZGLZLq4J9Y4kovRTbnzrfMcqyveP8m/vZhrw6r/AGJpPg97N+YR9xPZm2SymUXNIffOH/uhw85wKWOf0BTrFU6nRPQzGsLLeijB2FaTnIPJTLstaHRSF18zzaH+ANtmyBiVJycOZY1U+AxkJenXLusgHumcDC0dvuNMbsJvbigjYlUZKAh63Oo2qMngARqTEhNklJHa3UpMOJxULWz6zduSF5rmADXT8ZqklrvO3IZLzV7S/UGo3pug/1P1BwDEeNzd6P1pu63aad1Q8J/ra2fkMz7GT4X2unWIpL5Ah59VROs2VqNC9jrFJ/LWzJ5+/25pRBrJogUlRE2bVwLJgSul53n0Zlf9eSh+sSvD+2/5OOJkuAiRLtJzNocx33oxQFoQJ6zPMMFlSOQWfF8kzkr+BDytjUXhiQ2T1+eM0KO5h+rg8FuOV31Z7J7FwSUl48Qb54z1aAbVLwzg8n/pkJjjYnN4sOHCvtHJma+a6s1qiDlsf0eaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(83380400001)(8676002)(4326008)(8936002)(5660300002)(86362001)(7416002)(2906002)(33716001)(186003)(66946007)(316002)(6916009)(54906003)(53546011)(6486002)(38100700002)(44832011)(66556008)(478600001)(66476007)(41300700001)(6512007)(26005)(9686003)(6666004)(6506007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLZf2CfAdlHSOJsnVhJLsLO8v7wqmAT3Zk8EyDs2yV+Kf4Y2pOwbhrYgMiw1?=
 =?us-ascii?Q?ty4zOXj/Chifmmtb0714BSN+zw26Vnh53UcoGLQZKQJrKZ+at6L932pBlNlI?=
 =?us-ascii?Q?OyyDNP5MoylYZXg8HjpYopmy3S+KUooPLUGQD7xORyPUiQwFPrevd0fe/Aub?=
 =?us-ascii?Q?r7SMCo9vzCTN2R1inuy3W228Y42r/mkmYAuokl5WCh8P/hGMREGDH/+7ww3h?=
 =?us-ascii?Q?0xm6MOHIIij/nnu7mjmLuVqucoTn2PL99CAjnrltid56AyqiTELJc8LPQpZr?=
 =?us-ascii?Q?LpXhe2EV1yv0tnAbzOvnDp532st3vZHrzsDIjow5Zcmz97KBZNTM4xzHUSBu?=
 =?us-ascii?Q?sOvWTkE2aXVWfPcpYWlc2LNOYkUJDoFlCcmMjHKiiFs2RwE/jGNfqcZXMLsn?=
 =?us-ascii?Q?NpvVCP7roJFqD+PfhOO5uoqh3cbjLs4b6xIMac+Sl+YoZL3c2Y9T219jhHFk?=
 =?us-ascii?Q?ZMr4X6YNFu5EjvaS0abtBUSCbRPrORBuj8tGrZrMPvrCVAkJpHtgLRhE1Rtk?=
 =?us-ascii?Q?rWHdY+s6whqc5rVVLiX3gTZinj9gFew2vqi+AGFojcuYtOKTeTf7Fsi9G9C7?=
 =?us-ascii?Q?7lSB2Cp5CmxZpcjnSmOaNUt30Xoa+wGiLJCSy8q/q/lNXFzTgE+uQGdr2jiX?=
 =?us-ascii?Q?iKAkyGbbBfftGFkYV96o0YNNXi7jjrdWHWEPfcRrj62jjDUEhsfh0hhfqotK?=
 =?us-ascii?Q?bKMRAm8Uz/wDFkjw6IFtrNCKt9Nwngt188Y/qPT/DZN0+tnaMlfxmseAiKka?=
 =?us-ascii?Q?yTpsR+6oZNOlFP9wdHZVE+F8bv2erGDi3TJlcupxVKsoTcJJCO5afQUAeTF1?=
 =?us-ascii?Q?l+0VW87U1gzvDJgPUThaSVe6RbbiYTGjkgLOc5RF0BA9Yydg4rgeOVP3vABd?=
 =?us-ascii?Q?mNmQ4PHcbXPUdVWgCQ6+3bKrbJ9mv/GIAo0JVh/xETKZTqFjnQ+WPELZv//A?=
 =?us-ascii?Q?up3w4TzzMY/h/PN5lo0qDW3g/16XUUTCuBPhfDHc+88ACgeT85elI+kCVGEC?=
 =?us-ascii?Q?+30XMymzDDb7WopMTIVL6riyjgkmNqFOlnwMzAAB24jAkoAh8PmKY2fD11f8?=
 =?us-ascii?Q?PI6YIgXOAVtSLaDeUZ3g6nrAOIgpbUIwdlnw1wluoEv07F1RWyD0HK/sZT+f?=
 =?us-ascii?Q?b0V4RkiXBgXaC46GOwWtYVEUb3Z2CjWwOInG2jxoglXXNEaOTKcq+SZ/MOIo?=
 =?us-ascii?Q?5LZnHiQb96NnHzONCRyghDW2m+PUqLrEVfEyPmKoeIR2g+rJjXVcGmUGqfGt?=
 =?us-ascii?Q?+9GSFCdog44q3FHUoXAS9PDWA/KufooaQ7LzfX0CxUEN6QJ8M3xCXtsBfFH4?=
 =?us-ascii?Q?8dZtMN/Xk0L017QC/5kHhl3cruI15911A65QKw2Q+SvtxZ9z5jKf05pVRv2f?=
 =?us-ascii?Q?nrd8fPFt56cr4B1XAH/z93B61uADauJVIvqIB8Kf1iUbKe3H9ZaF4CSlkIVg?=
 =?us-ascii?Q?NCM7SNVJzpW8rskGi0ErNrsHSMiIX/8nFdGwQTxrMztVYQJGVzk4hFpXyFRQ?=
 =?us-ascii?Q?nH3OTdjxGZ/U+2DkKTqcZlQGUrh9z0HqPj8W5/fLANQFbQeY2G81uA7Y2RuG?=
 =?us-ascii?Q?RP6RP+xrcnBas/skle7iHgikURvQu/tSXygVn/TS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d695832-4efe-4533-d452-08da748c19dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 13:37:10.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PbDXE+VhfmU8u3niPTf6lc+WBoWZhz58PZfQ63OP2wEAyyK4HjWqU2yaG/FqGnM2A4Kg05xsOd9JSexp9PJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:30:44PM +0800, Dmitry Vyukov wrote:
> .On Tue, 2 Aug 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 8/2/22 09:06, Dmitry Vyukov wrote:
> > > On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
> > >>
> > >> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > >> > On 8/1/22 08:21, Feng Tang wrote:
> > >> [snip]
> > >> > > Cc kansan  mail list.
> > >> > >
> > >> > > This is really related with KASAN debug, that in free path, some
> > >> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > >> > > kasan to save free meta info.
> > >> > >
> > >> > > The callstack is:
> > >> > >
> > >> > >   kfree
> > >> > >     slab_free
> > >> > >       slab_free_freelist_hook
> > >> > >           slab_free_hook
> > >> > >             __kasan_slab_free
> > >> > >               ____kasan_slab_free
> > >> > >                 kasan_set_free_info
> > >> > >                   kasan_set_track
> > >> > >
> > >> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > >> > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > >> > > of the slabs will reserve space for alloc_track, and reuse the
> > >> > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > >> > > large, that it will occupy the whole 'kmalloc-16's object area,
> > >> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > >> > > error is triggered.
> > >> > >
> > >> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > >> > > conflict with kmalloc-redzone which stay in the latter part of
> > >> > > kmalloc area.
> > >> > >
> > >> > > So the solution I can think of is:
> > >> > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > >> > > * skip kmalloc-redzone if kasan is enabled, or
> > >> > > * let kasan reserve the free meta (16 bytes) outside of object
> > >> > >   just like for alloc meta
> > >> >
> > >> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > >> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > >> > __ksize() does.
> > >>
> > >> How about the following patch:
> > >>
> > >> ---
> > >> diff --git a/mm/slub.c b/mm/slub.c
> > >> index added2653bb0..33bbac2afaef 100644
> > >> --- a/mm/slub.c
> > >> +++ b/mm/slub.c
> > >> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> > >>         if (!slub_debug_orig_size(s))
> > >>                 return;
> > >>
> > >> +#ifdef CONFIG_KASAN
> > >> +       /*
> > >> +        * When kasan is enabled, it could save its free meta data in the
> > >> +        * start part of object area, so skip the kmalloc redzone check
> > >> +        * for small kmalloc slabs to avoid the data conflict.
> > >> +        */
> > >> +       if (s->object_size <= 32)
> > >> +               orig_size = s->object_size;
> > >> +#endif
> > >> +
> > >>         p += get_info_end(s);
> > >>         p += sizeof(struct track) * 2;
> > >>
> > >> I extend the size to 32 for potential's kasan meta data size increase.
> > >> This is tested locally, if people are OK with it, I can ask for 0Day's
> > >> help to verify this.
> >
> > Is there maybe some KASAN macro we can use instead of hardcoding 32?
> 
> kasan_free_meta is placed in the object data after freeing, so it can
> be sizeof(kasan_free_meta)

'kasan_free_meta' is defined in mm/kasan/kasan.h, to use it we need to
include "../kasan/kasan.h" in slub.c, or move its definition to
"include/linux/kasan.h"

Another idea is to save the info in kasan_info, like:

---
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b092277bf48d..97e899948d0b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -100,6 +100,7 @@ static inline bool kasan_has_integrated_init(void)
 struct kasan_cache {
 	int alloc_meta_offset;
 	int free_meta_offset;
+	int free_meta_size;
 	bool is_kmalloc;
 };
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c40c0e7b3b5f..7bd82c5ec264 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -178,6 +178,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
+	cache->kasan_info.free_meta_size = sizeof(struct free_meta_offset);
+
 	/*
 	 * Add free meta into redzone when it's not possible to store
 	 * it in the object. This is the case when:

Thanks,
Feng
