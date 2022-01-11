Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2048A8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348685AbiAKHtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:49:07 -0500
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:48353
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230352AbiAKHtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:49:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD7DXXOxs6F30GgEwWzorXWUxd3jJFn75w+Jsv5w4no0mfBGpiuoxQJxRjfi8IjpLyvlhgmLKGJtqncvbchqTf3BEYe1KJPfLUn79hRbPaqkbk/qJBfxQyy9jptB+ES1baqhpQGkREnqKtR/pGP1wp3pj9x5k0dlovNcJ38Ivt37wM7TNtzTj7aGjF3qLVvOgqGgVkbMzaxiCZGa83y9r+6JPApz75gVZyRFhO0t2nDzsvqjZaemf3T47GMa6UHmU3wm/QFWfZvoPGH+ZUqQM2E1jUE+4W8BGB4U5ZJCZBJaWsubIh6HTMeEElRiEJQh9m0YyOpcqSZl43y7SCNUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agg587DhbyxByyBmbytQysyWoOZm+QkbUpHT6q6saWw=;
 b=mW3l0Dww+bCvHVQtjLehWy8iGLzeoUvxM+laIMyj0q8KIA1NXyrbyByxzkphwmEuX1PDdL24NXuqTmj/sXudbBF8/dKWNz63prv66NoMu+ma+ze+ePi/GFySesyQmyD72ZXo4RhP7ceiw0Mw8iY6qDDH8pmlGNWHJwqx9ZiHfqKxuaVZBi8kogBGC696mUyyKqjTnPgzhV/+6egYnnKl0EuRKKRg6E2OTAP6hT9sT5SCEXO2vxmJwH5TU6tG0Vu1wXy9leJ4awSxw6t6Ph379R+kgyBzPL+GO7bHoUe9KB7fy2grntkP5AgNsE+MtNr0UPufxF/H661jV14rXJELHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agg587DhbyxByyBmbytQysyWoOZm+QkbUpHT6q6saWw=;
 b=Dk6N5qehs9Q2clL5aT4/LuL2UWlmkWnD3c11kcmHS6nTVTyI5wqz8aOv+H5BXTSp/+z+t6s66jnh7Q1xY36tOHllNMq5nD3cgB24uTgYgVwnvw0uMnO6GLPF3Ls987941pLbBEWaFrFksLCe/7dJ6XICjVlsGBfdVBI0014n0kpP8WvqFs4PZM+J4s4upOqcF01gF+3OuDeJGA7ltQ3u57ly8RS2yKTCU2awEXgxy6m0nBHeeOn7X69peosz44VjKbK03eWGjYXHHzVRe/ahmu9tRZYnIK3UHuAVWmDEgyH1TWpVFjBF9O6IVatvc31X7mkeonM/pRlDC0mB8Qfkmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 07:49:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:49:04 +0000
