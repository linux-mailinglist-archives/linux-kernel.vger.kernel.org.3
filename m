Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E24585674
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 23:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiG2VWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiG2VWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:22:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E528BA99
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbCje0mi9ANXsfXr28nLgoRXaZObiInCbqbdKyxTf42dB946ZjESkjxqlJR+Gsqy1yQSHOOHIq6GNu9+WAQVBoToj1xzA9XA04MUvb5CHlJEPRCqDKFfClYVuDO7S3X+TL1loJfEoxue74DVi2bNISdnr3sJ3opdnMYsrNyFGbY6tPKK8zSO0I7AFKmtk8dpkKhM/Oha3FRv8Z5CygEwwGnrzvgTPmORatxvbA08/MiD+IU66RBiTEYbZxoMfILlcvnTpuWXdcotqQMiKOlKGabarEiOwXsXZCLaDWVL3IRw1cjbBfhwmVK6QDnVE6oZx7OEIFY+/ipcJKMmADvWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP1Zotrer1eDw/FxVIN2GehhwCHGRN1OEKxKwEyKyrw=;
 b=Szk+6gd/kjCyppw/7vNJXqf9LsUZ//K1lVUjm5zfzfyYHDh9bPuHEARloXJALvm5agwroHGRyIYFlozAKU1u4kTKRcdCR6qOu70FhCioCzJwIEi9t4nYdSG1r6jRrEXDHSivdSe6DlQ4n9KgyEpokGw+pYyv/WVa4fJvIfSbmjhoObA4wQyYdh3TJk+rXWhEwwO6EtaYVnJR7xupe4irbMxXQxbccuqRhjf/AKPuy9ToLdT4R77PMRqVNXwUHHafF/6GcYMZmSyJgoWNtmn79jOTJxAgkqKEaoa7fHi9ZZxurZwjcZ0mLCUjZrRmnpdT5E+6MGRodNub0HCocFsZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP1Zotrer1eDw/FxVIN2GehhwCHGRN1OEKxKwEyKyrw=;
 b=gUjsQjBqyDxff4uar1ftRT6H9vX/lQwww6GdWW12YsXwQpjI9+1g1eCXR4uGQFI3RUm5sttyauB3o17f+5fWN9pQ5MbPkk4/3WfZc2stMX01iKfa35/GUM3zJoRv8fs5wUs1RdvhhbNIKO22kYEe3W1VxyvkuvLb2/nGCtgTLhLevxL2XsZ4rB7ijSrzG+/bsSRT+x+khZ4CwOX4Xmq9aPC78MRtx3RkgfZ7TKtiEvT5ODGWizyk5MtJXwi+Uo3W+t39/Jomlc01ckdM4aREwBXoLlTzrd4yj75aClXcEbn/DA8iccfdT7PniB9hjgei2Br+7nVZ33+45GfU8pxHiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB3910.namprd12.prod.outlook.com (2603:10b6:610:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Fri, 29 Jul
 2022 21:22:05 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::ad32:9c8c:9142:df53]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::ad32:9c8c:9142:df53%4]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 21:22:05 +0000
