Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9320148A89C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348609AbiAKHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:45:00 -0500
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:49377
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235501AbiAKHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:44:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBcrCMw4YtttIdqyAgjZkknkkeCVyVaZdZdpq5g4k4lEFI3aHuXPihQGR/7mWgzU/cvkHDDGxc6GmvQ9Yd7aGCHPFxBT8iQOYafU02WeByV9BYT4sfouRyygkziNgTqoUuhaRbjcci6YjxY5zj3xfsqHefrx9+JynrAODr/awtrfjfXGdVUgnt/c1TKltf77yeKhiADqmwMqvoV9odV9ro8zXXU5AY+qPReS1zwfpxbKR3QiAZqnl+lh5oM0LkbMEA8VxfTkFGMbIxeSDuC/mvQeKxBQwFGHpIHsXPUimVlUvQOQq+m1YRdg2x2TcVOAWt5XwTeJy4R9riAHYe/Axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCYA1z46xI+r0RlK8trA0RjUvXKf4AfYNA4JQajxxjc=;
 b=hK/N0SG+znV7Ys66Rmrv+TRu/iOxYH/3o3hYnw8EP6Qd+M2l+2gtDEGHEfZ7tTr/8CfJ4eWVZ9R/vtGK9xxuj85vk8xllHoxRUYrx899xSyvqb/MyHHofwnZ2p/Ud6TRbF90g2XKJE1zaSO20n5dzoFI9OOJlpm3Hr8Y1/wOsZSrOJ5Q5ihhFQ021eSrvSBc5ATP1eeMZv9OnNt/ZaCmmGlcFLekR5gJ5aafTNzPMMy1j6HAnoT2a1K8VBOd5QZGKUlVfywNICnZijP5n58fU88uwUGnGrrWQdO6zXOtvfM8H3ZdCCjD/P5/+6s2rnwbhvJfhpHr2PPfS5YQW/toDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCYA1z46xI+r0RlK8trA0RjUvXKf4AfYNA4JQajxxjc=;
 b=HEcw+J7GIlf6mhsslHZL9juyVZwzEGGoQ3X1XQZvD1uP14KgDXlaB3NdoCDT1PVUu4IOqdviPnn0OO1jRQn4Bd8+oWk3/1fZ1uAsNZ92YPMqW98SqtY7K/LNQy8R2o63D9gC9/koSaoRjTM0T5a/4gav0vNgy20HcJFEq9ZZ9i7Dd4JkxT48nG1Tg8TeaISVPRQTKzZyVkCTEWhkWck+c50dsELmqg/HmmLZFDdMlLy0obm+6AoU2MkOUQaTigmXQWFPiP2e9VJXSDbfi6C+dtrgOJKVc0RNsiDwbtsU/MqFqcKVzDDWQ7dapZN9eDLx+jOnR2esbIsBLPZZmFDXHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 07:44:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:44:57 +0000
