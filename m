Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C55285C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiEPNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiEPNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:47:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02E39147;
        Mon, 16 May 2022 06:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJTdgYgZSK0L6I2Kx2tcwR13p4KzsCjWwCqbZIu57PvmyCGpL8yCbJGIyrJwcbr629gB9TvuDYqBexjRsxmBNH7XBXX9tdbi1uaoo9CQ/bIJ/krdiSzx/eQ5R7o7I4zhMCDwEu8OObL/XnQqSNN5y579X303zNepqNTs3IsHRtcCN3zSIdC19lgcnZjgERshEShS5dgrl0drLH9O6bcHyMxQMM3TikB7EhCKKt08cDPSQJMf4B1cAz0DyA2T+dEPbi4ninQgSUlAmdNLxMWiyu2QlSVq1vPpvHUEiAvjEmABILZT05Y3gTHScz0sVJGEr0aQTuGZAEKvZj+3gQlrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7qNjebse6P5BzKldTYnuz8tySSf5O/q6nkmyVJIRik=;
 b=Xy4xid83UACAnRMNdTjsH5M1hC5g8BZksPJBnZV//74N/bFT9cawc9SMGxsxn5SLzPWNO8pU4DriPLdmM47E2qJufpYcD8UUskD4KgWuAA0+S7hi+r4gMWrOJuYOIAjtR7nwv3u+PMjMQoS/Y98xre0C7Kjg5Y2IdpNhBryoqv0OfEbEfJ1mrd8DCFojOTo8pQaSU9x61ZfiM2xYOZPBc7Cvd1ml9QFNiHoh9piBkvnhwyxJalBNuhG6Roq7c+rbF7L05cUalhue/O27aFPM6PELzr5PwUFcyYRYJ3LT7iBvaEa7N/689iz3av7bT9K+CGAkzjBdaWXp2KkN2JkPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7qNjebse6P5BzKldTYnuz8tySSf5O/q6nkmyVJIRik=;
 b=cSCUwVDR2wrv5VSHSLw7JmomPJmFavm0soNJuyACr104eK3oV2STTdEaguwx/ciDesZcSMuSMfnvE216VVO8c8XLaT8eGhAlbLbMamQmcU9Zg1XXhLrfqm5wTIX9CfuKYaUNpKTiRrwmMfuU2xHssLTnNMk8kg3L5j3Z04DBwyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 16 May
 2022 13:47:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Mon, 16 May 2022
 13:47:19 +0000
