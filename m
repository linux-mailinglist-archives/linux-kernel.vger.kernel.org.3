Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D729B55C326
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiF0M1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiF0M1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:27:16 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCFDBF53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:27:14 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R5pXV0023985;
        Mon, 27 Jun 2022 05:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=QsUGDOAcIoupWcDv0Ezvw6S/8WxRGklHu3PDDk86xL0=;
 b=sLvZCQqWo2IIbh3qpU+oX6tQ8bQpsb1weAxP1jn681cCdVraG51QsctUlbFPChrJ8Ziy
 h7ov8OQBxTOWLYGa+IEOURnaWjp5mC9W3xINJwzo9J3Yc0fXqd5H94wIP9UCx7kzaMFV
 gGU9GUevU7m92ji5lDlksT/Trr6sNpNels4O7gKC2hLeyr29Qvn10/pJcCOFaySHRzNh
 VsO9b5CqR0+/viNKJqNG12CICmjlN3y41VSDqCVRjTp48b1suhNtZXQsdLkPMOwap+mn
 2l+7RjpV3Y3sdWplkUnmqAq9WflZI6lACzyQEe+ytOjIguCYMnf0tpyuaEpL70JE7bEE iw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gwxpubn9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaIwWkrW8zdN6BpXMcZyZESUZHCuHm+K2At4bFOAnW0xMVE5TrVd+GvXOND5SLhKl9s3BO87geldi+LDkuuqv65VpP9puddZ+Xjp8mo4TX52XOT3bS+O+iL25nGmAU9CmOFw72OivQX73Ri5ArAS5rKYdJDHde0snImZO1d9MtSyK/Y7dEfSYqPaVT3nU9j0edEd+ewbNzo4FcDa9WX/xJBAv5+ULz/UdTcmvQcA6jxp3fQNH+D5cDunhhbAjNfQxAea83jx/L8NMLMkV5vT40jOrpj+UKK5mSHSITPTu+wtGUCsxM/UcaBl97IvaeL008tQrLU0kvahTAmc9tS2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsUGDOAcIoupWcDv0Ezvw6S/8WxRGklHu3PDDk86xL0=;
 b=lQRMuvGRmQeT0yHYW6EWlVMxezM9PsP+IkAb84pfATMMuaS/AJMB+063/aT1llELncuzRNkyq1de1OSJ9Oi5KlHA6B9rg01SYc3ajiNOYeGbQ9YtXsF+0D/xW5AtPuj/g9NvAidqLG7K0yWuotVANEBHqlVpwBMM2TtHLdoksclchw3WPpgoEmxu3UnGU5BJGI2HDvu6pQ06CErdLYIZYFtWVlc+5GRhQqjF3RomPYoMsOlwZXJ2qJLUlJX1RVH0ep7llru6DkJdS0jgqmIVs9GqpdSD0+dZIQHZYotJ/PJf+h1w4T9pMPeCg0gvfjmxbSy5tm6brsImMgkoS3dOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SN6PR02MB5296.namprd02.prod.outlook.com (2603:10b6:805:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 12:27:04 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:27:04 +0000
Message-ID: <cbdd91ba-bfd4-2f6d-9f9f-9cdcc8ff81a4@nutanix.com>
Date:   Mon, 27 Jun 2022 17:56:51 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-5-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0006.ausprd01.prod.outlook.com (2603:10c6:10::18)
 To PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ea0cbf-75d8-4f81-15c8-08da583857d7
X-MS-TrafficTypeDiagnostic: SN6PR02MB5296:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssxnX369HD2F0fiDltXlIaWra3d45Mlxpoly2v+MOAC4tFpfwQrB8Xjzw2C+yqkQNdA8nsSgfK/4UadT8AMIB/jJTaRAocjS8FcdZCDG94ToUoXFzO8UY1GIadWA2MQsCOQ3n6zONOcKr61lrcJognhCfNv0Z/35EYO1x1hUxtw25/kieAGGRy1XroA7/blVmeYqCf5eRCuyX/J+/CYHChEnUte31EtHBogwX3qRsg0dV2i2OVkknl3WjuTUYrJ0uvNQdyE6ThlSa4RQ+av77rk5wMm/fOcBRhVaAgL/W8NvK0fIUw7sjiVGrVOlbaC269KU+O+7m5TzLA+0Hz2C1FPTLAhp5iwe04ls2aGTWADwnr4ncDaKVejv6rl3yo5jFoImzNkMr9+LoPUSrvFHxFMl7lciQgyb20ntuyyyzzFT//WUKVXuA+/c8JRigQr3+jehv+5tiIk/01GDezJC3K10Xha31SCy6r69FBzfwto59TSeAjvGU93pBiiH9ccuSQ4RrvkivTtTfe/OgndHhlVpYv8jcZgOJx83JvsEX/MZMu4h7i6cRSMHXmb/WV/d4549/InmJSbPJWRGVksUWs2rfqzx4osFCp4RnK3/FDY7LVHRCaGnz5prozfXOlZb56QnO7msroPrxbj0ea9kKqj5PpoDL55rNLMGZdPmO2X/0ijudxj7jBdNXuwIs5+Dyzm3ChilcSlSLtvUm6ZOpgU70tbMho7D+JWN6VkIL9i3ytbNuH6YkYhnVcgg3oClBaCEjbJo9S8eB6nbGHVXI7R64MXzn62F6wuBxsEeNqaAftLY5I7LFmUbwa3+GExItFF1n+jY/Rb33sH+X0JHunS9um494/CJT32h2nB4i7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(366004)(346002)(39860400002)(2616005)(38100700002)(110136005)(36756003)(5660300002)(41300700001)(54906003)(2906002)(316002)(186003)(31686004)(6666004)(8936002)(6512007)(53546011)(8676002)(4326008)(26005)(86362001)(83380400001)(6506007)(66556008)(31696002)(66476007)(6486002)(66946007)(7416002)(478600001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRMeEZWWG5hRk13eGJGMFVFZHFLeXhVK016Nk9kR2tTZitPeWlJN2NHalVZ?=
 =?utf-8?B?M0RBOHpKL24rYXFRZS9xd21DOE5BMG1NUmdhUHFLZCtPcHdMK1MwODY0eDlm?=
 =?utf-8?B?cGc1dGFFbFNmYVFRZUM2aDFYb2RQRkhSSkliaUVSeUFJblNkT1M1YmREUEFQ?=
 =?utf-8?B?Uk5aSjQ5NDhuQXNqc2tOQ1NnTFphcGJrVi9oT09rdzhrZXVjKzBsWXdpTkxN?=
 =?utf-8?B?eCszWkNuRlF0WG5BNmU1T2R6THFaZmpZaTdCU09GUlREb3hZc1VVYWpOdVdx?=
 =?utf-8?B?c0FJNUxVc1FXWk9yZTlQNndaSlcwQVJzSURpbnd4a09pSW5jZ1pKdDdua0ZD?=
 =?utf-8?B?cVJDYk1XY3hrWU9LbmliUWZLU3pJeUsvWDdVMWdINjRVdHdRTFJhSnRlMVpv?=
 =?utf-8?B?K2JobFNDelBzNXFheitpV3UvdGVEWHZCWTFXOVlGWTg5eVpyTVl3UmdwTzE1?=
 =?utf-8?B?T1FyNVNnYUhhSlJnWko0VkhncEVLL0lkTWg5MW1UYmVJTlorYUdhOVhaVlA1?=
 =?utf-8?B?Y1pyYXkzVTBRQ1VMbHhVNDNzQkg4bUxzbGJQNmpjcFh2UG4rMU9kOUZJb3BQ?=
 =?utf-8?B?Tktjb05wYmtBMU5iVnh5bFF4aGl0cVJVTHpZWHRtUVRSbGsxcnZ3YlVPRkMy?=
 =?utf-8?B?MGNEeU5FSHllL3NndjkybjFuQ3lmNVYrQkYzTldSTm13RHVXdGpnWEJ4czdt?=
 =?utf-8?B?OHZBNEVoOHNWZjFKMGlCYWxsYjJ2QVRybzU2UnNBWDZVdFo2VWY5cVRxRmdi?=
 =?utf-8?B?SGZRWmszVjdpdDRxTFFKaHQwc3hzRHZoRGNOYU1oU1FONUVGL0JFeXE1V083?=
 =?utf-8?B?YzVFbkt5b3ROWExPcWNaRFNQNjQ4ODB1NVBSZDYwQW1zQTNBQU92NnIvUjZH?=
 =?utf-8?B?cG8yWnNJUUNvU0J4SGpSZEE4V25HMGZVN3dPZU4rbjBncjFRcmRrMmJSUmdC?=
 =?utf-8?B?T2FlUEFvdnhZMTJyNmZjZUhabktsY044QTdMeUhWMldWckdaQ202dnl3d3Y3?=
 =?utf-8?B?OEgyVTJac29CZVo2OVNFSERDd01hYUVza25uMnhWMjU4L0Z4aXp5cVBvYXdv?=
 =?utf-8?B?MlF1UWxjeWo3eEsvRFZFVnhwSmgvZm1uR1Z6N0pnbmtEQUVsTlUvOEE0NXVh?=
 =?utf-8?B?Kzc2aXhVOGkxM3Y2ZkdhbjltTGw3azM4bjFnZVY3dUpEbTlOQ3JuNnZSbm1C?=
 =?utf-8?B?anFGeGRDeDFmWFdJNVJ3VWV6Szc5WnlIMDFmWGxlcVZ0S3FNWGlFVTZXbkwv?=
 =?utf-8?B?TlYxSTdCVVlvYVMwWGpBVSs3Y1I3WWY2Nm9BUHk2ajhYaUN3QWdSUWNPcnRq?=
 =?utf-8?B?ZTNDZ1F2dVF2T0REYi95anJYM2JPelc5V2ZyMnp3T3ZhbTgwdzRFSHNKMlM1?=
 =?utf-8?B?VXRDb2RucmhWb0xVQUowVmFQNUtRSUFBQ2hkRWYyY3ByRVdmK25pSnJmYWs2?=
 =?utf-8?B?U3MxZHFrTkRuMHFRR29US3M5dEJyZVV0REtxbC9KRFkyV3MvdUNWcFlwQVdE?=
 =?utf-8?B?THo1REtTZ0JZSlcyVEMwNWJyanM0em9KWEhSKzI2aFhpbTU4d1I1L092QnhB?=
 =?utf-8?B?OEZNc0RwM0VVQjVQNGo1Q2s4Ykowa0VObXg3c3lVV1NsaHoycjJJYkZZMFUz?=
 =?utf-8?B?K1hhZE0xV0pWVmtoU1hIUlZRS1pMcUQ2Z1YzYm5KQzd5S1RWcDkrT3FNakp2?=
 =?utf-8?B?N1pKaVljbTNkYkEzQlpjNkpzQlZ5WGFZRGxXY0lOU004ZWUySkNucWdBbEM0?=
 =?utf-8?B?em0vTjhkbzFoUVBNOUdPUzFvS0Vyb1hCR01HVjd5VTRpOXA2RElTK0p6ZE5B?=
 =?utf-8?B?bWIvSnk2dGRDb3ZBTlp4Q3BYWFAzVzd1Nzh6amFUNzZKQjEvUXZQUk5hVldk?=
 =?utf-8?B?cXBQb2tVZDVpUWxVYzZSQ1NIWkJjTXdtUVZuS3Jrd3FvaXNTbVhFbDNFckQ2?=
 =?utf-8?B?NmIyS084ZUdheFU2QzZnTUFkNU16dW1Nc28zdng2bjNrNzZwMUFDNUpOVTdU?=
 =?utf-8?B?bWwwbUFrd2Z4WktyZWNlTDNic1hqSnF6Ulp5dURRa0R0RmtoTDRmaEY1VWFQ?=
 =?utf-8?B?TkN6YktxUFAxOVhtOTJGZWZ1VVNvci8vNDlyOVNUTEs2MmxuZDhvNmpHSVgr?=
 =?utf-8?B?Z0RxM2tPM0J0dFVSRWJySDBaWllBZ1JlbVh2S3JFUk5UWkFURWdISzhFNXZQ?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ea0cbf-75d8-4f81-15c8-08da583857d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:27:04.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05QwoIYg4GytSk/8BoFl4Xtc/gqFhfTFEN5yeCHC/u5lcseB5uImJ1cgDmFAD/F9BEUKzamkq91C2UGUsGINe9M/Q3hlxgX987+DgzSU2jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5296
X-Proofpoint-ORIG-GUID: lAt0UyXhOLXEoGEcRvSBMRC_gV_PF2Ac
X-Proofpoint-GUID: lAt0UyXhOLXEoGEcRvSBMRC_gV_PF2Ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/22 11:06 pm, James Houghton wrote:
> This is needed to handle PTL locking with high-granularity mapping. We
> won't always be using the PMD-level PTL even if we're using the 2M
> hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> case, we need to lock the PTL for the 4K PTE.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   arch/powerpc/mm/pgtable.c |  3 ++-
>   include/linux/hugetlb.h   | 19 ++++++++++++++-----
>   mm/hugetlb.c              |  9 +++++----
>   mm/migrate.c              |  3 ++-
>   mm/page_vma_mapped.c      |  3 ++-
>   5 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index e6166b71d36d..663d591a8f08 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -261,7 +261,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>   
>   		psize = hstate_get_psize(h);
>   #ifdef CONFIG_DEBUG_VM
> -		assert_spin_locked(huge_pte_lockptr(h, vma->vm_mm, ptep));
> +		assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),
> +						    vma->vm_mm, ptep));
>   #endif
>   
>   #else
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 498a4ae3d462..5fe1db46d8c9 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -868,12 +868,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>   	return modified_mask;
>   }
>   
> -static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> +static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
>   					   struct mm_struct *mm, pte_t *pte)
>   {
> -	if (huge_page_size(h) == PMD_SIZE)
> +	if (shift == PMD_SHIFT)
>   		return pmd_lockptr(mm, (pmd_t *) pte);
> -	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);

