Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360E4B96A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiBQDZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:25:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiBQDZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:25:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5275A28A114
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4GvkbfsELj94XLnyOq7fHzeRvc0kPWPSFnBMuqL42155R78/zlxd/mPjhp8IZ6pwkwlxur8hp+g+pf/HZ3dM55WLSE9U/br3jXhRYF4D2oHHo2o+hD8D56HFCIOQBJgCVyDr+reZxsTR8WJHVSs7T+Fwdyocb+mHc/Y1/uSR0SRD9vwwGrynYD6RybUrEOfrNeDQZAE8VO3Pg0A5QDgPLWodEghq7E5UJRIy8PhCJZOqVI2QN8Mz6SldBrP/SKKXMVfdmxBk+kklA7on4YwTaCANtab+K0DRxv9cq5hE+LfUIC0CIgQy9Cb0P1f7v3w3rJIGo2Bf/lLdlHXIdQ2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DNqvJKXFyv1XFLHRhXIYovB//lC3IBgfcb+qW5EGdU=;
 b=mI3eOS/uALEVaMbU7BaDQSU/jIW7BYJSgjqqP9bnQJKcjRs7TVohhJCpXKHOeldYVKdYH5VvtpKIepW/Ytkl1rZLO+M9vMtVIMxo1jC6jZi2uqXIwKMP80hSim87QKeeVehkFD0GAcUn3LIAIylZh/xrWsxmq3IAyuJM9+K+hd331PwKPNvxzjWvhbZMIrKMmUvD2YfZvrYhoUl4VmWbadlEVmt5CKQRLIfKE0KI/bWEqvz4ZuAf7IUZXBRx6SpxxuKd2c33nyeYNwzdFLTjuswccfOOXL7YjONaeW8a94my0YNhhvj/4DLwwREomb0vNAuQPEeQMSAQOjEdYfSCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DNqvJKXFyv1XFLHRhXIYovB//lC3IBgfcb+qW5EGdU=;
 b=D87OhXjSXiHUY5aJdG5+yeA2yW6EeTeMvj3ZcYxipthC02ecS7eRR9OyfuPBUjp/4Nrqg2lsWE4MurWu94AW16mVIU8aBQ7uFtnz4Pi1fbPW18zMCGu5bqZcz8eZFKg56TmQ/gb+9WdXJVrNMZ+Q9/FoCl/hEfmnWWCz4VT/mQTJxN35zv9GztQSLGP9wUHuHZhnqhjgzE7qMlXA3xLDIeXsxrL8gswEpVrVXTGXTeMuGGL6WOVNBGwDEe2HGQUcjCS/oxfptOvpAWgH+Oa5M3o9MgG6P7nJ+GeeNi3/r3jEPUmZnTiN5gfB5Kq0GlpATn07eNP7TlQeWk/QWaoeig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 03:25:18 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 03:25:18 +0000
