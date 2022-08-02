Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92E58766B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 06:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiHBEke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 00:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiHBEkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 00:40:31 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9162DF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 21:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcW9uXBWciuBaCMXnYNL9SNHOwjvDzaW9mOSTp5dP90qSg4SbYfzKdaKSDuFsauX21la+1lC7MBmw0chPvc5xJ8dB5QWv3WWLNGX4Ljm1HN43yp4IkiHT3pdc+XcoRkdexzpYYPJRY1D4dMB6CRKFWCDewoIXHLIDn7H9CvSTn4eW3/PS/39WEUwreHjXn+eho+EHRp59S3SQ/f5XEti3k8EqAPWt/OP07DV7GRkgvvymPIkh4ahueFuab+0IfeVYASvXmMD0gV5+US85M+m6Fayjdtba8LWZjo15/itrQMeEFv08FwlSb6T6LgAOgfFJOr5r+XJHZ4T7YIPOxM1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g47yK7Pks0DnjgsKvDs/crXUexQuDAY3vRjtWfr8BpY=;
 b=UYH5wgwEcSlRvChY2l4u07tr6Gc8dxgdjDN03dv0b6eGL24ldXw3bpbtMn2lFlJtcxK9yJzfm230XqjYCm4XGwP7G7/m8AVfFeyLK5ViiTfKZieHHCMJjAypZhTy+N4QvAzZ9kNgtzflNKBt5DMbpD2SMR8w417I/iqf9MrkdU4MDQ3kb7uhursco+wt9VFyPbO+a0lnMgnH6LGhO9Bdaa8FAq9WXo9zzINdhv6e516Raom8Gr+dNj+Cwhr/nt88/CYRBbOmoKq30VUCZ+7bD3V2jfbYla5VQF9Zhyf+v9U//y0O3gJ+6vpnWmsA3wGZAxJ0Nid/7YEt1hb6y/6Ttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g47yK7Pks0DnjgsKvDs/crXUexQuDAY3vRjtWfr8BpY=;
 b=fRQdmSB6JuW4bFQi9VyqgzKSIGnVcUpsfpJiP+yrMcIAY/I8kzoDihH/Q9ZVPlN3d/zqCOgT0yDBUXpsU4Nv5Qr4knquyRwspcMSDbZuFJPL/HM/M+4yFLXqN/Gh9yiXhpvSuWR0VJPs0L9zo0J3PhNLiFBmFaXefr8c9f58RWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB2893.namprd12.prod.outlook.com (2603:10b6:208:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 04:40:25 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a580:39f0:8893:8ede]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a580:39f0:8893:8ede%5]) with mapi id 15.20.5458.025; Tue, 2 Aug 2022
 04:40:23 +0000
Message-ID: <b0dff0d9-c18c-4465-90a5-54a8c28fe40c@amd.com>
Date:   Tue, 2 Aug 2022 10:10:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Libo Chen <libo.chen@oracle.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
 <dde78e86-6c05-5b36-6ffc-3c6b43370fcc@oracle.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <dde78e86-6c05-5b36-6ffc-3c6b43370fcc@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58485183-0bd5-418c-2e18-08da74411cbc
