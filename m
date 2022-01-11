Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9C48A6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiAKFAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:00:48 -0500
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:57222
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229436AbiAKFAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:00:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2qYgBw6TFEd33wT2jzvuVDGUTOzLwxFjuho9vspVyhp2nX5ZjbvpuzJ/2FRnVr3/GCnD9OWsRF+F2Iuoo0K0au4QOWkLW70XjivZlMfqMbEU7SwZ1MT8ltGiC/CswM7VnrthpTwzBlm35JgIBvxZOu1OKpYCQsc8J5BxL1iiS69Ydix4tdXvygp9LTf+ayzUL72kzi4rDBmrbQtkrB9rqACknuRsaucqYBE90czrZWj+Goi9BFNyj8ZKwIuckWDgtQCZI5YIscQlCb3JZ7UM4p0gv8OPRkWVMuqCnnd20RxOoQlLMGguZp5bgszB7lyqEuqCTBHl3pWOF4qC8vmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEkqINPZ5762CrWQzJuyfkaPZg90T5N7J00R4toH1vU=;
 b=bcge0F+/n6A+KLBTz7WA7O4iWP3BEMqTlvKGhEYFki1/5CBg1A+9N0l0KDvK4Q3n+97S2xmsjH5+SeJqTGwJOjVz4ZTvgFKlMhuoRxTUTqWin1LrG4gX6X7i2AYNlHAi3zrfLP0AESlIQCpt+SPwelZybDYwsIDXTJuRooiqWGhANAaaOASKKSGkJUljgoaBnicVmBuxzgMa4eHRPurW8LSMXqhzDg/2oRaVAnWxnsTWmICI4nEgVO4lztaP9hxoq5KbVL8GH3IgzTibKWvOKikERXAFyE6nExoIjHpchucZScK1PbuWVqwr+ypkzWUujOBIKQEdvt9HQGOyL1GB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEkqINPZ5762CrWQzJuyfkaPZg90T5N7J00R4toH1vU=;
 b=pLinaBrPaoU72Rpl2taKihS4t2GJ/VLFxTBCIWXn7KZh+fDNM+nzSp+9Z8syXO7hb3ImKAoCsqMPTL1IahnNERwXCenrmX39fazgKWn6cAq0QsVEBoqBbmU3XUkko9F3+inrWEqJn3AH4VjAnZgvGMAG20iWxkL4iGR4/wmn/GTkjmfX02NtQuA2wDuKN48loy9FIW96s2vdybgdfZsy4YcBviE5zkYMI1u77SQbaVNSD4MaGPErvweOVh03TfgDFtDd6cFmxxYRrtGUMVD7im092AUA//hL8GcVs/9WM5QKv0jAxsN82TJou1ocjRXcvJKzoKLxM3Z5v0Rpgbn2Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4803.namprd12.prod.outlook.com (2603:10b6:a03:1b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 05:00:43 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:00:43 +0000
