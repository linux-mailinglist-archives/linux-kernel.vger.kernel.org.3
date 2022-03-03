Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68424CB353
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiCCA02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiCCA00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:26:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42054161E;
        Wed,  2 Mar 2022 16:25:41 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Lx3MQ009332;
        Thu, 3 Mar 2022 00:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gsxtuzFp+zYVHrlYkSYwJr4rd6nqKm/j4BzsrIYprcw=;
 b=0GT2yTqYuSzJ80CdLacVQKcraeXraISlqYI7MM7z+LPsDWbWJgJsbV4ps1biLiDrk9Xa
 j75jclif+lvg7h6h8sFVWPrDvzHv2F8yxLXAZTAosdMKObfmofYrLb67/hoNrIkqnLEv
 Z8XEkVZQRqb//rKA1BUqTCvakuBreL5Bwd6aMbRRNwkRs+KyiSw3NIN6oI4WI8q8Z4j9
 KPMJanMdPvydTq5VNqZWbEn4/OhVSQoRSXtjsS9Szccfal46W7DezbQQ0yXIIPTYW4NM
 qR/nybudBZluXn/wWM3vmdKBvgfgTIiwadkefCwD16RxC29/TtfKsvpW2uGCakslT1T5 qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9dyx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 00:25:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2230FPMl155960;
        Thu, 3 Mar 2022 00:25:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3efdnratj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 00:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGbB+HW3vlYLacdSXNwR4cHHIFlXW+ol9GQZtCOv5IfVCyErJ5TkYIWcFNqyscxDjhDfR9ZCIzzeGv3TLnf2TlNi4ZDZiNx3JClUvaC/c8l1u6BP14yiMNel6AXNmnFeJ0s3d8rUqt1twkWQ0jvrgST5V6Kkb1QBpLScpkzEgK8onLVAOZKHPSi6vgkJQS/8pXrHf5qP1ZOSgcIetUHLBZl2YV9mwpaYocok2N4r6CeTsrsQZJRd0U4GbBEubod6N5r6nYbbzxNO7i7wFjWiBuFmrHMFt6BEDfvXQAHin+xx05IqO7D8FzAKJA/0LwdHDltHv6Y1W2noRawYctcXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsxtuzFp+zYVHrlYkSYwJr4rd6nqKm/j4BzsrIYprcw=;
 b=e+e7jBN8Gpq4PZ9jPevcpofhOUixfE7H801qZnq/564JWQ2egqEqpw7q2TNPjZ7NcVsVnYqoO3DsPKN+vxywTAyZzzjGoMIlHMJg0KB2usCdJiZqBKQqaqYWKmqKknI0RJ25g+MAMrkBZc3b4wYfLPe2Ekzfde44ud47hE37VBx6f50c/n97ytRyT/Myj95T3Uh3ozdaVru39YTT9FcADo1oMrwzAbBy9AntrRUobRHVQ9rrV2FRHWWC/B+1sJisWugRJiqfTIeCC1R1aoW5o0py0RgjCoiy1wWvjDObzI9Ynj28Ib2gNT0R6+W40XOnPBH9W5VH6rDgdvpGKaxCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsxtuzFp+zYVHrlYkSYwJr4rd6nqKm/j4BzsrIYprcw=;
 b=UqkktSVEZrOJnX+WlBFDyB9+CKgHVOjSWgGorlIgxda7/hCgv/k+u5ifFLVJYuaISoX+XCHTVIPPk9FXk/jwe8ds2j/NSQZdp8JYzQQL4oqavQBNimAIQB5bMTqPrjRUA2G8djjXl5hdldlnPU4/Lp9AUJpid1sAS1NgaD7Af1w=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR1001MB2265.namprd10.prod.outlook.com (2603:10b6:4:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 00:25:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 00:25:29 +0000
Message-ID: <e0ecfbdf-2d9e-4e2e-f538-fab115eaf4da@oracle.com>
Date:   Wed, 2 Mar 2022 16:25:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] mm: hugetlb: disable freeing vmemmap pages when
 struct page crosses page boundaries
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220302083758.32528-1-songmuchun@bytedance.com>
 <20220302083758.32528-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220302083758.32528-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:300:93::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15279707-a7d0-4f74-3773-08d9fcac51f2
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2265:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2265F95025448B1013C7CF42E2049@DM5PR1001MB2265.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSFoMx6kid3kAKbLTSE/PegNdM8i+l+djFEnnJXHSK9NQ3vR/yUgUGloK9AJFUQfvAcWBiBGXM2QNl/WnJSrHa5rIs1PZJd8uA1MWBwy04EcMpA4cXklu7AqJ8NnCz+rKYWDPu/Lw+iQWayTa5/ZOsr6AYqXEGVuFuHBxYrVx/p1J0EdKMf7qjT6xGA8W9a2dSJMgZP85CBCD4o0XuVdwhwz5HKNQzd6Z316nV/473A4W8Z/tDaDxiqQwGS4Tpo+IIpQPyn80hqbCcY6GEwjj66pJG0bb4Ue0HY3vsQYcfAWSwgbSMF9a0aX1wcRADKWJqXw0WWlVAYQ6WvInJf73Rw9SKRw0jHt79YNMzpUJiicqpgZIEuwrsvVPBldHI19c/8Ay9WZMAd7uhBj0P1ScVoHqicZOTaW42awoi2D7jMMpd+X8z2ABj20wMC6Lkjol+M5wkAyODptZEJj1pR6GR3TA/sL2hu3kVUy5kYX5U9y1p9FnXiJzOVQ1ygh/wNcpBP8IGnOZ+UO+LqAPno3tt3OqpTCUXGO/eeeaXvCoIIpantbHGulwytlunPGqed1U6v1OnSUqgEG6E8gFHCyrqz6v/27yf8JBVi+tdiivO3HIJkoHqFoRfSqEFMlx90fUGa2C/ghVfIOeJl7IQV/LbHQRtf/KMviY0tsx9cxWlopNwY0yZNYsNsmVzva0kOzUCLe4uGnhn0zQZWJmXoP+NjyyA6z7qZh2HGLnmIzDsX37PY0h/lZHyqPvqrsZGc2PMrJYnJwM+7GGUmhuRuhgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8676002)(44832011)(36756003)(38350700002)(508600001)(6486002)(31686004)(4326008)(38100700002)(2906002)(7416002)(8936002)(66476007)(66946007)(66556008)(83380400001)(2616005)(316002)(31696002)(6506007)(6666004)(6512007)(86362001)(52116002)(53546011)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FUdU0zOU4zRGE4S251UTVIUk5nUXlwdE1UYld4U053OElEMUV2Ti9oREQy?=
 =?utf-8?B?VURwQ3hXNE5yc0FLeGw5c0xVOS9kRWIwdG8vMEtRTnduZi9aMkF6VmQxcFhs?=
 =?utf-8?B?YjlpcFFCcjhkWlhldU9QWWlWUllBcjN2cTJjVnNxSUpjMXpaUU5GQkdCeVZT?=
 =?utf-8?B?WUtwV3dqd3ErRGorV0FvaDg0NWtPbWF5eTNhb2dUNWxuTHBSakNma1BzQXpj?=
 =?utf-8?B?dkIweXNtUHBhYzFPWTU4WlZVSWhvd1FLTDRKY05LcThSOEx5SjFacVNrdWsy?=
 =?utf-8?B?OFhXeW5ramthMEh6T1lFV2o2dEtNYlY3UkIyL0dQeCtRc2xodWVFbnUrK1Jx?=
 =?utf-8?B?Ulpmb3FLeWxxK3RXSkpVeTVPdG5abk9Sb3ZZdHZ0a253SUlDN0hHQWQveEtz?=
 =?utf-8?B?SFhCVVlpaS9qcmpYRituSFV5YW5mbWtzQXIwM3JZQ1BnamRIbGtVSFdYRjl5?=
 =?utf-8?B?NnlqVWIzZmdIcExEa243bW1yVk13REloODJCU1FxVUdGWEhXazBPdlkwMjlT?=
 =?utf-8?B?cXY0T0lNVUw3azMyS0pSSzY3bHZRdkFnbUEzMys4NEZhQ2NBWVdyUmJUN1Jk?=
 =?utf-8?B?S1VjckYvTXVvSzRydm0waERkQXZPV2hoUEJITkFyUTN2c2h3ZnZZa0RzbUtH?=
 =?utf-8?B?MU5udUVKUUxXc0RXUGhFcU9UV0ZEOUhpNjgzNG1KV1hTeFg2dmF0dWNTb2h5?=
 =?utf-8?B?eEhOejlaOVVZM2pEWlU3UzNaWkVRUkpZUEhtOTRaamVyeWRhcTl1bUZ5UzZw?=
 =?utf-8?B?U2cyU0Qxa1ljaDhzL3RWVWdkcTI1WlFmaWtrbUVXZVk4aEVVV00xbVZ6WXNQ?=
 =?utf-8?B?b1UrNFpVdUgwamhDNXlPL1crOEIyWTZHdkNEb0k3a3BvMG5vbnNNdkx5ZE5V?=
 =?utf-8?B?bzRYZzNlZ3B1M3ZJcTYwUmEwVmJjYTdYb25lNkhIRDBEL2E2Vm1PRjRYRVBB?=
 =?utf-8?B?d01lcTFuRDFFN0kxNjJkR1F0ai9rOGJCWFRidzlramZVbDhGUnE5SU5xTVFx?=
 =?utf-8?B?TGtndkV5WFhxMW44endPQ0ttWWtaejhsN21yQW50eUZyREZqT0pFT0xhR1pQ?=
 =?utf-8?B?SmpNSG81OGpZbEp0WXE2NUR6cDMwR0FBMnpJNk5WSU0xdmNlcWxvRS9WdWla?=
 =?utf-8?B?YmJETFJPUnVtblhFN3lndVYvQWhnOTlJRjNUclU1eS9CaHh1eWFzeDhKK1JH?=
 =?utf-8?B?UUpvNEhnaFNLMlJQcDZiQVVBall2Vmo5bVUxUHNQcTRHT0dGSWh2TGp4Qnl0?=
 =?utf-8?B?NlVvbGY0aWJrd1g4N1J6OHJoaXVVLzBrcHJmMW9mRjZ4VWtsbi9VK2V2NU1G?=
 =?utf-8?B?QzB0VWpQS2NFYVNZcGwvYSttejRIaVBzZjdPT3RFWEZWZWpETHFCeWtNU1Vx?=
 =?utf-8?B?TWFwN3ZRYVRGUnRHK2tGbGM2RnBlQ096SUE3b2Q4ZzBza3A4NGxjR29ITVdm?=
 =?utf-8?B?OUFGUlVmZkhiTURLalBZdDBnTmRGRjhWRjE0NXZhaThzc0ZhWjRjYjIzYjJC?=
 =?utf-8?B?dmVKMlJ4dVJhS2hObTJQMTZoNGxXb2szQUIrWTlENGNuVUxDRzFoM3N1cjM3?=
 =?utf-8?B?Y1NIVUNnUURxOEZXaXc1TDFrSzNaS2xmZFZkNWoycGdkaW5PK1NSMEtLa1lM?=
 =?utf-8?B?NzBSZmcydy9rUnI5TlM5Q1o3WTdBWWhFTzdObi9GelVteTcweWYxNm9LTG9O?=
 =?utf-8?B?VGNaYko1c0xiRGxHSEhMSitVek5xRlJHNjhrN084dmc1bEZRSWJScnJpN3VX?=
 =?utf-8?B?TWFaUHNDdXhuK2xhZlViMUZhUWdOak9MRkhWclR0MnJHWnlpNG5zNU0vQUpD?=
 =?utf-8?B?SEtCWC90R1RNdTRPWC8yMHpXTTN0YUphSU03VCtEMW5DR3ZFVmlRMGVhU3hy?=
 =?utf-8?B?bFZxZUNRRzBaUXJzd3VXMTYwR1pGbm1CZjVQZHVBUllXSUVnQ2Y5QnZxdGwr?=
 =?utf-8?B?UkdFRjQwTzRuRDc4enAzSytZOWtJWlJ0OTQ1MGhQU2pHR1YxUmZWMXExcmFD?=
 =?utf-8?B?UStKSWl6dmI5eG1TaGZCTHF3VWhXV3N3eDFUdHJ4ZzRlbE93RVRCY1E4Z2hH?=
 =?utf-8?B?V0ljd21xU1h4b1JGZVRiK0Y3c2lXVElGQnhwTlFtSC8xZE5iWGdkQkxUVkNE?=
 =?utf-8?B?RFRZNzRIVk0wSWtGQTJiY0V1dnZ6ckRjTnEyMFFmcGlENXBSdDIzNExMRWdD?=
 =?utf-8?Q?MgGGODs0UGIUwRdlWhc6OgY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15279707-a7d0-4f74-3773-08d9fcac51f2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 00:25:29.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp0Hx4xV68saUGPDOALxbeirzU4jJ54vjJN/izlAtGqaE5XdmYDNIoXWZq09CPFvI7/X9kJJuiT+2ZVuEBwJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2265
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030000
X-Proofpoint-GUID: jrJia7rU9kEPbmxZvpEKzFkD7iclYLap
X-Proofpoint-ORIG-GUID: jrJia7rU9kEPbmxZvpEKzFkD7iclYLap
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 00:37, Muchun Song wrote:
> If CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is enabled and the size
> of "struct page" is not power of two, we cannot optimize vmemmap pages
> of HugeTLB pages. We should disable this feature in this case.

I'll let you reply to the question from Luis, but IIUC there is no issue
today as "struct page" is certainly a power of two.  This is more future
looking.  Correct?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index b3118dba0518..836d1117f08b 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -121,6 +121,17 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	if (!hugetlb_free_vmemmap_enabled())
>  		return;
>  
> +	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON) &&
> +	    !is_power_of_2(sizeof(struct page))) {
> +		/*
> +		 * The hugetlb_free_vmemmap_enabled_key can be enabled when
> +		 * CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON. It should
> +		 * be disabled if "struct page" crosses page boundaries.
> +		 */
> +		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);

Should we possibly print a warning here as in the routine early_hugetlb_free_vmemmap_param?  This is called once per hstate, so
perhaps pr_warn_once.

-- 
Mike Kravetz

> +		return;
> +	}
> +
>  	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
>  	/*
>  	 * The head page is not to be freed to buddy allocator, the other tail


