Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4087353C41C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiFCFUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiFCFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:20:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90BB2A71E;
        Thu,  2 Jun 2022 22:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHYvK9NQvm3uKWZym3F0cVgM5j6h025lPKH+yom5d1LJhiolExz3bsZ+53a1YH26IbylvKqi2VqhKLW2wveREuovEQfFSiehO8jOvjaXi+N25tvExuXkcr7f2t6vQ39bajqsk4uGZEEY27QSOV4kufLD1ne/9BOoddSzE1Bn1ALXDNgaDXnaKnFYxELPEdjNbxGpcHWQ6JR4oiAwiUo44tsVvzl1FUPHcnNEQ1V0m/21rWtgn+/1PaChHpbiyMDeBrR5Ln90LQMgx2YpuAPIMF9B8njs80pVDcgkmsWcDMJGS/5qKliR5nvqEN7BvjtsSRqIizOw06EGT7R017XDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RG7FEIupJZ3Mj5j64cipzJUctu/n+YN1ZPST3WOgsY=;
 b=eVgmuYDlXhS53LmGrIqjs9nDF/hvuRwgxHVQIgjPfn2ZVyxsJAd5so2O/WHFA6GScIQqfql2K3oR3miM8jFUQJ6xAZ0Zhyq2lThO02OhXO8pT35SkErSOLQ7cN9T07Vb22A6dtT0Ulm03zDXMJUTKET3By6oplWVKXNeMyHeegFkb7FbWW+28dFPRsuM0ODjFiBrQ8EtMe8W3byMrMrakeUIU9aau3pm9aXmrI7j3nMgWQFS8BVDB33dSeWY1mrxkczAQ7PD+k/iddvzTrHqzAw+DFft0NveSldPdk54Lm1TOaSS6qgSLhabOxYdlU9Dzc/0Ap+QAROYhDsuI7P3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RG7FEIupJZ3Mj5j64cipzJUctu/n+YN1ZPST3WOgsY=;
 b=IqQ2exhr0F/HK5RzcUYY1FYOFtIG8CvmxIhn0g3TYWBgsXtjF/WwTNiBCR/+qTPcxJyDlcJX3FWdXQWdbMiSmkbPtJ4gMqRrWiapPald7AfeKpnnZsbFw9rXAWbkEMJi6KymFTLHXBgPK7pzwdfmQcvR0m4FfjI80Fn96x8eTeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 05:20:30 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%9]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 05:20:29 +0000
Message-ID: <6ffc76fe-f25e-c9e2-8b0a-6548525d3150@amd.com>
Date:   Fri, 3 Jun 2022 10:50:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 4/8] perf headers: Store pmu caps in an array of
 strings
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rrichter@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <20220601032608.1034-5-ravi.bangoria@amd.com>
 <CAM9d7cgraWne_NRGFqscWbYSx5nue_A2fJCQ-OaQBTC3g0eijg@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgraWne_NRGFqscWbYSx5nue_A2fJCQ-OaQBTC3g0eijg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d174949b-ad91-47e9-18b9-08da4520c649
