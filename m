Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF150BACF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449049AbiDVO5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449023AbiDVO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:57:33 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10088.outbound.protection.outlook.com [40.107.1.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B35C663;
        Fri, 22 Apr 2022 07:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqOaI6+S18VYi8M0I5s8gLpaHPiyZK3u2p5GtuAxi/M8n79E2poQBI4JCDEMa/ugrkNdTVJRl8LAkqXMlmxOj6Tk8s0gbDTO8MrhOVTSHzfTiUQbVQw1qdeguZSbW12lS+u8BAdczjqsuJmW674TO9X+CWf3yylbHmxw5WxxzwH8SWWhwDImhJb0JWY51hZmeyQd/Dr3DfZi2NZv/K0j2ge0eHuj4pZiwFhsdi5PH9Xj/fHuPWAdtOBfc1WjDwmMCMzichMCYuFBK5Y2wAQsBu3U2KgiIlAJV8+iWe8EH92uIoVE65twz4jTuf+GWDnHYAxpZ1Ompi151JSjqaGL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/Tj791zH32q26vxCWN/fRNY39uW8ZergoHZPJHI5tU=;
 b=FRs4Xeca3L3qRttZmkS4rNHSYZa5FdOjAUhpb2HJUGCqYII1SHDQFDDmQ0OVrgnKl13AqdT+gzqb3vAhR495Xh1Xvl6Rov7KYxsC3WsDP0ytpgjYc8ASZKWfQzcP6jwVxedTxtQ1ostCzrGExWUZyck82/yFz7m0cKroYJ2klUYJD3fuZHahoa9gPOtHRWUnaQ93egj5XCLSOJ5KLjzTzrjqnDGhdCtz4yoMruWy8kLwH2rVUasIhcLr9tn8J8F0bDv9c0HWlsMbcFvbN7DwEVD1fIUGZBd1L79halsMPjZJ5yK2AjwPGc9Kh0X7tszB0XoBFZzVL8bWGwj0cEZbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Tj791zH32q26vxCWN/fRNY39uW8ZergoHZPJHI5tU=;
 b=PTylPiYwPYCzfWyIBxZ0sM3NrPVFVeX0Mz7xW248+VOsIeOPAXYBt0grQBqJ6r4OeqzYUlf+zPo/Si6AK3h1UKSgDiGgqU9ohM4enHRUKKkyBsagWyTHJbeD4bZQEEBTb4uUZzxgvUsf6M7NznO5P6bJhMdkUuhYWLzf1OWYfXng7AqWZqkqUPX2m9tw5A7wAq+L5tjcnADmf5jxSQvSPQ0wMOoG+iYk/ahsMUTkEoKAp42gtnb1sT2XYKpCbln9fFSjqVY8JXz0nJyyBMpe836L/SNxwU1nSgiRHFKNZyeOmoHgIoAjPdxkUaQBGtw3qjnbbiYrs3OY/VIQrNz/vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by HE1PR0302MB2652.eurprd03.prod.outlook.com (2603:10a6:3:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:54:34 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:54:34 +0000
Subject: Re: [PATCH v2 0/9] nvmem: sfp: binding updates and additions
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <9ec1e889-178f-9b99-c73a-9f31c6c99563@seco.com>
Date:   Fri, 22 Apr 2022 10:54:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4e1f5b-ce4c-480b-fbed-08da247003ab
X-MS-TrafficTypeDiagnostic: HE1PR0302MB2652:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0302MB26527676B81EBB319430214A96F79@HE1PR0302MB2652.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHlkl6i/1tovWm3mfy3YMh0iNS4znx1c56FeWTbaJbhFUCAhB/QVFS4H/0CAn/tUTW9m6dRBcPq9WNZB/Mx/JYXaqgPdYq9Vq+HQCfrEiUdFQnnLSYI1834Brk3JpqR66T3CbPpeySGeOzfExUG1x4A4g7L6YjKnEJLrdfMhzd/9o5G0h14L3+w4dMZOoUgHKnKFEyaHxFcmktoC5VDZ5VdE19MEcfOBcnU2SK6OBHpvGrX4uvsYAkvck3CktVjD931OJjnF+AIKTz//aq4JajfyoL5/BxdRkgfPxXRp36K1kAtUXNXN+t1s4ClRKqQanrUP1eGV0msvWDG5iyUmDWmKWy1fSjys4jhyWB6tj7MloUu9mBOYzmg+kYHkKinXz0zliS6m8gLqpQLb05KCetpPRyN9Dxjmad56rsIipvV/q7JSub1NWdQ9QBvR94KNy2y6bzKstBScU+ZvQ1PVDJGjck47p4ENg7HJ0xoiYdTgFBIuS+IfwSO5ZMF49vTcziJ82HdVt8Ksyz9PJ9pgBjPxAvCJ80aQH9lwmzMh8xmTpIRJOu2I8PD1ADvty1lZPol3lvejRNz8//rE2qUn3aF8B4qlJJzAvKKaT6aTHaFqjKDhIe+ZOTxSASrpWrGbNIvEGjYaLl89F7JaJdkluOtP42Dfn/XU5yVP1ohfXBISU+Sk0oMvA8yhiIdQEioOi1xmEx8zSJMY8WOAl2ygNmeGv2xpoaNoq3WUsXtbxhZibio/Zf5WsLCe7OUDo0VLP/22tjQ/uM4k+gvba9MHbNj4ONSkwOTqFBxdVjsHLNPrrMI5kAnq3ZbiGkUL44RwxUBh0W1IpEGCaPV6bCPolxDli2/us/m0LZJ/Rg95uLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(36756003)(38350700002)(38100700002)(316002)(86362001)(4326008)(6486002)(508600001)(6666004)(8676002)(52116002)(7416002)(966005)(31686004)(8936002)(15650500001)(66946007)(66476007)(66556008)(5660300002)(6512007)(186003)(31696002)(6506007)(54906003)(53546011)(26005)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9KclA3VEtaRVdQUldvYi95S1A2bUFZU2NZdVVQcE9lanNHSHZBTDZybHpk?=
 =?utf-8?B?NXZFZGVYMm9wS0FYcCtiWW1wQ05FZ0dMRmVQUVZxcEZWenZyZXI0cHl0STBC?=
 =?utf-8?B?OWdxUm1Wc0NHSnVwVVYyU2phVFNFaUpJNk01YUYwU05TcDdnNWp6R2Q2SzNG?=
 =?utf-8?B?S2NCU0FoNk9nbk5JM05BR3ZvSDFGbC91ZDNTa1pBTnhNZEhTeGV4U0ZaeFQx?=
 =?utf-8?B?bnlNbEpWZitKTnBCOElRdWt3ZEg4TWF3aGVidjVKSWdkN3dMbWJ0aXhaVVlR?=
 =?utf-8?B?VEZuYjlkSkhBcUhOWksrSmYyeFM2VHdpUGhGQTN3K2JOMVY3MHVyUFp0RFZj?=
 =?utf-8?B?UlN4YUcxY1hCZXlFd3VSay9rR0Q3RnR2R0QzcXJlNVNIT09YNUpGVlVST1VK?=
 =?utf-8?B?U2FqMVprWWxMR3ViM09UclROOEhFQ2NMRi9IeFRNQjhaUkdyb0psekhQVlR4?=
 =?utf-8?B?dHhRYWJyaW51dklid2lJTUtIZm93M201K0pFb25UVzJMNnl5a25jSHpicjlm?=
 =?utf-8?B?MXpGVE9EUm1ZS3NaWXZ3MGsrYi8wMHZxOEVqbGxYbEVUMGtUSm5pc2JLZ0lD?=
 =?utf-8?B?TVE2NGd0eG9YdFk1Z2NjVGpGWmppdTEzTzJYTkhQcHZWc205WUo3K2VmYitU?=
 =?utf-8?B?bEVXc0hoY1dGa2xYb21nVFFGS1hjQVBxSGZBREIrWXRqdnArbGtVOEVHd1A0?=
 =?utf-8?B?WEdUeXpVZlRJRnBBSTc1ZnhoV0IzdFY3NGcrdXh1R2MxS0tHNkNidm5oRFQ0?=
 =?utf-8?B?ZEd5NEZoRVZCMEU5cURDMTNySXFUWUNjQzFkSHBGWFFhcDZwZmZVUlB3amlR?=
 =?utf-8?B?TURGemxtenV5VEViTHFnakovQTNJZlZVSTBjTldYdGYvOFRxQVQwVUxGbENQ?=
 =?utf-8?B?ZjNPUjFsZEJpU2VwTTRwNys3V2UwMFNzMitNV3lXblZrZC8zaWZvVTFtS3l2?=
 =?utf-8?B?L0RoR0J1VmdYRzZKM01nSC9TczhFSEx1RHFtcjZOK201NkZ4ZytwRTY3SkR0?=
 =?utf-8?B?ZWZQek5pZkFWMVg1ejBaLytrZ01xZElNMkZMWGpuTFlydGpzZnUxL3VGQy95?=
 =?utf-8?B?aU9zMDRNSFJvN2hlMVdJS1hTWGl5VzBvUFRpRjdqanh4SzNJTzhVYitFOWt4?=
 =?utf-8?B?emVxb0hlVVdUQzFrbFRTMGlCeHlHTkpTZUxjR3hwb3oxK1JqYnZLVW5uNDYy?=
 =?utf-8?B?UzRkZmNaWXdycVNEQWtzdzhDb01Eb1pGVFNlYml3cmF3WEEzRlY3YXpENGRE?=
 =?utf-8?B?OW13Vmo4NHVPTkJzdWhjSDhBcUhLemV0OEZZakNlNXpxSzc5UFBjc2ZFOEJr?=
 =?utf-8?B?M2FobW5JTGdEOGk3QTFSS3FuT0RPZlRjbXFhV2ZrNjlOV24wL2J1eTJxSjRK?=
 =?utf-8?B?aWk1eTdpYmFzakM3YTNwQ1N4ZGtBb3lIUUhla1owWlFwWmFLUUJBdVRJdlEy?=
 =?utf-8?B?ZUtFZjgyOE9YTzA4UTZJZ21xeHVlaTJUUDJYYy9iS1VuVkM5YVljWTVldVdk?=
 =?utf-8?B?dnIrR2lMMUhIOGNkbFo3VFJKT01HV2wxZ0daUjAzWkpQdk5scC9LekVLQ2RK?=
 =?utf-8?B?TmZyeS9zUnloUmpMSjNnd2NWeElod2RwblVHbUd6MGw0OGxoOWVKRzJMUXNE?=
 =?utf-8?B?VnJTTzVEZXF2Si9xY2Q0VnFOcFUvUDFYR0RjakdwUWdMVnMwSDRGTzJJcE9B?=
 =?utf-8?B?VER1S0xGSlo2L1BRbTlPOUxHTzEwa3QyL1BQbjRkSXFvb0VIU3RvR0paWlFY?=
 =?utf-8?B?LzhXK2dlOHA2Vy9LR0ZEaVMvdXorVk55REVkbjRmYmlkVzBkUTh1dEdPYkVR?=
 =?utf-8?B?ODNwNW50emljOGYzamxZOGZyZlFoWThrdUFESnNDNlVMTXhxODFUSkFrQjZj?=
 =?utf-8?B?NlNZZktSNXFSOEhMREQxRFBDZmE4aVloYXh3cXVTbktKcGFWSnZpaVJLcFhG?=
 =?utf-8?B?Z2tjT1JBMGdmUlNZeDFnVllLZWRKUDVKTkhyR0dsZm96bmhmMEw2clQxWXZP?=
 =?utf-8?B?bzJya2M1QTloTlpJemdrS01udUk3Z0ZWbmRQOXhMaTREODQzTjFIeGVwQzUx?=
 =?utf-8?B?WU5iS3ZyQUVHOVdNeENuaFd5NVhJUkdRTkRWelArM3lSYVQwOTlRbElCMnBG?=
 =?utf-8?B?MkFtY2tFT3oxUjFoYjdDd1BkY3BSR1VEdDZxT3ZBUXlxb0F1V3dsMFhtRUg4?=
 =?utf-8?B?ZnFIUVQzcUdoVkpmNzZOMG5wcjZTREhoSnp0QjhPZnBzTncveW9xeU4wUS9k?=
 =?utf-8?B?NDI1QzM3QitNMkExNVNEK1M5Q3pHUVlId1ZoR0Z1ZHFOR2R6c1dQVm9sNVR4?=
 =?utf-8?B?U2M1ZFozUWtQa0xRZllBYUlsSy9RZ0VLOFlTTk1nRkhKVVFPcnR2VjlFU3JN?=
 =?utf-8?Q?kr2VaUL5clqw64PM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4e1f5b-ce4c-480b-fbed-08da247003ab
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:54:34.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/u9KD8BLuCxl1QeuyN6/OiDx1hRlwtXdc+usRICZAJY6Db94a1ijolO/WFCDXEc5jBCtAV8MDxJ3ooZJyTxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2652
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 10:51 AM, Sean Anderson wrote:
> This adds several properties to the Layerscape Security Fuse Processor
> (SFP) necessary for writing. Although the Linux driver does not use
> these bindings, I plan to use them in U-Boot [1]. It also adds a new
> compatibles for Trust Architecture (TA) 2.1 devices. In addition, it
> also adds an SFP binding for all TA 2.1 and 3.0 devices.
> 
> [1] https://lore.kernel.org/u-boot/7c8e206a-cd40-2a77-6282-7f4bead2b13a@seco.com/T/#m591f8425b6f096ab3d54e6f7bd258e41cfa4c43b
> 
> Changes in v2:
> - Mention "regulator" in the description for ta-prog-sfp-supply
> - Convert sfp driver to use regmap
> - Fix various typos in commit messages
> 
> Sean Anderson (9):
>   dt-bindings: nvmem: sfp: Fix typo
>   dt-bindings: nvmem: sfp: Add clock properties
>   dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
>   dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
>   arm64: dts: ls1028a: Update SFP binding to include clock
>   ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
>   ARM: dts: Add SFP binding for TA 3.0 devices
>   nvmem: sfp: Use regmap
>   nvmem: sfp: Add support for TA 2.1 devices
> 
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 30 ++++++++++++++--
>  arch/arm/boot/dts/ls1021a.dtsi                |  7 ++++
>  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  8 +++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  5 ++-
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  8 +++++
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  8 +++++
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  8 +++++
>  .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  8 +++++
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  8 +++++
>  drivers/nvmem/Kconfig                         |  1 +
>  drivers/nvmem/layerscape-sfp.c                | 36 ++++++++++++++-----
>  11 files changed, 115 insertions(+), 12 deletions(-)
> 

I forgot to pick up Reviewed-bys from v1. I can resend this or add them for v3.

--Sean
