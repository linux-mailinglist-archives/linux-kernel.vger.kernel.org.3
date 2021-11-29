Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57544462407
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhK2WP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:15:28 -0500
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:9440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231403AbhK2WN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:13:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHtEiYlGogtW1JUTFgRI+s3+My+gXeGbDKDmGIebSs6rlkxIkjJ+rFnWSrpfEVtlwaCBoFAra2ZinQ2Y+2NMR2wJsqqg8pwY6hKAWo7PpOQock0z5V/EtxwiCVN2biA1T31CvmgEPaVioF+AoKqtOnDz5EtGtsq5q9U9ONM+L2P9HdlW8480Xbn95dZWY75994hQ7l9PzPWclBQY2/5MfLgZWDXwc35UIjo66TISPI3nM5m0qF31LTCDUV/SXoGmGOB1KuAVv4TCo9WwLQoKtNibWIzAskJyFnUgF3EBOApqyd13A/stbfCYvmuE5MD0NSomgnnosKc/lZEsZzvYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNEJH0qyTWBRXTUVHqpqdrQiaNjjAtQ4B9RVSHuKU6U=;
 b=LagRoEfEI6/QM16jnvGcdiEk2nGSaAR8pew4kQNy7d5TOkUL0fzoSdeKaE7SDqlVrZRKSwprzmtaNubrJmix2lCJcbgrpRcJfeMerYXCeQAQtWiqRNi6n9UEgbemZjOLzpUKcdq6SCWR3B+HY2mYhnesPBakc890Cjhq+4zExXXZByRkhZ2W6IwfSE3Wb0pNOJAdNZs82TwA3ZL26bdpilubJn4uiEtos633RscciPQR4cxrT7PnO+nExxio1hmQa1Qbw5uXLkdZSQrdrVazaGUE6LBMr4d9Y0PWGrft8dAir+d7HBrCbJVyNJJ4JVDrhjrqvkkFDgAqR4qDzKlhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNEJH0qyTWBRXTUVHqpqdrQiaNjjAtQ4B9RVSHuKU6U=;
 b=OouWe2LMrk+SpGZ17EVmjwxHvjp0VkXIUisv8RX4C6WBgcDFGn2qaXnmH8f7fSU9R9gxJxxNZX8o7YNGKJ14Zh1N01ZJzwUawzA3vOGWrLXJ/7KyynfrMBaEnYoFDoGkEuNpiAbnDKJQ8vN81FIVSvwJXoGbSDZvhyz4S5Yc+h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3187.namprd12.prod.outlook.com (2603:10b6:408:69::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 22:09:51 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 22:09:51 +0000
Message-ID: <4281dce8-0e2a-cfe8-3b05-1b9a455d09a9@amd.com>
Date:   Mon, 29 Nov 2021 16:09:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
Content-Language: en-US
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
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <f095bebf-77d5-94c7-5787-13a6f38867cc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0329.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::34) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Mon, 29 Nov 2021 22:09:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce11b4ee-2387-48d6-a92f-08d9b384f70b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3187:
X-Microsoft-Antispam-PRVS: <BN8PR12MB318723C8F316ECD9F3C1D4BF87669@BN8PR12MB3187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFUPEvq7CFEU2+X+jPizN5Xfkmi5mIRqQLk25/mtRXTfZve1hkE0IaCL9ULfplSEwnqgUXbjGMXta1cYNaP9YKHiumr/lkxaEz9F9Ef51jFExBUurDztXxnSeICJHLFV7QEu7KczL7iNqRjST9JicR4xvc/8a+ljLwqczMxAwZksOJTVz13ccMztBsaAokkSxl9u27uqiNYnMKCo5UuQmsa2NKN8WMtBlPSRs6kQBltrrzPqjWxB6s5ulcjsw6I8dMopIdxZN0gQy5x2V94Ow6iARAETJCHpGdMPnVd/gCE/ioA8pbzSe1JfXnV2CyocRwqGZoQVMjzpz7KByN967KtDQRlsbAUOt8EPfG5LK3+ZwVXPppbLE74xmqvIdiT4oVRo0JME8nUClknuxsR6cE7LrQEI16lHy24UTGwl4kWqif0ZvdY2F2Ltu79fALMiF/S3yGY99+3mqAPC6YOyevsKE2whwvBw3QVWqnAZx99d4kcbqa/nvYh8REHlEK9rzzIxggQnCX6v6aq+FMV84ZdKvlPPRHx4RKF/vzm8mxaMlUge8I6oog7bXsxHdFsYyCISShX+I4+BzY1AKluRmPq/pNuZBkIN+CgCynv75wSV8k9clV3rY2i/nGsm/cSZqjxHLpcn7EEAyiiOIra6weDQOCkY+PF+ujILNIRlr5rds0dGlvjah6EEnNQ618/fpeUGedTyv5jcvBsR/BYIjheLGXO0tuFflZuNmOqtakM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(26005)(110136005)(508600001)(54906003)(31696002)(66476007)(53546011)(8936002)(44832011)(6666004)(66946007)(7416002)(186003)(36756003)(956004)(31686004)(38100700002)(2616005)(5660300002)(8676002)(316002)(4326008)(6486002)(83380400001)(86362001)(16576012)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2diVTM4VWJxbmoyNEdvUCtTa1gzZFJXQk9xK0Yvb2xzdGFmUjRVMGdacUl1?=
 =?utf-8?B?S1krc1l5a2hkbWZmNU1FQmNKdkgwVzg0bzkyNVplUHR0RkZ4YitIVDNUNFVO?=
 =?utf-8?B?YmJONjZET3VuT3ZMM1hlUDZ1K3Z5aHRzcFpGbm9CblZwR1BWV3M1Y3g2REwy?=
 =?utf-8?B?K0loU293cFZnQ3BrdnhLc21XRmN1T05Kb0V5WUFiWEZxbHVoUGtSeEFJR1BT?=
 =?utf-8?B?VGRZNlBsMkVWYnF0RGR1MVFOaWU0RUcwYkp2a093QllzNkI1bnBJb2hzYk5v?=
 =?utf-8?B?MUdXeithbWhvVHQxVHM3UTJ1dC85MVpoeVpZT0tWMGl1MUVDK2VOcXFSenpZ?=
 =?utf-8?B?TndjWHZwY1M2enpMZ0NpNCt3dUQ3Z1RCS3E1UXRlVTRndlFkZEUvaHRpWTFZ?=
 =?utf-8?B?RjFZMkZZNXhwY3J2MWYwUEk5K1RERkphUFNlSGYweS82eER4ZVVUNWQvUWho?=
 =?utf-8?B?NGpUc3hBSFhua0pPbksvK0ZiYTl2WXRRaTh4YXdmRVEvNnNaTTJ3anFpNHpq?=
 =?utf-8?B?dUcrRXRKdGN2U3g0bjFGSmdMREVsQVNzc0d1aWZQdGFNQVZ3QzZTM01iVzVl?=
 =?utf-8?B?R1BKRUd6a2pQSUJFSnZ1eCtoRmNKUm0ydWt0OTlBWGlJeGxVNElIb3dEOGpu?=
 =?utf-8?B?SS9hSkhVdDJySUhrTGhEUUNoUkEybFRhclBSc0Y1V3p0K0VqMGFoV1NVREIx?=
 =?utf-8?B?anFjbUw2S0taSE1QNTl1dTE1SFZ4T1RpYVFQSEVLcFVRMXRhVWFCY0FzR05C?=
 =?utf-8?B?WDkydGxiMzNKRm1FTEoydG1sWHd5azkyZWNsVXJvczJIK2ZkMUVub0lHQ2RK?=
 =?utf-8?B?ZDc4L1huY2hkeTgxNE1WSHZVaGI5RTYxVHB0clZiRytHcTVuNHRuekJzRE5J?=
 =?utf-8?B?WWN3NzkzNzFtVHpjOGxXL0tmNmh3cWlnYXE0K011L3NiaUhHdmhMM3dPZUNO?=
 =?utf-8?B?bVhIa2tBQzA5aXg3MG1ZdGlmS3hGNlNiQy9qQXlzZ0hvVUJjK3ZKRVFWdS9s?=
 =?utf-8?B?UFd5VVR3ZXdHdUloK1FMeGxZSG82MkVWSHowaWN3TnRES1RiR2xIL0JTVDZl?=
 =?utf-8?B?REo1ZkwrU0tjRlFVSUFGMU1GbEFaMVdjS0hINjJHMUdhYW4yV01VRzlJNFFQ?=
 =?utf-8?B?ZW1aRU1URHp2UmdFWFp6MU85U0FRdWw5bFB0RU9iYTc2ejQyRGJEdEpWcnVU?=
 =?utf-8?B?NlRaQlRSSzNnUzB6cjB5WkhNUS9RMDRjUndXKzAvNW43RTZ5SVBUcWE1ZElI?=
 =?utf-8?B?QkNqTURyd2t4aEowaHdETHFrR3hDaWFoT1g5UTIvZVYwK3o5dlY2S1R2K0o0?=
 =?utf-8?B?alVtS0lsNktheHg4QzFWNlkvTzNvZ1gvaGFuZVkzajdFQXkrZGh1VjBxcFRY?=
 =?utf-8?B?Tkp4WDQ5V0d2Z1BienJaazJLL25FZHR0L1lKRHhlUHZJVjVkZUVZSDVhaUJu?=
 =?utf-8?B?MlBFaHAzbStmVHh4TkZsS1Q0L3JyMTEyNktGS2l2dlc2anVBY2toaXVMeVZt?=
 =?utf-8?B?VWtBV0RMcHloeFhmMWM4WUx1Ukx1NXZXbk5qZjEzSGNtMWw5cnlBcHRqVDBh?=
 =?utf-8?B?V1hGMmZqeWxhdjRSdzljNkQrOTBtN1VOT2dweW1oZHlEOFRPcWZoZ3MzRkwy?=
 =?utf-8?B?L3ZCb0RhTSt5a0hRWCtQMUJLL1V0N3Y1c0ZKdjRnLytYcU1maU1JUjRRcmpD?=
 =?utf-8?B?UUZDbVZaQlNqZ1Rzd09LU0pkaDBMRUNHWTc2M05DVUVxNTVrUy9XUCs3WXU1?=
 =?utf-8?B?a2NCRkZjYnYxQjZtTU12b0ZYUGdKNUR2WUtJaHJTWkF1NHhVRXhPY0xpYTNM?=
 =?utf-8?B?aW5MRnlZY1RJb3JJOWxkN3pkTVFGdEh6RFdpd3NZNlphMWhzOXJRUWhMenQw?=
 =?utf-8?B?TGhJZ3R1V1d2eDNrRFRybVlFUEZuU0xVcUNwSkhmeVVzSHU1ZnFXNW95UDdo?=
 =?utf-8?B?cEJBYjJpTW1KQ2Vodk5wTG8wV0IrWEEzVklXVUUwWVZrS2s5Yy9lTkQxbnl0?=
 =?utf-8?B?Kzk0ZlA0QlpleFlleWRvVWdpbnRRbDVjR3ZvZU9RQjlvQUZ2SmdlZk5Oa1FN?=
 =?utf-8?B?bURvTC9JcllBTDg1aGtPL0xraGh5UGx3UkprTC9xOURtUXlVNklwaGRzOGpW?=
 =?utf-8?B?Q2NPc3Q3ejNUbGpuMjhLWU1mQVQ1TzAyYmNmUFg0VStIOVRiMUxIek5NbTNI?=
 =?utf-8?Q?ILtKGtwHNUkFIxuKDFbsIIY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce11b4ee-2387-48d6-a92f-08d9b384f70b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 22:09:51.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b81WKstaVFttrsnPkxzEmGjMEW5BmSBeNccAVMgVxLo/Vhf3NIoMcNV+Zw+YZJqszBc7g3Wl+mnpjh6SJw56cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 2:00 AM, kajoljain wrote:
