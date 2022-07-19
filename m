Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C757978A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiGSKUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiGSKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:20:28 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234DB17E05
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:20:25 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8q9P1028711;
        Tue, 19 Jul 2022 03:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=epCtjCS+DkxzXOzNKBlXrw3WY+VnTk9vgpZ1dXslYMQ=;
 b=y2ZgZbQeMcfoZLbOk3/OtJpnORkRXVdWF4zfjDi9bBzj1u9f/UAwm1hd22m3oxC85nlU
 jycjM65vRvsm202oA3Ns6a5xSxyxN6ZN48ObAcCjkuh1wFjfq/6/gSYbqi74SWnr96cM
 C4AIuMBaQpSb4U2ArzPO1T/qGWGjUSlp+r1/p96uf+R5mQ75abG9XXaaW+ZQLQb14NpM
 HQiCxQgy/uRk4qzlgpzigPxjsoJRD89L8ROzI7KxAm9FrnW+IcQlEOgr7ubsr8zRJ57B
 LEcGVG/0dry0HzMrhJf0TA3lQxSn+e/3CfC7o0Qclh0ZspTgJ0GPUsgYJBw/kXDOgLvx nQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3hbvv1wq1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 03:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgFmQzYCMiR1OHwsgpXNkIpBqYBp+8ABKzPkfjzI9RPonN5LsEDP5g7mkFbAHqTjkyMTk4Uei/oppSHvEituER5gK6OZgO0xIsD+zkdvYOMg694Eb3K8ZsXIZFzV6tO6+MoTlcot51c5IvTuM1WTWstMq4jQUVOgo0fb3sW1p45lmB0hTOX7ol5DeRzqjq7+v8PcRhZYIkikAsp2khazO94QaCnyDytOeevQtBu2e5yvRWV2Yqx2lvv5g2diddX+NaXfsvxYIZmgyFDsz5Qg/YxjXsv4ilLoPcNZC4xt7/j9AmTvxWPIk8mMARG/on51h7kBOMwdu7fCq9Xt3vZsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epCtjCS+DkxzXOzNKBlXrw3WY+VnTk9vgpZ1dXslYMQ=;
 b=aG77QUgG8JSqNBCnQvCF4bYo6RBd2Pe+US6K05sJpX+iM9BzGCSb6zcOGb3Xu3FLSTxIB96AIIiJE/vS8RXCFf51LbtrceWFYhZN3HTkjejxUiM0FBP8IvEXKs5HO4bxiadcm1cowNn5EHHM95uX8xgsPVdl+MoKghS/sOajA0fV64vmzx1XaiktupD6tRtR2dSf4Q8NxbgAWS7WccvXSIFTBNssC9GyaOprJbvq6UsE3K9KHTyp8XVzCtoszAF2Ug1+mmqxw0/CtUWuVCyXODqE15GwGsItZvj6i+4FPMAlcEmRn0AfWzgeUTdDfXFkyIDdMsxvYnM6dulDCI4Kgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CY5PR02MB8943.namprd02.prod.outlook.com (2603:10b6:930:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 10:20:02 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::fcb1:6348:1169:82df]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::fcb1:6348:1169:82df%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 10:20:02 +0000
Message-ID: <22b5aa01-239d-8a06-3aaf-18bbd109ede8@nutanix.com>
Date:   Tue, 19 Jul 2022 15:49:49 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 15/26] hugetlb: make unmapping compatible with
 high-granularity mappings
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
 <20220624173656.2033256-16-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-16-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::10) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 223e2d8f-ea4e-43fa-8893-08da69703dbf
