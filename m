Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616C587946
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiHBIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHBIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:45:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C562ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659429930; x=1690965930;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X2NMFM94xaN12aZxsf2sus3bpYtXJ/KFWU1Hff70Nrw=;
  b=fNMpNGIK7McpHq/rbMpzsRb3eVi7aDWGdXCTBhkJB5TF2V+o8Q0+WYEL
   /FShfNZpB/4/x2x3h6fLRTqrY4vPf4HWIE5mg2GYLFTAZOLIPpmdIgqoR
   ANu6gqy3T+rCTqEhahMS87BM3PdMQbo3FdRowRx+EDtbob72yCsDoImI3
   TOiDJ71JfgCI8TQUXEDkT4CUUhuMb8m1nBdke6MMgYzvhUbkKRMlAbjyL
   SYIDC1lu/Dr9HAbsBL98ZVFpyt/X4e8/MqZAWVz/OHd6vUYsuIE4O78dP
   dIw/cPZV4CTqO0s0Y3bmEK+UsgkDxvWAte7kjhYwh17cbjmWI7aBCEQPi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288115696"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="288115696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="552843844"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 01:45:28 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 01:45:28 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 01:45:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 01:45:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 01:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhpoaDBArpGqrudpvwQ3y7+1ndtUjDO/GwlyMIMaHmteYvFq862VoyWwIT5ItUJ1ev+SIKSL8kFDkMkdurVdSj7AgdlZDjwV02sVzbC/EzfcGNALPD0TeWCFxJEme2C/ywUJwOH/y/+VZHk25Uo432xtXYTssDcAsrPgtB4eoaYSvwlC5U9YKQFNhx4oD/tEt5tVvFWiFKbEVkWM1DgqH7MDop6fLiqJDcsf5Kni3aiHVLiMHaSRFOmLeiXA2UxDfmw+betV0obWehQsxCb5swf0mSUxPXRY/gqwgZ/Q4UOzXhlg0/ryfznPrzA0/7HCZESiqU2+UYXaXxwnEQAtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRM0GOZWFdu4Kv2UGb7hhve1INcsi5d6FugtLSPaE9I=;
 b=cmIfsLB4xgNxRwdm30HI6gEH9pky7frFED0fPeaMWSOxphay0NUIg6A3JtP3lm0Qesj45Rz9E+j0Shdg9AinsD2t8zJ8+uen0Z4lyPuRk2Y6Nws6JuZAY16tLmyC/qJjEsAnd1p539bpo8PsBKM/qK8dOrSHf8erx1mtksE6XTnGRUpXAwyFsZXbJ+pQSULgp++HJQojJzEcJJZNEkDiyS0KgE3OjqRGus7brCED42FYZ0BApl1s5yPWndQqD0T0/798aDZ6eCN7CuM76SA2u4C3x0PoIhsvxr39dV6Q5Tqd6baLIR/O6Lmrc58trd90/KUbVxBFbr2lJ+k6XSo99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN6PR11MB1777.namprd11.prod.outlook.com (2603:10b6:404:101::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 08:45:20 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 08:45:19 +0000
Date:   Tue, 2 Aug 2022 16:44:31 +0800
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
Message-ID: <Yujj76AGNMXOQIsN@feng-skl>
References: <20220727071042.8796-4-feng.tang@intel.com>
 <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl>
 <Yudw5ge/lJ26Hksk@feng-skl>
 <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
 <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <YujWZzctbp1Bq25N@feng-skl>
 <CACT4Y+YEtmvR2KOW5P0VtbHatxdY7MT22hp9FrUOyjZiKR+BJw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+YEtmvR2KOW5P0VtbHatxdY7MT22hp9FrUOyjZiKR+BJw@mail.gmail.com>
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e62a59-7bc7-496b-024c-08da74635487
X-MS-TrafficTypeDiagnostic: BN6PR11MB1777:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0YrZS+d9UYGXivflYEHOYKS7zA2c4cvFYVIBRXcO2UKmSRIjlgK0VDXtUUwozYLraHvo0YNOEnQ9pKuFiaLehh/EdtDThbnKJGwWD60dsvr2OCB3Oc4Ck6PR6pn3mFOfevdibP77L6M4aWjZMpu2h1pN+sEq4WbFYG24vXpZvOK9o9iV72U3tRTYPgv3+RUwbYx+KsbpFMGgU7nU2NxVezHL16xqhSrytDKH0Qpo90wfQ6rTU9ileRkXzpCEw1DTy2peMaQ8Vd2hDwCKzjQgeU/Vf6OK2OvhJLl1PoczuTpfHCv/Gq/mOLnC3VWUdvzNIFJB6El4j+ovFQVko35ayuHLiIvTpUiAMmfwMfQTw+iKfdPGqmJRoJmT0MRqTcYEfoGPtVm3JUnuGaLdbCUXPtUKernhlVFH7FZuksD3dcAJiuJSA/Wb+roACQNYdYJDOnyalnws7SPkhZ6PhcJvClxqIfhLmIuOfbfcRbpCKnhD8rMygqricz1DLo0wG1pr5GCcMXWrRwAWg0jFeT3cv2ZX8szr0A3HBh8q/Qlm+Us+TeHZ6wvUPjeB1mQzWNT9Fa1uYWqBg0XdfEYCoWcxvX/b3DLEtwzRM3T0tqSfWgNrIPTRLP3CzWpfhUtZSxpRUacvdgnejmGubXJJO5pyvc0YVrwn+cBcADlyFBcMpfspr6tP+yJKbAHvGT+iuWx94uTkjJUAhR627GoldH0mla9MEF9yLvsV5yL3hIeQ9+nBTEONrSzV6yYaT7jZjiDuRRD81rPFN6d/weGCILnvvmNjvRjWOcrLbSaNGYigsbvIEdDixU1R6JBn/3Z+McI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(366004)(136003)(346002)(396003)(2906002)(83380400001)(186003)(38100700002)(8936002)(7416002)(44832011)(9686003)(53546011)(4326008)(6916009)(316002)(41300700001)(478600001)(26005)(86362001)(6666004)(6512007)(6506007)(5660300002)(54906003)(966005)(6486002)(82960400001)(66556008)(33716001)(66946007)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTPWD2wOWZ/NBO+Vp0mzl3/Cge+1N3yPczAmQjGE3VaZMlIBHsVNihuP9WZq?=
 =?us-ascii?Q?5F2rqvhsUSmOwvXfuRDPqvx5BK66FwLa59bNGhz6zuuT+9RSUDoiI+evAOq8?=
 =?us-ascii?Q?GSNuf8miqSJoyMGivYjTZEmOxZ3+bfuJ+qzQBK+zUv+PXUp3za2a0g+aopbw?=
 =?us-ascii?Q?LMRED4YVKkqYautSpcxMVUjbnjHLEhZ/KFXL9XG8tGJXK0CV8C8EJcvW53Jx?=
 =?us-ascii?Q?m6Pu520FSXe97wEVYvV0+UeZqyERyIT8XXWwwMrlKmfjcm0vocrJ16XlIBl/?=
 =?us-ascii?Q?NA8nq9+mj4Mf9u5eyvhYv43TpNZ4oROI+U1Uhq3QYAz+VfdGNHl4fo9yk8BA?=
 =?us-ascii?Q?f9Y4aKIfFhKkLIWX63xf38k0Mx26UVTZsg12aArR++bZCQo432KQGb6C6mm/?=
 =?us-ascii?Q?Xg9NB4dRVxXrJZwOPV3+4Hv2RV2uVPVZ52WUTjwN2GRe24/7zAdlP50gFRml?=
 =?us-ascii?Q?BT+fqiFzej0vm/j7z9t0lqnSX17bGhbdzOW74tunp6d8nNc6fj9pySzjJWU+?=
 =?us-ascii?Q?t4QYU58TvR/fvq25bQfp4WqGTNWvYi5oXhyO6Uy+ztcHgSZaondK12i2Kj9s?=
 =?us-ascii?Q?gxbAHnNlk4k89d/fyQ68R145HE5Qwr2MznsnB9oTp8Rnt215KsQrY5qqrZBV?=
 =?us-ascii?Q?qTkEbfVQepf6rcOpUbq0vyHN3EqYHSBb3dxRTdIIlPiH2/MxCkmrDMmyuazY?=
 =?us-ascii?Q?snmiGI+gADq+1M3Lx+XReFpjP+MNCBdsdy7JquOKDCcqvM24gVPxxB181JHQ?=
 =?us-ascii?Q?2bHa/BdQQl6aCofgxtBwAiyXDDWW4G2m3SPvpeIyGUMteh6Z04mOW6ZUqsJc?=
 =?us-ascii?Q?dE2qx4OaPjyrAa0w7384O6x45Bqa1/hr82400Wr09JbNwNMSMOxKPAhADkGd?=
 =?us-ascii?Q?TDqxH2U/B8nFHDr/ClxqXhGQ6kDfxyxSre/tfYqL4qDIRFctJSYtZOpumv2O?=
 =?us-ascii?Q?e7q7wDxSwZqRelg7dTLyb3uRpt0+V4SkyrSzY4txQ5t5BBAOE3hvWqCfLYRK?=
 =?us-ascii?Q?e+lFkOyEugXfTB8nhBG5KGeSTYynY6MqVpPVoAMkAFzkhXeT15zzWcC5Thah?=
 =?us-ascii?Q?3mOBy0kKEYutYoQAs2cmrryYSoRC13w2w0kMO0cedDPhYic+mcoGYymF5Ggc?=
 =?us-ascii?Q?qh4Sj3sL/R8lwELjvJwSqKZUxIA0N7HYCQqLUcrlAtxsj6zAyLHIgbwYMjb4?=
 =?us-ascii?Q?2R5rBGRT8p9+PrzqqgNYm+mCS48AK/hyBAI+UlSiYBbTpZd3cZevFY37DZj9?=
 =?us-ascii?Q?hFuGnGW7r4LUVvL6Nft4iZ1HQl5G6DVgHdvy0J8PTG92vErN+2DqE/XGQ8Mk?=
 =?us-ascii?Q?oN57wedONnp5cYpLXautaegdAewvIs7gv2FbLRZCb+zHxgNcLf1le96oJfzr?=
 =?us-ascii?Q?Fpnslsvim0TjzcqzqrxCfUF3HwoQriJIYva2pmSKGxGsmZYn+DHzghUQ5YX0?=
 =?us-ascii?Q?Y5gKClyx5eStQtgT4WRrs9iKi3WVEtzTFfUOW8kRqXXtDaAU4Ow2USuprR0V?=
 =?us-ascii?Q?/4bE/V/neARCnlO9wnh7WB3WVKH0nzKyO1WEBkIwrfawIde//Za+lCgWj6Ka?=
 =?us-ascii?Q?EzGeVdR9EYuIzcMpv43eN9xW3Xs/51kqYOx/DtmH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e62a59-7bc7-496b-024c-08da74635487
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 08:45:19.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNEkWcqqfBL5dwttvt9S3Mmhvud6v86bF4SlKdlHwGKALu6vARLrBu7ybWEAA3xYKosI7/7TNrD2r3vBZqe7Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1777
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:59:00PM +0800, Dmitry Vyukov wrote:
> On Tue, 2 Aug 2022 at 09:47, Feng Tang <feng.tang@intel.com> wrote:
> > > > On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > > > > On 8/1/22 08:21, Feng Tang wrote:
> > > > [snip]
> > > > > > Cc kansan  mail list.
> > > > > >
> > > > > > This is really related with KASAN debug, that in free path, some
> > > > > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > > > > > kasan to save free meta info.
> > > > > >
> > > > > > The callstack is:
> > > > > >
> > > > > >   kfree
> > > > > >     slab_free
> > > > > >       slab_free_freelist_hook
> > > > > >           slab_free_hook
> > > > > >             __kasan_slab_free
> > > > > >               ____kasan_slab_free
> > > > > >                 kasan_set_free_info
> > > > > >                   kasan_set_track
> > > > > >
> > > > > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > > > > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > > > > > of the slabs will reserve space for alloc_track, and reuse the
> > > > > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > > > > > large, that it will occupy the whole 'kmalloc-16's object area,
> > > > > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > > > > > error is triggered.
> > > > > >
> > > > > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > > > > > conflict with kmalloc-redzone which stay in the latter part of
> > > > > > kmalloc area.
> > > > > >
> > > > > > So the solution I can think of is:
> > > > > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > > > > > * skip kmalloc-redzone if kasan is enabled, or
> > > > > > * let kasan reserve the free meta (16 bytes) outside of object
> > > > > >   just like for alloc meta
> > > > >
> > > > > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > > > > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > > > > __ksize() does.
> > > >
> > > > How about the following patch:
> > > >
> > > > ---
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index added2653bb0..33bbac2afaef 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> > > >         if (!slub_debug_orig_size(s))
> > > >                 return;
> > > >
> > > > +#ifdef CONFIG_KASAN
> > > > +       /*
> > > > +        * When kasan is enabled, it could save its free meta data in the
> > > > +        * start part of object area, so skip the kmalloc redzone check
> > > > +        * for small kmalloc slabs to avoid the data conflict.
> > > > +        */
> > > > +       if (s->object_size <= 32)
> > > > +               orig_size = s->object_size;
> > > > +#endif
> 
> I think this can be done only when CONFIG_KASAN_GENERIC.
> Only CONFIG_KASAN_GENERIC stores free meta info in objects:
> https://elixir.bootlin.com/linux/latest/source/mm/kasan/common.c#L176

Thanks for the catch!  will change.

> And KASAN_HW_TAGS has chances of being enabled with DEBUG_SLUB in
> real-world uses (with Arm MTE).

I only have device to test the kasan-generic mode, and not SW/HW tag.
But if there is conflict, we may have to apply the similar solution :)

