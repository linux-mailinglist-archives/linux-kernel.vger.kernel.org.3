Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF84A9BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356453AbiBDPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:09:00 -0500
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:57728
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbiBDPI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:08:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGncwT8eOorAkZGwRxS0n9VZp7Zhb/mn/zLb204fX7DbsRxRgi+mqjm7/pbDJ2/8QlFchZpq9IYDzyUhlN9GlHlZBQeb6P4W78XKOIwhtDoFbQeKSJq55mVrkD3xSrZFyxd/LEUd0CDyN396OpBmTVGgFaVFYfc3XzaV/7j3NxExHYa0xokv9VOtuC7c/uLiXRwCOg0rtylHS76UAYOM6TeuO+KQZLUL8kM5MqQCSxVAivVCIuFd/+0BcoNJoIwVjDU6Y+77RRfxoLJC20PV6ZRWML1nW3jtXG9gYbHmbPUGt/IALO7L7H+X0aneNsUOlw0hC4CcjLWycAyqSzwo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGQdYWNLUxbLTMZiQogBGfE913Rkz+D+oUr1BiFB5Iw=;
 b=IkSRiSDKDzoeG4SH5V6f+MMVfZyX3R9lDTQVA5gCOvRhNN4BzC/0f/lHVAA//MjQkjiTkDvWIupPfJqhk+DAgH9v0r5RtrUFC90XhwCzKmNg/rwE4BzofPSkFDIfF4O/8QgriI+QTfahxWQYLeWqPZKazdOFyV103Ygt8vnL4KEQ3uu0DY0KOmoawEC1PIN6iKK+tMN25iiss717bqas78BwZvz7fDWiyJc7o2TlpCwPYv0N3Un9YhKOmHqyXVJ3ed5YYdIlCOIjQtwK7q5ct2kHM75QzdvK0HUUeR/ZUxjygfuHujyWUH7RKk1cCwMEKYkbAw9jbhJ+BWbMbDNrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGQdYWNLUxbLTMZiQogBGfE913Rkz+D+oUr1BiFB5Iw=;
 b=tZiz6OtOZr0iPP82OLPvWfqzrGo8RjIK3zIZ9+sbqLge6oGucKdD70kzg1Vlfk0TPyP2HKPIBUY5LoqqqJTy2MTUKdaG+q9ZVhkxt26IXIwr15ILc4m/pz/XLdQi6LZkbfw+1fh97AZOeHrKkENH56JtsLt4tAGWX/3VUJRM5BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BN8PR12MB3555.namprd12.prod.outlook.com (2603:10b6:408:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Fri, 4 Feb
 2022 15:08:09 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::7c2f:df56:1dfd:4f3e]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::7c2f:df56:1dfd:4f3e%4]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 15:08:09 +0000
Message-ID: <9d7e8fe1-d9d7-90df-0f30-cf82b82e7f1f@amd.com>
Date:   Fri, 4 Feb 2022 20:37:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220203144652.12540-1-mgorman@techsingularity.net>
 <20220203144652.12540-3-mgorman@techsingularity.net>
