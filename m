Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900EC53E956
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiFFJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiFFJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:41:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2019F1D1047;
        Mon,  6 Jun 2022 02:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLW7GxX3o/rq3n4G2vkEglnw6i81OxqJ6vK8s0XXy6kP62pYMmu6FXkywU6qqcDKf9IYNiCrMqRZDyocPq9EN6tq+tYlMoBWOL9UN9hFn/Xa69IOABBUU3J6MOD4vukUztxqJPcyRHLtaBAN0D0LinBjHTHiJ0LJVlURHV4jYLWkWvXfjUgqgxwAUNcWILGTEcCF7V3X6+vZV22ewkNM9Ml6fmWeYU+pYkx4f7haffRtuhzDCFEBfVFYwu8Ax3cuQAPlHofNhemHo/9j0HRKIc8JZJJJ0lOTZ4OoGRrrfE+1xm1WTNu3oLIrR5xbXK3WB84PTpKdWaTU8iuu3uMc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBtQo6EHJt9ENKLvWbGeZglXyg7yqLrgXMuCM9LVulU=;
 b=J+2Hiy2DAfxlvjTTbmcUJV4d6pt/BqfXHI/XAeWcsGjFc63Ob/jsBw4qs9t1gAeZ41j1bDgAVLCZm5j6RE6BQpNI4f8ZHAH/AS/3Qsy5C4zpAN1d3p9LzWYeFGKdWJPV/5+iapt5hJHPwCDqF8wFYZsCgSYw1FXVlUAKhJi8ZY2jss/YSHc9v6dd3pgLX1t4YEmGo+VjM2pYLDBC3UiWNYhmxOE9tMPllzZcHMtJ1cWm6r6YDxCqgQ87cKbVbmd4VJTpRXHEw34SHJ+sU5VbrAPTlqaDPyttaAv5r0Siq10VZqxESRaDArRCZBZ2ti1hIla6ANB6M4TUQq/CNGpejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBtQo6EHJt9ENKLvWbGeZglXyg7yqLrgXMuCM9LVulU=;
 b=brfxAcIFhhj+ILa+awPRCowj7OqZLU5Zwh8/PS09lPREn/JpFVQDW5kEdHAlXCf6i7Taz82duab/em3JR1gYz+IHGf1SyiHEPxVMmXk2dtn9Dy1SEUOJo2qwe3ZWpd6zfOYtd12KPD/9TLG0DW2hyITfG6sMhes2q2hDdT7KgH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PR3PR04MB7465.eurprd04.prod.outlook.com (2603:10a6:102:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:41:27 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f%8]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:41:27 +0000
Message-ID: <9b2acc8d-9755-9853-1dcb-cc9971a6ee1a@oss.nxp.com>
Date:   Mon, 6 Jun 2022 12:41:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220530074756.14585-1-ming.qian@nxp.com>
 <69817804-a618-32ba-06ca-3ec38ff1f124@oss.nxp.com>
 <AM6PR04MB63411F7904814E87116A5BEAE7A29@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <AM6PR04MB63411F7904814E87116A5BEAE7A29@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f92cbb-76e5-4d9e-0070-08da47a0ba05
