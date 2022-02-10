Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF04B0D13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiBJMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:01:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbiBJMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:01:43 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC62620;
        Thu, 10 Feb 2022 04:01:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rrdpbqe364sjgp4i5nTRMHyVsEwWBgS0YmprFUYDFNXH3LpEEUNMZhyZ6HEZnc5hWS2JzMcjIpTMcbtZHyAcwyQp6f1WmYOh5kj4XAcfWx0EHSJatpHsypAsQwJseKLWS/h48oGtvRib43sN8+zGYwYROkCISPitGiw0y5gZT7fcRb6hfpx8fSJir41TYSiM24XEOg4qXVYJze+2VQgPsG1WALjeN9JfUvwVvtA/eYzK/TaJ+X74wf+nKgH7hNYmMs20U5rFP7PxHsWpxXQhbGU06Jrj7jtr9+jYLlVtoMSNlkbWdUgLbxtwwq2b+3Vpm5U7Z4r55TipQeUvNqy6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGce6ShZWCo30tSM3s28/U/tqu+GKBgqIOyc36Rg2yw=;
 b=Uzo4jUlJSNk2ETzOHCiKr3x12VdIPpYfwFJaTFD0wJJb6Tr0y2kAEMUilSmq5y7/W9V9PftpHmqGUaCN1FCvIZbAC9/sTts1CUL4oI+GyGvnwvNpZP+O+nAWdTyeTZG2gLaMAjvf3Nadvu88b/PRF/zF6g6yrQKgJbNJez/X+W3zmbIkrrC7p21f8VIY4tefUpxQ9jDl3ZBk5wkESssxwIXH455NejgcjZVDpCNR2RNiK7OC0eru7LurnHLjayGL20gmjbG8QFG4Xbs3K5XVuevfatMlu+gQgVCSD0kDZBClHIoU4arM6Eekvuyf1PtOC7rjNbaUm5S5HxkvCEO2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGce6ShZWCo30tSM3s28/U/tqu+GKBgqIOyc36Rg2yw=;
 b=ZZfd/KZzJeRrMQu67iTRfT/DVI33zXQGbLanG2fCE6Tnu2JqIn5BAy+p3YP4Dyqmm2Xz/Nv0qF4B8cmZN+xho4JvcfCS10XjNYcyz56Cyz5bhYW5krUuiDCUtud3JAdqf0G+DwnF86CNB5ySEuxvGikbrOsgIoM32Bm5xXroYGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by HE1PR0402MB2875.eurprd04.prod.outlook.com
 (2603:10a6:3:d6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 12:01:41 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::a1ae:e74c:cadb:efb8]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::a1ae:e74c:cadb:efb8%12]) with mapi id 15.20.4975.011; Thu, 10 Feb
 2022 12:01:40 +0000
