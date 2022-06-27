Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E057455C9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiF0IWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiF0IWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:22:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950266309;
        Mon, 27 Jun 2022 01:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DELTK7v7+GbT3YwkeWICVMryvkvQW+t4Zvat7daeqDhvYhul6+0m7TqofgWM1ZBdCzkf7tqXLFKEaRpPBddAk4KsU12LQJDqLZFMUDel9bzM00hHmTH05Tiy6+1KlogZFOiGwDwt5kqJzhUS0QzaTwiYhzLoERziPX+YabrUTX5ZPrPROqF3KrnruPlQyL9FobsmPG1Gl/E/iQoFZMG3qtZGINZED0PUZ+OuTJOtG0zpdAOR8x8IUh3/CsMwBAc1PxmSDvYIGuOq2IGbg70iPvH6MMBBS6aiHSrRC9utEhhM4dhLie4e+8KYDhBBvXNxdqGBGDPpsIQ2TSS6FJQpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PotXxsV8fnEexJ8zg+X3TYlIxJfw9sSQxkk1qEl+VcU=;
 b=cMM0lxdRO/8fRNlFz24PfNn0MfnbVbZgVvWYrJBPdssUHtyE4XGzSPv0BPSGZUGiPQyrmOw1icIqRHvEOVazV6MldB0bTHWX3szL6i3/0ip8YNx4ervZpqw2sl3UICExWB9t1Cm13qNUNudndicMGag8FNSq8RoERfp/UQJWvPBvCIHghYo8siDc65IM97LIDdA069gh/e0OHoxkkWpBsz6zE7yI9jgujMnEckiUgzdI3Kym6nQpZdmtYpt7Eqo6wg6XWYR+jJev7ipNJLK0Swn/58Z+/vbO1UAPzifh6R/poJqz/W3A9t3bEmtI63fH4jOZEY4crnaRinRvmxZbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PotXxsV8fnEexJ8zg+X3TYlIxJfw9sSQxkk1qEl+VcU=;
 b=jtzAr4AEX+bpSPYz/Rr/ZOVrJmEb4x3KU1r+rih/JkfCuZR+qOuu2wTd4PMZLl6+q2m9aCMxoBtdM+MgfecrrecvSgekuRSKZGIsgbD9NPd8pg7PoJGaR8jT7VIy2kyoQvxYOnZBwhH2ZJ/8nTGqg39H9xhqywRY+v9DcZhDp2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 08:22:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 08:22:33 +0000
Message-ID: <cb65069b-909a-7318-68d8-eaa23c316740@oss.nxp.com>
Date:   Mon, 27 Jun 2022 16:22:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Saravana Kannan <saravanak@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        hvilleneuve@dimonoff.com, l.stach@pengutronix.de,
        abbaraju.manojsai@amarulasolutions.com, jagan@amarulasolutions.com,
        matteo.lisi@engicam.com, tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220622062027.994614-1-peng.fan@oss.nxp.com>
 <20220622072435.GT1615@pengutronix.de>
 <CAGETcx_R0zr1PMgNO8HAqcWpaQNOBGzpYdnrMa2MD=HP6mzDqg@mail.gmail.com>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
