Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6F500A19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbiDNJom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbiDNJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:44:37 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A052E65;
        Thu, 14 Apr 2022 02:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwCUr9/8diN1CsLryRRM5KwnOp6t6F7cg394BI9LvjgdXOzpi8ROnjNPf5y4D7qIZt0MhJ+DCswKSBeQJeE/TEJAaoUxrWdbsTthUBuf1VT8KI5aX8F3W3tjLKXJ2NCXu2uMsGI1d9Ol/Ay8Q8kQc6Ap8U943mP1q6jlwePbwr6WE2PJ+c0cj7dI35cbo/Z0WLM/lFmhM3M9TCHEbdpJCtDqzuvrCspiM5vSYgJWYSQIDstzkqzRnn0ktJL2B1xa7nWYLggDjyljdSTQbwOtkWqEh2WzAl6F+Bnr4PsRhHK64uG+qNIexTV3yZBqvKkyn+ublw3UuM6AEUCDmQ+bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcOYjYs7y+R/LCf00rRmfpdI0I2/j/I4QN50Sj1qkPI=;
 b=PNLSzXLPIiD/1SjA4D3etsBQdljCJV0iGhGadcg8yC+jGEaf+i/qasZHCN+IGt3FXB3v5U0GTe39w712wMXobEbg0ixFmcffB5+2ljhJp5RJK8g9HP2zZiD8yZqkX7lIaDIKIfNOt//Fm1Km8mCK5TA2Q3MfDB5SiuknQzSUQ/RTDIxuEyXy1Xi7Ob4LKghlhJBhYnOZ/uFpyRo+AfTf5am5h9ESDA18v2maZEozGDwLipMxVlnk2+0jlyUKqtGImjvxnCKQB6LIhhIP6+P9gSm7Lf3+X8S+LBQUwvf2HCzSw07hYI/H7HFglXnakfOXDF2GYBmKrKqnVR2mOZzEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcOYjYs7y+R/LCf00rRmfpdI0I2/j/I4QN50Sj1qkPI=;
 b=Bwbd+NBhLGlBiA8xSnJCipM5TIF4JbdxEM41g5dsCuOvsCEreZK3OjSRSjwr/E7tGzQimCVGmWMAF/FisGkdaVk3xLmXxmB8mCXbX8hgHkR9O4KeebLDvhjy1Od6nGjzehD5hF3OdreevoBFltJGB+qgnfEXhaxt7l6iVNNMKUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM0PR04MB5412.eurprd04.prod.outlook.com (2603:10a6:208:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 09:42:09 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af%5]) with mapi id 15.20.5144.027; Thu, 14 Apr 2022
 09:42:08 +0000
