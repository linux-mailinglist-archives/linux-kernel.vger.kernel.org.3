Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CF2528549
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiEPN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiEPN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:27:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9602C10F;
        Mon, 16 May 2022 06:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsuX9AJPYLWtTArOL4iZ2YGBzximTBTTscz47wWx7+iE/taqf3R2/e7elbmJfJXHa7kxMWQaSDof4L3J3hFIvfRt/1BaXhWBHdoArFJfKn0xsKy3HCruTFroBknY6+xkTc2xCnS+8uo10Ue28V7gPOV3c07xL0NMFrmSHVpsoDQuZgNZIkNEbP0MmlfBerqeixMZHmOSZHqurucysr2mhfsXh1n8mm+0pYy5Pdt/0sZZ8Gde6IMIRJcu3pppPPbSvZrq5s16xKvtqkEpqvxg8TG8u5jeZTAyNsBA9Qil5/iFV/lC00Jia96UldqKhSCwQZxlkwVkXIruZEm81bwBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG4Rz2bgr/7uen+IQrtW/YvFNVyOKyBY8VaKx10X/UU=;
 b=BjD0IocsTkpMdsTH/yEBaDTQZmRPXkuJGyQE8GCiAN6uzAX7W7GhKC+0f4V0r9OMhoGcE5bvIrvcCGQulK6zHB08bbivgtBmG+D1k+tLNSptE/gJyxUZi7Z7El4Op0n/ZTej82mrJ7mi22Yrhi8RDtruEp1kPbe5YS04vfrkZ6qHNjKH2WsBKSrDDXA5WmJKkixXtTTQFy/iRdjshMU6lxfwlHrwXEwtBgHkiJdnIT1u/Cf2PseeKe5fKeXTrNMFwNEAQFqrLVENwVfXQPUYWdRZbG4Q9xF5h+7XseKpSWuL388rpqRkQM8WXVLicSUnwcRAYZy6sdhaQ8CaJvDIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG4Rz2bgr/7uen+IQrtW/YvFNVyOKyBY8VaKx10X/UU=;
 b=3ehtZ1mE/foRLYWJxjCvGurm74c9h6FIa8veBVycamj/lf3POh/ZmGoYo5ExVmtTBpCm274MTM6/oXjneA49Rgw6UbFE4My5XR/lpiyvskPeZboqAV+RakycHAuR56EBjnn5TQHPppMIau0i8IuUA7J8VoKhMEX7WnbY9A1Sh+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 13:27:29 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f1f6:dd2c:7e78:9770%6]) with mapi id 15.20.5250.013; Mon, 16 May 2022
 13:27:29 +0000
