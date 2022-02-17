Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE224B9686
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiBQDSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:18:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiBQDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:18:21 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073ED258FEF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i66U83uydn+XuzJNa62UoXUcErnkOQutxOYdb2SuJHnXx+GVpoX2vRw0JLSw80iUWbqMvH3KEsNnIqKR3YR5TJYRkEvEnW4x8MoQRj3mD+dyaQOxHj7grFQ+EIIavGNb71RKB2gXLiVAZonWlzRFbrFMkm4J6xp5o19J4uDW3CmwJRRcZf0iTd4ccZNcMagXlj+U87tjxOI12LhkuvWcLvMKjSptbggpTgNXWXS51RpOCIoN2Qpw92Uf/0n+SrNGvhQXvTaSB99LF0S2nF/jpq2ZH/rBptGRO4rfw5OrhJSnNhqAgZOi1gvhIhVYPHr4XqbjV8QGoErC2hKmoTB4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OtYm29Hb9Wn4jDWH+hYY0kLW3dAZdP4sYLtEHKfgDA=;
 b=R2SUNOXlFB4h1oySgEiy+4zJZ639ec0zbFIRfwhduBsw7Vpvx/HcSe52zM7Ohs0Pj5CLlRnTrDImi3Jy3rnyzlYv9vQEwSiuNnOsVvo4HR/5Lqy3sdfZ/uf+jSuQdf2eVnldRC3p/CLQTxkHwcHxOBFzKdHzo4PBasqW26KUYCbOHhhHzHP8M8lil4x2mwtsUlqheeerSWznILMARMqKVrMfb89Nf2MfAkV8QFo0ErKWJjnIACp2Gi+bcCmxTmlazPjHRy7ISz06PzPwkG1Kwl/+cXnpwDKFj/Vn7nOXxC4vtMsOpRpFcMzuhH/QD3PWnjGT8SOfDn5W+7opgfF6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OtYm29Hb9Wn4jDWH+hYY0kLW3dAZdP4sYLtEHKfgDA=;
 b=DYdWkn7EqCRds5z9HLavVKSBN24wMXwAFY+PTIAMCu43GMKCuq8uqEdiSDuuHqF849q02W7QurwLgHCbEJDnGl/qoCxg88Wkba7jR6pIafdCnQJBAf+ww1fOht1Ove+PECF3SHlGITNt79xgFBTQyCtD2AVQtjT9FPJpkKttAjUHDmTggdzCmS6gpkKne4yCJ5pdXCdW1CNmVYQ7+TcU91urlxY0XWOK65E9+LZvxU5sAJjHgXrWPIAuvLlFgm1kl6Nya1yauQUuDBCiXlDSykPP2wx5fHTiLM8oeXXmwhAG+xgpAj+g4MMSL32s+XueZwqrSPNoI0ZddwulsnWO9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3522.namprd12.prod.outlook.com (2603:10b6:408:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 03:18:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 03:18:06 +0000
Message-ID: <abd63588-d45b-9d1e-5d1e-b095c8112793@nvidia.com>
Date:   Wed, 16 Feb 2022 19:18:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/4] mm: Rename zap_skip_check_mapping() to
 should_zap_page()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-3-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220216094810.60572-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:a03:54::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6059696-8e03-4484-d2a3-08d9f1c41d83
