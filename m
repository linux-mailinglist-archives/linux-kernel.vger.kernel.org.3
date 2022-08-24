Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6E59F2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiHXFH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiHXFH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:07:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B0280009
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icdWEW2l+Um0SKm8Fe19b4v4sJreiOs5ZkFajuO7VZZdli2oViTuN7kaUHP1gYoSl2gAGJsKMc2uJaswsUWcno76aqh4cpmFWvyEf8oJc5VBdhTJZYbPf2F21C19zRzbpFINtmaZ/268zsRelN1ifBcLFs6rOKFCP12hP5Im+N6YF5YcQ0CzN4w3CipYs0w4K1KLKVTltXDFRH1SnLoOGWUWkRGeIREbMeE3Q0g+5Cev8OQGoFi6BcUoaRPBO0Mex7hW+eK6uhTsnxZF5CbrTO836/8MEDb4cUkLeB9TezvMcEEoxDG6vOcSnl1CoBR3xM4I47osYQ3Op4ECr9bkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CHEj5ZnnHMwWsvr9EIthmK67FrnP5fkx5zsYDeI60Y=;
 b=CX7gqei3nrSPCeF5hgDE2qBFkMBZ8SklxWciQ05IVUSweOfRnzRaQlgQ5IKfcGaCtoPd8iKXEaFryu/5jGPBxdlSa+SnX34UdsafBmO8vB/q3rg6Hoc1SSwJR9j8MD7LT4/bqCPBRU25ighmsUQnhEKnDb0Wl20B8XeQn6nHoUyWRNBX1kYJncJ/yBwzFiXASiV8WRCj6V1pBMlBxrqoWmj9LkoD0UgqPb5bO3e7izWVnNSCiL3WuTTfT/tmIa1oHsgHnBaE842jIDwjb8XaPsmyJuvPjlvha+xZGp9RIgVnlRahdHBsCepb35s4flwSGxGhDw5IoT+VuTghQLnDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CHEj5ZnnHMwWsvr9EIthmK67FrnP5fkx5zsYDeI60Y=;
 b=3dwJ7PkId+XfvteW3LtoAS7hiOH4y2v0rINS/6UOyh2+XPsZoQ1FvPzfdg1iOJOLNT9UkQ/zKspBcOGZL6FxbPYZqT8XJ5/VzAwVMa7B39D5c3DZ6JNLeea9i/c3fWy9zwwjPhi7KD5IFwMEUzHXkMgWHlJG00MHU/iiyNO2cgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Wed, 24 Aug
 2022 05:07:52 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd%3]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 05:07:51 +0000
