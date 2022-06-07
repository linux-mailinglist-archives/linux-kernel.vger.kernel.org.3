Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0F53F899
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbiFGItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiFGIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:48:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252B6253;
        Tue,  7 Jun 2022 01:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0pCU4Ep9vbUTzmuls+RHIlSYZU4pYhrHxxwrdX1bN68LkjR9GHTloLlGTgzTULwv5MX6XkhxpKISk7xPYwhdJ/ugCcB2XSZChtetQ/mbP+B2zZE0kS5Rj47GztiGmAHhB/g5qw1PRIOUhRNaJp2wB7mHQW6UPcQLhprkTbVS2XaKXzl+FV81bb12h9Wojj8/RjH0NoZhByfUvbbV0AG1E+uPcNQswVW7pvMvFBOY4O9GvBKipLtkhAaG4uVU5p7VFkqaSGLkzbsxGYIJeJGJLdsTE0yCoXdt89FANiIl1FNhYRxjWnQ+bduKp5ntgNqXufB0ldQL5lZrX4uLnvj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSPf6nKt3W66t5w16Nz2mMOzyWYqhnIxZpZBFk2DysY=;
 b=Fl5RWumCFKfwPJu+zAy1XfF157k/y9T/9wIfbBKx7hUe+Ur8BvGP9N2Jluw/gkIFNd1ON/PZZZyV7jpRLba16fKb44xdTYgWsozoWDAcD4fGCQD8POKyuTjhblU/G82+Wl00r41WCx4dynL0MqG1YyPDXbu5bbVBSS+egAE2+/r+Xcxs+z83CQtgLIDH5oc0y7mteatZxo+HJxwnOGTLpTzmV6RgXu5lq8Y0uCVKc5gNtnVf83xjO3EgGq4OINtcj4Pb+Q+6U8b2ir8McmnRvm5mq0iKqCtKHxkKcrg+yhqJRI/INLzUz/PkMPFR0V5p5bvl6gLC/bmmfw/7wrjxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSPf6nKt3W66t5w16Nz2mMOzyWYqhnIxZpZBFk2DysY=;
 b=N7dhoXCgdxF976LQb3mYM8uvkdnuhmStjsw7RR/xX/z96JXQH/Mr0gXdekjA37oPCpLmL+Pm+KkEpGEp9yjihg9Yufox9v1Efprlxys4PrR9Dx/LbvdgEMygBq+aqXUwOG3p/K32s4opxfRtIny+BiiGsbGV31VRwt/1ZNv6IGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM0PR04MB6609.eurprd04.prod.outlook.com (2603:10a6:208:16c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 08:48:40 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:48:40 +0000
Message-ID: <fb477fa0-2272-9bd8-de09-91984dd5a0dd@oss.nxp.com>
Date:   Tue, 7 Jun 2022 11:48:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] media: imx-jpeg: Disable slot interrupt when frame done
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220607072315.23209-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220607072315.23209-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0073.eurprd05.prod.outlook.com
 (2603:10a6:208:136::13) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3388e905-154d-4dd5-a6c8-08da48628516