X-MS-TrafficTypeDiagnostic: IA1PR12MB6281:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB62813BD281E2193DFA2827B1E0A19@IA1PR12MB6281.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tG9bQedN3CuH3bcxfZdKaT6ii67T2ep07rS7A1bFY0nuX+TPnx+DS/WN92hZFch3TX7fg3hKKlN58apOZ8pLkpSxHtRrSMQGWLohN7HkbbIR7Y8DxT48TRXkfeuWhoeH0WoAQiBAKgHwenakFMoYz+bOZdY7NYB3HG5kunIS65ySNT+DQDkD/S3cxZTCvAaPvGA8JYeKuLrfj7+8s+6Qg9R7OrBPaUgI3+OKmKo/93ouINZMO0MTIulr+RaY4O/agu4KiGCFwY/nKS7T0clKMnk7xXwwQNhuFWDH7FZY15n7vKiUsZPvvjMwzzYJW09ZAUMYMxbf+3EzlV90JNv04SQmf78oUJ3Wcfunv1S214OPnQitLn1cwI1mg/AOv/HXp8sQcjAx7QNOxAda+DGFAG7C2EFHiR3YQwnUunHH2L4aMzb8P/twVkZ2tn+jgelQlL7VUk9WjSPEs/Wf3lStVDFXsdV9IZw3NZJkkHB7mQKJY8dKu5nQcUT8z1bUhpPKBy8WqDH0CscSb5usslX+tbFaJU0IDYtSJz3YLDo3o7qdF1pLlJ1mNpeBmHE46MJUlHJRea+ahbGZpWSJ9M852j9rA+13N8bJx8hfR8XuLug4HxyTv28C+Dxwn3Oo/YTlEo49Fo4oKAxVVUJbA4QbG7nYVZBmGbHJnO0AeMMnXMVtNL+mYr+a62QCpcr3cMSvQ3pM+ccO9gdGHNROFDXGGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(86362001)(38100700002)(44832011)(8936002)(5660300002)(508600001)(6666004)(6512007)(26005)(6486002)(2616005)(53546011)(2906002)(6506007)(186003)(6916009)(36756003)(31686004)(54906003)(316002)(4326008)(66946007)(8676002)(66556008)(66476007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pmcGI4SmszMUp0cjdxT0puZ3FtT2hUQm5QVFdybkhjZzNOdVVPSUFQRTZJ?=
 =?utf-8?B?VWFVRVN1bGllZkMzQTdvdHVuM1I4c0RRTzJIaFA5VEF1RWN4dVZ4WFBQdVg3?=
 =?utf-8?B?UVFlejA0bGdPQUs5M3JybjgrY1FmRng1OGwrOVorYlM3OUhQUDBQajFWdGww?=
 =?utf-8?B?djk2eENMZURPNVM2bnJtelhWdTBkbEdlaC9FWUkySW1zckovazlyQmwwU09C?=
 =?utf-8?B?dkJSanlJWmZ1NGsyeFUySkNnMitJZXB0YXZSRzlidEc1bDBaYnd6azdrMTNk?=
 =?utf-8?B?cnhuTmYyaHRuK0xwcU9acmpsMWtReWxtL3pUT1lWbkNWY1QwSFBVdFVqUy9L?=
 =?utf-8?B?a1FsOW9rdUlWTnVtNzVMVmxORkhQbkxhZ016OXM4TVNSYWVtUHVKZTd6NTlv?=
 =?utf-8?B?M3NmMTZEcjFMcVFXNUNvc2RVTUlnRjhZWjM3UWFabWVKbDZDM3dqNTVSbGc5?=
 =?utf-8?B?SURpNGxkQm9wR2JQaWRvcmtkZnpRakRVYUJkNFNVeU5tQzF6VEI2c3crK3Jz?=
 =?utf-8?B?ZXNySjgydndTMGYrWEtIY29yTjVsYWQ3SjBWU2dPaTB2MW1ST3BBaGo4a0JP?=
 =?utf-8?B?am50RnVFWGpObkptWEh2VU9hZmRnOHRjSmV2OHlPeC92SkdaZC94aGNtZm1u?=
 =?utf-8?B?LzZob1lGRmpvcHBWckZOMHBYa1NLM1VwTUJVeGFoaWxGVWNScVJtM21Iems0?=
 =?utf-8?B?UGZjeWdTQXllOHM2S05IZjlCT28xbXBRb2tES0lWN0ZHRVVCSk40eXRrWXpx?=
 =?utf-8?B?ZURIUG5nVndkbmF3RTFjT2pOVGlBK0IvNXA3NFZiRWlLclFFM2cyRnRhdHZu?=
 =?utf-8?B?MGE0UHE0citTbjNEM01uWWFUTU53Y1FYY2lMRllUTVVtWVRSWVk4eWRUbHFJ?=
 =?utf-8?B?eHJtbTdYS0ZoR09UNTcvbVJVTjNvS1JTRjY5NndtS1pyb1ZVNjJkSTVORHZi?=
 =?utf-8?B?UXNZSnI3dFB6VXhlVnFidzRDak1EOGQvUWs4NElRVWVYVlJ6U0xCemV1eGtw?=
 =?utf-8?B?YWdWNktEcTcwTDBKUWlnY3AyNXRLM2dWWks1b0lJaGFtWkJERGZURXFSVXYw?=
 =?utf-8?B?OE8wUnJ3R3Jxc2ROWnBWRUtMcU03aXl3cDJaRDFvVENySjBxSUE0allEbFE5?=
 =?utf-8?B?Rk01UzU4cENpZFRJSDB4Y0hxMTJ0cmIzVWd4TVpmQnh2QnVnWWpQUTd1SjUw?=
 =?utf-8?B?ZDFMR0x2cDR4clRJNCtqKzgrREZyL1lFUmpZMUVZbC85alNQN1hPWkxEMVE4?=
 =?utf-8?B?L1BNLzlQWTY4dm9vNXZ5QksvM3lEU2JxOUVhY29XWmU4ZVlyS3BUdlQ4c0Fv?=
 =?utf-8?B?L1BDb1ZEdXFLVHdscGtZbnpmeTVYOVorWnF3K09sM2t3U1kxTC80SFNVSGR0?=
 =?utf-8?B?SVJ6cXpsNVk5amRibVM5ZjFaKy9CSUMwRjFkZVFxS05EOWhUTHZDZDZ0eGpM?=
 =?utf-8?B?dVJzV0dZU28rQXMvOFpSemllVzQ0cmdnYjMyaDI1V1d2ak1sRC8wWkFiTXc5?=
 =?utf-8?B?SDY4VnZPdGI0c3hBWVpralF4WDZTTXQzd3ZlZ3A0OEhBSXRzT3JWclE5ci8x?=
 =?utf-8?B?azc0STNmeDFLb0V3a0xtNlc2aHAxZHR6TG8rZzNZVVNodTcrbkU1MEM3Q0VE?=
 =?utf-8?B?TWhzK0pOejdTOGNneWN2ZGFCUUVlbWY5RHE1ZGxGRnJaNTZnaUNCc1hVT1lT?=
 =?utf-8?B?d2NRbHZqeEJIOG9ONTFQUm9udHg1cVFnTzI1QlExS2svMjAwM0hVeHZyaGh2?=
 =?utf-8?B?MFV1TStGMXo4bXBBUFJvOFJ2WUhUTXpyZGN1cEVMdk1CelhCZ29DWlg4NzBC?=
 =?utf-8?B?c1hjN2dYbDBDZnY2a2F4dDdsMHZPWlcwUDR6YkYyZUpLYVJxZ3Vndmx5RE9u?=
 =?utf-8?B?eG5uVE1VTHZwRitMd0ZVbS9WcmF1VkRYbmFhMFdWVmw4cytiMm43WEpTbnVt?=
 =?utf-8?B?QzNYeFN1bFhIRTlVV2RmcVFJaDlTTzY0VEZ4aDBqTWVqSHhsOXZ1UjhFRW11?=
 =?utf-8?B?WUpTQ0xhMmRFdVlCS1NSOUUwanhTeFpJTUdhMnJZK2xha1pveitrdUdYN3pG?=
 =?utf-8?B?UkZYUDdsUEQ4L2VHUmEvNjl4WEQxZWRDUy81T0EyNS9OVVVBbUkyRU5vUmh5?=
 =?utf-8?B?Z1JnUFlJK0txeDdWbUdMY0Q1VHMwd0V1OUVaWGFMNUdSZGFOK1dlUnhRUVli?=
 =?utf-8?B?cW95T1lUZUhGRjVtZHdZL0hRZkhYRTJHVUV3V3NUdUFZUXg3QTNhSGJQL2x4?=
 =?utf-8?B?NFArQXVKRDBNbUFxSGN6NW9ZMFRFeUt3Z3ZOaGlPeitaTGdzTUR1d1IveTk4?=
 =?utf-8?B?Rk50RUhFcXNVcUhKb3NoZkp5NXpWMjBsaWFmRUl2UHd6Wkl3Vy80UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d174949b-ad91-47e9-18b9-08da4520c649
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 05:20:29.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxkKQ980iqkM5y3QOZhhrJ3zOPInl0A+K5xVfouMggvV7Q++SjyiBu+ieF0dAUHqBQ0iXElMm6pfX3Nd6AEbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 03-Jun-22 3:07 AM, Namhyung Kim wrote:
> On Tue, May 31, 2022 at 8:28 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Currently all capabilities are stored in a single string separated
>> by NULL character. Instead, store them in an array which makes
>> searching of capability easier.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
> [SNIP]
>> @@ -3231,12 +3226,16 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>>                 if (!value)
>>                         goto free_name;
>>
>> -               if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
>> +               name_size = strlen(name);
>> +               value_size = strlen(value);
>> +               ptr = zalloc(sizeof(char) * (name_size + value_size + 2));
>> +               if (!ptr)
>>                         goto free_value;
>>
>> -               /* include a NULL character at the end */
>> -               if (strbuf_add(&sb, "", 1) < 0)
>> -                       goto free_value;
>> +               memcpy(ptr, name, name_size);
>> +               ptr[name_size] = '=';
>> +               memcpy(ptr + name_size + 1, value, value_size);
> 
> What about using asprintf() instead?

Yeah asprintf() would make that code bit simpler. I think I'll have to
respin the series :)

Thanks,
Ravi
