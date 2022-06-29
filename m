Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609056021E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiF2OLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiF2OLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:11:46 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932562E08E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:11:45 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TA3RLP004675;
        Wed, 29 Jun 2022 07:11:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=SLzZZzt+2h4Tk/etBdl35PVPiGNVUh5CuQOsJMqafME=;
 b=fwcxVMPqWED3XaJttKfchgDrRyNELXToRvqJl7uo7euuc+7zTwqSjMFg5N4xsK2yRWEz
 21x172rfg85IvB9YOPj9MM0BJcpmnvXiIrsWlFwFIFdyEFWnp1DG/ZvFJgCyDhPV7293
 R1MozaVSbrmjJOu3yWchq1pSiE/8NfOPpwX+tKEPMEvu/wg6mu79+J8Sk5JFT46hPJJI
 904uLo6nLE0tX1a+914BPG1R0d/c1W81mKSuTgeaqDqWjZM1SDihtBi//SBojH6Ffseg
 FrrT9CPIMyM9l5C1xqwjS+hTYdPcEYhV2RY38OPj2odV1ZN4Hjrt516QRB6dOC6E3JUH kw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1wygtce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 07:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REA5flunuKuftzUNdqDK4OoaB/k9bWJ9Ieh9mq5+PAj8tPjerR+lWABKdfTJMGWwWMcXMDgCYEZMmuL1CENFJNZ01kWbDzOK5AUnYa5piQrnCLhpOL3QlT1aclSdt5M1MMxDupsjK1V019T8VCW4Z1yWYWfupeLzIbS8Xd65Hc37LulQ4Tx97Pf2lwOkWUyWQWLC+wYXwn051JlN/1i8TKHqL8Lw+Yp1KmymhqKzr5O9HdzhoxRKrbOrMOYc8HS4cA+0xMY+DRSqTH6CBzSbxygTICbv6Yibu2qR9QxAOZ+njt1HkXcsAY+PsivytI61NI2bBSZkKyNDTvYpUD0Cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLzZZzt+2h4Tk/etBdl35PVPiGNVUh5CuQOsJMqafME=;
 b=APbUEjRP8XSYOpRUu6tCcHD0cHKY50YHd/1Cwvz5Jy6ydocPB+a3w2WfzFGrsmzz+ToNXbTmbcWA53oNZh18VJDEZrK1hDyyOyM9reYphMKsWyddTRJchrxvAoxU1r2cSXuyuxHyUb6YFV2dwYNmuaWBnZlbBvbnuyHs9XKcAhBmdQSOQFid2yA5EdBHul1Hce+QkPbZEzalKHKq1ZN512seqpF4khimbH6iaMq0JdbakGzedSrQV2/3f7e69Wu/Kjcsszys4y4TcBOqpFIeoejvgqbjbKBdmye4pB7qHTs9jiK6OssVGCySqBO9osceSAqrjqmJiFG6h8Va/UELgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BYAPR02MB5319.namprd02.prod.outlook.com (2603:10b6:a03:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 29 Jun
 2022 14:11:31 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 14:11:31 +0000
Message-ID: <e585a4c2-53e2-8a70-e61b-2a1c0bd6f441@nutanix.com>
Date:   Wed, 29 Jun 2022 19:41:22 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 13/26] hugetlb: add huge_pte_alloc_high_granularity
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
 <20220624173656.2033256-14-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-14-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e75e08-f403-41c1-b35d-08da59d94444
