Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4215548BCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348298AbiALCJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:09:13 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:11588
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348262AbiALCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:09:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V15EaK3i19yRjYMFbt7uXtzkNwzbva8iQkRIvpol97dVJvZRq++nDTIa+NAcQ+8huEqZOvubmuMZ4NMJF1a3xdGGMQ0F3SNKCcl0BvkHWaMbUKuFk1WTgzgDwC1ebsYtlsuMiE7pDDZ53sOdXdvxMan5KNuxC9g0j5TVeGcTi2YgJsxLxNM6a58bLRMo3Nq1qbu3icaXXpHmWUOa56EJeF36kuEvcmqXVEpZ5tpT78lXJACWa9kRmIPrLaVd7kMKPgUX6p291cNJ82m+FcoAZYnGDqJb5ld4KxJeEsoei/8TSlHwoIs2KuyoZ3bXQKxGmqiGt3i09xvde3gEGoAjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmdAJYfqeMKNGstI+XrSayZQH6LF8twyh6xVH1weY4k=;
 b=hi4Wur+Xazd5j6+lIQOE4l9c+e0aFoKxLpG2up+DA6kc0w+UGfynYQk1VmBbEeFI2KN7ziAtrFQXCruSObJbuq6hYVQhRodYWChngRwy9+AWn7/7sa7bk2UfX+fr2hiX5SLeUXJwb2JcFN821OqrBLqyVMLr1ZKHPOmXk7Zbmcpb6+2rqEKtrjh90K8D23LXnUzPtL0h/gfCCWZv0cAgHczlvj/UntqpEwxdIsuI2WOg//jBkT0TLnBnNLbjSr5ihvuHstJwEyviBi7SOtuWCXZxc6Nl5hmqP1T77ZJLXUvEJNIHXWcGWKX97l8/rmDmNeA7dNXvrnndsnZt3jmuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmdAJYfqeMKNGstI+XrSayZQH6LF8twyh6xVH1weY4k=;
 b=RWVZCdt5h38NVvD5MYMBgzCruU5RETmbFiypquQNFRGwTCSE93dn3532mw8f5hBnOyxWohnVocryiPrp3DPZfkoc8Gl1Jxh+Rpk95wE8ACi3hl2wWnGLdvVrlBRYjzF909ob0pliTebYfK9bLz3FmUL0GFn9PF1mEySgF70sMU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by VI1PR0402MB2783.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 02:09:06 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::698a:af10:114f:2487]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::698a:af10:114f:2487%12]) with mapi id 15.20.4867.012; Wed, 12 Jan
 2022 02:09:05 +0000
