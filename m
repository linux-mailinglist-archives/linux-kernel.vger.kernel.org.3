Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2855AA0C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiFYMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFYMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:41:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3720BD0;
        Sat, 25 Jun 2022 05:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAaBU0vgV78rzMl4JssLK4CpKMKISElW1ynqCxUj+ZzCGlEJc6gMTEWaRk2OI36e9iKtOKAszAsGsBYVOdxoX1qnwnpVQrcf4PePuJgHrsHyYgnRYAQ7BWw4UilwHaryNIuOpB6ABoZ8bsz/gIAUC4i2DoCWaAKkZtkoNRmjboiq8gikndQ+aiSM0Fvo4LzxJwh3WYHwJrO+kwdeoomyodQPdeGgCAxgd0zshPKSEv9RkwKWw1zoQMuNqhRbby1/0+Q33aT8Rd1A5b/bVtLKWxC39GetfxrhqdGTfu/Cydt+4J7FUdrk7o5kDNHw8bqxB9iq89usuxxjZRJ2/IaeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfaWWvpSUiwGGL2kJXz2N1bmxEbLoQ716Nwl4LPyvNI=;
 b=dS9ANdKpUT7jsF4Hsn/JPmsVS/ByTPC+EJTyvvwFBK35LKyi7kaa0ldNBcs3vo29V0dThiW4p7JiR2Qqa3EEauS9Di2DiFs+atynOC3iBou5nRzdS3M9cRyOhQYwWK+AKTZ2uhbZ3mFCw79jBhS5X9CqTVAOKztTmOfMAwZ+rEaSZArgvF7CR8R5nXr7ZzfBCiEOlQLn8J/bM2ESSMPFWyZOBQPoJv26LHtY6iuixVTPZkGGVM50tQswvVIfAHeqEu+p/SQSYCdB9jxJWtDGFRUqtzH96JCng5v2GhYWAAyeYqpYuidRowAFkAnaRSVsgYcHTGCvmp8woKDqonfL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfaWWvpSUiwGGL2kJXz2N1bmxEbLoQ716Nwl4LPyvNI=;
 b=VC1VKiBCF700kGCqcpfl7blyvHWT9HlPIXaH+w2eYu+KUWx4xKuf7pRaThKkTo0oIBQrRR4yxi1s3j8J6L0wsCKxtr6WpDtKmhkwSGz04kXfJlXrmZ2t6wE0wBUoxsFxLnVzF1zHQWrkHaAOem+YU1tPQ00Ix1T9WFLfjY7QM7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4201.eurprd04.prod.outlook.com (2603:10a6:5:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Sat, 25 Jun
 2022 12:41:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5373.017; Sat, 25 Jun 2022
 12:41:28 +0000
Message-ID: <ac9b9231-4bbd-bfae-c551-39123914a610@oss.nxp.com>
Date:   Sat, 25 Jun 2022 20:41:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
 <42f2ba58-acd9-a214-83f2-037f669d8d59@prevas.dk>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
In-Reply-To: <42f2ba58-acd9-a214-83f2-037f669d8d59@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad483c7-da83-4889-7efd-08da56a80628
X-MS-TrafficTypeDiagnostic: DB7PR04MB4201:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOU4XEeKmsVSAnpXHKRVR7P6CR9E12GyZTM5CRMgCfXuWYIwMdCLfQJp2yHFlEolDKXaI+TlbHnRr7EkIE4vqIQVENFRYb8a7YPSBbWirHi7XqwgKQzg2eR2nA7jk+0zOi0yJYauAqff1KPVIoc3MyDR8NkdaUvgDQjR8GwmMQKqH/85lv4caz+szjoVotB6gvSqxPK84R3wOXsBw0vgUXQud9QGIiBQ6nBxobMI29HTSYhiHKLFXQpvEUHck7aOW1vxg953AhY3pPZhz8RaB2OgSRdJbdCEC+kM570VHXx0omL2wTSyt/fbzZpNrInx5HkcLX1E0lXmU5wuH7/LNRKyGxW5L5RgPunrcoaiCR6dkx98iOce+EJTd2+uj1emBOvX0xXofbkcZLcGqk7YtAhThk9SDqCnjzBsjLZGgngK8u9erl5/ickGcbJJ5gB4l6TZaLTqwR7zacM7w7iHy7FrSiGWC1Us9THGM9DAPrHXf7NGlGoB+Jh5zw0+rKMmPD+ommfI1JSnTAxiCphUQ3ILwhvXrJB7r52kQOt/2J3B6ydNxS+R3V57YF1xssh7foss+ctmstwHSKak3HluW8r0fY+M9AU8jGotr84oaO3qf2jRH7MH29EJRJW1j98eQqzFQh4N3kbVK9mUq6dUCgVZqGwhqwg/3XaeHlzWIRov92BA3Iwooh/+RasdlJboTQpII2jSiINCPEsQeDr6BeBtt/cZ1LQuGQApR5pzYJK9pV+iBX9+Burq4ck3oFDKO7S23Xo6f0aoENd+KUo5n8pGeUPxRUv7XwpyAjT18QafiRM746T1286AVc5WZv/6u5ODn36+l1XVUO+CnI1xGl8ggQraooZ7MgalTQU25VHxrxhhNROVzmBH/0Je0JMB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(478600001)(26005)(6512007)(6506007)(7416002)(66476007)(2616005)(6486002)(41300700001)(31696002)(5660300002)(8936002)(86362001)(38350700002)(6666004)(31686004)(186003)(52116002)(4326008)(66946007)(2906002)(316002)(38100700002)(66556008)(8676002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZYbnE1YXhrRmhiSlRkcE1ZcVVwS1ZVQnlFTDY1YTlYM2YrUEN1U0RkL3ND?=
 =?utf-8?B?ZXR4dmgxRjd4NjI2NXJwZTdDZk1qZUkwMWlMMzJ2VkRwclV4ejNVakZia0VK?=
 =?utf-8?B?bVJ5RTZwcW5IU2dQNGVmSHRtMWNSYlRXQlVhR1crYThUTUY0MFNmc0hkSkpo?=
 =?utf-8?B?VWpoRGhyMnl1MElTT0pxazJZeDJvS2pIQzI3S1AveWhlK0hTVVZFYjFTQkpn?=
 =?utf-8?B?elRpR05QOTBUMCswUytWVklNOXVZd2R1Rll0UlduaUJEUkVDck80NEZycGQ1?=
 =?utf-8?B?ZGxodXhUWUttVzhvMWx6RUJzSkMvVUVudC9aakdEQ05FY0g0QXFFbkxuNDQ3?=
 =?utf-8?B?UnVJc0tCbjlweVZ3cGh2VXNNdFZSdXkxakpUdkxDOXVpT2RMakYrQlVZeXlV?=
 =?utf-8?B?bVJCbTV3VFlReHA5SlBIR1pOZ0Q4ZUhSU2ZvNWVpcGZrbmxvWGZEelIxdGVy?=
 =?utf-8?B?SjNjY1RtTEE5SFNKOWNMUnlyemNKckJQRFF2N1pRU1NaUjZLSVRWUUpTZDE1?=
 =?utf-8?B?NmVidkRIcGNWYUNBUnNiamdrN0hZRDVBWWh2ZlNPWVlrRmd5aHNCNERYMUc2?=
 =?utf-8?B?QzgvRHkvYkRnakVTR01OMDRkdXVZMGJ0bGF6ais5c3FvZm5HakFKU2h1aGJJ?=
 =?utf-8?B?dGlDY0pldlVTVUc2S0xTM212OFRKUzlnNUNZZWhWQm8vRUM4RU9JNjhJRVBC?=
 =?utf-8?B?RnpHMmpsQ0pnb0daT3ptWVBvSHBQOER2dXptVUtIWlFPWjhKRDhFQVI3QnZX?=
 =?utf-8?B?bnIwRVEyWFdYL3dHQVIxV2JTbFF2YVV6RW5od2FySkpNUi9MTDZrcXpsU2Jl?=
 =?utf-8?B?ZmVpTUQvNEJQWkVKcUR6UEZRTzBIK3RKeDBOcCtZMVRyN2JSdHdBeTJGTmhi?=
 =?utf-8?B?OHZ5akxRVUZ3TW5vOHExL0ZBbHRSdTdobXVBMG1QeGhOM2JhRkZjZHU0T0dL?=
 =?utf-8?B?VHk5QmZkMTdYbmczbGR1WTZkV3VpZ3NTUTZCeFd6WVVQc3l6bUIxNmxCSWVr?=
 =?utf-8?B?NzB0bkRPdk5mU0JuWWNBUzBHZlFhV0ZIYVZrdVRZQlc4N1R6THVoUmlVbjQ1?=
 =?utf-8?B?UjRBcmF1eGlYWGx6WlArQ2oxRXUzU2xNNGthczU4NUpWbFlPY2oxRkgwUG02?=
 =?utf-8?B?YWZNc2FaNHgvTjcwUGVMZnN1S28yc1MyaU94bFFsUExvSk1CK2F6R1F2bm85?=
 =?utf-8?B?OTVVdUxVTGhvWDEwYXBya2xnemdxUVpBSmpIMFE2eHc3ZkxvTThaMWg5SW5B?=
 =?utf-8?B?UjFCVDNJNzhOQ1FsZElqRUMzRnFYM2F6NGxtd0s1RG5pUm1laUcxSmVzRHpZ?=
 =?utf-8?B?SWZPS1hhaHh3SWxDVGI0bEtPbllWTEpkYmw4ZzdGSzlnNlduaUp4MCtDQm5S?=
 =?utf-8?B?R01BcW1XQndWNUc5TVVTL1Q4Nm8rQlMreWswL2FYd3Jwenl4RVlkYjFScS9G?=
 =?utf-8?B?QitkcGt6VytEaHRQQzk4QzZlTTg0ckpJamxlMWFoVU1ybkQ2RUdZbEtyZGxl?=
 =?utf-8?B?YTMwVDNRUkRMemVPKzZxWGJLWkxqbnRnTXlab09IbDFkdVRRWHlYaTQvU1g3?=
 =?utf-8?B?V0hvVnNpak1VQXprZVNaNFlkcFRkVW9RaEUzQkhxRVc5UTlhNmpCbmN3T1FP?=
 =?utf-8?B?eFRuQ2EwbUl3TGN4UlhHVmx4WTVuZGxzVVdxeEI1aytkNjI1SURNeHJadWlO?=
 =?utf-8?B?djFpa0l1TG9kQ24wMzdhT2FpejdGTFVDbzBkQkZDN3hITTBLajdmNERHRTN2?=
 =?utf-8?B?LzNRMSszQjJTSTJFbko1SWJGNXNQQ2dYRS9FaGxhZmNTRzMvMXhxVzJnYmpT?=
 =?utf-8?B?bm4yYWt0dWIwK2VkakFlYlltTDE3a2xPSXRGb3dzdDk5RWplbjROb2lodGNC?=
 =?utf-8?B?Q01FUHVTU0xzcXNMVzRSQVQ5Q0NKenJiM3UxcmNsOTRWRE00RzgzMFROVDcw?=
 =?utf-8?B?YUJ2dzM3M3o4U0N5K3BTTWtXRTJyT0VhUEQ1TlJWZlUrK08zUnpEWnR6am1u?=
 =?utf-8?B?ZVdsS3dDR2VNR3A2ckJUbnJjeVZiYlFTWDRKS1lGYUl6d0FrOHNWUEgyeVpy?=
 =?utf-8?B?T25uQ3Bha3hTUUFTVnYvUnB3UTVqRjFrVlBOcDR3Z2J0NXZ1VlhrZEdLMGpC?=
 =?utf-8?Q?3/mgEMzilbxeLCOGHAht7EPTR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad483c7-da83-4889-7efd-08da56a80628
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2022 12:41:28.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1kUvZfA+kf49+x5p4094JZTarW8Qm+WeAF32fp2ZdnK6N4cU/4JQwnxZlqbslurIh/HBwKoUHXr8nmWMjfWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/22 14:31, Rasmus Villemoes 写道:
> On 22/06/2022 08.13, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> i.MX8MP iomux pad BIT3 and BIT0 are reserved bits. Writing 1 to the
>> reserved bit will be ignored and reading will still return 0. Although
>> function not broken with reserved bits set, we should not set reserved
>> bits.
> Thank you, these have really been bugging my while trying to bring up an
> imx8mp-based board and adding the right pinmux settings - not knowing
> whether there was some undocumented effect from including one of those
> bits has led me astray more than once.
>
> One question: E.g. in patch 11, you change the setting from 0x49 to
> 0x40, which is of course exactly what the patch description says. But
> when bit 8 (PE) is not set, is there any effect from either setting of
> bit 6 (PUE)? Not that I suggest changing to 0x00, but I'm just curious.

Set PE/PUE, it depends on board design or whether need it. Because the 
previous settings not set them, I not set them also, just
not touch the reserved bits.

THanks,
Peng.

>
> For the series:
>
> Reviewed-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

