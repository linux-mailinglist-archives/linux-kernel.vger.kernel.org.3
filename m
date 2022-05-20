Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2D52E541
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiETGst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiETGsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:48:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0414CDD8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaHU9OrBf6+LbvJmxYzYwYf7oIL39BMa54XAnhWXrubpto9sLPGKiUphFgYurr/3do7+34euHIgbI4lUpZ9QLJWltOAjlHMEDigPevSk1dhHBkCegoQje2YcR6hQ5wOrYBb8/RAyZFrepniUwoMay72v4mKzJ+Oh3w3rQSIPBqpbfbFyJZ7pceiVuUBxgkmZo4PlLuVyciXyeZ00lTN9ZUhs+5ogiXdxdtngiHUuIBTAlO/huFxl52tXUMAE3RHUnfnkglbhvIT/J7kVJLMyb0ivtvTN7xMRDEy6htf78aPpA09jgAMpd7srPXBp206N3aIFnCSAiFRIZeZ+d58KdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK+GJ9Gn4N3ZPj1JSyK1PuvIIcuIF4T5ZxMJ/g4pt3c=;
 b=Qq9WJ3p4oi7SDsk5T3fm1ma2eaJoYOQ3BRnInisV1QQmE3FGM2X6rtFP2YL5KKZH6/SvYSrmqv4OHCuiy+0VRVdKldM9QxEPRNzXwm7giyw6FsweNhDOpn4l9tEWLoWvpspMihOsIzVu/eWjBhmTc+PGsv3ErXgQnx1kRaoCSEztDPA0F9wkolIzDF1iZCINrOtYBfzPqoyoeMKwepJLzLSx0kKuhpAkdIu2TaUzWdin+0P816KlZPRaaQGdf5PFccqZ8C8mzAVIVYZBeGL+aUGdwUerSsduPzM+KXVxsq6Km5JHipkxy+U1P3gp08MYFPac8kMe550dc3kZ9L9u/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK+GJ9Gn4N3ZPj1JSyK1PuvIIcuIF4T5ZxMJ/g4pt3c=;
 b=fPTMsMz9JcNes75a+nFbCJpKetIh3TXQ9smI+yqjo0N+xygHkPuSU0bl0K5dXPmOk/y7sJIYz8PQ7OCSFBq9DpYGJprNCxxHkcEUGb5iNP46dTWXGpsAv0d85DyWH3+zq5u4oapXY19hmKuDXGfJIYRDc3ZK+Mmcd2HD/FR5bQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB3003.namprd12.prod.outlook.com (2603:10b6:5:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Fri, 20 May
 2022 06:48:41 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 06:48:41 +0000
Message-ID: <8a369b3c-58cd-84cb-d206-255dcc66e3e4@amd.com>
Date:   Fri, 20 May 2022 12:18:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220505122331.42696-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1442f026-6cd4-4a15-14c3-08da3a2cc63f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3003:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB300385382E669C5D2CE07E3098D39@DM6PR12MB3003.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPHEwRmPS7ku59Y6NpBYlf+Z4WFDjiiR0eEcPodWGgYPrAXyDRb/TjANXFIuA8Wdacqd0vMXWTIfhfCOt28ULIwIdRmyhmGJdiWMQxd4CypndITpECKNQkFGPRpKWr7Rcl+dR1diDJdW9+aslma3Rbev2qOJtibSUKKKzlbqLr+0yvaSHi3RHJRvDbkw/Z1EeTtM+oT/MMelmjeT90XuDXROeB4JmSQrZybNewgQWFAZ60OvsJ0H6/bHwj8PL3s4zs2XXNk6IzovVH1lt6W54CBA40FkVRqoGSsO+V5Jb/oV+1iM1NsVug52DR+97/kr7ubp49NdCoJRmQuPzceBHhJxeM2s083SOUIT1WBZGJOjXB8HhdxEo1bR3nBD1b3MdJTb7wIkHLwkLOSI+AbDPBvd+e46YgmxsaMb6nIhaMDngSnWXLl7ZkdVZ37dQngcVbLES/tTkC0VunCKVloxHgqubb9hIkVvW4Celhb5gOiCPvuMInPwRuO5e8atcez10+FJjxYudWi6P3CqQhoiiNDcyC4eXv/MWJIe11WZhQUxtwGIICOk27u/cFg8bS+1Snqgk3ZBF6hcvJnHTDOjNm80vqfrDhCi9q4Rk5KQaE+tuCE4JmUl2DIcKp/rTMuOjLTC9oCmGqge/UHrQhBt/1Esq9/g8ej200A+fWUAz8ia8BmZOfP47vv7YZgi3mTbMZygcQvqD/EKoEQv9cddyv3RCs3c7GxoQ5ZbMw0Nnr7pKe1Qq8s6GvxyoDuRBkNN3mAjLyk0YkvtMsoGdUVFFwpUbpISxSehi8n0yarYGcvq4F2uK9S+Un0putAa8VWY49CnE/4T0cqsLk8GS6tQZiYC+o+ssVUCLBga+8P970o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(40140700001)(38100700002)(31696002)(966005)(6666004)(66476007)(26005)(66556008)(110136005)(6486002)(508600001)(2906002)(316002)(8676002)(86362001)(4326008)(83380400001)(36756003)(6512007)(66946007)(8936002)(5660300002)(53546011)(186003)(30864003)(2616005)(31686004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZOWWFhZUZzTmo0NklwS200dERaOTk3dTQ0R1prL0xxWE1KWXQwdDZMNnRY?=
 =?utf-8?B?VW52NnRpdy9SNDQrME13V2lMSmVGUmtXRjh1R1RnSmJpa21WdUhJazd6Y2hC?=
 =?utf-8?B?WDV5dnNkaU5PcnY5cGhVemowVjhvYWREK2p3NVlYVW9QMW4vcElQSHcvdWU3?=
 =?utf-8?B?ZUJrWTE2M3R5UDV2VVpialUzV0tkWVpyWDJLa25MS3pYbmtVaWZlTnlldkpC?=
 =?utf-8?B?U1BCaFlIdnBRRCtublRnU0FMMVJGcGI2aXcyekRPWU42ZUxrQlBpcU1TR09k?=
 =?utf-8?B?bTNiUXV2aU9scitCajdGTi9USE0wVHZBSHVScDRySUF3bVAyOEZMQ0JuQjNW?=
 =?utf-8?B?ZU03RVBGQVZCYzFCeFdVVklmR1QwNWZNaGJESGNWaE9Icm50dmNUR1NBR3A0?=
 =?utf-8?B?a096U0xaYW5wa28rUWtoRmxHSCtJd2x1SjJjUDlrRno1WU9OWktXa0xreFdB?=
 =?utf-8?B?R1V0Ym9YaWRvbnYyWERQVWNDNGxqUmF1b2ptcVQ5NE5CTzFVSzMvRXplZXpa?=
 =?utf-8?B?SXdOOVlhaVBwa0F5WWJrUUFZVEZuS3gxVVQ1QnZTUHBqajd3VVYwRldQNStx?=
 =?utf-8?B?S1Z2NzBtYko0QlE1cTl6Rk56TDBkZklaeTArWlZ5T1Z1UnNjL0EwNWd2U1RH?=
 =?utf-8?B?cUY4blpMTTZCL3RKTWx1SUZzL1JNeG41dExaTnR3c0IxUzMzUzlOUjVlMCty?=
 =?utf-8?B?enA0ZGMrek8yZkFIS2o1bDVxdUFvYkR0Uy9xc2d5RVdOR1ZVajR5QmdJYUVr?=
 =?utf-8?B?MFVKa0tLV0p5dGhwbWNUODdYTkNlU0xuS2pYejFhcWZ4R1JKWlNDY3RJQ20v?=
 =?utf-8?B?elpUUHh3Y0pUK2UvRDhMekk3Q3JFTXhjQ1dpdHZlVW5OZkd0YTNBYlBKTWVI?=
 =?utf-8?B?dVhOSVl5RFlLUU9wWlN0YnY1MWpKSGpZSllmWjVVcHRWSWNSM2pGR3Bva0Rx?=
 =?utf-8?B?Mk1OazhMZjlCUFh5eEdIV0RITy9GYlZWSFZUSWpwMkVvZ0Zxd0tWY1JHUDBJ?=
 =?utf-8?B?Q21oeTltZE51WFpjZ0xBTGJFeVNMMkd3UzVwNEJjLzBtaDk4ZFI3Rlc2K2JJ?=
 =?utf-8?B?UndiQ2xMYmc5MkhUU0lTM1NLMFllbytmNnoxdHRmZkpLK0RCS3IraktyQi93?=
 =?utf-8?B?eDdXbENWWitYUVN1a0wrWmUxUmNEWkNJSTdIamdLOW5QQWpYYlNhbUNsVXkz?=
 =?utf-8?B?eDZib0U3WUNtTG94MGJmeGVtdm12RzlQRThJTnIrT2xnenk2a1A4RkZqTk5Y?=
 =?utf-8?B?N1VLZ2ZRbmNMVW9YcEVJakZwaHpVb09VS2dRc2x0M0E4bGxoUFFLRFJBRnho?=
 =?utf-8?B?STBPcDBJSm9LL2dBS09TODk4VmNqYzVUdFkxVVZ4ZnRCNDJnVjFseUwzNHBR?=
 =?utf-8?B?MTg4bGRXa1VDNzZ5ZDZPck5UUE5rNWVmTUVBMjBTdy9tNW9JREI5cnJDazdM?=
 =?utf-8?B?L1FXcmRHd3JDZ2VuTVVaQWQ0T29tbml1aWpZbzdtRTMxWmMrODd4QlVQKzBz?=
 =?utf-8?B?RmpiTTA5b29wbFRpVVZhR3lSRnB3amsrRytOUmg4WXVFd3BLamdJVE9WZXlK?=
 =?utf-8?B?b2ZJZUVSV1dNN09ZUGk2OW1LM2Q5K2JvZFR4T0c1ajdNTnBUbTYvRVRSaVpG?=
 =?utf-8?B?cDRRVXdxWkJwSWpybUxKTjd4VEI3eXRRRzhSOTVCS1ZoUjlVQVNiUk1MbURm?=
 =?utf-8?B?S05XT0ZJUFZnaC9McjlXb2VZVXlaSWNOVWhURGRZZnBsa3M5alBNeFVNeGt3?=
 =?utf-8?B?d0xGN2k0cVJYYXRJbEREeG9Gd1UzNkUrdm1PQnJwYzlLeGc5Sm9nQ2JCZVda?=
 =?utf-8?B?cENEWkFWdThINFpTb3RScVAyZGYxQ25RQXNOVWRSRjFMei90VFY4YTFNWmgz?=
 =?utf-8?B?c2kraWJ6RGpXRGxJdlYxVGdRV2xxK2J3dGhNMHRrV2ZabTVBUk1aeDNJWkZV?=
 =?utf-8?B?d1c3RDdpdmI4dk1lWTRseHBwbUhaOElrenBMSFA5eHJRNFB2TmFwbG1KY2NI?=
 =?utf-8?B?cjBqNjVmaWVzeG85Y0hWN1duS1hzT1VqV0dVZlN0NWplYldkcWhuU0VLeStJ?=
 =?utf-8?B?QWcrZVdzbi9zc2dhVnU3ajBBVzhRWm9XSWxwVFhTS1gxWmYzaElzbTZvZTlq?=
 =?utf-8?B?NEVlb2dlMGU3clcyT2o4aVNKelZOM3dER21VblBJZW41Qm9idTJnUmpsMzdG?=
 =?utf-8?B?WlJLYUxDOVFWWVF0MnVaSFMzTFhIMlQ2SDZYTVN2V0piRFBNZW5GbkJkb2hE?=
 =?utf-8?B?c1NReE0zNDNOT1ZJT1Vra3h6WWVueHhZd0pzYzJGOHhtOGV3WlYvekF2ODI2?=
 =?utf-8?B?dXM2R3dEY1ZsNTVOakpXaU1lRTY2NWNvWjZlTzBkQXFGNmFzL2RrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1442f026-6cd4-4a15-14c3-08da3a2cc63f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 06:48:40.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU+0tH2ceweY53brrDrVscWJ6WGrgEJyDVKoFUklNhoQfbDM3ZUIh7kgZBJCD8XHdGSKUKTnJV57iMGY7quITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3003
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

We tested this patch on our systems.

tl;dr

- We observed some regressions in schbench with 128 workers in
  NPS4 mode.
- tbench shows regression for 32 workers in NPS2 mode and 64 workers
  in NPS2 and NPS4 mode.
- Great improvements in schbench for low worker count.
- Overall, the performance seems to be comparable to the tip.

Below are the detailed numbers for each benchmark.

On 5/5/2022 5:53 PM, Abel Wu wrote:
> Try to improve searching efficiency of SIS by filtering out the
> overloaded cpus, and as a result the more overloaded the system
> is, the less cpus will be searched.
> 
> The overloaded cpus are tracked through LLC shared domain. To
> regulate accesses to the shared data, the update happens mainly
> at the tick. But in order to make it more accurate, we also take
> the task migrations into consideration during load balancing which
> can be quite frequent due to short running workload causing newly-
> idle. Since an overloaded runqueue requires at least 2 non-idle
> tasks runnable, we could have more faith on the "frequent newly-
> idle" case.
> 
> Benchmark
> =========
> 
> Tests are done in an Intel(R) Xeon(R) Platinum 8260 CPU@2.40GHz
> machine with 2 NUMA nodes each of which has 24 cores with SMT2
> enabled, so 96 CPUs in total.
> 
> All of the benchmarks are done inside a normal cpu cgroup in a
> clean environment with cpu turbo disabled.
> 
> Based on tip sched/core 089c02ae2771 (v5.18-rc1).
> 
> Results
> =======
> 
> hackbench-process-pipes
>                              vanilla		     filter
> Amean     1        0.2537 (   0.00%)      0.2330 (   8.15%)
> Amean     4        0.7090 (   0.00%)      0.7440 *  -4.94%*
> Amean     7        0.9153 (   0.00%)      0.9040 (   1.24%)
> Amean     12       1.1473 (   0.00%)      1.0857 *   5.37%*
> Amean     21       2.7210 (   0.00%)      2.2320 *  17.97%*
> Amean     30       4.8263 (   0.00%)      3.6170 *  25.06%*
> Amean     48       7.4107 (   0.00%)      6.1130 *  17.51%*
> Amean     79       9.2120 (   0.00%)      8.2350 *  10.61%*
> Amean     110     10.1647 (   0.00%)      8.8043 *  13.38%*
> Amean     141     11.5713 (   0.00%)     10.5867 *   8.51%*
> Amean     172     13.7963 (   0.00%)     12.8120 *   7.13%*
> Amean     203     15.9283 (   0.00%)     14.8703 *   6.64%*
> Amean     234     17.8737 (   0.00%)     17.1053 *   4.30%*
> Amean     265     19.8443 (   0.00%)     18.7870 *   5.33%*
> Amean     296     22.4147 (   0.00%)     21.3943 *   4.55%*
> 
> There is a regression in 4-groups test in which case lots of busy
> cpus can be found in the system. The busy cpus are not recorded in
> the overloaded cpu mask, so we trade overhead for nothing in SIS.
> This is the worst case of this feature.
> 
> hackbench-process-sockets
>                              vanilla		     filter
> Amean     1        0.5343 (   0.00%)      0.5270 (   1.37%)
> Amean     4        1.4500 (   0.00%)      1.4273 *   1.56%*
> Amean     7        2.4813 (   0.00%)      2.4383 *   1.73%*
> Amean     12       4.1357 (   0.00%)      4.0827 *   1.28%*
> Amean     21       6.9707 (   0.00%)      6.9290 (   0.60%)
> Amean     30       9.8373 (   0.00%)      9.6730 *   1.67%*
> Amean     48      15.6233 (   0.00%)     15.3213 *   1.93%*
> Amean     79      26.2763 (   0.00%)     25.3293 *   3.60%*
> Amean     110     36.6170 (   0.00%)     35.8920 *   1.98%*
> Amean     141     47.0720 (   0.00%)     45.8773 *   2.54%*
> Amean     172     57.0580 (   0.00%)     56.1627 *   1.57%*
> Amean     203     67.2040 (   0.00%)     66.4323 *   1.15%*
> Amean     234     77.8897 (   0.00%)     76.6320 *   1.61%*
> Amean     265     88.0437 (   0.00%)     87.1400 (   1.03%)
> Amean     296     98.2387 (   0.00%)     96.8633 *   1.40%*
> 
> hackbench-thread-pipes
>                              vanilla		     filter
> Amean     1        0.2693 (   0.00%)      0.2800 *  -3.96%*
> Amean     4        0.7843 (   0.00%)      0.7680 (   2.08%)
> Amean     7        0.9287 (   0.00%)      0.9217 (   0.75%)
> Amean     12       1.4443 (   0.00%)      1.3680 *   5.29%*
> Amean     21       3.5150 (   0.00%)      3.1107 *  11.50%*
> Amean     30       6.3997 (   0.00%)      5.2160 *  18.50%*
> Amean     48       8.4183 (   0.00%)      7.8477 *   6.78%*
> Amean     79      10.0713 (   0.00%)      9.2240 *   8.41%*
> Amean     110     10.9940 (   0.00%)     10.1280 *   7.88%*
> Amean     141     13.6347 (   0.00%)     11.9387 *  12.44%*
> Amean     172     15.0523 (   0.00%)     14.4117 (   4.26%)
> Amean     203     18.0710 (   0.00%)     17.3533 (   3.97%)
> Amean     234     19.7413 (   0.00%)     19.8453 (  -0.53%)
> Amean     265     23.1820 (   0.00%)     22.8223 (   1.55%)
> Amean     296     25.3820 (   0.00%)     24.2397 (   4.50%)
> 
> hackbench-thread-sockets
>                              vanilla		     filter
> Amean     1        0.5893 (   0.00%)      0.5750 *   2.43%*
> Amean     4        1.4853 (   0.00%)      1.4727 (   0.85%)
> Amean     7        2.5353 (   0.00%)      2.5047 *   1.21%*
> Amean     12       4.3003 (   0.00%)      4.1910 *   2.54%*
> Amean     21       7.1930 (   0.00%)      7.1533 (   0.55%)
> Amean     30      10.0983 (   0.00%)      9.9690 *   1.28%*
> Amean     48      15.9853 (   0.00%)     15.6963 *   1.81%*
> Amean     79      26.7537 (   0.00%)     25.9497 *   3.01%*
> Amean     110     37.3850 (   0.00%)     36.6793 *   1.89%*
> Amean     141     47.7730 (   0.00%)     47.0967 *   1.42%*
> Amean     172     58.4280 (   0.00%)     57.5513 *   1.50%*
> Amean     203     69.3093 (   0.00%)     67.7680 *   2.22%*
> Amean     234     80.0190 (   0.00%)     78.2633 *   2.19%*
> Amean     265     90.7237 (   0.00%)     89.1027 *   1.79%*
> Amean     296    101.1153 (   0.00%)     99.2693 *   1.83%*
> 
> schbench
> 				   vanilla		   filter
> Lat 50.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
> Lat 75.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
> Lat 90.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
> Lat 95.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
> Lat 99.0th-qrtle-1         6.00 (   0.00%)        6.00 (   0.00%)
> Lat 99.5th-qrtle-1         7.00 (   0.00%)        6.00 (  14.29%)
> Lat 99.9th-qrtle-1         7.00 (   0.00%)        7.00 (   0.00%)
> Lat 50.0th-qrtle-2         6.00 (   0.00%)        6.00 (   0.00%)
> Lat 75.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)
> Lat 90.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)
> Lat 95.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)
> Lat 99.0th-qrtle-2         9.00 (   0.00%)        8.00 (  11.11%)
> Lat 99.5th-qrtle-2         9.00 (   0.00%)        9.00 (   0.00%)
> Lat 99.9th-qrtle-2        12.00 (   0.00%)       11.00 (   8.33%)
> Lat 50.0th-qrtle-4         8.00 (   0.00%)        8.00 (   0.00%)
> Lat 75.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)
> Lat 90.0th-qrtle-4        10.00 (   0.00%)       11.00 ( -10.00%)
> Lat 95.0th-qrtle-4        11.00 (   0.00%)       11.00 (   0.00%)
> Lat 99.0th-qrtle-4        12.00 (   0.00%)       13.00 (  -8.33%)
> Lat 99.5th-qrtle-4        16.00 (   0.00%)       14.00 (  12.50%)
> Lat 99.9th-qrtle-4        17.00 (   0.00%)       15.00 (  11.76%)
> Lat 50.0th-qrtle-8        13.00 (   0.00%)       13.00 (   0.00%)
> Lat 75.0th-qrtle-8        16.00 (   0.00%)       16.00 (   0.00%)
> Lat 90.0th-qrtle-8        18.00 (   0.00%)       18.00 (   0.00%)
> Lat 95.0th-qrtle-8        19.00 (   0.00%)       18.00 (   5.26%)
> Lat 99.0th-qrtle-8        24.00 (   0.00%)       21.00 (  12.50%)
> Lat 99.5th-qrtle-8        28.00 (   0.00%)       26.00 (   7.14%)
> Lat 99.9th-qrtle-8        33.00 (   0.00%)       32.00 (   3.03%)
> Lat 50.0th-qrtle-16       20.00 (   0.00%)       20.00 (   0.00%)
> Lat 75.0th-qrtle-16       28.00 (   0.00%)       28.00 (   0.00%)
> Lat 90.0th-qrtle-16       32.00 (   0.00%)       32.00 (   0.00%)
> Lat 95.0th-qrtle-16       34.00 (   0.00%)       34.00 (   0.00%)
> Lat 99.0th-qrtle-16       40.00 (   0.00%)       40.00 (   0.00%)
> Lat 99.5th-qrtle-16       44.00 (   0.00%)       44.00 (   0.00%)
> Lat 99.9th-qrtle-16       53.00 (   0.00%)       67.00 ( -26.42%)
> Lat 50.0th-qrtle-32       39.00 (   0.00%)       36.00 (   7.69%)
> Lat 75.0th-qrtle-32       57.00 (   0.00%)       52.00 (   8.77%)
> Lat 90.0th-qrtle-32       69.00 (   0.00%)       61.00 (  11.59%)
> Lat 95.0th-qrtle-32       76.00 (   0.00%)       64.00 (  15.79%)
> Lat 99.0th-qrtle-32       88.00 (   0.00%)       74.00 (  15.91%)
> Lat 99.5th-qrtle-32       91.00 (   0.00%)       80.00 (  12.09%)
> Lat 99.9th-qrtle-32      115.00 (   0.00%)      107.00 (   6.96%)
> Lat 50.0th-qrtle-47       63.00 (   0.00%)       55.00 (  12.70%)
> Lat 75.0th-qrtle-47       93.00 (   0.00%)       80.00 (  13.98%)
> Lat 90.0th-qrtle-47      116.00 (   0.00%)       97.00 (  16.38%)
> Lat 95.0th-qrtle-47      129.00 (   0.00%)      106.00 (  17.83%)
> Lat 99.0th-qrtle-47      148.00 (   0.00%)      123.00 (  16.89%)
> Lat 99.5th-qrtle-47      157.00 (   0.00%)      132.00 (  15.92%)
> Lat 99.9th-qrtle-47      387.00 (   0.00%)      164.00 (  57.62%)
> 
> netperf-udp
> 				    vanilla		    filter
> Hmean     send-64         183.09 (   0.00%)      182.28 (  -0.44%)
> Hmean     send-128        364.68 (   0.00%)      363.12 (  -0.43%)
> Hmean     send-256        715.38 (   0.00%)      716.57 (   0.17%)
> Hmean     send-1024      2764.76 (   0.00%)     2779.17 (   0.52%)
> Hmean     send-2048      5282.93 (   0.00%)     5220.41 *  -1.18%*
> Hmean     send-3312      8282.26 (   0.00%)     8121.78 *  -1.94%*
> Hmean     send-4096     10108.12 (   0.00%)    10042.98 (  -0.64%)
> Hmean     send-8192     16868.49 (   0.00%)    16826.99 (  -0.25%)
> Hmean     send-16384    26230.44 (   0.00%)    26271.85 (   0.16%)
> Hmean     recv-64         183.09 (   0.00%)      182.28 (  -0.44%)
> Hmean     recv-128        364.68 (   0.00%)      363.12 (  -0.43%)
> Hmean     recv-256        715.38 (   0.00%)      716.57 (   0.17%)
> Hmean     recv-1024      2764.76 (   0.00%)     2779.17 (   0.52%)
> Hmean     recv-2048      5282.93 (   0.00%)     5220.39 *  -1.18%*
> Hmean     recv-3312      8282.26 (   0.00%)     8121.78 *  -1.94%*
> Hmean     recv-4096     10108.12 (   0.00%)    10042.97 (  -0.64%)
> Hmean     recv-8192     16868.47 (   0.00%)    16826.93 (  -0.25%)
> Hmean     recv-16384    26230.44 (   0.00%)    26271.75 (   0.16%)
> 
> The overhead this feature added to the scheduler can be unfriendly
> to the fast context-switching workloads like netperf/tbench. But
> the test result seems fine.
> 
> netperf-tcp
> 			       vanilla		       filter
> Hmean     64         863.35 (   0.00%)     1176.11 *  36.23%*
> Hmean     128       1674.32 (   0.00%)     2223.37 *  32.79%*
> Hmean     256       3151.03 (   0.00%)     4109.64 *  30.42%*
> Hmean     1024     10281.94 (   0.00%)    12799.28 *  24.48%*
> Hmean     2048     16906.05 (   0.00%)    20129.91 *  19.07%*
> Hmean     3312     21246.21 (   0.00%)    24747.24 *  16.48%*
> Hmean     4096     23690.57 (   0.00%)    26596.35 *  12.27%*
> Hmean     8192     28758.29 (   0.00%)    30423.10 *   5.79%*
> Hmean     16384    33071.06 (   0.00%)    34262.39 *   3.60%*
> 
> The suspicious improvement (and regression in tbench4-128) needs
> further digging..
> 
> tbench4 Throughput
> 			     vanilla		     filter
> Hmean     1        293.71 (   0.00%)      298.89 *   1.76%*
> Hmean     2        583.25 (   0.00%)      596.00 *   2.19%*
> Hmean     4       1162.40 (   0.00%)     1176.73 *   1.23%*
> Hmean     8       2309.28 (   0.00%)     2332.89 *   1.02%*
> Hmean     16      4517.23 (   0.00%)     4587.60 *   1.56%*
> Hmean     32      7458.54 (   0.00%)     7550.19 *   1.23%*
> Hmean     64      9041.62 (   0.00%)     9192.69 *   1.67%*
> Hmean     128    19983.62 (   0.00%)    12228.91 * -38.81%*
> Hmean     256    20054.12 (   0.00%)    20997.33 *   4.70%*
> Hmean     384    19137.11 (   0.00%)    20331.14 *   6.24%*

