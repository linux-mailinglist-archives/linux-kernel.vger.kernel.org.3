Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF959D03A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiHWEsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiHWEsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:48:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716213DF4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHUJi4t7Dl3Ja73AibYEoAVknL8izYc9y2cP9Fbgyx2B2NnbK9Wg7nwti1xhZUv1lyf+8uMrcp/b46ZekcWxq/3tgG2rzth1KBqGDz6hDC7dYzJC8/2+HBbSPaI8lrcOxS9BSskN8zZS/OYacxSS2or5SvyQtmO8y767Usm7xKsLYKTutU4F4bEc4+X7IzPdYyhY0G1cZdFaB2WVkDF+pymVvFcg8u/0T2hrX8NgUZC1WTMxSV3NWTcbSa1JYSMNX7HpjUdI6faLmBXed1dPmb/GG5fiCECguBzcsWQjVdfc+4/Ht3tx9qCb/iSSTQ0Zadp2lhl5hcAb4WW3PUHn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heEiB4I8UnZFyhFrH1aERggwLFgLGI+rCo1lar2yvmY=;
 b=arAFhsQo1Jlc2Xcvz/v+CaGdqym0QoMQksMD9yVHkl6OQKAUFOua90KseB8vc9I7ng8/momJ8a23a1Hhmbp7to+tUy03AmMsoDQ4Pw64bQczoMD4bsk4LPMEZEBXClJODL3oqTBwWMu2jWKuTEtW4wp43Z7jinsSW5K7x1H2YKSIje3Ma1bqkTwH0ifLFK3pguZTAzk96qPMBX+5ZOz9Gt7vzBbEkj1YwPLcaaSJ67byKpEY/JklOugDm72CP37Ofaa924wyFTugIYJp/UhoQdXGftBORqF8B33WIrYzcLaBoXMVFh4EDSHwXEoLrau7S33JXliwDPWY3D7ttD2Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heEiB4I8UnZFyhFrH1aERggwLFgLGI+rCo1lar2yvmY=;
 b=EAToFcJdlI1L5bM7+s/xEEuxR8UCvTZWJnL8naxmsZg/t8AxAgXbMHrg0qWsQSiYd5S5nKucmocanjzdH5PLNOz/PhjzI9MnBr98l7ULb4a8D6pr3RI2wOP4PNCyyRck4FGOtR7mQf8pk0Wjhx1z1kpUurzw7GO7tyT3OXgRvj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 04:48:32 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 04:48:32 +0000
Message-ID: <f53f2513-a67e-c082-25e1-8af797e7a71f@amd.com>
Date:   Tue, 23 Aug 2022 10:16:25 +0530
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
 <YqdP4NExuwOHdC0G@hirez.programming.kicks-ass.net>
 <35394cb7-a490-5aeb-b3a8-0f46e3c8ca28@amd.com>
 <YwOyZhk/eqrsPa1q@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YwOyZhk/eqrsPa1q@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4874f306-b019-4956-1410-08da84c2bb00
