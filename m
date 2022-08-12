Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C49590DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiHLJEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiHLJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:04:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB44A98E0;
        Fri, 12 Aug 2022 02:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2yBSHYhksU3eXiF1HYa4Y8Yq/AHnOCmZpiZFcocFCGVPb/ePoDnZSIyiqUq5tTEHEbS7G8pLOizIXgSLaAxVzWBEmkuEXgyvMOSRL1OUhluHdHnMF0s/pF+oM8kg3lKM9fzC67qhvEEI4Y/PSfZi/NtIMh5ilYe3pWTrs+J3rdCc2OoFaNVHqSdhcbYGLMjng5578OJBLgglaG8efxTEVJ1DBrzP204KV7DoI/pmrFUQIwZZ8V9OSs07w4RGDEoydMceRW6lA4yFiPqSrQZ2Ox2Ba4hu9C6xFUYsjxBKniArQMV8lIvuzQpwZX2Qh6+ytW0cJenejRbb9D9UhPaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+oin6geCSmQh9gzWg2SfyIjgfEI7x0IWLzMc+9LgPM=;
 b=acyuLiHZQkhclj+TQP+lBo7TinElxwe3MFj8E+BlTUCq6FaNfwHdjvfLVQp+Mb7YSunpQ0KmQjxocD2H7LZuBZK+EJ/o7v9uCqZlOulVq06omyFRACnBaxRK6vNjYwpUuiXThdEeydekI3z7CxJrUm32Qded3PwOuedkHIQO0uLUA+JBxhzqBPepCiBeKMXHXYxZk4hI4e4WqLzVrV1jNTkvDkvUQgpPxZZj9I4mxNExvG5epnZR9AB7Js8s+YAGyLBWB+O+yd4Qfxasj77FLpDuydT5zx56moP1JOW20v9j5FkqacmB2fEeFg1e/5HvpJ7VqQJVfzvJaK38PZL7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+oin6geCSmQh9gzWg2SfyIjgfEI7x0IWLzMc+9LgPM=;
 b=VU7g6LtO03enQewzwPAkiRiHO3dBYlpYyUCGRIpYtMNpSRhmRa9KYj7t3tv765R1ibLUHKx0dGL9Z6CHRXiKFAcdwY1wHSaqNVCAEjVhzrGBS0fXRE+MMn51yXp5wlUGk75WKFOQmrx5rMJcu+OPwWO5A0SJCS5aeCHa9837LIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 09:04:00 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b%9]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 09:04:00 +0000