Following are the results from testing on a dual socket Zen3 system
(2 x 64C/128T) in different NPS modes.

Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Kernel versions:
- tip:      		5.18-rc1 tip sched/core
- Filter Overloaded:    5.18-rc1 tip sched/core + this patch

When we began testing, we recorded the tip at:

commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"

Following are the results from the benchmark:

Note: Results marked with * are data points of concern. A rerun
for the data point has been provided on both the tip and the
patched kernel to check for any run to run variation.

~~~~~~~~~
hackbench
~~~~~~~~~

NPS1

Test:                   tip               Filter Overloaded
 1-groups:         4.64 (0.00 pct)         4.74 (-2.15 pct)
 2-groups:         5.38 (0.00 pct)         5.55 (-3.15 pct)
 4-groups:         6.15 (0.00 pct)         6.20 (-0.81 pct)
 8-groups:         7.42 (0.00 pct)         7.47 (-0.67 pct)
16-groups:        10.70 (0.00 pct)        10.60 (0.93 pct)

NPS2

Test:                   tip               Filter Overloaded
 1-groups:         4.70 (0.00 pct)         4.68 (0.42 pct)
 2-groups:         5.45 (0.00 pct)         5.46 (-0.18 pct)
 4-groups:         6.13 (0.00 pct)         6.11 (0.32 pct)
 8-groups:         7.30 (0.00 pct)         7.23 (0.95 pct)