Message-ID: <11052843-8fff-a497-f34e-8e53f846fe7e@amd.com>
Date:   Mon, 16 May 2022 18:57:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 5/8] perf record ibs: Warn about sampling period skew
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
 <20220509044914.1473-6-ravi.bangoria@amd.com> <YoJP+JqI2M1i647y@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YoJP+JqI2M1i647y@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4018aa3d-5b0c-40a4-609a-08da373fd33d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42791354AEB7C1EEE01DB6FEE0CF9@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMgfFwUbYc8uQidSvw14l/kfr+rbL0bFmJpHg63wfZ9CztCy7sPd7aFcNccM2SfCup5sKFRTxy7i2EMkF+1cqjK3YK2G2oY7VanSI4BC/pVnyY4W+spgkNhgKMILWkoMvXbQD3DbD7k15JNsdfvkf56YvI1FflipeSUY4NljaE8t0kIPkknzU16h/O6oRzD2UFsoDkcRmN5pB/jyNvvk55RVgAkB3XkR6dLNtP3cbK7jbjKcE15BdBdanW3BPnY6RLsk/SLLEiRWIIOtvJ31a+gcG09klmecunAUwpSuopoEKVnuSYnu3ko28hfG4UqMBtTiz2NB+6PVCLExJZBpQT/gY7/m7mx2y6Ub1T7DpE73zpFZ4/BFndg8glKxNGqe7t43gU01Ewx/CQm4+Nab50kWr2IYvE+T/w4atRuFOgKMT4rg91NHhGJIpJG7XJnURHiXT9mOcQVxjZKzdfVfdrXg2TlfsnudILRCpDHTPgnIZgyHefjJcRI6sYwvtC2m6nQUMmpW8nCDFQjGWMQtS83X4zOAb/Qthk3ZN33ukxslVFBgDvVxl8+l6BzHZKY4/7ITc0awkeesEb2ODh1lFkxLVtCSkO7xd8JGe+Ic+0fdRYNB4eiI99BrzUiu54l5B63+fUsFO8qE77zrF72R364pDMZ+uibHmJyCDbqMKBimegqUo6uIqrjHNhwWrrzZO8umVLnNLRb4527lDPqdh7LFQ9GLlo/b/G+5k/J8CZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(66946007)(8676002)(66476007)(36756003)(2906002)(6486002)(26005)(31686004)(6916009)(53546011)(6506007)(6512007)(316002)(31696002)(186003)(8936002)(83380400001)(38100700002)(6666004)(5660300002)(86362001)(2616005)(44832011)(7416002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFV4bUUwNzhtTEkyb0xHNlNoUzd0N3ViUXQxV2hPV1JVMUZoeDVvN2pTanEr?=
 =?utf-8?B?OVpOdC9TaVBwWWNOMVd5VnJvS3VqczQzWThPay9QUkMxUTZvbit4eGpxb2lx?=
 =?utf-8?B?akdwKzNOcnRqOEc5VUZUN2k2RUMrSDFQbHlwWXhYL3c1R1hKK2NnRytBWTNk?=
 =?utf-8?B?VDlKRi82TjBvTzUxakNvc2E2cEh0QTd6bS8xZmkwQmlmVFQxQVpvdDhsb2I5?=
 =?utf-8?B?UC8zK2x1Mi9uN3dtT3QrckFIU0pXMXJOTkwrMWdhQ1ZCdnhRUTQvUGtQM3VQ?=
 =?utf-8?B?dkcrcTRIYlZQSUR4ajlQOElabmUrd2VWdDZQU0xUU1czenEyQkNPbllRRGFG?=
 =?utf-8?B?NnRnWnYweUQ0TmdUdTFxWU9SaHhtVkVaQTdwQUlHa2YxMFlGeFMwSnByWDlM?=
 =?utf-8?B?N241QTFWTEN3QXpDRElhOU9jKzF3V0JiZEtKcDBQVUFEeUNMNkFZTktOMDB3?=
 =?utf-8?B?eVVySUhMRExxa0lNdFRUelBRdWkyc1dMRnVwcVk1OFhGN2dlVlloMXdFOWti?=
 =?utf-8?B?ZmltTEI5YjJaaTVQYlhtaW02ZHJDcjk3bDJqRVNiU0w4MDhsc0RzelB2ZHFx?=
 =?utf-8?B?ekQ5L0lFV1M5VXRiTmkrN0QzTlQ2dFB6WXhEOS80TklEN2VEVjluY0FhV3BP?=
 =?utf-8?B?c21RMTM5N2F4QWNISk43YlBYSmkzeG9QQjFaM2cxaUFXQ1lCUmFYSWJrYmVv?=
 =?utf-8?B?THFRdS8xL215SUVVOGtKRU1KdHluQi9nanE3aWtFczFrYm9ScjNCYUZqWlA0?=
 =?utf-8?B?OFlPUmJGaGg4b2hFQUQraVVaSktwWmN6dENZeWZicjhpSDlVSm1vM1ZXcG9N?=
 =?utf-8?B?SFJySFZOS0ptdzZPWkRRc1ZkVHJabUNmK2RHcGg4UmYyRmxQcEZYMW5jVFJP?=
 =?utf-8?B?VmZiU3c4dnZTQlgwMDRvVlViNTltRjZqM1VaRVJJUS9hM2FYV0FGcHovMUhn?=
 =?utf-8?B?WFJaYlM3ZnVXa3NyMVplTEZ2Q1g1cEFudFB3NkFGdzBZZVpEeVBpWm9penBV?=
 =?utf-8?B?cFI4OVRKZTNoR01sQ3JYbHhzdEtpclI2d1J3bysydE9oNUNvMmJUV0trbE9w?=
 =?utf-8?B?Qm1hdUdIRnFiNnozdHN0T3dPZ3MrYmV2M3oyRlcvSUllcUVoR0xWWDBwUWtX?=
 =?utf-8?B?ZUd0dWFxazN6aFU2ek9wUkRFNklhU2VKcExpbEJYM3BkcWVUU0ZpNjFFQm82?=
 =?utf-8?B?QUJDdjR4dHQ2T1V2eklyVzZGRmFNR3VUaGdFTUhBdGxrR0FndVFxa0Z3L3Y5?=
 =?utf-8?B?cE81YkkrSENVaVZ1cldqbk9JTDhMUEdubkVaWnV4T2hwMytuM2hBcXAzNUMw?=
 =?utf-8?B?bGJQZVh2c2dTc1pkK0FhbXMyU1R5TGh3clVHVDdlVkswMll2ZHgwUElpL0pP?=
 =?utf-8?B?bGVIbHQzZUdtNVNXOEp4RFl0THVjSjJyZHg0T01ZQ1RMTUhncUV3VURhQjJy?=
 =?utf-8?B?b0NVSVY2cGJJdXhlSXc2b3plK2tQVkpxOTE1OGRRSU1lUW5LdWxaVFFmRUtk?=
 =?utf-8?B?OXZLb2NGVWdoSlRrYSt3VGJSbnFZY0FBUXBEQngvMU5UazNWeisyblVzVkdU?=
 =?utf-8?B?aVVHOXpuUUJmVGVLMzkyUllOREg5ejhLV2FIditPaitIN3FaYnlXNkpQK0M1?=
 =?utf-8?B?U2NkcTRsYXpYRWdLbnEzMlcxN2ZpSGRCcys1UU83Y2E4T0hhYkl2RlVOeWIx?=
 =?utf-8?B?MHNpZGpkNUVIamRCMnA2RzA4MGgweXN4MEdkdjlKNzBnUW0zNG0xUHQwUWZD?=
 =?utf-8?B?c0Qwb3NqRUd5N1REbW9oaXQ2eUVQZmw2VG9rNm1lQXZ5MTdVT3c2dy9HUTM4?=
 =?utf-8?B?ZUNsUlJEcnR1bit6anN1VzYrSERPYWZaK0VqQzhQWXJXb1JYcnhJOTdiRDh5?=
 =?utf-8?B?Q1c3R2FYYlBXWGcrN1hJZ3k2cVp5d0JmSHNZNGNldU9WRkVRVDlmK1dwUnl1?=
 =?utf-8?B?NWljdWlyMVQ2OVlsUEZPSlhvY3ZTM1NZdjBZaHk3bm9IVW40M2crdFhDWkZv?=
 =?utf-8?B?UTBUYno1QUFySGU2QXhTS1EzcEdwbFh3SlA3Sm85M29URmVFRkRBVWdXcm85?=
 =?utf-8?B?RVBKeGJGdGdKbTBzZnUyM29VSUNlakozajNvb0hVdHE1US9UMDREMkVMTFRL?=
 =?utf-8?B?cjJlSXRFSDNsNlNBYWJMMWNYeEhvN1IxL05KZ2JWYjBiTnpGN00zWmNnQ3B4?=
 =?utf-8?B?M3VxMUJlODV0RkxuWmc5ZUVVZ08vbXRNWDhNRUJOZjBhSG5lV3d4cXVSaFNZ?=
 =?utf-8?B?UElFemZyM1hVdzYxMDZlQTZDMWNRUjMvdndSZUtzRW1JODNCNTlqUlQrTkcx?=
 =?utf-8?B?L2VzR2lOZFBjcThYUmhOeXZWcDhRYWNuSHhIR2d2L1NEN2M2emUxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4018aa3d-5b0c-40a4-609a-08da373fd33d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:27:29.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHo7IWZClp5hK0DDtDSGTwzUSmOWx1HuG9Ro6gyRCo9/lYz3KEY/3/pCyzihvkCvVmFgfqXkFI6OCDzxF3gnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-May-22 6:52 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 09, 2022 at 10:19:11AM +0530, Ravi Bangoria escreveu:
>> Samples without an L3 miss are discarded and counter is reset with
>> random value (between 1-15 for fetch pmu and 1-127 for op pmu) when
>> IBS L3 miss filtering is enabled. This causes a sampling period skew
>> but there is no way to reconstruct aggregated sampling period. So
>> print a warning at perf record if user sets l3missonly=1.
>>
>> Ex:
>>   # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
>>   WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
>>   and tagged operation does not cause L3 Miss. This causes sampling period skew.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  tools/perf/arch/x86/util/evsel.c | 34 ++++++++++++++++++++++++++++++++
>>  tools/perf/util/evsel.c          |  7 +++++++
>>  tools/perf/util/evsel.h          |  1 +
>>  3 files changed, 42 insertions(+)
>>
>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>> index ac2899a25b7a..6399faa70a88 100644
>> --- a/tools/perf/arch/x86/util/evsel.c
>> +++ b/tools/perf/arch/x86/util/evsel.c
>> @@ -4,6 +4,8 @@
>>  #include "util/evsel.h"
>>  #include "util/env.h"
>>  #include "linux/string.h"
>> +#include "util/pmu.h"
>> +#include "util/debug.h"
>>  
>>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>>  {
>> @@ -29,3 +31,35 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>>  
>>  	free(env.cpuid);
>>  }
>> +
>> +static void ibs_l3miss_warn(void)
>> +{
>> +	pr_warning(
>> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
>> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
>> +}
>> +
>> +void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr)
>> +{
>> +	struct perf_env *env = evsel__env(evsel);
>> +	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
>> +	struct perf_pmu *ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
>> +	struct perf_pmu *ibs_op_pmu = perf_pmu__find("ibs_op");
>> +	static int warned_once;
> 
> Please check first if the warning was emitted (warned_once is true)
> before calling all the find routines above.

Sure.

> 
>> +	if (warned_once || !perf_env__cpuid(env) || !env->cpuid ||
>> +	    !strstarts(env->cpuid, "AuthenticAMD") || !evsel_pmu)
>> +		return;
>> +
>> +	if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
>> +		if (attr->config & (1ULL << 59)) {
>> +			ibs_l3miss_warn();
>> +			warned_once = 1;
>> +		}
>> +	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
>> +		if (attr->config & (1ULL << 16)) {
>> +			ibs_l3miss_warn();
>> +			warned_once = 1;
>> +		}
>> +	}
>> +}
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 2a1729e7aee4..4f8b72d4a521 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1064,6 +1064,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
>>  {
>>  }
>>  
>> +void __weak arch_evsel__warn_ambiguity(struct evsel *evsel __maybe_unused,
>> +				       struct perf_event_attr *attr __maybe_unused)
>> +{
>> +}
>> +
>>  static void evsel__set_default_freq_period(struct record_opts *opts,
>>  					   struct perf_event_attr *attr)
>>  {
>> @@ -1339,6 +1344,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>>  	 */
>>  	if (evsel__is_dummy_event(evsel))
>>  		evsel__reset_sample_bit(evsel, BRANCH_STACK);
>> +
>> +	arch_evsel__warn_ambiguity(evsel, attr);
> 
> Wouldn't this be better as a single arch__post_evsel_config() function that
> could do arch specific fixups or emit such warnings _after_ (thus the
> "post") the common code evsel__config() does its thing?

Will rename accordingly. 

Thanks,
Ravi