Message-ID: <c5aabc87-0f1d-5967-f60e-924322456e60@nvidia.com>
Date:   Mon, 10 Jan 2022 23:49:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 27/28] mm: Add isolate_lru_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-28-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-28-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afcf472d-1d49-49d7-f4b3-08d9d4d6d6a4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30623EEF7703647C989EB550A8519@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acCz6ZFmRyJn/ZdoRY45Mp473aePh7CiLMgZbM5ws3sbEQnV4UjcKvJl/pLLZUZi2TLteDslXOt8wfHvHtPxbeWgMxNW2AMUU3cjYQQHPdI97/K2hwXt5+N024o5LvhSfxcMtMdwjEE3nH65zP2HZbFQ9x6g9MLkFGqapP28H+EDeEZI3yNapcXH9Sc19mb75HeU6b8ExhokUjhOnF04iH2V7M2vxrLsOJCSjhYAed+W8xRd45j1Lu1bZekzORRqyqwVWlc80nolkIH66j0jcStzrAk1zCuTl+hMRJ14WEt1+qfeq7xr/nwBwSgrkun05mXFJzG5SIiwk60Lft8iUp6FPADLdfnmJ1xONVOTR31LljhYmjtbFtwT4mZNhYq6MIo2epaP+HyF2SS4Hz3+4uEYvn/AdKHgBa1ezHFH0Ub5899gndQe2ti5fC+dqZxQLDvICDWxl58ZsnFo/dpjlfDKvoB8KOf/t8qsL6KCROKD5VLVLGR++E89JawRLOqW98t4cA6+mYitKYcR594YI3EAoZpO5rzWITheDVSGnQHJLTi8l4MP93phaOwGJTbAKIdBpLy9WCFvBMKbUCN+OTOMiKq+cY9wU+pKnsdE60htpRpQ1VSfIUpZEPl5Z/oxKTu3R9wE4RnOr8T3hH9sfacMbUByW319z7bbyFaqr95Z22hKWWTP+Rg0kcve6on3uaof1/mpFpWcQytn3WbBb+hlKNHDtA/RZNfX5gav1p4nqwodeSdBelZE7qOhxIJO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(2616005)(53546011)(508600001)(6506007)(66946007)(83380400001)(38100700002)(2906002)(6512007)(31696002)(36756003)(8936002)(6486002)(54906003)(31686004)(5660300002)(316002)(86362001)(4326008)(186003)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUovRmxCR1pHTmtMeXZyZm95Sjh5Tk1TdHdnMllmbE9WYlJjMllZQ0JXdjVl?=
 =?utf-8?B?WEVidngreTQwL1FWU3JGcnM4ajhGRHpZWThEWjhGZ0pEUE1tRFFJMVZlclFN?=
 =?utf-8?B?cDFvbFFLbkJ6LzgrMHhwZk5KSzM5amNibG5pcHVXRkdhaVMxM1ROREdFYnVB?=
 =?utf-8?B?clBPRW9wb2lXUDRDZWdkVUpsYjM1ZDRVZTk2OWFsNnJ0bFAyUDlDOHE1eUtR?=
 =?utf-8?B?YnBMSHRaWDJFSHhXc1BlQjNlRzd6SGZWTWZZYVpKTjFuR3JORWVndjdCWHI5?=
 =?utf-8?B?S3VsQXVUc3hvVjZGTHBYZ0dUc0U5NWNhYktGYmRmWk5VL1lmT0lqcjlFUHFK?=
 =?utf-8?B?WkFraWNCaW9RWGh0c1lEOWxSajZXcjMvSlpMa0Z6S2tnVVJLSnE1bVNyLy85?=
 =?utf-8?B?TU9XTjFjd1NJVVZmMGNUTDYzT0t5K3BMSU41YmcxS3lzNk1XQWpMdUYyajhU?=
 =?utf-8?B?dExXNzNjYlpzNlRLRDZpTG9YTDNyVm56NmlGdVVOMk9qTldjcXBkTnQ4SlE5?=
 =?utf-8?B?azliZFNZc2tjdENaWEhVcVI5Mm5yRFNtU3QwUHI3RVVyVUtha2wycU1wamxI?=
 =?utf-8?B?azQ2bk1wWFdxazJLTDdXZ2RqVjlJTXhVS2JreWxIM1M3VHJlbVVGWVlneWsr?=
 =?utf-8?B?ZXdHWXJaVzZYdFJXY3JZZmR2aXVnU3cwZGlvRWIyK3ovYkhQS08wbGVULzdH?=
 =?utf-8?B?azVsS1p3L2dNMVdnMGhZSkdiT1o5OUFMNFZtWkFCMTRFdlJYaXkxR0Erc1Ry?=
 =?utf-8?B?NzF3b3V3cUhicWcrT2JxMTZCUnJKYlcwNlEwMk0vU0NJTTE2TmtGTTFtWUVY?=
 =?utf-8?B?RTgxQUc2bWFvTVBqcVFwVXhqTXFVTjFBTmVQM3VOVit5c29oWldRVnpqZmZk?=
 =?utf-8?B?NTNJTDg5SFhLRTVrdUNYWDFmN2VzOFdPR3JmMVRwc05JeHBqZ1J5K2xuZmNt?=
 =?utf-8?B?MWFoSVNycXl6b0JGRUpBWnRWdUlaeUZJUWpIcy9JRm1UZGZyTzZrZkNMYkRq?=
 =?utf-8?B?M3dseTFTQmxkVVFPbDd5ekJUYlFPeThmWlJiN0tSVkJ3aDh1TytvWGJBcEto?=
 =?utf-8?B?TUM4ajlQOEQrMFNzZDc0ckdnWHZ2WmQyaFdVY1ZtRDJ5ejNTYnBLRGxRQ0FF?=
 =?utf-8?B?UWhQcThweFhMOFVoTkRlLzZuMENRbkt2aG1uSGYvNXEvY2Y0cmZzNUZkVy9K?=
 =?utf-8?B?dzk0WmRFdGE4WDdGMklWRy96RmpHcDFwbC9saU0vN09Cam5JSG44TFFsUzA2?=
 =?utf-8?B?Rzd5QVQxMy92RmZadW1VclJDYWFlQ0pKcGtNVGNBa2d4amVDMzJIbkowVk5r?=
 =?utf-8?B?Z2dmMGdmbTVQbitTUHFEUi9QUWlWV2ROelFLSC81MHBOOVU1V2dTSk43bGFZ?=
 =?utf-8?B?aXhycmpOYUp4VE9mbHh1aTd0VldIaUVpcTEzK3VObzE1OFF2dW9KMnQ5WGl5?=
 =?utf-8?B?c0Y1eDNqTDNnOWQwR2FDVngyTDJzRDN2OEFycnN1RzRmWnA4NGgxYlp6Ri9S?=
 =?utf-8?B?aUZ1bnVSM2o4S2lQR3FxdHp4SkFRbm9WeXZ2RjBUVmVZV2MrMDQ2Vk5nRyth?=
 =?utf-8?B?S3hTd1pHVnl5RGMvQkJFQi9uMmFUSDc0TFNvdXBkZEdJUE1Eek1MM0RUTkFv?=
 =?utf-8?B?dlJoNjg4cE5YcWEwSU41NUdVa2VFdnpMSGhMV25QbnZkaXdjMG5nejQxZ0N4?=
 =?utf-8?B?YTM1K0JnUWY1dG12MEJSUUV5VVg5SDJuVWl1QktJcm51dVBKMytHUUIyWHBa?=
 =?utf-8?B?ejFxKy9uZTR0dmR4azV5TU5qS2xrWFNrczNSUDdZMTlGNEpJL1JwSDRMMVNu?=
 =?utf-8?B?K1pwdFE2T3RsT21xeXcydFpaK1pTZC94QTZ2d3Z4MGF5ZVNsRkJwZDREV3l2?=
 =?utf-8?B?bGg2TXR3cDRFbythMExYckx4dmNGZURiV1dSWnVCVnBoampLbGUzQzExcFBo?=
 =?utf-8?B?Z0Y3Rjd6TnJJUlkzWFdDRm1laU8raGdNdDhoaUR1dXVQbUJZUFQrR1lpRUFL?=
 =?utf-8?B?bkRpZXhiRElYSGo4eHpRTVJRWERUOGZ3WEd5aDYvYXdNbm5veVdKb0VRTXZ3?=
 =?utf-8?B?Vyt6MW01OE9JbkFUN2k0dWJMbG1waFVsSjVQUWZEN2pUQWNSanhWc1dFbk5B?=
 =?utf-8?B?QVVtcnlKSTNGWVVDb2NucmtVSGdjVm5LTHFMdllNS2cwSjZqUTZLVDRmQ3A0?=
 =?utf-8?Q?yC1WLHVEyp+PiqD31onXxwo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcf472d-1d49-49d7-f4b3-08d9d4d6d6a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:49:04.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVeO8ukB4B+ZOGRh07dbEzKQzkL6LSp7SPjbVfXI4BaGVKDH7eniETpcSfDzzqB5w1B/dhMX9buENek3h1MsKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:24, Matthew Wilcox (Oracle) wrote:
> Turn isolate_lru_page() into a wrapper around isolate_lru_folio().
> TestClearPageLRU() would have always failed on a tail page, so
> returning -EBUSY is the same behaviour.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   arch/powerpc/include/asm/mmu_context.h |  1 -
>   mm/folio-compat.c                      |  8 +++++
>   mm/internal.h                          |  3 +-
>   mm/vmscan.c                            | 43 ++++++++++++--------------
>   4 files changed, 29 insertions(+), 26 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 9ba6b585337f..b9cab0a11421 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -21,7 +21,6 @@ extern void destroy_context(struct mm_struct *mm);
>   #ifdef CONFIG_SPAPR_TCE_IOMMU
>   struct mm_iommu_table_group_mem_t;
>   
> -extern int isolate_lru_page(struct page *page);	/* from internal.h */
>   extern bool mm_iommu_preregistered(struct mm_struct *mm);
>   extern long mm_iommu_new(struct mm_struct *mm,
>   		unsigned long ua, unsigned long entries,
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 749555a232a8..782e766cd1ee 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -7,6 +7,7 @@
>   #include <linux/migrate.h>
>   #include <linux/pagemap.h>
>   #include <linux/swap.h>
> +#include "internal.h"
>   
>   struct address_space *page_mapping(struct page *page)
>   {
> @@ -151,3 +152,10 @@ int try_to_release_page(struct page *page, gfp_t gfp)
>   	return filemap_release_folio(page_folio(page), gfp);
>   }
>   EXPORT_SYMBOL(try_to_release_page);
> +
> +int isolate_lru_page(struct page *page)
> +{
> +	if (WARN_RATELIMIT(PageTail(page), "trying to isolate tail page"))
> +		return -EBUSY;
> +	return isolate_lru_folio((struct folio *)page);
> +}
> diff --git a/mm/internal.h b/mm/internal.h
> index 9a72d1ecdab4..8b90db90e7f2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -157,7 +157,8 @@ extern unsigned long highest_memmap_pfn;
>   /*
>    * in mm/vmscan.c:
>    */
> -extern int isolate_lru_page(struct page *page);
> +int isolate_lru_page(struct page *page);
> +int isolate_lru_folio(struct folio *folio);
>   extern void putback_lru_page(struct page *page);
>   extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
>   
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..ac2f5b76cdb2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2168,45 +2168,40 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>   }
>   
>   /**
> - * isolate_lru_page - tries to isolate a page from its LRU list
> - * @page: page to isolate from its LRU list
> + * isolate_lru_folio - Try to isolate a folio from its LRU list.
> + * @folio: Folio to isolate from its LRU list.
>    *
> - * Isolates a @page from an LRU list, clears PageLRU and adjusts the
> - * vmstat statistic corresponding to whatever LRU list the page was on.
> + * Isolate a @folio from an LRU list and adjust the vmstat statistic
> + * corresponding to whatever LRU list the folio was on.
>    *
> - * Returns 0 if the page was removed from an LRU list.
> - * Returns -EBUSY if the page was not on an LRU list.
> - *
> - * The returned page will have PageLRU() cleared.  If it was found on
> - * the active list, it will have PageActive set.  If it was found on
> - * the unevictable list, it will have the PageUnevictable bit set. That flag
> + * The folio will have its LRU flag cleared.  If it was found on the
> + * active list, it will have the Active flag set.  If it was found on the
> + * unevictable list, it will have the Unevictable flag set.  These flags
>    * may need to be cleared by the caller before letting the page go.
>    *
> - * The vmstat statistic corresponding to the list on which the page was
> - * found will be decremented.
> - *
> - * Restrictions:
> + * Context:
>    *
>    * (1) Must be called with an elevated refcount on the page. This is a
> - *     fundamental difference from isolate_lru_pages (which is called
> + *     fundamental difference from isolate_lru_pages() (which is called
>    *     without a stable reference).
> - * (2) the lru_lock must not be held.
> - * (3) interrupts must be enabled.
> + * (2) The lru_lock must not be held.
> + * (3) Interrupts must be enabled.
> + *
> + * Return: 0 if the folio was removed from an LRU list.
> + * -EBUSY if the folio was not on an LRU list.
>    */
> -int isolate_lru_page(struct page *page)
> +int isolate_lru_folio(struct folio *folio)
>   {
> -	struct folio *folio = page_folio(page);
>   	int ret = -EBUSY;
>   
> -	VM_BUG_ON_PAGE(!page_count(page), page);
> -	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
> +	VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio);
>   
> -	if (TestClearPageLRU(page)) {
> +	if (folio_test_clear_lru(folio)) {
>   		struct lruvec *lruvec;
>   
> -		get_page(page);
> +		folio_get(folio);
>   		lruvec = folio_lruvec_lock_irq(folio);
> -		del_page_from_lru_list(page, lruvec);
> +		lruvec_del_folio(lruvec, folio);
>   		unlock_page_lruvec_irq(lruvec);
>   		ret = 0;
>   	}