X-MS-TrafficTypeDiagnostic: CY5PR02MB8943:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +a+4gBhDmUx4Y1iFPHdkI3lvVLK1pU3F0n22UwJUM/nAKdL+9DmMfhahwizgNaJXWpKkgVfbvGXMqYaF9jOdjhP1F4dNQspR0KIw/M//mNe4tk2HuxKjkN2hoooI3NzcIYjNhiBLQfxAIfa4yriWo2UUO4N7zxP5Mzv08EF6027hnzSJQdJA6oS3fGvvlE0NDtlnH63vXNxo0R3WZsH8XxJPyeY7clixpu0e0iSG80ztbvIkM7WJfTCZIWiECHkHgLu1TAcgdSEN4wDakIriPbmeEFt8yfsv5FM6rII9+8me0RNqVsxZtCY03157gsnaJF+abn9OpmpovQrtxq0smOmsRWXnRzfpk++bQAaL7df7x2Jn9I030MpV/12sb9vXFbxZC90A+1fYx5gmf9qNdV2/p3+g0X7eNffZ9Xuf1JILbY9NMQwzCEmXSXEnU3DkqLdASdbQhIDuLP81i8bRjneAeLHc2gEtUs1tBDhbWDwI5NMmKX1rEXXQm6llBiXLLnBR4Iv2tyOnCVyqlYrIvnIOGjsd3razrQvakdgmIH1nIIJBx5AwRui/V5V+8XwZ8+nfJQrTrrGAJErDpklOo99j8TRknJKOXBbe+SU/2iLCwQAh63nlv5ASnoCm6Kw955E9ccLRilvtqf3C2NNu4fWWssJ6s29ZBeq/QsESLnHcy39G8Zn5T11PYRk96ave0UW8C/evkl4XOoLaCl1+ZgoGrlLEgvPv0P9vkGWz8HI14tK8MUEnHRIDwy1Q/Oki3oAi/B4qEoxfpoaknt80CAPPqkaa5iG5yGJT1mZdy5stNslaJmPua0KiJhA2zEWjoU3TIpTfzkxI+66hw6KxLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(66946007)(66556008)(8676002)(66476007)(4326008)(8936002)(110136005)(86362001)(54906003)(316002)(36756003)(2906002)(31686004)(31696002)(7416002)(38100700002)(6486002)(83380400001)(26005)(41300700001)(6666004)(6506007)(5660300002)(53546011)(478600001)(6512007)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmkyRElKU0tSdVp6ZmFqUEd3M0dWMjdwbjEydlZFZ3lNeDB3cXV2UVZUdzNH?=
 =?utf-8?B?Qm56bVFhcnhxWi84SWRXNWpab0tpdk05cDZqeUFyMFlJUS8rRzdtbEgzQjhs?=
 =?utf-8?B?M2ROMGh1NTZmWmxLLzZ3M0JrUk1BeDM0bW5jS1ROeU94d05Dc2l2amE1ZldE?=
 =?utf-8?B?ZUduNmxKanNXTUV5M24rc1pkSHBGTzhWb0JJN085VFRjTERiTmg3bjVvNlZZ?=
 =?utf-8?B?V3g3ODFkS0IxTUdyamE1YU9wMkVZcVBuY1ZHd1RDdEpYUTlYRFdyNWRHSXc3?=
 =?utf-8?B?L2FnakFpYytYdmx3TUE0eUhhb2xtK1BwemxERld4ZTNqR2YzdVdRaWI3dTZz?=
 =?utf-8?B?SThDK0dseHhrN3lSRDFLQkNRY1Izb0pzc1RSb21jSWJiNVB3dHAwNWlQWnFl?=
 =?utf-8?B?clNBVURIclliM0FEN1NRVElKVmtJNjU2NVdkWm4vdnJxcEtwWlRnalhLSjQv?=
 =?utf-8?B?a2JWL2NsYzBtNDBMdGMxUklHUUVlUGxFMU9KWDBOQ1dwR0czWEJoR0FvVC96?=
 =?utf-8?B?cDlaVFU0WmQzVCtuTlNWbDFPL1FMbzhpUXFXNURCdzZDWWt3NzduVUU1OThx?=
 =?utf-8?B?dDZpanBRVUQzRy9kWlZyM1J3azJpZis4b0VDaVVmRzRVbXB0U1BteDlkZXZZ?=
 =?utf-8?B?eGtqSjJSN0tTcDFxcERzUVIwa1RiZkV2STQzV3IyWkVMY0QySU1PR2JyTHZj?=
 =?utf-8?B?KzBoRE8zUXFYSVljeTdnNHJNOHgzckdtWWgwQ3ZTSUE0MDVUQm1hMEhsWCtY?=
 =?utf-8?B?dlIvRjM0N2QxSncvQTF4WG9lS2ZaalJnWkxWMlR4bmIwcXNVL01HaFYrbk9h?=
 =?utf-8?B?MTk2anpVRkxKZzFXaHU3NVNuZmZ0cFhlMTI2eDRpR3QybGRLeUR6MkpZTm41?=
 =?utf-8?B?TnFGOGJtcHltcThzcjNJbHJnRVVHNHJBd1NtZTZKYVJjd2lOU0p0YWw1MTU4?=
 =?utf-8?B?ZkJUbHBVOFhqYkJCWUllSEcrcGtDWFh1ckgvVnM5MkZFR000U0M1NmZVWEZB?=
 =?utf-8?B?akNiamN6V0psTUNUNFFnWlNlOURhZnFncGp0NzlRa2JnZW01bWkvOTVqVmVx?=
 =?utf-8?B?aG1IQkp0SHErNDNkQVR1Y1QrUnVMZzBOOHNhTnJjam5tQmtraTRaTkt5S0pH?=
 =?utf-8?B?YU5OblBLQmZpVlJxQTh3c1h5amxsbkdldUpsK29rRDlBMmZuaTJNeHgvdHJG?=
 =?utf-8?B?OUVQWHEvd2tNZHBIeHNpTURyZWVCSVZ6N3lGeloxOXYyNzYrUVR3WTdvNjJZ?=
 =?utf-8?B?Wm53YVg2M2FROW9BQk1sdmVKNHU3TkZDR3FvdEtKZVpaU3FJRXpyUDNiR2c2?=
 =?utf-8?B?QkgrU1pSSHpoQjhiWTB3Z2kwSG12WjlVd0NoUnNvM2IwdVNYSTNIcERVM0M1?=
 =?utf-8?B?N2JmZTNRYkgrd1kzMHdYS0ZEbVZMZ3lDeSsycTlQQjRBaXluUFczdUVmWkU5?=
 =?utf-8?B?ZmduRnc3OWhZaW9tRlRCc2Z1dXJSUVVHMlUvVTFETTZyWGUzOUZ6emUzUTFz?=
 =?utf-8?B?ZkpiYzlKSUtSWnRTWm5mU0lNUUNIVG1xUjRBcFFkZTVpbGhQczJROFVpNnZX?=
 =?utf-8?B?OGVleElld1llNGZzQUpDTHl2RDdUd091L0N6c1AwOWRHaC82c2k4bmtJeFU2?=
 =?utf-8?B?RmhhR2NWaDQ2dm9wVWxQdjVsY3JKTG1CVUFieGx1MkxMdENhUkM1dmNIc2xv?=
 =?utf-8?B?ZGRlZlJoUkRXZ0FheUpjRkxkMk42NmtUYyt5Vk9lWVd2TGhhenRidnJlUlBM?=
 =?utf-8?B?N1dhS21VV01DK1V5Rk9wSkdxcnQvN0M0ams5K1g4ZFVPTklnZk43SWhiZU9s?=
 =?utf-8?B?SEFOdjJRaG1lek9MbDVHRGI5elNlMWw0d1REdGdmak05ZDFzN1RRS0I3YmN4?=
 =?utf-8?B?NzUwK2w1MTlSaEtxUEU2Qm5jemJ3VEIreWJuc0FSZXBoZm1CUCtvRGhpR2Vh?=
 =?utf-8?B?a1huQ3B3Snc3alJZZTZwV1NsWkdHUUZxbkhmN1VIZXhlU3cxeTFRWU5WWXJn?=
 =?utf-8?B?UUNKNHJwNU1hd1VFdHdmaE1SS2M2Y0YxcG42cW94U0ZnWE1NQllMSTdCV1Bw?=
 =?utf-8?B?anRlcVh1bENpb3NqeTRDc3FQQW0rdVoyTFBUTkJnNS9JcmEyeGZEcnE2ZzB5?=
 =?utf-8?B?aU1VLzFPQ2k0R2xiMUllUEJ5clRkNVJhVDF3akh5dnV3dExSWTRLRXpneGN6?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e2d8f-ea4e-43fa-8893-08da69703dbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 10:20:02.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrP5cqHw+nAkSOf4EdrzaJEj6ujLLMafUA7rKyLDyW4dH8GYoWEf2nnVq86PUx0U4LfMKRAISODJHUSZOUB91dflQaXw+5AyhsljGyN+QQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8943
