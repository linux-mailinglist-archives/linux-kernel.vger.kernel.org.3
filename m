Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734CF48A7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348286AbiAKGr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:47:29 -0500
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:5857
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233997AbiAKGr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:47:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4r+n4iBKcfJSNEF6P+SbanVDOoA/CoGsc21Fc4W6KEii+MNToPI+CLtYJ9IJC9SypzbwEij9OAkXZ3xjdkQPJ14AoyuFz48e3LrTfl9RWvw7uH0mNw1PQpf032DeTAzaKsxaG4KERuUNs4jEbegSWsd/eHzKoT1QzYXas8y3FAwr57wnHzhPxv/t4mEEW80dq3bFH0/8GqK+CL0HpGWopSbEmIbVzdoGfupwAx6oaivgkNJ+J4gQTNF0rZzk+TcmU0lUNLswGSmgrFcxaMEy+NZxRDGUekC4D73+NPgk4h34VyKz33Oxib8y5/LYJBIsqMI30blLQ2HPUQWeHKeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm6JdM1Bg6gPBbQaabR+kPa9wAhhvB0p8pSO/NAjBiU=;
 b=nWsITEV86ew5YkUd2bWAkjN/WH3A4x7mf1Czj71nYocjc2fILmjAG5H4yG+JNEy51SJQvPTNXi0yhI98900UU2VMVM8M14Bm70NaWEByWXjd3yXFxYMW4QGIRhJnHfw8IPEprbpLgyBGLWj2hP1I7GZpSz5fU3XISuRhr6SkV+CgNAcMWtJpLO2Bnga+lj0VLB9xnUA0YqP5IKL4tnjHN1CFdSQCAbnoTAAVimTjdK6WuXXegfodS0d/mcbVXx/rHnedJnWPwKtzTzUhFZtZjqR9TNi31U+F9oPQVISDAYbUdHNxI3k1Tlfnip647C3AKZT5wjWXCxo/GzsDi8Olow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm6JdM1Bg6gPBbQaabR+kPa9wAhhvB0p8pSO/NAjBiU=;
 b=ogf2FqGtLwY9lFuGRbvAsBnldm68A9DYWrAHyJKMesZ7eSFTLhjI40/3/IV6CpzqIn1NvegF8eGvb/vAUPzy5MW0KC6MaMzkhfkpGibsymylQ1J4QOLA8zqn9Z0TLdvHhDe/uLOFiMVANSe75HvnENZNpYkHJtINgb7CpyCZr/4I4O0H7MEKAbN+qo47K362zQi95n+XKRsjFeAsg1Tm4CFVMRa/nsu2SQ8HCkk9c7VH5y+X2IhlzPajldBrfdhQChcmmGplT6wB0jAMmXlqYlF51KlZgY85j3htJx0Z+YBjdv6ikI0uft0djwEK72FK8/WSSjo8B96pFljIlFkKUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 06:47:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 06:47:25 +0000
Message-ID: <a35eb904-aa1d-8f70-c868-8e50b791118b@nvidia.com>
Date:   Mon, 10 Jan 2022 22:47:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 18/28] hugetlb: Use try_grab_folio() instead of
 try_grab_compound_head()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-19-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-19-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3351c0-2a8e-49ae-64a5-08d9d4ce3a62
