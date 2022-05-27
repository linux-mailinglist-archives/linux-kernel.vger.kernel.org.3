Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF053577D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiE0CXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiE0CW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:22:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DAB6F494;
        Thu, 26 May 2022 19:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhNh4LdJytHMSzu4CV9oIWrJfk7r0xBYwZUZlVDYZVNTlUwJAzs7Ckx4yyCj3DvaUcJLKIgZ9ud7YNUWYifJlMPuCwJ7xFP9tTE6dVINaf7cT/EDzKoZrxSjo+qubd4GPiouHTAresUg7xI7qr9wXBZSOqvzVBQW612el++g/krXCaM6tC67FpRdxRTmRdqpJT4/CXYFcFpx9WJk4HQiGgCG5xsdzsBo99BGP/ubBQdrFnyWaiTLE/6zQrdF8SV7iOKeIDq1lSs35+C1RG9+OiqOVk6hESt0rF0Zd394hIDiKy8kfRvzPo1K1yNJjFZznq/feGU6bubUFNPmrKN/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k02jWeHx6bFmCwiTKqT6QMmOivwi3725B+Sj5tNzmoc=;
 b=Zd9rJJ4WuUpkn0PvQ8TuxmdCcEfQGL6Al+5eAJIK48UG8OP5v04gtKgna9SMQxAWNnOT+ViGyKeWv+/P6Sm036N+lLB4GwL1Ixfh6iO5vn1eMVEHnJCi6zBZA9WwqYNlcT7GCB1usSB8nZAXK2Gu4DhHmFVO7w3RmEgI8XSBMZoknTi29RXO2J8ILFwKSocomzSIkaIEs0RjMUpMpuuDxAXe+c02mbb8d/1eLLJaBF5/0R2EDFjHOz2Eqb7pOtYWBZU2bXCh+xl0r1Py6f5jLV+OjqwKQMJt7J/8NN2XQbQJvSQ8PM3NDzlYSBBsmOkjaAzk+K/EK/bWv+gztGnrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k02jWeHx6bFmCwiTKqT6QMmOivwi3725B+Sj5tNzmoc=;
 b=Ac/ZLUjJSeMixuKXr0Np+v9+VGFUJOSZdN/E6pc2knzL4r7yJA3bkyxPhtqAI2ia47st3j+fpgnrIeVQBbnxKFPc4dNyOqH5Jt1OSDQF1G9iRp0CaY5rmhlnTcpI9r3H8o9QLhcdAaZ7TwgwYTRk4j+i5Bt5s1Y8P9Fnb1qWHBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 02:22:51 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.023; Fri, 27 May 2022
 02:22:50 +0000
Message-ID: <05aa0287-ebc4-b85c-4012-f16870caf0b8@amd.com>
Date:   Fri, 27 May 2022 07:52:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, james.clark@arm.com, leo.yan@linaro.org,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-3-ravi.bangoria@amd.com>
 <7c072dd2-de6f-e083-a400-17467d6fe6e8@linux.intel.com>
 <4f7239e2-c065-0800-f679-d4ed797fdecd@amd.com>
 <adf43431-f828-75b2-359e-652c5fc96dc7@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <adf43431-f828-75b2-359e-652c5fc96dc7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffcd9e2f-83c4-46ac-2e17-08da3f87cc1e