16-groups:        10.30 (0.00 pct)        10.38 (-0.77 pct)

NPS4

Test:                   tip               Filter Overloaded
 1-groups:         4.60 (0.00 pct)         4.66 (-1.30 pct)
 2-groups:         5.41 (0.00 pct)         5.53 (-2.21 pct)
 4-groups:         6.12 (0.00 pct)         6.16 (-0.65 pct)
 8-groups:         7.22 (0.00 pct)         7.28 (-0.83 pct)
16-groups:        10.24 (0.00 pct)        10.26 (-0.19 pct)

~~~~~~~~
schbench
~~~~~~~~

NPS1

#workers:      tip                Filter Overloaded
  1:      29.00 (0.00 pct)        29.00 (0.00 pct)
  2:      28.00 (0.00 pct)        27.00 (3.57 pct)
  4:      31.50 (0.00 pct)        33.00 (-4.76 pct)
  8:      42.00 (0.00 pct)        42.50 (-1.19 pct)
 16:      56.50 (0.00 pct)        56.00 (0.88 pct)
 32:      94.50 (0.00 pct)        96.50 (-2.11 pct)
 64:     176.00 (0.00 pct)       178.50 (-1.42 pct)
128:     404.00 (0.00 pct)       418.00 (-3.46 pct)
256:     869.00 (0.00 pct)       900.00 (-3.56 pct)
512:     58432.00 (0.00 pct)     56256.00 (3.72 pct)