X-MS-TrafficTypeDiagnostic: BY5PR12MB4276:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42767F260747A0A04F861CC5A8519@BY5PR12MB4276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +c2zjd3wEs3yaVvZJcSEG5UDHQMHlPg/5O07ZuY+t51Om8IKBM5WOglI+eZRLNr6Drvsk6oexptyjdr27jBiGUKdG8XtDBsvcO43y5ZNre2fkjBRBK0w7lnBXEcFxytqr3buRYjdvs85gnzv6vZ89N/yLLadH2x5dpaLYdLhqDjGW1F0EtOIixTkxurV5T5AS7YwGiEP4GCGCilaHhc4ubLk6agXXSwTJYGqneX/EGqkbLu0T8LF5e7NYjfzDV6UxuN7AVNbFZHTf76XBQ7s4yDb79yvu833nZgmTzvVJaQZCh32wSA43nxn7tx5Efjq9+NyjvBOQPdQCNQ29QCBXEvlOunijVMQH9qJEM5yv6KnHnAf94XxqwyfBLA5a0wiD6tK09mTRQSmRxZAT5abmK0c1RAd8cp0sIsM8Sa5PSQ6zZzdd8qK5YXZSLnwHdBbFtWnUqd87vSDOw1FbKx31JTyHnxeYCrYNVZtMD0QjH48ZgxusjOIVOE8cG/FjQlxpmj+kWFKeFt5BoReLeMYJ7PUGnlQCtaG15pAVp6BRKtDhRkrQ01GZ8DJE7uKSvYkxTmovfhAlKL9xkc+lxab5F8TMa1pbI1mtyyUBAhyksKpYpQpEd2oHMl5w8zm1w8db1uV7MnmjT1fopzOSH8IiV3I64Ra3qz4+tjr7Q1gQQHQU0lgftL0lRAV6YWPsetCfJf9AZh9Aw/tpW+jz+Vc1qksZ0kUpwQrBWHtfzvfflsN0KzpKmHtylc80Rz093aW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6512007)(31696002)(38100700002)(26005)(2906002)(66946007)(36756003)(508600001)(53546011)(6506007)(86362001)(54906003)(316002)(31686004)(6486002)(4326008)(83380400001)(2616005)(8936002)(8676002)(66476007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnlHWFZhaUQveUd6WUlVOVFXREh2blpVMitkcUgyblYrem1PaFYvd0pTT2cz?=
 =?utf-8?B?ZGlMSkIrR1k0bklBQlNKSTdmakRud0crSlZ0WU0xbXQwNzN1Y3IxMkdBNVVx?=
 =?utf-8?B?Q2tEckJScnNVcENsNXFOYUozcEVHYndzMTJReFRPdXZHNXdUQmorZmxJOTND?=
 =?utf-8?B?VXd5SG16NjR3eG9CV0pWNWJ0cmE4TDd5QTZNT3prVTFVTWRoVXh4U29qZHR6?=
 =?utf-8?B?eERwODBUd1o1dzJRcUhCbVM2bDJOa0NjMzV2MHV4R1FMQXJOYTR6ZFA3SGZG?=
 =?utf-8?B?TWo3cmVnajEzaXlVWjh1ZXZiQVJqOGtYa1dHVEY5eDRBSWx2bU04eHcxMmdT?=
 =?utf-8?B?VGpGR3RXTEJkUVRSVHBQOXd0MkNlUHMzbXZlV1ZtbFVybS9VU2dmUzhKYWRp?=
 =?utf-8?B?YUxNQnlOWW9nYTdidnRFczcvL2o0MUFZUjdJQndRdUdCYzlkZjYxUGRESSt5?=
 =?utf-8?B?ZjM2SEtLdDI0aTdJZVRSOXdCUGQraGVCWkNZQ3Y1b3NwdHBVT0J2dUV1bTRn?=
 =?utf-8?B?YXN5MjNkdlFzbFBUNi9PcnRaQVI1M3J0ZzE1b09YYm9ZNlRTM01DMngwUmZJ?=
 =?utf-8?B?V0pkUFhJSU91dTNkMERNNDArL0tLazdGVDRsbmErK201M1cxeXBPcE1pMHI5?=
 =?utf-8?B?enhZZUhCMndSRGluZGFmMUhNR2NiaWlPU0hLbWNxVUJZZjE1cGhEbEI2cjlX?=
 =?utf-8?B?M1R4UjJndWdSSEhDWVFZbWpkSjZCdU5QTXdzWStuMUh0YVdOZWRHY2g2Uk9K?=
 =?utf-8?B?M2dXUFRHUWx4aTAxSEFiay9BQlQ4NENRU3hhbkErMnRmTkVMU21VRXNFdmhz?=
 =?utf-8?B?cGoyRUpRWHRubHprdEt5TFAzVDVmSmZFVU53NVhxSHRhNVJDanIzY1BkdlJH?=
 =?utf-8?B?cGZ1VTlDMkhBNGxiRncybnNST1VQL2k3VzAwbk9YczJFTDkvR0FJVEVGMm9p?=
 =?utf-8?B?ZUpCSGkxaEFGRG85NUluTDNBOXRkK01RZy9vUDlpMXFVUmJpSktJNkFoR3ll?=
 =?utf-8?B?amRhQTJ6UVFmc0plcUNZTXN2RW9OQzR2Q2xFYnFyc0t6TkdlRWxUODVtb0cr?=
 =?utf-8?B?bFY1bWt5RlBRYzFaVVYyS2NpQmdFSUkxTFJMM1UySmc3Y29TcVVzZnUzRVVq?=
 =?utf-8?B?b1orYjFuanhmOVpTWkNLWnJnQlRWc1dkR1lEUjlXb05mcEZ1SkMrWkMwa0xv?=
 =?utf-8?B?ODFwVVJaZXl6UkJQYXk5cjl3SHJ2djJEWmNnOHM3V1VXaGtselFoUDdkckRa?=
 =?utf-8?B?RS9ZVDlxTmdmTXl3VHpudTI4R2hTS01ZRzhJUG5sU3puMDFObDNqZVdvTjlp?=
 =?utf-8?B?T29KNHF0TzR3WFJ0MTdmQVJZS2V5Z3ZaOFR2UTNmUmszUk8vc3NzZ0ZEbDdK?=
 =?utf-8?B?TEdpYm53UVp2ZGh2RWRxQ3lwUGxCRUJYcTIyRTdZQ2xYdFp4bGJRQWYzODJ1?=
 =?utf-8?B?QXdvS0tJcGJMOUdBckFaMVp5QUN3dFBEZ3htR1ZUSDIzbWRPUXhkRnRkdTds?=
 =?utf-8?B?RFZ6V3ZhaXdDWkd5TXNDcGhsakdsaHcydlBNOXQwYW4vT2Rsa0s5R1JVZmFC?=
 =?utf-8?B?Q1p4UHQ4KzZ4cXdVcThmQjhsTThLSDJWRTAwZU5VOGl3VGZ2TUJCVGkrNFdl?=
 =?utf-8?B?MzJHcTl3ODd5ZHUrajhKbTJReHdtQVJRRko3cmdjaExJeWtlRFZWQ2V6VStn?=
 =?utf-8?B?T3BqU2YwWTIwQmppY2Z5TEZzNVRYWWo0VlZ4eXkrZjUyUlFhVzJtWE5QOXdt?=
 =?utf-8?B?YmV5dFJTQi9rUzBaekxOVGFoMGFKeTBFS01XbnIrNVBZcThNRFRCdHVURHQy?=
 =?utf-8?B?eHdPWjhlOXJXMThqd0VnUHlzclo2WVRoSXB2SmE1QWlzV0h3V1VNKy95MXdG?=
 =?utf-8?B?UUZJcnJEU3VLQmxrTXVyenhYKzJwQzFoWTYzN1NKckU1cHVKUjRiMG5FbWQ4?=
 =?utf-8?B?clB2UFJJZm4vZlE1bEhJbDJEVUpOTzRsVzN6T1BMREUreXBGVE9DUGYvYjNy?=
 =?utf-8?B?VTBwRHpsNWVEQUdLbVRRa3BRY0Q0TFRnQTlWV1J5RnVZSHV2aitrMDNtWXdm?=
 =?utf-8?B?YzdNNDQvZjMybzlQRCtlUkptbytCclNtVlpoSm80dHhzd2RFSjNTcURhb3NS?=
 =?utf-8?B?dXVhNlhLRzRxL09VZjYwbzFYTFArWTk5Nmxma0MwZW5oWGYyR3dGU2k3YjhQ?=
 =?utf-8?Q?f/Q6NG+tVtwWQx8rV1r/eaA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3351c0-2a8e-49ae-64a5-08d9d4ce3a62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 06:47:25.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vnwcVU7iS/I4OrcCr6m2YgaFfnHbE0S2/cV/w4mogcVUvuO2yRyvliA9wNfHlO0NeydMkrieZnlAlfIK/Ir+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> follow_hugetlb_page() only cares about success or failure, so it doesn't
> need to know the type of the returned pointer, only whether it's NULL
> or not.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 3 ---
>   mm/gup.c           | 2 +-
>   mm/hugetlb.c       | 7 +++----
>   3 files changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b249156f7cf1..c103c6401ecd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1195,9 +1195,6 @@ static inline void get_page(struct page *page)
>   }
>   
>   bool __must_check try_grab_page(struct page *page, unsigned int flags);
> -struct page *try_grab_compound_head(struct page *page, int refs,
> -				    unsigned int flags);
> -
>   
>   static inline __must_check bool try_get_page(struct page *page)
>   {
> diff --git a/mm/gup.c b/mm/gup.c
> index 719252fa0402..20703de2f107 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -146,7 +146,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   	return NULL;
>   }
>   
> -struct page *try_grab_compound_head(struct page *page,
> +static inline struct page *try_grab_compound_head(struct page *page,
>   		int refs, unsigned int flags)
>   {
>   	return &try_grab_folio(page, refs, flags)->page;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index abcd1785c629..ab67b13c4a71 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6072,7 +6072,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   		if (pages) {
>   			/*
> -			 * try_grab_compound_head() should always succeed here,
> +			 * try_grab_folio() should always succeed here,
>   			 * because: a) we hold the ptl lock, and b) we've just
>   			 * checked that the huge page is present in the page
>   			 * tables. If the huge page is present, then the tail
> @@ -6081,9 +6081,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			 * any way. So this page must be available at this
>   			 * point, unless the page refcount overflowed:
>   			 */
> -			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i],
> -								 refs,
> -								 flags))) {
> +			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
> +							 flags))) {
>   				spin_unlock(ptl);
>   				remainder = 0;
>   				err = -ENOMEM;
