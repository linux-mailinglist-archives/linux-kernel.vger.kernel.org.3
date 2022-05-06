Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85151D4DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381659AbiEFJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiEFJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:46:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE80309
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1OM1NWWk7sOKEikorgANpZqD4Ml20XwuhM6HNBYlJo82d2PoFSbiH34tB4SZhpodxCeSLosJyIEhT5iNFd4x9ZZIFfEXLgf30vBY0jLEV2SXQl+Jw/2tc9G9ZbLgUjZqGm6SAvCar/NhBd4FBVpuQBIFfDqD7X/zfoFtE2IRrKXnZoRXHCG4KoY9DjCWg4SC9gYlET/Cd7m52EdmKm7G/nmPx4mkB2VecslGKqp5Ih8fw953ab4NKG43oPvqEdCQYVpynrzmg917j6Lqf4EzRN3hka2RnLzJjOmWIJtLnrZJWzbU1uT/cU//M4YEI475LzEmix7Zphsb54z9fm93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr+Netug3QUKH5IV7iH5M5ElXjSX/Xa4k6duXAC2+Rc=;
 b=h5syhtCq28qs8PFClFIBt5Ozq5opYeMccm8WAWYWXNsQKob64HWTpsTDE6KlbteS7mRGZy5bH62ncbk3eFOYbRB97J8hFniYscEzsQDYY4BDNewdfGB0nMJZyF4RFo+Xp7JEEg42C3n6Y/3uv/PDuxSeZ3F9NwwZnD8DljkmL+20kvxb7zmewUhK9KyexX/nNalzbEOjPSVbo2o+PYDBlKCayzZEPGKoLS6zyC0aUGvtJxR8PnJA/huRAyi4jsgazx3nXZcvb6plWchl7RcsnC/tGOH08NkR1Mawnvdo/mIzibh4exr0poPuOIZ0HJdv9A5WmaEbeWzPUPDoJkfSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr+Netug3QUKH5IV7iH5M5ElXjSX/Xa4k6duXAC2+Rc=;
 b=SAB8/dWd9DffFDiDMrVycoTwF7MwMtVRnACTkY+zVLDRqAXimBYa5hfLEA5P/7w2rq6+Ea0OAO/gXJfeDT47CojxNQqlXND0hQsR47FbycO+RrmWKOgxsMO9Wp6Zhy3mKlu0UW4Qy7gT1hGkMnQtqdFNMHBvtDwPhp8ze7RbwJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 09:42:53 +0000
