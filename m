Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30471587702
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiHBGNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:13:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11316BE12
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtuLLT2Uvx6UruOf+yxfFUxd8xS5jNB7mh9UONJ6qrIuSi3Ew8n4gMv5Y8GA5Y7kbaEVJR7VlO4xTRulCo3UOPIa15sAkQMaVvj6DyVdVj+GE7eojkwDeixBBCJWE0KgtzFtsVmQvv5OmJjnh3Fl86h6PTHzreoy33CQNi7tP6KE/nhKyGqpKICV4bzvX8bdTDv/fMcIuY9ri039yXcLDUPR0kfjicJUOZfEyy2Nnz+RxbeUhoaPFEEJjQIqubS8bPMXwkl4/HdEDVQZvQi9JsbS5N62dzsmeP/D5JMG9CR+ju2S3wfrkQAUVHXUSQ7mpAT0HjpkZrYza84zsYR44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6kmF7UzvJX3vnq+FSviV6/mEa6gJLLfqatCkaeJL00=;
 b=YeCXf+0HbViKxVuVmjRVa8hAjb294Pk3FJv0lqZtrTSgxEdUsboj3jUfh0gHfz3AXEobZIo07tz3aSd2EI3giLJVO7lWQX6DiJQssP8LseuOYVrmNW/LKL4MoBBK+p33Fre7VKRkK2v2qfNr+biYDHfLUj04OOgr4Cgoh+ACPYp0zSM9tmurWGe3F+VkLxtlmUljItUuJh32mxVOJhkWZinCc3KTCQzTDTpt+B7duJR084ecyBUVc6LqQ5yNf+1WuchAgZ/z1IAKqeQT5VOLFIX1dIFC267yX2RJwRKP6fXWF2/UPcykmc8TKZPJ7XKRyV+S6U2cbnXfwkI9D+iGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6kmF7UzvJX3vnq+FSviV6/mEa6gJLLfqatCkaeJL00=;
 b=Ctf5DExx+VKiykjKJJv7uMKeLWTgCEzE0Ft0l30VD7e/V4c0yN4gLMCHZGB1renzS7DGQKUeIlRKDKELJEWvx1SGt/TyLOtfCu4fbmy9ff6qBnkRXLbNsU1pzSVyE9F6ciY2p2koBTTpp0xBwuRTAMJE6nUJHvxzrIjU33ts51g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:13:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 06:13:19 +0000
