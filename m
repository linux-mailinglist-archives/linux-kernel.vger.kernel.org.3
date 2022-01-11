Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8D48A54D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbiAKBre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:47:34 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:4577
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243903AbiAKBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:47:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7+yKLI4TCthv5P4njR/w//tj20bhpSA/BSeslB4m3BBgnhN94tkPu68hnPhvVX+BkPnNpAHd0WPM+ARgCr+wTnvKqUr6wIDJDp6RN8nY7ygAky5oV2D1YCtP6LJJWMeBukpBFL8hcyx2n+aYu8MedYGciNwTn/9iQpw5R8MCwbY9Rfh8Qjo5LrMQED1ndz8Kl7n6bisMi7+u8PvvWfJFJN4HIoYL0l7BEw4R55kh2S/kcwW14jxG9bL0+EUBbq8dRjv30tlV/ZMWzPlOqzY871EQfVCS/3AVYS13Hph3SbTflIbmLGHcsQmVp6YOixDZ2JkzEO6Sw5gb72FuIIyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXme3LxsvgN/ucEtYYixWBChlHbReaAzbiCQaUqOEN8=;
 b=kraCF1B7D1MhAGPvpzxwoimV786EyKhXIg7HcQFrH3S9VfNH7b0Tpf/d6yaOScEEplHLFtBuPLjRgVaw1DpWlnX+ua1r+QnvklsN2wEWw7dSQt3VmJxpYIV7jiapHlbIQaQCgZtbk+9Cvz6yekqPfonOYe4yiYEz1PizGeBZRrTB4ymubvJmY/RDuoSO8ZrMQaB6UDIWrBScwoAhyOWhWlryOVfW/dUb3vJGTz+NDpvZyAC07WAqZVvcOEsBOxvh4LDYp4JVPcqP0L3JElvkLRK/WTZc1KA6kgIqPyi5ijrmLFCnt5H6Xcq+f3MHGmhz43QxZFlFYuJQiU0ZKdO5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXme3LxsvgN/ucEtYYixWBChlHbReaAzbiCQaUqOEN8=;
 b=GzZ6LfUOTFQaUL+iZb5AhM1s5rSfnaH8+WHHUzGUyg/hX6RsKfmhLRTsvd8Xpb/gLce3bZ7BnWdCdDXTlYtdb96mCT03l8PEExNVqkXZsyITCy1OQ0hUL4sfu4/c791THHitvOVyEwxMGhIj6HSTZdUdUVTUiX8mtQGrQp0l7dI0eMSmraM/sTqk7mCnF/VJBhcuVKSYpyGxBgWLu7Xf/T1AuYu8bimXlMqNqT9d7E0eIa0tWeDCoBP014uX1PYmjQFamz4/NpfEghmEEaWvMSw3HB6aC7xoMiIuhnZel8CJqITl/KKi1BOzTBRxo7cjpZpvNv9dlnnsOvDJdhzjug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 01:47:31 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:47:31 +0000
