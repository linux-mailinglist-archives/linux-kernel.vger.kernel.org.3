Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C248B5114F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiD0Kn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiD0Kn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:43:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A953833C8;
        Wed, 27 Apr 2022 03:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJMTSFKwUUd+PZ9wjXghCBUxzEDfTNR210OZ+6EW6uTAuMWnkJh+TxawjvcAxQx/zGcITwStpdoADwsXQ9OGagsXHXj0PWmPUT+mA3iiFrrxYXvqRdBNo1SbmRW1BWuZBE+wXdIweehyD0qqSt5T9dvqo0H5aO/EIOOb8pvILLN53pWPs13n+Aw839EXBHfMIqorm5goBu7v+/RDE4UgmNJ4Mcs8fngvDjN+BlwxbaOiXXdQkkbyUm+OfkpNF/YP+cXxLYiBTVguFzbXRebACei22neLjq48mk9Pxe1Fm9jNpkgcmFwihojPnW0Ezad7E9dEXxXTQbdHjYI9CNTDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDKB8Z4a7W46ePFbduTiKosXT2435MHP5AAouTDENwI=;
 b=Ku7ylRXxIq3soIDZavEk5M0nDqZlOk9YSVUv3Z69eedd/3LhGrRU0r1KMee1QKg5K2ixXeZP5xItaFjIK0g3OsKKMSL9JmLyx8bZHNT1Ru9ynaXIC7sPG0l8hdkCclRU7gpmR0kzwAV3Ch2LJf7dAoWU0eYbjuwqoI0Vk4F172DTdvWH1mZ85QlKkenJ6xp8ouORW20iAPDG0C02QipolEhfIWZu9YyzKxnkxWqtBdbNOGzIrTAnrp9SQdy87IxYKymTPNheNda12oQ6ZCXOTf+AAQUxaHiUAIdwMACh5P7DLrxcFPq6YudyPlPH+6rXYL+irIoF2lBVtPrDzydQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDKB8Z4a7W46ePFbduTiKosXT2435MHP5AAouTDENwI=;
 b=kM7TnBw3wiZBqorFLmSPZ7YzCzvdu0WErH80GwkrfgK7y7rbExi2cgIcm9ZW9KfEQDhFWr6E4CocQ8ySEmEgWPypP0LsRe8UOxaF+k8Ox0l2plykR0uvChanajBvNRlzKURfPp2BvSTCqLHth7hntSwCUkf9PFyt+X36m3EOvEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by MN0PR12MB5738.namprd12.prod.outlook.com
 (2603:10b6:208:371::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 09:52:17 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::ed22:dd57:358b:9fb0]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::ed22:dd57:358b:9fb0%10]) with mapi id 15.20.5206.013; Wed, 27 Apr
 2022 09:52:17 +0000
Message-ID: <28329079-09f2-3ff2-4606-5ccd3831cf20@amd.com>
Date:   Wed, 27 Apr 2022 15:22:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasant Hegde <vasant.hegde@amd.com>
References: <cover.1650977962.git.sandipan.das@amd.com>
 <476a0d6feef8016ed19e4911ac25abdd20aabeb3.1650977962.git.sandipan.das@amd.com>
 <da7e8eb6-e473-84ff-1c7b-4214a5233a9b@gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <da7e8eb6-e473-84ff-1c7b-4214a5233a9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4d4647-c1b5-458d-b173-08da28339ccd
