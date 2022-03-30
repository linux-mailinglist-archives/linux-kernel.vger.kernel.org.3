Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400414EBB18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbiC3Gu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbiC3GuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:50:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131268A30C;
        Tue, 29 Mar 2022 23:48:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 380F81F4436E;
        Wed, 30 Mar 2022 07:48:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648622903;
        bh=NV0u/ujs6yEEQh0kTYEkObgi+i8FUlA9532q4bfxkjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCxKIpchhx7t8R+goxSJEZGr6eq5EwaRlfaJbWNfsFAYukxWuwXZVDPGAIdmOCwy1
         dt86+UwNNdNmgKc4Zh+eCCH7lKn2FgQuYS4piadVmMiGDfSIMpr/KfQvO5FTTcKNKh
         TutLt6dqdEoCqpAocRI3D16VVytdKjjbPOYPI5x+nCgmK6fVr+y462STLcp23lHyFR
         89bNiRUNwNyDa8l9wnx1G4CH/TDPdB1pQM9N3SCueR76ZLLr158ZRQPbgQhyecg+re
         w8f8XXZ5BPXYfZmUOCULy0aXBdJYidiyd/sV/lAJla8+4iGuQIx9Cph79aHi3ELxj8
         IuYF/AHFLjxBw==
Date:   Wed, 30 Mar 2022 08:48:19 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/24] media: rkvdec: h264: Validate and use pic width
 and height in mbs
Message-ID: <20220330064819.42q5uouydvl5yqfg@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-18-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-18-nicolas.dufresne@collabora.com>
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
>From: Jonas Karlman <jonas@kwiboo.se>
>
>The width and height in mbs is currently configured based on OUTPUT buffer
>resolution, this works for frame pictures but can cause issues for field
>pictures.

How about:

"""
The width and height measured in macroblocks (mbs) is currently
configured based on the resolution of the OUTPUT buffer, this works for
frame pictures but can cause issues for field pictures..
"""

(I think it improves readability to explain at least once what mbs means
to anyone not aware)

>
>When frame_mbs_only_flag is 0 the height in mbs should be height of
>the field instead of height of frame.
>
>Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
>against OUTPUT buffer resolution and use these values to configure HW.

s/OUTPUT buffer resolution/the resolution of the OUTPUT buffer/

>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian
>---
> drivers/staging/media/rkvdec/rkvdec-h264.c |  4 ++--
> drivers/staging/media/rkvdec/rkvdec.c      | 10 ++++++++++
> 2 files changed, 12 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>index db1e762baee5..847b8957dad3 100644
>--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>@@ -672,8 +672,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
> 		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
> 	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO),
> 		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
>-	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WIDTH_IN_MBS);
>-	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_HEIGHT_IN_MBS);
>+	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
>+	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MBS);
> 	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
> 		  FRAME_MBS_ONLY_FLAG);
> 	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD),
>diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>index 22c0382c579e..67539f4bf382 100644
>--- a/drivers/staging/media/rkvdec/rkvdec.c
>+++ b/drivers/staging/media/rkvdec/rkvdec.c
>@@ -29,8 +29,11 @@
>
> static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> {
>+	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
>+
> 	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
> 		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>+		unsigned int width, height;
> 		/*
> 		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> 		 * but it's currently broken in the driver.
>@@ -45,6 +48,13 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> 		if (sps->bit_depth_luma_minus8 != 0)
> 			/* Only 8-bit is supported */
> 			return -EINVAL;
>+
>+		width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
>+		height = (sps->pic_height_in_map_units_minus1 + 1) * 16;
>+
>+		if (width > ctx->coded_fmt.fmt.pix_mp.width ||
>+		    height > ctx->coded_fmt.fmt.pix_mp.height)
>+			return -EINVAL;
> 	}
> 	return 0;
> }
>-- 
>2.34.1
>
