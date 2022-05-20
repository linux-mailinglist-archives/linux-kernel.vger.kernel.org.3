Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ED952EEE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350660AbiETPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbiETPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:18:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D81F17788A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIokpzZnfUd5zqmFi2prH3WUq/sguwOgLLshQ9TXlBqqiR2YJLqnNdnsiR4BL9GPKCGpgnXm9i2gE5HaNwUTW1R3Ld+tOH8gMxLmhpbTDxUrEGjGZ1+G2flsOXGggzLyY5JXiDMlXeNZOVgfDNfTVFN3DHR0jfoWP90Apo0qx7cHQ3Y9QTTzAsRUAdK68nv96dyeg1XNo9b/KbOpeHz6AFdUFMKZT6Y5RW1satExWfwntScrjoFBW5z2rOALrIcivDz5WuMSUmR5nL+TSFqkPlULNl8j8FcVoK4+NPjFyBtQzy1Id1HGYbSYSM/aUsKIkg2rvBPd12pZLxrdqrVtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1Zc0PvwRtzri2Bg1ISGA8UrhRrZI3cGZYGW2UcP94U=;
 b=Ot69/7cz8Mfpda2CCE0LuBI2+tUKey0cIa7syWROgH4AaoVj/LD5owwVWvV8u35qbIX/sBxJ06IIMJ4KU+B9++l3kCykZJiWJ4g9QAQotXOg5y90hgTtdh4WwWgrDrPIow9VUdmroQdP6IDW5pdQ/oeUU7DTUdHPFmPdBnFdvfxxriQLZ+T3MQXuOoKWCcSA3KN3sCXCqyaqtqQb5+Fz2CZF3JnwhO1lrvLbGBiK8GuvqB1K1PEvWwXgkTvuYVxdf5FHpGHhDLLzWmkBZ9EXzv7K3js4HgcPhhtjaZgQyGP1kGdk284cE1Px+nK58Kp4ROmfacPF4ILWYLTtQvFJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1Zc0PvwRtzri2Bg1ISGA8UrhRrZI3cGZYGW2UcP94U=;
 b=vwMkOosnIO0RWi0Ly/NAVUMJK3ZkX4x+wgpvqobVIEA4RH2xhtiOLQcRU0DIbq18XU4RwobZ5Xe1zYwHc4m3ByzsqS5qs68s1QCCl9CQV4nRqA3yF2dpJ9fBAtofua4tIMWST1Hd6Qo1ifB/6aLSSqZ4iBOz0CCu7lnweYBACvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 15:18:00 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 15:18:00 +0000
Message-ID: <4b781c91-2947-a029-3558-f4a49130e5e0@amd.com>
Date:   Fri, 20 May 2022 20:47:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/4] Mitigate inconsistent NUMA imbalance behaviour
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <f6b2eba0-2c28-b41b-3900-8834abbd6575@amd.com>
 <20220520101812.GW3441@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220520101812.GW3441@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::28) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87890734-22cc-4fd4-35ad-08da3a73ecd4
