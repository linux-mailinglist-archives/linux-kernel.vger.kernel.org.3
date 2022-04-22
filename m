Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2050B476
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446295AbiDVJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446280AbiDVJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:59:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150A53E1A;
        Fri, 22 Apr 2022 02:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRrJuYSBOvMuSlAXJwhBP67WwogVFLlGtAQNjm2v1GVB7yag3fUk+TGEQ6ZQq2YibmPvPm7HGiRvAezpBt1FtDKcOFMeYowY1h2zev2y6y7V4o/4Yb+bBJn6e42UZ4qranjuXsGuof944X6zTGjrhZrDQ0cni2iUAsA1GYnKHy6k2XUr1mHqxH+FI7mFyWiJknJq2To8eXx78DMQYM4ALY6O3aqS0VgXYRh0Hzt9CaNv+3hh9cNmyMEObs2UHOgSFfsMwmDuOC2mEfPnW8NNAjW5Al1QpWiVg5zxRwHIH8VAISi4fof+WUVNmck1AfIqZ1qMp8HfCQcUJXywJ8F5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YZoVxSux8VnYHaAU+mggpkEDZFam8SSqSjAhEZz4+g=;
 b=WT8xatcNFgzsdLtq6oG1Jann7YYOyVZPPnpJ+/sgjWZz4wLcraVV+FanJ5QZ2xN/x7qdn5i32x3iN6wBBdd76NsIWfeTsxBICW2tmdPJf2M3aDCJfxmv3KpZLNc+b7yzxoF1WcAXGKTqWEbV2A8hwh4CD5TG2aOOZijL+74U2C1S5GUJDUpRgDj/UAFbobZym5fj9qKIbmoAuKtaSMT3mFjNbNQNrsDclDYATs1gHeO/vZ7xh7H7eUZzgZhE1843t0C7x5FGFPgOyPj2hgcq4g7FNc/f4iW4Lo7INZlaVkIZEK82ErIJ+270lIisTkrAPak0e2DGsqNhGgNVQBDA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YZoVxSux8VnYHaAU+mggpkEDZFam8SSqSjAhEZz4+g=;
 b=mdKTn89kKbmmiBcFhfzMwIcm9H/1xsBFxbq6dkxA1/+naOOszxEJLHi5D9CLj123xXUhhGHthlaFIuFPrrDdVGb9O2pl3GQVOJV61k+CuWrSG4uXKuJs0Rf0dr2zrfVJWAEILc18Lov5ZJjDq3yMFvlviS5fPr/MSQGWDl8WrSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by VI1PR04MB3104.eurprd04.prod.outlook.com (2603:10a6:802:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 09:56:21 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::255c:3e75:6c8a:54c5]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::255c:3e75:6c8a:54c5%9]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 09:56:21 +0000
