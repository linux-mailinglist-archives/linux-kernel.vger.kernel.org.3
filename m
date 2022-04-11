Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B94FBB56
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbiDKLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbiDKLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:52:32 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30048.outbound.protection.outlook.com [40.107.3.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550D741FB9;
        Mon, 11 Apr 2022 04:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK5QGDrNQTids4pdVVY2AizpEXi/4qyIdjt4qf+oNY3THycgLGm5HoVWz3Dec8X9JtLknYcUNepmVa2bzYhITCaCgSwRiphUI3cDW86LaetnKQlPx/Lar4QMOc51ToRZMY+0U8PXbPbGM6V3KDzi7xyaQxMWPP7M0D8fVyiZownjTASNP56ddnyMvzZCvA9zGpkEqvRfoTnxy1g9hlEF7+lEfWXW99ikQXOLn6VDI+wcpS5cPV+qSKNBc+CK2rOv01YXqkvwKUehHEh3NDJu9PfbIYTO+NDWXQLkKZTrRlNn7cQd0LStxbIu8l0riPjR22vtlt58jpmhR5kGCfy82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep1xbJpaZhS9xBMwdQOnBPyBT6fCerOCpo5HkkJ8LO4=;
 b=hAU/N1w+CgI0zZIHcYHxWoLKQxgfzvex1KjSJuzVufsvLyAKK+GPrrLXGteH9uDluLUEHW4q1qRPD1FjoIbh+VjDnvpI0y96kV+JH3SMZBKnKOwYDsycTWfKxzOx1V41vGNmXVBxY6aS89rXl9dJyyK2MPaWbVmQWhzSUXUeGznf7u+xhLo2tnLazHOZ154iqIHcBgCNnHnZoUqsJvWwX5KSvfmV3Ie6yItDvgVHgCWYo26lRH1cd8fC+bh2ZFHh8aGUaXZOCTtekSAPhQyMrl1RhTSRetC8M4aqv2+d0M4qby9qRwivnY0ETv/pYfySe9S89vBVSw61YDqQbbEubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep1xbJpaZhS9xBMwdQOnBPyBT6fCerOCpo5HkkJ8LO4=;
 b=FWTxXNZPLu3UgieRlVz6nt8cPoLBitu7IhVDxfAaZtrN4TB60y7RY5eBuZ3D77BYrOomfaqN/L/E0ue4Hth9dYFHUoqBm0LZXcJSpIHg7c8huYb+b4qPi6DCHVmbYN0flpv6T5FXHfO5HmH4XLzp4ucPIcZJP7Rxi2tXUjg+0F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:50:15 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af%5]) with mapi id 15.20.5144.027; Mon, 11 Apr 2022
 11:50:15 +0000
