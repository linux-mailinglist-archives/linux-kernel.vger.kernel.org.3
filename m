Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3C4B9689
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiBQDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:20:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBQDUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:20:12 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836B62819B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3sOvxwBw7mZcjUvuSYVSS7Qig4RiXODjHbNDt02IRtm+3OXc1xtJJP44z9L247ToTp2hdmhxNzZDCLsEcjEocv1MSt09NeGOIHoILQP24vHpasnQ+w7uDnsB1xcIUOMDvd5aDhNXmf3vCAS1NC/SvgC/vKO6ToaJ6BGa1gcd1wAB2KwWtlcK620guy97fpGg+CivEJ57ODa8je4tRClizjPo3Nx53qo1Ju3oEVIA7NxzLZES3wwU0spVjK3+a8NJeLbEMpPQY7X9nGR2vCb/+FhH94Adk9XFk+KAVFk2ieubtVqriDzhf0uvdlLb/pBJUoIrC2gwUaIYR9S6dMWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iehKPR7hATIMGUEzU9DELVcIorb4TAH185DoRot+Ra0=;
 b=PyTFjHuvxqglhG+EaZvU+CEjdDXX5Db23HSdtewbJ9cNAyA3x6ufcJAJwm2I5688BN8BLZTeSYZm9hW+xzbsziXqUlylfW02NBS2x7yaBThkdYIg3a3pbAhRc2cviPM2pCii+JV3N0VCHKrufIt7wO7ysHvB6DgTA1xUuAxd9R9P0Fut0QMNUxu8AQ9cf9CAAYgXyNefcXBYS3rxVdZzqubi7YHHxksIZH+t/hwfh3xUq6NAn2XUbBjSh/uXsQ+scVpBJVoMbUSqrsz/FJWPGFiJ3wxBZhBl/llxyxebG98poClVfbs+EQ/f+Ux071H7rxEIVHcM/PcrGKTBD6WscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iehKPR7hATIMGUEzU9DELVcIorb4TAH185DoRot+Ra0=;
 b=NvAHUSdD/lfOHjOgeLg9ngcsXu5kQkin6EjlW2NJES9gZxmIlwFViJiVVOfeB5K1NkTU4Gy5jr378VoW4/+nxIhsqRIBEgwDwJS6WuvuzoGh33Uh0AzUBYGRKLH9o8Xi4Tqk4C/yC2C4r1ZvRMUKCu3qHWROD93Q6W9MxoGXuX8LD3uMsKLgpUp3KRIO2mshj4EPsVyi7cGTD/AGnhfqSn6OtLAVDx9rAdeF+YxXdMXdu8DpMEPALWrkSf/V5d9g1DrBipDYdvlmkYahq1dDdbj3j2ADzcqVLr57gnddIw+TpadNDSRaPX4tgXV3rLUnkmMHVXowmUuaC9X7x3WyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3522.namprd12.prod.outlook.com (2603:10b6:408:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 03:19:58 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 03:19:57 +0000
Message-ID: <6df12647-c90c-97d5-c1bb-5b066affae46@nvidia.com>
Date:   Wed, 16 Feb 2022 19:19:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 3/4] mm: Change zap_details.zap_mapping into even_cows
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
 <20220216094810.60572-4-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220216094810.60572-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:a03:54::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e48d5f4-803a-43d3-55ad-08d9f1c45fc9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3522:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB352275C5443BF6EC2FD2501EA8369@BN8PR12MB3522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSy05Www9cTKoKjXVgE9A8B23q9xPiYTRtAOwNjyZgstJoyzA5HBtmuobc7csdTpwKsJJHjXeCa0F3OtCK+26gB9XqovVifOgdiz7pnmsTNkQ/OUgY+YGinRhfybLMlpFGoUpWQuVKCAtgQMUya+BmU4DLt7X3jLg7dhebYbevhZ8is2wD1nIqiYagkarte3ryURyUSoxoBEC/ycSnWa+lcu7Trp90ub4USpOfxRwmYx7Jqw7JEiS63/asrzR+QSRN1R4exj9bwJL8OCmSNPPU0uZzhGff+k2+pWH5QeC+qJjvWr0Y39oZIlwLoiP8S9QJrKckjlLjSYGd2M/E2PyJU1Uhm31ebxupDnt8IBTen/1ArTmOSI1Bk6Q7N23vyxmCoAILiOm1gSeb3Ogvz3X9Sdz164GzoTnMx5RysJiO82FX/lwGyL2JVHaRaAFuvtblXgPh+VjeCmI4wyb5jASexgpHqmT1lmW4oxQhZznT2elVJg3orMHwHAIUMMKXefJlCc85ngo44CcIQXsd9IKGeWOmsSIjPHmcMO6piARbsqKtLKIsc84Z2B3cW++KG8cDQpKPQavOGLvIOX2SXevKpXjo/xebID1mejkoUsOAJeUCH600b/Z+zYXrLVAY9L6cFGDOSzEgGll+zt5kVkK8ydwY2mjHGhyML2qsgIgE18HRVczSQ9lAo+55DGo9wlI/3l4kFgmimpAJ51ZHHqf1MhdAYD2JpcCwIuWACz1blErwgJoKPeQCsx0c5tf51qAIvWpQMuULI9uCKTOik6z24WWDEzC8pkXB8nIDPqfkS6ZPZeN1GV/UP1i/K0keHDHriT37ZnbWcqqMSRrq9UkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(508600001)(966005)(8676002)(4326008)(66476007)(66556008)(66946007)(2616005)(6506007)(5660300002)(53546011)(7416002)(2906002)(6512007)(26005)(186003)(38100700002)(31696002)(8936002)(86362001)(54906003)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlReFp1emtRSHFjYUN6TFh6emRWWjNVMlF4MDkvMjh2Y0xvR0F5bE1RcDBx?=
 =?utf-8?B?OEtGL3ZZRTIxczYwVjJpSjNBWHNicC9EUUNzaC9URGtLSWdQQXo1ZGtWZWtz?=
 =?utf-8?B?dTBYSlNvQzB1RE1MZmRKMjJWMG5UWG9td2tCNnd2TXlwUHQ3VFp2UzBKbXVY?=
 =?utf-8?B?N0lFKzhFQ3hjajNCNTFGN1dWZW4zOGtJcFhvb2poNGNrWkNIaTl2aDA1cmM5?=
 =?utf-8?B?TG5ONlpoV1dUdzAza3I3bzlqRjN4bWo0ckVjZTlyVkpRRElUTXRQMWNQNzNs?=
 =?utf-8?B?NEtWOHNBK2hwRUpJWG9NZHFvVDNiUlArYm5DK0pyNVh4Vlk4VzJLZlQ4TmhI?=
 =?utf-8?B?Rzc4K3lzTEtRZFRRZGhZRGorb2dqTS9WVlNEQ1A5eDdvaWVZa05QYmZDSzdH?=
 =?utf-8?B?TlQ3N1FqaTgxblRzR1FvUUZmelBzRDRuYWdJdEJTaUlGMTNHNmtRcTRPZHhV?=
 =?utf-8?B?TnJGZURpZ0gvdWRXb25SczE4R0NjYzNtd0FjcUVVOE92KzR5eTZXczJZRWhY?=
 =?utf-8?B?blhrRXQrM0t0VFVZRXNCNHhkNkw5eS9mTjhzRTh3c3VObVJaRnp0M3RCZTdW?=
 =?utf-8?B?dmpJQkQ3bWtrdFE3cWtpVkxZMDdmMUlsR2ZRRmxtMnBIV1lQM3MycW1sNHZS?=
 =?utf-8?B?bldRbkEvblhQSTVWMXNpcDAwKzV1enlaS2pPYVBUajNjOStueUlEaGJIOElZ?=
 =?utf-8?B?WkU1L3NBMkMzYXlFS2dhbDdqTmc0UTJJQ1VVbGw0MzByUlBzb0dSRFQ3bG4x?=
 =?utf-8?B?bTVzSXhhVXRMRHhWeXFFMURPY1hyM1lVUm1KN25JdEFrUVZBWk04TzB0Y2JX?=
 =?utf-8?B?TjdBbkdMckdjZnJDZEs1WjRhMXNWOERUZXZlYVpza3pKVis1MmxZM0dXTUI2?=
 =?utf-8?B?T3cyNytEY3h6OGp0S0sxb1FTNmV1cW8xUTE4N3lxbDZuZVZPSlFNYURkN1ZV?=
 =?utf-8?B?V1NpaUFZWHlUK2VXN1N3TTBOam1iRWJ2eEUydjJOaDF6bEVhdER2Qlo4Lyt1?=
 =?utf-8?B?R3crNkZ6VzdqTk1sVENJL2pRay85bGZSUHJaakhUbU5nczhreUZPeE5hVksz?=
 =?utf-8?B?RmJqYXNZY0FzRFBsbEF6RVhUWXVTcHBwOGZ5Nm5wWk1qSG94UGozL2RKdG9D?=
 =?utf-8?B?eUJSSzlTbDlMY04rMExMaFZ4bHlBZmx1RjFTcTQ1S3VITnYzYmJsRC9UMFVo?=
 =?utf-8?B?Z3F0M0orWm95UndQTEp5WnR6NGRpTUVLbEV4U0JnN3VxRFh2dUw5RmI0N084?=
 =?utf-8?B?S2U2YnJ3d1VET3JqQ1FnNzFkb1ViYlU3Z1F1dG9KSHE5YzBJQ2Y4WHZnTDVM?=
 =?utf-8?B?b2JXY0thMzZHY0dsM2thdUJBa3o0NnhUNjBuTGg5WmdhWHltSWNTWCtlK3Qv?=
 =?utf-8?B?VGxYVUNZUlR6MW1RTUNDbFZHNVpwK2E2ak9yUGxGZVhncUFCZ1QyZk11bVlm?=
 =?utf-8?B?MnB6M29VOWZNNlVDRVNkLzJlOHJ3Vk5uNEEyeExrOFplVnRYdVoyNEsyc3hK?=
 =?utf-8?B?dk9QMFZvVUQ0ek5DWDB0VzdjYnZCZmcrcnZtc2g3d2FKNXU1cjd1aGFEcFVZ?=
 =?utf-8?B?b1huZHZ1blE2ZElFWGFZWjBmRHNtYjQxNEcxM09TRlIyZmVzeVBKQ1NLQnJy?=
 =?utf-8?B?TjFtSEVCWHdZbThCTURXQWg3M2hwUWM3VWRSd1VFUTRCVkFJaWNDSTJQZDhu?=
 =?utf-8?B?YWwxTmhWNm9sU0l3NmFYWXF6bS96RklCeXZsM3EzNkxqajA4OXBkLzZtazFy?=
 =?utf-8?B?UnFWRGVsVmNmL3daWVJSRnIxOVpRTU9QVTVNVzg4YlBHN2FxcjJBeW1hZXla?=
 =?utf-8?B?cjY2Z2hvM2hsTmNEbm1ITVg4TVUycUpBM1B2QnpyNEI0SXRSczVDTGJNQ3BK?=
 =?utf-8?B?TDNPbFJlQk1rSHJwZmNabHBad3F3ekxuT0dKSnVHMXFmU1lwZWlKeEVWdFJ1?=
 =?utf-8?B?d1NwYVk5UGtNYnBPOXdFbjFVMXJuUEJSSnJzaUtjNlpVVzFKcUE2TlprTlVs?=
 =?utf-8?B?TG5meHB6UVNRMWpGbGNRWFovVFZxZE0zd1lXYmdKOGMvZ2RXWmZHd05RMEtl?=
 =?utf-8?B?cTJTNW51bkVOUVZuNk4xNkNrWGV2Znkzay8yNEJIaU9EK0FhYVpiYU4zQXl6?=
 =?utf-8?B?cm1JZWpOZSsvNURaVU5rdkNMY3BmTG1FRFFEZUNWdXFEb1h0Qko5Q3owY3BC?=
 =?utf-8?Q?ewuWJmCBwC/z94h301Mjj5A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e48d5f4-803a-43d3-55ad-08d9f1c45fc9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 03:19:57.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzseDkpyIYOlV3lm7oG4c342noOa8B/QhNYtUocmKjnb+22NoCTdGJMz60Bogk3EIUdGniEC84FLrabH1YLDsg==
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
> Currently we have a zap_mapping pointer maintained in zap_details, when it is
> specified we only want to zap the pages that has the same mapping with what the
> caller has specified.
> 
> But what we want to do is actually simpler: we want to skip zapping
> private (COW-ed) pages in some cases.  We can refer to unmap_mapping_pages()
> callers where we could have passed in different even_cows values.  The other
> user is unmap_mapping_folio() where we always want to skip private pages.
> 
> According to Hugh, we used a mapping pointer for historical reason, as
> explained here:
> 
>   https://lore.kernel.org/lkml/391aa58d-ce84-9d4-d68d-d98a9c533255@google.com/
> 
> Quoting partly from Hugh:
> 
>   Which raises the question again of why I did not just use a boolean flag
>   there originally: aah, I think I've found why.  In those days there was a
>   horrible "optimization", for better performance on some benchmark I guess,
>   which when you read from /dev/zero into a private mapping, would map the zero
>   page there (look up read_zero_pagealigned() and zeromap_page_range() if you
>   dare).  So there was another category of page to be skipped along with the
>   anon COWs, and I didn't want multiple tests in the zap loop, so checking
>   check_mapping against page->mapping did both.  I think nowadays you could do
>   it by checking for PageAnon page (or genuine swap entry) instead.
> 
> This patch replaced the zap_details.zap_mapping pointer into the even_cows
> boolean, then we check it against PageAnon.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 14d8428ff4db..ffa8c7dfe9ad 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1309,8 +1309,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
> -	struct address_space *zap_mapping;	/* Check page->mapping if set */
>  	struct folio *single_folio;	/* Locked folio to be unmapped */
> +	bool even_cows;			/* Zap COWed private pages too? */
>  };
>  
>  /* Whether we should zap all COWed (private) pages too */
> @@ -1321,13 +1321,10 @@ static inline bool should_zap_cows(struct zap_details *details)
>  		return true;
>  
>  	/* Or, we zap COWed pages only if the caller wants to */
> -	return !details->zap_mapping;
> +	return details->even_cows;
>  }
>  
> -/*
> - * We set details->zap_mapping when we want to unmap shared but keep private
> - * pages. Return true if we should zap this page, false otherwise.
> - */
> +/* Decides whether we should zap this page with the page pointer specified */
>  static inline bool should_zap_page(struct zap_details *details, struct page *page)
>  {
>  	/* If we can make a decision without *page.. */
> @@ -1338,7 +1335,8 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
>  	if (!page)
>  		return true;
>  
> -	return details->zap_mapping == page_rmapping(page);
> +	/* Otherwise we should only zap non-anon pages */
> +	return !PageAnon(page);
>  }
>  
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> @@ -3403,7 +3401,7 @@ void unmap_mapping_folio(struct folio *folio)
>  	first_index = folio->index;
>  	last_index = folio->index + folio_nr_pages(folio) - 1;
>  
> -	details.zap_mapping = mapping;
> +	details.even_cows = false;
>  	details.single_folio = folio;
>  
>  	i_mmap_lock_write(mapping);
> @@ -3432,7 +3430,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  	pgoff_t	first_index = start;
>  	pgoff_t	last_index = start + nr - 1;
>  
> -	details.zap_mapping = even_cows ? NULL : mapping;
> +	details.even_cows = even_cows;
>  	if (last_index < first_index)
>  		last_index = ULONG_MAX;
>  

