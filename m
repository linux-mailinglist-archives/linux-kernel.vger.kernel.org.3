Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEB55C48A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiF0Mwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiF0Mwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:52:32 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88963B09
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:52:31 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RBXZwD004675;
        Mon, 27 Jun 2022 05:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=El0L3LzTl2fyHEtOsLqV0pZIJwdYapXdV8QBHbJa2+k=;
 b=Q8zKuGINMN/uUfp392QUN5RcEmzY0UBnBaK6oRd79micYyfnpmByRLzOU3XgwM8gJGZI
 nOyQYzHzFmod/dq2nqY8DnHDLOOxiuuPf2COm/SI/G/v6UXDha0o1KjFvEViGwALpUvx
 APISv0wtXGz1DzejUOwK11sz+tS1/SZPTEKkCawG8nhgsS+afeQJr5Nb1CJXOdPE2ei0
 G8bM3XxH6f9ZwB1+7b4JamaeX7cxGIG+IjsHHofcum9sp8fLXtUP+5vHInUTn6z9j562
 csCokHzX8ijppIXmREgoazzKr2kRxVERju2NUcyvLWteDGh+lEnKyLbBMBgN/mjsPtBt KA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1wybfc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuFnEXhFc995u1vQpq0RVnn2r0nP9o1QvtVG89haw7mO18xcALwQ10+4xr/+JIz7I5ajYk2HuaFk3t2uMUqfDFPavq3zhySXl2hEmxRU7EJIQXL1QGZ/ZGWbbj+3Q2gblMWO8cRYE587CKe+5rPbq1eqNMExfYRrk58YvFrWD4wEMBB3gay14HF2UeJPaetX6xkD9g5kcDZCOSltxDk09q13XC+i3ItvE+eBzJnl/jQ6XDaNpjiYhRD9k563pY0fofuXVUAVvXIWX1R0jHi/m/urod42E3EmIOf71vRqpomAcfH2cJkZ13jbXFq7bSAbpcw0GbYTbLacMcjL8BnCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El0L3LzTl2fyHEtOsLqV0pZIJwdYapXdV8QBHbJa2+k=;
 b=CMUChVE4E1yZ0A6YlDoTVw3yW0OyaVmDN4tAL51Gogv9QkFEhUq/iHsJndEuSAT2dGSs8Jo7KWqvzqtMzeJml1tj2jD5H1yLc8zw9APqLfGDUWatpesyK0SgbUBU240qcd4heWysa80puIjMt7U8pIzU5tc8O2yVK3+a/WjwLPcrY9Lj7adJZyAKMsV0tvI0pGGJMypQKK1+LgMkV4EEiuF2nxPm+uF7/WSwXiuidipyLitCHs8B21qybPUbHUQWPr2GXLKDge3s0hPtjkduYuejfVD7XOIfbsxYz8Er8kPsRGo0tQbzaT/sXDOm6N88pCWOER/BplLXs9YL4It6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM6PR02MB6185.namprd02.prod.outlook.com (2603:10b6:5:1f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 12:52:20 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:52:20 +0000
Message-ID: <ef93aae8-ad15-9332-7871-4020b126760a@nutanix.com>
Date:   Mon, 27 Jun 2022 18:22:03 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 08/26] hugetlb: add hugetlb_free_range to free PT
 structures
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
 <20220624173656.2033256-9-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-9-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0096.ausprd01.prod.outlook.com
 (2603:10c6:10:111::11) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd8531b7-e2da-419e-771a-08da583bdf54
