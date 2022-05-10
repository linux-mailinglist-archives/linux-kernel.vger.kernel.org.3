Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4038520FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiEJIk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiEJIkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:40:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45B22DA32;
        Tue, 10 May 2022 01:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tou4MJ34YX+DNHOBOsGVTXpDmk4PFIdQGoqdDMSnGpwpQA2BL4Ng5Lrhm+6ByOW9+hhkDhSXvzIhJgHphEpvR90foUxbTjdICPeBh4e65P9M5Ww8c/CXMj/N49Rzm3bmlMLSWxm1Tb5V9OzVepCw/l2zctd9fTCq8a96AnPktxhr0b+edlvyQjc2yBIpVFh7zwhwzGEZeCmAT8OM7CNyqf/2yc5Gw4lvuGsDiXIneXtg3ET8KDuzRZ+544XEAvU/JOYHqjKT/RrfqIAKPvFQOq2gQ0fwWoWcZwf+6DCINtJUrSHKx1+yxO5aBW/xeHpqlMR/+zn1r1XjiRp/St5VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmxUCVVBFAlPe2H3bATYdkx73UKJsZ08UyNfqHTfBMI=;
 b=TrPirl8PqROC0NL2TC0xPU1ZJCabCnlkT1TQUAlF4coWW9T/5K2+ozrGclUTB5Nmm/zLLCEioHNCdoT++fiBTn/g4rjijwV6nwd0gUgXkOY0b/iJms2PfTEap7oG2paKprTa//vJfYUQjEhs7Op+FEUz2NU9aLvWbJoworSRLoTHSOz1pTLLSLAMAiOWwMsyqDQUiW51RtHpENRED2oJ/CgOjIEHOl100o4Hb6HXGGwK9SgeYhma5HKJ3+SuGSomnj59zQBZ9Cjljfq/8DYC+mixX1ACMw3comMWNxQO82uufMVpEKwhBmcpOAspOI5535+yCvjEtZldmy2fVdG9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmxUCVVBFAlPe2H3bATYdkx73UKJsZ08UyNfqHTfBMI=;
 b=flRuDicy3oRHKyzLugRtj4MqmKjlWr6slfyBMfJfW7rcPV7190BbMCgrg6I3yCqzGUaxv94u8m8eG20NwOV/pTyJ8oe4jEOGoSYuKy5Qouax6J3Xa3PVgJKC1Z9fkK5vmULy1unp2HFEX5UKe3dkIRMeLKB917eJdoOFGVUDTPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 08:36:50 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 08:36:50 +0000
