Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655254A9E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377178AbiBDRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:51:38 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:27393
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237982AbiBDRvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHlFxJU6lbQ8eHdQxi8w5hZVNxZFtzrLlHu4GFlrKMjAkT/KM3xKpa7JIUTQQIXn4kVC86rXHyNJmPZvJafefXF5M7cEv8AyVxDZ8jIJRd/ZOOQlOmF/ZAZxo92VqnuyKVubOZkkR9Y2JHaSpfDRV8CjAs8LmFDMkghj5cHu3E6PL+DmdVzctrEsIoRAjfDYJ12A1Jmo4iogdDShSQhKdAS9jxXeTg7yyDkcTR0IwHsRav84emXWtxBnsoAR3EAHjmFsJRuYSDvJ2iTAHo7qt5thMRCI7soNsL1ut9XTBRdjN9QNaNP5E6HSBNkHb6fbaQDfgPWY9nNV7k6m9pyhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqG3pjIrACv8/hoyZ3n2chVsJOIbqd6MwkUQgw1jI/U=;
 b=hC/vzbTwMcRX2miuRD6RTMETLVUOHLijqpqYnPuVpwAQ0vz7RNknsoFs1N8lYuwrRDI85qPMjREJfeuJlZRf74EIxyDhf1/bCtZoCEHMpUGujyVugtv6Uh85/SHC6LBZ2uN9q1L4WdPyCLnRKedjYGctkdg1OE4MO1MvzdBfxsxxfLkhV7cOcHiNCFLsr4TjOcGsmlLBa+enBLFwJiaP6+yufNdoSDRx/FWN2fhgruTxHC+YIQ4YvoFErQx3Vt93guHLQS9ks0bATKd8yhOOYDMqcpsIdJx4paWVGX++1G0iCW5zAbIT9ReF8wql4SAUf7ShXDu6PgfrNKPmhDeUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqG3pjIrACv8/hoyZ3n2chVsJOIbqd6MwkUQgw1jI/U=;
 b=laqpz1qLFDlCRX/UceF7eL4aHSBYnzS56KgkJvvTbZmP51CaSAZgDdlkj5NU4QyPDnNyTY4UMDysKoYjHYsJjdqYtQadnyKWWW698LQMVxsSSJoOjSUo1Y0RghegvMxQUIJZCn0UpZumgvtj1f1B2hhrEzE4RmYgtsSNb7c5hZkWR9xT9nkTeWys+3MzT1Y7v1UloiuuPNCN3f2GYioNCOAw17vDuMYBUTRF3r/R/HUR/JON5FL1rmq0OL4ddDVqKuVTy3LXgJQewFEvMgtQFSHVsa4C6V7e/VoNYkrrbnLiXR8nzdfxGroAy/VzBRt4EvuQDoKC6EbXimKCr3d4cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR0301MB2142.eurprd03.prod.outlook.com (2603:10a6:800:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 17:51:32 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 17:51:32 +0000
Subject: Re: [PATCH v12 2/2] pwm: Add support for Xilinx AXI Timer
From:   Sean Anderson <sean.anderson@seco.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        michal.simek@xilinx.com, Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211217233015.67664-1-sean.anderson@seco.com>
 <20211217233015.67664-2-sean.anderson@seco.com>
 <20220131141023.higpnrseko2wzyeo@pengutronix.de>
 <335f40ec-e122-1f53-051b-a94c8540edd9@seco.com>
Message-ID: <3c7e93c7-e487-5941-1bc6-6e065d4fb457@seco.com>
Date:   Fri, 4 Feb 2022 12:51:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <335f40ec-e122-1f53-051b-a94c8540edd9@seco.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d5483e-36d0-4de4-6c50-08d9e806faf5
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2142:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0301MB214260202B703D86AA2452B796299@VI1PR0301MB2142.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCKTIc1jvjZQZcxIY/LlwJYjiUWg6ew2dk7e1lJgduiCg83v/wE3YKyiFM0gvruYCvel7qa6Nwy5/w2VbVraFlpd0i5NQDsUhdCHnwFK8rYBRpd4b+5i8lECd+kT5k6aaDOpBEKYEZiK1E15sUpHRm2tNR/vugm7jB4ap3uVLmNq4yccBlPaX6utEWPIGR1YgG9au+U+tSV5VSB100hmk9gPmcneup+lf4M7fJFLIU2o8+Nacg1lHS7sGdGA83Z+Yx7CWN76Ss7bQS8oMw1Q2KtwQ+kl4hQZugA/LN7sP3dJzUuXUdHKZdkR59AwQz8ZirbKxiclMn5kbTNzzQnrnUaMGWtMMGZYlcl22Kd6PE2JrVJbyUmffK+axn3jb/Keh3zhGrXWx1Sh6fmSaB6IUzFP27CaKXPEu9/gaqLLbT3pjVokUgDq6kVkZ1BIJyZQRnGfTWAVhsWdXX16LIfejI5ddzSHe/JZyr76R+a1PRcnS0CSRMc9sz+ZbPNipYKA3k7G2icHzb/Y5gjWsp5hKXFvHp3JLG7haEdwkVvgqMP9b3zJtLyL31D6gRSa+Emabh9YyCXdZGe4hPL4gpqNQtMVNaMmWOxZN7iWYJqpFfW8uaIxNK326ED+s0gj+KhO22VE03hzYObHjTakaEUt8lq28mcJ/IfswI/6iwVBEVXvaldD+G/bAJV4s2RS+W7GOqmYr0rRPPhBhF9dOj723d7vGT7DgdwRpuHGWASfXbJs+myP2cOnDiyHsZB1l1UVB+v03KzWkx4dNtpTSR+Ohw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(7416002)(5660300002)(2906002)(44832011)(6666004)(31696002)(36756003)(6486002)(31686004)(508600001)(66574015)(38350700002)(38100700002)(316002)(186003)(26005)(6512007)(52116002)(53546011)(6506007)(86362001)(2616005)(54906003)(6916009)(8676002)(66476007)(8936002)(66556008)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?7bOcLarTRY8BE7XMymY3MzjzDopFGNSmFb6Il8okLD+R94QWldYN2ZlS?=
 =?Windows-1252?Q?pLuBZM7PmcR6KXAnA0hD6JQ1rXobjP88NbH9+Rt3Scx+V97o2paP349F?=
 =?Windows-1252?Q?w+vHTzO0CWtdpJgb5r8heC/JzCot6jp1zYONjtfN3bBTFffDH6t2HwTz?=
 =?Windows-1252?Q?PJBxgaC1/ehFSU0LsQQ7TVBJqVvAOwWgwYkrSN0h/Stda06l2/Br0EOX?=
 =?Windows-1252?Q?Eamqc38qDBXQYRaLql5ba4i7JRhJvXMOv7LgBxFatxR4gBWDbqyGf27N?=
 =?Windows-1252?Q?kE3g0kubl8WHHiV936A9++oiKJOIbFMgq0nvNRSTcZlf7Qwx1LzC5xpv?=
 =?Windows-1252?Q?W/QtjLj99Z0I4K+KdatBx/uJ7M0p6lSLWi15AllBjDj6tIDANT/4QgjD?=
 =?Windows-1252?Q?tSWt6AudHcguAekPgxlx8XQz2WLjhcQ74muFHS5GzZeGOMZ8LlZ/nUfQ?=
 =?Windows-1252?Q?mCmr3+5boYaTurU1c/katxdOhaIpeb/qXQRuUWhRSfEA6y0gCCwCJPTF?=
 =?Windows-1252?Q?ksaq8vq1VsAf3geqQNMsBfPe2iewsRKhAQeoxxU+C7TJJH3DHYuWJEMR?=
 =?Windows-1252?Q?yRmDqaSMeWKYCeHDHq3OohhSisil4yM6gMiwfBJBd2mnf9KyWk+lcfmG?=
 =?Windows-1252?Q?uLPi6JfuuL/GOoQKwv/sBGmqCtdrmeupIqmY9uRFo+KEJmwmqBp12lui?=
 =?Windows-1252?Q?u6UUVgkpMi2ropdYrfyv2v8sw8HqXemYaKKwPRXHVMY8sE22VLuViIU/?=
 =?Windows-1252?Q?l6aApP2P7kP8CFEcMwho9BiW53OcKaV2JBxd78vbH9JhEYJntGkIF0sH?=
 =?Windows-1252?Q?EfF9W9qv+MnLEHo6hK4Glmh13jpAkeGHPcqYAIA30VEtaB+C3KDmuuvO?=
 =?Windows-1252?Q?/PxHZVuDrmQE6CrDimX2eVA2IcpCZTMFfh5xXJEHZxYmUTOHziMfh5X2?=
 =?Windows-1252?Q?fImIfJYiFS7+D9gbfbuJAWDSfoN9nkgA/BUIV9mgpnFvamfazvwMSD99?=
 =?Windows-1252?Q?fR2kjaBHWvB9BCPIcMjhlOjRkAC46klH1ZwPiJcBppdo0E9520avIiFz?=
 =?Windows-1252?Q?3swTBb4bZH/r4NrNGrOoHPo/IyZvqxplRlQtbyeN+i6dUwM6jax0CCP9?=
 =?Windows-1252?Q?TlL3VRD2zWYkoyUYLg7YR1kD74b+/qRTxfrWXKwB/1lW3M4gUn/hc/1F?=
 =?Windows-1252?Q?ur6QFZ6n2mGCGgpXTZ/ZWhZXKlGJA6P9gHMvhxDUc/jrmH/0EVoneWJ4?=
 =?Windows-1252?Q?Qsx3oH1oFYQXLdFQ47GJazKSBOO6Mt9aX9WyP5IkTStW1BLPB5Dqkt27?=
 =?Windows-1252?Q?PO73TrZlQrL9DZOBGed61DASKbMRikQRMsdVNepY1ju8/L6hP0xdCSkX?=
 =?Windows-1252?Q?nEsx+HXQpXOIXuV3DwrrJAGkHbdsZZfyMaBM3d1+aN00RT7/f8DI9sf7?=
 =?Windows-1252?Q?l8De/P5VgMy1dpK+eAB+TeaGLS6uHmbmp4tu0GyUmzDeb9yYHtGI7hZh?=
 =?Windows-1252?Q?KobyVWxYunGeiobjSNsUYx1Z9AFBwK8ZB4lHNMhpWc+8o0rH9noqTgll?=
 =?Windows-1252?Q?KwoQ2X6GRwt9pRGFzIcZ9TFlJE/kkXc1yOJKq0pYigBhYFvnOQeXEWgy?=
 =?Windows-1252?Q?bNrLc5LODvtk415EPI9pRPxufY7BDnKSQujTvz7+ktdaLuje66va/+A5?=
 =?Windows-1252?Q?XIvq/4tV4XEZIyrr5+Wa3P7b3pVsJN0HYgic4kJyyTddp0YMUK7zN8Mz?=
 =?Windows-1252?Q?17QSVFAG1X2uiziuUv8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d5483e-36d0-4de4-6c50-08d9e806faf5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:51:32.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk557t4SoX19bgpS2tNdNfNG8BWvWsT1JyGik/nGsGoZWdXvfMvNtit2AhnYFpLEv6tNNmPQSFXQif1Je7TwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/22 11:40 AM, Sean Anderson wrote:
> 
> 
> On 1/31/22 9:10 AM, Uwe Kleine-König wrote:
>> Hello,
>> 
>> first of all: Sorry for taking so long for the next review round.
>> 
>>> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
>>> index f8832cf49384..26c385582c3b 100644
>>> --- a/arch/microblaze/kernel/timer.c
>>> +++ b/arch/microblaze/kernel/timer.c
>>> @@ -251,6 +251,10 @@ static int __init xilinx_timer_init(struct device_node *timer)
>>>  	u32 timer_num = 1;
>>>  	int ret;
>>>  
>>> +	/* If this property is present, the device is a PWM and not a timer */
>>> +	if (of_property_read_bool(timer, "#pwm-cells"))
>>> +		return 0;
>>> +
>>>  	if (initialized)
>>>  		return -EINVAL;
>>>  
>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>> index 21e3b05a5153..cefbf00b4c7e 100644
>>> --- a/drivers/pwm/Kconfig
>>> +++ b/drivers/pwm/Kconfig
>>> @@ -640,4 +640,18 @@ config PWM_VT8500
>>>  	  To compile this driver as a module, choose M here: the module
>>>  	  will be called pwm-vt8500.
>>>  
>>> +config PWM_XILINX
>>> +	tristate "Xilinx AXI Timer PWM support"
>>> +	depends on OF_ADDRESS
>>> +	depends on COMMON_CLK
>>> +	select REGMAP_MMIO
>>> +	help
>>> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
>>> +	  typically a soft core which may be present in Xilinx FPGAs.
>>> +	  This device may also be present in Microblaze soft processors.
>>> +	  If you don't have this IP in your design, choose N.
>>> +
>>> +	  To compile this driver as a module, choose M here: the module
>>> +	  will be called pwm-xilinx.
>>> +
>>>  endif
>>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>>> index 708840b7fba8..ea785480359b 100644
>>> --- a/drivers/pwm/Makefile
>>> +++ b/drivers/pwm/Makefile
>>> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>>>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>>>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>>>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>>> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
>>> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
>>> new file mode 100644
>>> index 000000000000..b4d93e8812c6
>>> --- /dev/null
>>> +++ b/drivers/pwm/pwm-xilinx.c
>>> @@ -0,0 +1,319 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
>>> + *
>>> + * Limitations:
>>> + * - When changing both duty cycle and period, we may end up with one cycle
>>> + *   with the old duty cycle and the new period. This is because the counters
>>> + *   may only be reloaded by first stopping them, or by letting them be
>>> + *   automatically reloaded at the end of a cycle. If this automatic reload
>>> + *   happens after we set TLR0 but before we set TLR1 then we will have a
>>> + *   bad cycle. This could probably be fixed by reading TCR0 just before
>>> + *   reprogramming, but I think it would add complexity for little gain.
>>> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
>>> + *   possible by stopping the counters at an appropriate point in the cycle,
>>> + *   but this is not (yet) implemented.
>>> + * - Only produces "normal" output.
>>> + * - Always produces low output if disabled.
>>> + */
>>> +
>>> +#include <clocksource/timer-xilinx.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pwm.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +/*
>>> + * The following functions are "common" to drivers for this device, and may be
>>> + * exported at a future date.
>>> + */
>>> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
>>> +			    u64 cycles)
>>> +{
>>> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
>>> +
>>> +	if (tcsr & TCSR_UDT)
>>> +		return cycles - 2;
>>> +	return priv->max - cycles + 2;
>>> +}
>>> +
>>> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
>>> +				     u32 tlr, u32 tcsr)
>>> +{
>>> +	u64 cycles;
>>> +
>>> +	if (tcsr & TCSR_UDT)
>>> +		cycles = tlr + 2;
>>> +	else
>>> +		cycles = (u64)priv->max - tlr + 2;
>>> +
>>> +	/* cycles has a max of 2^32 + 2 */
>> 
>> If you add "... so the multiplication doesn't overflow." it becomes more
>> obvious why this comment is there.
>> 
>>> +	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC,
>>> +				  clk_get_rate(priv->clk));
>>> +}
>>> +
>>> +/*
>>> + * The idea here is to capture whether the PWM is actually running (e.g.
>>> + * because we or the bootloader set it up) and we need to be careful to ensure
>>> + * we don't cause a glitch. According to the data sheet, to enable the PWM we
>>> + * need to
>>> + *
>>> + * - Set both timers to generate mode (MDT=1)
>>> + * - Set both timers to PWM mode (PWMA=1)
>>> + * - Enable the generate out signals (GENT=1)
>>> + *
>>> + * In addition,
>>> + *
>>> + * - The timer must be running (ENT=1)
>>> + * - The timer must auto-reload TLR into TCR (ARHT=1)
>>> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
>>> + * - Cascade mode must be disabled (CASC=0)
>>> + *
>>> + * If any of these differ from usual, then the PWM is either disabled, or is
>>> + * running in a mode that this driver does not support.
>>> + */
>>> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
>>> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
>>> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
>>> +
>>> +struct xilinx_pwm_device {
>>> +	struct pwm_chip chip;
>>> +	struct xilinx_timer_priv priv;
>>> +};
>>> +
>>> +static inline struct xilinx_timer_priv
>>> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
>>> +{
>>> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
>>> +}
>>> +
>>> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
>>> +{
>>> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
>>> +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
>>> +}
>>> +
>>> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>>> +			    const struct pwm_state *state)
>>> +{
>>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>>> +	u64 period_cycles, duty_cycles;
>>> +	unsigned long rate;
>>> +
>>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * To be representable by TLR, cycles must be between 2 and
>>> +	 * priv->max + 2. To enforce this we can reduce the cycles, but we may
>>> +	 * not increase them. Caveat emptor: while this does result in more
>>> +	 * predictable rounding, it may also result in a completely different
>>> +	 * duty cycle (% high time) than what was requested.
>>> +	 */
>>> +	rate = clk_get_rate(priv->clk);
>>> +	/* Avoid overflow */
>>> +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
>> 
>> on a 64 bit platform ULONG_MAX * NSEC_PER_SEC doesn't fit into an u64
>> ... I think if you replace ULONG_MAX by U32_MAX it works as intended.
>> 
>>> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
>>> +	period_cycles = min_t(u64, period_cycles, priv->max + 2);
>>> +	if (period_cycles < 2)
>>> +		return -ERANGE;
>>> +
>>> +[...]
>>> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
>>> +				 struct pwm_device *unused,
>>> +				 struct pwm_state *state)
>>> +{
>>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>>> +
>>> +	regmap_read(priv->map, TLR0, &tlr0);
>>> +	regmap_read(priv->map, TLR1, &tlr1);
>>> +	regmap_read(priv->map, TCSR0, &tcsr0);
>>> +	regmap_read(priv->map, TCSR1, &tcsr1);
>>> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>>> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
>>> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>>> +	state->polarity = PWM_POLARITY_NORMAL;
>>> +
>>> +	/* 100% duty cycle results in constant low output */
>>> +	if (state->period == state->duty_cycle)
>> 
>> There is a corner case: It can happen that
>> xilinx_timer_get_period(priv, tlr0, tcsr0) ==
>> xilinx_timer_get_period(priv, tlr1, tcsr1) but not tlr0 == tlr1.
>> 
>> This only happens for clkrate > 1000000000, but given that the fix is
>> cheap (i.e. check tlr0 == tlr1 instead of state->period ==
>> state->duty_cycle) I'd suggest to do that.
>

This is intentional. xilinx_timer_get_period abstracts over whether UDT
is set or not. I will fix this when you find me this hardware
implemented with a 1GHz clock.

--Sean