> On 11/23/21 8:55 PM, Kim Phillips wrote:
>> On 11/23/21 2:40 AM, kajoljain wrote:
>>> On 10/8/21 12:47 AM, Kim Phillips wrote:
>>>> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>>>>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>>>>> ---
>>>>>>     tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>>>>     1 file changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>>> index b915840690d4..f8a9cbd99314 100644
>>>>>> --- a/tools/perf/util/evsel.c
>>>>>> +++ b/tools/perf/util/evsel.c
>>>>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>>>>         return ret ? false : true;
>>>>>>     }
>>>>>>     +static bool is_amd(const char *arch, const char *cpuid)
>>>>>> +{
>>>>>> +    return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
>>>>>> "AuthenticAMD");
>>>>>> +}
>>>>>> +
>>>>>> +static bool is_amd_ibs(struct evsel *evsel)
>>>>>> +{
>>>>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>>>>> "ibs", 3);
>>>>>> +}
>>>>>> +
>>>>>>     int evsel__open_strerror(struct evsel *evsel, struct target
>>>>>> *target,
>>>>>>                  int err, char *msg, size_t size)
>>>>>>     {
>>>>>> +    struct perf_env *env = evsel__env(evsel);
>>>>>> +    const char *arch = perf_env__arch(env);
>>>>>> +    const char *cpuid = perf_env__cpuid(env);
>>>>>>         char sbuf[STRERR_BUFSIZE];
>>>>>>         int printed = 0, enforced = 0;
>>>>>>     @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel
>>>>>> *evsel, struct target *target,
>>>>>>                 return scnprintf(msg, size, "wrong clockid (%d).",
>>>>>> clockid);
>>>>>>             if (perf_missing_features.aux_output)
>>>>>>                 return scnprintf(msg, size, "The 'aux_output' feature
>>>>>> is not supported, update the kernel.");
>>>>>> +        if (is_amd(arch, cpuid)) {
>>>>>> +            if (is_amd_ibs(evsel)) {
>>>>>
>>>>> would single 'is_amd_ibs' call be better? checking on both amd and ibs
>>>>
>>>> Good suggestion. If you look at the later patch in the
>>>> BRS series, I have rewritten it to add the new
>>>> AMD PMU like so:
>>>>
>>>>    if (is_amd()) {
>>>>        if (is_amd_ibs()) {
>>>>            if (evsel->this)
>>>>                return
>>>>            if (evsel->that)
>>>>                return
>>>>        }
>>>> +    if (is_amd_brs()) {
>>>> +        if (evsel->this)
>>>> +            return
>>>> +        if (evsel->that)
>>>> +            return
>>>> +    }
>>>>    }
>>>
>>> Hi Kim,
>>>        From my point of view, it won't be a good idea of adding so many
>>> checks in common function definition itself.
>>> Can you just create a check to see if its amd machine and then add a
>>> function call which will handle all four conditions together?
>>>
>>> which is basically for:
>>>
>>> +        if (is_amd(arch, cpuid)) {
>>> +            if (is_amd_ibs(evsel)) {
>>> +                if (evsel->core.attr.exclude_kernel)
>>> +                    return scnprintf(msg, size,
>>> +    "AMD IBS can't exclude kernel events.  Try running at a higher
>>> privilege level.");
>>> +                if (!evsel->core.system_wide)
>>> +                    return scnprintf(msg, size,
>>> +    "AMD IBS may only be available in system-wide/per-cpu mode.  Try
>>> using
>>> -a, or -C and workload affinity");
>>> +            }
>>>
>>> and this:
>>>
>>> +            if (is_amd_brs(evsel)) {
>>> +                if (evsel->core.attr.freq)
>>> +                    return scnprintf(msg, size,
>>> +    "AMD Branch Sampling does not support frequency mode sampling, must
>>> pass a fixed sampling period via -c option or
>>> cpu/branch-brs,period=xxxx/.");
>>> +                /* another reason is that the period is too small */
>>> +                return scnprintf(msg, size,
>>> +    "AMD Branch Sampling does not support sampling period smaller than
>>> what is reported in /sys/devices/cpu/caps/branches.");
>>> +            }
>>
>> IIRC, I tried something like that but carrying the
>>
>>
>> struct target *target, int err, char *msg, size_t size
>>
>> parameters made things worse.
>>
>>> So, incase we are in amd machine,  common function evsel__open_strerror
>>> will call function may be something like amd_evesel_open_strerror_check
>>> which will look for both ibs and brs conditions and return corresponding
>>> error statement.
>>
>> The vast majority of decisions made by evsel__open_strerror are
>> going to be common across most arch/uarches.  AMD has only these
>> two pesky exceptions to the rule and therefore IMO it's ok
>> to have them inline with the common function, since the decisions
>> are so deeply intertwined.  A new amd_evsel_open_strerror_check
>> sounds like it'd duplicate too much of the common function code
>> in order to handle the common error cases.
> 
> Hi Kim,
>     Sorry for the confusion, what I meant by adding new function is just
> to handle these corner error cases and not duplicating whole
> evsel__open_strerror code.
> 
> Maybe something like below code, Its just prototype of code to show you
> the flow, you can refine it and check for any build or indentation
> issues using checkpatch.pl script.
> 
> So basically, in common function we can just have 2 calls, first to
> check if we are in amd system and second to return corresponding error
> message, rather then adding whole chunk of if's which are specific to amd.
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ac0127be0459..adefb162ae08 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2852,9 +2852,40 @@ static bool find_process(const char *name)
>          return ret ? false : true;
>   }
> 
> +static bool is_amd(const char *arch, const char *cpuid)
> +{
> +       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
> "AuthenticAMD");
> +}
> +
> +static int error_amd_ibs_brs(struct evsel *evsel, char *msg, size_t size)
> +{
> +       if (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
> "ibs", 3)) {
> +               if (evsel->core.attr.exclude_kernel)
> +                       return scnprintf(msg, size,
> +       "AMD IBS can't exclude kernel events.  Try running at a higher
> privilege level.");
> +               if (!evsel->core.system_wide)
> +                       return scnprintf(msg, size,
> +       "AMD IBS may only be available in system-wide/per-cpu mode.  Try
> using -a, or -C and workload affinity");
> +       }
> +
> +       if (((evsel->core.attr.config & 0xff) == 0xc4) &&
> (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)) {
> +               if (evsel->core.attr.freq) {
> +                       return scnprintf(msg, size,
> +       "AMD Branch Sampling does not support frequency mode sampling,
> must pass a fixed sampling
> +          period via -c option or cpu/branch-brs,period=xxxx/.");
> +                /* another reason is that the period is too small */
> +               return scnprintf(msg, size,
> +       "AMD Branch Sampling does not support sampling period smaller
> than what is reported in /sys/devices/cpu/caps/branches.");
> +               }
> +       }
> +}
> +
>   int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                           int err, char *msg, size_t size)
>   {
> +       struct perf_env *env = evsel__env(evsel);
> +       const char *arch = perf_env__arch(env);
> +       const char *cpuid = perf_env__cpuid(env);
>          char sbuf[STRERR_BUFSIZE];
>          int printed = 0, enforced = 0;
> 
> @@ -2950,6 +2981,8 @@ int evsel__open_strerror(struct evsel *evsel,
> struct target *target,
>                          return scnprintf(msg, size, "wrong clockid
> (%d).", clockid);
>                  if (perf_missing_features.aux_output)
>                          return scnprintf(msg, size, "The 'aux_output'
> feature is not supported, update the kernel.");
> +               if (is_amd(arch, cpuid))
> +                       return error_amd_ibs_brs(evsel, msg, size);
>                  break;
>          case ENODATA:
>                  return scnprintf(msg, size, "Cannot collect data source
> with the load latency event alone. "

That change will makes AMD machines fail to fall back to the default
"The sys_perf_event_open() syscall returned with..." error string
in case it's not those AMD IBS and BRS sub-conditions.

Is having the AMD error code checking in the main evsel__open_strerror()
so bad?  Other arches and their PMU implementations may find error
conditions that they have in common with AMD's, therefore
opening up the code for opposite types of refactoring and
reuse than what is being requested here.  E.g., I've seen
other hardware configurations - not specific to one architecture -
that could also use this message:

{"AMD IBS"->"%s",pmu_name} may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");

Thanks,

Kim
