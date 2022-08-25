Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CAD5A087C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiHYFjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiHYFjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:39:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172B9F0D5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiRxDmhXK0zjRpsnQTHUYplx6J9cu96465/+t+ibh23+N6KDWszR2BofGc/EfqsgshMBc15JUs2lIIhhXVAUr+UHcKtja96Iie4Py+NxX5o0gLvvJ4kTvIh6YhZJZI9m7KSpSj+QMJut+7Y786wykdVgpkLUeyYXorrQQccbGS0C3uE8R6ryP3yC+ZKAlcfMHv7EKP9aMcHuKOWi+AoqBXNNhUw1Yjf8qg3rjyo6Ym4JZGh2qSiA+a0/i7fpEr17rEiZW04j1P8SWBCGLuvbeg6i4UcWqb8HfWt6xnFFIi9Y6YqjgcjGeIlNQlhfFXO2att0XNnnFslNBXeHr4GtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxyltUPn/SbWofoxcTxx3L0e8O68uScX95qIck4Sevo=;
 b=Pl0VTxgTFkSWwd4Sr1fFtKUKO0F+k5ceSveP7gKBPZsCXiDWBJp0HLO8wpWobGZXdMLIixWwL+xb34s3xWyDbFsfibq4RHQ0OhFqI57jljyJe6yOtzjkOhlLSS8ai3DOt5vWcT4CSs/5F/OET7rhb8gCQvadYyFCM5mqI/jhtzvfCVp3IHQbUGKT7iXI7c4NOG3C7kBGtU1TS/VlPLbXSMfVDrsjwcYk2pWptVDtrOicAnMtmvaVcSFBD4Q0zaWo6qEMPYA5La+Aa7nar2qC5n7vEF3XJGFGWkFpz4bdENP4DFMtXk5vFfN999+zf3WNytT74s/LIFCpHVq9P1/Cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxyltUPn/SbWofoxcTxx3L0e8O68uScX95qIck4Sevo=;
 b=C260yZOAx+G2kRMHXM34CGu8/xEgwwS6gYmRXzirSlwx/U59VxzvrazqiBB49lQdd6csYEMg3WynGC4Qor7GqoldTVBDdFfIK5x3oIAbgsPky3IAK4eextVm9weJaubTxL4sfvQPWkh8mxQyYLkXq+u3Nae9j0WQAPR3taxhZN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 05:39:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 05:39:18 +0000