From:   "Nayak, KPrateek (K Prateek)" <kprateek.nayak@amd.com>
In-Reply-To: <20220203144652.12540-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::20) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72184318-f2d1-4788-6ca7-08d9e7f0272c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3555:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35557E434CB5AE61A39D427798299@BN8PR12MB3555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVp+G3lkjYWiIM+u/htTwq4A/YPpxRCONjXxyCCIzEPzNpY4/ACCjBh2+PeR8p7SsoN3rcaWt8THlgKhy1JLWkbPtizbukhkvLqRtKhRoWj4g8Jqw1a0Jr52rmMAvJJXNoTfIJM+gPvMJCbiWP9nq/hkZdW+0dB9JMpxWXvKjg0JOBE9nn4y6Ka5PvtsvBP/MfZQXMbQXYRdemhsThIC7Xpu9sha7hCcJjxBZZLZ0nOg9eV0yWVLcLUt5x/U0mbjYfryAlJ3baow3WUPTP+1PP0aPdzopJ6nXo2iFcAXyFqEUubOnD6+jhYUbr6n9WfH2qg3uJvBzxgjza752jpoBM0lYA6ZbzzYJxgT822novlcjuhll5kyCIn0K8c0H4jEhxPq8g39BJMdLKMZGOrXYif86/FnCutJEMQnlTKYq6InDv2WUprMLvi2XkoU6OB2PF2nv76rcPUq5fF7Y0vBr8jrcoAJRT0ZyX8U27Jm5Mnvt8fu93dZjS5s9/n2SNovQalrXdsDqMfRxGvnPymQb4xJHZu384P8gj7kHtYcwyIWEBoVzgIxfce/1cqwFfSXtkzD9Fryc67KiEdD5+Ki5Gpdyq6/dFJv9evpp3absNo1Kck4cxGG2NYIQUYwAQ0c0wndJPzUOiTQDNShsw1VS7lzSr2+8U3hyc0pFm/wBdZIvb7uI07e0LfKXcFQxtMxauF5+v5IQPbEkm1LU4vrbIVOgY4lUZlUsuZcWMDD6Y0Aqp4lX0qPL9kdaP0DBfarq+bvKF8QbjnbLGLcRi2xtSEisvi1xaBovRI4zdROljjMvXPiqIWortYJ86u64/YD89AVqeTfHTr50XS6koNI83BrLB30OjA5dnc4Kq3p/b0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31686004)(2906002)(5660300002)(2616005)(7416002)(30864003)(4326008)(8936002)(66946007)(110136005)(186003)(26005)(86362001)(54906003)(316002)(83380400001)(8676002)(31696002)(6506007)(53546011)(6666004)(38100700002)(66556008)(66476007)(508600001)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0JyblZITnY4ODJYdDZKYjhDWjYyYmhOS2Y2cmZ5TExxKzYrZWJQRXZvbTJN?=
 =?utf-8?B?WThCK1dyQkF0d04xaGpmUStyMWdHem5aK2JJV0ZlS3daMlFUSDZMbStoOHA5?=
 =?utf-8?B?YWo4eGMyS2ViSjlURUNpSHJ3RW1HOEpIaE91UXBONytSZjI3ajl5Y1dwVjRi?=
 =?utf-8?B?dnkzMUFVOGxYQjEwQ2ZCUmpsRUdtNTB1bWVEd2dCMHUzNGsyaFlXK1VwbkQ5?=
 =?utf-8?B?SGFvbkI2TE9rOTQ4RnZMZS9uUXNaMnVLVDNNdkhNVXdVMnVVR3RpaVdneVQy?=
 =?utf-8?B?VFhNcU1kRXkxYjE3Y1NhaXNVOUZ1aEdsa2hibUhNWU9hYUx0dnR6TFhmaVF3?=
 =?utf-8?B?U0Y5SDlzSjcycGJlajdKTmV6NDd0SGZoVURrL3E0T0JhalJCOFpIdGFCTFZS?=
 =?utf-8?B?Vm5WUnRtekFLTDlqVG94Zzd3U2UxazJmeENpVkJ3dDlNVW8xNXpaSW9Ya2Uz?=
 =?utf-8?B?WG1XS1VVSkxkZmFVQ25kWEtZUFU3S2h5U0JEZklXOWNQdWtoR1V2Mkt0LzZ5?=
 =?utf-8?B?dE9LdytEdXl2NFRmN3Y0RkF0MmNsV3NpNnh3ZEsxV1N5SkNONmFMTDVuSkFv?=
 =?utf-8?B?NFlPdXAvQXpuY2NKTExiYlhEZjdVVm1XbWU0eUJsUzh4ZnFCVDV5UzJZdUto?=
 =?utf-8?B?c2R3R0lab2tjbHVmRmlJaktqdFVDKzJoTElSQzB1aFBnTHpXY3FQMnUxZ1Nt?=
 =?utf-8?B?MTJ4a00wSmZZMTF6OXlJUGZ2bzk4RHBWWTNQQUd4YVNsVDRncXdlOThubENz?=
 =?utf-8?B?VGFldjZ5cUlBd2JHMDdRYURvbTRwV1o0dy9NMDAzOGZwWUxUd3hWK2VwODVq?=
 =?utf-8?B?WnlGU2ZiRzh2RzFyNWYycHI2NTRKT1FqZGJ1K3RGOWFWUDRYOEZDYzR4dFVo?=
 =?utf-8?B?L1RzdGhyOG9WdU8vTkxKbk1FWW1JTWNCcVc2ZzU1NmNWcFB4ZTJhcXNGKzJw?=
 =?utf-8?B?Q0E5RFkxWFVQdWV0aWdLM0FRNGVrOStRWlN3TEd5WVBqWWlsTzFFamQ2ZUF0?=
 =?utf-8?B?Z1QvOFNZdEZVei9OcStuZmJJREkzbThRcEJEcU5PcFU1Q3JHMWI1K2lqKy84?=
 =?utf-8?B?UmNLaW1GdlI5Q1prQ1hpWXpYVXAwcUtId0FFRnlZZ0xDU3A1ZTRmbkpXcGdB?=
 =?utf-8?B?bE5tL0JlRW4yT21oQU1rSWgrU1I4RXAzTzF5N0plaUlSQkx5L3VHSW1zWktm?=
 =?utf-8?B?a0dlUWpxZ2hmQUlDaFU3SlJwbUlNNWFWcVM1NHh0cnIxZDI5SHBaU3VGbXd4?=
 =?utf-8?B?N2ZJTXpDM2RPZTRzeFJwbXNucFBwUHV0ZGZsNG5pblJJM0U0dlJ1azV3MUp6?=
 =?utf-8?B?REw0REJWeHNiNTNzZys4RmZUTFJkTmRwOUo1MnpsaW5EV0paeWUxS0EvWGpR?=
 =?utf-8?B?SGg1N3hvb2YrYm1aUE5uZU9rbHhxNmRFeENSVDVpejRDRlVZZC9TL29OaERR?=
 =?utf-8?B?OGlFcEJNM1U4bm9KM1RLRTZ1Y1h3dHZZbHA3NGtzZ2xkTTdjUCtLdVFhNHBl?=
 =?utf-8?B?VkhHUnJEV1phanVyYXN6NDRUN1p0QVk5TW83UlhZYXplOWU0b2tVWENvWmVr?=
 =?utf-8?B?cDl6dzVNZG1qdU1TbXo1WW1vbktNMVJXdzBKNFp1R3dPMnRMcUgwTDAzVGVq?=
 =?utf-8?B?NUZjN0dlc3dBdG51eDJDeElYSDJUNC90NytoRitIYSs3Y2xEbS9KTzhnSGZx?=
 =?utf-8?B?T2k4aFlHV0dwcEFSOTBCQlFDdFBjUjdhY3YxYllrSGVseFI3K0tkR0oyWmNa?=
 =?utf-8?B?TnplbmhkK0RuWHJvdHlVK0U3MFg1WVVSLzBjdmRtYVVsYVBVU1JYMEZvazZy?=
 =?utf-8?B?cStVdzIwZkQvclVlNWgwYU9YWWJsbHhDeWhiNm5ER3F6cmhRT2tKZXN5YkN3?=
 =?utf-8?B?NzR3WFpLNnBlc0pRU0JCRjJubWoxT3dzVHI5QTFjMFdrdmszNnRnOXJjVlo2?=
 =?utf-8?B?Z1JHQnE1bkl3ejgxaW54bVJBdndrbUlVdmw5VHg2d0FUbXNvWFlCSUYzc0U2?=
 =?utf-8?B?UkZVb2ZMUHdKbEgxdm1icnppR2szenpiWU9Lbnp0ZjJpKzhLRk5Gck1qT1lD?=
 =?utf-8?B?eXhMZkExcVR5QkF3L2dxbnFzall3VmxNVnpKSXREbndYQ2U4dmNwdFFjNmJi?=
 =?utf-8?B?Z2I0ZVoxaGY4V0RHaWJ1Y2JuMzN1bGREMUcxOUtmUDdxcHVwWHQ1QzBCMWc4?=
 =?utf-8?Q?PY89Iqty4Ku9Daw+5vzx3Xw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72184318-f2d1-4788-6ca7-08d9e7f0272c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 15:08:08.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHFtRPeu4KDpwsYueyH/oqY1HmzEq/Ze7dxR6fGO/XLXGEAPPDc6EXS3u1T+opwWMDEBG1nKTVHXHX1+a1jK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On 2/3/2022 8:16 PM, Mel Gorman wrote:
> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> nodes") allowed an imbalance between NUMA nodes such that communicating
> tasks would not be pulled apart by the load balancer. This works fine when
> there is a 1:1 relationship between LLC and node but can be suboptimal
> for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
> 
> Zen* has multiple LLCs per node with local memory channels and due to
> the allowed imbalance, it's far harder to tune some workloads to run
> optimally than it is on hardware that has 1 LLC per node. This patch
> allows an imbalance to exist up to the point where LLCs should be balanced
> between nodes.
> 
> On a Zen3 machine running STREAM parallelised with OMP to have on instance
> per LLC the results and without binding, the results are
> 
>                             5.17.0-rc0             5.17.0-rc0
>                                vanilla       sched-numaimb-v5
> MB/sec copy-16    162596.94 (   0.00%)   501967.12 ( 208.72%)
> MB/sec scale-16   136901.28 (   0.00%)   376531.50 ( 175.04%)
> MB/sec add-16     157300.70 (   0.00%)   569997.42 ( 262.36%)
> MB/sec triad-16   151446.88 (   0.00%)   553204.54 ( 265.28%)
> 
> STREAM can use directives to force the spread if the OpenMP is new
> enough but that doesn't help if an application uses threads and
> it's not known in advance how many threads will be created.
> 
> Coremark is a CPU and cache intensive benchmark parallelised with
> threads. When running with 1 thread per core, the vanilla kernel
> allows threads to contend on cache. With the patch;
> 
>                                5.17.0-rc0             5.17.0-rc0
>                                   vanilla       sched-numaimb-v5
> Min       Score-16   368239.36 (   0.00%)   400876.92 (   8.86%)
> Hmean     Score-16   388607.33 (   0.00%)   441447.30 *  13.60%*
> Max       Score-16   408945.69 (   0.00%)   478826.87 (  17.09%)
> Stddev    Score-16    15247.04 (   0.00%)    34061.76 (-123.40%)
> CoeffVar  Score-16        3.92 (   0.00%)        7.67 ( -95.82%)
> 
> It can also make a big difference for semi-realistic workloads
> like specjbb which can execute arbitrary numbers of threads without
> advance knowledge of how they should be placed
> 
>                                5.17.0-rc0             5.17.0-rc0
>                                   vanilla       sched-numaimb-v5
> Hmean     tput-1      71631.55 (   0.00%)    70383.46 (  -1.74%)
> Hmean     tput-8     582758.78 (   0.00%)   607290.89 *   4.21%*
> Hmean     tput-16   1020372.75 (   0.00%)  1031257.25 (   1.07%)
> Hmean     tput-24   1416430.67 (   0.00%)  1587576.33 *  12.08%*
> Hmean     tput-32   1687702.72 (   0.00%)  1724207.51 (   2.16%)
> Hmean     tput-40   1798094.90 (   0.00%)  1983053.56 *  10.29%*
> Hmean     tput-48   1972731.77 (   0.00%)  2157461.70 (   9.36%)
> Hmean     tput-56   2386872.38 (   0.00%)  2193237.42 (  -8.11%)
> Hmean     tput-64   2536954.17 (   0.00%)  2588741.08 (   2.04%)
> Hmean     tput-72   2585071.36 (   0.00%)  2654776.36 (   2.70%)
> Hmean     tput-80   2960523.94 (   0.00%)  2894657.12 (  -2.22%)
> Hmean     tput-88   3061408.57 (   0.00%)  2903167.72 (  -5.17%)
> Hmean     tput-96   3052394.82 (   0.00%)  2872605.46 (  -5.89%)
> Hmean     tput-104  2997814.76 (   0.00%)  3013660.26 (   0.53%)
> Hmean     tput-112  2955353.29 (   0.00%)  3029122.16 (   2.50%)
> Hmean     tput-120  2889770.71 (   0.00%)  2957739.88 (   2.35%)
> Hmean     tput-128  2871713.84 (   0.00%)  2912410.18 (   1.42%)
> 
> In general, the standard deviation figures also are a lot more
> stable.
> 
> Similarly, for embarassingly parallel problems like NPB-ep, there are
> improvements due to better spreading across LLC when the machine is not
> fully utilised.
> 
>                               vanilla    sched-numaimb-v5r12
> Min       ep.D       31.79 (   0.00%)       26.11 (  17.87%)
> Amean     ep.D       31.86 (   0.00%)       26.26 *  17.58%*
> Stddev    ep.D        0.07 (   0.00%)        0.18 (-157.54%)
> CoeffVar  ep.D        0.22 (   0.00%)        0.69 (-212.46%)
> Max       ep.D       31.93 (   0.00%)       26.46 (  17.13%)
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 22 +++++++-------
>  kernel/sched/topology.c        | 53 ++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 8054641c0a7b..56cffe42abbc 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -93,6 +93,7 @@ struct sched_domain {
>  	unsigned int busy_factor;	/* less balancing by factor if busy */
>  	unsigned int imbalance_pct;	/* No balance until over watermark */
>  	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
> +	unsigned int imb_numa_nr;	/* Nr running tasks that allows a NUMA imbalance */
>  
>  	int nohz_idle;			/* NOHZ IDLE status */
>  	int flags;			/* See SD_* */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4592ccf82c34..86abf97a8df6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1489,6 +1489,7 @@ struct task_numa_env {
>  
>  	int src_cpu, src_nid;
>  	int dst_cpu, dst_nid;
> +	int imb_numa_nr;
>  
>  	struct numa_stats src_stats, dst_stats;
>  
> @@ -1503,7 +1504,7 @@ struct task_numa_env {
>  static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
>  static inline long adjust_numa_imbalance(int imbalance,
> -					int dst_running, int dst_weight);
> +					int dst_running, int imb_numa_nr);
>  
>  static inline enum
>  numa_type numa_classify(unsigned int imbalance_pct,
> @@ -1884,7 +1885,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		dst_running = env->dst_stats.nr_running + 1;
>  		imbalance = max(0, dst_running - src_running);
>  		imbalance = adjust_numa_imbalance(imbalance, dst_running,
> -							env->dst_stats.weight);
> +						  env->imb_numa_nr);
>  
>  		/* Use idle CPU if there is no imbalance */
>  		if (!imbalance) {
> @@ -1949,8 +1950,10 @@ static int task_numa_migrate(struct task_struct *p)
>  	 */
>  	rcu_read_lock();
>  	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
> -	if (sd)
> +	if (sd) {
>  		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
> +		env.imb_numa_nr = sd->imb_numa_nr;
> +	}
>  	rcu_read_unlock();
>  
>  	/*
> @@ -9003,10 +9006,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * This is an approximation as the number of running tasks may not be
>   * related to the number of busy CPUs due to sched_setaffinity.
>   */
> -static inline bool
> -allow_numa_imbalance(unsigned int running, unsigned int weight)
> +static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
>  {
> -	return (running < (weight >> 2));
> +	return running < imb_numa_nr;
>  }
>  
>  /*
> @@ -9146,7 +9148,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  			 * allowed. If there is a real need of migration,
>  			 * periodic load balance will take care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))

Could you please clarify why are we adding 1 to local_sgs.sum_nr_running while allowing imbalance?
allow_numa_imbalance allows the imbalance based on the following inequality:

	running < imb_numa_nr

Consider on a Zen3 CPU with 8 LLCs in the sched group of the NUMA domain.
Assume the group is running 7 task and we are finding the idlest group for the 8th task:

 	sd->imb_numa_nr = 8
	local_sgs.sum_nr_running = 7

In this case, local_sgs.sum_nr_running + 1 is equal to sd->imb_numa_nr and if we allow NUMA imbalance
and place the task in the same group, each task can be given one LLC.
However, allow_numa_imbalance returns 0 for the above case and can lead to task being placed on a different
NUMA group.

In case of Gautham's suggested fix (https://lore.kernel.org/lkml/YcHs37STv71n4erJ@BLR-5CG11610CF.amd.com/),
the v4 patch in question (https://lore.kernel.org/lkml/20211210093307.31701-3-mgorman@techsingularity.net/)
used the inequality "<=" to allow NUMA imbalance where we needed to consider the additional load CPU had
to bear. However that doesn't seem to be the case here.

>  				return NULL;
>  		}
>  
> @@ -9238,9 +9240,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  #define NUMA_IMBALANCE_MIN 2
>  
>  static inline long adjust_numa_imbalance(int imbalance,
> -				int dst_running, int dst_weight)
> +				int dst_running, int imb_numa_nr)
>  {
> -	if (!allow_numa_imbalance(dst_running, dst_weight))
> +	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
>  		return imbalance;
>  
>  	/*
> @@ -9352,7 +9354,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		/* Consider allowing a small imbalance between NUMA groups */
>  		if (env->sd->flags & SD_NUMA) {
>  			env->imbalance = adjust_numa_imbalance(env->imbalance,
> -				local->sum_nr_running + 1, local->group_weight);
> +				local->sum_nr_running + 1, env->sd->imb_numa_nr);
>  		}
>  
>  		return;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..e6cd55951304 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2242,6 +2242,59 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  		}
>  	}
>  
> +	/*
> +	 * Calculate an allowed NUMA imbalance such that LLCs do not get
> +	 * imbalanced.
> +	 */
> +	for_each_cpu(i, cpu_map) {
> +		unsigned int imb = 0;
> +		unsigned int imb_span = 1;
> +
> +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> +			struct sched_domain *child = sd->child;
> +
> +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> +				struct sched_domain *top, *top_p;
> +				unsigned int nr_llcs;
> +
> +				/*
> +				 * For a single LLC per node, allow an
> +				 * imbalance up to 25% of the node. This is an
> +				 * arbitrary cutoff based on SMT-2 to balance
> +				 * between memory bandwidth and avoiding
> +				 * premature sharing of HT resources and SMT-4
> +				 * or SMT-8 *may* benefit from a different
> +				 * cutoff.
> +				 *
> +				 * For multiple LLCs, allow an imbalance
> +				 * until multiple tasks would share an LLC
> +				 * on one node while LLCs on another node
> +				 * remain idle.
> +				 */

To add to my point above, the comment here says -
"allow an imbalance until multiple tasks would share an LLC on one node"
Whereas, in the case I highlighted above, we see balancing kick in with possibly
one LLC being unaccounted for. 

> +				nr_llcs = sd->span_weight / child->span_weight;
> +				if (nr_llcs == 1)
> +					imb = sd->span_weight >> 2;
> +				else
> +					imb = nr_llcs;
> +				sd->imb_numa_nr = imb;
> +
> +				/* Set span based on the first NUMA domain. */
> +				top = sd;
> +				top_p = top->parent;
> +				while (top_p && !(top_p->flags & SD_NUMA)) {
> +					top = top->parent;
> +					top_p = top->parent;
> +				}
> +				imb_span = top_p ? top_p->span_weight : sd->span_weight;
> +			} else {
> +				int factor = max(1U, (sd->span_weight / imb_span));
> +
> +				sd->imb_numa_nr = imb * factor;
> +			}
> +		}
> +	}
> +
>  	/* Calculate CPU capacity for physical packages and nodes */
>  	for (i = nr_cpumask_bits-1; i >= 0; i--) {
>  		if (!cpumask_test_cpu(i, cpu_map))

Please correct me if I'm wrong.

Thanks and Regards
Prateek