Message-ID: <80bcabe7-5761-7244-c6ea-1b5893395170@oss.nxp.com>
Date:   Thu, 14 Apr 2022 12:42:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: imx-jpeg: Encoder support to set jpeg quality
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220406094623.7887-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220406094623.7887-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0069.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::22) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ed80de1-e5e7-4b56-3d0d-08da1dfb0b06
X-MS-TrafficTypeDiagnostic: AM0PR04MB5412:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5412BE1234F969353299C431CEEF9@AM0PR04MB5412.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pGBn7UMK++u5/ZnEl0SZr5BEpRqMpf9TcWbSCrblrtD6wg2bWKioj8b51I+6gpInIU6meAIrcHFbEXvc14g6U75M6R306zU2CKcT8dsVhMyPaX8/ZFu3yrMjW8D3EiCro1EJIF7x/5rkxAnlT0S3S6q/jeUIgbuB1rR1IyPjxLHHTEmRmOpWZKP+hAxlknfqMhhTF/EVzRROSghzKDo30ghsH+TpjsTgmlDKhrr68CCl3W6bUb2jiWkycsmQ6CGNZceU3UtwsVai7vHtdPp6i6SfDDrTYOA4lXvYSYEUECQTs9vquiEwc82cAIsr4u8nqTxe2pjCKkAIV+Cxcw2ukYKtT5oGK/kpWa64unoA7F9bX8vaA+6wbP5CEQP5OhWt93pPiBKBqHGQFm1BHneXctobTVQtMhLbmvnv23Ve1TDD0OPu5aT0p7Bsse9gfTzimrwVylO5qwdIfSMoBMIA1vAh1gO2983Jm7hpL6JTT9mhS2McgQWv4hRJCiye3q5lCm8xk1nDZbLKqLo3z2jdgFZfzfKtRgywBgrS8kDvOP0xl47x9oj6u17Fafg3BS8NshkQXhy5r9R31N3d+xAlq903UWg10pCDFahIvJo8eQwAqjKW1RLjyjY2sT9AfU4+6UQvCvXkrlHhbWMKbGhkNxRaEfi9nRxILJSlXnRMQ6SVdLFE+/vAovtaesAe8L9/FMHgoxAf8vvlvixncLQa/PI0ja166rTAq+2VRmuH3pnbsmuC3EwLX7ww1s/LCWxqXf6K660occLcwfxtlWTvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(66946007)(8676002)(66556008)(66476007)(2906002)(7416002)(86362001)(31696002)(5660300002)(8936002)(38350700002)(38100700002)(83380400001)(6512007)(6506007)(53546011)(2616005)(186003)(52116002)(26005)(508600001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEUraFNXdVpnSVkrRzF4NWQvYTJBSWNuK3l1Snh1QmtHZjdaa0hZVkFCZCtx?=
 =?utf-8?B?QUtHMkZHanQ5RVFXUXJ3VFZIekpJOEwxTVNYREdRNUNDK213Zzc0RVB5NzRy?=
 =?utf-8?B?TURBRjdCMGxYRHowR0RpdFFkaGwrV0ZwYUNXZ0g4ZVpGSWZqVjRaYkJmcWJa?=
 =?utf-8?B?TTRyRFV2cVBBSHhUdmFFZFZqVVBjMEtGZU1BaGVuaU5INTFzZFBjQzZTem8w?=
 =?utf-8?B?cUtWM3V5djJ3MXg4NFo5VmlKZm94TGprandJdFJVNnRDeGVRaHdsZ2tPa0Mw?=
 =?utf-8?B?NHRKcFNhdVlQdlp3STVUWnhDY3RvVWJIazVGdFpvUlVWd0loRWEwUXdPUzhX?=
 =?utf-8?B?amtmMUhhUWZadGRXYldPM1pObXdvUHZDOWZKWHBsajhic2ZDSW1CUE1iUGpZ?=
 =?utf-8?B?QXZxb2l2Y2UxWFVhWjIwL2ZrdERaZ1dXZks0WnpuQjVTSko4K0x1VVEraTBF?=
 =?utf-8?B?SGZJTU13cWJaTFE4ajBEeW1obEUzZFdvdG9iQmNBY2lLOW5FcDBpWHJneVFI?=
 =?utf-8?B?V0ZmdDZSM21jbnZTdjhRMmw0SVlyamlicXZYb2k2RXRpVkhzVUF4aXp4SUFx?=
 =?utf-8?B?VFFGR2pSNWUyMnQxYjdhSE1QNVdGa2lLUmc0TXRLR3h5ZE1TOXlhZ1pSSHJR?=
 =?utf-8?B?SC9wSmFYcmdaQlIrQjZuMXZQa3VGMGtSdUVMRXloYTlFZ0JaeUZZbmtnS0hU?=
 =?utf-8?B?Sk51S0JTUXU4OHcyZ3Zka1RNWXlsKzFUdjEzaXFPMUtnWGVIWHpsVUVYTkNO?=
 =?utf-8?B?bjZNb2pvcytoR3ZiYXNtT0xXaWZSY2g1M2dld3c5aEJMbjIvRCswNHc0UWhX?=
 =?utf-8?B?ZThCRGxKamVpazR4SEtSTkNaUnpGTS9xQllVWmhFMmtJeEo0TjJTZ0V0U0Rx?=
 =?utf-8?B?N1dOTXEwdXEwcVN1cUNMa2FJQUtsOW1oWlhBOXd6Z3JUQXVXV2FUNUNUOEJa?=
 =?utf-8?B?V2N0THJ4aUhORDVma0FaM2pzTTJhbEtLVlJWM0xBUFcyTnR1VVMvUFpzN0dR?=
 =?utf-8?B?QW00YmJXTmNYUkFERGVsMVFzbHV6MUI5ckt4bERadHovL3JYN3EwMWQ0REEz?=
 =?utf-8?B?LzBMeUtVYlBWa25EZUgya1Uza05SMGQxbERHL0dyaVJpTm9pU3NoNGpqMVRj?=
 =?utf-8?B?TkpPUDVKelVYTDlveVJqSmZNdWRnN3Axa3ltRGNReFVRZkE2ZEtmWnkwSDN3?=
 =?utf-8?B?RTFKTjd5V2RLN2ptTUk0UGIvUFhOVHhHMGVuc29jeFloN3N6dCtpRFFnRldx?=
 =?utf-8?B?S3MzbTlRUXZJeC9ZYTM5WHpmRmp0S2tqVVBRSElnS2p2dGFNN1dPb0NjNkV3?=
 =?utf-8?B?T3BYd2lOb0o0TU0rU2R0WGhyYW5JSnhiamIya2ZzSklzYWJ0dzRzUEJ4ZFFD?=
 =?utf-8?B?L2lZQ3VSNFNybFM2aFB2TFpRcWVQTGh3dUJuZUZUODZTck1GQXk2RjJ3QjRV?=
 =?utf-8?B?ZEVTdVJ0eWgxaHdOQ21rV0h6TWR5OGVMaEpzY2RWUjBkNXc4MHhJQ0xwSnpl?=
 =?utf-8?B?VVVRRktwREJqSUVLWnNpa1JmcTBUbzVQYkY3OFhwUXh5Q3RVUmxQaVdUM09V?=
 =?utf-8?B?K1FaSk5KbHJRbWNBZ0hNa0NxV3dvQ255ZGF3QWgxK0FQR04xeENQaW8rOWJQ?=
 =?utf-8?B?bFE1bWJiTitrRWJhZGROYnA1S0poMmM3QkpET0dqUGswdkFyU0VqUm40UVRq?=
 =?utf-8?B?MTlUTDBhdVFpcHd2VWZRREgyYXp5YWJpdVdHRVltMnl2TkdqT2hZYTZkRmd1?=
 =?utf-8?B?b3c1UFV2S3dHZXZEQnBsMElmOHB3RnJOMm9NZlB6a0Y2YkxRZFhjazQwbjZT?=
 =?utf-8?B?elRCMlo1MlYyeEZJV0MvS2x6RWpmN29vZEZVd0gyOWFjOFdraVZWd0loSGxF?=
 =?utf-8?B?MUVvZVJSc01JQUQzVG1wbVc3NmxtQjQxMkNVUjBDeHpqTEFDL3lpcFh1WGI2?=
 =?utf-8?B?UnhrTVpHVjV5NUNsRGZ3VDNxNC9kRnBoSWhGSXA0b2J3L2lBMER2cjRCNzda?=
 =?utf-8?B?dllXeVBTMThJKzBTQnRRVkg1NHBURmtyN2lZZVYveTNlTExLMU1ILzZ5MWZS?=
 =?utf-8?B?MTZHQmluUC9zdy9sZXdlbGR5bFdkVkdtYUtrRXhhZ0NPQlhEOFhoV05YOFl0?=
 =?utf-8?B?SlkvMjg4YzMydjV1RzhYcldmKytWS2xHZ2lTcjc5QTNLUlJaYVNnUkF2bUYr?=
 =?utf-8?B?dWRmZ1RYcUJuMkdnaUpnYlM0SzhlWko3T2NGeENIYTFzQktjaFZGQS9zR3FK?=
 =?utf-8?B?MWd6Nk9pdFNjazlwRWZEbW1CbE9OZlRVUGUrNTNHOTRtTXV1MGdWZmd0MVRl?=
 =?utf-8?B?K1hnSjhnM0FQeDkvaFREZUZXRnJjc3l0SXI3RXFEU2JYcHM5dlZiOUU3aVZw?=
 =?utf-8?Q?ae/hwDjRx7TmvmC4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed80de1-e5e7-4b56-3d0d-08da1dfb0b06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:42:08.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM/7Sr7EwkPQBjOBjMEqZVvSy/gO1eJOlqwcI8lfC9MLraQqQ7mGOCxovO2jI8EKXR6BJ8fphPfcQ7ZU3WDjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5412
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 06.04.2022 12:46, Ming Qian wrote:
> Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
> to set jpeg quality
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 ++--
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 50 +++++++++++++++++++
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
>   4 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> index 29c604b1b179..c482228262a3 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> @@ -100,9 +100,6 @@ void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg)
>   
>   	/* all markers and segments */
>   	writel(0x3ff, reg + CAST_CFG_MODE);
> -
> -	/* quality factor */
> -	writel(0x4b, reg + CAST_QUALITY);
>   }
>   
>   void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
> @@ -114,6 +111,14 @@ void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
>   	writel(0x140, reg + CAST_MODE);
>   }
>   
> +void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality)
> +{
> +	dev_dbg(dev, "CAST Encoder Quality %d...\n", quality);
> +
> +	/* quality factor */
> +	writel(quality, reg + CAST_QUALITY);
> +}
> +
>   void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg)
>   {
>   	dev_dbg(dev, "CAST Decoder GO...\n");
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index ae70d3a0dc24..356e40140987 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -119,6 +119,7 @@ int mxc_jpeg_enable(void __iomem *reg);
>   void wait_frmdone(struct device *dev, void __iomem *reg);
>   void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg);
>   void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg);
> +void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality);
>   void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg);
>   int mxc_jpeg_get_slot(void __iomem *reg);
>   u32 mxc_jpeg_get_offset(void __iomem *reg, int slot);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 0c3a1efbeae7..ccc26372e178 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -624,6 +624,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>   	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
>   		ctx->enc_state = MXC_JPEG_ENCODING;
>   		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
> +		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);