Message-ID: <8ee6981e-9d75-038c-578b-e15b580ec63e@oss.nxp.com>
Date:   Thu, 10 Feb 2022 14:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220210054601.5889-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20220210054601.5889-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e83fdf-eeba-4648-8e24-08d9ec8d189b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2875:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2875669C3AE07D2CE1D536DBCE2F9@HE1PR0402MB2875.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvcFSVazxcZ2+FZR2sNHLO2JCtdjaI5+L3OYBLJAS93+as5khN0s5JqEfVWcM7mrNvxl+KYFymmFProG9MyFCJ7T+WGEVmwRBC8UUD0P+8tvBilbBR4Cw9N0xy2h9Jp8TNzr97y79RI1Eijv1qOPMK0jJOMTDtI9O3VUImiDAj4TjtxMfjTmFjlE9qH8znAsnW06hJ+qdykg+4sm/fEsZnUXaWcp6RvaG7DIlLyLMHbATarLM4W6sWJbxU/AXkEVdgbwEKKj3dvaqGxq6iNkIASyQFMdt9XDhYM0FkpUsegpQXZtQc5f9MV2JDJc2jW4KghYn9+zbugJ6B9jVBmovuJCXWKm/UyUHDa3sXhItYZ5x5KVm4l/L7oanoh/yPW/GeNUTS7mJDD1jKm2RpYAp3Ls9TsYeCAr/F45mxsBgoXRAxoS61xqYkkDgtHfhtShUs4esuNch+hsS9D57aMC1IJwIPkSFUPJDpAL/tcsjNVFuLH+8tLuPUCTp4TEbTwHMUs/6YEPBbL3rCfXu6xhsfaBksqaxhbUCKvwnBiNGmi9EgMXYyhrd3CHtjA4V2thxaqeOJlu4jSZvyjOZ5mQmt4FgGqKUDG87ZsxF2gM69P+jSQMpUlb4pxTgm2o82BxXazGvSL2JGxJ7cQ0Zp3HBftfYFatWxS21RKR9Ph6v1hJSSer8AFrWUITWl9TXLD0lAhges4YjMeEsxruBpPykhFMyW+9yiq6S78tSflPVKHtrWgy1YAxsTLxK1qQJyHrfubnzS/y7vLEjOJtNQ0ClQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(186003)(5660300002)(66946007)(26005)(66476007)(66556008)(86362001)(83380400001)(2906002)(7416002)(38350700002)(31696002)(38100700002)(8676002)(52116002)(6666004)(53546011)(2616005)(6512007)(6506007)(8936002)(6486002)(31686004)(508600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djl5bEVOZ1FoS3FraW9qU1QyczhHTGhCNTNmcVVUaCtuQXR6VHp6Q0Y1eXN5?=
 =?utf-8?B?cm1ZandNeC85cU0vNURqTFlpSHl1WWZsbFRFa1pWQ05iTlkwNVphL0F5MHBs?=
 =?utf-8?B?WkZQWXVaYzFvMzVFVkxhak1QdVVldlNYRE5OVlQ4RTl4U3h6aGUvM21KcWtT?=
 =?utf-8?B?dDhreTQyVmZHVWkvdXE2WThnTVBMRkMzV1R1eFRkNjZiV1dJRmJsc2x0Z2FG?=
 =?utf-8?B?WUMraU5XUXRuOXpmV0Z1Ulp4Z2hOblRzdDhsVGhLK0dDVUNxR1pPMWRib3Q1?=
 =?utf-8?B?cWN1c2svS0p3Mm40VzdVMHB6ZURXWnBBZmM3VmxEZnZPeG4wRFV6cEpBOXJs?=
 =?utf-8?B?NktHR0F2MGZoNkpZYmtHZ3B0T290bVNHY3VLSDdPSlNkVnJQZ2NOUFBlRlgy?=
 =?utf-8?B?RW9XMmt6YkoxRVR2YkxZSEJ5T09qcEFjOUJIenhyMGV3VFdnU0thK0ljckpW?=
 =?utf-8?B?RHlFNGlkRVRXWG1ZZy9EQVg2dXErMG5yUlg5L2Y5ZXNaZDBsNHBPVDFzTmpU?=
 =?utf-8?B?eUxseCtIQnhDVThyYjArN2RXVWdRdHhib04ycytWL1k1c0Ribmp3NWhVdnpo?=
 =?utf-8?B?cS9ZVU5uYVd6RklXd1JpRXVPblVvY1ZjZlpKZ3E1ZmJxU1QwaGhVZVhEYVpI?=
 =?utf-8?B?em9uSjAvN3BvV3dIRUszYzVYaDlmN29qNFZlOVI2Vk1zREpBRlJtSkhXTFV4?=
 =?utf-8?B?TEJEUFhXUWZmbWJiR2oxSlNySGFKUXJacE5CUFRFZy9mMlNhaUdDak5aaWpR?=
 =?utf-8?B?TmdWSlJSbW8rZ1RjR0FXV2VVRkNwd3NTQVZYTXJlcFAwcHJvbDEvY2IrUUMw?=
 =?utf-8?B?bzBLSlUrNFJwNEFvRGlUZlI3V1ZTYkZmZ2lZUFJBRlV6NWtXSXZZTGtPYjhy?=
 =?utf-8?B?SkdNVFZ1T2tndVdYSnQzd2J3dnJQelNXS0lBRk5PaGk1blc4L2tJSEN4NGRm?=
 =?utf-8?B?WW1kLy9ZUTBIWmNUcGdBVFc4bDVobktwa25ac1k2QTR2b092ZXlSZmRZSUpN?=
 =?utf-8?B?MHZyQnlyS2pxajFBTXFPK1dDV24xV1FMN0gxUXVTcWY2b1JodFd5dENWWklY?=
 =?utf-8?B?OTdpWm5ZRkJXd21HczZMdXRhUTRYVVNGOGNxWXcyZURqN3pxZ05ZQ0lMSnZQ?=
 =?utf-8?B?cHFwTnhxVlpEdWttQXlsY3F1V2d6bjRPMzhwZlZXM3hjU0NDenM4UlUreGRN?=
 =?utf-8?B?R1MzZ1B1QzFDR3JCVkNRb3UvWGdaVlAzOWZhQ2RvOGp0ejZQUXl2Y1p0RmVU?=
 =?utf-8?B?WkFxSnZYQmwwRHZmN1BrVHBJSHFNT0dxQUJsMkozN0ZTb2tGa3pZeEkxby9V?=
 =?utf-8?B?SDllMGp1V2lZZHpzUnRkWTdPUTFJU2ZjNE5mc0E0UlVndnRCT2ZZQkdBZnVE?=
 =?utf-8?B?bnhNa3dPMmxvS3hEZ2lENlZpN0R3Z2JGYmhUblZMSm1MM05rV3lpai9xMHRZ?=
 =?utf-8?B?Z3UveGFzSFdXV3FEaDVrK0I3NFB4cVRyTkltZnY0YVpHeC9IWEVpSk1Jc1FH?=
 =?utf-8?B?dzBaM2dGRjNlL21Ub3E2Y3JHbS9KYTA1bm1jRS9OM29kNGNUZFRrb0Z5UVVT?=
 =?utf-8?B?RE9ibEhFNU1saUJHYzBaNDRXOHQ4aE15QWdSekVmL0hSM0hGb2ZodDJ4VkJh?=
 =?utf-8?B?bkcyMjBGTmxrVkR3M0xuOWFsY093NmZvbTlaRHJEaVFvUWQyVW85MXVIZ3ht?=
 =?utf-8?B?bjI3TXowd0RoUnc3bi9RTEYxbW5uaHVxS1Q3WGpIOHBFVm9paWtJQkVGcytU?=
 =?utf-8?B?TXVEY1lFbXZ3blFmbkJKZFR2MVZ0b25lbXhoZ1o2bHpLaWpDZzlBWVgyZUZY?=
 =?utf-8?B?KzJBVnJwV21KMlIzVW9SUHlFNHFLaGFCQ0dpRVFBeXJWU0FnSHpVVllJS1Fq?=
 =?utf-8?B?L3dYT01aTlNwcVpVSk0yNWpjT3l6aDZTcjkvaTY5QUw4QWZ6Z0VwQkszbkVP?=
 =?utf-8?B?YWRxWCs0Tmt3SjB0R0lHMW9zOGVUS2lOZkU3dGd4M0t1cmxyUTBzRlpRZWtF?=
 =?utf-8?B?RU9oQ3BkQ1dTZFEyMVNVc0phRkpQeEZJZ2pvMHg5SUtCcXd1bHZZaERSYkM1?=
 =?utf-8?B?U3VrckM0L2VjMEx4ZG40YTFrV2x6ME4zNjRVRm1QQ3dVeVA4djJVb29ITW1l?=
 =?utf-8?B?WGQ3TGNjM0dSaXQvZDdBUlR3MUdhN1IyM3I0VVdCcncwelhnZlZoY1VpMHVQ?=
 =?utf-8?Q?k3p0KNSe7M2hGtFV0QrDIQI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e83fdf-eeba-4648-8e24-08d9ec8d189b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 12:01:39.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juquM68TTEZtVJHmUnv7pz23OLB3WTO4qLyNg6EtohKU47dclF5K6xwPWFjVvHXv61mXhxkioopciPQjDwjVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,
thanks for the description update.

Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

Regards,
Mirela

On 10.02.2022 07:46, Ming Qian wrote:
> The V4L2_EVENT_EOS event is a deprecated behavior,
> the V4L2_BUF_FLAG_LAST buffer flag should be used instead.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>   drivers/media/platform/imx-jpeg/mxc-jpeg.c | 39 ++++++++++++++++++++--
>   drivers/media/platform/imx-jpeg/mxc-jpeg.h |  1 +
>   2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> index 86d37d14cfe2..3c50c572d6b0 100644
> --- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> @@ -991,6 +991,20 @@ static void mxc_jpeg_device_run(void *priv)
>   	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
>   }
>   
> +static void mxc_jpeg_set_last_buffer_dequeued(struct mxc_jpeg_ctx *ctx)
> +{
> +	struct vb2_queue *q;
> +
> +	ctx->stopped = 1;
> +	q = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
> +	if (!list_empty(&q->done_list))
> +		return;
> +
> +	q->last_buffer_dequeued = true;
> +	wake_up(&q->done_wq);
> +	ctx->stopped = 0;
> +}
> +
>   static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
>   				struct v4l2_decoder_cmd *cmd)
>   {
> @@ -1008,6 +1022,7 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
>   		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
>   			/* No more src bufs, notify app EOS */
>   			notify_eos(ctx);
> +			mxc_jpeg_set_last_buffer_dequeued(ctx);
>   		} else {
>   			/* will send EOS later*/
>   			ctx->stopping = 1;
> @@ -1034,6 +1049,7 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
>   		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
>   			/* No more src bufs, notify app EOS */
>   			notify_eos(ctx);
> +			mxc_jpeg_set_last_buffer_dequeued(ctx);
>   		} else {
>   			/* will send EOS later*/
>   			ctx->stopping = 1;
> @@ -1110,6 +1126,8 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
>   		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>   	}
>   	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
> +	ctx->stopping = 0;
> +	ctx->stopped = 0;
>   }
>   
>   static int mxc_jpeg_valid_comp_id(struct device *dev,
> @@ -1401,12 +1419,29 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
>   	return 0;
>   }
>   
> +static void mxc_jpeg_buf_finish(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_queue *q = vb->vb2_queue;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(vb->type))
> +		return;
> +	if (!ctx->stopped)
> +		return;
> +	if (list_empty(&q->done_list)) {
> +		vbuf->flags |= V4L2_BUF_FLAG_LAST;
> +		ctx->stopped = 0;
> +	}
> +}
> +
>   static const struct vb2_ops mxc_jpeg_qops = {
>   	.queue_setup		= mxc_jpeg_queue_setup,
>   	.wait_prepare		= vb2_ops_wait_prepare,
>   	.wait_finish		= vb2_ops_wait_finish,
>   	.buf_out_validate	= mxc_jpeg_buf_out_validate,
>   	.buf_prepare		= mxc_jpeg_buf_prepare,
> +	.buf_finish             = mxc_jpeg_buf_finish,
>   	.start_streaming	= mxc_jpeg_start_streaming,
>   	.stop_streaming		= mxc_jpeg_stop_streaming,
>   	.buf_queue		= mxc_jpeg_buf_queue,
> @@ -1842,14 +1877,14 @@ static int mxc_jpeg_dqbuf(struct file *file, void *priv,
>   	int ret;
>   
>   	dev_dbg(dev, "DQBUF type=%d, index=%d", buf->type, buf->index);
> -	if (ctx->stopping == 1	&& num_src_ready == 0) {
> +	if (ctx->stopping == 1 && num_src_ready == 0) {
>   		/* No more src bufs, notify app EOS */
>   		notify_eos(ctx);
>   		ctx->stopping = 0;
> +		mxc_jpeg_set_last_buffer_dequeued(ctx);
>   	}
>   
>   	ret = v4l2_m2m_dqbuf(file, fh->m2m_ctx, buf);
> -
>   	return ret;
>   }
>   
> diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
> index 9fb2a5aaa941..f53f004ba851 100644
> --- a/drivers/media/platform/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
> @@ -91,6 +91,7 @@ struct mxc_jpeg_ctx {
>   	struct v4l2_fh			fh;
>   	enum mxc_jpeg_enc_state		enc_state;
>   	unsigned int			stopping;
> +	unsigned int			stopped;
>   	unsigned int			slot;
>   };
>   
