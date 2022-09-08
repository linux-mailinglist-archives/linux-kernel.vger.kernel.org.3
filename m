Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5EF5B10EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHAUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiIHAU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:20:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0786C761;
        Wed,  7 Sep 2022 17:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiQJwwXuEqFXVu1R/bPJEsHqmwOFFx5kOuoND2AwgYgaQgidoIa8sQfZafWNvXgzTcGzmmpn48UPFecGb69GcdPUc8jAkAI5x6DJ9fWxcl9pVUs1UVGtWSbP/HOQDbABEI9Kp1jECY7BTa4mgqlkoTyguvFS98NpKBtDJfpY73+3CcqlCfwnkM4gyuTHe6iKM22cbZDIAdjsiAattyCjxYp8m3iEz0xTr/YjRlq1Z4eiJA5NAyQniKXow94BalQoA7DilT5Z0j9wWGrnp9jK7QKSfsf+GxSShX6+ZwbtcqVLNJ8wr/ngnk+uFJoMZJDERApWhePZWouMjTtlCjLi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga7HnA8Xh4YKMAhrkYUsHccdmPJDBjpiVryyho3I2Kc=;
 b=lRWCiFQjFWqNLWxbf4Sn7UK+adUQhVXEtTChgWgIq4LVoPleWkm8oXt75EBgXSUlp7ZgG5EGxZY0laSY4e4SUNC9m/69IA1t4DKtNsxaV1ad4jI7vY1kbZVb4csHupMQxqki/+glezq5k1WUDFNSovsBaFgQIofxb4xL5yecLSaT9JYJTyBju+iuMtjl/p5h0fU5UTNUdFz76jdnaFVBhhaGxcNZjFfag428LjH3880cTKh9j3JRVJw9wOtq2nuuCYKn/IjVngQ5lfKwty/CgJyScDAGVo0p5AsNHTr9dbvvKndPlnIkcUDFEV4Prv9ndysXrM84Zx1n624mXBVw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga7HnA8Xh4YKMAhrkYUsHccdmPJDBjpiVryyho3I2Kc=;
 b=D3JLxyoLz5FIaDvKH+VtZSPQPkdKokFGujHw9CqJsqiP+gwML+MQFalVBnojZW9lcLaoJ+/nMPj6G9y8rtPefcjqvDVIbHbVKCBatU1aDWMR8Vnt+T1fVdarEjP3b+5myVdr7LVl96QXkbGib5raqUll1k538GSJilD1VjApWak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7637.eurprd04.prod.outlook.com (2603:10a6:20b:29d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 00:20:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 00:20:23 +0000
Message-ID: <f623215c-da68-1527-442a-bec4fceefc63@oss.nxp.com>
Date:   Thu, 8 Sep 2022 08:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
 <20220822064536.3947512-6-peng.fan@oss.nxp.com> <2849448.e9J7NaK4W3@steina-w>
 <80ff145c-7f83-6d5f-7c9f-9bae1b6ffb89@oss.nxp.com>
In-Reply-To: <80ff145c-7f83-6d5f-7c9f-9bae1b6ffb89@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6808caa1-299e-4eee-de8f-08da912febd2
X-MS-TrafficTypeDiagnostic: AS8PR04MB7637:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mO/Idn6dJMCn9v9q5it4uYmGnHwaRv1mW9/tI4PCFXncEK1vAH/jS5jU+4j37dEx+ewtNhpgO5JXa2Bf4lZirSTiN6i27iR3vxhRrsfp4vK8HfCTg3yCPN4dCyz5dUbtIfoFtrL0HGZ5KmShsLXv9XLagHqSwl4Gdf6fQ7oy2iKNenaleewfO/tjNEoy0gLIv23H6d9cY+gfodPRBDfUYYZRMk/0FUdHq2UtFE96RW3B5048OEHhk05ACegtODjqyIe/a6AXc4fI6MUnsi4hMCEUFcCZh+7bUDQDpJyj51zKGlFew/pH6ZDueJIVmhmiyLHuw+e2DiytSk/Wc7yT9T/o2ksONQQ9f5TFDHrF8QksPkqqGcLA49AjCiTM4RZwIzWbZO046siqIKYQalP1urHTcFwnwkPg29y1llIylifMXlQ0X6z0DA31e4B5aSoEr5fV/Ar5r2YKDMksxtN7t2I7Ot7dpU6+IXHjvQYwKeIZbMfWGQPLPgtr+POpR8SA72eRmvy50EfxVlEp++SCMlsJAHrMjCK/pHuSJ0xvq0g0h44rUObcrc5n5Ini2SHkG8mGGYHKmsFiNJF+fJJ0Zy7dGBuJBnf+3R3WUzovgWfcFB4P+4ot5U+iJT5Ybd52zpR8gP286aK2hPtNKF17CRGJfLNO/y3nFA55MMwCrOLG7GFfSUkBPnkjZXNiCmHGegG12p87e00j2uBTh/9ehC0Hg2p2h83FwAC0/4TFgOyXhW2evFEwRJzIxH/eLQrVL2frpaFFl0FyXmd+bq+19G8EWLsrZAeVobUU3kfqjtr+oDVe8FKhT3kUxNdaYlYYmxrkLB67akywL/qIm3wId7oHTPf0PmzNoBn1/5abzII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(41300700001)(5660300002)(316002)(31686004)(44832011)(8936002)(6916009)(2906002)(45080400002)(4326008)(66946007)(7416002)(8676002)(66476007)(66556008)(478600001)(52116002)(26005)(6666004)(6486002)(966005)(53546011)(31696002)(2616005)(186003)(38350700002)(38100700002)(6506007)(86362001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkhITlBDa3F4VEh0NVBWdlNncTRTQmdaTWM4eTFGU0dsS0dONWZoUTUxMVhm?=
 =?utf-8?B?MktxZEhqZE1qcUppNlFvbHpnS0VRak51ekZybkNaZ0Z1T3dlYWl5RTdraHRq?=
 =?utf-8?B?WVNuSENqbWxGL2xJc0Ntb0tmM3dlMjZMSW5YMmtJNHNvYm9lek5LNGRlV0F6?=
 =?utf-8?B?N25vMTd5WUEyVTI3YmYwaGZkMVVmTXJORnRBd25hMGtTUmNHZ2c5dTE5dDZJ?=
 =?utf-8?B?TGV5bEdoZktpMU02Mlp6ZmZwTk1pWHlsSVYweSsvTHh3NHNkR1hYQ3V6WTJZ?=
 =?utf-8?B?TlZkYmdMTGxJWDMreXJuR3B4UExsdHU0NVIyZVJGSnZTNUVDUzYrN3FMcVU5?=
 =?utf-8?B?UEtpakNHcGpQUmU5ZXNrMFluZy9CbGRrcElxUGRkdmZSdlVCcnhMRzF5eHdj?=
 =?utf-8?B?THlqeDNHcGYzdmc4S2RORk1veWFvaWZIY0EwNlNJOGxpNkFXcEkvZG0vbDVk?=
 =?utf-8?B?RzNRVS9LWHJDNE94Zk9IRkMxMm9tK0JuQTVRWlFtZS9hN3JiZjBaNCsvd1FB?=
 =?utf-8?B?UEc0bmdrODFrS1lIN0xRV1Vva3g3ZVgxOUdTQ1FZVW4vUXYvMlIrRTJLOWc5?=
 =?utf-8?B?dXNVdVhoOFgrMGtnMmFHNVFyOENDZlkvby9jTFF1aHFiL1RSbG5KV21JQkZt?=
 =?utf-8?B?S1ZLWVRTcmtKNXI1blBBR2VBUUt5c2hnK0IwSHhxTm9Pd0g1cFZyN2p5ZUNR?=
 =?utf-8?B?TjMrUnEwNk5qNmwzd3cvL0lqVkppZFkvMjlDY1BvY1doSDl4TGZOUERzR3ho?=
 =?utf-8?B?b0hDcVpyZ0hwRFRrTWZmaWtXSlQrQjdialRJaWFkNVB2Rnpxc0UyaUNhRmJI?=
 =?utf-8?B?U1kwcG81UGVQM1B3Rmd1MkVVNll1RVRYNVhZNVhxN29kMEljTkZOTUpITkFC?=
 =?utf-8?B?d291K2NORkFVQit5V0ZCQTVqZXV4U2F1SXlEeWxkcDhmSkFmRUNKbHM2TWFC?=
 =?utf-8?B?dnBOeFdXWXdJNmYzN0hCSkpHV3FHTDNjZnFPSlhwaW92eXFpODN4Zkt4b0k3?=
 =?utf-8?B?TjBwLzRadzdBZ2xtTDh1V05xOHN1Y3E4QXNXc0xWVjlRWUZYbVIrQnptMi9h?=
 =?utf-8?B?ZDJxUndTY2crV2Q4Sm0ySGx5dGFWSzVyZUwxQWtnUDQ2ZEEzVndsREF0TVR1?=
 =?utf-8?B?SmNvYWZzSjFLcnhoUmJYN1FxbUk1SjBIb3RZeHIrQVFINFNseUI4RWt4akVC?=
 =?utf-8?B?V014aHJocmozTUhtTXlIRTVOOFg3a0g2dEFTV0E5bDUzR2NnaEZtSDE5andv?=
 =?utf-8?B?YWpncVZuODZwc0dtWUZ5ZDFlSVcvanNqcjdhQk1iUWQxK2NzMlJRaTVxZUNS?=
 =?utf-8?B?Q0xzYjlaTXVUdHkvY0dpSW9IdWd2ajVOM01LSEdFYXZnR2plUFhPbG5VOEZ6?=
 =?utf-8?B?SVdBemdXenZ5QzFxUW0rYVQ4enFaQnYrVkZmeGdsbmZaNjlmUjJpdzNISTlk?=
 =?utf-8?B?ckdzVnJ2MkhLdmJBQzhjVEdaMFgzLzR3WlZNSmNCa2s4OVRWZ29HY3JvOFQy?=
 =?utf-8?B?M1lHZytMaFY0OXNFQWFzU1hYMng5Sk01MnBMZWxKaFUxcDJ3N2kxWGpIN2ZR?=
 =?utf-8?B?bFB0dW9BcEN4NmF4T09ZT0VJclhqTTBnK2FUOElBbUhpQTFWWTcyUmdlem1p?=
 =?utf-8?B?b1UwYUQwM2VBcG0wdE1rNDNwQWRFQmN3YXpJUGJJS041Nkt0V2NIdWtOS29L?=
 =?utf-8?B?TGZQZnZrODB1QkMwS2RGTndnaEE2bDhTRmNyeDJzNklsaUJYdEtJcG0reUhr?=
 =?utf-8?B?dk1IemV6WG1SandTMFIrQ2lvN0pEWkkvbGRYMlZybmVwak56SjJBV0xVWXRz?=
 =?utf-8?B?ZHBoYzIyYlZEeFEzbVBiN1pndUxoUFFXbTMwT0thdi9OK09Nd0N3TmFqbW9v?=
 =?utf-8?B?U21RNExyL0RPS2d1WGY2ZUtLWmxBVEtLbHNOS0tLelZhRFRLZlBEWVluVzJP?=
 =?utf-8?B?dGJJOUhPMFZ2d0RseWlYMFhhdDlKQ0lwS1hDVkhWRmhtZXRNNDczMkxIdVh6?=
 =?utf-8?B?TThjYzRlallDQnRSVFpXVTVZVGl6UWlYclhjdEY2dUY0YXZ1ZUJZQW11bUFV?=
 =?utf-8?B?WnVxNWtTczJXR2tNMHJHRGZoYUNuSnpjYklyc3A0YnZ2WDZ5UnFMdHYxZVJH?=
 =?utf-8?Q?YpH4SgIMsAGD4D65xOEjXLaVr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6808caa1-299e-4eee-de8f-08da912febd2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:20:23.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtxuuxiDoHBIEJzdNpxTq7THZ47uHE47VzYopmiugIuNIXvL7AWLqxX3DHedAI70DxXhhpdTmNtjuQ4SNyWi2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7637
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 10:41 AM, Peng Fan wrote:
> 
> 
> On 9/6/2022 10:37 PM, Alexander Stein wrote:
>> Hello,
>>
>> Am Montag, 22. August 2022, 08:45:33 CEST schrieb Peng Fan (OSS):
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video Memory Write Master
>>> for RXRX validation), so add them.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>   drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
>>> b/drivers/soc/imx/imx8mp-blk-ctrl.c index 6f983adcb47c..527d45d12a54 
>>> 100644
>>> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
>>> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
>>> @@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct
>>> imx8mp_blk_ctrl *bc, regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
>>> BIT(12));
>>>           regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
>>>           break;
>>> +    case IMX8MP_HDMIBLK_PD_HDCP:
>>> +        regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
>>> +        break;
>>> +    case IMX8MP_HDMIBLK_PD_HRV:
>>> +        regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) |
>> BIT(4) | BIT(5));
>>> +        regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
>> BIT(15));
>>> +        break;
>>>       default:
>>>           break;
>>>       }
>>> @@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct
>>> imx8mp_blk_ctrl *bc, regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
>>> BIT(12));
>>>           regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22)
>> | BIT(24));
>>>           break;
>>> +    case IMX8MP_HDMIBLK_PD_HDCP:
>>> +        regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
>> BIT(11));
>>> +        break;
>>> +    case IMX8MP_HDMIBLK_PD_HRV:
>>> +        regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
>> BIT(15));
>>> +        regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
>> | BIT(4) |
>>> BIT(5)); +        break;
>>>       default:
>>>           break;
>>>       }
>>> @@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data
>>> imx8mp_hdmi_domain_data[] = { .num_clks = 2,
>>>           .gpc_name = "hdmi-tx-phy",
>>>       },
>>> +    [IMX8MP_HDMIBLK_PD_HRV] = {
>>> +        .name = "hdmiblk-hrv",
>>> +        .clk_names = (const char *[]){ "axi", "apb" },
>>> +        .num_clks = 2,
>>> +        .gpc_name = "hrv",
>>> +        .path_names = (const char *[]){"hrv"},
>>> +        .num_paths = 1,
>>> +    },
>>> +    [IMX8MP_HDMIBLK_PD_HDCP] = {
>>> +        .name = "hdmiblk-hdcp",
>>> +        .clk_names = (const char *[]){ "axi", "apb" },
>>> +        .num_clks = 2,
>>> +        .gpc_name = "hdcp",
>>> +        .path_names = (const char *[]){"hdcp"},
>>> +        .num_paths = 1,
>>> +    },
>>>   };
>>>
>>>   static const struct imx8mp_blk_ctrl_data 
>>> imx8mp_hdmi_blk_ctl_dev_data = {
>>
>> Something is missing here. Iget the following error during boot:
>> [    0.886211] Unable to handle kernel NULL pointer dereference at 
>> virtual
>> address 0000000000000000
>> [    0.895043] Mem abort info:
>> [    0.897841]   ESR = 0x0000000096000004
>> [    0.901606]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    0.906942]   SET = 0, FnV = 0
>> [    0.910003]   EA = 0, S1PTW = 0
>> [    0.913159]   FSC = 0x04: level 0 translation fault
>> [    0.918054] Data abort info:
>> [    0.920943]   ISV = 0, ISS = 0x00000004
>> [    0.924791]   CM = 0, WnR = 0
>> [    0.927761] [0000000000000000] user address but active_mm is swapper
>> [    0.934157] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [    0.939749] Modules linked in:
>> [    0.942813] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc4-
>> next-20220906+ #674 2c55fa642ba20b0dbb66c0e78dacc9ca96d5e733
>> [    0.954099] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on 
>> MBa8MPxL (DT)
>> [    0.961100] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
>> BTYPE=--)
>> [    0.968099] pc : kobject_set_name_vargs+0x10/0xd0
>> [    0.972823] lr : dev_set_name+0x58/0x80
>> [    0.976674] sp : ffff800009c7b860
>> [    0.979997] x29: ffff800009c7b860 x28: ffff000002d728f8 x27:
>> 0000000000000150
>> [    0.987172] x26: 0000000000000009 x25: 0000000000000007 x24:
>> ffff800009ab8958
>> [    0.994347] x23: ffff0000000a0000 x22: ffff800008eb77d8 x21:
>> ffff000000225410
>> [    1.001524] x20: ffff800008eb7808 x19: 0000000000000000 x18:
>> 0000000000000000
>> [    1.008697] x17: 702d78742d696d64 x16: 682d6b6c62696d64 x15:
>> 68203a656d616e3e
>> [    1.015872] x14: 0000000000000000 x13: 70636468203a656d x12:
>> 616e5f6370673e2d
>> [    1.023047] x11: 61746164203a6c72 x10: 74632d6b6c622e30 x9 :
>> 7274632d6b6c622e
>> [    1.030222] x8 : 3030303063663233 x7 : 205d353039393738 x6 :
>> ffff800009a240e0
>> [    1.037397] x5 : 00000000ffffffd0 x4 : ffff800009c7b920 x3 :
>> 00000000ffffffd0
>> [    1.044572] x2 : ffff800009c7b8d0 x1 : ffff80000936ca78 x0 :
>> 0000000000000000
>> [    1.051749] Call trace:
>> [    1.054199]  kobject_set_name_vargs+0x10/0xd0
>> [    1.058574]  dev_set_name+0x58/0x80
>> [    1.062072]  imx8mp_blk_ctrl_probe+0x5c0/0x660
>> [    1.066534]  platform_probe+0x64/0x100
>> [    1.070297]  call_driver_probe+0x28/0x140
>> [    1.074322]  really_probe+0xc0/0x334
>> [    1.077909]  __driver_probe_device+0x84/0x144
>> [    1.082284]  driver_probe_device+0x38/0x130
>> [    1.086486]  __driver_attach+0xac/0x244
>> [    1.090334]  bus_for_each_dev+0x6c/0xc0
>> [    1.094184]  driver_attach+0x20/0x30
>> [    1.097772]  bus_add_driver+0x174/0x244
>> [    1.101622]  driver_register+0x74/0x120
>> [    1.105474]  __platform_driver_register+0x24/0x30
>> [    1.110197]  imx8mp_blk_ctrl_driver_init+0x18/0x20
>> [    1.115009]  do_one_initcall+0x58/0x200
>> [    1.118861]  do_initcalls+0x164/0x19c
>> [    1.122534]  kernel_init_freeable+0x134/0x17c
>> [    1.126909]  kernel_init+0x2c/0x150
>> [    1.130411]  ret_from_fork+0x10/0x20
>> [    1.134003] Code: a9bb7bfd 910003fd a90153f3 aa0003f3 (f9400000)
>> [    1.140127] ---[ end trace 0000000000000000 ]---
>>
>> Adding some debug out shows:
>> [    0.866795] imx8mp-blk-ctrl 32fc0000.blk-ctrl: domain->power_dev: 0x0
>> [    0.873257] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->name: 
>> hdmiblk-hdcp
>> [    0.879905] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->gpc_name: hdcp
>>
>> AFAICS the power domains 'hrv' and 'hdcp' are missing in the 
>> 'hdmi_blk_ctrl:
>> blk-ctrl@32fc0000' node thus resulting in a NULL pointer from calling
>> dev_pm_domain_attach_by_name().

yes, you are correct.

Should add hrv/hdcp entry in hdmi_blk_ctrl node to Lucas's patch:
https://lore.kernel.org/all/20220826192932.3217260-1-l.stach@pengutronix.de/

Regards,
Peng.

> 
> The HDMI blk ctrl dts not landed in Shawn's branch, could you share me 
> your dts change?
> 
> And dev_set_name, as I recall, Lucas has a patch to remove that.
> 
> Regards,
> Peng.
> 
>>
>> Is there a patch I am missing.
>>
>> Best regards,
>> Alexander
>>
>>
