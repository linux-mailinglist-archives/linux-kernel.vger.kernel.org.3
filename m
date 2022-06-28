Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B855155ED91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiF1TGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiF1TFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:05:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA131C122
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:05:26 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-101ec2d6087so18322583fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7rpepXQ7MoTX7jgDnqruqbXS4kYEhIFVMSPcRo6CMIA=;
        b=RV7tV4wMrVTS377CAAvh/1t4rSKEiJ9YCis3oRYHCpC5gvZQAd3ijGt+qx8y87XQ2v
         HXkrHQzQxl2HRzs18pxWd2A85m2uYNAcZxFWAlpABXhyi9DxAenGhLMGDhFngZ8gQRN3
         kciJtTxPZxw9pvlhSwDOsizpYRv/gZN2C8c+YXAz4JybN8i/Z0vXS5WsXqucQ6XI2k+m
         fQjWHlU7w4GcFDubH0GQTf2UKu9PsD7hG+XBVm7OWzS3NrhX8KyT+KlRYV1vIotVOls8
         Hi3GROfyujIRuOm65SJ9D5cA3POeVvdoBFpBjSJsY836MmT1R7vS0IVRF8AExAv6f9kk
         H/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rpepXQ7MoTX7jgDnqruqbXS4kYEhIFVMSPcRo6CMIA=;
        b=p25KVtfoNV19vNIUzIwftAMMjRsztOrRbaLE39XgoH5Pph6ucvKxjuBlEr7qDsPHCw
         qOuoTBPoIPEPc1VdR88PMWXMssCSYGUBDLEuBheXMQygJ/SHIlyuhJTicFRgIecgpGTO
         11FUp4N8RVUouAnbkvcQbzZgtHr15YVzuaIrkCRJAqO/02EYxr1p79QriBMuU0eYmnZd
         W9FQqjEr/7M9Mtkk331q4JiJKyqV/pqIB3yHo05V/pa1OoHVcVLPw3MnuhkzQCskqogp
         BgoZUJqmdejLsMSjotuwCuFl2m2fKWi3KLdTvhftGtakkW3QH3Z6BOwhVgJBIiGIO/IG
         HgLw==
X-Gm-Message-State: AJIora/auAww/j1+tqnip0ABnXrL1cNiQqUzKpq0kSoB4r/nUAo5CgwQ
        8GIQ5I1iNrZaEu568Jn2jb02vA==
X-Google-Smtp-Source: AGRyM1tOoQ4XHySVoKEHg7PMnDK8eOS/21P2AH31NPdXic4KRq7OI36aPs3Ti5RkN9Wy9jcYVCwbZg==
X-Received: by 2002:a05:6870:231d:b0:10b:7a0e:1be6 with SMTP id w29-20020a056870231d00b0010b7a0e1be6mr691329oao.114.1656443125781;
        Tue, 28 Jun 2022 12:05:25 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id 127-20020aca0785000000b00334c2e81dfbsm131742oih.0.2022.06.28.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:05:25 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:05:19 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: Fix incorrect P010 chroma order description
Message-ID: <YrtQ70tLrPgeZWzz@eze-laptop>
References: <20220627071224.16787-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627071224.16787-1-sebastian.fricke@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:12:23AM +0200, Sebastian Fricke wrote:
> The chroma order of P010 is `CbCr`,
> match with the descriptions in `include/uapi/linux/videodev2.h` and the
> documentation.
> 
> Fixes: 5374d8fb75f31 Add P010 video format
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index e2526701294e..e03362c8aef9 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1306,7 +1306,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
> -	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
> +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
> -- 
> 2.25.1
> 