Message-ID: <10d8889e-4ca9-7e4e-a3e4-d769da79d047@amd.com>
Date:   Thu, 25 Aug 2022 11:09:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2] perf: Rewrite core context handling
Content-Language: en-US
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
 <YwYWUbVvSAYseDaO@worktop.programming.kicks-ass.net>
 <YwY8u7gx6bO+RBcg@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YwY8u7gx6bO+RBcg@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b663c06-faa8-442d-1d5d-08da865c278e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp/h2RxolyIWZkrhcQXOkLUzbqZVHc71+7tidJmw/v3V9Z2YI4zSyjor3BeaJLzdfuYbugiNKDxQLwfteq/dwgEW9GkO1iaYilN8ed6ppbz52cLBJBjIUFwyYKqQwtoJcEh6SzIbSpWg/4rmVVWcRLwyO09rKdvRmlTuYhmGPmhhyGA+Lri2QW2r0hXZJR7L90TAYEu628HTFGt4pDXgBJ93WHD21i3rueybbssHEsCRQos9NtzuxywsLwMt1tlBqQZkL7yfVisiItuwDSxu/0AivtyDnLsSqmj67DIH9zWwuv8h4XKclOxl/0SOA3Y7nio/toE6/jCAl5a8mULAn9Kpe03AUhl7ZRJCeFj8gccu16CHcvZQUeZQ8G1UzmupiEVuHw58F11ENp9HZdwRBs06vGuawkE6dMEn5fEmQ7Vf/IEEau1/1vSOOOqnBtWXEwMCMKNEMkeB/ZOIe8aLCoBjuLNL/CkkCQ22lMDGIH3cOkvET9ph+6Bs4W+V+xiK9D2dFL+jz5u+E+Ms9/OgvmZEXAMzU/WDX51+sC2hAmzubnLWAIqk/cS3C/rESJfHFJ8rYyqRyhl4jDiiJ7GXfPzhdGpBqHXhpitylwzsnBx01ntN/YRkGb8ZmMjlRVuibzuK+BfmW/k0MLOq1Y8sbNuOkLNIUQV85ZjvhbQnrt6SC3Kvu4kELQkBkpQH7oML0T0s9hnSLcVoEMEmO7ngEgZnVLCD8RnjbSVN1IchTHD/Mqru0f6v3IR6DdtXj8KLMNFgzSPqmmzc/GUBbn1YROmKmdfrZCNpqF7F/BvvdbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(6666004)(478600001)(6506007)(6486002)(41300700001)(6512007)(2616005)(186003)(44832011)(2906002)(8936002)(7416002)(5660300002)(316002)(6916009)(66946007)(4326008)(8676002)(66556008)(36756003)(66476007)(26005)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJWOGhBUGwwcHpiY1R3Qi8wWVVQVjc2UFBUaXE5RWg1NEMwSk50ZHVJSXBm?=
 =?utf-8?B?SnltWXFpWUU0cDdzQkxNL0hvYkd3bzBhRWJXUERnSk5vL0FBWXd4S294RXNO?=
 =?utf-8?B?YjdVVVY2YTRUWnpac3U0dnBNd2Rwcll5dDZadWhMUWtVVUo0cjV5SUxPaVpl?=
 =?utf-8?B?d0lBbzhtQVZwQTlWNjd4QXhDdTJ2b0krUjcwRlRUd29FRXlSWkRrOGhUWTEx?=
 =?utf-8?B?NDlEVXNiNmJPbHRvZWVLT2d0bFgzWk1yM09IcWtoem02OE94K1RLVitTSnZK?=
 =?utf-8?B?ZkRPOWpJOWNjR29VZmxSUTdFRVNMMTdrWWhDWDdkdHRVOHdTSkdaZkZBWmE2?=
 =?utf-8?B?Q0N2VFBzQ29hK3JpaEd0dWs3S2FXcmRnNTBxa1JGSDZNM3hmQWFmZ05WcFFT?=
 =?utf-8?B?SVpJUUIxODBIYW5ubGlobC83K3VSdUFVMktjU2wwWWpPQWRsOGk0SUc4UDBm?=
 =?utf-8?B?TVdQK2xiUCtIMlZYR1hPK0NYUlJCSWZkNDhKVTB0dEM3SGhmSVhjSi9UNVVv?=
 =?utf-8?B?RmZJdXdiZDJVb2hhT1JrUWNLd21na3N3Y0lnOW9HSzc4aDlVR0x6V3k4c1Bh?=
 =?utf-8?B?cVpTVkVia2owM05EL2hLOWxrL1dhYUZ3TzJOdUJrTk4yMmthMDdHVG05VzhM?=
 =?utf-8?B?cm1kTzBmOTBXblZ2RHFReStzNkFIRjdtM0tCcE9yN21Tc2pRdCtabmJ1N3ln?=
 =?utf-8?B?UWVYKzZSNHIwcU5NUmUxWnJQOHNBZG9kZ0g5eHh0RFYwNlUzVVlhMlhGYjdY?=
 =?utf-8?B?WlliY0ZJdXg5UTRUUTJEaWdUT3RONjlPRXMrMjQ5UDRmRll5YUNKRHJkZkow?=
 =?utf-8?B?OFFuWEtmb1RqWjZKc0d1c3d4dFh4dXhIZVMrTXdFWVFISFhDUCszVjdZbFV5?=
 =?utf-8?B?VXhVL0tDOFNJeWpuTGdqaitsOEFDSVFrMnRsdHArRWFPM2k4V3dxSE5oMU5X?=
 =?utf-8?B?dUpDZHV4d1gvOWFnT2djQ1haUmVxb3VBK0JTektkRUpSM3I2N2VlS2pCMUxT?=
 =?utf-8?B?MzlkRURMU3pkclM0eEZQQ3l6QlpOZjlUWFlxbElGUFRwSkJybGNRSEI4b3oz?=
 =?utf-8?B?ZTJpVXBPc2xqMGlsZm0rNTRHVFEzd3NIejBvRWI5L0Q1ZTg2V0JYSVpoejlD?=
 =?utf-8?B?R1dPZjhhRUZtbnBvZ3lkbG53RUgybndrWno4V05CWVpXOXI5UWVpcjlQOXE1?=
 =?utf-8?B?WDlGcEJlejUrWnpVanVGZy8xaHcxR1doRzFvRzlXSnhoSUpuTVN6SHNJV2Nz?=
 =?utf-8?B?dEFMT1YyUEczK0MyL1NaWnEydkRKdHh1K2t1L0R0MktCa3FyMDFxVFNZWi9q?=
 =?utf-8?B?d3F5RDlnOWZaNkJqOG1RMWZKRkt6K3oxYlArTTZLWXc5QkhZb00rdXdTM1l6?=
 =?utf-8?B?Z05xV3ZJaWxTL2R5b1k3eHROczY1ZFI5SkRQWlk1QjJEUWordVhFSGRnWnFS?=
 =?utf-8?B?Y3hIb09lWWtoSkhHTU0yTmpxNVZUaXZYd1ozdFM0Mm5oTDEwaTNDWVI5OFRq?=
 =?utf-8?B?L0JocThQUThveC82aGJtSXhDQnp5V1FLOWRKbnpHaFBiQkx4bkt2T2FKcUtT?=
 =?utf-8?B?ZDJHYkRsTEVXUG40cWh4WFNvMkJMRnpvbVVwMnVyaHpBT3N4ZDVVcS9mdjQy?=
 =?utf-8?B?RzVkR3Rwa1RQT0pyRWxybVhKT21OTDExWEY3S2VhclRWcFFmNGlsLzRnM0tO?=
 =?utf-8?B?TnRmWUx4YjJMTWxHZzlEVGdBNTNpQ1VQK0FvSURqOFBrQk5naTgyRHErRm1m?=
 =?utf-8?B?MXVoWXg3VmR4OG94bEZTL1BOV3ZYL0U3WHRQWDFkWFBwL1VPTXFXVzQ4c1Qr?=
 =?utf-8?B?aXhyOG9WbVVyRWtwRkJVRTRHS2RvMUROc3BZZVJRZU9JM3htakJxL05oa1ZB?=
 =?utf-8?B?T0xoczI1N2FNSFBpZkptOFJYSVRuS3BPUm9TZFJQS09nR0p5cTdvQkcwNVdn?=
 =?utf-8?B?ODN4K244dUkwR2JnWHdlNHh5TVRjTlVFckpMTFR2WkFkUGNSZnlIcGVWNllk?=
 =?utf-8?B?eXBwS3BoV0tWTHRJNVQzTHZCeS9QRnRWNW9IQ3NjcVpqb3lrZzMvNkdVbFdj?=
 =?utf-8?B?Z1lPRXk5b0YvYWlPOURFV0JLQWx3SndtRTZhb1llK3l3amF1cm9NOTI0NHZo?=
 =?utf-8?Q?fnEwUhmIcdfpZgq9J4a0o/fEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b663c06-faa8-442d-1d5d-08da865c278e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 05:39:18.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO9A8qycaob/Km2R15sd4AVIBO51qns1XfteZwQdw5popnupegZi6uTUH2qwFMESYTjTnXrENZRcgPlJAM+QeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static inline int __pmu_filter_match(struct perf_event *event)