Message-ID: <29103c7d-8108-cce8-8369-496a08c5c6d8@amd.com>
Date:   Tue, 10 May 2022 14:06:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Like Xu <like.xu.linux@gmail.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1651058600.git.sandipan.das@amd.com>
 <8d3e23760726cf6647a98999e1fcd12a37f36a42.1651058600.git.sandipan.das@amd.com>
 <78e001bd-42bd-5481-5a19-1a0bcca9a63c@gmail.com>
 <96e41431-eb80-f61d-9ab9-c76cd9b6086a@amd.com>
 <YnkTFRNpCykEndsk@hirez.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YnkTFRNpCykEndsk@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb839330-c71a-43d3-ed4b-08da32603a1a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4140E2F22402982ECC05BCBA8BC99@DM6PR12MB4140.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FfK6SJXIvZOJZhklWgiNtmAg+31etvASHUDOdjMi+wg0mJNbSmwkgXdkovjIO7iv0GaQvxfomXPU+r9qMH/2eE9hu1QqcPWwEAcJKK0L//KCOvycHVI6fbLoE1exsYbz7xwSTeqm3Js9CzRa22ZNR6rV3QR1oDsrjFUc5yTRfh1o/XGu3gChDpTQpAtejeyhHep1RexQIFhzqHuE1idnCirqN6/F9RaqBcqdbug7IpKs952XKTJ6nrpixyG/8q1xDjCX+jZVj8jn6m9hBG7+qjrZLHXJhmgl6Av3pcDTGDbrucTDsFSTf1PJJ3ALcaydZ2UtFMolHp9vxr4Yjgqtr796pVq4oLJ1Sf1iKROcdaGB4ypUhbyqFY5dmlLrve8ORAQi3bBro5I/VhcpkXNYsX5fuRD/zpwbodn0vmxjbwVl3wFEtCel5NbTbmz0tZXn2zqA2yb8yywakwyGOzG7lZhbku51BZkGnsMleK78AdjWhX2z6RYjUeFORQRyK1A/Shv26d3s+Y40XFADKcwZsFSOcwBqBEF+ocyJw+JZ/LloAO2rU3v9fuD/npopEZNKnT+11a/5UiAd5+nGNctx+Q7OTzihqAPC8gKn+wlunGAULFHDYIxGCNO/u73B97yiSCvUFkZzbmhVyKRu/391Rw1ycStx87iGokLHCgsQrFpcOoL5r2QLYabXBt67Fb/zxAwKXcHuOsiVJSyNWkRkDY+ND9oymoi+z226qM+Bws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(36756003)(316002)(54906003)(6916009)(2616005)(31686004)(186003)(83380400001)(4326008)(8676002)(6506007)(66946007)(8936002)(31696002)(26005)(66556008)(6512007)(66476007)(38100700002)(53546011)(508600001)(2906002)(7416002)(44832011)(6486002)(5660300002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2x5VEwvQmVRQzNUckNmU3crZDRnSnpadUd1QkY1a09XVXg2Q3pzVWlwNlkv?=
 =?utf-8?B?ZHN6NWRXRTQ1dDB0WXBMMVFETHE2eURPRHIzd1Z5SzN6N2xVaHVaRUpIZGRi?=
 =?utf-8?B?OTRmanpsd3dUaHBQRGJPK0VSKzFIY25pMm5sZENuNEJOSjRxMDd5K0wwMmVY?=
 =?utf-8?B?RHVSRlZzVjFRWnFjT0FLTkhkbnhVaFBBb3ZHYzdlWFljWjg4WUtKN2RKQTZn?=
 =?utf-8?B?ZkxrS3NjTUEvMlJjR1ZxMHc5RzVhYWpFN2VrT3hDb09tTjVPWTVISkZiSTgr?=
 =?utf-8?B?WHU1RVZrSWtaelYzWUN3T0hITE84alJWc21NNzlZbTB2QWIyZE5NbVl3Y1lu?=
 =?utf-8?B?amlHTXY4dW8yamRob2xOV0g2N0FkWGQ3d3dKZU1FMm9haVV1TzJvWkFSb0lB?=
 =?utf-8?B?SUt4RC85Q3E4aEZkbFhHdGlGaUJuQm1OSWoyTFpuMGRqTGtvUmZkR0JYRGZv?=
 =?utf-8?B?MUdmc2hTOWNvaEs2RzQyb1A2R2xDUFd5NHZhSEhKQnhsN0p3YzFCbys2WG41?=
 =?utf-8?B?M3hhakkyV0tOc3NxMXpjbktWY0VrZDJFVzM3UVBXRU0zUEZObnlmY3ZaYkhK?=
 =?utf-8?B?Y1RpWm8xL01oakszK0RZV1dQK2FnVzBHM2lqOWhDSzgzeitHQnc5UUs2WW5u?=
 =?utf-8?B?Z3p3dUxRb2lOMjV1SEs2ZnlvRk9FQ2czeGwvR1dzZjdOZC9mZ3d0dzJwR2h5?=
 =?utf-8?B?d2JkNVBpdVRzV2pSVnVZYml1TCtmRUZyc21iNGFFNGRNcGc5d2QwVHB5VmJY?=
 =?utf-8?B?SzUzRzV0K2pWVXFNam5IZTJJaWZDYVlTUUlOYkJ3cm8waFprWmJWY3Z6OU4z?=
 =?utf-8?B?OVFxeXVLMHN0VkhseEEwUjUxdlY0RjRIeEtkYWlZOEJrdHpPb2dHdXM5cmww?=
 =?utf-8?B?S2ZXN1EvOHVlZWlpTy9QMEFLQmFiUnFVQXNZNXVSMGRnTGd5bDk5Yk0vV1Nl?=
 =?utf-8?B?dEVja3Y3SVFQYUhtdzdBbHVJQWQ1OU5CUmZiRUJraW9iVWFYWnJYY0NoMkRp?=
 =?utf-8?B?UXZQTE5jTzJRZkxWc0Q1WTQ5M2lFTkZ5NjF2eGxMbnkyMlYraXluYzgzUm5j?=
 =?utf-8?B?RkdCeno0SXhHMHRNU0U1d05HZlozWEtIRlNPTEtPOUgrSjRWcnFZSVBmbjN2?=
 =?utf-8?B?VEV4eVdMWGRwdE0vbVI0cEI2ckU0SldpVWY0am1MeE43SXZWVnVTc0w0ZkZO?=
 =?utf-8?B?SytYWGJTVlZKaVhReGxxYU9vdCsrVFVEZEFCYWF4elpiTlVyMHpvNW5hMkxs?=
 =?utf-8?B?aEptV2ZSNHNpcHkzbzBkdTRWUmJpY29zZ2k1YWFDcWZIbkZFZ2Z2MUFwVnJj?=
 =?utf-8?B?eUJXWHZKeFNsRkNDeTZtRkVlMVBOTExla2tsc2NoSW9KaFVGVExCM0pScjlG?=
 =?utf-8?B?eTNQZEp5ZFZJa3pzR2VWR0djVzFqZkwvSjVreVlDd1RsTFZOM0NBS3NiZFBS?=
 =?utf-8?B?Vm1zV1BLeEVmdlNHYVIrcGVkcWc0bktsU29VRUhyVTE4bUs0R1lOamZObmVs?=
 =?utf-8?B?bVhDeDMyTUdxdGhPeGNveFh0Mm82cG1LNStNdnJJd3BybVJtLzBXSEdFSTZl?=
 =?utf-8?B?OGgweHpmYmpyWGk4RzZvcm53V0tSNGhrL1J0TksrVXBKeGE2WVdWempXaDVP?=
 =?utf-8?B?Q3BmS2dLbHBzd3BGTWMwY1NtbkY2bTVWWkhMNGpmc0haN0lXeDVmNjJwZ0Ji?=
 =?utf-8?B?QlhMRjNTa2d3WlhMTkZzU3RBTHN5YjVEY2VXN3dwdUp0VlJwZXdlME85LzNV?=
 =?utf-8?B?dUlCbHAzaUtycmEvZ3k3SC9vUDZLWXBHcVRnc2IydzlZY0ZCUDVOVXlydGZx?=
 =?utf-8?B?ZlFLVG0ydzFPZGZUMkJteGpTaHVBVmlrY2NqT3Z6bFlLL0xLTThPZTRLcTZC?=
 =?utf-8?B?THhHMkpGNjZOdFBKSkl4VVQ3bWVQbDNDSThjaDVObFo1T21aNFU2QXljOUht?=
 =?utf-8?B?WkhjdzVoNjY0ZDM5WGR0c1VTMnByeXdOWTFRMnUxeUEvSUQ4ZVF0S1V2VWtG?=
 =?utf-8?B?QnVBcGVhZHJZdGF0NTZ0YVZzM2xDanhxRkhsZWV1WnVBVEJZYWJLaVdQUXh5?=
 =?utf-8?B?bWprZWZpT3ppVHRTa3pkdC9VeXRpN0FoUkNOK1haMkk3WmtnQm9BYmZ5dDRV?=
 =?utf-8?B?WVdUOHB6MTUzY3kvRzliMUFmVHlVSXFGRzJzVjVBOGNWUkNVWUV0ZmpyVm5o?=
 =?utf-8?B?dnFXc0hjWGRwN0gzV044cCs2VTc4aHVvOWJBVWhEVE4yZkk1Wnl0TUQzNVd2?=
 =?utf-8?B?SVpud3haMEQ0WitDS0NOZm5hcHZsMGs2TUxZVVdyUndsY1M3a2xlNmdGdFpk?=
 =?utf-8?B?OTl3Ym5tQ3pYcEVWNHpXZ2ltazFNVWFBekJhT1I1SUQvOFRrWkdvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb839330-c71a-43d3-ed4b-08da32603a1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 08:36:50.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEDNk/mpwTP1gcyumDq7kEmuYWuhR+z+CI1ASEPNDECfnxnsOQ+oKfj0o4Ae186np9RhrkTQqPI1yvHWM3JiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 5/9/2022 6:41 PM, Peter Zijlstra wrote:
> On Mon, May 09, 2022 at 06:38:19PM +0530, Sandipan Das wrote:
>>
>> On 5/9/2022 6:31 PM, Like Xu wrote:
>>> On 27/4/2022 7:31 pm, Sandipan Das wrote:
>>>
>>>>       x86_pmu.num_counters    = AMD64_NUM_COUNTERS_CORE;
>>>
>>> Thus boot_cpu_has(X86_FEATURE_PERFCTR_CORE) is true.
>>>
>>>> +
>>>> +    /* Check for Performance Monitoring v2 support */
>>>> +    if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
>>>> +        /* Update PMU version for later usage */
>>>> +        x86_pmu.version = 2;
>>>
>>> Is it safe to assume that once AMD CPU has the PERFMON_V2 (or further) bit,
>>>
>>> it must also have the PERFCTR_CORE bit set ?
>>>
>>
>> Yes, always. There won't be a case where PERFCTR_CORE is absent
>> but PERFMON_V2 is present.
> 
> Let me introduce you to this dodgy virt stuff :-) Best put a sanity
> check on it.

I see that amd_core_pmu_init() returns if X86_FEATURE_PERFCTR_CORE is
not found right after entry. Is there anywhere else that you feel should
have an additional sanity check?

I also noticed a bug in the X86_FEATURE_PERFCTR_CORE feature check where
it should have returned something like -ENODEV instead of 0. Will send
out a fix for it.


- Sandipan
