Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18B4746BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhLNPqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:46:06 -0500
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:18432
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229752AbhLNPqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:46:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTRaXIeGwzvIWrwVtaHY5KwVVNhQPRJ30fW3KnyCFrx3EMR8Ka+QFeiKHxwLxjlfA69JThTRy5tXM1zc79ZcOrWrQxLzBsW/5HwOzztrbod4Psl1C2FQo562eSdXsTfn3hExCiFdirqQxOGY1ZTnnAHdNkZk+LbB39tjJozHRC/6ay4G6TXSp2hCEuQcN1+TNA6sPlMpreBA49GuH04vyJERkrMYZ8ksAc3f77+bEBOf4MLpWZV7fCVrLT6o66SeQMwk3CPKDukj1zQu8BftyAqEJuxnnazwV7gLf9ISpP+FMdDdMl6N0PkVbQeBZuQXixIzr+kcVB0YVLognMrtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZsDhuTqLj2RvQ2b8c2BJCAmP+WgeDMR8j671RkSIJ0=;
 b=M9VjOCI3MoGbwRV70Syr5Y58BwIQxeeWzNtwd3Ej/ZirZ54EJMzgKlIhMLDet6EFm0e4MlRdwpXLAFPOQXjuPNmpEJ30taRJ+SkPL23nnacolMMqIK7nwf/0Z/sWSqSjpfsGH7UOL+SxMWtPaZNF5LnONbscw4zRlEzN8uf/nr0TztDAc+9/oxFXboDHumqkxOfhGEqNrRNeL2UgEH8kZwhpYjqq5JQ7Nk800QZAL+ZDO0/bez5VmgvSnh67567k2vzLWIZS0tLeWlaJuV8Uome8wTUMMrP5O5Iz+bVtEcmHyCSNTpPxpragH22O8HhYe4/AHNEuZAeXQybD2ML6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZsDhuTqLj2RvQ2b8c2BJCAmP+WgeDMR8j671RkSIJ0=;
 b=dhjM/lVi4sQlHjCa7jLLI4C1MC0o9QMJckLk7HfSL7oebwFu6siaGvnJy7Vph3fxm3EuFJAlC3/nBRtiwijagApVIai0QJqFVKRv3WVKL41OCSVbwlVYxwFOMTtGxIj76svr9bSFfV6n9/4kyjWOg32Fx+oRQvDOOVsIr/AfrO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7051.eurprd03.prod.outlook.com (2603:10a6:10:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 14 Dec
 2021 15:46:00 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 15:46:00 +0000
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <91cfadf3-fe9e-398c-e563-c700522bba06@seco.com>
Date:   Tue, 14 Dec 2021 10:45:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BYAPR02MB4278A250C64CEEAED222A785A1759@BYAPR02MB4278.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::29) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 490fab0f-fc3f-4afa-7afa-08d9bf18d3cc
X-MS-TrafficTypeDiagnostic: DBBPR03MB7051:EE_
X-Microsoft-Antispam-PRVS: <DBBPR03MB70517B738B1E5E72C5FFB39596759@DBBPR03MB7051.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqP/5gF374cQ1ExEldsKMgRRmfB10CSzaz27hDRAqmlU/HI16SNuQiPbDubmz9IQ/cyD8bKeeIDxX0rpHr/YmfeGCLo/FkCXPcN/h7A/r/e1itUxMTLWtWxnytAnTCAsE5E+LC+HRtUsE16pQ/mBPkBN17oR2zNYVypY14WmxNhPBbhzYIahPOfeAVPCXE7XPstgt650q+OtzBc0u8BDMR+CbfKZ4TpjLmggzWyuSYZKmPW0hwTSmB8ydSc7LM3X1T73qhpDuOII4SUcXQH42Aqr+sJJwj+8/zDz7vYSyPpvZUgvIVlsWZ15H3BZymh0ArjWNPTzijuzUEZ0QFwzU2E3xC0dVz3wnpJx9sNN8afexTMiwytJ9hW/k9wIBy6R8upeDq48cFDeIjhHo9StS7sLZm6Y/aE4sdAI4CzD57efHGpwsAB9LbJfPtzIz9RVzHSeqbNqX8VQagGk8t2gXagquaN3Crb2K9SKA3KEXtGIRyKDY0eS1k4qCj7xDq3xJk+FUJDgAQBdqBkKtHawsqYfDa78jbhUn4O2wuAGWBXmC/GCr/u46RUpQuYjyi+CTsL4B45oQjaNBtLw5RF34ml0pgQ5/+Bn0zMrR30K2eQyfKzfigHAGAKx1K9L50iA7DztZu+T0cG0ZSZhIv27LAsFo25DnSr0Ygp/45+hLFYKn8R/JNL2iL1pHRGqhfEvlM/Ilx49TuWiI2qfPNGNcBQ0qtj6tgcHIskbk4Fiih/hIw+KpqkrWd14AnpzSSxnl9sa7CaM939vIafIHCKvx8cnFxaksbFDhRJufKKxr30Bmqyxtuc2M7SkUuWnGSNl4uzD9Nw2OJTEvdFJ+iHXOoe4FWIGcl3RGpxtLFvfJCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6512007)(31686004)(86362001)(508600001)(2906002)(31696002)(4326008)(316002)(8936002)(52116002)(6486002)(186003)(66476007)(38100700002)(53546011)(110136005)(66946007)(26005)(6506007)(44832011)(54906003)(7416002)(38350700002)(5660300002)(966005)(36756003)(66556008)(2616005)(83380400001)(66574015)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNyZCs3cDJGQ2g5TDQ2RkZ0WUhqRnFvbGFIbmFCSExSZUlndDVXWUpIdFpY?=
 =?utf-8?B?YU9IelN2VHJ0ajBMREM2OFRYdDJoWDB4SnV6SzVsREtGWmRtemxmTjRIVTZZ?=
 =?utf-8?B?RFVia2xBSWIrUkM4aWlzdVc2ZUVkVVR2SWlUc285S2x1YWsyclErZ3NWMzB5?=
 =?utf-8?B?bjF1SEtlY2QrOHppTkE1VWlzd0gyMkZ0bzBKUm42ZlhiK3QvT092OGNuQUJX?=
 =?utf-8?B?OWNacHJVR2pTbXh6WS9LbjJPS2oyWkFGZjUrVENUR3hCQ0t4NTF4Q2ZQcWlQ?=
 =?utf-8?B?c0pzYmpKK2FFVk5KWUpud1psQzBaSW5mZkxURVJQb2wweHNia05saEYxZmJs?=
 =?utf-8?B?VFI1TCtNcURxZ2FOOGMxWThhaitFRUlOT0Yrc2JtcUVGdEk4eW5uRGZtQjFT?=
 =?utf-8?B?NUtZa2ZpTnJqUFBiaWZSNGVHL3lFbGp4TXBCMGNvV0tkV3hCdng4N1pSNnlF?=
 =?utf-8?B?ZDVjMXRuaXdJVExkWE9qWFMrWjgxVmN3RXlmOW9SbmxSWjJRbm0vK0hVU3Js?=
 =?utf-8?B?U0dTM2doNkZyalJGS1Jram9uWG9SNzljelV6Z1ozY2ZRQVVDWW11ZG00dFIz?=
 =?utf-8?B?THEzQ3YrUUN5NVBDc0xBdUh3REdYampZWXRjN1NEbTlIbTdrOW5LVSsrNytN?=
 =?utf-8?B?RUJ6OGNDMFJKMlFlYlJPdFh0Mks4L1BaWWZGSitRSnhobHh1TjRVczZweE1O?=
 =?utf-8?B?MWQxa2kydzd4YjdzRlBHTUVYNmhxY1dubFpsZHh3aXVXYWtoZCtsMElBUU05?=
 =?utf-8?B?aSs1UTB5STJQVHBVYmphd3RpN2tDNHNaRUZHUEZieEZySFJkMmRZalhmcDVH?=
 =?utf-8?B?clozT01DcC9IT2xjL1dXMWZYbmorOW1ManNrYUdhQUNoYS81WDhwSmZST3A1?=
 =?utf-8?B?dWtXcmdZL21CaFlGMHkwWEp2ZHhJUWpiaVB4aDdkUGNGZEFZaWMvL0I3ck1a?=
 =?utf-8?B?UDVZbnVIRGV5dlVMK0pxQk8zaktRVUJoQlNZVjkwNnFzTGtjZHFYalNMRHY1?=
 =?utf-8?B?VGVkM1UrUU5xTXB1RXRKaW5LQzJvZzBqWlA0Y01VQXo2eXhKNWYya0xqSE50?=
 =?utf-8?B?RHhGNTV4ajZ2ZU5pakszVnlGTCt3QnBzTTdxbmJUMnRaajdZaFZRUktnS0R3?=
 =?utf-8?B?b3FqMjJINXpDMDFjZjNlTldLaFhzYUpvMGd3SkxwNStGVVRTNEo2S1BreDdZ?=
 =?utf-8?B?MUZRSXNUQW1Ib1RsVnh5aGc3Y3VQNmxJcitBcXcrQlllMWNEQTVnQytNUVF0?=
 =?utf-8?B?cVJpZS9nWGRGc1VyUUZRRUNpRzdqZUtIcnRGdmFlWGJhWTlualBBcFVMZXdi?=
 =?utf-8?B?YnRBVllmNUxqSDJKcjRwUUZjRmZNd1h1Qitpb1ZwQmRydllkWUZ6UFgxU3VP?=
 =?utf-8?B?dzUwVC9RWXhHemN6c1VrMnRQeVVpVTk3V3ZOSlJUNXY0bmNHUEs5RTRVak9r?=
 =?utf-8?B?Q0puUkpqM0l3T0JxTmVqeDJ1dnVpYmxwUzR4eDZ6WWxMYlJDZUVEbG9ZYXVx?=
 =?utf-8?B?elZiTnVRMVRCQVdzZmNKMFlObzUzajBXRlBvMnh1aVd3eVlSUHdweDNNbnhD?=
 =?utf-8?B?VXR3RzdIYm1pMWQyKzdiOGlZSUh4Mm5mTi9tYTVHODBaWlBaYUJlRnVHbXhD?=
 =?utf-8?B?RzNaaHN4cm9rell0MkVNY3U1Z1hEMnVpOXRlUWFXK00yUzNLdUloTnp4TmE0?=
 =?utf-8?B?alVQbjZMWmg0K095VDM1VE0rYkFFb1FuRlZzQ0RZNFliY21Rd2FYOFZPS0Rv?=
 =?utf-8?B?QUM2ZXpxbDFLYnZuT2V3bjBPQ2cydzVYeHhZeFRnUHJuYy9hWitkcnVOeXVX?=
 =?utf-8?B?V2E3em42SFJ0bnR5Y3lPWmQ2QmcvbUZOSXpOQ3NoMXBOVzBGdVJ5eW5ZVGR4?=
 =?utf-8?B?L1VaRFlSUzdORUJsVGhyLzdUR1Y5R3dLbXUrM2NsQWZjMDZYK0pPZ3JibFpU?=
 =?utf-8?B?czVZMDJVOTZDRGszUVp5K0lFVE9tMXpWNzVTUi9KQm1yd3NFcDN0QlFZNzRW?=
 =?utf-8?B?RXo2bEZXUzhqVzFtUlczcFE5VGE3c212RGhuc0MwWktaRnkxUHVVREtoMkZ2?=
 =?utf-8?B?UUZVaUV1MkI5SkxuSlIyTEh4QUErQ21EWkd1M2d3elp2Z1cvbVVHMFhQWnlW?=
 =?utf-8?B?b0p3SDhxYitnU01XeXZaL2ZudmgxSE5oUlZiK2xENjdmTEQzczdtRkEzRW5F?=
 =?utf-8?Q?WdJmTZVk/KxfQrlwPgb2v9k=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490fab0f-fc3f-4afa-7afa-08d9bf18d3cc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 15:46:00.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qAHGypBLhNfpLsTdp+UrujONRv5Y1MXnJMm+t1mzPB6Tg6wG+9hzE8YOdaF1Jtw1UUUzwNZDZvUHysil4jr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 4:08 AM, Mubin Usman Sayyed wrote:
