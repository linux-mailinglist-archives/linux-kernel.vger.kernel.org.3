Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5499F571537
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiGLJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiGLJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:00:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDCD4F68B;
        Tue, 12 Jul 2022 02:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2s+djAv6OMR7XttluIHXbhArGDNM6WTQbR0ytTPvi/pX61oyB3+RtjT2xjDs5gLm9D9deWi9uo4YMG9mK/cv4Q08HDrn9b9xM23bkNmGF+HQngwrS7tTaiV/Lq9O8vk9mdXTxp2MzE46oi13aphEK5d6e4iIydR5S6H4G6N9I4xu0RECHWIerz6fvXh0gMHsqj0hPFNWsK1AmkSXkZ418PBy86V7ZrXcTT0xVDOq5gPFp/jNhLgc7JeYATIXKew16ev8ywyv5M33YqzL3uituUYQYfzzQkRck9a3oW9pPOB5epVZwoaBQFqQ7dLQZGlQmjbmOkDtGwlpjjLvRP9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/4cTYmkfpbKag1vhzPTokLVXyFv3HWc4EwUTQEzMoA=;
 b=OO+yKtJsICwxN027W7gArHzZGqPqs9AAXQwilJYnjvBg8HJRSQduXiRqXgFhwZMkOojslnFtXKZJA5g3cchPLxFwzQupwf2VHvs0pbSOKJrl0J0UBWWluWeBiNym1cufdE845QcsSX2pzo/IZQKLtTzpE/dQgyp0cXy1AeoxawVCvp3Ja6pniEnkVQI3tF+n4XjhmZ3WLshF9xtgBCuWoriYh7OPf8M9OjEMJNLA8KEpcFmUncGLE5dqee9ck7cGyoyKQ8AnOH+vQXnEHkrTXww6L75sknWGIsCtQhInyJwg9pCpjxPLShw20/KEgfW3AivUjnQCXzXfSR0/AlJwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/4cTYmkfpbKag1vhzPTokLVXyFv3HWc4EwUTQEzMoA=;
 b=NUubOs1mldecZyPDMmPNjf0yj9lnTYdKwyNWnE3ZGN0FzsMgfGq67CdlEN0eO7LtBnZaMv+t1NZ9RfN7ln6tcFQeSWVEdhIHzw8zTR8nKcRRwVWeh0J7Y6roPQKppcvPoAYHl7JYNBlxNrQ3nVllgIaEI0Va4YoVZ6TO+t4a+7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 09:00:55 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:00:54 +0000