X-Proofpoint-ORIG-GUID: bCOp1DBC6OVIqcmRG9bOFi5a9beYpTHF
X-Proofpoint-GUID: bCOp1DBC6OVIqcmRG9bOFi5a9beYpTHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/22 11:06 pm, James Houghton wrote:
> This enlightens __unmap_hugepage_range to deal with high-granularity
> mappings. This doesn't change its API; it still must be called with
> hugepage alignment, but it will correctly unmap hugepages that have been
> mapped at high granularity.
>
> Analogous to the mapcount rules introduced by hugetlb_no_page, we only
> drop mapcount in this case if we are unmapping an entire hugepage in one
> operation. This is the case when a VMA is destroyed.
>
> Eventually, functionality here can be expanded to allow users to call
> MADV_DONTNEED on PAGE_SIZE-aligned sections of a hugepage, but that is
> not done here.

Sorry i may have misunderstood something here, but allowing something like

MADV_DONTNEED on PAGE_SIZE in hugetlbfs can cause fragmentation

in hugetlbfs pool which kind of looks opposite of prupose of hugetlbfs?

>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/asm-generic/tlb.h |  6 +--
>   mm/hugetlb.c              | 85 ++++++++++++++++++++++++++-------------
>   2 files changed, 59 insertions(+), 32 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index ff3e82553a76..8daa3ae460d9 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -562,9 +562,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>   		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>   	} while (0)
>   
> -#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
> +#define tlb_remove_huge_tlb_entry(tlb, hpte, address)	\
>   	do {							\
> -		unsigned long _sz = huge_page_size(h);		\
> +		unsigned long _sz = hugetlb_pte_size(&hpte);	\
>   		if (_sz >= P4D_SIZE)				\
>   			tlb_flush_p4d_range(tlb, address, _sz);	\
>   		else if (_sz >= PUD_SIZE)			\
> @@ -573,7 +573,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>   			tlb_flush_pmd_range(tlb, address, _sz);	\
>   		else						\
>   			tlb_flush_pte_range(tlb, address, _sz);	\
> -		__tlb_remove_tlb_entry(tlb, ptep, address);	\
> +		__tlb_remove_tlb_entry(tlb, hpte.ptep, address);\
>   	} while (0)
>   
>   /**
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da30621656b8..51fc1d3f122f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5120,24 +5120,20 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   {
>   	struct mm_struct *mm = vma->vm_mm;
>   	unsigned long address;
> -	pte_t *ptep;
> +	struct hugetlb_pte hpte;
>   	pte_t pte;
>   	spinlock_t *ptl;
> -	struct page *page;
> +	struct page *hpage, *subpage;
>   	struct hstate *h = hstate_vma(vma);
>   	unsigned long sz = huge_page_size(h);
>   	struct mmu_notifier_range range;
>   	bool force_flush = false;
> +	bool hgm_enabled = hugetlb_hgm_enabled(vma);
>   
>   	WARN_ON(!is_vm_hugetlb_page(vma));
>   	BUG_ON(start & ~huge_page_mask(h));
>   	BUG_ON(end & ~huge_page_mask(h));
>   
> -	/*
> -	 * This is a hugetlb vma, all the pte entries should point
> -	 * to huge page.
> -	 */
> -	tlb_change_page_size(tlb, sz);
>   	tlb_start_vma(tlb, vma);
>   
>   	/*
> @@ -5148,25 +5144,43 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
>   	mmu_notifier_invalidate_range_start(&range);
>   	address = start;
> -	for (; address < end; address += sz) {
> -		ptep = huge_pte_offset(mm, address, sz);
> -		if (!ptep)
> +
> +	while (address < end) {
> +		pte_t *ptep = huge_pte_offset(mm, address, sz);
> +
> +		if (!ptep) {
> +			address += sz;
>   			continue;
> +		}
> +		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h));
> +		if (hgm_enabled) {
> +			int ret = huge_pte_alloc_high_granularity(
> +					&hpte, mm, vma, address, PAGE_SHIFT,
> +					HUGETLB_SPLIT_NEVER,
> +					/*write_locked=*/true);

