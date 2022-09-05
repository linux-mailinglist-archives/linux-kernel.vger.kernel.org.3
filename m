Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01025AC893
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiIEBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIEBfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:35:36 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20044.outbound.protection.outlook.com [40.107.2.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D622316C;
        Sun,  4 Sep 2022 18:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSJDu1/Wme9LrFPzDlP6VABBTLHI2WBb/Fyi8XlrmXZjQb2n+TYgZIawt/t3e2TlT99OI0e9NRDKdjXpwFz5apJfNdFdYqFCoj0zXopAQgMuQGwsbZdBe7jfNfECr5ye7fitVKmkISZBUTGQ3UIIDjJOec34kMVeLET+iFJKVhcDfYpM6j1J6f2zMQr6pJzC1Er7Xi2H+clCz/OWwfWHw2yjji6fjAPu7axv3xRjJ231beMtI+LS8/P5Kr/MsrR+TIitFyF5Yoc4/XjKWkEiuIfGkk8XLVKHfQjWdcvMq/LkjeL4TKp0c1zmr95NfZ9jyRTuSqlFSMGvRqHLWbhe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zadIbKYDFrAaggtiU+2JMhR47zPJ+QQJC/49WQTAfPY=;
 b=JNgyxGfRs/7x3jAelBjgMX9yiVXpHJTtPwNRJHZRDN5Erygrw9ELPAMiSdKV4xqVL6906Qq+jVGeo7o4I0UiCWxYV+ODgnDDmPZ/zHBWLmefuuYd6S71wtKoi4wk3eaNWL0SSkAks8rSnwKHVqRMzwuxsdCZPdVTZDn6xqUgn6/tl+osS1JZuuXTxtJ2kf1pZIGj4ponqMFxMAnL5jdPdJl2dsq8E2ZkQvgCqIOuUhBdEL3asSjvtGeGH1rZZDSBvA/Yo8ss9bDn7yP3MPMoJQype0X3W64deaJlECnYeOAjIzH8OAPdegSxpLqfBQHtx1I8qqtvLzTU9Ua0Ylr3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zadIbKYDFrAaggtiU+2JMhR47zPJ+QQJC/49WQTAfPY=;
 b=MpRSz28dmxxn3O6/TH28MwrYmZbKtBVQ8zG8sjDMjymI9wUn03YMw6mg2tSWGiqVetKSLUgxxdiKAWXxqNeAok2OR9ZaJPXkejfdno9tOmqEwJfAgOlUp1xdV36oMZnzNjNT5LLm/+sFbaI1mIA/Rz/RSpAGr1aAj8Xiuro/hsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB5519.eurprd04.prod.outlook.com (2603:10a6:803:cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Mon, 5 Sep
 2022 01:35:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 01:35:29 +0000
Message-ID: <e71b7769-9855-4bf8-e006-f2e74b391b1a@oss.nxp.com>
Date:   Mon, 5 Sep 2022 09:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V8 3/6] soc: imx: add i.MX93 SRC power domain driver
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
 <20220823055215.1139197-4-peng.fan@oss.nxp.com>
 <20220904095248.GI1728671@dragon>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220904095248.GI1728671@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82af719-14f4-4cc7-7c5f-08da8edeea96
X-MS-TrafficTypeDiagnostic: VI1PR04MB5519:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opMHmsZzBL0osjgZIZF+VpGl7FBLKmHEXz/fOUUiK2BxQ3yZWfVYGWFBe6wW4mwJMF8vvr3WLPsuwxNiwLiBSKyIWRXYNQlE5SljuLGgPV3ZvHgXXiUDHgXbWoUwQ59ZUDlgBiLIx+7sKMJCoPG3K0m75VJJ0J1XRxdnOgulYNv5NvXucOdxJE3xl6DVkrNmrO2z3TT7b5gHOgwmhocNhF0J+Szg3SE6xyvFYX6Nz8i3k3OesXKwl2hEWGqc/iuuIvr53hPMoHCPQaSwm4u+/Xe+WDCsBENRT0kHH21UTtxKNzPhrrqNIACgadhgShwlmgHOMNJUbk0kSHcMjlA3ucHUBbjNXcQwD1h8n+61eYhtgn2Nm/sjyMlJsjjSCte6s/98DqM2roD7qb7U7SxTvs9K5qVRsJ+NHCX6BhukkOgLarEd16Ew6iiGlPfYf2pOFzsUOgpVjTtVqlHrqUP0qYJnceId+E22HuCugBBU4G2pXNjIX7rqGdtkDaaND3dC/7HD/1NdxBjcGyCUc0P1I9gF/q65XJPXN4Mb5YAXI0drC/ZcA34APe+Q3S9uYODazuNu+oqvw91wnJagswVRDNnWOXqmNpTP+NSUlCn9efa1rU7s1neCnHVS6YIIP+7AmWeE9mtmXAyGZhftTXk8eRamKwo0c9olQI6wB2GAjmocNZlNxHaYzxqr2sWqdZ0m9AaJj3u/Nm9UvAq9W7wSSn/ZNuf5gjDnQ2E4coyZGxuJb3xtPrCpt3mycJ71X6QRxfiUcXDU9AklWHsLX18+YBjdJ0nvW4rXd5yqWpkNQnVWl95eps2QIYRhXF3CW69bndC2GnvfFH5PSO/1jjWFdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(6506007)(4326008)(66556008)(86362001)(66946007)(66476007)(6486002)(8676002)(53546011)(6512007)(26005)(52116002)(31696002)(83380400001)(38100700002)(38350700002)(316002)(6666004)(41300700001)(5660300002)(2616005)(186003)(44832011)(31686004)(2906002)(6916009)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1oVFVRdTBmZkx0ZkNvbXZaZDVFTTZ5RXJwRGNJZGFWZzRlTENuK1YzRmgr?=
 =?utf-8?B?SkZ5RnNQOWk0OVFFT25XSThUWUtTbmJEQjlIZ0NXL2lqMVg5OURIL3A3N1JW?=
 =?utf-8?B?VC94RmFrQk9NSnVnNXZ3cHdqb0hYME50bi9ab1ozQmtyTlJBRHR2K2xmZEI2?=
 =?utf-8?B?S0kxRlRnTGh6dkl6eWZNYk5wS25OSXRXTG5mU1RNc1FZUm1UbmFaMU9rVEpB?=
 =?utf-8?B?dllUK0lZRjBOaHFEaFF0ZWxnbmFZMHNuOU1RakM3VE1UYlBScVFFUUdpNWRj?=
 =?utf-8?B?bldqMVpOMXhneDQ3Z0NtRU9oVjIxcG9hcS93MWZoZkxkSXErWDNYcVEvS0JF?=
 =?utf-8?B?MjhmeFJ1a1ZsVkFZRkcvajVwdEt3RE55Ympnc2RwQUtYWk0wT2dhNWJTRitt?=
 =?utf-8?B?Ti9ablRLWTl1cWxIRjRmZFZGQ3E2Z1pnNG5lQWJYRlYrbURqcjdoRVRMamVV?=
 =?utf-8?B?SSsyWC8yVjIyeVZ6SVdXcXM1azg3NTIxODBXckxHYnVOdUU5WU56SGliSmZL?=
 =?utf-8?B?UlBNL3VVZ2p5UEpiMThORHp2aWJMcCtiM3ZLd0RzVlhDdWQ4VnZWaDN0M2Rn?=
 =?utf-8?B?ZENONEdiVW1ic0lxa3dwR2ZuUVRUR2pjTmtLZmZBbXltdTB2ZS9RNGtjSjhD?=
 =?utf-8?B?UHdQTGp4aXlJRmlhUWpvbkcyenFOYTV3S20rYzg5MmNHWjNCQVJTQ0ltMHR0?=
 =?utf-8?B?N3FFOHliV0dBcUZXa3crMjBIZTRJcDZwTzRLS2VBaTlQRElSVTlKbXVaZ1lx?=
 =?utf-8?B?b0Roa1ZaZ09YeTFMK0pscDF4OEpMT0c3VllTMGxJY0pVZUNGbXEwaWJUMHBj?=
 =?utf-8?B?UndYVXBtanl0NFlGa3YzTjg4OUI2ZW1NSmNoOWdBamIxT2M1WWNjZU1oNUZ1?=
 =?utf-8?B?Qzd2Zk51eVBpblBwdHdBOGVWd2JRTzNlYU04dDl0SGtXaGcweTBpbWlsYXBp?=
 =?utf-8?B?blBDbnRRaDh6OHJtVDRsSHFZTUljRWg2YmUxMkhLQ2p1a2xVekdPNUlPYnAx?=
 =?utf-8?B?Myt3R3FPaTNvUTZNWWhvL2dsTFVIeHhMZVJKWS9jWURlemdGT2lMY1hTeFBm?=
 =?utf-8?B?ZjB4WGVmeGxiMEQ3Q2txMFIvQ0puSVZqLytPb09rK2JJUm1pYkxOWW5lenJU?=
 =?utf-8?B?NTFYUGVOVU4xUHdkSVl5Q0xlWXNLQjRocU85UURHeG9XcnJYbWtjYkZEVng1?=
 =?utf-8?B?Sjh0ME1ERmZIbE5mV09nYnlkNFBIY1haL0Z6RDBKcjgvMkgzWjZ5MW5veTFs?=
 =?utf-8?B?OVl2b29aSXk1b3ZTb1dCbXJ6TUl1OUNGd25hNjFmeWthS0MvcFhGMXpBWFhY?=
 =?utf-8?B?ZFBFdzV5aUE0dGJ1NFBGUUdsR2FHQXI3QWFFa3lDeDZFVHlqejArQkpieGNF?=
 =?utf-8?B?WnZDOG9QS3JlQWczVkNJQWdMOTJqQUgrV3g4RTB5c2RhWU1nWkVHb2hXNC85?=
 =?utf-8?B?TDB0UU5uRVVmS0xZMStMZmVkOW1SYnpZWXJueDRWbHFQTnNnenJPbGhMdDV1?=
 =?utf-8?B?bFkzL2c0QUZIVXBuamo3c0Z2bTBhRzNKZ3BacGFuOUpyL2poaDR2QjhVdlBK?=
 =?utf-8?B?ZTR1NGh6RlJZajRIbkIrbmZRVk9aVUpGRzhkQmJpdHJyV3B0cVpuL0Jndy81?=
 =?utf-8?B?QVREbERBKytqaUMwT1I1ZkZrZWRzUEwxZjdyOWRJSkM5RnF2OG9HRm9vaTRj?=
 =?utf-8?B?WG51ZkxLcDNXcmVwVERqelI5Ry9VdDE1SnhOclVuNzVNK3N4VFN2NFBEQk9Y?=
 =?utf-8?B?T3VFK2VHUFB5OTN5Q05HYjZ3TGUreEo3Vmo2NzA0a1ZNL0RtNW9RVTYzSUhm?=
 =?utf-8?B?QTNQQjA1MUkvOCtPRnNheVFXb3EzdDVFQ2xEZnMvZ3NFODJGdTdQcUtMajlx?=
 =?utf-8?B?cFRIUEpVUnI1VWo3MVRZaHZxMjQ1WmZtS3pTTk5BYStwbnkzckU1bHR0ZDNG?=
 =?utf-8?B?QjdJU3grTllTTVBGUmZDTnhQK09zcWU3MjFTeE9XOUFXcE84NXZURnhJWEht?=
 =?utf-8?B?ZVJoS2xuc1lBY0FCUTdWV3FjTys4b1VZc24wdnh3V0c0SzNVNkVtUFRSbHEz?=
 =?utf-8?B?VTFSS1lCbFRiR3pFOGVTZUxhM2ZzV0NQQ0pHOFFjOUVCQXJTU3NhOTFJNlVG?=
 =?utf-8?Q?3iBkBWsZPSEyX1zff8Ingaij1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82af719-14f4-4cc7-7c5f-08da8edeea96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 01:35:29.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv96hYfXsPqNUTc86yHudINeknorgq+/1nQpq/GWQLb7mlL2CjEok5I3eauvpyyOXiOVhvvBRGDYPCHbJ8dEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5519
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2022 5:52 PM, Shawn Guo wrote:
> On Tue, Aug 23, 2022 at 01:52:12PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Support controlling power domain managed by System Reset
>> Controller(SRC). Current supported power domain is mediamix power
>> domain.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/Kconfig     |   8 ++
>>   drivers/soc/imx/Makefile    |   1 +
>>   drivers/soc/imx/imx93-pd.c  | 164 ++++++++++++++++++++++++++++++++++++
>>   drivers/soc/imx/imx93-src.c |  33 ++++++++
>>   4 files changed, 206 insertions(+)
>>   create mode 100644 drivers/soc/imx/imx93-pd.c
>>   create mode 100644 drivers/soc/imx/imx93-src.c
>>
>> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
>> index a840494e849a..4b906791d6c7 100644
>> --- a/drivers/soc/imx/Kconfig
>> +++ b/drivers/soc/imx/Kconfig
>> @@ -20,4 +20,12 @@ config SOC_IMX8M
>>   	  support, it will provide the SoC info like SoC family,
>>   	  ID and revision etc.
>>   
>> +config SOC_IMX9
>> +	tristate "i.MX9 SoC family support"
>> +	depends on ARCH_MXC || COMPILE_TEST
>> +	default ARCH_MXC && ARM64
>> +	select SOC_BUS
>> +	help
>> +	  If you say yes here, you get support for the NXP i.MX9 family
>> +
>>   endmenu
>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
>> index 63cd29f6d4d2..a0baa2a01adb 100644
>> --- a/drivers/soc/imx/Makefile
>> +++ b/drivers/soc/imx/Makefile
>> @@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>>   obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
>>   obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
>>   obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
>> +obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
>> diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
>> new file mode 100644
>> index 000000000000..042a89cb53da
>> --- /dev/null
>> +++ b/drivers/soc/imx/imx93-pd.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2022 NXP
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/of_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
> 
> Can we sort these headers alphabetically?

Fix in V9.

> 
>> +
>> +#define MIX_SLICE_SW_CTRL_OFF		0x20
>> +#define SLICE_SW_CTRL_PSW_CTRL_OFF_MASK	BIT(4)
>> +#define SLICE_SW_CTRL_PDN_SOFT_MASK	BIT(31)
>> +
>> +#define MIX_FUNC_STAT_OFF		0xB4
>> +
>> +#define FUNC_STAT_PSW_STAT_MASK		BIT(0)
>> +#define FUNC_STAT_RST_STAT_MASK		BIT(2)
>> +#define FUNC_STAT_ISO_STAT_MASK		BIT(4)
>> +
>> +struct imx93_power_domain {
>> +	struct generic_pm_domain genpd;
>> +	struct device *dev;
>> +	void __iomem *addr;
>> +	struct clk_bulk_data *clks;
>> +	int num_clks;
>> +	bool init_off;
>> +};
>> +
>> +#define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
>> +
>> +static int imx93_pd_on(struct generic_pm_domain *genpd)
>> +{
>> +	struct imx93_power_domain *domain = to_imx93_pd(genpd);
>> +	void __iomem *addr = domain->addr;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
>> +	if (ret) {
>> +		dev_err(domain->dev, "failed to enable clocks for domain: %s\n", genpd->name);
>> +		return ret;
>> +	}
>> +
>> +	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
>> +	val &= ~SLICE_SW_CTRL_PDN_SOFT_MASK;
>> +	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>> +
>> +	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
>> +				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
>> +	if (ret) {
>> +		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx93_pd_off(struct generic_pm_domain *genpd)
>> +{
>> +	struct imx93_power_domain *domain = to_imx93_pd(genpd);
>> +	void __iomem *addr = domain->addr;
>> +	int ret;
>> +	u32 val;
>> +
>> +	/* Power off MIX */
>> +	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
>> +	val |= SLICE_SW_CTRL_PDN_SOFT_MASK;
>> +	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>> +
>> +	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
>> +				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
>> +	if (ret) {
>> +		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
>> +		return ret;
>> +	}
>> +
>> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>> +
>> +	return 0;
>> +};
>> +
>> +static int imx93_pd_remove(struct platform_device *pdev)
>> +{
>> +	struct imx93_power_domain *domain = platform_get_drvdata(pdev);
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +
>> +	if (!domain->init_off)
>> +		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>> +
>> +	of_genpd_del_provider(np);
>> +	pm_genpd_remove(&domain->genpd);
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx93_pd_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct imx93_power_domain *domain;
>> +	int ret;
>> +
>> +	domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
>> +	if (!domain)
>> +		return -ENOMEM;
>> +
>> +	domain->addr = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(domain->addr))
>> +		return PTR_ERR(domain->addr);
>> +
>> +	domain->num_clks = devm_clk_bulk_get_all(dev, &domain->clks);
>> +	if (domain->num_clks < 0)
>> +		return dev_err_probe(dev, domain->num_clks, "Failed to get domain's clocks\n");
>> +
>> +	domain->genpd.name = dev_name(dev);
>> +	domain->genpd.power_off = imx93_pd_off;
>> +	domain->genpd.power_on = imx93_pd_on;
>> +	domain->dev = dev;
>> +
>> +	domain->init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
>> +	/* Just to sync the status of hardware */
>> +	if (!domain->init_off) {
>> +		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
>> +		if (ret) {
>> +			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
>> +				domain->genpd.name);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, domain);
>> +
>> +	return of_genpd_add_provider_simple(np, &domain->genpd);
>> +}
>> +
>> +static const struct of_device_id imx93_dt_ids[] = {
> 
> Can we make the variable name a bit driver specific? 'imx93_dt_ids' is
> used in both this power domain and SRC driver below.

Yes, fix in v9.

> 
>> +	{ .compatible = "fsl,imx93-src-slice" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, imx93_dt_ids);
>> +
>> +static struct platform_driver imx93_power_domain_driver = {
>> +	.driver = {
>> +		.name	= "imx93_power_domain",
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = imx93_dt_ids,
>> +	},
>> +	.probe = imx93_pd_probe,
>> +	.remove = imx93_pd_remove,
>> +};
>> +module_platform_driver(imx93_power_domain_driver);
>> +
>> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
>> +MODULE_DESCRIPTION("NXP i.MX93 power domain driver");
>> +MODULE_LICENSE("GPL");
> 
> Considering 'SPDX-License-Identifier: GPL-2.0' above, should we use
> "GPL v2" here?

No. Per ./Documentation/process/license-rules.rst

"GPL v2"    Same as "GPL". It exists for historic reasons.

Thanks,
Peng.

> 
> Shawn
> 
>> diff --git a/drivers/soc/imx/imx93-src.c b/drivers/soc/imx/imx93-src.c
>> new file mode 100644
>> index 000000000000..830cbb9541c1
>> --- /dev/null
>> +++ b/drivers/soc/imx/imx93-src.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2022 NXP
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +
>> +static int imx93_src_probe(struct platform_device *pdev)
>> +{
>> +	return devm_of_platform_populate(&pdev->dev);
>> +}
>> +
>> +static const struct of_device_id imx93_dt_ids[] = {
>> +	{ .compatible = "fsl,imx93-src" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, imx93_dt_ids);
>> +
>> +static struct platform_driver imx93_src_driver = {
>> +	.driver = {
>> +		.name	= "imx93_src",
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = imx93_dt_ids,
>> +	},
>> +	.probe = imx93_src_probe,
>> +};
>> +module_platform_driver(imx93_src_driver);
>> +
>> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
>> +MODULE_DESCRIPTION("NXP i.MX93 src driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.37.1
>>