X-MS-TrafficTypeDiagnostic: MN0PR12MB5738:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB573885E998FC1829D81FE5BC8BFA9@MN0PR12MB5738.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kq/1aXdHlm19FVrIROT3v8GfcY/39yk/AGXiDQsCVQWDC/r2JE5gJNywPR6i+FDynlteEfomphObYwpLfdnvTM7Ht/RkuNxcJjB69G6vqxgeDXEvD/BRAezCS/t6QklER0VdaCm2hBD78IzKW2BIAzgcylathpuHSscjsQVzQY+5MF409tj+xkybUe4ktRj9SWA6n6wQi828yuyOkXb8m/N6NLhDQc91ei8sPw8GefkDFgEU7/w6grCP2hAeoUBcwmbgCkqh2wPi8j22F/BFHXSCp/mP39iBGRxzHaSNDm7XFsYoOwgWDGIkO44pumeLCK/qGIe7zLhk+UUO5seYVXBtiZtONV/zznUeNeYZtoPwhzkKdqsGB4GdDqfNA+eCfHIwiVb0Zf92seE9L+HJe7YqfXBOAxcVJgIqILAiYl7IR7Ma7Vy7+IM2/B5PrXgpe4xsW8mO2fHQ9N0IUtmoieG33ZxrT1dJZBjpXi2YiM0YkDDCiy8ux5XeyaaFaRsRHk7cBCGuiVzC7KTmg1/tu6AV/D7x+kRSmP/VYAxq0B9DXbWSREoe6+2mNDkfGjrZxfMM1ljbz/Iuhvycs8+lcjXIucymiSfMv24so4s2Rn6kZ1ZMIiPYKhRSo38dx+j+//nGxq3lGlioSjN7fHXioAEdC5PBRCsXwvlds47v9ZkWJrMW/NTdV78wwK1mlURQkTGMBoTpA88eJojtQFVLCP2T9amGizis19G4nwsEmqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(83380400001)(7416002)(53546011)(2906002)(31696002)(6486002)(316002)(6666004)(5660300002)(31686004)(38100700002)(186003)(86362001)(508600001)(26005)(8936002)(6506007)(6916009)(36756003)(66476007)(44832011)(54906003)(66556008)(66946007)(4326008)(8676002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhzUHMzZ3dkNUhUbFlyRlBLU2ducVE4dVB5U2NOUGlma3VNZ3ZqRHRNZGMw?=
 =?utf-8?B?cTJCSDNPc0hzUkFpLzVWV1c5OXh6anV0OHdyTkwzVmRtZVlCMUUvWTRoZkpX?=
 =?utf-8?B?WmRISGJ1K1NUa1FLZ01Pb2NGKy8yMWdKMW8xOW1JdmZ3ME1FdmlMTVY2RHBl?=
 =?utf-8?B?L0ZUUzgyb0o2aGhqSUFDUG0yUDRPT2daRjFoV2pBY3REZTUwbG5wTGF2Z1dn?=
 =?utf-8?B?Z0dXV2l1R29ZV3lOajJ1MjZ5U3hUdjJ4TFQ1c21RWm94MDg2MFYrS09CY0tR?=
 =?utf-8?B?NlZKT3pmTU5UUm5PTjNid0FFVjZ2RUE5QzhrUys0R0FqZkdkS0szRnNsRHkz?=
 =?utf-8?B?bHV4aDd4UWRBVXREVVdDMmNYWisvaGNzVEtiem9VU0R0Qk5XV0lFdEw5dVVY?=
 =?utf-8?B?WXRwVWJTakJYMnZaRWlsWnNJajB3M3BIZUhRdDlyRGx6MmpCSTg2OElRRDcv?=
 =?utf-8?B?ZmVnM3pUQ1g0Mmx2aDlUalRVajBjQ2w2RDR6MG0wY2doVmFXKytsNGNsMkFP?=
 =?utf-8?B?Y01SMVdrbzZ0a1NKT21xcHcwamJZVkdMWTdFcXBNQWpTaUtPTmZvcWlzeWhm?=
 =?utf-8?B?NzNmZnZobXJKeTNYckNUc2JHWFFVMkdmV0R5alFkT1p1aEJ1Rlo1dHBhTFc4?=
 =?utf-8?B?eWhIMDZNcTVDMDJ0TldUSzNHd3BpbzJwWEdRYWJpOTloOWRFYXlqM2tKSHdy?=
 =?utf-8?B?Z20ybWZ3b0YyR1hsaFBVbmJQZUxHQTcySTY3akFJK2ladXM0aVltN2M1R1Fm?=
 =?utf-8?B?WTdicnRmREhlTFF0V0ZlYy9kYllwZnZXQWlVTmtHSjViaVdqM3N3OG16VWRk?=
 =?utf-8?B?eWdKL1FUMTdBMTRSS3grR2kwVzEzbGd4N0FhL2dzRC9FSzkyMUpRSlVtRFRG?=
 =?utf-8?B?WEMyU081MEI1UWZiejZCYzFvNCtCd0V5c1ZKTjFQWXAzMVJpN0hTSTBVNmlh?=
 =?utf-8?B?NWFzZGtPM0I1ME9qYVA0bWFVQjMvcFFKaTB0NVAvYlZuS3gxeW15ZDRWNmRi?=
 =?utf-8?B?ZDJwTm5lWTU4cCtLbnZNWERaMTJBU3RjVFZPbmh5UG8zenpDeEpZTUN4V0sr?=
 =?utf-8?B?VVhWZGZibCttNXZjQWhCbFFSMUVBZHl5a1gyNlFhdURBemN2ZnZTQ2FEcFRq?=
 =?utf-8?B?YXZIQW5nUEJDMk1jVGNod2FTR3pNSGFPTEpxSllkb3RPVXdjTktRVkZwLysr?=
 =?utf-8?B?eUNRSGlDcWViY0hwMyt1bVlRZWRBVUE5RWZkR21ROXdVRDQ5SkZMR1VFODh3?=
 =?utf-8?B?QkVveWQ5M1JYUXFMOXBnYXp1OWIxWWY1QU9tMmJTQkIzTWVYc0RyZE9jZ0l0?=
 =?utf-8?B?TC9UQmIrd2ZyVEV5VHpNRDhFRkRFV3l1WjdHTjd0UC8rTG5hVXg2QW51Tkds?=
 =?utf-8?B?RUR4RGdXOHhXR0IzMnRzM1dpeFJlUzBtZVYxZUV2bS94a2lJclEyWUFrNE9J?=
 =?utf-8?B?QzlzeWxvbUZCR0tTdHJKTWNFNGw1NFEvYUlCQXFJbWwwOUI0Yk1pdU40SUlD?=
 =?utf-8?B?TEVHQWgwUm1lejJnaXJ4bHZWZGJKMEQrVCttdmJxb1pzbko3VG5zd1RrbVU1?=
 =?utf-8?B?czRIdDQvN3dZS2NBQnN1UUk1Ti9IYlJHcnhMb2FuSnVtQzZRZEE0REMvcnR2?=
 =?utf-8?B?NUpXZ2d1M2ZrNlExd0I0TUg1S1lPZTF2MG9BSGZDOWZ2NWZkZnNkUkE1ZDhp?=
 =?utf-8?B?cGppRkIvWUY0aXgvbkRIcXVJV3BOSUxXN0hCU2pnZTdlbVdTN0pTeklrSTBD?=
 =?utf-8?B?N3Zjd3MwZ1ZtczRqQ1ErN0lHT2dIYTRack54VnNhb21KNXlobHRnWXZKVUtv?=
 =?utf-8?B?MmRSK1h6UXVaSzN4UDFKcCs0ZE5sN3FFWU1uYVlJVTJwUFR0Tm94V2xhR0hQ?=
 =?utf-8?B?eVFjN3hKVjdQNTV0OVpOaDRuclViMnZ4enBFMFhMZnRGRTA0bEhCaVIxZjBK?=
 =?utf-8?B?TmRNVWR6amsyMTFhKzJkT0dVMmZCK2c4T25lK3U4UTBMV0ZVWndGMkVqN0xo?=
 =?utf-8?B?b3o4SnpyWTFnMFNuMnRjWGQrd2xxYkViRVlqc0tTV2hxeTJ6cno5RkZhL0xj?=
 =?utf-8?B?QXJBQ0gvSTdwT1lES1hLSnZCK1pPQldIK2ZPckpveHI5Y1pxeFpsUzVTZkV4?=
 =?utf-8?B?MHVHUlpUTG5Ea3FocVgvMzRTb3NjREJwdlZMekFXUDhOV21jS3EvaExsN1R6?=
 =?utf-8?B?QUFpNEsvdno2d1lzams3TlByczUwQmhqaGxsc3JGSlBXbWlMQmtsRTFYRWhQ?=
 =?utf-8?B?WDRQbnNRRUNSLzJ2UTZYVy9tVk5CejJMZHpXYVF5N0s1dFRYKzA5emNLak9u?=
 =?utf-8?B?dVFZS2F0STUwK25UemJaRG5IY1JiRjlmU0NvZmxpZWY0L1NyMkNwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4d4647-c1b5-458d-b173-08da28339ccd
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:52:17.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBV4uet1dmYINEIGhDe1D4wclnGeShT3LUvBRARkbE5ddAOzH2siTvhnr/rC4A8e9nVd6h0eCEq82Fwl19AL5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/2022 3:02 PM, Like Xu wrote:
> On 26/4/2022 9:05 pm, Sandipan Das wrote:
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
>> and Hygon processors. If AMD PerfMonV2 is detected, the PMU
> 
> So, why not:
> 
>         if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON))
>             break;
> ?
> 

That seems to be a better option. Thanks for the suggestion!
Will change it in the next revision.

>> version is set to 2 and guest startup breaks because of an
>> attempt to access a non-existent MSR. Return zeros to avoid
>> this.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 4b62d80bb22f..d27d6a8f601a 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -872,6 +872,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>           union cpuid10_eax eax;
>>           union cpuid10_edx edx;
>>   +        if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +            boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +            entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +            break;
>> +        }
>> +
>>           perf_get_x86_pmu_capability(&cap);
>>             /*
