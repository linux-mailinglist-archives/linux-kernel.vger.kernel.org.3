Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6E52E451
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbiETFVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbiETFVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:21:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813993702C;
        Thu, 19 May 2022 22:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLqSfX+JDCUbZX1AkfRm/OTMuW6gboS3nRDpaizPPuo1BV0GfWh5YHjQKeW0HShiID2R2jaC0HzWSRd7pbCdiClqMuP6HkLZJ/0Qr4EIr4PuxNdslNJolSO0DTJ0Wi5pI3qCtPnzkCEiIMmzdrGd77PtA66okctEDk0FcGpgiIqkA+pRk09DYNCd649oUFU6f9aDp3dmIhkWxY1AevI3DpqP4U4BYhCG8XPqMhwBEOFu9lUJTDqDaDZi12JQjqagfRiDu2QYV7RoG6Sr+aCLiHKULJiZTArObo65ywAgxy1y6koFuFRD7yzA1sUB77/lhH16i6X1jDMSKRxw2ugCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDnK0O1kqX+oFdKnlaoJ0/5aiyiMCLWhqAt9soEpUxw=;
 b=Zedy9RLNHlZNg3zjIHSmW4ukSOfzux2r6fQQJuLqJ1sVB2k3UHFLnNS8iA/NWQ3Ry/Ks5eyapqppFu98urNx1EkjYT7o42tYAg0bZWByaCXqiYuHXw+DNIGbqicLl2UAUGhdh7yCnI/fUY97nupgwX4uQDyNXvL5k7iKSR9rwHuEH5GpK15BfeJkiZz9R0yM8jxXXxamUtNQAF5qaPzeXY8VJX200ybmUMQdZ8CDCEzS7eKlQGpZViYu8jPcLe3cjRW96Ir53Bt+/z63agiinkkJVKHcaAwdY/ossXERyf/LkJQW4wS+FjMXa7kU0BvokOfshzgb6A1+hC0EZZxo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDnK0O1kqX+oFdKnlaoJ0/5aiyiMCLWhqAt9soEpUxw=;
 b=ldmDqkYV5urB3TMSxZN3s10VAnwL51+1Xw04cuf/faYkgq7tGtKJKtUf56gDkUQjlBwlPUuND9uT/9aTSfXjVFfHaWn2bsW63ZdqEXBTHcc4u4fIJfNHZtDQF1ia8jcDQo7kt+X12rY4nv8m4JAGAidYHgggr4ZTW45vT3CuaUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Fri, 20 May
 2022 05:21:04 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Fri, 20 May 2022
 05:21:04 +0000
