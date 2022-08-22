Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A292459BFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiHVMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiHVMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:52:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761142E9CA;
        Mon, 22 Aug 2022 05:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSeWCHq/H5Z1UfabfSOoxWrtdG8BwcMEddkbjGExnNLirZNkQWA+c1Emt+vkvziLFIqj5EPBVVEBEZiyxP3bv9t6+iyNQ302FgU1RhzJNB+RRRdMmx7oA6LdIbGwdf8nTVnBgec/x6Eon7A2E8E9TqUYKR3HZXmg7CoW29/dKer728p+hqufsGeOnxu+N7el6WMqNKpwLnSlIpn3kRgVuk+C0xSXSaGMyyUsjRZ4HC1KOlvZdAjp4RZ3S4o+WgCkeZf07tCl4u9wTWGQaLhSS6qb2Kvprll+xIZw+joMNfuPnlBwAeOhhpAtYLdVgCq3oNK1ptDNXpDYXMEAArXhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTVtNZG6iDcTwU33RBGkkRMnmA3hG/11ANVaNFKEa7Y=;
 b=V+XQmLT9RtoDkzV/m+e6PAgU0qSLLcijmhexBtQCYcg5YVrzB5tyKVy0sE6ZCtGP1oyJ4lfbzUqn1v4Yn2hbrYsUgf5UQMMO7Td+TfONuliYVcVNcE3UaUjhLERg/+1gAcZUa1K6ESMD5ck9SkAIjnV17T/6Y1J/mrcXZpz+78LgAd15aqbdQRdVEtMgQieYi/pSA/MRvyqeO/od/xMHjw8gMiL27CHqbQbrchxoy5zmSYXb5wLcr2z47B1h+Lz1cl4GA5UwdXy0kII1YpHsNGo8P3/7xXpNlU7VGFM6RubpKof7y+jkfwikS6264wqOEb7zR76SOaw5K7g16A8SZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTVtNZG6iDcTwU33RBGkkRMnmA3hG/11ANVaNFKEa7Y=;
 b=XuBv9Gty/rnCRQu401mJwoEx4DEgtD3GJI6+tBXkBY0DDOeKUurK4bNKUtF4uaBlwfFbrbpR86BmGiP+crE7ZXF72rUHbzouCu0NVJDswhjvsGgflkKcAsJrRyPTfVMIRDvClvZnu61Kv+XpA4BFhVu5SqtvRJQ/DTKAb5Q75qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 12:52:40 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 12:52:40 +0000
