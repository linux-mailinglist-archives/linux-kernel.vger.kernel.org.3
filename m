Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED04A3CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 05:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357603AbiAaEnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 23:43:33 -0500
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:39904
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbiAaEnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:43:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k52OLfnkXRYL8MvD+skYy89aSxgXFgw9djg/dmll4LmQoig9QJnv6S3rWfc8SgY5ZLTO7/Xe+SCS4niMpohIm432lo/rs3mp3Uxor390g+64IEe1ocMV+5gk9oz56JTBrqQXZDSHLTB1yZ9r7+EOwwODtWpdFuf9zWxp/bJWfldcXtjjUMHU1JdME4ZB0bNoFdFlXfZ5HPhoJ2V6hpgSlDHiEHl9G4Akpi1e4WxOYNCvepoqZA2L2mYioxEMeGSbuR9R9AzVcRuIVekjNYhYJ5lKrF2RTGppfB/482KKEId5P1nLm2Okws2pvDkyKaSNsHdSUASGNjO+sT/pN1NvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhxLvmG+qKYzVnxck4f+UBPT8JkZMFWGX4Rq+hBV0XM=;
 b=lzuvjXZbVBr0u6quEjZ0WKd1ESlnLWiVphi1zvhTnsUzMeLJd6OnRMzYU6yJjqgK6S6ZLP5eCW7EBfaiWR+K9KdhpE3oT3ynZ73UQpKcfbQdcG/unZ7vAWkzKYo+Tdkdfd40PxnSd5xDbaZK4dkDAh32OZqLal4FujoFlMaEB3348Sb4YcNjGwZDJKIxv1kt8/ukWNn/2yhrs4X9tjb6rmoICJhs+0tn3+nSWliNdJneLrZ/iq2i7t92rx2h+5ZO0P3PrIdH7P4RCKJPp+Jx2K+OK2a5O3Ff1VN4BFTWCmRXE1/zHZlnD5bbCSSS6Z1q6FB8lUo+1/o9u4DHjWJMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhxLvmG+qKYzVnxck4f+UBPT8JkZMFWGX4Rq+hBV0XM=;
 b=RG22cLB6HRs2E0pTM866KuvCyL6r1yPqvuJO2TilR0nmmDgKw2aMmEcyPjacmUoBBQoaFY/GcNFa8Weqk6f1uLi+h8khS4pYBf8OqEGiGUnuiPg4PbMr2mLM3nZArWDd8zyEXTgVROOURyy0SyFlb0kNjaHT6zCyXWOwEngQenE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by MWHPR1201MB0159.namprd12.prod.outlook.com (2603:10b6:301:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 04:43:29 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::10c4:c928:bb18:44bc]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::10c4:c928:bb18:44bc%5]) with mapi id 15.20.4930.019; Mon, 31 Jan 2022
 04:43:28 +0000
