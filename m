Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEB548A884
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiAKHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:38:06 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:20992
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235559AbiAKHiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:38:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+by6kaT1HNOJnbj1apTpFsyvuNfuYHxB5HK8VSIiZfy8GZp6tYk1R82KI9fLudKaLLEyGMbGmKRePKcZyLC3lSZrVrv6J3e6sQFoNf82/dmdBqkryOF+B/Sc7bbPVVS8kebW78mUUzJqOSUv01ymDU9uRLrIdK/3WxAHRqEHPrez5DW2xhU0MEJ7XgyAgkKjOmF7N6zEAfvUa2Kps5efhAzDrGY2qJ0S4H9W6K5HcRLRMUx1W8aNGEBEadfMq90avuRdWUP4I0yaD6I0Rmmgxuaxc4HK971w8esZk0ThFqXvl8MaPiXXNMWo6SNwUDdlmevX7Tm8QYxkVL4IPmj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZVJ4+ZJhohvHyWcG2kUOV7QVH+Ntha+GOtXgw5+y5E=;
 b=dkqToLIBqvj6ZBwY1LpgA934g/YH4Se12d7XBf5btllr+It4wXhqaFkMgJyCkok/fK8G5lRRJzLR+VHKHcriIgO3MgV9GTttDt9h70mNTlV5JEnimnMONDnf9lMUu44MfZhtBIWEKCj5OkZqrVHFGCgLyr8UWdSavP5JTAOhprBe8GCYL3gQGjpJkfhbV1NDceBcEhCND8Cjy3ttTxPW7St+IgFj4c6Eu5ocTyGBmt4Qm7EVyQE323BZSV7Inc/RbixMIAvmbWW9ca7zMJ+nHOdbxOetfE0B1jvrHEBhd9WvB8VUf+l6XEyad1F52gQzJLeikC6TGGUSGLZ427Q++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZVJ4+ZJhohvHyWcG2kUOV7QVH+Ntha+GOtXgw5+y5E=;
 b=oJfcV+sLiL7mm7yJ5dTSlplUDEDXRW9Mu3LXGRoi8JyZxYplrkTBgRGK7x/9DhNpBtJDS2PLJkoBNMBqEllurgKQLMIREH7yHxV85MNbwhBGoKyWIYEW01/OBTmpQwt/eSM3Fm8YntSislKctaQQR4Gr+urG2PCLtkrSEQIJsQ/EODDQh2jGE4pVxFPXVfBnpun5su2x64go+KdF9JIv52amf5cQ1KHr1gyGXkGVDiAZA9zzkP7UbEOVEU3BrNAaS9NYNPcwbLLurrVPVgVQVh1tBa5YewgBIJNomczre6Xtqmuf7NSIrskaEHhgARoKjrrewxR6n/q2dZ2EhO40Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 07:38:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:38:04 +0000
