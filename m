Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C548A872
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbiAKHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:33:14 -0500
Received: from mail-sn1anam02on2045.outbound.protection.outlook.com ([40.107.96.45]:62365
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235241AbiAKHdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:33:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsU9R6VLD3O9/7cV9x1WtKzEDwK0UxaCRNK1Q5/GorUAZrh1eGTCZoFTytEFalYfBKJORNOnOpNQgWKzcLTEdDkQ9Imxtsses2iNXMFx5SnJqfB4+7oSPMDSQg/BMsKipiIh3gqtqjuLFjyhw5D1qvgb1quZFg1B33q9eh3MFwJ7CH+K4o8vdNkrE+hh8LiBgkq8Un1msn/wxJKDPYTlCyDZh5KYqKS8F5518sC92s887BraC8SdyQQEjbr3pXaycup4cg0isDtGC399KQ7tzSCeD2oGKcS8jz1kqZVwWv6IOc/OctcgwkiP2P2HADyWOuFSf9aUgEfUesSmmT41Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqdsfEcfzLtDMfmKpkPo8jQJSOfeRpL6q+ygnv3H/A0=;
 b=arpjElLbn03POKrgBuPrXY2eI1RUr6/5Ec8FnwuPDAL1kSSV+k+e0i2Ie94YCqWGQjfEomu6TwX1JZCWR0sMAuatWEGf8xbRQFsaDGxeVrU4AZ+mVwSvDSXy+H8d3lVaBXF2iAcgRoNtixoP33+iXFoLkwcZyFrrgMvQkjiJ0THIZFEXgObzMP988kUi4/k5nUUMWPAcE5vX4dckoLfe9tMXbYStCUJhQjagpSyHg1PHlHmqc2ewFbxiTxZqvDDAj7r79vu4E6bb1RcIkC4AlqrBMgWr3kHvGahVom8esN3KwXwWwgiNbGNfSCuV4DP4ARItp5nJV2ib6b6TatMOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqdsfEcfzLtDMfmKpkPo8jQJSOfeRpL6q+ygnv3H/A0=;
 b=n+liBW/pBCsOyxDmdU5swfzZCw/tWmJtJUM3+0Cz3kjxcZmANeqM/0VIZdKeeg3ic95RFNt/w7If7FA6qGo1oEs0R5S0VG7RnpvgiodfRkP277bR60iKCxg9ZxOdGm2hlR8B3eqwSWXTKhIgAqIYJn9vEJgkcx4R1Eyd8AubCF/pPQiYdaErPn8MmpYvB9R9kYGv7i7H2NqTEIf+sytUrbA4GMCKhaCq1zL6B8WSgiusTYXtQ2va1OqZCiPDnRhH0zwXMj6fRqpCkcRJGsEFyqoh4Gdw7QgCbANqQ3/+vjpFmTMpfmkWd8HGa/pB2aQMtmY8R685Eyd8wcIUqXi2hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 07:33:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:33:07 +0000
Message-ID: <058018ea-b621-2c2f-d1a0-dc8dae0d5d83@nvidia.com>
Date:   Mon, 10 Jan 2022 23:33:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 21/28] gup: Convert gup_hugepte() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-22-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-22-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481d1c3f-5fbb-4117-1407-08d9d4d49c9f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4049:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40497D4197D1912B0613F908A8519@BY5PR12MB4049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URsL9gkfzVETWndUKjbL8qRoHsfZGuzuKWzSSDe+Ha1m2/j5TJVuQ7Jnpuf2p2bbOpiEydmmv93v8aAZCYVdKFAtWYEBE7fuR4zpbEh3WEoLL9wtsWC0/2jIhZWaqIfxI0v54cfDhsAGgrELX585MevB/+Q9GjOtnNFbsggFtyQlxsJKi5YyrHUPlZj4aDHG/0rsoAakZW0VC3pxYMX5MaYPOnsDRLY2RXQ0ZxgxrZ6gHDamNZQs6JPSjjtCJwSdG/PhJUliF9Dfc4qxaQZ6cgynMW4ObZDGTXoTeLu4QwfGB8KEqIBdGUD8LX2d1beuKIJKS3jB03JGu5Yl1bzwHA3I0EYkGlrPh3Q3B6SYcw4MXpDsgcyrRDUwlwuzrlmzNaqzJ9LEogDci2lwPl2a6FytV0m57BXE15OhYSD0qDklEdCbXeItbCeyJ3rP5+cFf3HwPHKF5TddRnADtOAmu58QGZHFkh3hVnt5H+79t7KkCpAL9AHWcTq9QebUoXRHeXJi6QdJm30kJp4sH0m1M77JQyuchBE//gM2OJJHCFcqhubdq9epWDmttgVH5SSvvMKt98Igzh2R19T5D6pOt1Ew9ZE/mMbaqQZlxPaCAvDHHQ2+b6dGPWzWkJI5KjRadYz+zQsziGH4PfR52bmJvqWBL9HxLQ+tqe1u3kiN/OMnb9e1W5+jVseAVu++xrOR2+EJA551vE9IGC9ODAiPhdMhHy1x+XyyB2tEIMiKySw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(8676002)(8936002)(38100700002)(53546011)(31696002)(66946007)(6506007)(186003)(83380400001)(6512007)(31686004)(2616005)(66556008)(316002)(2906002)(66476007)(54906003)(5660300002)(508600001)(6486002)(86362001)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFsTk5nRUVyZDV6bEFScDVnczdYa1ZkaU5KNWFLNjdCK0FvZUgrNVBEbDdU?=
 =?utf-8?B?dVBFOXNKd2phS1Z1U2x6NVQxVnR5SXdjNkd5MmQ4OWsvWnRTcERMYWJ6SEFz?=
 =?utf-8?B?WitheHcyc2FURHlldmdVb256dHg3ZGRxSTE1VjhJNDlBemxSOS9CR3ZId3Zj?=
 =?utf-8?B?Sk9jUW9takZobWJkSGRoU2loSXhXbm9vcU5JbWNKcHB2QmthNzBjS3h1aStB?=
 =?utf-8?B?M2IyUjVUWG1UdXFlSXVuemU2QldReWRrT3crNmZyYjlRdlVTTHZHbmx5SGJS?=
 =?utf-8?B?bG5KK2pXbkZZSGhDRG54MWU5azd1N0Q0bFdmbGQveUIzWDBPdkpMWjhYZmVP?=
 =?utf-8?B?Y1ROWWx1bDVnQ211M0NuSVplSkljbkZ0MUxlS1JIS0JyUmZtQklTVlhKSThY?=
 =?utf-8?B?akkzNGVoZjNybWs3QzkzdDhRS20xREcwMy9PdFpEeHVzSHF6dEt2OVl4bXhn?=
 =?utf-8?B?dlgvbm5namlad2hDaFJtU25xbUlwTTNHWHUwMmg5UmdWWXZTYWloK0ZZZHpX?=
 =?utf-8?B?RUE5THV6WCtEZjhwS0M5MWFQc2xNTU5Ocng2dy9ZV3E1S25XWllhdWtRa01U?=
 =?utf-8?B?aUh4V2YrdDJRanYrRHplbXBycERCR0wzaHlKWGN2dUQ0c1JjcWJxT3BJQkND?=
 =?utf-8?B?Z1BOUnpKT2ZzOVZaUkZkTjNvYUtRZDA0UWZLOGthVmx2UzBOMlR5ektlUUlG?=
 =?utf-8?B?WXpZbFBYamU4RHNkaDBZKzNEa1Z0cDJIUzd0bVE1OTgwak1tc1lodDJVSjJa?=
 =?utf-8?B?M0NZMFpudjJQTkFwZXZKL1dBeFNINUlIYzZjZitSY1VPM21Tbkd2aC9CZ1l3?=
 =?utf-8?B?c3QzRXJQVjY3NmN2WXVFeVpzT3Vna3RaNDBlNnB2VTIrOWFPTE91ZHArZVZk?=
 =?utf-8?B?aHowTG1ZM2dkUEsxeEM0bC9ySlhzYUNrNWJ4ZmtMQ0tJTStiQjM4U1AxbnNn?=
 =?utf-8?B?NEw2ZC9EVzE3eVJrSjZxRi83QnBpUjl1WEIwWkhyc05MNjRscEZDUGxwRndu?=
 =?utf-8?B?eTZ6RmZ6TTZIVEhuY1gwalVvRXE3NnRmN2h6R0tOd2d5OHhwTEk2OEFSWURK?=
 =?utf-8?B?N2N5OTZqTlNIc3hvMXRHYlk3Z2JYODJVOC96N01USWxjY201cmhDeU9udlRq?=
 =?utf-8?B?bXJyUk5TNnUvUFRqMG8rWUk1NHd6VklEZkpaOFdwSUI3OUFhUklHMC9uTTZ1?=
 =?utf-8?B?SnpRakc0VXE5OXVUQmV0WFI1aUpEeXpRem1yeGZkQ0YyckpTWTJhcE5ObHN0?=
 =?utf-8?B?emkrc3EwMEtnTWp6Y2RQTFEyQy9ZM1Zsby9nNWxlL3FBRGFBcnQ0UldHSGpm?=
 =?utf-8?B?dDJ2cTc0dEM4SWlxSjdQTmtkY3ExK29BMnVNQ0RsSlgyNURTTFl4ZUN1VUEw?=
 =?utf-8?B?d0VZVy9nbUNON1dMRGorQU1oRUV1cEtNaVcrMmw5SWZ3K3F4Ym4wV3YwWDFi?=
 =?utf-8?B?R2V4cW9iN3BPMi9mSDc4RXVjazhQOHdKQTYwWGJ1M2EvOVNZL3FyUTlsWWla?=
 =?utf-8?B?WXlVNUlKS0NQN0F1RWRpMTVsOGdBOCt4NEhzdWNiT1RNQWYwYWtwcS8xSzUr?=
 =?utf-8?B?ZEsyeGpxKzJUY0lxQy91Ums4NEt6dGJuSUNYemRxZWZta3NQSyt1ekx5QlYz?=
 =?utf-8?B?V3VHZzN3U1N6bzc4L0NGTTVuL3V0MmFLN3FrWWN2NEd6MHF3a1M1eG9oMXJ5?=
 =?utf-8?B?aWkrWUF2Yk5lc1R0ZUQyTXYvWm5HZnRGekZyM1F4cmt4U1pYNFBpMlZRcnNq?=
 =?utf-8?B?TGZCNzdTRkRrdVFUWmcxVldXTm51TFJTTDhKTTVnNTArNk4yU2VucjFnazVr?=
 =?utf-8?B?dVNWK0ZEeWxWM2FVeVgxLzlJN3JWeFZuVTZxcDRoMjdUQUQrY0djWFUrNzVt?=
 =?utf-8?B?U3hFMVRCdXF5RUFKQlFaUlZlN3NZeWdqeG8vMEcxcE5ObG1JOFQzemVoQjdw?=
 =?utf-8?B?NjRtSzlrYkVCWVRlTk1kNmdTb0pXQjMxV1ZDQVQyenVOTWI3K081QjZreFho?=
 =?utf-8?B?RDdENUNUUUZpeXQ1N0hrZkZYTkVSc3pTbmlZcDJ6eG5FOFR3MVVhNjdGUDFU?=
 =?utf-8?B?dzRJRVphSlAybm5KQytIUmVQUkVscTVvK0NkajI3emViYTF2U29jM3pCdjNo?=
 =?utf-8?B?RExFOUtIcTBJZk40SER5UmVSNzNabmdud3dOUkJXOWo5L0lUK2ZRdExKMS9H?=
 =?utf-8?Q?4QESdJeucwlpJ9eVM0h5ubw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481d1c3f-5fbb-4117-1407-08d9d4d49c9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:33:07.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x/EFiiE9QArsYeQueZPzEN/knwTKqdNO3ceN2mg1vka8yiitsTinkYDEae5s5wiEzdy1dzCXPizdoRhvO8DLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> There should be little to no effect from this patch; just removing
> uses of some old APIs.
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
> index 27cc097ec05d..250326458df6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2428,7 +2428,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>   		       struct page **pages, int *nr)
>   {
>   	unsigned long pte_end;
> -	struct page *head, *page;
> +	struct page *page;
> +	struct folio *folio;
>   	pte_t pte;
>   	int refs;
>   
> @@ -2444,21 +2445,20 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>   	/* hugepages are never "special" */
>   	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>   
> -	head = pte_page(pte);
> -	page = nth_page(head, (addr & (sz-1)) >> PAGE_SHIFT);
> +	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
>   	refs = record_subpages(page, addr, end, pages + *nr);
>   
> -	head = try_grab_compound_head(head, refs, flags);
> -	if (!head)
> +	folio = try_grab_folio(page, refs, flags);
> +	if (!folio)
>   		return 0;
>   
>   	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
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
