Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8A587707
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiHBGQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:16:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB89F5A0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRxyH73so+6QeMoNAD99DYxXlkAjwpG7duU6ieWC8IA6JgNAy1Rxba31sIQy3ii5LH2kCIxKFTrPFlHuEhLsHrqyt5xhSl6NIw+xrsgMQiwswHwsYX/a+SAN57jhqMyAZBYAP8X8sDhqiMAJ0p+7OsmrfGObsQWohG7EkTjT8VQq4AfBItbgywVilOTfUYZJH4F+gJ8rrd3cpC7773BuKL4en2iNl6MXKSUmzYZStcdkl8BNqg9/g8JqWf0SHzld9uKsHiQlHQ32fTLl48ItjG2yDHWsGR7qQRSNPVZyPocMkzqAsmCiX9V8S3z4LYQeYFLU4OO6689b63izuRS8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AmnbqFB1EVsuvuMUIhjKQ9RbLmjo5lni3Z994geCtE=;
 b=kFvbq/e2oWl4XWvAn4BrZhBMLulBMqnGwygC63FiQXcO6NBsxuxryo8Yw5Sbqz2JIQXcmED9b3l1B7ycZ2kFrnJchb8NQowOBhoZ1cV3VtfGdAPu+St12orgy0/csOdak3WqwEYYez5Ndk89YlMbuosZmRTIyfDMtJDDXWjA/jn62LBrpkBuhNWDjqFjJi7P4JWX1ptMEp1GrxKZ6RzT8tNCttnvzbQKY6f8W24SaNzyVaokqo0RX4mYZ6/NhBHuQgu8qItAsBHInOvITaTu+CYzPjefOB2XjwZCRfX9Le6awFPVAuOHrV08xLYAVAm2OL0k0j2mVowINKKf1EMuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AmnbqFB1EVsuvuMUIhjKQ9RbLmjo5lni3Z994geCtE=;
 b=D2/d8GEvxS85P4bXURqeyIp1BKEzIhrPYTh5b+pX48jGA/IxeRZU+l0mwsJxkRSODBOZQqF5Tnf9bHNGVZGS4hxQG5WIcGG+ZB3rvjdgNOV+kykdxKamwgsTq+lXN/bpuHMyfozrFNgx68sYatPPwoMiYE3ri1A9xjRK0MkkQj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:16:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 06:16:47 +0000
