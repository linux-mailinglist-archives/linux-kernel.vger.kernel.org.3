Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE59046B1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhLGD5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:57:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51762 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhLGD5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:57:44 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5CYQ004499;
        Tue, 7 Dec 2021 03:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/tagJWJszFGhqBn1qVI/at06cak62POKNCFvO0hZm8E=;
 b=MItyzbLQNmN5HP4sM0qByx1R4g5fMNaswZOcf6xEHG9KHDcTCVK2Gcm0UuCXefiOte93
 1q13IUjaO61qLas2qQ2MccLS8w0RApf1lNcXfY5qFXbFMvLXDMmQaXPALcXzV2tB9Jun
 XMOb+H1zEva+dl9weiZYl9QUSB3iEfMmlBONrsUKNFMNQqNPaH7rchy3NGsC7qgfwuQ2
 osSl493uGerbCRKsGQZ5UZ46OrbacMnNS9EAc1dr7SrBBH0Ej17itlEF1SgyGPNu+Js3
 D2vYL7tnEhqI7BVqZuJ485PfiZjnThk1v7m7upciD4SH6TiIJYlWINZNdeB+AqNhqN1+ hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csdfjc0gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:53:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73q4Lm119384;
        Tue, 7 Dec 2021 03:53:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170] (may be forged))
        by aserp3020.oracle.com with ESMTP id 3cr054bb51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf8JEU73BWe5/ZJDOrKNdvJL/PPfdba1Ox3DOiQyi3hbWnMrqzHI+55CAu0uLtjV3CCh+CTF/HLpAp9mYtJZfc7WHR0S+JT2RKptvnnLG6gik83ofJt7ZMei3yIwPyT7KL07aZYl6YLrbe3Aq8sdaRYyjrw1irMtqWDnFp9uFg1y4Hbv7JEIlwPg8NUXZWNtS0n4GoHNyvyWwWYIPLgW2GYkTwwy3HdA5jYDCe52Rh9FoGnR5OrnSQJ4FwN0MUhKATcye3EoP5WFJbJyU6504mWLSL0wMZLs4D8vgLPCnMTWdjESRneBOALWICGLBHYyAusDbgE2QFfGSphLJCHinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tagJWJszFGhqBn1qVI/at06cak62POKNCFvO0hZm8E=;
 b=hDd2fBSaL6tprgMWATshfEgrsk1UUA98/QfIlUqEIqDf61DKDgBDYgJyrVnJW7CuaBj2n9oJ+JvFgEE1ADusgDIJP7lI6ArMk+QUu5s9Y0yD10jPUQiTWZrcbwzhp4gxFJ7wWIGgSjoZ6BL+CwWcZEfRhrWzvvVI0kTJgKjoBs/SeF9WpUWExdI26mWHoG5P+slan+DTgZxhXhNSZdpdU878kh45qhgzwk2dTQJ8iT6+bqpVjIbntFUHX95PqDpB4DzlapbZhs98aaZDmDtebwo86RGc3JjpY+7kwAq33YsOKA3p9x1QgPkPxTzkYvki9S8tx3SXjeYeX4nHYoTrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tagJWJszFGhqBn1qVI/at06cak62POKNCFvO0hZm8E=;
 b=dnb7UcAPhbV0Y1hJgujdSsmDDpW6zVDkhOjStijNuolXquSCFEgCdaXLrZ9wf8oZojWgIT3TtRUzzujmKqMeJ8i3IZ4LHqoNFcApB8o0o1Ith2yaSoLUd9EMrgyGEYVHKgev/Vqp4lZ8A3ELrV8S8KSjyLhDVAzoGOGDScQxkUQ=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 03:53:54 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:53:54 +0000
