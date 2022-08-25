Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD45A0ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiHYLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiHYLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:17:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB165AEDA3;
        Thu, 25 Aug 2022 04:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd8xmBju6LEOKqAgJE6e22KMNX16a9IqLn8XE8xhIT3PK7Dhq7A1MmjrBCk7Si6vupSuBRMr6I83CCyxa6CstCyJ637pNatpdnkZFvA/6RE1kZQb6Y3C3vbG50FGF8iXONrEblZarw0BuQMLmCuvjDBlKf4qqFCdND19ZeoLO1sTrWNiDPg3G7T4f9QeY/MT3Q2jom6lyngqacrRd01KfpQ6s2GDWc1RsfqnMTqpWOs+c3395cYEJqmrWi9UZVQ8KHE8JTfk3LYhT4iYxCxg7zLN+03mlr/KNjHbmqNrg56L+liElia06SEbB4s21f8YtyE0b547NO6MKl1JtGcSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7QokkOoIZIpBbXeRc1vNU6nfMbPwOSg3FK4e9ELsvs=;
 b=CPFbmC/78QjbhDg25+fcs7gU9TrXRhGx67vlt3xHQsoyCwmcJMtnxystmco918WD7sts7ohr3611mSQ3uywoCbiEfR3mYV8Te1OlRTdDz3jremT05nCQ9yOJ29+DO68/w9x7XnL5DPUm2+bG71ZsijfOI9kD/jzqDf+mAoPNYLwjm+J2OvQxJjfC740dJwagsBvI+Y89E6h2oCLmrd9G8WnTbSv1J/buhXe0itkiqV4VZbXFQN9mYx3Jo7xP78RDfAWrdnQJ5efoYuE2nxI4NJDkG6aL58B5zWFN1abtrl42i0Mcc9OSe0snKgDTv8YdiuOqaqc1eaWM2EpG51LjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7QokkOoIZIpBbXeRc1vNU6nfMbPwOSg3FK4e9ELsvs=;
 b=UfqzBxu4Hjj9XWaYnZRClGkHcXdZ7pOdc1x+yE/FsFo5u+08YTenr3ISEVX+n4/m6C0yfTSmdJpFxkv+z69h6RJaVXc7/kZVZW8UUIUJXiSc9FIHnZtvA6crmuxI14QRAo6lPKRtO5f9dJpXMI+vI2GpwQAG7UZmTkCr0socmUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 11:17:03 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::6958:4b1d:7283:edbd%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 11:17:03 +0000
Message-ID: <0ec741c0-2399-97e7-2f00-12cb38dbfe4f@amd.com>
Date:   Thu, 25 Aug 2022 16:46:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 00/14] perf mem/c2c: Add support for AMD
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com,
        ravi.bangoria@amd.com
