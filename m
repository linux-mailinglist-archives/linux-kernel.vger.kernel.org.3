Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F2473429
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhLMSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:36:54 -0500
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:19425
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236630AbhLMSgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:36:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaQbARyq27//MZD3lVLBJFdvwoGcS7TezXlwg1gI110ZyDJURp2t/Vil5c0o9FKXNtqzHB0nva/YrAr+Z+/MYM8UVVNCaRBrx7ACeZH6YwfBnNjkNVZCxj/4RQJOO4J65SF9rYINrwoInaiEmss7pyDB9EZPxc0V3mMXy42Uv1wO/IxhtKZ16A2jVYGOHKmOc1dkbAk/8fEmdLbic9crz5kdzg41HV5E0ZoSmv1bVDT8JsYVzF0iyWRPWii/p0/5luzsJuV4CS9DeK+rfovxrGiZyV337f5T9YtSpS2hU6/T0eedKam5Dn5PxCJ59j1OCEzXf/zr+xmMC6KLOtvzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYpHBX9l7bb4RRAq9MYPnj831pMGH31WRmXwu7Qs3vk=;
 b=TKLirZ9EXIqX4+TV3Tb+I4S/L8yNAeTQZJeq+oW5SZ/OoEMuzKVwuKhGkH9AU81eZuJs9fTn1ULFhuOMazwmxKOl1JiG5v8YiD3aOY4YUlpEpnpcTP0fPYm89F2HfPldxt7xY6WDAeNEs0YvJtDwQVNI+ly7tiN1zQ89lpnd44wVkAahMrbZaMi1yxaX332XqU7I6iKVsdKPGCJnXBIRqu30ElFSMVxWyVVICbIqHcQJjdN1XQkYnbesLusvcZCCE0y9CFsTDBHZrK/FymQxtVhg5yhKEmuMytw+W4abbnmdVoHrDX3xekwYLMxodgjhTkSqjvbShL8zdCFG8m2jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYpHBX9l7bb4RRAq9MYPnj831pMGH31WRmXwu7Qs3vk=;
 b=f9U/vVAtqYvE/Un2rOxj/QFD0pjbMVSHvkUd7wujLLcP1toibkz1NWSzMF0wIfgQuvp0BEaOHYqpL4znEbaKhCvo0Z3RbFOBzyzTHiyksWBZJL8gwiYSoqt8PFQlCztDH76lkeAu5EzOdaduICrOP9aDcsuawcIo9Kz+STIU99c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5577.eurprd03.prod.outlook.com (2603:10a6:10:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 18:36:51 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 18:36:50 +0000
Subject: Re: [PATCH v11 2/2] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org
References: <20211123232536.3909773-1-sean.anderson@seco.com>
 <20211123232536.3909773-2-sean.anderson@seco.com>
 <20211124073720.3yf2lgylu4jrg7bh@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <ad511de5-2c57-df78-b37c-08644e914241@seco.com>
Date:   Mon, 13 Dec 2021 13:36:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211124073720.3yf2lgylu4jrg7bh@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d3b578-706c-4eff-5081-08d9be6786fe
X-MS-TrafficTypeDiagnostic: DB8PR03MB5577:EE_
X-Microsoft-Antispam-PRVS: <DB8PR03MB55778E861E4FE749F56D4FA696749@DB8PR03MB5577.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRcGJlKAYitn/XOvLsFj96epH2N73s+NNiFCJonJZGfIuSpzxj9Oc1gCD4kTL+cZ2rah64aL+r630jRYWqB3t63W9n1UKxAqGFhv7odEZpWxfiDz017D4+2osltgHouLm9jQXTd7brpCrd7ju/WvC0ju8YKdQ1h801D1a81oHPdItO1PHgx4SDgSYTsRB1MMHCvsCw4JuL/x9YsS+IY+WTqzkz/sl+8/fhLwYhflvefX9DKgtDBUKrLaaS42EzBpcxKFEw+rOzwjXVp0Wld3WZ3vvjmJjdNnFRbG8c1Uoqpobra40tdY9CTCp4FUbfInS7Jx9/CxRfZlu+45PDu10SkSbI4XBCuNkHOt8aIvkhpjONtU9tG8RN4V4z5cRIBIvOR5AbM+BkeYOzakyIWIrvLf9CBOTxjSMllxlUiW/Z75h/445JyGNNjAA2a8jU9zvjjRCOWH3ub7/K0uqfIHCB31g19De+Yz59BTsLbcy1Td40XRogeJwl4ipomqmUMxANAL+Xk5RdTowgQ7IYcCxAw9ADvTo9K3zK+ErzYTKqmCNGf0eVxp1aROpd1lqH6W36NYXsguT/meVhyDo6MJ8wnMUaJslgxrYzaW2liR1MO5DhL2+F7qYqbdTUhk3CYy9xCwCFsaGYLjr70akkVGJZqClQLMN6JqT+8FTI0Z+4mq3woaGqGfmi15yELXDj2ceiK3yBxVKzb1kOnhDOnm0gQpYYUb75XoxQ1LXfmx6CsB7Cbv8csl7X4X9W1tpWE6MYZDYjashdXv8NoeE1LR1IEA1ePCGKgVV6ZKozqoLr2ux/vUvVkA9U6hoJO1r/qSbA4VYu/qfd6dycaF9O4M+92dOn1mNVjR3WgAbUQmKZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(4326008)(66556008)(44832011)(8936002)(66946007)(52116002)(31686004)(508600001)(2616005)(54906003)(6506007)(6666004)(66476007)(83380400001)(5660300002)(6916009)(53546011)(316002)(66574015)(186003)(6512007)(36756003)(8676002)(38350700002)(86362001)(2906002)(38100700002)(26005)(966005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?ynvTNyrCdBTPKlRpPfnXneWYSlFV1I2e/0/wCxL+wnChEqthg7nIbsrP?=
 =?Windows-1252?Q?Jb+NktMm+bNVDoqs4HIgUPQSoyP0Yw4FzKdQPCmMXKAQHtIQ9Hdmqcz1?=
 =?Windows-1252?Q?sEVs6jlg0Q0naIujb0kJQcQEulu0UJoRlERH4OVXa/7sDz/CPVaxgoXe?=
 =?Windows-1252?Q?3gF+aSWT7l+M9fBn42cH23pcDJcE5ykj6hjuMJSQV3j1+yeZ+ZKp1tdl?=
 =?Windows-1252?Q?IohYKJ6Q50gwEDslN2XVU+DB9bKln1A1yTKrE0c93vuNg/5w1FzAE+du?=
 =?Windows-1252?Q?D0pfEi0H4As1ew3aeNevVqRjyx1EBhHclp3+Q2hCy//aeU+p2SJmmwHB?=
 =?Windows-1252?Q?ccEP7lMU1OPCuSqXkluphggPR2AG3XckqQLubrTg+BtD1oFFGIzKIRda?=
 =?Windows-1252?Q?f6cxTD1VVmWXU88GM0fIjcZw96S9YaMcndB2IPqR+B+z1HetHVaQPwvS?=
 =?Windows-1252?Q?0ozQe8qQ/qxRQWwOQ7EamcCc81RSZty6uBPjR9MUulLzPjWLy+FEJ+we?=
 =?Windows-1252?Q?tWMfrPyDSakSY7FbrvGpB8aJ8oa3oCwwTxiSgJeIOBjFi8+zh5oktnr9?=
 =?Windows-1252?Q?B/10wJx1V7UB3tJv4zIfXgkwdxbsmV8JdJKPb13+3BcFbLa4OFtQO6T9?=
 =?Windows-1252?Q?DLJvev7muOh8quYIg04FMzDrCpcN/G2jgQVUG3MSFOus7prPYiGxxdgt?=
 =?Windows-1252?Q?9hxyBDdiDQI0NscrEgrXUqWIQaY5RpGDckJtSuBdP/2opE86ontIBUpB?=
 =?Windows-1252?Q?WlIoOVjp1CfPpys2611xq5KoIdOyaMP7AQ6ei3PwFlaMCHeEBhwn4LtS?=
 =?Windows-1252?Q?AIPUm2R71Gv+2rm+ANz9eEjRATgRY7tpkydvi4z9CeMV64lqecknTesQ?=
 =?Windows-1252?Q?F6YQ3pcg0e4PoqINN9AYI5g728TdVEoJ9fMnS8XCMnPh2nJobRS/Xc2c?=
 =?Windows-1252?Q?/5u3R7gAe9l/bS3rj9A46AikiLvJvJHEEzX5cSp2ZsSphTS9qP8qhtES?=
 =?Windows-1252?Q?4vSIhZVqyaRnTPKkPV8YX+uUPcxltQupVjk/MvuU7HCoRpYMl2eeFCfP?=
 =?Windows-1252?Q?W6lKd4n9JlWPnRmAhob0RuAp2+xjA4SGTjHh8yJUAyeCLTvetR1dy/+6?=
 =?Windows-1252?Q?/DYKPna3y3q44yzk09BWLnyrtn5jqSNj0xnTgX49H5M8NS/MJCwLiCt/?=
 =?Windows-1252?Q?Z+YKCp3eKyhmRhZPGihyEhwBB/ZdKCKDXHJss4v/BrgOqVN3K9Oyfx3a?=
 =?Windows-1252?Q?CJFqJDnIHuIPXH01hhbETVmq5gcUvIy/zfNN4/jP0J1Ip0SYiqEtwZII?=
 =?Windows-1252?Q?DmLJBkc7EoLRq7Ptm/ToZVn9vt9HYi6FjX8U0Cg06OM4uOCMTcbqnz69?=
 =?Windows-1252?Q?1cYzNX3raVngBWXoSgnsuoBjbdTfwd2O9p98QONIWqGth2MIKq+pYbrA?=
 =?Windows-1252?Q?giwXZ5ga1k/Js6Jl1sdM3sSWEv+dW4Y6W2r7i9dKlK8Neb3kSHK8H3B6?=
 =?Windows-1252?Q?svqyYqLuJ0xO4gGoV1DmIFTlmmKLl9BpW7sEofS3F5cssXUykzAqPKQH?=
 =?Windows-1252?Q?q+4BSG/sfM+sMijNJh0lH7/Vc4Vhi9VXiwEUAF+gW4ELu5Kzx9uljn+3?=
 =?Windows-1252?Q?KHrb0BHC/LDQDRtiYMhaVpbgCJbI8tOa9Zyd6mi/tZVsY0RBccVuLy+4?=
 =?Windows-1252?Q?Dldre3ldu4hf3w8gmynD1m1I2iszpQXtxZBdLj9iAi5X6U36bxqNL4rs?=
 =?Windows-1252?Q?LbebvRgHR/LbvjIwNLE=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d3b578-706c-4eff-5081-08d9be6786fe
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 18:36:50.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvhfnUPgZJ1dSQ6bNCQRvUDY1ZrWAZSVwaO1KKBeRXv6o7rncXJhVOJ2v3ciYtd5DDgQlErFtLgY2YVmWjHVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5577
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 11/24/21 2:37 AM, Uwe Kleine-König wrote:
> Hello Sean,
> 
> On Tue, Nov 23, 2021 at 06:25:36PM -0500, Sean Anderson wrote:
>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>> found on Xilinx FPGAs. At the moment clock control is very basic: we
>> just enable the clock during probe and pin the frequency. In the future,
>> someone could add support for disabling the clock when not in use.
>> 
>> Some common code has been specially demarcated. While currently only
>> used by the PWM driver, it is anticipated that it may be split off in
>> the future to be used by the timer driver as well.
>> 
>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>> 
>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> 
>> Changes in v11:
>> - Add comment about why we test for #pwm-cells
>> - Clarify comment on generate out signal
>> - Rename pwm variables to xilinx_pwm
>> - Round like Uwe wants...
>> - s/xilinx_timer/xilinx_pwm/ for non-common functions
> 
> I'm mostly happy with this driver now. Just a few minor comments below.
> 
>> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
>> index f8832cf49384..dea34a3d4aa4 100644
>> --- a/arch/microblaze/kernel/timer.c
>> +++ b/arch/microblaze/kernel/timer.c
>> @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
>>  	u32 timer_num = 1;
>>  	int ret;
>>  
>> +	if (of_property_read_bool(timer, "#pwm-cells"))
>> +		return 0;
>> +
> 
> The pwm driver has a comment at the location where #pwm-cells is
> checked. I suggest to add a matching comment here.

OK

>>  	if (initialized)
>>  		return -EINVAL;
>>  
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 21e3b05a5153..cefbf00b4c7e 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -640,4 +640,18 @@ config PWM_VT8500
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-vt8500.
>>  
>> +config PWM_XILINX
>> +	tristate "Xilinx AXI Timer PWM support"
>> +	depends on OF_ADDRESS
>> +	depends on COMMON_CLK
>> +	select REGMAP_MMIO
>> +	help
>> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
>> +	  typically a soft core which may be present in Xilinx FPGAs.
>> +	  This device may also be present in Microblaze soft processors.
>> +	  If you don't have this IP in your design, choose N.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-xilinx.
>> +
>>  endif
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 708840b7fba8..ea785480359b 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
>> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
>> new file mode 100644
>> index 000000000000..b64735880c4c
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-xilinx.c
>> @@ -0,0 +1,318 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
>> + *
>> + * Limitations:
>> + * - When changing both duty cycle and period, we may end up with one cycle
>> + *   with the old duty cycle and the new period. This is because the counters
>> + *   may only be reloaded by first stopping them, or by letting them be
>> + *   automatically reloaded at the end of a cycle. If this automatic reload
>> + *   happens after we set TLR0 but before we set TLR1 then we will have a
>> + *   bad cycle. This could probably be fixed by reading TCR0 just before
>> + *   reprogramming, but I think it would add complexity for little gain.
>> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
>> + *   possible by stopping the counters at an appropriate point in the cycle,
>> + *   but this is not (yet) implemented.
>> + * - Only produces "normal" output.
>> + * - Always produces low output if disabled.
>> + */
>> +
>> +#include <clocksource/timer-xilinx.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +
>> +/*
>> + * The following functions are "common" to drivers for this device, and may be
>> + * exported at a future date.
>> + */
>> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
>> +			    u64 cycles)
>> +{
>> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
>> +
>> +	if (tcsr & TCSR_UDT)
>> +		return cycles - 2;
>> +	return priv->max - cycles + 2;
>> +}
>> +
>> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
>> +				     u32 tlr, u32 tcsr)
>> +{
>> +	u64 cycles;
>> +
>> +	if (tcsr & TCSR_UDT)
>> +		cycles = tlr + 2;
>> +	else
>> +		cycles = (u64)priv->max - tlr + 2;
>> +
>> +	/* cycles has a max of 2^32 + 2 */
>> +	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC,
>> +				  clk_get_rate(priv->clk));
>> +}
>> +
>> +/*
>> + * The idea here is to capture whether the PWM is actually running (e.g.
>> + * because we or the bootloader set it up) and we need to be careful to ensure
>> + * we don't cause a glitch. According to the data sheet, to enable the PWM we
>> + * need to
>> + *
>> + * - Set both timers to generate mode (MDT=1)
>> + * - Set both timers to PWM mode (PWMA=1)
>> + * - Enable the generate out signals (GENT=1)
>> + *
>> + * In addition,
>> + *
>> + * - The timer must be running (ENT=1)
>> + * - The timer must auto-reload TLR into TCR (ARHT=1)
>> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
>> + * - Cascade mode must be disabled (CASC=0)
>> + *
>> + * If any of these differ from usual, then the PWM is either disabled, or is
>> + * running in a mode that this driver does not support.
>> + */
>> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
>> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
>> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
>> +
>> +struct xilinx_pwm_device {
>> +	struct pwm_chip chip;
>> +	struct xilinx_timer_priv priv;
>> +};
>> +
>> +static inline struct xilinx_timer_priv
>> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
>> +{
>> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
>> +}
>> +
>> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
>> +{
>> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
>> +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
>> +}
>> +
>> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> +	u64 period_cycles, duty_cycles;
>> +	unsigned long rate;
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * To be representable by TLR, cycles must be between 2 and
>> +	 * priv->max + 2. To enforce this we can reduce the duty
>> +	 * cycle, but we may not increase it.
> 
> s/duty cycle/period/

replaced with "cycles", since this applies to both

>> +	 */
>> +	rate = clk_get_rate(priv->clk);
>> +	/* Avoid overflow */
>> +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
>> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
>> +	/* Clamp it for Uwe */
> 
> Hmm, not sure this comment is understandable in the long term.

Incorporated into the above

>> +	period_cycles = min_t(u64, period_cycles, priv->max + 2);
>> +	if (period_cycles < 2)
>> +		return -ERANGE;
>> +
>> +	/* Same thing for duty cycles */
> 
> s/duty cycles/duty cycle/, also for the variable name.

It is named this way to match period_cycles. "duty_cycle_cycles" seems rather redundant.

>> +	duty_cycles = min_t(u64, state->duty_cycle, ULONG_MAX * NSEC_PER_SEC);
>> +	duty_cycles = mul_u64_u32_div(duty_cycles, rate, NSEC_PER_SEC);
>> +	duty_cycles = min_t(u64, duty_cycles, priv->max + 2);

--Sean
