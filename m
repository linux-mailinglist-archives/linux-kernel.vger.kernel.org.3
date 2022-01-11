Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297AD48A87E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348545AbiAKHgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:36:12 -0500
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:26721
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235278AbiAKHgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6tzm2zQVguPi3X6d9BhOw2esUwKdbQlr5Ty8DF2QFovUewmoyOtsWjVZTttasim9qVRL43UacV8a0wq7CiXx+DdgC4Qcpb/uQmAzCRsVO2S1qICtwSO3m43lY/ug4t4P7t8sMaYHeBsvIhJtw7BgfFosvYRBVRlluTpxEdN8lkE3Nzs8zkLhnqebVhbFHT8O9KXwikVFavBm+tUK46OkCCorvGfPQAWtampd1hz9fsSEH3e7sFOLmikQwUXrB5LrHDHCoKFIU1TsEKDfTfCOJZhFjiqnXGYSi22EwC48SUOb+IFoCGwn4ypIsIvxxoffhxbnwqVRlBs7zBCRaTy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9vBKmKInw1kHxcCfqmU+GlaeRfALJS2DyiQNI1vUl8=;
 b=mv7f8P67WjWuItjVD6pHKnaOz/JfLnG7wvPqgBoosDqd6FOuFu1N/+5OIlKODzwQJqHjlx4MbjGhh4Mt1KZVeQa9Y0xyf4z6H5FCVjHPgHqe3JMRKKOXSXOjFTrlHawrzpya9uxVa/ps3OMreZWtjK7gpBt6xATbCL6iUX+oLC93bgozHp6Aq9ADvi8fkBI0IVk48Vc6J0xpgyEHR+z/0vzY2wo1R+M9gLaC/R2ya+85cWgqiURlJ+xLBqhw6RKetwQ27VjcDTc/3GE3GpawAS53yGYLlPfp6WmDWP6zUOxNd47rbpEgEP/O7LnLytGM0LSAc7RxDv3pr2jIKmU1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9vBKmKInw1kHxcCfqmU+GlaeRfALJS2DyiQNI1vUl8=;
 b=R3AHDGeFTlAY4Thf9VcVIZ+cpNgKOKr1odP+WUAZtDpdT2i/OndsgxxwGNDrDbhCGbnI0IFO+j+9dm5dIqXNZ18l/cAd3/ZYQEunemCYKzfCtdVsJ5H5As6pmin94qk/+8P4zW+vBFuuD1t+VJ7CFoFvGh8dBQD5YtY+4ASAlSYced1+MaCRop2TG092MZfHG0kQOBM/qiRikEIa3MyN84Sl0gXFxlvQxoQGF/EN3tycgXOkOJ/MvL7uffAh95NZfNSF5n/yym1BQE0NxTyvZDI4LCIUHRbYoXEpBdBEOP/9TfpajFpWDdlYP1+/erFvnxl3obBPmFl1s5APig0dUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3972.namprd12.prod.outlook.com (2603:10b6:a03:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 07:36:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:36:09 +0000
Message-ID: <7d0aafa7-8cbc-f77f-bce7-31517173432d@nvidia.com>
Date:   Mon, 10 Jan 2022 23:36:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 22/28] gup: Convert gup_huge_pmd() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-23-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-23-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f4cbcc9-8f49-4412-e2ed-08d9d4d508c1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3972:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39725A93DDEFD831B24B27CBA8519@BY5PR12MB3972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VV9MOA4Zu+Bn/JJ+NfTq6Y4qWH/pz4bIfgc8fg3nkJZkf1mxI9v1CkncrELO9/7rlVUolX1Fu+desHqFQMPqAw2ofL4gxn9HEHCzGhGHzBuxnmKh1dvc5UVisaTYQGbZhkdWmJcLhyv1uUR7Aso+M0KM2jX9VP26vPhRzhYdg+3zniSMsmLzQKkh1Rt/PxjJA0u0z+VaF+vC3K0+qNfrbBQgo2X/TN/J2/jSHIrkJPhZRl3rYdEdSqMV42jvKQgYMM19EJVKXAusDwro2BG65U7V8VChwbvOWSAReu/3ZMVmnZxr+WZxKTqcZsMiJdn5AcHihqxFPjbfrFmRjfjPr1ti8nPuIlUieaGRtmye3/sB1FkaaLloP0St4pSYVFFXWge/Kpqh4oZ+quIBYiu9NtkD0VXkz0VrwEox1KEi5fn8jt2kOQdvqKIZCkBDYQNKvwrka4yPJ/wusvb0F2swnLYL0dWsgDKfhe15cqCjD1icYnn5jAEbIEcs0rmdNG41XhHtC27EpPJ6newNkgu+IH9JZDwlUf2rO1j9DpzoTCgXXD6jmGRG7SkVA4tglXrpp+TijOkBP8Tfpt2ZcsvqIr35HkQNw9qV7rq0ff9zoqlERVcEXaV70RSCiFLUO13oiNVaEG3u/TGVkKpqWJjV10OF6AKLdxS0RQZaMLaGesFLIMMd3pqJj3Efyf55DKrArv9/b1jM/4D42322NPMgPwMdu8GnGwvl5I3be8Ah8E2IEhE+NmQPBmrv7S9XWXmG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8936002)(6486002)(316002)(53546011)(86362001)(6506007)(6512007)(54906003)(186003)(8676002)(2616005)(26005)(4326008)(31686004)(31696002)(83380400001)(5660300002)(2906002)(36756003)(66476007)(66556008)(66946007)(38100700002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9BaTEvR0ZOVWFLUGRDZFVNZWV1QmVxYVlTYnIrbkRMKzdqcmI4U1c3Qisy?=
 =?utf-8?B?cUVjNzFXYU9hTkxKckxJejkxVkN4emF5VmFBMXc3dlp5d0I4NlVsblNZWlVF?=
 =?utf-8?B?REVLVnZMcDEvYVZUYnFMTUx5U3JxdG1zN3ZTWFdBSDlkLzZWYXpEMDVwYW5F?=
 =?utf-8?B?OWZRNGdwS25qQ3dwQXQvMXhHUUlnQWw1ZjlUOU1hN2daalc1WHMyclEvNTVU?=
 =?utf-8?B?Q1p1MllTSXFBU0xoU2dJTDh3bnpqYVhzY1RLTHpNWWo4Sm0yR0FZSDJ0aUp2?=
 =?utf-8?B?SDlod01zZzdkbjVlTnd1aTJmQ3hlUmlPbjN5OHp1Q2tGaDBGUEQxLzN5RFhC?=
 =?utf-8?B?YXNJMWUwbnlJWkxTTE9YOFQ5WEV2NW0zYXJ0OG8rNmo0ZWY3YWZrT2tNYngv?=
 =?utf-8?B?NXhYaWRHYktsM2lyZFpyUzdSWTdSejBFYW55WkVwSE1DSVJORGRvamUrZDJo?=
 =?utf-8?B?dnZDWlZoR2xXMCtHZThJQzc3MGtVVHA4cEt5V0Zxa2g3anJVcmgxRnVTTmVp?=
 =?utf-8?B?aXYzTnhvYVhmS0YrRFEzN3diTUpkN2tZckdXMlFYdVhnWXkwWWZVZExZcllJ?=
 =?utf-8?B?YWlTa3IrckJ0SjUyQmdKMk14VlpMU0d4ZEZTdDlKY2dSUS82TURPL1ladzha?=
 =?utf-8?B?QzQzK2JnbjFaTytLRXpZMlN2cVpvWXZEMHJyTWlJZHlEMFB2N3ZWS25vT1pz?=
 =?utf-8?B?Y3k1d3JQclB2Y2E2MTA2elZ5MUdrcnorUDJraWhMekEzdmdSdXhGM2drcVJY?=
 =?utf-8?B?WnJhMFN2SlljaEo1YmtNRzlqL3pETi93U2trb2M0TlhvWXRaUzlnbUN1U0I0?=
 =?utf-8?B?WklNMU5JbTIvQk81bUlNNkxwVUtpY3pxRFBwZ1FBYlloS3VaeWlqaHNSdXE5?=
 =?utf-8?B?WHEzT0taQzdDWWRIUkxScCtGYVJmYlVpZjRLZFpNYXZiT2hnS013TGNmanRv?=
 =?utf-8?B?ZzdYd2NPYzBiaEl2VFlmRVd2K1J3K2xkZmMxQ0xlUHQ0SjV2T2NySGlmMGtK?=
 =?utf-8?B?MGlxUXBkT1RlMkxuTnVYMm1MRnY4QzZoMWdCOTZtdGlBY0NGSTc0NElQQ0Nm?=
 =?utf-8?B?VHhtNDI4VjVjalpET2NGMzRnME9Id2hCQzZOSGY5b0c0TzdpbkpCM1VRNkg0?=
 =?utf-8?B?N0xJMWRtUWpUaWhRK3FBREYzOTV0VHpEQ2gzMUY0WC90M2VYNU53WDA2SzBH?=
 =?utf-8?B?YzFja0RKQzNCZUhkUzJoblhrZklvRHRPdy9YaElnZS83cjZSRWg3cDZBem95?=
 =?utf-8?B?eGY5VWk2L3M0VGRQM0luL3FzenREQTUvT0x1SG8wbDlyLy9XaVVrR0pZaEo3?=
 =?utf-8?B?UFcrNElFZnh2TWlwN3ZXVlhpYS96T0w0d2c3Yy9VMGRkaFgxbzFJR3pONVpL?=
 =?utf-8?B?UWF3TGRHM0pKWExsYWFlQkdGa1h2YTJBdGYxL05tVnJDU0tET3dMNG9MODZp?=
 =?utf-8?B?ZS9XQVBtU0J5dHM4Rmc5RTBIdGVLaUczSVF6UjZ3TThsWnU2Tk56b2dma3dM?=
 =?utf-8?B?TWVUU1pPMTB5bTVvRVQyU2gwb3V1MXB5OUpqOVNoWWY3dVRldDYxcm9xZTFk?=
 =?utf-8?B?dXNacjhUcmZOT0xQNUVXdWpkMEpjeDJla3laVS9YWGlFSFJHcHNpN1BEQkZp?=
 =?utf-8?B?RFhSVlpnUkVFTUE4MnlGRlNMU2Y3Q0IwRWt1c0N6clIxM1dJTnFjWmNVdWRh?=
 =?utf-8?B?ZGJzNlFneFRPbnZlT0hma2dJTitBQ1k3Vnl3UGNwdk4rblZsc01RdzVHRnlk?=
 =?utf-8?B?ZitveG02cFZnTy9oVElvdDF4UWpsbDVObDVPUWNTOEk1UWJiaGNndWJMTFEz?=
 =?utf-8?B?NmdreHpFYkkyem1yR2VIMytUcWFsdHlzMm42VkxjcmZYdzFITWNoWHZXQW1D?=
 =?utf-8?B?R21BMnV2Ukg5UXp0eC93NHQxZksyOEdYKzl6blBCbTUyVVpYSnVmZzFKRXNF?=
 =?utf-8?B?dDZZWlpYVEFWdjlpb1Y0bWtYbFhGZnRNSVlHdTVaRXFHa2ZlZmdYWEZ3ZzlG?=
 =?utf-8?B?L3JYQXlzMmNCS0Q0bXp0YmtBb2pJc3pYdjRWbHhwbXdOVnlDK1BKeGZHN3VD?=
 =?utf-8?B?ZFA0N1dUaUhGMGNJeW1zOFR0ajJEeEpxVmptNVArZ2FUdFJodzBKWnFheXhT?=
 =?utf-8?B?eHBsWEdmVVQ4RE94TDNYazhqYkhPOE53bzZHTW9HVUprdlRVcTZmeHVWazRQ?=
 =?utf-8?Q?0Qe9C5LXL3FZsQ+p75NJaqU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4cbcc9-8f49-4412-e2ed-08d9d4d508c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:36:09.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fK/5xCJnXKhFjdGebOn76ZpZZR8OWVmejncCFZwll/Rzubrdy/HN/QyceesMOGZpAsEjN7Eg+eeHViYaukVbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3972
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:24, Matthew Wilcox (Oracle) wrote:
> Use the new folio-based APIs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/mm/gup.c b/mm/gup.c
> index 250326458df6..a006bce2d47b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2492,7 +2492,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   			unsigned long end, unsigned int flags,
>   			struct page **pages, int *nr)
>   {
> -	struct page *head, *page;
> +	struct page *page;
> +	struct folio *folio;
>   	int refs;
>   
>   	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
> @@ -2508,17 +2509,17 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
> -	head = try_grab_compound_head(pmd_page(orig), refs, flags);
> -	if (!head)
> +	folio = try_grab_folio(page, refs, flags);
> +	if (!folio)
>   		return 0;
>   
>   	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> -		put_compound_head(head, refs, flags);
> +		gup_put_folio(folio, refs, flags);
>   		return 0;
>   	}
>   
>   	*nr += refs;
> -	SetPageReferenced(head);
> +	folio_set_referenced(folio);
>   	return 1;
>   }
>   