X-MS-TrafficTypeDiagnostic: BN8PR12MB3522:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3522F01795E4A4816B0255AAA8369@BN8PR12MB3522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8gFXAZ1zNYqgX3pR7pgZwLI5THq/RtJOX2LOnUP2NwrUWoZPQCOkXpefyL5ZFNC4qJN/d5y/N5/9HNAxVJv3+L3AMkNY5Qca3OS19IzVWv0Ectk3Zho/fDJYcSy3Qr/tgf1EYc6fGWb6X/axqtFgW8BH71SetnDNlMU5KFYRTizpJenHmIE7kCBzxD1kbXnK1yMeHLKWLmO4L2XMD6nM6XFvH27kbDEXc+MD4bFuetZGb6GwdrjcYNPZIPRP0vaCPiEE5Xc+IlW9c46lQCzt4prUwDCXRgVwljOzNUj/rxpW/c2wXddeJ2kOV4kQiOUwksA5G3UbHZ77ANPDSIs7qv+kW5qpkO/Gy4ErOtJ5Zi2h4ifgqm0MFMYu4KNWmVLSBTXkiov5XMxwt4h/vEa1KrKdbLQbsoLSY7DtrQ2R7Z9yyJH+c619y8Ipr/Jc3xcj3STUuqoeYEvM0Lr/aadKUqkZeAHedOEzqaKiXCJRC3Yd1xsOF5nxDzkEi1Qt2/zaRc7DVTH9JMI4EH4KYzd6lq4/EjcbxUmq2zViBzWZiQ7hIPbjQD60c9bXeqVzSCga9c4DxVXiPqSx0xI0ZWJC2HWhodmFDIcdIm+rRlRfSp2Cq5tFO7eM+GLCtRVIjHxJJX0/EXHJrtmg14Ft4MQR3KDDwoiEkiucaywTk/hON7n3Y++DxDCh66JO0Flq2g7jaxKVO2tte/k0CTKMK5dGtNXHbg0Psdjf8LjF5T7Wlq5/T4Q9smbf3E48Rbuau8x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(508600001)(8676002)(4326008)(66476007)(66556008)(66946007)(2616005)(6506007)(5660300002)(53546011)(7416002)(2906002)(6512007)(26005)(186003)(38100700002)(6666004)(31696002)(8936002)(86362001)(54906003)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hBbWZhbndRT1lGd202bFVPRlNDdzgrYm5RQXV0ZFpMSGRvRHYvZHloSDlI?=
 =?utf-8?B?ZXpubWpib3hlRVh0Ty9xUGxVSkFjRDF5ZFdOdzRSVTBxWHlJcys3aTRNMTJh?=
 =?utf-8?B?a3BWRFd6MHlQb3lHNUdhby9UZjBWbUFVQVY5aWQzWS9tdmkxS1lFdzJjVW96?=
 =?utf-8?B?NDk0VnMrK1kxdHZ2OTluMHpGNEhUWVo3eHZjYXYyVURVaENUVFR1ZTg2aGdl?=
 =?utf-8?B?Nkx0VXhaVmoySGk4eWxVNll3UG41RW5ycjFnbCtkVkM4bEtxM1dBcCtaYVhq?=
 =?utf-8?B?ZFQ5SDlhVUV0cTFpbGFWKzM2YUxxZzF0VTlnT1M1OE5LR24xYVFGUjNLWElM?=
 =?utf-8?B?aXNrdHoxcVM4bE9URlIrQTJHcjhuemZuT2kxb3EyL21HUHUwOTdja0NmWlFT?=
 =?utf-8?B?aUpPTEtYUHBIUDBCL1QwS21ucmJxVFkrSGpldWxDQ2lzRGpBeHdaeDdDTVhY?=
 =?utf-8?B?V0wydXp4eEtGZFZGZEtvbEpiNS9pZHgrdy84MUhBMzEvNExyTDA5SzNZZmZF?=
 =?utf-8?B?L1RVdEM3OTYvbVFFUTZoZWJ5Yk1vL2dFSDRIZlJPa2wxcXdlSGtacVdsTnUx?=
 =?utf-8?B?QzNLNFAxUUlNQ2hrcDV5Nzg1VTN3V0s3Smp0UGF1T09aQmZ5V0o3c2l5MHRM?=
 =?utf-8?B?UUwwWXU0QzhRNkJzcFJzVXFmY0lPZHJTT3YxVzhmVysrU3ZjOExDa09neE4r?=
 =?utf-8?B?NWVvZWtTaWJGS2ZzWU9BRzhMQTRXenM4VDhtaTU4NGlKTVJBc3A4L3pDVmJU?=
 =?utf-8?B?K3NETDYrWEdtMW9LR3NuQlVFZWpyYzVBbjNsNEJpbVBhemVjQXJHTmpMczNT?=
 =?utf-8?B?b3MrazRWbGhOU0R5Q05abjBBaWdGNE5wQVpSbWd0dTZ0Z3IyK2ZsUWNtSTlV?=
 =?utf-8?B?OVhGc2wvUy95eWg0dWUyZk5kL29JMFcrU0R0Tm9PR1d0cTJjQWV2U3N1dWZL?=
 =?utf-8?B?V1N3NG14dXBNdlFvbU53Z0JQVm8wS1ExSVM0Mks2dUVTeCtWeE8vc1dERUk3?=
 =?utf-8?B?TGVlamxWMFR3R0lwN2x0TzlRaVNPNGNBUE0zMW1uWGpRLzJnT29CMTNJVkZI?=
 =?utf-8?B?QWNrdHhqZ21RMlhEZCs5WGlLSmpQNG02VHNKUFM2Njh6NThCcGN5OXh3dzI3?=
 =?utf-8?B?eDlHT2IwTGFnRzFzTElTS1NaRndzZlRQLzFGZlMzVmVwZW9KUmlTb2NkRUti?=
 =?utf-8?B?N0dHZE5tQUR5WXozTkJ5ODBVTDV5dUpkV3ZmZ1crSEgzSlJRUWRncXJrOXA3?=
 =?utf-8?B?NEZ4T1ZJTlFDOXNmSEp3TnY4T2FTTmVaL1RXNGJSTHAvaFdnOUdVMlVxcnN5?=
 =?utf-8?B?bWpOT0tua2E3VlY3SWdBa24xMncxTmFHQ2VERFVSYUlSVDVqTjJLcnJhRjBa?=
 =?utf-8?B?NlpJemd5RkF0cXRhdnphUzBYcFZ0NjJTQ0lYWVRnclVZSEtrSDlsN01HOFBn?=
 =?utf-8?B?VXNidFVkdDNteWJlMEFxTE9KcHgxcHhvWVBKWjZqRndyR1JKQ211MzlnNmdL?=
 =?utf-8?B?U0gweUtndjl1VHRjMHpLSjlFZnJ0RTFrRis0dC9QNDJJb3RQb2VsSXpPSlBD?=
 =?utf-8?B?WVFqbUk4OWZaci9Yc2Zjbm9PNEdGUHFhL0pIRDBqeENQbElJT3lXaEZHMFFK?=
 =?utf-8?B?OTYrektKMi9pTzBuYTN4bnJrSTR2NTczdUE2d2EzU0hldFBqWDVkWHZnYWpO?=
 =?utf-8?B?YzBncmd2OVRhMit0UytWbm9YblFSY29rMkpadVJQR2hERnlDUFVpclJuMTFO?=
 =?utf-8?B?bXFVYjJzaElSNXhvVzRSeXZ4UVdxeCtFOEoyVzlDNllaUEs2anhEcUgzbzhj?=
 =?utf-8?B?MWp0UFAyRFhnaXEzdWlpelI2MnhJeG55L0djL3Y4MHRNdGhjMFJnbmRTdFpV?=
 =?utf-8?B?VkY3Sk80MTY1aFJTYXZxMnpadmZ4N2V5Mk82VDJDVThNWEdwdUJ5dmtXUmpM?=
 =?utf-8?B?d1ZBNHNCekE2Q2I2cG1uZkdmUkdJWEpzSTlvVlBoS1V4N2ZJbFBWcUE4bEty?=
 =?utf-8?B?SG9VcDVtR01tdmNjVXdYRDViR2tOMG5oM1h3U1JZcW1XOUhTZWNoUi9LbkxG?=
 =?utf-8?B?N09jZjlTczh4WjVSTk83WURRQVg0WW1HUHVLNkpPWExwa1pqWUtMZk5LSTZ0?=
 =?utf-8?B?Z2dNSko4dWhmd2ViL00rV0VJRE9tV1R0UzNWcG5wNWxZU05yclhPcXo0cWM0?=
 =?utf-8?Q?gkMi5eNBDrLKbEAwtIpamlc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6059696-8e03-4484-d2a3-08d9f1c41d83
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 03:18:06.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fKSkIR+CSIyCaTRAYQtmCtxXfLSVwefDB2Iv120pXwHD86/pSR9Trd1F7EnIAHd9XnyHSpWbS5JtQSQWpyxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3522
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 1:48 AM, Peter Xu wrote:
> The previous name is against the natural way people think.  Invert the meaning

