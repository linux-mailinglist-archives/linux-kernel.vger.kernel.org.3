Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6957D876
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiGVCVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiGVCVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:21:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FE974B1;
        Thu, 21 Jul 2022 19:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUV2uX1efDNq5DrZtuWsG9owFsIT6FIMhOwFOIFFrbBFxhpveptclvpiYQuyzPLyp5qYIK8PmwNdPxwvpvniTMpiSC5mt0T9Fuh3rVRML93ezpBxgGjTYqC9+diUtIaMtO425yCNofrlnFee1sEaSdRudJdPJbtkfIENTxS5hK7J19mt95lynHbd2bZKBAKyfGzrYmEO6LfSZdAuDpfH+qRfvE0oSxyeDh1kePkCoFOTHBoCkeL26d8Y7pfpL+KkiX8DiEmLN46q2QXoM4ZvY+fXH40Fj1zm2hiqWEiOThAd/NXOiCR8ULpJeVNKDKc7pxT13efiYflrAyv1CakpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYCbQfpay7DBBpf8xSG0NWbm1rU5XlZoVy90kKdLQL0=;
 b=CjsJ+rW50h/sCMUATApDznye55A7Cs9OhLgZVk/5hY/4n/NL1bSpS0w48vZaR3BTMyvQphoq6B3DdqBBsU/NwWxvI8M+PDsjAFuIfLHBnKk9fTE3Geljdd29Ecibm2BIS12NipA2fiXxBawHBI1lrwkr5TLCL8RsO8awr68vYhikuuFj3j1ewVNWGHPVvPwXae04ji1RQ/itm2dU0+fRhAjgT+odIMun7C+2xf1JBg4G/53lPnHseQxrlHnW6GLe0WB1iSRF549cwSkDpiFI7YfjZI+4GJY8KV66plxd9jGCVdy23qjzk606eXYxG45vLnnSnYiive05DPfhxQg7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYCbQfpay7DBBpf8xSG0NWbm1rU5XlZoVy90kKdLQL0=;
 b=saJJs9tofShG0xT4/krCByvBoKGYFDcjn3AljllZX4J+kCNtuWvYG4deGCdXsp/I75nBQO7duXyIaHsFlY0OmFkzem4N5I6EFtlYXzrgu8TE9oYuxd4sFEnC12HPGgGHlh3i5KFhdw//mjGgZHWVlcWfTCNuHK0bgylI31vbw34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 02:21:41 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 02:21:41 +0000
