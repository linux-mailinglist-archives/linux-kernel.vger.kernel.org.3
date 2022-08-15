Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BEF5930B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiHOO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbiHOO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:28:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B322B33
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQQHFImBBDq7CLC2VncANrOvie4qumxrJbkaUWXhNOofmRHUL1HgDTxCb1eeOBnYVUQRkAumFD0tmeoSq44clTUFCRjzf/XV27gJX88wNdDiosmtpM+T+ktHxrDWa/F44VjTGBmh/Mn6xA//8/4Q/EHsD0Xf7h6WiGEC3L0roQS8QAkelsJeR6If2WdtsqfXeMqjqtbu/GB8e1HFwTyMUMfhh2xWwsOk16dJsOmL31JTxzXHy59Hlm5a+SWTbBRpp9Thga/PxXOfqxNOr7G9KHJMQsikXw4rRoArzIsOdGaIir7ohM0HTwikNRKwV7mO8Kf9ZBFSJl6kkacZUdn/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9u7jr5/vSf8/u6H80+ZNmzmXbt0rl2y46pW2IkjEdw=;
 b=oEDHzYdHHPZPEU1uAzTebNNs70SgbQfwJYTqdhFTinVfFTbAt+UssJakIpmw0YgyVa+S0TJxiUw++feYSCUXiwP+1WRCQxhpspbGUbdbnHBh+uQS3ch27GbPIatC2r2f1lEq+y+8tMOkaTbyBhfPPNssFGTvJPtGy7URPE1ZLMWoAwKUcbkclCoJcGCsNcQas+eiEfnHSBjhmP3hsZaEtfMCVWTdQJzo1Ao+Y4lqNwVGnS3mDL1pIN8nkk5XOR4hAcAoAs2qGpyRGBwea+mblwQuqcUzm8AixnW3CzDrzzjvEbg0jCGH35mJdNkgw4RdDxoQJRg0hQYnttgndO6tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9u7jr5/vSf8/u6H80+ZNmzmXbt0rl2y46pW2IkjEdw=;
 b=XnkeOBUyZ5PP1PdfkijnFdzQJ73EAy9v4P7SfF9d13LBTNN+GqqCW3Ua9teJEAMY75vXtmY8z5FKd74/Vjfpj2c2aKCFBI75mzgBugsSTxtuJbt4uDc6cPT707hfqGlPzsWx5HCVtcbsdwsDBG4dchRkSADBh0H55PdU5pel9Ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB5530.namprd12.prod.outlook.com (2603:10b6:610:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 14:28:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 14:28:04 +0000
Message-ID: <a5ea6933-5cfb-37fb-3a97-c698f0ae255d@amd.com>
Date:   Mon, 15 Aug 2022 10:28:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Content-Language: en-US
To:     Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815070240.470469-1-haiyue.wang@intel.com>
 <20220815070240.470469-3-haiyue.wang@intel.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220815070240.470469-3-haiyue.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ffbe5c9-8029-4fd6-e778-08da7eca5d8d
X-MS-TrafficTypeDiagnostic: CH2PR12MB5530:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxH27wj4lm1yMOuQ07G/Yus2g+yov91hVynqON4uOjk2LBD+WnZzWXksyndymyus8uCkLplER6NACKHGGrAkAVZDBNDDYsfjAAClhwU2IhN0fy3E0tGB+J5IPiSR8p0M61r+PgsTtv4Dvf8obuyf90Qb9BA4rYyqEf1GOGk3F9w1M4ylvttHLVuSyQJF5gIqejz9aJfmVm9GzguWemJAFx6xw/QO0870kc6R//J1VHXz1cN6WVT+XUnAyT6VMBKFvI0RgzD/jpOdTiEbUasJDqp9ci5p3ZcroR6Qno6fY3qSsmneyLfiZ8e7WGXxM26qZn+XcDpnxUwJV3wJByQtHYta3p8yJwjwYxnuMS5djkpjcY1HHXYhUM6+phlpvvNI4Im/APEXhKaimniNrYMzz6E1zv9qeRzUeTZtgJbQg1VFTEtvXwSWvVaSTkTMMKKs5ahTpMQqbc1VN5Gi6GlI/ieyZrS9PZBbQ0zCXIQFcd1ciQjRtRyI98xpld9LUNt5aZtOAzsBI17YvkN0SkWQ7JpWXELgo4pdWT2pW+tngrdfOT4VA3bNWF89JemsLHrC3rUSIP+hzYW1K3HbPIhYwVbjM8mZ5+OymFPm41zK54HIzd5Dtr4EKdTUQLko/6fkrr0drIB3xdFsR5/n65/NWTI7OUeDp7kU+1vydju4I6HoIwbLG4iIgDpMScfF1cDlFBqoEdJM9FGiJvMxr4ZzSP1u0HUqL0P9pSn0fJ8jZ/m7axY41gPpDwGSY3phjaMsQJYoA2YXY8/YSbUvjljrNFul1W7l2Ii7TEvKgExnewHeM8eDhISVYcYWxIMo3V9mFP2dqM6ZK8IsSSSXAIiL5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(5660300002)(66556008)(66476007)(8676002)(4326008)(66946007)(316002)(2906002)(8936002)(44832011)(38100700002)(36756003)(86362001)(6512007)(31696002)(186003)(478600001)(41300700001)(26005)(7416002)(6486002)(2616005)(6506007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRDNWpBdzRFNDkrakpKN3FqcnBBWkRtYlAzUDlmS0hMeVMxQzY5NERISFZp?=
 =?utf-8?B?NVU0ZTB5UmRobnVBd2RBQzhFT2pyb0tOYlV6eDF4NndydGZTZExGd2tISEsv?=
 =?utf-8?B?REtuaEhxRkdFQ0tkb05oS0x1YXdNRFhKN1V2c3pLbEsxYTg1SDN6U3VHVVlw?=
 =?utf-8?B?R0JwUXhHa1pwS3VhTzRnODdSRko4cFo4aDRJVlkxeER2ejAxTXk2bXdFN3Y0?=
 =?utf-8?B?bk9DZGk3Sk51QklqWU8wVnB3M29TSWtKVmxWbEVKVW1ZQ0QyUHlQL3ZwTjYx?=
 =?utf-8?B?MkdycHRlUlpwczFIUWtoYWQ5SFBFQ2o3MDlXTUgvVkpCaWVYeHhRZVFpTHF2?=
 =?utf-8?B?MGZ6N2hDYjJ5bThjcHFTN3VWaWFyakFTdUN4ckpleWhOcG9DZENkRUxBKzZa?=
 =?utf-8?B?WVVrQlQ2c2F6T0M3aFU3VVErSVpmZmdYOVJZamJ0c1ZxZGhqdWZISFN1RGMy?=
 =?utf-8?B?WlFxQ29ZVjIvN3YyOVJ3Yk9PZmZ3SjAyUDN3VVFGT1J3aHpSb1d3OWlwclZq?=
 =?utf-8?B?dWV1ZGNhNURUbVNhNTNqVnN5WHVUekdKQXViYm5GakNzWmhReUtqdHhzSjFq?=
 =?utf-8?B?eGJsdzJsNVdFcXJRWUdBUFZEd3gyNENuTmwwbFZlR2RUb3RkUFdYVFMybDBV?=
 =?utf-8?B?M29jRm5nSEZ1WlhnWkR2eENoRGhXZVNsMThxTXVBSkYzTGtoamdOek4zUFI4?=
 =?utf-8?B?c3JtY1l1QjJYMWRoaUV3cnhwS0lxd3kvNXNOcmJubmJVUXNKUVFUdGZVWERv?=
 =?utf-8?B?WUwwNFJyVVIzNm9WdzJQdVJldFgrSGhBRFFUdlNZaDNJVHp0c0pXazRTb0pj?=
 =?utf-8?B?azVQTWo2QWdiMjVxaHVtZVR3eExMaVhFTVpyeVNkNGhSS3hxS01VRDJyRGgv?=
 =?utf-8?B?UERzejY5WHhsRVVrRUlpaWdRM29WMTZUV0ZEam00NCs3bW5nMGhibkl6bVRk?=
 =?utf-8?B?cjhIT04wMWhtdmNEQnBBM3NyZVJRTjNzY1pGczFKU2dqSUlVTURUdmVXeFRN?=
 =?utf-8?B?MDh1aG8rOHdzOTJuNE90dWllc1B3N0JLeVNXc1R5eFh1ZVkzY1JZc0pJMG1Q?=
 =?utf-8?B?emVyMFlTNjN2RTQvZEk4TjdSMDc0S3kxczl4ejJQa05XSW9EZXppeFZoY3RL?=
 =?utf-8?B?d0JMM1Q4L2VBeU16eDhkTUVvRUZVYXNJLy9PK2RMbWllbSs0M2o3a05NQ0Zi?=
 =?utf-8?B?SmZ1WjNOWjJWVkRqYUNDQkxWa1BZdUZVL05TUFBoOGtEN0xQVStBdUdFWkxB?=
 =?utf-8?B?Yzd5OWRxRnp0V1RUMTljWTE4RmZhTW1Fd1U5TGJNVktRZW9PRkNWa3owcitm?=
 =?utf-8?B?SjZBd0xMNXJYL1E1V1FYR056VTlIWEZQQU81R1o1elNsMUZva05PMURBQzRv?=
 =?utf-8?B?OHlLLzJpdS9LSjc5K1Y3QWZJaVBJR1hXN29KZ1hoVmllcHkwMTMxcjlhdlBL?=
 =?utf-8?B?VnVGL0cwS1JlLzJRZnBVdjJQcDg1OXlhQlZnRDdOcFlaRUVzTUR4bGF6UnZj?=
 =?utf-8?B?YXhrTGYwZ0xVRVc2TkxHa0kwcVk1VzJXTXI4bm14ZStjMWRjQk11TFZuSHRk?=
 =?utf-8?B?UUVtZlZBeFpLMkZHU3Z3c1VBdlJxNVZvUGhuWkNRVm5IM2ZmMzdxRzVzMmNU?=
 =?utf-8?B?RGlrWVRjNzlYWEhJWEVTcHZhNHRORUtQZm95ZmZhZEEwdTFmRmh2cFdFNGkw?=
 =?utf-8?B?eSszZXozRno4YmlCUHBHMUQrL0x0Y2MzdXZUL002WFl6WGQrVktINmtZZ1VM?=
 =?utf-8?B?UmhjWnU2eXo5TkVVYVFxNmpyY0gxKzhXNVlYaXBMMHkvR1BRcUZMSmk3SmVw?=
 =?utf-8?B?NmIrd3RaMGUya2NpbEFrNmhnQUd0MjVtNUhHdzdVL2s2QnBMckNnMTFGWTdT?=
 =?utf-8?B?V3VHMDJ1dHBwNXdPb3NWQlFGUE56dVdoNTdSdTYyNDUzQnFtTGs0Z2RSU0VK?=
 =?utf-8?B?Ty8xOVVaRGtMeFJLVDRBL2l1K0V3cytaZVh4cEpNVEpoMjliNC9IY2ZvYTVP?=
 =?utf-8?B?RnZlTXdyRWpYSGVyNU1nNFF3c2ZmN1VBa2VFcW85bEkwWEZ0dmdHSXY3ZkFF?=
 =?utf-8?B?TVZ4OWxma1k0MFptQStrRWhqcVhiSFJhelpSdFZiVGVWNkxLOG52UWV2S3VC?=
 =?utf-8?Q?za4x2M8nY15U3CKiV/GhIFjAW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffbe5c9-8029-4fd6-e778-08da7eca5d8d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 14:28:04.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep+PO8ChqUZ/fLSM1gpyKCngniCjvCXbXkNngHp69dMMyUF/rs8ZmmdIc1Z5JSdmuWQR18M+xVtUTGyxVuii/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-08-15 um 03:02 schrieb Haiyue Wang:
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

Thank you for catching this. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   mm/huge_memory.c |  4 ++--
>   mm/ksm.c         | 12 +++++++++---
>   mm/migrate.c     | 10 +++++++---
>   3 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8a7c1b344abe..b2ba17c3dcd7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>   		/* FOLL_DUMP to ignore special (like zero) pages */
>   		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>   
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>   			continue;
>   
> -		if (!is_transparent_hugepage(page))
> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
>   			goto next;
>   
>   		total++;
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 42ab153335a2..e26f57fc1f0e 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>   		cond_resched();
>   		page = follow_page(vma, addr,
>   				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>   			break;
>   		if (PageKsm(page))
>   			ret = handle_mm_fault(vma, addr,
> @@ -560,12 +560,15 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
>   		goto out;
>   
>   	page = follow_page(vma, addr, FOLL_GET);
> -	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +	if (IS_ERR_OR_NULL(page))
>   		goto out;
> +	if (is_zone_device_page(page))
> +		goto out_putpage;
>   	if (PageAnon(page)) {
>   		flush_anon_page(vma, page, addr);
>   		flush_dcache_page(page);
>   	} else {
> +out_putpage:
>   		put_page(page);
>   out:
>   		page = NULL;
> @@ -2308,11 +2311,13 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>   			if (ksm_test_exit(mm))
>   				break;
>   			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
> -			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
> +			if (IS_ERR_OR_NULL(*page)) {
>   				ksm_scan.address += PAGE_SIZE;
>   				cond_resched();
>   				continue;
>   			}
> +			if (is_zone_device_page(*page))
> +				goto next_page;
>   			if (PageAnon(*page)) {
>   				flush_anon_page(vma, *page, ksm_scan.address);
>   				flush_dcache_page(*page);
> @@ -2327,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>   				mmap_read_unlock(mm);
>   				return rmap_item;
>   			}
> +next_page:
>   			put_page(*page);
>   			ksm_scan.address += PAGE_SIZE;
>   			cond_resched();
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 581dfaad9257..fee12cd2f294 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1672,9 +1672,12 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>   		goto out;
>   
>   	err = -ENOENT;
> -	if (!page || is_zone_device_page(page))
> +	if (!page)
>   		goto out;
>   
> +	if (is_zone_device_page(page))
> +		goto out_putpage;
> +
>   	err = 0;
>   	if (page_to_nid(page) == node)
>   		goto out_putpage;
> @@ -1868,8 +1871,9 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>   		if (IS_ERR(page))
>   			goto set_status;
>   
> -		if (page && !is_zone_device_page(page)) {
> -			err = page_to_nid(page);
> +		if (page) {
> +			err = !is_zone_device_page(page) ? page_to_nid(page)
> +							 : -ENOENT;
>   			if (foll_flags & FOLL_GET)
>   				put_page(page);
>   		} else {
