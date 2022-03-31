Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74B4EE275
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiCaUR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiCaUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:17:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F119E399
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:15:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e189so680069oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6O6TQE9gY/RCGoA8Lj72Kezh8AhkaXWoFpitVHtqqC0=;
        b=mXBaYXFodB5BNYtQLsAi85UeIgUz+rJ8jR+IjiFZ7xdlENE8KMHvCXLuuZLNbwMwx2
         woFVXRWjONwaTsuJqBRZbtbssVAObJzulRjY/OOqYy5RVGQRFUuoj6VMHtyCP+iLwZVH
         AXRy5kqcp/yQ8DrLEinN4/hL3JYxoLGiDeQ62TnzGrMe9RPKG8OTEfDdW+L+ACVrzuZC
         hCHP05rd5gQYTbLk7gzcg0t/pR1vNhlgDDfZhEBo1gk03ccs7VWJCITWMFe8GHrJaGhB
         vWi9ZMT9l5ycdy5Co2CJd8cPoiy8xAQmIdtlDAd+PzlDjajTJC0+zPiAfeEF03DmSMFZ
         w+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6O6TQE9gY/RCGoA8Lj72Kezh8AhkaXWoFpitVHtqqC0=;
        b=ntKh8JnfO/Uh1B8776cpWMugQu9nEylQSVpv9xDU0k/y8Bscoj4M0Lj7+skpz0uOX8
         OSwe17Oqg59SdP0+giewPG9Ow0gQCIjxLrvfNkKkPV6L8umKbxBD8IG6X4P4J3l/Qqjr
         YlYMwEBZORlE8H31t8IRSF6ahOpdtrzz9nEIc44gXFtw4zlH6epc1mbn7LHiIMFQd3pf
         77Wd8zWB7+VpYI7DsiLBwSj+bzTyJNRr3AxN5deHR9Co8PTDrh28CJ0ePYcYJKYcJpe4
         7d0VZwLC8fs4iqS4kB0V8alE9TWtMJmVFQYPpez5WQQfCn11SQMVfd3QDPJRmjbxLBJt
         zlfw==
X-Gm-Message-State: AOAM5312Xw7gc4TGmRz4BEg39r3l7xL6K/PSVDey7LmbWGcL7/gw9awh
        51IBEhsd9eMHmO+v+oNe0SHspQ==
X-Google-Smtp-Source: ABdhPJz0dHz0S0Kxb6XfpeUoORZA029B4Og25ME2y94yefm5MksonaTie6pvHqTlUxRYIXLjV2cN7g==
X-Received: by 2002:a05:6808:ec5:b0:2f7:4019:53be with SMTP id q5-20020a0568080ec500b002f7401953bemr3370230oiv.176.1648757737012;
        Thu, 31 Mar 2022 13:15:37 -0700 (PDT)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id z10-20020a0568301daa00b005ce0f36dd81sm252391oti.12.2022.03.31.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:15:36 -0700 (PDT)
Date:   Thu, 31 Mar 2022 17:15:31 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: hantro: Empty encoder capture buffers by default
Message-ID: <YkYL45bEwjS/1+Rs@eze-laptop>
References: <20220331084907.628349-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331084907.628349-1-wenst@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:49:06PM +0800, Chen-Yu Tsai wrote:
> The payload size for encoder capture buffers is set by the driver upon
> finishing encoding each frame, based on the encoded length returned from
> hardware, and whatever header and padding length used. Setting a
> non-zero default serves no real purpose, and also causes issues if the
> capture buffer is returned to userspace unused, confusing the
> application.
> 
> Instead, always set the payload size to 0 for encoder capture buffers
> when preparing them.
> 
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Fixes: 082aaecff35f ("media: hantro: Fix .buf_prepare")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
> 
> This was previously incorrectly squashed into my Hantro encoder cmd
> patch [1].
> 
> [1] https://lore.kernel.org/linux-media/20220301042225.1540019-1-wenst@chromium.org/
> 
>  drivers/staging/media/hantro/hantro_v4l2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 67148ba346f5..261beb0c40f6 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -733,8 +733,12 @@ static int hantro_buf_prepare(struct vb2_buffer *vb)
>  	 * (for OUTPUT buffers, if userspace passes 0 bytesused, v4l2-core sets
>  	 * it to buffer length).
>  	 */
> -	if (V4L2_TYPE_IS_CAPTURE(vq->type))
> -		vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> +	if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
> +		if (ctx->is_encoder)
> +			vb2_set_plane_payload(vb, 0, 0);
> +		else
> +			vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.35.1.1021.g381101b075-goog
> 
