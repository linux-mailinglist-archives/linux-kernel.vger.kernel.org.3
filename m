Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740A848A7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiAKGon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:44:43 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:47264
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348226AbiAKGoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:44:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbz0fY8btkEa0WS6RZCz0XyIENhr3wyTL8oBkrRHKjLRgj2BrS7ZcknsWZTRwwAYuukoq7xBqArjGK0/X4UDvKfthlyXA89YLkSMIa8xyQBd3gzF4Feh5gBf6lVIS5Yj2cBnT39M5UdcOFJRGtP+NKYexvOEojSaxy83z4YYLHXn+z0wUaw90jZFsRgRcRhEwdcMsC8BVGPEygQqzdeyM+HGggXse1ng8idXYHq3NfnkJOii6/M5c+nqIW+9UwyBH9RzHJlWhuMZTz3tASbjQJ/okA4iBn4bODYPAawYRlZIzhvIeDyaqyo7ovrrM+rPnCLI0Pn1DrvAL/WcZOYsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E54jDy51AuAA2hrLsj3H1PXKwPrlVnEDQnKs3sK/5Y=;
 b=dbKkNd7fB8MnX78t+4pPblb1g9ghFFgwVfkxGBZIby+Cuu2d6/XKjdFqwvWEOkSEek1wfg3tDkANxhQK0P7A7fCIgAOi0QgMbqXC8bQi5vsFibwSSgkRPisgsqD7l5Ao1NJaZ0AGW4/fy6Knjpkb0w6eMEsKQ8dk8lAOBopAbUBlOD6VQ4Rd/I+gMhEUri8lznJby779J/FgQ1HJezxw8DDcegriTVR41G+2VbJNhMYUnQ6KtYjnHjPMFTDaFjYqAIbsQbpT26j4SuIJU5FxPazr3UdI8sPRvwp2+METUmCO+uEIISDHtVYDVR8T3Wecot+AkXYIebIyOedSmi6ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E54jDy51AuAA2hrLsj3H1PXKwPrlVnEDQnKs3sK/5Y=;
 b=MKAMx5w84z71CMOQsp9UKGl6GSutTVSQCFRsX37GqQAXqNu1iQqK4UbGs6dmodvCsBCBpwaWTtUh6NGwO5OYyLxq7ATfy2hOI2x4kA2msy7H9omIkW9pNMauGnfXI7qDOlPWQCtVn8NRn2m9q2TCdsIZ/ZburT61gHnLAIb25u55zD5eK0V8+T+HHdF9KBlZZtx9Xckir8c0B8q21uAVYYDYsmMxXPin8cLahZwXAUlJ0KLMhLQ6aJa3yPYmbmGwG2v6sPtkQ2UbX82c7cFmZN6a0WP39UciR8T3I88G9aX8JkBwXzEKbU64DVFUBDEtwLxJ7fSAl8B5LhE6iVs4xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 06:44:32 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 06:44:32 +0000