Message-ID: <76cc3643-db74-607a-a6b9-c5e0d10081e3@oss.nxp.com>
Date:   Mon, 11 Apr 2022 14:50:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/5] media: imx-jpeg: Propagate the output frame size
 to the capture side
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1648023273.git.ming.qian@nxp.com>
 <473edd5666b24a659f651ca003add12ac9a0c2d2.1648023273.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <473edd5666b24a659f651ca003add12ac9a0c2d2.1648023273.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::14) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b26a3e-9f13-4155-a571-08da1bb17145
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6900EC30EBF8AFB49030311FCEEA9@AM0PR04MB6900.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGw3JDpyRKdEKPGHQ0pwPC1cBVW4vZBkaLfo7Us8vOJQsME9X3ieagHWwieOUg6QGBsJOZ+bgT4Wmm8tFwLUFFyrLFIWoe1HnVjmH5ivlB/Y82tMgP2muzo3ueQi9M6/HJ85b4SEtvFiadXwgZHrVrVIUlH7ZYRHEqa8WXqxwr+iZHMN1Pn5V6B1nqGzd87UW0yBrWR4Z9axydO14Re4XA2OhEDdY4bhtg6NLPFYClpUyjo2xEbl4hAMAx87RWIztWLkmwf1rRl2f9tqm3uxsnSiBch8QvC7CX2tBJPhuOsvMwrZaQMtY1ETeFulUoy63idjyjYPAPTjsOTAEcJ98xMsdxtRjBDyDDmys7SPPepbje0m0B9NhnCa9ba5Z/TimdBYCx005mR+PCI2qHBp8K0MF9cnkeUCooI5btcEpvxUaWMIwqRyOP67XrulXplkEkRke0UPjQvIQxwojhc7ZOj+Pjr+G6Fkg5wgE3UqosH2NzeWqIfXQiiMRoVtxty9TQiKlBlSxPdInCfzXKyTQO9tonmwWba8I56AL8ntImx806RHwxooxqQO/3r3+QtXD+qLBLsq/sRS70GhThxwTlfRRoxMDIh98fE8F4NfojeC03ZRWaMBiEtQmBMjqzXIXsPNfnBtHS0NS8xyYEpYb8SkzG7lLzMjA3bjw/JkuvvfppVog5rEEFLkCBeFen0ZYGFU45rBw6peefOazID61NDFRPHQACjbnwdHAt+yrb18iFDpAyhsIG0+guGZHE5gWSJgSfvdG1C+Imvg4laqRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(5660300002)(2906002)(8676002)(66946007)(66476007)(66556008)(8936002)(7416002)(53546011)(316002)(86362001)(4326008)(38350700002)(6512007)(52116002)(83380400001)(6506007)(186003)(38100700002)(2616005)(26005)(6486002)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk9BelNkK1dUVkEzZWVWWmZQVmwzUWsrYVN2TFdEYm1QRTlPOHVDemw2MFgy?=
 =?utf-8?B?UE02cVcvS0FTKzVJLzlmVkNoVEtqSE1rdm41akt0QUQ2YnBFUStPOXVPZnp3?=
 =?utf-8?B?OEg0dnZHZWJiQkIvNEFYSmVCWHFIZ2QrdmszSnkvclNIZ0JsMy9kellSdFI4?=
 =?utf-8?B?bG9XY0llYjBCN3NpcCtyamIxaHFndUxjcjRvOWhDUVlhSFdwWHlNVFljdXgx?=
 =?utf-8?B?UGZQb0JVVkZxc3RXaVN4ODRmcnZic1JUQTJ6TURaaWVsdXp6ZXdtaDJTV2Fo?=
 =?utf-8?B?MFVsa3BBbStPNFQvdlZ2djlaQ0VFMWhlRW1FQUdIMUlhVXdiVTNSd2I3SlJW?=
 =?utf-8?B?OXR3bDZOTnkrR1MxUnN0RGNNUGgvUlhlVUdtdHlKMnhVaW9YakcrTUpsK2Vl?=
 =?utf-8?B?Mk55Sk1KeWZDNjVScW42RlNVZWQzNDNuTDBvTFNraFptWUoxcTYxNDJnK0ow?=
 =?utf-8?B?WmdPYVl0cUhvSm1kaFgzNGYyN0JlMlRXeFhyRUk4cmMyRmhHLzBiaTZiVmZy?=
 =?utf-8?B?a0ZSVEJGWkt4ZS9WUTNUWmZZeEFkY3R2YnZNK1dEVU05SGNQTXlrUEhMdWhy?=
 =?utf-8?B?eC9JamJHTTZya2NibzJ3OHV5TE9zOVFQTG5HazNJT3dWYSs4L3Q3TmZJWHdZ?=
 =?utf-8?B?OENXaFFtYWE2UW05NkIwMjUrQlhjWmtTa1dZQ1ptZEdMaDk4T1c5cUF2M0g3?=
 =?utf-8?B?L1hMR1hCSS82RS9nSStEblc5SWFwTDJVS2ZRTmZhbGQ0TDhhTkdYbWw0RXND?=
 =?utf-8?B?aG9lL2RKRzhJMkJqdG0wYTBVNEpHb2ZxeEpjeG9VbkJYcXBweEZoalM3Qlhr?=
 =?utf-8?B?Vk9UK2dBZWZ5T2VDTFJNQSsrMHdGS1NFTFJRWUhnU3Nib3RDRE1jak91OURu?=
 =?utf-8?B?YjVyaDJkQ0VjRjQ0OFJSUVcyY0hzcHcva0lieDJNVk4vRkJYRUhPMzJWUnNa?=
 =?utf-8?B?TytWa0Y3bnB5cUhGVVJKS2lTVDRjNFJWY3FrNi93bW1nQjRqVzlpLzJRKzBy?=
 =?utf-8?B?NmtZWGU1Vmpkak9YdS9XL3BTOE5UUlpXemU5VUdoYWtCcUVEcE1nSUg1VlpD?=
 =?utf-8?B?T2JHYXhYcUQxMUxEc0txaWV4UkE4cmdUZ29Ma1NKWkYyWGs1SHRNVjl3Y25B?=
 =?utf-8?B?bVBKMXJQendLd3VrTEI3dEtsbHJ3ODVsb2ZNN21wVzFLMU5Kc1lJUkdwOXZx?=
 =?utf-8?B?cVZZUXJScTZ4eGFrSHMwdERHNVdLS0V0MGJXVFpSWS9zQmdRaWJNY1ZpclBL?=
 =?utf-8?B?bmoxMVdqcExUUmluU2lmem02S08rMEF6aURiUVJ1Q2YrWmhaYWVLZEhrUHI0?=
 =?utf-8?B?cHhYQmQ2T2U2aXlXTzJkSzdnRzhZZDJzZzBONlJmWGJ6WFM1c3k5WGJKTEEy?=
 =?utf-8?B?RnBqZUdRQVJVUXZxU1ZHcUdHendFUEtyekU2dVpzWGdBeHdORHliKzcrdjhv?=
 =?utf-8?B?NU8reGROaUpzSlJzZitCWGFmaWY2c0VZWUxBeXM2ZXZIZHU5MTlsQlZ5ZHpw?=
 =?utf-8?B?TEg0MnJMYjFUUkxPTHk5cUovRklsMzRMY0YzMW9XbmNtb21pbWFjWnNjSWx3?=
 =?utf-8?B?WkQ4Qkc5Z3M2SlJUdnNaZUZwaC9IeEd0NmEzOEQ5OXlydXVOUmtvdG9FcDJN?=
 =?utf-8?B?NXlOLzI1MEhiKytpS1JXZVhCSnpPL2U1RkNRSjQrbzhmdUJVVmE4UHZjbXl0?=
 =?utf-8?B?QjZuVExOSW5SblVsOXlTbG1PUWxxV0Z1Uk9HU3g1cTRJYUhqaFdEaUhKQVFY?=
 =?utf-8?B?dkpXNXh3d1BJeGdmUDVPMENUcjRreTJpdldsZFpJbGQrRU51NVJXZlZVWVdl?=
 =?utf-8?B?MXd3cWVWejhlbzNSUE05MU0rbFJNR1hucEs2K1FlQVFFNnoyYzByOFpTcTFW?=
 =?utf-8?B?ZG1rM28zVGVVdlB5dEk5dDJTYzVqVXVSUy9YM0NwWFV5SHZ4M0dUTENHQjFT?=
 =?utf-8?B?VlFObm5iNlh1bThHcExOVzJJa1dleS8yNjg2RXVoSEpTdXJpaDdwY3JBMkYw?=
 =?utf-8?B?WWxZQ3drZlJzT1FjckhBdVFXTUJWbUNOcU03SlN6TnFaYkZrWEZZQ3hxZ01J?=
 =?utf-8?B?WWU4QjdqK1RnRVR5K3UwYXhZbUl1QkdqTm9DWXNXczk5dUVuTXVpMGxZSW1v?=
 =?utf-8?B?T3JqbzRVT1d2cFdnVG9xVTZqYXJrWVU1aG9kek41R0tQTWxkRlByUnZWMS9E?=
 =?utf-8?B?RnhWQ2h2bzF6MnJHWVh0ZjI3VTNuRHFPR1VGRHgxSmZ2L2NkNnBNSWVSaXlp?=
 =?utf-8?B?R2NiRWcyZSswUFkyUGlLakNpZitGQmJRS3Jad3BvSmlxZ0ZHSVlXdThxeStZ?=
 =?utf-8?B?UHJLWi9JV1p0Q2dhSk1OaldXdjd5bGRHLzJFekoyOGxVSXRnZkxPUU5KeG93?=
 =?utf-8?Q?tcDWMufwsINSj1oM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b26a3e-9f13-4155-a571-08da1bb17145
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:50:15.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVWmy+1uBajq4mnPcmCbYJd1fwpzAkpgYQDCA8BquiwvZz111pBkSPuRCVG13fQv4ElG3KbDmxRRuF+opZ0iAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6900
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 23.03.2022 11:05, Ming Qian wrote:
> The GStreamer v4l2videodec only ever calls S_FMT on the output side
> and then expects G_FMT on the capture side to return a valid format.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 30 ++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index a95305639dd9..5dfa6f87871e 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -1831,12 +1831,40 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
>   				  struct v4l2_format *f)
>   {
>   	int ret;
> +	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
> +	struct vb2_queue *dst_vq;
> +	struct mxc_jpeg_q_data *q_data_cap;
> +	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	struct v4l2_format fc;
>   
>   	ret = mxc_jpeg_try_fmt_vid_out(file, priv, f);
>   	if (ret)
>   		return ret;
>   
> -	return mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
> +	ret = mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
> +	if (ret)
> +		return ret;
> +
> +	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE)
> +		return 0;
> +
> +	dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, cap_type);
> +	if (!dst_vq)
> +		return -EINVAL;
> +
> +	if (vb2_is_busy(dst_vq))
> +		return 0;
> +
> +	q_data_cap = mxc_jpeg_get_q_data(ctx, cap_type);
> +	if (q_data_cap->w == f->fmt.pix_mp.width && q_data_cap->h == f->fmt.pix_mp.height)
> +		return 0;

Is this an optimization, to avoid propagating the format to the capture 
queue, if it is already set? If so, shouldn't fourcc also be part of the 
comparison?

Thanks,
Mirela

> +	memset(&fc, 0, sizeof(fc));
> +	fc.type = cap_type;
> +	fc.fmt.pix_mp.pixelformat = q_data_cap->fmt->fourcc;
> +	fc.fmt.pix_mp.width = f->fmt.pix_mp.width;
> +	fc.fmt.pix_mp.height = f->fmt.pix_mp.height;
> +
> +	return mxc_jpeg_s_fmt_vid_cap(file, priv, &fc);
>   }
>   
>   static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
