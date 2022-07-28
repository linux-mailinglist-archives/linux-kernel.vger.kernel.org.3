Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2E584371
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiG1Pnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiG1Pnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:43:51 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00058.outbound.protection.outlook.com [40.107.0.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD36A9C5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZVH3tDQ6ZpkrDEXe4L54z8U69Vopi5mflv9jP8MC7LEm0gJDK8SPCiQh5v8a5juQAtCYLoNcJdKw/XsF28vMdtADmyus7rORr9frf8vTKwa0WCA0FURgEuprtxAieI5MzL4CLRVW//cZ3xWu37SGzrfOv126jK9llVm3nrjjp4FSZDC77XLKXI0BJUCGR+Ok8lOwKDywUGCAhNnYtZcAFrpR7Lf9fypvSguY95vAnrWeUOLlX8JZ43XqCie3z/9Z0IrjH4fQkJAXXZ5X7a0O+GouQfLRR7cLt12wk3KrJElFOorPzJSzSEallT0FaoP25dKEafIDL8PAx5yVIraMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKlfxbaNihXnMv6vTrY34Uu6KyfRX3UEmk06mKell+w=;
 b=cTli58Y+598v7LGvZohSGhUsoHuYSX2QwuYXx8H+nBFLD3Wp97ANwdkLlUjFJ4MI7wFmvzvOTU0Rn76HS/3Xc8PNSmOb+JnpyoHnABATIZtNd+R61eW5hgbEhH6Xh4LCPPjgcfAdRHK5GaOmhagcDQxd4L8exxljoMCxe/RS5JYDIwgovCtsK0Qs5Sm2g1oefPk0+/CP6oBGHXPCqb5dYwVitmC32ukTK6+0yOvhAUpGZqBPk6/4bsn/dVafBQ+cfBthLOdovL5YD4NRXpzmuHM2KwIoKmeNr2sUOzmAf3Ju1F0yOJNlg6PdAnG00bO4duIb1RCvmmHIcZiHEi7M5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKlfxbaNihXnMv6vTrY34Uu6KyfRX3UEmk06mKell+w=;
 b=VXwOpDnydCjTY4o+GmutpA0XuAbjsAH96adJCFVPjhjNC7oEpw3MxYrZMR3PkhlLZbz5zCOxPs4BajNqBpvwr2qvxNfDREzhweTHa02/EwjlhVvLVyBWcU/U2rWi9XCdZt8E4tojxMXjueseaJ8JUOgvpZtX0ZnrgG2tlxOla4MGmctOoKtCYcD1XNUkhmOFtxA1XUxGyOxRrdbyaUaKVyEeCwpsm1qoCoPni8oZ7CfbiTHbh8JKbopWoxdccXFF31IOAmIMopNLL6xhbCmDQDiThRYKcxYzzJwjV39CklDm7Kfbl/SbD1z6wjqTGCq6V60DnYUgMD9yNo9vi7BIvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com (2603:10a6:803:c5::12)
 by DB7PR03MB4121.eurprd03.prod.outlook.com (2603:10a6:5:33::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 15:43:47 +0000
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::3974:3665:ac2:906]) by VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::3974:3665:ac2:906%4]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 15:43:47 +0000
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
 <501b52ba-7691-0263-c007-38174c7e5c22@seco.com>
 <20220728152815.6h4ytx52ll2gzjj3@skbuf>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <532c8141-2a8b-6842-c9a2-cc4d17afd73d@seco.com>
