Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCB497644
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiAWXEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiAWXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:04:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ECCC06173B;
        Sun, 23 Jan 2022 15:04:52 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD29AA15;
        Mon, 24 Jan 2022 00:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642979090;
        bh=oRXijnjlbc6rg3Y2fSOFxHu51GuUHv+cYHsNAhLMCA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tv0TZEZzAvgw05R1Mz2Bm/Kw91rC2bpFLl865puTFQS1f3vIIqWTfS+A9P3X80ECW
         7L14TY0mt3m+kHd/ItG2fKaL/5WyoumSUPXmfzRJO8AdQM+0YKx8g5MfH7mtnA4Iv2
         XlDIL6fpTx0TnATVBXGBlgknNqRtAZpgIY0AuZJI=
Date:   Mon, 24 Jan 2022 01:04:34 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        mchehab@kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3] drivers: staging: media: omap4iss: Use BIT macro
 instead of left shifting
Message-ID: <Ye3fAuBFkuzesBTM@pendragon.ideasonboard.com>
References: <20220121100837.337094-2-mosescb.dev@gmail.com>
 <20220121105111.2651-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121105111.2651-1-mosescb.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moses,

Thank you for the patch.

On Fri, Jan 21, 2022 at 11:51:11AM +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.
> 
> Example:  1 << 7  is same as BIT(7)
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  V2 -> V3: Add Dan's Reviewed-by tag to commit message
>  V1 -> V2: Use BIT(0) instead of 1
> 
>  drivers/staging/media/omap4iss/iss_video.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/media/omap4iss/iss_video.h b/drivers/staging/media/omap4iss/iss_video.h
> index 526281bf0051..1724ed03ce9d 100644
> --- a/drivers/staging/media/omap4iss/iss_video.h
> +++ b/drivers/staging/media/omap4iss/iss_video.h
> @@ -53,19 +53,19 @@ enum iss_pipeline_stream_state {
>  
>  enum iss_pipeline_state {
>  	/* The stream has been started on the input video node. */
> -	ISS_PIPELINE_STREAM_INPUT = 1,
> +	ISS_PIPELINE_STREAM_INPUT = BIT(0),
>  	/* The stream has been started on the output video node. */
> -	ISS_PIPELINE_STREAM_OUTPUT = (1 << 1),
> +	ISS_PIPELINE_STREAM_OUTPUT = BIT(1),
>  	/* At least one buffer is queued on the input video node. */
> -	ISS_PIPELINE_QUEUE_INPUT = (1 << 2),
> +	ISS_PIPELINE_QUEUE_INPUT = BIT(2),
>  	/* At least one buffer is queued on the output video node. */
> -	ISS_PIPELINE_QUEUE_OUTPUT = (1 << 3),
> +	ISS_PIPELINE_QUEUE_OUTPUT = BIT(3),
>  	/* The input entity is idle, ready to be started. */
> -	ISS_PIPELINE_IDLE_INPUT = (1 << 4),
> +	ISS_PIPELINE_IDLE_INPUT = BIT(4),
>  	/* The output entity is idle, ready to be started. */
> -	ISS_PIPELINE_IDLE_OUTPUT = (1 << 5),
> +	ISS_PIPELINE_IDLE_OUTPUT = BIT(5),
>  	/* The pipeline is currently streaming. */
> -	ISS_PIPELINE_STREAM = (1 << 6),
> +	ISS_PIPELINE_STREAM = BIT(6),
>  };
>  
>  /*
> @@ -119,9 +119,9 @@ struct iss_buffer {
>  
>  enum iss_video_dmaqueue_flags {
>  	/* Set if DMA queue becomes empty when ISS_PIPELINE_STREAM_CONTINUOUS */
> -	ISS_VIDEO_DMAQUEUE_UNDERRUN = (1 << 0),
> +	ISS_VIDEO_DMAQUEUE_UNDERRUN = BIT(0),
>  	/* Set when queuing buffer to an empty DMA queue */
> -	ISS_VIDEO_DMAQUEUE_QUEUED = (1 << 1),
> +	ISS_VIDEO_DMAQUEUE_QUEUED = BIT(1),
>  };
>  
>  #define iss_video_dmaqueue_flags_clr(video)	\

-- 
Regards,

Laurent Pinchart