X-MS-TrafficTypeDiagnostic: BYAPR02MB5319:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CF04Efvz7jB+EvSsH5RGY6GD05jwrki+jTxWTX3aCB9ppfRkRA18OYid74vRhQ8X6ZoQG955MlIeS1Hi8GEUqCkeqRMPHZH3oaNoSXWidXsebEvipUbZkIc3Zp1RnSGJQZJOAq9r4pl2QsXZszdnPRLO4oe9TGlOOoAz3kyz0Cc2QqyQCML45Mik9n2iCSNMFJe8ljlWnoZRXtSgjWM2CFNuFhGoWLAUqcIqYpHDRkD5L257SyBVsLmBH4KY63ci9QTrJ+1Q6tkpTxjUvybem9nqvb38nM2rX+mf3KBBWKiUVRJFF2lmzq7NPrlYenangIdVSE+Mt9V3ricZUBLK2YgBlpaEObIwZr5MSBcjNgKpZ7d09l5lqnl3tisk7R+OBjfFiQ8IQtaZMVL7ieOayJy3ygluF1WyPoFYdmjZLYV5PFSVXcYaiFUIAmS79cypLkjxOgbvLZAyEOoeJi1D7Yefw5aIean8868EJAUQurDkoK4xlFkPq1ocqa/b3HCFkWZyFp8PYBBA5leTdqazRAYFtAV1eqY/9He/y3Tmcd9+T6v7S9I6lhsBCjpa1PU73acZUuvjr03+dxl6aNTRNE8xqc/zVqXIkPQjYX9gdEeyo5e3NKOJmjxAspDClKmhIlFVqwL/P9E+C1htMGAbgyzmVcoLGbydmK7mOTs72hAUayDLdDY9dP1qqKLxf27TiXvqoWMFpuYzQ0vo9AuMN/AlcSDUCs0LvsojcdbSpEFqmIUmKHnwpR6FibcbMngFgI/+Uk9+9kBk05jEnJUVsujTMNcjfo7O1zDcRtAbcAyBg2q/pig3e1hnAOGZvcQHpgzYd8K+X0nEd8dk6AdSSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(39860400002)(376002)(136003)(26005)(316002)(31696002)(478600001)(66556008)(186003)(7416002)(8676002)(38100700002)(54906003)(110136005)(6512007)(4326008)(86362001)(66946007)(66476007)(5660300002)(2906002)(6666004)(2616005)(6506007)(53546011)(8936002)(41300700001)(6486002)(83380400001)(36756003)(31686004)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpoeDcwNE9reEpSZDJyUERLakFMcUw0M0VTUDA4WW1HNmZvV0dQYlpRVytI?=
 =?utf-8?B?L01UZjhnaE4zSkh2RGNXcW02YUs4ZEVFYm8wM09pd0x6bHA0eEVweitpQmNU?=
 =?utf-8?B?YmpNY3pqVnc0V1JEWHo0cFh4V2lTK3lEaE9DTUgxaEduZWRua3BIK0RFdU0r?=
 =?utf-8?B?emRsd2ZVTG9pQmVhYnEzeGdoZzFJVlFhRFdOMTlBY3kvQW5RdmdJQ1o1aGdq?=
 =?utf-8?B?MSttZGthNnNBbWVGL3c3UVpQN25XOUJDa2QwYW5YUjJMNWUxUHNjNnh4SEFi?=
 =?utf-8?B?ZkVZVkJCYUR2Vk9GSk1uMzl6a2RLbmV1cHh5dGUvL3BGSkNNbU5oL2QrUDBL?=
 =?utf-8?B?VFJjT3ozYmpTdEQ3YUJSVXJROHZXQlFnZG1mbkx5cWdyZkl5OFl4Lyt0cXhz?=
 =?utf-8?B?Rnc0SkNhakdjVFExZzVnNWZPUzlEcDUxY1paaUtzV2lDRHRPdndjTDE2VG5S?=
 =?utf-8?B?eE1ZWUhXQnJyTjhvajhEbVovc2pseC9CeHk3OUZaNzNFaVRiUWtBTEJ2Q1Y3?=
 =?utf-8?B?cmZLT09VQmkvL1JydHlXbkdRRmdDTEFyQi9hUXM0enE4MVRVQzN0Z1o3cWI1?=
 =?utf-8?B?NmdCaFBuQ3Z3MEhhM1psR2xFbE9mWmtYbW1UM2E4SS9ydE5sZXZuNmlnakph?=
 =?utf-8?B?Z0ovRnRRUVNQRi9PaGxIOStUZWpjUHBEd3lleXdPWjVtUlFldVQ4cTlQSURj?=
 =?utf-8?B?WTVrSnB5VHV1OW9mc1dhWk1maDRQVGJVY01DdWJDdHNudm1xTDQrbmtTblA1?=
 =?utf-8?B?dXFYeTJJWUhjS1BYS2hBM3RZeVEraHpweHc4R0ZlVGdUV0VHdjN3ZGFFYnpz?=
 =?utf-8?B?Z3diWVVpRzNTOGd5ZFlOVXVJcEoyQlpRVi9Vc2RFOGJ2dm9hK254enVGcnFt?=
 =?utf-8?B?cVZIOEM2ZU9nQ2lkeEJON2pJZUNsaEpJQlNOcjRELzVGKzB0c24wbWt0UW5t?=
 =?utf-8?B?QXA5TXVhajZ5WHYxV1J0UVU0ZE4zL2U2TnVOYzBBNW5WZk5vdVg0Z2x6QjFJ?=
 =?utf-8?B?Yms2NjNIR2dkZnlsNkRaV3NFbDJaZTR3K0c3cmd5Zmh4TVZkTXZkMDdQWXo2?=
 =?utf-8?B?ZGRoS0x5ZEd5eDArZTYvZ3NnSXNmeFVlTEVtcE1VZ1FIWkdFa2xoaVloRGUx?=
 =?utf-8?B?WDlqQWZZOUNGNUp4Q3VocXVneEN2bjZSamtNbE1LbkU5Ry9MSHJWVHhibkV4?=
 =?utf-8?B?YkZGb2ptWGRiU3VOZG5ORkZkNjQ4QzFjaXBmVkxnOGVkU3l5amxEMWV0M0ZU?=
 =?utf-8?B?K292OWhMdHRBRHBKemVIQUljVEJmYTg0d1d4bVdFd0pyYWZJb1NWUitvYlNq?=
 =?utf-8?B?NjB6T3UzNWxhMG91RlJVRENKMUUwUHo0Snd2VlhhMlBPcTFiQW9TcDRsZlEw?=
 =?utf-8?B?RWhRajhEbW5sTDVacFp4NS9sRmhZaWs4WkJucW1rN2lQOXB5akI3R1NOYUJx?=
 =?utf-8?B?L051UHBhU0IwZTE0Sm8ybUVnejJ6ZUFpMldGS2Y1ZW8vNTFIWk9ObXlwa3BQ?=
 =?utf-8?B?UDEzaWNnWFJrciswZ3hqZTdQV3A3T05FaHkwZTR5T3JObGlROXF2RmQzbDZi?=
 =?utf-8?B?RlFSSDZUaDZjNWtVdUlJaGZCNDc4TjJlejBzekNzWWNsaW1IU3dQSVpzaHkw?=
 =?utf-8?B?QmN0aGRHLzhpRjhCNHp4V2lQTTUyNlBhd1luM3k4MDF2RG05NEtaSmFnYk1Q?=
 =?utf-8?B?TDRTUWlPQWtjbDlVYXg4cjdnT2FYbTQ3TTN6VFB1SFEzUlN0Z0xIYnFLVWRZ?=
 =?utf-8?B?NUxNMjAwS2l2ZVpaT3dvQ1RST1htdFF0UUhDK2t0SEFrWEFkbFJQWmNxVUdE?=
 =?utf-8?B?Z1BGK3ZnM05MQmxQVVNlWVhaMldwYjU4NEZSVFFES2o1d00ySkZwai9NY2Fu?=
 =?utf-8?B?cUVNbm5zVXJXelVuUjlRd2lqSHErWGdLVVdrd3QxdVNtVWNwaGRnbHJzLzFo?=
 =?utf-8?B?M0tubzFqZTByZ2FkbnpPNkFiRExRZEVxbEdWQ24yUHE2VEFINEpNSWpVQkJW?=
 =?utf-8?B?V3lQRVBiRnpaU3FIRU5YazJvTTZJcTM5dlVUdmpoSTM2bE9PNm0wYjVwa2U4?=
 =?utf-8?B?ZjVYQS9OQmt2U0VvQ3dtek9VTFY2dERUL0dKQXFXdlhEZGJyYUt2bUVXeVd5?=
 =?utf-8?B?c01CZkZ5eDFNYkJiNFV2ZU9yZVZHRm8waFlVTDZkRVNRR2V5TzVSbmxvRzlK?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e75e08-f403-41c1-b35d-08da59d94444
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 14:11:31.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGDGIZUBMXbCSHE7AVuAubbLrQ1zasQg6gUgmguxrkV94qTxC5v6511jBrHYdAsnUCccov01bF9SLM7gyEIs1nSibU7cpbsogt6PUu0ZUug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5319
X-Proofpoint-ORIG-GUID: 8qiP4Dd9wpRyVtl46dIMShabxJt7IbsI
X-Proofpoint-GUID: 8qiP4Dd9wpRyVtl46dIMShabxJt7IbsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_17,2022-06-28_01,2022-06-22_01
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
> This function is to be used to do a HugeTLB page table walk where we may
> need to split a leaf-level huge PTE into a new page table level.
>
> Consider the case where we want to install 4K inside an empty 1G page:
> 1. We walk to the PUD and notice that it is pte_none.
> 2. We split the PUD by calling `hugetlb_split_to_shift`, creating a
>     standard PUD that points to PMDs that are all pte_none.
> 3. We continue the PT walk to find the PMD. We split it just like we
>     split the PUD.
> 4. We find the PTE and give it back to the caller.
>
> To avoid concurrent splitting operations on the same page table entry,
> we require that the mapping rwsem is held for writing while collapsing
> and for reading when doing a high-granularity PT walk.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/linux/hugetlb.h | 23 ++++++++++++++
>   mm/hugetlb.c            | 67 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 605aa19d8572..321f5745d87f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1176,14 +1176,37 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>   }
>   #endif	/* CONFIG_HUGETLB_PAGE */
>   
> +enum split_mode {
> +	HUGETLB_SPLIT_NEVER   = 0,
> +	HUGETLB_SPLIT_NONE    = 1 << 0,
> +	HUGETLB_SPLIT_PRESENT = 1 << 1,
huge
> +	HUGETLB_SPLIT_ALWAYS  = HUGETLB_SPLIT_NONE | HUGETLB_SPLIT_PRESENT,
> +};
>   #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
>   /* If HugeTLB high-granularity mappings are enabled for this VMA. */
>   bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
> +				    struct mm_struct *mm,
> +				    struct vm_area_struct *vma,
> +				    unsigned long addr,
> +				    unsigned int desired_sz,
> +				    enum split_mode mode,
> +				    bool write_locked);
>   #else
>   static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
>   {
>   	return false;
>   }
> +static inline int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
> +					   struct mm_struct *mm,
> +					   struct vm_area_struct *vma,
> +					   unsigned long addr,
> +					   unsigned int desired_sz,
> +					   enum split_mode mode,
> +					   bool write_locked)
> +{
> +	return -EINVAL;
> +}
>   #endif
>   
>   static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index eaffe7b4f67c..6e0c5fbfe32c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7166,6 +7166,73 @@ static int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *v
>   	tlb_finish_mmu(&tlb);
>   	return ret;
>   }
> +
> +/*
> + * Similar to huge_pte_alloc except that this can be used to create or walk
> + * high-granularity mappings. It will automatically split existing HugeTLB PTEs
> + * if required by @mode. The resulting HugeTLB PTE will be returned in @hpte.
> + *
> + * There are three options for @mode:
> + *  - HUGETLB_SPLIT_NEVER   - Never split.
> + *  - HUGETLB_SPLIT_NONE    - Split empty PTEs.
> + *  - HUGETLB_SPLIT_PRESENT - Split present PTEs.
> + *  - HUGETLB_SPLIT_ALWAYS  - Split both empty and present PTEs.
> + */
> +int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
> +				    struct mm_struct *mm,
> +				    struct vm_area_struct *vma,
> +				    unsigned long addr,
> +				    unsigned int desired_shift,
> +				    enum split_mode mode,
> +				    bool write_locked)
> +{
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +	bool has_write_lock = write_locked;
> +	unsigned long desired_sz = 1UL << desired_shift;
> +	int ret;
> +
> +	BUG_ON(!hpte);
> +
> +	if (has_write_lock)
> +		i_mmap_assert_write_locked(mapping);
> +	else
> +		i_mmap_assert_locked(mapping);

> +
> +retry:
> +	ret = 0;
> +	hugetlb_pte_init(hpte);
> +
> +	ret = hugetlb_walk_to(mm, hpte, addr, desired_sz,
> +			      !(mode & HUGETLB_SPLIT_NONE));

hugetlb_walk_to when called with split_non mode can change mappings?

If so should be ensure we are holding write-lock here.

> +	if (ret || hugetlb_pte_size(hpte) == desired_sz)
> +		goto out;
> +
> +	if (
> +		((mode & HUGETLB_SPLIT_NONE) && hugetlb_pte_none(hpte)) ||
> +		((mode & HUGETLB_SPLIT_PRESENT) &&
> +		  hugetlb_pte_present_leaf(hpte))
> +	   ) {
> +		if (!has_write_lock) {
> +			i_mmap_unlock_read(mapping);
Should lock upgrade be used here?
> +			i_mmap_lock_write(mapping);
> +			has_write_lock = true;
> +			goto retry;
> +		}
> +		ret = hugetlb_split_to_shift(mm, vma, hpte, addr,
> +					     desired_shift);
> +	}
> +
> +out:
> +	if (has_write_lock && !write_locked) {
> +		/* Drop the write lock. */
> +		i_mmap_unlock_write(mapping);
> +		i_mmap_lock_read(mapping);
same here lock downgrade?
> +		has_write_lock = false;
> +		goto retry;
> +	}
> +
> +	return ret;
> +}
>   #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>   
>   /*