Message-ID: <280540de-99bb-91f0-1850-1efe828e4b45@nvidia.com>
Date:   Mon, 10 Jan 2022 23:44:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 26/28] gup: Convert compound_range_next() to
 gup_folio_range_next()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-27-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-27-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::47) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0be5ed1-b468-4fcc-21a7-08d9d4d6436a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2840BCA40183CFEC5BA896DEA8519@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLfMciQ062JfBbvXIwYJUCDfmzP52hE1/ibzIMKIxjnn+f9AUUElfw+0H5MA9UyXF6aZjIcVsetQgwE3hSldBF4aERXGXtatxLHQiYXp8F/BfdmpQIOzFF0ENdppppx9hGa2beBdvA2X9CJlSpJScx3OI1k3lcAIDNsrUlM5HPZQpT8sNJpxfB/KDw/CPUW3moBZnZ0aFxN5ZnRt09PZNKJRSuwmM/wdx+QZAV+dI7rhGaeYmKKXHo84tR1SDhiZ1B91eFU68ZpzFKqQ8FDUALShtwdbhKMJelTgh/7JCaukr4UZISKp5eCPqiaY9hTZFhh0295xpHRuZ7AcW4FvNwkxtX7T+UrsA5ge7upYqtdl7MsbUw4aleOD3eY+wB/6U3VxuxtQslKzVaz8wNEWL5KqFHkEVHT9Bq+GlqT/DNElx9VTr1ychWP47PeA8aUGOhJHeBWN0/xX9vI+tFsq9Hu0AmmnstzztlcEcjqUuu2gIT0wy1Jxc68zjkV5y6AaRkBXPVLDB1UwkrSfk2v0rsGWEOPPuGURyiv0C61XZZn5/9YTbZycQB7q8n586LgwTZQBucBZ7ef72Ayw4jx0a99xgapdhfcQe2NjzfOGxbQxDTcFzIl62CK8A07Z0ZZ3PKhs6eP75OQnXA52h2zUn6/iWhTTqaSDbxQSVtht8ZfYKmMQG0TlJ/ERURjrzqhL6Y9jmq/beJpUYv8eq5RGHHJK46S2NpWqyCH/UDVSwtJRsd3nrGPM8bi+6l4xioPi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(508600001)(8936002)(8676002)(54906003)(66556008)(66476007)(31686004)(38100700002)(5660300002)(86362001)(2906002)(53546011)(4326008)(6512007)(6506007)(2616005)(316002)(26005)(66946007)(36756003)(31696002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZGS3h3R2JmeEVtdytTR0VKUllVVXhSay9qcUtlQlF0cnZtYXJQd2VsQThk?=
 =?utf-8?B?SmtpazZ2eWpsT1hkb2FGbXl5Q0UxdzNhRitIQ2pZMXBpZkF4Q2EyREFmVWJy?=
 =?utf-8?B?OTlQZTRMUkZYdkFpTHpLVUYySXovYVRkS0orNE5IRnRTb1JxRm8vb2w3aERj?=
 =?utf-8?B?QlZWYmZMdjVXVVlFWUtncWtTb2l4b1FIQU5FaDBaNG1oNDhscVBGK2EwTU1k?=
 =?utf-8?B?YmxaZ2xURVF0bHRLbnl4d3JUWStVWmhMT0xUR0RYYytQa1V0SG4xN0NsTjZh?=
 =?utf-8?B?N2VSUUhlS2pLblVBV1lSY3RoK3VTdFRPalpuVk1KeGFEdmJJM2dIUWNSc0la?=
 =?utf-8?B?RWEvNXA5WDRVZlhScERhMktqeDdFc1EvSWh1dlZicWgzRFhrRWFsMm9vV1Zi?=
 =?utf-8?B?NCsyQnlMWlpKZ05MbG9ObmpDSDlQN0kzODdzZThuRFY5V2IwMEhJdm40cTJX?=
 =?utf-8?B?N01LR1NWemFJWEJVS1YzOTFmNGdwejRKRlFjSUJ5RExJWnVjSk5DaHU3Nm5I?=
 =?utf-8?B?YTJGVjU0M0dkSWlYVzdDVHNpck1Jd0plWndNTStGTnkyaW9QMVlVelY1a0h0?=
 =?utf-8?B?U1Jrc09wWTR6VHNReWZDY1E3R0UxYWJoRUhhSmpHT0ZqTWRxejk1c3p3aFUw?=
 =?utf-8?B?aUZ1cGRzRjNsRkRvY3loSGNvUEdNSE5pVXA0S3NhN0txWkNoVzZWZzBGNkN4?=
 =?utf-8?B?czNOei82NmFvQWJnQURDRkRRKzhPNmY0b2p3NFZ3N2lvYm5qRW5oK1RteWtN?=
 =?utf-8?B?TDhyTlFPS05zSzRUSEd6Zkp0MnFCaDNnWERhK3ljUmZEeE1YbHptKzJMczZ1?=
 =?utf-8?B?MnlmbGtGWHh6ckhINWZWMXNUY2cxZ1IxbkNPQVJpM01HK2NTTmNaYUZDelIr?=
 =?utf-8?B?M3lwTVMxVW9UNWtWbXF6Tlh4WVp2QzdtYWRNc2dSVFpIR21EVFNGbFlUS1NB?=
 =?utf-8?B?T1JIYmRvQVlvSElpUHNVM01vaXozdExMWlZRZFVrMVFQTlMwNmhrajNadCtq?=
 =?utf-8?B?cUJMMXdxa1JIV01wY2IxdjYxd1ZLRnhFY1k4Wm10cUtOTEpVZXdUSUhsZlU3?=
 =?utf-8?B?NXMxUGRQWlZ4NXNPNU5Tb0FEaElHUXhxb1IwcTg4bFd5NTBnZncwVWFGQVAr?=
 =?utf-8?B?V2xnUU8wSWtUVWsreWc1WStwRkUxeHZkdWl2U25NV3lUQWtFVWFjR3p0UGtJ?=
 =?utf-8?B?cHZpbDRWWk51U3l0SGV4ZTAvcklTQzJ1NndFbktaZU1LakVJUThIZXFLWlc3?=
 =?utf-8?B?dkxWcGIxZVc3VHE2cERDTytXNTFCSHBPVzB5RDErSzE1Zm1TRVNYUWlHU0tw?=
 =?utf-8?B?cmZ3b3V1RnVoTnNVUzF6ZHpuMDlpU1RhbWtZYzFIQ3dRdWd0TkJKMkRmTjRp?=
 =?utf-8?B?MGJoZlh4c2lTOVJVeXplc3QwRFVOem4yMEE5Yk1zeWdVSzFjQTFnK3JqOG5v?=
 =?utf-8?B?bWt2cENqU3ZEWWh0Vktzc1JkNTZMUnZoZXFJSlgwL1BjdEsraGhUOCtUM29J?=
 =?utf-8?B?YWxsZERNVjZmV3VCK3kxVlhYVDBlSDU0MTdNcnJmMk5PKzZTdWM0aW5ZZ3Zu?=
 =?utf-8?B?TGN0K1pFQVdlRTF0OFUxUnAzVDBoSUtuK0xjbzJ6dmpBa3ZQdkVqeG8zMngx?=
 =?utf-8?B?RFVacnNIMkpoOFhFWnFNVkxNTFFpOXBBZXgxMU1GNzl5YzVJM2poRTdsNUps?=
 =?utf-8?B?ZzFKSkhPcHZoZDIyVHcxeGtvZGpDZXdNNTJkNXBrcmtMVFlZTVlnNkp4eGh2?=
 =?utf-8?B?dGlZZjhGcUUzcUV4eksxdk1vdkNCalRsb3JYSWoyalN0VTFKQVNzb2hWUmVD?=
 =?utf-8?B?WFlIYXgxWGtMNkczMkV4MjNXdGY1eGJHdFExc1FuLzRWYzV1VHlWbHpPa0oy?=
 =?utf-8?B?cEUrVG9RbWVYOTBKQTkvZkFUa1lCQ0gwOXgvVjFUSjdBUkg1WkVnSkszSjMw?=
 =?utf-8?B?UFBHVFNCSVozS1h2bFdYK2tmSkhrME5nT0RldWhMSk1ta3hRTC85ZHhDVHpi?=
 =?utf-8?B?ZTJQbFB1T0Zva1hnYkJySEx4RUlUTDFVeWEyeGJWTU5XSWs0bS9MeEFtV1VM?=
 =?utf-8?B?bERiN3Z3K0s3T01pU1IxUGdOSDVzY1o4bmVaQlBqSG9EYllLaUdrZHdPcXdt?=
 =?utf-8?B?MnEzUDdvamxsYTcvZ2R2QzVCMWdmZjNTOHlIeGFCV280RDdzcU1OY1hhMzFC?=
 =?utf-8?Q?0U6LJ3pwi8hrlz+Jl9mVsew=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0be5ed1-b468-4fcc-21a7-08d9d4d6436a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:44:56.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTPRswzhrGu8ltzi0cNcrLVwNs7XMbBNm0D6pzhQCUVG2Jw9Tnw6w+/hOAvdacuVd6Oms0IbeYo2WnrLg8/KnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:24, Matthew Wilcox (Oracle) wrote:
> Convert the only caller to work on folios instead of pages.
> This removes the last caller of put_compound_head(), so delete it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h |  4 ++--
>   mm/gup.c           | 38 ++++++++++++++++++--------------------
>   2 files changed, 20 insertions(+), 22 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c103c6401ecd..1ddb0a55b5ca 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -216,10 +216,10 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
>   
>   #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>   #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> -#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
> +#define folio_nth(folio, page)	(page_to_pfn(page) - folio_pfn(folio))
>   #else
>   #define nth_page(page,n) ((page) + (n))
> -#define page_nth(head, tail)	((tail) - (head))
> +#define folio_nth(folio, tail)	((tail) - &(folio)->page)
>   #endif
>   
>   /* to align the pointer to the (next) page boundary */
> diff --git a/mm/gup.c b/mm/gup.c
> index 0cf2d5fd8d2d..1cdd5f2887a8 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -156,12 +156,6 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   	folio_put_refs(folio, refs);
>   }
>   
> -static void put_compound_head(struct page *page, int refs, unsigned int flags)
> -{
> -	VM_BUG_ON_PAGE(PageTail(page), page);
> -	gup_put_folio((struct folio *)page, refs, flags);
> -}
> -
>   /**
>    * try_grab_page() - elevate a page's refcount by a flag-dependent amount
>    *
> @@ -204,20 +198,21 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> -static inline struct page *compound_range_next(unsigned long i,
> +static inline struct folio *gup_folio_range_next(unsigned long i,
>   		unsigned long npages, struct page *start, unsigned int *ntails)
>   {
> -	struct page *next, *page;
> +	struct page *next;
> +	struct folio *folio;
>   	unsigned int nr = 1;
>   
>   	next = nth_page(start, i);
> -	page = compound_head(next);
> -	if (PageHead(page))
> +	folio = page_folio(next);
> +	if (folio_test_large(folio))
>   		nr = min_t(unsigned int, npages - i,
> -			   compound_nr(page) - page_nth(page, next));
> +			   folio_nr_pages(folio) - folio_nth(folio, next));
>   
>   	*ntails = nr;
> -	return page;
> +	return folio;
>   }
>   
>   static inline struct folio *gup_folio_next(unsigned long i,
> @@ -326,15 +321,18 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
>   void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
>   				      bool make_dirty)
>   {
> -	unsigned long index;
> -	struct page *head;
> -	unsigned int ntails;
> +	unsigned long i;
> +	struct folio *folio;
> +	unsigned int nr;
>   
> -	for (index = 0; index < npages; index += ntails) {
> -		head = compound_range_next(index, npages, page, &ntails);
> -		if (make_dirty && !PageDirty(head))
> -			set_page_dirty_lock(head);
> -		put_compound_head(head, ntails, FOLL_PIN);
> +	for (i = 0; i < npages; i += nr) {
> +		folio = gup_folio_range_next(i, npages, page, &nr);
> +		if (make_dirty && !folio_test_dirty(folio)) {
> +			folio_lock(folio);
> +			folio_mark_dirty(folio);
> +			folio_unlock(folio);
> +		}
> +		gup_put_folio(folio, nr, FOLL_PIN);
>   	}
>   }
>   EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);