Message-ID: <4789f3d7-1e6c-65ad-8410-29a8a9b26c99@nvidia.com>
Date:   Mon, 10 Jan 2022 23:38:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 23/28] gup: Convert gup_huge_pud() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-24-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-24-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eec63eb-eff3-40e5-d468-08d9d4d54d6a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB341472466A02B69B0A536718A8519@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJKXxzVNZnCHJMbdGHHWOb6g4/LLAZ04XxtNvYcPX5UDSTnrMvEUL5eFEB9xS8/S2Odk7F9wOsvAUlJnBXD5DTcFL5sDeN+dtPCiRF9dMZmJ8+aUSxPHGTSRtrca0i2RZa3yadtbo40VaEhi6PuDmt7zPZaAjSnE8QR2W6f0tdWfKEbwbOceHoWgROrTh5ee969UrJxBo1n0U91JyPWEH7yA1WP15tWm49y7CoeV5OTWEyoOwvsJoO841UBcGe/r97X9+U4iiMlh1m7+QSQnbRMKVgf5GLlp99IN+jP3k+g0ktjD1+r+kmp3kK7Hlh1fHJ6+P30AutxqvHm8gb2zC5huE+Xgi1LjHijtKrEss6Oe7WOpivQYqcf2CiUS5QKqNhI6dhhoJNMXU9wNsar3fW/5qvwUtPjrkHAQEOGmtSaOnAPv8zmoPTxBRlfpYYYaB0SQR8efaE1ogNuFmop48/A0uis4/uzXFwxLpkBRbDApgbdFr1OEK9CzYagvZJVwd87xoUof6b4wEKI5t9ClIo7hx3XfmTS/BVGwvxH6R8mltOxLuD/A1BeHvzzBwM9xUXTDJNCYvP9lefpwCN3DkWWnxltEj4CzyBQZqT4+3+OyhC9hbziehXuSjUfr0Mln6oPEgBlUQ1lpHybSFQLHa8uc/s3F6lrv1iNx9rciuoeLGuowJAAf9u9GC0717YC1Korz0YAOEs6722c0a85PUWwrxTkphA5oEJ6huiD5cRmBBqbI4xwebKrSeeJ0TZvy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(186003)(31696002)(54906003)(6512007)(66476007)(5660300002)(66556008)(6486002)(31686004)(6506007)(53546011)(316002)(86362001)(38100700002)(83380400001)(508600001)(26005)(66946007)(4326008)(36756003)(8936002)(8676002)(2906002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2l5MGk2VHptb2JJL3dMR0pzeXVPcVZuZDB6bHBHNk5zdU9haWlSUDM2TGxS?=
 =?utf-8?B?RjQwRVVDTVNncmhqVEhHZk42SlgrN2YrbCtMbEJVVmdwUzNOajVFSi9GenhD?=
 =?utf-8?B?VFdaQ213YlIzaVJnSS9yRzArZXpRMnZUME5WcnVjZ2YwMm9hemRZc2lGYTUw?=
 =?utf-8?B?bEpMODFDSG0xMUdJb3RpUXpXOU8yVVFJamRqVmJmSUpXKy83dkxUTWlIUnNV?=
 =?utf-8?B?bjFQd29WOS9sL0V0OWliZGMrdG5DeHM4TmtNeDlUQlh3T2tTVE55RjN5TlVC?=
 =?utf-8?B?NGozbHY3V2lpakpPQTlKK21Lb1poVlZVYVVuOC8wMzc3Sy9QRkdOTmZURkh1?=
 =?utf-8?B?RE1PSlFTblpNbFBaQUwzd0lpNlR5QjNST2Flbk0vOHloSkxyanlOakZuUDhW?=
 =?utf-8?B?ckdORXROd3NDNVZVQlpTTzYxSy9acU1VUS9kTHVIMXBSUFM3RkdBVCt2UHJj?=
 =?utf-8?B?TkxSZEZtVDZYYzBkQzllc3NyMUJ4VnhhT2pSOHh3bWFseVYyZ2dQT2Zac05D?=
 =?utf-8?B?Y25rcDFoYm5KaG42MVBkZndoVWRVZldXZkRvL2NydVM5bWlIazJOaGFLMGdO?=
 =?utf-8?B?QmxLZlVXTHBSUUJkNkhDbEVWT0RlOHRpdGJBbTVTUjNXdC9Wd1MzcmpOZXFR?=
 =?utf-8?B?eW5IcVhwaUJyMkhPQXFsNmJxeDRUb3lLbG0zclFiNGt5RW9JWFFkWnduUVZn?=
 =?utf-8?B?Y0tZSk9KTTZnMW1ZSktQRGdzWm9IZm8xWHUza2VhRjRHbUM0WXI4VmhESDhH?=
 =?utf-8?B?b2F1aW1SZ0NwUHNJdnFlS0FqVEsrL2tWeElkcEd6QU5kckd0ajNtMGZrOHdj?=
 =?utf-8?B?QjFXNW9lcEk4Z2hMK0tMZ1JsK3lOK3ArWjEwTGx3Z091K3VSWUhHRW5ObktS?=
 =?utf-8?B?SUd5dUk1eVNHVTFlaFBQQVo3S1pIMStyQlQyRTIvbWtORmE3bU90a0Q1L3V1?=
 =?utf-8?B?RlJyMjB3UFNGWFVnenRSa1dQWjZQQmtSTDFUNGIvaFF1RHBNa3pBbDZqTTR4?=
 =?utf-8?B?RTR1bVl6UEJHM0tmeG53MVJCTjRUTHhuU2dUd2ZXR1pFaEJ6S0VRYnpXSnZT?=
 =?utf-8?B?UCtWQVZYVHhDR0dSVjhMU3N1QzRUL1RGOGE0cEN2bjBSQmFCMCtUMm5yRTZ0?=
 =?utf-8?B?MGxuZTZnTzVqQkRDVmFncCsvcVFuZHRWVTRpMFRsbFFPeWhFMHowblpDallq?=
 =?utf-8?B?RkNqWmRTZVA4OTFHTDFIeVFEekROZGJCQ1dONE01aktNODBYem5RVzZRZEVK?=
 =?utf-8?B?cEpRMkdrWDR2RFo0ZVdNS2RkRmRGaXZyNGcybHQxOEVUWUhvM2oyTmVkNUM4?=
 =?utf-8?B?eVB4ZWpod2E0U2dXZjQzSjBDZCtTNlMrSVNOWGRmS1ZTcjNOZ0t5OEhKVytW?=
 =?utf-8?B?aENvaG9keVRHNXk0MndSazFRTjFSV0NnamFVMWsraFgxRDBibGJVa0w2bFZr?=
 =?utf-8?B?QllDOUdrWVhUa3lhL3NtWmZGSml4d3RWSnBtTGRObDBudTVZcHRrQmQ1UHkr?=
 =?utf-8?B?VnFudHBidWpMK0xEdFd5Q3cwYW8yYUVyZ3JzbER4Mk9PdmtGUThvZnRpV1hx?=
 =?utf-8?B?TEIvOFpLaHF4STBkNDRhMlFZR0tnTFBIRDZ1YUpDdFN4dklSMjM3YjExdFJh?=
 =?utf-8?B?SzBTaERVYWtzR3ZYdWhKZGdUTERlUDlXYW44SjBFcWJZU0hpdVNXV2p3VHZX?=
 =?utf-8?B?TjlOdGttby9IR2pDOEowTERLRm50TlowNEQ0RUpLTlVJa3c4RHJhUlRUKzR0?=
 =?utf-8?B?MEJhY2g4YkpvV2tmekhaTFV2MEVUeUZrUXFjbEFPRytUYXBXVEIyZDYzOFM3?=
 =?utf-8?B?Z2NWSzViREFCYWYyOUpZUEREK0hIMWNqYzhvYmQxRU1ERFFkSlBNVVlzcmFk?=
 =?utf-8?B?c2IzM3F0UEEzdFB1a3E2cHJISmgxRlZMWm4ydEJ4dDR5RGlCZ21BZEdDTi9v?=
 =?utf-8?B?RWtvc01HNmNCTy8yWVhQV0FtSXpyMHNKTTYwRzVEbEpTNFpWZERwOXF0aHl5?=
 =?utf-8?B?emRLTkUzL3BvMUp3WVBhdVQ5Wm9IcDEzVHhQQzI0MmErTXkzOXVrNGY2V29K?=
 =?utf-8?B?RnFDQVFSNWhyV2Z3TVA1bG9XRlowZGw1RTBOTDY3TGY2bm1PRWZ2L0dtTDJM?=
 =?utf-8?B?TXF6ekxtWVl5dG1oRitISTlXb1dlMGlDWjhzMHdZN3dLaENxWGpab2RsaWFO?=
 =?utf-8?Q?XmbWjcngohcOhJYel+jSqWM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eec63eb-eff3-40e5-d468-08d9d4d54d6a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:38:04.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/iAaiEVXHVRfvTuq1VW6mKRC3O2h0VORn+yyRrvzCEIWLbbibGnMGvjWmRXJYBeBzs7Ow6yYTiSnScvKmrWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a006bce2d47b..7b7bf8361558 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2527,7 +2527,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>   			unsigned long end, unsigned int flags,
>   			struct page **pages, int *nr)
>   {
> -	struct page *head, *page;
> +	struct page *page;
> +	struct folio *folio;
>   	int refs;
>   
>   	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
> @@ -2543,17 +2544,17 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>   	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
> -	head = try_grab_compound_head(pud_page(orig), refs, flags);
> -	if (!head)
> +	folio = try_grab_folio(page, refs, flags);
> +	if (!folio)
>   		return 0;
>   
>   	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
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