X-MS-TrafficTypeDiagnostic: MN0PR12MB6032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvUrfR7h4K0cq1Rz2ieIjRw1RWwwqmnG1WKD3WwbEqjvEJBPfThEBvVz+RogPJ6rm867wV09uub7lbYIOKkLUCVTcDp9DPg8fjrxw6T+QQ3KNlskvzA2RQfjwwZlmTP/Icy8fIfTFzWEXTW7TTkhhH8QaW0t40ueZoTX1txQWfy3NIAAoi3+hN2KG0SyMu2Rh1WK+QZSM9Thz2nExX62PIxRY3nSROjCd/XWs2ny+a9863GxFGCjff7jrQPBS/XrCq3ZyQGy3xq6nkrlhuFyB9OqtrVkIwzzJPsp2c/PhSf/H0KGtckIJw/9r24P788HauaumMPsuQpcVpOAEmruTd9Chzd/f6dsNuLr2gniZtjy2+Tpg2sWXWZWuKR3iAdg5N8HRxtL9VbTTOXcUI3BrphGelyuYpl8Xc2ediasZ2KTHi9EFy30ip5HB3kezxT0S+CjjQnGeVNLcx8pr4EvZwD30PjfAKbz/awg+O1nU1pdRbBRRU5rxVXxtzeDmPucLIIb0wBSI2GOvDFny10DKplbNX8PmT2ULtp2mTvZuViJ4KglMrmOQaJz37Iz89LLbbfOtb3bcIV0ObLKo5CdkweyNOJuCx8PQcbn7jF29H+PAkIWpe90wBNzP04WKAVXp+wKSzdnlunG3J51a8bzEw7ig7pNgk0LPgyl1UeX8IK3rrEiBxshPtFgwQSHKiJdvz+SxJy4dDPWY1NLJg033X/2ZTSj0roHjjzVNfj2jQxI6bZmXL+K7OAvKhOM7MDhnmi4VZtIL8fD2Xa3T4y4pAflBFngebWsd5W1PfaIy7EzLGzZH9inac31JKuFYf+6fMKIRvsQY6q89nzvL7HCZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(36756003)(53546011)(6916009)(41300700001)(6666004)(5660300002)(26005)(478600001)(6486002)(6512007)(31686004)(6506007)(86362001)(186003)(316002)(2616005)(38100700002)(31696002)(66946007)(2906002)(66476007)(4326008)(8676002)(66556008)(8936002)(7416002)(44832011)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdJdU1yaktuY25LL2dNSmlqa3dnOEtQSk9SbmtpVDB1R25STmdnOFhIZW9H?=
 =?utf-8?B?U1RmbzBJOGQ3SzN0NUpETkFTdCt1ZVFHVDJWM2tiTElFQlNjNDdKT0xEclVh?=
 =?utf-8?B?OW9ZTzdCK2JjNXVVMTFwMWUxK0ViSVl3enlmditqY25xOWpPZUtPSmtaSGk3?=
 =?utf-8?B?Rmk2Zmd2b3Bvb2lyV24xeEdoeVpla1BqUlFwR0NVOVFESVRnZUZMeEZhR3I2?=
 =?utf-8?B?R3QrN3FpYzRzbWFTMm5QdEtSVzNDK2tRZmVGTWxoQnNzL3dmbE8vVDZhMGN4?=
 =?utf-8?B?RHhndjR3NlhaZ3BZc0xpdTJLSkhJOEFqbHQ3eDh6eDg5bWhqOVBabENmTnMw?=
 =?utf-8?B?WWplcDhTRk1YYkNwWXIrRXMyNFlqY0wwZlA0TlNSU0c2cHpNZHRiRndubk5p?=
 =?utf-8?B?STNNSklGQ3g3b1kybnJPWWRSUUxNbWtKZWdJaGZsM3JSZjIxNzBBSTFZRW5H?=
 =?utf-8?B?ZVhQejBTZ2RzQU1wam41b2lXclo0cE5WTkxxQTdpR0RVazN1RXJhNHZjeWFI?=
 =?utf-8?B?WGovR2NFdG01VURPS2dDTFYwSnRLMkVWUUxGcXdVeTZRRlZrUGRVeTQzbEVM?=
 =?utf-8?B?Q3JpTDkreHR0Vy9ha0ducTFVQlNnUlRIN0FUbis5Y2dIdy9BUHZaaFk3dmxp?=
 =?utf-8?B?WTRqNVo5QVV6U0VVZk5sS3NYQ0NEeFVGRGVoL1poYVFDRXFsZlc4dVNSTEZx?=
 =?utf-8?B?bm1pWjd3enlRYWc2aU9vN3MwU1ZTSEZSZURmTDJUYkNQZ3R1L3VOSjU2R2gv?=
 =?utf-8?B?REMveW1PaTVOMnZSbzJaZ0FlaGtWeDZvbjJoSWVJemtrcGt2UGt3Yjc5REda?=
 =?utf-8?B?QzR1cVhnd2pDL3dobUM3YmIrRVcrVndSa252UEJybG9GaU95RWk3V08vVDhh?=
 =?utf-8?B?Ri85cUJGamlhdXM5UGpIVVp6eTI2UVV1Z2gvQzU2VXZIWVFVVVkwZ0w2UGts?=
 =?utf-8?B?RHpvYllMeUxMUG5IL2ZWUXhoWFlSRi9vc2lJNThZSWVMcW5vNUlxNTQzbVRR?=
 =?utf-8?B?Y2swbFlZTVNSa25MbCtGZkIyTVQ1eFpsaUhML1ZyTU5id2U2TWRvRG1hZVVO?=
 =?utf-8?B?Vkp2K2tQTVphQ3RWbXllYkQxb01OeTZuSTJqemdRSEJ0TmN0WDh2MFZiclhX?=
 =?utf-8?B?WUdVWXNzVEFMWnhzbWZJZGtoRW9WNDZYdHl0ZVphSjJkU1NTb21MR09QdTRi?=
 =?utf-8?B?RTJqNWcyZVVzdUl0RkYwMGs1MEJEL01rNGlCUjM4NUJIUm15QWxTVnpjbmxG?=
 =?utf-8?B?MXJqR09aejVDeExJOXowUGJPbnNYaGQwZjEvWjNFUmg3aFBNY0ZzczE4azNB?=
 =?utf-8?B?Kzdud2lPRTNoaElTWFRteHdSbDBlL2JueHI1bnFwT2VNRFFtUW5TN3VhRU1h?=
 =?utf-8?B?NEppRFgzMGd1bitqN2dBZ1VkWmhCbUVzdXNrK2FOL2tRR09XSXI2Z1htb3k4?=
 =?utf-8?B?MllhZGF0ek43UkhsYXFCU3liN0lqMGUvbWVveWVYdGpVWUZ3Q3Z5cEZyN0M1?=
 =?utf-8?B?bHVTOWtWamFaeFBUOUkrbDIvOTFtSU90TExRdU1LSlJFREhXQXBlWFpZZSt3?=
 =?utf-8?B?eDJocDY5WmJBQ1NINFg2WEwrWCtKbE5ka0pPYUFlWEc3b0lTRXFYb1c3czF1?=
 =?utf-8?B?NzhqUTJlL3QxajE1WStFbzJqVDJtWGZNSzZjOXU2YzZ2U2gzYVRqdFU3Tnkw?=
 =?utf-8?B?Z1MydHp6TGFnUG9BYXFHcVE1V054V2NpQ0czTzMvZ0Y4Y0Y2RVZQTFdmazkx?=
 =?utf-8?B?d3p1Vy90dld0QVdjRW5FRndMZmRLSlh0UWFUMlZxZ05SRDkyOEsvQ0dxQzNo?=
 =?utf-8?B?M1h4Q0RKMWdoTndIcllZRksrd2Y1Ulp4ZFRkaUN0YzJOYkdlZDZxU29vUWJ1?=
 =?utf-8?B?N3Y1SkFZQ0VGWHZUa2VGaU0wZnpzRjJwZmNWSVFacGxEL0pCUXM1Y3pCNFl0?=
 =?utf-8?B?WkFNUmVTTTVWcEhydUR1dE1CZHFteWpwZm9nK09uaUIzRThvREpMdEJDdWk1?=
 =?utf-8?B?dGE4RU41ZkNwUllXUm1wZTl1bkg4TmY1UUxQT3RLa3FHUGtLZTc5aDJMblRC?=
 =?utf-8?B?bURMNk1YR1F4NXFyYWZUbG5JVXlvVXdqT3c2RkFoTDYzNTN3dkFtUEp5Tno5?=
 =?utf-8?Q?Hgq8l/N3erVJ+pqKN66S3zFbH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4874f306-b019-4956-1410-08da84c2bb00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:48:32.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ykf/LLBEZcZQ74qG4VXb0xuEeh10XEqG3Z8Pb7Gf0V4aAC+KuVdhZyUrvtvKbzccbU8R5hqPVGs2Nxmv3FqKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Aug-22 10:14 PM, Peter Zijlstra wrote:
> On Tue, Aug 02, 2022 at 11:40:34AM +0530, Ravi Bangoria wrote:
>> On 13-Jun-22 8:25 PM, Peter Zijlstra wrote:
>>> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
>>>> @@ -12125,6 +12232,8 @@ SYSCALL_DEFINE5(perf_event_open,
>>>>  		goto err_task;
>>>>  	}
>>>>  
>>>> +	// XXX premature; what if this is allowed, but we get moved to a PMU
>>>> +	// that doesn't have this.
>>>>  	if (is_sampling_event(event)) {
>>>>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>>>>  			err = -EOPNOTSUPP;
>>>
>>> No; this really should be against the event's native PMU. If the event
>>> can't natively sample, it can't sample when placed in another group
>>> either.
>>
>> Right. But IIUC, the question was, would there be any issue if we allow
>> grouping of perf_sw_context sampling event as group leader and
>> perf_{hw|invalid}_context counting event as group member. I think no. It
>> should just work fine. And, there could be real usecases of it as you
>> described in one old thread[1].
> 
> Like you I need to bend my brain around this again, but I'm not seeing a
> contradiction. The use-case from [1] is a software sampler with a bunch
> of non-sampling uncore events.
> 
> The uncore events aren't sampling, the are simply read by the software
> event (SAMPLE_READ). And moving the sampling software event to the
> non-sample capable uncore PMU shouldn't matter.

Ok.

> That is; the code as it stands here seems right, we should check
> is_sampling_event() against an event's native pmu->capabilities.
> 
> Or am I misunderstanding things?

No, that's correct. We must use event's native pmu to check capabilities.
I'll remove this comment from code.

Thanks,
Ravi