NPS2

#workers:      tip                Filter Overloaded
  1:      26.50 (0.00 pct)        14.00 (47.16 pct)
  2:      26.50 (0.00 pct)        14.50 (45.28 pct)
  4:      34.50 (0.00 pct)        18.00 (47.82 pct)
  8:      45.00 (0.00 pct)        30.50 (32.22 pct)
 16:      56.50 (0.00 pct)        57.00 (-0.88 pct)
 32:      95.50 (0.00 pct)        94.00 (1.57 pct)
 64:     179.00 (0.00 pct)       176.00 (1.67 pct)
128:     369.00 (0.00 pct)       411.00 (-11.38 pct)    *
128:     400.60 (0.00 pct)       412.90 (-3.07 pct)     [Verification Run]
256:     898.00 (0.00 pct)       850.00 (5.34 pct)
512:     56256.00 (0.00 pct)     59456.00 (-5.68 pct)

NPS4

#workers:      tip                Filter Overloaded
  1:      25.00 (0.00 pct)        24.50 (2.00 pct)
  2:      28.00 (0.00 pct)        24.00 (14.28 pct)
  4:      29.50 (0.00 pct)        28.50 (3.38 pct)
  8:      41.00 (0.00 pct)        36.50 (10.97 pct)
 16:      65.50 (0.00 pct)        59.00 (9.92 pct)
 32:      93.00 (0.00 pct)        95.50 (-2.68 pct)
 64:     170.50 (0.00 pct)       182.00 (-6.74 pct)     *
 64:     175.00 (0.00 pct)       176.00 (-0.57 pct)     [Verification Run]
