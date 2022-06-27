Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A555D8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiF0McY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiF0McT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:32:19 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAFABF56
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:32:18 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R6Agtt008071;
        Mon, 27 Jun 2022 05:32:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=87EhgG1eBUeNAVfQ8HUxSbLdOMnrMuECXJ83CsjoCaQ=;
 b=J5Gp3hZFjTrLvbrnVxvMXWQ540sVkI0wGMAg+fp4X1j74RikJiPqKtnrfs9qKXAAzFyG
 SdFV6Y3rkP/DmQVI1PmpugDcnccKpr4wHimaQGuzUk9TWKQNuTnRLl8LTVKZzizUNeIs
 MP5LvYKZUQklKP1vma+FD7yGNBzVkiPaaeEhwH4d8DcbnGJ1hWXliG6VH2xovIoz6rDr
 SGEn5WAGzvvcUlLVEcS+vFP1xrqjfbJBPhxBsQfQ7/vvmYctJvnC1S7OzrsPBw8bWkRb
 mKkFmH488nyMypiBtcgzbCB5CHSDSsswRbNZA7IYCoQWAR2xZExDgTjr0eg+z5sdQ3ZY gQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx0fhbjg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8bKZYakKA/jhJtvXQMm6WhzoSNaq+Uv705bJVzgnyH9PQg9W4ew87uHloBjeN3nln5PUpGVts+Q5gm6Rk1Aqn6pfQoPjRLYZV4iZgE38YNgqmfc9ISq0zadwLyFkBa1uSSQBKnHIvcNEJsDi+6UyQqgR1naRh6jgMgrgtvua+Q4xfMNQH1Rrf1RKRtnMj66h3WrE0hlWjUyjsFCb0y1ftO++SR+3MZJzWSvOPPKOtAt4f2sUa2cHZeVAufFVaBXizKBHXOj+YiTw1TKWlgfxk5byuROFgSqlyZbTKeU++KpHiy8zkkxM7IXyckNzE1/5H6/VBuraK+EmRz9s7587w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87EhgG1eBUeNAVfQ8HUxSbLdOMnrMuECXJ83CsjoCaQ=;
 b=DR3rdP+6+QqrSASZjZxsgj41OauS8rftUK51QsQRf2YrIT8ZQo0JlqqIyr1J27j4qElNlzTEJHgHwVD39z2SsTZ8OHLHwGWxy8K4fynvOtMSGW5APtqbpPnjNHPFV4Hj2oGv7kWA4QpbPkzK6y6vUtR1PeS35f9YlfavejoLwsaYnaqQ2YMA6WPVxec4Gn1X2B5r+c74W1VkpR6Z9X4+EqV/Qc3OQEe0hT7uNf6e1+LUH73LIbL8b+4AjRbzuhub7TV1GXB1slzNeYv0cRTdghSaeI5JRfcM04R2BqeQruxGfi9VP0I0t2zgYtgDimMw5BTPW0zQz3gjkiH3XIPw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM5PR02MB3735.namprd02.prod.outlook.com (2603:10b6:4:af::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 12:32:10 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:32:10 +0000
Message-ID: <81ef275e-7119-e802-3563-814a6811b857@nutanix.com>
Date:   Mon, 27 Jun 2022 18:01:56 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 06/26] mm: make free_p?d_range functions public
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
 <20220624173656.2033256-7-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-7-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0050.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::19) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc1683c-9697-4b10-52f4-08da58390e48
