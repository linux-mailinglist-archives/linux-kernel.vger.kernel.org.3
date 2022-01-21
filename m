Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B979495AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378980AbiAUHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:30:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41764 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378954AbiAUHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:30:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D3E617A8;
        Fri, 21 Jan 2022 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5310C340E1;
        Fri, 21 Jan 2022 07:30:18 +0000 (UTC)
Message-ID: <418fc1b2-ddbe-24e3-82cc-aa8ce74f4507@xs4all.nl>
Date:   Fri, 21 Jan 2022 08:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] media: aspeed: Fix timing polarity incorrect
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
 <20211222082139.26933-5-jammy_huang@aspeedtech.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211222082139.26933-5-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 09:21, Jammy Huang wrote:
> This is a workaround for sync polarity unstable.
> Sync value get by VR09C counts from sync's rising edge, which means
> sync's polarity is negative if sync value is bigger than total/2.

Do you have an example of such a format, or is this mostly theoretical?

Either provide the example or make a note that it is theoretical.

Regards,

	Hans

> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  v2:
>   - Use 'total/2' rather than 'total<<1'
>   - Update comment
> ---
>  drivers/media/platform/aspeed-video.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 7c50567f5ab0..c3e3343d91e1 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -989,6 +989,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>  
>  		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
>  		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
> +
> +		/*
> +		 * This is a workaround for polarity detection when the sync
> +		 * value is larger than half.
> +		 */
> +		if (vsync > (vtotal / 2))
> +			det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
> +		else
> +			det->polarities |= V4L2_DV_VSYNC_POS_POL;
> +
>  		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
>  			det->vbackporch = video->frame_top - vsync;
>  			det->vfrontporch = vtotal - video->frame_bottom;
> @@ -1003,6 +1013,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>  
>  		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
>  		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
> +
> +		/*
> +		 * This is a workaround for polarity detection when the sync
> +		 * value is larger than half.
> +		 */
> +		if (hsync > (htotal / 2))
> +			det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
> +		else
> +			det->polarities |= V4L2_DV_HSYNC_POS_POL;
> +
>  		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
>  			det->hbackporch = video->frame_left - hsync;
>  			det->hfrontporch = htotal - video->frame_right;