> -{
> -	struct pmu *pmu = event->pmu;
> -	return pmu->filter_match ? pmu->filter_match(event) : 1;
> -}
> -
> -/*
> - * Check whether we should attempt to schedule an event group based on
> - * PMU-specific filtering. An event group can consist of HW and SW events,
> - * potentially with a SW leader, so we must check all the filters, to
> - * determine whether a group is schedulable:
> - */
> -static inline int pmu_filter_match(struct perf_event *event)
> -{
> -	struct perf_event *sibling;
> -
> -	if (!__pmu_filter_match(event))
> -		return 0;
> -
> -	for_each_sibling_event(sibling, event) {
> -		if (!__pmu_filter_match(sibling))
> -			return 0;
> -	}
> -
> -	return 1;
> -}
> -
>  static inline int
>  event_filter_match(struct perf_event *event)
>  {
>  	return (event->cpu == -1 || event->cpu == smp_processor_id()) &&
> -	       perf_cgroup_match(event) && pmu_filter_match(event);
> +	       perf_cgroup_match(event);

There are many callers of event_filter_match() which might not endup calling
visit_groups_merge(). I hope this is intentional change?

>  }
>  
>  static void
> @@ -3661,6 +3634,9 @@ static noinline int visit_groups_merge(struct perf_event_context *ctx,
>  	struct perf_event **evt;
>  	int ret;
>  
> +	if (pmu->filter && pmu->filter(pmu, cpu))
> +		return 0;
> +
>  	if (!ctx->task) {
>  		cpuctx = this_cpu_ptr(&cpu_context);
>  		event_heap = (struct min_heap){

Thanks,
Ravi
