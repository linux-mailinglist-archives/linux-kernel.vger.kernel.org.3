Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9504DD5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiCRIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiCRIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:00:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89E17E37F;
        Fri, 18 Mar 2022 00:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me2/BuR5xpxNbLXt+1vfWxdVCKS3Keudiwv0vpGWVOgnk4OT9Fsp8lm//hgAQ3uPXzYL/50KyT7MCWOzV7VsLjwIM4ZMUNZ99wG5Zm1cNWzvLsefVzJIYx458VuK2RkSsmSuB6BMg+HuWPlyZif8kZCph2y05qOn4dGDbVAZwvuJRFI5Ha6vNI7EpAfYEXZfRpSr5lJT8wSncd00wLIHWd6osmMBMH3qMkOma52CZpkTZXGkmjaF571IL35ozihyOt6IeRpLebZMC/CytQmlR/aVT8APdgGm503HGykchgFYdVPcNGRkVh1IdQdWXXo4gekgCqw9W2+R1yx3Ykyv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyag2Azp64OruyFk93mz152vMx1r1YeDe8UgbQ/bfSo=;
 b=Rl3xa2NeaA5Ox9eeGpBqrmSZZ9fQtgLqsdbNHc1l+Sgk14/hB7tAPQgltXI2hX3H2mHQ5OgI0Gbc9lXwTChvc65di6oNObXGdUVwKLrTWV7igNNUYbwWHy6Rn4n7vSQdrtQsdFyZzgn4Bpz3LPAwUV5jgybFdfQ9Rr4xSKeDxoU5f2H3FJW17gGfLkb9U2ynPFDqCBEDioPfsRqNMY0P3ylDa7DugCtfKB6RgNowa0DiPLke/ePgS5yO8yYObMiWDkHw2elJGkyCewG9QJ2osrI+1VYqabwiykg2z58/nLuxeINmX4SNWvsl9/cFz0Q1Ia1gMHSuL+AMLkYiK5yPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyag2Azp64OruyFk93mz152vMx1r1YeDe8UgbQ/bfSo=;
 b=gYqXdi1BzwNRv+No5Ox/PDARrkkVJF0gORdBi/XpNbVe0Ux3y3iG94MKhweU/CjWD993VUa1NMihBDy1yKWjKA7a7bqc2N1AyXYLjZOxLHpqGzFRnVInJFmUWnSLkJj1FIWGs5YrWEQw2d/HCveyqUyGyD3kjxYmonaJw5RAgVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by DM6PR12MB2634.namprd12.prod.outlook.com
 (2603:10b6:5:49::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 18 Mar
 2022 07:59:35 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 07:59:33 +0000
Message-ID: <27057728-e22f-a36e-bc68-aac311aeecba@amd.com>
Date:   Fri, 18 Mar 2022 13:29:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/7] kvm: x86/cpuid: Fix Architectural Performance
 Monitoring support
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1647498015.git.sandipan.das@amd.com>
 <bc58ac02d642ea1fcbd04a525046dfe978e9f323.1647498015.git.sandipan.das@amd.com>
 <YjMkk/O1UqaKpFja@hirez.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YjMkk/O1UqaKpFja@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::32) To BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3035a066-2bb7-40f6-4870-08da08b53cbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB2634:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB263493761DFB553FD59CE6D08B139@DM6PR12MB2634.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93CLlhZxi5K9+/YimrN5LETf5DKRybSnMAZ6v9sXgFd7/v/6qlSoT1NfCRP0oJ1xLFokqihcANaC4LaCy++SpRQ0jTDST2amtwutznws+LbaLras6DN1Bak9+l1imCjVYD/5n2Z86/r9oTZEg0ppuqTxXPjag8YhPnggvkLK9TI1a3bwe72Ckt6BF+FNPY90kpP3T2+FpFcGg3XNLDF0Ztx3+ni1eFMVh4S3WoBuTpLjnXTA2pPlJlF1OhJ+vaF6ju9009IMMtY+/+XqyqY1QSkvNG9Zz5hG1FDb9YH4EILOX/IgHMMDq7vmWC4D41JlWHWgaDcfuCqhC5DPQaaVYHSMfmmQh0mL475YRz/aQUGUUWOgTm3PautYCugfh9EEbFNurHuyzs17IhNCHmovWkZnwhQzTSc9yq13REsen4Y8RCzhjWvUb8FF1KlpXEXvchS8qJBNsWJeZFNqn4Nl2luOnNTk7TiVB9PPrWKGpOlj0NjRon2q20niitQjY8c1uJajQWC31aVgXt/uSqCtFi6RNcmp9fMlgZSyr098ALIdasJPMDRLt3xaD/e8FUlGNvy4LntY8fxBB1b/N3ZUldknA3rdk9NB9QTfq16vwLFpuEpAaU4QoytF28jf2eyBT6vbBPMXscPQh/MJhF52+U2JzdUDO9wuUt+KQJE75ChrzA1EFv6fbqVNB0Ar5CTN6pyCv5ZVlJJIU/2edoY5A2CTQXn3s+AuOLz+cCi3hds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(508600001)(6486002)(2906002)(36756003)(44832011)(5660300002)(186003)(26005)(2616005)(38100700002)(8676002)(316002)(66556008)(66946007)(66476007)(6506007)(6916009)(86362001)(31696002)(53546011)(7416002)(8936002)(6666004)(6512007)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtGSEhIMk5RaVljbVR1aGgwMjdySXBjcG1MODZUbkVTdlNFaytSVzI1WHVT?=
 =?utf-8?B?YTVHTUNrbjZNZkFFckw2VDhlMERUc3ByanJVaHNVTjJBUlNuMlRFRTZ2elVM?=
 =?utf-8?B?OWlpTVlCSklqMElGQUs0RG9xNUxFNGwyQ2VucXZWckxBWWExQllZdkJ3dWpF?=
 =?utf-8?B?dHZKUDNUMlZXRHhvdUhRVGJhSGpPeFFiUXVLK0Iwci92bitMWmowMW1lek16?=
 =?utf-8?B?VGtvYllCT2o4bndxVlFLblpDUmZ2RFJpWFpWblNBc3FVUGgyUDF5RXloY0xo?=
 =?utf-8?B?dTJJRisvSFVMZHNLNXFTdWEyZkJwNlgvVDVxWlFtL05HTXRFTUFDMURjYWk5?=
 =?utf-8?B?NnFBVnFwc3kwM2NsYTl0N1JwWWVYOUdUNjkwYUZXVzBuNFAxU3JHNkFZd0RL?=
 =?utf-8?B?OWYwaU9CWjN4amdOU1RoSUdHZzViL2lIb2tKaVQwT0hnczNkZ0l4Rit5Zm5o?=
 =?utf-8?B?TldMcXQvVHBBcmNuRzQreUVqSm9oaTlURFVrRnVwbGEvc3VuNnhPZDJldDg1?=
 =?utf-8?B?ZWkyc2E4K0NYRGFKMU5iZ2FvcjN0bDlPUUVVS1JTajA1cDlsYklnSi9hNFA0?=
 =?utf-8?B?UEdjYUlOWmxhQjM0eHlOakoxQmhSdSt3MDBubjJOQlVIT1ZqUkh3RGFJTlpR?=
 =?utf-8?B?MUErU3RaUTY1VHJjVFdOM29SU2R6TGRkQ3hXNldiaEJyY2Uxb3FsYkprdUJ4?=
 =?utf-8?B?K1Mwa3dvc0lwTW1xV0pzUlJ1bjVabXpLVTFmY0VRcXFjYTdOblZkQktSOVhK?=
 =?utf-8?B?R3FYMWJpd1VSRU15SkF2Q0RNRmU0SytSRkdneWJzbnRSdjhmZ1dWNXRSeERE?=
 =?utf-8?B?Y3JoL3lXMHhZSTk4eEJ2UGE1VlNGdFdmZkpsZkNEQy9jRTZnQXR5NUxaOFBD?=
 =?utf-8?B?UnBxMmVIc0hSQ0tQOEZlWDlsK0VibE85eE1YcG1GcnR1V0JDTGdmbkRCTjhZ?=
 =?utf-8?B?cHd4Yi9wVmFka1hSTUtHK0xlUkdoZ2FFM0FqUDk1RE1IRHltSVNIeHpTVVNi?=
 =?utf-8?B?S3d1UGNyVUVrUzdWVk5DYjZQSkxWc2pFeG9PTG1UMjM0L3h3bFhGYlZoc2JV?=
 =?utf-8?B?dEtZanM0Vmlvc1hHYVlocEg3K1pCOUtOQlpKMmZnR0taMjBxQzZ0ZHdrSGZU?=
 =?utf-8?B?SGkrTHc5L1pJNjlFb1BIMkVtVkFtY245a1QrWUpIdjY3SnZHYURyeUxGb3FJ?=
 =?utf-8?B?dWlFMUk5aVBoTmE4STNNRWdrSElkTmVhd3Qxd093bU84clo1OW5pSjRtUnpB?=
 =?utf-8?B?SVMxaEZpbkNVMWlSRS9mcWZoMW9ENmhOclNzcXVTMzZGQU5iZzJDcXEvUXBx?=
 =?utf-8?B?ckRZZk5oTjJURU5XRS9MTmdEV1FtMUQ3TXl0anNkd3RkK2pkb08rZ05kK3k0?=
 =?utf-8?B?UHZPY25PYmxaTXBjMi9CQWd3M09FSzJNUXJxMlhwNUVLMjFKMGNnWVdyc2pV?=
 =?utf-8?B?cGVTQUFEVWdHZ1dzUU9XL1I3WUdiYk1Fb2pOVEZCUHI1R1o4c3BGTmd2Tjln?=
 =?utf-8?B?dGJEeVhEb21VYW9uTWNwNVIxcWN0RFVUaGZkeldxb0JUUXJ0bE9BYnlveTFj?=
 =?utf-8?B?ekltR09TT2ZHelBHTGFibnNZSGxxaHRRQkV4MjhaYkZUemxnUTJ3WWtrbU8v?=
 =?utf-8?B?MW5wUkR4YzhFdjlZK21oUzd3MXFnd1ZzTnFFSnVUUHlrUHUrMVM1aDRadWdX?=
 =?utf-8?B?SEM0NEVVOU9xQXgzZFhrd0JUanBYd21PNFlIWXZIaWQxTDQyT3M1WGZISm43?=
 =?utf-8?B?ZHdLZ1JxMXM5RE5oWHNHNVV5Q2J1c09WTW5aVXVmMVBwTTF3NFlGYWVzMDM4?=
 =?utf-8?B?eFhIQk82Zkk2cG80cmkrTHZ1YzBhWlJQdFpLOU0yeDEweVhyZFVuaksrVWo2?=
 =?utf-8?B?amc2QlZObmFwWkROQUFPUTRTUGNGR0k5NE84TWZpd1h0S2dydWhwYnRpMVZV?=
 =?utf-8?Q?2OZ9DcYUcdk0g/0IXE1tKS8rzp0W7UgG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3035a066-2bb7-40f6-4870-08da08b53cbf
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 07:59:33.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZqHXlKj+eqUe/FfZ6pZHoEeM1Mm+RaKlzblYkjxEdbTFJ9IJcVlfixemh7ZXAnTK24FUfniusqDMYuK00GWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2022 5:37 PM, Peter Zijlstra wrote:
> On Thu, Mar 17, 2022 at 11:58:36AM +0530, Sandipan Das wrote:
>> CPUID 0xA provides information on Architectural Performance
>> Monitoring features on some x86 processors. It advertises a
>> PMU version which Qemu uses to determine the availability of
>> additional MSRs to manage the PMCs.
>>
>> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
>> the same, the kernel constructs return values based on the
>> x86_pmu_capability irrespective of the vendor.
>>
>> This CPUID function and additional MSRs are not supported on
>> AMD processors. If PerfMonV2 is detected, the PMU version is
>> set to 2 and guest startup breaks because of an attempt to
>> access a non-existent MSR. Return zeros to avoid this.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/kvm/cpuid.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index b8f8d268d058..1d9ca5726167 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -865,6 +865,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		union cpuid10_eax eax;
>>  		union cpuid10_edx edx;
>>  
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +			break;
>> +		}
>> +
> 
> Because actually implementing perfmon-v2 would've been too convenient,
> right? IIRC you're very close to actually supporing perfmon-v2
> capability wise here.

That's in the works as well. However, in this case, Qemu will have
to test CPUID Fn8000_0022 EAX bit 0 to see if the global control and
status registers are available.

- Sandipan
