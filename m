Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7774C54B3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbiFNOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347945AbiFNOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:40:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE52E089
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655217611; x=1686753611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TxnWews7eXsBNJUQVRCKcoy9VkBJHFD6BeDptFrc/D8=;
  b=TUQtKS8tjYMPA85LyZYc9chpvUPA72THzm8bFwZASraUkCHzyRv1bxDU
   3v1PjZ+gvLbLiDx8v/wBaYqtxpfKxZLpWAGndvx2sr5pn4+z7yTEnokVb
   9bzXZmAzYiPhREyQB4DW6jdulJYfbhYv7IS4sCO5sOS6Yl1aEKiNecuf6
   jxJ7EPQN7q4tezU9PIZPKpLbooeSQvR9mJ5IOjDYpcIZe1SNynTZNQo2D
   thAieE6rD+5WvyAstajiV2yM8haSR/Vh7QvDJiRAlCCoJ1/hc+fM2pdkA
   gSOXMbfI3uBHX25SjLycoLbWrkxvZjQ73qYrG+NxhPUAgR/b0bXtKQGI2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261663286"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261663286"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 07:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652076222"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2022 07:40:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 07:40:10 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 07:40:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 07:40:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 07:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Low7Ybvc2XLdeeZnmGruyloCbzSTpOLUAIzK2OZs29JQub5WnCbLDkxHSBgy8IyP1iizdNdzKlJFip1mjSmStIm/PiehHO3YICQRiFEqzP+DojK9Ois0IzXR6KKUQOypJOgC9KRzQr2h7oeKdd33pMhKo4/epPMC829cjH3F3Fn2frRibeuy7L9iueyH1hR5VT6+GOoOf5qWb4DZTbvAPmvRz9zlFfh8hqHfYFQB9nHeMPnTsGrLm2Z44w4X1SJBlVgIMELKE+cJlBbeCdu9O6AnmZxhuRT3N+l8nfDqWYZGV0H6ZGAtk2E3+4bc4lWMokd+SVCkXGTuY6cFOXHz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vUaNgbsIw+9KSJhaFZeXlJP2gS7cVeL8ZZocwJmDLs=;
 b=Xn94zdmTm0Usmb4sB3avNIzFZ+i6I/gCDziqeTJXp9EV0eHC754L30wgFbY7A7QaIcps/Q0arLEHbkgxXpBAekW0jCaJdSSvnsGqcHfW8IRSjBWnA5saC/7Yrttkralk99iW9fSy6PpwceAogTv6eujKbSpveehxQePm9ESwZscAggoWxbT0TiB2JJFN1UAW/Ukd5yxpIYW9lveeD5/3QlI8OJGcDtCY+r0mqQGbVYsHVJMpNlKmzEf6MrsXqwyfYXVh459Kn9pnU6G2pnBPHbtRXUdzgabch0Cae2sSM4HqlSP9t5KNumJUmuLJ+TS3vphC4M+HAEyGEUe8r7vb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 14:40:06 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 14:40:06 +0000
Date:   Tue, 14 Jun 2022 07:39:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] highmem: Make __kunmap_{local,atomic}() take "const void
 *"