Definitely. 

> and also the return value.  No functional change intended.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4bfeaca7cbc7..14d8428ff4db 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1326,20 +1326,19 @@ static inline bool should_zap_cows(struct zap_details *details)
>  
>  /*
>   * We set details->zap_mapping when we want to unmap shared but keep private
> - * pages. Return true if skip zapping this page, false otherwise.
> + * pages. Return true if we should zap this page, false otherwise.
>   */
> -static inline bool
> -zap_skip_check_mapping(struct zap_details *details, struct page *page)
> +static inline bool should_zap_page(struct zap_details *details, struct page *page)
>  {
>  	/* If we can make a decision without *page.. */
>  	if (should_zap_cows(details))
> -		return false;
> +		return true;
>  
>  	/* E.g. zero page */
>  	if (!page)
> -		return false;
> +		return true;
>  
> -	return details->zap_mapping != page_rmapping(page);
> +	return details->zap_mapping == page_rmapping(page);
>  }
>  
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> @@ -1374,7 +1373,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			struct page *page;
>  
>  			page = vm_normal_page(vma, addr, ptent);
> -			if (unlikely(zap_skip_check_mapping(details, page)))
> +			if (unlikely(!should_zap_page(details, page)))
>  				continue;
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
> @@ -1408,7 +1407,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		    is_device_exclusive_entry(entry)) {
>  			struct page *page = pfn_swap_entry_to_page(entry);
>  
> -			if (unlikely(zap_skip_check_mapping(details, page)))
> +			if (unlikely(!should_zap_page(details, page)))
>  				continue;
>  			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			rss[mm_counter(page)]--;
> @@ -1433,7 +1432,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			struct page *page;
>  
>  			page = pfn_swap_entry_to_page(entry);
> -			if (zap_skip_check_mapping(details, page))
> +			if (!should_zap_page(details, page))
>  				continue;
>  			rss[mm_counter(page)]--;
>  		} else if (is_hwpoison_entry(entry)) {

