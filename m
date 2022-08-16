Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F2595E25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiHPONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHPONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:13:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E98E1A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660659191; x=1692195191;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W+VrkRPHo2x7Z2jOziuTWRbacvTegedFxX57ONUdsuQ=;
  b=FEDMs4Z01sCFtCDT9MWqaYbmPuMVxVzw84jJq/gyvGhpZnnbQd9+8d16
   nvAzyXdoVURBQ3dJYVncMAG67khBM5rEA34M/mEx/52bsRTk08imCDObd
   MPOpfrkYMSSvICzGis0gRraQELMXqr7nFMmqiqlAN2yx2qQlGk9wNbtut
   hNEoCWnij0CYazl9OEpyf/UYsjVYw2ZU5oDoyw+FIz4JIiQcgCQ3yP+MV
   7LiSDRiBHz7BslqUrHET6DUdm42ipfYhRwCfRC9u/kajpUW1i201IUsiQ
   ykUCNRFR6uOjD8vS+9aKdxtpmLugAhCd219scfN39VFMH7PjMoDq1xbVP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293504495"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="293504495"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 07:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="934923847"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 07:13:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 07:13:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 07:13:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 07:13:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 07:13:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCLN28MOFgahqp32r9Mr3iH0W9Qe56Kj1LqO4dPDwqgqKM5u9F+Prb5mXiUBBBUiWd6cVVgtTeINOscbad/w49AaVKUSbzVJj7oas0q3lbHtRKQBL58TQeoVLQw7+aoSUklYeMVOEfi5IYwmMzuGucPe3G+207FFauKq4g8KrgDNteGUI5DRP2aMKTu8GT7wNB+V1x0aFu6LUS/f812ZeFjgEBCt/EFVnV1rP1tblB1LeM+EF2QvaseiVFo8RA1RuuzwDyHxpzs29iYxppIoW/+EvJqupoMnI+4T66eA1wzH0QpWvBueUJYUF2aqsXHykRmx019I6vUNjWeQKwfQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P3apf191TmbBiLeuWBK3j8YzpHIHd+P2ewD7KjO7/k=;
 b=bdDs0iIKoOuN+vDMznovzrc1SRTimHXlTDMxKcEW2iEGUZWPOw91CUPEeD2MkRiU80WCcLUWsx19RHMl3y4vnU9HTS7fWf3Sug7s2U/3cHRBk6W3BCuXovunEV9C0T6YH4xPnzcf4dsjltCH4B4t7tjwuMZWu7z3DdRhBXBxEmPNXsXxY+dT4GVHJbfX1MKZJcv8rDPVZH58U3zVG+SkDb2qzdIBIp+jOC6fgn1RA47AfU+PwGRRJK+7Z9+A7jbF3i5YjdJpV4WUHsg4wPLMuolbCwqlXilTtrkyD2ToJVUyxQYb/4LBNrrgGzXh54WjVqrNizlIDY/w7vBua5kOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN9PR11MB5372.namprd11.prod.outlook.com (2603:10b6:408:105::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 14:13:04 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 14:13:04 +0000
Date:   Tue, 16 Aug 2022 22:12:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [mm/slub] 3616799128:
 BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
Message-ID: <Yvulv68VmqCJFVJq@feng-clx>
References: <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
 <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
 <YukoZEm4Q6CSEKKj@feng-skl>
 <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
 <YutnCD5dPie/yoIk@feng-clx>
 <CACT4Y+Zzzj7+LwUwyMoBketXFBHRksnx148B1aLATZ48AU9o3w@mail.gmail.com>
 <Yuu6B0vUuXvtEG8b@feng-clx>
 <Yvn1b8y20Mr0gfUQ@feng-clx>
 <YvubS48W0dE7uA4E@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvubS48W0dE7uA4E@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 905af6ec-7a8c-4dd6-01e9-08da7f916f63
X-MS-TrafficTypeDiagnostic: BN9PR11MB5372:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2bDj/PF1exWijjb6ETEc5WZ73jgWJmqb3joMkL5Y5lwlKp8HTiHAMSAc+lWbMpU9NkOL1GQ7KCeAqrWK5Rx5NZSURB316fPNohqpdDi+APqLLN+CNTHUGBf3BF8VZza4STbu3cVRx9yGSNAAvIgCnZFsLG0plm+7ET7th0O5X3yp9NQcbpF6LftQ3C8kmVjEsaImTy6Myd18KWia+vlRoBXxaCNSC+nivgPcIAHWukJaS+2YIp9LB8ATDwFYUKjn1TPNzzUD/Xb6oxQRFfmxCLibVFaQvbgfyqWv5XMKX8DeYsXNjrB1murkCSjw8fzddc6eop9OB2dvCznNkA6PqPSFCwYlYo9plkTSbzE+rgeprrSlOAPGGIecXzbnTwXZIKsFSBis6723YiX7o0I91fL5gH5Cm8DDvHLYYDd2PHbfF04rfCyZf5Zi/z7Ts7IUt/aKwPTOKN5gCAEeZaxpVhyudEWsi4GtVjWgBc7vUIXtSUbN84PyWQk837Y9gSmGNpD4ImslxFfpt8zjRZAJy2/uZD8XYWVHzZRx9GRAhet/36xhxHKi3tTHOoeN3r5qyraSjqc5mmEUNMX/DM78YRseWmJF6a+G2MmWGiSilJQ37NjPAkLBA17/IzvIlrFojJG6sUhpZ9qBpsQ+XD5OfY65rTqph/7B+DNfgvr5JD69RTYj9WuSxWomfvD5X2YFZYaWq2Jg932tEb5edCnnYd8GA9jkL7qGvxDk0Bbaa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(38100700002)(4326008)(316002)(66556008)(8676002)(83380400001)(478600001)(66946007)(54906003)(6636002)(6486002)(33716001)(44832011)(86362001)(26005)(2906002)(7416002)(5660300002)(8936002)(6862004)(9686003)(6512007)(6506007)(82960400001)(6666004)(41300700001)(66476007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kHPOoOMKP/OZyio3hrBd3hpTnZ6JmVig5GFgyqlFHFTjV84eqjdYP4yameyM?=
 =?us-ascii?Q?M2G85hIDaLhcveGS2LzitjOsnKIGVtlIeeFdcytL1stzDrpiGeKQT1GBuKk6?=
 =?us-ascii?Q?Mar07pX2eiHA/1JvwWgwu8VoI9e72wo56sq2kAMO5lZk98BT9X9Dv4HtGbjg?=
 =?us-ascii?Q?wQ37RCCTWWr6d+ByFLNOWsBS2QLMTSIx2kOhpkwZsjCVzRhOqIg3RHzJSlLL?=
 =?us-ascii?Q?PIhgcSIp658WE3QU1Q5rhcfUEwo+og2ogmFeAwBN6mTKZM2yI/c8jFLrnyRs?=
 =?us-ascii?Q?5G+14X8T+5ezdnhwV5zdk/UNuVOkTL0cP/1KBv6vbn+HCUgAcRe2PTt3TRWq?=
 =?us-ascii?Q?BF4Q0o3AF9J/z7xxGGL+M3AgupjpeHrn6lT+NaHekFPakBd2hFiUINKyVZds?=
 =?us-ascii?Q?0HnGameKHZQnCq+wEd3ABKBd0w7FPr3s2VgcudNElAT1l0tWJ5342qbhVPHo?=
 =?us-ascii?Q?FZCpaYYXUQ+KavvajGb2VvPutoGIS5kQa6SJ9+st3l830TYTNU1LKdJf9q7g?=
 =?us-ascii?Q?CcmYWZKYcZT8xDkdd4lKX/AJ3CG+Qh7gK5NOisCSTIgyj9AknXZzwTGUb33a?=
 =?us-ascii?Q?C1QO9BbRhmPSXWcuSmqVdGQYY2IBJuxgumsQUd+gDVf3jIyPOb3nEKLvdJ8j?=
 =?us-ascii?Q?pHvyfh0tmbts8C+IPrVzs8vBBZgGhwKNzfvLK9KmT1Dfr0yqJ4ELrsMEMZKV?=
 =?us-ascii?Q?UOS28sdtGaFcKVGxvvXmR8tbVCxWPcU8wwQ0+bBu6/5kGqPyWIGmgD5I35Js?=
 =?us-ascii?Q?sDzSXNKJ2A5sMBSTOZHWwnaYcAseeVoxU0k/xFyxQHiHvCjlkg949slLSf2M?=
 =?us-ascii?Q?/RwvtmeN1mB65Wf8jcQ+Io0eB+ve7miV9nvWOHeNoZUJKXz0FmF5EuziLfFH?=
 =?us-ascii?Q?drTK3hbUL/RqEKPCcImc2KLT0X5vka/1dqWtnuNq7U5C/8SDCHmIlXJNypMt?=
 =?us-ascii?Q?0hsOJ3kn08ZpzWY0UrcKQrFAn14SwpcUOrv8McVqZ7S28aJRaAE+PlvFKYYH?=
 =?us-ascii?Q?RYaz3bZbsUaFkBTD9QOlpagrLcHOVdX7xYs4yjGKBL3GRVZqzAHN+uzLuPk+?=
 =?us-ascii?Q?yvg4paK/USpIRVtkC0MyV5l+vXuNSPcqi7Ip74yTyG4pSIMNwMJqKU1U5YSf?=
 =?us-ascii?Q?6m67iIAdRgACqQnUrtNxQ5WVAIGm7HWaDBMaDJbtiHTl6WjrOjixdX6caUKo?=
 =?us-ascii?Q?9GIvPBlD0QSrZ4xKw4YUQGNj5X3VbJJ3CbRlBbDdJ5HDZvLilW3cw4ONsi1M?=
 =?us-ascii?Q?9XDMGiLoYwHlKMNkSBYgTSWJDpETA39LAVA6ifH2vofbPG4qvFO0bxnCaBVb?=
 =?us-ascii?Q?9wVekDRqhWz8VEdMjROVJos5cY+KVHQuDg/FT+I8ZzLZcA2JR/DNQoZ7TfYT?=
 =?us-ascii?Q?owH6F0cqjl1oDxqESqxzMu2lVNKf0cavpGA19Vaoek6BO360lA4JHlCxSekW?=
 =?us-ascii?Q?n+RK06NOMOULZw0yjNi062QXIg6Kbhc9tYuTb7nt3w1YxWCE1t/7O6DWCpI9?=
 =?us-ascii?Q?uE4bO7hvr4tAbLcCJK3TlJUmLCZDpt3Yxz7nNiPmBhARCLtsw151mZxD0ZwG?=
 =?us-ascii?Q?b9ke5A8INgpqpoVaRe5D45SFOf5+z56JGQyFfq7g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 905af6ec-7a8c-4dd6-01e9-08da7f916f63
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 14:13:04.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8DJD7urJVFnUQKp9oP+TD+INoEtkvyA6J2lZAFwU9ajkzBupPwgHZUvacrHDkfr1Bgj4QgP6i5FzZexiHTuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5372
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

On Tue, Aug 16, 2022 at 09:27:39PM +0800, Sang, Oliver wrote:
> Hi Feng,
> 
> On Mon, Aug 15, 2022 at 03:27:43PM +0800, Feng Tang wrote:
> > Hi Oliver,
> > 
> > Could you help to check if the below combined patch fix the problem
> > you reported? thanks!
> 
> I applied below patch upon 3616799128:
> 28b34693c816e9 (linux-devel/fixup-3616799128) fix for 3616799128: BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
> 3616799128612e (linux-review/Feng-Tang/mm-slub-some-debug-enhancements/20220727-151318) mm/slub: extend redzone check to cover extra allocated kmalloc space than requested
> acc77d62f91ccc mm/slub: only zero the requested size of buffer for kzalloc
> 
> 
> confirmed the issue gone:

Many thanks for helping testing!

- Feng


> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   gcc-11/x86_64-randconfig-a005-20220117/debian-11.1-x86_64-20220510.cgz/300/vm-snb/boot
> 
> 
> acc77d62f91ccca2 3616799128612e04ed919579e2c 28b34693c816e9fcbe42bdd341e
> ---------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |
>            :20          95%          19:20           0%            :22    dmesg.BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
>            :20          95%          19:20           0%            :22    dmesg.BUG_kmalloc-#(Tainted:G_B):kmalloc_Redzone_overwritten
> 
> 
> 
> > 
> > - Feng
> > 
> > ---
> > 
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index b092277bf48d6..293bdaa0ba09c 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
> >  struct kasan_cache {
> >  	int alloc_meta_offset;
> >  	int free_meta_offset;
> > +	/* size of free_meta data saved in object's data area */
> > +	int free_meta_size_in_object;
> >  	bool is_kmalloc;
> >  };
> >  
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index c40c0e7b3b5f1..9d2994dbe4e7a 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -200,6 +200,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >  			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
> >  			*size = ok_size;
> >  		}
> > +	} else {
> > +		cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
> >  	}
> >  
> >  	/* Calculate size with optimal redzone. */
> > diff --git a/mm/slub.c b/mm/slub.c
> > index added2653bb03..272dcdbaaa03b 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> >  	if (!slub_debug_orig_size(s))
> >  		return;
> >  
> > +#ifdef CONFIG_KASAN_GENERIC
> > +	/*
> > +	 * kasn could save its free meta data in the start part of object
> > +	 * area, so skip the redzone check if kasan's meta data size is
> > +	 * bigger enough to possibly overlap with kmalloc redzone
> > +	 */
> > +	if (s->kasan_info.free_meta_size_in_object * 2 > s->object_size)
> > +		orig_size = s->object_size;
> > +#endif
> > +
> >  	p += get_info_end(s);
> >  	p += sizeof(struct track) * 2;
> >  