Message-ID: <8f1f3278-ce9e-e328-6a8b-a793bc7f950f@nvidia.com>
Date:   Fri, 29 Jul 2022 14:22:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
References: <20220729024645.764366-1-apopple@nvidia.com>
 <YuQ4mJqjIUncf7iF@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YuQ4mJqjIUncf7iF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22da4c70-559d-417f-131b-08da71a862fb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRZHGrMwY7qtMdVVsC6BHn/TPLYDWSKRybUnRiaRHugpNc8tXbVyiR3pQTvng85DctbMKcy/Ldn9d/aL8IQvJqeH4QESUzI8dfPFL6c3czI8iortdA4PY6ii4g7kqDEGhrdYQZeFOi3EVN9pt0ym6ivvNvhDY2qQh/AoefClqNPQ253dkN8aKjFZxU7D3qoQus5bHVnKcG9qiJC0T9zRCxCPchup7graGBdu/AKHhvOaMEJsr52B19RHIxIWFf60PCJG+OnezSc5k6pinzkOLnd6ihqAYe7IIw4yc7GAGpAmaXZo4VGLpDLAkOIAzhHuCLVq+tO4cWZHiSf4OgR1ID72VaZn4ZRq/UsZeSMR2M4p1gmkTYXWNIyIqhAIALYCXth/+TsC1Mxjt19benuhgTHnRuWaFipSNzoSQ/MinDeP+jSdivBJKnXG2C+k7dYtYC3qlt/8dVOl+spejnOIs7rh0QtaRoenVJl04KBzYjzA/Jpg5CDy3kMM3TwsPPmiff5vcmUW0G9oh/FjpDskIeORN1E8KkFntsrMhGsLJKSoMc00lQ/jFZC3/rwG1sN9dpGrrKV5foLFETuhXNP4Kw1kTf7H/kY90IaDDN4tOdaVNBZOXij/jgJvzQiNqjhMh3zrLdkmG4uPegI+3qRg6IGc8Mndk2v2L84wu28dHt16+HUGbPO7xh6oWbl8hvlGkjrmzm1GUPGYHCxITQVEBJt2iVSc36xiltXr6l/ZmwhB+1c34mvYYiP/aCmH5yJ3kFVf5LmijvieqfywterXxMMDSXz+4dmMhuvtioxAapVtvg8/yTzRtFpcgmQSrSdnBpY+HBa45DNBS1J8YO+94Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(38100700002)(316002)(2906002)(8936002)(86362001)(36756003)(31686004)(31696002)(41300700001)(5660300002)(83380400001)(66476007)(66556008)(4326008)(478600001)(110136005)(53546011)(26005)(6636002)(186003)(6486002)(8676002)(2616005)(6506007)(6512007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak9NMUNmaktFWDFyaTJ6cENXeHVmMWVsRE1HZXg5MVl3czBGNCtuSlpoSk1D?=
 =?utf-8?B?K3A4TzRXRHlWQlk1VU1qZkRhNVpNTm9vL2t2bkNoVHZUNEhCQW8zKzJPZENx?=
 =?utf-8?B?c1ZGejhWaXFtZmJ5a3ltSkdFS05Dc3NCeHBlK3NoRjBwQXNKZ2RqV2srYlJj?=
 =?utf-8?B?ek5ZUDVqc2lkbHQxU1hqOUlWeHRTdDYvcC8yMW1wdzFYb21waGFVRk54Q0ox?=
 =?utf-8?B?WktISU5zQU9tZzlNR3Z1bDZVaHdyNTNpaXZsUUMyV0dXVHY3ZWxBalh4Y09m?=
 =?utf-8?B?TWluR1ZRZ1pGNUFYcmk1T3RXQlZ4ZTdQRkNJQjBxdGZ2Q24zd1Z3MGh4YkRX?=
 =?utf-8?B?bTR3cFRpNFduaXBwSm12alcxY0daU0F1eUNGWmkwY1hEeVY2VnFYaXQrcnlr?=
 =?utf-8?B?d2liWXl3RlJqTnpRWWM5Q0xwL29EblJRSlV5c1M2TWxtOWwrTWMyYzhRcW1q?=
 =?utf-8?B?ekdVMEZZRlJkTzl3Szg4bHQ0a3NuN1M0VkYwU2ZsWW5JM2lyTXJ0UE8zaXkw?=
 =?utf-8?B?dm5rczZHbGE3RUs5blpab3BpV3cxSzhsQndHencwNXhKMHd5b0ZnRVF0VC8z?=
 =?utf-8?B?ODVPQzM5ZGI2VERaT0VKRHlJbVFtUGx1K2t5cUJEWW01UEdicmJVajg5YkFY?=
 =?utf-8?B?YkRMQWYzTE9Ec0o1aHZFNGlXblpySnpRbGcxMzRRRVlsMzVnRWRYbHBZWmZi?=
 =?utf-8?B?M3M5cUNNblRZdmxxTGlNbXExeGh3WjVERXl5U2FyY2NwT1g4UllUdVMwaDNw?=
 =?utf-8?B?ZG9SdnBLdW5ZajZIejA4b3F5VGYyQnpQZG1scmtQc0cwLzdiaXRjRjArODkw?=
 =?utf-8?B?dlU1dCtINUlqc3JWUkEwQlE1VjZjTDhCTHgyRjJzWGJFZzM3SHRHQ2tXK1ow?=
 =?utf-8?B?b2szSld0ejlsNFRLR2FrL1NmZi9oRzQ3ek53bWFMeUNKaXk4Y0FuSGR0cGlU?=
 =?utf-8?B?bi9nK0lEZVpDUm9HVVlwUDJMSFU1L2hGYjFIKzRra2hSUUswRWVSNlRoR1Q5?=
 =?utf-8?B?ODdTNk1ETDFCdDVPazRlbVJ2MUEzdzFUKzg5eUtqY0NtOGlXZWtzOEE0aUlt?=
 =?utf-8?B?THdpbldENGoxOVRhYVBEMnBhdDdTRE1Fd2hKS1k3U3hCNnVPc0k1YTc4NkdO?=
 =?utf-8?B?UUgzTjlkK3RJT3lndlNxWkxYVkRWWDRrVlliRjJ6YVhjODI0UW9KNFV5Rkg4?=
 =?utf-8?B?RnRjY25ocUFhK0RCdUxvTVVLYzgySnUzRHdRRVJrUEVIcUpMT09LMmxBSS9m?=
 =?utf-8?B?WTN2VHZ1MjV4SnZhVWc2NVFXSGtVTHcvU2xyVitHUTFic2VvMHZRd3NRU0wy?=
 =?utf-8?B?ZENnenByZVBLWU9Xc3JIYzdEbFFIaU5Zbk4zN2syUVdEbjJUUVNMVFQ2Y0Na?=
 =?utf-8?B?Y21MbDZzaERCODNrcUE2bTQ2cGkvMldjdXdyazZnTDcrZUFBenAreXJ4NjF3?=
 =?utf-8?B?cEJQTGd4aVdLZThSb3pxTjYwK1VSWGEvR1ExaXA4QnRXeDdoYThRWllEcjUv?=
 =?utf-8?B?aGxjYUxjUDlLNktKZWRGZWtCajJLWXpPNUNjcytWc01TN3pMRkVaZTVVMlRs?=
 =?utf-8?B?dk1CSEZsU1lHdllmTWZxVWg3QllGaytaTzMxaUh4RWlaWk9PTktoUkIvQWtT?=
 =?utf-8?B?UjkvamNYc3hDdUQvblhIOTVUcTN3dDBIQWhyN2ozSVJpRlRueTBQZkMvUzky?=
 =?utf-8?B?VGdoekg5VkY1K3hUc0wvNEluQTNLZERNMFJqaVNKMWZ3T1pMTEZXWGFQVHBu?=
 =?utf-8?B?MW52Q0lCU2FqNWRML1l0V0d3QzZrY0UrY25LNUhHdnYybWdFeTY2bkpKSzJW?=
 =?utf-8?B?cFg3bGVUWUVmL3NXd3hvRlpHSkorbWUxNVE1OVRyTGhSTFZPejhQQXBvVDNo?=
 =?utf-8?B?S0VtOUxqbW9JWlFmeUlMaGgyTnJIdXVGS2QxVk5ZQkhCcDVDMzVFaW9xcEk0?=
 =?utf-8?B?VEZoUmk5VFV6WjdBK2VIWGdHR3poZXh0a2FhRmJRdzhiMEIzN3hBQjNHeXZp?=
 =?utf-8?B?SGplR1pwRFlTVkFjU3JZLzhOejRzT09GZFEwNER6Tk43TjlsYUtlTDBMZzM0?=
 =?utf-8?B?TEw3UUh5czJRQVRhc1N5RktJMWlpOXFmUHhqcFkxTGdmM0tkRUxrVWc1aHF0?=
 =?utf-8?Q?Ssddk4K+8s5EyHaIz2H5Q6juo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22da4c70-559d-417f-131b-08da71a862fb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 21:22:05.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7BQXN33S3AokZj67CWNVVbqP43NJtbhyqm0YQiZ21W8w4Vd0DBmiHsrws4Sw9S02+cJJf1n15GJoVqnyxMOGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3910
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 12:44, Jason Gunthorpe wrote:

> I came up with this ontop:
> 
That cleans it up even more, looks nice. I'd go just a touch further,
and also (unless there is some odd reason?) stay with -EAGAIN rather
than -EBUSY, because otherwise both the function's comment header, and
the caller, should change from -EBUSY to -EAGAIN just for consistency.

And also because the way it's used: the caller is literally "trying
again".

So on top of the ontop:

diff --git a/mm/gup.c b/mm/gup.c
index 43c1fc532842..5f04033ee0ed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1901,10 +1901,12 @@ struct page *get_dump_page(unsigned long addr)

  #ifdef CONFIG_MIGRATION
  /*
- * Check whether all pages are pinnable. If some pages are not pinnable migrate
- * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
- * if all pages are pinnable and in the right zone. Other errors indicate
- * migration failure.
+ * Check whether all pages are pinnable. If some pages are not pinnable, migrate
+ * them and unpin all the pages.
+ * Return values:
+ *       0:      all pages are already pinnable and in the right zone
+ *      -EAGAIN: some pages were unpinned or were zero
+ *      -ENOMEM: migration of some pages failed
   */
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
  					    struct page **pages,
@@ -1914,11 +1916,11 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
  		.nid = NUMA_NO_NODE,
  		.gfp_mask = GFP_USER | __GFP_NOWARN,
  	};
-	unsigned long i;
+	unsigned long i, not_migrated;
  	struct folio *prev_folio = NULL;
  	LIST_HEAD(movable_page_list);
  	bool drain_allow = true, coherent_pages = false;
-	int ret = -EBUSY;
+	int ret = -EAGAIN;

  	for (i = 0; i < nr_pages; i++) {
  		struct folio *folio = page_folio(pages[i]);
@@ -1990,7 +1992,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,

  	/*
  	 * Unpin all pages. If device coherent pages were found
-	 * migrate_deivce_coherent_page() will have dropped the pin and set
+	 * migrate_device_coherent_page() will have dropped the pin and set
  	 * pages[i] == NULL.
  	 */
  	for (i = 0; i < nr_pages; i++) {


thanks,
-- 
John Hubbard
NVIDIA