128:     377.00 (0.00 pct)       409.50 (-8.62 pct)     *
128:     372.00 (0.00 pct)       401.00 (-7.79 pct)     [Verification Run]
256:     867.00 (0.00 pct)       940.00 (-8.41 pct)     *
256:     925.00 (0.00 pct)       892.00 (+3.45 pct)     [Verification Run]
512:     58048.00 (0.00 pct)     59456.00 (-2.42 pct)

~~~~~~
tbench
~~~~~~

NPS1

Clients:      tip                Filter Overloaded
    1    443.31 (0.00 pct)       466.32 (5.19 pct)
    2    877.32 (0.00 pct)       891.87 (1.65 pct)
    4    1665.11 (0.00 pct)      1727.98 (3.77 pct)
    8    3016.68 (0.00 pct)      3125.12 (3.59 pct)
   16    5374.30 (0.00 pct)      5414.02 (0.73 pct)
   32    8763.86 (0.00 pct)      8599.72 (-1.87 pct)
   64    15786.93 (0.00 pct)     14095.47 (-10.71 pct)  *
   64    15441.33 (0.00 pct)     15148.00 (-1.89 pct)   [Verification Run]
  128    26826.08 (0.00 pct)     27837.07 (3.76 pct)
  256    24207.35 (0.00 pct)     23769.48 (-1.80 pct)
  512    51740.58 (0.00 pct)     53369.28 (3.14 pct)
 1024    51177.82 (0.00 pct)     51928.06 (1.46 pct)

