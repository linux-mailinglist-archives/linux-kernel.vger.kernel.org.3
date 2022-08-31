Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899EC5A7F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiHaN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:59:37 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50054.outbound.protection.outlook.com [40.107.5.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB0D5E8B;
        Wed, 31 Aug 2022 06:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvYukudJnYwwJuydeepo3nEs8ZHGf/j0b9cn7/WzAFIgJuBrzkXAE+b0cKdWyVJ+PviQqTb2Ot9UiM4n144kDlNQ3RMiQ1ndVUdDjwl4ZXEiSWHViGwx2Eo3AJFAOqXjVVQejU0kMEe1FklmpD2lR2uCSB5Llpx+PMie2EB3r9H9Q0KbuLpDCaugm7icaDZdft+2zVon5XCyzW2ZTVNjHchxa3dnOqAP3ycL/GZFMwyd65dU7JO+FbBV5KdDiGmvVaEdQkxjZ6nLv8Ue4AwKtHJl5wv+J1pAhhyXMxPi9uTBiaQUwPRKCUGttNjF9Uez8i7RMlfrzpAq6Co5OWVOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQzyUmR2FVd83+eV6xFMecDHxvTu2l1J9CQpEvlIjdE=;
 b=HydCF13IDr9CpNZh/EqP+inTZUQ0LrWHeDJOtVQ9Sq0qqvN7vKyWm5OsEw9QQ/xsQr7hJn5fHNeju0DQ4aHR6/E00T3HicBH67UGnM7gPrEnwx7IQAeQ1l8YNxb2E2EEvBOcv+XfbZBVl56w4nxZMBCAdO1B4ZM64XNwgk1JRVtrLlZ8ou6zDh9pxDwa8dNUtx/StxtLLQozPOWF/mRPwtEQzRUFAW3GdfHqorgzBoXU+l8WtwESwn/uVw0zmQXeaHhQ1Og86tdO/GIkJzyxjv7d45PBjV5WUYzaSeL8YWdL9XguD2YACZj+XGlcEt2CN5R1vWtV41mZo4GECb5WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQzyUmR2FVd83+eV6xFMecDHxvTu2l1J9CQpEvlIjdE=;
 b=Fueit1dNuyXyBPCTRZn07QyeYyhhtIv8JLScVRtboJCrGwFTgZnQ/vczMOF5wRoEFqpvbbPq9F4chqrY3JvfxtE2elG2/nYcaD1SawGXx/2/Z64DQk1PCEAGLiMYC/B5iC5iLyxb5OjepIApIMxuI9H8sT1PAXpEx5cHcYPZi3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9465.eurprd04.prod.outlook.com (2603:10a6:10:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 13:59:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 13:59:33 +0000
Message-ID: <4c060e3d-5a2c-2073-099d-1dcd649e469e@oss.nxp.com>
Date:   Wed, 31 Aug 2022 21:59:20 +0800
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
 <0cacdfc0-b62d-ddd4-825e-3118071fe365@oss.nxp.com>
 <8d1328bb-9484-9c32-b059-bdebfc18663d@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <8d1328bb-9484-9c32-b059-bdebfc18663d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b9ed861-839a-4308-1168-08da8b5907f3
X-MS-TrafficTypeDiagnostic: DU0PR04MB9465:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVWpAP5CPoibd0P1Q02HPJ+VjFWsfOcE249/QP2Zwx4glPw+ppC2ImDdcg1lNrPf//0VAw+tgF2KzILO9jYi3oWAOCYF4nMe9TvPxjDcrBJRKYEkxo/Hngps0Pqf3O5LDgzcVYStrtw4XpjQRm8pBg6VVh0Jy8zKut0vX8DayuvGe/VbTPq0HOYnuBQwx0ptoW3f01ocucDIcWQ7pntdel1bNxPy/D/kblQK0W2vXNDD68miebpCZRPs+fKmOJDW9DpTerNna7hQ13Y+0LMSrrJ93CxzXWgNpUbPQUMJBT4N1n5rOmmAwBcTGY3DLsr1zXD4W6OmvVFRF/Rik9W8wU7Lx3wBjzkdpoAc6AHABGyQlj82kfAUjyzco5MVupfMrd7Y50obJEGuR2XgSlATvShf0FSvodm9nYIG5hcSTxihlfpToLa0vaopXKoICrmULxSXnUza3qfSs9/4gGbsDtRYA6te63HiD31snNAa6gFhKL7uBdcVqSTfycQ/8DzJMN8o6tEaOM1Reki7EQTlcGB0gCeI4wv8XBJtS2pXz152NJLbJWD+1qPQcQelKHzd9z2qLj8udrrbZpaVTq3ExUHI2L52rxffbEPRN92HJ2dV7UT95qZrNDSv14EwWVIwhSrao2JXIlH65BIGmL4jb9mk8P86Q6VpqIwtTEr7PnDP6jegz1PGib6jQ5l7aRdQKfdPvbABrvrbPz9MGXWHT0w7w6jovM5nT7/dop4Lq6AioGScvUPcnDy5bklgj1798LxNv8zMwg5d1z4woPmC6sFXVnAk13lli+J6+Hd5+ztYfaIPuiNcVO+dXyOAdzM0xv3D/JvelcPzIbjCIYrJgVhVZuGjzDJDFQQzsFdLZebTRsOjgWSNcfLCpJfoFqoUQ0h/ciSqjmFOZfNBvHsVBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(186003)(316002)(2616005)(31686004)(44832011)(26005)(6506007)(6666004)(83380400001)(53546011)(6512007)(2906002)(52116002)(86362001)(38100700002)(38350700002)(6486002)(66476007)(5660300002)(41300700001)(8936002)(478600001)(7416002)(8676002)(31696002)(4326008)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek83R1NBKy9wM0VZaFYyNGxrRW9DTC8ranQ0YS9Yb2JxMFhmcWhjWWR4NVd0?=
 =?utf-8?B?aXJKcnZLZTdHYjdVVU8zSE1DVXYzeE1GZkRjSkFVTThwUEdESDhjMk50OHF2?=
 =?utf-8?B?cGtUUENTcy9XZGtrSE1hWFNFMkR6NXR1MDlQS3JaZ3p3R2NDSGovTVlWNFR5?=
 =?utf-8?B?TzNtTVRYM3VxeWtwTWpYdmhRQThhZUNTb3dOeHZHbVlKZmZobWZvUzAveS9l?=
 =?utf-8?B?Ujl4Q1BDa2RrR0cydjRyVHJnandRWU1YK3cvNURuTDRhRHo1WVVVd09CRE1U?=
 =?utf-8?B?YmdPNFl4Nmg3dlZJdnZiZUtIck9EeVRBbmVkZkN1ZHJyWkozb004Q3VWeERF?=
 =?utf-8?B?YVFGN3hFK3Fzc2pLcHNwN1lSVFYyOW9lR2ZzZjRCMnRiSnoveS9UOUp1Umsr?=
 =?utf-8?B?NFJjTk9NdTZ2a3B2K2FlVmRWSG4wdGtTbEE5UEZ0QzEwMi9JeSt1aVpKc3J2?=
 =?utf-8?B?cVV6SHhIVGtCWktoeEpHSlVzS3J3eS9HQmROK1ZkQzcxOXJpSVBkL285amlo?=
 =?utf-8?B?QkppdzNKZFkvRDFYSUhZNDlSNkRxTWFXZSt3TVJDNzZvRWNDcDdwT1pRMUNB?=
 =?utf-8?B?S2J6cmhIR2lCcmZJeGlCMlRadnpjRml3TENLVWxEU2NvUEs1S3YxaGpGNjRE?=
 =?utf-8?B?SVZjTXVidVRIM0hmeUNiM05MN0xzdm04WmdOMno4T0J2ODFDSGhVc3l1VEFX?=
 =?utf-8?B?ajRCK3ArYjFnYThwa1p1OHYwUFRCcngyNk1NQW1COC9lVjZwb0w0bG5PUzVS?=
 =?utf-8?B?dGl2cWpFcDhFaTVLbzk0dVQzUitWSm1SY2J1QkNrV2FsUGJ5MWIxbEYzY2pl?=
 =?utf-8?B?TDhIQm0zOUZKSXRtaVlUSTl1STlVMHBuemtXZUVBdWFCcHJSc2dKWnloaWJW?=
 =?utf-8?B?MmRTLzFPWjRteW1FRkNiWHA5L3pQNUI3a0ZUOWpRYTVmckRTNU45SVRvSzNO?=
 =?utf-8?B?VzNRV29ndWJQSVRPbk9mY2NOcElGUlBHTGlod3plRkVBS0ZPaTUrSHFKQmFl?=
 =?utf-8?B?S1B6QTYwNzk5NExPaDB3UXVpekFIcHFqWkhlWFp6a211bWNMeCsrbGVtVStB?=
 =?utf-8?B?c3ZKakFMOG1kK0ZlTEQxQjVmY3Z5amNrVDZSbFJIREZZNmZrN2wrd3d2QUk1?=
 =?utf-8?B?aVBCVFNnSURLR0crMGpnOVVqd1JkZ2hGeVBORVVuUkVvS3g0UFAvc2Q4ckpJ?=
 =?utf-8?B?emlkTkdkMXFIbWtaOHRWR3d4eDBtSHBnVDZCYVB4emlHZGJFWW1MQ25SWXAy?=
 =?utf-8?B?RkovcTE3Mk4xd3p0aGdwbmc5ZXJNWWJWWHhlNFRWNFpSRkdCR2JKbU96bGs5?=
 =?utf-8?B?T1Q4ZDZZMm1iZWVML2JEM3d2NENhMzc5bXBWcDZvWDkxckxHUndhb2JjZkVk?=
 =?utf-8?B?OHRqSisrTnFLdjR1enZsenYwMm96blZ0Y2NwaHBjQ05SYWtkd0dZdDdmYUg1?=
 =?utf-8?B?SzBydkY2M2hmaUNpVmlmckVhelVwZUVMRllsVThmbG02SnRDOXNBbzRoaytO?=
 =?utf-8?B?MWFmSTdRYWZrZ25vRVlBMjIwRVJkbkZNMTFnR1gwSlJnRUw5cHRScENXMWJY?=
 =?utf-8?B?WUhJZGJNZDFFTlorcmcwb3k2Vm0vQUhJVXJ2dzVlQXhVVHIxcTVrZmRoTDJv?=
 =?utf-8?B?alp2YkwvRFQ5M3liaFNnNlFnS01VTlJyKzJLWWNodHVDUlFTZUhLekZHdEJQ?=
 =?utf-8?B?cmI5ZkR5NUdIb0lpRklwbk9XdG1JSTd3ZzBHQ0xNNXBzeWhXN3NHNHNXQlJ4?=
 =?utf-8?B?ODVYSWNBS2lKd3EvT0wyaC9WL2t1Z3l6R01wd0VRakdUQlpSWmIzV1pZTWZG?=
 =?utf-8?B?M3R6S3NNQlBNWk4xVzNMTjNqUHpqcEFNTzdrZ2h4Y3J1SHlnV0J3bGJxS3RD?=
 =?utf-8?B?MXlWRzU2eFdXa0l2cWdxR0dVdDlnR2hST3dPeFB6NlY0QmlBaEJiYlczd3Uw?=
 =?utf-8?B?c0daUm1BL2hHNEl1bEJkSXh6K3hOMTJteFdpdXdJem5CcTdFYXdoUUp3M2Vh?=
 =?utf-8?B?YzhwQ0lkV0gxNkJFaWJjN2UwVGE2UERFU2ZaVkdhMnI5R0g0SjhINGdFYjhq?=
 =?utf-8?B?V0MxMGVEaWk2b2Vzb3REa1dOU09qRWpoeFVERWRIM2RPaitLa0I5d2EvQmhn?=
 =?utf-8?Q?6QDHEa4T/yW4nnfgJVfPGeSYD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9ed861-839a-4308-1168-08da8b5907f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 13:59:33.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lN/DUrx6FrKAGYE0e+lmJekxCHAY18+d8z2DdxI0bFKhqcwOya+l0/tu1ga8vPiMLRjWKU//wWd1ekiUZaCxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9465
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2022 9:45 PM, Krzysztof Kozlowski wrote:
> On 31/08/2022 16:41, Peng Fan wrote:
>>
>>
>> On 8/31/2022 8:54 PM, Krzysztof Kozlowski wrote:
>>> On 31/08/2022 13:08, Peng Fan wrote:
>>>>
>>>>
>>>> On 8/31/2022 5:15 PM, Krzysztof Kozlowski wrote:
>>>>> On 31/08/2022 10:49, Peng Fan (OSS) wrote:
>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>
>>>>>> Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
>>>>>>
>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>> ---
>>>>>>     .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
>>>>>>     1 file changed, 37 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..90c5e354f86c
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>>> @@ -0,0 +1,37 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
>>>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>>>
>>>>> One more - drop the quotes both lines above.
>>>>
>>>> There will be dtbs_check error. I updated schema with:
>>>> pip3 install git+https://github.com/devicetree-org/dt-schema.git@main
>>>>
>>>> So it is ok the drop the two quotes above? Is there
>>>> any new update in dt-schema that not landed in repo?
>>>
>>> This is something new to me, can you paste the error?
>>
>> I have renamed the file to "fsl,imx93-syscon.yaml"
>>
>> $DT_SCHEMA_FILES=Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml
>> make ARCH=arm64 DT_CHECKER_FLAGS=-m dtbs_check
>>
>>     LINT    Documentation/devicetree/bindings
>>     CHKDT   Documentation/devicetree/bindings/processed-schema.json
>> ./Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml: error
>> checking schema file
>>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> 
> Hm, not much of an actual message. Most - or almost all - bindings do
> not have quotes, you know...
> 
> This is something with your setup because above error is not reproducible.

I got something wrong in my side, my bad. It passes check now.

Thanks,
Peng.

> 
> Best regards,
> Krzysztof