Message-ID: <06e9a357-422d-1870-ae72-18e74964caf3@amd.com>
Date:   Mon, 22 Aug 2022 18:22:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, acme@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, like.xu.linux@gmail.com,
        Stephane Eranian <eranian@google.com>, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <cover.1660211399.git.sandipan.das@amd.com>
 <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
 <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
 <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8962ffd-e9fb-4ac2-c6ea-08da843d326e
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6050:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhe50/MpAAcxe4wJFOSfqL6tCXNomdJqFDfRfkaD/G5Ffp5qu+nlpEPBp4HRxzmB7T1BUQ/sfPujS8TKGngGiI4w6aPpmsz1qnIuWyY8mCM+OHdqazSzhDDZlk77R7bL8EwernovEmQm9aQpJ3zes3kMefVUAkT7xxrL9XYxeSGhDxPjPnP4WK7rF+i5vtYu4CADCkr/eW8YMjwBdeLALLhr003wjpU8ozK4rvdqdXUb6AInugMtteFYJhh1F9v2jbqj8Y3VNrNEcVWWl06TZQCQkOAVc6n6ed0PLlqOR1TXCMxHdYPRm0juuhquxKXacm/xjmUQZVZPewjPEOFz4J5tiWzRsOutfGW1/+FmV/gcSF6PmppADoxs5sS0uss1Iew2tV0+paSH9akTK+AWFLBBWlN03JA//k2yPr+gLRok09mMKxcf/VUUl0Wu+itFkv0S1qER0DmBia3Cn10NG/T4x9AHE/YKIqrdvqLMbq8XWoT23wOQyg8KQPxN/bSuKU9q2vTiQ8FC6XYj+S7zYOsuJ80Xkda6v18Jzy5my9WYgswjd4Dd27wekYt5h0hCfSC6WSJhDnq8hKgCVeaPU5+1TOZ0CxnG03Zr+klr4kc+WIL166k8FX5NvnB+M8xpH782lUorPFTRi4xlpCvet4eZYPNd13tutVPasEcYYUqdzBOBEMBVTsUClMWKwCn2d0HP1hcUcFAZZhokvaHyXlJLtEygXwCcU0VMZ6GCHRQWMWUon/vLyq+A38vh4zNwQt6LtEyAuOM6f8jSneW9iQToL6W7Y7gRd1hQxgB4yO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(66946007)(66556008)(8676002)(66476007)(8936002)(4326008)(6916009)(316002)(186003)(31686004)(44832011)(7416002)(5660300002)(36756003)(2906002)(41300700001)(53546011)(2616005)(6666004)(86362001)(6512007)(26005)(31696002)(83380400001)(6486002)(478600001)(6506007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Y2NmpudEUySkQ3Y1hlaUEvdlRTSnNPTUFmN09rZUs5RlZCcUdOL0dlTXRu?=
 =?utf-8?B?VVBoZGlCVXZjMGJza1M2UEFGSnJScG1CVmFCZnRPSTV1UUg0T05VYWsyK0hB?=
 =?utf-8?B?b1FjUjhZclFGNGUzZG1FWkFuQVZKRHhqeFU1SFRKY0toTXVhWU5neVpXVFVC?=
 =?utf-8?B?NTlJR0VMcy8xVXFlSzB2NWhFczVBV3hwdzFLblVIT0x5Q0RRc0xsMnMyeEVt?=
 =?utf-8?B?M1I4b09VZUNBcnd4MzBlR21vMGsyUkNrV1lzQkY3RmZZTHdUQ21VdE5Pb1Fh?=
 =?utf-8?B?d2lSNE44MUlETnBkRUViMDZQZjNkWm9DaUUraW1CeWhYUDZRalVobnVtcFM4?=
 =?utf-8?B?N2lFMHIwNFR3Tng4NXdXZVVERndjWWVaY2E5b3FCaVllTDJWWXhockFlbmtj?=
 =?utf-8?B?MjJnSVRXY2hvNnpnbVYvZVNXUVZkRG5rSkh1Y2h6dzgyNldHS2tNUjlaNzZG?=
 =?utf-8?B?cW0wcW03ZGFzNi9OSTdVRXdIR0pRVHpWZ1luUVRqODlMZVR6TWZvVzBFdExz?=
 =?utf-8?B?a3oybklGTVBLY0ZyRUlyZ2U2MHRoUTNGR2taSzc3Zm8rVEJNZ0xQaFJCb0U1?=
 =?utf-8?B?U2sxMkUvbHNpMTJwM1ZWVU5tWXZaekx1bXNsUURpMGJqeW1CWlhub2Vjei95?=
 =?utf-8?B?M09Sd1dPVGcxL1BWU0Y3V0d5R2dxQytndnV5YWFJcHVxWGc3R254NUs2eVZw?=
 =?utf-8?B?VWtsY2tpYVYvUzRFR3NCeUJlckVLZy84Snd4NEpXRzNjVmgvbm5BR2lGNHNH?=
 =?utf-8?B?S0FBYVRxK3Y3bjNlWEFmUlEzTmZEUmFUT2o4N25QQkhIR2gyd2F4aVZiMkNz?=
 =?utf-8?B?MUVWRGprTmhTM3A1TVRZOEdNa1krUnovTHhQWGJWQWgzaWFlYWlyWjhWNm5D?=
 =?utf-8?B?dG1nQVRNU0crQVBKd3VqUnBmYXlBOHkwcklDVFFFek5OUUR6L3ZDNTVJZ1JL?=
 =?utf-8?B?RzVWSmYrOGFuUzRXK3J4TGgxNm5lNEhkYk5nU0piamhoMVlMYzdNUWVvaVdm?=
 =?utf-8?B?bkttRE03dGdoMk5sSy9xUjlUMjhwMkFMZGJqTE9hL2d3QXBHbmU2OXNZMWVW?=
 =?utf-8?B?cjBiVENEMDdYK3Q3VFIvR3BEMHdSSWdUOExEVTFZMHRvSTlDYUExeWc5aVFn?=
 =?utf-8?B?Sm5OSXJnOUxCR2ZOcnJCVTJWNUJqaDZVdjRDc3dXYm55NU1rMXZ5enAzWEZt?=
 =?utf-8?B?ZEczZ21IenhVb2xzK3JRZDhNb1JTQzRMelI5SWNxUmVubkNLNnJHRzZoV3dS?=
 =?utf-8?B?SkcwUnhNb0hSblJmYkhPRUN5UTJwU01heU5IVEN3MTgvemxyWXVhQlVjQTFG?=
 =?utf-8?B?b3gyeWswRTRhT1haZGUzVmp6S0E0NjZib3RHOCt3VmNjT0JDN2JrbTJvcU02?=
 =?utf-8?B?UksrbW9lSE5NM2Nrd2t5Rjh1RjlWSUlLY25BeC9rUENac2U2OXFaZWNocGVz?=
 =?utf-8?B?ZHVTM2RvNGhoS0JDbms1Vm9aYlU4bk9SNld3czJCZHV5VjZiTjhOdzlidUR6?=
 =?utf-8?B?eGg0ZTZqTjlEcEZLN255cUR2TFJaMDY2VElrYmlwbjlJNm11dC83WEk4ZVly?=
 =?utf-8?B?K25GTEVFMTZTWFJ0NUN0WEc2OHA2Q01mQUJMcnJiYk5LeWlmaXUvOXQ5WXd6?=
 =?utf-8?B?eXM3a1BhcmhGekJXVktpcEZyR1Jja3dLL2laSzNpNUM0d0J1SnZ5UlFoTEhD?=
 =?utf-8?B?RW54ZWpaSUpnc01mSTF5T0s1dzBRMXNaOEFaa0JPT2dKK25sdUs1dUQ3bHEw?=
 =?utf-8?B?WGV6bHFyb3ZzdzI5bUJvOHk3REplZG9nbnRzRURWUGhCSXpXZTM4YXBUR2RO?=
 =?utf-8?B?ejlKWjhJL3lWV0V6UkVtUTcxMGUrUTh0bXN1enBkZ1BpR1VxQjYrVTRMRTlh?=
 =?utf-8?B?NCs2UlU5NGo3MkhlNGk4U25sYTlOeEtDc2l0bVBaaExNeWJ6SXEzM3BjejA3?=
 =?utf-8?B?cHp6TlFiWTRwU1FHYVNRai9ZVzd6MEtDdzYwTGg0RWtpcksxZTZXMzFuOFdO?=
 =?utf-8?B?VXpyRnM3ZzllNXhTSS9DN2Y1NWxsNUJIcmdPUUpVZkxFTmVleXBPM3BxNmFR?=
 =?utf-8?B?TGUzRGpzUFlrcGNZR0hHRTVRRDIzcEgwSkMydVpmc2FaVDdXMmcyNDJISEhy?=
 =?utf-8?Q?JT/FOz8J9eWxPHD1QCjbJoWJK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8962ffd-e9fb-4ac2-c6ea-08da843d326e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 12:52:40.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ieDpJpXzP3qrM0jhNxz4As6UoJgluNb/A+bnAVkKjGeANb3p/PANuDhci0h5XIr1QKARvk5nx130MCDiIh6Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/22/2022 2:35 PM, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 12:42:23PM -0700, Stephane Eranian wrote:
>> Hi,
>>
>> On Mon, Aug 15, 2022 at 4:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Thu, Aug 11, 2022 at 05:59:52PM +0530, Sandipan Das wrote:
>>>> CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some new performance
>>>> monitoring features for AMD processors.
>>>>
>>>> Bit 1 of EAX indicates support for Last Branch Record Extension Version 2
>>>> (LbrExtV2) features. If found to be set during PMU initialization, the EBX
>>>> bits of the same leaf can be used to determine the number of available LBR
>>>> entries.
>>>>
>>>> For better utilization of feature words, LbrExtV2 is added as a scattered
>>>> feature bit.
>>>>
>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>> ---
>>>>  arch/x86/include/asm/cpufeatures.h | 2 +-
>>>>  arch/x86/kernel/cpu/scattered.c    | 1 +
>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>>>> index 393f2bbb5e3a..e3fa476a24b0 100644
>>>> --- a/arch/x86/include/asm/cpufeatures.h
>>>> +++ b/arch/x86/include/asm/cpufeatures.h
>>>> @@ -96,7 +96,7 @@
>>>>  #define X86_FEATURE_SYSCALL32                ( 3*32+14) /* "" syscall in IA32 userspace */
>>>>  #define X86_FEATURE_SYSENTER32               ( 3*32+15) /* "" sysenter in IA32 userspace */
>>>>  #define X86_FEATURE_REP_GOOD         ( 3*32+16) /* REP microcode works well */
>>>> -/* FREE!                                ( 3*32+17) */
>>>> +#define X86_FEATURE_LBREXT_V2                ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
>>>>  #define X86_FEATURE_LFENCE_RDTSC     ( 3*32+18) /* "" LFENCE synchronizes RDTSC */
>>>>  #define X86_FEATURE_ACC_POWER                ( 3*32+19) /* AMD Accumulated Power Mechanism */
>>>>  #define X86_FEATURE_NOPL             ( 3*32+20) /* The NOPL (0F 1F) instructions */
>>>> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
>>>> index dbaa8326d6f2..6be46dffddbf 100644
>>>> --- a/arch/x86/kernel/cpu/scattered.c
>>>> +++ b/arch/x86/kernel/cpu/scattered.c
>>>> @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>>>>       { X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>>>>       { X86_FEATURE_MBA,              CPUID_EBX,  6, 0x80000008, 0 },
>>>>       { X86_FEATURE_PERFMON_V2,       CPUID_EAX,  0, 0x80000022, 0 },
>>>> +     { X86_FEATURE_LBREXT_V2,        CPUID_EAX,  1, 0x80000022, 0 },
>>>>       { 0, 0, 0, 0, 0 }
>>>>  };
>>>
>>> Would LBR_V2 work at all? It being a new version already seems to imply
>>> extention, no? Then again, I suppose there's an argument to be had for
>>> avoiding confusion vs the Intel LBR thing.. Couldn't you have called
>>> this BRS_V2 :-)
>>>
>> I believe it is called v2 because there was already a LBR in previous
>> generations, however it
> 
> That's not the question; It's currently called LBREXT_V2, which is a bit
> of a shit name. Then again LBR_V2 is too because AMD and Intel LBR are
> quite different. So in that respect BRS_V2 would be an ever so much
> better name.

AMD LbrExtV2 is similar to Intel LBR. Unlike BRS, LbrExtV2 does not rely on
interrupt holding. The branch records are "frozen" at the time of counter
overflow.

- Sandipan
