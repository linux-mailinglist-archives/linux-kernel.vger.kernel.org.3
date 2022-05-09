Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C321F51F936
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiEIKD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiEIKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:02:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF11FCDD;
        Mon,  9 May 2022 02:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CahuaNL4K/01x8gDHU0Alok6Mhy0PdDCvCy/PcI2lL6w4cyPOptPlKGBThhjRlD5/ObMg+qygoA6xT4RpvuOY3yaJSbxRFSP6tTC9k25XxT8ZISAHwhWH1v9J97FpvAeJe9qR8sSg6aScdMiCwCCgTqsDc4lpU7Iea6l5sF8qpz6qc/u6Ou2h6Yj4aiFed2V79AKm+JMjYP4Xj2Lvl3tYcNMGc7TdgByG7h7apPjTXlx3KJO4nWQf+jSIPjRKjK6OX24bXwx+vSDhKk8hQ2TOiN+u7S9BYjBmnqJXT5Dew7mjIB2yhCJtgSVddnbl2WaQGsGBZrm5A3cdtmpuO1ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rIcUWCg7o9O4RS4eKRe/HnXwFegRzjB+WI8y46R0GU=;
 b=WzvvhNVYg3g5cCG+JtFxBC3jLrZeCYiOTCXMkKzfjCfkfUMJ1HxGVQd2RNLIVuetFgIjgyjxEahWm9mBPumYPC4MO1BMsTVU8sfuzNrR8vBCFXl1MJvAhqb6C6bJyQSlfrQcw6MBiX7Is+wThgcY1f+3cgfGfbQJaIfHFf88kO/+34v9TOzvs4nPnmF3vWe98l7VQU+7FfYqjNFT/jsJULoOvnUbJc330tg9EV6ki50snMhFTaMDno0jfkzUMGW6P3TdpBXoaO4jSsfRX9645NVVSHu4UxLxy5EhNIY71T8Osg+8k6GhBCyWGJq0Pke+tV9KzNdxKAD+csZhoH+KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rIcUWCg7o9O4RS4eKRe/HnXwFegRzjB+WI8y46R0GU=;
 b=f2VcjcmQN73cByjIR72QjJgPW/z9+uuu6KaPO1F9mGqNX6uvzN1ZM5AybO8hoALl7nNE8e9CR8L/AvmS3yG8UNXkIi3FqAiza4ez+f0R7vxvTvWPY71n4DVJhzB9Wy5le6m+14b/+HpE/soeP+uvduTHu/EqIhnHc7PT7RX4qDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH0PR12MB5370.namprd12.prod.outlook.com (2603:10b6:610:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 09:58:25 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 09:58:24 +0000
Message-ID: <0b9dced9-a080-1b00-3315-5ba22537558f@amd.com>
Date:   Mon, 9 May 2022 15:28:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>, peterz@infradead.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, pbonzini@redhat.com, jmattson@google.com,
        eranian@google.com, puwen@hygon.cn, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1651058600.git.sandipan.das@amd.com>
 <5c30d99af03fff90e2fc3165755d18d14bdb229f.1651058600.git.sandipan.das@amd.com>
 <c313e9c9-97eb-8273-5bb7-553692e8e2f5@gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <c313e9c9-97eb-8273-5bb7-553692e8e2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9940dcb-15d2-40cb-619b-08da31a274a5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5370:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5370B7676DDD264ACDCFB0038BC69@CH0PR12MB5370.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wG5v2XoVrDTupjAcK3FJKevkdD+kmMvzk02GymLOORXzhHO6wU1sG4+zWTTs52Hn16f+Qqhhhlq3iOJIp2si7lBBdx4UZP71/4lK3OewybTmBE1vcJOfXsG9bi6I/V43DvXKlxTImJkEMI2H2oxOPFJN+sTKgXqK9eGxhkLGoFN/XzscwE/lKpY4Xmevj8qRUv6j8DEF/RRxdtv84LYHotus9Ig0cw0jkVNIiAjfm6JM7NUBMWaKf4EeOFmYh15byW6cPjAnoOokVKu3cAvXGFl2s9k+YqsDCwJVU6kuOxJsjj1VmNO9nMCL3Wve/bSmKQAUP2k+yOXlRAAnF+wRkTfgxC365j3tyVd3r0KcTniKp/600LlYbMAzVhKw72Ylh20i7RlfR+aKrlpHbnZ8mojiUD8gYNnpD5QI/B4Fia6kU93W377VttD298jaueYTyCLjklAIr83/UkeRksxTWODIwh+4DdtQ4ckJQ9YrZNFJ6rODR+QQbKV1fYwVGFPosi5sRtqyHpJ3EaYQ6AIqhYQ5t+LgvJ+doSprUO6ypG1SCDGPAOh6bIrdm/PB4+yDY+9W9EGgQNy3hMqrQfjx4sD/rmh6y+TvfMYRzSDg8pO82bK2woc0dXez72Sb9BrA6AKoICwXjG+IDmiN86aeVnji+U4Ir1gmKw/r8D03i6hD0qdQHfJ+E16NC4x1knzY8Ue3Yy7mCSv5cyJUPldvM7536K+jfM5mBZBjrUyl9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(26005)(6512007)(38100700002)(4326008)(31686004)(36756003)(8676002)(186003)(66476007)(66556008)(66946007)(316002)(6666004)(53546011)(508600001)(5660300002)(86362001)(6506007)(31696002)(2906002)(8936002)(6486002)(7416002)(83380400001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lPamdlRnN1azBlVTYxOThUaDc4dU1BeEJYVE5OM2grQXhpOTVNRjAzTFVz?=
 =?utf-8?B?ZmFBSzM5RjVoZUpzVUJBZU9wVFgxd0dDTUlFWTVYRlNxU2wxYVBLSmN5b25W?=
 =?utf-8?B?S1RaOHpuQU5kSTRVWEZqaTNscTdrcUN2WGNwWVk0NThBS2t6Q1BjZkdJenJV?=
 =?utf-8?B?N2c4eExFNDFKMmFXUm5SM0Z2NkpZdlptYnJEYjZCOTV0OHRhNFpLaVpmNjBQ?=
 =?utf-8?B?LzBwL1ByTTl4VVFUdXR1RnAzM2dOeFEva0gxUi9SVDJmZm12b21hWWVFU0pn?=
 =?utf-8?B?YVF6OVZ4MXhGcEFQU21SVEJoYkhFdUhIUzhicVZZcjFXQXFsZVdNQVlZRlp5?=
 =?utf-8?B?MVdNWWF2RkVJQ0J2ZmZzc2pkUzhqMTY0c0NFOVVRVHZ2eXJUdFBqV2c2SHJX?=
 =?utf-8?B?UGxOR2ZZZE5Icy9tK3BpNGZob0VEajlLdzlGd2hyQktYY1dVeTc1TFNxQW1Z?=
 =?utf-8?B?a0J2cUpjMGhuTThPU3lqSm5yMVJUK1RJSDVrNUdsa0JBeWVlUEFQNVcrSENF?=
 =?utf-8?B?TjdUOVZmOGdJTWtpQm9JN2hIaUYwamFJU2tKdDdqbzVaODZ0bVV6VHVqc3p0?=
 =?utf-8?B?eXRCV1V5T0hrUTJDL2h1TGNnRU94bjlKeURualY3bm55UVBranlDVERzL1Vk?=
 =?utf-8?B?TjlYSUozdVFHK2JXUGlBUU9ET3pzTUdNMml4THU3eXplU2pjU3NSa1VCdDVW?=
 =?utf-8?B?TUVlVmE2VGFyU1I1N1VWN2VDT2RUdWJkMjV0bDU0VzBsWEVRYnNaWnNiMjFO?=
 =?utf-8?B?WEtycmJvcVBnd0paU2w2OVgzYW0vaVRQWFFDQ3dzd1pkczEyOEdFNWJVaEpT?=
 =?utf-8?B?anNuWHRsL0JpS1FEY0RidWVwS2FsQ0wrdTV3M2lNSDhlNmlEUGNjZVZHb0lz?=
 =?utf-8?B?TzRWMmVUOFhUTjlCcEE2dzRWZlVQYk5sYnJzWGs3U2ZNSjVQQ21mcDY4bEl0?=
 =?utf-8?B?SjBRVWNMWUlNeldHTytWTmhhMjljQllOZEpHa1FNZ3RrK0lLZDk1Zm9sSTFm?=
 =?utf-8?B?R0NVOXNvSG41TGtLdit2MlhXWXJMT3hYK3VLc0lEMnZrM0ZLZ1gzZGdnSThF?=
 =?utf-8?B?TlhCMFBtd0pkVGdZQ2RoMGV6MEp2QUtDYzROYysyanlTWjdObDY4bzVIdGR0?=
 =?utf-8?B?S1ZMdDVXaGRoWWFqY0hPeXZTRU9VZ0JPRXpyRVViZkNQOUtqcDNXQXhjUUFw?=
 =?utf-8?B?Z3lOUm5CNGR5T09pb0c4bTFMY0JMbFRDQU5iRVYrUGFiSkFwU00zSUxkSTMv?=
 =?utf-8?B?TXhSZ2NFZUc3VVJmb1psSHV0QTZad2wvV1lQNXZjUjZsRnhEb0xpWGk3N3B6?=
 =?utf-8?B?WmlSWHFGU1RGd1ZmVmo1aW1kL212bW5LMmpLSTZ1UUJKaCtXZTZQN3VoN3U1?=
 =?utf-8?B?RzV1RFFjTlMzbHpYY2lQREU4M3djZEZmMjZldGZvdzhVQU1oNW42UnM5Smc4?=
 =?utf-8?B?RmJKSXprUVl3aE5JNGV0OUc3Y3ZOWi9KUXMwZHhpeXhoTnlrY055VmtWcHR3?=
 =?utf-8?B?c2gyK1RMSFQ1M3l5eStZcDIxRU9KRXAwb3hYZU1udDE5Zldxc3M1d3NXdHZV?=
 =?utf-8?B?MEd4cjdiTGdQK2kzeExHU0FtcnEwc1A5UVB1TW9sYk9RMGY4SS9mUEhTbW0y?=
 =?utf-8?B?dEpZRTR5cjROWm9BVnArdFZzT0FadE5hMkJ2K1VzTG9ZM1BrSXp6QTJRN0th?=
 =?utf-8?B?NGpCNHlRTSs0T2FkNVlrRHR2YUFHTXd0MEVBUkFSOTJWRU04MHNZcER3UTRH?=
 =?utf-8?B?bGxMNFZHMkpJUFgrblRPaS9pZ0E1YVhQNW0wMHdWUXpPQUY2Q01XNGRNbTJW?=
 =?utf-8?B?MnJFUFVIU1FicE5KV1VpTFdTMkJHWUNDQzJzQ05EdzIxRUR4RWNTWGVCVWlp?=
 =?utf-8?B?WmJhYmxuWTFIR21pKy96SW8wbWc2YXpWekZFNG83Vi9KbUpiUU51NXJRSHhQ?=
 =?utf-8?B?ZmVXNHFSczZ5Z3ZDYm91MnBmdWI3eEE0ZllZeldQaEdkN0E5Qi9pTHBMdXJ4?=
 =?utf-8?B?TFllend1QjIzY2pqVjV4ZEZVRVZCWGJNMklLTG9sL3l1TWprKzBtR1JXVDNy?=
 =?utf-8?B?YTVEb09yVFk0Q2hLaWJXZ1dwQmVLeWlBLzlhdEN2bXRhT3NURG5obWdFTFo0?=
 =?utf-8?B?MVBvR1drdEw3T1Z4ekxpWTF4QXp5RHhyNk5GOGlvbm9udCsvSzBxQ3g5cGJR?=
 =?utf-8?B?VFg2bVMvb0ZsbDQzc2toSEFxQlRNL2NTTGFSR3ZlZGZvRWQ4UUt2di83eXVi?=
 =?utf-8?B?eGl5cWlPVG5hVlpxZnRiNU9CMmdpYkx2Y0NiUSt4Vm5YVlNPeE5YeDNJNFNu?=
 =?utf-8?B?eHJpZDc1SUFZOFRVQU1ETmZ3dCtxMkd3WlB1anlMK21aZFFqSGdKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9940dcb-15d2-40cb-619b-08da31a274a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:58:24.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X+oNA4XwNLo79dXspr6U/RYmI5dB71wW4RXH3ioNi4WYgHeUoQ6UkjCsja0yT9ZCONAB7uprcRJn+Tz1VP3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/9/2022 12:35 PM, Like Xu wrote:
> On 27/4/2022 7:31 pm, Sandipan Das wrote:
> 
>>   static void amd_pmu_add_event(struct perf_event *event)
>>   {
>>       if (needs_branch_stack(event))
>> @@ -1216,6 +1251,11 @@ static int __init amd_core_pmu_init(void)
>>           x86_pmu.num_counters = ebx.split.num_core_pmc;
>>             amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
>> +
>> +        /* Update PMC handling functions */
>> +        x86_pmu.enable_all = amd_pmu_v2_enable_all;
>> +        x86_pmu.disable_all = amd_pmu_v2_disable_all;
>> +        x86_pmu.enable = amd_pmu_v2_enable_event;
>>       }
> 
> Considering the below part of code also run on the PerfMonV2 host
> 
> whatever the guest PMU version, how about updating these two use cases as well in this patch ?
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 262e39a85031..2f7c62e46314 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1469,8 +1469,8 @@ void amd_pmu_enable_virt(void)
>         cpuc->perf_ctr_virt_mask = 0;
> 
>         /* Reload all events */
> -       amd_pmu_disable_all();
> -       x86_pmu_enable_all(0);
> +       amd_pmu.disable_all();
> +       amd_pmu.enable_all(0);
>  }
>  EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
> 
> @@ -1487,7 +1487,7 @@ void amd_pmu_disable_virt(void)
>         cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
> 
>         /* Reload all events */
> -       amd_pmu_disable_all();
> -       x86_pmu_enable_all(0);
> +       amd_pmu.disable_all();
> +       amd_pmu.enable_all(0);
>  }
>  EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);
> 

Good point. I had made these changes as a part of the guest PerfMonV2
enablement.


Peter,

Since these patches are now in perf/core, should I send out a separate
fix for this?


- Sandipan
