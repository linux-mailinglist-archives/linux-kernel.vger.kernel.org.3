Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26052E364
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbiETD4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345269AbiETD4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:56:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9637BC2;
        Thu, 19 May 2022 20:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK5y7gGfkF7+GuMvp1LPyKClGFtPZR5ENJtBIvL+Yr95u/uNYkJrmmljAyIc9ELAoltTjOte70WGyy6i48DyL4bVtY4qxX6ajzl9rqmC0U7gUeKKtLt0FtPqwO82KJxd0bX+Phg/JJmI5rwn4x6hOZ6jisBVs6wYKcLJfwSsSkbbzpANPOH3Dx6+rrjklVtD8LqkxxHhq677DQ4mjaZtcqxZhkcd6L9bxM1oVSb61Jl4ENAmGLqOG3TByi8MqQFOJDgVG3fSBTU/QdGcudtVEYPdH15P1g4XDDdB38bDQU5CVrIyeBm8wVDqcQFu7vjHem1MSXloczfZURTfuxwLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2i2Y5MWde29PcrZs5u9x6NPf+NlHBNx7q0M94JxlTo=;
 b=SphCCkVwIf0VlU+J0bfiCGi5dSGrfOBeskh97WN/bUJ1bck3iwJ+xckz9Phr0BItrYrWJjeFXHvlC0rYusXtFykrzpqUuN3wbD4jfu2F5Um3FisdGydC+WI8L5l4bLmiBLSyR146NvMcPUtkWZEHSN9S/VJHTbknHyn54ncSt1sV7MdCe2tT2G7VojGZmuaM3cw4MovMl9uJY4HlA5/m9K1x3xAZijId2WS9mwcBOADlYlS3oQfbBwj6lzxxkR+eQa6J0hdEovIKRfb4JzuOJ72ntoaRpoEOErYXZdQzWRTeNMDq548SUwscyZaB95LrqRnqC+qjyJMgdEZDcoFXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2i2Y5MWde29PcrZs5u9x6NPf+NlHBNx7q0M94JxlTo=;
 b=MNGy+wh+E3tmAJ0KR0ww8inRCmwU74d6nTOvBnVvcXTxMsLjqIAgzFUp7EbCSQunKMU7E14b+mrCh0wsNJAxGDlaYVZ7Z3MMLuBVpa+9TGZVBQnzd/iCJX1G36R621JtbeWGnocX/2hb1cOW26Yqat8rmp4WyBJm6VkJcUq9u+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 03:56:03 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Fri, 20 May 2022
 03:56:03 +0000