> 
> > > > +
> > > >         p += get_info_end(s);
> > > >         p += sizeof(struct track) * 2;
> > > >
> > > > I extend the size to 32 for potential's kasan meta data size increase.
> > > > This is tested locally, if people are OK with it, I can ask for 0Day's
> > > > help to verify this.
> > >
> > > Where is set_orig_size() function defined? Don't see it upstream nor
> > > in linux-next.
> > > This looks fine but my only concern is that this should not increase
> > > memory consumption when slub debug tracking is not enabled, which
> > > should be the main operation mode when KASAN is enabled. But I can't
> > > figure this out w/o context.
> >
> > Yes, the patchset was only posted on LKML, and not in any tree now.
> > The link to the original patches is:
> >
> > https://lore.kernel.org/lkml/20220727071042.8796-1-feng.tang@intel.com/t/
> 
> Lots of code...
> 
> This SLAB_STORE_USER seems to be set on all kmalloc slabs by default
> when CONFIG_SLUB_DEBUG is enabled, right?

Christoph has explained in one earlier mail that CONFIG_SLUB_DEBUG only
compile in the debug support but not activate it. Option CONFIG_SLUB_DEBUG_ON
will enable it, and each slub debug flag bits can also be enabled 
by changing kernel cmdline for some or all slabs.  

> And KASAN enables CONFIG_SLUB_DEBUG, this means that this is stored
> always when KASAN is enabled? Looks wrong.

Thanks,
Feng
