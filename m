Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042235ACC37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiIEHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiIEHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:07:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052D3ED51
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662361657; x=1693897657;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4x1ReN4c9ZmQcBWqyA0qStlgVPhgxSzZQbDLn5b9k2k=;
  b=Ivgqqjw0wGOrI5MF1plrCtHftJbaFNa9Z03OvGvBG5/XnCjoO7KFRxNC
   auNGIQSxlM6XXNjPA4OjExpU9PPSwSYMxEk2pMQw93K4/a9ay9+sQ9+1E
   KkN/EipUohp9xLkdPnAALmn6AhRlc1O2/ppgLE9Fgrp3X8ApCyBmdZ+Hm
   uzbI/MIxfnZCbPsWSq4Sh61b1G3F6ENhPM470286+BKrY6t9+2uGoZ2bk
   E7Hpv+MzaxBGvybCleUq/pmWHK018pdNV3qoQefQmjKXG3exRt5KsO1nP
   XETLO+penowoKtx3PSSvODYFrjY0A3ztP9eaZNRybFE5nN9dswdXf8NRh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297633979"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="297633979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="717241259"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2022 00:07:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 00:07:35 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 00:07:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 00:07:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 00:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EozraySjjnHtLHJfPY50in2tPkZq+oIhyq6zL4gugn4Q2Ubg+78tRO+oD5Q7xdwxfIBB+2cFf1ns87nOMWz+H54ObYwbD5wglNmqFIQVR2q7SAYPyiVlFuJU2BoMVQ8h+GBetRX/7IWEmj0676jGs1TSohTXF62+Eh1VryEupxq4zHIIC8W8NmS+2BuQ5LPqIH4wRkL/pZTMoiY5Xemej1pK51qtXZzJSijvXqVo1nh60cVsN5gwcYpspWHO9RmAtnuFdVK/8wQH4HRae4CkKIKwoIaYIwkKfbcrIIZ+uKiwEDsojioC3ZGphhEUsLTCpr1XzWCs6kylZtOam/dpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwbO4BMIXpuYgujZvVcj5S+5tMvpxjkWNo+OwyC228I=;
 b=KiJ3f7EMKxslatDy7FfnZpneXQkriepiesVTooHdcpD8P7Qkig/cr8HXuCDFMaKs3k3uVZXCqKCYxTnDYaiWSwX+s+iIvsw0g83H0BOjX+4Y+tjDEzeLhvd5AKYmpB+ab77ugDEcq4ESxtAKuAvzVm5FFTl6G05eEIM6h7p/2v6ApUlKGlToRcDWE4cKXati+xLUcdCj1lWK+DTyxBkJ+02SySrJ78mbx7uu3IeOr1hJUuQ1UAf3+RVuklZrXH+W78g3X0PfSwinEYq13Ou3fLTyzuL0rb1MyKGS+sjbC6wupvz8Wz/0SWXgy7OGsfnklh3nNxtwrdE02k8tKy4bmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 07:07:32 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Mon, 5 Sep 2022
 07:07:32 +0000