Message-ID: <5c6a53dc-99f2-cb82-5aee-05d9b5061b42@amd.com>
Date:   Mon, 31 Jan 2022 10:13:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC v2] perf: Rewrite core context handling
Content-Language: en-US
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::33) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d280ed22-40ed-4f2b-4016-08d9e47438fc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0159C9EA97F0E650068C3634E0259@MWHPR1201MB0159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZv1GrIfka1xg+EIQerYsFbxVCdPNNsyT5sG91RP1HYCZUioXk3vl277SpoMF18YiMCHTyRhtlkLCkoWYMrxkEoX3Xd7HWc34kV2VDQHer6wA66skrtJNy37nXA7Wo055OsQf/K2goLb6iVMB411eZIgtLbtJT3UrfxPpA/eQq07aNKWRj6kWgjB4bLgCSQzcbsE/wpJ3gi+wR8k232AzqD2uH9lMjE/9dNgB67n19Ad6waum7jR5T7z//EWIvNduFC94IAOswjD38yB0xp6NGBmo5lx1rQjCX5ZuWrD1eEIhWKYbe7JrTzWy8Iy3+qUaaQ3merReuRNlu/b7DD++RVimYvRzuJkXRcOB0Btb9ZcIfyXxhqkGBa7g3FJsO7egOteqfa9ZSCTvanSctY9jsEALMtn4xoVd0XnLaz3rXwHAF+tdr/Yu0Kra6k/a+xxQ25GKYCV0uvbzt9rcU2hyuZdK5Lr5nMXzXfswhs+qDqfWcWUC9oxZranMZI8YF6hukRqWLmQ5OAHwvL5AuG07qQ3qbVBlsnM6B0SoHh0n49ld1DXdH4Oyn5VwiCrK5Vc417YOAB5OzaqoVf7Tf753UZaAVo6CAnwEO5jThx64L1BTJWp1aj97GSLrmEweDQzSKrMYvr4QndtlxIBPo0qeErf7MmtyWmi97iL/9MpCCvqeVeyIIKxInF8QjhgpvmRZ+XyElEMNK5rS30vmR486aUghiZ/Zr2DUNP56cTLecfq2he4bexoYuv5kaQerxjuQ/tFx4hGLQSZOfGJUi78Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66946007)(66556008)(8936002)(53546011)(6512007)(6916009)(6486002)(8676002)(4326008)(508600001)(66476007)(6666004)(31696002)(6506007)(83380400001)(316002)(26005)(2616005)(36756003)(38100700002)(31686004)(44832011)(7416002)(5660300002)(2906002)(186003)(21314003)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXp1VzFSOTNRSm1aQW5xeTA3K2xwVlJXbHNMVytOQ3piaFZuTzBLSEdqWWtL?=
 =?utf-8?B?aWs2THU0UVo3NEpleXBKZVBuRVBWZ2YwTnhRVDVxUVJMNGtkWE0wdnpJRTkw?=
 =?utf-8?B?MjI5Q0dsNEdKS3Zaajh4Z1kwa3ZQQ1lEQ2laaDdvTEhoVURjSWFKQk9Td3Rv?=
 =?utf-8?B?eDVmT01VOUIxN2dCb0JVNktqUkRjK2ZLRXUzY09FSjBVMDA1MWh2djN0eGZs?=
 =?utf-8?B?MUpKdksyVk5sdWJJVDF5dVdSb0FRVGRNSTRiMDJyQmNBb3hhZ2E2Y0NnS0xN?=
 =?utf-8?B?dEVpQkNrNStFSXFpL3NaY2ozYml4ZTJ4T2VmZkhyU0tjcTNwcUMyU2xRd2sv?=
 =?utf-8?B?U0JBeFdCTXMycEIyNTBsWWVpbUk2ank0a0hLdGZuVDU5aDlQb3Y3WWNCeUMv?=
 =?utf-8?B?VVgzbmRIYkZzeXczU29URCs1YWdsWS9kWGg1ZEwzYTE3K1ZsOW1rekkwMWtB?=
 =?utf-8?B?bkJNUUtuZjhLMUVyL0hPL012V1h1YmNrYTljQ005N3NKSHk2N0h2Mlo2bE9q?=
 =?utf-8?B?aWViUFJkRUFCSEw1by90MTBxMllOTy9PSFdxVXI3QXkwaWhBRzl6SzRJd0pN?=
 =?utf-8?B?RXpta0FmdmJENGdiREdVdFZLZUNOeFFqS0N6TFdPTk9uYVRKdFlBb3BkbXEv?=
 =?utf-8?B?b2hQT1lTUDFQaFFoeFY0MVdQT2hzdk5CWVpCQlV0cnFaRFJueERRZ3cxSVFz?=
 =?utf-8?B?ZGJSL0dwaFVXMmZHZUFaRnhZbGNJWGdVaXhyaHBLckdBcFV2Y2tucnd6bDJn?=
 =?utf-8?B?aTczS3Z2MjBMT3NjVDhMTjRKckNaUXFmRmdUT1NFNThEcm9uOEF4UCtsZUpC?=
 =?utf-8?B?TkJTS3lYUTZWeGdxRytWanBGRzk0Nlg4STlnSXFDWUhRSHRBVFVzVjFoa2JR?=
 =?utf-8?B?eWtqWEwxMFErUUowSzMyNEtMNkowK2ZzUEh3b3RJNHVoVkxZdW8zeUhjbGEv?=
 =?utf-8?B?bnF4MTQwSUhuaXNjcDFEMFhmVFpTL3B2TVoxYk5ZdlpUdU02clZoKzUzeWN3?=
 =?utf-8?B?aG1RaDJUaFljSzZFR0xmVHU5Y1krN0xiTDJxZnAxRGtaWDVybXcxYUFrbGN5?=
 =?utf-8?B?Um9SU2tJd2paWGRaNXhwSFlqVGxXNG5QY00vS2czbVlVV1hGUDdUWFJRU0hZ?=
 =?utf-8?B?dUNCc2UwVStmRVlHSThBUDYycTVIOXVBajFhYS9yelM0TW5nMFE0T2xUYVV4?=
 =?utf-8?B?KzBGVmVyZGFxbndhZlNZMDdUQTEyY0VaaSt5RWFtamc2dEFoQXdsVXh4cURN?=
 =?utf-8?B?REpGNytEWFpSb1RmK1ZCcWtMdGtKYmF2OG5TdVQya0dzbkhzbVlsR3BVWm4z?=
 =?utf-8?B?NXR0d29wU1AzWWtIbE1TQmJ5T1B0alhVQS9LRXhxZGM1RHl6OVNvaGZ2WjJM?=
 =?utf-8?B?WUI3SUdLZmxlM3BCWTNwVHNwQmZ0SU00VGhXMTduRDVxbk1JMDJVTm9Pbmsw?=
 =?utf-8?B?K1ZXTnRhU1JjU1Bpd0FUbk9NZFhIWHBDMWJSVjVzSHBJejlCdTNmZytyd2kz?=
 =?utf-8?B?SmZvZ1Z3TG9Cai8zOHAwVVNZTnd1SDhadm9TNUpnMFVQN2l3bWFPWWp3dGZj?=
 =?utf-8?B?ZEJlZzZYRm5VY1BrS2NUUy9OUGRYUVNnU3d1Zmo5K25pdlJ1em81WThkcmVm?=
 =?utf-8?B?a3g0SCtrMVpDTnJTbjBoYmd3UDRST05mc0xuMDhaTWpEMWJFWUJJWHdMOWhR?=
 =?utf-8?B?TVF0Rjgra1djWm91VU9iK2t4NktjSURndTJ3UFZwT01FRWRJNkNJL3N5RzZY?=
 =?utf-8?B?V1dzem1ZRE54RWl3ZDJQbnZqWU1Fc2VWUXJ5WlhrMWpLZFg2cTZ5VUxqdHF0?=
 =?utf-8?B?THpseS9GUXhyUElPSCtnaG1hR2xSdHVNT0Q1c0sxMXN5ZThVcVcyU0FNeUxE?=
 =?utf-8?B?a3piOEhJR05SbmxiVlBxc1djbDdDVzVxbDd2d25vanVQVGNmUkYvMzhsNWVP?=
 =?utf-8?B?SHVKQ0dBMHZpdWgvcFVvbHhsc3hwam1PVjU0UkltNWJabEN6Z1VkU3dxeUpQ?=
 =?utf-8?B?Y2tFN0NqWlpBSGRTaGYxUzlHMnlNUGtLaE1kOExXVnNQTzdoZnlWWlU5L3lZ?=
 =?utf-8?B?R2RSSlVacnQ4NytjN3orRHozNzNmNC9GdzR3ZUFQRmRObXA2emJrSHFFeEta?=
 =?utf-8?B?WTd6SCtPQkhKMlRyZUllRlF0TEhoL0pnQ3hINGUwWktJTkhuQzhsRlpNNmQ2?=
 =?utf-8?Q?6qekedsfI7+MxgaiZ2X0NYk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d280ed22-40ed-4f2b-4016-08d9e47438fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 04:43:28.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJ/EN76+zltoqayWLP07Z4wyfR0gqiz0YFUbcooW2atLAuFral08H7UI0vhl4cZzv2jZLp+IMEmB0KHXHPUVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13-Jan-22 7:17 PM, Ravi Bangoria wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This is the 2nd version of RFC originally posted by Peter[1].
