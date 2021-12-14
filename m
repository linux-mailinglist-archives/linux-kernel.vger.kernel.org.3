Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667E1474A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhLNRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:54:34 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:56071
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231778AbhLNRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:54:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfJUK1mDG9q/ClnPjTjcZTAu8hA3x2hDnSDEqf2G56RmPBj4/3j5mET05NWCgQA97ZRwH+Ndd0X7Tq8L14p4f0GQMOWE7Xf73cMljilYSI9M3MNsDWFwkt1fo5MO162a+Rp2sjuOF/L9E7OsnPC5kXyPtxI40NNFCz9AZL7K5cs9LrUuCdJrTLpWjuS01e7A/uVGVg+Rzpgq7xPfxgpKsT/6VaR2A9CoC1KD7umzdnLPLOrWPOtorRuN0GlDlCgoc5OrfnmIzshadomtmOOVUY57KjJuUbZVJeoy3mHrzy1f55nduuxFzAk51ktqgZGGcZc70WDtmRKO3G5gadQlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFaJMooY+uzBF8d0A/b1wDnXKffVf77GWBB5hNyUXEs=;
 b=iMAUtH1LroegMMOzr1wzXIUEx4DIrJqW4HaBBC1BfsxZcVRxsaYYku61L5iSbQ3tCOn7nmSA9YIjVvuEfRPX3ca1qUZoLGQUn5Qlo3/+jrYGqQ8E507XxEKdTNrPBy3DNfCc0mwJ789K/MEuKvSJx498Y1oEVsNFr+u2c0TTj59LJhitOnvKYOKIItP6pCgY+uYAEF+bvG5jOIlAXIbkdin3Ea77iGtKIKGlo2jRTKfOGpxAxHQJnws87aCRa2e8GJw0RI7vw0IQcqUQ3Mn3aVX2T7nqNq5uj4ZdIjgubvFo++YcFOCwgOG0nYE9B3JP2qE+335QCiPlq74lPU6G+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFaJMooY+uzBF8d0A/b1wDnXKffVf77GWBB5hNyUXEs=;
 b=bYITUaiqzBZkEA0Ohx9qKYcvk34/sV0qZSqsC5Kr0cuXNQfOXqspjEbkIAkxt64PRxodlvtVgS5NnisU9kUs+yC7ycAVaKfT1jEIDfHl3F4s9BeXgKKd5n7LSN0zp4n3SqR4YiLLWVlSmraxLki83L4tCN3HIQvvLViuTPgp6Fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4857.eurprd03.prod.outlook.com (2603:10a6:10:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 14 Dec
 2021 17:54:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 17:54:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v11 2/2] pwm: Add support for Xilinx AXI Timer
To:     Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211123232536.3909773-1-sean.anderson@seco.com>
 <20211123232536.3909773-2-sean.anderson@seco.com>
 <ce51714f-0a29-6dd5-aba2-4cb790617a12@monstr.eu>
 <BYAPR02MB4278A250C64CEEAED222A785A1759@BYAPR02MB4278.namprd02.prod.outlook.com>
 <91cfadf3-fe9e-398c-e563-c700522bba06@seco.com>
 <BYAPR02MB427839858F255B562062C607A1759@BYAPR02MB4278.namprd02.prod.outlook.com>
