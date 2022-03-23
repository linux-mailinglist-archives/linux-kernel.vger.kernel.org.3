Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16564E52BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbiCWNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiCWNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:07:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE5D75E71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:05:38 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id k125so973890qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jP6H13YhnBeGfeYQzZ93Xibqu7njgIeGZjFH0n7MMa4=;
        b=SVuc3CYsfFZNSxW31DMhZalADPrE6ytJWJ6fYRABmZqRer+hM1I5sG3ysnQbaxX4az
         /I/tZmgbtqDnzRocLG4qvhI3WC7KFv99yPUmBamXoar2jTVUHmUsWCBOEtSt030geA+U
         BEo2lntsE18w76kHid7lCBUoYeLCPKnyLwb/uDub7zaDZgbAk7sKZ+WosvjO6GsGVHOD
         mEAWa2d0YNJ/RF3nXsSu1J/h0IRdieGzc57FA36WG4Fqe5mNM3AH6w/hRFMRGOGikpoM
         0671oZPiP9IfaSvLOmcDSuBI+oXLGMbCKQ6ucMVCNzJTuimOc+rhbN5QnXPHA9mopXvi
         qX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jP6H13YhnBeGfeYQzZ93Xibqu7njgIeGZjFH0n7MMa4=;
        b=OMzPi+GEHH7nZYp1D/6FNU8aHgs9kS47DRD6Rkdzj6ZW2n8iKejT06K8+0wNLPdo9j
         81goOpdqAuweaMJ87BK5w4F67IvDs1YFXXOByu8Sn9GY8tBE1lUDW7FE3wkzoKmT7Y8o
         lUFf2Lbzy2gSQ14w/HPOtAGptRgvIRv1LmxJiGFcTVVPRWSisLK9+JrzNkuaBbuh8mZV
         R3CuoGJSestROuIzzTA2X53Hg8ewbNe1AOFxwMir6RTw/pTMd/jfNpvJjtfQT1HNfNlx
         YZ0DcIvLR2qeNIdQgu+rEwcPAI6su58fxjVALgYNRo6zLJDTjLTUOfmt/Am8qE563q6F
         /3sg==
X-Gm-Message-State: AOAM531ejgwzWxYD2afAgtwCLBUECjD4A7mOhqZhTxgqlrVPMDoSWYP1
        29i8q+4HM8JJWyxri5wfk4pC4w==
X-Google-Smtp-Source: ABdhPJyTImRZbWZybzHwuqooxwilNQZaFKxrxF+882HKRVaCtSuV6OwyhLLuhF5MwvoGm5gl2Whr5A==
X-Received: by 2002:a05:620a:45a1:b0:67d:af98:10d5 with SMTP id bp33-20020a05620a45a100b0067daf9810d5mr18580578qkb.1.1648040737316;
        Wed, 23 Mar 2022 06:05:37 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id y15-20020a05622a004f00b002e1aaa1738dsm16215255qtw.12.2022.03.23.06.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:05:36 -0700 (PDT)
Message-ID: <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Date:   Wed, 23 Mar 2022 09:05:35 -0400
In-Reply-To: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
References: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

thanks for giving a second look a this issue.

Le mardi 22 mars 2022 à 16:23 +0300, Dmitry Osipenko a écrit :
> Use data offsets provided by applications for multi-planar capture
> buffers. This allows V4L to import and use dma-bufs exported by other
> subsystems in cases where application wants to customize data offsets
> of capture buffers in order to meet hardware alignment requirements of
> both dma-buf exporter and importer.
> 
> This feature is wanted for providing a better support of media hardware
> found on Chromebooks. In particular display and camera ISP hardware of
> Rockchip and MediaTek SoCs require special handling by userspace because
> display h/w has specific alignment requirements that don't match default
> alignments expected by V4L and there is a need to customize the data
> offsets in case of multi-planar formats.
> 
> Some drivers already have preliminary support for data offsets
> customization of capture buffers, like NVIDIA Tegra video decoder driver
> for example, and V4L allows applications to provide data offsets for
> multi-planar output buffers, let's support such customization for the
> capture buffers as well.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  Documentation/userspace-api/media/v4l/buffer.rst | 9 ++++++++-
>  drivers/media/common/videobuf2/videobuf2-v4l2.c  | 7 +++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
> index 4638ec64db00..75b1929e2acb 100644
> --- a/Documentation/userspace-api/media/v4l/buffer.rst
> +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> @@ -369,13 +369,20 @@ struct v4l2_plane
>        - ``data_offset``
>        - Offset in bytes to video data in the plane. Drivers must set this
>  	field when ``type`` refers to a capture stream, applications when
> -	it refers to an output stream.
> +	it refers to an output or capture stream.

There is a clear contradiction in this paragraph. Both the driver and the
application MUST set the data_offset.

Would it be possible to demo your idea by implementing this in a virtual driver
? vivid already have data_offset for capture in some cases, you could verify if
your idea works without any conflict in this scenario.

>  
>  	.. note::
>  
>  	   That data_offset is included  in ``bytesused``. So the
>  	   size of the image in the plane is ``bytesused``-``data_offset``
>  	   at offset ``data_offset`` from the start of the plane.
> +
> +	   For capture planes data_offset may be specified by applications
> +	   and by drivers. Driver may override application's offset or error
> +	   out buffer if offset can't be satisfied by hardware. This allows
> +	   applications to customize data offsets of imported dma-bufs.
> +	   Handling of application's offsets is driver-dependent, application
> +	   must use the resulting buffer offset.
>      * - __u32
>        - ``reserved[11]``
>        - Reserved for future use. Should be zeroed by drivers and
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 6edf4508c636..929107a431cc 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -263,6 +263,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
>  						psrc->bytesused : pdst->length;
>  				pdst->data_offset = psrc->data_offset;
>  			}
> +		} else {
> +			for (plane = 0; plane < vb->num_planes; ++plane) {
> +				struct vb2_plane *pdst = &planes[plane];
> +				struct v4l2_plane *psrc = &b->m.planes[plane];
> +
> +				pdst->data_offset = psrc->data_offset;
> +			}
>  		}
>  	} else {
>  		/*

