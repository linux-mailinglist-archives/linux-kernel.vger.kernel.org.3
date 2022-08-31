Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6A5A7F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiHaNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiHaNmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:42:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A9BBA68;
        Wed, 31 Aug 2022 06:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+KxR+aeD+5VriqInOSkPbFNXDKWQjsJcFZXYFwDqZKHFb0xPjHnbTVDWYnhADEmzI8DjmdBEnYVn2Igi5KxxvzXcMlUIjt8wfEr6zhV6ht1/GdSTomCqKao9mAcIZ6I9votNZ3rAGtuolcGU8dsIscGiLrGkDJEWj+gwmVzUpYc3bOj0avB1Kg01QWQm7KK4KrCJe2DDPiAe0D6qFaayNOWPcZx3ex/QOzySrWoulwypJGV8Jjow+C8dATZR+lnt+csUvvralgXv6kUdc+WZMLnTISHM9Xf5PeTJkDGguV9Yh6TqEnLZpfP2hIsNzIp9FHDD1dIGh/k2KJr9XmYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjlnknrt4RdQbppF4L/+5bfyQwpSzu7N2udgJFThrpk=;
 b=X61m+nWOROjpWRiNTPqlTaoUtunwj1YICNilSZq3cbTZWOyfCkk2UZOTFai34w/9rarIAPHNTHyMlPVapp/zaFnhJhRXZliZaX7FNJk+pFJHtTgg6shTQEXwMNf/KAsw287Ga7sHYJPOs0/1aL02woekFxFjoUp0K/phrgQlPaYlesRLYDw+JBBKvVSlvoSkLYdF2CT75eZ0B/EVRluXzcuBKUOFTVMPcnjy1Pxnb59cWeGtyZRLQ9lc4PH2oK3p/VPSgarmQGVBPVELtD9/qZ9MJGk6r+r2PRm6jiVzAkYccPGmeEkGVyGh8RhIK3qQd2glxh+IJx4oqkdvEL1PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjlnknrt4RdQbppF4L/+5bfyQwpSzu7N2udgJFThrpk=;
 b=C9/V06SFj8K3Jjd2xZKbR7NqoAJRKh+aYlkj1vFvKbWsoBa6M/85E+BMqLm2VFSFUPZlF6nDYqwYogOtZxofO/8Nn0VFprolVHHQc9L6hBWsc7expDVEOQjymTC7cVA6OPjirjY8pUwgokIfJkpBhXYuveP5xHrudh434NqKBu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB3263.eurprd04.prod.outlook.com (2603:10a6:802:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 13:42:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 13:42:05 +0000
Message-ID: <0cacdfc0-b62d-ddd4-825e-3118071fe365@oss.nxp.com>
Date:   Wed, 31 Aug 2022 21:41:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
 syscon
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
 <20220831074923.3085937-2-peng.fan@oss.nxp.com>
 <cb3870bc-451a-ff62-e671-f2045eecc781@linaro.org>
 <9c7854a2-bc9c-f4e6-3b37-f740e05768c5@oss.nxp.com>
 <7f8a4f33-4bde-384f-f541-f383c8e0b27d@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <7f8a4f33-4bde-384f-f541-f383c8e0b27d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10a549e7-667e-4e4d-30b6-08da8b569741
X-MS-TrafficTypeDiagnostic: VI1PR04MB3263:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqMKfNSjxfUjGgjUlVP/ZdmR+qiGNDJxCR2/kz1+lWwyd38UW+ijO3kb67eUNcnlWzcInNj1S6rNhu5FysQwrTbG7jcN9QFtDlmXXmPmW0wNOad5TgJDuzn0X3Zw8KNegKO0De/2+PiG7u7DEQ0g79haCGotw9CvIeqeoDpDPEfAOmIzkcHCDJINHIsa6jPsWaxE8SB5y7rw2n8NI4thYIZXtXFhFIqio5rNHeSnqpw37zIOvq8oDiZ0cHbhCSO4l6Ibsw/hyNX3Tq+IQdISp50nXUCcv0bDG1lusk9+ma2Qepaqitqn92lVXULxamlp2IJdAbijqfDbVyc1k3eL2XD2DZF4hilKjwICWWgJPL2diwZS7BrrUeO+cxhXCg2sd7J8G+eF9frCuhQu8dIcyV6AMp75TDNIlc1Y2NlqvfAr8YpnKy6JvkG6CP7B1QM1xmaIC8715MnTfg7DUjmetdHozGFEUGpOxxE+BgMIrCuhnWvI7ou9fq7d+5agyFxtyC8Nm2Ie+jPPOdQ4JfaVeQH3b/qSh5gUI0D3LtwImAMI7hzcw7RB+SXYXxAFVZrQzkITdh/k4EixIHp51rcNofrz5Ks/wEyf4UqCx8ogMeWOrXw95wejqgZvF5mpuBpmLWL0pcdDPpyWlJEk+X6fF3XO8IeJgti2VGW3KMg/6lFBbqKyg2qkwpudRqtqy9Geqnzt9cxYBDvqANKyWFMH08L+m3YZo8zxg3ygRNv9koJn22P0vnAk7wH7QMt1PiGbk47s1GK+kHqfTXFtt6OZnAT5E4q3WK4t8wafoh7i5XneXZiqrWo1Jojk4Yk1+7AFg8KL3MOsDjqfCOSPHpLTK1OCRdehYKf3kvPOphANFTLXQMUVE3aLvoVirC9f0DL1MX+twhg85FtDzEPj4/xRbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(2616005)(31686004)(316002)(31696002)(38350700002)(38100700002)(86362001)(52116002)(83380400001)(53546011)(2906002)(66946007)(8676002)(66556008)(6486002)(4326008)(66476007)(44832011)(6666004)(186003)(478600001)(7416002)(6506007)(41300700001)(6512007)(8936002)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uks0NnJ4aVorcGI1alhtNDV3MG1pcW5MYStYTHlhc2ptdy9ha2NyWGFSMGVN?=
 =?utf-8?B?cjU1cGpid1h2QlVCVHVPUHlJQ2d2T29PWmIyaUtiSlQxM3ZWM0lSd2pGNGFz?=
 =?utf-8?B?ZEhrbkc0MFhZb3FwZ3dmQlRiVlFUMjI5d0ZKdjlQT0FvNHQ0aUlobGVnczFS?=
 =?utf-8?B?N3ZZeENzRVJSSTNSS20rWHRFTEhqMEpEUjhOeVNLNE5jbGpJbmtWRDl3SCtl?=
 =?utf-8?B?dGZkcGU2ZHJIb1dFdW1UYzVkeHUvN3IyMnM3cWhrblM0NUVEYUNEcDczcENR?=
 =?utf-8?B?aW00blR3UDJjaGhiV2JoYVJtLzMzeHN6dFNsZE96UWpBUFUrcCt3dWo1YVA5?=
 =?utf-8?B?VDBZazExVnkwa0lOS1diYUM2ck10U3QrNS9mYytJU0ZwcHJManFxeHJiRm5I?=
 =?utf-8?B?bForZEJjZEVhbVBaTkQzZTA1R3UzVlo5RGJuNHFzKzFZbmNVOHhhWEx3Q0Nr?=
 =?utf-8?B?aFdPaytGYXdSbkJCcHN4WXdzb1Y2VEFtcXJVaENrS0J2NWd3cVVPSllHVmZY?=
 =?utf-8?B?bmZRRHNZR1Jnc0h4c1NyYnJyOU9NL0NxSFlxMDdlWWtiMVlQWWtFelV1RVBN?=
 =?utf-8?B?elBHbnpDUklWRFhERThDSGo5bXhUVk11SjdtN1E3a0JDMUIydHFrV1Q3dS9H?=
 =?utf-8?B?SUpPYmw0Rk51Qjl6U1RTdHUvWXdLU1dNTHVQVE83Wkp3UWVMNXNwWnpxV1ZU?=
 =?utf-8?B?MUlrTkFLcURjV3o4ZU9SUVdvM3o3QVpWVk50ZWJRL0h3NU1wTEF2a1U5amtB?=
 =?utf-8?B?UThWVnBVVEk5alFJWkMvem1WbFNXV0NyRFJIVXRBc2JpemU0NU0xUGZNaEVC?=
 =?utf-8?B?NUNGaTAwMjd5c2E4bklsV3ZHSWlQZzlmYzRnNDJCZ2FXTUpiU2xxTG5zV2U2?=
 =?utf-8?B?T1MxbnA2NG5oQVJja1Q2eGtQUkd5ZkszdmZVMUNuSzcrbEZ0M3VhdURURi9w?=
 =?utf-8?B?Z3V2L3ErdkV6NkNwa0d6UjZocHJaK2dtOTRUU1RpUmowU2IyMHk2M1Q1T2sy?=
 =?utf-8?B?WUJkek5kbjJzODdReXowbFFlOFBHOTVtU0ExL0dkbjBrUlFlaEZDTW5BK21h?=
 =?utf-8?B?Vkp3RkJGL2NyeXlML0h2SnV6bDM2NjFYcElKVTZpNHlEUjNZWGdLZXg3YnBh?=
 =?utf-8?B?T01IcXFIcWdaTnRYSGVGUmdaNjk0cjcvS1IwT1Q4STlONkFJd3Y5TCs4c21m?=
 =?utf-8?B?UjBadkZIVmZITE1XTUs0OWhXWVdDNHVPSGdibXEzNERIaDM0QmFVclhwK2c4?=
 =?utf-8?B?QUJ4ZG4wTUZRaEtFWE43UmZ0U0laMm1za1FmUE9rREtMTUtQREVxWnNuSm9D?=
 =?utf-8?B?RTJpczgwNyt2bjdvUFQwUzRvalBNY2lxMlIzcmRlbnZpYWo1bSs0WHczS0Ew?=
 =?utf-8?B?Qmo1bWFnWUVXeTI4SnE2UUdPRmVFdW5YKzVDbkg4djhHZlE0ZXpxSE5USEVO?=
 =?utf-8?B?R1hZUkVJTWcyTzI5T3FDeTRtOWxCTzYwZUExN0JIbnVObUxwQ1puUVV2N1Nr?=
 =?utf-8?B?Q292dCtxU2lRZ3RmYlkzOEZHOHpQazRzMjJhQnpvczUrVmgxZHA0anJKVmc4?=
 =?utf-8?B?TndzZ3FBZklNb1FQOUdVb3ZsRDZ1QkUxQmNEMHFhdFNmWTYyK285UkQ1QzRs?=
 =?utf-8?B?YkpjRUVlWjJDQnFGcWZZa2lWQi8vbVZmZk80UExUZ1lpWnljL2c5RzlBSVha?=
 =?utf-8?B?Z0JHdHZPTnNkN1NHSHRkY1k4ZHFXbDdpb2d1YS9oc21tUS90S0FtVlowMlBh?=
 =?utf-8?B?M25MN1NOb0Y2c3k4OWk3VW1Wam1uQ3FTMlplRjFvazdBQnB0bWtTQWFieFc3?=
 =?utf-8?B?bS9iaXZMUThreVNPSkh5ZWgrNHJJYThIRXhmSGoyaFFpZU1qdGx0RjJ2Z0NP?=
 =?utf-8?B?b0VHUDNIYUNRUW9KdHgyTDZlRlBZWEl4STFkYlQ3bHh4RGJrS2VGOGluWDk1?=
 =?utf-8?B?R2ZDbEhWWmNYNS94LzVTS2cxUnlkSUJ3aVJpVWxpc2kvb1hJYk1GN0VISmtD?=
 =?utf-8?B?b0IrNm9QbFMrbFJLVE42SlhVcW8yYlErRDBEa3FRaFlBUUx6TVRnbFVvUEtR?=
 =?utf-8?B?a041R2FxZkFhSjVLdjdJVVNiemJrcGM3Skt0TUxUU3NiMmJ4V3NCNjZCMmlU?=
 =?utf-8?Q?TWfLoPSOIzOafGnn1ZtUphKqq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a549e7-667e-4e4d-30b6-08da8b569741
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 13:42:05.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz+Q+2NQfb+DrAmjuHvXCzBttbupqJIQBib91w6yuakC9WD2g6wZAv4njE1S6tIk+x83T546zu1YWVOmrJCSFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3263
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2022 8:54 PM, Krzysztof Kozlowski wrote:
> On 31/08/2022 13:08, Peng Fan wrote:
>>
>>
>> On 8/31/2022 5:15 PM, Krzysztof Kozlowski wrote:
>>> On 31/08/2022 10:49, Peng Fan (OSS) wrote:
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
>>>>
>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> ---
>>>>    .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>> new file mode 100644
>>>> index 000000000000..90c5e354f86c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>> @@ -0,0 +1,37 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>
>>> One more - drop the quotes both lines above.
>>
>> There will be dtbs_check error. I updated schema with:
>> pip3 install git+https://github.com/devicetree-org/dt-schema.git@main
>>
>> So it is ok the drop the two quotes above? Is there
>> any new update in dt-schema that not landed in repo?
> 
> This is something new to me, can you paste the error?

I have renamed the file to "fsl,imx93-syscon.yaml"

$DT_SCHEMA_FILES=Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml 
make ARCH=arm64 DT_CHECKER_FLAGS=-m dtbs_check

   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
./Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml: error 
checking schema file
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json

Thanks,
Peng.

> 
> Best regards,
> Krzysztof
