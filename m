Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761D8560351
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiF2Olm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiF2Oll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:41 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199F39179
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:41:40 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TA3RPn004675;
        Wed, 29 Jun 2022 07:41:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=kYEhn2BPSdE0+HLVORZYkKlWTLxlu8dPAv/u8PSKEhw=;
 b=1iFTwVHuJsNYspwt5BLsX4H3EGB8CoBwGTI9WD2XQ0RTNn0gX096zA4aK81cISNdBmwd
 PxATPoeJcb0Ij782zkAI/gQViUcZIlJ+U0A22z9MsOIV2J1A7gyIqu9j1BrKvyZti2t3
 3qx4Z0+qFbxXUfDYMpqZ9kU+QtZsfkr3KlpmgSA8X8lgVmzk8zp5Ml0y0ZP7hFeZiYG7
 pmH5hNnqC2BkK/YQ9PFdnHV8X582BiVpsaEKWDhBENo7lkB28+14vYGn7vWKXFHKbCwK
 W0ubWy4yzkHF7FmUa36pk9uDQnjXKzkEsuemlWDlMA3opwWJlf6ldt0t1rGwOQyS1cQr FQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1wygv6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 07:41:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImadbP+/R73sl5XdNcaDqo4xF/zKhVqtFhN8FV362KPiLVIOujJS60OBsy0dqr/+9BRR3WvTbE4/KMEep9wpo9GG0hhlD89rrveuOlzgZ10Y7qUn+BFXP4Cne/LqNQzUCTL6+5dIs1bQ2m6ztQWXS/4a6nlQBzpIE4cmDY0/eAihcwvHwJ7pj3WzSimZ230ylGk8aWTKUjKiqlKtx0tAAUoghU2JoIMJNn+TRi/vcFg1/gNlusmZErp8FKbDzTz9CA+KAu+/ZDpjrnMlTcbkPcp6kTSi7xiUhQ9jq4zuREgSsyCa9hN9MaCIxOom5boBKhrGxw5Of/Y4lOhKnFHOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYEhn2BPSdE0+HLVORZYkKlWTLxlu8dPAv/u8PSKEhw=;
 b=MCg4xNqriN59pGFExZhb9/7RabNAnl63SuIamyjydHTLKQ2bhIeA8NKJbT4492Yvk9+vP/XHGVQFYIgDILvfNwSyvP0f4GQW1uzMeE8hpvVT5Oj8WECzTV5fqvYpXr1kDzxBkBmLbMCzOYiSlAA6ZwCnlbLQusiWeulpJ61C095DcSjIG/mfPBxewNy7dOaxlncbufG5xOIgBz7dazfmLb1Y10DeaXFP2ZXUrzS0CVFg64VpBJ8+smpoH12IusvswFnyuzHDk9ILkNbbq+3FcX1/Phh2hvRthH73oERi7OG7EDQqWjV5z5i/cGAv/6vTaELolRWcELFBXn4770P4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CH2PR02MB7014.namprd02.prod.outlook.com (2603:10b6:610:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 14:41:29 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 14:41:29 +0000
Message-ID: <95d96d47-b72d-6089-b14f-d66fa882c16f@nutanix.com>
Date:   Wed, 29 Jun 2022 20:10:16 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 14/26] hugetlb: add HGM support for hugetlb_fault and
 hugetlb_no_page
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
 <20220624173656.2033256-15-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-15-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:a03:80::26) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05122ac4-ffc8-4bb2-c5c6-08da59dd739d