Message-ID: <f4954822-16f9-3239-539e-ac7549700577@nvidia.com>
Date:   Mon, 10 Jan 2022 17:47:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 06/28] gup: Fix some contiguous memmap assumptions
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-7-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-7-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84028ff-9a31-40b5-58fe-08d9d4a454db
X-MS-TrafficTypeDiagnostic: BY5PR12MB3891:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38910D09C62D505CC0D34662A8519@BY5PR12MB3891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuLo/JrjmjuQzJgNhXO8IHqTLZjm2Te6TrxP2bDESoLGPDJn3dJXMMLxcT9i99lDdz7C/i3Lu6OoSKSSnCp2kQt29jNu6R0e/gR/4uH82ZlIk05rgPdUWsqHBiOeTLD9oGclt9aoW1cuJbJIMfCpw3T3P5gObGb132kiwcE9IHiqPSpma8b2FGrT1Zfa743K2RFuyZq1s/bu8FjxEV6vzreb2yi5JGtv4NXcp9IROspnB9iAUKg8HOIYHZRhDUR1UY1eQTyIm/EfBMwBtHoZiOfoqDXF7jqbwkj6EHVJNFG3n7k1gzXohRDbPBu3s+/GFesxYNRUyKY4xaPSTR3TH0kV+aVFquedp3Kh6vCCz+534vZZw5Zii0bX/GGnJT3YO171l1qbSKbbyNwj0nWDPML8wInL3PnYyS8bKiTRpyYWz75Cjs/wXDN74CCyOUaWfDvX4wk759SwEVtyy1Tm5XefLhkXXEGAyIbT4Zc0Y0LO/jbMSxidXdqqqHETFL9cy1N6DKoTV+aheJACqAg4B3gfm91thv92fEs/+shwqLVjCgrv7/mZqpScLEWatpZmYuoxfoGfCrIwpAokEHSZyCuqW7kaNNC0QOP3Dbk+IzcCYjd6BRIrdaPpCs9CQha2K6QgBRy9t1JSjI69ajVZ9jbLDzr2P0WhEhqlCDfXZ1DNeoQAF/oiYpr29qjmbtUCL9ozwXseCJ2R7GGnAUNKg/McS+9T/CM6MebJzoILmuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6512007)(53546011)(186003)(6506007)(26005)(2906002)(8936002)(66476007)(8676002)(66946007)(4326008)(2616005)(54906003)(6486002)(36756003)(86362001)(316002)(5660300002)(83380400001)(31696002)(31686004)(508600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdvdFQ5em1WQnp3TWYzRGR6VVkzWlFNVWtUT3kxNDNDVkU3WFgrTHV1UjVY?=
 =?utf-8?B?TTFMb0ZBSi9XNWxLekhyL0JpUTBsOEJZZ0JvQUVtSTQ2NjFvUTFma3NZY2Ni?=
 =?utf-8?B?S0xOcnl5Z2dubWszU2FiWmRZSWFXa2d2VGpIeVE2N1RyMGtCQzczd3Rqbzhy?=
 =?utf-8?B?NHBkbXd2UThWUGNrN1U2anpjZTBSeUd3RWdRZVlPNlFwTWxLN3ZvMkIycS95?=
 =?utf-8?B?YVhUYWZxaDF5VjhIaFJDbmNUcGM5aVU5cmltMWtxZm1YcUdEc2Q0TXdWVVhG?=
 =?utf-8?B?Ry9jV2hsc2JSeDZMbE4rQlc2TGRzdVpVQmlISWNLZXZSRVlBR0s5bHFnWExF?=
 =?utf-8?B?eVltcWxKTkFsY08xTmFyY2d1VzNLQmdHRW9wamgrTXQwM1ZicXhMaGY3RWZ3?=
 =?utf-8?B?ajFGcFlQSkJaSkVRemYvVC9Pb2tmM2ZTZG9LUDFaU01OSEhUZUlIWWxsTE1k?=
 =?utf-8?B?TUVrdXBmNlg0ZTdsaWIvMmVFWkNZek5QcU9qdXlRbnZZT085cU9FY2p5Sit5?=
 =?utf-8?B?czk5SjdCRTZvbzlGVlJhVE41Ny9STVAySDBjS0lNRkxVSlhmYjkxRFhQcjV4?=
 =?utf-8?B?cEFiNUxaT2dTTk5XYnpNeWl1UFNOUWxOdFJOREQyUkZ6bkRFR1dJd1h4bFZZ?=
 =?utf-8?B?ZVZZNWpjbXB6VHd3Tk5ONGRhM2VBSnorb3ZwMnB6cHJhN0dwWGJ6RFJON2g1?=
 =?utf-8?B?Tk93WFYvdFUzVnJLc01zM0hXRDc5Ymp1WWNXZkZ4TmxTZklNUk1sdFBZRGxN?=
 =?utf-8?B?c0JOOERaZ0E4Y0JnRXZIdzFFbkRuYldrd1RzalVOdUphODBFbWpiQmxHVUdL?=
 =?utf-8?B?aDNINjZIbEhpVVVQQmtHWDhhRk5EeVdzSFhUY29aTzBsWXhHdlBFUWFVVVVl?=
 =?utf-8?B?Yko5SHhVSTMvWmdkdjk0MzgvZ3IrWEVKYndtRWdJS2JvMFQ5WEhVVkp6aS9V?=
 =?utf-8?B?MFdRM3pvd2dETHBzTkhvaVJFTnZvZWxjK2ZqWi9KM3VBNWlRWWtLMFVIUFZp?=
 =?utf-8?B?bWh4cHZvRHhhcC81dGlreDlFam5lUnd0WU14M3Vod2hHbm5RVldiMHBPSzVI?=
 =?utf-8?B?ZUd1Z0IzZHQ2VjhnNHV5Wk1uSm8rdDNBSmZMZU01d2Jqbm9zODB4VTZDejQ3?=
 =?utf-8?B?MmJVZVV2VkV2WmlXb0R3TUg2Zzd6ZEoyZm80U1QvTXI4MUhVTXllS0NOSEVV?=
 =?utf-8?B?R3laSGdYTjBicDBzUnU1a3U1amxPQ1Fsd0I0Z3JsMVJyekxBQ2Y0MEJXRTR6?=
 =?utf-8?B?OHB0RGxpQVZQNmJnUmhKc1hhTEg4dTdUcVA4TEczSlA0YmhqNGFNdkYrcll4?=
 =?utf-8?B?alA2NzRyQWwvRVo1RVVYTzBacTZOVjJBZklTYVVxdXBPQlprVGZzdFVEYlUv?=
 =?utf-8?B?MSt5bThvUmYyRmp3RGZhcEVtZG1lUjBmL0h5Ny9HdWttaUNhN21UbEFHN2Jt?=
 =?utf-8?B?bWo3dEcwL0llVCt2K2xCcVFiamhnRjkvYlBFU253Tm1NcDhxaEUvbTVmTnR3?=
 =?utf-8?B?ZkNUUW0wMDVKVkNNOFBFYXBDNS9FTEs4L2JNQkFXcmJCUmhuSVpQRlhRckpt?=
 =?utf-8?B?Nzcvcmx4Nzlza0JSQTJBajZxMlFndVh1Wk5zeGMxMEZwNFEvQ2NGemVLd29V?=
 =?utf-8?B?VHBBaU5Uc1o5NU15N01hdHZoNTBOSFpZWGNWcWdJMnUzaDU5NXRNM1JVQnJR?=
 =?utf-8?B?aDlCeFhSejA3eUphTVVZRHRjaHR3V2N4dlJSSVdHRTRRcDVHYkQ5d09HbkdD?=
 =?utf-8?B?ZlVQcGtOT243N21Cc25jazdZYUdMOXBwOG1CS0h4ZVR0SlYvbTlwTWwzdFZ4?=
 =?utf-8?B?YW9xWngzZEk5SVYwWDFCR1ExUnZSa1hWRDJ2NmNpU0VPY3Vma3BxMDE5SzVK?=
 =?utf-8?B?Q0VMOHM1RXVDT0ZkeHp2KzdzRjBEVHJUdHIwN255Vy9zblpPUVVZd3pJK3Q0?=
 =?utf-8?B?Z1k0T0o4VjRURFpyY05rMVBlMWJ4d2dtcmJKbEF2Zm93NytQdHREWGxscXdq?=
 =?utf-8?B?bXc0RWVwbVNQcHhHd2J6REZIZ2hzTDBsRlFRU01aa2VnZ3hwSDkzOUI4V3Q1?=
 =?utf-8?B?QUZQV3R6VXF2a1VRSVNmMDNvYTQ0c2prMU5obmZ3aUg2b1dMU0RoTDJyeDhz?=
 =?utf-8?B?UXIvZzc0V3JMWkYvVEVrV1Z6UHA1ZEdmK0NkYTU1TVl4Qi9kU0FQeHdEd1Yx?=
 =?utf-8?Q?Nd6mTQPC24eomW1HUiE5zKw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84028ff-9a31-40b5-58fe-08d9d4a454db
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:47:31.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSB+D+s6AQZg0a24Oyf5bMiWrHq0LueUdLQW92I4sPg+pIE9BBHa5xXK040hjnZ/RnuoYxKz2/STLG+MuwBHHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Several functions in gup.c assume that a compound page has virtually
> contiguous page structs.  This isn't true for SPARSEMEM configs unless
> SPARSEMEM_VMEMMAP is also set.  Fix them by using nth_page() instead of
> plain pointer arithmetic.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 8a0ea220ced1..9c0a702a4e03 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -235,7 +235,7 @@ static inline struct page *compound_range_next(unsigned long i,
>   	struct page *next, *page;
>   	unsigned int nr = 1;
>   
> -	next = start + i;
> +	next = nth_page(start, i);
>   	page = compound_head(next);
>   	if (PageHead(page))
>   		nr = min_t(unsigned int,
> @@ -2430,8 +2430,8 @@ static int record_subpages(struct page *page, unsigned long addr,
>   {
>   	int nr;
>   
> -	for (nr = 0; addr != end; addr += PAGE_SIZE)
> -		pages[nr++] = page++;
> +	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
> +		pages[nr] = nth_page(page, nr);
>   
>   	return nr;
>   }
> @@ -2466,7 +2466,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>   	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>   
>   	head = pte_page(pte);
> -	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
> +	page = nth_page(head, (addr & (sz-1)) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
>   	head = try_grab_compound_head(head, refs, flags);
> @@ -2526,7 +2526,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   					     pages, nr);
>   	}
>   
> -	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
>   	head = try_grab_compound_head(pmd_page(orig), refs, flags);
> @@ -2560,7 +2560,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>   					     pages, nr);
>   	}
>   
> -	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> +	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
>   	head = try_grab_compound_head(pud_page(orig), refs, flags);
> @@ -2589,7 +2589,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>   
>   	BUILD_BUG_ON(pgd_devmap(orig));
>   
> -	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
> +	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
>   	head = try_grab_compound_head(pgd_page(orig), refs, flags);

