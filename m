Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC180495D85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379948AbiAUKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:14:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58888 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbiAUKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:14:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FE5FB81ED6;
        Fri, 21 Jan 2022 10:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5C9C340E1;
        Fri, 21 Jan 2022 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642760092;
        bh=OxfqaqrpAaOv9SLpAlG2G9A4RfcC3FPdy8OzW+VRIo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqpDeTuXotaXme9Cb7YBjcXjYxmRDW3DqVaPf8On8G90RNfUKL1MbunQQIP20fJQi
         DcBRcpvzEOZ/aPQMbCg0QOvLhYqf5YWnwixDwY4aN1wVCBM07MyDJ+YkoOPWn9GSLm
         tPRPNI/1Z6CG61Wiee3sTreO90dOJKi5MeEF/Hao=
Date:   Fri, 21 Jan 2022 11:14:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        mchehab@kernel.org
Subject: Re: [PATCH v2] drivers: staging: media: omap4iss: Use BIT macro
 instead of left shifting
Message-ID: <YeqHmEPE695vZ3Tt@kroah.com>
References: <20220121093722.320082-1-mosescb.dev@gmail.com>
 <20220121100837.337094-1-mosescb.dev@gmail.com>
 <20220121100837.337094-2-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121100837.337094-2-mosescb.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:08:37AM +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.
> 
> Example:  1 << 7  is same as BIT(7)
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---
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
> -- 
> 2.30.2
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