Message-ID: <6d799f30-f66c-8fa0-929f-75f2c04ed55b@nvidia.com>
Date:   Mon, 10 Jan 2022 21:00:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 15/28] gup: Add try_get_folio() and try_grab_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-16-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-16-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb2399ef-e34c-4579-22eb-08d9d4bf5271
X-MS-TrafficTypeDiagnostic: BY5PR12MB4803:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48036CD93A7655083200D905A8519@BY5PR12MB4803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuOH9TQ7QR7RXj/7Se3V/1c/cvQxHj9+j475ASwl9O4TYAMg3eTaLClWOLVcFAgIgAKhQxRgQZXfhuxgKDTNj0zMao4IKUVS/C+gb3FC2n7nyxb0nt4O0L3UKC6Vdh2Nu3TD6VvOH5s1KaM3fSy2BIBn4uo0Sy6XTaBuh11F7jgaJYCoxEy0g73I2dwlB6KU/g7Roa+lju1JGZBXUK/kQqQHyboQiGcC7BcsX8Xt58MeoHk3EZ/OvSNgq0Uee1o4b3lwto0FN+/STL6tZgc0QIsvlsitVPpUZoNOznVMEsTzyaLueuaNPmCrJ6asYCGBslw8Bvb6dLIroDM8Sgu+GX+ERQYrCIzy55fnEq+tkvpf6lfN8Wx2e70yGL31cZD22VF7Pmv9Zs3F9nwQTH/sAsq28lzr94cVmrwO7byHi2NgMmyA7iiKHd6oyLWt2fwULfv6jkBPeUA59e06S64hkqC0qOFwF6lwXIFLC+j69Flc/E+w1gHBde/pXwQFfEcjtbTU/iokoejpvTlgogD+sqsVsgeBm7XBZD/XPF0Z4P6i6aBDX5koG5fxpij/CAKU4dM9s4n4Xb0D1Q8j89o6aFmyz562EADxywFuuWf3XtSqxukCtY1SZH878PUC8wMvo/KBeAQuRrwPd05w4cCqeP9LS4DSEiSolwOzukilA5+o9xo5aX7hixpOwTrORHEzm3YwfnaU9GY1s6ojQG36TcanRa7Bep6V0Ezqc/KrenHO+haGwbhkLOSbWOi5mPmg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(38100700002)(6512007)(31686004)(8936002)(26005)(53546011)(6506007)(6486002)(86362001)(83380400001)(31696002)(4326008)(54906003)(2906002)(508600001)(316002)(66946007)(8676002)(5660300002)(2616005)(66476007)(186003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjE3cWZXN01YdFRQb0FxQnlScHEzc0YvVGt6QnhsT20wV3pnR3h4a3UrbFgy?=
 =?utf-8?B?UFRNSzhZOUE3ZlpCVW83bVl1bTJRand5S2pHZFhMdmdSTGdzQ3pVd2I3djNJ?=
 =?utf-8?B?dnIydmRrTXdTdm91K09HcDFkakx0Uk1hQ3JGdlhRZzVpdm1aUEdQNWZkREx5?=
 =?utf-8?B?MUd0ZVM1Z2tkRUVVbHF1QW9YYndWM2k4b1ZvcThONjZrSEQzeGJ6RjI5UExl?=
 =?utf-8?B?QUFhOEtJL1lEUlZEaXZRY2ZzRENmTFh1dlpUZzVMeEc4VnZrbWdiZlYydlhC?=
 =?utf-8?B?SzNNS3RXVU1PNXRhN1ErU05pRnA1SnZ0c3dHdk91ZS80RG94eGo3d2RQRTN5?=
 =?utf-8?B?Z3dYSVZKWDZmRjc3WGRWdXIrVHhVUzdjM2pxZVRyOVJ6cTR3ak1xY08rcHJ4?=
 =?utf-8?B?RUtXb0lMdVRDc1hiUkJJVm9XS0NzMit6WHYxOFRrUjVwK05UZVZ2cGc4dTRi?=
 =?utf-8?B?QXpncnJPdU50MElxSnl1TVE2eXM3ZVE1WHl6d2ZkYkZhZWIzUzZXaCtoS1lJ?=
 =?utf-8?B?NWpPdzZPWWNjV2JLY1ZKT0Y5MHhZbHg5VWhoMWdRWFdkbVFmcjd3NklQWE1l?=
 =?utf-8?B?K3FTeURuLzVWVFJJNXpjWEd6RmdOczBwME81UkZmQ1VSbzNQdHJ1dVo1WUsv?=
 =?utf-8?B?RVBGMTFjSHV5ZWFPRS93eGZRVGYvVXpLUkFpMVdRays2eTVRckxWakxiVk0z?=
 =?utf-8?B?RWNOSEJPZEVHK1NPcVhvWCtaQkNmNFJpbG1XM0svU0ZNRUR1azlLaXVhUFZr?=
 =?utf-8?B?bXFpMUUvL0VvWWVkZ242RVg2QS9RYlFoOFErOUcwS2pNMU9mZVFLVE0ybmJX?=
 =?utf-8?B?V1FvQ0kxMStFR1VFRmxUVGhORGhkZjExQXBOUFFueThvYldwb05PRERNeWQ4?=
 =?utf-8?B?eUd2RUxNaDg1Zi9renVZeWIwRlMxa1ozSmgwYU1SL0RUU1VLbnFRWkNDQko4?=
 =?utf-8?B?OHJkT0Y2bW9aVCthRHgyWEhjUnFIYjR2VGI4d2NwVVhRcFpPNStwZFhVekxQ?=
 =?utf-8?B?ZHE1cVVKRGhTQXN3UUQwellnZHgzcnZuZDRkSGhPOHpWajQwMGYzdUxTQXBz?=
 =?utf-8?B?anFtdE1ZMXE5eG5MMFZmZEZ0STMvM2NUWk1obXhkVHc1cUdYdUhiNzJDM3gz?=
 =?utf-8?B?d3VBVTJkdkZDSFd6T1NNWFVQV29laGlmWGRReFJhUHAxbzdQTWlzNWNOMmVQ?=
 =?utf-8?B?R3Bma1gyVmZmcVcySVRZVEVBK0lyTkZGRGxuYVJlNjhRNngwUjdlY29QT2tk?=
 =?utf-8?B?QmRTMmRXNzVCRGJCdTFmQzdUWVlnZTN4ai9YQ2kvdEFEbEVOYmVrOG1lSXg4?=
 =?utf-8?B?S1ExdThWbWFpMyt5UkljUTdod1RyL3duV3lXTkczSHJzWTkxZmJrL1pEVXpz?=
 =?utf-8?B?djRKNHZkVGNlNGVFSUlJZG9sbDFSbGpSamdVR2o4Z3AwQ294QlpCcXVvMWNm?=
 =?utf-8?B?STdzRkZMbFdMWU1kZDhLbFRYcjhZU21zUVgvNE9YZ1pLaXVmcUZBVjk5WS9Y?=
 =?utf-8?B?N09WcUZKd3l5V0tNeXBpdStieXhZWlhwVnhJNklmeC9KRlc5a0puRUJBNDlj?=
 =?utf-8?B?SUxzajB5cHlKeWV5OTlVS1ZhOFNKWjcyUW1TVWkrelEvWjJ4UFBzSGZ2RExO?=
 =?utf-8?B?WUFvTnBxNEx4RkY3bmtEbldiaEsvVkFHL0RpVmVpbitZZFBIQWg2UVR2aUhQ?=
 =?utf-8?B?KzF3bWxkcU50cVVmZE1XTC9IVHRkcTA0ajE3TGs3d2VqMzVpRXNEbGs3aHBp?=
 =?utf-8?B?WVlwRlBhUXNHdDlXM3ROaHpDdnk3dC9VajhabFZaeUZ3aDFoZGZZNjhWYVFW?=
 =?utf-8?B?WHBtY2tsbmxod1RiWGZzOUNVTXhFaXFQajlrT1RCZzc3L21rNmE5Y1BCbG1t?=
 =?utf-8?B?RHB4dWxaRHAxYzlXbTNJeWdMYTBOMEtpb1M5aE1PcHl5Z2ExYUsxak1FWS9R?=
 =?utf-8?B?T1laMjVwaGYrU1p0YmxMR3k0eldtaUN0NDZjV2xtYmdiQjFCTDNBTW5KWEZ0?=
 =?utf-8?B?OERYdGZ1NklhQWFaQjlKUWZMaDJ2Q2M1b2JFOUhhMHlhTVZGeW90TzArUGVv?=
 =?utf-8?B?Zk5oWHR4WVdsN2ZGOWxFZzdkZ3VDaGFMbGhFQlVzVUpoT0tJTnRlblZGTGNV?=
 =?utf-8?B?RFp4NlZYVWc5a3djbFJpMkJnRkUyczZRdzZUSDlzUGxLWE1LSHlrVTB3ZG1o?=
 =?utf-8?Q?krU/UeTTV6QuIEFnd84qT3M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2399ef-e34c-4579-22eb-08d9d4bf5271
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:00:43.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEhbOVQEZeuagS7hdn5lnt7wVOCOFBZG2jwxuVI9EBxCZwn9ufOfxxuOi+T7qiyxvlJczu+E3qgfqt9zaKeE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Convert try_get_compound_head() into try_get_folio() and convert
> try_grab_compound_head() into try_grab_folio().  Also convert
> hpage_pincount_add() to folio_pincount_add().  Add a temporary
> try_grab_compound_head() wrapper around try_grab_folio() to
> let us convert callers individually.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c      | 104 +++++++++++++++++++++++++-------------------------
>   mm/internal.h |   5 +++
>   2 files changed, 56 insertions(+), 53 deletions(-)

Still looks good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 1282d29357b7..9e581201d679 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -30,21 +30,19 @@ struct follow_page_context {
>   };
>   
>   /*
> - * When pinning a compound page, use an exact count to track it, via
> - * page_pincount_add/_sub().
> + * When pinning a large folio, use an exact count to track it.
>    *
> - * However, be sure to *also* increment the normal page refcount field
> - * at least once, so that the page really is pinned.  That's why the
> - * refcount from the earlier try_get_compound_head() is left intact.
> + * However, be sure to *also* increment the normal folio refcount
> + * field at least once, so that the folio really is pinned.
> + * That's why the refcount from the earlier
> + * try_get_folio() is left intact.
>    */
> -static void page_pincount_add(struct page *page, int refs)
> +static void folio_pincount_add(struct folio *folio, int refs)
>   {
> -	VM_BUG_ON_PAGE(page != compound_head(page), page);
> -
> -	if (PageHead(page))
> -		atomic_add(refs, compound_pincount_ptr(page));
> +	if (folio_test_large(folio))
> +		atomic_add(refs, folio_pincount_ptr(folio));
>   	else
> -		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
> +		folio_ref_add(folio, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   }
>   
>   static int page_pincount_sub(struct page *page, int refs)
> @@ -76,75 +74,70 @@ static void put_page_refs(struct page *page, int refs)
>   }
>   
>   /*
> - * Return the compound head page with ref appropriately incremented,
> + * Return the folio with ref appropriately incremented,
>    * or NULL if that failed.
>    */
> -static inline struct page *try_get_compound_head(struct page *page, int refs)
> +static inline struct folio *try_get_folio(struct page *page, int refs)
>   {
> -	struct page *head;
> +	struct folio *folio;
>   
>   retry:
> -	head = compound_head(page);
> -
> -	if (WARN_ON_ONCE(page_ref_count(head) < 0))
> +	folio = page_folio(page);
> +	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
>   		return NULL;
> -	if (unlikely(!page_cache_add_speculative(head, refs)))
> +	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
>   		return NULL;
>   
>   	/*
> -	 * At this point we have a stable reference to the head page; but it
> -	 * could be that between the compound_head() lookup and the refcount
> -	 * increment, the compound page was split, in which case we'd end up
> -	 * holding a reference on a page that has nothing to do with the page
> +	 * At this point we have a stable reference to the folio; but it
> +	 * could be that between calling page_folio() and the refcount
> +	 * increment, the folio was split, in which case we'd end up
> +	 * holding a reference on a folio that has nothing to do with the page
>   	 * we were given anymore.
> -	 * So now that the head page is stable, recheck that the pages still
> -	 * belong together.
> +	 * So now that the folio is stable, recheck that the page still
> +	 * belongs to this folio.
>   	 */
> -	if (unlikely(compound_head(page) != head)) {
> -		put_page_refs(head, refs);
> +	if (unlikely(page_folio(page) != folio)) {
> +		folio_put_refs(folio, refs);
>   		goto retry;
>   	}
>   
> -	return head;
> +	return folio;
>   }
>   
>   /**
> - * try_grab_compound_head() - attempt to elevate a page's refcount, by a
> - * flags-dependent amount.
> - *
> - * Even though the name includes "compound_head", this function is still
> - * appropriate for callers that have a non-compound @page to get.
> - *
> + * try_grab_folio() - Attempt to get or pin a folio.
>    * @page:  pointer to page to be grabbed
> - * @refs:  the value to (effectively) add to the page's refcount
> + * @refs:  the value to (effectively) add to the folio's refcount
>    * @flags: gup flags: these are the FOLL_* flag values.
>    *
>    * "grab" names in this file mean, "look at flags to decide whether to use
> - * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
> + * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
>    *
>    * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
>    * same time. (That's true throughout the get_user_pages*() and
>    * pin_user_pages*() APIs.) Cases:
>    *
> - *    FOLL_GET: page's refcount will be incremented by @refs.
> + *    FOLL_GET: folio's refcount will be incremented by @refs.
>    *
> - *    FOLL_PIN on compound pages: page's refcount will be incremented by
> - *    @refs, and page[1].compound_pincount will be incremented by @refs.
> + *    FOLL_PIN on large folios: folio's refcount will be incremented by
> + *    @refs, and its compound_pincount will be incremented by @refs.
>    *
> - *    FOLL_PIN on normal pages: page's refcount will be incremented by
> + *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
>    *    @refs * GUP_PIN_COUNTING_BIAS.
>    *
> - * Return: head page (with refcount appropriately incremented) for success, or
> - * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
> - * considered failure, and furthermore, a likely bug in the caller, so a warning
> - * is also emitted.
> + * Return: The folio containing @page (with refcount appropriately
> + * incremented) for success, or NULL upon failure. If neither FOLL_GET
> + * nor FOLL_PIN was set, that's considered failure, and furthermore,
> + * a likely bug in the caller, so a warning is also emitted.
>    */
> -struct page *try_grab_compound_head(struct page *page,
> -				    int refs, unsigned int flags)
> +struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_GET)
> -		return try_get_compound_head(page, refs);
> +		return try_get_folio(page, refs);
>   	else if (flags & FOLL_PIN) {
> +		struct folio *folio;
> +
>   		/*
>   		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>   		 * right zone, so fail and let the caller fall back to the slow
> @@ -158,21 +151,26 @@ struct page *try_grab_compound_head(struct page *page,
>   		 * CAUTION: Don't use compound_head() on the page before this
>   		 * point, the result won't be stable.
>   		 */
> -		page = try_get_compound_head(page, refs);
> -		if (!page)
> +		folio = try_get_folio(page, refs);
> +		if (!folio)
>   			return NULL;
>   
> -		page_pincount_add(page, refs);
> -		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
> -				    refs);
> +		folio_pincount_add(folio, refs);
> +		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>   
> -		return page;
> +		return folio;
>   	}
>   
>   	WARN_ON_ONCE(1);
>   	return NULL;
>   }
>   
> +struct page *try_grab_compound_head(struct page *page,
> +		int refs, unsigned int flags)
> +{
> +	return &try_grab_folio(page, refs, flags)->page;
> +}
> +
>   static void put_compound_head(struct page *page, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_PIN) {
> @@ -196,7 +194,7 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>    * @flags:   gup flags: these are the FOLL_* flag values.
>    *
>    * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
> - * time. Cases: please see the try_grab_compound_head() documentation, with
> + * time. Cases: please see the try_grab_folio() documentation, with
>    * "refs=1".
>    *
>    * Return: true for success, or if no action was required (if neither FOLL_PIN
> diff --git a/mm/internal.h b/mm/internal.h
> index 26af8a5a5be3..9a72d1ecdab4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -723,4 +723,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>   int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>   		      unsigned long addr, int page_nid, int *flags);
>   
> +/*
> + * mm/gup.c
> + */
> +struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
> +
>   #endif	/* __MM_INTERNAL_H */