X-MS-TrafficTypeDiagnostic: CH2PR02MB7014:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VK3Hbr/rwvF4vYgNWlAS6ir0sDrOcARWrC6ENrWc4lP3RsHI5RrFJO3gRt+JjyLfvt7BDk9oPPttqLEJng0YP9Y0XfQG5yLhrflRK9IURwGQ/NOrCAHuTwvm8zgnuFTCj32oDQcvlg/4aUEoYnhNKqKZHtClmAxTnte4/rItIc8olraTKOsRIwsn0OqlLCk8txu8ajDRXta+nsDP0CHDXr/HbADF8360GVMl4dhXuNiZS7W0gyqvPbJ7knRYPk4+GvtvyU5+pKSHYKA44zpQcuyyk0k5eMmnNt8n6Od18LP0zbnsSHVcuugUkrS34yv3USHU+CKMCCc+W1+fUJg4MttNioIMU0Bwv9EMTu/h7eKw19wsMY1Fq4LvLpO/85WCzIGnxxK0OjrDbX78mFBFI3e3tfuqHNmCdMoIKEjglE5FxhHbcxkl5VVbHYf+tbWNi5e985YdKQme6nrlWh4fRIBHtslOU8sJGNHqJ0d/0ls2gZgRevoUD/cu2cyqTV8HV71rxV6CRiQw7GvaJsG+f0WjMshQNZxDAFPJSso1I6Y98kYsONfl1G7B1ctxQAj9BODoNBzH9dSTfRuEglKtuJFAo1f3RjiKMt8QwWLTk2tixk1H624wiJRy6zEgUzuyQCekno3p+qRj8hEP4yVqXbJIBDZ7j32l98tBpnW8EN+C1V1myjhulB5C/CnO8Wb5iwHNKcvWxeJbBlQyT08qObQhhU7omAaHIAF/cabJ4WsKcjQiLPWAZ6DAQ08DQSIHwn5TAWjKvDqgn9HTpGm+UaOxOqC3DT0KaWTsUWwCutZq/417xWfiMVNnXm/htdQf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(376002)(346002)(366004)(478600001)(5660300002)(66476007)(110136005)(83380400001)(31696002)(4326008)(41300700001)(7416002)(66946007)(38100700002)(26005)(6506007)(66556008)(186003)(54906003)(8676002)(316002)(6512007)(2616005)(6666004)(8936002)(2906002)(53546011)(31686004)(86362001)(6486002)(36756003)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkgxaExBUXBxcW5TOXVmVnRPcGQwa1hHS1dBTFBwU3NKMk9zRkcyQktTQkV6?=
 =?utf-8?B?L20vcWdsR2VpY1djTFcxU0xDMFNLY0JEeFh3bkR4NG9uR1YrcXFjb00za1NL?=
 =?utf-8?B?OTQ5L2lPRnRLcHdnTFFScUFRV2xnU3BpMlQvKzVHdFQ0SnBtR0hpUFFtNytO?=
 =?utf-8?B?Sy9uZ3prWWNIWGZOUDBKSGRUQUNLWHQzVVJsb0FrK3cvY3A2V0Z2T2JQM1Ex?=
 =?utf-8?B?RkNiVW41WnBobE9tUkl6VVY2S1IralNLR1dWT0E5NW1KeTlpWm5FUS9wZDI0?=
 =?utf-8?B?eHlMRWJuV2JORi9aV0lLOWYzeTI3QlVLVTVTSHIvazQrbEo1TEpLM2dzM0Qv?=
 =?utf-8?B?RnZrZzV3c2Q5dStaZ3I0a0RtVlFRRSt4NXpyVXUvNmlkZmRKdkJESU1MT1dC?=
 =?utf-8?B?aEJZSG4raVJFRkRpQmtSdUtaWHU2Y0l6Z1lFck9rNVJQb1lzNWFQWlRtbUc3?=
 =?utf-8?B?MDQwdW96bzI5T2VvZGYxSEZkbXJyK28yTUZoU3E1UXNlQlNSeFg0S0FLdnJM?=
 =?utf-8?B?dktvUFRyTEQ5UXQyZFUrWWJCT2J6MnU3Zy9sOG4weU8xa2NTekZ0ZXVrWEJW?=
 =?utf-8?B?dENpN2YzNGY5NTkycVl0bld2aVBCb3FaWFo1YWhKYUoyRUZERlJLTEtSU3Rr?=
 =?utf-8?B?bTcxdFJpdkx2U2JlTnZsQWlPUW13clBBYlgxQ1BTY2d2TU5Naytja01jZWVm?=
 =?utf-8?B?LzIwdC9GVHNSaWZVSU9mOXB3UG80Q3JVWlVMN3ZqTVByZ3VrQms0VjVhdkNi?=
 =?utf-8?B?SUFjamtBeW1DdjByWGxmcytLbnR1c3hQcCtJeVJJSFV3c3dvUkJNeDE1SVhz?=
 =?utf-8?B?cURlemRIbUtHQWI2Y1ZmWm9Ndy9HbGZNMlVvUVFEb2FXL0RGOUZXZm5WOFVZ?=
 =?utf-8?B?b0RwcXAzNEJUd2RyaW9Wc092UzllKzNvaDJ6Q2E0NW56ekt3a3QwTVZKa280?=
 =?utf-8?B?OHN6MXc0aitTSDBQSEhqakM1NEc2ektlUVp0c1lmcmVIS0RRaWo1RUxvUm1R?=
 =?utf-8?B?SFAyeHBZaFZHY1pQNGJrT2lUTWQ1MXBmNGwwb2M5MWk4Y1ZzNGV6M2FqenB2?=
 =?utf-8?B?djVJc1pra0xHTG15b0ZrWDdobmRnRE00elpDRnQyWU9zZGN4TGNXbGxJNURU?=
 =?utf-8?B?K3FucWdvcmc3anB4dnhBdGtCVlNvTWVtbWIwRC9Ha0YyVzVWMVdLdTN5VCs3?=
 =?utf-8?B?eUVoUHF5TmVobHBmSnZ0TTZSTEpheTI0ZEs3SlU4RG5sdDl4Z0N6N1h1aVVG?=
 =?utf-8?B?RWVibTZLN1IwMVM0b3ZobDhjcm1mN1lhb25jVmYwOVJERUtWMXhKUHpINVJN?=
 =?utf-8?B?K2doUTN4VTNXUWFnWUZFWTNqTVhRd05QK1dJY1BYRjJvaHF0OUw0OUdwMVlt?=
 =?utf-8?B?L3FReDE1NzRsYTBwU3ZQZkJzQWtid285TFpXWlJxdTJLdTVKTWtBMVZXK3VT?=
 =?utf-8?B?Y09oR0NjbzBOK3krTTExNDhXVmFMN3pKM1UwQW5NRW91ZTlGZVhvQmg5ZTQx?=
 =?utf-8?B?bXhIakFKTVlLTzFZUTV0bFM4RWVRZGc0TmFoNjhSSFU2akZ1RzhuY2lwTmVs?=
 =?utf-8?B?czZmWEZHd2hxc1dQSy8zV1hoS2paUWVtN0tKZElQOXdld0V1Y3FBZ3BvZ2J5?=
 =?utf-8?B?YjFFeXA2Sm5QZmxOV0FncVp3V2tJM1NwdzIxTWhGbDdBb2h1dld6aUkyOGNk?=
 =?utf-8?B?UzBaWGFBWFB4UGFYdjI0N1BNVXJ0TkZ2dGJMbCtGa0creEEreGJmaGl1TmZn?=
 =?utf-8?B?U21mdUdYTnR5QU9hREN2dm1pMWdQRSt3eEFxSklBUkF2cTE0STV2WG5Maytu?=
 =?utf-8?B?Z0FTN3VQaTVZc1gzTVM2WGNWeXBxQ2ZOMGpXcGZRWDRoeHRoQm1pb05iUDNK?=
 =?utf-8?B?eGMxU0ticVZJRnIrWFFLd3RvQjdUWHU1VFgxT1N5QjE3MWNCblFsR0g4cmZx?=
 =?utf-8?B?SGZSb3h6TFc2c1NPb0xnWnRxS0oxTVVtTWhsWUl4dlpYOCsrSXFTNWltYzBP?=
 =?utf-8?B?aVB6QktwMjd0VEFCeHBFSlVWQzJ5Y1N0dXA1MDFob2RHQWhNMVczS3hEc3lH?=
 =?utf-8?B?S2xYSlhSVE42dlBsRnppcDFaYUYrVlozYVlTTlQ0VitJVDJiMGFqbVRGUlY0?=
 =?utf-8?B?bjBkUDFWNWhiUmFzZm9yMDlNVHVVcTRpUFdpdGdPNi9GdGJ0RUxWODdPWGEr?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05122ac4-ffc8-4bb2-c5c6-08da59dd739d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 14:41:29.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3PXel/vOpH4ZemTUVFsqbV+ELJxzCyk/X3GsbQbyUZQ3XTbhfVxibpkvEI9YIlLwLN6csNeAX2Hdohvqng1f+CJ/PDX9TnG2PzKqtcwVoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7014
