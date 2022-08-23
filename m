Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5F59D043
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiHWE50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiHWE5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:57:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BD5A148
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdb+kdpfts12k5sITh+fIjNja7/Dg2gSs+0PPsnJSR8OXHl7t2qW0SkjYzuo4VUtICo5bZl0kOGNuB71cIXTCJoQDCunZkMsLYr2CS489M/vILMW353aP6bQVi4/nHmQDiwe/RhPn9GQlGSPWJNEvpBuswC9/9vSzON9pqNlv58s8zt0jLoUNFvEEuw8MxDDvh4P61oQEYKWQlrQc8x/48aOa8TVKpfAzUjIPImsPpm9Url+oRe383kGYUbUFFi05gsKQ8EDYZWUek61RiovGnnL4QGRCrpAROOC7QUMy6TVDFynKtrpARNKvX38co4pspHo0IPbNtqsH77QUrSfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj0Y3eARDQjKyWWqFQE1Zi+qCC/i94jU0yk/iMGisU4=;
 b=drG6TOzjTgAc3cvH4/KZgTD3wNUiHsSB+5cIKXTGAUMPFIbYXYbJ1CUgKOJeWJ3uRFqUMn5GHXKm3nxSK1cVUUYL0CIn3mcGiECT83XLPNHsuvTGMkWMh5VQ174d4loT6++0WVubt5IiD8PcJo++hBQITXddzH3QPnsk3ZJ2fSeKMENRc1K/LluQ8qwUQmdUyyVYKoRDFi+34A2aOuvuHrnqwB8KHg9SBlT1fSISzF7rcya9HrxGlnM65CY2wIDtrhuBhqGGNhaDAobG6QT6L8/02QeC1ugV4iith+PWt1dv9nbWx/Jxo5g4glEtC/nuMdT4YJoXoeTYU33eHukYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj0Y3eARDQjKyWWqFQE1Zi+qCC/i94jU0yk/iMGisU4=;
 b=mDyEUA7OLP7nHOG+JbqPWKYdYUjnuMDk+moDkTZ+xV3zGREILXxUuvrkh0Ml5U+E87eY/m8wDnIZKkfnypDe0xjjJE1vsIamHMzu+TOBmXhxJl7Ak0Qc8/6WJ7CEmSygPvUh5ub+KqbCw5F1bo0dmBE4jXe8qdVi+g+MQ+HL980=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4825.namprd12.prod.outlook.com (2603:10b6:5:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 04:57:20 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 04:57:20 +0000
Message-ID: <8e8202e2-6e28-61f0-b6b1-d3f782ba90f7@amd.com>
Date:   Tue, 23 Aug 2022 10:27:07 +0530
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
 <YwO0Nh5LHZ7uzWvm@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YwO0Nh5LHZ7uzWvm@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2944c19e-226a-4857-18d6-08da84c3f585
X-MS-TrafficTypeDiagnostic: DM6PR12MB4825:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO5GDj7bpOT7m+J1W6C4osqJERkhXRW23DFyON27SONf/okBn5diD/OP6mrSIcK4uMSLs82fMNMwOddnGaH1A2g+b9Lh6Ie4ePw4C8EYT6e7eUsZk4cTvTUMbU1rLUK3e3NvA7f3EXe/f60sImTNCejr3d1//bo1bWGD/0nuI9Aiyk740YD1PQRod8+3/Ta8kMOSMENV9BLRkgV+mdd7zkPQSSn4kXVXXdCvbWOa8mxmW0uvtAOyKrycBsIS9byVXNAI8tLpFLaUDQAt5DkUsSIwmcTIotpTnaVC4ualYqq9DAG660tshRx5zOck0YIFM7gIWe1ojQ9G7UVvoijY3g8Qog5w6IUddtWvl8cKeCWk4YHbdPkhDZH+5y5XMjKIJmE0uViWZOBSgQieXp5uEzPo26DW+EEJ7mju2jiUxRrHWKR2sQoWsXVuX2LJUoFQcdt2zHsnZj3f7Ul7k5a0RpYNmzZLoArXab8tuBxLK158YlHK9xo21RQZFFzG+lXKTaqk7X7lAuVAC83Qm+cWMH2/9KsJFqWbuR6eA7mMFbrCt6Wwj0QjDJSK/294P2xAKvrHZhuEzOrv2oYxn+WNmTYi/X230uzb4whln2p5uL4JDRKm0m84DqeZnmpMiUZqN7PJqtdehTp7vJXzJRAKVO/lAKdtad9ph+1dJDRP+yzHKEtPkk+gqALnuWKl4FDDVysgFDCVjHKxq818DXJmJn+vIVgLqWUFWleX1w+JE0rKIlUzD2G3xIVR240Xk3a3iH6RrNwVTzmdYWO9GEVG2F8dr3kYdL5S9pvMP1IL114=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(2616005)(38100700002)(83380400001)(36756003)(66476007)(31686004)(4326008)(316002)(6916009)(66946007)(8676002)(66556008)(6512007)(26005)(6486002)(31696002)(6506007)(2906002)(53546011)(86362001)(186003)(6666004)(7416002)(41300700001)(44832011)(478600001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDhXQ1pRM3dEeTA4REk1L3Ftc2hxc0R3bDVrRGFFbVFyWGZLbEE5aURPcm5n?=
 =?utf-8?B?UlYzL2RzQmR3aU1uY1p3ZE1zcUJjb3lESFNydURCQUJxMzBCNTdjKzA4ckdr?=
 =?utf-8?B?a0NkSlV5YmdSRmRpQzdtZXBXS0toaCtMYTFDd3FBWU9LOHpoWDN3SFB3TGVV?=
 =?utf-8?B?byt5SS9xVGxvZFdPUTZMcGQ2SmdSOHlDRHQ1em9wZzgyU2ZZVWo0U3RmUTZk?=
 =?utf-8?B?emFXMGw3WGJaeHF0MzJZWmxLZENHNGRRY1lWYmdPTkgvMzdPaDRjamtIUVdW?=
 =?utf-8?B?VFpVdExnamRndDFrSCsxZ2s5eU1TSzZQNTNMRE5kT3diaFVkNUpaRXhUMkpX?=
 =?utf-8?B?aFBqU2tPTExuSFdsZUFzNnRmZFJhc3Jkd1FaREJWWC8wQ05PeUNYRjVDVkxE?=
 =?utf-8?B?dDQvUDJqTlRXV1NRTGVKY3VnbXI3azMzOVQrV2lZV3c0ZDhoVjlndDZtMU1o?=
 =?utf-8?B?enlCYkx6THB0aGhHYXlzTFY3MnZuSldNSGc2Umg1OFdOSVd5SkQyVTBpQUdp?=
 =?utf-8?B?VHhXa3FoS29SQlhZL3F1UDE5M0VxYXlLZkNHZlJmcnovby9FSndiaEdKd0M1?=
 =?utf-8?B?bkY4VVpCaUVLemdHOS9yL2I5RE1lTDZWbmIwK1dqaEpNVFVNZ1lLTmF2aG1x?=
 =?utf-8?B?dnVsbzNzVS9uMTA5ZjF2OWIvV3d2a05vN2lrYm9zNUUvTDMvZEprUzRaSDNG?=
 =?utf-8?B?ZmIxa3pXR3VWVEErak11YnNjd01aYnRrL2RFWEVYd3pVemdML2UreXhSVkxN?=
 =?utf-8?B?SVk1UmpGbUdiRnMyVFMwd2t1V1RCWFRjaFJnSjk3SDl2VEI2OURGcWxjY0pk?=
 =?utf-8?B?ZDR6SVhhSk0zclQ5Y3pJMUxuWkVrNkNveEhwRGpONmdQenY3dEg2VXpIa2hN?=
 =?utf-8?B?SmhTTkNtMzZLUER1UzVoNXdJUFVGbGQ2dGdreWp1SDVaaVlzZGd4R01qV2NI?=
 =?utf-8?B?VVZlL29IRTBrR2E0RDVWR0Q5TXNORm9qdGVjZGMwaUwyaXRsc0pITXhLa2JU?=
 =?utf-8?B?TjQyckV0MWo3U2x0ckZrZ3RrYzh4OFhPa3RIRFZFd0JxQkJKTmhlS1hqVmYz?=
 =?utf-8?B?UzRkN0dZWXpLNStDbk1wendKZnczQ3paa3hvekZ3bTRKMmhqU3QyNG8zd1FF?=
 =?utf-8?B?NjBwcnY5ZCtqWHhwdGFiR0hSVkliUGdRSUlPSjY5MDlUYUlvY1FhQlZaQldC?=
 =?utf-8?B?Vk9YZDM3T3kwWlNJaUFPWFpuVEtQM1VpUmwxbTN6WnkwS2dGUElSQ0g2elZK?=
 =?utf-8?B?S3ZpcytsTjNtUmVBNC9kQ1MyMlVUY2xEaHF5dEIvV05SRlZyb2dOTVBwa2du?=
 =?utf-8?B?bVIxdWkrTnloQnptZ2ZGM0NnbG1mYUErd3hGbVVSbDBpc1J6Z0M1RkQwbi9G?=
 =?utf-8?B?YXFhMStKWllRd2lQWURDblJGQ0lKdktsU3N3L3pGVzVicTI5Yml4bWpVZlVv?=
 =?utf-8?B?RXE4V1BKMDRGWG9ObVMwTlB3SXNxTXg5YW4yTDZ0VmhZMjhLTGFMMlhTWFE3?=
 =?utf-8?B?Y1dIVy83YnYvM0Z1aFVvUityVVZycUtEVC8zWGI5L1ZvaVRPNVMrdUs3elZI?=
 =?utf-8?B?WWZtNHUvYkJZb0dSL0FFSS94cmd3eGJvYzRTSVVkYU1hU2g2RjBzZnZLQ01v?=
 =?utf-8?B?bmZhM3VxdEtFcVBySEhyK0orOGl3eURKM29HVUpMVU9aaHFGenZQbk54Z2Fy?=
 =?utf-8?B?VXJhbzJIeHJQNGg2L0hFMHk4K2RMQ0FKWVYyem1XZDlyZmU1eUxjVUdGNDZN?=
 =?utf-8?B?anlpVDVBNWZCWk9PL3RUQ1VhLzhDWlJ2VTJuUFhvQkF5ai9yMFVMZUFBY0wr?=
 =?utf-8?B?cmRVbnZ0V2VwNzJRRGtxWmhkMkRuRnRSMFVYNFdlUU9OZWpYSWRQWGQ0WjAz?=
 =?utf-8?B?cG9kMlBodXZGSnhhSFUvTnpZUVNSbVhqT3VBeldXVVYzMkwzRUEwMldwdEVr?=
 =?utf-8?B?akFZdE1ocytzQjluQUNyT3UxcVZKZTdsSmYwSU9hTmpIdDNPYmppKytLUjJW?=
 =?utf-8?B?YkRZZm5vUWVnSTRkeTdpOFdhbUQzOUdmem9vRjZ6VHRYOFRPV2RkSGVHdktx?=
 =?utf-8?B?ZWk1QXNUcXo5MTlDSFFsWmxHOXNpN3dQNzJvS1lKTVp3SHp0VkFscE1KSlhU?=
 =?utf-8?Q?Pnd679EZm/rC6yE9I/K3I3WK4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2944c19e-226a-4857-18d6-08da84c3f585
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:57:20.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRHefAh8dW2scetON5oZ2Pt5KtAsnPsYFH8YwUhtLPqugHTHbFyKQgWw2f0MbAd8xQKZDO7fXf3SYAJYT4a4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Aug-22 10:22 PM, Peter Zijlstra wrote:
> On Tue, Aug 02, 2022 at 11:41:42AM +0530, Ravi Bangoria wrote:
> 
>>> @@ -12358,58 +12374,14 @@ SYSCALL_DEFINE5(perf_event_open,
>>>  			goto err_context;
>>>  	}
>>>  
>>> -	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
>>> -	if (IS_ERR(event_file)) {
>>> -		err = PTR_ERR(event_file);
>>> -		event_file = NULL;
>>> -		goto err_context;
>>> -	}
>>> -
>>> -	if (task) {
>>> -		err = down_read_interruptible(&task->signal->exec_update_lock);
>>> -		if (err)
>>> -			goto err_file;
>>> -
>>> -		/*
>>> -		 * We must hold exec_update_lock across this and any potential
>>> -		 * perf_install_in_context() call for this new event to
>>> -		 * serialize against exec() altering our credentials (and the
>>> -		 * perf_event_exit_task() that could imply).
>>> -		 */
>>> -		err = -EACCES;
>>> -		if (!perf_check_permission(&attr, task))
>>> -			goto err_cred;
>>> -	}
>>> -
>>> -	if (ctx->task == TASK_TOMBSTONE) {
>>> -		err = -ESRCH;
>>> -		goto err_locked;
>>> -	}
>>
>> I think we need to keep (ctx->task == TASK_TOMBSTONE) check?
> 
> I think so too; in fact the code I have still has it, perhaps it was
> there write before this patch?
> 
>>> -
>>>  	if (!perf_event_validate_size(event)) {
>>>  		err = -E2BIG;
>>> -		goto err_locked;
>>> -	}
>>> -
>>> -	if (!task) {
>>> -		/*
>>> -		 * Check if the @cpu we're creating an event for is online.
>>> -		 *
>>> -		 * We use the perf_cpu_context::ctx::mutex to serialize against
>>> -		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
>>> -		 */
>>> -		struct perf_cpu_context *cpuctx =
>>> -			container_of(ctx, struct perf_cpu_context, ctx);
>>> -
>>> -		if (!cpuctx->online) {
>>> -			err = -ENODEV;
>>> -			goto err_locked;
>>> -		}
>>> +		goto err_context;
>>
>> Why did you remove this hunk? We should confirm whether cpu is online or not
>> before creating event. No?
> 
> Idem.
> 
> Perhaps it is best if we look at the end result of all these patches
> combined and then I'll fold the lot if we're in agreement and then we
> can forget about these intermediate steps.

Let me accumulate all these changes, rebase to v6.0-rc2 and send RFC v3.

Thanks,
Ravi