I see huge_pte_alloc_high_granularity with HUGETLB_SPLIT_NEVER just

do huge_tlb_walk. So is HUGETLB_SPLIT_NEVER even required, i mean

for those cases you can directly do huge_tlb_walk? I mean name

huge_pte_alloc_high_granularity confuses for those cases.

> +			/*
> +			 * We will never split anything, so this should always
> +			 * succeed.
> +			 */
> +			BUG_ON(ret);
> +		}
>   
> -		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
> +		ptl = hugetlb_pte_lock(mm, &hpte);
> +		if (!hgm_enabled && huge_pmd_unshare(
> +					mm, vma, &address, hpte.ptep)) {
>   			spin_unlock(ptl);
>   			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
>   			force_flush = true;
> -			continue;
> +			goto next_hpte;
>   		}
>   
> -		pte = huge_ptep_get(ptep);
> -		if (huge_pte_none(pte)) {
> +		if (hugetlb_pte_none(&hpte)) {
>   			spin_unlock(ptl);
> -			continue;
> +			goto next_hpte;
>   		}
>   
> +		pte = hugetlb_ptep_get(&hpte);
> +
>   		/*
>   		 * Migrating hugepage or HWPoisoned hugepage is already
>   		 * unmapped and its refcount is dropped, so just clear pte here.
> @@ -5180,24 +5194,27 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   			 */
>   			if (pte_swp_uffd_wp_any(pte) &&
>   			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
> -				set_huge_pte_at(mm, address, ptep,
> +				set_huge_pte_at(mm, address, hpte.ptep,
>   						make_pte_marker(PTE_MARKER_UFFD_WP));
>   			else
> -				huge_pte_clear(mm, address, ptep, sz);
> +				huge_pte_clear(mm, address, hpte.ptep,
> +						hugetlb_pte_size(&hpte));
>   			spin_unlock(ptl);
> -			continue;
> +			goto next_hpte;
>   		}
>   
> -		page = pte_page(pte);
> +		subpage = pte_page(pte);
> +		BUG_ON(!subpage);
> +		hpage = compound_head(subpage);
>   		/*
>   		 * If a reference page is supplied, it is because a specific
>   		 * page is being unmapped, not a range. Ensure the page we
>   		 * are about to unmap is the actual page of interest.
>   		 */
>   		if (ref_page) {
> -			if (page != ref_page) {
> +			if (hpage != ref_page) {
>   				spin_unlock(ptl);
> -				continue;
> +				goto next_hpte;
>   			}
>   			/*
>   			 * Mark the VMA as having unmapped its page so that
> @@ -5207,25 +5224,35 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>   			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
>   		}
>   
> -		pte = huge_ptep_get_and_clear(mm, address, ptep);
> -		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
> +		pte = huge_ptep_get_and_clear(mm, address, hpte.ptep);
> +		tlb_change_page_size(tlb, hugetlb_pte_size(&hpte));
> +		tlb_remove_huge_tlb_entry(tlb, hpte, address);
>   		if (huge_pte_dirty(pte))
> -			set_page_dirty(page);
> +			set_page_dirty(hpage);
>   		/* Leave a uffd-wp pte marker if needed */
>   		if (huge_pte_uffd_wp(pte) &&
>   		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
> -			set_huge_pte_at(mm, address, ptep,
> +			set_huge_pte_at(mm, address, hpte.ptep,
>   					make_pte_marker(PTE_MARKER_UFFD_WP));
> -		hugetlb_count_sub(pages_per_huge_page(h), mm);
> -		page_remove_rmap(page, vma, true);
> +
> +		hugetlb_count_sub(hugetlb_pte_size(&hpte)/PAGE_SIZE, mm);
> +
> +		/*
> +		 * If we are unmapping the entire page, remove it from the
> +		 * rmap.
> +		 */
> +		if (IS_ALIGNED(address, sz) && address + sz <= end)
> +			page_remove_rmap(hpage, vma, true);
>   
>   		spin_unlock(ptl);
> -		tlb_remove_page_size(tlb, page, huge_page_size(h));
> +		tlb_remove_page_size(tlb, subpage, hugetlb_pte_size(&hpte));
>   		/*
>   		 * Bail out after unmapping reference page if supplied
>   		 */
>   		if (ref_page)
>   			break;
> +next_hpte:
> +		address += hugetlb_pte_size(&hpte);
>   	}
>   	mmu_notifier_invalidate_range_end(&range);
>   	tlb_end_vma(tlb, vma);