X-MS-TrafficTypeDiagnostic: DM6PR02MB6185:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voHtTdZ24XW4LG0NsYMYrXK8N2SbDla9xqflPS4/El+JCBZXnFrYfRxKelLg7m2OtafhAXzSyYAEjcKlEcWfcofSv/kKgnmKlfYMHXUEaQaXCtm+TwNRXn//80ZdTe19mngkhAFKsO0Y7RX+mlSsfH5u9j6/uxhFZAFfDf8HLNLFjlrptEecumRG+pNjnf65DZKkLBEnYEgOqpVzyORPUWKoICk7isUVEBrpZp6HSf0cK6qlSeDMwT3tujX478qqW+8tjEA/StuupK+mIgLyuGxKDoLmgxW13WVs8mb7aCYW4368WedSqXF2SPBHT/QhO/eI6m2u7ITLmp5ohE4g0LAUVv4hTP/uZ9S0meohdlXvU91wN8jhn6d7Gcyf1MtnQ1RuwuPti9lxb1NAigWDHRJxIwf+AhMdhcYuXFOn9qy+jGFCjf+NXBbqzsf6AhVYfk+OYLF00nJxS3DEryIfxwwPx0y21wI2zaEpxitcT2aB2CIkOJVzBSiYePCMb8TBEOiRwINcbcr4YUIKMnTcl9ToJEl3ypFlL46C08S+gCJOuDM6q/jD3YLIAaZ7RENLF1Vt5PqQGKUk+KDeDqiiH1g0wh3SYWDWCa487fKfsc7xYflnQ3Sbg89Z8gHavZBoN5BDKB6AvbjkxOHSMQlFPEtSzRXturNCPZmFB0OaClkHiVKbsqUL5Itw2MjprHSLL8BPJHlE9u/deThLtYvimm1Pc7msfedzfpmMEcRnDwMdXe6Fqjmg+J1JqdC3PN+DVV3u+SO+6ER5S+KK/HHh3oC7d+YX9TVk2o2cL9hgbQ91fb1B2FjJqF+G1g/obHwM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(39860400002)(376002)(396003)(2906002)(31696002)(6512007)(54906003)(26005)(83380400001)(86362001)(110136005)(66476007)(53546011)(8936002)(6486002)(478600001)(2616005)(31686004)(4326008)(186003)(66946007)(6506007)(7416002)(41300700001)(6666004)(36756003)(8676002)(38100700002)(316002)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdlS1ZqNlpOQlRwRmtlbWR1MDBiN2pWUnQ1RVJwUElQUzRWdng0NHBucE5E?=
 =?utf-8?B?SFRQKy8rNmlNeG5VVnN4RU40UFZyaUgybnVmOG84dmZxWkFlRXV5ZWsySFcv?=
 =?utf-8?B?NHBwbElCaUZJS0M3MjM5SlBQUlV2UDB1K1J3UEFIWCtTNTBpMjF0M3ZDbWJa?=
 =?utf-8?B?d3RKYW5Ic1VLT1BXTGhiZHAxNW5pK0ZnM0cxc29kMnpwdjYxZTdLNDJVUFkz?=
 =?utf-8?B?VDF0emdYUk9YSEVjd2JSbVQ4c0EzR3djZ3duYlNqT0JzbFBoaDBDcldBd0FG?=
 =?utf-8?B?OUtTeHV1YWxaajBCWjBkM3ZNOXhpQkJEMDFadnl1WEo5QVMvbCtUZCtUM0Rt?=
 =?utf-8?B?RVg3RGpScFh4MEpsQ25ZNUtjQ1Jub1lVWVJSSUQraGZuZ1lrTmZzYTR0cDBv?=
 =?utf-8?B?NlhIRVVQSEF4QktlSlB2Q1hoSjByZWN5UFV4dVAyT2s3K3ZoNHMrZytkaTA0?=
 =?utf-8?B?Q1ZBbVZhRjVnK1pMWkNtVjdJSmdOVkRtRlpCbHdUdUtLbUFMMHFJWTlRYzdV?=
 =?utf-8?B?a0lIcXI1OUwyWTdmbmpNcllmbkhRN0NrbUEzRmIzODhJU2tUNlcxVHdSY3o5?=
 =?utf-8?B?Mk02R1F6RlA5RktGOFBPdVQ3RkdDLzVOcXY1V1o0WGJKN2FCWm04Q3RvV01i?=
 =?utf-8?B?MGdHc0JnUWdZWXVXUFFOZm5LZkk4amtXRUtxamxJazM5dlpycDV2UElIYTMv?=
 =?utf-8?B?SGFTbU5Dd2laNTBEWUY1NDdJWVU4SWhFOWNxRGx0WmZ6Q1VFOENDN0Z4alJI?=
 =?utf-8?B?ZCt5YXJjWDRhM3ZBU3F4QUJLbi9QaEFuZ2EwY1ZYc3NIYUNCemtNQytxK2pH?=
 =?utf-8?B?M2RXaXBkYnE1NWZ2ajhMTFBqNUp6RExkQjg2MVl2R29uL0thUjdxTHNhQ2dH?=
 =?utf-8?B?b2ZaMGpMcmhTWExlczRrU2VvS3M5SWptZG5IaFBBMVJwczl1N0YyUWUxTlB5?=
 =?utf-8?B?VWwvNGdPYTRTaEZJOTRudmp6cnJzeFdudWpRRjlITzY4dy9VOW1wZGRuNm42?=
 =?utf-8?B?bzIvZlMvMEZhbjdteStuY2p3L1QreUxYRWZtV0ZPNUVpTU5lZ244TmZ4b3F1?=
 =?utf-8?B?eTVyWVJ0ZS9HTGtNNmZSSy8reEtaZkpXaGVSVE05SnMvSGhvZVk5c0UvZXFD?=
 =?utf-8?B?YjhVai9GM0pJeUlDSnNsd3lEeTQyanM5ZHZZbVdTMlZxSmR5OW1zMlBsY0Uz?=
 =?utf-8?B?MWhnVCtmUGI5ZHo3Lzk5NWpzSlFrVVJxZkxnWlNJN1JpSkx1cVZjL1dxTm85?=
 =?utf-8?B?U3U1RksvSVY4ZTJjSjROTi9BRFJ6Nlk0aWYrclJ3WWtWRXRWRFZIcnZsUitW?=
 =?utf-8?B?a0M5NzYycExQNUVKOHNLYXJNRjRwWHFpM1l6dGptaENHdjgrME5BdUpLSnFo?=
 =?utf-8?B?enVFYnNXd3JBVml5SmpYWGlNU3JSR0JPaTY3K1lPYUJzTnNXdTcyZU9kWWNO?=
 =?utf-8?B?VkRxaWpSMnNhMnRsVjE5MjhISkxWMnF0NDZ1Y1FiNjFCNTB1NDdDanB5Y00z?=
 =?utf-8?B?VElaTE1LWVVrZ3Y0ditOWFRmdlg4SGFDZmdxcndtQ2tIQWJDV3JVY1NhMVYx?=
 =?utf-8?B?ZG1YL0xmTzZWTjh1Q3hDUWI2d1NzQXRyNVR4NHYzc1RGbGJhLytlSjJ4UEtj?=
 =?utf-8?B?aktnSjc3aVJ5bmJ4NlRQRitDeWcxa2tJZjVIazNsR2JEK0VQdmpxSVJDRUJs?=
 =?utf-8?B?Z2hIM0cxT1hoN1dVYTB1UE53c3lFUUZ2dTNGTm1oV0JjcjlUOExObDVjWEIx?=
 =?utf-8?B?NmN5Z1IvL2VNcFd1d0hMUzhMVmZXQWJmV21rTVREQ0YvelZUbkVYa3RiTlEy?=
 =?utf-8?B?RmNhYkFjUFRsUGszWmxZbU42Yzd0YTVZNTdXYWV4WlkrSzBMN3FQeTlPVWRj?=
 =?utf-8?B?cE1uMm1jMW5yVVVkOGRXVVJWTDRxaUhDMnppVDVrNjI2Z0JZUHhvRjhuRDJR?=
 =?utf-8?B?NE1kZEVTZTB1SXVuRjJWeUZkRGcrS2lYZmtHWkFhME1RZEF0NWw3TE5QMS9S?=
 =?utf-8?B?VHFXcEtuOWxQK3BYUHhrNzJ6ZUw0a2pOd0VWbTVsczB1WmhveEVMRU1UQklv?=
 =?utf-8?B?MDVlOExyZjY0N1BVY1UxbG9HbWNJeGJuQ2wyVVZzNm1jOGFiM2xjMWx3c1lM?=
 =?utf-8?B?TWQyN2FSaEhpQ2ZRbnBUSXZyMVV1d1FFK2xwSHFaSmxtSHFNMTFjQkVlRC9S?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8531b7-e2da-419e-771a-08da583bdf54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:52:20.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGHTRRvqucW2UNQFKAon6oGBGPRT0VmYv7NSsE3P81lS+j067a8PW/ZviXBbOzvZ3pNc5zd80DIWu70JxAlBInNIEEaedRrykR9I/2GYCpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6185