> 
> There have been various issues and limitations with the way perf uses
> (task) contexts to track events. Most notable is the single hardware
> PMU task context, which has resulted in a number of yucky things (both
> proposed and merged).
> 
> Notably:
>  - HW breakpoint PMU
>  - ARM big.little PMU / Intel ADL PMU
>  - Intel Branch Monitoring PMU
>  - AMD IBS
> 
> Current design:
> ---------------
> Currently we have a per task and per cpu perf_event_contexts:
> 
>   task_struct::perf_events_ctxp[] <-> perf_event_context <-> perf_cpu_context
>        ^                                 |    ^     |
>        `---------------------------------'    |     `--> pmu
>                                               v           ^
>                                          perf_event ------'
> 
> Each task has an array of pointers to a perf_event_context. Each
> perf_event_context has a direct relation to a PMU and a group of
> events for that PMU. The task related perf_event_context's have a
> pointer back to that task.
> 
> Each PMU has a per-cpu pointer to a per-cpu perf_cpu_context, which
> includes a perf_event_context, which again has a direct relation to
> that PMU, and a group of events for that PMU.
> 
> The perf_cpu_context also tracks which task context is currently
> associated with that CPU and includes a few other things like the
> hrtimer for rotation etc.
> 
> Each perf_event is then associated with its PMU and one
> perf_event_context.
> 
> Proposed design:
> ----------------
> New design proposed by this patch reduce to a single task context and
> a single CPU context but adds some intermediate data-structures:
> 
>   task_struct::perf_event_ctxp -> perf_event_context <- perf_cpu_context
>        ^                                 |    ^ ^
>        `---------------------------------'    | |
>                                               | |    perf_cpu_pmu_context
>                                               | `----.    ^
>                                               |      |    |
>                                               |      v    v
>                                               | ,--> perf_event_pmu_context
>                                               | |         ^
>                                               | |         |
>                                               v v         v
>                                          perf_event ---> pmu
> 
> With new design, perf_event_context will hold all pmu events in the
> respective(pinned/flexible) rbtrees. This can be achieved by adding
> pmu to rbtree key:
> 
>   {cpu, pmu, cgroup_id, group_index}
> 
> Each perf_event_context carry a list of perf_event_pmu_context which
> is used to hold per-pmu-per-context state. For ex, it keeps track of
> currently active events for that pmu, a pmu specific task_ctx_data,
> a flag to tell whether rotation is required or not etc.
> 
> Similarly perf_cpu_pmu_context is used to hold per-pmu-per-cpu state
> like hrtimer details to drive the event rotation, a pointer to
> perf_event_pmu_context of currently running task and some other
> ancillary information.
> 
> Each perf_event is associated to it's pmu, perf_event_context and
> perf_event_pmu_context.
> 
> Original RFC -> RFC v2:
> -----------------------
> In addition to porting the patch to latest (v5.16-rc6) kernel, here
> are some of the major changes between two revisions:
> 
> - There were quite a bit of fundamental changes since original patch.
>   Most notably a rbtree key has changed from {cpu,group_index} to
>   {cpu,cgroup_id,group_index}. Adding a pmu key in between as proposed
>   in original patch is not straight forward as it will break cgroup
>   specific optimization. Hence we need to iterate over all pmu_ctx
>   for a given ctx and call visit_groups_merge() one by one.
> - Enabled cgroup support (CGROUP_PERF).
> - Some changes wrt multiplexing events as with new design the rotation
>   happens at cgroup subtree unlike at pmu subtree in original patch.
> 
> Because of additional complexity above changes bring in, I thought to
> get initial review about the overall approach before starting to make it
> upstream ready. Hence this patch just provides an idea of the direction
> we will head toward. Many loose ends in the patch rightnow. Like, I've
> not paid much attention to synchronization related aspects. Similarly,
> some of the issues marked in original patch (XXX) haven't been fixed.
> 
> A simple perf stat/record/top survives with the patch but machine
> crashes with first run of perf test (stale cpc->task_epc causing the
> crash). Lockdep is also screaming a lot :)

Hi Peter, can you please review this.

Thanks,
Ravi