Message-ID: <23aab424-0937-4ef5-8af9-7c78a2f1b541@oracle.com>
Date:   Mon, 6 Dec 2021 21:53:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, kexec@lists.infradead.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207030750.30824-4-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.126] (47.220.27.44) by YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 03:53:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7d6781-a0d9-41df-f8a5-08d9b9353035
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4514B1FC4932726C1311EE4FC76E9@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnFoo6oOm0Yc/ZN/dOexzT7naRpPbDV2W1M8hkX6eZRl0TMIjTSFMYNvvQbHC8IF0JL85ICoMio5fu/2oteF7A38eMnMH8I+aZOiGTdFKdIUFtnPeN5s4KqFLH8hW0MftarrPQP650v2Zx5MRhIRjQ8AovBW73UO1ct80X7AQBOhDcNIzFt3h5sTP9eJnX1/Pm3kI4VjBOqLpUroh2oJmL76ZguxdGRU0RLMkVufCXNrPhUn4auh8KTSKwbsZ21EJTOQaWNdkPLrMEBPtSIqcm/9REMmt2xYJqfJ5B5YHjAyug1U+Pxkh+TaGvzexoe+tr4SEU6xlIafLD2vNzX3cLCQIFZ3jbs6NsdffpAALIY+YWO+lCPWNdHrrGF/3mvXaM+mNf26hKlb4Yb2tReqL0TXWVb76bsZZRX7t99gEd1Y5nGQwhsYI6QId6IClhrjSHBXvMOJlzwYIZgEJkX1n2YpMaDU5qPFicEILiCJlLuFVj/qGE5fiMZGVLz/BGDD4R35EECmek2OGbe/8JOIsyd7W6UpHbC9ozKZ3DGkHhLe903hAOK9MZCCuEbbL37XyiOZt0NkrIICpNkMguYfC7MPBUNWz18T7r8PxPRlaYa3TwPzmHCMcnHMvcWotC2YaHZCoxiv8ZqYaQ0wUkcSe22ziJTZK8z7PqcCWH9hkxfEomxgNqWsGdikI9XwQeFJQdj9bk1jLpxdDFwL9lILmIaNq+fMZiYUIo46UAeGyUwIyFDyGVVXDJM0+iCys+kx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(8676002)(6486002)(53546011)(5660300002)(8936002)(956004)(2616005)(38100700002)(2906002)(26005)(66556008)(86362001)(7416002)(83380400001)(31696002)(16576012)(36756003)(186003)(4326008)(66476007)(66946007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVpKQjBFK1V2Q2ZwZGh0ZzdCTHJKVFY5clVGZWQwWlROWlpMY0xMZXpocEV5?=
 =?utf-8?B?UUZqbEc5MCtGK0IxelFSa3R4R0w2TWN4aFJ2VW5COUhCQm9wMWFPRmwwbmFh?=
 =?utf-8?B?bEJieVpQNHNJdDc5S2FvaEJXa2hsWVFRcExCa01iZHVoT2tnYlNjalNZM2Ri?=
 =?utf-8?B?UWE1QlFrQXFETUhTMDlpeG0vcmJ1YzREUFBXbGN1V0FXS3pKSWZrazQrSHZB?=
 =?utf-8?B?TWEzNXV0YU9hNzdBbnppcmx4dS8wT1FUNXF0TndISHJ0alVldXRXajc2b3pv?=
 =?utf-8?B?MWNUaTg3SkFKQzdhUGs3UGtaZWFPQ0dyV043Z0Eva09vRnFENnVOQ3VaeU9p?=
 =?utf-8?B?cGt5ZW1vZ2lsYndjOE1qWEoxL3pJNnJXbk9QK1FONGpDYjUrMDFDdUZ0cW43?=
 =?utf-8?B?WjI1TFB2VGsvRzV5TGxxUHdBSWtPUUdNNlVpbXp6T2hHalhXeTUvRnNxcThU?=
 =?utf-8?B?SzFZRURVNFF6Y0pLbDR0L1IramhPb0ZybE9QNHVpN0w2K1NBd2greVFkdjJh?=
 =?utf-8?B?MWhVdTU1YU9pT3MyYkNyTkVlbklsSUpsUSszNUxxODdxWHFKdXk3QllVVzI3?=
 =?utf-8?B?MGlLR0xVQUQvRUVMdWIvcnhHNklvbzY3ejVobkxuT2tVM2poSGwyT0JuMXRn?=
 =?utf-8?B?UDRXeWtRd3hHZm02clJheTVYdnFlY01QZkp6ZXBhVWpWT2hrOU4reG5qOENp?=
 =?utf-8?B?SXowMFh3c0w5OXBGL2Y0amtEZFFvNjFRQy9jRytpUGlZWDg5THA3UmF5eWVw?=
 =?utf-8?B?cURldklEZ1dPRWMyekJ3Qm1oWVBmZnp0bEg2c1RSbm8vUXlOVjBBbGtHMUpP?=
 =?utf-8?B?UVdzN0pBcHM4anExZ3ZlYXpLaE4yZnhzb2lhRElTaGJKY1ZOM01jSTVlcS93?=
 =?utf-8?B?MTZBdGVmbnhvcFg3UXA1VS9hSW9rK0tmZ25ZejVhc0VrVVZ2aTVEbDY0V3FZ?=
 =?utf-8?B?R0QyRzNwNlJCdVJKaVpTN1I1YnYyelJKRHllK2xlNlIvMStkdGxUTHNFUzVm?=
 =?utf-8?B?NVAxTlRzUzAwUEY1RHdoOVcvU0p4OVRQTFljcG5yVEdldFpqbHo0dVZBYlpX?=
 =?utf-8?B?MzhCMWE5aGZlV050eUlVV2ppZ0VmNmFFRTF2Wi82UGhna3U5ZngycmdpSkln?=
 =?utf-8?B?M0pqdFZieXFjWmcrRWphYUhBNkF0LzluMnU4YlhCL2JsWnI0N0E4NGdHYUZX?=
 =?utf-8?B?OURkU0tSd284clp2Y3lHTWxlU3k5WHJKRFYwazRNbndVYWcxM2p3QzV3cW8x?=
 =?utf-8?B?WTV5MzNyUTNNY2NVV1dJMEozeEZWWGlYM0ltVEZOV2RVT01MRk5aY2l5amNh?=
 =?utf-8?B?ZnNVM2lUUnUrNlNUMUQ2Y1dTemNqSEtuaFNJWm9YV044cUE1ZFZZV01TNGFE?=
 =?utf-8?B?a2h3QnV6aWtXeGNHWTlaVVNBRTl3WmhTb2RrRi9ROUhoQS92disrVktqUk9y?=
 =?utf-8?B?SHdxdDAzdlQyVEsxSFA3UnNxQlZPV3AyS0hOQTRUdGUzS0V6WUw3YVZlYnRT?=
 =?utf-8?B?OVY0cmxaMWVkVGx3RUVmYjNRZnJFWkxQUWlGRXVlalhBaytlMDUxQ2pmbFBB?=
 =?utf-8?B?OHNvYlI4UzA2UDhkdHp0T2VtZ24zTDBKSlJDNjFzSTRDTkl6S1VCajdFMkFY?=
 =?utf-8?B?QittMHBGUWRFLzZkL2FpRVBUVWM1Y0tmeHQyTXd3WXl2WGJEeC9qSWVDejNM?=
 =?utf-8?B?V0txdXZKamg0R3lmUG82dHQ3NDBDOHYrc1dyMjBCTmVGV0JkbnRnUG10RUNE?=
 =?utf-8?B?WEJxSldVTHg0WWlBY2s3T2RjOXVYY29lbW5lMnNCc0RCLzUwWVVUcWs2Rzkw?=
 =?utf-8?B?TDZBWVZLeW9jM04zZkVQbWdUUVF1aXFYTDArOTFlZENzY1VuTHBIWU5nUzdS?=
 =?utf-8?B?cFlzdEhhYTBiVUorei9jWEdPc2NCTENXQk9SQXJCRis3MldkL0xkMmw4YmxO?=
 =?utf-8?B?R1pEK1o1RS9mbjhJdDB2dGphNSt3OEFsWldXUWhFLzBWSlh4eGREYlBlbk9L?=
 =?utf-8?B?THhUWWppZHByaElUcXJOWUtLbTBFRStJUDdKbWRUQ1VyL2pMSjhhaW5KQW5z?=
 =?utf-8?B?K2hRak5oMlBWenIrdXIvejlncDgrdDdzUzh4VHZXTGRHMXozNi9KbmhQaHZP?=
 =?utf-8?B?c2J6MjNjUkFYaHFKTFEvNi8vSVB0a05OZlBXS2hvVWhERlpZdFU2RkUyQTI1?=
 =?utf-8?B?TERuQlhrNVQ5MExMaE9CdFRXV1pDb1I1dVpuUVBqWjlRdjlzcmlmV3F6VkV0?=
 =?utf-8?Q?tdZyJukUbaCFjneK8jK7wfiEcvZM50DyXNKyhGC/LI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7d6781-a0d9-41df-f8a5-08d9b9353035
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:53:54.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FFXQeNZrsnqtlqZTc1IWiBvEyg6Q+WxizKNNrVqMZJSu1R627CMvOeImDkvAL5Y/CxMsFNIQKvdRYogrjC8l2A3bOCy9HP2SIQs5UJB7ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070022
X-Proofpoint-GUID: SIxBmo6_THKfbaZGH1VChq0exRrDRGXZ
X-Proofpoint-ORIG-GUID: SIxBmo6_THKfbaZGH1VChq0exRrDRGXZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 9:07 PM, Baoquan He wrote:
> In some places of the current kernel, it assumes that dma zone must have
> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
> at very early stage of boot, so that there's no managed pages at all in
> DMA zone. This exception will always cause page allocation failure if page
> is requested from DMA zone.
> 
> Here add function has_managed_dma() and the relevant helper functions to
> check if there's DMA zone with managed pages. It will be used in later
> patches.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
  Reviewed-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>
> ---
>   include/linux/mmzone.h | 21 +++++++++++++++++++++
>   mm/page_alloc.c        | 11 +++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..82d23e13e0e5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
>   }
>   #endif
>   
> +#ifdef CONFIG_ZONE_DMA
> +static inline bool zone_is_dma(struct zone *zone)
> +{
> +	return zone_idx(zone) == ZONE_DMA;
> +}
> +#else
> +static inline bool zone_is_dma(struct zone *zone)
> +{
> +	return false;
> +}
> +#endif
> +
>   /*
>    * Returns true if a zone has pages managed by the buddy allocator.
>    * All the reclaim decisions have to use this function rather than
> @@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
>   #endif
>   }
>   
> +bool has_managed_dma(void);
>   /**
>    * is_highmem - helper function to quickly check if a struct zone is a
>    *              highmem zone or not.  This is an attempt to keep references
> @@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
>   			; /* do nothing */		\
>   		else
>   
> +#define for_each_managed_zone(zone)		        \
> +	for (zone = (first_online_pgdat())->node_zones; \
> +	     zone;					\
> +	     zone = next_zone(zone))			\
> +		if (!managed_zone(zone))		\
> +			; /* do nothing */		\
> +		else
> +
>   static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>   {
>   	return zoneref->zone;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..ac0ea42a4e5f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
>   	spin_unlock_irqrestore(&zone->lock, flags);
>   	return ret;
>   }
> +
> +bool has_managed_dma(void)
> +{
> +	struct zone *zone;
> +
> +	for_each_managed_zone(zone) {
> +		if (zone_is_dma(zone))
> +			return true;
> +	}
> +	return false;
> +}
>   #endif
> 