Message-ID: <aab04cfb-2dd5-89dc-213d-7fa253615864@amd.com>
Date:   Tue, 2 Aug 2022 11:46:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b51be613-1d61-4968-cddb-08da744e948e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7zHEDNUX3X3Moj7s/6WIEHNEht1dm5ugfuN0AqmuU0UspcE/pvhw3MgtWc1Ff86otEx9Ui4a1bGdvSoz+O2jTvhFL13ntKVJKUjESpTCBMME0EmgvG/yGnxHCejuf+Nce9oyZCk55nHAUR/0eot/NYjEYLsC3PjzAlSIrr+uClpDfJGPM71niII7Pgxrf1LcYKNxzjLB5esKDgyLdpybIaV/Rh4P1spmh5tKAsvF9SCPnZIf58faQ0UquO16FXQ/gvcQ6ApkpcmleRnpPTxyMJiOqO8U5oCwJmDPsrLeok8f1eo0qDtuJYGLogRBrSyaAcZrKKOAJCS2WyN9/DRNE8VWDO+NVgGIN4MXh0BMFpePlEPV9yK1s0beQOnf3Bx2XW/Tmo8aqAyou8AiMsaM9s/CAbNjO2TX0gQlla4LIGzXBW8K5/isCte8lMTl4VEIoYWWm9McH2k+FTQTcL4dgnNjyLYD82eiWGc74xFy+cMXmeR0IEi6g+516gI6cNWpdJMLAiRt0fO6NrYIfiagpRMSEWuZki7mMpmL3IOvEJIhX2EXH6wURPAB4+Xeo1/7/BEoTmYCNgypu4UrlbperOi03VVeap+kxoUognEnnW5YBd5sqL/9WhaTFQjONbuC5sevxsznFM+3Rye92ygRsEpmwCjXEsl9HejKQxiQMYWTw8LMyjIOetvpl2PR8rS43eNr9uJoPCEYCMNADz6UakprdHBzpY9vsHgei3/Qm53CSFq4Oadgt94cishnnOkFNjuXuh8jrrSCq9Z1ToLcATWc7DfFB+dq8lzidbthsznLgcUTED9dZ1nDnlmEjsSnyrs2To8G/degAmAWCGlZ2Vdy+KDc2wqQzvG/K6Twm0mGGCtam7LAbOrg1u8Y/AbkdHPFzOtbOrGfYB6dbR3hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(6666004)(41300700001)(478600001)(5660300002)(7416002)(2906002)(6916009)(6486002)(966005)(316002)(8936002)(44832011)(38100700002)(2616005)(66946007)(66556008)(66476007)(31696002)(86362001)(53546011)(186003)(36756003)(8676002)(26005)(6512007)(4326008)(31686004)(6506007)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHBqclgzNE84aEdvaGo4ejlmWlhBMjQ1UThIMldvc2xmbTNnKytBMUVDQ3Z1?=
 =?utf-8?B?cEh3M0E3bC9yNmw3K0Ura0JXNDROU1E5aU5SZGJmQjQ4MW5HZzZYZ055Rkpy?=
 =?utf-8?B?S2d5ZXJJZlZIeUEzd0JzWTA0eE42MG5EemRTZVV6OEJMUHlDS2tjSjRPUGxh?=
 =?utf-8?B?ZUV3L2hDaGZlaW95ekJKaFM4aXdVY2wwRTRWbGswZXh4WkExeVF0ckZaSHVN?=
 =?utf-8?B?eU9XRStGMGpLbGVXc0hQcE9sRjQwMzZ3VWMwVnBLNzZKZFo2L2hTaWxVZmRr?=
 =?utf-8?B?aVB0cllvNnVPbnVsWmhKdWJOdGsvZXhuMTBsYzRhdVdGMmhNVEdqV3NJRStX?=
 =?utf-8?B?K2JBK0E3ZmJhcUxxU1NCMWFHanpOaHhCYTg4QXNnQmo3Q2U2UG1XN1RkekJp?=
 =?utf-8?B?cGthQ09YUEtaOFUwYzMyc3l6THA3eWVlYUYzdW9rZUFuSEY1MHUzSlZTVEhG?=
 =?utf-8?B?UnFRVHBIOU9oMXRwNlJ6SlpFS2xVRFhEallaSXh2Rmk5ZjhyVUJBT3pqWGJw?=
 =?utf-8?B?RzdqcjFYTFBFdzlDMWVTL3pDMlRLVHVTaCtxNzQ1MWpzK0VKQyt3d0R1cjlK?=
 =?utf-8?B?L1pxQ0RBaUNaTEdGUmEyZ1djS053bldPaXY3NXdiWGtIcW9QV0hvbVVkeVlO?=
 =?utf-8?B?ck5oS2o1Z2MxYTRVZnMwcDg2TWZrcjZzeUFVandXME5ycGY1aEIvMkZnMDZk?=
 =?utf-8?B?L3RIZzhVVVExMkhUZ21jRHlEcGxZUTdjanhJSHJFK2FRRVg1TFBrR2xSbFdq?=
 =?utf-8?B?Y1hLZ3gwUEpUOXlxTyswN3ZlZThNUDl1MEE4dGlaSDdVdkxZM0xyQ3JmS0Ix?=
 =?utf-8?B?dlJZZkpyQmNFNmRZcXZRT0wvd1lSelFWMmlvRXhjbEFUZFFSMmh0YjRzdDZC?=
 =?utf-8?B?cWlnbmFaMUE4SnoyNVQ0S1ZzeXkrQ3BuZkI4L3RraFhNaFpPUG1meTd1a3gw?=
 =?utf-8?B?bTBEaUJabkFPN1ZjN2lVVENuN1JHa0o3ZmFjQWlIdWZUR1dObVIxanJ0dHJK?=
 =?utf-8?B?SUlBdWZyY3BFSFdpMXVDREFqaFFHWnRIeFZ6YWVhdTh5NlZFa0dqR21nZStU?=
 =?utf-8?B?aFM5VEJ4SmVKSVBXdWozQ0J5ZHpPc3dpR2M0dzMrSFZHdzdkeHV4K240dEJx?=
 =?utf-8?B?NDdpd1VjL0txd1ZkUXk4Y3g4SlQrWjYxaEd4MGRsZXRXdVVGcVd1RnlRelky?=
 =?utf-8?B?Qm0xalo1R0ZTeFlKM1FzZ2swNDhvTEx0TUdtVWZHOVJ0SmJzei9CellQMkVr?=
 =?utf-8?B?OWlkYTV0aGcyUXlnMEdUQmRYYUZRTUFlczNiakNpNkpDeWRwZFZub2JRYTV4?=
 =?utf-8?B?ZzlhUk5GSW1GUFhEeUUwenhDK3J1Nmp0ampXY2REOGU4cXZENEVaU0VrYkFG?=
 =?utf-8?B?MHluanhCNFBYdk5SVGRvc0t0SUgvQVRZcTdRaCs0VCtJMHdCUWErMndia1ZF?=
 =?utf-8?B?S3ZpTWVEWHFhQms4cWE4aVE0M3FnTW44eHJOMWhtY3kxZFVWTDk5ZVN6MS80?=
 =?utf-8?B?NTdVZUdxU0dUK0FWRDVVWWdJVHN6ckNLM3hYY3d0cWkyUlBXTm8wa0p6TFZp?=
 =?utf-8?B?R1hCRW8yN0o5SC9CaUxrQTVueDloeWlkQ2hsdmZlbGNYNHZORDRrVnNFMWdZ?=
 =?utf-8?B?SEZGdk5SbUszM2I0SFdUU01MNFdUckI2VjJjVE9ZRlJxVjQ4Y0U3b1lMYlVv?=
 =?utf-8?B?bE5GSmVSdVZiVk9hZktQYnZtUzk1Q3c2cEhwVEVxWUpHWU9UeVpvODlQVUxw?=
 =?utf-8?B?MlFRbTVZcDE3cHcwRWt4V0R0dkVzVUpudENRZm5ZOXV1SFFGYUxZQkpXSExD?=
 =?utf-8?B?U1p0V2tyMEhDU0FBTVZkd055dVQ3R205bVNhWnpDa3l2SXNMVFphaFRld3RH?=
 =?utf-8?B?dnJOenhtNTBvcy9QQk9QbFY1SUJSY2hnQ3RVSXpwVk1TS09WN2tiUFJuZ3Fp?=
 =?utf-8?B?WDBkSGNOUnFwMm0zK0dIbFBzVzBsY2Rqa1pTVFVVRzcydmFHVUp5VGlVRUxr?=
 =?utf-8?B?OUJSS01oeVN2bWV0N0ZvakcvUTVWTjhqQ2FvYVBFbVJkL1AzT2t3cjlBK1d3?=
 =?utf-8?B?WVRra09BQnlNTWZzSzdTV2hiekRRWWV4Y2k5R2E0cWgrVVl4K2V2RmlFRDEx?=
 =?utf-8?Q?Kllv9MpMVQtfMkEeaYG9rA2HA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51be613-1d61-4968-cddb-08da744e948e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:16:47.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5Ldf8B+5v/tMEo88Ae0gMvKQIIPmyDwOZW1AIHFW24YkPYl5nOscXAEOFiRLHNZeesDF0SWET4G6xxQ5CaVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Jun-22 8:13 PM, Peter Zijlstra wrote:
> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> 
>> @@ -3652,17 +3697,28 @@ static noinline int visit_groups_merge(s
>>  			.size = ARRAY_SIZE(itrs),
>>  		};
>>  		/* Events not within a CPU context may be on any CPU. */
>> -		__heap_add(&event_heap, perf_event_groups_first(groups, -1, NULL));
>> +		__heap_add(&event_heap, perf_event_groups_first(groups, -1, pmu, NULL));
>>  	}
>>  	evt = event_heap.data;
>>  
>> -	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
>> +	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, pmu, NULL));
>>  
>>  #ifdef CONFIG_CGROUP_PERF
>>  	for (; css; css = css->parent)
>> -		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, css->cgroup));
>> +		__heap_add(&event_heap, perf_event_groups_first(groups, cpu, pmu, css->cgroup));
>>  #endif
>>  
>> +	if (event_heap.nr) {
>> +		/*
>> +		 * XXX: For now, visit_groups_merge() gets called with pmu
>> +		 * pointer never NULL. But these functions needs to be called
>> +		 * once for each pmu if I implement pmu=NULL optimization.
>> +		 */
>> +		__link_epc((*evt)->pmu_ctx);
>> +		perf_assert_pmu_disabled((*evt)->pmu_ctx->pmu);
>> +	}
>> +
>> +
>>  	min_heapify_all(&event_heap, &perf_min_heap);
>>  
>>  	while (event_heap.nr) {
> 
>> @@ -3741,39 +3799,67 @@ static int merge_sched_in(struct perf_ev
>>  	return 0;
>>  }
>>  
>> -static void
>> -ctx_pinned_sched_in(struct perf_event_context *ctx,
>> -		    struct perf_cpu_context *cpuctx)
>> +static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
>>  {
>> +	struct perf_event_pmu_context *pmu_ctx;
>>  	int can_add_hw = 1;
>>  
>> -	if (ctx != &cpuctx->ctx)
>> -		cpuctx = NULL;
>> -
>> -	visit_groups_merge(cpuctx, &ctx->pinned_groups,
>> -			   smp_processor_id(),
>> -			   merge_sched_in, &can_add_hw);
>> +	if (pmu) {
>> +		visit_groups_merge(ctx, &ctx->pinned_groups,
>> +				   smp_processor_id(), pmu,
>> +				   merge_sched_in, &can_add_hw);
>> +	} else {
>> +		/*
>> +		 * XXX: This can be optimized for per-task context by calling
>> +		 * visit_groups_merge() only once with:
>> +		 *   1) pmu=NULL
>> +		 *   2) Ignoring pmu in perf_event_groups_cmp() when it's NULL
>> +		 *   3) Making can_add_hw a per-pmu variable
>> +		 *
>> +		 * Though, it can not be opimized for per-cpu context because
>> +		 * per-cpu rb-tree consist of pmu-subtrees and pmu-subtrees
>> +		 * consist of cgroup-subtrees. i.e. a cgroup events of same
>> +		 * cgroup but different pmus are seperated out into respective
>> +		 * pmu-subtrees.
>> +		 */
>> +		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
>> +			can_add_hw = 1;
>> +			visit_groups_merge(ctx, &ctx->pinned_groups,
>> +					   smp_processor_id(), pmu_ctx->pmu,
>> +					   merge_sched_in, &can_add_hw);
>> +		}
>> +	}
>>  }
> 
> I'm not sure I follow.. task context can have multiple PMUs just the
> same as CPU context can, that's more or less the entire point of the
> patch.

Current rbtree key is {cpu, cgroup_id, group_idx}. However, effective key for
task specific context is {cpu, group_idx} because cgroup_id is always 0. And
effective key for cpu specific context is {cgroup_id, group_idx} because cpu
is same for entire rbtree.

With New design, rbtree key will be {cpu, pmu, cgroup_id, group_idx}. But as
explained above, effective key for task specific context will be {cpu, pmu,
group_idx}. Thus, we can handle pmu=NULL in visit_groups_merge(), same as you
did in the very first RFC[1]. (This may make things more complicated though
because we might also need to increase heap size to accommodate all pmu events
in single heap. Current heap size is 2 for task specific context, which is
sufficient if we iterate over all pmus).

Same optimization won't work for cpu specific context because, it's effective
key would be {pmu, cgroup_id, group_idx} i.e. each pmu subtree is made up of
cgroup subtrees.

Please correct me if my understanding is wrong.

Thanks,
Ravi

[1]:
https://lore.kernel.org/lkml/20181010104559.GO5728@hirez.programming.kicks-ass.net