Date:   Mon, 5 Sep 2022 15:06:57 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <YxWgEZTxyI/4ISHa@feng-clx>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
 <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx>
 <YxSE6XmHl3itv4JY@hyeyoo>
 <YxVlB/YRj7SNLqml@feng-clx>
 <8ff805f4-76ae-fc0f-424f-4d230c08285e@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ff805f4-76ae-fc0f-424f-4d230c08285e@suse.cz>
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cafcc75-279b-439f-e124-08da8f0d4d7c
X-MS-TrafficTypeDiagnostic: DM4PR11MB5263:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiVNeptD3scLeSO+uajkg5pQ8ruxYKK8lOlGG/iAPpZBB/xqXT0z5cV0D95DI+j7+bUM9cGsViwvr6E+J97kgtcVL1sZhl6jGiuvdGKeP6GtXrTVllEI6kNFLKnLQ2+DKe3CEiRunFjbgoiUR6SGORgG8IAXy1HZ9bavwtgcJEfTilP8tCQgnUspK7NfcoGfMqzs5vDS+yuo6LAvVMwHkMMfwz84g3+b4cA1HgIZtcOqGdvMMEHGcT/mMZmvLX5YazOAe9WvsI4VkfSZACGf+HEYVrFNTLZ5TziARVAY2APMR188TSKkssR+TnIOOL9bLjowximcqQji28O0U++xQ9Sn7BetZOy5p+eIXEQHUudW1sdR26SSMG93jjH+L1VXKvjqegArHVquNVJQToUfBZTrcgbYY4QOAk3FKVdRGrro25k6It4O0myUlIjWl9whpUj2GxgFkCAhmRJjqUok8brKXDbWMILpIH2es5G80VqJ1rzF4xWsVkzA+AZ98NXGtMlM8SDkc4Dq5gHRCFl0kZ2ERRnZEFpjaHFr8fGFsxh7FsCosYpXXey551ebDqL4PNpAyczntE5e2hxNM2Trq1iWoYMZsoU/wkQklbf0yUkF6k5KvAMsLeUOmrCAxdAdwH6ielkYDJq9Ww1NFhjmMxDFFWp4gnz8DRhiGuVOHQr7FeBrfQ9Sje68lRBWUrCLKJ2IZXXGTTivliBdb2BEQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(5660300002)(316002)(83380400001)(4326008)(66946007)(66476007)(7416002)(8936002)(6916009)(54906003)(44832011)(2906002)(8676002)(478600001)(41300700001)(6486002)(6512007)(9686003)(26005)(53546011)(86362001)(66556008)(186003)(6666004)(82960400001)(6506007)(33716001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3d9X7eKvpqBrvVjZaK+5qwe/cYmbwU1vsZttHL8xXQuDPZi3DWQEPtr/bnbg?=
 =?us-ascii?Q?p5udPM5KE+k8gTgTyOy0h7U6jtgUpAfCku1N3rOyIY1AGPw26u+IyXc1arSo?=
 =?us-ascii?Q?euWS987SG9Gol2ZeoeLBscBNPKgUMEtkyutp0oHfnBL24PGyyhW1FE1YQB1H?=
 =?us-ascii?Q?NfN/tdgu7fbq2M1MTzZ0CIln/zsyYfYREPGK2QeQJXIgNZe0Io50neo8/4kq?=
 =?us-ascii?Q?+Q9jpfCR9aaHWC2VRJiWkky2usErmllDhkyifrn/NmkZF/eYpncbwGoG7wPv?=
 =?us-ascii?Q?5NGeuzPGOUYF+tteZ1vAzaVKewIR1+nZgAgGXeiBq2V0qLCwiq0wSWo/Ee0C?=
 =?us-ascii?Q?7mfRZe4NRhTEf9pehYg22tky6sMtgu6UpCu0IbwAo0myKc7z9nIbzF7xTGWK?=
 =?us-ascii?Q?ppw6841EEW8UTiBL98k8grcXrLs6tGD8P5T+J4Y9AAJoDXEkddqnT+jVzj5L?=
 =?us-ascii?Q?He+TvAt38zGzK+oZ4IQZ67dBwNU+DjeFZP4Mm/sSI48fel3zm037g4B8cPiW?=
 =?us-ascii?Q?9XZ0PwYc1Zb4AB7O1/2DZ5KqjJTsV2NndR8WXAx87cCkDEVve7a3LwhjJ7ls?=
 =?us-ascii?Q?pOOhGh1dMOAdBI1NYEpYtiNseqQ1U6RNY9JBoRVLHJBVcEXhv+7MXjFNWjpy?=
 =?us-ascii?Q?WC/rXAnFit7jAkHpvAoT6RBFA/HJ0krWWEMluiIgz8Grvnpip5wyrkK4logL?=
 =?us-ascii?Q?HwBsE/Vmf9+kerp7N0QzqhqHgN1tyZV331lYU2bC06ippURZ5Kc14k82FQqz?=
 =?us-ascii?Q?V4W63WxP/v0C8IkQbWso82vPjSYN9x2Rxnu9HBi8O8Db9D4CdHNGhfCvwcWD?=
 =?us-ascii?Q?JTPj6Jes5QXBUJ5hQgDI34774aP8uy8vIaxrg5dRivnjXMh2Pgoba7iSVyiF?=
 =?us-ascii?Q?aBTZ26NGoSUWqNJjzq3YBXAP+rhwLhRcVwajnWZvHOC8RB9eyovb8eIqDRAq?=
 =?us-ascii?Q?o7CZea3w6FsM+fPYeR73AAU9gX4XT4O0ZKQXnFDEg5Wz4eSlbfbCYCVGSpHr?=
 =?us-ascii?Q?X2LnrnQKoXCvvF2ZVqNeuIM4/ywRgT8Gpgm6c1iwlLEabw76qAGz4rP/xbC0?=
 =?us-ascii?Q?SdlJLX7VL3SrEEyShV82jk7CGQewMkbG9slErV7g94pRPX5bQ99lxRaJkQyk?=
 =?us-ascii?Q?M1b/5jue75M43KnpEEmIWE1VlcrmlZmcxnca1cQUMbJ7WzZX/NXl/gAuD5Op?=
 =?us-ascii?Q?/o7BWHpy6Yi1lkW9sVQaVhDYhmMSImDh6RSCKiLa/eeOhOYU6REs1/2f5Vw0?=
 =?us-ascii?Q?uJOkEHPT8E7Tyvz8pNRPyl3zxAO/HSH8aSxm88V7JWOFB0BUtmk3T59Scn1f?=
 =?us-ascii?Q?Y5a1KtDEY+msu7L04AkkcrM//O7hR9TgvoffeAbBwCY+dpHq8LhJljr8bTCr?=
 =?us-ascii?Q?Ay7Z4v9G5YWwKpb0ZvvYD43RzKNz5Pcvvh2LCoSNtjqx4VCDGHyziCWPzpFH?=
 =?us-ascii?Q?xBd/MpfTPZtdCVgq+0KLwnzr6a/EwQJFThKg46MzGimvMOREZqb1Y++NaDQe?=
 =?us-ascii?Q?B+pdXdfXpMjIe+lO4Frzq4nCiOU35l/Ah1Q14K/RDDtBNSob/xW+no8CMfEr?=
 =?us-ascii?Q?K1pXFCCOGZjIG+PQCGyQFR7YIuPIufWHzZSma8dS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cafcc75-279b-439f-e124-08da8f0d4d7c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 07:07:32.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hzAXRYR5QtxUeQ56qtY3iDHggr+NqKVU7+YrdCLUggth9OwILlxmP0w+IxIue2PhqsgJgFSDZVskHfXMehI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
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

On Mon, Sep 05, 2022 at 02:29:51PM +0800, Vlastimil Babka wrote:
> On 9/5/22 04:55, Feng Tang wrote:
> > On Sun, Sep 04, 2022 at 06:58:49PM +0800, Hyeonggon Yoo wrote:
> >> On Sun, Sep 04, 2022 at 05:42:33PM +0800, Feng Tang wrote:
> >> > On Sun, Sep 04, 2022 at 05:03:34PM +0800, Hyeonggon Yoo wrote:
> >> > [...]
> >> > > > > 
> >> > > > > This patch is okay but with patch 4, init_object() initializes redzone/poison area
> >> > > > > using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
> >> > > > > Why not do it in init_object() in the first time?
> >> > > > > 
> >> > > > > Also, updating redzone/poison area after alloc_single_from_new_slab()
> >> > > > > (outside list_lock, after adding slab to list) will introduce races with validation.
> >> > > > > 
> >> > > > > So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.
> >> > > > 
> >> > > > Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
> >> > > > done in alloc_debug_processing() (through init_object()). When
> >> > > > rebasing to v4, I met the classical problem: how to pass 'orig_size'
> >> > > > parameter :)
> >> > > > 
> >> > > > In latest 'for-next' branch, one call path for alloc_debug_processing()
> >> > > > is
> >> > > >   ___slab_alloc
> >> > > >     get_partial
> >> > > >       get_any_partial
> >> > > >         get_partial_node
> >> > > >           alloc_debug_processing
> >> > > > 
> >> > > > Adding 'orig_size' paramter to all these function looks horrible, and
> >> > > > I couldn't figure out a good way and chosed to put those ops after
> >> > > > 'set_track()'
> >> > > 
> >> > > IMO adding a parameter to them isn't too horrible...
> >> > > I don't see better solution than adding a parameter with current implementation.
> >> > > (Yeah, the code is quite complicated...)
> >> > > 
> >> > > It won't affect performance to meaningful degree as most of
> >> > > allocations will be served from cpu slab or percpu partial list. 
> >> > 
> >> > Thanks for the suggestion! I'm fine with it and just afraid other
> >> > developers may dislike the extra parameter. 
> >> > 
> >> > The race condition you mentioned is a valid concern, and I have thought
> >> > about it, one way is moving the set_orig_size() after the redzone/poision
> >> > setup, and in 'check_object()' we can detect whether the 'orig_size' is
> >> > set, and skip that check if it's not set yet. As the manual validate_slab
> >> > triggered from sysfs interface is a rare debug activity, I think skipping
> >> > one object shouldn't hurt much.
> >> 
> >> That will require smp_wmb()/smp_rmb() pair to make sure that
> >> effects of set_orig_size() to be visible after redzone/poison setup.
> > 
> > Yes, synchronization is needed here.
> > 
> >> Isn't it simpler to add a parameter?
> > 
> > OK, I can go this way in v5 if other developers are fine. thanks
> 
> How about get_partial() instantiates an on-stack structure that contains
> gfpflags, ret_slab, orig_size and passes pointer to that to all the nested
> functions.
> 
> Would be similar to "struct alloc_context" in page allocation.
> Something like "struct partial_context pc"?

Yep! This would make the parameters passing much tidier. Will try
this way. 

More aggressively is to also embed the 'kmem_cache' parameter into
it, but this may make the code look ambiguous.

Thanks,
Feng


