Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386E3592AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiHOH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHOH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:28:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784C17E38
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660548522; x=1692084522;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2JeMOR1jDzTC/3p7z8hg/XgVtzMB4+FIUIvuwSdZb9I=;
  b=UCqDZoS8c4BlXoNpgmLLUG+ydJB0+Wv24jKG4x2e+g0bnG0pezgSoKUd
   uxslBVBpwMMSjhCHpiNeGOMtwdDXUvb4SZ1XTyBW+/0lkLHjOd/OHR1Ye
   J7y0kBsQ9BVhIawSMn1LQjrU0jk63N+vg8EPYSGACmDHXLYKsAu0WI0Qc
   F/AzdCohCfblzh05/EjWksSCy/sMHRo44xbQ61B6IRyAGo6JWHcYoAQGw
   j7vpvBsG8v66SDMr31sShGiM2W2Py5AjGVUfLlIHo7Wqsq0j5JM2davER
   xyHPlpOVdh1iobBl/emorm5CEbJfMprAqjuq3K+l6s5IL91sMYZW+k3VT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317890935"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="317890935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="557202926"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 00:28:37 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 00:28:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 00:28:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 00:28:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 00:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj72PO1Vkv1EbPRxA9BX042jv6YhfnUqxRNv8nWSIvzDxYJ2A1FcvzBNqpZF6RWWvwo/2chFHSXOnAGKt2O26mBWYowNoJQXV6YglAGDsCS68LfiUPXaS0kU9ZxQ6WjQDgeJimt02ok8Nn7TvH3u7ZlS4879gyDHPZCjeRRmKSTakRZuW0Fda2d2euLogqSYyApRyGi0WyPniFTNpjyHbPueSLMSQ4QfvqDJa32fyh7LC7vzIWQW+xdwKPUMtlwdlfQClSBx5SclW8GkxtPRq+wgE5tMavxPJgn8+jeZCvn8pUH55i1+DnvML5HU09l+R++83r+HIH3NaNT+D16imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i96hzWdXJYBpSfRb6FS1KmMq/y401ujKYeYzvItPrQk=;
 b=M6QCO8tGyKHBs1Ro7dQsM6Bwp6OgP1T7jBV135Y4d/VkJz70VzBUnW9MrP/vebovtlO0sNZSCl6rzkkXhEVGuLCEcAsTAbF6PmQHU9NyRcvstwfHwTOLf+M+us2LugHdX615tIsE8e4q8ttTKjeFcASW7MLPPgmB6SmKwJRU0v/cV1DQSNaWQjpINiMOMo+aqOloc9yKQrPZ/DKa4iha0qolbya8zZQyrHhJlf41a53jJU7UO4LmgOXuhhsVm9CMMpD+jvDzwJ0cMmYOXFlolAtJUvgg5P+2KkHYd+0wgFmtnNtsxnOrMUBHSlXg0jTyNxra1bKXX8VqNTJ/tANHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BY5PR11MB4209.namprd11.prod.outlook.com (2603:10b6:a03:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 07:28:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8%5]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 07:28:34 +0000
Date:   Mon, 15 Aug 2022 15:27:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
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
Message-ID: <Yvn1b8y20Mr0gfUQ@feng-clx>
References: <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl>
 <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz>
 <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
 <YukoZEm4Q6CSEKKj@feng-skl>
 <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
 <YutnCD5dPie/yoIk@feng-clx>
 <CACT4Y+Zzzj7+LwUwyMoBketXFBHRksnx148B1aLATZ48AU9o3w@mail.gmail.com>
 <Yuu6B0vUuXvtEG8b@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yuu6B0vUuXvtEG8b@feng-clx>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb14b16b-c25c-4ae9-eff4-08da7e8fc2f5