X-MS-TrafficTypeDiagnostic: MN2PR12MB2893:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrxL40UrXdsPZyURLMmZkWwb+ugi6azkoeHqlSW9BnfsMQqr/KfTbwoFxWNCTBR2Fko0RM8QLOOuxzK158y7OJX6e522+gcY/LLKfIGyc/wFnFele7xB7IKLwrigpesRvxdBRGakiMRleyDIEJzYFEn/ar1nM74r/unRybAKaGGJtD4nEC9+vzPZKJszFAzRtjgBmyGltDdE87UTXJ2bvQjqsu/DCdEPIFFSAin7tcKSLN+oL0xoOJHUgyPiYhYhbiVWSMe4nyLRLi7wNFNoEJ3ze0WA+2s25lxoxHsiC/3zLbKOx186IX0eXL73nt0pMUApk4R22WKtWCfr42nCapuI/z8U/nfNtHD0coZvOby6baJszSLr+JMWOstnwNBRVHV8V4z82su80jGZImeectGsGJEr2mVW0n3qjMrxFsj6ClTcx/iqsSCx3u3AEXHxkdjO6jSJ28P8gLa0BqKOeABQGK+F7I7D47CCvbzwPokQgFkDo+/PPfznaBDXOwlRt7CNEAarhr78g46kyQuWNgK/ZnlBK0RPmvCxkHU927wQRqWgJtXvh3Tz/PinTgBLooXX1jdNaqbIf4m8fVcQ5kNlBnwcyw9/0BhqJ8LK9/egmUkJpVaniJOOsgaG03xtVdVfKRVxGlEcxr3ad2Ukxz0fnri0bIqNbSswXvqgBWqieDqe7Ag843XiDEbHtEG3jfftW+WI7pHD7s4ht1Oxl2Jec8NrRviVlIy/qQLk3KRaBL4p+iCt6pgyTVYWvRHcYbbr08xEIKm6ByUqbdjpS2i6+4HTZL8oRUPo7ZyDMuBm9R7rf7FmKO/KqoJTIFChlWxrl84baZnEAllx7Pl+sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(36756003)(83380400001)(8676002)(8936002)(4326008)(31696002)(5660300002)(2906002)(86362001)(2616005)(186003)(66946007)(316002)(31686004)(53546011)(6486002)(38100700002)(66476007)(478600001)(41300700001)(6512007)(6506007)(26005)(6666004)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBlazBwR2RhbXRMRElRWHduNWRTTHhveVZIL09CVmFQVEQ4NTRNVkNIWXdo?=
 =?utf-8?B?NEpWcmI1SHYwL1M1alN6dnNlbFR3NzNJRS8wbjRjV29JV1ZObGhaMTRNM2Rk?=
 =?utf-8?B?TkVZM05yUWlMeUhucVI4RXljTHNlTFRCYXowaERBd0pnWmxKQ2t0ckYyTldH?=
 =?utf-8?B?QjFqQjlmY1A0eDh3bXRXbk15YlB0alVJQlBZRUU4T05rNkxRT09JL1NYOEVs?=
 =?utf-8?B?VlZEUkloUzBpTCtXQlJKTE1DTmtsdEdtU0FxMEN6Nzl5OTgzbGhvazduYmdY?=
 =?utf-8?B?bVZrZU5LU3Vjb3RlVkJ0RlRUVU13cGZzNE1GTUNrdkUvWXRsTk1jS21ualZi?=
 =?utf-8?B?anlqRFBoT2YxelVmZjY4VDMzeHZBNlF2VGRuVFRaWUZUNVRTV0tJNnhXQjJM?=
 =?utf-8?B?ZTA3Rjd3ZDlhRzFXTE5vanB6N1JXSDVjMDd0VWZrL3lvdWw5SnlTU0QveFVl?=
 =?utf-8?B?OW54ZG9qZUJTd3MramVFZXhjbGMzZEFYYUVzQWFneU9ZSzdzVnl6TE1RaG5G?=
 =?utf-8?B?Qmt2Y0R1T0grSk5zQ1JLZk1pMGI4Y00wTGczckxmeDlTRWJQYTh4MjYySkhx?=
 =?utf-8?B?bFNDMGVscjdOdmJHNXl1T3k2ZnhRajlJVlFQVFNMOHlGWVkzcjVmTzlHTW1W?=
 =?utf-8?B?V0pmOUFsaC9XMUgrQ21lS2VGR2hHR1RHbWdEandxZFptUmxYdUtabWtuVDB2?=
 =?utf-8?B?dGx4NnZZVHA4UEt2eUF2Z1ZJY3hOSHljMkZGNER2SmZsQ2V2ZGYzWjhQczcw?=
 =?utf-8?B?THVjNDAvUks2TlFhMEh1S2xDS01GWUxHR0pxdU5XQ1JmNVo5VGI5UWhJa2N5?=
 =?utf-8?B?VXYxbVVXV2dhSHhBOHF3ZWJpME5BL1hVQW1uU216amswc2RlcDg1Y1ZRc1BO?=
 =?utf-8?B?S0ZLaXZaYVVmSGNXcXR6QVZyeTY3WENmaVZwayt4aXZTcTFWZms3K2hicEV3?=
 =?utf-8?B?emR0Z1JuUHZaamhhZDgyN2U5VlZUWG5iUDNleUJwNkJ5MlE4dmp5RmdhLytH?=
 =?utf-8?B?QWczRVpibml0Qzg1bitxSXV4K0FwWk1mTzVOWWQwN2tkMHNvdWF5NlBma3V2?=
 =?utf-8?B?YVBSbCsrTnJ1NWNxRmRud0NVY2hvR2JSKzBCbkx4aWFidEM3RXI4OWZLUFlM?=
 =?utf-8?B?L2pNYjJiUFh1NUFvWnJJMjcyL25xSVJJN0Njb3UrQno4WWs4ZVJqQXdDMm15?=
 =?utf-8?B?cU0yV252bDdmcVNUSXFtN0RCODVJOTZlOFlGMW5YY1c3bUxSci9TOUhzd09h?=
 =?utf-8?B?V2FsMDNzN2RLejd1Z0MwN2ZROVFsalBwSkttVElrbE9hMk9JVmh5aEQzbUtO?=
 =?utf-8?B?VmliQytvaHEwWEZYM1QxRnFoblN2ZG5aOVVvYm5pNmk3WTUzOUw0NVZBM2l1?=
 =?utf-8?B?NFhRNU8zeW9UWmxMVEdqQ2NRZERzbndnUWFlYVcxRmR6NHRLeGdRWGJvTmJD?=
 =?utf-8?B?Uys5KzdjUUQxekhlNGlsbGVQMm05WDBPMXM0bVJUN3dMbm9MSXFYSzRZNUYz?=
 =?utf-8?B?ejR3YTA3dm9QdTlCckNrMHVJM0RvNUhpR2dSZ25pM054S2x3ckxQMFMrdmp3?=
 =?utf-8?B?bHlreXp5M2wwUGVRL0tWQnBvcVpLeXROVFAvengyRUVkYmhsYlRlOVFmSm92?=
 =?utf-8?B?ZHprY2lFSVZaTzhNTlNEMVpWZDVoWDl3Nk1YNUtJWWxWTGtocFpqeVVoaDVt?=
 =?utf-8?B?QlUvWlUzSzgvelpqS1JCUTE3RWJ5OHovUXllbWs4SFRiaFJESXdHR2g2OEpq?=
 =?utf-8?B?WHBrZFp3aTV6VXhtSnBXTCt1ajFldWdVdTdhUjlnZmF0ZHJMQzBWMVNHMkti?=
 =?utf-8?B?NFFOYkZXQUF4cjJFOEVRSEdJcU9PR0p2alRYMzRrazFZUEZOVkU5L2ptaVdC?=
 =?utf-8?B?TFo2dko0bUJJcGNTZkdzWGhHeUVZQ252b29FcDlZeE1FSzl2eU1oVm45bGlV?=
 =?utf-8?B?aHp4dnBVRmZFd3laUVllZDJzVFlMRS9OcnpUUmZjdnJRSzg0WWFITEN2Z0pz?=
 =?utf-8?B?UGJFU2RaTUgxbXVPdktqTjIvRWhJTzVsbjRKMUY1NFNzV0FOd3p1aW5Qejhl?=
 =?utf-8?B?WGtXV1hDZURCRlhLRi85L0ZDQkEyRkVkODJxSURjTUFEYklrNzY4T0Q2MFNV?=
 =?utf-8?Q?YGlgifox7s6ujX+92/fmRLAsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58485183-0bd5-418c-2e18-08da74411cbc
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 04:40:23.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rGn9VV/5UPtqcJxo4TBfh7JRb7/CdUKnzeXyLfMtoDgqDzOlS/jCKGWAhP/ZsAyK+PR9nZ+wZz0XYI/a6Q0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Libo,

