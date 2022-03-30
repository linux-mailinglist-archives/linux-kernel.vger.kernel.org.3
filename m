Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502C34EBBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbiC3Hhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiC3Hhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:37:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A37455777;
        Wed, 30 Mar 2022 00:36:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 71E2F1F4438B;
        Wed, 30 Mar 2022 08:36:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648625764;
        bh=UTGb39eNA/52bA/avUqa1vAIsS16AGDE3+w7kh3a6og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QC4vZngr3Uf9QXAtUMWbst6zGquCSCpyytNiKEzxsZj3KX7YkpTaAlCupEzhztCPu
         gBJtGKKFaTKzt3tRoPoeRVPScGQU6tLJ3nNxXts+psMN6kB80q6gPkLi0cJ47e9Wux
         FoP6RuXDpcKGL6XkQNuVDQdjEiZC3Myw5SRjrwZBXc4IiO4iMFIB+5VVSpQZH9cFCH
         /O69NoNP4PL9lKjX9l5WRAA0dyC2KAbdhPyezJ3MGtESVdfvlM0FviZ5YEgKxgh2GP
         5GfogVIFouwXZUdf+uMedRxRRsUGa28HYlOLVEOnJr2+m4ftNFyRC8GNrKw+8plX2c
         zxWeWiR1hOXww==
Date:   Wed, 30 Mar 2022 09:36:00 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 20/24] media: hantro: Enable HOLD_CAPTURE_BUF for H.264
Message-ID: <20220330073600.crbi5wqlp4rimx2a@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-21-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-21-nicolas.dufresne@collabora.com>
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
>This is needed to optimizing field decoding. Each field will be

s/is needed to optimizing/is needed to optimize/

>decoded in the same capture buffer, so to make use of the queues

s/in the same/into the same/

>we need to be able to ask the driver to keep the capture buffer.

How about:
"""
During field decoding each field will be decoded into the same capture
buffer. Optimise this mode by asking the driver to hold the buffer until
all fields are written into it.
"""

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/staging/media/hantro/hantro_v4l2.c | 25 ++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>
>diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
>index 67148ba346f5..50d636678ff3 100644
>--- a/drivers/staging/media/hantro/hantro_v4l2.c
>+++ b/drivers/staging/media/hantro/hantro_v4l2.c
>@@ -409,6 +409,30 @@ hantro_update_requires_request(struct hantro_ctx *ctx, u32 fourcc)
> 	}
> }
>
>+static void
>+hantro_update_requires_hold_capture_buf(struct hantro_ctx *ctx, u32 fourcc)
>+{
>+	struct vb2_queue *vq;
>+
>+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
>+			     V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>+
>+	switch (fourcc) {
>+	case V4L2_PIX_FMT_JPEG:
>+	case V4L2_PIX_FMT_MPEG2_SLICE:
>+	case V4L2_PIX_FMT_VP8_FRAME:
>+	case V4L2_PIX_FMT_HEVC_SLICE:
>+	case V4L2_PIX_FMT_VP9_FRAME:
>+		vq->subsystem_flags &= ~(VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF);
>+		break;

Out of curiosity, why would it be bad for the other codecs to have
support for that feature activated? As this doesn't actually hold the
buffers but only makes sure that they could be held.

>+	case V4L2_PIX_FMT_H264_SLICE:
>+		vq->subsystem_flags |= VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;

I think it is worth it to highlight with a comment why only this one
receives support for holding the buffer. As it is quite confusing
without background info and just the code.

How about:
```
/*
  * During field decoding in H264, all fields are written into the
  * same capture buffer, thus we need to be able to hold the buffer
  * until all fields are written to it
  */
```

>+		break;
>+	default:

The only other decoding formats remaining are:
- V4L2_PIX_FMT_NV12_4L4
- V4L2_PIX_FMT_NV12

Both have codec mode HANTRO_MODE_NONE.

My thought is:
If we don't care for these two, the we might as well disable buffer holding
support for them as well. So, we could make this simplier
(but a bit less descriptive):

```
/*
  * During field decoding in H264, all fields are written into the
  * same capture buffer, thus we need to be able to hold the buffer
  * until all fields are written to it
  */
if (fourcc == V4L2_PIX_FMT_H264_SLICE)
     vq->subsystem_flags |= VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
else 
		vq->subsystem_flags &= ~(VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF);
```

Greetings,
Sebastian

>+		break;
>+	}
>+}
>+
> static int hantro_set_fmt_out(struct hantro_ctx *ctx,
> 			      struct v4l2_pix_format_mplane *pix_mp)
> {
>@@ -472,6 +496,7 @@ static int hantro_set_fmt_out(struct hantro_ctx *ctx,
> 	ctx->dst_fmt.quantization = pix_mp->quantization;
>
> 	hantro_update_requires_request(ctx, pix_mp->pixelformat);
>+	hantro_update_requires_hold_capture_buf(ctx, pix_mp->pixelformat);
>
> 	vpu_debug(0, "OUTPUT codec mode: %d\n", ctx->vpu_src_fmt->codec_mode);
> 	vpu_debug(0, "fmt - w: %d, h: %d\n",
>-- 
>2.34.1
>