X-MS-TrafficTypeDiagnostic: BY5PR11MB4209:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFwb54clbkaA5tKjHZhbjoclQ5OGQUuZhSEum/zALXarALL692QVh36qJ6OCh95ATwwqARX62TmL8rZWb2zre8I7oQZhKRkaNbImeob+FvRwvFGxq+Jlpsele0ZltVlK7pdb+2Waee5ngGSW12RWcmmlx9IkdeehJZPqNC5S7y/z2LaiJf7A/zsfsVfeBbddMTZftWm2nsUB8JXGjI9+/TR4FfVTLYkamhc/U2wkCstNQ1qFQ7yopgM8J06O709VqZxb/XG8PPXoMd2AnTYoSRrR5dgLODAWEmkdzr/gCd5RVoshz2mkX5h09VDM3Z1QiPXygYAAPfszMia82OQsvnoqql7yKmAQGqQWYIHmCwvKgLOfe4JmBZdGBj5uU7uMV4XamyOMBFb7QKODWgPM2I/kNgIdBaXm5767SHPo0vqJBOwnTtW2D/7dIdsbnZc1fjynUi+rylpSWkELfX5v64S7LZ10PJkVc/8vUYi3edU6KgckMhXlaGVGZFEmGFI0YQnn+gmWB/rtBBMPG16a36es3C2BH5ATzN+w4Z8pw2SddKChj/l5dcLO/F+FF83vGEWxe0qFxrc/oqr4cIz6eohgsGj/inbw0EQqMiMmeVuEkYWd4bOjsKQhuIYx2DgwOTO6LpxIUhzw9c2RYe57OBJXn4oAUx3qgS3mPCZ1D7JJyulj6U4ry83E/YyaSPEIE/2lBMVhvnYxMEEw0cIrx0dYswPbfzyWWdJuZHeyEZzBamNkQiMH2JfYPnikOKMMumb0X95Xqp/S1v8MKDgskQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(33716001)(82960400001)(186003)(6486002)(478600001)(966005)(38100700002)(6512007)(316002)(6666004)(41300700001)(66556008)(7416002)(44832011)(5660300002)(6636002)(54906003)(26005)(2906002)(8936002)(9686003)(66946007)(110136005)(66476007)(4326008)(8676002)(53546011)(86362001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VFOBn4+PrKRqJLiqVU72sa8W1G6+Pvb70ly6Wn0NrNY0fZeOmA2QOJKHjW7n?=
 =?us-ascii?Q?1qN2cRNuAGapUvv/KMnQ7lJuRQaE6MjURwBl+pD7t0GfxTbTdjqbW3lvPY4O?=
 =?us-ascii?Q?E9w4J5OIXmuA4uZqJJvGu9+YVUdbCOsRTATPiFCefgsa4qwzHD2KxAHKzDE+?=
 =?us-ascii?Q?1h2/RpWl2MOXLVptRh2NwcKHsVovKnMIO1BuD0xY+Tkjj5eAN/WZ56lARLba?=
 =?us-ascii?Q?yTmjHmFEp2y+0mZ4DZjvJ/u2rzUp5dn/LO2Q+VIsQhm9FxfED9KzfplGJ5AS?=
 =?us-ascii?Q?XfMxIOjpTDlBbXTlS10T/+tOhp3OB7PLYdlPqjYe7lcsM9njBlrvy6IQNl5o?=
 =?us-ascii?Q?0orGXbBm0GhjmDcyqJ4+7uLS9YvzJj2eeX0pWjYVF3ndpHT+KNTCxe6pUCfM?=
 =?us-ascii?Q?DhJEnYBOQ6VVz0wPBIhk9p0W3lVrfJmim3eVfwr2rD8YCY04t9kdvfjY46oE?=
 =?us-ascii?Q?Z6wPSigMZ24n5Y+nyMfOXkNIR5EiFUiEFgujhOlc/0hB6hhZJ3sLRaVwT9O7?=
 =?us-ascii?Q?rk/hu66i13r6omS0puwzv57LqR/2ZuVfsm6GBpnS8JMBmC2CDLcqcbU5MMnP?=
 =?us-ascii?Q?PI4NKRGj9DldJS/sM32EzXtdtzH5o47Yyi0EI2iEu6DUBQTpo3my1/aR3Md7?=
 =?us-ascii?Q?AEFjMhFMzfn0sZVmYJuti5Dwyz2g3diBd6T7C4vpN/VWWXgRBgwWMuIgzUrw?=
 =?us-ascii?Q?dWDK6hDgNDrqnJwyJAqDdW+zJtoGqtvA83aLkBZ+EnHb+hQR6rbJTvv7RhvZ?=
 =?us-ascii?Q?qUJX9HN9GijosjN+E90AxGUzR2jSOnClgwMStv001z0vI2fV1qBOWUMkjMlW?=
 =?us-ascii?Q?tgf5/AhXrJeMRG0e8KREYt95jMHBig/pDM14sZAyqlSFERXvdg8MUQguRq2K?=
 =?us-ascii?Q?ejmync8ARcOW4rMZfrEa5ltzr96SX79bV9OeHBKU/lROlYO9njPLyN/R3oc6?=
 =?us-ascii?Q?nZ6bcnX7M/nFE7l2gS53yeQJbR120y23aP8ltAme4ZCkYYwupy6qFc4fvZUr?=
 =?us-ascii?Q?FQX/5OJMItI0rJnOb3wIDnsIzkjXoBvKapkDeqnRP2pxzxWZt5zzt8Sb4aO0?=
 =?us-ascii?Q?be0JsnPJZQo0+xib5Pj4yRgaPT3RHNlxYcQSFLKIQYPC8PaZW+sziPgxyMmM?=
 =?us-ascii?Q?imRu7lTRDgh32XrVmfHiT8wh+/k9lJfTdB6fVU2WT6MIwt2DGBs31NGcumUN?=
 =?us-ascii?Q?PBEU00VfyiWrP11WqHDtAs8dUDNlhpKuVBMw/bJURKHlPjBpbmKVzuPto511?=
 =?us-ascii?Q?mNMZTCS/SUMs7dh2p4brqrufLveC97AK2fYRIF/qPOgozWgyNIlEIbR26w0C?=
 =?us-ascii?Q?1w1sL2hmkka+Ix1i8Be+vbJLxJPYi1LtVYs0zhndwesiGSFMasIq9DuDqYHf?=
 =?us-ascii?Q?Zj+qJt8Iz+ONIN01WQi9iA5xSA4GCpp+4BP3HG4vCUP/L7dis2no+1mapJtB?=
 =?us-ascii?Q?LPL4n/3bcboLgLRApsKlzvR8u+ISdcGcx0mDpBMeU2woqGEh+zJD/MMO/rdR?=
 =?us-ascii?Q?mAklceddkAPfkWBPjp41FQdO3Su1R2Idlnw9pCFYNCojj4gfYzAAMjAjnAMZ?=
 =?us-ascii?Q?sNv/6smZlZHdmHMgoOm5Kb6rBL8YbjUVQtvb2b8z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb14b16b-c25c-4ae9-eff4-08da7e8fc2f5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 07:28:34.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31kFIIYbtEZcsjCHbXJQD73TptLLDwguL8W5VKJAbfqX4lp+WXLbSFGkF5R/5pvm8oYhZI+Owtgd/KcnOCmQsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

Could you help to check if the below combined patch fix the problem
you reported? thanks!

- Feng

---

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b092277bf48d6..293bdaa0ba09c 100644
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
index c40c0e7b3b5f1..9d2994dbe4e7a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -200,6 +200,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
 			*size = ok_size;
 		}