Message-ID: <8b0fc830-a0f6-c2ca-a493-011a46dc190d@amd.com>
Date:   Fri, 20 May 2022 09:25:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 4/5] perf tool ibs: Sync amd ibs header file
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220519054355.477-1-ravi.bangoria@amd.com>
 <20220519054355.477-5-ravi.bangoria@amd.com>
 <CAP-5=fU5ArsMcTiYNgZ1U+i6mmtdc+OGx9_ny0x46+O7d4+dpQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fU5ArsMcTiYNgZ1U+i6mmtdc+OGx9_ny0x46+O7d4+dpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2c0cbcc-82e6-4f48-ecc4-08da3a14a8b1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0063AB1567504E2A8D64B0CDE0D39@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cccgx1Bst9p4yd+H0GHCUE8q+WfSGXNpqSUchGPSA4rCpm0jIdlOKUqtajFAcKv5R1zVfAXvrkiV0JAxhDUBbZPVzSJP4/TlBRry3d0FIsiyAB69rzLZJLgeg72bXxCn3vwBW9yuZI+BLTG1NMMgDfUgq9MAXbCWdtzLDPN+v3oB+M+P62ovftsN15IaRbhduG8u37kvSnulH+ijHsw1+s9bSZrWrSPk8FNNpA4IlUVl2fl3HVcT7k7lkZ27RAU/qJyxmptNE4bwKfyFis04wfmxPN6dltFaW70P/C6dh3wSVuW9IfwsSAQvb8vHxu+DNsjwJln/UWXOg29/n19/jx0kCSXC/z9Dreo4M8a/edC/4L7VH6td+ym9sL4QQWuR2si/3K+sJKoHIgELyitSXK5CeCkIKU0IdoPifXgVMw+zuWCHpXweeHLWxHHmJQEzYcqIw7CI8vOVZFEw5OnG26uBjYBXMNViLDQPyxx+Qd8UbPuM6y+qLxNcE6tQp/uMQg9j/e0IU2oDGiXYhIFwnbvAQMEP8vNAc45AGWnZ389mGnnYdouMuHe99ZtPJt8uP3uJeNlQSW3UAs6Re7dlDYsGTCiMITSMGFdl1w7LfqmJaGpk9aFss7/+bfsT4c9eG3nQ5BbRvg0k2Bm9rH5UgMZWhOQYDv3RWmrrJhjaCZafZnF2FGs8gZQ06IvTRVXuDyXs80cIuMJUyDly1V6CTQGufZlDPWDGfEkrWwF0YrLrVMf2mtTsRaUgyqAqYpJ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(7416002)(31686004)(316002)(6916009)(31696002)(26005)(44832011)(8676002)(4326008)(66946007)(66476007)(66556008)(38100700002)(6512007)(36756003)(86362001)(508600001)(2616005)(8936002)(6506007)(2906002)(6666004)(53546011)(5660300002)(6486002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODF0VjE1MzR4eXd1RitMaWJHTkh3b0lmcGkrOXZIYkRCVGJkMExZRE5ubXZn?=
 =?utf-8?B?U3RMM2ZvT0w5eHRYclVFa3FjYllReitISFlQRzF6RE9mK2Z3UG8ySDAvaklQ?=
 =?utf-8?B?SUhlMVFLWW12cTc0NjhSZG5tTzE2KzNsZU9ESUdwTmRxQ3VOQVJnOVRyakMr?=
 =?utf-8?B?MlRqWUxYTHpVVmp2VjBpTzlQc3ZQeGErb0xXL0h3K1VINFExbEJtdWtjbVJ5?=
 =?utf-8?B?QnlBaHN4Z0xVV0FUQjdpZTEvZXZEL0hla0F2Wm5oZnllWllBZkdzc1hsai85?=
 =?utf-8?B?OE5pUy9seHBIRzlyRnNWYit6cFZDSGVqWFRtMW9scDNmWnJXZnRZM255MWo5?=
 =?utf-8?B?dE1OZ3pZWXdaUVBrcC9PSjFteUdWeE9QZFBFQ0RPcWZlbTN5d0VBK2ZiYzFs?=
 =?utf-8?B?b28vVDNDa1AzVTJaNElMTXltMnRhL0RST2YxOXdXNG1tWk9zWU4wcVR5bHlD?=
 =?utf-8?B?QjlVcTRmajg2Sk0rYlpqT0VvaUJpcEtiUi8zUzlGdUZHNnpjWWIwS3h6Zkxx?=
 =?utf-8?B?czdSR3FzRG1ld2lqc0F1bWo0SjVsNTkwVW1ndzNtZVEwMVZucmJ0cjF5T2oy?=
 =?utf-8?B?Q3duU3B3OTdFVzZBZVIyOVZuZmNSS2VLNk83MkdZUmp2aHhSeGRyanUvNy9O?=
 =?utf-8?B?WTJiaU5uTTY3eVBRUDN2N1RxbUV3b1A5WndVT01IN3dsYUQzaTBvUHRjVEhj?=
 =?utf-8?B?WWIwMk5Vd1JrYjQ3OTJnbENhc0s3L3pheS9TVVBJTGRBM211RzgvejJnWVJ2?=
 =?utf-8?B?Qm0vSE9YWlR2Q0ZxdzZ3SHNJUlY4N2ZrU2JTQUxZWkVadVZiRVhLekJCcjlt?=
 =?utf-8?B?ODYwdmRzTitoL20wbGdnRWJBQU96MlpKVTB2bVV6MW5kekgydHlJNWVOV1oy?=
 =?utf-8?B?YzkxTTU2NkJzRXd5d1liRmF6T0VSSmpQSTUzV3NYNk5yWUpScXkrWDdtbk1Q?=
 =?utf-8?B?aEV2QThFQVNNakpSQXNEWXNkS1RmWlMwRDZLUUdMU01XVUhBK0NvdVd3UWNJ?=
 =?utf-8?B?djN4NXJVQksyeWQ3TVVkckQwNTU2RGlEemtxRWxJUEhtdkplWXBHemViMGhI?=
 =?utf-8?B?NVJJd3FsVDdSSVNya1RJdG9EQVhEUGNEY2lQRTNIZm00UzVKcWUxeG9mUlph?=
 =?utf-8?B?QjNvVzVCbnMvMjR6NXNrYnJVQXZIdGlBTzFuRTlUYUk4U2tPdGVSZDZRYVps?=
 =?utf-8?B?UHdYR0JJbngwM0hhQTlHSmMwd3UvSkFpQ3JrRTFSNG9ySzdRVXJxSGh1Z1F2?=
 =?utf-8?B?K0FMbFZleEJROXRyMlZTYlFETlUwUDd5aExQcFpJcXJiMFhpVmdhNi9rRFNs?=
 =?utf-8?B?NTdTQXpoSnJ1U1JidlBwN3NwWGExLzJEV2VCeUFKb3ZKc0VUU3owVnZwQnFR?=
 =?utf-8?B?M1MxQ2hXQ0lQdUpyQnN1ZlJMYnZ4V3B6YjZuekZHbnc1cG9xNTBTaStacGlN?=
 =?utf-8?B?eHlYK01qald6TWNQcU81UjBNMzkzK21JYlBkK0tMN04yYStYUUpVMFVPTTJD?=
 =?utf-8?B?dHlCUU9NNXBTRDMvWGhrOW9IMzZvYThzQVR6MUZkTEZISmc2M3daWlhhdU5v?=
 =?utf-8?B?KzBtWWsxWmFHeUMvMnhJOEpwbGlFNVRyL0RJRXpWTEt6TnkzT0g4bDNaQW85?=
 =?utf-8?B?RHRyNGlRZmRPOHd3dFF1ZHBBd3k4aUpnZ29GYkNSQ3Q3bm9wcTFuU2lScHY1?=
 =?utf-8?B?VkpqT3FzU3hkcDdENG9YNm9KdkV3RnEzUDhoelI2VHI0WmRRdjNsRmNFWEhB?=
 =?utf-8?B?dFhlUzhlWUhlM3Z2K3RpRzB5UUx5VDVrQTd6MGpaVnVCNTNYZHhpVElCRStv?=
 =?utf-8?B?MGFjUDFzSzU0aGpxaWJTakFjeDBrUGs5TEhrZkhhL0JlZ3VhQ3FmZlExVUhB?=
 =?utf-8?B?Y3dhY0dBQm1uK01kYkhvSE1UTzBySGZYWHVCUllkbW1iUURHYzFLUVk4d241?=
 =?utf-8?B?ZFQyYUtGdW9WZERkazJZZFBJc3hpWWNkRHl0YWJqOVhKSDhJMGpoM2Zibnda?=
 =?utf-8?B?dXBjbW16WG9KWXh0WU9wSGNDLzZ5VE9tNURQM0RKL0VqWTJQb2NiMzJTQjRo?=
 =?utf-8?B?aWl2Q0gwUXdReFAwbjRFbFN3SHhTVWw3bmNmR1JjRlgwUUx1alVXV2pGRTdh?=
 =?utf-8?B?V202MzMyQlpjNUNXMGlzcDdHSHNqenB4MWl6MEYzaDFVSmowSEpOK2k1cVpV?=
 =?utf-8?B?OTlBU1hiQkZSY0hGaFFpejFxMm5nREt4SHlTK0QzQm0zeDlFWG0yeVlKcUc5?=
 =?utf-8?B?eG5hVEc1RGhHVnlZZ1RpTUNGeENjb0Q1amh4NnBQeDVxbDB2a0JXSHlGS0Fj?=
 =?utf-8?B?U0Z0MW9XV1pyaXRMQzhNT1NsaWdveWQ4SWsxMVZOV2JVeFZnUWtIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c0cbcc-82e6-4f48-ecc4-08da3a14a8b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:56:03.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJVVCS/ZuHxizwzzfMs0cYToepeC/NLiZ3ZBFmi10KqwrPG3FaLtdBqjOVrEaFy+X9z86J28AyB3YLaTc6q8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 20-May-22 5:18 AM, Ian Rogers wrote:
> On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> IBS support has been enhanced with two new features in upcoming uarch:
>> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
>> has been introduced in IBS registers to exploit these features.
>> New bits are already defining in arch/x86/ header. Sync it with tools
>> header file.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  tools/arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
>>  tools/perf/util/amd-sample-raw.c     |  4 ++--
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
>> index 765e9e752d03..9a3312e12e2e 100644
>> --- a/tools/arch/x86/include/asm/amd-ibs.h
>> +++ b/tools/arch/x86/include/asm/amd-ibs.h
>> @@ -29,7 +29,10 @@ union ibs_fetch_ctl {
>>                         rand_en:1,      /* 57: random tagging enable */
>>                         fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
>>                                          *      (needs IbsFetchComp) */
>> -                       reserved:5;     /* 59-63: reserved */
>> +                       l3_miss_only:1, /* 59: Collect L3 miss samples only */
>> +                       fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
>> +                       fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
>> +                       reserved:2;     /* 62-63: reserved */
>>         };
>>  };
>>
>> @@ -38,14 +41,14 @@ union ibs_op_ctl {
>>         __u64 val;
>>         struct {
>>                 __u64   opmaxcnt:16,    /* 0-15: periodic op max. count */
>> -                       reserved0:1,    /* 16: reserved */
>> +                       l3_miss_only:1, /* 16: Collect L3 miss samples only */
>>                         op_en:1,        /* 17: op sampling enable */
>>                         op_val:1,       /* 18: op sample valid */
>>                         cnt_ctl:1,      /* 19: periodic op counter control */
>>                         opmaxcnt_ext:7, /* 20-26: upper 7 bits of periodic op maximum count */
>> -                       reserved1:5,    /* 27-31: reserved */
>> +                       reserved0:5,    /* 27-31: reserved */
>>                         opcurcnt:27,    /* 32-58: periodic op counter current count */
>> -                       reserved2:5;    /* 59-63: reserved */
>> +                       reserved1:5;    /* 59-63: reserved */
>>         };
>>  };
>>
>> @@ -71,11 +74,12 @@ union ibs_op_data {
>>  union ibs_op_data2 {
>>         __u64 val;
>>         struct {
>> -               __u64   data_src:3,     /* 0-2: data source */
>> +               __u64   data_src_lo:3,  /* 0-2: data source low */
>>                         reserved0:1,    /* 3: reserved */
>>                         rmt_node:1,     /* 4: destination node */
>>                         cache_hit_st:1, /* 5: cache hit state */
>> -                       reserved1:57;   /* 5-63: reserved */
>> +                       data_src_hi:2,  /* 6-7: data source high */
>> +                       reserved1:56;   /* 8-63: reserved */
>>         };
>>  };
>>
>> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
>> index d19d765195c5..3b623ea6ee7e 100644
>> --- a/tools/perf/util/amd-sample-raw.c
>> +++ b/tools/perf/util/amd-sample-raw.c
> 
> nit: given the commit message this should probably be a separate patch.

Renaming of an existing field in only header file creates a build issue.
So I had to include it in this patch. Would documenting it in the patch
description help?

  Also rename existing ibs_op_data field "data_src" to "data_src_lo".

Thanks for the review,
Ravi

> 
> Thanks,
> Ian
> 
>> @@ -98,9 +98,9 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
>>         };
>>
>>         printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
>> -              reg.data_src == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
>> +              reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
>>                                                      : "CacheHitSt 0=M-state ") : "",
>> -              reg.rmt_node, data_src_str[reg.data_src]);
>> +              reg.rmt_node, data_src_str[reg.data_src_lo]);
>>  }
>>
>>  static void pr_ibs_op_data3(union ibs_op_data3 reg)
>> --
>> 2.27.0
>>