Thank you for looking into this.

On 8/1/2022 8:27 PM, Libo Chen wrote:
> 
> 
> On 7/28/22 21:47, K Prateek Nayak wrote:
>> Hello Libo and Peter,
>>
>> tl;dr
>>
>> - We observed a major regression with tbench when testing the latest tip
>>    sched/core at:
>>    commit 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
>>    Reason for the regression are the fewer affine wakeups that leaves the
>>    client farther away from the data it needs to consume next primed in the
>>    waker's LLC.
>>    Such regressions can be expected from tasks that use sockets to communicate
>>    significant amount of data especially on system with multiple LLCs.
>>
>> - Other benchmarks have a comparable behavior to the tip at previous commit
>>    commit : 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue
>>    into core tree when update cookie"
>>
>> I'll leave more details below.
>>
>> On 7/12/2022 4:17 AM, Libo Chen wrote:
>>> [..snip..]
>>
>> The two tests kernels used are:
>>
>> - tip at commit: 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
>> - tip at commit: 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue into core tree when update cookie"
>>
>> Below are the tbench result on a dual socket Zen3 machine
>> running in NPS1 mode. Following is the NUMA configuration
>> NPS1 mode:
>>
>> - NPS1: Each socket is a NUMA node.
>>    Total 2 NUMA nodes in the dual socket machine.
>>
>>    Node 0: 0-63,   128-191
>>    Node 1: 64-127, 192-255
>>
>> Clients: tip (91caa5ae2424)      tip (14b3f2d9ee8d)
>>      1    569.24 (0.00 pct)       283.63 (-50.17 pct)    *
>>      2    1104.76 (0.00 pct)      590.45 (-46.55 pct)    *
>>      4    2058.78 (0.00 pct)      1080.63 (-47.51 pct)   *
>>      8    3590.20 (0.00 pct)      2098.05 (-41.56 pct)   *
>>     16    6119.21 (0.00 pct)      4348.40 (-28.93 pct)   *
>>     32    11383.91 (0.00 pct)     8417.55 (-26.05 pct)   *
>>     64    21910.01 (0.00 pct)     19405.11 (-11.43 pct)  *
>>    128    33105.27 (0.00 pct)     29791.80 (-10.00 pct)  *
>>    256    45550.99 (0.00 pct)     45847.10 (0.65 pct)
>>    512    57753.81 (0.00 pct)     49481.17 (-14.32 pct)  *
>>   1024    55684.33 (0.00 pct)     48748.38 (-12.45 pct)  *
>>
>> This regression is consistently reproducible.
> I ran tbench with 1 client on my 8 nodes zen2 machine because 1~4 clients count generally shouldn't be affected by this patch. I do see throughput regresses with the patch but
> the latency improves pretty much equally. Furthermore, I also don't see tbench tasks being separated in different LLC domains from my ftrace, they are almost always in the same CCXes.
> What I do see is there are a lot less interrupts and context switches, and average CPU frequency is slower too with the patch. This is bizarre that Intel doesn't seem to be impacted.
> Trying to understand why right now.