Message-ID: <d32c3898-523a-8b64-fa95-4f59a5f2fca6@amd.com>
Date:   Mon, 16 May 2022 19:16:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 6/8] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-7-ravi.bangoria@amd.com> <YoJRYI2P0EEnhZXv@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YoJRYI2P0EEnhZXv@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e19a064-8d51-41f8-3f7f-08da3742983c
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB6657B93901DCB4329CCB08FDE0CF9@PH7PR12MB6657.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nMilAlSy5bsM8ezDCYKyxWfQrRSVKlQbs4M8Sm9PqP2ne8oo8c2HKnHgXNyFoyG6KUG8PKuY3inH6N2BxlExgAvGTB5hcPCClsS43m7eJvrLQU0Vyaar5Eo6FtUfXc7SF8RkRSXaZGPbLAB65c1X320KVAXmKM/jV6L9S+N8YsyAl5EDdb024hHCdl0lFDusSxnw3mBXvbslTvkbYlSmW1I2PfjlSn7FP4LPMo7r4OiBaeZxdlL3boUjWezSoH7DY42Ub9Mla8Txxnc9hKrb24qTivxV93e8WNmUuWZG/39438ogrKmKUlsr+77T99kcGFB09QhzdQXmOPfvAFXegA7KYzMESrdsyjo7TqK3rnQJ/NzszDQnWfPy+KnAHr8mZ5n74hj+6TNfsOtD8BPb4lkNsnkXPwitIbuK6Z8k9wZ6csxVOz13ceLIUlc5ZBBPs1zR1gBqAO00/COhKm/7qedMKdLoK9wGtOLBmgHaKd0X1geVHnCZtD/q/Tm5Q369LhGduFpCm8dw4KjjAHwCcC7NFpmV3pDMkb1S5dro2W24Pwhp1u5Pio44L5cDEqq2v/lecOlk/qnkov9lXyLFkGy6YftV4DB+ZifM60+4JFy+VlxTmM+kwiG0drAkku+gP02WgvLwnNb7rIdbva974sbBMSlGmk6jR7ckGjpHIy1nhdYDdfyq/CuuMKpXd8ubfQccHfv2lVP8hE1XVDSzjAFlpTwxCfFP2vaXjU1fmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(26005)(2616005)(6916009)(4326008)(31686004)(6512007)(6666004)(8676002)(66946007)(36756003)(186003)(83380400001)(66476007)(2906002)(8936002)(53546011)(86362001)(6506007)(31696002)(5660300002)(7416002)(6486002)(508600001)(316002)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFjZExPcXVxb3VRblBhbXUrY0pSMmpvZWE2cG5vQTFoVkZnQWZyVitZaWZM?=
 =?utf-8?B?RHAzUk5JK3ZqTnQvWVUyNWRUV1lzcDE5YmRZK2JiSUVxcFAzbFI5R0l4MTdq?=
 =?utf-8?B?R2YwaHdMWFZERi9LZTFSL0xubDMyUk1FNkoxaU5IcDdrOWNSMVY0N2F3TFpl?=
 =?utf-8?B?UURmOEVOeVBaNkV0QkZLWklJdC9tNTFTWGs4dW9vZVVzVlNvVXUyRlV2Q09J?=
 =?utf-8?B?NE92N25VczE4cXFpUGh3dVNhS1FXRmFxWW9kU1ZYQTkwYzlNVXNwUi8zWWNM?=
 =?utf-8?B?UHVtcWxjVDkwN2lJM0FTSGtrdHNiUnhabkJzajRKWE1IV0xaekNxRjgwc0N6?=
 =?utf-8?B?U2k5Wm9Za21GNmNSSVlsU0FCRWRyYlVpaTQrQjltaSt6VFhTL3dlTFNwUUpP?=
 =?utf-8?B?Z3ZaM0FrUVFOQmFPM2tmQU52ZzcvajV3WlZNY3JIYmhZcStkTXdBWUs3NEF1?=
 =?utf-8?B?d1Yrc3QzQThNcWkwcWVKaXZZdHp1anpVRjBMNUV0aTR1SUt4Ync4elcxcnVs?=
 =?utf-8?B?RnJBZncvc1VJQ3hWU3FHS000SFFDTnl3R2dBc2kzTG4zVGRpVWNhaWFYWERL?=
 =?utf-8?B?ZFl2YlpXY1lCSWYwMG5LcEpuejRiR1l0RGxjTXRiSmtXd0ZmZklybWIvQVho?=
 =?utf-8?B?T1hPZFhYS3Zsc00wcnZFeGFMc0Y4V0NYSktIZTlndm9wc3pUdzVMZUxZLzNl?=
 =?utf-8?B?MHFXSU9LYko3cXByMHNCMnh2Y3RNYzg4OTEzb0JDZWNkWnRlN3M3eUIyUUpQ?=
 =?utf-8?B?Wi84TTUxWXRHanVSa3pxc09QL1laOXNWZThwOGVtYlJtVHByWHJXR2hDaGFo?=
 =?utf-8?B?L251M3RMOGE1cXNpRkthTFdiWCs4eWU5UFlKOEdXR1JjYVVlVFJkak9RZUxW?=
 =?utf-8?B?b0lLT0FZSmVHaHFINDUvRmU1UjhNVXUzbENkZEJnMUlKMWdMK04yQ0Q0RElU?=
 =?utf-8?B?MnRkMm9tOWg0T2F1dHlQSkRzQk9SUXM1K1AydXo3TTdMei9ETUF6S3VnUjlT?=
 =?utf-8?B?bnFGTU5rNFBEc3paVm1xaTF2L3QzeVFaMWZDR3FIUEM5NC9Ga1YrSXY2c0RE?=
 =?utf-8?B?Yk5pWm5PUUxqVWVtdmlCTUpHU2VkQ3AzTDBrNVF0ZElHamJtclFsbFM2UUdm?=
 =?utf-8?B?T3JmcjFiQXg0UCtQTW81OTdhL0JWN3IwVDh5bHJ4NThGK21CcjkwSHp3K0VM?=
 =?utf-8?B?dVQ5bGRRN2RqdDBzSkd5c3lndU9nRGY3bGJnWml5ZG1WZU9UYmtmNTk4dXo0?=
 =?utf-8?B?MWpaQ0FGU21YQ0Y0Q1pYRENRRHVlQVhEUVR4T0ErZGFIOTBVd0pkbE1Jcjdh?=
 =?utf-8?B?VlplWmNQSlE4cDFwOUU2Qk8yc1lPYlF1bTVnU0JUdlRsNk4vV0o1SE1qaENs?=
 =?utf-8?B?VnBqdUZKWlQ2R3owaVJQMlVyUkVleG85VDEzd2QrMWNoQ0RycGtsbEQ0ZWE5?=
 =?utf-8?B?TWpLWVVhU0pjQTg5Nm5RbGVNbXhwMnhTT2NkWmNMdC9USjRGQ1FvS1dyT0cx?=
 =?utf-8?B?VzZTTXJjV1crLytyYkdJZTZmUktYVHFBSFZVekQ2RS9MUEY2OTZHSmdIRGl1?=
 =?utf-8?B?M2Q0M0lZaGRJSVRhN0JURUZpemNjTERrcUV6c0pOMzRMQUdxRXh0SGZuaHJa?=
 =?utf-8?B?dm5oUmYveS9PZ09jMjg0S29uNmlFeVJKeXo4UVBvU3VmVWp5UTJONTRjNGRr?=
 =?utf-8?B?ZEhqNDJjQnNNbWRQLzN1VjhzWFZpYTJoT25nanFPaHdQUzQ0elU3QlNteXZh?=
 =?utf-8?B?UzlBbVNGNkUxOHNlNnpKalM1QUExcXpkM1pkTWRRdDJYZHgxcWZ1bGM5LzFV?=
 =?utf-8?B?RVBpZmt3S2tlYWZJODFuNGt6cGdCQ2x0eEJhemQrbzB0dEI4L01rOWtkMWZo?=
 =?utf-8?B?Y2pYY0NJMkt0aWY4VFZZa1J0QmhPL21ZY3ZpcFdKUmRLajBSLzVXUFFCNExa?=
 =?utf-8?B?UnpMMlpMcXdhMmFiK2ZPMUdJYVBjWnV0U2dQeDZ4MHdqWlNyTHZzQmVuV2Nr?=
 =?utf-8?B?MzhOYWROeXpQa0FETG05UDMvL0IrczFlbE5TdUNNQ1BHVGk2KzNqREV6VkNR?=
 =?utf-8?B?WE80TmFrNDA0KzBkZWRrdGVvbWN1TmIrWStwZkgvaXUxVE0xMmJxd2lOUnZz?=
 =?utf-8?B?RGNjUFZUVXM4Y2VLb1ByZXh5bTBab25hdkRkNng0d2RDNW8ybllHNVlCL1ln?=
 =?utf-8?B?OFBCZzJjVks0Qklma2ozQ3VRRW5GbG5IQnhRUk5RZG1jeTNTVnlFbmIvWkxU?=
 =?utf-8?B?K1I4Z0FDakl2VHdxdncyQnhTSXYvdlBxTXpqRjBjOFgxTkREam9ZQnBoTXFD?=
 =?utf-8?B?djU1UkJjazlhTmUwWk5pR0FwZVNORm5uUk1hWk1lM09xRXpGdGRqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e19a064-8d51-41f8-3f7f-08da3742983c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:47:19.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9+Vb9wF8YcArFDyBhKyaqF9cmkLHJIgXcJcBOgRyTgtDfYECTYtLeO199bllJu40y8ChwZVm+mS8/kYLwoQxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-May-22 6:58 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 09, 2022 at 10:19:12AM +0530, Ravi Bangoria escreveu:
>> Pmus advertise their capabilities via sysfs attribute files but
>> perf tool currently parses only core(cpu) pmu capabilities. Add
>> support for parsing non-cpu pmu capabilities.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  .../Documentation/perf.data-file-format.txt   |  18 ++
>>  tools/perf/util/env.c                         |  48 +++-
>>  tools/perf/util/env.h                         |  11 +
>>  tools/perf/util/header.c                      | 211 ++++++++++++++++++
>>  tools/perf/util/header.h                      |   1 +
>>  tools/perf/util/pmu.c                         |  15 +-
>>  tools/perf/util/pmu.h                         |   2 +
>>  7 files changed, 301 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index f56d0e0fbff6..dea3acb36558 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -435,6 +435,24 @@ struct {
>>  	} [nr_pmu];
>>  };
>>  
>> +	HEADER_PMU_CAPS = 32,
>> +
>> +	List of pmu capabilities (except cpu pmu which is already
>> +	covered by HEADER_CPU_PMU_CAPS)
>> +
>> +struct {
>> +	u32 nr_pmus;
>> +	struct {
>> +		u8 core_type;	/* For hybrid topology */
> 
> Humm, I'd say use u32 here and..
> 
>> +		char pmu_name[];
>> +		u16 nr_caps;
> 
> Here, no need to save space here, I guess.

Yeah I know it's not a biggie but fwiw I thoughtfully allocated space.
256 types should be more than enough for core_type. Similarly no real
pmu will have more than 65,536 capabilities :)

Anyway, will convert them to u32.

Thanks,
Ravi