Message-ID: <YqidvW4Yw6p5Bcmv@iweiny-desk3>
References: <20220614142531.16478-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220614142531.16478-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61986fba-6451-40ac-f4b1-08da4e13c639
X-MS-TrafficTypeDiagnostic: SA1PR11MB5900:EE_
X-Microsoft-Antispam-PRVS: <SA1PR11MB5900C7903AF36F4B06ADBD0AF7AA9@SA1PR11MB5900.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fGYD/JyrqxUnCMKyTYzBUnSku1Zo8tY4xrH/LCmlXDl/JtG9oZpxe1lOzJ/BgTvmafRh5hH9U+yJhXWgkv+obIdfqkLzdmfY3/O6Lyyjs2BhhDfEnBAnrRxiXzTIL5e4f5/T+TdbuKPC2T19WK38un24P94TufdOMIFv+A/Js++qf7csmqeJyqXF/T5wGhkcIHEVBkkBHvJ+hLZVvbCaa+ZBf1ua6vLbHrINZcEwbBVC1HQCXkpgDLK5vsLSYnYlTafgxoeO+A0Tvs6PKx7HpBsgKOfl10ZZbih+ECEwnZpjmqzlLASHMNcSW1OzHDpo/cXg2CtVT3GupvcQWjcZF7Il9sC8efMc7p/d6h+bUPJBMELaEz2zbW8X9Y77fdWD4majFmjECAoYuyPLdJnAdNP5IRwKQ3EYyJuWpbD2Oipglorw2R+l3yUcXavmAUq+SeSMp9gEgLnwjsv/yKdT1lw7dhsF65CC/lRuWlBqBFfQcqFvaTUNGweXNlwzfu9wf1CWRDoPyO7jWKfRMK3vqP9/56WCWAinrBolkIz+ei7WzeAjy4v5XDG8iWI1JXHUZ20JCBNbd676NqNRf2SPwNIS0SAd5d+LKnVX9j/4lus8ORmnfBKpmztVjyZBsyEbEEC/m77ppZPyvVNpV3Nnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(86362001)(33716001)(4326008)(8676002)(8936002)(66476007)(82960400001)(5660300002)(44832011)(66946007)(6486002)(508600001)(2906002)(316002)(54906003)(38100700002)(186003)(26005)(6506007)(6666004)(66556008)(83380400001)(6916009)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L/ST6vGuph7aRTUdYv3I+66wMOQx+o8eL2z2gn0jDEpPrVV6NhkLSisubKIj?=
 =?us-ascii?Q?br8Gc7T1uFgcoHD+fzspTGJtIczlqGe74KiWJVTYNDzT1etA1DEnZqnpvoKA?=
 =?us-ascii?Q?SEJ5KLJjFY70KnyWOTKJTf7w3JGPofKb/JVOz61Qyr1WIfIdU6Zk91E35sCy?=
 =?us-ascii?Q?US/VmIPsN1bd975J0cm4Sj0ZRp8UXgnr/LkHs6ONx4y6CQ52zn6yx4tTviAT?=
 =?us-ascii?Q?dHL+CZOcuBtbQ0oGE9FolAAaeE443Rll0wtp1t5ahNf67iaS402n5AbBCx++?=
 =?us-ascii?Q?6cORZLpvbLl0IYsD5am7i8fRhJoQRrzpq9zkiO6f1PWPeqd+bZExiHt2P3e+?=
 =?us-ascii?Q?+eoMC6RqgrfwKXDFcrqfNk4snkLQt90aRvKDhUg6jlXoEZuHG4cNwpLktqMm?=
 =?us-ascii?Q?JrLkE/V4s4qMOs1csQLQioZiM67AEEI2//AxHwSDFxeHzOD//Ob6gmWObteX?=
 =?us-ascii?Q?we+MPp66hjHs9QIgeS0zf9ZK4UzATDwkJePq+bmPIfdAojICNGFzeJd54A4f?=
 =?us-ascii?Q?ZEQI1+PWWDj7X92aYjuIRmu9K4cVZV3aaoQ1fmtY4Br/rdK/6k3enD7/cYr4?=
 =?us-ascii?Q?WtoSUQAKL0GDALsfV/kQSi1oZIwOpHn2V+kAYG4TIeBZ/r1EcM6JX1ZY8beL?=
 =?us-ascii?Q?07eCdHYT4Dq8IN1XX7mtI7jxpeSU7l/F9BHT2F8Pko88eKKbCctuhb8DlFi5?=
 =?us-ascii?Q?S+d1kHZlq4toWVPrLtUX+QWPYX1KheZqZM+19lm20WdUsBTSv6ZXwhPrmfTD?=
 =?us-ascii?Q?T8BgAZXWGEE9Lon97WbDuIbPN1Ye1gfFEa3arRgrfg+5HqxQUf3FJEGAU17I?=
 =?us-ascii?Q?I+Rb9V+zzLXID3R96UCkijcowoxQocgTzKUbFu7PJSTDXdEnFzwYoBLCBMQk?=
 =?us-ascii?Q?b1vx5CdymPDGNdJfUHALkDuekKJos7w0OOO0f+wcfmVoUZcrTYnTMDMbMXvE?=
 =?us-ascii?Q?fWKmPJPZiw2EaViDgZRWsQcq+SlZdY9uX1C/aqKpWSn3wFlk2ClchrVGOqvJ?=
 =?us-ascii?Q?JXlHur55iSkYWL6/SREwtR1+BrClNYIMhoT5leGaOKavQ9NckAfNk/mDldX6?=
 =?us-ascii?Q?hHtvzvAblICLUaXOUKZ19WD+7yvTWuc+pRzm1A7QsfekK2Jm7bi0/zsLAnK0?=
 =?us-ascii?Q?g5gk5KBJZFjGbvWo2xdOa492jk/6zQ3Czw38QxbzoHaFYifBlxqA5egGBOnq?=
 =?us-ascii?Q?/40D3cLs5Iqkb5hShG5AhHGS3gslUNgdWTEwo9VYxBWx4xJDJY6QPEeuOXce?=
 =?us-ascii?Q?6JNKnlGf3srSd/SjH7Zwo81gu1Q3tgk1lOrHTVeUe9zMAUbtS5n17qlMZfJ4?=
 =?us-ascii?Q?ogOccMp4deQYH4Aa7L4QAt/9ke4fwg7Fy5dNpNwDd8d8gE+ttKwinDOJ7fEB?=
 =?us-ascii?Q?OVokvY3w41esnNQwwbPpGZjkuqqCwSKBpMvq1iVbgFjrEy24Ix8ZfnJg8fCo?=
 =?us-ascii?Q?Nc+gflDIFbFks/uZuEr39CN4mj5pbt9Aj5zYDKtqfFy3iVIvpi9YXUvazrBx?=
 =?us-ascii?Q?EyIJZ0s5WguEYH3zL1waMrzUF/lL0QWjx50/13WfCpfNHz0TR2Mc0P8kMw/M?=
 =?us-ascii?Q?oiqZreO26O//jv/ZjZ20iFsprU9kVYl9w4Jd2BGbwCC3eVqzdcYEtBDa/3b2?=
 =?us-ascii?Q?RJKkvbu++vpZ6FinEpZpXltIoK+EkwUi91nrJCDAKS1Pl36yCJN0RVDLgyQD?=
 =?us-ascii?Q?rvfsxqiUlUixOhG4DuM5cKfUypVjXORNvjTWiOK1i2LeKgNNolcvBtWvzZgZ?=
 =?us-ascii?Q?t6uXGxvyJcC3Ta263x/OSJt8TUuWMgA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61986fba-6451-40ac-f4b1-08da4e13c639
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:40:06.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivzeEdN1mrhkWekusENHjMpVHScByu1cOvRVxk8dLCnt3BUaHx3O9TrhC1OpS1qA9DGWAiquSkH3nQ2cKJ0oew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:25:31PM +0200, Fabio M. De Francesco wrote:
> Sometimes __kunmap_{local,atomic}() should take pointers to const void.
> Currently their prototypes take pointers to void, therefore compilations
> break in cases like the above-mentioned.