NPS2

Clients:      tip                Filter Overloaded
    1    449.49 (0.00 pct)       464.65 (3.37 pct)
    2    867.28 (0.00 pct)       898.85 (3.64 pct)
    4    1643.60 (0.00 pct)      1691.53 (2.91 pct)
    8    3047.35 (0.00 pct)      3010.65 (-1.20 pct)
   16    5340.77 (0.00 pct)      5242.42 (-1.84 pct)
   32    10536.85 (0.00 pct)     8978.74 (-14.78 pct)   *
   32    10417.46 /90.00 pct)    8375.55 (-19.60 pct)   [Verification Run]
   64    16543.23 (0.00 pct)     15357.35 (-7.16 pct)   *
   64    17101.56 (0.00 pct)     15465.73 (-9.56 pct)   [Verification Run]
  128    26400.40 (0.00 pct)     26637.87 (0.89 pct)
  256    23436.75 (0.00 pct)     24324.08 (3.78 pct)
  512    50902.60 (0.00 pct)     49159.14 (-3.42 pct)
 1024    50216.10 (0.00 pct)     50218.74 (0.00 pct)

NPS4

Clients:      tip                Filter Overloaded
    1    443.82 (0.00 pct)       458.65 (3.34 pct)
    2    849.14 (0.00 pct)       883.79 (4.08 pct)
    4    1603.26 (0.00 pct)      1658.89 (3.46 pct)
    8    2972.37 (0.00 pct)      3087.76 (3.88 pct)
   16    5277.13 (0.00 pct)      5472.11 (3.69 pct)
   32    9744.73 (0.00 pct)      9666.67 (-0.80 pct)
   64    15854.80 (0.00 pct)     13778.51 (-13.09 pct)  *
   64    15732.56 (0.00 pct)     14397.83 (-8.48 pct)   [Verification Run]
  128    26116.97 (0.00 pct)     25966.86 (-0.57 pct)
  256    22403.25 (0.00 pct)     22634.04 (1.03 pct)
  512    48317.20 (0.00 pct)     47123.73 (-2.47 pct)
 1024    50445.41 (0.00 pct)     48934.56 (-2.99 pct)

