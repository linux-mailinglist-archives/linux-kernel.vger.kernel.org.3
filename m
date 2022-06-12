Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A6547CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiFLWz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiFLWz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:55:58 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50077.outbound.protection.outlook.com [40.107.5.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7831DFA;
        Sun, 12 Jun 2022 15:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6zSMsKz0kDSUZozXJx06u22+1Vawza1sv0EM6Js6lDS/WBrhSSfzgyJac7doo2wBCD/g/TeArfavKKosNdfcVVTgDtryerPB4u5do1m7RcVEeMyVefSdjc8XuoxsoOgPXJE+BuKZLW/MrPA85OK27OwwwPuzhJxsAejQpPNuyDjO/6TEc47ZtI15nlDR4h8P2RQ4Snu5BxKhe5/UbQiDkdxsVKUhv4Z3wKbDFvZ9swGVAOrqWkuU16T/w2YtjII/aFzT8+mAzObvY6W/pGc4oL/yKDJsNCt9UgLK8yr2cfhMk+C10WCb2ZXL3RekUT+HnrwDwTVpujOvIq3V4zI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ssOjzLivbjJf8r+jQBz8mCy8a2eiS7Ws6EoGzjKYM=;
 b=nR0TC5rNSlU3tNccy183kLxpL2P3Rf+nG/SCH9y9XbrFN4bLs0acf1qxxeNXWICE32yZ3IN7S23P3bBficvnKT5XPvCGtiJhPFQmvxRtWROuoDtVT9dTZUaxKCh5YadG7EhMwm9x76/0JnXmWWOR+Pk+n6qPiypJ8zLbupaLJpNTaxXQymDvvVdtgywJQ/yyu/KOBiwer4Mx4btcVzucGJqMZI8xsShHXlViQo8Zf1TDYaTu66YqahcrBW4q7P2peOQuLz/1y1N3rlZcnBXpQO+/rFDp1JIWEL7hE4Uf4huyfm507dTESjPJZ1JcUpavdw7gNHneZmoheJMxlqqC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ssOjzLivbjJf8r+jQBz8mCy8a2eiS7Ws6EoGzjKYM=;
 b=JLHF3Ymtq02ErYDD42MZMkODhvXd/9jXzY9CrFCyH5O7gLTcxjwZ1NWCu++X3hr/J2W8SZjJgO/YsdcG6ubioi8Svl07geLrZc9dJGseNjeFJM9hVrEZxiz5PUHOlYXtZmoPFYyG4SsTm1aheQY05RcAmrOSWtiknoCcPg+LCxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DBBPR04MB7803.eurprd04.prod.outlook.com (2603:10a6:10:1e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Sun, 12 Jun
 2022 22:55:53 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::60ed:7367:9545:512f%9]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 22:55:53 +0000
Message-ID: <0859ab90-4cb4-a2d0-c3af-84a372742634@oss.nxp.com>
Date:   Mon, 13 Jun 2022 01:55:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: imx-jpeg: Align upwards buffer size
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220530074919.14982-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220530074919.14982-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0113.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::15) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead5b00b-35b7-4b41-2dca-08da4cc6b3fa
X-MS-TrafficTypeDiagnostic: DBBPR04MB7803:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7803B0A19A5139C7C3DDD1E5CEA89@DBBPR04MB7803.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzoXga7Xv6NtFpmOJbgnYGhVOSRelsZ7M/j/WRLQKa4LlHXIyzkAM0kDHqzU0KSiCmU8vqxhrccLj32SjNBXAaG4vRtr1aHJlmxq6OiGTQ3Tgu4M+yQflmi2c4K+79OJynhp8vS8NPS3pzSmwEzBzbiSZIowbb82MPjx/Ope5B8EIgjhXkZd9hGDQj0ubCVF0yid7QuttyBGAqB4pbZ4LoDU6SvCzC688U4sa5YhTH6HjCqHeEZPV4oXMtNCwlYJnNj2McAC29tv6hvLJw+8KkCbBGAiDOosJIV5gvXSsdU280enpxnwkPqUObn9TagT/q4tUjvQZRNtk5imFtTYTLwFqBxkoEeyQ2UZR5bYCyj+7zwbIJxig3WNIfvskyhcZv50FyxdibV923Qbj2680HQcCUydHHMpJlgiYie/qL1FTDHF0GkzOwwhYXwKdxZbhtBkcai4SVShSgvrPms4W+vZWDsaAHJBhmrqxWTmknC3aM0DjWwv6T0Sq/R+9MzDcIBHqEZKxE6SZf3+72Xb4bd3pyWbpBl3vsdViNBjPBPJgi3ezZ0vZrpMZMw08/HnEK04v+bsWK7N4V3OuOJJYq1ILF0sJYazN5ADQf3EuoJk+7F+Jj+VK6+O4b69JZ8XfMRzJnMzahQy3pF1o5KL936OLtifLgrbDWGT5Opr7Yy6lH2mw2AdBW6SzdZXrDasn3XAeffSTUi6Z2H6F819j2b6Xb5mj3P0h+ijnycUkDzRWAz4nS5osIZuODLmYSMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(31696002)(26005)(53546011)(6506007)(52116002)(6512007)(316002)(66946007)(66556008)(66476007)(6486002)(2616005)(86362001)(508600001)(38100700002)(38350700002)(186003)(83380400001)(4326008)(2906002)(8676002)(31686004)(5660300002)(8936002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlOUWh3cnRpYzR5bFhqQlNNVld0a3R3cHlTbTIrbHU1bERvTEtPN2xHSzFi?=
 =?utf-8?B?YmhFYnhYMEM5bldYQWZKOTFFTVNkMFRaWmJkTU5TUjh1MW0rU2VnQ3NJeUJX?=
 =?utf-8?B?cU4weHhxKzdhZ0EySGVNQzNGa1ZvRjhabTNuQVErb1RuckpBY3JCSWtWaHpQ?=
 =?utf-8?B?RjVDQ0ViRXhDdElUNEtDK0FzMGl6NDFnT0Y4anU4cUNvSEdmVjJ5VytQdFFs?=
 =?utf-8?B?QjVlTXoyR1BZRWdMYmF1d1U3UXpkYWNmYVgyMG8vZk9sbkwvcmtxUC8xUXpH?=
 =?utf-8?B?Q21TanVRSXpFQTNSRWpHMXplZFJNRFd3M2RoaitJYVI2enZWM0hNNFNnYllC?=
 =?utf-8?B?MFNOV0k3aml6c2pHa0ljcnU3d0ZucWNmanc1K09zZWMrU1NHNzl5QW5JbDFK?=
 =?utf-8?B?ZXFrSlNtWGZlMEtDSTczSlhOQjZQRTNzUG9BRXRoUTd6YkJBRkY5WTA5Ni8r?=
 =?utf-8?B?VXRTZW9qUEdIOElvYWEvNzJHSk03OHlPOEJqbUxZVE93K2tDbm1jSmU2U2No?=
 =?utf-8?B?VlZBZ283ejhHVUtOYk5ndWViSENFY3FlVDJjRzZTVFFZTkJNaHBBM3RiZVZD?=
 =?utf-8?B?OFEzNXlnY3QwV3hGcitDQlBEVzZZU1hvWDlJY1J1WWRHSDAvUE13a2craEJH?=
 =?utf-8?B?SmtZRThMYmdmbGxkL3JNL0xVU0dOYUNOTGN0eVpOWmdYb2V0Wm5US0k1WTcx?=
 =?utf-8?B?akJNZ1orNkZZczNzZW92Mm9xMmtxV3VhYVc3Y3lCRDEvOTJzN1J6R1grQzBR?=
 =?utf-8?B?YmV3T253TzgzTWQ0K0d4Mml0cnFsa3o1Zjg5dks5Mll5UTBUd2p0cUs4bTVn?=
 =?utf-8?B?clR0bXR4YXJNOXBsbTJUZWw0VXMwWnZTRzJJQUpYb2Y2cVpGV29lVEw1bmcx?=
 =?utf-8?B?Y3Z1d000L1VjQkM4Q21WRnUraXE5WkI5ZHc4Q3I5Zm56S25QaGlPUmkrZXdp?=
 =?utf-8?B?TUhzQ3Y0YzJNeDB2ZnZTRmgvTi9iaEJEUHE5djZTeDRLQUcxQmdGSDAwZ25P?=
 =?utf-8?B?ZWZBR2FOQ1BmdFlpOGIxYmpyUHBKUmdWcU5YRjJmblBSQ3c2UnozRDg0YXB5?=
 =?utf-8?B?M1hIZFA5dDNNZTJzVkxYYmpWZDd0dXlHT09vZ2NQZzQ3Q3hIeGNQaHVYKzRZ?=
 =?utf-8?B?V2tFcjRFc1huUEQzcHRlNW5USzlWSEdPbWZqT09oUnlpWldlaHBPSm9PZEw4?=
 =?utf-8?B?eVRHVE14ZEl4V3RmbjRodlpzRHZCVTRoT2x5aVVUTlZ6Nzk2aGYzbVdFYUt4?=
 =?utf-8?B?Vnphd1hKRy8rcHFFdkNiZ1l1VHk1UWIrNFMwSjg0OXhjSG1UTU8yMkNQVXMy?=
 =?utf-8?B?bGVrQ1A3VHNIUUtrc0Nxc212WEVRK2RBWVJLZGZHZGFEcGIzVW1UdGVJRnVU?=
 =?utf-8?B?MVh5UFIxdExSSmM2UHp6UXU4SG9sUDRoZlhIaUM2WndxTXZQTFlpVHE0U0k3?=
 =?utf-8?B?dmptR25Ic3RHNEprMEtlc25UM1luNXRpWEl4TzVZc0U1M0IrMWc4d3JXcE5J?=
 =?utf-8?B?WEFLYmcyNUZyWUpTem1vcFRKaU13UU5heE4yTEtNNCtHazkwODdJUi9rNE05?=
 =?utf-8?B?QmRqMWlkYndVUGlDeXExTnFZZks1TkgzTm1JRk0wTXdiQTFkTlkrYXFvVngr?=
 =?utf-8?B?SWlqZnA0MGU2dHZOdndGbFp5UnpDa0lrakxkakJqSzRrOXZ5bVh3NWY1Uysx?=
 =?utf-8?B?czJWZVEzZlRPTU9SQjlQWDNwcUpmdlNzR0E0bXdFeG15enM0MU9RWjVRT1Zy?=
 =?utf-8?B?VEVtMXB3LzlvSEVjWkJKdjFDUEFRR2FvQXRCNnZTKzgzWERBbWw5OStDT2t4?=
 =?utf-8?B?QStkZG56TGtsRW0wa1B6L0VVVytWODM5RDZseUI1clZsLzdXUlNQTE93TUQ1?=
 =?utf-8?B?dVdDdFp6MVk0U2pzWlZXcU0xV1o4S2M0dmdmK3Q4K0h0RDZENzAxYkJNdkdU?=
 =?utf-8?B?YThuUVRsVHhHNTR1bk9EUHJ4N3dLN3hDRXdQWEJzN3RSb3VBVlp5UXBnNzBM?=
 =?utf-8?B?OE9WZ2tzOVg5ZjRIdXpPMi9MQVN4MGNGK3g4UENnVjhPYktuRTdia29OZlE1?=
 =?utf-8?B?UStjS21TRnptWTlReFd6VHJyMmQ1OHQwK3g1cXhNM2o3NStFbTgreHV0dzVY?=
 =?utf-8?B?a05uSUNUeWM1TFAvbWlGbjhRTlJJVHdVMUNNRHRoQVd4c1ZxWjYyZU1QV25O?=
 =?utf-8?B?d0ZsTG9SellYWmVWWitVL2l2NVlGZzlBc2FLTlA3MnErYytsK0tDZFptQ2FS?=
 =?utf-8?B?NnYvOHZNd0s2Q0x6bUlCaXgzWUx0bklGdFA4aTZsSzI4dGRZNGxXdTRtSGF2?=
 =?utf-8?B?VmZ4L2JXNGtmN2Vva05XVEUzbGFKRzRma25qTHFvS3FkVXpPdkdPenJXR0tt?=
 =?utf-8?Q?G85Y5DYVvxhSpapM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead5b00b-35b7-4b41-2dca-08da4cc6b3fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 22:55:53.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+zhNN4hH+ZpbzHXHB7hEHLtdMThglOp4AERYwodwrKfVsWigD/M64IYOdudxLSwr293aprArNQ1TeEld6CF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7803
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 30.05.2022 10:49, Ming Qian wrote:
> The hardware can support any image size WxH,
> with arbitrary W (image width) and H (image height) dimensions.
> 
> Align upwards buffer size for both encoder and decoder.
> and leave the picture resolution unchanged.
> 
> For decoder, the risk of memory out of bounds can be avoided.
> For both encoder and decoder, the driver will lift the limitation of
> resolution alignment.
> 
> For example, the decoder can support jpeg whose resolution is 227x149

I doubt 227x149 is working. I have tried 127x127, with your patch 
applied, both on encoder and decoder, the image does not look ok. The 
126x127 seems to work. Having an odd resolution seems strange, I see not 
even gstreamer supports it (tried videotestsrc & filesink with BGR, 
127x128 produces a 128x128 size).

We need to gain more clarity on this one.
And when we do, if we really can support any arbitrary resolution, from 
both the jpeg core and wrapper point of view, we have stuff to clean up.
The assumption that I started with was, as stated in the comments:
  * The alignment requirements for the resolution depend on the format,
  * multiple of 16 resolutions should work for all formats.
  * Special workarounds are made in the driver to support NV12 1080p.
With h_align/v_align defined in mxc_formats[].

Regards,
Mirela

> the encoder can support nv12 1080P, won't change it to 1920x1072.
> 
> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v2
> - add Fixes tag
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 88 ++++++++-----------
>   1 file changed, 37 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index c0fd030d0f19..9a1c8df522ed 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -894,8 +894,8 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
>   	jpeg->slot_data[slot].cfg_stream_size =
>   			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
>   						  q_data->fmt->fourcc,
> -						  q_data->w_adjusted,
> -						  q_data->h_adjusted);
> +						  q_data->w,
> +						  q_data->h);
>   
>   	/* chain the config descriptor with the encoding descriptor */
>   	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
> @@ -977,7 +977,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>   				      &q_data_cap->h_adjusted,
>   				      q_data_cap->h_adjusted, /* adjust up */
>   				      MXC_JPEG_MAX_HEIGHT,
> -				      q_data_cap->fmt->v_align,
> +				      0,
>   				      0);
>   
>   		/* setup bytesperline/sizeimage for capture queue */
> @@ -1161,18 +1161,30 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>   {
>   	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(q);
>   	struct mxc_jpeg_q_data *q_data = NULL;
> +	struct mxc_jpeg_q_data tmp_q;
>   	int i;
>   
>   	q_data = mxc_jpeg_get_q_data(ctx, q->type);
>   	if (!q_data)
>   		return -EINVAL;
>   
> +	tmp_q.fmt = q_data->fmt;
> +	tmp_q.w = q_data->w_adjusted;
> +	tmp_q.h = q_data->h_adjusted;
> +	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++) {
> +		tmp_q.bytesperline[i] = q_data->bytesperline[i];
> +		tmp_q.sizeimage[i] = q_data->sizeimage[i];
> +	}
> +	mxc_jpeg_sizeimage(&tmp_q);
> +	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++)
> +		tmp_q.sizeimage[i] = max(tmp_q.sizeimage[i], q_data->sizeimage[i]);
> +
>   	/* Handle CREATE_BUFS situation - *nplanes != 0 */
>   	if (*nplanes) {
>   		if (*nplanes != q_data->fmt->colplanes)
>   			return -EINVAL;
>   		for (i = 0; i < *nplanes; i++) {
> -			if (sizes[i] < q_data->sizeimage[i])
> +			if (sizes[i] < tmp_q.sizeimage[i])
>   				return -EINVAL;
>   		}
>   		return 0;
> @@ -1181,7 +1193,7 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>   	/* Handle REQBUFS situation */
>   	*nplanes = q_data->fmt->colplanes;
>   	for (i = 0; i < *nplanes; i++)
> -		sizes[i] = q_data->sizeimage[i];
> +		sizes[i] = tmp_q.sizeimage[i];
>   
>   	return 0;
>   }
> @@ -1381,11 +1393,6 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
>   	}
>   	q_data_out->w = header.frame.width;
>   	q_data_out->h = header.frame.height;
> -	if (header.frame.width % 8 != 0 || header.frame.height % 8 != 0) {
> -		dev_err(dev, "JPEG width or height not multiple of 8: %dx%d\n",
> -			header.frame.width, header.frame.height);
> -		return -EINVAL;
> -	}
>   	if (header.frame.width > MXC_JPEG_MAX_WIDTH ||
>   	    header.frame.height > MXC_JPEG_MAX_HEIGHT) {
>   		dev_err(dev, "JPEG width or height should be <= 8192: %dx%d\n",
> @@ -1748,22 +1755,17 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
>   	pix_mp->num_planes = fmt->colplanes;
>   	pix_mp->pixelformat = fmt->fourcc;
>   
> -	/*
> -	 * use MXC_JPEG_H_ALIGN instead of fmt->v_align, for vertical
> -	 * alignment, to loosen up the alignment to multiple of 8,
> -	 * otherwise NV12-1080p fails as 1080 is not a multiple of 16
> -	 */
> +	pix_mp->width = w;
> +	pix_mp->height = h;
>   	v4l_bound_align_image(&w,
> -			      MXC_JPEG_MIN_WIDTH,
> -			      w, /* adjust downwards*/
> +			      w, /* adjust upwards*/
> +			      MXC_JPEG_MAX_WIDTH,
>   			      fmt->h_align,
>   			      &h,
> -			      MXC_JPEG_MIN_HEIGHT,
> -			      h, /* adjust downwards*/
> -			      MXC_JPEG_H_ALIGN,
> +			      h, /* adjust upwards*/
> +			      MXC_JPEG_MAX_HEIGHT,
> +			      0,
>   			      0);
> -	pix_mp->width = w; /* negotiate the width */
> -	pix_mp->height = h; /* negotiate the height */
>   
>   	/* get user input into the tmp_q */
>   	tmp_q.w = w;
> @@ -1889,35 +1891,19 @@ static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx *ctx,
>   
>   	q_data->w_adjusted = q_data->w;
>   	q_data->h_adjusted = q_data->h;
> -	if (jpeg->mode == MXC_JPEG_DECODE) {
> -		/*
> -		 * align up the resolution for CAST IP,
> -		 * but leave the buffer resolution unchanged
> -		 */
> -		v4l_bound_align_image(&q_data->w_adjusted,
> -				      q_data->w_adjusted,  /* adjust upwards */
> -				      MXC_JPEG_MAX_WIDTH,
> -				      q_data->fmt->h_align,
> -				      &q_data->h_adjusted,
> -				      q_data->h_adjusted, /* adjust upwards */
> -				      MXC_JPEG_MAX_HEIGHT,
> -				      q_data->fmt->v_align,
> -				      0);
> -	} else {
> -		/*
> -		 * align down the resolution for CAST IP,
> -		 * but leave the buffer resolution unchanged
> -		 */
> -		v4l_bound_align_image(&q_data->w_adjusted,
> -				      MXC_JPEG_MIN_WIDTH,
> -				      q_data->w_adjusted, /* adjust downwards*/
> -				      q_data->fmt->h_align,
> -				      &q_data->h_adjusted,
> -				      MXC_JPEG_MIN_HEIGHT,
> -				      q_data->h_adjusted, /* adjust downwards*/
> -				      q_data->fmt->v_align,
> -				      0);
> -	}
> +	/*
> +	 * align up the resolution for CAST IP,
> +	 * but leave the buffer resolution unchanged
> +	 */
> +	v4l_bound_align_image(&q_data->w_adjusted,
> +			      q_data->w_adjusted,  /* adjust upwards */
> +			      MXC_JPEG_MAX_WIDTH,
> +			      q_data->fmt->h_align,
> +			      &q_data->h_adjusted,
> +			      q_data->h_adjusted, /* adjust upwards */
> +			      MXC_JPEG_MAX_HEIGHT,
> +			      q_data->fmt->v_align,
> +			      0);
>   
>   	for (i = 0; i < pix_mp->num_planes; i++) {
>   		q_data->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