I may have wrong understanding here, is per pmd lock for reducing

contention, if that is the case should be take per pmd lock of

PAGE_SIZE too and page_table_lock for anything higer than PMD.

>   	return &mm->page_table_lock;
>   }
>   
> @@ -1076,7 +1075,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>   	return 0;
>   }
>   
> -static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> +static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
>   					   struct mm_struct *mm, pte_t *pte)
>   {
>   	return &mm->page_table_lock;
> @@ -1116,7 +1115,17 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
>   {
>   	spinlock_t *ptl;
>   
> -	ptl = huge_pte_lockptr(h, mm, pte);
> +	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
> +	spin_lock(ptl);
> +	return ptl;
> +}
> +
> +static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
> +					      struct mm_struct *mm, pte_t *pte)
> +{
> +	spinlock_t *ptl;
> +
> +	ptl = huge_pte_lockptr(shift, mm, pte);
>   	spin_lock(ptl);
>   	return ptl;
>   }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0eec34edf3b2..d6d0d4c03def 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4817,7 +4817,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   			continue;
>   
>   		dst_ptl = huge_pte_lock(h, dst, dst_pte);
> -		src_ptl = huge_pte_lockptr(h, src, src_pte);
> +		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
>   		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>   		entry = huge_ptep_get(src_pte);
>   		dst_entry = huge_ptep_get(dst_pte);
> @@ -4894,7 +4894,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   
>   				/* Install the new huge page if src pte stable */
>   				dst_ptl = huge_pte_lock(h, dst, dst_pte);
> -				src_ptl = huge_pte_lockptr(h, src, src_pte);
> +				src_ptl = huge_pte_lockptr(huge_page_shift(h),
> +							   src, src_pte);
>   				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>   				entry = huge_ptep_get(src_pte);
>   				if (!pte_same(src_pte_old, entry)) {
> @@ -4948,7 +4949,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>   	pte_t pte;
>   
>   	dst_ptl = huge_pte_lock(h, mm, dst_pte);
> -	src_ptl = huge_pte_lockptr(h, mm, src_pte);
> +	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
>   
>   	/*
>   	 * We don't have to worry about the ordering of src and dst ptlocks
> @@ -6024,7 +6025,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>   		page_in_pagecache = true;
>   	}
>   
> -	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
> +	ptl = huge_pte_lockptr(huge_page_shift(h), dst_mm, dst_pte);
>   	spin_lock(ptl);
>   
>   	/*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e51588e95f57..a8a960992373 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -318,7 +318,8 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>   void migration_entry_wait_huge(struct vm_area_struct *vma,
>   		struct mm_struct *mm, pte_t *pte)
>   {
> -	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
> +	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
> +					   mm, pte);
>   	__migration_entry_wait(mm, pte, ptl);
>   }
>   
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index c10f839fc410..8921dd4e41b1 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -174,7 +174,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		if (!pvmw->pte)
>   			return false;
>   
> -		pvmw->ptl = huge_pte_lockptr(hstate, mm, pvmw->pte);
> +		pvmw->ptl = huge_pte_lockptr(huge_page_shift(hstate),
> +					     mm, pvmw->pte);
>   		spin_lock(pvmw->ptl);
>   		if (!check_pte(pvmw))
>   			return not_found(pvmw);
