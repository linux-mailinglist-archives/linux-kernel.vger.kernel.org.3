Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7745F4CC8E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiCCW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiCCW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:29:22 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C32FFD5;
        Thu,  3 Mar 2022 14:28:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsGWVJZk72S5SBJEatIpg76it4qVRBzHUMx8HEkhzmV/jp+xBaePOWv6t+GcnzMmhmnO+3Q+DmhQ7qUP+ZMqB2LVQdyMTMSF4WsPyR+y5kMMbjphRjkL0LzyTeMSTlHFnlSo/2cXgEZy0q0jwrgLGP11Woc5Gfka+0DGWek2ixE2UDSjDSpTF1Sfv/6SmjBEXWbppfJlPO0ZicF8QWpH9GQ/AJmyLQRs1Qi8ev77RMXjzS+uORh9k9UK2aJXhf5/FOj2vvMbPsmEg0Rx19Ay51XWgTw4DEAicEj5QENoI1UHB7rgs+ls5FPbItz7ko1XvSJTYG3PVGuWoulklQU7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSlGsGnf70nJWR2MCU2IgR4NM4JaoibNWXZn0RbZ51M=;
 b=Ee3U+s7vsYG4IJvDuh7X+EWlxV0SJCloAvcf+uXFam7qipJykaLGkaF0/qJ5yzc+JsWulsyDRqC5XV3D6HaMI8ZPMsCH40N659bEyGBcwCg2UO3jXsVtESeNRysMCrExy09vPBvpMi3619SdLYBxAJ+D9qbv98bef59LlpJorizmewU77ibqhIRG+eaPtxert8WviX0q38rxb/8zsdPKJAzex1Gfq2a+Ce/QVCiZq0ymKSBlw0RALANaVE6LIzOON6QoqVwjJW+MO3UPeJOYHGJ6WQj0xfSWlQOW1nIv5UTj6X8PCIUaL9snHUgvCTjbP58lD+IVK/RuzTcuaiV1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSlGsGnf70nJWR2MCU2IgR4NM4JaoibNWXZn0RbZ51M=;
 b=0x0/8sZiSeWOCrLrUz/hQs7jW1J5y6zs+/Tm1LFrlNPT4uxmzrWdRPQFiPPrQ23ooy1TqsLoOgkoVyVqinHBBJ4VS1ECURz/Y6Jie4663gCJcJ19W8BTddpD6LTDtQCxz4PKY3qv6JnYMnu15wNY5pZy2mP/sfEAMbPxq8T3NgLzIGJIMkeXHhjrwWm/SXI/h1e3WCXy3cq09AiqHBu78YHhZJXl7KjhZKVKEpXBYU+FQ+tZPVwKju//9/7QV+PNB0+UkzHskeohAyZKYbGjXjji4JiYbYOWPgfrQdhLKIlNxsImzvVP68Ni5viz3WenqHj2t4KMYKaTQ99SiWwNQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB3PR0302MB3387.eurprd03.prod.outlook.com (2603:10a6:8:c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 22:28:31 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 22:28:31 +0000
Subject: Re: [PATCH v13 2/2] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>
References: <20220204180106.154000-1-sean.anderson@seco.com>
 <20220204180106.154000-2-sean.anderson@seco.com>
 <20220303222542.6ytwfp3bvm62igyy@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <3381d726-1d18-3386-5d3d-d89a9efdf091@seco.com>