Thank you for analyzing this. I see a drop in max latency with the patch but the
average latency have increased on the patched kernel. Following are the logs from
one of the runs for 1 client case:

- tip (91caa5ae2424)

 Operation                Count    AvgLat    MaxLat
 --------------------------------------------------
 Deltree                     28     0.000     0.001
 Flush                    76361     0.008     0.018
 Close                   800338     0.008     0.080
 LockX                     3546     0.008     0.015
 Mkdir                       14     0.008     0.009
 Rename                   46131     0.008     0.050
 ReadX                  1707761     0.009     0.139
 WriteX                  543274     0.012     0.092
 Unlink                  220019     0.008     0.083
 UnlockX                   3546     0.008     0.016
 FIND_FIRST              381795     0.008     0.079
 SET_FILE_INFORMATION     88740     0.008     0.080
 QUERY_FILE_INFORMATION  173062     0.008     0.061
 QUERY_PATH_INFORMATION  987524     0.008     0.070
 QUERY_FS_INFORMATION    181068     0.008     0.049
 NTCreateX              1089543     0.008     0.083

Throughput 570.36 MB/sec  1 clients  1 procs  max_latency=0.140 ms

- tip (14b3f2d9ee8d)

Operation                Count    AvgLat    MaxLat
 --------------------------------------------------
 Deltree                     14     0.000     0.001
 Flush                    38993     0.017     0.059
 Close                   408696     0.017     0.085
 LockX                     1810     0.017     0.023
 Mkdir                        7     0.016     0.017
 Rename                   23555     0.017     0.052
 ReadX                   871996     0.018     0.097
 WriteX                  277343     0.025     0.105
 Unlink                  112357     0.017     0.055
 UnlockX                   1810     0.017     0.023
 FIND_FIRST              194961     0.017     0.089
 SET_FILE_INFORMATION     45312     0.017     0.032
 QUERY_FILE_INFORMATION   88356     0.017     0.078
 QUERY_PATH_INFORMATION  504289     0.017     0.119
 QUERY_FS_INFORMATION     92460     0.017     0.085
 NTCreateX               556374     0.017     0.097

