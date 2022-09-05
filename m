Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED4F5ACE23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiIEIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiIEIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:38:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F511BEA2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662367082; x=1693903082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LsNT1ghROEcY5excBTmbuyf67lUADIBtg0qnAgwX2pM=;
  b=BCRfvwLFj4sntDj79+yTehW3HZfacrAW76Nfk6mtFEE5ntjpblftldCu
   8xlSJMgvyRuVMi7nvLattoo9Who94UVlr0qSxmeKgSscqM4LFbWAsTOkc
   RrTaUz3kGjH299Z1dtfrcRHn66o6ejhjGeU44Xn2Ca3gb9hnHgdcbmevI
   XHDUMWy87McYVHeTxDWoGooS+yfjsECXmEfJvlI81EFgKIZNZaVXWm6//
   EDzY7UIIIH97G2A+3FT1jCsouThXBolJGqCGNBVMHNWp78m+38KzSFI2R
   rwrYW6EgH29CAHVNJhTzoScVI9Sf7/H472zfhjQMB9FqH/lYRXckZAGCc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="322507899"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="322507899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="702811254"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2022 01:37:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 01:37:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 01:37:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 01:37:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 01:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5EfKHQBRbPjkWRN7UXwZzy0UuhcjMfhC/sXWuuWy8Vn8hkZ+z4Mn2zN/ZMx0Gn9eMrttkVbsMID4NxG6TmgnQ1okArnxrLLmGbs4c4WTosXFX9jasMl+4VBiLPkr0HF/NfoySe5dI4lwUG8INksDEtsHYl78PoOl3RIgGaEvXpePikcykQwqUcGdcVyduKLOpt2kdiM/uf0fDlrIgrPrPbsnbb94NktIydcxPWnl3uUsmRp2tfZ3HPrDaLp3ZLUnyb6YRCJtIuHsZMTO67bnHK4iWQGql6q3YnoY0LjZ6RlxfWWYACJMQKl7amlOSNcn5oYZUb5B6ZKP5SGhjB57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnxnXKbawKMspvGgfde1qHrv1l4iHX59t+KisFTXDRc=;
 b=FpXNh3vb8L1EYxnaenDZVw2rZNEDAiMpsaVqGqLqlewc6EiMEuiSAkOfhslnTChAXHjT1d7ATCOM7jRTqMy8w+sUQeQXvN3OsF7w89oNsrka239bkRq4tUYP/ABOw985yJ7/n5LvH9wMU301e2rg/85QaWEpjHqu/F+N9sYzOtwuMxxVEFvHGQS2ZE0Us9uLov6LgNONTlF2ngTu9aOPrRv3LZYFsc+yFI35RaALSITCmokHlDTp3nTir3JjeRxYgr+b2fw1HA3lBNUJFUhBKV2x1+Co2aZSJ1rW0c4mJkuXrCcNwz3F0lpmMwqo34hdcXwmINnVVrls/V9Ryn/y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BYAPR11MB3574.namprd11.prod.outlook.com (2603:10b6:a03:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Mon, 5 Sep
 2022 08:37:39 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Mon, 5 Sep 2022
 08:37:39 +0000
Date:   Mon, 5 Sep 2022 16:37:05 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxW1MUIKJ8B17xl1@feng-clx>
References: <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
 <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx>
 <YxSE6XmHl3itv4JY@hyeyoo>
 <YxVlB/YRj7SNLqml@feng-clx>
 <8ff805f4-76ae-fc0f-424f-4d230c08285e@suse.cz>
 <YxWgEZTxyI/4ISHa@feng-clx>
 <f5057559-d4a7-552d-c5e8-1f1cd133a7f1@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5057559-d4a7-552d-c5e8-1f1cd133a7f1@suse.cz>
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eea13f6-d46f-4756-bc80-08da8f19e44e
X-MS-TrafficTypeDiagnostic: BYAPR11MB3574:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS28UeZDStgUn2cP9FK06nPc6atq6ZQAhheZ+HE3114SP3AsBLkK0qYvM0kf2Vvxx570GB/qnrXiQdBcpC16IuS08za10q6pCSeNvJBP8cB/OuK/3TUUCQeM/I4vcZqZq1LeeGLzyd3MtzBL7TsJRyABue1wvbi8elADHSDRt9sIWBb/P59QwZSDtVmkGSrx1bkEpiiQ6OJg2vXIZJICK591+GTBYhWrP1nyWgR02ZX5y2dMe6psbvAQv6j+F7/BaD+3wJnCRHu1LCoradUngchO5CDYeqVCdprSlUf3/uJf1gmO2XXWROjtXPzzLwYBcTROtjWJxJrrsc/45hrli1UD/4S9CAri4QQWdwtd34xjgE2X4kC4UTo1khQmNWnc3oYKRhyeYRxfQyTc4n/xlR7WRpvY/c+Of7M5pjq7w/9JPu00rp+5hZbe3v9nd8WapABStf2IE0WxRGL99+zCftjYkdLaXgWdsg+sUdQPVbzRPIW/1THkUiQlpzv6EVD/beSyapPdjc1f/4INuhXPIJENUCc2h2qMjuu8H3L3wba4Rm4h98dgsZFXwZtuh/IWBMWLgXhti5wNwYKflITlsM8z+7bFKeO84GG1stHm35KWyJl3IKVfuWTv+fct2ajD+0wvYhmNNjgkotjUJP6lYXBMz7RQgGp39iRRnDqwveKrtnwTJFSwqwo6fAO4cx0wUSCeupiGHzUDNNGNfpTrrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(66476007)(54906003)(6512007)(478600001)(26005)(66946007)(110136005)(41300700001)(86362001)(83380400001)(9686003)(38100700002)(316002)(6666004)(33716001)(66556008)(6486002)(2906002)(7416002)(5660300002)(82960400001)(8936002)(8676002)(4326008)(53546011)(44832011)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8xK9EWktj2Mw+MuppEOA1EB3XuKkElELukGoPguGbojGMCCgFlRLi0VTWmD?=
 =?us-ascii?Q?OROWbSH10wTcDkRSXn5r8knVw2TRSl2uTj0TDM7Or6bpufbijdWGQElf9olE?=
 =?us-ascii?Q?Sk3npmIlBr/iS2uEnc/YAKQB0bw07BDrh9jecNVmTPfdFPvgVUCEw6QJUXQp?=
 =?us-ascii?Q?yxReJgPjebKg7JItjpH456U4mYxyIjn9feLpW8xkFlBIjoar5iUvBbP/1prm?=
 =?us-ascii?Q?OakZFeuIi7BB2pCZv63zmMEibEir0BQ65e7TNOVO9nFWHLParpIVltvdZYOi?=
 =?us-ascii?Q?XQSD2UDdweIw3fe28CrpZinJhkvwaQ6UMdm2twGyGL7cDdSik6v3uYUYpdt5?=
 =?us-ascii?Q?t2GLX1zdoHq1Y73ctLDGE5Lnvee66CZJubMIWttl3a7lHqGo5inr7kn36SzN?=
 =?us-ascii?Q?N4qcMIliLqvLS15l+4sDp3UPM3WePnSJt741/hFI7By/crBuzZrjsjmzX37M?=
 =?us-ascii?Q?tydqG4XTndJED57uIvGal0NGb52Qyh1ev2JJrS8m8JVmVNhMmZt6KssFPGrX?=
 =?us-ascii?Q?WrgkLzLfnutHW0SvY5024TV6Qb2mSDkxrm2+aunSox9aNwJUFhTok4TJFzy5?=
 =?us-ascii?Q?CDSx3NhDzRxEQDYgL6aJQCcSMejuOq7DQ6+JKa5roUTQp1T6FrwTrDj3jtt4?=
 =?us-ascii?Q?/IzjWXuSa9e7omOSdKgzuPllJuu15DTfVcedloCiLcYvpyp9qgUo0b/jVG05?=
 =?us-ascii?Q?nZeD8C4JOiTtNAR1VJfK459xjnk25h2A3jYDyYE/9qm+Va7hq+LTkVy7eVJ1?=
 =?us-ascii?Q?na6k5W/owXYZ98QdnfQDpXNn9CwDZW4g5EdvYo90oluQc8RHbPdE2jkQ+0GT?=
 =?us-ascii?Q?YOBR920exyCy2o7uelXYGP0AbgzLfyDXYAZFAy0RR0sqbG0zCINwWdxQxJS4?=
 =?us-ascii?Q?ZVPd0vaaRhZX8vI9DVEQKuohU5i2wiAzHTl8pYXtF0LEveKcevVz6DdfrY7j?=
 =?us-ascii?Q?P+jTrHUQa8Cu/S0ynOqUHsErDx08F/7ypOg4Q1nuoIdo203V/N9owddsG8eW?=
 =?us-ascii?Q?sxBwg61tC/iCa380CMqYEiQbBTVTgIkPP9W6VRJU3tcHNQC/KwykCh/ux/DK?=
 =?us-ascii?Q?eFnNvg4H1+Z/Ev1h9Dj/f0OadwHhTcgQgG/ccLB+X4rp9VmfcuSYV5NNUkRc?=
 =?us-ascii?Q?bD2uyfTjivfrxpHmZMsqFPsClivrIDdJEKuujTUQYTxb+ge7JnWS/2lFeKjD?=
 =?us-ascii?Q?DGU5KbMsxnpe5YCs6hqNKpc5VMJak8evZwnpGdwQHkM3DzdvkVI19Sjtqq3O?=
 =?us-ascii?Q?GdomFZoHtEalHzpRRUkG96Hwu3vqJqxjI6BPFoQfJHEc1t8SsFTat94J6JL7?=
 =?us-ascii?Q?R8hm86dasbokOrtvIU2ObC2eDP9ybcPRY6UekR7H2HtzEvZrw9np/DZBberH?=
 =?us-ascii?Q?Waanqpl1k2C2CZtyb1Q/5rb6IS5zDKBQwd2N6eOuNXLul8WqiVB8b+5YzEKW?=
 =?us-ascii?Q?XA+2BX9c5pdbmlKOlEuLe3eWywVCYOsuJc4dR6Hzhch8YwukCpjmccq7pm3j?=
 =?us-ascii?Q?LprjaHQCqrq2WtKpJutcUqAHbEmV95pHE9J2aZgialfa9RVdFR/P124QSEmI?=
 =?us-ascii?Q?RmgByiAWb7MGyD/DC8AO2pCPZPoPrMDfGaqTOPir?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eea13f6-d46f-4756-bc80-08da8f19e44e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 08:37:39.5071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHRLZKpMsOoHpKJ1dPsvM78HnmOfxKecd1B4BiqpUiItD9+VL84g2nxSFWmtlSibcE7nPRrj/K6zWEGmqEfT4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 03:33:14PM +0800, Vlastimil Babka wrote:
> On 9/5/22 09:06, Feng Tang wrote:
> > On Mon, Sep 05, 2022 at 02:29:51PM +0800, Vlastimil Babka wrote:
> >> 
> >> How about get_partial() instantiates an on-stack structure that contains
> >> gfpflags, ret_slab, orig_size and passes pointer to that to all the nested
> >> functions.
> >> 
> >> Would be similar to "struct alloc_context" in page allocation.
> >> Something like "struct partial_context pc"?
> > 
> > Yep! This would make the parameters passing much tidier. Will try
> > this way. 
> > 
> > More aggressively is to also embed the 'kmem_cache' parameter into
> > it, but this may make the code look ambiguous.
> 
> That one is used a lot everywhere, so it would be tedious to dereference it
> from a struct, and also might be a bit better code if it's in a register.

Got it. Following is the incremental patch for 1/4, which uses the
'partial_context' to pass parameters. And actually the 4/4 patch will
benefit more from this refactoring, as the object initialization doesn't
need to be separated and has race issue.

Thanks,
Feng

---
diff --git a/mm/slub.c b/mm/slub.c
index 82e7bd3a3966..7497fb6ca8e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -194,6 +194,12 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif		/* CONFIG_SLUB_DEBUG */
 
+struct partial_context {
+	struct slab **slab;
+	gfp_t flags;
+	int orig_size;
+};
+
 static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
@@ -1333,7 +1339,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 }
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
-					struct slab *slab, void *object)
+			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
@@ -1342,6 +1348,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 
 	/* Success. Perform special debug activities for allocs */
 	trace(s, slab, object, 1);
