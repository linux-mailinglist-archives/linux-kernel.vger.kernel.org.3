Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11689595384
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiHPHNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiHPHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:12:48 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AD1C4740
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9V8vnI7dI15dFEjyvqQYQ7dbNumlSC6J/1CUOYavrCOqKHINB0ml1W1y9i3LfomjEAfxo4efG0+iQCN5NsONQXZFQWC0QdaBfiW5rlHdLKfuCpfoc+7u9N03EIpZq3XctD3G/MRdubVBHqxl2bhX3oXYu1HSauxny6oV/SlwdHm7FfsWwJDgZu5RRbaSYBtsw2gG4E+6gRoRMs+XWjyPssiSo2VhB875XzyJlN3s7LDG9grv+h7xY3yl8+d27PP23Jxjwas7qqzeF7FTwf2tSLIRfhrYdToVyrBNKuimgCsIQwa6qPeunp8p4amVG73cu093k3Bem9L4yT61EHRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x67OEHyAO7q+gFvLoWKxmzFCxqFJj3vLmYZA6bdvwSs=;
 b=J3iqNFGqJWM9B8fWrGig/J4opZjiLEabZMRIj15EaHy68bti92d22Yrh/Jyr+FTTNcYmouJQ45H2orDiGOaSOoNwiT4QLyOt8IwBzggLzJa6rc+2gkq8f2TAy4tQLDuw/KLpXbcN6V76f91u2Lo9/TU1QTkfLJURUOLYR21QQleUZglvdEg/2tA4QuWGjvxjs9yceyjDZWFFOYmg2pH8oQ180wTaCY9zNFUCeJwoOSciTF3iNqhIzf5AwiUhALx5jgIhJsL5Wuf9GIHXP4If25JlDg7gr3wH/KEbuNRHW+7DDIVheUz53OiRZLQhGjOxSFPRZZxxUoH7LT07tbDvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x67OEHyAO7q+gFvLoWKxmzFCxqFJj3vLmYZA6bdvwSs=;
 b=ryzD3nL5XVDZOUldzMBp1d7vinNUCBjAxmgJg9KxugYihzNk2LIZeERJ4YGmP60KrMYo2ex91IZafhZCO3FahMri6cZvQtCWcuBMHVHtKZY+P3E2iGdK2TmwHZ/AqzpCENE4b/Wsal9VdnB6qAM2iNX4xgzPkx0qGYiTZlQh8SOYDLsqLekjQNP9cuOo6LP5VZHom2QcjnENumKeKyVf63AdLZWH0EUAvv/Cl1kRa8fpxT/YUbahCOKl/dM0g+A0Bx4xCxzM99d7LwYrcamNZtL/bhVy2pT5nnkesdydkcKYPA7fOp+RvcFdGXWyoN9s80WdCHjOTdlRlKfltGagUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 04:43:10 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 04:43:10 +0000
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-3-haiyue.wang@intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Date:   Tue, 16 Aug 2022 14:42:38 +1000
In-reply-to: <20220816022102.582865-3-haiyue.wang@intel.com>
Message-ID: <87ilmsvlwk.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a4201be-c3dc-419b-bb55-08da7f41d1ee
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reb0R9B+bj38ZaNu9Lw34tEBIYB5XC2uLD7oe20iWo88XVMHlbKqJO54E3sgLQL8y+bt+mUFeVcSvdPsw4lOcKkLAx1k/NYqQvlh8gy4xqaXtrOF+fsDLQabDAZBvQPZS0j6hnQhj+qAnUb50K+VzrmuLBkrmQD7OcVKFu9fjgpGeDkWVdENF+NItvQguZMFxyXaMXZ8SlGX+F9rQLO0eiA8PNe6XUlUoy0CNO9RQZNEA4v7YVyzCOKFVKKisRo9kGseuq77kAT/KdJJXyGBPLHgcEnLWaNKllDEV76FllskPxJ/Kl7tQg9nMp1sqtaZ7DOKzVkXd68+QQZ/duKefP3n1R6YI0JC/xKfEvuO1a69GyJ6bjSImL6CSEeWfDLEgvUCOf4rBavopV94LRRxcQMiqRkdHWsl6b/nwWUfVOaBCwbLjl0LwpItL59Q6P05bfMnFMtt/4Mc3bzsL3dJounywb/nzywZI+2vVCSVtKI5yrltRNrG1eX2cgJtRsDC2xMFJx5F/vaVtliOzrJD2PUntzXSP2PfZCHxuWPbwefpFBv6vLzNoB2bGt72NYndjRI21BxvVmhOFmVUbcesGIqDCUui1j5k+7JdLZ9zmdQTh3hWyVSD8BIl5HRLCCsQ8HcruyNMv0baDvz53J+q1uVu29sORQS/kq1tq8HZfeKx4q7SbMyawdoYKdyRA0sCLsYDLhi+9bg1W6uNjGLXfAVeq6Ovl0fKB5cRnvBON2bp2STalT7VErQGcE0UDPwI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(9686003)(38100700002)(26005)(7416002)(5660300002)(6486002)(66476007)(6512007)(478600001)(6506007)(86362001)(8936002)(6666004)(41300700001)(83380400001)(8676002)(2906002)(4326008)(6916009)(66946007)(66556008)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tU5OlVhyUl6wm8TFEbtwqz3Uwj8EkezbY5Mc/hNeqijL02ji5EDcgNJMDYE0?=
 =?us-ascii?Q?bioQlIoUyWe592oeArgV5Aj54ArRVxo2JmrhVzszekCwploBEwEnp6KlwQOO?=
 =?us-ascii?Q?5TThbsGRmVXuIoPDm+ZQ7cVTUMVSNON19Wz/tFfUXQDXnV0qWtiw4pVYBTVm?=
 =?us-ascii?Q?3HaCK5Y1xTtFdtykIrHAVhMeiY3z3yPPS4LjpC4Vq4H1uufgQuGOBa1AQlgO?=
 =?us-ascii?Q?Y8PzWalGFGkry0iH/3H4xiCkm22bRgqjHjCeZ6eRoZfXc5g3ZUxUoh9crlCy?=
 =?us-ascii?Q?1I1q6UzGJmrgnRFFFowUuLwOZYKGzFJF26bzRyM0Wl9S/sMGaKsYQL2KAX6Z?=
 =?us-ascii?Q?uXe0eftSpKUYGrS3KKkyLQWlqVk+T8RTs2V13DUfSe5JH94hkTeKLgj4/Zs+?=
 =?us-ascii?Q?X8+pawrd5v/RGJcHJCWTRqdtAOqt5oI7wiWKslgGk6pT1bUy5NkQknvCfBCd?=
 =?us-ascii?Q?gCk1ke+xNPCNuz9UP3IoBdu4yqh6m+4TbRDdxhw6lqrSNNEPXWNBkbMeX71l?=
 =?us-ascii?Q?dMReXxVTSonB/HE3wrf9+m+Kju1dUZIw/oAYv736Br+SPz0SUaVRNOkk/p+L?=
 =?us-ascii?Q?YaEUSv85GoHfBuoCFW3kY8l8QF2aqHnwRfEiebz8dF5lilowmak2QSjvL/xj?=
 =?us-ascii?Q?aj1EdLZI3zYOVEpxDQrRbPwkTHsi89RAm8h1XZQSqlMC7YINZM/SaOHmNKRP?=
 =?us-ascii?Q?mnmdh2Hv6m2QgsNXkeG3zCIdtVJhwpCStAtPoK9Kz5UgkJTfhs0D5Hf7ytgt?=
 =?us-ascii?Q?ttaEr6KgOKs+BsZ4v23Gho53Vs+b25BXbZUhCgXBcX59qWjmsBX57t69H9AB?=
 =?us-ascii?Q?nYO6F+k9dt2rM8cj4vqaKJtONa0gyWiWDFD9J7t4hDWCzxd9vDwHKkre86Yo?=
 =?us-ascii?Q?Emq1fDoANVLQU2C4uEfkanEOMGYuokONWlqvCvO57RIUU6Rywnm6d4qtNXJh?=
 =?us-ascii?Q?C56bbFIVHYnZfywYJ7brWP8eoR6a9RZYMYCx9iz9UV2Q9adFiajCpmRJEQoT?=
 =?us-ascii?Q?ki07q3WiH2FCblGQL7clyAW6Os39qlkuYOIe7FebUi6KGWjej5lG1TH/CQFT?=
 =?us-ascii?Q?WMM8XbQjKzaUj8mcUDVaoAczFzvyyTUju2cR/NSTs591vrlh9dmhGkW/Ul6R?=
 =?us-ascii?Q?MuLjMKRNXvtW9Up2BbYk/AyY9S4zElH6uIqmTRX2JVI8pMQ0pp5jk1R9MHvf?=
 =?us-ascii?Q?6Mbpf1hsqFRmxDaKg3rLqIaH+AGzf4Umt/qUV4Dpga7WoTmYzozwfcuQIRyd?=
 =?us-ascii?Q?dMInGDGvWLo4q3Zy6OkqM393lRF6p5lBY8ybg5mYw/lxoYAhAIX9WNDP705K?=
 =?us-ascii?Q?FgnKHci3SwWfJoHoP18va0QG2uku9T1nchMQEP9GMzhNftXpYAFpkxV41pwX?=
 =?us-ascii?Q?sS6pXD+WFfBeUPo/puHVYJNRmH7JnpiM1qC2i7beg8pZaO7P17Jp25dgGbgb?=
 =?us-ascii?Q?RkWFGCtKUy6iS5xDECYDf7Xk7LN3JJeryalUy7oumYUQ8N2KRUqv3VwUcz6g?=
 =?us-ascii?Q?hWXIeaUcpus9MXOB2FSl/zHSX3OsyG4sInNeB0iAdGf22V2mv2BZUM3EfsgS?=
 =?us-ascii?Q?HrUPL7643z3mPLebSYVHft5y/MAJI4tofLlUhdxq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4201be-c3dc-419b-bb55-08da7f41d1ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:43:09.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: df+LBH4scSgL2bmkFvis9VNjZdddNmQ8Na+c+gUVxYKWjEy/aGz+WYWfzhHd+o6Ie+wTwiXVgiZvgE1oDIdICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good, thanks.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

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
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  mm/huge_memory.c |  4 ++--
>  mm/ksm.c         | 12 +++++++++---
>  mm/migrate.c     | 19 ++++++++++++-------
>  3 files changed, 23 insertions(+), 12 deletions(-)
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
> index 581dfaad9257..44e05ce41d49 100644
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
> @@ -1868,13 +1871,15 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  		if (IS_ERR(page))
>  			goto set_status;
>
> -		if (page && !is_zone_device_page(page)) {
> +		err = -ENOENT;
> +		if (!page)
> +			goto set_status;
> +
> +		if (!is_zone_device_page(page))
>  			err = page_to_nid(page);
> -			if (foll_flags & FOLL_GET)
> -				put_page(page);
> -		} else {
> -			err = -ENOENT;
> -		}
> +
> +		if (foll_flags & FOLL_GET)
> +			put_page(page);
>  set_status:
>  		*status = err;