+	} else {
+		cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
 	}
 
 	/* Calculate size with optimal redzone. */
diff --git a/mm/slub.c b/mm/slub.c
index added2653bb03..272dcdbaaa03b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
 	if (!slub_debug_orig_size(s))
 		return;
 
+#ifdef CONFIG_KASAN_GENERIC
+	/*
+	 * kasn could save its free meta data in the start part of object
+	 * area, so skip the redzone check if kasan's meta data size is
+	 * bigger enough to possibly overlap with kmalloc redzone
+	 */
+	if (s->kasan_info.free_meta_size_in_object * 2 > s->object_size)
+		orig_size = s->object_size;
+#endif
+
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
On Thu, Aug 04, 2022 at 08:22:31PM +0800, Tang, Feng wrote:
> On Thu, Aug 04, 2022 at 06:47:58PM +0800, Dmitry Vyukov wrote:
> >  On Thu, 4 Aug 2022 at 08:29, Feng Tang <feng.tang@intel.com> wrote:
> [...]
> > >
> > > ---8<---
> > > From c4fc739ea4d5222f0aba4b42b59668d64a010082 Mon Sep 17 00:00:00 2001
> > > From: Feng Tang <feng.tang@intel.com>
> > > Date: Thu, 4 Aug 2022 13:25:35 +0800
> > > Subject: [PATCH] mm: kasan: Add free_meta size info in struct kasan_cache
> > >
> > > When kasan is enabled for slab/slub, it may save kasan' free_meta
> > > data in the former part of slab object data area in slab object
> > > free path, which works fine.
> > >
> > > There is ongoing effort to extend slub's debug function which will
> > > redzone the latter part of kmalloc object area, and when both of
> > > the debug are enabled, there is possible conflict, especially when
> > > the kmalloc object has small size, as caught by 0Day bot [1]
> > >
> > > For better information for slab/slub, add free_meta's data size
> > > info 'kasan_cache', so that its users can take right action to
> > > avoid data conflict.
> > >
> > > [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > 
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
>  
> Thanks for your suggestion and review!
> 
> > I assume there will be a second patch that uses
> > free_meta_size_in_object  in slub debug code.
>  
> Yes, it will be called in the slub kmalloc object redzone debug code.
> 
> Thanks,
> Feng
> 
> > > ---
> > >  include/linux/kasan.h | 2 ++
> > >  mm/kasan/common.c     | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index b092277bf48d..293bdaa0ba09 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
> > >  struct kasan_cache {
> > >         int alloc_meta_offset;
> > >         int free_meta_offset;
> > > +       /* size of free_meta data saved in object's data area */
> > > +       int free_meta_size_in_object;
> > >         bool is_kmalloc;
> > >  };
> > >
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > index 78be2beb7453..a627efa267d1 100644
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> > >                         cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
> > >                         *size = ok_size;
> > >                 }
> > > +       } else {
> > > +               cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
> > >         }
> > >
> > >         /* Calculate size with optimal redzone. */
> > > --
> > > 2.27.0
> > 