Message-ID: <725ee15c-e2c0-ca74-995f-a6f8b5196f62@nvidia.com>
Date:   Mon, 10 Jan 2022 22:44:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 17/28] gup: Add gup_put_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-18-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-18-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17dadf0-6aa5-454c-5c44-08d9d4cdd314
X-MS-TrafficTypeDiagnostic: BY5PR12MB4276:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4276E927E6388E698426556EA8519@BY5PR12MB4276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuZSXlp2Z9fdUr5wFdJwyJl2szs3ZFkvYDKv23mlzz9WLcDWhm0GjY0qYkf99STDLvbubQ0C6k2Vo35PUCj7edy3q3iMFtBH++neN/RgiarTk1fCpypBg3nCbfC9EubT4BvvTdSlcHDC2PZcdcc8ISrFyx1p1Lbm5WeWQ0A5Lw8WDQfcNaFYftgN5NySG3GiP4ZRuv/pQp5LCKKXZqPMFazBu+QK2f3GuuRhPvw0WnZZ6msThZWOlCABwnPNL83NbB65rbVnYf1Kzxw4IsSEK6joqZuuQ52WEraJ8rS2Vr/Z2x3JnDl75wpupD7pZH7Y8pFQ+o/uY9zOjF4Ca149Ird7PK6RZRSlNWk6/gqUNg9n2KS1r1pUCRqPUYhJyDoG2qfV1daBQ0hph67MYUA3hcvWEDt3RB/p0jcVjkbzyzi4BQEe/NzokuJXEgiQQascQviCx4NeQLQQznTwvwBNMc6UYqSgQQ4/+10SjFlXyXoGJ+SqrFlU+f4uRfSszm8l7gs3Ay35SnuHWzCDo8H8yw9dBDnoUByMRKbK11tZAwjzACL2YlPYYv8HrgAm0qyUFohe3oIYk6A4NxVN09/1UaN1O7pUQ1vEFwLXC8u8mvsnAVUexrUrn8AbT6MWp5eC5+SShJvUkDYJkXI7B3+27Yz9HJi64jDo3IQy0dK6I1zsHb9Oyqf2t1uk5yJSWiyeIkAukYayxdY5ZAFpXMEvizUPprVE/7ShQiK+BbilrRhsbAc2vqobeEb5kmX/zlgf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2616005)(66556008)(66476007)(2906002)(66946007)(26005)(36756003)(508600001)(6512007)(186003)(31696002)(6486002)(38100700002)(54906003)(316002)(31686004)(86362001)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFrNFhMTlo3VGtlcURNeUUyc0xuVHVBTm5TUEFaZFNJSWQrY1FJdU14M3l2?=
 =?utf-8?B?cVNHK0RHSHBSTG4yYWh4L1N6a01pS2xMWnRFcUpBT3lxU2ROSnpUZGY1b3Jx?=
 =?utf-8?B?YmZSNWhidkpaZlRrdGVFR2RsUWQ0aEptN0hPNnZBR3BvRlRxL2RvUzU3VGgx?=
 =?utf-8?B?cmY1UEZRMjZCRWlNbm84VHMzUDhoVzhSYm1vWjVaWU92dW81dUdHTFBNYWNR?=
 =?utf-8?B?T2prWU0zN0o3OHNtRWJ1ZkhNQjgzMGZoeW85cHpsNnJ3bTM4alprYytHWXd2?=
 =?utf-8?B?VEdUTHQvdS82dm1WTHBaUXZRRnBlYVdkZ3o1Z05nL0ZycWtHTWxjVll6eHh4?=
 =?utf-8?B?SDlGYTQzMFNMdnl0RFpsOGNYUnl0djBweFJPbU1YQSs5bDdFcTZmVnVjd0lI?=
 =?utf-8?B?cGFTUzkydnFNUTB0cUhKZVhmY3FIMnpib29UaFNKdUl5ZVE1SGI1OEVOL3Bq?=
 =?utf-8?B?Si9Fby9BK29OQ3hKaWpHU2ZSU21oMlNzSjBLZE1meFNhNTY5Qzh5dWh3Umcy?=
 =?utf-8?B?SG0wR2V5N3F1ckdTNkUzbUI3ZHNNU0tCNEVSZDNzWVhkNUdEMjVRbTJOR3ZD?=
 =?utf-8?B?NWJFY2pjVm5BYWZQZkpvdkQzb0hZaytKR3N5Y3QxMENxUDV4ZVZ1WTF0djMv?=
 =?utf-8?B?RGM4Vy9uNzdYdTdMbkoyeFZibzg2RS9OM1J0WG9wWWhndkl0N1B1Y0VqMm0y?=
 =?utf-8?B?dHdmUlpoWklpSFhhbDdvMkIvUld5R253N0paTzZxS1k0MlJaMkNDK3dPaW5Q?=
 =?utf-8?B?NGFpcjNlTnF1WXgyc1VDaEc5UjRVMW82S3UvL1dSdzc0QWw4Z3dEWjJ1djJj?=
 =?utf-8?B?RTIvUlNDb2o1TGxKVG1KdTZjaWZZSzJvOHlRa3BFak96THdEdFMycFlGRkhy?=
 =?utf-8?B?UmVONER5ZG5OK2t1TFphbW9oMkNUVTRwRlM0a3dDdmwzRUpxUTFXKyt5K290?=
 =?utf-8?B?N2Zmb3FuVVZpdVR4Mk9hcTFKOU8vZE13czJHVkdVN0x6NS9sblo0YldPY3I0?=
 =?utf-8?B?NzcxZTI2eGdwcmVMajVHbWdhY1dWc2dMb1lXa2NZRE1KZGZ5TnN4R2Z3bjhi?=
 =?utf-8?B?T040TGRKMWFNb3pLSHBiM3dzOGdxRTUvenZRNis0U3F6ZjNLUWw3OTBRM0Qz?=
 =?utf-8?B?MkRhTTliL0paN2tjdEpmMGRvT21hYlAxS0VheVd1WDRtRFR2Z0xPb0xST2lI?=
 =?utf-8?B?SEJBZXcvT2tRQmpuRnRkRG5uZUZ1ZDl0UjlRV2RkRWNLSkhydHpVZWVxcElQ?=
 =?utf-8?B?UnkveWp5MFh5bnpSSzZCZGlkakk3cTlCMkptYWhiZFZXU1ZSRytTb3FPL0hx?=
 =?utf-8?B?N0tkZzFhRnBmSHNPWk9Bb0tSeXBHUVlld290bytrSytSM0xKUFA2UzQ4cHhz?=
 =?utf-8?B?SmRpRmVmUnpsRFAvOFFoalg5Z0lIZVRjUFBEVXN1aEVkYkVGY0MyL21DMDdJ?=
 =?utf-8?B?SzQ1K3lYODM0OEhqbU9WalBLbUhtOWdtMUtPWEI5Q2xWUVZaWmZXbDdEelpH?=
 =?utf-8?B?WDdtQy82cUs0VnVXNVBQQlJxMVdIMTlvS1lvYlJ5Y2d3QkROUU4xazNBNzJo?=
 =?utf-8?B?RWxxY05ZWGdBdFRQOFdIOHpVcG1EUHp1Qk1WVUZHNGxodDNjQ3p1NDE4YTdY?=
 =?utf-8?B?Y2hSSllSVlpRZVRFdnl1amJLeHR1L0xGVmRLS2FiS1pnS3JLbDhib0xXK3Iy?=
 =?utf-8?B?cVpFV0tnWEIzNktJRHB0V3RJeUo2WStPMXRnWldHR1VEM1owMitQV3VOdm1n?=
 =?utf-8?B?NndZT2wxaVliN25ERjZXTkliL2MyVENjVzNsWi9mRkljZmsxNnhzd2dkZVds?=
 =?utf-8?B?Z3lScWFuVHpCMkhyQ3Uwak5yemt4aEsvZFR1T3hxZHhsSVg1a2FXQVVrMzBT?=
 =?utf-8?B?aGZQVWNCNjhBeGtQNHFkRmVmbEdXUG8rOWh3cFRvQmRHa1hLc2lSdjl3NUd6?=
 =?utf-8?B?ZmRzTTFBU242SXk0RzI1V1NKZjlkb0VXSEJ6SU9YR2ZkMlhJVkxlYjYvTHlK?=
 =?utf-8?B?Mk8zVnVnaWpLZTJSQWxMdTFEQmQzVDhOTnhBZG1zTUxBeWFvRTRFYTVtZlJu?=
 =?utf-8?B?M0VHV2wzN1lucUIyTlhHeVRqcGNsUWZJdnBZa1FVaXJlQm1uejBDbEJ6ODFK?=
 =?utf-8?B?NjFPV2Y1dWo4WmV4NkN1NndmTGN2V3FwOGpHdmswYzNBdWhsdUdya0N0b2c2?=
 =?utf-8?Q?yylykoO9T+xHgxYGCx5MOzI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17dadf0-6aa5-454c-5c44-08d9d4cdd314
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 06:44:32.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvuNN6HdXLMHJd5OYUzN9CQdtVJjQpO6QuJ/v3RelIrwWO3+MdB+whIUw53Nfa7PlGEgZZ2cornHStRkkx2K9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Convert put_compound_head() to gup_put_folio() and hpage_pincount_sub()
> to folio_pincount_sub().  This removes the last call to put_page_refs(),
> so delete it.  Add a temporary put_compound_head() wrapper which will
> be deleted by the end of this series.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 42 ++++++++++++++----------------------------
>   1 file changed, 14 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 9e581201d679..719252fa0402 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -45,34 +45,15 @@ static void folio_pincount_add(struct folio *folio, int refs)
>   		folio_ref_add(folio, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   }
>   
> -static int page_pincount_sub(struct page *page, int refs)
> +static int folio_pincount_sub(struct folio *folio, int refs)