X-MS-TrafficTypeDiagnostic: DS0PR12MB6558:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6558ECA9736A929B79D5B8C998D39@DS0PR12MB6558.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WG0FD7faqXFrvB7GIT9mZBSm18dZhPvZ4TSJdFcoQGROTzNVzlURpZd5vc7DrF530i2QalQydwaXc596IW4lkuzpwQDP8eO1HH9Js/T4oZdnLyzgs3uJDeKZq46qpV5YcyICMC20ZHdGELEd4fA4lGDGunLspCfpL9WYGNkfzArRTFiNt/N8kaA0jGKhySvypc1KAUqCOFDM0+aLMGm0LpW0ELDSCsB0QtIO2+iht2twIRS+JfVocqPuk+WVSQgANsyfPLWArVmjH2yUhesQerlipzMjCVNeWOCl48dcinA5fuKI1odqtXEX7+uj3tn1bWP115cILsifc+nd0Nup+RPqcthoEQ9aD2UIVzhbvtdKYVPBr8InAzULlGjYkXDupv0bwiqh/4kE/4FZpvtY4COs+pDWJH4vTO1ufYIFpoy4q1ZgWPfH1RbDf4yCBMjUodxrfyRG6xEpixTK4RQE3LQfs/2+bgF5uy2Bi+Nn/K+ZzxfpZ9FG7exO7EqF0hllL5dpBVeJJKTvBdQFBUVaoNDCR78cLcMjd/febKQVVGgtzfLVWWLwf3C9/AWS93VFFtLGQQ4c96BVE2Q4hnH62odjNMloPaFr6Wl/Bwber5hzzujTeagyNgaPP6T4JBLMvUWpnE1dVktOo9dkjvE9fkCSnJX7WNZgcXBRzGKIV0escZa8I3Z0Z5ZHxPdnp8DFS0drYlPjiz4rDpbHtlCEnuAHFgdXJToDt7+eWIiLX2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(53546011)(6506007)(6916009)(36756003)(31696002)(6512007)(8936002)(54906003)(26005)(31686004)(6486002)(8676002)(5660300002)(83380400001)(2616005)(4326008)(66556008)(38100700002)(6666004)(2906002)(66476007)(66946007)(508600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE00YlhYVW5XUy9BUkcxZjZWUjBFZXVOWmdKd2paeU9MUHRqcFIzUHl3Rnlw?=
 =?utf-8?B?Lzg2MWEveHcrMEVPT3VBYU1kS2IvZWhCc2o3UDIxMXkyZlVyOGlZeVdFaUYy?=
 =?utf-8?B?QmlXRml6V2ZYd1RvSjd0cTN6M1R1NlFoTHFXWXd4alFBMUVzRlNOVlJ3eEsx?=
 =?utf-8?B?TU9ZbEpudlRHTHdrSGJpMk0xc01pNFlXZ2Z4YlJPV3AwaVJsQjBMS216YzFL?=
 =?utf-8?B?ekttY2lsaWEwVG9QdnVzN00wN1g1YnFvSjRhaGhweWFVS005RDhwNnVYWmk4?=
 =?utf-8?B?N3JxelpUZmZMS1pTYnN6RUZtSThyQWUvampPdUFadW1NdDZqWDVzdVdjZ3lO?=
 =?utf-8?B?MXVxT2g1N296UTF4TTQ3M0xEYjI5TzZVMlUycDlHQ3FRMVJad1hlVE9JSldH?=
 =?utf-8?B?N2I5ZVEwR2hMOFphSFdTcWxjN1ZyMDZoaE9JTUlQbjhTb3VGSUEvRE51V0kx?=
 =?utf-8?B?emdIb1FrS0NwNEpNOWxnS2pNM1RJelhNUmNDdzBNTlZVSWxiTWpjZHlsWTJV?=
 =?utf-8?B?NVV5YTJldkQvQWtNeEl0V3ZIUGxVN0JPTGJXU2thMW1VQW9mTHdkdW5VV29u?=
 =?utf-8?B?dHAyZ2ZLNnVLRGZEb2dpcGp6Y1JReXhWZUNPVjRtcHBITWJKV2pqUE10OERn?=
 =?utf-8?B?TGg0YkcvWUtXTU1wcThsaTlvSXgyOE1HeDVyajRmTk93eG1pUHh5TEVCR05I?=
 =?utf-8?B?YlNvVk5VdHQxZXZaRzVKVm5lWHpmUkEyVXhKcmdyeGNQV2pzZjE3b3VYaVRv?=
 =?utf-8?B?K2hUU3RCQzNtUzNyQTBkdTlRYmEvazcvU3BkNTdwdFNYVG54VGgzelFKMnRu?=
 =?utf-8?B?M1ZKVmZvakNGdU1tWm5hUm50dkl0Q09ITzE3aDRTS214cVltRFkxczd4aVoz?=
 =?utf-8?B?WUJYWklDOWs4MGpNUUE5WXdUdGdic3RNaUg5MHRCZEp6bkxJbjZwZHdWVWF2?=
 =?utf-8?B?VVU1MWx4ejc4WWhIWWljcUVUdDlmK1hHeTZ0SUtEOG1QOG1kL1g2US8vaUFQ?=
 =?utf-8?B?YzNuVE0wUytpd1c2VVpqY1RHZC9VTkxOaVN0MnhGUFRMS1REaUFQMjVIQlNK?=
 =?utf-8?B?TFp5WHEwMXZGNmQ5a1ViWVZMODVPT1BOZ1AwaFpOZU9aTFVOc1h1cTBIUURK?=
 =?utf-8?B?ZXRnaGxQdzFmOWJyVFhOMjNvMkxuRGpyY2JMbHR6ZUdoMTIzTVh3SjFHSkFV?=
 =?utf-8?B?bENmMDh5YTljdEd5Ty9RcUd5SU5Jdm5wODdTUmlIVGlQVkhETkJWT2JwSVA5?=
 =?utf-8?B?YlBocjZmWFNjVVY4b240WEJTOS9xWEVaYlJvTjBybEgzeDNvMjBKZUplUW9C?=
 =?utf-8?B?YXZoZlVOSC9xeTF4YjRMWUZuOXZzdUN2OEhaaFRVNEh1T25DMzl0MzE0c3Nw?=
 =?utf-8?B?RDRDVjZSdGQ4Nkhyc2xsM05mVWJ2dytHdjFyd0c5LzBtMnQyaGxBNUxPK0Q0?=
 =?utf-8?B?ZFI0ZDNPV1hGQ2VFN2NOZUVWd1FPYTVheWZjUnRzUXN5MHoyUkdIdzMrUURs?=
 =?utf-8?B?UXZSWWI0WDZFK3BXQ0RkRUFUejF0T1h3a1BKQUZUdkJRbTV3S2dnTXhJQUF5?=
 =?utf-8?B?RDdLNFEzcGZBMGYvSlJtT0RIUVRCWmlHejVlTUhpbDZyVzVJUG8wQ1pFQVY1?=
 =?utf-8?B?bkpSTVk5THY5ZDhVTG1TdElTWkg4YW1KcDd6OVQ2TDY2QUFMODVMV1dYd0M2?=
 =?utf-8?B?ZDdpR3JUMmYvQ0pGSHZadG90clVnby9EWFZTM09rcCtRa3ltVDZ0b3dqZTZV?=
 =?utf-8?B?RlBlUHlRbC9SRmRXNi9nNDNsUXcvQnpRTTV4T1RURzg4SHNyYnFBVmpMQVJC?=
 =?utf-8?B?TDQwWjBaamFOVVlCOTVXRXp2bUE2RGpoK1ZQemtKZEZ4bjQ0RWFmTmFaS2NL?=
 =?utf-8?B?UUhTb1kwcENCVVdNQ3ppMG5kdG5YMDdPSnQwVVBJUHlRRm1xY1lQUjkyVE9w?=
 =?utf-8?B?YnNvNTVzNDNBTllERng1WWVHOGxiS2psUno2N1FldHlDa3J0M0VFVkp3clRh?=
 =?utf-8?B?eFo5Nm9La3dWeGl5cGJlS3BnV0JBVUlRd0h0cDh3WnZsMmUzOGtsa1RKZ3dO?=
 =?utf-8?B?S3VSQ3BFZllQWlQ4TFlyeEJkTzBKV1AwUHpyZEhMU01nWVRXVlh6djMvbEpz?=
 =?utf-8?B?emRmQldpWEdNY3pxRjZ4K0Mxbjl1WE1Pa1RGazBDNEwyd1RRcXpPM1dMcnY3?=
 =?utf-8?B?blZzY25sNjdtcUtzYUVLWnlQaXZFWTk4MC9FVnEyMHk0TGQ2OGtGTnhYaURB?=
 =?utf-8?B?eTNPeWxvUWFoWkpNMFFXL2ZBREF2RkVrUXBORmpka09UYXZ1NFBlRlRxQ01M?=
 =?utf-8?B?d3hHcVIxQjIyVm0wL2M0TnNSVkRIaWVjYmJKczlRTkFINVZtU3dydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87890734-22cc-4fd4-35ad-08da3a73ecd4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 15:18:00.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pcupYGdkVkg7Kc/u+Ua0RLiNp6zPPOxDGk62UXWtOAAU4tepV0WyAMc9SfzzNRXhZtzqwsKPdpkLfZFHdjw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

Thank you for looking at the results.

On 5/20/2022 3:48 PM, Mel Gorman wrote:
> On Fri, May 20, 2022 at 10:28:02AM +0530, K Prateek Nayak wrote:
>> Hello Mel,
>>
>> We tested the patch series on a our systems.
>>
>> tl;dr
>>
>> Results of testing:
>> - Benefits short running Stream tasks in NPS2 and NPS4 mode.
>> - Benefits seen for tbench in NPS1 mode for 8-128 worker count.
>> - Regression in Hackbench with 16 groups in NPS1 mode. A rerun for
>>   same data point suggested run to run variation on patched kernel.
>> - Regression in case of tbench with 32 and 64 workers in NPS2 mode.
>>   Patched kernel however seems to report more stable value for 64
>>   worker count compared to tip.
>> - Slight regression in schbench in NPS2 and NPS4 mode for large
>>   worker count but we did spot some run to run variation with
>>   both tip and patched kernel.
>>
>> Below are all the detailed numbers for the benchmarks.
>>
> Thanks!
>
> I looked through the results but I do not see anything that is very
> alarming. Some notes.
>
> o Hackbench with 16 groups on NPS1, that would likely be 640 tasks
>   communicating unless other paramters are used. I expect it to be
>   variable and it's a heavily overloaded scenario. Initial placement is
>   not necessarily critical as migrations are likely to be very high.
>   On NPS1, there is going to be random luck given that the latency
>   to individual CPUs and the physical topology is hidden.
I agree. On rerun, the numbers are quite close so I don't think it
is a concern currently.
> o NPS2 with 128 workers. That's at the threshold where load is
>   potentially evenly split between the two sockets but not perfectly
>   split due to migrate-on-wakeup being a little unpredictable. Might
>   be worth checking the variability there.

For schbench, following are the stats recorded for 128 workers:

Configuration: NPS2

- tip

Min           : 357.00
Max           : 407.00
Median        : 369.00
AMean         : 376.30
AMean Stddev  : 19.15
AMean CoefVar : 5.09 pct

- NUMA Bal

Min           : 384.00
Max           : 410.00
Median        : 400.50
AMean         : 400.40
AMean Stddev  : 8.36
AMean CoefVar : 2.09 pct


Configuration: NPS4

- tip

Min           : 361.00
Max           : 399.00
Median        : 377.00
AMean         : 377.00
AMean Stddev  : 10.31
AMean CoefVar : 2.73 pct

- NUMA Bal

Min           : 379.00
Max           : 394.00
Median        : 390.50
AMean         : 388.10
AMean Stddev  : 5.55
AMean CoefVar : 1.43 pct

In the above cases, the patched kernel seems to
be giving more stable results compared to the tip.
schbench is run 10 times for each worker count to
gather these statistics.

> o Same observations for tbench. I looked at my own results for NPS1
>   on Zen3 and what I see is that there is a small blip there but
>   the mpstat heat map indicates that the nodes are being more evenly
>   used than without the patch which is expected.
I agree. The task distribution should have improved with the patch.
Following are the stats recorded for the tbench run for 32 and 64
workers.

Configuration: NPS2

o 32 workers

- tip

Min           : 10250.10
Max           : 10721.90
Median        : 10651.00
AMean         : 10541.00
AMean Stddev  : 254.41
AMean CoefVar : 2.41 pct

- NUMA Bal

Min           : 8932.03
Max           : 10065.10
Median        : 9894.89
AMean         : 9630.67
AMean Stddev  : 611.00
AMean CoefVar : 6.34 pct

o 64 workers

- tip

Min           : 16197.20
Max           : 17175.90
Median        : 16291.20
AMean         : 16554.77
AMean Stddev  : 539.97
AMean CoefVar : 3.26 pct

- NUMA Bal

Min           : 14386.80
Max           : 16625.50
Median        : 16441.10
AMean         : 15817.80
AMean Stddev  : 1242.71
AMean CoefVar : 7.86 pct

We are observing tip to be more stable in this case.
tbench is run 3 times with for given worker count
to gather these statistics.

> o STREAM is interesting in that there are large differences between
>   10 runs and 100 hundred runs. In indicates that without pinning that
>   STREAM can be a bit variable. The problem might be similar to NAS
>   as reported in the leader mail with the variability due to commit
>   c6f886546cb8 for unknown reasons.
There are some cases of Stream where two Stream threads will be co-located
on the same LLC which results in performance drop. I suspect the
patch helps in such situation by getting a better balance much earlier.
>>>  kernel/sched/fair.c     | 59 ++++++++++++++++++++++++++---------------
>>>  kernel/sched/topology.c | 23 ++++++++++------
>>>  2 files changed, 53 insertions(+), 29 deletions(-)
>>>
>> Please let me know if you would like me to get some additional
>> data on the test system.
> Other than checking variability, the min, max and range, I don't need
> additional data. I suspect in some cases like what I observed with NAS
> that there is wide variability for reasons independent of this series.
I've inlined the data above.
> I'm of the opinion though that your results are not a barrier for
> merging. Do you agree?
The results overall look good and shouldn't be a barrier for merging.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

--
Thanks and Regards,
Prateek