I think the setting of the quality should be moved in device_run, to 
keep the interrupt handler lean, I checked it works fine after:
dev_dbg(dev, "Encoder config finished. Start encoding...\n");

>   		mxc_jpeg_enc_mode_go(dev, reg);
>   		goto job_unlock;
>   	}
> @@ -1563,6 +1564,44 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
>   	}
>   }
>   
> +static int mxc_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct mxc_jpeg_ctx *ctx =
> +		container_of(ctrl->handler, struct mxc_jpeg_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_JPEG_COMPRESSION_QUALITY:

Looks like this is allowed for decoder, which is not ok, maybe return 
-EINVAL for decoder.

> +		ctx->jpeg_quality = ctrl->val;
> +		break;
> +	default:
> +		dev_err(ctx->mxc_jpeg->dev, "Invalid control, id = %d, val = %d\n",
> +			ctrl->id, ctrl->val);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ctrl_ops mxc_jpeg_ctrl_ops = {
> +	.s_ctrl = mxc_jpeg_s_ctrl,
> +};
> +
> +static void mxc_jpeg_encode_ctrls(struct mxc_jpeg_ctx *ctx)
> +{
> +	v4l2_ctrl_new_std(&ctx->ctrl_handler, &mxc_jpeg_ctrl_ops,
> +			  V4L2_CID_JPEG_COMPRESSION_QUALITY, 1, 100, 1, 75);

The v4l2_ctrl_new_std may return an error, which is not checked here 
(NULL is returned and @hdl->error is set...), please fix.

> +}
> +
> +static int mxc_jpeg_ctrls_setup(struct mxc_jpeg_ctx *ctx)
> +{
> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 2);

ctrl_handler has a lock member, which could be setup here.

> +
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
> +		mxc_jpeg_encode_ctrls(ctx);
> +
> +	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
> +}
> +
>   static int mxc_jpeg_open(struct file *file)
>   {
>   	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file);
> @@ -1594,6 +1633,12 @@ static int mxc_jpeg_open(struct file *file)
>   		goto error;
>   	}
>   
> +	ret = mxc_jpeg_ctrls_setup(ctx);
> +	if (ret) {
> +		dev_err(ctx->mxc_jpeg->dev, "failed to setup mxc jpeg controls\n");
> +		goto err_ctrls_setup;
> +	}
> +	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
>   	mxc_jpeg_set_default_params(ctx);
>   	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
>   
> @@ -1605,6 +1650,8 @@ static int mxc_jpeg_open(struct file *file)
>   
>   	return 0;
>   
> +err_ctrls_setup:
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>   error:
>   	v4l2_fh_del(&ctx->fh);
>   	v4l2_fh_exit(&ctx->fh);
> @@ -1962,6 +2009,8 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
>   		return v4l2_event_subscribe(fh, sub, 0, NULL);
>   	case V4L2_EVENT_SOURCE_CHANGE:
>   		return v4l2_src_change_event_subscribe(fh, sub);
> +	case V4L2_EVENT_CTRL:
> +		return v4l2_ctrl_subscribe_event(fh, sub);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -2035,6 +2084,7 @@ static int mxc_jpeg_release(struct file *file)
>   	else
>   		dev_dbg(dev, "Release JPEG encoder instance on slot %d.",
>   			ctx->slot);
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
>   	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>   	v4l2_fh_del(&ctx->fh);
>   	v4l2_fh_exit(&ctx->fh);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index 9ae56e6e0fbe..9c9da32b2125 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -96,6 +96,8 @@ struct mxc_jpeg_ctx {
>   	unsigned int			slot;
>   	unsigned int			source_change;
>   	bool				header_parsed;
> +	struct v4l2_ctrl_handler	ctrl_handler;
> +	u8				jpeg_quality;
>   };
>   
>   struct mxc_jpeg_slot_data {
