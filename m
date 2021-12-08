Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7E46D95B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhLHRSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:18:20 -0500
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:39073
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234490AbhLHRST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:18:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPGA5iA8bCWDLHjZxLEFocOCfWKFQ0wlpcVkOsP/vWnAtdSY6wQAhxSdY/pewKZFktjFM0b7NXKXgNMJDCHjJaS6gS4WOsLONDFUE/jgP6NLiSK+lyJrWum/+THl4aQHuInPpB4RclmgkKjpeIajV4IeD3vufuRNwhh8WTVKcsv53yyEf61Q4SuP06CpgFEN7VkR5UnTAr1alq5PjxbBz4QvZutTri1WVK4JhcPFN+mROindGv1Cplsis8SMHk2olvKzEKGlJBAakVYQj/ZDDksr9LCFoaCmQU5LIyiAJ+dG1OECicb1CIt6o1uKyuqEq1uEm79iiBjKHocQp9gWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc7aP45eZR66I71CVOZvxmegxINBc1qO6H43QrEnOFA=;
 b=EOC//fw7IciaDnNjEYHDonTyitlsfOui5wg1Smx08iOz8V/Wogemt8vH2d2iu4Jh7uK5/DRyxStswNdGcXYCrNhoMTyoJQ8NTahzcNPIjWBv7OJpivEqu8XuXMnwH3hVyUuFbGfCOJCEfjzohh9X3j3MJSdNRDn21JpvDJXDlc8iTxqe1FeoBc+G65K4ZW9n7i9CfTHXArJye6sH12QjpjmH4Dal6GzVPNdKpZgQZAbQSC/zU6prNXGYf7FG+anXGXEu3lJWVFCsjHpYRv1HRX7wsuaLGn+/L3lZjIRFeQC5l4Nq7hWDIShpiZwoVlMpsf2F1fA34RwwoWhVQfit/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc7aP45eZR66I71CVOZvxmegxINBc1qO6H43QrEnOFA=;
 b=zv3UfrA9ZAjwFoPaAX37fcJ3SErXLp0GtGHcfpKxS8VYbuyOHvuxjHdQ+7UUcHb7wP0vQpFkWPriaur01nGjQJYfZ/Fizj/yvJpk+Hk6CfA82BxxOIteqSOzi5oCKSryp4jXTpVYbXIqChyDlD7WZFUgrYlRaQiGPAfw/ADBM0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3458.namprd12.prod.outlook.com (2603:10b6:408:44::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 17:14:43 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::78f1:d238:dd66:cf69]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::78f1:d238:dd66:cf69%4]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:14:43 +0000
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <20211004214114.188477-2-kim.phillips@amd.com> <YV8uQVnMnnMd1Led@krava>
 <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
 <fdcfec83-01c6-5e25-5b99-dac05287fdae@linux.ibm.com>
 <74e17a71-98ff-e0b1-61d4-d37992b1ae15@amd.com>
 <f095bebf-77d5-94c7-5787-13a6f38867cc@linux.ibm.com>
 <4281dce8-0e2a-cfe8-3b05-1b9a455d09a9@amd.com>
 <e937591b-542d-c3ac-bc64-d5223c27f70d@linux.ibm.com>
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
Message-ID: <ab336582-cff7-7e64-2f89-16305699cb5c@amd.com>
Date:   Wed, 8 Dec 2021 11:14:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <e937591b-542d-c3ac-bc64-d5223c27f70d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:610:58::14) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [IPv6:2603:8080:1540:87c:5a65:fe78:b4d2:c9a5] (2603:8080:1540:87c:5a65:fe78:b4d2:c9a5) by CH2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:610:58::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 17:14:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ac9cc4-6b8d-4067-d8a4-08d9ba6e3966
X-MS-TrafficTypeDiagnostic: BN8PR12MB3458:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34581A5385A5E2C1D992812B876F9@BN8PR12MB3458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bVTfhv3dsOdB7Oewmd88mhV2q64a3nyDtfS9R3Uj3xne9F74y/z5TQs6qwZw2G4sa9i//1UrS30t6vr7Cm85z6K/REbVLI9KbPKU0RoQwNnNw48p2ELLkgPgCygF5Vn/LmxQJbeMmuZtMeXBefeblO4Iljt2XS/lEVlFd1Anj8qAVHhuCXIcyFmyH/fEhg4DbRSu7/85u6ffe9eauQ1ohWo0TiYM2uD/440VhNWqciHnfN2V/nh7AhSoKKmYzoSPbb1vdtxEEMPNbE3RNPQmCq/EPfCYY2huvnyCsv5EqSFRXnP/U74VfrKVY46NA+RaXvZa+qLu1RvN2k//mCA0psO4y5ZnFzTIWEQZWYJ6/lPZKPNxEs+n0z13ce7Cj28xT9YHREkJjjaG3JZLirJ+bfNuZl5pETMvHsZG9EdthLn0Rq9GVEFqMHjvUNDvofh+gOPvoEnkrw/OtsD3Vh2UNClvbONqIjozDRBwIp51Wzd9RP/jMO6kf5XhdDPzBt/eNEsCnmOtyQTXVz+mdn/UcFU7/vLsLBZ++GSStwASuAJ36/8TzdZGkzyl7BAL2hWAY8hNQi6auCuSGgsFx7ug8Qg3aqMKRUs1hUIOX2wL+VQkstgqnC3pXljJDdcmGcjxqJmEb7wkaeCmFWNl/mXrSlwFV5wm1xD/s1XjLDb1NUVCbMlaUKRefTFPHBV1qNxIUHKtg9vkQz9BkgHFWFLRx3TgUMY5HjLj0MzSn8CPxQ22S48Sz9UfuGQFDmCARQk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66556008)(66946007)(4326008)(66476007)(6666004)(110136005)(54906003)(86362001)(44832011)(2616005)(186003)(8676002)(31696002)(53546011)(36916002)(6486002)(316002)(36756003)(31686004)(83380400001)(8936002)(5660300002)(508600001)(7416002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dQWW84ZnphSnE2ZUsrUjNhR3JGTFVCVlF0Z3Y5VDRCd2lyVjBKcHVNYUhQ?=
 =?utf-8?B?M3NEejVtR05qOVZORkpHTTZnSW5LZ2toSjNiQkVKbVAwOUZlU3lPNm54MGp0?=
 =?utf-8?B?T05IMExSY1BHQkw4aTAxSnk2L0U4R0pBZThSN3JqWHlsa0Z2SThrT2tDTmxO?=
 =?utf-8?B?LytlZ0NmaWVsT0VCaVRVTXVuSEVKelZwUzVsMXl1YlhiVlRheFZzVStYUlFS?=
 =?utf-8?B?Y1JiNlQvSk8wQ0plK2hkbWxhaG8ycW5aQ3lvZjdKbGlFRUlQYlNsNC9kUXZF?=
 =?utf-8?B?TW85WURYcGIwWE9CY0NRRithT0N2MzlFNW4zQ1FJZW5hOFZTNEFsUjd6YVBU?=
 =?utf-8?B?bG0xeUJ2SXZPT3p1WWszVGl4cUpsUUROOTNObWxQeWpmaE54bzRFeEdlUUNF?=
 =?utf-8?B?dzNzT2FlQng4QnBpNUtpNHFEdFd1OEtKaHlqVFdGQXYvNEgwY294azJsOHZk?=
 =?utf-8?B?bGsxUzZsZkpua3Nib1pXWTNScUxrdHpiRkdRdjl2NFNkUGpWUC9GcUltZUIv?=
 =?utf-8?B?MXUzbjlxOGR5SFJUVThtMHp2NDBoUmJRMDByeEt4R2NJNjNhQmt5UFBUR2Yx?=
 =?utf-8?B?VXpPYlIrbFNpditUTjBIZDIzVUZYMmhPcWRWNCt4Y214Z2lRNW9abXNiWDND?=
 =?utf-8?B?eUpDWFpLRnZhbS9sWWxmMU9jTG1sNkI2b0ZjLzlQNlhEK2U3NlF4b1pNQ05h?=
 =?utf-8?B?NklGWmE4VWVOWFh4Q0IyZDd5VlJnNTk2eFl0Z0VZUElLekplWUpMZnpqMGdG?=
 =?utf-8?B?bkZjKzZwd285QXRNZnhWQk01cC95dkRZR0ZFY0czd1NJQjI5MGVMVUNVWmNq?=
 =?utf-8?B?WTY3TWNiTEpqNU5ERjFjOWtUb0o2Qm42Uk42OGZIRi95ZzMrR1llMDdNQ1li?=
 =?utf-8?B?VWJUM0xUUWRENVVvOXU0ZW84UVlJSGlleFFMYi9velJpbFBsZjZjRWFkbXRq?=
 =?utf-8?B?aHJhQnBqNzRJL2Nod2NXZ2loTDJtRVZJWlNwdlJEeWUrSXg2djZML0VtY2tu?=
 =?utf-8?B?Wk1BTm9oYWdKaU9ibXpEQ1E2WGVtM1JqUC9PRjMweGRwam9ZY0p4WHhoZ3pr?=
 =?utf-8?B?VzBkYWY4NkM4U09HZ0pVWVhBMzVGcm45T0pxUVJIWnV4K1B4N3lIS1V1bklV?=
 =?utf-8?B?ZVFXVjl0Yng3NjVyMTE5U29ZbkJJV2txZUNQWHR0VXo3aTIxdTd2TnVnRDF1?=
 =?utf-8?B?d3pKcmNVMWFIenk3T2E5VE5ENDRHUDNpNVNMWk5aNGx6Rk4zemd2clpDbkR3?=
 =?utf-8?B?MnNQWVhKUXVCMnd0eldHM3RRTGVyeEorenZMQTRsb05rTEgwMlE5SjRQZjFS?=
 =?utf-8?B?a0tpUk04QnkwMG1jU280Sy9WSUZrQWhRQjBQMlVWa3ZKWnRKYVZ3RGpUWlpl?=
 =?utf-8?B?bjlqZE5kRytteUgrcGVKLy9pTll0dHRBUnNCQlF6aXk4NDJ4aTZ2ZEl4Skxs?=
 =?utf-8?B?bjBKdWs4MTMwTXZXMzZ2SVl1YVpyK2tmQkJyaXpQclN0emZjYlI1L1JjelZ0?=
 =?utf-8?B?Nk44OHowR3R5ZUhWdUFlcFpsbkJOQkpkZXZic1pxUG5WTENhZHQvQmVaSzcw?=
 =?utf-8?B?ZWRWVGhMTFZLZXZRNzM4djdmYkI5QVVYWW1YUW00OGRTQmltcjRjdll6ZFBT?=
 =?utf-8?B?SDJMQnkranM2UklmYUFNMTNGTElvQU00akZISzlpNmpXL0Z3S3pBaFQvOHBt?=
 =?utf-8?B?SjkzZWJkS1F0OTd3R2hIdWdPSktjTHI0UEE5bDBLbDV2SE1OOE91QnY5aGh1?=
 =?utf-8?B?VWVlRWQyYmRpeVlHcWt3L29GWVRLc1I1WVZCdDJGRXZndW13MXlJdDkxaldv?=
 =?utf-8?B?TWZoQndLdXRITFcyS1RXSjJkL3FpK0pERUQxUlNZVzRYZWphTGpOTjhjWnlJ?=
 =?utf-8?B?ZkVwWWxzNzd3MzRtVEgzZkpraHlSRCtBRC9rMnB4Mmc5bDdhN2NPY1JkLzJG?=
 =?utf-8?B?TFRvN2J2ZTVBMlh1VTgvUzJFY1lCdENrWk1oZ0RNMmo1TE51SnRNRXFOTzJ0?=
 =?utf-8?B?aUFrZjdRSXNoK29FdC9ndGVWSDFlUUxwaGEzdlFzVnIvc0ZWN2lVajU1MmxO?=
 =?utf-8?B?Q25GMkNUcGVvci9EQ1VXYWtIMjZZZGxaa3p6Q2VramtPMi9sdGxZbzE5azY2?=
 =?utf-8?B?UXVqeFZMbkRSZ3BLOENBSXYzNHRHMi8vYWxrd0tjbHV4UXVDNU9GSmViVzg0?=
 =?utf-8?B?anV2OGkxSm0waURLaWs5cEswcGMxZ21qZVA4eXFNVk1NSWlPc2lYc2tvSmtv?=
 =?utf-8?Q?xuL+TlQEhKvpgjMjr2Dpt7KDwChO0vjCSgW/owhtFA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac9cc4-6b8d-4067-d8a4-08d9ba6e3966
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:14:43.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2koi4kfRgB2AfBmNNl6ZHQpL+/6Gfw1F+EY7eznxKgWbml9yzArF+iJIY67Mik12m7ZcoU50nXNabqJGGAf6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 12:33 AM, kajoljain wrote:
> On 11/30/21 3:39 AM, Kim Phillips wrote:
>> On 11/24/21 2:00 AM, kajoljain wrote:
>>> On 11/23/21 8:55 PM, Kim Phillips wrote:
>>>> On 11/23/21 2:40 AM, kajoljain wrote:
>>>>> On 10/8/21 12:47 AM, Kim Phillips wrote:
>>>>>> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>>>>>>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>>>>>>> ---
>>>>>>>>      tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>>>>>>      1 file changed, 24 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>>>>> index b915840690d4..f8a9cbd99314 100644
>>>>>>>> --- a/tools/perf/util/evsel.c
>>>>>>>> +++ b/tools/perf/util/evsel.c
>>>>>>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>>>>>>          return ret ? false : true;
>>>>>>>>      }
>>>>>>>>      +static bool is_amd(const char *arch, const char *cpuid)
>>>>>>>> +{
>>>>>>>> +    return arch && !strcmp("x86", arch) && cpuid &&
>>>>>>>> strstarts(cpuid,
>>>>>>>> "AuthenticAMD");
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static bool is_amd_ibs(struct evsel *evsel)
>>>>>>>> +{
>>>>>>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>>>>>>> "ibs", 3);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      int evsel__open_strerror(struct evsel *evsel, struct target
>>>>>>>> *target,
>>>>>>>>                   int err, char *msg, size_t size)
>>>>>>>>      {
>>>>>>>> +    struct perf_env *env = evsel__env(evsel);
>>>>>>>> +    const char *arch = perf_env__arch(env);
>>>>>>>> +    const char *cpuid = perf_env__cpuid(env);
>>>>>>>>          char sbuf[STRERR_BUFSIZE];
>>>>>>>>          int printed = 0, enforced = 0;
>>>>>>>>      @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel
>>>>>>>> *evsel, struct target *target,
>>>>>>>>                  return scnprintf(msg, size, "wrong clockid (%d).",
>>>>>>>> clockid);
>>>>>>>>              if (perf_missing_features.aux_output)
>>>>>>>>                  return scnprintf(msg, size, "The 'aux_output'
>>>>>>>> feature
>>>>>>>> is not supported, update the kernel.");
>>>>>>>> +        if (is_amd(arch, cpuid)) {
>>>>>>>> +            if (is_amd_ibs(evsel)) {
>>>>>>>
>>>>>>> would single 'is_amd_ibs' call be better? checking on both amd and
>>>>>>> ibs
>>>>>>
>>>>>> Good suggestion. If you look at the later patch in the
>>>>>> BRS series, I have rewritten it to add the new
>>>>>> AMD PMU like so:
>>>>>>
>>>>>>     if (is_amd()) {
>>>>>>         if (is_amd_ibs()) {
>>>>>>             if (evsel->this)
>>>>>>                 return
>>>>>>             if (evsel->that)
>>>>>>                 return
>>>>>>         }
>>>>>> +    if (is_amd_brs()) {
>>>>>> +        if (evsel->this)
>>>>>> +            return
>>>>>> +        if (evsel->that)
>>>>>> +            return
>>>>>> +    }
>>>>>>     }
>>>>>
>>>>> Hi Kim,
>>>>>         From my point of view, it won't be a good idea of adding so many
>>>>> checks in common function definition itself.
>>>>> Can you just create a check to see if its amd machine and then add a
>>>>> function call which will handle all four conditions together?
>>>>>
>>>>> which is basically for:
>>>>>
>>>>> +        if (is_amd(arch, cpuid)) {
>>>>> +            if (is_amd_ibs(evsel)) {
>>>>> +                if (evsel->core.attr.exclude_kernel)
>>>>> +                    return scnprintf(msg, size,
>>>>> +    "AMD IBS can't exclude kernel events.  Try running at a higher
>>>>> privilege level.");
>>>>> +                if (!evsel->core.system_wide)
>>>>> +                    return scnprintf(msg, size,
>>>>> +    "AMD IBS may only be available in system-wide/per-cpu mode.  Try
>>>>> using
>>>>> -a, or -C and workload affinity");
>>>>> +            }
>>>>>
>>>>> and this:
>>>>>
>>>>> +            if (is_amd_brs(evsel)) {
>>>>> +                if (evsel->core.attr.freq)
>>>>> +                    return scnprintf(msg, size,
>>>>> +    "AMD Branch Sampling does not support frequency mode sampling,
>>>>> must
>>>>> pass a fixed sampling period via -c option or
>>>>> cpu/branch-brs,period=xxxx/.");
>>>>> +                /* another reason is that the period is too small */
>>>>> +                return scnprintf(msg, size,
>>>>> +    "AMD Branch Sampling does not support sampling period smaller than
>>>>> what is reported in /sys/devices/cpu/caps/branches.");
>>>>> +            }
>>>>
>>>> IIRC, I tried something like that but carrying the
>>>>
>>>>
>>>> struct target *target, int err, char *msg, size_t size
>>>>
>>>> parameters made things worse.
>>>>
>>>>> So, incase we are in amd machine,  common function evsel__open_strerror
>>>>> will call function may be something like amd_evesel_open_strerror_check
>>>>> which will look for both ibs and brs conditions and return
>>>>> corresponding
>>>>> error statement.
>>>>
>>>> The vast majority of decisions made by evsel__open_strerror are
>>>> going to be common across most arch/uarches.  AMD has only these
>>>> two pesky exceptions to the rule and therefore IMO it's ok
>>>> to have them inline with the common function, since the decisions
>>>> are so deeply intertwined.  A new amd_evsel_open_strerror_check
>>>> sounds like it'd duplicate too much of the common function code
>>>> in order to handle the common error cases.
>>>
>>> Hi Kim,
>>>      Sorry for the confusion, what I meant by adding new function is just
>>> to handle these corner error cases and not duplicating whole
>>> evsel__open_strerror code.
>>>
>>> Maybe something like below code, Its just prototype of code to show you
>>> the flow, you can refine it and check for any build or indentation
>>> issues using checkpatch.pl script.
>>>
>>> So basically, in common function we can just have 2 calls, first to
>>> check if we are in amd system and second to return corresponding error
>>> message, rather then adding whole chunk of if's which are specific to
>>> amd.
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index ac0127be0459..adefb162ae08 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2852,9 +2852,40 @@ static bool find_process(const char *name)
>>>           return ret ? false : true;
>>>    }
>>>
>>> +static bool is_amd(const char *arch, const char *cpuid)
>>> +{
>>> +       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
>>> "AuthenticAMD");
>>> +}
>>> +
>>> +static int error_amd_ibs_brs(struct evsel *evsel, char *msg, size_t
>>> size)
>>> +{
>>> +       if (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>> "ibs", 3)) {
>>> +               if (evsel->core.attr.exclude_kernel)
>>> +                       return scnprintf(msg, size,
>>> +       "AMD IBS can't exclude kernel events.  Try running at a higher
>>> privilege level.");
>>> +               if (!evsel->core.system_wide)
>>> +                       return scnprintf(msg, size,
>>> +       "AMD IBS may only be available in system-wide/per-cpu mode.  Try
>>> using -a, or -C and workload affinity");
>>> +       }
>>> +
>>> +       if (((evsel->core.attr.config & 0xff) == 0xc4) &&
>>> (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)) {
>>> +               if (evsel->core.attr.freq) {
>>> +                       return scnprintf(msg, size,
>>> +       "AMD Branch Sampling does not support frequency mode sampling,
>>> must pass a fixed sampling
>>> +          period via -c option or cpu/branch-brs,period=xxxx/.");
>>> +                /* another reason is that the period is too small */
>>> +               return scnprintf(msg, size,
>>> +       "AMD Branch Sampling does not support sampling period smaller
>>> than what is reported in /sys/devices/cpu/caps/branches.");
>>> +               }
>>> +       }
>>> +}
>>> +
>>>    int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>>                            int err, char *msg, size_t size)
>>>    {
>>> +       struct perf_env *env = evsel__env(evsel);
>>> +       const char *arch = perf_env__arch(env);
>>> +       const char *cpuid = perf_env__cpuid(env);
>>>           char sbuf[STRERR_BUFSIZE];
>>>           int printed = 0, enforced = 0;
>>>
>>> @@ -2950,6 +2981,8 @@ int evsel__open_strerror(struct evsel *evsel,
>>> struct target *target,
>>>                           return scnprintf(msg, size, "wrong clockid
>>> (%d).", clockid);
>>>                   if (perf_missing_features.aux_output)
>>>                           return scnprintf(msg, size, "The 'aux_output'
>>> feature is not supported, update the kernel.");
>>> +               if (is_amd(arch, cpuid))
>>> +                       return error_amd_ibs_brs(evsel, msg, size);
>>>                   break;
>>>           case ENODATA:
>>>                   return scnprintf(msg, size, "Cannot collect data source
>>> with the load latency event alone. "
>>
>> That change will makes AMD machines fail to fall back to the default
>> "The sys_perf_event_open() syscall returned with..." error string
>> in case it's not those AMD IBS and BRS sub-conditions.
> 
> Yes right, as I mentioned before, the code I pointed was just a
> prototype to show you the flow, these corner cases can be handled on top
> of it.

Right but these corner cases disrupt the existing flow: adding
int ret; ret = foo(); if (ret) goto report_generic_einval doesn't
go with the flow.

>> Is having the AMD error code checking in the main evsel__open_strerror()
>> so bad?  Other arches and their PMU implementations may find error
>> conditions that they have in common with AMD's, therefore
>> opening up the code for opposite types of refactoring and
>> reuse than what is being requested here.  E.g., I've seen
>> other hardware configurations - not specific to one architecture -
>> that could also use this message:
>>
> 
>  From my understanding, adding too many checks in common function
> for a specific arch is not a good practice. Since you already adding

My point above is that other arches can come in and adopt
the same error conditions and text.

> multiple functions to get information like ,if current system is
> amd/ibs/brs. Can't we rather just add a single function and handled all
> these checks there?

That will remove the code from the common path.  Code that's
possible (and in some cases likely) that will be adopted
by other arches.

Thanks,

Kim