X-MS-TrafficTypeDiagnostic: AM0PR04MB6609:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB66091A081383311D965F4D98CEA59@AM0PR04MB6609.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMmszxa/uQPGkPIvBHs8KGT5xvCC7rzg4nvi2z9dZFhvExbpq8CYmqrMmE1UM2SXvu5ee2+dkugmv2Sn8GrrkZrJs6iiI4VctiMMcmjDvoiSSfoeXGBB/6k/qh83Vo2E51wFBIBKuGU9LX6PjdZho5V2VrHQnCFnlwM0ZYQA1uU9GYeG6BVAZoeCZDtFQ5xHfYN9Aw51h/azb/N+Qe5OqbnX8Vd4oyHQNKb0VQp4lxSB1MUbMXLUeBjkxj+xf8343KJ8KEwDj2CJCnU3LImlVwMdxz8gujQrfOieRRO/soFS8F/lH/zihOT5p7qa7Y6r1R3Zrq4kvMZ50g+JE1ubwgBv/s9+ScfpMRhZ6oKKxzr7b0HWhU2au7DTycPpjzqrFq5sndXf6NCkbbynGTMHd8B35tQPwgQFFNXWGe7SygRQtYlkADzfmENTBre627ZwK+qceI/f581c8VYpgFdPOVOSf6aMeAsFRwRmhLbAkUvgbxkdNaSD3cwODkZwENIGIQyAH7clpOSTL9m0rr6/exiktW3YJMgBF8AwIMRqffZ3JTtI6bhF6dNxysFeVttFw1rpjkRavZwKiLN1KoBw42UJVHlK9Cv4/B/hxbG0Lsj9Ya4S3mk/xd960zMHu5groqoyEsdPIfAslMgKacy0AMEga7JjNtEG0FxxpdJkG2dgHQlG62kXfrCtssnjKZrSzDQYAMrQzisurDh4be4tkzEhArvu/Bh/ODr9gMZofY/bWh3bxm9TM/nTecj/mLZez1DqlE0hIAY9XS3Jz40IDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(38350700002)(186003)(66556008)(53546011)(52116002)(66946007)(38100700002)(2616005)(4326008)(8936002)(8676002)(6506007)(26005)(6512007)(31686004)(83380400001)(6486002)(2906002)(316002)(5660300002)(31696002)(7416002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNxWmxQMG5Fb0VWLzZibzZNajkrUDdIdThzaEVOWUx2cFNrZXlGamdkYm5S?=
 =?utf-8?B?THJGWUR1bGlxb3hhejNiOU1VT1RvNVBQNEttZWVQc2xRMEtiNEtweUk1d2Zm?=
 =?utf-8?B?RUU0QncvMSswWDBNaDhkMWwvL2YveGVsdzJnVEhEY0pzdGhUaS9BTmJ3VHhy?=
 =?utf-8?B?MWZZK1o4ZjZralZOT0o4WFh6ZE1pN1ZGK1ZhTnE3alE4STZyVnRRZUx1MzRR?=
 =?utf-8?B?Y1hvQ0FwOHNGTGJQQk9RK0hDM1gybTZQZmtFVHRjYUtyVEliSmZTNkVLYXdr?=
 =?utf-8?B?STNTM0x5L0E5TnRWWjlub2dOZW5Xc0xlN29nUjRGa3pTR3paeXZubU1yWUtv?=
 =?utf-8?B?czBRU1BXZVEzUXVkejc4Y3RUbkpHUUpzMEQxWWozMEdPS0F6RThqUEZjcThQ?=
 =?utf-8?B?bnZmQzdPWXRZZSs5dkdqdHU4Z0x3S0NWeVRwdHA0VExyekRNMmgrQXFsc1Yr?=
 =?utf-8?B?Q2JDR1p1Z0xyWUwwU3pRNlR1Q3BjdHpHK1E0OU84eHFvLzd0THhhaG5MMjZm?=
 =?utf-8?B?YnYvVGd1K0pUNkRISjI3QnN1dlJIZmtUUExja25KZytrU0hsTDd1Q2V3bUlY?=
 =?utf-8?B?bm96d1JLaW05ZW1ZbHdjNHI0ZmkvR0w0dGFOZUhSNldBanYrdW1BazdmQVR6?=
 =?utf-8?B?eXczUC9HQkhXdjhWK01ab3dYSUc2blovVVY2enJWYjZxSGdmaXQ3SktTTEps?=
 =?utf-8?B?b2lSVWh5Ny8rdzYvZFZKOWpWWWxIdHJ5dFYzbmRNYlo2NW1lT2srU3BQVEww?=
 =?utf-8?B?eUErQS9uOXdLZkZBQkUvVFZFTENoQ1RvcFRNV0tVMGU5blV3MGxPYjAva2N4?=
 =?utf-8?B?LzVwRldEeGJBMU5rbHdTbnJweGtKdmh3eWx3YVdzcHo2OHRPRDZsc2JTQXd5?=
 =?utf-8?B?SW5BM0xIQUI5U2xUZG8rbHloOGJCcWYwY3o3T1lPVUFlTHc2NjRoNEdQVlRm?=
 =?utf-8?B?Vm1MS09GMmhsUm9zMEt3RGZEalJzMzdGZjhDaS9MNkw3V2dPSjZuSTRlV01u?=
 =?utf-8?B?eHRiNVhUTjVCVHFuTytnUXJDVHUxMGdTOXRvMG42enNKeHVBUDJZSEVIdFVp?=
 =?utf-8?B?SGlYdHNJdXJyNVFHUVRhcElqMFRLWjR6ckhWQkFFZ3A3YXMxOE0xSUMvWlJH?=
 =?utf-8?B?SXdBaGFKRyt1VVdBWE4wSDBOVngvV3BsdHNYUktod3NaOHlObEprYmdjZWRx?=
 =?utf-8?B?a0o1dk5XWmg4ajE0eXF5Q1FPMFBLNzVydjRLVFlXU2g4ek1PU0NsV0UxMzN4?=
 =?utf-8?B?TmtQVkgxSVZ3UlRnVkJzVCtiZ2xSc2tpd1B5d0lZbC9zV3pyY3JqNmlWejNP?=
 =?utf-8?B?RG9FVXdueTQwSlR2RHdtTkwxbkdqc0FCUmZJR2dKS2xuZWcreHAvdWtOWThM?=
 =?utf-8?B?SXltN0VURUI1Y0V6QkM2QldTQkZ5TVZRLzg1OUR4M1piTFc3R0VaV0NOTDRE?=
 =?utf-8?B?VG1TVDhXTG9aM0x6Q2FGZStwamFkRGlFNUJkeURtVWRXLzVvdFRRdUJZWlJH?=
 =?utf-8?B?YWNJSTdmcVdDaEhhSVQ4UHdsem1nYjJvdytWcXliUW02YlMzcXlGZEVUWE9B?=
 =?utf-8?B?TnBYb3FXd2Z5RFFOcXJjUHJuMGxkSm9Ja2cvYXY1YnZQTzZldnNiMi9mR3lI?=
 =?utf-8?B?MTJWZkpwaWxQNXVEUS9iLy95NWZYL3pSUlZSTFNJenN0cStEYzArVXBhTHhF?=
 =?utf-8?B?TXQ3bWRRdW1ZekZsVTl2UUMvV2pUTDQwcUROcDZ1SUxlUUJUVnVMSjNWeUd4?=
 =?utf-8?B?YU5IRnphL2JNWkI3R3A3MXFNaFErZFJtR3RPRHp3bUpSOFk4Z09jU0J5U2pj?=
 =?utf-8?B?VkVnYmk0dzNRcG9BK3Jpa1pRTFp1NTJvUCtpMVlSTXlZaFNaUDkrcVl6VVVm?=
 =?utf-8?B?c1RjTkZ1dGxVRW90amV1OXoxWG92b0pnaUlybXBTY3RuMGxhY0NTNnFJTjBV?=
 =?utf-8?B?QzR5MDN6YlhWWTVTR0FMYWh3Y1ZvbGltRlZmZi84VkZDRVF1QUdldC9QZ0ZI?=
 =?utf-8?B?SFNSaFZRTUxBQnZYYmg5NW1hTHk4TW4xTDBJUnNEOHlRMzVvSlIxM2t3OG1x?=
 =?utf-8?B?RXJSbFNmOGhDdkFOV1FFazZoa3RrNXlxSlpJdGs3ajdwcDFxNjZvaVZxaUly?=
 =?utf-8?B?MjVNSEI2b1RLbXEzZjIwb2hpWXc1b3VWa2dpZS9pc1pCSUlRWGNZMnNtSHNV?=
 =?utf-8?B?MWtPQ09Ic2poQkVqeDUyUTB1bkNWTGJVM2tIS2c4QUlCdnBSSWp3aHlSU3FF?=
 =?utf-8?B?Z1ZPZ1dKaUZNT2E2QjdEUFMzMHVUSXNxVFVDS1B5MVZkelFXcDJNT0JzMTgr?=
 =?utf-8?B?aTF6V3Nad0hGRGQrZW90WnBwVUlFa3VKY0JkOTRnS3dEakt6RVQvNXBTS2lr?=
 =?utf-8?Q?5dcoM+8BDi4j5KH0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3388e905-154d-4dd5-a6c8-08da48628516
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 08:48:40.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfutCoVajtieohePMS5GoQY6cvfFvBRpewOS08RIHghE3tJPguuWMuxoWc7AMK4jaSSUxQTHc2930aeKQrZj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.06.2022 10:23, Ming Qian wrote:
> The interrupt STMBUF_HALF may be triggered after frame done.
> It may led to system hang if driver try to access the register after
> power off.
> 
> Disable the slot interrupt when frame done.
> 
> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Thanks Ming,

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Tested-by: Mirela Rabulea <mirela.rabulea@nxp.com>

Regards,
Mirela

> ---
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  5 +++++
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 11 ++---------
>   3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> index c482228262a3..9418fcf740a8 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> @@ -79,6 +79,11 @@ void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
>   	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
>   }
>   
> +void mxc_jpeg_disable_irq(void __iomem *reg, int slot)
> +{
> +	writel(0x0, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
> +}
> +
>   void mxc_jpeg_sw_reset(void __iomem *reg)
>   {
>   	/*
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index 07655502f4bd..ecf3b6562ba2 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -126,6 +126,7 @@ u32 mxc_jpeg_get_offset(void __iomem *reg, int slot);
>   void mxc_jpeg_enable_slot(void __iomem *reg, int slot);
>   void mxc_jpeg_set_l_endian(void __iomem *reg, int le);
>   void mxc_jpeg_enable_irq(void __iomem *reg, int slot);
> +void mxc_jpeg_disable_irq(void __iomem *reg, int slot);
>   int mxc_jpeg_set_input(void __iomem *reg, u32 in_buf, u32 bufsize);
>   int mxc_jpeg_set_output(void __iomem *reg, u16 out_pitch, u32 out_buf,
>   			u16 w, u16 h);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 965021d3c7ef..b1f48835398e 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -592,15 +592,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>   	dev_dbg(dev, "Irq %d on slot %d.\n", irq, slot);
>   
>   	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
> -	if (!ctx) {
> -		dev_err(dev,
> -			"Instance released before the end of transaction.\n");
> -		/* soft reset only resets internal state, not registers */
> -		mxc_jpeg_sw_reset(reg);
> -		/* clear all interrupts */
> -		writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
> -		goto job_unlock;
> -	}
> +	WARN_ON(!ctx);
>   
>   	if (slot != ctx->slot) {
>   		/* TODO investigate when adding multi-instance support */
> @@ -673,6 +665,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>   	buf_state = VB2_BUF_STATE_DONE;
>   
>   buffers_done:
> +	mxc_jpeg_disable_irq(reg, ctx->slot);
>   	jpeg->slot_data[slot].used = false; /* unused, but don't free */
>   	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
>   	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
