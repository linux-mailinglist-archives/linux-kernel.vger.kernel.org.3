Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC1520D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiEJFDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiEJFDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:03:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED21C94FB;
        Mon,  9 May 2022 21:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJcAEY4fo11UdncVUGoIs308jdQoi6mKqFHplOdw9JdqHZ7WxorjIXi3GR9WLrGA7I1wg8aLJdLZQYYB/hjlOSKKWhgL+WiuADsGaRvAqHySbMJQW6qGmz6rq1hMi0FiP+eCqyXd7yu1dxrpAWXqaXNiPvhsu+ViEMtUt/C0xXQJ82/1gVyhFTk/QzBYSckTOuNMbuvZ0Xl9fqv0mklBAZKPIPjAy/mBcRbBA2c5NTT51Q5bnuVcIZLeFiN71AAUbmxjJcBWTCX7wUALmV8yNR1rQOEiq9dpnoqu49GROnjYhwm9UdxUoyzEb5u4sI05QsJ7n4DoGPg8oE+qVI12Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFlBi/trKjkTAk8NaGVwVUkfN4gjyEXu75T2tY1+JT4=;
 b=gD6X8sXmdiC4lGdgNiEZqtCKjffZzfAC8i6BotgEacPJ59oPc+JWHLcuIJUAU9InFj4s8qlFn52sXMTFfjEwOq1/dY9Qp3mL0SLbBgY144Cw7dxEuxM5SpsCPTISXQQ+AE1X5mdS4JpmAGugFXtLN3VVuBIe4FGFFNIOSqBINx4J3IWMSQGemVpXPwVh3uF4OIWhmpy3sExqcO44ETvPuC/avsbo1fwM0LHw3uCWGsyiftdd4gQ4cNkBrGkp3mAuW2e1kJykr562wMTwC8oRbuPrkiszNgc8/IfQHMEofnSqrcANeNBpeIIYbrHvCin5mvQxNbWSu+bG/RUSSApWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFlBi/trKjkTAk8NaGVwVUkfN4gjyEXu75T2tY1+JT4=;
 b=R3j3BBVusRJTTuGhA/P7+srsaFyRq9NK/tRAS3TNVQmzyaRNWMtvibDfULjFkibkgnotAaa5M9u5ot0pb26zIYIX/8w17sqRv1fHEZ3Z02mRezHM1DwuNDgZOM+re6B7sIlysFDPuUQ/NhZkfdTh+kQ3lobxFbCsAQjpBVKIrAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BN8PR12MB2897.namprd12.prod.outlook.com (2603:10b6:408:99::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 04:59:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::8d3b:6561:8563:4f1b%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 04:59:46 +0000
Message-ID: <246a7466-dc61-0186-2ff2-77fe37e73c06@amd.com>
Date:   Tue, 10 May 2022 10:29:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [tip: perf/core] kvm: x86/cpuid: Fix CPUID leaf 0xA
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Vasant Hegde <vasant.hegde@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        pbonzini@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <165126412838.4207.9648561218200979307.tip-bot2@tip-bot2>
 <YnlOMDv5lMw2kGVb@zn.tnic>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YnlOMDv5lMw2kGVb@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3beca310-5eb7-4408-ebe4-08da3241e746
X-MS-TrafficTypeDiagnostic: BN8PR12MB2897:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB28976D6FFFF277F720263B138BC99@BN8PR12MB2897.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY7lmNmWw0m2WTSdArQOvN4obj8+lhZKbhWOMrANFUPwfNldNgUqxRYL6m0SyYNxTK9+1upsYnNnL44GU4Hsali9VeheZHDMP+D8NgNk0lnqmdxxLETMb4oLVcC15aBGjycb10VVxo3E5lxlJ/moB9XbOTSadBEisqqgYHCpT6DI64bkuRZcAmFs/dfHGVa7lsZa9j1m/bAZ8o4u7p+mu3LC9e80XJCKP1aZ6jWSg71uT3VSb6uvSvsHxHf2wMHG/ECkW7L0291f32S/recydIGqufBC634w7UGCV/QbEslxcGam8NIFIg+f3B1uTLOhNWrelqhqp+NtYpZegw9JVVENkNcLrVuuQEXGzv+f4IR3T58kHMPzd0qo7OViWSeaaBVK4GfoMkc9n9MDbOzbUAcB/x/BbKtSg8ZsQ6Lk6J3bZ5/6eTrekn3ry7xhsNsbAi9bdpaW0PnC033DraSGrKPcfO2daP+Vgdh0Mr0YeTP9W5yAvobP0Iz9VTArRxZxQgt9EmjeXgYC0HSp07ChpqbUbrb3RXS7Pts42opar3aq2nYF/Wk7zszHKtuauHGh6S9BY3rhpOVw32xYZvtZVR+1OhPYreUJ6B/lwS2DMXhujk7mZ5T6eCWOHcGQPOKD7piOTeBtEVF4c5mYMniyA/QAsuEWXQmkr7GdIYwMdTUNODik1KM+rovVFnCIi21q1dxKvgWWt8hgyReFA8YlgWyBYbM+W1+77KQuzqkn6yTv18uFlsi+2/DsD7KS7O9GZHNn1m77OfZXBmJ2vfv8N/4TBu5Nynwaf56GjlhPgNo9PKi520qxfPaLuGvIS+gmm4crw9nvMBlNSN8VgvZnOLBFdPd2Bt8GJDRW9Q5W1bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(31696002)(2616005)(53546011)(83380400001)(36756003)(8936002)(66946007)(4326008)(6916009)(66476007)(54906003)(8676002)(66556008)(31686004)(38100700002)(26005)(6512007)(316002)(6486002)(966005)(508600001)(2906002)(5660300002)(186003)(6666004)(6506007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpjV1VndnlkazlZeUJKNHZqbWFoUHlPcUV0RmtkUFdVVERRdjVuL2ROQUxQ?=
 =?utf-8?B?b01IWHJ4NUNCb05mVFB2MUFEazBOb2pDS244OEwzMkxzdE5jWGdLY0dVaHND?=
 =?utf-8?B?RjhHZjhzY0lMbkFGRmxtS015bXAyR1FSVVY4NnhSRUFqZ09za3ZEQ0ZUbWZE?=
 =?utf-8?B?Y3ZNdTZzU0dzZzhBWHE0UWxSUHB2bnpBQmtpTkR4djd2dXFRT0lYWDdDMEhj?=
 =?utf-8?B?TnJYeE5XZk5MM3B0Z2ZDMXJ0YmRTbWRyaVpQdUpNZmx0V3RFekY2NHQ4Rnh4?=
 =?utf-8?B?TldQdDRHZy9SWWRMVkF1dDlkL3FKdXROM3N1OXNpL3RFeElPM0pjZ0xpQStj?=
 =?utf-8?B?Y3RXbXlZcEdPek5ESkxUdGlNQ0N6bjNsZzFJTGRycjdLSVZnd1lnTnZhZ3Zj?=
 =?utf-8?B?OSs0MUlWcTFPSytrY3FYd1l6Z2RreVpCR21HaUVISnN1OUFSN2JKUmZiYnpL?=
 =?utf-8?B?SnBaNW90VGFEcERIS1FaVVVEWEw4SkNUakZ4SFlUeEowZ1RZMUZ4Y3JnTnho?=
 =?utf-8?B?RXNPVkZkOG0rL0Qvbzc3S0lhaHBlM2c2a3BFci9qNmtPK1prbXM5SHpTRFdG?=
 =?utf-8?B?SkFsVmFzT011OCtNR2h4eERINWlBQ1ozYTZoVEVzRjFPdSszdVdXejR0VENn?=
 =?utf-8?B?bFA5NUlwR3BlRlp6TW9raGdoZGVnb3diek1ZTjNHMFFLSmh0bFBTVGFCa2Zh?=
 =?utf-8?B?T1d1V1l5cVVCQWNmNmRuMno4UjUrRjdrdC9QMTFlK0NQMUUvVFRWVVBKVGFP?=
 =?utf-8?B?OWFBQTRPOERkcU1OdERpQjF2OWszV3d4UktLSTZ1dlFPdk40T2VJZktXY3ZN?=
 =?utf-8?B?UFIxbG5idktYZkU0ZUtUQ1YxVkFocVRFOGIxajlqVmIvY00vdE9ESEFLbFBn?=
 =?utf-8?B?aGlBR3BlZnVLNjJzZXIvQkFxREE2eDlTUTNGQkFjSkNBRWNuVWtONnZLbExP?=
 =?utf-8?B?ZGRjNmF5VTg1V0w2NksrM2NvcWt4cVpOUUY4ZnRtQ05tcWVVRUYxdkhyUnpO?=
 =?utf-8?B?dkhpQ25nQi82Tk5tYjV2MkdYdzE3ZzlINzRGZGc0RUJRMmJqa3p0UnF5dHFL?=
 =?utf-8?B?dC9YMFlKOEZBeVNXblFzdlpJZU55S3lERVdEd3huK1oyNzRSOUExVHVrY25N?=
 =?utf-8?B?OTc0MU1PZ1ZGQzlIODBhVDVscTFjK1FuZldMa0UrSkFLU3grL0pLS29XUTBr?=
 =?utf-8?B?VkpOVTh2N0J6K3pxdktOb1JJS0tPUnE0SStnckJKL0RYaWRiam1Jclk2NjBC?=
 =?utf-8?B?SUtVZHJaSGIwWjJsWEpneXFTeHhkb0wrUFF1VGFkUUk4SkhnWEpPYXhsbzNU?=
 =?utf-8?B?NldCWHJiQ0ZCUnU5V1JwMHJXUGZ2RFA5bm5ZMDd6bTJjK1lOVnZkSFFSMDBv?=
 =?utf-8?B?bDByWDRHYmlycVVjT0tTSWJKQVllMGxjZlBaTXh2dUVnRmptTXZubnEyMnpi?=
 =?utf-8?B?aVdRWjIwU0MwUC9KVDl3bU54TzVxdUFmSnJLWktuQ0tmSzJLSnFibHBuMm9q?=
 =?utf-8?B?WEd1QXh5V2k1cHpkamhGRVFGamNnUWNoYTQrT1ZKckJud2xwYVZsWlZHWUZJ?=
 =?utf-8?B?eTZtQkgzc0ZkNWpMQUovM3NGc2tFUWViMlRNZ0dqWGk1S25OU1BVZmxRRkV3?=
 =?utf-8?B?ZUVuWTNZVGxaR0IxMVlEWmpOelY2dk5qVURHTDQzZFhQSzByQlkrZ3dCSE1O?=
 =?utf-8?B?My9iUTc2ZjVTZ0t6dkx2UlpVYWV2N01TT3dSYzVBcGQ3MDJaNlVSbUU5RXBI?=
 =?utf-8?B?RnFDNU9rTHBiWEtRYkwzYzNKWER0OXJyZHpUTzgzSmQ4T0hJcXpLSDYrRTVK?=
 =?utf-8?B?M3dsc29NS05GRmVnLzQ1Z1hnbHErbXp2QXYrTWVPa0w5REVVREJabjNNczht?=
 =?utf-8?B?RTF4WFZtemlLQzBMYjk3M3FaZklHWUFoQ1hUVHZEQjJsZnZ6Slc2RzdGdGdk?=
 =?utf-8?B?VkIyRlFHR2FKUGVXbnZqYTV5WGUzSmgydzBaUzQvMU1xS2dUdUZibE9lKytq?=
 =?utf-8?B?SFhMcFJpNW5uL0hvUmdtWWFZM0Y3Q24zQjk1bXRuaDBWSk1rQmZRUjgvMkZq?=
 =?utf-8?B?T2FOb2VNY3lHcVBkMnhxaUovWFREVXB0Wlh4Y1pkbEhWRzZ2RS93aGsyWk5I?=
 =?utf-8?B?VkFIdG95NlBiQkc4aXZySUcxdHpvOFVtc1hENzdSMXdaSFdLVWJFNW9tVGda?=
 =?utf-8?B?cGRJRHBDalcwbTFDMHBYZVEwMU9seDNJTmN1T1J3SHUrUTErYlBuYk9NSXpi?=
 =?utf-8?B?c3pSS3YwYnN6VEMrMGJJRXRyYmZSZS9Za08vWlkzOWs0NkxJQk9BZFRtR0pa?=
 =?utf-8?B?Qm1CZktjbS9PR2J0TnVFTkVnRnAvY2dPMTFncUtLdytDbFZrQmpVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beca310-5eb7-4408-ebe4-08da3241e746
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 04:59:46.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlDfAD7b+XwACC3C+kerOUkeKr9QO6UZvj3oYCGALSPhpQ10SNo/i218hiHj3dy+gtuzVnNNzDmwmTqWiIks2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2897
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 5/9/2022 10:54 PM, Borislav Petkov wrote:
> On Fri, Apr 29, 2022 at 08:28:48PM -0000, tip-bot2 for Sandipan Das wrote:
>> The following commit has been merged into the perf/core branch of tip:
>>
>> Commit-ID:     fafd15ab6dc1fdfff66908e6d9231b124e1875cf
>> Gitweb:        https://git.kernel.org/tip/fafd15ab6dc1fdfff66908e6d9231b124e1875cf
>> Author:        Sandipan Das <sandipan.das@amd.com>
>> AuthorDate:    Thu, 21 Apr 2022 11:16:59 +05:30
>> Committer:     Peter Zijlstra <peterz@infradead.org>
>> CommitterDate: Fri, 29 Apr 2022 11:06:27 +02:00
>>
>> kvm: x86/cpuid: Fix CPUID leaf 0xA
>>
>> On some x86 processors, CPUID leaf 0xA provides information
>> on Architectural Performance Monitoring features. It
>> advertises a PMU version which Qemu uses to determine the
>> availability of additional MSRs to manage the PMCs.
>>
>> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
>> the same, the kernel constructs return values based on the
>> x86_pmu_capability irrespective of the vendor.
>>
>> This leaf and the additional MSRs are not supported on AMD
>> processors. If PerfMonV2 is detected, the PMU version is
>> set to 2 and guest startup breaks because of an attempt to
>> access a non-existent MSR. Return zeros to avoid this.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Link: https://lkml.kernel.org/r/54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com
>> ---
>>  arch/x86/kvm/cpuid.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index b24ca7f..ae1d963 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -887,6 +887,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		union cpuid10_eax eax;
>>  		union cpuid10_edx edx;
>>  
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +			break;
>> +		}
>> +
> 
> This is all fine and dandy but this patch in tip conflicts with the very
> similar patch of yours:
> 
>   5a1bde46f98b ("kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has architectural PMU")
> 
> which is already upstream.
> 
> So which is it? Should we zap this version in tip instead?
> 

Please remove this patch and keep commit 5a1bde46f98b instead.

- Sandipan