Message-ID: <2acacbcb-2bdb-30d6-3300-8d125b06a0f3@amd.com>
Date:   Tue, 2 Aug 2022 11:43:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Language: en-US
In-Reply-To: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9039fd7e-d2c8-44ac-a155-08da744e1804
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bR66qlSKsKNTbwO1cUWf1tpXmiiHAEbk2oW21ZpxeGHppFYka86qcqcsm9QtQjuCsSOEEJm2h0Oh8OCOkKR92FWj7uhJcShTh0uJmb92UtdtY8tb2ajBq2V4UiyYx9CC9XUkqCnQyLrKX/jsgB/rJyV6QSDpVUrlok/LqIptqmkCJZ36PPve34rTRjbwz4kRRnMb4OJGMKuVwSluEPU+5EIdlgpGefxUZIf4qnk25NG/Cl0iYzMj8rNodkVpS/kqPUsf7tqUVdsDnAqH3t4DfDU8yEz4wv4o8EicwQm29oVELiweoqf176AAMDZ8Gviyrf/DQB2pG48my3oMwr4Y5oJyLgvp8CeL9icplSw0U37/fSA0VcmzbuSlt4AUg7UTuQSZ2pTgwR+styhanH1GqjLO5X2BNtEr1VxSsz9KL76eWnubWWIOIvYR44yX4wR3dG50ALwLEd7BZao+hgPRD0F46qC1yDm/+oy3R0eMFKuDejtdQ/ImXNHID1Q96fm9gSOMxYXhQfJOtyHrVNgBrUsT/ZNjAUnbQs7BD07ssiAllkS4VzyvjcXzFvic+Of6p5/zjTXlpqjRI+6EVCoIGMaeZGjvx38/2RvfRF7sPd2bPrBNP+o4p4CnwAjB1yuqM/isEaJs1tGMHVO54iufhY58nwmVV9rc0MsVfS3Fu8AdYVVSJ1UxIbh4CWOw0Tj2cVMCauyMWF2YO98y5BzBaVgFDnS+dxlCFVUcPWYscLNed3qA8c6MerOiuyq6VkJA+v0YScA18Dduie6FP8zaiLKTUPa4EfiMNpCa58BVyPa5h2Z4RwsfRqioA4oYYRvjCgHjqE0V8vbVdqNcYVIOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(6512007)(26005)(6506007)(31696002)(6666004)(41300700001)(86362001)(6916009)(316002)(6486002)(478600001)(38100700002)(2616005)(186003)(2906002)(66946007)(66556008)(8676002)(4326008)(66476007)(8936002)(44832011)(31686004)(5660300002)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0FJcmN3ME0rMFQzQ2dXRUFkLzVtS1pBZmFpQUJiMDl6TE5hWmRhQ2pDRCtF?=
 =?utf-8?B?TkwrckRYUjBqQnRoZG1QMEcxZitMdUQ1MlNqa2dnRWF5SjVEcy9USitOZ0dV?=
 =?utf-8?B?OWQvNzFHVW1oVDdHZS9FckIxaCtBZWtJdWtxaE5BV2s5U0hWTWdiQllHRC9L?=
 =?utf-8?B?R013VUZhblVoU3ZiV210eHZXNEptR3NsOG9KTHd4L1VianZqVUM3QjNQUGw0?=
 =?utf-8?B?RlByajVrZUZmL1hKdHVlNFNDd2lic3FLVjZBVkN0Vm1MSTgzR3ZyaGx4VDRa?=
 =?utf-8?B?MHhtZFFIR2crSHVZbkRta3Y5Y09CTnFWVlBkVFRnNG1Md0JlT2JaeHRDK2Qr?=
 =?utf-8?B?OEdwK1dkV3NSaW9wZVArNjQ2VVVURkVrWjdjSkgrRllLZ2x5UnIwUUVPZ1Ix?=
 =?utf-8?B?ZXNvQ3lvRUVKSkR2UFpwMWJlQ3pQWnZ1bVozTENZeVVCMWk5VHBzMmZISTBZ?=
 =?utf-8?B?Y0dzSmV2cWpWakRRWEZjN0pESkpaOC9sN3FjZTlIa1F1M2lFcHNxeElrTHB4?=
 =?utf-8?B?Qk5ZajdjUnIzbCtiNG9Yd3grM3ZPZndyZjdEblRac0VVRzJESXdqaitxN1V3?=
 =?utf-8?B?Y3RMTUlHYk1SUFpPdDNvMnNBS01Ib0RjSi91NkNhOEZvb20yckhnMUhnTk0w?=
 =?utf-8?B?NVNUdnFnazEvT210U2xhVGI3aGFWZHJiQUFOK3JJbDZhT0ZFNEpmejE4MjZ3?=
 =?utf-8?B?enh6RTgyV1dZa3NCSVJFaE9NcWp0R0VTRzVSQ3RxL1pybWFEL1hORE9PQ0c2?=
 =?utf-8?B?bVU1dTZkL2x2aTVTMHFVTStJMTRHbmRqQnppSHNZcTdiZDZkOXNkUEg0bGFp?=
 =?utf-8?B?RGdqTDF1SVJRYkVpSWlxa0JPY3crQnBnVmZJcU1SaTRtVDlCNU5tajMwTmJD?=
 =?utf-8?B?RVJvNVRyQXdDNVVMaUlFczRkZkVCM2tRZnN4UTNOTDNRQnFXSWVKSlFCV0F5?=
 =?utf-8?B?Z3BmTXZrVEJNQ3p1TDFBR29hazdMUVVEYTZEV0lMS1hWRWV5b2RrMk82R0Zx?=
 =?utf-8?B?WENxM05YRzNQMVZ2dWF2dVRKREhZWHZnWkEwUC9XLzBobndTS3dKKzRpY1Vp?=
 =?utf-8?B?K1pXRmtJMXYvVzZ1MzZSTlArbE4zSFY4cEJxdkVNS1l4R1ZXa2ErV2ZXd01a?=
 =?utf-8?B?cm5NMlhnS0F6Tk9jTWJNQlJHcXAxZ01HMGhkdFhUVGNCbTBKc0ZsZUVQaFRR?=
 =?utf-8?B?cVVHN1pCS24xQmg4RW5DTmJVdW91dE5sNmdrVFQ0R3R5K1lpa2hOUktya2RG?=
 =?utf-8?B?aWVIWlpDRnlwTDN1WldER3RZaFRLSnYxaEc2cFhDRE5uUkZsRG1OdGxiY2hG?=
 =?utf-8?B?dmo5VDk0OFYwbGRYekl2aWNiTkxYWWlUaFRTQ3kzRUd3dm1KYnVrRjJvNDdD?=
 =?utf-8?B?YmpzazVKUFNPWTJ3clJkVGJNUXlXcVlUWlpiTzhpcy9aNWlROTFVam5UcTUw?=
 =?utf-8?B?UlFUd0s2SHZNUlJlUy8xbElqQll3bklKSjlwVXNlTXpKOWtiUlhVbnE3V3pt?=
 =?utf-8?B?UGMyVHZjM2tRU21QaGpFNTBTbHg4L052ZUc1L0dZNml3MVpaMmRaUVI1ZldK?=
 =?utf-8?B?NG5sQi9xeklUb3hFQ2MzSysrU1AyUFVXNG1vM2Vwc0xZbEdUSXV0NU15T2I1?=
 =?utf-8?B?em4vQTZjUjZCMzRkWENIWHBGeGcrMUpITCtYMEdrdXdVbFExYi9NSXlQbGc3?=
 =?utf-8?B?UkxLMTJVeENLSUVpbHJEMFkwbTBhNjNodHgyL3ZtUUxJMHpUeFFsQWdwMHNJ?=
 =?utf-8?B?REpLSlJqQjc5T1Q4dC8wR1VDMnpHbUFwc2dvUjcxTURhMzVvUmI0UTluU1dv?=
 =?utf-8?B?WHlPbndsZUN2dzBrTm9TSU9mOVMxNmNqcndndkdUK3d3YlZtQkxudkladkJ2?=
 =?utf-8?B?WUxaSUFYMWlRKzVGMkJHWktqaFk5VHVtaTIrdFRxemNpWkMyUm1XNXN6dGpy?=
 =?utf-8?B?R0xiUTJIRzU4emNnakRVT0tWc2RuNXZ0NnB1aC9ETGM3RzhIUWRUaUlJb3E1?=
 =?utf-8?B?WjhaT1lCME9XUStPUy8xRnJOWXB3RWFDcENjUVB4Wm9DMG4vaWxlU0daZ21a?=
 =?utf-8?B?Q3VtZE96NmdKazJUVzJ1a3N1c29ldjl0N05GTlFxR3kwRmNWVDB4K2tUR1RG?=
 =?utf-8?Q?sACe8vBzZUllUR9ZHLsZxZFg0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9039fd7e-d2c8-44ac-a155-08da744e1804
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:13:18.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjqMzvErfNEojNMoujjkVXkce8zFkg6zZzHRCQMaDY2K+3C8TYBXEYn4bZhpaBGbGXHiNFYKL/UfC8AFmHkVew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>  /*
> @@ -2718,7 +2706,6 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  			struct perf_event_context *task_ctx,
>  			enum event_type_t event_type)
>  {
> -	enum event_type_t ctx_event_type;
>  	bool cpu_event = !!(event_type & EVENT_CPU);
>  
>  	/*
> @@ -2728,11 +2715,13 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	if (event_type & EVENT_PINNED)
>  		event_type |= EVENT_FLEXIBLE;
>  
> -	ctx_event_type = event_type & EVENT_ALL;
> +	event_type &= EVENT_ALL;
>  
> -	perf_pmu_disable(cpuctx->ctx.pmu);
> -	if (task_ctx)
> -		task_ctx_sched_out(cpuctx, task_ctx, event_type);
> +	perf_ctx_disable(&cpuctx->ctx);
> +	if (task_ctx) {
> +		perf_ctx_disable(task_ctx);
> +		task_ctx_sched_out(task_ctx, event_type);
> +	}
>  
>  	/*
>  	 * Decide which cpu ctx groups to schedule out based on the types
> @@ -2742,17 +2731,20 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	 *  - otherwise, do nothing more.
>  	 */
>  	if (cpu_event)
> -		cpu_ctx_sched_out(cpuctx, ctx_event_type);
> -	else if (ctx_event_type & EVENT_PINNED)
> -		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
> +		ctx_sched_out(&cpuctx->ctx, event_type);
> +	else if (event_type & EVENT_PINNED)
> +		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
>  
>  	perf_event_sched_in(cpuctx, task_ctx, current);
> -	perf_pmu_enable(cpuctx->ctx.pmu);
> +
> +	perf_ctx_enable(&cpuctx->ctx);
> +	if (task_ctx)
> +		perf_ctx_enable(task_ctx);
>  }

ctx_resched() reschedule entire perf_event_context while adding new event
to the context or enabling existing event in the context. We can probably
optimize it by rescheduling only affected pmu_ctx.

Thanks,
Ravi