X-Proofpoint-ORIG-GUID: cIP_dA2jcBBkZp44cx34O88sCAPzhUdA
X-Proofpoint-GUID: cIP_dA2jcBBkZp44cx34O88sCAPzhUdA
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
> This is a helper function for freeing the bits of the page table that
> map a particular HugeTLB PTE.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/linux/hugetlb.h |  2 ++
>   mm/hugetlb.c            | 17 +++++++++++++++++
>   2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1d4ec9dfdebf..33ba48fac551 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -107,6 +107,8 @@ bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
>   pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
>   void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
>   		       unsigned long address);
> +void hugetlb_free_range(struct mmu_gather *tlb, const struct hugetlb_pte *hpte,
> +			unsigned long start, unsigned long end);
>   
>   struct hugepage_subpool {
>   	spinlock_t lock;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1a1434e29740..a2d2ffa76173 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1120,6 +1120,23 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>   	return false;
>   }
>   
> +void hugetlb_free_range(struct mmu_gather *tlb, const struct hugetlb_pte *hpte,
> +			unsigned long start, unsigned long end)
> +{
> +	unsigned long floor = start & hugetlb_pte_mask(hpte);
> +	unsigned long ceiling = floor + hugetlb_pte_size(hpte);
> +
> +	if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {

sorry again did not understand why it is >= check and not just ==, does it help

in non-x86 arches.

> +		free_p4d_range(tlb, (pgd_t *)hpte->ptep, start, end, floor, ceiling);
> +	} else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
> +		free_pud_range(tlb, (p4d_t *)hpte->ptep, start, end, floor, ceiling);
> +	} else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
> +		free_pmd_range(tlb, (pud_t *)hpte->ptep, start, end, floor, ceiling);
> +	} else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
> +		free_pte_range(tlb, (pmd_t *)hpte->ptep, start);
> +	}
> +}
> +
>   bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
>   {
>   	pgd_t pgd;