X-Proofpoint-ORIG-GUID: -cSSp6Ta_Cx-A7cvQn2zTcebveZuDSwW
X-Proofpoint-GUID: -cSSp6Ta_Cx-A7cvQn2zTcebveZuDSwW
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
> This CL is the first main functional HugeTLB change. Together, these
> changes allow the HugeTLB fault path to handle faults on HGM-enabled
> VMAs. The two main behaviors that can be done now:
>    1. Faults can be passed to handle_userfault. (Userspace will want to
>       use UFFD_FEATURE_REAL_ADDRESS to get the real address to know which
>       region they should be call UFFDIO_CONTINUE on later.)
>    2. Faults on pages that have been partially mapped (and userfaultfd is
>       not being used) will get mapped at the largest possible size.
>       For example, if a 1G page has been partially mapped at 2M, and we
>       fault on an unmapped 2M section, hugetlb_no_page will create a 2M
>       PMD to map the faulting address.
>
> This commit does not handle hugetlb_wp right now, and it doesn't handle
> HugeTLB page migration and swap entries.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/linux/hugetlb.h |  12 ++++
>   mm/hugetlb.c            | 121 +++++++++++++++++++++++++++++++---------
>   2 files changed, 106 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 321f5745d87f..ac4ac8fbd901 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1185,6 +1185,9 @@ enum split_mode {
>   #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
>   /* If HugeTLB high-granularity mappings are enabled for this VMA. */
>   bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> +			      struct vm_area_struct *vma, unsigned long start,
> +			      unsigned long end);
>   int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
>   				    struct mm_struct *mm,
>   				    struct vm_area_struct *vma,
> @@ -1197,6 +1200,15 @@ static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
>   {
>   	return false;
>   }
> +
> +static inline
> +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> +			      struct vm_area_struct *vma, unsigned long start,
> +			      unsigned long end)
> +{
> +		BUG();
> +}
> +
>   static inline int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
>   					   struct mm_struct *mm,
>   					   struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6e0c5fbfe32c..da30621656b8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5605,18 +5605,24 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>   static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   			struct vm_area_struct *vma,
>   			struct address_space *mapping, pgoff_t idx,
> -			unsigned long address, pte_t *ptep,
> +			unsigned long address, struct hugetlb_pte *hpte,
>   			pte_t old_pte, unsigned int flags)
>   {
>   	struct hstate *h = hstate_vma(vma);
>   	vm_fault_t ret = VM_FAULT_SIGBUS;
>   	int anon_rmap = 0;
>   	unsigned long size;
> -	struct page *page;
> +	struct page *page, *subpage;
>   	pte_t new_pte;
>   	spinlock_t *ptl;
>   	unsigned long haddr = address & huge_page_mask(h);
> +	unsigned long haddr_hgm = address & hugetlb_pte_mask(hpte);
>   	bool new_page, new_pagecache_page = false;
> +	/*
> +	 * This page is getting mapped for the first time, in which case we
> +	 * want to increment its mapcount.
> +	 */
> +	bool new_mapping = hpte->shift == huge_page_shift(h);
>   
>   	/*
>   	 * Currently, we are forced to kill the process in the event the
> @@ -5665,9 +5671,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   			 * here.  Before returning error, get ptl and make
>   			 * sure there really is no pte entry.
>   			 */
> -			ptl = huge_pte_lock(h, mm, ptep);
> +			ptl = hugetlb_pte_lock(mm, hpte);
>   			ret = 0;
> -			if (huge_pte_none(huge_ptep_get(ptep)))
> +			if (hugetlb_pte_none(hpte))
>   				ret = vmf_error(PTR_ERR(page));
>   			spin_unlock(ptl);
>   			goto out;
> @@ -5731,18 +5737,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   		vma_end_reservation(h, vma, haddr);
>   	}
>   
> -	ptl = huge_pte_lock(h, mm, ptep);
> +	ptl = hugetlb_pte_lock(mm, hpte);
>   	ret = 0;
>   	/* If pte changed from under us, retry */
> -	if (!pte_same(huge_ptep_get(ptep), old_pte))
> +	if (!pte_same(hugetlb_ptep_get(hpte), old_pte))
>   		goto backout;
>   
> -	if (anon_rmap) {
> -		ClearHPageRestoreReserve(page);
> -		hugepage_add_new_anon_rmap(page, vma, haddr);
> -	} else
> -		page_dup_file_rmap(page, true);
> -	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
> +	if (new_mapping) {
> +		/* Only increment this page's mapcount if we are mapping it
> +		 * for the first time.
> +		 */
> +		if (anon_rmap) {
> +			ClearHPageRestoreReserve(page);
> +			hugepage_add_new_anon_rmap(page, vma, haddr);
> +		} else
> +			page_dup_file_rmap(page, true);
> +	}
> +
> +	subpage = hugetlb_find_subpage(h, page, haddr_hgm);

               sorry did not understand why make_huge_pte we may be mapping just PAGE_SIZE

               too here.