Message-ID: <ef9034a6-c4b2-ff82-a56c-bd7df2d10884@amd.com>
Date:   Fri, 22 Jul 2022 07:51:27 +0530
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
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CA+JHD91X9_dMV-sXho_L9k326-Eneor4ZeOtw_WgWNtHbKzWxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72fd5f47-754b-42e0-84d4-08da6b88e9a7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2954:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSPWb4F2Ynm6nJQxpz2aU89UGSZ7iTFSoykjPKK2ZrbTGYTJH650jb67NqkXKCYtWThrgcNWbuK7zA4K85cdEuTm22ngSWg9niZ/mN/1mO4riL1GhSNZnSFR9EA1o4XZnoQvz6+bxAiYgM150LkvQONAELJ+1r6eFhqYg9d99o+aMvf/pKUY9sfz80NxzTtowwnZykrIy+acwk9QZ5weHjiGAmJ5zCInjLicz52dF5ckwZDc6xUqV8b8tSEuUs8NlX0zFH9xvHDq7SwBQwCDd8JGK7CGuTPBNcljG0YrhGa2dR803PTSVfwO2p4Ml3IFJkR0+TeifRzb8lPCVxp/8dowQt0B1Nv1BzK7VLlp6YM8cSnDhkuxHDoCJCrKEqYs3di+wLLXiQp3bJp1rwtcqZ9IvA5z59r6du5iD72O9gqJdPzzZa2jKmQfqz4FQEtAmkCKfb0Gko8D+RT7EIhM1Q2njtTf5XYlvthVK9fOLiO5LLauquglRDmzoHBUxUNtA4ult/QPjbg0ymKbjMraS0+Hbren9xC5MaiX339bQi+kuceZ23lVoeFsjo1zBUgzcf/qF18CxVTDB7XqRX0It3x77FV7XEnBkq5WH2zRTGDik2+/ybEpYYh0kPIYHJ4qj3WRWtMAgbP1+o9hxUw7rHxZ90gz7cmNNZfYDlIW/zlbB6k89KKEGsPgSEy2CzIqr9MokhVGFODG7vYSBi+nw4dDMCJhfCvQ+s1Rds9FAfF08F4Uf+zhDz1KRkW4+3iKRS13Jae75S2RKqcU+K/1sThnFrn9XRj4R8IpgIcoloWyJ2psHmWZjL+V9yH6p1Mj89pPvcmQyK3kyhMML7ux7IrSdBV04XCe1uC8DRVHG67n9/7DbwwPPgowhPpD8gKzu4ufQv9zqNmOS4VIVXS2gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(6666004)(6506007)(53546011)(55236004)(2616005)(478600001)(26005)(186003)(2906002)(36756003)(6512007)(66946007)(7416002)(31686004)(83380400001)(5660300002)(44832011)(6486002)(8936002)(966005)(4326008)(54906003)(8676002)(38100700002)(316002)(41300700001)(31696002)(6916009)(66556008)(66476007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFFjRllRb0RWVU82QlZTd0RiOTlSbWE3T3lSWFhYTUZyalUyZWZabitWdWkv?=
 =?utf-8?B?Q2NwVDdEZjNOT3pGN1dyajFIUVRTTGRRTkZBcHdHUDZrblFGZ2VjNVFVQVRr?=
 =?utf-8?B?bWpmZGxzV1ZwWDBmeUYydmh2MWpuQlZYZ1BJT0NLM2xqSUN1Z1J6MEtENTBQ?=
 =?utf-8?B?bWtTYm5MVm5oVDkvOWxSVCtZSUhmZEhBd1QzeUxFU1haSS9YWmY3bThwZWhx?=
 =?utf-8?B?Nk83TDZ1elhOQnM0eWRLQzJyUWw1ZHJhbHBWU3lxbFh5ZXY5V2ZnWUtDcjYz?=
 =?utf-8?B?VnV2NFpUM3djVEdJNDRtRzc3MTVWMjNZazJ4U2FhV0FNVlBHT280Tlk5VmZs?=
 =?utf-8?B?YkYrTmhuamZFYTF1TFNHMHJCcmtSdGk4dVoyWEFkbzI3TkhLTnB4R3pGWnBG?=
 =?utf-8?B?bEE4WVZEMmtKMFBTb0tMM3MvTkMrNjlQbjJzZ0pPdEJCYmdoTlpkTXI4eXJH?=
 =?utf-8?B?Z1p3dktPOXFySEVIUVZubzUrNHcyTHhCNjMrcUh6ckJFcEgySURXS0lBSXdN?=
 =?utf-8?B?ZjhsOFA1NnpsdG5hZ0p4S3pvTnhHM2IzemRldG82Zm9aUnB5ZW01anEwSGI0?=
 =?utf-8?B?MlBLRXNITnYxNGxYbzFFT3VwRTZRTGg2dDNDdE5Demo3ZkZjTXZFMXVNMWFn?=
 =?utf-8?B?ZzhUZVNkK010SFd5dXlEeTVmdUJKTVFUeTJOa1ArU3VIWk5GcVZzK1BROXJH?=
 =?utf-8?B?UURVcjBnU2hVZmVvY2k1QUFjMkxWSEhON1RMWm5zd0pReWxCd0J0Uzd2UEo3?=
 =?utf-8?B?MWl1U0dGbVdHUUZkVkZoRk8xL0dOZzJmRWRrK1l1K0g3R0o2K2RqOHRHNzRC?=
 =?utf-8?B?QWY3aEFFZ25IN041YjJNdERJU1RSN2daWGZqVVFGYUdBTmJjU2hzTnAxaEM4?=
 =?utf-8?B?Rnlsc25LNTV1T3pZdFB1a3IzNEtHU210RlBKbk9vNE9DSHhIQSt0eGRhZjg5?=
 =?utf-8?B?RjdpalpEWWdUMUVEVms4bWtuNlBaRlJQQVh5NEdGUmFBYkVsVE8rMkw4SGtK?=
 =?utf-8?B?V3J0RGlnYzlHRXBxajZCeUhWc3JVVEtIdmNoZHc4dm5MdVNhbGlCRDJmWTh5?=
 =?utf-8?B?UFpWd1AvT3NNa3c5YVFVYWZST1loekVUeWZXdGtLQVpQTEMwMUlacVUreUpO?=
 =?utf-8?B?MnU5L1R4TXZwOGN2NjA0OVZOMDBmb2Jsd3g1eUNqS3JUbEN1bFpnS2hjTzh3?=
 =?utf-8?B?YmpVcTRMZ2g3VlEwdyt5NE9ONU0wSVIxZ0d3WGlJZ25UaEVTSnhzbzAvd1A3?=
 =?utf-8?B?UFQxajFyaWtsMW11MmIxOFMxTkhGdEZPd1VuNE1ib0ZZNFJZSm01VFlPTDFC?=
 =?utf-8?B?cDR3N0wxaXhGWkF4YjZqSklvUDFBRTFQeWt6aTRVNkZ4U01qT2tHZ0RwU1do?=
 =?utf-8?B?N2NmbWowZUNTSlYxU1FDNXdPY29OZ3dpNDVCZHBBRmEyOXBCMGdTaktOc0lv?=
 =?utf-8?B?OHkyMHI5c1VweWVNTTdvS0VycGEyM0FNOFFLdnlub005WFVHelpUMzFCK3BL?=
 =?utf-8?B?WlRwaVpQU3VTRmlvNnhVUEovUGJWeUNNc3QxMVoycEFidzAxU29zeGk2dFVR?=
 =?utf-8?B?WENkNjZaV3RWSHg3TTlsSUZqQ0tpSGxXeGhGckFkYzN0OE5tQldLL3RYQjdj?=
 =?utf-8?B?KzFySlVVemE3a1dhamJjVFh2TXhvdzU2NzNBcDcydksxaVFsdkZrSWJiR295?=
 =?utf-8?B?SHJ5ZzJja3RaSHhJcU5tRDdlQU40c1UrUURvZ1prakxqS0xQTlVXV1BadzFC?=
 =?utf-8?B?cGRBVlRaL0QvYnJoVXpiUE94cEI1UHRmRG1aMUkwVFZjNVhxbHFGODV4UUhx?=
 =?utf-8?B?c1NxaGxwOEN5Q3h4QkVKdnJRendHcWM1T0hMdXg2TjFlRFhuNWFsN2dqWWwr?=
 =?utf-8?B?QWJIQ0Vwb1FMT3BMREdxTFVuaVg3VUNJK1had05VdmdHcU12bDRoeFNKemcv?=
 =?utf-8?B?NjlxdkxZRy8wUDVmTHRjMTAvT2hRRHRvR09DZGNYd0VlRFZCV0hqaFVHbnBB?=
 =?utf-8?B?N3JUdzQwdmhpMmFIT2tBNHYwU0s3SVRRTjl2ZUpqY2VCL1gxRHc5NGEwTEox?=
 =?utf-8?B?RDBwTHF4eXprejF2cko5RjZwdXNQZG1xZENtVkNDYUt5U2FQTytqbDFhVW5G?=
 =?utf-8?Q?oYFnTX3jPAHpen2v92789hQfT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd5f47-754b-42e0-84d4-08da6b88e9a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 02:21:40.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkXrP1r2FK6pdH49NVsUn9atW6iYbckQ+odJ6Bprm2iwZ3sd0KcygxIcGx+vVp/I6X0VEW5aCRMvYnC4TpKeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Jul-22 10:54 PM, Arnaldo Carvalho de Melo wrote:
> Ping.
> 
> On Mon, Jul 18, 2022, 12:34 PM Arnaldo Carvalho de Melo <
> arnaldo.melo@gmail.com> wrote:
> 
>> Em Tue, Jul 12, 2022 at 01:35:25PM +0200, Jiri Olsa escreveu:
>>> On Thu, Jun 16, 2022 at 05:06:23PM +0530, Ravi Bangoria wrote:
>>>> Perf mem and c2c tools are wrappers around perf record with mem load/
>>>> store events. IBS tagged load/store sample provides most of the
>>>> information needed for these tools. Enable support for these tools on
>>>> AMD Zen processors based on IBS Op pmu.
>>>>
>>>> There are some limitations though: Only load/store instructions provide
>>>> mem/c2c information. However, IBS does not provide a way to choose a
>>>> particular type of instruction to tag. This results in many non-LS
>>>> instructions being tagged which appear as N/A. IBS, being an uncore pmu
>>>> from kernel point of view[1], does not support per process monitoring.
>>>> Thus, perf mem/c2c on AMD are currently supported in per-cpu mode only.
>>>>
>>>> Example:
>>>>   $ sudo ./perf mem record -- -c 10000
>>>>   ^C[ perf record: Woken up 227 times to write data ]
>>>>   [ perf record: Captured and wrote 58.760 MB perf.data (836978
>> samples) ]
>>>>
>>>>   $ sudo ./perf mem report -F mem,sample,snoop
>>>>   Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
>>>>   Memory access                  Samples  Snoop
>>>>   N/A                             700620  N/A
>>>>   L1 hit                          126675  N/A
>>>>   L2 hit                             424  N/A
>>>>   L3 hit                             664  HitM
>>>>   L3 hit                              10  N/A
>>>>   Local RAM hit                        2  N/A
>>>>   Remote RAM (1 hop) hit            8558  N/A
>>>>   Remote Cache (1 hop) hit             3  N/A
>>>>   Remote Cache (1 hop) hit             2  HitM
>>>>   Remote Cache (2 hops) hit            10  HitM
>>>>   Remote Cache (2 hops) hit             6  N/A
>>>>   Uncached hit                         4  N/A
>>>>
>>>> Prepared on amd/perf/core (9886142c7a22) + IBS Zen4 enhancement
>> patches[2]
>>>>
>>>> [1]:
>> https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com
>>>> [2]:
>> https://lore.kernel.org/lkml/20220604044519.594-1-ravi.bangoria@amd.com
>>>>
>>>> v1:
>> https://lore.kernel.org/lkml/20220525093938.4101-1-ravi.bangoria@amd.com
>>>> v1->v2:
>>>>  - Instead of defining macros to extract IBS register bits, use
>> existing
>>>>    bitfield definitions. Zen4 has introduced additional set of bits in
>>>>    IBS registers which this series also exploits and thus this series
>>>>    now depends on IBS Zen4 enhancement patchset.
>>>>  - Add support for PERF_SAMPLE_WEIGHT_STRUCT. While opening a new
>> event,
>>>>    perf tool starts with a set of attributes and goes on reverting some
>>>>    attributes in a predefined order until it succeeds or run out or all
>>>>    attempts. Here, 1st attempt includes WEIGHT_STRUCT and exclude_guest
>>>>    which always fails because IBS does not support guest filtering. The
>>>>    problem however is, perf reverts WEIGHT_STRUCT but keeps trying with
>>>>    exclude_guest. Thus, although, this series enables WEIGHT_STRUCT
>>>>    support from kernel, using it from the perf tool need more changes.
>>>>    I'll try to address this bug later.
>>>>  - Introduce __PERF_SAMPLE_CALLCHAIN_EARLY to hint generic perf driver
>>>>    that physical address is set by arch pmu driver and should not be
>>>>    overwritten.
>>>>
>>>>
>>>> Ravi Bangoria (14):
>>>>   perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
>>>>   perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
>>>>   perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
>>>>   perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
>>>>   perf/x86/amd: Support PERF_SAMPLE_ADDR
>>>>   perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
>>>>   perf tool: Sync include/uapi/linux/perf_event.h header
>>>>   perf tool: Sync arch/x86/include/asm/amd-ibs.h header
>>>>   perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
>>>>   perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
>>>>   perf mem/c2c: Add load store event mappings for AMD
>>>>   perf mem/c2c: Avoid printing empty lines for unsupported events
>>>>   perf mem: Use more generic term for LFB
>>>>   perf script: Add missing fields in usage hint
>>>
>>> tools part looks good to me
>>>
>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>
>> What about the kernel bits? PeterZ? Is this in some tip branch?

Peter, Would you able to pick this up for next merge window? Please
note that, one dependency patch needs to be applied first from "IBS
Zen4 enhancement" series:

[PATCH v6 6/8] perf/x86/ibs: Add new IBS register bits into header
https://lore.kernel.org/lkml/20220604044519.594-7-ravi.bangoria@amd.com

Please let me know if you face any issues.

Thanks,
Ravi