Date:   Thu, 28 Jul 2022 11:43:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220728152815.6h4ytx52ll2gzjj3@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:610:4e::24) To VI1PR03MB4973.eurprd03.prod.outlook.com
 (2603:10a6:803:c5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870ef600-8cc3-489f-2762-08da70aff59e
X-MS-TrafficTypeDiagnostic: DB7PR03MB4121:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2jenfSS9KsTU4ZJ5EtaCq4i3Tx9NN3ezm0SgXlwVqIHM9mi/uy3fq9SVSi398HG0btabmKDrexshjGDwI3kbT+t6gXOjwx6qqjOA0E/HwjvLWASJ9ifiwGhu2fOREeurFWSRwdBrby5filS2ZFifuf89Rh12K3CReYcKANdEkd3P+0Sbec7pwFGLIDFUstVA7pJAPI1JcIbkVgrlCOYN9WBuz0nT7HR5f+dtgHumxig7CKSwu4Kk0SP8WZ9rRGeYG0Ofj5LhfEAUszMuTpmiLuDs92vxq8DczZJ48m0PMCY9jB7ftTAyHDKH33E0spG6d5h6YeVZ/2uBOX1wcklfOGRBAoAxCzxiXrapOFyOQZoal1bfkLH6H8pu/lweae2VpEcA6YRftA2f2F2Xm7SxWthsM7GosKTK2HbT3OMVIv5F3w8ctUCoQ9FQrF4qX2pBd1lb08pF3aT2Nknp2M4MlOnsbU/8ERxBKbwGH9q58CgE9PJ7qfGk0882A61lzs2XApGVNY38mXeAKBhR5FGGwNMQ6TfImLFBpUCmPf2MhwLz5PhFMxj5SF2zHG0hdkafHMZbdo6zsJQThJHh2kd9u4YYyE8XN8xCDp/7rRTGLVDJ6PECbNZ2BTrWORuS93fSvd7hNwzb0FjDgiuWt7eOccF8zmt8+hioeXYPSCsL8D9GPSLDMUdadOUqyVTYGqfgP/qugnjFzv031kGeCrrVFYGSMPa7LXTrYIcCcnCNDsT19fLopQHVPwPKQFbWm4/dVsWtJvwO0Nhk0TWNmW3yC7FWcA9hLL4+XLl2tR2DpHMxogA8FeQUEyj5/bqv65ng0h97/MrJn5lG4TeWfmVesMDtKtaEfHHfx+cwVLBqMxKqsJyVSkGZlbQbZHundNGdiuflhTAFRaDKCSlddocAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4973.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(366004)(39850400004)(346002)(52116002)(41300700001)(6512007)(2906002)(478600001)(54906003)(8936002)(8676002)(6916009)(26005)(6506007)(66946007)(966005)(6486002)(316002)(44832011)(186003)(4326008)(66476007)(6666004)(66556008)(36756003)(38100700002)(5660300002)(53546011)(31686004)(86362001)(83380400001)(31696002)(2616005)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3AwaGN3c0xsbElQajh2L2xFckpCaFA5eGNScTgva1BseEJNdDl3RDAzbnpL?=
 =?utf-8?B?NWdhbTBhanFON1JVaVdjK2Nkdm00WStjSVZMaXNHejErMElleGRYREZhZHN1?=
 =?utf-8?B?Z3ZFL2F6aXg5cGJoUThmYUhoRy9tMzZMZXdjSWhXZGhKM09ocnVRYUNsWm82?=
 =?utf-8?B?azJMYVhPQ09ETVBMdk5ScnpRT1JYS2JSWWl5bFBqaHVLZGxHSWVXYmJWa1Ew?=
 =?utf-8?B?N01aL3lIZ2FXc3o1NlZCdFh3QWdqM3ZBUWphd041UWg1bVZnTHJ0aUpmelBv?=
 =?utf-8?B?d2V4cnQ5K1M5TEFocGZBbExNZ0QrNkUyQmtpTmNBTDRVL3kzdWJYVjdYaERS?=
 =?utf-8?B?Rkp4WVBsWEpMditrSnJSMlBsRngwTzJVOGtQN2F2eTVRZldIY2NSWWdQejBl?=
 =?utf-8?B?THBEMVJ2YVg1ajd2L0h3ZjRnTnNndU8yd3dzR2pQeXdVQ1BqTHhnQmxleDJI?=
 =?utf-8?B?cEtha3cxV0ZidytHWTB2cDZuRWNMQytSUlFvZnZTWENlQndKcVFRM1lyS1V4?=
 =?utf-8?B?Ti8vZzJaM2Fpb25vSTBpTEhENWZXMWNtY28rblllQXhaQXZnejFmdjgvaFhi?=
 =?utf-8?B?ZUxxeTJxdUZwcDdTUThxYnVxdFhSa3Flc3gzNElHWjZDSEdBWDNWYm5YUWNq?=
 =?utf-8?B?bkl3T1dxZUJTZGZtdTNWQ3c4T1pETDBVY0NTakV4NzlvWEdudkNvbDNEbUNt?=
 =?utf-8?B?Rjd2bnoyVm9ocTNzN3EwcDNFQzRpRzg4K20yRFpMRjBTN1V3NGhoeHVvdHlK?=
 =?utf-8?B?MnRZVm8yYU13V3NBNzRzdkRwaU5mR25MeWQxZHhYa0svM2VvWERYZ1ZXTmFm?=
 =?utf-8?B?Q2hSMzE2cEdzTDRMMWh0M2ZpamNDcGI0OWp1WG5qclg5UEJRTXZGZTlaU0N3?=
 =?utf-8?B?cHdleWhuQndnYTUrY0YwNDJsSy9lTmNQcnRkWGY5N3FIeGNHazk3TTRXYXJn?=
 =?utf-8?B?TkdveHZIb0RTYnRsQUw1S01lNnJJblkzbW1WNzVnbmEzVkg5Zmp3QzNRZkcv?=
 =?utf-8?B?YVU0aCtsYVVrNnhDaCtOWXJiZk9KeWdxejVkN1Znemx3OCsrcHFSQjA0WWdj?=
 =?utf-8?B?QVp2YTl3ZEtRV1IzMGNISFh6ZmJnNWE0N1NBWk02clJSK0tZazJ2ZElnbS9N?=
 =?utf-8?B?MG5JOVNlSTVxOG1nNmVieTRLQjhFeCtvYnNIWnRFV0QvSUtPdGptZXc5QVVF?=
 =?utf-8?B?Y3hlTklzZ08xdGZPWEsvbzI2Y0tWL0JGUjlVc2h6Ull1cVlqRXpEaHh1dm9z?=
 =?utf-8?B?SHF2MmxqcjRlNDRWdk9iNnFpVDAyRFhCT2FPb0Y5M3Jla2d3aWJ2d2x0b3NH?=
 =?utf-8?B?eTBCRmcxZEZBUmQvSHR0THZ3UU5tK3hyNFRleGdiYkt3b0Rld1U2SFYvS3dU?=
 =?utf-8?B?aFdJOU1UVGRURHZiSCtQdVJuU3N0VjhsemJsd0s3dEFXaGNnSHhvUFpaV0N0?=
 =?utf-8?B?OXNjZk84SENaYVJXYmhkVnhJbzlvaEprbUd1WDlqNkNaQ2Jpc0MzZnN5QUtD?=
 =?utf-8?B?dyt3N2RDTUNsd0k0bkhQcFpvWE96aTViZDZHczVaQSt0TWtKRU1mTlVYMHZ5?=
 =?utf-8?B?UUhPRXVybnlRMWowN1RoSkpDVUUyT0xvSWNWNDhKc2NGejlpM1gvbHZwVmVk?=
 =?utf-8?B?S2wxU3laNEdnY1haSG5xN3NvdDduUHkyYk1kRVdxTTdoZVYxWTRJMk5QUVha?=
 =?utf-8?B?bXkwWUZLbDczUU5VTlo4Vlh3ck1veGNmeUg5ZDNCeVNOam5VTVFTbkZGY25W?=
 =?utf-8?B?dG9GNlpHTi9JYUppYzRJUldyU1BvcUpqYjFOa2taMVJ4Yi9xRFFCYTRMS0sv?=
 =?utf-8?B?YUE1VFRKTkVEZ0FQdGk4QSt1NVBXM3pXenZLUWRoMHNGbE9DWW92UFVpNEYw?=
 =?utf-8?B?bVJwVEVFNWg2VFM5QlgyVUpISzRJUGxXMzZFUXZOOHVrTStpekQ4VFZ1eS9q?=
 =?utf-8?B?RlpFMmdUSGpyRS9lZjhkd0xYWTZlTXlJMnprTk5UQWVMZ2N6SU9velBIdi8r?=
 =?utf-8?B?R2h4bXFjV0hyYW45OEVFTHFDeUZndlpKVFhJR3hnbWNvSjI0ZEJkS3h3Ulg5?=
 =?utf-8?B?TkZ6RkJkbUJBemZVNmd0eG0vYUFSTlRoYXNNQVJrSjVRRjBzYlIvaDRtNGJG?=
 =?utf-8?B?eVRqY0hubW1XYlg2ZytCYVRQRHBjUXBEb0duQ3l5SGZVWXBtSEMzZXBqdVFP?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870ef600-8cc3-489f-2762-08da70aff59e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4973.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 15:43:47.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZvoa1Hm76ZXUi4EN56Jr9Y4ScV97DLe/571dDLQLa9rI+yhoRe4Gh3wCxV6XezYFUGwNzct9ygn4RPPExzIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 11:28 AM, Vladimir Oltean wrote:
> On Thu, Jul 28, 2022 at 11:25:23AM -0400, Sean Anderson wrote:
>> Could we just use use_raw_spinlock in the regmap config?
> 
> That was v2, essentially:
> https://lore.kernel.org/lkml/874jz6dcp6.wl-maz@kernel.org/
> 

On 7/24/22 6:31 AM, Marc Zyngier wrote:
> On Fri, 22 Jul 2022 21:40:19 +0100,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>>
>> The irqchip->irq_set_type method is called by __irq_set_trigger() under
>> the desc->lock raw spinlock.
>>
>> The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
>> regmap created by of_syscon_register(), which uses plain spinlocks
>> (the kind that are sleepable on RT).
>>
>> Therefore, this is an invalid locking scheme for which we get a kernel
>> splat stating just that ("[ BUG: Invalid wait context ]"), because the
>> context in which the plain spinlock may sleep is atomic due to the raw
>> spinlock. We need to go raw spinlocks all the way.
>>
>> Make this driver create its own MMIO regmap, with use_raw_spinlock=true,
>> and stop relying on syscon to provide it. Since the regmap we got from
>> syscon belonged to the parent and this one belongs to us, the offset to
>> the INTPCR register is now 0, because of the address translation that
>> takes place through the device tree.
>>
>> Another complication that we need to deal with is the fact that we need
>> to parse the 'little-endian'/'big-endian' specifiers that exist in
>> device trees for the parent ourselves now, since we no longer involve
>> syscon.
>>
>> And yet one final complication, due to the fact that this driver uses
>> IRQCHIP_DECLARE rather than traditional platform devices with probe and
>> remove methods, is that we cannot use devres, so we need to implement a
>> full-blown cleanup procedure on the error path.
>>
>> This patch depends on commit 67021f25d952 ("regmap: teach regmap to use
>> raw spinlocks if requested in the config").
> 
> This information doesn't belong to the commit message (and please read
> the documentation about the use of "This patch").
> 
>>
>> Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interrupt lines")
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
>> v1->v2: create a separate regmap for the ls-extirq driver rather than
>>         relying on the one provided by syscon or modifying that.
>>
>> For reference, v1 is at:
>> https://lore.kernel.org/lkml/20210825205041.927788-3-vladimir.oltean@nxp.com/
>>
>> For extra reviewer convenience, the ls-extirq appears in the following
>> SoC device trees:
>> https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi#L289
>> https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi#L249
>> https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi#L319
>> https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi#L325
>> https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi#L682
>> https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm/boot/dts/ls1021a.dtsi#L182
>>
>> Patch tested on LX2160A and LS1021A.
>>
>>  drivers/irqchip/irq-ls-extirq.c | 81 +++++++++++++++++++++++----------
>>  1 file changed, 58 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
>> index 853b3972dbe7..94a22642b3f2 100644
>> --- a/drivers/irqchip/irq-ls-extirq.c
>> +++ b/drivers/irqchip/irq-ls-extirq.c
>> @@ -6,7 +6,7 @@
>>  #include <linux/irqchip.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/of.h>
>> -#include <linux/mfd/syscon.h>
>> +#include <linux/of_address.h>
>>  #include <linux/regmap.h>
>>  #include <linux/slab.h>
>>  
>> @@ -16,8 +16,7 @@
>>  #define LS1021A_SCFGREVCR 0x200
>>  
>>  struct ls_extirq_data {
>> -	struct regmap		*syscon;
>> -	u32			intpcr;
>> +	struct regmap		*regmap;
>>  	bool			is_ls1021a_or_ls1043a;
>>  	u32			nirq;
>>  	struct irq_fwspec	map[MAXIRQ];
>> @@ -51,7 +50,10 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
>>  	default:
>>  		return -EINVAL;
>>  	}
>> -	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
>> +	/* INTPCR is the only register of our regmap,
>> +	 * therefore its offset is 0
>> +	 */
> 
> For multi-line comments, please use the normal kernel comment style,
> not the one that is mandated for net.
> 
>> +	regmap_update_bits(priv->regmap, 0, mask, value);
>>  
>>  	return irq_chip_set_type_parent(data, type);
>>  }
>> @@ -143,48 +145,81 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
>>  static int __init
>>  ls_extirq_of_init(struct device_node *node, struct device_node *parent)
>>  {
>> -
>> +	struct regmap_config extirq_regmap_config = {
>> +		.name = "intpcr",
>> +		.reg_bits = 32,
>> +		.val_bits = 32,
>> +		.reg_stride = 4,
>> +		.use_raw_spinlock = true,
>> +	};
>>  	struct irq_domain *domain, *parent_domain;
>>  	struct ls_extirq_data *priv;
>> +	void __iomem *base;
>>  	int ret;
>>  
>>  	parent_domain = irq_find_host(parent);
>>  	if (!parent_domain) {
>>  		pr_err("Cannot find parent domain\n");
>> -		return -ENODEV;
>> +		ret = -ENODEV;
>> +		goto err_irq_find_host;
>>  	}
>>  
>>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> -	if (!priv)
>> -		return -ENOMEM;
>> -
>> -	priv->syscon = syscon_node_to_regmap(node->parent);
>> -	if (IS_ERR(priv->syscon)) {
>> -		ret = PTR_ERR(priv->syscon);
>> -		pr_err("Failed to lookup parent regmap\n");
>> -		goto out;
>> +	if (!priv) {
>> +		ret = -ENOMEM;
>> +		goto err_alloc_priv;
>> +	}
>> +
>> +	/* All extirq OF nodes are under a scfg/syscon node with
>> +	 * the 'ranges' property
>> +	 */
>> +	base = of_iomap(node, 0);
>> +	if (!base) {
>> +		pr_err("Cannot ioremap OF node %pOF\n", node);
>> +		ret = -ENOMEM;
>> +		goto err_iomap;
>>  	}
>> -	ret = of_property_read_u32(node, "reg", &priv->intpcr);
>> -	if (ret) {
>> -		pr_err("Missing INTPCR offset value\n");
>> -		goto out;
>> +
>> +	/* Parse the parent device's DT node for an endianness specification */
>> +	if (of_property_read_bool(parent, "big-endian"))
>> +		extirq_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
>> +	else if (of_property_read_bool(parent, "little-endian"))
>> +		extirq_regmap_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
>> +	else if (of_property_read_bool(parent, "native-endian"))
>> +		extirq_regmap_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
> 
> All of this should be rewritten to use of_device_is_big_endian(), and
> reduce the whole thing to two cases (I don't think native endian makes
> much sense anyway). I also wonder what the result is if none of these
> properties is present...

I think regmap_get_val_endian would be better here.

>> +
>> +	priv->regmap = regmap_init_mmio(NULL, base, &extirq_regmap_config);

It could also be done automatically if we pass the syscon dev instead of
NULL. The only downside is that some regmap error messages will use the
syscon device

>> +	if (IS_ERR(priv->regmap)) {
>> +		pr_err("Cannot create MMIO regmap: %pe\n", priv->regmap);
>> +		ret = PTR_ERR(priv->regmap);
>> +		goto err_regmap_init;
> 
> Finally, what is the actual benefit of using a regmap here? It seems
> like a very roundabout way of performing a RMW on a register whilst
> holding a lock... Passing NULL for a device to regmap_init_mmio() also
> seems to be an extremely rare idiom (only 5 cases in the tree), and
> this doesn't seem completely right to me.

The benefit is that you don't have to write (yet another) set of
endian-converting read/write functions. The above (non-NULL) usage of
regmap_init would also address your criticism here.

--Sean
