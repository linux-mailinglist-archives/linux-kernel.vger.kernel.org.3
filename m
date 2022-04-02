Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575EE4F00CD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354527AbiDBKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354552AbiDBKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:54:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD6144B40
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:52:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t21so5207507oie.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ey9vgHYF15jaDHDhev6v9T/d9GPKBVHQu6Tqb5CYYyM=;
        b=HSIAyb6agxiQlPpmDhu5VUFC8W6axguHYuWiQ1YjcJSUXFQG0Klku8VYjsWDOE1iK8
         SiaSwjmRfSzwGXb/YRwSXmKS9k9c5AQNI06TWQNPKAwbCqc9H2b6ujVz6aUZjAlzL+kN
         59GwFhWpv7ENyIQlv9nXdHYlHdOYL8WhuNF76Gbmnwypuq7t4h9piSmTuVifU4/GciDG
         U9eNehQlBIE+6GRNJHpAMDaPJU76XB0K8bcpm6RweE6DOcvLSNJu2gNSX62rtiBckmKY
         eUFRHqNv4kcD7FaGaigSnEb94x3FkF+t4HOEm2GoXli39nwcVGGd8JUE7fig4iFPYq4Z
         Tb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ey9vgHYF15jaDHDhev6v9T/d9GPKBVHQu6Tqb5CYYyM=;
        b=jJGS/aggdexpzrXMJwjbSOPAsJ/0sq/6a88xGjoRr6lqDPNge/HMQhWqOjpiZQ4O84
         Ne3ugB7tnm5HqYahRNY4xObUONcD+XN0TZ5WiWmr8YAwmy5wgeScWp66brw0n/LwzeBe
         HVlhiO8twXtk9jfylnbK6ZOriuirWy+0ZO0rJe9c0ufRC0WJcWRz/yQ7MsXLUanGk1SK
         fZn7we6AUGkd0lY9+WqBnycrBWatCkfZ//n8QxuI0PK0AYTKz1LPp9QJUtme5AkX7dnA
         vkmEJ8iYRL1vH0Smw5dVP8VxtwC0f8+5GtlWkGgT/ndl+H9yeZ3NhAA//lgJKoluXk2n
         /elg==
X-Gm-Message-State: AOAM533wZsOnf6s6GhFV7uFhHplVasTNZryrul6/IgK81rbiSgTLrI6o
        UeyFYUaE8xteCCxOY2CaAqVbiw==
X-Google-Smtp-Source: ABdhPJzAojYVGGVf2DMiQ6Yncl14J2QRw60j6diHXtf/kKGVIcqcwAN8wNu/oR/IqF6/57Pz9/oMog==
X-Received: by 2002:a05:6808:1992:b0:2da:7ea7:7ef8 with SMTP id bj18-20020a056808199200b002da7ea77ef8mr6395564oib.49.1648896746687;
        Sat, 02 Apr 2022 03:52:26 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id 20-20020a05687010d400b000de9c6d81e3sm2015920oar.58.2022.04.02.03.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:52:25 -0700 (PDT)
Date:   Sat, 2 Apr 2022 07:52:20 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/23] media: videobuf2-v4l2: Warn on holding buffers
 without support
Message-ID: <Ykgq5EWX9T7q0VEZ@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-4-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-4-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:37:05PM -0400, Nicolas Dufresne wrote:
> From: Sebastian Fricke <sebastian.fricke@collabora.com>
> 
> Using V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF flag without specifying the
> subsystem flag VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF, results in
> silently ignoring it.
> Warn the user via a debug print when the flag is requested but ignored
> by the videobuf2 framework.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 6edf4508c636..812c8d1962e0 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -329,8 +329,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
>  		 */
>  		vbuf->flags &= ~V4L2_BUF_FLAG_TIMECODE;
>  		vbuf->field = b->field;
> -		if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF))
> +		if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF)) {
> +			if (vbuf->flags & V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF)
> +				dprintk(q, 1,
> +					"Request holding buffer (%d), unsupported on output queue\n",
> +					b->index);
>  			vbuf->flags &= ~V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF;
> +		}
>  	} else {
>  		/* Zero any output buffer flags as this is a capture buffer */
>  		vbuf->flags &= ~V4L2_BUFFER_OUT_FLAGS;
> -- 
> 2.34.1
> 