Message-ID: <94f483f5-c541-2a1e-87f6-a4105c30a045@amd.com>
Date:   Fri, 12 Aug 2022 14:33:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] tools headers x86: Sync msr-index.h with kernel
 sources
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1660217326.git.sandipan.das@amd.com>
 <ffb9a9f0aa46a4339bb61282e26810112700ae97.1660217326.git.sandipan.das@amd.com>
 <YvYQQr5VenglbpWM@krava>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YvYQQr5VenglbpWM@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::27) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6781bf93-2491-4e15-559a-08da7c4198aa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cYROuxUEZmGy3QSxXMHfPgZTi85x/bKS+m1Z2xCzh7OOYnv8RWVjlo+U116Dy1RjMonBEODJxTVJstQx5RNNmQhYQJkN50QaFW6YOQ15pMFD9ADuLCVE+L2IcNzt0NXg4zzMzX7AM9/sZqeC7PM+X8JzUa1V/lteci/8ThRf2xZckTq3ahGkILW1kZIbRInKn6ZR4PPjUOO9XgpvnOYh6pXTFkxFfyvDJyXUG3iipw0vsKH+Mf2DWl/Dgh8Cw2yzuwN1wmyFG344hc8ZW8dsY1a/j8zT6f9LCU7xzUH4x6ogJeaQhNAEJ4ZePtpXTz6Bur1otMRhzNFRCNB3E4UKN6n/+8wgU0myEMa23369Z+uqrLC0CcTVnzpR3n3UCfPtHgDeX5/uVPx8doSvLtB119owLWcguKR4L2h8xumlS1uSkcsgT87Qp7BYOqEuFKhGz6dPeVfWtZhkBfMl5e5FFYL24NlzcrnuPJACEkjPfuHsPW7wPgbpQyrAAIIhfr/cw9G/AUMEBZ4Saj6LcJDlY3/JnoQdZIlCBCkMrq0VJ/H0s2g+5ci7C5lmkrd8afox3Lxcxs1EveEd8x+HgLPxnQeM4yKguMAgg2elR/YaFAa6lYfBVUHwyRd0NnMutiinXAlJaVeeIRp8TEc1XYZpu8l7s8jzeSxk7xRJ1Bot9u7s1Uqv7FdX4Uqy7t1rnYUbetzxmhKBLUv9rPNVsJ04M/EOZaGljGzub88gLNsbrIA5tFZx453dWkVAjOTAAvRScROGDcFOc8djZRquPHTj+j6lqd4oDKdNIlYtH4ZKk98fptQeT++jarj5CSOdfG5BVwjGmAr6dBJ0KEWLGnQlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(6666004)(6512007)(31696002)(26005)(8676002)(38100700002)(66556008)(66476007)(66946007)(4326008)(53546011)(6486002)(478600001)(6506007)(316002)(41300700001)(36756003)(2616005)(186003)(2906002)(5660300002)(6916009)(31686004)(8936002)(7416002)(86362001)(44832011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szd4YjlrY2JJUDVSWitmQk9QdzY4QU9YcWh4aVJITUYxMWNXQkxMajlsRUty?=
 =?utf-8?B?WVBYRC9PT3FvZklndmt2WjRoSWhtVWJtRzRTeEI0NmJFVkYycHl4TWxESHll?=
 =?utf-8?B?eUlROEplNDB2M2x3V0hJVlExeWRDc1ZWVFAyWkNtTkVGSzZsT2R6ZFJJT3gz?=
 =?utf-8?B?eDc4bEFaK3hCa0wyL2d6ZVN3TmhxUEFqeUVFYVlKOHh2S0JMbndwTzNOeUFX?=
 =?utf-8?B?cmdWa1ZodnpOWm41Wm0ySXYybGVsUVh1aXkrMFpwaFNBRWFYVlVvRXpMSk1I?=
 =?utf-8?B?Q0U4dWV4NlJwbWt5TWZFcGRCRkdRUHlTRnRNSzVnbXh6Sno5N0hHclprZGhQ?=
 =?utf-8?B?dVp3NjUxa2tXdFdKQVVtL0twSWxwR0JtOEplSzlEd0djTDA5SDhNREFpdFUr?=
 =?utf-8?B?Sml6WFF4RlhOa08vT05CZm9RZ0FGUStnU2JiWEN2aDNmcjEvdVJhaTJkUkNz?=
 =?utf-8?B?M05KRGZqbkI4SXRNRHVMaXBMdGhibUptV0VJMVNZT0Z0NTYxRmFRaEppVjNa?=
 =?utf-8?B?WXNlMENSZFpIdHNXOFRyVThrT2VMaDVuaEpCZkNvYWNDVGZTVEFORjNwb28x?=
 =?utf-8?B?REU5YXdndUpuSnZ1TFBoc3dTSTZ1dWFVSFRMMm5zY1RWVm9kb21aTTViTExh?=
 =?utf-8?B?cEhER1E1aTVpeUZCQ1hCM1Q5dGRrMEtnM0VKbXhJYkFNRW95U3VidXdHZ01w?=
 =?utf-8?B?UWErZjVIL0xBeXZrdW11TzE4RFJZY1VGcHc2ekdnYzNPMmVaRHdRd2hKTlVl?=
 =?utf-8?B?TXlIdmNPSW5JenU1eVNzcS9SNGZFY0x6SlpwdUhOaUFkZzQ4WW04WENLNCtH?=
 =?utf-8?B?QlpSUFNhUTVGOG9OdEpXUmYxRTkyUDlaMGVrdjBmNXBjRmVKUUN3bmdKbE5P?=
 =?utf-8?B?b1hYK0xjUGl2TlRMVWZVcHVRckt0dFlpZkJ4RmpVSXkwYzh6QnpPSzUvd3lC?=
 =?utf-8?B?TzBOR0NVVGVMTEh1RzFsbWcyT3BYbzJWTFUrOFlxcys3S0g3WFF2ZWswZGFF?=
 =?utf-8?B?c0hhVG9HamJ5ZnJRZHNVWTJyOTlKV1hMVFJ6NjVod0ZOWk1XaENHQ2JhS2li?=
 =?utf-8?B?SzNDbUhxdG13YnBYdnVKNUJXNHNjYWR6ZXpoa2E3V2hxYzBWTDZoYUJndy9n?=
 =?utf-8?B?bDFZZ2RJQVdqRlRZVGN6ZTE1SldVUGtpRklEcFA0djZNT2pZS0wrdGQzcXR3?=
 =?utf-8?B?VGlsSC9Lb1VFM3QzcFl1TGR4NFJ6UGZlYU5DV3d1anJWbWN3TndWRmRpMVUy?=
 =?utf-8?B?cmQ3czFEdThxckplclovRzVZVlVMRHRWSmltMjloR3FjdGEwQlU4YnF3ZnhU?=
 =?utf-8?B?aHhDb2JGNk95eG40S2ZTaUFWalV0dEU0L0dIQ2hEQ3VIM3BqMWE2cmZ4d3FH?=
 =?utf-8?B?a0RYZGJubTgvclVEeEJicHhxUWJJSVJ5cXV2RjYwaDRNNkpnbTU3T2pHNXVI?=
 =?utf-8?B?emN2UWJTU0xISDdyWjRMMkZwMEQxYnM2T0pQTWYrYytrRFJRd3ZObzZiN3Jm?=
 =?utf-8?B?c2ViaUhNbUlqV2lzdGFmWEpFckxETlNISjlzZE9vUER0V0dOeDRra01YanFL?=
 =?utf-8?B?ZElvS3gvbXpVMGhQSU9RU0xBU0FUR1pxMTd4ZUdiWG9GZndpUllIb2JNelU4?=
 =?utf-8?B?MUcyN1pEclNPZHhZcTZqQVNCdHlZdExHVVJET0xBTndkZ2tPTHJLd1p6UFZq?=
 =?utf-8?B?by83aVhreFgrWE8reE1Vd1IxallsU3dSaG1hQ0czL2xTb25KNEFwSkR0N1ZS?=
 =?utf-8?B?U01wQmdFTFBQTmlrbm4rZWQ0akp3cjJhbURDamVONVdKekZvck9vR0xjeWdK?=
 =?utf-8?B?dXZ5T0dWbU9IcDlkUzd0Rzd6VHpRUkhFbUlwZE45clZuWWNPR3p2U1RteE9p?=
 =?utf-8?B?VFRxNXB2eWdqc05lVEkySDE0eDVTOFhNOTNBa2hPQWFXQ0RVem5XWHh2MUty?=
 =?utf-8?B?TE9xT1V2bFlQa0dmQlRtZVJTcnBrOE5Bd3R2YVVLczRlamkyeXJkdUpWMHg1?=
 =?utf-8?B?eVNqUnJuTDEyVXRoTGg0a2t6ekwyS2Jrb0YzeVUvWGlJRTRpajZHb055ZkpY?=
 =?utf-8?B?cnNRSFZBdFVIRzhFM1pwOUN2RGY1YTY5OGVET3BlMEZsckh5U0x0YTVvWUlH?=
 =?utf-8?Q?rjWJvf6C22qE0BsIceQlTJO4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6781bf93-2491-4e15-559a-08da7c4198aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 09:04:00.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2nl07YKUDHQElq5CIcuF6T0x3XUEBFJFAA5mjTKD1vX5oTGt6uCEL2eNqz8omlPNJPmAD+hkoUtWp0iFluNOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 8/12/2022 2:03 PM, Jiri Olsa wrote:
> On Thu, Aug 11, 2022 at 06:16:47PM +0530, Sandipan Das wrote:
>> Sync msr-index.h with the kernel sources by adding the new AMD Last Branch
>> Record Extension Version 2 (LbrExtV2) MSRs.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  tools/arch/x86/include/asm/msr-index.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
>> index cc615be27a54..7f9eaf497947 100644
>> --- a/tools/arch/x86/include/asm/msr-index.h
>> +++ b/tools/arch/x86/include/asm/msr-index.h
>> @@ -574,6 +574,9 @@
>>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>>  
>> +/* AMD Last Branch Record MSRs */
>> +#define MSR_AMD64_LBR_SELECT			0xc000010e
> 
> curious do we actualy use this in tools somewhere?
> 
> jirka
> 

Commit 9dde6cadb92b ("tools arch x86: Sync the msr-index.h copy with the kernel sources")
from Arnaldo says that adding these new MSR definitions in the tools headers allows the
beautification scripts to pick up new entries which can be used for filtering MSR access
traces.

E.g. one can trace the hardware LBR branch filter bits getting written to the LBR_SELECT
MSR while recording branches.

$ perf record -j any,u true
$ perf record -j any_call,u true

$ sudo perf trace -e msr:write_msr/max-stack=32/ --filter="msr == AMD64_LBR_SELECT"

[...]
224568.130 perf/9093 msr:write_msr(msr: AMD64_LBR_SELECT, val: 1)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       native_write_msr ([kernel.kallsyms])
                                       amd_pmu_lbr_enable_all ([kernel.kallsyms])
                                       amd_pmu_v2_enable_all ([kernel.kallsyms])
                                       x86_pmu_enable ([kernel.kallsyms])
                                       ctx_resched ([kernel.kallsyms])
                                       perf_event_exec ([kernel.kallsyms])
                                       begin_new_exec ([kernel.kallsyms])
                                       load_elf_binary ([kernel.kallsyms])
                                       bprm_execve ([kernel.kallsyms])
                                       do_execveat_common.isra.0 ([kernel.kallsyms])
                                       __x64_sys_execve ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       execve (/usr/lib/x86_64-linux-gnu/libc.so.6)
[...]
302748.439 perf/9126 msr:write_msr(msr: AMD64_LBR_SELECT, val: 229)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       native_write_msr ([kernel.kallsyms])
                                       amd_pmu_lbr_enable_all ([kernel.kallsyms])
                                       amd_pmu_v2_enable_all ([kernel.kallsyms])
                                       x86_pmu_enable ([kernel.kallsyms])
                                       ctx_resched ([kernel.kallsyms])
                                       perf_event_exec ([kernel.kallsyms])
                                       begin_new_exec ([kernel.kallsyms])
                                       load_elf_binary ([kernel.kallsyms])
                                       bprm_execve ([kernel.kallsyms])
                                       do_execveat_common.isra.0 ([kernel.kallsyms])
                                       __x64_sys_execve ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       execve (/usr/lib/x86_64-linux-gnu/libc.so.6)
[...]

I can add this example to the commit message in the next revision.


- Sandipan