Throughput 291.163 MB/sec  1 clients  1 procs  max_latency=0.119 ms

I had only analyzed the schedstat data which showed a clear shift
in the number of affine wakeups. I haven't measured the average CPU
frequency during the runs. The numbers reported are with the performance
governor. I'll try to get more data on the CPU frequency front.

>> Below are the statistics gathered from schedstat data:
>>
>> Kernel                                                     :        tip + remove 14b3f2d9ee8d                    tip
>> HEAD commit                                                :             91caa5ae2424                       14b3f2d9ee8d
>> sched_yield cnt                                            :                   11                                 17
>> Legacy counter can be ignored                              :                    0                                  0
>> schedule called                                            :             12621212                           15104022
>> schedule left the processor idle                           :              6306653 ( 49.96% of times )        7547375       ( 49.96% of times )
>> try_to_wake_up was called                                  :              6310778                            7552147
>> try_to_wake_up was called to wake up the local cpu         :                12305 ( 0.19% of times )           12816       ( 0.16% of times )
>> total time by tasks on this processor (in jiffies)         :          78497712520                        72461915902
>> total time waiting tasks on this processor (in jiffies)    :             56398803 ( 0.07% of times )        34631178       ( 0.04% of times )
>> total timeslices run on this cpu                           :              6314548                            7556630
>>
>> Wakeups on same                                    SMT     :                   39 ( 0.00062 )                    263 ( 0.00348 )
>> Wakeups on same                                    MC      :              6297015 ( 99.78% of time ) <---       1079 ( 0.01429 )
>> Wakeups on same                                    DIE     :                  559 ( 0.00886 )                7537909 ( 99.81147 ) <--- With the patch, the task will prefer
> I don't have a zen3 right now. What is the span of your MC domain as well as DIE?

on Zen3, a group in MC domain consists of the 16 CPUs on the same CCD.
On a dual socket Zen3 system (2 x 64C/128T) running in NPS 1 mode,
the DIE domain will consists of all the CPUs on the same socket. There are two
DIE groups in the dual socket test system. Following are the span of each:

- DIE0: 0-63,128-191

    DIE 0 MC 0: 0-7,128-135
    DIE 0 MC 1: 8-15,136-143
    DIE 0 MC 2: 16-23,144-151
    DIE 0 MC 3: 24-31,152-159
    DIE 0 MC 4: 32-39,160-167
    DIE 0 MC 5: 40-47,168-175
    DIE 0 MC 6: 48-55,176-183
    DIE 0 MC 7: 56-63,184-191

- DIE1: 64-127,192-255

    DIE 1 MC 0: 64-71,192-199
    DIE 1 MC 1: 72-79,200-207
    DIE 1 MC 2: 80-87,208-215
    DIE 1 MC 3: 88-95,216-223
    DIE 1 MC 4: 96-103,224-231
    DIE 1 MC 5: 104-111,232-239
    DIE 1 MC 6: 112-119,240-247
    DIE 1 MC 7: 120-127,248-255