Note: tbench resuts for 256 workers are known to have
a great amount of run to run variation on the test
machine. Any regression seen for the data point can
be safely ignored.

~~~~~~
Stream
~~~~~~

- 10 runs

NPS1

Test:         tip                  Filter Overloaded
 Copy:   189113.11 (0.00 pct)    184006.43 (-2.70 pct)
Scale:   201190.61 (0.00 pct)    197663.80 (-1.75 pct)
  Add:   232654.21 (0.00 pct)    223226.88 (-4.05 pct)
Triad:   226583.57 (0.00 pct)    218920.27 (-3.38 pct)

NPS2

Test:          tip                 Filter Overloaded
 Copy:   155347.14 (0.00 pct)    150710.93 (-2.98 pct)
Scale:   191701.53 (0.00 pct)    181436.61 (-5.35 pct)
  Add:   210013.97 (0.00 pct)    200397.89 (-4.57 pct)
Triad:   207602.00 (0.00 pct)    198247.25 (-4.50 pct)

NPS4

Test:          tip                 Filter Overloaded
 Copy:   136421.15 (0.00 pct)    137608.05 (0.87 pct)
Scale:   191217.59 (0.00 pct)    189674.77 (-0.80 pct)
  Add:   189229.52 (0.00 pct)    188682.22 (-0.28 pct)
