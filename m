Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5C59CD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiHWBFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbiHWBFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:05:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ECB57881;
        Mon, 22 Aug 2022 18:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYxdRvdmoeyt3QrQXyXVxtmkYxod9Vd2k4R2YuTPbuAE8hI9Ur2wirfsrP8boJGJGn/gQDlQ3a0/AEWypGwft4bqqNv3DrZn8jlDCLJtHsw/M7xdqRVlJibCQLg7hRkExur6H+pD7a5aul328y65EmdHx2XhcgXYGuCIA4IpJ5dlJlY7nO12llSdE94A/0y4ao7nUGsOX+ifoqXsFl0tRt2cGOTn4l8Q7CEBt5kdhPMJb9AcychX/iHhLkmGLJpmWWiGVQrJYXIPu5UwxXZX7XvYujyc8ougAIACmvpPKFwBzRGaWcH+cQ/bV/8/CNVE05nNnQ2RSFyp+PdNJPbd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEvHeOiJ1sj4oY1XFHgjBLHFfI5ShoZv5BHn9nGa35M=;
 b=DJN7f7XKJB/SzMuMuU+8vy/aiqncxhmzYJvUX0+SIdALeaFBR4OiOG525pGNk93RVA/wXetK+/3kqtDZv8rKdFV4+TTU9jUYEiorpM4D/nn6+snj6Wkb/e81ipBnu8HU7CktxY5CAh/9oIObLiEIG44na+WHoizlgYohydHb0/wN2iBrTf+STb93BhunvvSHZKufcghGf5OgL258xP0NgBsOOzLaOZfMeadeH8kb26RkbvijCMkSmRrwPr0Kz7sL/aI/DIuTNdl3IqHhudXjYaGCFnHA0ltAzhKBjsCtSqeDamLOcRTMU9Ub3jxWpNTlja+g0+RpN+NyOyBNltmlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEvHeOiJ1sj4oY1XFHgjBLHFfI5ShoZv5BHn9nGa35M=;
 b=BaG+aABhz64VgzsJa3BXjr61r8Hqc1C4I4ioDJB9Wik8GyzhhoSoqgYW/AzJXAPYDSmXAgeWR7L4b6l1KyZ7BNXAKveJ9NHdPprxArHRddQn8dVGG2M0zg5IaqLIS0RPufzYeGoCsMI5TZSwzViID0dqxevxUriC9ojRlNw5MVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 01:05:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 01:05:11 +0000
Message-ID: <6ac64bd3-ccfe-9043-0795-a63bdbe23310@oss.nxp.com>
Date:   Tue, 23 Aug 2022 09:05:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V2] clk: imx: support protected-clocks
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220816130327.2987710-1-peng.fan@oss.nxp.com>
 <20220816150201.GS2387@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220816150201.GS2387@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ce590f-abb6-41e1-57d5-08da84a38724