X-MS-TrafficTypeDiagnostic: DM5PR02MB3735:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4zst9fcL4FFo73LEK+R/v0eS6v1aJ4UKjcuyhs6sZ+ZLir3BioJSwRj9bjs2luJvyMPygOyWp0hhP9WYqXb6INy9B5SlW4JAX4U1tQST9WH7yxNjhMGmrlunrssHn49swcskDpRXo3NkqojFMnbk/uewpnWov2dQJqlYackK4he+Vr+MRF/t4ttnA1HaAesiJwskRhCO1KzCRifaVVqo+yfExswjoaqzfgZW78E54AXQ6WJDD8s41z6BjBW+H3wtN05QTSpT+M0Cu6FE75dRLhjvrtqfbMaTQwU918Me1s/Lx1B3LnctvhDKOizQoaBsklQLXnWU83ai3d6i0wXYhKRFtQc2tD0cEiSSRKzzRn+KCuZ6XR4RgKo5SjqNqtHh1LUzJbI22VF9RqvW69XzG/9HKsjUbvvDajfErD4p1ES1rSX1xYnFclrWAo8gkHkhXEOx3kA4fwzpi67HweyPp+EpFVT5xHcPFPkasxVs1cLmn9wk/TLUsh0jAMm07ejx+rvJ/GaAKgJKTvah2QP8DYvXgDyoGlgD/LklUbg+Dv8Im+UW0H9ZB1r0BraUAbNetzotYnOqhPGSJ3XIYapQdOAOoLEYcH9iC5Uqyyvybm+WSSvipnK3/KiZ+HcMb6/nvAymp9wqUzYcI6EcH3PCuzFsm/EC9NMmm2U5QnltFkACW6PE/m8fZUOjLNyDaQYTUYxLuPNGevm51JCz2WoXN1yUfeHgeJFmyTvNA/iPmfZO3sgZUckDd88lI+uVOV4hHTkrbiZv6SnJqY7YoGuSk8nOoTBbarMG5Ahc4Eu9YcAam4HowtMkPAq2cKWgWm3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(136003)(346002)(53546011)(83380400001)(186003)(41300700001)(6666004)(8676002)(54906003)(2616005)(26005)(6506007)(31696002)(6512007)(38100700002)(4326008)(110136005)(31686004)(36756003)(2906002)(5660300002)(7416002)(478600001)(66556008)(86362001)(6486002)(66476007)(8936002)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFp4dEZUaGNESC94Zk5mOG0yS1liQnc3Q2ROczJlaGJ3dE1ZMVlQSWZ1VGF0?=
 =?utf-8?B?VzgvQk0yM2drNnpycnR4dWh3V0twOVRpTXdNN0JpTzZCenYrWjVWUjliSVoz?=
 =?utf-8?B?WWZRMU5pNUtiNE95RUZSTGRPU2Qvais3b1Z6NnR4Y1F5QjRlK2d0T08wV2wx?=
 =?utf-8?B?dEsvWDY1NVJQeFNIWTdLYVNlNVAvNUxUQnZQRkVWY2FTTlo1Y2l0bzAyU3Rx?=
 =?utf-8?B?WU1lbHJYNG1MRE1pZHVEQWkvd3BwMDlmUnRHWVptR245VCtYRWp6aUdmbTds?=
 =?utf-8?B?Z2pQNTJhWGxNU0JBa09EVTFuNlMxMjhaRnRFWVhNRDZRZG9CUVdKWWJoczRh?=
 =?utf-8?B?eEx0Z05NUFVHY2ZCaExWaHVYR3IxWlB5dVU4TFl1VUdwS2YwMGRKS1o0Y084?=
 =?utf-8?B?RStWWjBvZGViSE9EKzRGQnBXVHV1UFArL29IZ0lkRFFLakdSRncvU1VCQ1px?=
 =?utf-8?B?K1RVV3VVOXpybEZtT1gvRVRLWHY3MXhoRlAxWTFoWnNGb2RuZjVNd3QzMDcr?=
 =?utf-8?B?SFpCNTUycEtDTHBzUTRJZHM2dkVwSjJVMVd1NU5DMmZpWmxOMmhVMDQwbnB4?=
 =?utf-8?B?RE4ydC9FZldyU2FpUHJQZzQ5TVU2Vnc3eHhaeWZHMXJ0VkVIN2FIcldxOXpY?=
 =?utf-8?B?MHJzTGhVU3lkVDMyQUd0MU4rMmhtYlpnNitDVjVPNGFkT09xeDlCejg5VVkw?=
 =?utf-8?B?V3BRdmd1bU5UNHNHbzlOUzZoczJRRWVpNWdPR01FU1U2YTNwVzhvL2NKVStq?=
 =?utf-8?B?bE13M3l2Yk1pRUJHM0VuQStCSXVnbUpwNEZ4Rm5tdGd4UEhFemMvcTVINkVm?=
 =?utf-8?B?V3VQU3VNM3hGRFpIcVZ0Rmt0Mm0rQy9vR09vQmI4YzFBdms3N3EwL3VHZENS?=
 =?utf-8?B?bW9ncVZzd2xBRzNTMWNUZnkyZC9tUHVMSm1nKzJGS083RUFzb2dodHhNWUUx?=
 =?utf-8?B?M2lSQnRXTEFjeXRFbmVNSW1rejVRVnpkSWtQU045Ym5CbnFEZC9DcXYvRS9m?=
 =?utf-8?B?b2R6RUdxTzArNDNWVGVWQVBlRVBSTFpBMHlOK29NNmlkeExYQm1DMDBxQkxO?=
 =?utf-8?B?MnY4SzBUMDhsYUF2VDRxdjhieXlIZ1F2RDJRZnp2NE5LRHFKcWtxZGlDZDVO?=
 =?utf-8?B?UlRGNXlQMkJKZXM5UUt2dGNSTVVPeVgwRWo0elZWSjRNUFZxTjVabFNFMVE1?=
 =?utf-8?B?d2ZsTWpYS01HL1MxYnJ2bnBQc1paOURMUCttUDB1YTNrOXhCOFFmZDVKbCtR?=
 =?utf-8?B?TitZclZXWUNhQ2EyZ2pwdUgrM3YyaXA0UWxHWWtCWDBQNHh1Rm1NTFVkcU9K?=
 =?utf-8?B?bjk0bTNDc0lKUnBEUmFmZTR6RE1kSC9xUUJiWm0xZmx0dGkzRGl3ZUpab0Q4?=
 =?utf-8?B?TXQ1Mm1TM3NVZFhSeUNWU1NGOWlIY2RpaEx0TUpsQzZvY2VoRXg1QURHSVY4?=
 =?utf-8?B?U3F1WjlMdXVtYThEM0dWNmsrSWt3Zkp1TU5Bb3g1VmZGb2ZyNXhYM1kvWUc5?=
 =?utf-8?B?dUZyUWcrY0dXYVYxR2g5ejZqMW5WVmlYNnhMY2ZSbFJydFoxY3FHNWswOGly?=
 =?utf-8?B?bXg4OWFxK29GWFEyS1hEWWhmeStTVEh0ZXVtall5amlmbmVEWXV3MDNPMkU0?=
 =?utf-8?B?Q05jWGw2TmFkbnFVdDc1OVV4eHlMNEZNOFF4L1hjbkhwc3RibzEyNmVNc2Fn?=
 =?utf-8?B?UVJqc1ovaWJZeTVkZjljR1MzSnFPV3FBeTFkNngwVU92N1VnTmxveXJRWmV1?=
 =?utf-8?B?Q0l0UEFRNXlneFFkWkc3VmxxeDU0SkVkTjRxWENGK3JFQm1PeG4waFY3TXRl?=
 =?utf-8?B?QXJUZUtrOXZWOWZsS1ppN1RpWFRFNjJBbDFuRVhqejV4Z2ZxcTZBbzRNZVJ2?=
 =?utf-8?B?Ylh6bVpYSEZaWGhOTkFxRGxCUlpNZkxWN1Y3Z3B4TEhJMUxseVZ5MC9kbnIy?=
 =?utf-8?B?NTI0R1UvWWFjRVA2VVhnMXFtRUJZNm1SajN2U3IwTVVHbjJKWGhEdUhCeUgz?=
 =?utf-8?B?RDNvZHh2aTRzU3lWakd4VUJhNEs4ZFhtTzVpcTJHMmZnMTdudFdVK3RQNVlH?=
 =?utf-8?B?akd4TWhQZExHR3hicUdWZnJjY25SUG9TckllQ1lvRWpGSThOalhlbWcxb3A2?=
 =?utf-8?B?UUhhaUVtRUhKU21rUERNc1FlNmY4Z0dyNURSb0c4RzBjQ3VSQ0hnWWRaNUhK?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc1683c-9697-4b10-52f4-08da58390e48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:32:10.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeqUyq+TaJErxy+QWzxfK95PGLkmANXD7nc4SxqzgWJyK4DSFgFXCmFqY46rXvDjPe2VwtQdIiH7UHBsbNUOi3YvGmIBuToHqjtp+7i0Uk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3735
