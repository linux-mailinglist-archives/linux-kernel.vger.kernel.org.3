Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2424494DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbiATMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiATMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0EC061574;
        Thu, 20 Jan 2022 04:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EC2FB81D56;
        Thu, 20 Jan 2022 12:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B31C340E0;
        Thu, 20 Jan 2022 12:31:03 +0000 (UTC)
Message-ID: <5868782b-3383-5ee6-4111-841707ffee39@xs4all.nl>
Date:   Thu, 20 Jan 2022 13:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] media: aspeed: Correct values for detected timing
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
 <20211222082139.26933-4-jammy_huang@aspeedtech.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211222082139.26933-4-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

I just want to double check this: I assume you have tested this with the
various polarity combinations?

I ask because I've never seen this before in any other hardware. The
sync and porch values reported by hardware are always independent from the
polarity, so that's why I am surprised to see this.

Same for the next patch (4/4).

Regards,

	Hans

On 12/22/21 09:21, Jammy Huang wrote:
> Correct timing's fp/sync/bp value based on the information below.
> It should be noticed that the calculation formula should be changed
> per sync polarity.
> 
> The sequence of signal: sync - backporch - video data - frontporch
> 
> The following registers start counting from sync's rising edge:
> 1. VR090: frame edge's left and right
> 2. VR094: frame edge's top and bottom
> 3. VR09C: counting from sync's rising edge to falling edge
> 
> [Vertical timing]
>             +--+     +-------------------+     +--+
>             |  |     |    v i d e o      |     |  |
>          +--+  +-----+                   +-----+  +---+
> 
>        vsync+--+
>    frame_top+--------+
> frame_bottom+----------------------------+
> 
>                   +-------------------+
>                   |    v i d e o      |
>       +--+  +-----+                   +-----+  +---+
>          |  |                               |  |
>          +--+                               +--+
>        vsync+-------------------------------+
>    frame_top+-----+
> frame_bottom+-------------------------+
> 
> [Horizontal timing]
>             +--+     +-------------------+     +--+
>             |  |     |    v i d e o      |     |  |
>          +--+  +-----+                   +-----+  +---+
> 
>        hsync+--+
>   frame_left+--------+
>  frame_right+----------------------------+
> 
>                   +-------------------+
>                   |    v i d e o      |
>       +--+  +-----+                   +-----+  +---+
>          |  |                               |  |
>          +--+                               +--+
>        hsync+-------------------------------+
>   frame_left+-----+
>  frame_right+-------------------------+
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  v2:
>   - Code refined per Joel's suggestion
>   - Update commit message to have name matching variable
> ---
>  drivers/media/platform/aspeed-video.c | 30 ++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index c241038ee27c..7c50567f5ab0 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -936,7 +936,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>  	u32 src_lr_edge;
>  	u32 src_tb_edge;
>  	u32 sync;
> -	u32 htotal;
> +	u32 htotal, vtotal, vsync, hsync;
>  	struct v4l2_bt_timings *det = &video->detected_timings;
>  
>  	det->width = MIN_WIDTH;
> @@ -983,21 +983,35 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>  		mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
>  		sync = aspeed_video_read(video, VE_SYNC_STATUS);
>  		htotal = aspeed_video_read(video, VE_H_TOTAL_PIXELS);
> +		vtotal = FIELD_GET(VE_MODE_DETECT_V_LINES, mds);
> +		vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
> +		hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
>  
>  		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
>  		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
> -		det->vfrontporch = video->frame_top;
> -		det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> -			video->frame_bottom;
> -		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
> +		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
> +			det->vbackporch = video->frame_top - vsync;
> +			det->vfrontporch = vtotal - video->frame_bottom;
> +			det->vsync = vsync;
> +		} else {
> +			det->vbackporch = video->frame_top;
> +			det->vfrontporch = vsync - video->frame_bottom;
> +			det->vsync = vtotal - vsync;
> +		}
>  		if (video->frame_top > video->frame_bottom)
>  			continue;
>  
>  		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
>  		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
> -		det->hfrontporch = video->frame_left;
> -		det->hbackporch = htotal - video->frame_right;
> -		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
> +		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
> +			det->hbackporch = video->frame_left - hsync;
> +			det->hfrontporch = htotal - video->frame_right;
> +			det->hsync = hsync;
> +		} else {
> +			det->hbackporch = video->frame_left;
> +			det->hfrontporch = hsync - video->frame_right;
> +			det->hsync = htotal - hsync;
> +		}
>  		if (video->frame_left > video->frame_right)
>  			continue;
>  