I think the compilation problem is just a symptom of the real issue.
kunmap_local() has no reason to change the vaddr parameter and therefore it is
correct to declare it a const.

This allows callers to also maintain vaddr as a const value to be passed back
to kumap_local() if they wish.

Ira

> 
> This is the output of GCC-12 when it encounters one those cases:
> 
> ./linux/fs/btrfs/zstd.c:547:33: warning: passing
> argument 1 of '__kunmap_local' discards 'const' qualifier from pointer
> target type [-Wdiscarded-qualifiers]
>   547 |   kunmap_local(workspace->in_buf.src);
>       |                ~~~~~~~~~~~~~~~~~^~~~
> ./linux/include/linux/highmem-internal.h:284:17:
> note: in definition of macro 'kunmap_local'
>   284 |  __kunmap_local(__addr);     \
>       |                 ^~~~~~
> ./linux/include/linux/highmem-internal.h:92:41:
> note: expected 'void *' but argument is of type 'const void *'
>    92 | static inline void __kunmap_local(void *vaddr)
>       |                                   ~~~~~~^~~~~
> 
> Make __kunmap_{local,atomic}() take pointers to const void.
> 
> Suggested-by: David Sterba <dsterba@suse.cz>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem-internal.h | 10 +++++-----
>  mm/highmem.c                     |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index cddb42ff0473..034b1106d022 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -8,7 +8,7 @@
>  #ifdef CONFIG_KMAP_LOCAL
>  void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
>  void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
> -void kunmap_local_indexed(void *vaddr);
> +void kunmap_local_indexed(const void *vaddr);
>  void kmap_local_fork(struct task_struct *tsk);
>  void __kmap_local_sched_out(void);
>  void __kmap_local_sched_in(void);
> @@ -89,7 +89,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
>  
> -static inline void __kunmap_local(void *vaddr)
> +static inline void __kunmap_local(const void *vaddr)
>  {
>  	kunmap_local_indexed(vaddr);
>  }
> @@ -121,7 +121,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
>  
> -static inline void __kunmap_atomic(void *addr)
> +static inline void __kunmap_atomic(const void *addr)
>  {
>  	kunmap_local_indexed(addr);
>  	pagefault_enable();
> @@ -197,7 +197,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  	return kmap_local_page(pfn_to_page(pfn));
>  }
>  
> -static inline void __kunmap_local(void *addr)
> +static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(addr);
> @@ -224,7 +224,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
>  	return kmap_atomic(pfn_to_page(pfn));
>  }
>  
> -static inline void __kunmap_atomic(void *addr)
> +static inline void __kunmap_atomic(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(addr);
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 1a692997fac4..e32083e4ce0d 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -561,7 +561,7 @@ void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
>  }
>  EXPORT_SYMBOL(__kmap_local_page_prot);
>  
> -void kunmap_local_indexed(void *vaddr)
> +void kunmap_local_indexed(const void *vaddr)
>  {
>  	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
>  	pte_t *kmap_pte;
> -- 
> 2.36.1
> 