X-MS-TrafficTypeDiagnostic: MW5PR12MB5599:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB55992A8C48C760F2EBA3275FE0D89@MW5PR12MB5599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xIeoEoukEoIt5HjYpd80VMXbnUsC2TszAbgcU5lPXdYDCpws5OyjTXVsUYVnieZqiiBdA7QK+mEwjBAqHtNx8Yq6C+wPzx6pzwUBGdBaif6hpbZaran0G51sHGt09JOJbtqwHfv9FeEWs8kFri488k5FoX8q7syduDjlWT3Z0rBX6O8O9+rwGXqiQ/YuxNUtJ3GhNg9goCbO6ilY7qdpBqNiJ8uyqSCJWP4EQCU9YTolEB3qAXi7ebMwxwVMc5Y0PX1bzOrjYbafFny2FPNUowLY77nHTH+NsqqjGSep/0lVKjHw/GN2kewWTAnHJe8CEdlJikbmvRKCuumvmP8T9syu8K7ZuYz1QxNaAf3Dm1gngnyI298qtWCWGKw8KK+zCbtJJVXBApbgjl9gBkBCYMjc7B9zHNOIq1ILlcBurnBIHatDqgnJrXsf5ZfeZ9/tifA5XKbeHLDs0FnlYhFBr3hZmz65/tU3NblCA7WyXalpKs4LAsy4/Zd762ciSBPxB1oD0yYuK57ON9DM9iOkj/AHdTopqFWX2QNASN1CuaD1qlLekyMlP4dqw1+BaSe392/0i+wgMKPEXcLG5mz2lyNm87W6yNXFaPg9CzdD/M8F7DOojQo5s1ooCGHvUBfutFiqtq1TFg+vcJ2GVBLZZH3Zx6mnqna6i3bvejHpiH0CDU43E5oqdy81kV5EOwvB3iFAsZoCqZZATgmcAwTzIYkuSOlr5vOUlXm/LZ+wx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(66946007)(66476007)(66556008)(44832011)(8676002)(6666004)(36756003)(2906002)(186003)(4326008)(2616005)(53546011)(6512007)(6916009)(7416002)(6506007)(5660300002)(508600001)(86362001)(6486002)(8936002)(38100700002)(31696002)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlNRVNoRFhHTExSOHBHZCt4bmZxN2xLUEpKUlg0R2NSMElaa013NTdpd2Jy?=
 =?utf-8?B?d2VsK2JBNFFLeElmcVRtZkY5My9OUDAwTStYUW12TGQycS9Sa3NYeFVpMGhN?=
 =?utf-8?B?VUFrelR0ZEJGNVMwMkRWK05GVEk2d1loNVFrWXA5bjloM211RDRRK2JvOThW?=
 =?utf-8?B?Mklod3ZXYlozbUlYZWZiRnFia3FYWk5HdldKYjJSWk9EVm5IUHREWlZLZUtN?=
 =?utf-8?B?cEU1Z21xZmRIck5kUTFiWGE1eDNJdFVDY25pSUtmbEJ2R0Z0SzlqUjlobEMw?=
 =?utf-8?B?NVhyNDdOQ004R0IxbUxHOHR2OHZpVzlEbzFSMitJYUIzMG1aMmZpdDd0elpY?=
 =?utf-8?B?TGM5VVNxck5VUkp5bHpYWWRkeTZWMFRXbGhqalFrb0ZsNUp4N0JaemRqb1Bz?=
 =?utf-8?B?K2RzNENLVHdGbGplU1dia1RGQzMxTVNHLzVHMEcrUnl6WGh1aTBxL1R0OVRa?=
 =?utf-8?B?c2hPanFBa1RteUlsTmV3MmVTamlTUlU0R01tbEtVT0UvWTBQUENjOHVCQkxi?=
 =?utf-8?B?UGF5bjlQQ0xBMnc0RGRpdzdlYTZPcXd5NnJVcjZCUGxyQmtZcHoxczR1b1Z3?=
 =?utf-8?B?NGc2di8xdUY5NFlhYlBOS3YrS21lQW9rOTd6RFJBME8vMWJYRWZVNEpLcW9F?=
 =?utf-8?B?Mjh0RnNXK2gzSkl1a0dNc2FReEI4ekIySllqWFNVUmdTckNDR2FUNG1JMEQv?=
 =?utf-8?B?MllVK0hYeEcvYnA5UUE4VlJSc1A1dVkxQlltUUxMY2RKalZYYXJ2ZEdMV05h?=
 =?utf-8?B?N1JKc3FxcGhtVE9zQnp6dmoxaU1ISDd1K2xMbWRYb3JGMGZlbnc1ZXN1Y3lx?=
 =?utf-8?B?a0UrZGxaMFVYeTh6TGo2TDBQVHRZNHFoclZPY0JBTjBrMCtEUURzQzZ2M2ZT?=
 =?utf-8?B?KzZHbGoycXRFWFJIOHBNb3M2VXRjMWJNaHNnSWwzQk52Y2Ntb0lod3QzTHh3?=
 =?utf-8?B?eFJvdmlXT1FUZGh3dlMzelJBVzhVTXd0WWUzR1I3K0lnYldRQW9jOTEzZExu?=
 =?utf-8?B?NkdNWXhJWUwycVJuNjhjWmFJMWhMNVJSclcxbDNlMTlvNm1KTTY3QkYxT3E2?=
 =?utf-8?B?YnhHR28xL292UjVDUDFVdEQvUkluTW13UlU2Y0FvWEplUHlLM0x3Y3g4cjJ3?=
 =?utf-8?B?MGVKTW9CZmlSODNtVE9ycHJ6UFE3QmR0dC9IT3hrSjlWK01hWEFxc0tRbFBO?=
 =?utf-8?B?UXR1dGlTcE1LeGo1RjcwMlZBQklaUG5LR3JmdWY3L2JEU1NvWjNDYjhQVFNq?=
 =?utf-8?B?R1pCTU1menJydTI3R0lBbHRyWmFHcVF6UDNqRStZSU8zT1BYRmFxZzIraUpX?=
 =?utf-8?B?ajVCVFhNUEdwR1V4RnBtbHNiZlc1aGZ3Vis3eTBGekV2MWdOMnU5cVJUUHI5?=
 =?utf-8?B?R2JBR0RPWUEvd2ZHbFIvVDA3aUhFWExRWC9lL2xMcTJUaWJlcitnSDUrNWY4?=
 =?utf-8?B?MDdETWswZmQrdDlzUUpKVFF5L2xSODhZWWl5NUJBSGszaEdodmVMVTU0NUtM?=
 =?utf-8?B?aG9xYXQ5Qk5DZFZhelAwbmFMV3JXTDBXMktvQUcrQlk5TUVCVjVkOFRiNnIz?=
 =?utf-8?B?QXhMeUk2aklOZmJzdWtxQ29CTXNrdjNMTjdVUjlHQ0N4N2hBYlE0a2lvZXYx?=
 =?utf-8?B?Zno2ajJrVmhsQU9MN2Y5YzJITUw2bFRtWUV3RkxYV2xZS093YThoVGRuNXA3?=
 =?utf-8?B?UkxEckVzRktxSmRjUVVMQ3BKcGlCVHZTQzhkald3eXF1elNDckt4b3VGMVph?=
 =?utf-8?B?YWN6ZUFScndBcHNnSXRzb3hHc2tVTUp0Unl1WktJQzhNdW0yK2p2ZTgrZGY4?=
 =?utf-8?B?YmJYM01EQWVXQXhlSzBIbXh0aHF1SVU0YTFaT3BDa1dIQjl6NzE3VUFxR2dJ?=
 =?utf-8?B?WmVMRmtPZjRxNTJVZk5reWtlYUd6eENHMGZYdXdwRzlkQXNaZDN3cEpBWXFy?=
 =?utf-8?B?Z05hUmZ1Vy9ja1NyQVhoYWxZOHI5US9GbmErRm5lVHdZWHNQK3hyYmFEdjkw?=
 =?utf-8?B?ZWphcFlIY2hqN2s4TU9ydXdyVjBaOUtMUnpnRmcrUFhwK0lGVUVwMnkwYXZF?=
 =?utf-8?B?WHhCZkdnb3ZGRDNlTXczc2hNbis2UmNpc0Nvc3Ivck45b0dLbEVHMmVRK0Fs?=
 =?utf-8?B?OEZHMFQ5d1FBTkJkb1ExUWlJNVBHb21lakpPZ2t6K1RYR2FhdnlNTmhXTmR4?=
 =?utf-8?B?VU4wUE0ySTNuWEtqRHprdVFKTHNpeUhnM0dxaHFYdFJQVkNZdGxSRFFDazNZ?=
 =?utf-8?B?YmJjTXhUeUFHb0hEaUdRVG9MNFl6RkQvSSt2cHlUYi9sOGdFdTdDZWhQQTlQ?=
 =?utf-8?B?WFVTbzdnZjVUeHVLd3pEdWx3ejY5OVJqRkpnQXErbUlsMkJ3SzkzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd9e2f-83c4-46ac-2e17-08da3f87cc1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 02:22:50.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUx9Bvo7N5GKwJSMSEf3Rj9X3x9R+3FtJJtl3nqrRH60R9klp53BVLWlWQB1DbhQ6QdyWdux6iHtGOpe8nVAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-May-22 9:25 PM, Liang, Kan wrote:
> 
> 
> On 5/26/2022 11:08 AM, Ravi Bangoria wrote:
>> Hi Kan,
>>
>> [...]
>>
>>>> +static int write_pmu_caps(struct feat_fd *ff, struct evlist *evlist __maybe_unused)
>>>> +{
>>>> +    struct perf_pmu_caps *caps = NULL;
>>>> +    struct perf_pmu *pmu = NULL;
>>>> +    u32 nr_pmus = 0;
>>>> +    int ret;
>>>> +
>>>> +    while ((pmu = perf_pmu__scan(pmu))) {
>>>> +        if (!pmu->name || !strncmp(pmu->name, "cpu", 3) ||
>>>> +            perf_pmu__caps_parse(pmu) <= 0)
>>>> +            continue;
>>>> +        nr_pmus++;
>>>> +    }
>>>> +
>>>> +    ret = do_write(ff, &nr_pmus, sizeof(nr_pmus));
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    if (!nr_pmus)
>>>> +        return 0;
>>>> +
>>>> +    while ((pmu = perf_pmu__scan(pmu))) {
>>>> +        if (!pmu->name || !strncmp(pmu->name, "cpu", 3) || !pmu->nr_caps)
>>>> +            continue;
>>>> +
>>>> +        ret = do_write_string(ff, pmu->name);
>>>> +        if (ret < 0)
>>>> +            return ret;
>>>> +
>>>> +        ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
>>>> +        if (ret < 0)
>>>> +            return ret;
>>>> +
>>>> +        list_for_each_entry(caps, &pmu->caps, list) {
>>>> +            ret = do_write_string(ff, caps->name);
>>>> +            if (ret < 0)
>>>> +                return ret;
>>>> +
>>>> +            ret = do_write_string(ff, caps->value);
>>>> +            if (ret < 0)
>>>> +                return ret;
>>>> +        }
>>>> +    }
>>>
>>> The write_per_cpu_pmu_caps() also does a similar thing. Can we factor out a generic write_pmu_caps() which works for both cpu and non-cpu pmu capabilities?
>>
>> I might be able to do this but..
>>
>>> It seems the print_pmu_caps()/process_pmu_caps() can also does similar factor out.
>>
>> not this, see below..
>>
>>> Actually, more aggressively, why not use the HEADER_PMU_CAPS to replace the HEADER_HYBRID_CPU_PMU_CAPS? The HEADER_HYBRID_CPU_PMU_CAPS is the last header feature. It seems doable. We can always write/print the "cpu_" kind of PMU first to be compatible with the old tools.
>>
>> There are some differences in how capabilities are stored in perf.data header
>> as well as perf_env. In case of HEADER_CPU_PMU_CAPS or
>> HEADER_HYBRID_CPU_PMU_CAPS, all capabilities are stored in a single string
>> separated by NULL character. 
> 
> I think this is the format for the internal string, not the format of the perf.data header.

Yeah I just realized that after replying. Anyway, thanks for clarifying.
Will change internal format of HEADER_HYBRID_CPU_PMU_CAPS (as well as
HEADER_CPU_PMU_CAPS), and replace HEADER_HYBRID_CPU_PMU_CAPS with
HEADER_PMU_CAPS.

Thanks,
Ravi