Date:   Thu, 3 Mar 2022 17:28:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220303222542.6ytwfp3bvm62igyy@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:208:32a::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16cf954a-768c-42f1-1242-08d9fd6524ed
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3387:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3387A2B10DB8045141A071EC96049@DB3PR0302MB3387.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31irPlU4xAIIk0TL3K+1hj/qloaqtV43gPesk1NloXbSG/dNGscT/DtgwbvMOLDV5ZVyrK9z3ZlT/yLWLe2VjomMcF2MPXMqyQjKlkTfKWBS3+EEplLV65k5uDRYPwA7vjvHP+oJhJ+q+A7cz45JDK2qaun8MPQk8wo9fLm9wQfB8kXcWnFiSYVv85nkK3UhfPVrPucwwYkuzKUY6AIpd5XlMIQaxlWUgsKbXLwvi61NCgWq85ZwJ7fhrZSUpCwpZ6/LveWWPYmwcBGMT/Sl6G+KhGoNhGxszhdcGete+c6DYvNqdDKIXu2SJUt+v6ODZ3sEZHMugAKXSa7B55KD799dfSlT7p9j6Qk+sHw/fhhfAuqUgAlXM6nj1qnAMj8dFC0j2UkVyXv2mnOIp/4jwAyG9NTgFveRs3I+qrwuCq/KNOimFV5CZ7MQJeYwZgsTUdkLDIK0agYWFLjb7pCwVAJUjZVMJPoL1TQWEc+YoCiSpDZ8RUOAfsEVQnjgBs0EwTI8r4OGsaf9/6sS/nmwxxRp+AbS/NI8ircuXqbbmf5y/4hiy7cNE0iXvvuc4eiVb2ZQn+aI2lXGdJyXcZrEFkAcpN+gd5gKNjw3XDjubwmGsIIXPFQ7j/JKXB7JjRhfvJngSXYSAZSu+SJSVLUCD6oRU4SOGknblKu6Lmx6C8Jx9JmX8H0iedJDV8LPXVtMWsp6AcK0CDMnwfghdfIYUDXbCjRoha2KhK0q5AfA89BEgQT2Cpa5TCs2XlG8kaQadUneITfiQtWAp4FGPvmiaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6916009)(54906003)(38100700002)(38350700002)(52116002)(53546011)(6506007)(36756003)(2616005)(83380400001)(6512007)(7416002)(2906002)(186003)(26005)(31686004)(44832011)(6666004)(8936002)(86362001)(31696002)(316002)(4326008)(66556008)(8676002)(66946007)(66476007)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?5Beg6Sxh4L1oFtMAiBlTgiUhG4r60QQePkxoFhl0z2OJcnXc8pnDKFUf?=
 =?Windows-1252?Q?epe+7mwJhByPUT65rEChdhr4rhwOZK9fICMDx+8RrDuowSvL02fnBp6o?=
 =?Windows-1252?Q?3dBkhJ+j3PwZWYDfjZDlGgubrQY/ItewZ6rQYWPP0zYDzHpeZZa9xVT1?=
 =?Windows-1252?Q?NG1rhE6um3034lVtNz879SMbwcGoPnb8q87QPy4LEPeAOx6FsF510D9X?=
 =?Windows-1252?Q?lTkelFgNAq9QwcZqsRJ25cykkrWCrIhG6rcUb+CdhJjiCdTxX/1SPtY+?=
 =?Windows-1252?Q?vVTraAX+jSUYluCyvvMw7Tg29CSsqwkGYVTOKlVwiaysZkesiFYOB7af?=
 =?Windows-1252?Q?OUufBzmCWZGX6x+I7+MgEbI4DuPZJde21ioB0+CG+wRUKQ0+bp82xpEj?=
 =?Windows-1252?Q?B9srGTkPUkWeY0JX/JK68dn3FyQrdfbaXWy3uTaT0SB8g6RcTimOlQ9A?=
 =?Windows-1252?Q?GxH2ajxFjpVYdpzLPKbdKnUXz/MButWopLqzwTkr+VDTGMu8SimKI1Vf?=
 =?Windows-1252?Q?2yLwwFhYddepsGsYog42Q1OeeYFP955W6pBiRBiCZ+oIkvkusKaBw6XK?=
 =?Windows-1252?Q?97dBzJgQKstS7jtGF/xgKfXCPs30nbjr0uS/89eETBIQqB9ht44ce7xw?=
 =?Windows-1252?Q?0GQcB2lO1oIUKR6DxXcmYEkhUHFRfc+ukwqgY0MnPbtjW4tnxShAwzd+?=
 =?Windows-1252?Q?TPHyeo/t2l/BHeP2WixVFawwdT7WcYmdA37jGNfR3zkbGaH5/kLf0hEI?=
 =?Windows-1252?Q?SynusFvV4NlWULzEPEKAOTYDMl82ldjdUjFoFpLHpRDd1UIgv2rfQCTN?=
 =?Windows-1252?Q?CdE6X5Qwm4XgARwcG5mbb6BbuafLKt6I0gQRwakNITSPqfKkzG9mbJE+?=
 =?Windows-1252?Q?CxklQIbADpq7ECyVmDli0BeH9beKeSgQS8GUJDPD+E8nTcF6VMXHjcxE?=
 =?Windows-1252?Q?JOc5ce+EzXXaSa/5jTGCQk3zUpVhHQeluvPfLCnr8ZX9RMRi/NVP35uV?=
 =?Windows-1252?Q?L85V6i1OHljID0X3fsLlIdWvvJv/K8jQGAu1gM/FoZPoPaUoqRn95+9s?=
 =?Windows-1252?Q?uN7dql3nuxWkEqHLBeMMthaJbDIH35X8WBnfmPHGBoq75t3sRQkqSYSz?=
 =?Windows-1252?Q?7AYyyyuNY8UPWxQExn2J7+YlB5prJMFo3pG6oz1pgaSacJ6UpvpU7vUo?=
 =?Windows-1252?Q?unFbimmyLe97BhGB0EnDHePEtEL+BgmcVZtwzOvwUr9J6hOWqJWfH7xk?=
 =?Windows-1252?Q?WbjElKsJHkjgywGA0GiyYAs54HCrr9xsm2wiYC2M8MLYs3wEswClOTNu?=
 =?Windows-1252?Q?MMLZqOFfsDMpE3A+G43Pjc45MkBnHqvFx+oqNBscspyPDlFW2OE0YVYj?=
 =?Windows-1252?Q?jl7krINrcmp4QGliiVzLW7bc/TFACxpb/15IzWVRlAnEa4sENTQ9Gg8f?=
 =?Windows-1252?Q?LB7Qp/M2a2b2bzBkYaUbtvvOmrDjSpdqbi/nj/mCqamCPmsv6/zmnclS?=
 =?Windows-1252?Q?1ahJrZ7F7LAAXe/Qau6gT1gjzHzlECNxp8HVfN3M0MrYIvEGOvH068le?=
 =?Windows-1252?Q?NgzIxH3kzmJ6KT2Mzxi7fRnia6FyIhShrQjTCBC0+eI86z+iSFrq7lDt?=
 =?Windows-1252?Q?gfAl3Ry8rA7dL2g1H6sjwZ0m2tiwth7f8CxM2Bp9auxAVeH7B49KURrT?=
 =?Windows-1252?Q?LfRGsxAIr99HezPKv0NSSVHrastlcfbDNyW2sD9QUukIk0pUzGfEWEaU?=
 =?Windows-1252?Q?Gj8lQLd3LDZwFOzdrno=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cf954a-768c-42f1-1242-08d9fd6524ed
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 22:28:30.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESA2tjqjnoaRT2W/2IcTr3kQu6oA7yDPIN707RTxS6rhELUCfYEkKUe/l5wwHjb7qCYvvUFrsocTTbOi1+Snog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3387
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/22 5:25 PM, Uwe Kleine-König wrote:
> Hello,
> 
> just a few minor things left for me to criticise:
> 
> On Fri, Feb 04, 2022 at 01:01:06PM -0500, Sean Anderson wrote:
>> [...]
>> +	regmap_read(priv->map, TCSR1, &tcsr1);
>> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
>> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +
>> +	/*
>> +	 * 100% duty cycle results in constant low output. This may be slightly
>> +	 * wrong if rate >= 1GHz, so fix this if you have such hardware :)
>> +	 */
> 
> I'd drop "slightly" here. If the bug happens (e.g. tlr0 = 999999999,
> tlr1 = 999999998, clkrate = 1000000001 Hz) then you diagnose a nearly
> 100% relative duty cycle as 0%. Also s/>= 1GHz/> 1 GHz/.

OK

>> [...]
>> +	if (one_timer)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Two timers required for PWM mode\n");
>> +
>> +
> 
> One empty line here would be enough.

OK

>> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
>> new file mode 100644
>> index 000000000000..1f7757b84a5e
>> --- /dev/null
>> +++ b/include/clocksource/timer-xilinx.h
>> @@ -0,0 +1,91 @@
>> [...]
>> +/**
>> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
>> + *                              AXI timer drivers.
>> + * @priv: The timer's private data
>> + * @np: The devicetree node for the timer
>> + * @one_timer: Set to %1 if there is only one timer
>> + *
>> + * This performs common initialization, such as detecting endianness,
>> + * and parsing devicetree properties. @priv->regs must be initialized
>> + * before calling this function. This function initializes @priv->read,
>> + * @priv->write, and @priv->width.
>> + *
>> + * Return: 0, or negative errno
>> + */
>> +int xilinx_timer_common_init(struct device_node *np,
>> +			     struct xilinx_timer_priv *priv,
>> +			     u32 *one_timer);
> 
> This function is gone, so the prototype should go away, too.

OK

--Sean