Subject: Re: [PATCH v1] media: imx-jpeg: use NV12M to represent non contiguous
 NV12
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211224030241.4624-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
Message-ID: <9a1a19cf-b6ee-16bf-6e9e-195df5b47ebf@oss.nxp.com>
Date:   Wed, 12 Jan 2022 04:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211224030241.4624-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad2c962d-5d19-4aaf-ce79-08d9d57082a7
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2783:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB27831B4154AE02D170893BF7CE529@VI1PR0402MB2783.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDYTvIuUtu8y2o+ANRuUJdAkoqQMZ86hNtbxw9cki4E4FLDZNliu6QEjvt5bF3VNlgGAmkgsvcG3Tbktq1NIPxlYbVRFU/sjOOKDNfxO686FR84Cg4+2LEFt5566dzxI7j/ZXp0XXaMGURsVb8RP/7oSqGkNH1G53kA8eJTwevsnyrUnd791dlDJjSNEs1nuhQxWps6n1G+6iwn11AHI2kQPIgwtAvyc3jauJoIIgXRKU+T+JH19WwqI+BaPIxk9lXbXBJvhgNvsXdPPe6iHOF8guzIUJGTx7goP8uNRDkCQwuTZHFBxYSeEdkGgmQMuPf3x/uzu08cc1Qjs7YPUi6ZVML56Mt+bgQG0nEPov8dIb6OWcvVpIvuP69Cjf14woOFsJs0B+mJh5t/OqJDcOaC/ZnJkTKUB5PYTJkkKiOixvb4VJotnXFebk9hpBHi5l7ulyYrlEDEl7GoUcT/VTyHD2anyLAvzzKbgAn/lLfX9zXPzHf86XrC8+UiNOGK1bk9yV04EAj0Cqv3pmHAuHdeSeSo0vSCO67RGjG8fCdXIX8REOQ9GmhOfxjrMAZbNVzyCSnm2LRi/RMBy4HBbYSXfs8dcA6qB3sioDtwJ+Ildtv4IWAjfJhQgSAf3nCt9zsQx3Dg+qDjGSv6CMtAumRMSeL2u/MeIS9MNU4A3o4ZB3Du9x8DJST9yV1hl5Pj2St0Tj7SYd2+JBZkhOEcfreFOZsyp034tyNRguY/rNz7NQY2XpJqJBbl1nJOjn4wReCSWHgC5Pze4c0bRmxOJww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(186003)(38100700002)(26005)(52116002)(316002)(38350700002)(6666004)(31686004)(8676002)(6506007)(2906002)(4326008)(66556008)(83380400001)(66476007)(66946007)(53546011)(8936002)(2616005)(6512007)(6486002)(31696002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXMyR3cvZGUyQ0tOay9oZm55NVdjS2RyN3NIYlhNL0h6L3hqTXh1VnpkNzBP?=
 =?utf-8?B?R2MyaDhKanJ5bWl1UnlFbzVpY0kvN3ozaFh5M0VySGhjWDB0bXhDZ216TVhy?=
 =?utf-8?B?K3JvSnFWUTQxWm5wWkRnZVVLZk53cno0Qml6cndlRFFiQWMzS0x6UHE2QUEw?=
 =?utf-8?B?SU5uTVV5YzZqOHI0cTl5OE94K3N5T3Rsa2ZnYmNtczJIUzVUZ0o2QU9NK2xK?=
 =?utf-8?B?Z0lvbnh6UCtjZVU1b2lJbkJGaE5Zb0N4V2NqS0x6VUtJM1dlUnRCVTdMa2Nj?=
 =?utf-8?B?SjZFbXM5NFBpSVNXVVVHVEcwbVBrZG5oRkR5emRCTndLYUpTZDRCR2pUZWdU?=
 =?utf-8?B?K2t2R0FFRXdpaUZXeWtUMmtzRG56bGVIeVJRcjczZ3JaUndORGpGaExrTVBl?=
 =?utf-8?B?MENPZGpSSTdqZnJPQUkyWmJVZkNkRDJQd1RFOWlvSy80cTN3SWNTK1M3RkZX?=
 =?utf-8?B?MHVDcXp5cjJjR21vSkJWYXBlbExsWDNUdm9FTVJHaU1URXE4bTFQYWxhR1VT?=
 =?utf-8?B?WjNMZElxdHVyS0Rqc1E5TkhxVUhsUTdGTXMwZloxQnYxWTNZRnRHVVkyOWpI?=
 =?utf-8?B?Zk11ZmtLNndGOFU3ZjJ0cWtmcDliR3M0R0lQN1BxbHNuMDQyOTVGNGQybEUv?=
 =?utf-8?B?c2xRdmROYUNDNVdjSkNkbnJoTG9jZ1ROYUxUSTd3d2ovRVRwUVp3NUdXTEFs?=
 =?utf-8?B?K0xTQVZLT3B5WjkyVXdqZTFlODhuTzduMFZNeFBjMFBwQjNYYm5IdldMbHJo?=
 =?utf-8?B?bHBITUJFck8xaTdrMEtIVjhyVnRVb2tjNHdUVm1nMXFkelZ0MDVQd2tubWdV?=
 =?utf-8?B?UWtXbVdTbXlHd1dEdUc4TklockszTVJEMVVRQkVYaUJwc24xN3B1UDBVdk5K?=
 =?utf-8?B?RDl5ZVRMU0dieGVZcUZpUjdDbEl1R2w4UGhQZ0xqeVJHMlRpQS8vM3IxcDZS?=
 =?utf-8?B?NmkrcGUvS0hndXM1S3czcG50SU8vbktad21yU0I2Z3JRc3NmTHN3Nkx4dlpZ?=
 =?utf-8?B?YXZFejNKb0RyNUJxV1ZDSG5uWERyUEhWNExUdXRLTkRLYmQ5amYyZkZUMXFm?=
 =?utf-8?B?RXFLVllVNlBwUjJqOWhnRzE5SFJ5SzRJc3JyNkJncUI0Y1IzNEhYRTJiNDE2?=
 =?utf-8?B?RUtnOTlOMFkyZGIraEo0ditkTkhUL3lSaElOV0cybkVwbk9aNDQ5YWpWLzdI?=
 =?utf-8?B?MUlDU3c1dUFvUDF1c0NGdll6anh6dVhUVnYvM2QzSVJkUmhjLzVkWEYvUXpP?=
 =?utf-8?B?eGxTaFBwUGo0UnpNcEY5UForcXZxdFdxQkE5bmRJdmMzRGxZMXQzeCtyUklH?=
 =?utf-8?B?TkFXZ1B3Z1B4K2U3RW5KREhFTFF1VG53TlNiWktxamxRZ2traDVhUFhTOExT?=
 =?utf-8?B?TEZoTWkrQ2wxUWpNRjRoTkZrQThBVDNUZmpPckxTQkxSMXBrU0VuL2dWdEtQ?=
 =?utf-8?B?SDdFcWpjaS9IRHR2ZUNxeXFlUEtPWUhibXBJMWNJWHJ2SnNKRk1Qc01ZTkVY?=
 =?utf-8?B?VCtxZE80SXQ4emxsOEZxQkQ0ZnZSYURjUHRGZHlkT3h1SVZ4RkM2aEYzc1hD?=
 =?utf-8?B?c3BnMGNGU2JUTzFwbElCUEVpcllBS2lZUVcyRG1jcUFRdzVQOHZOZkV1OHd1?=
 =?utf-8?B?eWlNNDV5QnAzOERLNkNycEh1T0E5aGs1dEJZVmU0VG9IVFZ5VVJnYUpKWVVj?=
 =?utf-8?B?N2lBTzBZWldHMG96RVhKSjlpS2lxTld3UTl4MzFqdHhXWHlYYWI1L01jamcr?=
 =?utf-8?B?VFVaWnFUVWxKZEc2d1FPZEJyQ0ZleDBxTk42dHJ2UmNpT0xVM1Evc1ZKVXJa?=
 =?utf-8?B?STRIWURQL0YwYVVZS2M4ZG5XbkVTaTFSUy9vYWRueG1SSUtUU3F0L05KSWlE?=
 =?utf-8?B?SVpRRUwzUW14MkdsODNkTTFXUWJhUHRxQS9hUzljVFJpbzR5eXlKZXdsTXB0?=
 =?utf-8?B?WnJxUjl0L2lSdStTTjV4WmllTjhaTXJyazJVZWltTG5DbjlNMXVLVlVQN3RN?=
 =?utf-8?B?bXBnUlhUWDBIcWVSOU51VXhhdUNFMHg4Y2VFVlRIQURWc0YrUXJsM2lqQzdz?=
 =?utf-8?B?b0pMQWpaZXc3b1JZQkQxdVNJY3pmVStBZ0pVbG9CMHp1MVF6TE1UbXpGRElw?=
 =?utf-8?B?ay9MVlYyb1g0aTdCWHNPOVkxZDBwMndLbW9xNkJxNXJzanZiNjRpcDhYWXlZ?=
 =?utf-8?Q?gIkc49IM5+feG734Hv8NL/Y=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2c962d-5d19-4aaf-ce79-08d9d57082a7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 02:09:05.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrPrpeddF44wBiRbpxl49MW+cNv0gna/uO1MSM9xrPScgqqeD7krtRq1HODBsntMuteHpLQimvSQq6kQIrZvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 24.12.2021 05:02, Ming Qian wrote:
> V4L2_PIX_FMT_NV12 requires num_planes equals to 1,
> V4L2_PIX_FMT_NV12M requires num_planes equals to 2.
> and mxc-jpeg supports 2 planes for nv12,
> so we should use 4L2_PIX_FMT_NV12M instead of V4L2_PIX_FMT_NV12,
> otherwise it will confuses gstreamer and prevent encoding and decoding.

I missed some typos here:
and mxc-jpeg supports => Since mxc-jpeg supports
4L2_PIX_FMT_NV12M => V4L2_PIX_FMT_NV12M
will confuses => will confuse

For the patch contents: Reviewed-by: Mirela Rabulea 
<mirela.rabulea@oss.nxp.com>

Regards,
Mirela

> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> Reviewed-by: Mirela Rabulea <mirela.rabulea@oss.nxp.com>
> ---
>   drivers/media/platform/imx-jpeg/mxc-jpeg.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> index 4ca96cf9def7..7c0366f5f801 100644
> --- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> @@ -96,7 +96,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
>   	},
>   	{
>   		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
> -		.fourcc		= V4L2_PIX_FMT_NV12,
> +		.fourcc		= V4L2_PIX_FMT_NV12M,
>   		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
>   		.nc		= 3,
>   		.depth		= 12, /* 6 bytes (4Y + UV) for 4 pixels */
> @@ -404,7 +404,7 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
>   		return MXC_JPEG_GRAY;
>   	case V4L2_PIX_FMT_YUYV:
>   		return MXC_JPEG_YUV422;
> -	case V4L2_PIX_FMT_NV12:
> +	case V4L2_PIX_FMT_NV12M:
>   		return MXC_JPEG_YUV420;
>   	case V4L2_PIX_FMT_YUV24:
>   		return MXC_JPEG_YUV444;
> @@ -673,7 +673,7 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
>   	_bswap16(&sof->width);
>   
>   	switch (fourcc) {
> -	case V4L2_PIX_FMT_NV12:
> +	case V4L2_PIX_FMT_NV12M:
>   		sof->components_no = 3;
>   		sof->comp[0].v = 0x2;
>   		sof->comp[0].h = 0x2;
> @@ -709,7 +709,7 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
>   	u8 *sof_u8 = (u8 *)sos;
>   
>   	switch (fourcc) {
> -	case V4L2_PIX_FMT_NV12:
> +	case V4L2_PIX_FMT_NV12M:
>   		sos->components_no = 3;
>   		break;
>   	case V4L2_PIX_FMT_YUYV:
> @@ -1183,7 +1183,7 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q,
>   		/* bytesperline unused for compressed formats */
>   		q->bytesperline[0] = 0;
>   		q->bytesperline[1] = 0;
> -	} else if (q->fmt->fourcc == V4L2_PIX_FMT_NV12) {
> +	} else if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M) {
>   		/* When the image format is planar the bytesperline value
>   		 * applies to the first plane and is divided by the same factor
>   		 * as the width field for the other planes
> @@ -1215,7 +1215,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
>   	} else {
>   		q->sizeimage[0] = q->bytesperline[0] * q->h;
>   		q->sizeimage[1] = 0;
> -		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12)
> +		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
>   			q->sizeimage[1] = q->sizeimage[0] / 2;
>   	}
>   }
> 
> base-commit: 68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c
> 