X-MS-TrafficTypeDiagnostic: PAXPR04MB8622:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OUqI25fGcP+yGPWsrUB7+QAlOdh5wUpwdqpDy7pQiNOteuix4BCXVa8BtDIkaK/04akZFM4sKzATqRZb+fJ7XRKByqmqmdhEQ/HWAsh7gwsJOWsOO/JuNk6Uz4TiRzABCDqZ4X+tsK5N3+iIOoy1ic6Z3GtxneZQ4h97xSQiceHyPQeBPzeU+g4Q0l3Lul9qkF3Qtk+aavW6OZ3wlni+blYzx4HoNrtqoOfbK3dWVhc/LISSf2/1tSw6nTGMqFSInXsV48CBLMcYgYmAyBm7+Br1bPiU3CcLQzXXI+tKaHSvyXAbXwOsiIsBFWIlqDAbWqj53J14rRNawy1kIC5Z2kAR6kJ1bBYgm5DMnH6N/62kuuMT/SpXeF4gblZNInleP6Md+NNgSdZoRiQcZrNKvad+WUtPDwpTtz/Z6Khz1xGBISLE1h7C83AxTHzAH7MSu1oUM8Xv5L5RTZ27RsfAe89/Zg5xqVmXMgzcQ/Vh46PsV4bbjLwl50PvyzpWvQuILSnzvN4GO7zoHZWaHL0KCq8/9WwWCeweSVr3H6IZNuRhY2BzNsOaOZm4C3UqzI+zBo1g7CNSvpeGhmYV8THMQnZOElVA4cDTwW8EtdiPD9y6xAyZhfEH44WpMnpXsh/XZvO1OQm4vDoz99ZYI/dLTg84X71HpyoHH7KR8hu3qHh5F9CkBpusH1sp7XOvgjYefxB8XuR7ZDbXe4BxKy94eukAzfWyobDTb218JfUJpt4T70mbDohdjsQhohOw4iIekRynxrLsnY3JTmgSE5jOP2+7+Mcq9XySzIMLUUjemAYhVAUkTlbG5ey7b0Y544GppP0G23rEuZmlGHfCgR7Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(478600001)(38350700002)(6666004)(52116002)(53546011)(6506007)(31696002)(86362001)(31686004)(6512007)(83380400001)(26005)(2616005)(6486002)(186003)(41300700001)(66476007)(4326008)(8676002)(316002)(6916009)(66556008)(66946007)(38100700002)(44832011)(7416002)(5660300002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkd5OU1KMnhpT0w1K05Ta0hISmRjbU9jT0p6TXFhd1ZrVXlTNG9waDhRcWI2?=
 =?utf-8?B?eGdieXdmVDd0Ui85ZTRuRUltY21HemxmVC9HMXlrc1Z6eEJKbGJNUGt0K1JG?=
 =?utf-8?B?ZkgzZGprMzJjTThCcXpQNEN1WGVRY3BSOFJhSmdZcTV5QW9mb2RmOVdhYjNB?=
 =?utf-8?B?MkgvM085WTVqWHlkTmVBOGxzR0k1TVVrNDBNdHh5SUptK3IwSm02YWRYQ2lt?=
 =?utf-8?B?TzJTRTdDaVgwcjBNQTBsZVBRYWVvMDI3TGNXYlQ0dVMxU3UwdWZhbUFPN3Rz?=
 =?utf-8?B?d3lycm56ckFSdGZpbDU1Qm9sVWtvUnVaRkM1cVVUbWVsbVdGZFpIa05SMXQx?=
 =?utf-8?B?S0l1VWtQKzR6VmF3ZTRIZERYRnhra1FLZkFXMXc5U0IrT01yQXBhV2R0aDhX?=
 =?utf-8?B?MEMxeTdTaTFqRUo3Qk9kb2VFYmZVYmloaFB6V0UrUUtucHV4Qlg5U0YvaFBi?=
 =?utf-8?B?YlZCMEd5NDZ6SGxjcHlHT3prcUdtR0RrRjFwa1hQVzZKeVNvdWNwamx3RWNh?=
 =?utf-8?B?aVNRT1Rsb2NsNmYrYmxkTWlqUjlvaStIY3hqYTZSeGpTd3BsUFhuNHgxM282?=
 =?utf-8?B?cVFPS2lCTldVMXpRN1hwZUhDWURzdTJBUmdoRVRyRjJha2Y0UjYra3VFazlG?=
 =?utf-8?B?eitHVmlFUzFKWnJjNGhhUEVZR1gwMjNUcTJ4SHpjUW1PVGg1SWI3Z29QWmg3?=
 =?utf-8?B?WWtmOEduWm1GMUs1MWFQdVF1S2gwcTYzcmZNUW9KUWFmbkJJQzgycFdJTnVv?=
 =?utf-8?B?cFJnbGNqU0lNRTNQVHJyd3BIcXp4Z0h5UjlIVGRaemw0eklGSFY2bi94OXBF?=
 =?utf-8?B?MTI0bUVUbWNvTHdGT0l4VXRyQ0d3VjFBRCtvcWY4WFZ0RVBKTzlmNzdTc0VJ?=
 =?utf-8?B?L291clNEUXZQb0VSdFp6d1hsTkNBMHplY1F6Sm56NlIrSU5NQnhpbHlETFZr?=
 =?utf-8?B?c1lMMHBoN3VpYS9MQlROVVF0bmg3MjBmcHd0Syt1MmFTMFY2R1F4dGQwMlBs?=
 =?utf-8?B?OHZhOWtrWnpneFZtbFAzWitZTm9FZEFZWTRWd2JROTFnVkhsTWw3d1hQTjFp?=
 =?utf-8?B?RXI4ZDl5czZEVktsK2kycTNGcDBiYTQvL2w2YlJDVE14K3k0V2NkV2NUV1hY?=
 =?utf-8?B?aFRRaWtPMXlWZzlNSWcxNlBjTUFCQlFHM055a1JLQVVKL0gwSU9YaUxja0Nj?=
 =?utf-8?B?TkYwUk4rTFQ3Q3pPYTFIT1dSMEtFZUt0cmJTamZ4azdQaFNBUGpWZU1ORENU?=
 =?utf-8?B?UDZTdU9yVWdmOHpMck5Tb2dOeXp3Vm1PYUN0STVOVVdyejQxRzRhWkJLOGVp?=
 =?utf-8?B?K05qZnd2K012c241MTZrTkJHNndRMitERnFNM2lZSEJ1RVpjVFVsYjMyeENR?=
 =?utf-8?B?TFNZbXMrMEV5MzZBcUdoVmpzUnZPQ2NPZnFNNEJLL1BaaHNrcHIrVWhPSVJp?=
 =?utf-8?B?NGVVd004NUdyazNYby9NTDcrTlp1QkZvVlg5cEJBVmdvSUprQ2NYZXZacm9N?=
 =?utf-8?B?VkFLM1VZTG9kbFQ4TWtWSGMwbUFEVzZ2NEdNMW5Ja2F4RFp4N0xhUTdaVnVx?=
 =?utf-8?B?bFBlSzlWcU1LNER5b0RaZktOcDlkb09tN3hvbVhmOVZjLzhCUGxlcmg2bWNW?=
 =?utf-8?B?aEtxcEdQTFVhRzlZeVM0QzRGYTBhM3M0d08zQURGbnRzWnIxTm02bm5JTC91?=
 =?utf-8?B?UnV5eXZ0eUR3NjlJemI3cjZJMnNVWitvd1dUUThpTmZpUnprcVZSSGhrMkhv?=
 =?utf-8?B?MTQxVlJ0N2dWOHlSYUt3ckdiZm9KRWwrTS9GSkExeEtIUXhVUDlLYVpYSHRL?=
 =?utf-8?B?REc5TGhBRUVkS0FvbzNGQjZnK0hVeERXbm9Iall3UWpHSDJEZ3NQNEhnQi9G?=
 =?utf-8?B?UzJ4Ny9uZzFMOSthK0RiM2J6d0t3Z2pmdWhwQWN6cldIbnhPMUdzZWxid0hO?=
 =?utf-8?B?UkJlUnI4cVQ5ZVQzV09aeDF1VnFyWnBOc2YvVHdhMGNnRmIwRm9CRWtkSWhv?=
 =?utf-8?B?MnQwVGdRcWN1Ym9CMnAzYmVmK3l6bEFWUnNtYjNLUEhJL2R2NVBOVmpWMWt4?=
 =?utf-8?B?QmMyclYvOEloVGJjU0NrY0l2bCszTmZQWDU5SFJQN1ZPVjVqQlRUV0ExdklR?=
 =?utf-8?Q?UNgcHi0ALaQJ0twbRzuvwvC1r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ce590f-abb6-41e1-57d5-08da84a38724
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 01:05:11.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xbYHH0uxQxpAKFhoROfYRgq8J/RqpMKn5D/LinVeD67i/iNRWbOEiT/B2WkEyytTYJXGzPWVwf5tmMMX/D3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2022 11:02 PM, Sascha Hauer wrote:
> On Tue, Aug 16, 2022 at 09:03:27PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> For the clocks listed in protected-clocks, enable them to avoid
>> Linux disable them. This will benifit root Linux and inmate cell run
>> on top of Jailhouse hypervisor, and benifit the other case(
>> A53 Linux run together with M7 RTOS).
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> V2:
>>   Per Sascha, use common protected-clocks property.
> 
> See my mail to v1. I did not request that you should use the
> protected-clocks property:
> 
>> There were cases when a property first started with a "soc," prefix and
>> later when people realized that it could be useful for other
>> drivers/SoCs as well, the prefix was removed. With that in mind I
>> would expect that a "fsl,protected-clocks" property behaves the same
>> as a "protected-clocks" property without the prefix.
>>
>> If it doesn't please pick a different name. I didn't want to suggest
>> to just drop the "fsl," prefix and to use the generic property name
>> when the properties have a different meaning.

oh, I misunderstood.

Here I just wanna linux prepare enable clks and never off them,
the clks may vary per different usecase.

how about
fsl,init-on-clks=<xx>?
or extend to
fsl,init-on-clks-with-rate=<xx>?

Thanks,
Peng.
> 
> Sascha
> 