Message-ID: <77a60ba0-91f0-05ae-d4d5-2675783e70f7@oss.nxp.com>
Date:   Fri, 22 Apr 2022 12:56:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] media: imx-jpeg: Encoder support to set jpeg quality
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220422015320.14600-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220422015320.14600-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::41) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588afb1c-02e3-4514-9cea-08da24465a45
X-MS-TrafficTypeDiagnostic: VI1PR04MB3104:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3104617CF4FA47C7E28E7D67CEF79@VI1PR04MB3104.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KYqViDqhhqnlL8c80CxJi/SORuY5iRuskIfLWweJLwJR9/fkCby0k1DC/VWL85KzaGDZUnpP6RYJnsRQJL/wRkHr+SUPFvx68hOw6W8TM9gYgon9dQj4MQl1Vmj2lqMCfXwkr0mEvm0qadDOJD7Ia60Qw+ZL/QXGXabneQf0cwFAy8HxN0VjatdS2Vf+nDllI8jZ47EajXFzQLM0XWSAkB7IMQ0BPoLa9+JxCNc2jhCR650/fnWcpXa5CPHIVqe2OC8Rke0flbUVSKO7E0vqFpDuV6ItCbHULbc3J/b3Uc7OqiBJA6H7US3u798nP2Zr5dswmbD7RROConWbmJj3qi0bQe855v/o9vEgP9y7+EKA07npOYb+NB59awksKR5Jl8+MJK4vvfW6KXTK8y3jjolxZkmYSuWGIPoU0NsgVuG8MUx8ogVXNipgblQNjJ+ucdZIm45FRMRKYCiF6cXk4+kY9cmLDwPrvqQVyzR2xEbKoHA3dP/TrBfdUYz+iwFKH+nJ3S4h6TN8bpPOFGXZUGP/Il/Ir0wgnHmG3rkgrOp/Y2RvWN3OEZiUK3fRHeo4YLEDmLhPBFMf5cNCtIBhbpsP+27c1sQuhDlvO6ZHUzI4AMn3Wz0SeLkpDJ6vKZjE74yDaHeMds0RB1nKOvPVg9C/4SmdcVLNpKJXN6fHuDby8SfW3tMXGAcMSbdSXcD+yyKgF/l2hNXEsVz6vkBR2kBkuEsLzzr3J0EtQMx7xa49lDfJ7DLjbeulaqepr68EPamZhM3VVX2dmP0dKDn6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(6666004)(6486002)(7416002)(186003)(508600001)(8936002)(31686004)(8676002)(4326008)(31696002)(38350700002)(83380400001)(38100700002)(6512007)(26005)(2616005)(5660300002)(6506007)(86362001)(53546011)(66476007)(66556008)(66946007)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUV5RVl3d0tXMXJBb1BkaEp3cERjTDRHVlpLdWI3ZHdSWXNmbldvOE9wZGtB?=
 =?utf-8?B?bHRpWUdKUExpVkNYRlprTTl3MlZLVmo5dzZLNCtGYnpjNlJFSy9hVXIxSVFO?=
 =?utf-8?B?bi9LSTY3QldHeTNRRitOL1BtQjJFL0FHOE5yNE1hakt2dnY4cXFuVG40RldZ?=
 =?utf-8?B?NVFzeUJydGtlMUJtTHNieTR5Tnp3UUNaSzd1L2lKU3d6Vmxua0d3ci81L3h5?=
 =?utf-8?B?bGcvRkQ0ZTJUYVJJS1hmaUNVZndhUFpCYUxhZk9DMExyVUcvNDdBdE16ZzNu?=
 =?utf-8?B?Sm0rQldscm5TZzJmU0w2aklpdkxIUzhxNm5KcUorakRrNEowdzMrZjhibTBN?=
 =?utf-8?B?bHUzTTB5aVdrVnJwMTN4RlBMV3V2UG1VVWJWTFk3MUFPQW5BMjl3UFBHRnZS?=
 =?utf-8?B?a00vQUdpZFJYYXlhQXE5dGpXWU9HY1dmRUxwMXJWcFhONmI1dVBqV29KbVI5?=
 =?utf-8?B?U09oTDRtNTJJVTQ1OGlMYlE4WjczWXR4QW91UlU3Vm5JTzNVV0hVN0lRckZz?=
 =?utf-8?B?VFdZUDhDNVNLclVPTEk0RDVqOHpaYm8yYlNadVcxWTgxOVdSdzJnallIQlVK?=
 =?utf-8?B?aldRM2FWVVZIK3h3TEFEakhUVzdNQ1NVS3dNVUl2TlUxR0ZNRVRuZjZRMWxH?=
 =?utf-8?B?MDVWMkhQTWdBQzQrcXNuZUJpVUlibTRvQi9lSEZja3ZaTkxINFUyL0RoQjNR?=
 =?utf-8?B?cWIzUFgybUlhenNTdWVFdGxLSGFRVDFZaTA1Y3RUM2Z6N1l1NngzZDlpZDdo?=
 =?utf-8?B?L3UwSGZxcEduWEhDd1czdk5zdXB6YzRlMGNZTWd4aVFiempqemxuNWdlR3lw?=
 =?utf-8?B?anM2alp5cEJqY1hwcmdxd0N6d1VtZGI1TzBHSVJJK3Z4Y1JTUklORUtjQTJM?=
 =?utf-8?B?M0lCR3EwWlM3cFNqb0QzcmJrQTI4Q0ZLUHpQZTBvWklJcUpXcG1KK3V4cVRr?=
 =?utf-8?B?cXZTZVVodVFYaHZlVDQxbHRDRWQzOE1MQ1ltS0xucDVaMXhtNWYyU0NYWU9T?=
 =?utf-8?B?ZXBkakFOVVREWm1yckhud3RLYktNYktGMUsrSUZZNTBZNVRQTGJ3cGtJUVZT?=
 =?utf-8?B?eGdtU3BrZkc4eGhuUVI3d2t2Q0xpT3hGRlFZYmZIVVozeld3OVE1c0dCZkJr?=
 =?utf-8?B?TldHdWx4SGk0Y29ZOVdVN3FyYURyMUI4a0Z1NldqQWR2U0FEUlRKSU9DUm5H?=
 =?utf-8?B?dklEbk9BZnJlQmRzTkJBLzAxYjZMdVh5SWlnQlVuOEtmZE9lTFRkUHBKbHhj?=
 =?utf-8?B?R3ZFK2MxVlpJMjkwZlRIcy9iVkxjRDA2cjdEQ3FtNmVFMzRJYWRkdEJNajZV?=
 =?utf-8?B?aC8wdlQ5Y0cvc2JtMDRadkU4RHpsQjREZ0VKM3lWYS9TM0h3MWxvWmg0K3dq?=
 =?utf-8?B?Tjl0MytEOVUvMkJEYzY5UHdIMUFhQ0JzUVNqVDZyR0E2NGdPVDlGWUJWekxU?=
 =?utf-8?B?SnhPdTlTSzFQb0FIRXZMMndHTnpkZ2s3eHNLaG1ETVFDYzN6M1ByZEI0Vlp2?=
 =?utf-8?B?WFQreUo2ajJkUm16Mk9xUmpGRUg0ZStHa1dBc3FKQ3I5SURHTExTeXdwd0x5?=
 =?utf-8?B?R2VCVm13bEgrSUlhSG5xb0p3WXAwK3hTNUtPbjlJRms5MWpkaUhXb3NqQkxN?=
 =?utf-8?B?d2hKcGxXNFc3YTM4bFI5dDlHVUhsTlF3dEFnb1dMdGF1NE5tendza21RVWJZ?=
 =?utf-8?B?T3pNWHo5WDdKU2ZEOFlmUnpUZFpWZEdIV2ltR2I4MlZWeUZtR3FHYjJkRVM4?=
 =?utf-8?B?QTRrcm5FQnRKZEtVaHF3S2NCdW9GT2RLMjlxS3IrYy9UazJXaVJvRkpzVGUv?=
 =?utf-8?B?VlViTDVpS25xWVpVZk9aZm9heFB0dXNzNk9JOHAwQ2lPVjZsK0pLYVAxSllO?=
 =?utf-8?B?UkdqRnl0aGRxNUdJbmRqdHNOZ2IyN3dWT1VvUDJPU3pPajcxd2pKTzJhSmZj?=
 =?utf-8?B?bUViemRpZlJPdTZXT3hJYlZDUEdvTVpwSzBLck00RFRHZGM5dERBVmFzWDI0?=
 =?utf-8?B?SVRIUVd6RXUrZHJIS0NNY1VHTW1uUlpxYk5ORXhWWDY5UVlUOUpLOThhUlVE?=
 =?utf-8?B?VTdmaFFNbEFFN1VOR0FRaUpuOTdFUEFpRU5IdzVpcnpCK0sveTRCUGxEK1kv?=
 =?utf-8?B?MXAwbzU0ZjdJUU9mQ2ZYd2Y5SXg3SjRib1JRVUNMWE1OZ2pUMEFQNExFei9C?=
 =?utf-8?B?VUdyVEhpWFViMG85MDhxS2tCdmJiSWE1WWJvQllsRklVWHBoMXhzc0ZuSUVU?=
 =?utf-8?B?aFk1REw0ZEtzdk1zME5TdUpGRzN6bEFDNFZwZHZTN0t5eGJXSld2QkRSWEtm?=
 =?utf-8?B?UXhBSlZNbWd4WUpCempIQ2pIYllxblFSMnZxVXFiV3l3b0JRanBHTzhMUTM3?=
 =?utf-8?Q?cHOuR0Ua0LOm1SmY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588afb1c-02e3-4514-9cea-08da24465a45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 09:56:21.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeYkM8l8Ow0MxnHj0S/0S9keo9JXYhr678bWQKvWE1ECUz1dAc/laHX7pAud5UFoMkss9vkcecYFfcVyx+Nc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3104
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.04.2022 04:53, Ming Qian wrote:
> Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
> to set jpeg quality
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
> v4
> - put the changelog in wrong place in v3
> v3
> - put this v3 information below the --- line
> v2
> - free ctrl handler if error is set and return error
> 
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 +++-
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 57 +++++++++++++++++++
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
>   4 files changed, 68 insertions(+), 3 deletions(-)
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
> index 0c3a1efbeae7..1bd245ba00e2 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -624,6 +624,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>   	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
>   		ctx->enc_state = MXC_JPEG_ENCODING;
>   		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
> +		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);
>   		mxc_jpeg_enc_mode_go(dev, reg);
>   		goto job_unlock;
>   	}
> @@ -1563,6 +1564,51 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
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
> +}
> +
> +static int mxc_jpeg_ctrls_setup(struct mxc_jpeg_ctx *ctx)
> +{
> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 2);
> +
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
> +		mxc_jpeg_encode_ctrls(ctx);
> +
> +	if (ctx->ctrl_handler.error) {
> +		int err = ctx->ctrl_handler.error;
> +
> +		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +		return err;
> +	}
> +
> +	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
> +}
> +
>   static int mxc_jpeg_open(struct file *file)
>   {
>   	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file);
> @@ -1594,6 +1640,12 @@ static int mxc_jpeg_open(struct file *file)
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
> @@ -1605,6 +1657,8 @@ static int mxc_jpeg_open(struct file *file)
>   
>   	return 0;
>   
> +err_ctrls_setup:
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>   error:
>   	v4l2_fh_del(&ctx->fh);
>   	v4l2_fh_exit(&ctx->fh);
> @@ -1962,6 +2016,8 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
>   		return v4l2_event_subscribe(fh, sub, 0, NULL);
>   	case V4L2_EVENT_SOURCE_CHANGE:
>   		return v4l2_src_change_event_subscribe(fh, sub);
> +	case V4L2_EVENT_CTRL:
> +		return v4l2_ctrl_subscribe_event(fh, sub);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -2035,6 +2091,7 @@ static int mxc_jpeg_release(struct file *file)
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