> Hi Sean,
> 
>> -----Original Message-----
>> From: Michal Simek <monstr@monstr.eu>
>> Sent: Tuesday, December 14, 2021 1:38 PM
>> To: Sean Anderson <sean.anderson@seco.com>; linux-
>> pwm@vger.kernel.org; devicetree@vger.kernel.org; Thierry Reding
>> <thierry.reding@gmail.com>
>> Cc: linux-arm-kernel@lists.infradead.org; Alvaro Gamez
>> <alvaro.gamez@hazent.com>; Lee Jones <lee.jones@linaro.org>; Uwe
>> Kleine-König <u.kleine-koenig@pengutronix.de>; Michal Simek
>> <michals@xilinx.com>; linux-kernel@vger.kernel.org; Mubin Usman Sayyed
>> <MUBINUSM@xilinx.com>
>> Subject: Re: [PATCH v11 2/2] pwm: Add support for Xilinx AXI Timer
>> 
>> +Mubin
>> 
>> On 11/24/21 00:25, Sean Anderson wrote:
>> > This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>> > found on Xilinx FPGAs. At the moment clock control is very basic: we
>> > just enable the clock during probe and pin the frequency. In the
>> > future, someone could add support for disabling the clock when not in use.
>> >
>> > Some common code has been specially demarcated. While currently only
>> > used by the PWM driver, it is anticipated that it may be split off in
>> > the future to be used by the timer driver as well.
>> >
>> > This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>> >
>> > [1]
>> >
>> https://www.xilinx.com/support/documentation/ip_documentation/axi_tim
>> e
>> > r/v1_03_a/axi_timer_ds764.pdf
>> >
>> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> > Acked-by: Michal Simek <michal.simek@xilinx.com>
>> > ---
>> >
>> > Changes in v11:
>> > - Add comment about why we test for #pwm-cells
>> > - Clarify comment on generate out signal
>> > - Rename pwm variables to xilinx_pwm
>> > - Round like Uwe wants...
>> > - s/xilinx_timer/xilinx_pwm/ for non-common functions
>> >
>> > Changes in v10:
>> > - Fix compilation error in timer driver
>> >
>> > Changes in v9:
>> > - Refactor "if { return } else if { }" to "if { return } if { }"
>> > - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
>> > - Remove xilinx_timer_common_init and integrate it into
>> > xilinx_timer_probe
>> >
>> > Changes in v8:
>> > - Drop new timer driver; it has been deferred for future series
>> >
>> > Changes in v7:
>> > - Add dependency on OF_ADDRESS
>> > - Fix period_cycles calculation
>> > - Fix typo in limitations
>> >
>> > Changes in v6:
>> > - Capitalize error messages
>> > - Don't disable regmap locking to allow inspection of registers via
>> >    debugfs
>> > - Prevent overflow when calculating period_cycles
>> > - Remove enabled variable from xilinx_pwm_apply
>> > - Swap order of period_cycle range comparisons
>> >
>> > Changes in v5:
>> > - Allow non-zero #pwm-cells
>> > - Correctly set duty_cycle in get_state when TLR0=TLR1
>> > - Elaborate on limitation section
>> > - Perform some additional checks/rounding in apply_state
>> > - Remove xlnx,axi-timer-2.0 compatible string
>> > - Rework duty-cycle and period calculations with feedback from Uwe
>> > - Switch to regmap to abstract endianness issues
>> > - Use more verbose error messages
>> >
>> > Changes in v4:
>> > - Don't use volatile in read/write replacements. Some arches have it and
>> >    some don't.
>> > - Put common timer properties into their own struct to better reuse
>> >    code.
>> > - Remove references to properties which are not good enough for Linux.
>> >
>> > Changes in v3:
>> > - Add clockevent and clocksource support
>> > - Remove old microblaze driver
>> > - Rewrite probe to only use a device_node, since timers may need to be
>> >    initialized before we have proper devices. This does bloat the code a bit
>> >    since we can no longer rely on helpers such as dev_err_probe. We also
>> >    cannot rely on device resources being free'd on failure, so we must free
>> >    them manually.
>> > - We now access registers through xilinx_timer_(read|write). This allows us
>> >    to deal with endianness issues, as originally seen in the microblaze
>> >    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>> >
>> > Changes in v2:
>> > - Add comment describing device
>> > - Add comment explaining why we depend on !MICROBLAZE
>> > - Add dependencies on COMMON_CLK and HAS_IOMEM
>> > - Cast dividends to u64 to avoid overflow
>> > - Check for over- and underflow when calculating TLR
>> > - Check range of xlnx,count-width
>> > - Don't compile this module by default for arm64
>> > - Don't set pwmchip.base to -1
>> > - Ensure the clock is always running when the pwm is registered
>> > - Remove debugfs file :l
>> > - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>> > - Report errors with dev_error_probe
>> > - Set xilinx_pwm_ops.owner
>> > - Use NSEC_TO_SEC instead of defining our own
>> > - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by
>> > Uwe
>> >
>> >   MAINTAINERS                        |   6 +
>> >   arch/microblaze/kernel/timer.c     |   3 +
>> >   drivers/pwm/Kconfig                |  14 ++
>> >   drivers/pwm/Makefile               |   1 +
>> >   drivers/pwm/pwm-xilinx.c           | 318 +++++++++++++++++++++++++++++
>> >   include/clocksource/timer-xilinx.h |  91 +++++++++
>> >   6 files changed, 433 insertions(+)
>> >   create mode 100644 drivers/pwm/pwm-xilinx.c
>> >   create mode 100644 include/clocksource/timer-xilinx.h
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS index
>> > 5250298d2817..b2b3ce106e99 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -20897,6 +20897,12 @@ F:	drivers/misc/Makefile
>> >   F:	drivers/misc/xilinx_sdfec.c
>> >   F:	include/uapi/misc/xilinx_sdfec.h
>> >
>> > +XILINX PWM DRIVER
>> > +M:	Sean Anderson <sean.anderson@seco.com>
>> > +S:	Maintained
>> > +F:	drivers/pwm/pwm-xilinx.c
>> > +F:	include/clocksource/timer-xilinx.h
>> > +
>> >   XILINX UARTLITE SERIAL DRIVER
>> >   M:	Peter Korsgaard <jacmet@sunsite.dk>
>> >   L:	linux-serial@vger.kernel.org
>> > diff --git a/arch/microblaze/kernel/timer.c
>> > b/arch/microblaze/kernel/timer.c index f8832cf49384..dea34a3d4aa4
>> > 100644
>> > --- a/arch/microblaze/kernel/timer.c
>> > +++ b/arch/microblaze/kernel/timer.c
>> > @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node
>> *timer)
>> >   	u32 timer_num = 1;
>> >   	int ret;
>> >
>> > +	if (of_property_read_bool(timer, "#pwm-cells"))
>> > +		return 0;
> [Mubin]:  Can you please return  -ENODEV here,  PWM driver would not be probed if return value is 0.

This needs to return 0 so that timer_probe doesn't spuriously announce the "error".

--Sean
