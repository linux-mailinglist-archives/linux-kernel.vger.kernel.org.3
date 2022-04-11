Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7DC4FBDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbiDKNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346748AbiDKNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:52:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42424090
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:50:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b189so10631401qkf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Ee9cHL3O4lr4TWLTa3s8ofVsmmXbJuEmkg2vJR97Q5M=;
        b=geFfMqZanAauvixw04TDDWB3pMYfZF9YMaeCNuqqMuK6YkEaHIg4N1WFuR4NOYrm81
         Pnib5t96sONoKMMf4N2OqlROMFFoiaxYbCYq9KUk8X8jYh0bKYEEf1ICMCVk2Lk8FqCZ
         our+s6P0g2iNTgCFt4oOnsN5lCEbmpTor8e88Q/R7VFbajcUFp0qRQpP8PDJeeNeKSEJ
         xG7PiCjQxlk31z+0y3byT95S9aQMc63CjYB2et+CwkcHyz71p9OP9B46ysKxDT4uVMLO
         qx7c9aVlQGJZqNabQWdONLPve3Qyk/SnHsB3Y9Ss3uFaQ7M4665lJcaTjUuG/MNrw0ln
         myXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Ee9cHL3O4lr4TWLTa3s8ofVsmmXbJuEmkg2vJR97Q5M=;
        b=sFnOSgGfdGBNXPU3IbXPdZEvIArPFwAJ64yyCKeu9puF8HwdVdOpPoHHQAUxwMwCml
         F1ESLkjU/LB1tP90LXv1MZO6AeL/TXnj3OGrMQfX0+X54wNYaUNkm3daTzYxLHG+tl4I
         hNOavOx5OOhV/herFx01Vk72m9c3mt4SdtvlTOM2LzsABPqdmV53mvnADm19zOGwcACa
         QXjpdf8IFTumglZnJUUY+WQO7wpFnc4dCmwrEX2ZfUARDZaUjY5cID8mPgI9qeS/nk4r
         doPVwHGYMUO1ZRgSCbuVI6xrPMBdKJOroEMhIEdH2DB0RdVXqz6CiWJSJbBCf4ug6L5j
         6zIQ==
X-Gm-Message-State: AOAM530hg9TFg/GgtNzXnzZxk/yIW9kK9oIdQ1E+OgF6GGUR9DNbveRM
        CS77ufstIh8XwAo2lwIk+sN+3w==
X-Google-Smtp-Source: ABdhPJzTPsAEpa9EYwweA9WGhebfnIttjIU58Yz6eHg0zov/iI3h1PCXca6xczQJyN45UetI2l6wKg==
X-Received: by 2002:a05:620a:121c:b0:67d:da02:19e3 with SMTP id u28-20020a05620a121c00b0067dda0219e3mr21500316qkj.173.1649685016543;
        Mon, 11 Apr 2022 06:50:16 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id p8-20020a05620a15e800b0069c1006a883sm3162930qkm.2.2022.04.11.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:50:16 -0700 (PDT)
Message-ID: <854cc6172735360f73d5a93ddadbb3030cc1a57b.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: v4l: Add H265 pixel format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     James_Lin <Ping-lei.Lin@mediatek.com>, linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ming Qian <ming.qian@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lecopzer.chen@mediatek.com,
        max.yan@mediatek.com, sherlock.chang@mediatek.com,
        tm.wu@mediatek.com
Date:   Mon, 11 Apr 2022 09:50:14 -0400
In-Reply-To: <20220411080120.26008-3-Ping-lei.Lin@mediatek.com>
References: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com>
         <20220411080120.26008-3-Ping-lei.Lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 11 avril 2022 =C3=A0 16:01 +0800, James_Lin a =C3=A9crit=C2=A0:
> Add H265 pixel format.
> So driver can recognize external camera devices=20
> whom use h265 to describe High Efficiency Video Coding method.
>=20
> Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-compressed.rst      | 10 ++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                   |  1 +
>  include/uapi/linux/videodev2.h                         |  1 +
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 967fc803ef94..75292aafe2eb 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -36,6 +36,16 @@ Compressed Formats
>        - MPEG multiplexed stream. The actual format is determined by
>  	extended control ``V4L2_CID_MPEG_STREAM_TYPE``, see
>  	:ref:`mpeg-control-id`.
> +    * .. _V4L2-PIX-FMT-H265:
> +
> +      - ``V4L2_PIX_FMT_H265``

Please name this V4L2_PIX_FMT_HEVC. This has been discussed few years ago,
related to the staging V4L2_PIX_FMT_HEVC_SLICE format (which is being worke=
d on
to be taken out of staging). HEVC was preferred over H.265, so lets be
consistent now that decision has been made.

> +      - 'H265'
> +      - H.265 Access Unit.
> +	The decoder expects one Access Unit per buffer.
> +	The encoder generates one Access Unit per buffer.
> +	If :ref:`VIDIOC_ENUM_FMT` reports ``V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM=
``
> +	then the decoder has no	requirements since it can parse all the
> +	information from the raw bytestream.
>      * .. _V4L2-PIX-FMT-H264:
> =20
>        - ``V4L2_PIX_FMT_H264``
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 96e307fe3aab..aeaeb29307a4 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1402,6 +1402,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_JPEG:		descr =3D "JFIF JPEG"; break;
>  		case V4L2_PIX_FMT_DV:		descr =3D "1394"; break;
>  		case V4L2_PIX_FMT_MPEG:		descr =3D "MPEG-1/2/4"; break;
> +		case V4L2_PIX_FMT_H265:		descr =3D "H.265"; break;
>  		case V4L2_PIX_FMT_H264:		descr =3D "H.264"; break;
>  		case V4L2_PIX_FMT_H264_NO_SC:	descr =3D "H.264 (No Start Codes)"; brea=
k;
>  		case V4L2_PIX_FMT_H264_MVC:	descr =3D "H.264 MVC"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3768a0a80830..636e4236bfb8 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -691,6 +691,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J', 'P', 'E', 'G') /* JFIF JP=
EG     */
>  #define V4L2_PIX_FMT_DV       v4l2_fourcc('d', 'v', 's', 'd') /* 1394   =
       */
>  #define V4L2_PIX_FMT_MPEG     v4l2_fourcc('M', 'P', 'E', 'G') /* MPEG-1/=
2/4 Multiplexed */
> +#define V4L2_PIX_FMT_H265     v4l2_fourcc('H', '2', '6', '5') /* H265 wi=
th start codes */
>  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 wi=
th start codes */
>  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 =
without start codes */
>  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MV=
C */