Message-ID: <2a5229f4-75cb-3a27-7746-6d9cd097d022@seco.com>
Date:   Tue, 14 Dec 2021 12:54:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BYAPR02MB427839858F255B562062C607A1759@BYAPR02MB4278.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0362.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::7) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669793af-727b-4863-18db-08d9bf2ac6a6
X-MS-TrafficTypeDiagnostic: DB7PR03MB4857:EE_
X-Microsoft-Antispam-PRVS: <DB7PR03MB48579BB4875230B78032ADC196759@DB7PR03MB4857.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2+jYiRHjeMdZcXdjdMJxzcv+l+5Op5r4XfLWPhK7e9WUaUjt9LAlOFBqAXQt0btxV0DmPd+DlDNPkT7YSn+dJ51pW0DKsQ4VmNEr18Cxn2A02l3CMmqaKV1548srjN4KYqWxrlUI9T3ZYaHChLVmn7OedqIoka4EMfBdl78nO95WeXvTE/FjxS+umYzPgiXapBRIyZ/cXyLx6CGj2htdBXoNkU0HSBaDA/nfJK1Wt9gFdXDjQX+Tlu0dBjrdF2lqvdIm824wXGZmOryp0n+XZwSKoKIR79iu1kQCnALLwOqwnBUu4rgSiRwtuqxmZ5xNl0NNPLrlqPbW6Fi/lHkr1fLrARspUmtMtK6LHI+NER7w1qf803tPCsSOXUPZgTI1M32YedO9NB+k9U8steUD/pWsGI18cZ8JB5joMKo7tlXuVostpp7mq6iZN7ur+K0IcamWQI0+y95g36TBWmzb/QF9NCixMAdzVNIYNTJyi2ODIHw3IB0DgDcCZ7w7vduH+9PvykLL0p2PRfXnkuHapysNXm6pL726Ii2ey1cXDn/4qG3Iv95IDaXvc98rweUft+I/eKdVJUdYi0T7lQNC6BtrVOErLavuVQoWtrjiSRQi36qXG34HuEavXBnxhNfN/Ad9iNIYkoblbEfPd/bR7aI/hho9OKoj8W9Ugra94MTvVNvAM9zhTQ/iCBJPJAxEumqkItxbh2M7EJgv/q3qU5QOsc7EpLAwfHi0yaXv+FDMtyD/xzhR+bihAeu7mdC4Gdd2rtqkK5XiBEQYGJgajbTH3YGH5szjGED/oU/LO1JSpyHbbZ/nfQRGOyuYpsHAZAErG9d5MtsGOqMNp9jSd0y4bTExhmsDjYFimxbYds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(2906002)(6506007)(966005)(186003)(8936002)(508600001)(36756003)(66556008)(54906003)(66946007)(38100700002)(31686004)(66476007)(83380400001)(4326008)(7416002)(6666004)(2616005)(86362001)(26005)(31696002)(6512007)(110136005)(8676002)(66574015)(38350700002)(6486002)(316002)(5660300002)(44832011)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWk2Sy90ZlVLUFQrUUEvT1psRjlJODlRQUxCRy9BZEVybnVSVGtCTGlMMG5s?=
 =?utf-8?B?ZnY0anFRSGVRUm1YK3Q2MnBBaW5XbENtanFOeGVNTlMvdFZ4TEt6cFErcUd4?=
 =?utf-8?B?SnZaeitBNG5ZVGxOcnpaYXdMZW9pa2FiSHZ0MTBwMnB2QXM2MXBXdGxxRS9T?=
 =?utf-8?B?ZzNVSDdZUW1ia1JoaHlQZno4TFhQeCszR0FuVzVYUWRGWUhBQ21qcHA3clRx?=
 =?utf-8?B?U2JtazRXSUl4VmdORHozQXZseEdVYXo2c0NsQ1BEdlFpaitPT3hYRWNCRjJR?=
 =?utf-8?B?NkJxOFN5SWdxMWYxMkwwa2J0Vmh2bDdhdTZ4bzdIZ2tSWXc2enVQWGJCVEpy?=
 =?utf-8?B?empYOWN1T25wZkdNRnJnTFl6cWJsVXdVYUxlWUpTOUpkMmVmT2R2R1dWYU5R?=
 =?utf-8?B?aVhkdElBWHNaeWtyUlkyNWxyelVpWUh1b095Ulk0cFAzclJ3aHhFelVJMXN2?=
 =?utf-8?B?Z2JDc281L2tYZTRoUWJMYUFOcWJHN1JOVjRlSEt3Y1dRQTlFcnRWYnVXN0dL?=
 =?utf-8?B?cjAvdUE4dExQNWhFdUlsdHllUmdOck1wNm9Xd1liWXdGM2QrNmtzdnJoOTd2?=
 =?utf-8?B?Z2ZZWVc2SFdjQlNRbWV5QzBnZ01yVmhUSzZBckdxbmlkSXFmQW1qUnI3M1JH?=
 =?utf-8?B?V3B0S1Q3c0x4Ty9sMFlWN3NMRVRxcWZYUUJ3N2kydGVYcUZMdEk2NDFwb0Nv?=
 =?utf-8?B?Z3lyTTRZd1g2Z1g5aUdmVWpURnc1UXNlamZ0VEtpQ2Z3dzRRYWp3VGZxOGI2?=
 =?utf-8?B?Nm1BcEJYU2dIKzc4UkNrbjR6RDluM1NPVy9wcjZzK0ZaUUJ3UU5jQ3k0Sm5K?=
 =?utf-8?B?WDNWbVJpZzhveUtzZTZ6YkEwcWVyLzBEN0locGIyU0RnY1d5SlEvVjZUdVBG?=
 =?utf-8?B?dTgvZkU5ZFBFeHMxZURQdVJCWDFsZzMvNHprWHl3WWRhZERzOGxMTVJzM3M1?=
 =?utf-8?B?aGlJU081T1lScngzRjQxTm5YaUFNUkxZWWJCQkdhdTFtbkFvN2lEWDNUZWVF?=
 =?utf-8?B?VW4zUExmQm5JK2o3MkVRUmR2cXNZUVg5MDlVcXlRaGUrdWRtL24wSzFqai9m?=
 =?utf-8?B?S3IyTjhvZUhiS1VvL01udmFzVjFqSzZBVUZYM1ZIVkZrUW1OamQ0NXFuSGtD?=
 =?utf-8?B?cDlCallRYXNHeWEza3Q3UUhyM2FWcWNUYXhEMXRwaThRVU9NYzhxZG1SZmFw?=
 =?utf-8?B?UzR3aTdROUNUNm1qQnZrRksyMUVBUEdZQXducDFOWVpNdVZ0MmVxR0JkcTVN?=
 =?utf-8?B?RWRVTGtoSWV3dmtvWDU0M3VONDIwUXRxdHR1Sy9NVUliZEpPYVFjcnJNTmMw?=
 =?utf-8?B?eFlNOFhwa1dQeUNPVldpTUpxanlHMTRxQlMxU3A4Sjg0bnRySnpZNDVSWFFH?=
 =?utf-8?B?bVlDbk5Na1Q4cVJYN1lHZytIN0psZ0JBN25DZUZLcHY2WFkwN1RadzBCT05i?=
 =?utf-8?B?S1ZYdnl3RlBGd0lsR3pSU2tEWG5Mbit5cnJ5MWEwMGxTNUJQYXgvZ3h5SWky?=
 =?utf-8?B?YkgvRHd3RUVEL1E4bWt6aDF3djVLSHdWU3VTSVRlRzJVZi92VXhSajBpVjkr?=
 =?utf-8?B?eFpodEU3UDg3MGpmZHQzOThicDI0SU9Xb2h2anQ3QzgyZTI4MFNFZ1ZzUjMr?=
 =?utf-8?B?c1RlNmFuQkMvUDRNWHQrTlhqSGFGYXIrS1BGK1dsd2dJQ2tFbnY5VUZJeE1M?=
 =?utf-8?B?WElheFc3cHpYUmd0WXZ1SHhYdHpBK0JReWtGcXdwbzRmZWFBcytoVTdTQjJt?=
 =?utf-8?B?SHh5TjZlUHZkdjZSTy9GNFZwa1VUdS8vOUFuR2pZVzczcW9QOHdmZG9lTDB2?=
 =?utf-8?B?RnBYR24xMi9DM0kraEQ1bjhWTVdYRnJUbHhIa0pQb1FyK3pPZXhWa21LUDJW?=
 =?utf-8?B?LytzN3lEOVpOM0Frb002VmVUek1taUxET2t2azVKU2UwU001VFlQUlZ3Ynp3?=
 =?utf-8?B?ajJFTVJjWG11VnlPWThLVzVyUXBZQmZSUnM1UFc5MFBGWVZLVXM5bHh1Rmd5?=
 =?utf-8?B?QkRXQ3hWNWgrU294TFdWLzRIOUJvUm1SeXZob3F0WnN1N09IUmRtQ3VSNkdK?=
 =?utf-8?B?MVYyb0ZWeWNGTEdjY3p5T2VvMm81QkUzMUMrb0p0Vkt1UE13cndQUWFDZ0NL?=
 =?utf-8?B?WWZtdGI1VjFUTWlydnJUenVkdGdJZlNuNE9QOE91aXlSWUpDaUxqWmErbjd4?=
 =?utf-8?Q?piy4qiL1+L6uT8yRpAgLf2s=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669793af-727b-4863-18db-08d9bf2ac6a6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 17:54:29.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/3GM7k40VBRiAIxqynN18+YJ9JalZpVbN3eIGtfRClsKthYKP13T/zElVDUoU//6+nCgoFBRwNGioQ5X4UGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 12:39 PM, Mubin Usman Sayyed wrote:
> Hi Sean,
>
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@seco.com>
>> Sent: Tuesday, December 14, 2021 9:16 PM
>> To: Mubin Usman Sayyed <MUBINUSM@xilinx.com>; Michal Simek
>> <monstr@monstr.eu>; linux-pwm@vger.kernel.org;
>> devicetree@vger.kernel.org; Thierry Reding <thierry.reding@gmail.com>
>> Cc: linux-arm-kernel@lists.infradead.org; Alvaro Gamez
>> <alvaro.gamez@hazent.com>; Lee Jones <lee.jones@linaro.org>; Uwe
>> Kleine-König <u.kleine-koenig@pengutronix.de>; Michal Simek
>> <michals@xilinx.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v11 2/2] pwm: Add support for Xilinx AXI Timer
>>
>>
>>
>> On 12/14/21 4:08 AM, Mubin Usman Sayyed wrote:
>> > Hi Sean,
>> >
>> >> -----Original Message-----
>> >> From: Michal Simek <monstr@monstr.eu>
>> >> Sent: Tuesday, December 14, 2021 1:38 PM
>> >> To: Sean Anderson <sean.anderson@seco.com>; linux-
>> >> pwm@vger.kernel.org; devicetree@vger.kernel.org; Thierry Reding
>> >> <thierry.reding@gmail.com>
>> >> Cc: linux-arm-kernel@lists.infradead.org; Alvaro Gamez
>> >> <alvaro.gamez@hazent.com>; Lee Jones <lee.jones@linaro.org>; Uwe
>> >> Kleine-König <u.kleine-koenig@pengutronix.de>; Michal Simek
>> >> <michals@xilinx.com>; linux-kernel@vger.kernel.org; Mubin Usman
>> >> Sayyed <MUBINUSM@xilinx.com>
>> >> Subject: Re: [PATCH v11 2/2] pwm: Add support for Xilinx AXI Timer
>> >>
>> >> +Mubin
>> >>
>> >> On 11/24/21 00:25, Sean Anderson wrote:
>> >> > This adds PWM support for Xilinx LogiCORE IP AXI soft timers
>> >> > commonly found on Xilinx FPGAs. At the moment clock control is very
>> >> > basic: we just enable the clock during probe and pin the frequency.
>> >> > In the future, someone could add support for disabling the clock when
>> not in use.
>> >> >
>> >> > Some common code has been specially demarcated. While currently
>> >> > only used by the PWM driver, it is anticipated that it may be split
>> >> > off in the future to be used by the timer driver as well.
>> >> >
>> >> > This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>> >> >
>> >> > [1]
>> >> >
>> >>
>> https://www.xilinx.com/support/documentation/ip_documentation/axi_tim
>> >> e
>> >> > r/v1_03_a/axi_timer_ds764.pdf
>> >> >
>> >> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> >> > Acked-by: Michal Simek <michal.simek@xilinx.com>
>> >> > ---
>> >> >
>> >> > Changes in v11:
>> >> > - Add comment about why we test for #pwm-cells
>> >> > - Clarify comment on generate out signal
>> >> > - Rename pwm variables to xilinx_pwm
>> >> > - Round like Uwe wants...
>> >> > - s/xilinx_timer/xilinx_pwm/ for non-common functions
>> >> >
>> >> > Changes in v10:
>> >> > - Fix compilation error in timer driver
>> >> >
>> >> > Changes in v9:
>> >> > - Refactor "if { return } else if { }" to "if { return } if { }"
>> >> > - Remove drivers/clocksource/timer-xilinx-common.c from
>> MAINTAINERS
>> >> > - Remove xilinx_timer_common_init and integrate it into
>> >> > xilinx_timer_probe
>> >> >
>> >> > Changes in v8:
>> >> > - Drop new timer driver; it has been deferred for future series
>> >> >
>> >> > Changes in v7:
>> >> > - Add dependency on OF_ADDRESS
>> >> > - Fix period_cycles calculation
>> >> > - Fix typo in limitations
>> >> >
>> >> > Changes in v6:
>> >> > - Capitalize error messages
>> >> > - Don't disable regmap locking to allow inspection of registers via
>> >> >    debugfs
>> >> > - Prevent overflow when calculating period_cycles
>> >> > - Remove enabled variable from xilinx_pwm_apply
>> >> > - Swap order of period_cycle range comparisons
>> >> >
>> >> > Changes in v5:
>> >> > - Allow non-zero #pwm-cells
>> >> > - Correctly set duty_cycle in get_state when TLR0=TLR1
>> >> > - Elaborate on limitation section
>> >> > - Perform some additional checks/rounding in apply_state
>> >> > - Remove xlnx,axi-timer-2.0 compatible string
>> >> > - Rework duty-cycle and period calculations with feedback from Uwe
>> >> > - Switch to regmap to abstract endianness issues
>> >> > - Use more verbose error messages
>> >> >
>> >> > Changes in v4:
>> >> > - Don't use volatile in read/write replacements. Some arches have it and
>> >> >    some don't.
>> >> > - Put common timer properties into their own struct to better reuse
>> >> >    code.
>> >> > - Remove references to properties which are not good enough for
>> Linux.
>> >> >
>> >> > Changes in v3:
>> >> > - Add clockevent and clocksource support
>> >> > - Remove old microblaze driver
>> >> > - Rewrite probe to only use a device_node, since timers may need to be
>> >> >    initialized before we have proper devices. This does bloat the code a
>> bit
>> >> >    since we can no longer rely on helpers such as dev_err_probe. We also
>> >> >    cannot rely on device resources being free'd on failure, so we must
>> free
>> >> >    them manually.
>> >> > - We now access registers through xilinx_timer_(read|write). This
>> allows us
>> >> >    to deal with endianness issues, as originally seen in the microblaze
>> >> >    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>> >> >
>> >> > Changes in v2:
>> >> > - Add comment describing device
>> >> > - Add comment explaining why we depend on !MICROBLAZE
>> >> > - Add dependencies on COMMON_CLK and HAS_IOMEM
>> >> > - Cast dividends to u64 to avoid overflow
>> >> > - Check for over- and underflow when calculating TLR
>> >> > - Check range of xlnx,count-width
>> >> > - Don't compile this module by default for arm64
>> >> > - Don't set pwmchip.base to -1
>> >> > - Ensure the clock is always running when the pwm is registered
>> >> > - Remove debugfs file :l
>> >> > - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>> >> > - Report errors with dev_error_probe
>> >> > - Set xilinx_pwm_ops.owner
>> >> > - Use NSEC_TO_SEC instead of defining our own
>> >> > - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested
>> by
>> >> > Uwe
>> >> >
>> >> >   MAINTAINERS                        |   6 +
>> >> >   arch/microblaze/kernel/timer.c     |   3 +
>> >> >   drivers/pwm/Kconfig                |  14 ++
>> >> >   drivers/pwm/Makefile               |   1 +
>> >> >   drivers/pwm/pwm-xilinx.c           | 318
>> +++++++++++++++++++++++++++++
>> >> >   include/clocksource/timer-xilinx.h |  91 +++++++++
>> >> >   6 files changed, 433 insertions(+)
>> >> >   create mode 100644 drivers/pwm/pwm-xilinx.c
>> >> >   create mode 100644 include/clocksource/timer-xilinx.h
>> >> >
>> >> > diff --git a/MAINTAINERS b/MAINTAINERS index
>> >> > 5250298d2817..b2b3ce106e99 100644
>> >> > --- a/MAINTAINERS
>> >> > +++ b/MAINTAINERS
>> >> > @@ -20897,6 +20897,12 @@ F:	drivers/misc/Makefile
>> >> >   F:	drivers/misc/xilinx_sdfec.c
>> >> >   F:	include/uapi/misc/xilinx_sdfec.h
>> >> >
>> >> > +XILINX PWM DRIVER
>> >> > +M:	Sean Anderson <sean.anderson@seco.com>
>> >> > +S:	Maintained
>> >> > +F:	drivers/pwm/pwm-xilinx.c
>> >> > +F:	include/clocksource/timer-xilinx.h
>> >> > +
>> >> >   XILINX UARTLITE SERIAL DRIVER
>> >> >   M:	Peter Korsgaard <jacmet@sunsite.dk>
>> >> >   L:	linux-serial@vger.kernel.org
>> >> > diff --git a/arch/microblaze/kernel/timer.c
>> >> > b/arch/microblaze/kernel/timer.c index f8832cf49384..dea34a3d4aa4
>> >> > 100644
>> >> > --- a/arch/microblaze/kernel/timer.c
>> >> > +++ b/arch/microblaze/kernel/timer.c
>> >> > @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct
>> >> > device_node
>> >> *timer)
>> >> >   	u32 timer_num = 1;
>> >> >   	int ret;
>> >> >
>> >> > +	if (of_property_read_bool(timer, "#pwm-cells"))
>> >> > +		return 0;
>> > [Mubin]:  Can you please return  -ENODEV here,  PWM driver would not be
>> probed if return value is 0.
>>
>> This needs to return 0 so that timer_probe doesn't spuriously announce the
>> "error".
> [Mubin]: I am trying similar implementation for cadence TTC timer. I observed that, pwm driver is not getting probed, if 0 is returned from clocksource driver (based on pwm-cells property).

I believe that is because the ttc is not used as the primary
clocksource, and so is probed by usual methods (e.g.
call_driver_probe). TIMER_OF_DECLARE drivers get set up before the rest
of the driver model is set up, and timer_probe probes them manually.

--Sean
