Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9159C441
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiHVQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiHVQiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:38:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9DB419B5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6vU5yeIlPqs8RAs5z4NIMnwYgmWN7bXxLcCeNBWoh3lkccSLe55Mk8XnyIlz3K29utD3qp+pc5v6DwsH5mNXLFzP/F9ANjWapeqcHamGFlKFJL1Gvhohvmlj+OGsk11eOAZwB4ojhfed/vMOnJs3IAtF1+V5g6zfRppc07efCD974vtz+JCYfrB8THult/0of2Evcy5XqOfj5zCX5MPZbWGbBxAtcRNlToScjWIDqCRDdQRXgtCuIf+5X2Mq13Wq4cccgSD6jdRmme5yDr3XrIBYR/kUkfWfz9EDvGUspgxzwYTynEhhES62Y++e0yeNl0mHUM+gyYLpoUFRo2D4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHgCqVTDcyqQJI4ZjCHfMwWnpFGfV2UI2lHxM/v8SZo=;
 b=bi1bBmxkAev+AY2l0ZjCO7UiUrgblWsqK9VDkITjnEiXizhdOgSXpe1rLnYHZ4n5x/CnVibMZnuFEa5Q7aS3wQbD2UHB72HT+rltEvJQy9WSRFi6kR7ZwaJ4h92kM8dp5mxLvHBngJg4rm8iLowHrsg15CC77j4B6XgwNU5O+zefkmaRkbJDoQYQsxUoKfi6rq6dSxedNByhZkweUDHJB5ynjHeEZY/ikJZbk0UiPHl1MlbEAjCHHfJPsf0ebaFAks6eiNy7xepig5rYBjn6JAgKHmRbtZafOuD7qM26aT8pcHnwPKRDPLhCcOktzIIY3A2wcBbXzHTwYyVTPZlSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHgCqVTDcyqQJI4ZjCHfMwWnpFGfV2UI2lHxM/v8SZo=;
 b=k4tCM1cBcgmvk1JxlvDt2MeAxcfahmDXmTlkT4iAfnJNrVDqB0f54cOZc+WvSeYBMKZX1ygSVs+Z6msviMDyod8G566Ry2eKjmb2OBZcHtcB6l7SwJQwpbDvBp9uT3pbPXKl4rGTDNyujvdPrNvmZ49yWcydkAOOOImHoRAX4x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB3622.namprd12.prod.outlook.com (2603:10b6:a03:d9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 16:37:56 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 16:37:56 +0000
Message-ID: <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
Date:   Mon, 22 Aug 2022 22:07:45 +0530
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
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
 <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
 <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55921085-9989-467f-fb32-08da845caabc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3622:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +auSy2nAAxvdz9JF9s1V76UiZ8UsygStCYjl6kltGdrcgBQHowCazAKutwPUXMugqLKFc7RJ3bn5qkGo5AxMA4HpsNjmqylwmmLVFRB/T54l4fHK+mGjaDce43tI21m8/O+gO2A3G3KOotFeG1e7k6OGnVj7OYNxvHhmOHAMWNpEKCr4NZpT5akvPUUlk1bL4IZ9K+aLbMAF01skjHyt8LDLncII5xx30BPZVGBOHHyyyvav1bS32XotTRZsHYjVPLigz73W0IImWehDwdsPLi+SPeVpzGgt+t0G3I5YTtbH3V20xn5VBZdMn7nYZ+9rfRbS77+kXPQKqZp8nupMKskrCstU29MpieRNSZ7PFQ+/39o9pFLXTQ8zzuqoE7F3gv/0XwQ4/q1rPZkVV3cJrMxXq83F2WLuPhKFRUHxkJIFL1CCxgMs/jiCtBd/8h3JegsFANR3Fzb1z/w0lxtnxRlU+Cc+Fxcq7daRE8HfaZOxuJ+krD+Afkdki8JEUWgghKIhTvZpVbblyF4LSkv02u3EctC88a9wOuKnQybpFTbihebaTKJGj3CRVoXe5Nad7NNfNgdiqTvTFfAILPY3Rok2m8e0+5tynlfJ1nWgBtSa2iZhLUmDEN2BgdhcS6Ddn+BJ3eKTpepMTjyuy1fwpdNy29zb5rGFDgiVhjXEXra2la4uXCzlyN38CtXKLgC80ocOZgWX29PpKmrbwwX1KwLT4CIEhZFYdm5kyEoSGym+gYm5MnNR9i1rMxGQl2o9XUn+XarEEgNq4W6X5+gcUexKzsClKohxx4PGjCLfZ5yNkEVkkZt2IlGX4q2RavpMulvfRurcv7rBlZmNR8g4RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(478600001)(6486002)(966005)(83380400001)(316002)(26005)(6512007)(6916009)(31686004)(36756003)(2616005)(186003)(38100700002)(66946007)(8676002)(4326008)(66556008)(66476007)(7416002)(2906002)(53546011)(41300700001)(6506007)(6666004)(44832011)(31696002)(86362001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akxtNjRiY0p6ZkRtR0FIb1BGZ3loWVFaVWdYeDZTNGJPak4zdndaM3ZTcGlh?=
 =?utf-8?B?QUpBSUpuVXhwY09UQ0ZVaWxHMkFTVzgrZHo4enM5d252V0o3NEtybnZHZ0VF?=
 =?utf-8?B?RHhzRk9wZW1FR1lOZ2lpaWsvc25Henczbit5NTJ2aVhDQ0tUTGtLZXh0SXJw?=
 =?utf-8?B?OU91bUxzSmVLdFNxTE5tSUNSblY4NklxaHpBQmo0SHAwOUhyOFdLVkMxV2VV?=
 =?utf-8?B?TEZ3ZzdncnRGKzgzNjh3V2VWdUhmS3BYVkN4YWYwMVRrcnc2SHFKa1FoTExz?=
 =?utf-8?B?RUUxVFVnS3dNV0pUTEhvREhqRENhKzFKeFlGQ0hNTERoSjFXcmFUSStCNHRk?=
 =?utf-8?B?d3ZDWWdKaFREMTVHK1dQeXBnM1AxNnpRK1U1cDl0MitUSkJBaTg3MC9CK21I?=
 =?utf-8?B?OCtrdlB4MGcwTW5jWWwrZk1SWGZSVTMwUjBQWUdOTVhwR0VaVjN1S2Y3cVRG?=
 =?utf-8?B?eTZPM2ZKb0lIRnBUenE1dDVmUHVkcnBGcy83RHUxTGFLU3pGczhycWU3THg5?=
 =?utf-8?B?R3pVNEcwYmhsTkpjSWVncmVrWTQvOHNIYVBxN3FOYklmeStiQXdnUjBXc3BV?=
 =?utf-8?B?dUpmbWxEbjY5Z2xCS1c3VytkQUorczBCVTE0WWVxN1lDSXJoNDVQNXBlRUlj?=
 =?utf-8?B?L295K0pTcWpnNU1aYjR2YU5PV0s0MHBWa0RNUE5DUmdXMERncFFpWjJRem5n?=
 =?utf-8?B?SnA4bDlvOWpDRVFyRzh1amFMa2RBSFF3VHE1cHFnSTcxc3FEbE04OVJkSzN2?=
 =?utf-8?B?UUd6eDk0amJDMmJvN3EralpVSG03U2xnam9IZ09ZVXhLNFk0UTZJbFordEow?=
 =?utf-8?B?emlxaGl1VVJEbFNuMGhWYmxSU0NETXdtOVAwdkxEYS9YdDFHTmlNcE9Qanhn?=
 =?utf-8?B?OXY2TGlBUHVXZ3puR2tla0h0aVlqb1p4Wk90U3NYRmhzSGd3OUpkZTB1cU11?=
 =?utf-8?B?YXYvRmhSZFU1Q2hQcHlPa3J4eWxvbEcrU2dZdlA5Ti9aZEVlWld0cEJwMng3?=
 =?utf-8?B?TWtrTkxVWWo1a2RMZUVkNFJJSGh4ekJFWnUxc1VOaVNZK2tnU2w2T0pKSDBG?=
 =?utf-8?B?dzZFM2c2VFk3SXBoTmNSWFpodHVQQzhnWHpFR05KNHNUSjZRSGw0NW0wWGdS?=
 =?utf-8?B?b05XUDRxYjlDS3VwNi8wSVlzVjVhRmFNY1F2OU1WcG85MEZkdUJWMzV0aWdo?=
 =?utf-8?B?VE5JRXN2cHN1UEJnUXpWTiszZjlKUVE4bk5NcVBGU2hSTGwwa3pPRGkwTG5o?=
 =?utf-8?B?d3NJYm41ckpBbUgyc3l6dEdiOU5XM2VZcHV3Mi9qeFRNMnRjTlFNc2JJbzVz?=
 =?utf-8?B?WU95ejhvT1dVazJPWnIvL1c4Tjgrck5JWlU3bmliOEtLdUt2Mm5RSXdLYWV0?=
 =?utf-8?B?ZXduUHpucFJlOHJmTFdpWXlOM3VVRnhXc2ZMdnQzbkFxUG1jYzhsSTNiU3VS?=
 =?utf-8?B?NXdibzNhRWxteFdFQ2hQMWJKNkcwSy9tb2dtbFVYYkx1SXdVcVE1eHkzS3JX?=
 =?utf-8?B?MGdXY3p4aEFhbDRwMSs0N0dMb2dIYVVaV1hHamhET1F2T3R3WktkSUhqRU5s?=
 =?utf-8?B?dWNNSmNQa2hMQ1NmT2NKSGlnL2czcDdzR1ZUTHFPQXVzVWVGT1loYXZIaVpu?=
 =?utf-8?B?R1FXQ3k4cXZHUzcwajBLd1o1TGxNM2NzRE5OeWRMQlNicU1DS1pOcmpOcXlG?=
 =?utf-8?B?MXNXa09CQ240azk4aUtZbVArbjZiMHp2SUJIUUNUU2tLODVEbFhiRng1bisw?=
 =?utf-8?B?OTF4Q0ZsMHRSR3FFU1VtU1N6MW1PbVhSTytWM0ppNDN2ZGpFSnIwK294VVJm?=
 =?utf-8?B?QlFiNHZRanJEQ2hvQWZUS2JFVXoyWGNja0EyTWY1eUhDcmxHL0pnM2d2VlZM?=
 =?utf-8?B?TFhxQlBnYjliaHNBRXZybVJPSkJtbDA5ODk2QTVRZFYyTlJsY0VKYlhycVhS?=
 =?utf-8?B?WGtKemlJTXM1MlZYTG1Oa0orUHFBeEc4QTNqM29EYUQzOEI0SEFyUkJNVFM0?=
 =?utf-8?B?dnRMUm9KV016Q0NNL0UxRmRwQVZNN0JjNDhQd0NYNlY5ejJJZjE0dTFibHJL?=
 =?utf-8?B?UUc0dUpjRElKU2N2NzYwZnJOUjNZdEVMY2p4ZzJWT29DenFCYk9wenFpdTln?=
 =?utf-8?Q?Sse/GPS6MX6ZxLAZBl3MHJluQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55921085-9989-467f-fb32-08da845caabc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 16:37:56.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTUKXOESUqAZBWN8Va0h7c2PX6h9FFDrW0OpJZWq7kvT/J4Bb17a/YPe0u4jkATJLxMHORzsToVFrGCwKkpdnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Aug-22 9:13 PM, Peter Zijlstra wrote:
> On Mon, Aug 22, 2022 at 05:29:11PM +0200, Peter Zijlstra wrote:
>> On Tue, Aug 02, 2022 at 11:41:42AM +0530, Ravi Bangoria wrote:
>>>
>>>> pulling up the ctx->mutex makes things simpler, but also violates the
>>>> locking order vs exec_update_lock.
>>>>
>>>> Pull that lock up as well...
>>>
>>> I'm not able to apply this patch as is but I get the idea. Few
>>> questions below...
>>
>> I was just about to rebase the 'series' to current, let me do that and
>> get back to you on the specifics.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/wip.rewrite

Additional set of changes on top of this tree is required to build and boot,
atleast on my AMD machine:

---
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ccd231ea6a4e..94fb65d7b291 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1248,7 +1248,7 @@ static inline void amd_pmu_brs_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->pmu_ctx->pmu);
 	cpuc->lbr_users++;
 	/*
 	 * No need to reset BRS because it is reset
@@ -1263,7 +1263,7 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->pmu_ctx->pmu);
 }
 
 void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 31ae032d6783..086e37fa32be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -843,7 +843,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 
 	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
-		continue;
+		return;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_ctx_disable(&cpuctx->ctx);
@@ -881,7 +881,7 @@ static int perf_cgroup_ensure_storage(struct perf_event *event,
 		heap_size++;
 
 	for_each_possible_cpu(cpu) {
-		cpuctx = this_cpu_ptr(&cpu_context);
+		cpuctx = per_cpu_ptr(&cpu_context, cpu);
 		if (heap_size <= cpuctx->heap_size)
 			continue;
 
@@ -2315,7 +2315,7 @@ __perf_remove_from_context(struct perf_event *event,
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
 
-		if (ctx->task) {
+		if (ctx->task && ctx->is_active) {
 			struct perf_cpu_pmu_context *cpc;
 
 			cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
@@ -11972,6 +11972,15 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	goto out;
 }
 
+static void mutex_lock_double(struct mutex *a, struct mutex *b)
+{
+	if (b < a)
+		swap(a, b);
+
+	mutex_lock(a);
+	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
+}
+
 static int
 perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 {
---

With this, I can run 'perf test' and perf_event_tests without any error in
dmesg. I'll run perf fuzzer over night and see if it reports any issue.

Thanks,
Ravi
