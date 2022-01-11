Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AC748A88A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbiAKHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:38:49 -0500
Received: from mail-sn1anam02on2066.outbound.protection.outlook.com ([40.107.96.66]:26931
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348545AbiAKHis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:38:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb4GtvCUdaz1HK09beVHaU8ETaNunFbiNh7gMN0l/2TWzAa+g2E2NXf5j6yIDnqLpT0bWmC9pJ35e7g936RklyOi4QFSADJxy2IEV9r4isWlI+sfig/mtPBSftWW0T0A7eD8AZsIM8SvaobE1C259bDWKJv/hOLgPFe1cKZJsp6UvJG6mYB9nKvU98/gF+TDIsJupQF9XC8RsqZIZH6CFgZNauB1YU8KkVfl7uO9b+OczjhiWAFHZwtjDfjc6LjQFD3hjqKxqyHjxxfhwU++WrU+bUeXoCauic7jymbUhaCLe0G6S1UJ+qbA9vwRK40eP39/MyWYylRrGmFWdXAOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj6/ID8LWyzhB6J4dj3zlAdpXbhdHa6Cyas8fhRP0W0=;
 b=lV8En+d+fjZdyAEABEs5ulfYlx6Wse3m82cGoXTaYrs7uvQe/Mw6kBmV/1YNxok01rOcRIbhlC5rgqaS6G52nVSae03yK7z7ypfkOITqN2vOOVrDdO5l8c5JbGd6glorDYLyKZ/1ezHO/ChAOszK+wvAdxDWkae7D96bVUvSYRxUkMlw+8WAm/q/SdqWZTNwjS7C9SMYk7Q6yIjRueoDEa2s7zzMVD1+0giUmy9pfE3v27fEUncG2TigX5OgEWSaW/49pTQ7gpVsFrWOOMBBJTLfsik44Kx8khCrhZYp5kpQIVR3tgGO3nK9veR1FE/FsY4XSCeUg6ivpKxdbBPqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj6/ID8LWyzhB6J4dj3zlAdpXbhdHa6Cyas8fhRP0W0=;
 b=crdmNv9yKN71ZdVJ0y2T7d4PEjiry4mj/fhsu9vE1L5O196uQyizVvWDBcBSDuw38r/8VQzX/WasP1I+W5bdDJm/QcyYMLRxciulSF22hsqMoyKQibZOx+EJY8XNF0mskCUbfx065T2XbJij9oMW0oi65EE0mZJVw9sKdtsNNfLLp0x1oL+qWfuVGN/S6VXtWgcSfeIDXOO0yK/kAAMNFhclujfnBnQmZcSDJDvtJDVpB6Z5Q1RBUMSapL2WGjZEW6vnrhsFE5Pox4AOJo29LbR9jl1Vl0epYiD24o7CGvJay7hTAegkPYxCGEwlxnzyjq0n7NGKRBE6i07WwxGcgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:38:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:38:45 +0000
Message-ID: <75588728-df1a-f081-70ee-fa0470d08047@nvidia.com>
Date:   Mon, 10 Jan 2022 23:38:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 24/28] gup: Convert gup_huge_pgd() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-25-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-25-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6eeac28-d23c-4c23-5144-08d9d4d56634
X-MS-TrafficTypeDiagnostic: BY5PR12MB3873:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB387361F347EC8A98AF9ABE43A8519@BY5PR12MB3873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUSx7ABHxVJQwWChJgCWSiFPx0MahgsRDZ8sYsjnpaCe3HVK5FsPDuBXyFMnNnB5D3V5u3eCf3bYtiSWAkD66VSnmG6C2H50gv//CJRDkMlQt0wmJt+TLuMs4QERSgsuP3LrX4TVFLWMOGXBuEApR6U2AyM5NGcrMeE2wqxCMs/E0ChkKPoTGoDpNO9b862jCGCbwh14Z8OwXI1n3RAtuVEJhMSE3FIEQgweqlOtsVeHgkJzl8l/dlL3MX5c3M09a/C2zNImS57qBG/nFvcfTXLJmulkw3bo3WjQjvBMVSyJXeikwW8twcp58Tt8jByFhwupDB3s9m2bDSt9bmlNx8O2QKLn6FzOy3B6YMZSaYI9ICWYxw/qD6MlbDVrA79bd9T3rQmMH1c2Z+3fpd9JEZbMctOroBkMsdaNM7CJpZ2wWV6c804pYQWtLppVh9U4WuUIlh3RxE3BTnmBykHNjgfZsAC6AuGsngzMnpI3L7JOZHjkoZCEsh/yjaG1llthbtn1eFcD7P/o2tlhWMzi9woekHnPSh22ahFO+HqbY0w/NDWlsQLGJYn2ifEUy0Rzm3c8fp7AnqBVVHMZsQfSOBnAxAphCmmFHkRo6LWmCq/VlCWvrLSrriGZ4YGPRn5d+Fmm/6/2HIOWTcuMg4x0lkb+8F938KuZoIirNnWJg2V7+g31Rcqh9KDmOZKlZFw8HXiPQZ/jtMWzoRoM5yYorGzXuk7mlbzvEp0ydoDQwu9zBjwC9TTUZB0msq72OGvI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(83380400001)(316002)(38100700002)(4326008)(31686004)(31696002)(6506007)(53546011)(508600001)(8676002)(2616005)(5660300002)(186003)(66556008)(8936002)(54906003)(36756003)(2906002)(86362001)(26005)(66476007)(66946007)(6486002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJ0S051NFVWTVlyVlRBczJtMHB2L0dOa3p6ODB5bTcrUmk2Y0JpaHRMVXBa?=
 =?utf-8?B?QkRsMGx0dFJ4ajc3SXNCZ2RDeU1wMmhlM3dMMFJTbmFyTXFGZGxjaDRqc2dW?=
 =?utf-8?B?Y1I5eWY4WDYzeEp1dVdoU2xaUTNCVFFLcWZQUzlReHdMT2lTQjhEak84blpT?=
 =?utf-8?B?QXJwY2QycWlxMWxxQ2h3T2JMaVdGUEswTm1TdEx1WVNJU3lydDlhWXJGN1VM?=
 =?utf-8?B?dkRXeDRzWExZaGJYZTMyNWxhWnl4VWtSc3NvcUdXRmg5dG5YVWo1SzBxdkhO?=
 =?utf-8?B?dUQvdThDN2hIN2lJenFwajlNYjdlVU1Nck9kSFhiUjlDc21EWnh3MUtoTTJC?=
 =?utf-8?B?S0RYbUNWZVI3djNxZDdXSWEwd0tGUmQ3Y3ROQ3Z5RXgxbXpkd08vUzRSYjIw?=
 =?utf-8?B?TGErUXg0QXUyVXlzRmQxNXRxSnZlbWlxMnVrUCs5UE1US29TRG9YdEIzVUVo?=
 =?utf-8?B?TDRCblRIK0s0T0dOcWVJWFNKV0w0cmV6TDMxZElxTHg5QTFhSGNzd202bklW?=
 =?utf-8?B?UnM2NDN1RDhTU3pqR24rUUQrNEl6bE5BUFhqb3BoWWtwZ0QvWE9YaUNOSFZI?=
 =?utf-8?B?UEhKelZvQjcwNUFxT0N2UGVJTXFnTDBuNzlOWkFCTDJtajFScmtlSmRvbXFs?=
 =?utf-8?B?NGVjVHVqWTkwTnVxeGtUbTNnWW0waThBalhpRWNVcmFzZVQ4UjRhY2JRYmdm?=
 =?utf-8?B?eWtteGZFMEozRUNOZUp5Nk4yM294TlRCN2FYQzc4RC9YdUU3RjZCM1pvcVBO?=
 =?utf-8?B?WDJEZzVOS3JzREprRzc1cUNDeldCaXQ5TG1lTDJEUEtIUGtXaVZFUytCcG9k?=
 =?utf-8?B?TXBNRk1NODViSEE0cUczSlZLRmd6VUlEK3NxOGc0YVoxdGNXaWM2U21JUVlz?=
 =?utf-8?B?VmpScFE3SkxsY1hJWVBMb2xuUU5nM0phSjhpbWFZV2trcVowZWpjZHhOSktq?=
 =?utf-8?B?dlFTU1JCZzVINzNxd2pmOENmVHJFQ2tRbGFUMnRPR2JCbVRpcUtDN0lFVG1S?=
 =?utf-8?B?NU90UTNyYzR6ekxTWlZhUnM4YU5vaGJPa3FBMHlhekdXNE16MXZ3Tk5jZDE5?=
 =?utf-8?B?NEphcnJHV1dWbUE0eGhsMGtEVnJ5R1dpVVIycFZRWERGUVNUamlTVzNWU0sr?=
 =?utf-8?B?dXBBeWZvQ2MremRKeXhHTmtySW0zSjBSVTRlV2tRVmhycFhVRzFQUGRDSzdG?=
 =?utf-8?B?UkNabGJxdG5GZmZpVUp5RXdwandXN3F1WjlwTjJ6Z201TUtkQnpqOTI3NGcr?=
 =?utf-8?B?M2ZyNWEyT0RjMjh4MytQbTdIZ09OakFDRVRjN1VDV1FLaFloS2RxNCtoQmtY?=
 =?utf-8?B?S0RCd0dhdmZzcjBSNFFwaXlFMHdhaXRLL2QwNW8wWnQyNDRxZldycXRVK1Bm?=
 =?utf-8?B?MFUxWHpCZTY3NnRnT1o5SVhCdUd5UldxUE5NRjJrVmVRMU0xaTdpcGw2YklL?=
 =?utf-8?B?NXRDNm9vSkFSTEpxeXlZQ3ZtRmExQUd1ZjZaN1dzNXUxUWhKQWZ2eEZBTXda?=
 =?utf-8?B?NndmKy9XZ2d4NW5WSHd6ZU9GVkdrbFNZQVorNUFNbnFYOGJxZnFQYjk5bEQ3?=
 =?utf-8?B?K2cvcExDNTBmQTB3c1k5b3g3V3lWUjMxcExBb1paMml0TGRHMmNEOG5wUVFI?=
 =?utf-8?B?czRNRXVEZmRtV3VnT3VhdWIrWFdRUnc3cCt6M0JRSmxCb0VZdHIvUzhvQTBJ?=
 =?utf-8?B?ckZ4T0pQQmNFWWdURUFHRTRMR0I2ZHlUNVRtbU54ZU5YRnExMnFSUlNCZFdx?=
 =?utf-8?B?cFpRKzFBWEErc1kxMllrd29ObnhJdzdyOFlhZi9hODhiMlpzMERtVXR5alVX?=
 =?utf-8?B?VkxFNkRNOUR0aEJiVUFMVmh5YlhYeGliekpweU9kZGRxZkRaTmI0N2ZGdStN?=
 =?utf-8?B?QlRzUU1uYVJkMkY2OEJsQjhSelJCTEZHck9UT0hwNXRyOXlhUXdsWTU5Wjkv?=
 =?utf-8?B?UjlOM1VhWktaTkV6YzVBNG1aMDYvb0FQMHdrZ2t6dVhWZldzTThIbnBncFNF?=
 =?utf-8?B?QzEyVjhpQm5ZVTl4NXdWYVBlTnM1M0RjWTdLeXVxdDU3UHZzcnVsM2t4U2Jz?=
 =?utf-8?B?VE93Vjk3TDVxQjFRYUZOenhJREhINlhkSEhLNXBUT1J4a1lsZXdseCtCcmNp?=
 =?utf-8?B?YjAyMmNZTko0dzFldTUyTXozT0tFT05MSkFwL0NEdTRXaHFjMTlpUWJkSjhu?=
 =?utf-8?Q?56q85fmb1fD6YJY/V4+L5zc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eeac28-d23c-4c23-5144-08d9d4d56634
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:38:45.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbyUZQOszkVKNSK7SjaSPDVRfb02KZXKMHchleo14B5pD9M0CH9XmwBm5G9bL9i8ttfRPO7tsc+ANwG4kxoX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:24, Matthew Wilcox (Oracle) wrote:
> Use the new folio-based APIs.  This was the last user of
> try_grab_compound_head(), so remove it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7b7bf8361558..b5786e83c418 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -146,12 +146,6 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   	return NULL;
>   }
>   
> -static inline struct page *try_grab_compound_head(struct page *page,
> -		int refs, unsigned int flags)
> -{
> -	return &try_grab_folio(page, refs, flags)->page;
> -}
> -
>   static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_PIN) {
> @@ -2563,7 +2557,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>   			struct page **pages, int *nr)
>   {
>   	int refs;
> -	struct page *head, *page;
> +	struct page *page;
> +	struct folio *folio;
>   
>   	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
>   		return 0;
> @@ -2573,17 +2568,17 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>   	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
> -	head = try_grab_compound_head(pgd_page(orig), refs, flags);
> -	if (!head)
> +	folio = try_grab_folio(page, refs, flags);
> +	if (!folio)
>   		return 0;
>   
>   	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
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