> +	new_pte = make_huge_pte(vma, subpage, ((vma->vm_flags & VM_WRITE)
>   				&& (vma->vm_flags & VM_SHARED)));
>   	/*
>   	 * If this pte was previously wr-protected, keep it wr-protected even
> @@ -5750,12 +5763,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   	 */
>   	if (unlikely(pte_marker_uffd_wp(old_pte)))
>   		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
> -	set_huge_pte_at(mm, haddr, ptep, new_pte);
> +	set_huge_pte_at(mm, haddr_hgm, hpte->ptep, new_pte);
>   
> -	hugetlb_count_add(pages_per_huge_page(h), mm);
> +	hugetlb_count_add(hugetlb_pte_size(hpte) / PAGE_SIZE, mm);
>   	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
> +		BUG_ON(hugetlb_pte_size(hpte) != huge_page_size(h));
>   		/* Optimization, do the COW without a second fault */
> -		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
> +		ret = hugetlb_wp(mm, vma, address, hpte->ptep, flags, page, ptl);
>   	}
>   
>   	spin_unlock(ptl);
> @@ -5816,11 +5830,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	u32 hash;
>   	pgoff_t idx;
>   	struct page *page = NULL;
> +	struct page *subpage = NULL;
>   	struct page *pagecache_page = NULL;
>   	struct hstate *h = hstate_vma(vma);
>   	struct address_space *mapping;
>   	int need_wait_lock = 0;
>   	unsigned long haddr = address & huge_page_mask(h);
> +	unsigned long haddr_hgm;
> +	bool hgm_enabled = hugetlb_hgm_enabled(vma);
> +	struct hugetlb_pte hpte;
>   
>   	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>   	if (ptep) {
> @@ -5866,11 +5884,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	hash = hugetlb_fault_mutex_hash(mapping, idx);
>   	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>   
> -	entry = huge_ptep_get(ptep);
> +	hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h));
> +
> +	if (hgm_enabled) {
> +		ret = hugetlb_walk_to(mm, &hpte, address,
> +				      PAGE_SIZE, /*stop_at_none=*/true);
> +		if (ret) {
> +			ret = vmf_error(ret);
> +			goto out_mutex;
> +		}
> +	}
> +
> +	entry = hugetlb_ptep_get(&hpte);
>   	/* PTE markers should be handled the same way as none pte */
> -	if (huge_pte_none_mostly(entry)) {
> -		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
> -				      entry, flags);
> +	if (hugetlb_pte_none_mostly(&hpte)) {
> +		ret = hugetlb_no_page(mm, vma, mapping, idx, address, &hpte,
> +				entry, flags);
>   		goto out_mutex;
>   	}
>   
> @@ -5908,14 +5937,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   								vma, haddr);
>   	}
>   
> -	ptl = huge_pte_lock(h, mm, ptep);
> +	ptl = hugetlb_pte_lock(mm, &hpte);
>   
>   	/* Check for a racing update before calling hugetlb_wp() */
> -	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
> +	if (unlikely(!pte_same(entry, hugetlb_ptep_get(&hpte))))
>   		goto out_ptl;
>   
> +	/* haddr_hgm is the base address of the region that hpte maps. */
> +	haddr_hgm = address & hugetlb_pte_mask(&hpte);
> +
>   	/* Handle userfault-wp first, before trying to lock more pages */
> -	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
> +	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(hugetlb_ptep_get(&hpte)) &&
>   	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
>   		struct vm_fault vmf = {
>   			.vma = vma,
> @@ -5939,7 +5971,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * pagecache_page, so here we need take the former one
>   	 * when page != pagecache_page or !pagecache_page.
>   	 */
> -	page = pte_page(entry);
> +	subpage = pte_page(entry);
> +	page = compound_head(subpage);
>   	if (page != pagecache_page)
>   		if (!trylock_page(page)) {
>   			need_wait_lock = 1;
> @@ -5950,7 +5983,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>   		if (!huge_pte_write(entry)) {
> -			ret = hugetlb_wp(mm, vma, address, ptep, flags,
> +			BUG_ON(hugetlb_pte_size(&hpte) != huge_page_size(h));

is it in respect to fact that userfault_wp is not support with HGM mapping currently? Not

sure yet though how it is controlled may be next patches will have more details.

> +			ret = hugetlb_wp(mm, vma, address, hpte.ptep, flags,
>   					 pagecache_page, ptl);
>   			goto out_put_page;
>   		} else if (likely(flags & FAULT_FLAG_WRITE)) {
> @@ -5958,9 +5992,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   		}
>   	}
>   	entry = pte_mkyoung(entry);
> -	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
> +	if (huge_ptep_set_access_flags(vma, haddr_hgm, hpte.ptep, entry,
>   						flags & FAULT_FLAG_WRITE))
> -		update_mmu_cache(vma, haddr, ptep);
> +		update_mmu_cache(vma, haddr_hgm, hpte.ptep);
>   out_put_page:
>   	if (page != pagecache_page)
>   		unlock_page(page);
> @@ -6951,7 +6985,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   				pte = (pte_t *)pmd_alloc(mm, pud, addr);
>   		}
>   	}
> -	BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
> +	if (!hugetlb_hgm_enabled(vma))
> +		BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
>   
>   	return pte;
>   }
> @@ -7057,6 +7092,38 @@ static unsigned int __shift_for_hstate(struct hstate *h)
>   			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
>   			       (tmp_h)++)
>   
> +/*
> + * Allocate a HugeTLB PTE that maps as much of [start, end) as possible with a
> + * single page table entry. The allocated HugeTLB PTE is returned in hpte.
> + */

Will it be used for madvise_collapase? If so will it make sense to keep it in different patch

as this one title says just for handle_page_fault routines.

> +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> +			      struct vm_area_struct *vma, unsigned long start,
> +			      unsigned long end)
> +{
> +	struct hstate *h = hstate_vma(vma), *tmp_h;
> +	unsigned int shift;
> +	int ret;
> +
> +	for_each_hgm_shift(h, tmp_h, shift) {
> +		unsigned long sz = 1UL << shift;
> +
> +		if (!IS_ALIGNED(start, sz) || start + sz > end)
> +			continue;
> +		ret = huge_pte_alloc_high_granularity(hpte, mm, vma, start,
> +						      shift, HUGETLB_SPLIT_NONE,
> +						      /*write_locked=*/false);
> +		if (ret)
> +			return ret;
> +
> +		if (hpte->shift > shift)
> +			return -EEXIST;
> +
> +		BUG_ON(hpte->shift != shift);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>   /*
>    * Given a particular address, split the HugeTLB PTE that currently maps it
>    * so that, for the given address, the PTE that maps it is `desired_shift`.
