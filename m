Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DE594F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiHPEGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiHPEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:05:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6513509BE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQTzfmUhKkxI0Maoi63iGpQM0PpUhMWEK9sqMuJzn3sdJp+FNb+W21OZOCO/wGVp6KLY+ZABBdH5YLEHPe4pKQdGcuLLV4Hm3nftDWYZ7M6VNDBTFfFoNvXa4cYjaZC/MgA2+z8XlILl0CIu2lXViWswXwulQpcYDP4Xgc026cBemehmescA71dVV2y5zeFX4XxCmqFJiKvVb/gaMGedzeViY3fDuA14EEmHCMv7//ytAeUCa2WMr6ks7xOG5P2YSFjzQDgQXc6ToDz9eWMTu3OvdF5Q0UlHUFBztuo3QBVJKOIcEOkxoipSetrdgRtNIetIIcZG9XMiLNCcEb+j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7uP1xE86I9c4T79hZtFrgp92vctAojw930ecCs9n30=;
 b=kMmBoZRDngjy5pzhdpheCUw2L+dbj6JxvK7NYuKlsalJ+nBywDpy7VbAs5ELX8MEOpaMThtl77EZjccl2aZ6TdfBEWE6ry+FpLLwkGK1FrNRmYW6Ak1aalQiSra4MIt86S+J1MP9e2o429mttRsF3IcR+2Oi6vBfd7tj631mj/GtSQz3yn5uOZgollkba9FR0QIz4TrG18HOcixRVMnjJ6SxDAAGk7aim2nRTlPZsO/Q+B8L1DJrxOTK14g0Oc1vOzt3/WYmt5j0ci19xU+BdrWxvSPACRm002Cr7FwDuQ7Qq5k6o3RTpM+jvH/RnRkMPcWgU9U4xyDrTquGozUC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7uP1xE86I9c4T79hZtFrgp92vctAojw930ecCs9n30=;
 b=ugNHbpTciR5QVVGkcA904ebhP9EciAXNRqBYdvKON7z/+VwcSFry4UTtDhO7+OK1f+J5dN9OcVSlfgNPdwq5VIibj0KjsbWzK6P6U2P1EJB7T46/ocvpi+a1EjWPDtLW+7WziyRbik0Mbcy+v59f3OZosQVxLiLGoPLbn/PvTn7oItwqx3P9LDtoiGvEWde8tY+aY8orgb1sU14xum+iQjZaMOmU6MxtrGM5bfafRqhL64RboRt3/k3SkkWFO9HV9BoEuiUKftsX1l2l//YitAhVCn/sAnY8NOjZGF+pC94UHtrojx61S0gtmZp0PbbFx7T3jt156JTe+EOkX3g+9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 00:34:13 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 00:34:13 +0000
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815070240.470469-1-haiyue.wang@intel.com>
 <20220815070240.470469-3-haiyue.wang@intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Date:   Tue, 16 Aug 2022 10:00:47 +1000