Received: from BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d]) by BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d%7]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 09:42:52 +0000
Message-ID: <fa4e26df-d2e7-7b13-a961-4f741b319e79@amd.com>
Date:   Fri, 6 May 2022 15:12:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505110140.453184-1-wyes.karny@amd.com>
 <0b501f18-a6b8-1d9b-e72a-ea6cb33720a2@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <0b501f18-a6b8-1d9b-e72a-ea6cb33720a2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To BYAPR12MB3368.namprd12.prod.outlook.com
 (2603:10b6:a03:dc::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0a127cb-178f-417e-d532-08da2f44ca32
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0211B7EA20ADC1542814228F84C59@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbrzXmRdsMwph2rEziBhdFWnNtepBAJvRgGbVe8voJaTvnUeqcXLYE9rxyGHrefgVXJPWm8GHvJfP7XNpsu8MecRhzWaLwtQM0fhsoKqAAzC/VpLweUyobL5HQwFopoWYNzwCOZ8ABEAAAoCbFitEBosD4PmjO7aE0hTmmGrf38NJ87scFCkPRdU7YJXAvxDGKtMxoagoAvGSuXByeYeH1IRcePTKYWVrN6tKb3GKUxvFJfyE9gGz6dXUhrcrOS55fZiNd8y4jhWt1IdzHJqjPeceVQPrQTn8ys5/0eOlEXoBfBEEGBcpfRB2YDMtvj+oR2vP48P1P1mINyvifQbd76RqxvyGtF+eRLDilwOB3QvuLQUkJZHo2c4M+Jf+FEjeRGEc1Q1SNpIQV6g1jtJDqbYY8JhulZviw933GX/dCHwARWnIpS+htYS+9JsZhDq1cvuWjDwY9nrxMzY/VuRw6N4JBo0C5lrxl5npHh+doqfnpRwbVVPSPRxYZDoMqra9oKx+kVRfdvZbH2BbnToaQB7hap0/ShylrvUfwmuEJ5GnuYrFqckNmaVvj0cB+UcHwX/QWFgVWNidyXgGtlnvZg2n58hJI807o6hjLQvIwQdglfxeA8MDd3QUj/pzq01Ed5al/8Pgqr4mpXDEvnU7iM9lf9AVmJHsFNbSq1Ytq3iFVZhrzw7+pehvuZgWEsBE6iKfgb/WEjR4pvn+1ITCkG8/NCmeRI2wj7MFV28sl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3368.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(5660300002)(508600001)(83380400001)(44832011)(6486002)(8936002)(36756003)(66476007)(31686004)(316002)(4326008)(66556008)(66946007)(8676002)(2906002)(26005)(6512007)(2616005)(186003)(6666004)(6506007)(53546011)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJGZnhFQytMZDM4S2FkajdYbHJwanYzV1dGK3Z2MEx6OHhiTDE1UjNzTnhV?=
 =?utf-8?B?andycFlGSFMxMXgrS1B3NjROTFJQcFJ6VDBaSDMybE5ycnRuT3JXNlQzRkd3?=
 =?utf-8?B?eE5LR0xEU3QxTVVoZVJUT1hUQ3hKVng1d3Mwa0IrTkhYc0hMRVRQamgzL29S?=
 =?utf-8?B?YTNPZzIwMU5hTWlkVnFzcUozWG5JZW9QLy9IQ0dKRHpWYW10Y21SMW1kMDNo?=
 =?utf-8?B?d0MxMG5KcFptL01kcnd3NlJUUjZJYTc2OUVQdENUYVE3MlIrR2wzV2lFclNp?=
 =?utf-8?B?RGwyTkk2RFVRSUxZaGdzVFp3bTlieDBSRURWa0JZZVNoOU01czJWTzVWSzd0?=
 =?utf-8?B?K1dIbEl1NUFhMUJvTkFHZUdHU1VmZUluUFUwS2w1ZVdkUXpvVFBtZ3dMRWdh?=
 =?utf-8?B?U2dlYys1T2xDYWVTQy9ESGpBeEsyaldncE1zL1dNaDhMVlJqenBvNi9WdXhs?=
 =?utf-8?B?OWR2OGx6ZjZweStHUnh2SlY0UUVwdFU1ekZGR1JpNGVzbURsLzc0Y0RVL3pG?=
 =?utf-8?B?SUZ6OElvSE5EL201eU9IbENjdGZCT3dVVytjTzcrR2VPV3ZRNis3WTN6QjNB?=
 =?utf-8?B?cUMzdUg4WEcwN2FjQ2sveXI5cmFOZzhscWJJOVNicmdrZ0p3S2VFVWU5am5R?=
 =?utf-8?B?Rm9ZUFFqNUEra1o5a2tXUmhzRG5sSjlKU050VUFMTitWWVN2ZWNYZ0o2aHh3?=
 =?utf-8?B?dEVqK0ZucEErNVErbDNjOTlJbGpsdUw4OUhaNnNMMEdSeDk2WGpHdVcxSnZX?=
 =?utf-8?B?RUc0WVVocVBPeXptQktqYU8wRWg3dzFmWlF2WWRQV3NwU3p1WS9OZ3QvVlRE?=
 =?utf-8?B?UmJKTU14ZUZkdW9zbWtzcUVEL1Q1UHlPd0pUbVJycG8xQkgvT2tHV284WmtV?=
 =?utf-8?B?ZjVrQlBVWUdnWnpBalRYMktTZm50QnQ4eG53L1hlb09zaFpJTXdWcGJ5Tllm?=
 =?utf-8?B?LysyaE1leXZFcGN4c21rd3JwL1dRMGtIdVBmSVBFcEU5K1pWdlhFNE45bXY5?=
 =?utf-8?B?RWtnSkhVbXcrSkNUbTc0S2ZpVlZoN0RBaGRHZlJhM2ZEN2ZXQjhFK1BFaDJ5?=
 =?utf-8?B?ZTY5OWV4NTZEcW1Jcm1jMGZ2Uit6SSt5ckIrdHc1Q1p4TERBeWJrMXZwOGJk?=
 =?utf-8?B?OVZJbHRZQWhGK2w3cDlDdWptYU9XTnR1M1c4bHNlT3ZZTk4wQTg5S1NkSnJi?=
 =?utf-8?B?UDZNeURRZWFhNGpyai94d00rcEhudmxLS1BET1NXUTB4L0E0R04zak9QU3lp?=
 =?utf-8?B?SlRyK2EwcW9kRmVpMlVzT2NoVTdPT1BXMCthNmFuVkJwbzJpcVV2Ry9OSUJC?=
 =?utf-8?B?dzNpVGExN1gxdHdLcjNkNVlnWDMxZzRheUpNTEF0UVh5M3V4b3B6cWZLTWRh?=
 =?utf-8?B?MUVmZFRFWVhsNFpkTnBkU1AvL3UvdFlLZE51TW5XL01sTzJXUlJ6bXVsWVc0?=
 =?utf-8?B?Q0NCakRCeEZoa0d4UlcvY3dxTWlsZHphZGFTSmxjWVY5dU9yZS96aUVEbzZX?=
 =?utf-8?B?cVNTQWpGWjViR0Jwa3pueGU1Q2p6TU9tdVlpTzJ6UGZsZzJERSt1RkpVSmpt?=
 =?utf-8?B?cXdtNHRNU2xHL2dCQ2p2dVpPRlNwTWpQTkJuTUxWVTB6Yk0yZm5RdDZSMGs0?=
 =?utf-8?B?RVlaL1MrelhHdEJ4VnE2QnlrUVFKZE1pYldlckNDeW9wem44Wk4zRTN6bmpy?=
 =?utf-8?B?U3JwWTdhbUZWWTQ3bnR3UEJNUnNCeXR1WGI2MFdCV1NBMmZsTG9rd0hML3JK?=
 =?utf-8?B?UmthSHlxWm54SFBUUXgxUTRWL1ZwM0hpeElIK3JOT1BaSGpCcTc3eU10UHBC?=
 =?utf-8?B?cUhtc2ZPeXRnd1lxeFpqd052WktKV2NzcnNUNHNxNkVsancyRVlrTXgyVUdJ?=
 =?utf-8?B?b1NiL0E3eUdLKzg5Q0xVQ1ZGT1lJaGo3UzRVZ053YzBleHEvTmRwUndKVjZo?=
 =?utf-8?B?bUlaaUlLNmZPQnZHWEg5ZHh5bzlnVFQ3SkRvQ0RmWWIrYlRJd3dYRjBPWFYv?=
 =?utf-8?B?bmtsVSt6aEg5Z1FTdFEyUkxPL0F3STRzUGYrUTd6c1YvUm9LMXYzWmg5azBX?=
 =?utf-8?B?blFzdUQrRENZV3RuQSs5Nnl5c3kvcnNNdEVscXNNVldsTXBzSlJHbkxmVVBO?=
 =?utf-8?B?NFgzVjUveXFKQk9TcGc2ZTlVbnhPY3NCSEF5NWpFcTRlSE5IOWhQNUlkOGJO?=
 =?utf-8?B?Q2hiYjhtbkhJNmFnVXhTMzRQaEQvdTczMVM2ZHZ4cE9odFBkb2RoRjVpUSth?=
 =?utf-8?B?dFh1YUN6OVgrQ3phZEt4N3BEaEtkdkxlM1E0R2pNb2pUeTIrcjcyWHZVZmo0?=
 =?utf-8?B?MmFhc1JjYVFWOC9LdDVpb1F0ekVPWXRseUpDMjFhbWRBZW1idU83UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a127cb-178f-417e-d532-08da2f44ca32
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 09:42:52.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIyE9HwZhQN9IIncSJ7AUai6wB+ztcx+YJDDXqZ2X3IXP+Z29S9lGMVvLXApsZtQGnfbB6hohImMD9Wj0SNJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

On 5/5/2022 10:34 PM, Dave Hansen wrote:
> On 5/5/22 04:01, Wyes Karny wrote:
>> -	if (c->x86_vendor != X86_VENDOR_INTEL)
>> +	/* MWAIT is not supported on this platform. Fallback to HALT */
>> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
>> +		return 0;
>> +
>> +	/* Monitor has a bug. Fallback to HALT */
>> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>>  		return 0;
>>  
>> -	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
>> +	if (c->cpuid_level < CPUID_MWAIT_LEAF)
>>  		return 0;
> 
> First of all, thanks for all the detail in this new version of the patches!
> 
> In arch/x86/kernel/cpu/common.c, we have:
> 
> cpuid_dependent_features[] = {
>         { X86_FEATURE_MWAIT,            0x00000005 },
> 	...
> 
> Shouldn't that clear X86_FEATURE_MWAIT on all systems without
> CPUID_MWAIT_LEAF?  That would make the c->cpuid_level check above
> unnecessary.

Agreed. I will update it in the next version.

> 
>> +	/*
>> +	 * If ECX doesn't have extended info about MWAIT,
>> +	 * don't need to check substates.
>> +	 */
>> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
>> +		return 1;
> 
> Could you explain a bit more about this?  I don't know this CPUID leaf
> off the top of my head and the line after this is checking EDX.  It's
> not apparent from this comment why "!ECX_EXTENSIONS_SUPPORTED" means
> that MWAIT should be preferred.

MWAIT can be used for two cases - address range monitoring and advanced power management.

According to Intel Architectures Software Developer’s Manual, Volume2B:

"MWAIT accepts a hint and optional extension to the processor that it 
can enter a specified target C state while waiting for an event or a store 
operation to the address range armed by MONITOR. Support for MWAIT extensions
for power management is indicated by CPUID.05H:ECX[bit 0] reporting 1.

EAX and ECX are used to communicate the additional information to the MWAIT instruction,
such as the kind of optimized state the processor should enter.

ECX specifies optional extensions for the MWAIT instruction.
EAX may contain hints such as the preferred optimized state the processor should enter."

So, if CPUID.05H:ECX[0] = 0, MWAIT extensions are not available (not allowed) and hence 
it is safe to use MWAIT with EAX=0,ECX=0. Otherwise, we have to check CPUID.05H:EDX[bit 7:4]
to get the number of C1 substates and this should be greater than equal to 1.

> 
>> +	/* Check, whether at least 1 MWAIT C1 substate is present */
>> +	return (edx & MWAIT_C1_SUBSTATE_MASK);
> 

Thanks,
Wyes