I just noticed that this return value was a little hard to reason about, which
prompted me to notice that I'd skipped reviewing patch 10. So I went back
and added a note there. :)

Anyway, this one looks good,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

>   {
> -	VM_BUG_ON_PAGE(page != compound_head(page), page);
> -
> -	if (PageHead(page))
> -		atomic_sub(refs, compound_pincount_ptr(page));
> +	if (folio_test_large(folio))
> +		atomic_sub(refs, folio_pincount_ptr(folio));
>   	else
>   		refs *= GUP_PIN_COUNTING_BIAS;
>   	return refs;
>   }
>   
> -/* Equivalent to calling put_page() @refs times. */
> -static void put_page_refs(struct page *page, int refs)
> -{
> -#ifdef CONFIG_DEBUG_VM
> -	if (VM_WARN_ON_ONCE_PAGE(page_ref_count(page) < refs, page))
> -		return;
> -#endif
> -
> -	/*
> -	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> -	 * ref needs a put_page().
> -	 */
> -	if (refs > 1)
> -		page_ref_sub(page, refs - 1);
> -	put_page(page);
> -}
> -
>   /*
>    * Return the folio with ref appropriately incremented,
>    * or NULL if that failed.
> @@ -171,15 +152,20 @@ struct page *try_grab_compound_head(struct page *page,
>   	return &try_grab_folio(page, refs, flags)->page;
>   }
>   
> -static void put_compound_head(struct page *page, int refs, unsigned int flags)
> +static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_PIN) {
> -		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
> -				    refs);
> -		refs = page_pincount_sub(page, refs);
> +		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
> +		refs = folio_pincount_sub(folio, refs);
>   	}
>   
> -	put_page_refs(page, refs);
> +	folio_put_refs(folio, refs);
> +}
> +
> +static void put_compound_head(struct page *page, int refs, unsigned int flags)
> +{
> +	VM_BUG_ON_PAGE(PageTail(page), page);
> +	gup_put_folio((struct folio *)page, refs, flags);
>   }
>   
>   /**
> @@ -220,7 +206,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>    */
>   void unpin_user_page(struct page *page)
>   {
> -	put_compound_head(compound_head(page), 1, FOLL_PIN);
> +	gup_put_folio(page_folio(page), 1, FOLL_PIN);
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   