References: <20220616113638.900-1-ravi.bangoria@amd.com>
 <Ys1cfZgL4TyWazRm@krava> <YtV9kwfulEVWuaXR@kernel.org>
 <CA+JHD91X9_dMV-sXho_L9k326-Eneor4ZeOtw_WgWNtHbKzWxg@mail.gmail.com>
 <ef9034a6-c4b2-ff82-a56c-bd7df2d10884@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ef9034a6-c4b2-ff82-a56c-bd7df2d10884@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b315a0b8-57d9-4a15-1f24-08da868b5615
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08I9r8KiyzXh6ZwlDtnq5y5X362OX9cLK1t8A7yEJ0tkbusf1ElzQNo0Gx20BU5fh7QVOYkgtnj/y0xmcaQtF5LRsUch2sfn0772skDuTff+ns2F4T8zLP0QYmq6e2cybD7z+8PYfnCeytkPe9xWa9mox6fOWSas6zLacXBapljzeUIr/6gstFDl7MltgizSWy/HqUxqtelOW34xtmb2fuVl+7P52SPubtbIm45gAxi9rvql6R77BJqBhg6hIfUH+sADFLMQ9OVzpqZ0PDsE7JTzTasYFTfCnvvhVoCOuNWgJSeWNO2ibQb5Jxu2/+d34tw+8otcUJ5T4NVGqqe5zpTXnc63ZN8HKuAVoQoKsSy7LI0UGTQIWb0dNrowkCPNPiGfRHQTjY+W2oTbpyvJamfGwOgOLtV3RcTIYg/Ywa8wvoCHeUwdOiRVPEjIh6QxBJq8mXP3UgJdb7yLL1BXh+NCpGL5BkUIKSGMD7pOb4ZzNqOnxcZrqr9OMrZZhJyxrT1R+4Vl5RE6Wx03fhfFVrKcUoOQ6WitjadFQ+ryaFUeIahHsrq7ZI0yWJnTz2CjI/mtVLpTM6K1AF1ffI6+mrbw8FANOn+WknrMVTJrkNA5VJv1WhjTV+mkv1LWtYRQapRtaI5tSK2WDb57joptm56em5tnMUSztLLLmwnV/VHUN7riKzAMUHgdqThVip1acReUG9iRgizfgRFHAByujxb3YxDUuTUKAkDNB+jbouGg3C6TJE7HAGANBl3jcN5sbkaM/VSKsF50OHUNA2vPT0+yTdWcxMS44llf3Szv+ybObGOsMlI/SGE2ssR+VYJ5incv5HGLeZ0BHuWCSY74ZwG6ghvBzldL7thrIPS0uuO0WY+opB5wFtiSMFJiz+k7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(6666004)(66556008)(6486002)(26005)(478600001)(41300700001)(6506007)(53546011)(186003)(6512007)(2616005)(966005)(5660300002)(8936002)(44832011)(6916009)(54906003)(83380400001)(4326008)(66476007)(8676002)(66946007)(38100700002)(2906002)(31686004)(31696002)(86362001)(316002)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJ6eHVKQThyRGx5c1BPcjkrNjdIVTA5UmJ2TTczcFZHaVlNWmIyS2ZNRW1a?=
 =?utf-8?B?L2FrbG9vK2FjN1dWb1pjdGlIdlBxTTcyamdCMVFBeHFqS2pSRkxpOXpwY3ZX?=
 =?utf-8?B?K0lCVEdsNHFNL2VISVo3TVNpOTlxWnYydmJWaWNpbkw1V2pFNUNSZ3ZnMVNp?=
 =?utf-8?B?WGc1SlhRZjlzU1VnRmRZTzE2b2FjSGRTcSs4UmhNa0swNEk2U1JPUnExdzB2?=
 =?utf-8?B?dk1OL3FlZFZwUHNocEtCaStsY1FpUlpiSTUwcFpYbmRmYXQvV1dKQ25jTWhh?=
 =?utf-8?B?bE5GT01PRE5kcWJoTkY5T1ZoaFVIQkRoVVNkUEsvV2EvaHNIdmI0WWYxdzhq?=
 =?utf-8?B?RlJtbWVybWkzUkhvV2k1YUlJSEJWY2V5SHlsK1lHc1hoVTRRMjVDMFhBcCtC?=
 =?utf-8?B?UDVWVk05cFNDVnV4RUIrRityYmZaVG1oUEZxNHdIS3lFZ3pKR09Nd2p2bWtj?=
 =?utf-8?B?WU9PMzIwVW0vVHRhbkdWcGY2R2dUZ0l1ZmpNVm9tb0I3NWNhYjhwU3VlT0xE?=
 =?utf-8?B?SGJWWlRVNUVwZWVuUUlZaVgxVURVYUptU0M2TFh5TVhES0lHUTY4WkJFTE9X?=
 =?utf-8?B?emxCOE5uN2tPVDZON0RFMUI5KzBZbHZ4UEY5YmVmSUlRY1dwaHFvcjk5RDh6?=
 =?utf-8?B?emJMMWVicm1yWTNXNFpPQ29ySmMxV0paZHV6QTAyNlJFSXBRa0RZNGdhM3A2?=
 =?utf-8?B?dFlUTWhobU1JZ2FDR1FScnVTU0kvYUNyVzB3RjdwWkhJOE9ZeGdOc2MrVHFo?=
 =?utf-8?B?Ry9YZm13MkxWL1dLV3dxN0J1TU9jaUpBNmd4ZTRyWHp0bXJhWkt6Vk13bDg1?=
 =?utf-8?B?dHdCZi9aWHhJOWdtbU1Famk5YzlJSjMyaTRIaEpia1ZJZUFVdytnRlBUZzhN?=
 =?utf-8?B?N3l1ekUvbS9GSnNzTDN3QzF4MWFNSEc3NlZBUkYrL2hCajJUOXhpcG1kSGx5?=
 =?utf-8?B?YUtJOHh1WWlBR0Vacnh6N05zWFRPUG5YY05SSytvSkV6NmhSbWt6dlB1YjEy?=
 =?utf-8?B?Sk1UNDVuYUxuQ3N6dW8yL3JoSmFpdzArV3d3ekhQWi8yUlNjaTkxQzVkSDdH?=
 =?utf-8?B?dkRLaUEwRGhtdmFnVGlRckVVNXhiT1JHWmpra1B3ZTRrSm9od3FlVTAxWnk5?=
 =?utf-8?B?cDVlZlFUSGMxdGk1VmR0NmJjZUVZL3NDMFoycVZBYzF3eW1aWEdlRDNya0Nw?=
 =?utf-8?B?M2thVnFkWDJMNzhMWTluWjRZNWhoMHZQenBEN3VrbkhqWHFqTHJxSElwWlZC?=
 =?utf-8?B?Z2VHU0tqTnM3N005S1NHREVMMFZYak9TalVpS3UrRThvaUpUN1k1Q1J0SFAx?=
 =?utf-8?B?RitNVWdaMnFEdjFLQ1RyVDJXUU5wTG5wQmVPNEVNZXNXeitmVm1VM3lBd1M0?=
 =?utf-8?B?bXY3c0FicU5zeHM1UGJMTU9nZmphdUI4QkpxVW96Y3dEQXJDOEZHc1pwU1Vx?=
 =?utf-8?B?aUdNNklMQXlpOGY2UVhoTlgraVh1R1NHaEpOeFhlRjYyZ3RBZlQ3YitDWWVs?=
 =?utf-8?B?dGpVaEwrUHpybWE0VVRMZ3VUUlNQc1ZJdCs5M3lLR0hHTi9iWUJaeEdvaVl4?=
 =?utf-8?B?U0gwd245SGRqMlpOVGxjUktvb1k5OC9uanE1QXJYeVpCY0JuU0haVWZkNTBO?=
 =?utf-8?B?bmpRWklnTER5TGNETDNyVnRVNk5yUFNQWGtkWjFjSW5WcElTTi9iMUFZT3lZ?=
 =?utf-8?B?NlduYytpdW9uclpxRGRnQTRXdkozMU5hZ0NQQWFkaURMNERYMW14SG1mSEdt?=
 =?utf-8?B?Y2FrRnZ4WWkwNDZsN202MVFXdUsyOTRDZ2xqUFpiWUZIZDdTdjR5QzZxVHhY?=
 =?utf-8?B?ZWZiOWFsdnEySFF0T25wdnY3MytWYVJTMkZ3NlJ6ejhxbDh4L3hKZFVhN2FK?=
 =?utf-8?B?cTFFQ1o2MHYxa1ZKV3BpMi9PbnpkZktBbjlqbndxY2R2bkhjNGhZWVNXa2xp?=
 =?utf-8?B?QVY5TkRVTmFIbm5Sd3pTY1hrb2l6UWFtVzBwWHpiaXpiZEMyOUMrekRuZEp0?=
 =?utf-8?B?bVJRRkEvcWFZUzZFOTFNR1JDeGFVQkdTQ0FTM0FDSlAxcEh5TlRVMldCUDFI?=
 =?utf-8?B?M0J2K3ZBL3NDcGJ0YzVXc0ZOOHg1aWxMRFAzTG5jSVZ0Q01TQnJMc1VXMk5s?=
 =?utf-8?Q?yJCyWGTykJoIQhM/tNoLCVh21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b315a0b8-57d9-4a15-1f24-08da868b5615
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 11:17:03.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me3NT8uhtpu7UQAZh/r5d9AF8YTGKoXeOAX8nY8j3hFKI98iOrBT4VcImMNPRBU3PblY1h4GApEvonD/0fGRZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jul-22 7:51 AM, Ravi Bangoria wrote:
> On 21-Jul-22 10:54 PM, Arnaldo Carvalho de Melo wrote:
>> Ping.
>>
>> On Mon, Jul 18, 2022, 12:34 PM Arnaldo Carvalho de Melo <
>> arnaldo.melo@gmail.com> wrote:
>>
>>> Em Tue, Jul 12, 2022 at 01:35:25PM +0200, Jiri Olsa escreveu:
>>>> On Thu, Jun 16, 2022 at 05:06:23PM +0530, Ravi Bangoria wrote:
>>>>> Perf mem and c2c tools are wrappers around perf record with mem load/
>>>>> store events. IBS tagged load/store sample provides most of the
>>>>> information needed for these tools. Enable support for these tools on
>>>>> AMD Zen processors based on IBS Op pmu.
>>>>>
>>>>> There are some limitations though: Only load/store instructions provide
>>>>> mem/c2c information. However, IBS does not provide a way to choose a
>>>>> particular type of instruction to tag. This results in many non-LS
>>>>> instructions being tagged which appear as N/A. IBS, being an uncore pmu
>>>>> from kernel point of view[1], does not support per process monitoring.
>>>>> Thus, perf mem/c2c on AMD are currently supported in per-cpu mode only.
>>>>>
>>>>> Example:
>>>>>   $ sudo ./perf mem record -- -c 10000
>>>>>   ^C[ perf record: Woken up 227 times to write data ]
>>>>>   [ perf record: Captured and wrote 58.760 MB perf.data (836978
>>> samples) ]
>>>>>
>>>>>   $ sudo ./perf mem report -F mem,sample,snoop
>>>>>   Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
>>>>>   Memory access                  Samples  Snoop
>>>>>   N/A                             700620  N/A
>>>>>   L1 hit                          126675  N/A
>>>>>   L2 hit                             424  N/A
>>>>>   L3 hit                             664  HitM
>>>>>   L3 hit                              10  N/A
>>>>>   Local RAM hit                        2  N/A
>>>>>   Remote RAM (1 hop) hit            8558  N/A
>>>>>   Remote Cache (1 hop) hit             3  N/A
>>>>>   Remote Cache (1 hop) hit             2  HitM
>>>>>   Remote Cache (2 hops) hit            10  HitM
>>>>>   Remote Cache (2 hops) hit             6  N/A
>>>>>   Uncached hit                         4  N/A
>>>>>
>>>>> Prepared on amd/perf/core (9886142c7a22) + IBS Zen4 enhancement
>>> patches[2]
>>>>>
>>>>> [1]:
>>> https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com
>>>>> [2]:
>>> https://lore.kernel.org/lkml/20220604044519.594-1-ravi.bangoria@amd.com
>>>>>
>>>>> v1:
>>> https://lore.kernel.org/lkml/20220525093938.4101-1-ravi.bangoria@amd.com
>>>>> v1->v2:
>>>>>  - Instead of defining macros to extract IBS register bits, use
>>> existing
>>>>>    bitfield definitions. Zen4 has introduced additional set of bits in
>>>>>    IBS registers which this series also exploits and thus this series
>>>>>    now depends on IBS Zen4 enhancement patchset.
>>>>>  - Add support for PERF_SAMPLE_WEIGHT_STRUCT. While opening a new
>>> event,
>>>>>    perf tool starts with a set of attributes and goes on reverting some
>>>>>    attributes in a predefined order until it succeeds or run out or all
>>>>>    attempts. Here, 1st attempt includes WEIGHT_STRUCT and exclude_guest
>>>>>    which always fails because IBS does not support guest filtering. The
>>>>>    problem however is, perf reverts WEIGHT_STRUCT but keeps trying with
>>>>>    exclude_guest. Thus, although, this series enables WEIGHT_STRUCT
>>>>>    support from kernel, using it from the perf tool need more changes.
>>>>>    I'll try to address this bug later.
>>>>>  - Introduce __PERF_SAMPLE_CALLCHAIN_EARLY to hint generic perf driver
>>>>>    that physical address is set by arch pmu driver and should not be
>>>>>    overwritten.
>>>>>
>>>>>
>>>>> Ravi Bangoria (14):
>>>>>   perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
>>>>>   perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
>>>>>   perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
>>>>>   perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
>>>>>   perf/x86/amd: Support PERF_SAMPLE_ADDR
>>>>>   perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
>>>>>   perf tool: Sync include/uapi/linux/perf_event.h header
>>>>>   perf tool: Sync arch/x86/include/asm/amd-ibs.h header
>>>>>   perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
>>>>>   perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
>>>>>   perf mem/c2c: Add load store event mappings for AMD
>>>>>   perf mem/c2c: Avoid printing empty lines for unsupported events
>>>>>   perf mem: Use more generic term for LFB
>>>>>   perf script: Add missing fields in usage hint
>>>>
>>>> tools part looks good to me
>>>>
>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>> What about the kernel bits? PeterZ? Is this in some tip branch?
> 
> Peter, Would you able to pick this up for next merge window? Please
> note that, one dependency patch needs to be applied first from "IBS
> Zen4 enhancement" series:
> 
> [PATCH v6 6/8] perf/x86/ibs: Add new IBS register bits into header
> https://lore.kernel.org/lkml/20220604044519.594-7-ravi.bangoria@amd.com

Peter, can you please pull this series. (Dependency patch is already
picked up by Boris.)

Thanks,
Ravi