Message-ID: <ac23d789-12b5-133a-a2b1-1ea9727b3d97@amd.com>
Date:   Tue, 12 Jul 2022 14:30:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 00/14] perf mem/c2c: Add support for AMD
Content-Language: en-US
To:     peterz@infradead.org, acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220616113638.900-1-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220616113638.900-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::35) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19de081b-55c6-49db-324c-08da63e506cd
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dZL3pp/qtPnoBIdZoTfsUkS99dqeA6dtv8eB9d3DwIgm7NXNdM8sDPPVOB7M1iwqASPcBpjr1HWtKkvrNTMPM83Bq33t0biFr+QGZDQBemsZDxNOv/hF0BQpMIM0siUR8H3V75zAe0NrtT3UwdgPN4AbY6MWHBSrJQjEdjbBN2ZdRfSyPXI/s6XuR6GNwt0OpuJVSQEfLYlcZUgrXfKf+3MddUUURrm4Y+ZTePDaSa6posJobWPWqM79IbUNGlIgJDt56FMsLHfbinjfIaKXXBKp54q6G4dhXfnA/4oP44GyMLrnXUUFXlK/bGrPPY1G+VMnWRE+oo4EuCMPWLFCWNmxSOpltSC6fhlzLwGraePqgS1adx96zexyooovGD93Pz/B9Ek7ZQ6F5rT0YX41TaWOBeU2kiFzW9jdu0X/j8clOeB2EnkWOEWdvorc+SBTLWQ0x2puq7qSExx+9GHvaDCYHVExaLcBhwH8lRlFwUMopRnOVshTdxVjfjJHSxMsttYc3lnLGTtDx5qPYihPYwLDghUh6O2xPe/RB0/BgDoXvB1bt/skcPZRnMzkNg3mNmshTssfP3cqpzgx6K06j8pelsf3+r4iCFeIUQX3zYFiaZCDvh9KZirWkg6M7+qETGPTOIMh6FKkg6crZN/jVToIBFaUrvj2qflYbRCzIYmWdO3LmO3hsYypC4vvEIA6pfH++sZtfktaEc5ZuwSnPLqVBGgotoQ7IFSqC3DLYfQNcrF/GvQlifeq4Zt9ohrCloSlEBHhLuTkY6Xizi2yz3FuJrOBXGW6sdPNozastpLhkTgBjtdUh+45hrEsuzFo1Yto5nEysWrZgCHscHVJM7a1M2RpBcXCErHwNx84WY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(36756003)(31686004)(2906002)(38100700002)(6486002)(4744005)(44832011)(5660300002)(316002)(7416002)(31696002)(8936002)(6666004)(26005)(66476007)(86362001)(66556008)(66946007)(6512007)(6506007)(186003)(8676002)(2616005)(53546011)(478600001)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNiSlRrUGs1TE5EczhJdFN4Y1pwbFpyZnZwUDN1bEVQamZOUWE3ZzVYNmJB?=
 =?utf-8?B?YVh4ZXhWNWljUmc1eVZqcXg4SU9xL2NvYVF3YTlzQVJFajBobGo5UjAvY3lU?=
 =?utf-8?B?Nm5EdjBjNkUycHVuOG81RUxBYTZPZ1Z0TFRVSkN0aDRYOHVNWUJDNWFkL2Zo?=
 =?utf-8?B?NkxBMW1SYWQ2THF5azBNRTVRK0Z4Q1YwM2NhNDB5c2hVK1dMekFSaUViNjJp?=
 =?utf-8?B?ZXNHS1Z2K1grSFkyc0VVVm9aclYvalNHZTJQQ1pzNVJXQTk4TlpuMFhYQW1m?=
 =?utf-8?B?RnlMRGpnTXI0ZEI1KytYOXF6U0h0YTVnSUhUR25HRXVPamJHdzluQWtLYTJx?=
 =?utf-8?B?M29QYzVhUC9OcitYY0NnMVpVdUVvaUdUZUV0amxDTGM0ZFJpaDluNGp1SER4?=
 =?utf-8?B?ZTBOZGFTZTc0RW41SWVrVVRHUFBNSTFyMjJqaXU4K3IxVGU5bEU1ZkcxTEN5?=
 =?utf-8?B?MVRvZC80blQwdU1Kak51Mmo5OXhlL3hsVXBJb0I0cW5VYkI3K3U0Q3NkNU9P?=
 =?utf-8?B?UmE4bml3VkJoQi81QUs3ekMvTjhScGNQZWs4UFVKUVNyY0prbVpDRzlrU2JU?=
 =?utf-8?B?blFCazlPVVFjdFVqM3VQWWd3VzZGd21UcnBITEtlZWhRSXMrTTNqSkRzVzVa?=
 =?utf-8?B?dWx0dUlQazNZTlNOdVRsa0x3R2VVbWd0d1pQdFFSWDc5djhPOVZJR3Q4RHEy?=
 =?utf-8?B?cjRReVNqU1lIOC82SkF0YUxvNk93YVFvakU0V1dXNmU4cll5Z01LSkdYQUFp?=
 =?utf-8?B?ZkRJbXpKdTA3eE1zQzBTNWRzdGt1MmllZ0QvL0trRnZBQmN3NGRNNHIrRFd1?=
 =?utf-8?B?bnpNZUVLQnQ1NTRyUDA2eDdLV0MwMUxLanF5QnVGOEJsZGdtZWFtTkdJQS9j?=
 =?utf-8?B?M0lkcGRNUGUra2kzNHhQcC9VbXIxalhvbW8zVFByNWZEbzhOc0R0Y2lUTnUw?=
 =?utf-8?B?UWlUaFJXc3BNcVJLK2IrUjlmVWJlU3BqWEowdW9wVy9yeUdNNWp2VG9Ody9z?=
 =?utf-8?B?ZWxKTjlsS2F2d25PNGRaalAzV2FVNFJ4ZTRkN01FTWFYa29LdWtGK0ZGcmVC?=
 =?utf-8?B?NDdUVTFUS2FVU3QzcFA2UjBWOC9XN2g4UGE0NTE4Um82SEJGR0JoaFFoQjcr?=
 =?utf-8?B?TnIzL3pqeS9oSVNKSFIxcjNZOER4WkVqVnVCUnJRdG95aHB6UVlicTZkZ2FF?=
 =?utf-8?B?bGdTOE1uZXZyY0kwM3hYSzZTUU9iLzdLSGtWVlRMY2I5SVpEQmpIalFkTVVD?=
 =?utf-8?B?YVI2OUpaTklpUG4wSmxaOWx3dHNOUlgybU1PblRsa3ltMTl6S044czIxOWxq?=
 =?utf-8?B?TlBzMWdYMVF5QW00L01MbTdXWjZnVDYrdVBURUx5dk9DMENQTUZqZ2E2UlJl?=
 =?utf-8?B?TEg1dm9STC90ZzBoeTZqcjZFc28xVDdEZTVJdjNCazBlNW5kRzlhUUZOejhr?=
 =?utf-8?B?RXFwYmQ4T2JSd2J0Q0xKWUZhK1NGRm5ObFczWWJVZDNKdENnTHlpMlJFMmNz?=
 =?utf-8?B?NUJPbTF4WG1rQjNEVzhuL3lZaDhEbVN6RDJGTlhyVkFoQjhUVThkenEzNTN1?=
 =?utf-8?B?ZlR0UFNPU2tUN0ppU3J2OHhaekpncGVsNGxaOUtqOE9SNWN6bEdaa3NJY2tU?=
 =?utf-8?B?ZmVDZFJwWGlLRC9aSmhGemxJWjFZZEM2WFUweUtwbmtFWEVLWTBkK3dqd2xU?=
 =?utf-8?B?MEd2S1doKzhVSTkvUXdYUzd3NGJzb1BTSzZIV2RIZHIxMGs2NlBQemVNVkE3?=
 =?utf-8?B?Sk1ZdCsvaTlLNUdkQkhFRWpKeURwc0hpOGRhdnFjL3MzbEh3UnFiWkgxbTVu?=
 =?utf-8?B?TXNIb1RXUGU4NUcra0dLN2NPd1lvM2tZOU5BUWFxcWpoNlc3OVd2QjNSUW13?=
 =?utf-8?B?clNEMENwQ1dDVnhkcUJpdVJMeWMwRExWT2lJYkYzOHZoRWtISWQ0WmY2ei9u?=
 =?utf-8?B?SjdYYjVzS2JEbS9sSEhXaml6eDd6RTF4bEMydVp5MFV2cjBFVzdkMkJsTHd2?=
 =?utf-8?B?eFI5WEd2THpncDhmSlNLeTNlQmo0Mm9RQ2FZZlZBNWpZbFdYeTFEVllVS3hJ?=
 =?utf-8?B?K1UzS2N3WUxHQW13cXhKL0JnbHM1WW4waU9uZHhVdDQ0UzMzZ2FRbVEvYkQ0?=
 =?utf-8?Q?HFsZ+6m+i4+xTCOf/wdz4Q8Kw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19de081b-55c6-49db-324c-08da63e506cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:00:54.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXLWyHD1/22+w9IAn/i2TodRO7ToRaLuwzShz2/qhe2GhyD3Mw32pr5BFkZva/Pz7DyB3tFKUbuKfp33V/Twsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-Jun-22 5:06 PM, Ravi Bangoria wrote:
> Perf mem and c2c tools are wrappers around perf record with mem load/
> store events. IBS tagged load/store sample provides most of the
> information needed for these tools. Enable support for these tools on
> AMD Zen processors based on IBS Op pmu.

Gentle ping!

Thank,
Ravi
