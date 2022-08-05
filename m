Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC058A734
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiHEHfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:35:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7449BA8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQInFMs3JrXLf2hPAsTgUW7zuaWe2DhipNZ4tqbexoQ0lOVl8yriHj5PT7G8zs+TuM07JQm7OKZYS3r+mB/K8wpAGVgDzgczbMcaoieM4VvljVTz9QmovQNZezhorQfuGtijSbqszFcUashZo1vC4EKxGWDWwpytjx66bVhuId5y1vez1ENXETtxUlk9OBVhPWwWBjZGVxoeXNzdpZ3J76woEM9jUgSxv9/xGvC87ZPnXeuYzla15zsGYUSww8GJ1IYAHVGxN+upgT4mKT4XS6f7z/bsaO2CrD1FQ2dYO4+hilIiJYQCJFXtY42fqFf7GO8ee7crHoM5K8jxI/rHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGSYwpC54b4ou3wFxA+Bebb8ISu+CtgH07esc/RylgE=;
 b=YaUK7gGOdCnMxqjRlfHBU2oQaRbVkbr2uWiQDaotjvkhBWRd2Xr0H05XdciDbmM6v05S33r3Y95LVBikXkLUscv6LM9+PqTeD7gKSCxg9lEMkvMorc6z0l/Zgz68jr59QbIsrMmgMendKrENPrqJG150crxjW3J59QjVWOfU/1u6PEym9DvjxZ/dSZU9ibML/ghBQsJzOp9npwo61ZyBj9016bpGm0BaNUNsdwn/ddFeyxasbmJq6fGz0BsIQEUgs0VbsK1fAF7cLTufMF2Y8vn9nwYIIrR2PYriCSfYOB1y0AyfmFawVePZLdhvw7RL+1FHtqeqBWCx5YpN19nvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGSYwpC54b4ou3wFxA+Bebb8ISu+CtgH07esc/RylgE=;
 b=sBa/K0CStWIkfiilOoLK6EostiUbV2d7APQ3j/PmF2zonqYMawNiMdZOzf3RTt+sSatNeyajOtRMPJsSQJol2Ff2GrnsLMP2kLDDhQR5DwVhX6JVaC/gcTBG8ZhR4y8KAgX8xHesyh8zXDmT9c2aLqFKIMiW98CrK+3+vwFSsHYi6zojZdtQGXB+r3wRmeUyrLlSBjHeqttuWYddNYr39l5EGGviXu1j2hYBcwEj3Xzm9BiVZKmgLuLUlQ2zWCtHyv3DvMl7Jigi/B167Vx5zQPQkpH9Ta/v0u06YJo2bzVUabqmywm08XW3Qsqv+y9TfwLV2uA9Sr951SNE00rqsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 07:35:11 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 07:35:11 +0000