Message-ID: <25ebba62-0100-f7af-80fa-556fd6c2e879@amd.com>
Date:   Fri, 20 May 2022 10:50:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220519054355.477-1-ravi.bangoria@amd.com>
 <20220519054355.477-3-ravi.bangoria@amd.com>
 <CAP-5=fXiZj+EBqmg89faK0pZD-Af3V1fHWMOkds1oKoaz+ucFA@mail.gmail.com>
 <e578d274-946f-2c73-026d-9b172ce32f19@amd.com>
 <CAP-5=fXJQcVEUEz3taSXsm0Kd0Fs3Vc4+++vz1fVEHLjB3nMPw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fXJQcVEUEz3taSXsm0Kd0Fs3Vc4+++vz1fVEHLjB3nMPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::34) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07b538de-0d81-4ed9-394b-08da3a2088e1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3090FB97DF1B8F5616C1FBF4E0D39@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /htRR4uhxdSxAz7AL9QgcdRo8bLgR+ZrO+wb4ZfMs7G4cVV73/5XYRY2kmWhf2fLBPTo+9lffjF19J/+BTTdKTYD09GFJHCu8eMb12jaMwzGPfB+KX/WWAT6GO/Hw9VWY8RubYdRahIxGFLTFLdgJ7x9nBc/wKjp/k2toMmEpz7rEH9bdH0GjyZ+/x5g96qkay9bR0QU+FToACdhwzbQ9xQnZSNWM7HLuafQRc6+uPcNC8qB7B7JF37rXrYNYrj0295XA7JLtZqqNc0hv/K/Xe34Vxzhzu6V40Y/Pj//ZoRpqrGeV0IqYEr2OXoLtLY/zCKBxFxBxCAPdsCZjPDZZGnwrs6JNfFpmpOlzw9KKn15Rs5xJUg8SsHee/W2Wl2kz110rF2RVFGXCdd/wxnLPiXxYzTltYyusQ2DjUMW3ocjfNN3qpmVL1v7xr0JPLxiRaStFeSgL0phB64CJK0fJAOWGa+4qrGyjfxXnMaDnIDYZJC8Du0nP/mAKlA/ih8P3X9mVjB6BOuVwwOxToJNm7wzvTfMPGKX65j8kwX69EP8/bGMi84hKW0RJ5Lf5+TpRhMsicPCzHZpo8D38rKOIO4ylvrGfet0FVuwwlNaV3k1rneZEXg0bS60aTsw9Lf3PTQ6e3Alh7dbtSltsn7gT+yin+dCMbjIufvTIOfAz0kSMGTiy97sfe7WxjGPXNsPBBetVHP4Iv9O83R1DrOTSrEULa0sqn1IYOfqJEmeMJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(6486002)(186003)(31686004)(44832011)(7416002)(5660300002)(2906002)(83380400001)(36756003)(53546011)(86362001)(8676002)(2616005)(316002)(66476007)(31696002)(8936002)(66556008)(66946007)(6506007)(26005)(4326008)(6916009)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZNODMyNmlubm92emw2cUsyT2dWWCtkcytpVVV6Y1lyMktpV25KMUpXSzVx?=
 =?utf-8?B?SitEWXY4RFQ3WFBDUWJnd3ZtT2VUa1pGMzJwWDREdXA1MGhtSHRaRGVJVTJG?=
 =?utf-8?B?bFBvL0NmZWZ4SkVOQUc2cVRmcGJhTm9rT1FBTWFzM0gweEFFZHNDLzhiekQ5?=
 =?utf-8?B?ZFMxU284UldYMXZ6WTFDYitGY0hYTTZvZlExbXE3VGgzcHJ4RkpSTktXZVIz?=
 =?utf-8?B?NEJQcWt3ZWQ0c1pjZGljcWZMUFVObUN1NXoySXc4MnErYW14cXZlZlUvQnJF?=
 =?utf-8?B?OFpibElMMFNCVzg1VDEyM0phL0FmeXVXS2Z4VjNMc3piaHdRQlJ5VUUwVHFr?=
 =?utf-8?B?NzVrQThrWjdxd1MycDVuRzEyQk1TWTVpSUt5R0tub2xPaWxWbzdYd1FWbFVW?=
 =?utf-8?B?N2dPSFB5cFF6TVpKQ05FWlo3SHY5RXVSbFpweEV0eCtPVGF1M1VnbUFwa2tC?=
 =?utf-8?B?UFFrWVVzblU5M29vRkJzYVBZZjRoTURvTVp2ZWY3aHVLcVJpYzJVV29QMlp0?=
 =?utf-8?B?ODFnVUFEZlJ0T3pNbnAwbmFyTWsxazRRd2xaSVo2cFNYMlJVSnZqekhqUWZi?=
 =?utf-8?B?ZzQ2cklra0RxQ2F3ZVFUa29wNG1qNmg3dFZXTWFoYWRxZ0RnOEJod3ZqSm1T?=
 =?utf-8?B?RDlNYWtxRmpLVlRsQXRvcG5ZRkJYZDNsQjByOHNKR2NtTkVaVHFGSS9LeEpY?=
 =?utf-8?B?YzA0TGZQR2dVWUw0MmV3ODZ6SFVRRG9VRFloV1FyeC9DZk1KSm0wc1ZVY0hq?=
 =?utf-8?B?OHUvRnByN2xhaU8wcG1aMnAyREU2OERVSmJReXV5ZXNyWTYvalJKQzJGeEpU?=
 =?utf-8?B?MnZFeFVSbVlIY2pHcHRIQlg4cnMzeUVZODI5Z0lBOXUyRWFvWm5veU50aDVV?=
 =?utf-8?B?TUVRWXljRzJDTXBld1FGemtNcW54MjNIaVhiV1lEZWtqL3lMNzZBTHBLMGdV?=
 =?utf-8?B?Zi9vaFNmVUlEUCt3QTVCMWFVYVRacnY0TXdIZ2xDdVVkNzRVamVCQXJMdjVs?=
 =?utf-8?B?WmFZaVBGWFRNdUU2UjMrSjVyNEE3VDNDN3gvc0FFMlBqS2tDYW1IQVZUNDZh?=
 =?utf-8?B?cFlnUEs1QlUrMHB6ak0yeXdrTEpFbkJYUC9tMFNBSHFmRjhCWmtsVGtGU3pE?=
 =?utf-8?B?MVVWU2tTYnBHclJGYXNucFhxTDd5U1BjeWhxbkJGdStrVlZmaUdjcFR0WUhD?=
 =?utf-8?B?Z3p5YTk3R3BUL3ZvWTVSL01taHgxa2FlUE9GaVZRUmJkNnp0b0dpTnQ1S1VL?=
 =?utf-8?B?QlBjZThtT2VhUUpIM1B1M2srbU53UElUVFJKVHlUMFVKaDJkbE5JUzZsVzlt?=
 =?utf-8?B?Y2oyTDY2MVMvWTJXczRJem9MdnZqU0hrOGVDZjQxSk9GQjN4L1hycDhiY25F?=
 =?utf-8?B?eWt0L2N3V3ErWXJxV09BTnRIWWZUVVFqY3ZrSzZUeXN0bGhnRzYzbWhPdkhr?=
 =?utf-8?B?bVk1NUJxSDRvWmR1aDFWOXQzekgxbDN4bW5YM2h5SlBPcXluYW9kelBTQzlY?=
 =?utf-8?B?amFrblNaaDNaVkxMTVRkbG0xYXRVUldCRXFuSS9LcVdYVWZSVnIxMjZCMnhn?=
 =?utf-8?B?VWlKV0hocFdMaEZTZ1VKeGpvZy8yTEViV3dkN3RORmNPRjBFdnlTckJFOGM4?=
 =?utf-8?B?OEFhekRYbUNmU29ZRDE3bmJZRzdsZWxjU3dLZTdpb3RyMU0rZVhRYWRWSzNZ?=
 =?utf-8?B?Wis0RnRaVDJmTDNiS1ZmUkJZU3VOS04wNUkwWGZPTGZVQ0FEZjRnSW9VZy95?=
 =?utf-8?B?Y29jOXVHYlZzelQ2b1hUVW5kNmNzdkxPQk9wbC80YkRVZUh5SER4MlZyOFJP?=
 =?utf-8?B?YWR2WEEzc1ZxLytRQ3lZejQrRThhRXdDMU1LanhlbmxFQzVJbjY3aU1yR216?=
 =?utf-8?B?dDNpNTBQT2FORm9OTFpZek5Ya05kZ3BhVXBLWktveVd1SmdZQTNxRDJXRVhp?=
 =?utf-8?B?VE05eDVPQUM3WStzNFQvdFlaOUkzOGFLNzhmYkwySVJ2bXF3d2dvZ2xDT3A1?=
 =?utf-8?B?dERuNVRjVTF6Wnk0MHI3ZnppWGlMdlBITEExUndYUWtvMXpPMjlWeDY3ZnNO?=
 =?utf-8?B?SXUyMkNwb0M4V05HU1NvVHU1WTJpd2JOcFRnNzRvVTRvbWhxb3RxbWd0VFVG?=
 =?utf-8?B?TWxETkpOeHRmSXNHVnk3UUcyNlpUaThNZzlRWFR5YzRLT0o0aStuZHE1ZkdH?=
 =?utf-8?B?VTZ3QUtpZThjVkEwVG81L3JkZTdRak9pQTBvcFcvbzIyYTdDVEJCa1JUQTVv?=
 =?utf-8?B?akcyYnZFYTNhc2RWK2ZqVWo0bC9wL3RqWm5RV3lmV0hFMUNzaVdhVkFVN2px?=
 =?utf-8?B?bWFYQ3V0bEROak1oOWswd1M5Tlo0R3JCU0l4TTloTGdCcUxCLzRVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b538de-0d81-4ed9-394b-08da3a2088e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 05:21:04.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql2SFX2fVFBIjdo68L4tQUGD9k+73Yhzf9OMU6YL4wK0y0HHKyyNoFmSvCa+Hjn8De3qMMPlkwUGtwx9sGWynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-May-22 10:01 AM, Ian Rogers wrote:
> On Thu, May 19, 2022 at 8:49 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Hi Ian,
>>
>> On 20-May-22 3:57 AM, Ian Rogers wrote:
>>> On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>
>>>> Pmus advertise their capabilities via sysfs attribute files but
>>>> perf tool currently parses only core(cpu) pmu capabilities. Add
>>>> support for parsing non-cpu pmu capabilities.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>> ---
>>>>  .../Documentation/perf.data-file-format.txt   |  18 ++
>>>>  tools/perf/util/env.c                         |  48 +++++
>>>>  tools/perf/util/env.h                         |  11 +
>>>>  tools/perf/util/header.c                      | 198 ++++++++++++++++++
>>>>  tools/perf/util/header.h                      |   1 +
>>>>  tools/perf/util/pmu.c                         |  15 +-
>>>>  tools/perf/util/pmu.h                         |   2 +
>>>>  7 files changed, 289 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>>>> index f56d0e0fbff6..7f8341db9134 100644
>>>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>>>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>>>> @@ -435,6 +435,24 @@ struct {
>>>>         } [nr_pmu];
>>>>  };
>>>>
>>>> +       HEADER_PMU_CAPS = 32,
>>>> +
>>>> +       List of pmu capabilities (except cpu pmu which is already
>>>> +       covered by HEADER_CPU_PMU_CAPS)
>>>
>>> Sorry for the ignorance, is this currently broken for hybrid then?
>>> Will hybrid have a HEADER_CPU_PMU_CAPS? Presumably this varies between
>>> ARM's big.little and Alderlake.
>>
>> It's covered by HEADER_HYBRID_CPU_PMU_CAPS, but that too covers only
>> cpu pmu. I think I should update the above comment to:
>>
>>         List of pmu capabilities (except cpu pmu which is already
>>         covered by HEADER_CPU_PMU_CAPS / HEADER_HYBRID_CPU_PMU_CAPS)
>>
>>>> +
>>>> +struct {
>>>> +       u32 nr_pmus;
>>>> +       struct {
>>>> +               u32 core_type;  /* For hybrid topology */
>>>
>>> Could this be pmu_type as presumably we can have capabilities on any
>>> kind of PMU?
>>
>> Not sure I follow that question but let me just put my thoughts here.
>>
>> {core_type, pmu_name} is the unique key here. Considering a hypothetical
>> scenario: A system has two types of cores P-core and E-core. Certain pmu
>> inside P-core has some capabilities which are missing in the identical
>> pmu belonging to E-core. The header will look something like:
>>
>> struct {
>>         .nr_pmus = 2,
>>         [0] = struct {
>>                 .core_type = 0, /* P-core */
>>                 .pmu_name = xyz_pmu,
>>                 .nr_caps = 2,
>>                 [0] = { .name = cap1, .value = value1 },
>>                 [1] = { .name = cap2, .value = value2 },
>>         },
>>         [1] = struct {
>>                 .core_type = 1; /* E-core */
>>                 .pmu_name = xyz_pmu;
>>                 .nr_caps = 1;
>>                 [0] = { .name = cap1, .value = value1 };
>>         },
>> };
>>
>> Does that answer your question?
>>
>> Thanks for the review,
>> Ravi
> 
> I may be being a little ahead of the current code as I'm wondering
> about heterogeneous systems with many non-CPU PMUs. It seems such a
> scenario just wouldn't touch the core_type field here. Could the p or
> e core-ness of a PMU be implied by the name?

Using just pmu_name to identify the type of core it belongs to; yeah
that might work assuming perf_pmu_register() doesn't allow registering
multiple pmus with the same name. I'll remove 'core_type'.

> Is there something similar to core_type in sysfs

I don't think so. I don't have any Intel ADL or ARM big.LITTLE system
to try. But that's not required now.

Thanks,
Ravi