> 
> Thanks for the testing.
> 
> Libo
>> Wakeups on same                                    NUMA    :                  860 ( 0.01363 )                     80 ( 0.00106 )       to wake on the same LLC where it previously
>> Affine wakeups on same                             SMT     :                   25 ( 0.00040 )                    255 ( 0.00338 )       ran as compared to the LLC of waker.
>> Affine wakeups on same                             MC      :              6282684 ( 99.55% of time ) <---        961 ( 0.01272 )       This results in performance degradation as
>> Affine wakeups on same                             DIE     :                  523 ( 0.00829 )                7537220 ( 99.80235 ) <--- the task is farther away from data it will
>> Affine wakeups on same                             NUMA    :                  839 ( 0.01329 )                     46 ( 0.00061 )       consume next.
>>
>> All the statistics are comparable except for the reduced number of affine
>> wakeup on the waker's LLC that resulting in task being placed on the previous
>> LLC farther away from the data that resides in the waker's LLC that the wakee
>> will consume next.
>>
>> All wakeups in the tbench, happens in_serving_softirq() making in_taks() false
>> for all the cases where sync would have been true otherwise.
>>
>> We wanted to highlight there are workloads which would still benefit from
>> affine wakeups even when it happens in an interrupt context. It would be
>> great if we could spot such cases and bias wakeups towards waker's LLC.
>>
>> Other benchmarks results are comparable to the tip in most cases.
>> All benchmarks were run on machine configured in NPS1 mode.
>> Following are the results:
>>
>> ~~~~~~~~~
>> hackbench
>> ~~~~~~~~~
>>
>> Test:             tip (91caa5ae2424)      tip (14b3f2d9ee8d)
>>   1-groups:         4.22 (0.00 pct)         4.48 (-6.16 pct)     *
>>   1-groups:         4.22 (0.00 pct)         4.30 (-1.89 pct)     [Verification run]
>>   2-groups:         5.01 (0.00 pct)         4.87 (2.79 pct)
>>   4-groups:         5.49 (0.00 pct)         5.34 (2.73 pct)
>>   8-groups:         5.64 (0.00 pct)         5.50 (2.48 pct)
>> 16-groups:         7.54 (0.00 pct)         7.34 (2.65 pct)
>>
>> ~~~~~~~~
>> schbench
>> ~~~~~~~~
>>
>> #workers: tip (91caa5ae2424)     tip (14b3f2d9ee8d)
>>    1:      22.00 (0.00 pct)        22.00 (0.00 pct)
>>    2:      22.00 (0.00 pct)        27.00 (-22.72 pct)    * Known to have run to run
>>    4:      33.00 (0.00 pct)        38.00 (-15.15 pct)    * variations.
>>    8:      48.00 (0.00 pct)        51.00 (-6.25 pct)     *
>>   16:      70.00 (0.00 pct)        70.00 (0.00 pct)
>>   32:     118.00 (0.00 pct)       120.00 (-1.69 pct)
>>   64:     217.00 (0.00 pct)       223.00 (-2.76 pct)
>> 128:     485.00 (0.00 pct)       488.00 (-0.61 pct)
>> 256:     1066.00 (0.00 pct)      1054.00 (1.12 pct)
>> 512:     47296.00 (0.00 pct)     47168.00 (0.27 pct)
>>
>> Note: schbench results at lower worker count have a large
>> run-to-run variance and depends on certain characteristics
>> of new-idle balance.
>>
>> ~~~~~~
>> stream
>> ~~~~~~
>>
>> - 10 runs
>>
>> Test:     tip (91caa5ae2424)      tip (14b3f2d9ee8d)
>>   Copy:   336140.45 (0.00 pct)    334362.29 (-0.52 pct)
>> Scale:   214679.13 (0.00 pct)    218016.44 (1.55 pct)
>>    Add:   251691.67 (0.00 pct)    249734.04 (-0.77 pct)
>> Triad:   262174.93 (0.00 pct)    260063.57 (-0.80 pct)
>>
>> - 100 runs
>>
>> Test:     tip (91caa5ae2424)      tip (14b3f2d9ee8d)
>>   Copy:   336576.38 (0.00 pct)    334646.27 (-0.57 pct)
>> Scale:   219124.86 (0.00 pct)    223480.29 (1.98 pct)
>>    Add:   251796.93 (0.00 pct)    250845.95 (-0.37 pct)
>> Triad:   262286.47 (0.00 pct)    258020.57 (-1.62 pct)
>>
>> ~~~~~~~~~~~~
>> ycsb-mongodb
>> ~~~~~~~~~~~~
>>
>> tip (91caa5ae2424):   290479.00 (var: 1.53)
>> tip (14b3f2d9ee8d):   287361.67 (var: 0.80) (-1.07 pct)
>>
>>> [..snip..]
> 

Thank you again for looking into this issue and for sharing the
observations on the Zen2 system.
--
Thanks and Regards,
Prateek