In-Reply-To: <CAGETcx_R0zr1PMgNO8HAqcWpaQNOBGzpYdnrMa2MD=HP6mzDqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04ca1e3-e65f-4783-6b13-08da58162f2b
X-MS-TrafficTypeDiagnostic: AS8PR04MB7592:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns6aHtpMyCyUwNS3Kg1oWJT0yNWaSUrXjo4wAxqKtGZvChPBJ9r/5s3U8XIXtvWp9ARIdhQTa2o/decG86fCvjKXSs9GZJRsOCaDjjAWHzefRyO9ql5ODjcyoqi21ok0W/58YCUY6Q3rt5dnUu2sbQR9VMS9Ohry/CTYjZix3YymhwTsPEgcqeOY97PlVFqCEjmEKYhabv2O4CRPunYabvGYZ9UhoZIEogfiRmsN+or2nKuJ2TaiEZTt043WIXWVNeGy+OwBMXPyP0b21hpm6cFVtSwSkixgQpzDydYVJO4+GV/uj7afd3vwZ/rd8Np7Xum0eSV5UD+QlxibVPzeOjSMcjbQazvVQnTBgG0qeq/mL1CoDJ/L1DaTlXKs0sm7L7qsp3MduynpthXMgJL3B4YwZ8qwel7oi1mTNqLwJODgFs8/d8kmDhL3rxmte2X/WU51GsiEe0RkrOLtMlTu/kDIr1eGdMKNlNdJ5P9xZ8FLs9uKMgtSmxBR/gnHTCSKCTWJ4ArHfD0D9jSCLdw+gM5XB+RH5q76+4eA3SCpn37gch3jlXfu3ofUDwaVDV/TWgaSWl54v1aQMqr4OpVJfD5q6cyfKbnykmmu1nZlcPl427EbrgcOmikX/wdV7oY7cssCekLxyfoZmfQ8kBMjkW+LjKDRrB0fLdlFTjuCq4z+HC8kpBiY1IpDtEbq8Q1VfsYrjlUSGyLnxjQB8GZyW2+2Wg/vygpdKVdtenPwLrVAqo+RXKBH6cmSqO+jdHey4w0E9n37TvDRIKTuI7AvHhHVeqzxGeZGBHBDdOkfK0Vw1f6pt9eGTyYDkqQHrc8tRjGOdJUVmhfqquvxtkRDKvD3plK1DnBtnuHSEDfOqTUfJzjAuPNkAYska8k/afO/scrqBbuQYSGDqLk59ZF+8nnCWblfIeiSB29Pvth/xv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(66476007)(83380400001)(66946007)(6486002)(186003)(6512007)(41300700001)(26005)(2906002)(8936002)(66556008)(966005)(8676002)(31696002)(6506007)(4326008)(86362001)(5660300002)(2616005)(478600001)(7416002)(53546011)(6666004)(110136005)(52116002)(316002)(31686004)(38350700002)(38100700002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpGWkFwUGlqbjJqUzBadDlZaVNOMy9GMGVBSGMveDRwNWg3UWlCclN5NVpu?=
 =?utf-8?B?ZnBDdFFUUENCMlZSREo5dGlGS2cxMGFXY0tmTWVFcUJyY24zQzUzcU1CL0FM?=
 =?utf-8?B?ZzBicnhsTm5UWlhUbStWRGZVZFZkUUFIdmlMREFjQzFwVlhzM3NyVG9sd2Rz?=
 =?utf-8?B?RzdEeVBHaGVpOUY4d2ovYndDc2JQOHFwQ09sYnNaT1VOWXk4SVlHVERTcExQ?=
 =?utf-8?B?bDRuc28ybHI4TmowR1lZUzBkRmVxT3dUWFpvalV3b1FQd3NhWHBzYnQ4Rjh2?=
 =?utf-8?B?bFNIajJBVWdodjZTWWRtOE1xbTJsbGRHRnM5VStETG1iNjExTzZCd0kzaFRz?=
 =?utf-8?B?d21WZktjaUgrS0E4cHRxQnhKaW5udm1EVHFRRUtDNC8vODQrOEtrWVVzT3FT?=
 =?utf-8?B?Y2NEUUQ5ay9mWTQ5d2Y4YzBwbGx4MW9QNXk1OEtvMWVERFNyTDRydWtrZlFP?=
 =?utf-8?B?OXFnUEQzbHE2RmhseDNqWjVOb0dvREZKeDkycHdTc1cvaEZqKyt5OFdUWHcx?=
 =?utf-8?B?QXFUcVVTMXdiWjlvaG55T1lJekNKUTFSZUdidFF5cm90eFRWK2tsNHhmUU9J?=
 =?utf-8?B?bXNDVjNMZmdBTzViOGtqdnNMZi84ZVdJQmQ5Q3VmdGNQaTN2ZWU2eiswQUJ2?=
 =?utf-8?B?U0EwY1ZNdG4xNWdkM1VxMDYwMEZqelV1bno4NU9PbUlVVjliZUpEbzZSeXl5?=
 =?utf-8?B?T3Y5dlNzbGpxaVFNalB1MHQyTHBzU1liei8rcitvK0RxZUlxSGo3aVJ4ZW1w?=
 =?utf-8?B?aGNUS2V4b2R0ckt2V0lwQU94bmNMYjcxMjJVcWFTZERTbnNZUEx2NzZWbkQr?=
 =?utf-8?B?dExUcDRqM3JIYjBWSWxPSXFHR0ZJZmZOV2lGMFlkeldvMXYzK05IcVlORXZj?=
 =?utf-8?B?dEM2L0FvYVV4em05RS81QVBWZFVFT1IxYXZJTjBhdjVOeXNZQmNOQlFTRVhS?=
 =?utf-8?B?WWVFZ3I5REVOWEhxZEFVV1lLRHlDMjdic1RCRGVySlQ1UnBDRm5tOEF6ek1Z?=
 =?utf-8?B?U3V3QnpPcE4xVEJYZFdNTUVTY0hTVm9wZEhlZU5Vd0FES0xsQWxpUUpyTlJK?=
 =?utf-8?B?a2tZQ0dZOEt5cW11YzlCV3AyZmNMcEpCd1YyTTlad1libC8xa2cvVURlamVr?=
 =?utf-8?B?TWJmNWIzM3VmTUdGc3loWWJRK3U1SWp3NmIyMTRjRDQwYVV4bTlUQnFpSXBj?=
 =?utf-8?B?OHVnc0RLNFJ6cUhTVTUwQ3psL2kzTHJGVko1Y25YWTVEWjZ4eW5vZGNRZE5w?=
 =?utf-8?B?TXk3eGRISUJycW5hNlZ1YmNYeXdOL0ltQ1AxVm9heFBiZVZhSDVDRVBpWGdP?=
 =?utf-8?B?VGNpQ2JqY2ZEdnhCRVU1UU5uNDJJQ0R3SWZ6b1BENUNzcVVRR0JBc2NhM2Fs?=
 =?utf-8?B?T0RZcWtYckVRcG9QMmF2V1lXVHdVcEVXYXE0aXk0UmEwNklja0gvQkFmWTYv?=
 =?utf-8?B?UTNrQVdJeUVyejNDWTJhZHQvNUtqQ1Q0NXVPdlRyNGdFQyt4TnVMNXpJeHNn?=
 =?utf-8?B?RUxKRHMrN3BoV0dVU2E3ZEVHSzBDTDBRa3B6emZVaFhJcEZvdk5xbHlUdDg2?=
 =?utf-8?B?MTNGTFlva0pJZUdZNnNjenhNa2FWVlcrV2dJUHVMVDJQUTJVQVVNaXU5eWdL?=
 =?utf-8?B?ajB5VjloUjY5eDJ4a01ZUnlkTnBrRndGN2xXdUVWUzRjQVVaREtOT3Z3Zitm?=
 =?utf-8?B?azEydmg3R2FJb0JBbzVTK1hldkFhNHpXTUxMZ2thRmRRcUNRY2c5OWovMXNS?=
 =?utf-8?B?M1BRK095SXZqczBRWGlkTk5WU0dvcklsblVCUnlYRlMvaGdwWkVZa24wVndy?=
 =?utf-8?B?dXdoRVAwTjBjMXJVYjRydVJjOURva1d5Y3crZWh0UFVnbGJRTHMwRzFZVFd5?=
 =?utf-8?B?OE9XbmIvTEVDRWFiUHg5TVdhNHZoS3dSYlNvZzJrY2NlTkpRSzN1V1N6Vkl2?=
 =?utf-8?B?YTl0Mlp0RUFuM09INjNKS3U4RWpHY0djR3VVcGdWU0xqVnhaekhUVVNGZlNl?=
 =?utf-8?B?Qk1iU0hoVURWUEN0MEY3NTdXbzYyRjg4MmlZenhhTFVsd2UwRWo2aEl6Mm12?=
 =?utf-8?B?THg5TldjdWV1ZmhBVm02V3RVSHdBUVdIZWMwSnlha2NpdTJVOHBwS1lQaEkw?=
 =?utf-8?Q?VkiHm5WCoVfLky/goKzNzuOg0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04ca1e3-e65f-4783-6b13-08da58162f2b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 08:22:33.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2EBIxQJXzFtlh1U07b1UPAx+4oBjQKWJYgiCcYdKSgylIZKn3Kbh729sM44PgjKvzRtJBTYzkVWRsdOyT+iIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

在 2022/6/25 15:15, Saravana Kannan 写道:
> On Wed, Jun 22, 2022 at 12:24 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> +Cc Saravana Kannan <saravanak@google.com>, the author of 71066545b48e4
>>
>> On Wed, Jun 22, 2022 at 02:20:27PM +0800, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Commit 71066545b48e4("driver core: Set fw_devlink.strict=1 by default")
>>> default set fw_devlink to true. This has a side effect to i.MX uart
>>> console. The sdma will make the i.MX8MP uart driver defer probe for some
>>> time (~10s with i.MX8MP-EVK board) until sdma ready, because sdma is a
>>> supplier with property dmas set in device tree node.
>> I just tested this on an i.MX6 board and observed the same behaviour.
>> The same will happen on any other i.MX board as well. This will also
>> likely happen on any other SoC on which the UART driver uses dmaengine.
>>
>>> Since this uart is for console, we need log printed out as soon as
>>> possible, so remove the dmas property for the uart console node.
>> Fixing this at board level is not really an option because that means
>> fixing each and every, at least i.MX board in the tree. Furthermore
>> this would mean to bring the deleted property back in and to remove
>> another dmas property should a user want to switch to another console
>> port.
>>
>> For what it's worth: NACK for 71066545b48e4.
> Hi Peng/Sascha/Fabio,
>
> I was looking at a fix for this (even when stdout-path isn't set in
> DT) and looking at the older code (say, 5.18), and it looks like
> before my recent changes the console would still only get probed
> during late_initcall(). Does that match your experience?

I could not get you. In driver, it is module init: 
module_init(imx_uart_init), not late_initcall.

Thanks,
Peng

>
> Thanks,
> Saravana
>
>> Sascha
>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V1:
>>>   The upper set fw_devlink.strict=1 patch is in linux-next tree.
>>>
>>>   arch/arm64/boot/dts/freescale/imx8mp-evk.dts                  | 2 ++
>>>   arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 2 ++
>>>   arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  | 2 ++
>>>   arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts        | 2 ++
>>>   4 files changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>>> index fb11c03bc8b1..3fdb38bc0069 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>>> @@ -359,6 +359,8 @@ &uart2 {
>>>        pinctrl-names = "default";
>>>        pinctrl-0 = <&pinctrl_uart2>;
>>>        status = "okay";
>>> +     /delete-property/ dmas;
>>> +     /delete-property/ dma-names;
>>>   };
>>>
>>>   &usb3_phy1 {
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
>>> index dd703b6a5e17..fb2b44e94482 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
>>> @@ -69,6 +69,8 @@ &uart2 {
>>>        pinctrl-names = "default";
>>>        pinctrl-0 = <&pinctrl_uart2>;
>>>        status = "okay";
>>> +     /delete-property/ dmas;
>>> +     /delete-property/ dma-names;
>>>   };
>>>
>>>   &usb3_phy0 {
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
>>> index 6aa720bafe28..68a478151292 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
>>> @@ -99,6 +99,8 @@ &uart1 {
>>>        pinctrl-names = "default";
>>>        pinctrl-0 = <&pinctrl_uart1>;
>>>        status = "okay";
>>> +     /delete-property/ dmas;
>>> +     /delete-property/ dma-names;
>>>   };
>>>
>>>   /* SD-Card */
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
>>> index 521215520a0f..f90c1ac2791c 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
>>> @@ -554,6 +554,8 @@ &uart2 {
>>>        pinctrl-names = "default";
>>>        pinctrl-0 = <&pinctrl_uart2>;
>>>        status = "okay";
>>> +     /delete-property/ dmas;
>>> +     /delete-property/ dma-names;
>>>   };
>>>
>>>   &uart4 {
>>> --
>>> 2.25.1
>>>
>>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