In-reply-to: <20220815070240.470469-3-haiyue.wang@intel.com>
Message-ID: <874jydvxfh.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e240058-6c20-46a7-3957-08da7f1f0b08
X-MS-TrafficTypeDiagnostic: DM6PR12MB3721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Je6nXNzEO62FYmbOtnrDktbSbpn3QOAARJCKJ8lvCHo0WcO2UKjlgvKi7P1yLhzOi5kJ87omdnP0uJQuip5c4p3OpgOKOCyE0DFUIyS2M9wBRnH6OvbCuPgVs32XUBF6NABFYMM/6C8NDvhS23sUDdTkeVoaLiLsx4Wb4BZOT+0vYjHMqElzGYHKp/N4D1/MyPSfWbd/RvvVAXSl72QDh4/F3vJXeaRfZVTP2jAMZxlMDiT90akGJ9LEtN+MPb0KdT9WM5/OGdecWI6sH4A+q4fgVC+14liOBePe6DswGfDeN8xUhpEUfUY1OQnQjr/tbCWHL27c5OahxwDiAa+kYyB3DlQC539ldCEFdEeG4WI6/mrC6qQ5BSwNWXzdwvIZ0w4/V1wFAYvI6X9ueGXu/dO3crTAiQucL9zYxyTm9atDUFfFCAOmJqtRCZ9NyXHt1PeEpTWq5JClG9FMwfIEm+MuaWuR2yfJj1wCW77lY9PZVvi4o2WsQ1xExwezo+gTW+v9J76/6Sr6hKqCfw15cnBsGqq9/AiZSCatRvI44fwPIkGv/ZdZ9N9urs4DHY0lFa7+jWRETlRTwDpZuUGLFIPX65M/vmcN9dl9ybV549Js6ueLTH3PQChjlZARxi1Ekd1TNSzf55KdPdTAsc8lyh8J49ZFFgliIEoEK66xfVSU7nNEsOcwtNKAAsGvwbWkzIerJJg4/LThT+nrLEMyRVim7qQ5Ak/P7wTHtHHgXi5DRyZkrWuB9msXKmvtbdt8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(186003)(478600001)(5660300002)(6506007)(6486002)(83380400001)(6916009)(8936002)(86362001)(316002)(41300700001)(7416002)(8676002)(4326008)(66556008)(38100700002)(6666004)(6512007)(2906002)(66946007)(9686003)(66476007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4t0AL9hukYe36CcDOvsUbvTUCPo1jsDb4f6AujdZBR4g9prqjRn1TSVTfbWN?=
 =?us-ascii?Q?ukQIu6jMizbr4Kl4gG84kSTt6UrabjKjFSkWXsuIj/m/vu/k1Kz0d9kn/nGG?=
 =?us-ascii?Q?1L5ZokK+F2amGCvvtOiNklcNbylaSPjhvUyAL6gJYxGe36dlYSeS0n5MPzDB?=
 =?us-ascii?Q?fyQZOBLRy6EgbT89rI2jpTsR9KDtqL6q3VWfAFdHa4YICSfQEwRmguWj8Moc?=
 =?us-ascii?Q?eTTYYcqry+6WQm2IcrYpbaMR7Rl2IQaqexHqNXpI0EXNtDftwrdzuPTMUYgs?=
 =?us-ascii?Q?payuS+HyztuN0Lzt5f4UaZ7hV7WlN6EM+OBowF8R+n9XgRzYz0MGg5W9+AQJ?=
 =?us-ascii?Q?b4fsg265DJjAjou7XgOgJktR/3+Ju0ErZokNKP4901FAsYFsxhcCWL0Rci5q?=
 =?us-ascii?Q?433e44aDbrNCTDUBarHsMFY/EoT3fUNMcJ28wXjDK7QKTUyfTKsbID9SnKrx?=
 =?us-ascii?Q?x1Um4oG1d3Br6/M9mH5armAu9tEaHA8PfAUpFGmY8sMsE8OAPBAmRiqLV5/p?=
 =?us-ascii?Q?KyIRpaKsKwFPbpgdQzhToSumcWd+UgKmF4PzxWrcRJ16zbTBeE71gfh7se6z?=
 =?us-ascii?Q?BMRZ3TaxzS19pUCQCXs/IeW4o3jDWaBkX4W4xAGyC5AyWVHbo6EjJQxsqbew?=
 =?us-ascii?Q?+EM80NDa3hhuCA+jdti5NeV72PnVJlUukQr0lVHy9P7Iw5gTiNRdOPf2IZwy?=
 =?us-ascii?Q?hWY5PhZZHT3Vj10CtPjWa8RKPFrJBbGzRDHv1YfHd37VcTsmlO1Swl5Iwz5C?=
 =?us-ascii?Q?/+LqPZBa3Jjo3GKiD6JGKPl3pO+JoeEDUqo9HWoLqVJSevP6ovR8Lgck2tL/?=
 =?us-ascii?Q?AyQU4VOBMao6PPLSJSGlDXLoGTQLp1u3WSnYmp14INUZN10ZIJ0dkgTs8vTD?=
 =?us-ascii?Q?7Za5jAf1S2ACPVJaTBPwHxrOkj5adayy56ar08KxE87e1VDPvkuUwQ4dAlN2?=
 =?us-ascii?Q?iHbrQTTvH+3586hW48KrrzAt3k25u6LtkYC6RKZrkBPMzMX3vkeE5xIJMNpN?=
 =?us-ascii?Q?3Xapkx4zjh2FP7EMPS42kKq83VBTqIW6OnhvcaHRoptj2feq6Kat9xC1rp7k?=
 =?us-ascii?Q?16573RLCnlMTDaudWi3TdhCMAe1Qf2qgdzSGsjdu3VAAhOK3f3DcdrFsiwxk?=
 =?us-ascii?Q?ONgpxW2xUikGZobK2SBXMnSImePIdiDOjtIJORrDiSBRqFYW+yRSzYJfmXdK?=
 =?us-ascii?Q?kaUYq1DkXmAqMJyYxigri6WZAlz6lYBtsv4UAtzYZMhSJxyVTVMVhXik5sAM?=
 =?us-ascii?Q?9+oCuo7o5kC+3VJrCH2emA4iK2kxom9+U3hsLLAPyj/qTHi1TJth47JBVJqz?=
 =?us-ascii?Q?BNq7zjCDHuUxFRIFIvJIa7QXdT9QEQun0vbvgN9gl27LJHrTWUTeKk5Fzlbb?=
 =?us-ascii?Q?K7pZkAsZsEp2TkfmQLsifOuq3LTwB64BStVAKl8slyVUcCJFV5I83WUcTM87?=
 =?us-ascii?Q?9ma9l8+W6ukpZO4gNaLZwqeI3QcaqNp1F8WUTAeixDNfvEyClrXEYgfQ/RbT?=
 =?us-ascii?Q?mV/WExCkT/YGXjBdHYCr0Bm4QC+4r6/+cj+rB/U/00+O2F30AJrEWX2qi4j4?=
 =?us-ascii?Q?Sy9Q/mS2s87U9Fi0dL3wMOJmfimZj4FruDDUwiJj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e240058-6c20-46a7-3957-08da7f1f0b08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 00:34:13.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TSSmXlC88tuacCG672NdX2TP9v3otT7L2BvQ7Zv7vhtOSjYXx3B8J9Szphw6W/vy1ADsjbxG73CnLT+graBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Haiyue Wang <haiyue.wang@intel.com> writes:

> The handling Non-LRU pages returned by follow_page() jumps directly, it
> doesn't call put_page() to handle the reference count, since 'FOLL_GET'
> flag for follow_page() has get_page() called. Fix the zone device page
> check by handling the page reference count correctly before returning.
>
> And as David reviewed, "device pages are never PageKsm pages". Drop this
> zone device page check for break_ksm().
>
> Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  mm/huge_memory.c |  4 ++--
>  mm/ksm.c         | 12 +++++++++---
>  mm/migrate.c     | 10 +++++++---
>  3 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8a7c1b344abe..b2ba17c3dcd7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		/* FOLL_DUMP to ignore special (like zero) pages */
>  		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>  			continue;
>
> -		if (!is_transparent_hugepage(page))
> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
>  			goto next;
>
>  		total++;
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 42ab153335a2..e26f57fc1f0e 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>  		cond_resched();
>  		page = follow_page(vma, addr,
>  				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>  			break;
>  		if (PageKsm(page))
>  			ret = handle_mm_fault(vma, addr,
> @@ -560,12 +560,15 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
>  		goto out;
>
>  	page = follow_page(vma, addr, FOLL_GET);
> -	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +	if (IS_ERR_OR_NULL(page))
>  		goto out;
> +	if (is_zone_device_page(page))

Same as for break_ksm() I think we should be able to drop the
is_zone_device_page() check here because scan_get_next_rmap_item()
already filters out zone device pages.

> +		goto out_putpage;
>  	if (PageAnon(page)) {
>  		flush_anon_page(vma, page, addr);
>  		flush_dcache_page(page);
>  	} else {
> +out_putpage:
>  		put_page(page);
>  out:
>  		page = NULL;
> @@ -2308,11 +2311,13 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  			if (ksm_test_exit(mm))
>  				break;
>  			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
> -			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
> +			if (IS_ERR_OR_NULL(*page)) {
>  				ksm_scan.address += PAGE_SIZE;
>  				cond_resched();
>  				continue;
>  			}
> +			if (is_zone_device_page(*page))
> +				goto next_page;
>  			if (PageAnon(*page)) {
>  				flush_anon_page(vma, *page, ksm_scan.address);
>  				flush_dcache_page(*page);
> @@ -2327,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  				mmap_read_unlock(mm);
>  				return rmap_item;
>  			}
> +next_page:
>  			put_page(*page);
>  			ksm_scan.address += PAGE_SIZE;
>  			cond_resched();
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 581dfaad9257..fee12cd2f294 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1672,9 +1672,12 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		goto out;
>
>  	err = -ENOENT;
> -	if (!page || is_zone_device_page(page))
> +	if (!page)
>  		goto out;
>
> +	if (is_zone_device_page(page))
> +		goto out_putpage;
> +
>  	err = 0;
>  	if (page_to_nid(page) == node)
>  		goto out_putpage;
> @@ -1868,8 +1871,9 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  		if (IS_ERR(page))
>  			goto set_status;
>
> -		if (page && !is_zone_device_page(page)) {
> -			err = page_to_nid(page);
> +		if (page) {
> +			err = !is_zone_device_page(page) ? page_to_nid(page)
> +							 : -ENOENT;

Can we remove the multiple layers of conditionals here? Something like
this is cleaner and easier to understand IMHO:

-               if (page && !is_zone_device_page(page)) {
-                       err = page_to_nid(page);
-                       if (foll_flags & FOLL_GET)
-                               put_page(page);
-               } else {
+               if (!page) {
                        err = -ENOENT;
+                       goto set_status;
                }
+
+               if (is_zone_device_page(page))
+                       err = -ENOENT;
+               else
+                       err = page_to_nid_page(page);
+
+               if (foll_flags & FOLL_GET)
+                       put_page(page);

Thanks.

 - Alistair

>  			if (foll_flags & FOLL_GET)
>  				put_page(page);
>  		} else {