X-MS-TrafficTypeDiagnostic: PR3PR04MB7465:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB74656DFBEEC0435142926F6DCEA29@PR3PR04MB7465.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXtgXwEgeQh9XWnQ/ymZnEguSI/87beqT6VdXY1vqJzJlb4VEi2W4tmbokD6kVxO8BMB9CuTtXj1ujj7Q14k1RYpM0LY1qi9ZjX37Rg6jg3qk5ILqy+2b/qm6fMinEoFuhnPIP+UsILwmtuo8tMUxENM85EYIbPaG9LcfqaT96AGx5AW3fYAA674c6LwdKFSSm6YbHoMODvoLqzLPFwqA7bdy8eK2E7vR8t7XmjfeEDbAdtNCO4zRLV87rvXcxIlIpysMxxXhY2Iax4jkI4KjFQScoqe74cbUg0arBJwYU/vaIK8vGTg0yuCpxUJMVArqHwLuruz7qQR5gs4Z/QngB/PpMXvRBKM3DEBmYdfYyg8i08btdoWz64uqI+Van3E5aJZxvg30FpLoVns5jSousVTCX/lHwwCosgHXF2NKC688eUTnyZfQdsTW+gDV5fQm8uq9uwxtP0VGfitjenzDSBWknkVqlcSqSndpqVj0Xxvsk/FchM4qXBFt5b5E/lM/bS9Klhrrz6GYFCtoKIan1jLRGUBo6IAHWdKKEyVrVyGkS770KRb9QSaHxz4l/KYt9gD/LSaGpAoZbY9FuoGlwJ/bTNVec6Dt43V6dirhVEaaN2S/elaHdV17CK5fsbMmfyALtyu1wKVywsTMCz6IXbPKjg6LeC1+xPFjf7ZFd9LOfkYwHFfgpDiQ9eo3/h3onQ8/vpK0P2ZF1+zjnHqzAIBbOTDrJgXdMkTmkOeXMcdsn72/5NKawxLo3WKZKAPbAwqe4vDe7cKKt3Ke+X2ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38350700002)(38100700002)(4326008)(8676002)(5660300002)(31686004)(8936002)(7416002)(66476007)(66556008)(66946007)(6506007)(6486002)(6666004)(54906003)(110136005)(26005)(316002)(52116002)(53546011)(186003)(83380400001)(2906002)(508600001)(2616005)(31696002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjljRDF6dFE0YlllRy9NNDlkK1BuZUM4eUNobWluMTljbnJvWWZzOTlsa1BU?=
 =?utf-8?B?emtpbk9uazYvQndQelp1dHB0Y2RyQ1NRd1NzMGdXWGU2NVlLbG02T2pBWmkv?=
 =?utf-8?B?ZE9CQVRsbDRHbXlsRHpFS1dEQjhJdGluTDJxUnRvd2dWcWZCcFd2N0h6eUdx?=
 =?utf-8?B?MVJzTmVFQWlOTjBWLzFrWFZid05OZWlZVndhejRqeFc0YXdFVU5wdGJ5VkpK?=
 =?utf-8?B?S3B6R1VzWG9mVGlqQTdyRkZaUmZEbVJDYnIrUHh6RFBYVXpyL2VkYW5udzBN?=
 =?utf-8?B?cXZicmwzclRPU0NrZWdPTmgwKy9pL0dtWVk0OW9jWU9TZVRyRTFucEpaSzB4?=
 =?utf-8?B?MkdvbEhNT0xyeFpnZ0g4ek1FMmhuUWlmTmcxSVpucDQ4Mjh2SkdZL3FRbi9s?=
 =?utf-8?B?T0pYNnBLZkthWHhFOEpsSUhpNmRlNXV1TTJBcDA5ZnpWTWNIcWtIUXFLQyt0?=
 =?utf-8?B?Y1FaWXp0WGgwNS9KbGl3K1g3SXh2d3N2Y2xySzM2NC9PTWRoeVcwTWl2RitC?=
 =?utf-8?B?d0NNQXNnalkyelRZNFhzdDArejhEenF5Sk5uYjBzbmppS1JSS3BWV0hDMU9w?=
 =?utf-8?B?NThLb2RiajB5L08wYTRpOUxaZC80eUhwQUxXUzBSWFhScXI1Uk4rc0dGZVpD?=
 =?utf-8?B?TGF6R2NtTnBsL2NzM0ZXNXBxUTdqNUlzeVIxRU0yckw1ZXRlN0hIakJaOHB0?=
 =?utf-8?B?RjFFL25yazd6VFJGZnJLZ2NRZmptcXpkd2NMdENCL243aUM0K1VBME1pNWhk?=
 =?utf-8?B?R1FEdjFaMWVmU094QWtFMm9LQ0lQNjFhcUdMMTl2d1kvMmtNTG9XUyt3Qlh5?=
 =?utf-8?B?VE1LMDF3eC9MOGV2UmxCSmNxU1FKclpQSEtHSk15ZVNldEVsSUtYeWtZNEtF?=
 =?utf-8?B?V3FtOXM3eENxQ09nMDFTYitNaERMT244OTgzSFgrblR6V3kyQUhMU0hMWmd0?=
 =?utf-8?B?bnFLZWxnc0xLeXc3WU85UEV3YmxtK1ZRUGQ3VTdEdDRqeTVONHdNZ3pLT3Mv?=
 =?utf-8?B?NDFIRGEvL0tWbUMwRklTdzZpU0FqTEhEcTR1bjl6UXZiNjVTcURIdGdua0Y1?=
 =?utf-8?B?MXdMU0RHQVhnbndoQmZWeHhsZ3dmMUJHQlR0UUp0MEsvd2ZhZmtsbTVUMjRy?=
 =?utf-8?B?NmROWTJWSDRkbEtOcWcyOWlBaVFBdHNUYjk3SWJ6RFNGcnpsc3MyWndWY0NW?=
 =?utf-8?B?OFFiV21SU0RvcXpsaUhXTUdxcGdzdHZLVUdCNWo2azBGbVZFdGxSUUhrMTBo?=
 =?utf-8?B?VVE0ZjdhcW5WMDhOc3NXeXpVSW9BM09XVkQxV2hhV1E3NmpsWVZETDE5dzJM?=
 =?utf-8?B?REVFT2YzZ0oxL2l0ejkvTkh3TjZjMmg1UlAzbW5BbWlKS2lhazYybzZ6ejd1?=
 =?utf-8?B?QzVqREk4SmVLWU5iOTdrZXFhSGwxcU9SdU8rZ3NUMjZ0eVRpRVBBRXIwL3h4?=
 =?utf-8?B?RG4vQ2hkSG1PRnhUOHhYeEFqSENMclV6WnlIcTBSVU9OTWk5Q1Jna3FLK3B0?=
 =?utf-8?B?MFVkd0hJOXJiempQUURkNEJYM2NOay9zZHRhWFN0ZGpuUHlEbzQ5aFA1Y2RR?=
 =?utf-8?B?UTU1UlhCZmo0UTRoZjd5Rm5LM2RoaVRmdEQ1NHhSU3hSMUYrM0NkTUgzYVFN?=
 =?utf-8?B?M2RDTldLSk5QcU5zbzB2WTY4MENlODF6UzlzTTV6ak12MFRBZUxwYjhLempH?=
 =?utf-8?B?M3JJZGRzdnAxUi8zUTNtQk1rQkpMbExURDIxQno4Y28weTdieGFOTGFTa1Zn?=
 =?utf-8?B?aUJJTnNKRmdTRHE3NGFEMko5SkpRZG1FQ3lQTng0NGhadHBTSzdsN2lSeFhJ?=
 =?utf-8?B?L0Ivb08vMllKYU5tWUlGa3B2Z0IwZkRBWnp5SlkybGtGQTRyaS9FZUpOS0Nu?=
 =?utf-8?B?eU5jejl1UUlzdGhrSHRRbmZGK05ZOTdhUGlUTU8rdDR3WC8yRE1TUjBvbzBy?=
 =?utf-8?B?cGs1cmdWMlF1eFp1RGtISFJXdWk0ckgrWll2eGxIdFMzZm5pdTZ4a2VYVmNh?=
 =?utf-8?B?RjNHTnZEYml2QXZ2dkQxRXpXUXBzTThvd0RQVmpuUStINlJJK1c3bkdvQTBN?=
 =?utf-8?B?dlFEeFdjWEoxL0M2VWlmSWtnU1ErUXFnazBoMjJac1Q4dXRXck9SZHZhdkpY?=
 =?utf-8?B?bjVoR0VwZWdtd3hacEFXamJpaHROZFM4UTFPQ2NjMTRzQ2s3L1ROOW1RMFEx?=
 =?utf-8?B?bjlJNzNaNUtVV0J2QWF3eTdDcnUzSlNBL1VlMm1IZlR0Q0tXOCt3WExrUmtl?=
 =?utf-8?B?bmxjMWRrcExrWlBsR3BGejVXRFBDMm9oZmhpTFhpdUorS2xJTDZPRkFid2lZ?=
 =?utf-8?B?VU1GTWM2TjNBMTVJMEptTThXNCsxSUprWHV1Q1owcURRT0pHc2EvWHlOeUxP?=
 =?utf-8?Q?ILs7dycjoyd7nxbs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f92cbb-76e5-4d9e-0070-08da47a0ba05
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:41:27.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGoQYDYNwBaicNn7DutKkbZj3GoWNEOWc7pQi4tNvA1zUWSUp8ET1IB8DFZyNgUtramGAwiRSGzAGGJUbQSwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7465
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.06.2022 05:33, Ming Qian wrote:
>> From: Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com>
>> Sent: 2022年6月6日 0:43
>> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
>> hverkuil-cisco@xs4all.nl
>> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v2] media: imx-jpeg: Disable some unused interrupt
>>
>> Hi Ming,
>>
>> On 30.05.2022 10:47, Ming Qian wrote:
>>> The interrupt STMBUF_HALF may be triggered after frame done.
>>> It may led to system hang if driver try to access the register after
>>> power off.
>>> And interrupt STMBUF_HALF and STMBUF_RTND have no other effect.
>>> So disable them and the unused interrupts.
>>>
>>> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG
>>> Encoder/Decoder")
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>> v2
>>> - add Fixes tag
>>>    drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> index c482228262a3..258fbee7ab66 100644
>>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
>>> @@ -76,7 +76,7 @@ void print_wrapper_info(struct device *dev, void
>>> __iomem *reg)
>>>
>>>    void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
>>>    {
>>> -	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
>>> +	writel(0xF0C, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
>>
>> There is another way, less aggressive, to go around this, disable all the
>> interrupts once FRMDONE is received (or some other error condition),
>> interrupts will get re-enabled at the next device_run. I checked this works, in
>> mxc_jpeg_dec_irq:
>> buffers_done:
>> 	writel(0x0, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
>>
> 
> Hi Mirela,
> 
> Yes, I think it should work if we disable slot interrupt when frame done.
> And which solution do you prefer?

Hi Ming, I don't have a strong preference, but just in case we decide to 
later use some of these interrupts, I would suggest to go with the 
disabling after FRMDONE.

Please do not forget to clean the other code related to "Instance 
released before the end of transaction".

Thanks,
Mirela

> 
> Ming
> 
>> Either way, I would also replace this:
>> 	if (!ctx) {
>> 		dev_err(dev,
>> 			"Instance released before the end of transaction.\n");
>> 		/* soft reset only resets internal state, not registers */
>> 		mxc_jpeg_sw_reset(reg);
>> 		/* clear all interrupts */
>> 		writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
>> 		goto job_unlock;
>> 	}
>>
>> With something like:
>> BUG_ON(!ctx)
>>
>> The initial intent of this code was to cope with the same problem,
>> STMBUF_HALF interrupt received after FRMDONE, which could not be cleared,
>> but it was not done right, I can see the hang in some rare cases. We should not
>> run into it anymore, with interrupts disabled, either the way you proposed, or
>> mine.
>>
>> Regards,
>> Mirela
>>
>>>    }
>>>
>>>    void mxc_jpeg_sw_reset(void __iomem *reg)