Message-ID: <f6f16c66-0771-4c61-449b-5278f277a7e2@nvidia.com>
Date:   Fri, 5 Aug 2022 00:35:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3385c9-c25a-4961-2f56-08da76b5071a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4035:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+IYg5fLfAROKukTVaKBDkj4kBOl630fKecV9wuQgW7vv5Rw/ltcwS1hk+quRQzNwCKXVkvtFGHA1/JeGCKGcWeE6RM1P+Pybs97qRfez56TC0LflM+K+DSgR5uz8dlBWWuHztmfspeDVSWEeoUkPFk+9qe8/mGj0oiT5rbpS49xxvcyx6rXwRy1KW7StWQCxQYJg4O+6owkajsaVnXvKCupkKfCrMARXXSa/SZgkbp9BFqiTocRL+A42NAMq4pbVEn8LXYBqAzKhcR51O0+nukC6bXEgFs1DH839CLwovCUDB2bj9xi8UMM/j0lzhvPOUH5rqa4mUvGIEKDSseLp7DOQpxW5ngA/n4+eQOy0fTAkU3sews0ZXr6yr3D6ItvNPartBYGhWgVdNxlXeVejOF8SgpwPkDZwe3U6o6VlrCkvPTkn+8m/wcYG6m8CewqD7k1ZLH4DrFPw+hFSawDYZ3PwT3ibGwCQ+0DSlDW/W/V+L78PQJ0gAAra7+8MPsKZennr4spNT2Vl//q8r2pkitzSteYVESkdh1/V+KK/3/ohYsdzOMOVJS8UWDFDcdBL2Bg3myX5l7ZsBxnbX93A41+i64tpjvBoNz6n87rFaYwQ5QL67x4MU8g8Ii7ZGf4XszbosysdX5Fiqsu7xcQIKkrmDaSLm2T9SNoEromtyZ9Jy1r7EjLSAfgsGlXzijNlrSQmwryuCJ2KR9SEq6py38y2P+2Pw8AgJF7aLyRqIkgNn1Sl3ZHcQc1pFmBHILWCRzJxpxoQq70NGhSVBBEl5CA6J4Nmh4dV6eqiAsmO6Dw3KtQ7w/DEmhVSPBakIySTRIVeR/h/tryEK/9e0xjzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(83380400001)(186003)(2616005)(26005)(8676002)(66556008)(66946007)(66476007)(316002)(36756003)(31686004)(54906003)(4326008)(41300700001)(8936002)(6506007)(6666004)(7416002)(53546011)(5660300002)(86362001)(478600001)(2906002)(6486002)(6512007)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNDQUJHNVRxcGpVUVJGdG42QXczVkN0cHBVcklra2g4dVBVaHArR09XK1p1?=
 =?utf-8?B?Mktpcjk1d29xSFhjNFR0Q3J3UzBDVll4OWNMOE5FeVJHc2VJUWFiU09vQy9w?=
 =?utf-8?B?TE1ZUng4bnI5Y1VKckYyamcySUZtL2VhWEpyVTM5K0had2xnNytmdEdCVlJV?=
 =?utf-8?B?UDdDT1Q5VnA3NmowODlmMWZwcmF1QW4reVRrR05vSUZZWXhKblVxQVZheFZR?=
 =?utf-8?B?cm9qdDRBejhmdDAvZUduaTdDLzVvdHM2Qi9kb0RpY29VanVQTUlqOU43bHYz?=
 =?utf-8?B?MkZoc0dzYk1CKzVWWWhKbkorQk1DOFg1WnArd3loaVdLUWJyL2tpQ1FOUXVi?=
 =?utf-8?B?Sk9PVGJYNlpBN3JRZ1A3T05GQ0dNazZ0Z0tSM1VwUnZEdUY3Q0xXeW5uZElM?=
 =?utf-8?B?cmVTN0R5VWxheWdrbXhJU0pOWk00SE92c1JvNTU1Wkx0SGtjZ3ptSXhLWlFV?=
 =?utf-8?B?eDlucnR6NnhSY09vTzBKQXZNSTVxYkx4Ly9LM2ZTWk1vMGZDQS85WExpM093?=
 =?utf-8?B?UnVjcmtnUkNLTWF2VndyTStHSW4xektKYy9hVWhHSHJ4a1JqeDBuUmNXK2RN?=
 =?utf-8?B?bWlXY0JKV1owSS9GSTR5UkM4WjNhcTY4QmMrTG9VOUp5alM0NitnNjhkYmg1?=
 =?utf-8?B?SW42WGlBaCszTkU4VXo1WThCQzVqZ3UzNEdqSU1raC81WU9GWnNld1F5aWJZ?=
 =?utf-8?B?bTZBUm56NEtTU2xFNzZkMlhvVm02aWQ1Z2FhRkx6MFBsTDF2VDdWTDJWMTcx?=
 =?utf-8?B?YlhkdUhNNGpSNlhGTWg3c2VEU2d6clA4b1B6MGcvcUFyU3M2TWdvMVdGTVdK?=
 =?utf-8?B?Z1ljSklnR2tWcHR0dm03NU81NEVhMm1FSjVoVTJPRHgrd2hjb2N3ZWJteWc5?=
 =?utf-8?B?d0N1czdVT2VvTTJIcnVNZDZ2TE9JLzdvNGtkaVVxZW9ZbC9aRmFmY1E2L1VE?=
 =?utf-8?B?SWxoTjFHcUorTFlWdnlwVUFPQk5aQk11OG9kdGNBZ21ZV2loWWRRblRqT1hh?=
 =?utf-8?B?Y21lakpDSHpuWHFPSmUrR2dRN25RM0FwYjFJVVNnK0NyUUZHc2J4R3FmTDRC?=
 =?utf-8?B?bUFWNzY2NkJxWmw3bFlXL1NhNWpROTBNMFd6K1MvZ0VOQWZHTjFMbUJkSkdV?=
 =?utf-8?B?a0VrYm5uL09yK0o3Y29kRlJjZ014QjFKcHcxQ1R3WGFudGE5UVlrQmI1Mkt1?=
 =?utf-8?B?WFFFRUl6TDBiQ2t2blFKUXRjQTV3aUFIZ1Y1THRScWlQUjFBd2NrTEZ6aVNk?=
 =?utf-8?B?WG5obHcwNTlRZ0kyaEhtdGNyejVpNFQ5MmFSWVZmY0I4TDFQR3pIeUFmell5?=
 =?utf-8?B?ZHhYUnVhd2piVkY2cWs0NDhsL3VGTUpaZFF2TGExbzczT3cycUI1cXlPWXdh?=
 =?utf-8?B?ZlZYZXByMVJEVllETFlZWDl5bWVKcVR2cUVDLzBjVE01SSt5Z2R3THZpR2cz?=
 =?utf-8?B?cGNoNkUvNEJnYnA4TktUUUwvb3YyUWFLTitkRlY2V3NDRkZ4eTFtZERuVDNM?=
 =?utf-8?B?cU9xY083STdWVWkveWNmWXVkdjM2QXVjdVFZcVFYZ0NoQjdSZ1d4VzZ1TXRo?=
 =?utf-8?B?eTRuc1B1WFF6Mm03d0RWUnA3bFZrZHl0V1NBaVhMS2dYZTlEdDBQUEZ4NDR1?=
 =?utf-8?B?Tk9iSnBCR091NWJ5ZXBQV29jdTc2WWZKRXVibFVmcEoxRHcybS8rbkhJempG?=
 =?utf-8?B?eWljUURtVWFmWHg4RWljQ2VVeEU5c2xwTHp2THpPTHQwTUswZEEydlN1Ynps?=
 =?utf-8?B?OCs4QXphcDVtcm5LWjlDaFkzRElTaTFEemVBbXpiUjl0ZHVnLzZYandwUUF1?=
 =?utf-8?B?VnJROHpFWFhhRmkyN2FDZXQzMU1OemwzZ0NLUEdsNjVqMDhvNGNRRlphQytX?=
 =?utf-8?B?dmFlZ0xkcHp0azhXUTVjR1VCMlVtY2RHdGRhQmYvOTFrVHRwZlNqZHY4cFUz?=
 =?utf-8?B?TGUyUm8yTUZ5eElJODNtL3VmSG1qZnFsZnpucmNGcUMvRHB1YkpzU0c3Lzh1?=
 =?utf-8?B?Q0hZOGdxTU12N1BCdjZSVmNWUnhnb3hIQ1o0TTMvRm5HM29WMUtxQlFwL0px?=
 =?utf-8?B?eW1IRmU1UXRicVpndG92YVEwb1YxRHNaNDZzcDZvbDhDblh4RGhNYzBVekR2?=
 =?utf-8?Q?gOBsL6vjPYfx4INdwzJODGug+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3385c9-c25a-4961-2f56-08da76b5071a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 07:35:10.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: end0n3WPnJI+FxLo+z3MYLO/lXUHaIqg2FHBfgGXsZPxSHu/VpnuYmm0BhpXWUNAZ394SaT6G8zjpe8jykJ61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 23:29, Alistair Popple wrote:
> gup_flags is passed to check_and_migrate_movable_pages() so that it can
> call either put_page() or unpin_user_page() to drop the page reference.
> However check_and_migrate_movable_pages() is only called for
> FOLL_LONGTERM, which implies FOLL_PIN so there is no need to pass

heh, while verifying the above claim, I noticed that
__gup_longterm_locked() has been misnamed for some time now. That
function handles both FOLL_LONGTERM and !FOLL_LONGTERM. There's
always something...

Anyway, though, this patch is a good cleanup step, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> gup_flags.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   mm/gup.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c6d060d..e26ccc0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1907,8 +1907,7 @@ struct page *get_dump_page(unsigned long addr)
>    * Return negative error if migration fails.
>    */
>   static long check_and_migrate_movable_pages(unsigned long nr_pages,
> -					    struct page **pages,
> -					    unsigned int gup_flags)
> +					    struct page **pages)
>   {
>   	unsigned long isolation_error_count = 0, i;
>   	struct folio *prev_folio = NULL;
> @@ -1941,10 +1940,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   			 * Migration will fail if the page is pinned, so convert
>   			 * the pin on the source page to a normal reference.
>   			 */
> -			if (gup_flags & FOLL_PIN) {
> -				get_page(&folio->page);
> -				unpin_user_page(&folio->page);
> -			}
> +			get_page(&folio->page);
> +			unpin_user_page(&folio->page);
>   
>   			ret = migrate_device_coherent_page(&folio->page);
>   			if (ret)
> @@ -1998,10 +1995,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   		if (!pages[i])
>   			continue;
>   
> -		if (gup_flags & FOLL_PIN)
> -			unpin_user_page(pages[i]);
> -		else
> -			put_page(pages[i]);
> +		unpin_user_page(pages[i]);
>   	}
>   
>   	if (!list_empty(&movable_page_list)) {
> @@ -2023,8 +2017,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   }
>   #else
>   static long check_and_migrate_movable_pages(unsigned long nr_pages,
> -					    struct page **pages,
> -					    unsigned int gup_flags)
> +					    struct page **pages)
>   {
>   	return nr_pages;
>   }
> @@ -2053,7 +2046,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   					     NULL, gup_flags);
>   		if (rc <= 0)
>   			break;
> -		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
> +
> +		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
> +		rc = check_and_migrate_movable_pages(rc, pages);
>   	} while (!rc);
>   	memalloc_pin_restore(flags);
>   
> 
> base-commit: 360614c01f81f48a89d8b13f8fa69c3ae0a1f5c7