+	set_orig_size(s, object, orig_size);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
 
@@ -1610,7 +1617,7 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object) { return 0; }
+	struct slab *slab, void *object, int orig_size) { return 0; }
 
 static inline void set_orig_size(struct kmem_cache *s,
 	void *object, unsigned int orig_size) {}
@@ -2042,7 +2049,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
  * it to full list if it was the last free object.
  */
 static void *alloc_single_from_partial(struct kmem_cache *s,
-		struct kmem_cache_node *n, struct slab *slab)
+		struct kmem_cache_node *n, struct slab *slab, int orig_size)
 {
 	void *object;
 
@@ -2052,7 +2059,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse++;
 
-	if (!alloc_debug_processing(s, slab, object)) {
+	if (!alloc_debug_processing(s, slab, object, orig_size)) {
 		remove_partial(n, slab);
 		return NULL;
 	}
@@ -2071,7 +2078,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
  * and put the slab to the partial (or full) list.
  */
 static void *alloc_single_from_new_slab(struct kmem_cache *s,
-					struct slab *slab)
+					struct slab *slab, int orig_size)
 {
 	int nid = slab_nid(slab);
 	struct kmem_cache_node *n = get_node(s, nid);
@@ -2083,7 +2090,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse = 1;
 
-	if (!alloc_debug_processing(s, slab, object))
+	if (!alloc_debug_processing(s, slab, object, orig_size))
 		/*
 		 * It's not really expected that this would fail on a
 		 * freshly allocated slab, but a concurrent memory
@@ -2161,7 +2168,7 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-			      struct slab **ret_slab, gfp_t gfpflags)
+			      struct partial_context *pc)
 {
 	struct slab *slab, *slab2;
 	void *object = NULL;
@@ -2181,11 +2188,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 		void *t;
 
-		if (!pfmemalloc_match(slab, gfpflags))
+		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
 
 		if (kmem_cache_debug(s)) {
-			object = alloc_single_from_partial(s, n, slab);
+			object = alloc_single_from_partial(s, n, slab, pc->orig_size);
 			if (object)
 				break;
 			continue;
@@ -2196,7 +2203,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			break;
 
 		if (!object) {
-			*ret_slab = slab;
+			*pc->slab = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
@@ -2220,14 +2227,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 /*
  * Get a slab from somewhere. Search in increasing NUMA distances.
  */
-static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-			     struct slab **ret_slab)
+static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type highest_zoneidx = gfp_zone(flags);
+	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
 	void *object;
 	unsigned int cpuset_mems_cookie;
 
@@ -2255,15 +2261,15 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
-		zonelist = node_zonelist(mempolicy_slab_node(), flags);
+		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
 		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
 
-			if (n && cpuset_zone_allowed(zone, flags) &&
+			if (n && cpuset_zone_allowed(zone, pc->flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, ret_slab, flags);
+				object = get_partial_node(s, n, pc);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2284,8 +2290,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 /*
  * Get a partial slab, lock it and return it.
  */
-static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-			 struct slab **ret_slab)
+static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
 {
 	void *object;
 	int searchnode = node;
@@ -2293,11 +2298,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	object = get_partial_node(s, get_node(s, searchnode), ret_slab, flags);
+	object = get_partial_node(s, get_node(s, searchnode), pc);
 	if (object || node != NUMA_NO_NODE)
 		return object;
 
-	return get_any_partial(s, flags, ret_slab);
+	return get_any_partial(s, pc);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -3022,6 +3027,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	void *freelist;
 	struct slab *slab;
 	unsigned long flags;
+	struct partial_context pc;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3135,7 +3141,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 new_objects:
 
-	freelist = get_partial(s, gfpflags, node, &slab);
+	pc.flags = gfpflags;
+	pc.slab = &slab;
+	pc.orig_size = orig_size;
+	freelist = get_partial(s, node, &pc);
 	if (freelist)
 		goto check_new_slab;
 
@@ -3151,14 +3160,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
-		freelist = alloc_single_from_new_slab(s, slab);
+		freelist = alloc_single_from_new_slab(s, slab, orig_size);
 
 		if (unlikely(!freelist))
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
-		set_orig_size(s, freelist, orig_size);
 
 		return freelist;
 	}
@@ -3184,7 +3192,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
-		set_orig_size(s, freelist, orig_size);
 
 		return freelist;
 	}
