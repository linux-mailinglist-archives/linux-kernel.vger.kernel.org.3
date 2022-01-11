Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2851648A81B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbiAKHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:06:10 -0500
Received: from mail-dm6nam08on2069.outbound.protection.outlook.com ([40.107.102.69]:14688
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230147AbiAKHGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:06:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy0DzcHzyfmZplkoc0GugNbjryHO2KaprjR+e+OxWyXDp0rWILKjz983qcc74iyZxjTI/vIgsviK2+KRS8eqWqNmQGuD6uDsuz4ADfWS1Ntv0ypNizNHO5XCA/6EvOMw7jn0gHt0gAcXcRcjRRn90tacIBhs9BKAhJucPxtNjLHGK4tAzTKPkwWpcHCEQfZ7a4f52yaZx7eTZL0KIc2vFtbh/p5+p4BFJqkmryHJdnuiiRByUo1F6j+E8os6nuau03ihJQYb3T/EbtHw20mZihp7QeRPr+pKDH6BNWo1m+bJ5qqBJEAjKCLD1C2RXAzDY22q8vRplGRlWXzYeOElfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2rkOt/mOytGLA2rwE6ajT4TpgGkmoS7rIr2MqXHMps=;
 b=nVsrPIR7VG/tVUXYdQe/eYVHZvekbBET1+KrkoAZcKGqypcZ0Lodu1DKAX0xkwf1q9wzvbskpQhOwXdgni9X0TbjVNWVGrUypvC+PDD//bLXKcYJQ9SxA6XXIY3+AInw6wf0u3usxjysQjQMcEc+bOBIf1WRzJJvGrzFatZr3ZkKwdAZj3ro8P7XXZrDaee8hNMRL1u8qyrVdNpm6Bcjn26VMtjZALKBnY/I7BaJOT9BUR5ik+DAMoCYEdu0GdwKTO33GpduQBEgwlMm5KDCEb84SGh/hqCB130ewCwI4LDSxPmkenFhsB5OSOsN4/QuKrJ+6zEdZYClFnIlJgm4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2rkOt/mOytGLA2rwE6ajT4TpgGkmoS7rIr2MqXHMps=;
 b=frAuQvG9oNLeYvTdy6lTgaImWrW04WMpfacWqMXoExOD20GaRpwMhhjxjx/GtucrdGwwF2kA/N9DkCk1V9NrwGrxMWVK7eZfc3KeSu6Coo8vdQYppnFLRkeh0YrICjZYDyH6SR0cA0lNA61iN8yI7PfNDhMOuMPpo6u9xXI5jLDEdtFra3euQDjEFlrOnXHgchnoBK+NIV2lctEo3zyieAtpv6xWG7mG7nHh3ZuyO/3YWat88yiSsNYUsOakUrfzaQbZUVutJtPHLhr6bnMQFkVQAvTB0Nm7YN2zEF+imMPdNAUoqawQ4JQw7uYhV68ciT6si6/XDommEBMuIQrH/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:06:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:06:07 +0000
Message-ID: <9191dcc5-375d-b894-a711-5eadebb51c5f@nvidia.com>
Date:   Mon, 10 Jan 2022 23:06:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 20/28] gup: Convert gup_pte_range() to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-21-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-21-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cfbda2c-f320-4bdf-03f6-08d9d4d0d6c2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4630:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4630A6C9B38299175A170929A8519@BYAPR12MB4630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWfn7Mtgd7f0KXhdri8GhoFC+VsMHnlQpGabxmtQMtQ8hdQhXwuUyT/mMYU5UAJMzGZ3wLGdr4dxbJhSBsXdlSnzc2k4L2WB5fm25f8EbNpxoVLIQQaNkmnTkynNjXbeebsobKXaIqleW73IrmmUoAc0zm/mIrxUVFzxqR9dCcOOgJyZV/FdpIdNzSiiSvABB4xkANwVuL4ofRSfzGHtKCiRpUUBdG0RYkq8qCgCGglkego3xNmMkiFc6KudqVFYvVf/auyjjwjRHhOf969hGo7rro4g3l8Lal7M2Las3YcnYI82JDQyt2Kv8aP/9iKQUKG2cCPHO5CFhxf8T6EnnkyyCPCtcx7DilnkHeogXaMs1KtjH9q2u8JKjUMn8ZYTno7C9JlwQk+SpgHfdyl1sMrmyZ8LBXEr/ABaWBwLT9aLg4HtfEhAuq7WfRXCtuK0gwi7EyVXwXlzsp87vepbayE57hw/zFDliZhR8x70+qffgaZxWaQp10rw+P3HAKijuuGZqsbUtSdwOweOoxLoNM0MKn6JLj6d2NZtfd2mvZip0NZszj3H1njuvi6zczrQmy5iPXyiirCs32f64MeewuGAssM8ZZhXjUeH+UpfVzM9/+TwW1dak7N0JFbcR8DDuo0fTc99Fua9WUOSwi470AFXQY11kKZA5/vnOljlieYWY+ZHDvJmsYXGgQv/Fd+3EAOpFnbyE6WSSwdxmptCLZK75+Gm0UC91+Z8JJhs4Y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(8676002)(31686004)(2906002)(4326008)(53546011)(83380400001)(66556008)(66476007)(6512007)(66946007)(316002)(86362001)(186003)(36756003)(8936002)(38100700002)(508600001)(2616005)(26005)(54906003)(5660300002)(6506007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnV5YnF4dkZQVDR6a2VDSW5qWFk5cXVxTXJ0S1hmcTkyb3hqd3RMdkpSQVpP?=
 =?utf-8?B?bVk1ZnJFbWFmYktrcFN5RnVaTnVLQ3J4UmxKMVVpQWhKUDR5bjNaNnF0MzNw?=
 =?utf-8?B?VnVsNFZ1VDJaRzNGK0E0cnlndEMyM0k2OThXYW90cEFCdmtLUWxIejhORjBS?=
 =?utf-8?B?WXlSRWc5MzZFenQ4eG9iL3Jvbk5lVk5kV0hCU1prV3N0eVpITUFlMDhYdSt0?=
 =?utf-8?B?UzJjZURaOXZzaTlHMnFtdnFhRFpPUDROTWYraDdWejlwaWtZeVF1UEVBT2Rx?=
 =?utf-8?B?NmVLa1I2Qzltbk53UEdiUit4cFNLdWFCYjdmNW44bnVzamFRT2lHaC81elhK?=
 =?utf-8?B?cVNyRnBGVWNlaUJYa1dkcVR4bUpmWndZdW01QTVDQ1UxckhEMHVHMGlPUXFy?=
 =?utf-8?B?SkNBRlpndlB6MWxjUS9CNk14czlZaXc1Q1F1YllFWTJQRytYUjVkOU16OVlV?=
 =?utf-8?B?WFpOMnIvNDI0T2tjbXQzV2l2Y3FGWWRka1FSUE9GSnpRQVVEbzlhc1U2dWxS?=
 =?utf-8?B?ZUtldlJyeTRJTXRsNTRmaXVma3h1dkxXZWluVFRCeFVTbnEwZHl6a1pxU29T?=
 =?utf-8?B?SVd3aTNtZHNvaFliL3FzSzc4ZytGTm1NUkhJMytpQTA1MklaSmhqZVRjSU5N?=
 =?utf-8?B?TDc0R0JMTW5kZmY1SExUMHJSVmdMdG51NmF5MjJCbnIzSWx3VndLazFHRkFF?=
 =?utf-8?B?MUxuMm1BWmpoMDdma1crdGdMSW5PaXF5NlBSbWFud3J0djNvVWwzeFduZ28r?=
 =?utf-8?B?Q21vNEhSNGpJRmlXUWpFZmVuNXUvZENvbFFJZmJWMW1lWWkrYit2ZHFQNnVh?=
 =?utf-8?B?dWZLb0lia3JRUDExMDd0aG1MK1p1WnM1UEhta1d2aStBMUFIUDZwaGNmcDc4?=
 =?utf-8?B?L0toNjZsN0Z2ck9sQ2JoQzdBd3FEbHNaYnFILzl3UzB0dCsvczNhOWpJRjVC?=
 =?utf-8?B?NDB6eFBkb0VYTmVvMHdMNkMzQUpSK29IMWRCV1dwSlZMYmdvWlJNcTJrcmpt?=
 =?utf-8?B?NHZiL1VILzE1U243VUFwRjZSc2hCS21rOGFuM0NoYUE0aytxU2svdzhURWdD?=
 =?utf-8?B?VGs1YnBNWDlJWXpDcDlIdEc4Si9FRldWSnA5cHhkcFdGaXZMeEdsOGg2R3M1?=
 =?utf-8?B?THg5em9qSkFnWExabUl6QnNRb3ZaTnlXaUgxSjM2bWJqMEJKNm9QdGJmUnNK?=
 =?utf-8?B?MHI0b3JYVUJ0S1o4TGFEVkNrUmNoTlRUU0JvREQvaUNqTDNkdnU2Vy9HS1Ru?=
 =?utf-8?B?TVEvVDU2SjF3cDMvWkVjVm1IUVpabmNNb3JoWkZaNW1PaVFSR1RFUytxQTNC?=
 =?utf-8?B?QUZ2bkluK1I2QjFEbStveWMyb2xkRDAzYTZPdzZoM0g5MGlKeEkxQVFWcTlN?=
 =?utf-8?B?UmRzNnpiTUpJVEVqRVhab0pBTy9TN2tNdXFYYWNpVWtRaEpZdXdxMWUzLzdR?=
 =?utf-8?B?OXpyK1FoTTIwQ3NKTWRxdXN3OWkvRkUrTkxjUDdmRHF1alY2Z1FXdFhPK29t?=
 =?utf-8?B?S3hGNjZ2UDNtZjNEbWtXNTRYSWRobTZjcCtRN0pZdnVXblNUOTIxZWdVYmx4?=
 =?utf-8?B?UXJoWDZnaCtKcTZDM3VmekpSdm9JeWZST0hFREluMVEwZjc5d2pxZENuMXdz?=
 =?utf-8?B?T2NhTFdoRWlJYjB1VmxVSUdpK0k4SjZseHN4M0pCTFZEYytMby9kcjZyeFVQ?=
 =?utf-8?B?NVJnakJGcDA3czNsMzlOUTlTdC9JSW1JK00wcTk0TnA4L1RSV2c3dkt6akZ4?=
 =?utf-8?B?UldFV2JOOGFES3VTSit0YTJXOGFGV3YrSWlhb1VQZlp5eWcwSG1DcVNhT0ZW?=
 =?utf-8?B?cFpuN0lBb2E4YzI3RTBWUkUxd2ZGWEdQSVhoeE9jOWVESVlIQW5iRUlFek5G?=
 =?utf-8?B?UFFETnpJK3FBekRpQ1g0Qm0wTm1HTHlXR0hxaUlMRi9NcThyTHU4SkRYK3gy?=
 =?utf-8?B?dlM3UHh1NlcwN20zdTQ5T21qa0ZlK21wL3Fmd1RhaVlLbzhlYkY0ZjV5ZTlu?=
 =?utf-8?B?YXgyWCtrZkRzbzFLQ1ZOSjhjMUZpbllFTWl0MUF6TVNKR083NWJKbTlTRjc2?=
 =?utf-8?B?VlFyQ0pmeTY0U0JqbU1ndGI3WkgyQmNUc3Jmbk1MdFQrRWNKZHhEeC9BQTMy?=
 =?utf-8?B?L3N0YkhNOUVyY0dxNllVWFpyQ3lGUitsR1crMWx6dVVYbU84R0JKamxDOEJ2?=
 =?utf-8?Q?yWsDjJOD5cLT7DbqhirzQ1M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfbda2c-f320-4bdf-03f6-08d9d4d0d6c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:06:07.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRyGWhrCRaksWc4AkvRD/wMahD9cubbORYUlaoS5QjvbwTjPPziC7ftaK3qENfHNgby7DSuNeb3CkRbO2L5wSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> We still call try_grab_folio() once per PTE; a future patch could
> optimise to just adjust the reference count for each page within
> the folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Still looks good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c3e514172eaf..27cc097ec05d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2235,7 +2235,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   	ptem = ptep = pte_offset_map(&pmd, addr);
>   	do {
>   		pte_t pte = ptep_get_lockless(ptep);
> -		struct page *head, *page;
> +		struct page *page;
> +		struct folio *folio;
>   
>   		/*
>   		 * Similar to the PMD case below, NUMA hinting must take slow
> @@ -2262,22 +2263,20 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>   		page = pte_page(pte);
>   
> -		head = try_grab_compound_head(page, 1, flags);
> -		if (!head)
> +		folio = try_grab_folio(page, 1, flags);
> +		if (!folio)
>   			goto pte_unmap;
>   
>   		if (unlikely(page_is_secretmem(page))) {
> -			put_compound_head(head, 1, flags);
> +			gup_put_folio(folio, 1, flags);
>   			goto pte_unmap;
>   		}
>   
>   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -			put_compound_head(head, 1, flags);
> +			gup_put_folio(folio, 1, flags);
>   			goto pte_unmap;
>   		}
>   
> -		VM_BUG_ON_PAGE(compound_head(page) != head, page);
> -
>   		/*
>   		 * We need to make the page accessible if and only if we are
>   		 * going to access its content (the FOLL_PIN case).  Please
> @@ -2291,10 +2290,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   				goto pte_unmap;
>   			}
>   		}
> -		SetPageReferenced(page);
> +		folio_set_referenced(folio);
>   		pages[*nr] = page;
>   		(*nr)++;
> -
>   	} while (ptep++, addr += PAGE_SIZE, addr != end);
>   
>   	ret = 1;

