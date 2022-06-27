Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DCB55D43D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiF0MJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiF0MJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:09:18 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73120BC39
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:09:17 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R7ji9V023679;
        Mon, 27 Jun 2022 05:09:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=w1iFXc530euwpahh2K2tqI6/8BC/olnGjpexb4LcT5A=;
 b=UnK3UA4Dw4MF0kfKXj4uOK4w67B4fcm2BElODmVD/C19GmG8YDL0ZoJ+4L7l/xLnS0Sc
 Le4CCtUputi4qZpLaJNIFtzgGkRm3v8e9AawUTYgQkIpmoGJHNeHAlMBaotiZwfZbOSJ
 ilwdhPXeEDvn8j0S42CayCkYy5tqFkQQpxihIL2DRJQUlliTGmPQUnJ5wDNpSHHnZ5h0
 Op7jFtUsLd45bJ/h4bbPepU0/i0dAs+kAR7OV9PzgzHPSAA2WPNfEgnFR6bDG9Lq9wz2
 J3TH3sCKssCtPxeRzCwATMXhF6uWHhY5BlY2bq2LsUDY/W6+yy+BcxEXGF2ml29BoO0d xA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gwx9a3neg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2BPtn7CY7qTcAlN+Vyq9h4RNXLACEI0tcr/83Z137QYXAhCTXnMGwX3jywPlEU+3sCt9Ow5F4uO0ngjJwdDoHTQt7b8y+RCSeO2WvlnuaKi/ZlZj9bMxjpf5bjSxIPsbvHsCMG/OjqWDJ2ClFm4bpl4ofdskPZAOuWrpnttMkk6fnSpIZBmryfg6cB9bWJha6ZYozV2DM77T6HbpqwqqSUBsnoqsr4ojDQKyZMFizWFz+xJsY0bb6SdbNuniQgC1u41erpCJ7zjTQjD89n020ecsiIT4sx5gg5WeC6tKejO724scyRwOX8O9pn1sZMwhT5GCC9i2gavV9JloqRd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1iFXc530euwpahh2K2tqI6/8BC/olnGjpexb4LcT5A=;
 b=GRzGibOF6fXQi8lQZUDYa5slUI/hXsxV5iqNmg0T35/wN8WL5ln/EgBGD7Yonimj4n5m3HPNF2f/LGjJXm2SBcvaKanAIk5iHzXHh4hF4KKQXhxBRavmbjZBFQHP3yUuk/eNa/jFHVjne9qiqCXNjnRyqD3GLepeGUcsX4A86WJ6nAx12L21Cew0xg4AFL3UmPveXWrc+5fFEcTx8E79j/3Sn/a9lBizEmPEGS16dV7/N3RHwO2Sv7xPCVXuLkeIdVKOX+hc9flPVIRG19mWxqvIWuDnatjLkJh+6YH/32HrKyqW2DDIFU9PBQQcv7GsziO8AKilnpL66s1ZSgmnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by MN2PR02MB6463.namprd02.prod.outlook.com (2603:10b6:208:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 12:09:07 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:09:04 +0000
Message-ID: <7ec9cbbe-742a-4629-8764-90213e85ac58@nutanix.com>
Date:   Mon, 27 Jun 2022 17:38:50 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
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
 <20220624173656.2033256-3-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03cd034c-1d4a-45e6-6641-08da5835d3f5
X-MS-TrafficTypeDiagnostic: MN2PR02MB6463:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BE6BObW8KqzAooyuIvSte06+nyAgOBZ49AROg/7UNZgeKSK0R53e8c3JKbM+uE+5Hbz6Vw4nqUfbDpNirLHexSqrmuv/OD8UGA0nVaS8JqSzDLpzrfA32rIcLgasldr6rME80/XwjHfXqMgdag/SgoE9rzxBQysjfqVdnLMnVV2h7k8PQ9tMZYA8iZoTPZ7qKKvjusVqY1NtBaU7A03YBXF3HVcZKHYTxZ+UDmI44f1TieDrRMM3SNwWqUo51kzS7H/v9iRliQLJIV6eOy0QfNRPeZ/aGT1hjR8gTQV32zg2ccTIn6aPOyqv9Y8/UcD5YjCiZvrtk+vvzr3FnfaF8vX+75kloTf3QkOt4v3UyMLISDVu0apcPQTHaXDoQC6z4mw4cBgHUiH2veMu6P1jucCmmb4N+pmrwRIcIgu20UhlOOGlHCF1qjtn+ahLzmf2s4KqbgD+/niLabLR3l3Y7nCt21wW/6ZWVH01+O0CK6YDREka3DxUqrZzZYXD+J8TNdRZfz2Z0Owd/JKHvqgRTUp4QEWhI87F5iiOBDHjkkdNrQ689ZiBc5lqh9LTlrxAYagKqN1LC6jjikyjQiQdP5nEaR4UhUN4koLLifEzqcS60E6NAqlX3Ws8ahYNrvTDdnC/UXMYvCpkeH5vrlREQCiSs6dMFcQw2jMObbfAQee5SOgdG4cQGTQcMUWQSWgvjJJwQ3aOxhApFe1ZP3jchGm/zm+RMvMXtI9vukfP4gRDWqMXQD0A8cQuui/ZKpe6g1Bextok+3bFJfcLm9cWlhmANNlSFkbnWkSt/SSGxcoAa5HAQVWTcU3doaSnYyxz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(39860400002)(136003)(83380400001)(4326008)(66946007)(8676002)(31686004)(66476007)(5660300002)(186003)(53546011)(66556008)(31696002)(8936002)(38100700002)(316002)(36756003)(41300700001)(26005)(2616005)(7416002)(6512007)(6486002)(6506007)(6666004)(54906003)(2906002)(110136005)(478600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZYeStBNFhRcFRCSklJNDltMUdhZXM1UTkxK3I4Q2p0TW1VVHRCV3NCUU85?=
 =?utf-8?B?VkEvRUZKMVFwZ0xQQnNoY0JtVzMxcHNUNWhEYTlVaGZtcmV1M01WVnROTG5q?=
 =?utf-8?B?a1RRY0lvM1lTUUtra05BempOdkFUS3JLOVhzTUNmSnZDb09PU2F5KzFBZTc3?=
 =?utf-8?B?Mmk5OHNES3UrUStnMXBzeDh5S1IzUlN6UENCaCtsYXFWejNvZkJUMmhFZCsr?=
 =?utf-8?B?akZkRkUxdUgxeklBTUpmY0YzVjAxVVh0RE9xZWQ2TzVGNmZsVXpsQzZLMWVi?=
 =?utf-8?B?VmI4NGpWNU9RSkhTYTlOVy9KanN2c05jSW5NcGNNZUVGTDFRQWZPTnJOTTB0?=
 =?utf-8?B?cThoeHRaSDl2RW4xa1ZFNXVFdWQzL1RCMnlIWEdGWURCUlJHUnROWUx0aFls?=
 =?utf-8?B?REljRVNJMkd1OXkvWE9xQU5xMkN3RlRwWE9JSlR5YmpWRTRzVUxRR3VEaGRv?=
 =?utf-8?B?STZzZnN3OCtyVlAyZ3dFRjFNUUQ1MWNBaW9adTNpOTcxUk52cFV3N2hUWmtB?=
 =?utf-8?B?Y3d3TGExS3Izdm1pTkdJN2NLK3RCVW5wWWRhZzVBc3liTk16OCt2OFp0cjlx?=
 =?utf-8?B?WllRa3ZsUk5kbzZXZFVLWXBHeDRFeGFWSnFWMzhkbkxiMGRwSkV1UEpaV05N?=
 =?utf-8?B?S1I0UFp4RUFudjBTZ1lPZG4xUHlVUm5tWHMzbk1yK3NuN3g2WUpFTjVVbVV4?=
 =?utf-8?B?MWxIdGZ5YnVlNGRHVW92NkVrZkxaUittUDJMRkxLVWx3WTMzQVVWVEswb21B?=
 =?utf-8?B?Z3hQQko2S2IrTzJKRXhkbDBwSEVDN0R3RXU1VzdiaUhMV041Mi9FQmZhSlBN?=
 =?utf-8?B?MjdxQUZKa1RtVVQ2MzJtOEJ6dHRKUkEzYzViVUhNYXQvMzMydnpkdHRocXRr?=
 =?utf-8?B?d2UzUEdmZ3g4UytOL1BIQzhwTWczeVJSMW56ZldOSjJPa0FwMVA2a0hVZzJ5?=
 =?utf-8?B?TDBtVDcvcUx3SnI2dm9zaUZNQjRsVVQyMUcxU0JKTjA4TEtuVXJWOWNTbFhI?=
 =?utf-8?B?MFgvbVhIVzZMR0E0bWxCSDNJUHpnVUx4SVhrNXNPbS9QbDZMaUFRc0VLdTlP?=
 =?utf-8?B?SkJRUU1OdlhSTUlwSit4S2lmck84ajZXb0J4ZG15bjZWSXl5bzA1WUxtOCsz?=
 =?utf-8?B?bnZ0ekc2UWxvVXVGMTJuSTVPZEFuU1NPUGFEaUZGZzgvMVpZQ3l3dWExRzFY?=
 =?utf-8?B?UDFlRWlNSjdRK1pSczB4L2NDM3BBTXhNRkJ3NzhBYzNDbnRkanhlSDNxeDVT?=
 =?utf-8?B?STZXeXdDQmJTdHFNR0ZGcWdZTThtTktsalZSQ3VseUE5Q1lHNFNlM2YzclIx?=
 =?utf-8?B?YkpTakxZUGk2cGp4V1krblVianNwUnJYZlBLcE1KYlZBKzBJQmxqZ0tZTGxJ?=
 =?utf-8?B?Z3RiSHVWM05Qajd2R3ltaHJEZHlVZUxOZk85LzBZNFNOMGFwQ3RQaWpPSHZX?=
 =?utf-8?B?dWpFdFF3WERGOFJsbFZNWEJDYjRoN21JSXVqVXFDMFVaSm1Dc25ycUFQa3FX?=
 =?utf-8?B?UzhST0dJdVd1RDhQSnoxangra0gxYldWdmFUUVdJeVorVW03NGZmWjlDZllq?=
 =?utf-8?B?Y1FKTzM0d2djZldMVE5HWEF1Q0VzSUlENjJuT2NCcFFhcGZqOERzVmY2M2hj?=
 =?utf-8?B?cEdyd2lXUjMyUXRFMmVKZ1ZlYVVKaXlad2RMeUxiSmpuZEdiUjZBYzNEY0Fv?=
 =?utf-8?B?b1ZzNkdrSGRad0htSlgzemVBNTZwQjA5eEZlRDhsNWJEUi94NVNVdTVzUkxJ?=
 =?utf-8?B?ZEd4dHRQSkkvekova2JyZnJBeDEySHNETGlWNnZOSk5OS0FIWTJhaTNCSHJW?=
 =?utf-8?B?d2Rid0doU1NUdGpBc0RXeXl6MUNrWTFnZCtHSFJUYXc3MFg0Rm1VV2ZQZDVL?=
 =?utf-8?B?RTdLUXhKeG1majFxRk9zQkgvdzVHQTRlSS92cFRlR0pqVFRYOStVMlFvNElZ?=
 =?utf-8?B?NnZDWFdDR3VaR2JVdzd5NEFuVGZNK3ludndWenkxaXJkaENNQ3IvSkZsbXA2?=
 =?utf-8?B?SEN0aFNuSVZhbnhBOFlHVVlpOWFzOVZ5VGlPTytPUVpoYUw1bXAzbU9YcWZD?=
 =?utf-8?B?UEMrVG42OHZneWdLWlRmUzNVNCtWNTQwQzI2Y1VPY3NsMUdTbDFTR3p1bEw1?=
 =?utf-8?B?VWVuU3NOWldLNzBTWTlmZkxOVjhFeXdKdFhiS08vbzJmSXNpSVNUWW9wTHFK?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cd034c-1d4a-45e6-6641-08da5835d3f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:09:04.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRLpMMeEpxA6MumGTTZb1zQtVpQWjYtXbHZWiU7z93SeE+W1i79DxlYQAGlptwz/n58EBYH10vn5CBGNENl3QQSlrQgoHIw/BHzBSiHfho0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6463
X-Proofpoint-GUID: JMhufP1kMQIHAmvaqx2nIz6hYasrqWwC
X-Proofpoint-ORIG-GUID: JMhufP1kMQIHAmvaqx2nIz6hYasrqWwC
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
> When using HugeTLB high-granularity mapping, we need to go through the
> supported hugepage sizes in decreasing order so that we pick the largest
> size that works. Consider the case where we're faulting in a 1G hugepage
> for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> a PUD. By going through the sizes in decreasing order, we will find that
> PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a57e1be41401..5df838d86f32 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -33,6 +33,7 @@
>   #include <linux/migrate.h>
>   #include <linux/nospec.h>
>   #include <linux/delayacct.h>
> +#include <linux/sort.h>
>   
>   #include <asm/page.h>
>   #include <asm/pgalloc.h>
> @@ -48,6 +49,10 @@
>   
>   int hugetlb_max_hstate __read_mostly;
>   unsigned int default_hstate_idx;
> +/*
> + * After hugetlb_init_hstates is called, hstates will be sorted from largest
> + * to smallest.
> + */
>   struct hstate hstates[HUGE_MAX_HSTATE];
>   
>   #ifdef CONFIG_CMA
> @@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   	kfree(node_alloc_noretry);
>   }
>   
> +static int compare_hstates_decreasing(const void *a, const void *b)
> +{
> +	const int shift_a = huge_page_shift((const struct hstate *)a);
> +	const int shift_b = huge_page_shift((const struct hstate *)b);
> +
> +	if (shift_a < shift_b)
> +		return 1;
> +	if (shift_a > shift_b)
> +		return -1;
> +	return 0;
> +}
> +
> +static void sort_hstates(void)
> +{
> +	unsigned long default_hstate_sz = huge_page_size(&default_hstate);
> +
> +	/* Sort from largest to smallest. */
> +	sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
> +	     compare_hstates_decreasing, NULL);
> +
> +	/*
> +	 * We may have changed the location of the default hstate, so we need to
> +	 * update it.
> +	 */
> +	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
> +}
> +
>   static void __init hugetlb_init_hstates(void)
>   {
>   	struct hstate *h, *h2;
>   
> -	for_each_hstate(h) {
> -		if (minimum_order > huge_page_order(h))
> -			minimum_order = huge_page_order(h);
> +	sort_hstates();
>   
> +	/* The last hstate is now the smallest. */
> +	minimum_order = huge_page_order(&hstates[hugetlb_max_hstate - 1]);
> +
> +	for_each_hstate(h) {
>   		/* oversize hugepages were init'ed in early boot */
>   		if (!hstate_is_gigantic(h))
>   			hugetlb_hstate_alloc_pages(h);

As now hstates are ordered can code which does calculation of demot_order

can too be optimised, i mean it can be value of order of hstate at next index?