Triad:   188052.99 (0.00 pct)    188946.75 (0.47 pct)

- 100 runs

NPS1

Test:          tip                 Filter Overloaded
 Copy:   244693.32 (0.00 pct)    235089.48 (-3.92 pct)
Scale:   221874.99 (0.00 pct)    217716.94 (-1.87 pct)
  Add:   268363.89 (0.00 pct)    266529.22 (-0.68 pct)
Triad:   260945.24 (0.00 pct)    252780.93 (-3.12 pct)

NPS2

Test:          tip                 Filter Overloaded
 Copy:   211262.00 (0.00 pct)    240922.15 (14.03 pct)
Scale:   222493.34 (0.00 pct)    220122.09 (-1.06 pct)
  Add:   280277.17 (0.00 pct)    278002.19 (-0.81 pct)
Triad:   265860.49 (0.00 pct)    264231.43 (-0.61 pct)

NPS4

Test:          tip                 Filter Overloaded
 Copy:   250171.40 (0.00 pct)    243512.01 (-2.66 pct)
Scale:   222293.56 (0.00 pct)    224911.55 (1.17 pct)
  Add:   279222.16 (0.00 pct)    280700.91 (0.52 pct)
Triad:   262013.92 (0.00 pct)    265729.44 (1.41 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

NPS1

sched-tip:      303718.33 (var: 1.31)
NUMA Bal:       309396.00 (var: 1.24)    (+1.83%)

NPS2

sched-tip:      304536.33 (var: 2.46)
NUMA Bal:       305209.00 (var: 0.80)    (+0.22%)

NPS4

sched-tip:      301192.33 (var: 1.81)
NUMA Bal:       304248.00 (var: 2.05)    (+1.00%)

~~~~~
Notes
~~~~~

- schbench shows regression for 128 workers in NPS4 mode.
  The rerun shows stable results for both tip and patched
  kernel.
- tbench shows regression for 64 workers in NPS2 and NPS4
  mode. In NPS2 mode, the tip shows some run to run variance
  however the median of 10 runs reported is lower for the
  patched kernel.
- tbench shows regression for 32 workers in NPS2 mode. The
  tip seems to report stable values here but there is a
  slight run to run variation observed in the patched kernel.

- Overall, the performance is comparable to that of the tip.
- schbench low worker count improvements has the load balancer
  coming into the picture. We still have to do deeper analysis
  to see if and how this patch is helping.

I haven't run the mmtest as a part of this testing. I've made
a note of the configs you ran the numbers for. I'll try to
get numbers for same.

> 
> v3:
>   - removed sched-idle balance feature and focus on SIS
>   - take non-CFS tasks into consideration
>   - several fixes/improvement suggested by Josh Don
> 
> v2:
>   - several optimizations on sched-idle balancing
>   - ignore asym topos in can_migrate_task
>   - add more benchmarks including SIS efficiency
>   - re-organize patch as suggested by Mel
> 
> v1: https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/
> v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 12 ++++++++++
>  kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
>  kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
>  kernel/sched/idle.c            |  1 +
>  kernel/sched/sched.h           |  4 ++++
>  kernel/sched/topology.c        |  4 +++-
>  6 files changed, 92 insertions(+), 10 deletions(-)
> 
> [..snip..]

Let me know if there is some additional data you would like
me to gather on the test machine.
--
Thanks and Regards,
Prateek