X-Proofpoint-ORIG-GUID: dtFdZ0jIBsc5YaaNE9nZccQnBa3C3o7C
X-Proofpoint-GUID: dtFdZ0jIBsc5YaaNE9nZccQnBa3C3o7C
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
> This makes them usable for HugeTLB page table freeing operations.
> After HugeTLB high-granularity mapping, the page table for a HugeTLB VMA
> can get more complex, and these functions handle freeing page tables
> generally.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
reviewed-by: manish.mishra@nutanix.com
> ---
>   include/linux/mm.h | 7 +++++++
>   mm/memory.c        | 8 ++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..07f5da512147 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1847,6 +1847,13 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>   
>   struct mmu_notifier_range;
>   
> +void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long addr);
> +void free_pmd_range(struct mmu_gather *tlb, pud_t *pud, unsigned long addr,
> +		unsigned long end, unsigned long floor, unsigned long ceiling);
> +void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d, unsigned long addr,
> +		unsigned long end, unsigned long floor, unsigned long ceiling);
> +void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long addr,
> +		unsigned long end, unsigned long floor, unsigned long ceiling);
>   void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>   		unsigned long end, unsigned long floor, unsigned long ceiling);
>   int
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..bb3b9b5b94fb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -227,7 +227,7 @@ static void check_sync_rss_stat(struct task_struct *task)
>    * Note: this doesn't free the actual pages themselves. That
>    * has been handled earlier when unmapping all the memory regions.
>    */
> -static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> +void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>   			   unsigned long addr)
>   {
>   	pgtable_t token = pmd_pgtable(*pmd);
> @@ -236,7 +236,7 @@ static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>   	mm_dec_nr_ptes(tlb->mm);
>   }
>   
> -static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> +inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>   				unsigned long addr, unsigned long end,
>   				unsigned long floor, unsigned long ceiling)
>   {
> @@ -270,7 +270,7 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>   	mm_dec_nr_pmds(tlb->mm);
>   }
>   
> -static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> +inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>   				unsigned long addr, unsigned long end,
>   				unsigned long floor, unsigned long ceiling)
>   {
> @@ -304,7 +304,7 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>   	mm_dec_nr_puds(tlb->mm);
>   }
>   
> -static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
> +inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
>   				unsigned long addr, unsigned long end,
>   				unsigned long floor, unsigned long ceiling)
>   {