Message-ID: <cf2cdf28-8678-8e61-9992-a460e61d3ce2@amd.com>
Date:   Wed, 24 Aug 2022 10:37:36 +0530
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
 <YqdNKJllCVMci3ov@hirez.programming.kicks-ass.net>
 <aab04cfb-2dd5-89dc-213d-7fa253615864@amd.com>
 <YwSWhXW+BUA3WkIE@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YwSWhXW+BUA3WkIE@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::30) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 277f86b7-6663-438c-3cb2-08da858e97d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPu3ztwhzdgUMo+sJeLQo6zMxxJPLJM9ctj+ZAfEX4k1fGRE1MgH+uZv4+ZIDe+WMa+G7suulrtrwyK+YQa8wAeUUa2mnFiMKerwmGhaTPOs1IfeC/jErtzQ6j2cH9+ZJXxFCc/KWyVHnI88kmNqTvARETIEUN71uquR273/E2TFinTVtHCFFSC3c+85uFETFXrgEwCpUsHd0ha5XRkN0mJIyY1U0LBSCyzyfMg4JnWOFvm9AW6hNtAql5xvWPqnDhF/hVpkstDu5gxAZyEDOJzO0X8Oolv6AITKs9Px5otiGe5cpIOEJ0F8kFqY5o/rzJWhEBXZ3LaNoDKrKvXIxsaDwlXpQRfm4ivzrhMKBrm4wXss4jtI87yZe+f9X83JngcNFheDVWsLcjxReHCSYvp2wtYST2AHWQ0N/XCNEZGxnafX4pnHVhDY4D4Cke285o3kmLg1O4VUuzMFDUGCR2GQczrC++3mL/z06C0Sa0uRVzr3RlhDP+s6ol82Y18mZ3GZYi6kCBuyAHs/2j5Af7kfDflaQjXJ15iCEwU1p6TwLcn/8Toy3tWIreGiO1c0XpjzQGuX+TNWaoKGR7hQ++GuEbSbg2fme/7ruuAaChwmqTC1w1SmSPxjskoVOlvu9B1vAGRMLoxb1NLIPgN2fLKUNl5gin2Q7HxefwqFvq3HtTNmhpU99cWysLcz32Pd8Fcm0wyJJtFjZA4AsOxJa8vKIa6lhmAR4ovK4BQMrqOI3mAWtM5NEb4NvGBt18T7YEpU/jReedVJZd1GbiMUKnwwwALosHWNi86rEQto7mAoeNO4x646kdlryDnOtWVP7xbvB4A7M4G1wWd22e4N4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(86362001)(31696002)(38100700002)(8936002)(186003)(5660300002)(6666004)(44832011)(7416002)(6916009)(41300700001)(478600001)(31686004)(66476007)(316002)(66946007)(8676002)(4326008)(66556008)(2616005)(36756003)(26005)(83380400001)(6512007)(53546011)(2906002)(6506007)(6486002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1QreC9wNjJPa29FdFlhQ3JINHNNNWpaTElMbFZ0dWdHdTBkNUJpaDhwSlVG?=
 =?utf-8?B?a1VZWjJiOHA2a0U1YnA3UUVLTlFuV0w4SXRxM29kYW1CZXV2WmF0SnF4c0Vj?=
 =?utf-8?B?V2szdFIwZGFleU5JYjVERVRLVDhtUVZ6QTZycnZ0M1hmMHBQWENWZGNCVUlo?=
 =?utf-8?B?ME9RUjZZQjJiN3RDMFFqbkUvQWVEeEc1UmhvME1PU3VMSWJaQ25ZMWlkTnl5?=
 =?utf-8?B?TzlDZWk3QkxHY1pybHYyN1pnVVY2TUY2TFFraFR1STZodXZaQ3pkcThPcmpR?=
 =?utf-8?B?bEM1Vys5M2ZVNGdqb3piWFVBQ1NoSkxjOEJlS3BRcTJHY1plWHFwYTNQTU9i?=
 =?utf-8?B?azZwRkE5a2JlRWJWTitxMi9ZeVRXTnJ0cGxWNVlVc0QwUW5YUW1Tbm9WVFdN?=
 =?utf-8?B?RnRaVmRueVZCTk1SWGttK2ZPTGhnVzRucmw5WnhJY3h0QUlXa3JVdXl5Ymd1?=
 =?utf-8?B?K3pIZlk1Ni9jMTh5UkpZcElHS0JyUUlGem5ueEVnaE15cnIvUlhHNGU1TEFX?=
 =?utf-8?B?WW42WG5zb0pVbWlBYVorNlN3MjNjTGJ6Y3ZLWFRuckZnVHFZZEFNVFpsVVJu?=
 =?utf-8?B?Y1RBemRPZ0FyYmZtdTErM2d2MWN4ckpRdXhCakN6eGc5UDlZamUvNzBvSlNS?=
 =?utf-8?B?U1NzN3VkVXQ4ZlBRT216QWIvMnZ4MkpJUE5yN0xhVlN2M01abXVONHlIdXBo?=
 =?utf-8?B?Nm5zYnpkTHlOTnFCS3Z1YzFQejRSUmtmVnluV3VkNVpkVXdSTXhiZXlhSnNs?=
 =?utf-8?B?bG1KUk1sZXVLWCtHQXFNM3Rqb2VPT2lwYWJBYmR4UGMwZmFTdThnaGs3S2lQ?=
 =?utf-8?B?RFl2ZFpVWk9oS1ptL1RZbVZUSUprd0s5ZTNhdktVcWVLcy9HLzFOWEJvcitB?=
 =?utf-8?B?cDhackk2cXhoblhUckJ2cWZpMXNYRzkvRXBtbzQ2L2YxTVZkWStLUFBKRU5L?=
 =?utf-8?B?czFKaWxiY3hPSGRoSGFybW5JL3E1ZVE2S2YxU00xTXBWazlIUnhQS1lUU00z?=
 =?utf-8?B?ZVZyVmxUdmN2eit3YmtOUG9SUGNFSFdUeW14eC9sMVBzUnY1anFQU0hBM1JE?=
 =?utf-8?B?Q2lkcUZuUU03QUo5VytvZVo5RmdYOUFlN1V0dW1ITGpmVkM3UFF6NURnT3o1?=
 =?utf-8?B?c1o3R3NYMU5HR2hnWXR5U2MwZnhnZmYwMlo3UDFFdXdzSWxCQTBkVzlHY1dT?=
 =?utf-8?B?em1LU0h4NjdKelBDV2pMWmJ5RmRuVE5vWGlQL3ZEdmtodXNLTnU1dmdQaENk?=
 =?utf-8?B?T0J2YitDVFIrWEVETnVnU2l2U1IxK1gzcmphN0dyQVJ5cWJUQnhJcU1KTmk0?=
 =?utf-8?B?R2hxY0cxQXY4Q2dWSG0xKy9SaERmQUczd2xjd3RBRmdwSXZXQi9KMGZUYTFu?=
 =?utf-8?B?ZnhiU3RaWEJYSU9KT1FNNTJnUGRmM3ppVkI0ZnBqcExSb0h1UHIybGowZm9Y?=
 =?utf-8?B?dkFLeStscDdDT1F1STFFUjM1UDRkakpuWXZ4MkVzaW5MMjdRTExTTFhZemtp?=
 =?utf-8?B?TlNOUTJDMzcxb1JNaFRUa3l1Vm9rTnpCM3MyYi9ZdG1EQ3NMSCswNFl4VzNY?=
 =?utf-8?B?bE96amxXb0VSVWw0VDYxOGNIOFpDeFBRTHVqdktrOXBNTm1VNVpyT0ZpOWls?=
 =?utf-8?B?NlNySEc1SlFmTms3N3Z0TElhVmFOYTl4dUFCWEp1Nm5KYktnNjd5NitnQ1J4?=
 =?utf-8?B?RnZ1akljYUNQMXJJeW0rdml6U1pCSWp0bDUwSTNCWDBZTE15THMyV05RejJV?=
 =?utf-8?B?aG01Q3FBb2NYYW9LeDhhZks2YkxuajlIMkhIbi8xN3NVcTFoTUVMejlUL1lZ?=
 =?utf-8?B?OXdrVXJqS3NPTStmZzErN3dhZ2tFRkl0Yi9QdVNiNjRTaVYyNGY2MnE0WTRP?=
 =?utf-8?B?dGhqRnNFSmQ4bW9pa3ZsK2J6d25SZ0d3WDA4Qmhvclh3cTJ4bmJySmp6RDly?=
 =?utf-8?B?MDIwWmlJZnBLNkZKMjYwOEVKRXBvUHhTUDExT3VEaER4T3JydVhHSEU0b1px?=
 =?utf-8?B?MVowUDFIc3BxOUsxblZkd01OeVovZVRKQ1Q0bHg3NlAydzFlS2xhaGdsN0ox?=
 =?utf-8?B?TkkzRDZodEMrWWQvMlJ3emNrYmt1WGpjcVM5YUZjWU81aXFJYXI0VXFkaW5w?=
 =?utf-8?Q?VPnVl0dEVJWqMCTyneam/eaby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277f86b7-6663-438c-3cb2-08da858e97d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 05:07:50.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25NnaYmJaWRDLWdph3SXVXvkcPGMeMIhhkH/jXIeMcvsKyrRi7v8R1IMUy+mvHN+TpEeZ6yrbhAZXBOWubs17A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Aug-22 2:27 PM, Peter Zijlstra wrote:
> On Tue, Aug 02, 2022 at 11:46:32AM +0530, Ravi Bangoria wrote:
>> On 13-Jun-22 8:13 PM, Peter Zijlstra wrote:
>>> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> 
>>>> +static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
>>>>  {
>>>> +	struct perf_event_pmu_context *pmu_ctx;
>>>>  	int can_add_hw = 1;
>>>>  
>>>> -	if (ctx != &cpuctx->ctx)
>>>> -		cpuctx = NULL;
>>>> -
>>>> -	visit_groups_merge(cpuctx, &ctx->pinned_groups,
>>>> -			   smp_processor_id(),
>>>> -			   merge_sched_in, &can_add_hw);
>>>> +	if (pmu) {
>>>> +		visit_groups_merge(ctx, &ctx->pinned_groups,
>>>> +				   smp_processor_id(), pmu,
>>>> +				   merge_sched_in, &can_add_hw);
>>>> +	} else {
>>>> +		/*
>>>> +		 * XXX: This can be optimized for per-task context by calling
>>>> +		 * visit_groups_merge() only once with:
>>>> +		 *   1) pmu=NULL
>>>> +		 *   2) Ignoring pmu in perf_event_groups_cmp() when it's NULL
>>>> +		 *   3) Making can_add_hw a per-pmu variable
>>>> +		 *
>>>> +		 * Though, it can not be opimized for per-cpu context because
>>>> +		 * per-cpu rb-tree consist of pmu-subtrees and pmu-subtrees
>>>> +		 * consist of cgroup-subtrees. i.e. a cgroup events of same
>>>> +		 * cgroup but different pmus are seperated out into respective
>>>> +		 * pmu-subtrees.
>>>> +		 */
>>>> +		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
>>>> +			can_add_hw = 1;
>>>> +			visit_groups_merge(ctx, &ctx->pinned_groups,
>>>> +					   smp_processor_id(), pmu_ctx->pmu,
>>>> +					   merge_sched_in, &can_add_hw);
>>>> +		}
>>>> +	}
>>>>  }
>>>
>>> I'm not sure I follow.. task context can have multiple PMUs just the
>>> same as CPU context can, that's more or less the entire point of the
>>> patch.
>>
>> Current rbtree key is {cpu, cgroup_id, group_idx}. However, effective key for
>> task specific context is {cpu, group_idx} because cgroup_id is always 0. And
>> effective key for cpu specific context is {cgroup_id, group_idx} because cpu
>> is same for entire rbtree.
>>
>> With New design, rbtree key will be {cpu, pmu, cgroup_id, group_idx}. But as
>> explained above, effective key for task specific context will be {cpu, pmu,
>> group_idx}. Thus, we can handle pmu=NULL in visit_groups_merge(), same as you
>> did in the very first RFC[1]. (This may make things more complicated though
>> because we might also need to increase heap size to accommodate all pmu events
>> in single heap. Current heap size is 2 for task specific context, which is
>> sufficient if we iterate over all pmus).
>>
>> Same optimization won't work for cpu specific context because, it's effective
>> key would be {pmu, cgroup_id, group_idx} i.e. each pmu subtree is made up of
>> cgroup subtrees.
> 
> Agreed, new order is: {cpu, pmu, cgroup_id, group_idx}
> 
> Event scheduling looks at the {cpu, pmu, cgroup_id} subtree to find the
> leftmost group_idx event to schedule next.
> 
> However, since cgroup events are per-cpu events, per-task events will
> always have cgroup=NULL. Resulting in the subtrees:
> 
>   {-1, pmu, NULL} and {cpu, pmu, NULL}
> 
> Which is what the code does, it iterates ctx->pmu_ctx_list to find all
> @pmu values and then for each does the schedule dance.
> 
> Now, I suppose making that:
> 
>   {-1, NULL, NULL}, {cpu, NULL, NULL}
> 
> could work, but wouldn't iterating the the tree be more expensive than
> just finding the sub-trees as we do now?

pmu=NULL can be used while scheduling entire context. We can just traverse
through all pmu events of both cpu subtrees.

> 
> You also talk about extending extending the heap, which I read like
> doing the heap-merge over:
> 
>  {-1, pmu0, NULL}, {-1, pmu1, NULL}, ...
>  {cpu, pmu0, NULL}, ...
> 
> But that doesn't make sense, the schedule dance is per-pmu.
> 
> Or am I just still not getting it?

Ok. Let's not complicate the design. We can go with current approach of
iterating over all pmus in the first phase and think about optimizing it
later.

Thanks,
Ravi