Message-ID: <b04fabea-6216-3808-44e8-0a2125bf0230@nvidia.com>
Date:   Wed, 16 Feb 2022 19:25:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 4/4] mm: Rework swap handling of zap_pte_range
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-5-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220216094810.60572-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 338d689b-5935-42b9-51f7-08d9f1c51f1e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB162044816AE5E0AF2354DCA3A8369@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5oCwpRwxuEkikzh45hHIMsFp3moqUDp2thtin03v7u7G1XtRmcwitZeq2jiidxFiNyNgYxBDy79nX5Yg+YRsVOiNfR+LckrPfmuFSPyasHyShJ74Lnvsf+uJs9y+570tOU0/RllPQ1TJXe2b9H+9yjL7ZzIWtcRRrnt3P1MMmWS7AO2wJqj+JEvBlklhnOwTUolarUdXtxOHPQnpGdqP8NI/eycdnNUvnmGDeD9eAUKqWpODep9tYMnrhbAM5On2t2Dz4HMXxv6/NbByvk6244J6tm1JoetoG8bB0lfNsAP6vsucbWkhiqZGI0iEFldm851AJR8nKkFQtPIf1WBQpo4RLx/PvNvMNxzpBp9pF89BOKSApGYnENMPBHU86CxwKjvqMwp2zFxEGuoV30nW4iLwsaYja80sYRylhGlbuDzT/gorwYP43xrfG8Y3Ay7AKnSy2fcTahmBdCVGOZqu2G1wtaEQuHwUDzX00xsx4sPhzG3ejMLjelp/mx+F4wDMBxd+bIS4Pq+qsA6pn6vkX1yFmgjQEki2ODcObr2A+9inN+KG7cGnEUsmcCCgR+0GuoL7TdGZGg1BVXMtCP65XEiIs9hkKEUjQk89CQesiISQ0okxm/XLxN3qgh6RE0/3XWshrzcTwK5tj7E4Kp/dBDcS1WwWt42Zfhepq7sHL8UkWoeWeQEvAe12fzG5GKsn/Ru7DDcPH3dO5//RforLz7hy1PxJwPTHIsXsI28teU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31696002)(316002)(53546011)(66476007)(8936002)(8676002)(66556008)(2906002)(86362001)(4326008)(6666004)(6512007)(508600001)(2616005)(26005)(186003)(6506007)(31686004)(38100700002)(6486002)(7416002)(5660300002)(66946007)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpubkRkdGFZaWFiZHdxYVZRWlp5OFFBZGEyQU1sWEUyVjJTaE91dXE1cXR4?=
 =?utf-8?B?VlBPalpkb3RhY1I5eFJwbktLYi9zb25JUTRXQ0FFaGVhZzdleWlFRTBjSVlL?=
 =?utf-8?B?ZUtFd1RmdkRhZnJMSkFjZVFlVFZ3REpOTWNrRHdqWWJvK2Zxd2ZUc3d2bklO?=
 =?utf-8?B?NEQ0Y1l1Ujd4RXhPTkVrSVQ5S0FIUU1FcWFWeE41ZGMrOW1pN3I3bXVBUWhV?=
 =?utf-8?B?STlFVGJWckxGM0NTTVBtWllKY1V6STArRTZXSm43RitIU0xjZEc3akVnOHpR?=
 =?utf-8?B?bGd0aFJLclU4b0xwRldMck5hYVozbVdueE1nVWlKRHNOUlpsMWJicG03czlR?=
 =?utf-8?B?L3BWaU16M3ZWUmNKRzZDOGpSWlpyckRhcjFnOW15emk0K2NIc1RPOTl1bks3?=
 =?utf-8?B?bHNJYkhZNWdZRXpyNTcyQjV6c3NNbGczMFBvS2xDK1licFNvS1h5UkRGUEVn?=
 =?utf-8?B?eUo5NHkvU0tuamxab3puN05RVEtCSDV0dWJwKzhmUncvL3FIb0RzeW9wVEsv?=
 =?utf-8?B?cVBMWDY5Y29rVlR2QytZUG5XOXFwdmNqTEhMTHVodXFMS2RFREd0SzBsQ2VU?=
 =?utf-8?B?eFJtQTA0OUI0R0pQWEUwcGpQaXExY0kzcmw1bHRXM2svQWUyVmQ0T25BcDBB?=
 =?utf-8?B?OGZ5UFhQejRUeWx0UllFemh4WTVkK21kNjhHdTB2REYzaUVTWmZXdjFGZEsv?=
 =?utf-8?B?SHo2cDBxaW84SWE2UWdlUldkMXQ2cjcyMXNkQVFCOUJ5dzJDYytaNm5nb0NQ?=
 =?utf-8?B?eVEwOEwyVE8rWWNNT05BNC8ybFExS3ZkMjdFUUFhd2xLUzZvNjB4WEdlV29k?=
 =?utf-8?B?bDBYNFI3cml5cnpweGF5NFhpYVJ0SFpGZCtkeU8vbExCZjR3YitEcSt6YmRk?=
 =?utf-8?B?NmNDNXhWcXNDZSs4TGQycjZaRHNmcUZxcXhqeWljazBpaWNHV1pxWlJwMTJj?=
 =?utf-8?B?cGJ5SjlNcFErR2RoL1BmV0NIZDZTa1BuTjNCR3NJaE9uekptaVJQQkZxcFdF?=
 =?utf-8?B?aktxMlR6d2R3QmZSUFNjQTJBWk40cnYwS2UrOUN1K2J5Y1llT1VwRGEzemhO?=
 =?utf-8?B?Y2lSZ2RCMmhZVnl0Z0NKZmc0aUlzUThGRldxVkNVeXRDdncwb25yWjhMaFg3?=
 =?utf-8?B?T0VRUnlxZVN6VGRqbk55NVpPdGNEbVhQMjhsQVBabGVmODZlMko2b3B3QUQ4?=
 =?utf-8?B?a2NTTG1zK3cwZHlpenNsbGNkV2tBY0JYd213YlhxNG9NcEp0WlV1bTBheDZ4?=
 =?utf-8?B?VithdG9lT21nbHNSZnhKUlhYM0R4YjQwelM3VnNxZ2QzK2FMZldJNmlLajky?=
 =?utf-8?B?cWEvTDllc3FCTGl1TnQwTFpXRTNYKzFDN09DbzZQODVXc2hIRU14b0tGMkV3?=
 =?utf-8?B?KzdwUDRGSE1pR21CU1ZKczhTVmQzUUtCNTBqZlFSUElENEx6cStiYVozZ2Z5?=
 =?utf-8?B?MmJiSTdRR1JSaXU3SVhaclhtMEs1SmpGZHpSa08xdER4S0lsK2x5TmRBeHox?=
 =?utf-8?B?ZEVnR2FTZzlIMGNJNk9ueTlaQVpuSXo2cSs5MDEvaDh5SjE2ZTZnS3RqbDAr?=
 =?utf-8?B?Z0w5OW9UWEJPOGR4Zlh1bER0VHNRcXdpRUFtZ1VidjNKYktEeG51WUluNUF1?=
 =?utf-8?B?LzROODNwV1A4U1gyQXZsRFVoMUNLRlFKLzlNakczQVNvRW1kdVNCTFJZNVVT?=
 =?utf-8?B?Rk5LZk1pdEhMdjY2amtNMkVzbmZqQzFpVnN0a1R3L0FkY3ZDQ3B1V2o0aFY5?=
 =?utf-8?B?anBGMWQ4VkRwU2x0TW5QMWxXKzNYb3gzcHZrM1JDSkM5bXFZT0VHeXVYTHdT?=
 =?utf-8?B?RHhtUVRQeVJ1MncxcjkzakdxTmhDK21yNXdVNkhsaWJwOXcwWDhQdE1Eblhp?=
 =?utf-8?B?d3lhTGxvMklodEIvVmlZaFNMaW4zZ3Mrby9GRnhnbXJVRTJQN0dZd3RSanNz?=
 =?utf-8?B?amhtajY2a05ZM1FUOXBQeC9QUGJ1bzRkbzVjRndqZTZ3ZDdvOEl0MHZFK2NY?=
 =?utf-8?B?N1VyT3FIaG5Xb0Myc0xNM2pObzFYK1pBa0dxbXZVMThtdVpVaGxqeTlZTWpV?=
 =?utf-8?B?TGN3M0RjcWNGbUZmZVdZQlIvbEZadUtvZVJPWjdFRTlrNytwZERQOGJLdUM3?=
 =?utf-8?B?WXczYXBxOFpOakplQko5eHBBZEJqM3pWV1MraHh0aE9iMU1hdUY4TzBMZmtv?=
 =?utf-8?Q?iMKqYNX0sy9eofwaBT1Pg4o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338d689b-5935-42b9-51f7-08d9f1c51f1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 03:25:18.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7YmhUOIaYAcN7X4rtayDida84+wiXpQYK8Pt4IXO7wM4UEm2jsyHY8RxZ0lZXSkdd8gYaVI64yQW6mkzssJpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 1:48 AM, Peter Xu wrote:
> Clean the code up by merging the device private/exclusive swap entry handling
> with the rest, then we merge the pte clear operation too.

Maybe also mention that you reduced the code duplication in the 
is_device_private_entry() area, by letting it fall through to the common
pte_clear_not_present_full() at the end of the loop? Since you're listing
the other changes, that one seems worth mentioning.

> 
> struct* page is defined in multiple places in the function, move it upward.
> 
> free_swap_and_cache() is only useful for !non_swap_entry() case, put it into
> the condition.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ffa8c7dfe9ad..cade96024349 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1361,6 +1361,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	arch_enter_lazy_mmu_mode();
>  	do {
>  		pte_t ptent = *pte;
> +		struct page *page;
> +
>  		if (pte_none(ptent))
>  			continue;
>  
> @@ -1368,8 +1370,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			break;
>  
>  		if (pte_present(ptent)) {
> -			struct page *page;
> -
>  			page = vm_normal_page(vma, addr, ptent);
>  			if (unlikely(!should_zap_page(details, page)))
>  				continue;
> @@ -1403,21 +1403,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		entry = pte_to_swp_entry(ptent);
>  		if (is_device_private_entry(entry) ||
>  		    is_device_exclusive_entry(entry)) {
> -			struct page *page = pfn_swap_entry_to_page(entry);
> -
> +			page = pfn_swap_entry_to_page(entry);
>  			if (unlikely(!should_zap_page(details, page)))
>  				continue;
> -			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);

Yes! Good cleanup there.

>  			rss[mm_counter(page)]--;
> -
>  			if (is_device_private_entry(entry))
>  				page_remove_rmap(page, false);
> -
>  			put_page(page);
> -			continue;
> -		}
> -
> -		if (!non_swap_entry(entry)) {
> +		} else if (!non_swap_entry(entry)) {
>  			/*
>  			 * If this is a genuine swap entry, then it must be an
>  			 * private anon page.  If the caller wants to skip
> @@ -1426,9 +1419,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			if (!should_zap_cows(details))
>  				continue;
>  			rss[MM_SWAPENTS]--;
> +			if (unlikely(!free_swap_and_cache(entry)))
> +				print_bad_pte(vma, addr, ptent, NULL);
>  		} else if (is_migration_entry(entry)) {
> -			struct page *page;
> -
>  			page = pfn_swap_entry_to_page(entry);
>  			if (!should_zap_page(details, page))
>  				continue;
> @@ -1441,8 +1434,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			/* We should have covered all the swap entry types */
>  			WARN_ON_ONCE(1);
>  		}
> -		if (unlikely(!free_swap_and_cache(entry)))
> -			print_bad_pte(vma, addr, ptent, NULL);
>  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
