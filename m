Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FA4EB0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiC2PgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiC2PgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:36:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD723B03D;
        Tue, 29 Mar 2022 08:34:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8CD3F1F44125;
        Tue, 29 Mar 2022 16:34:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648568062;
        bh=nGX92UvfWgt2Qv/de13zxyDQ5ZWhrMUfiZ3gbHkaldY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2sQ2pq+IanUJcoPmS5cQ2dTSCNdmrop2QBRkMayanfPOvpqf4G1Vk3ibBPFQI08d
         9xZWHReZFrwyveeZ3QZ+Nd0ue4A3tukodjvm5IsdNhsGIwj6sL/W4FFoCRwIr57wP9
         fP6SCna099Z1aCMb+P4klF15+KT+UhqTRYwep52fpbDtREnjNeaGY4FQfskQ07D/PG
         j+0VA4o3E264anCZbpKv+7ZWvJJSYU9MAjd5eWp0EOn7uf9Hr6n1YEJIuSCOXKxHeN
         f6Ja5nAoJnLO1gbtxd1rvZbgIMieoFHYUaSa1dTwYVnH5IVbxCmNJOZNviFTj9Wsd3
         nKvMaCqOP1oPA==
Date:   Tue, 29 Mar 2022 17:34:19 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 15/24] media: rkvdec: Enable capture buffer holding
 for H264
Message-ID: <20220329153419.2l67xawgabqefcao@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-16-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-16-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>In order to support interlaced video decoding, the driver must
>allow holding the capture buffer so that the second field can
>be decoded into it.
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/staging/media/rkvdec/rkvdec.c | 4 ++++
> drivers/staging/media/rkvdec/rkvdec.h | 1 +
> 2 files changed, 5 insertions(+)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>index 2df8cf4883e2..05824f1997f7 100644
>--- a/drivers/staging/media/rkvdec/rkvdec.c
>+++ b/drivers/staging/media/rkvdec/rkvdec.c
>@@ -138,6 +138,7 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
> 		.ops = &rkvdec_h264_fmt_ops,
> 		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
> 		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
>+		.subsystem_flags = VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
> 	},
> 	{
> 		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
>@@ -394,6 +395,9 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
> 	cap_fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
> 	cap_fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
>
>+	/* Enable format specific queue feature */

s/feature/features/

Greetings,
Sebastian

>+	vq->subsystem_flags |= desc->subsystem_flags;
>+
> 	return 0;
> }
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
>index 2f4ea1786b93..e37f1a015fa0 100644
>--- a/drivers/staging/media/rkvdec/rkvdec.h
>+++ b/drivers/staging/media/rkvdec/rkvdec.h
>@@ -81,6 +81,7 @@ struct rkvdec_coded_fmt_desc {
> 	const struct rkvdec_coded_fmt_ops *ops;
> 	unsigned int num_decoded_fmts;
> 	const u32 *decoded_fmts;
>+	u32 subsystem_flags;
> };
>
> struct rkvdec_dev {
>-- 
>2.34.1
>
