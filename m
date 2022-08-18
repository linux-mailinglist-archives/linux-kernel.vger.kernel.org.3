Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029D597E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiHRGGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiHRGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:06:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2C8B98B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:06:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b9so456041qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cT4f2XhjXBJBHTSJpC4pdUChqVFRK77ChBprqcQ+BVU=;
        b=bq60LqMxqmmufCyuH6E8yRgzSpa0YgzrXIQoeCjJyytvS1FVdZNZidQ7JY6qWrcEm+
         Aec8EbmTohoEYZdrL/KXEuBb9ei088WCipMorbwpAlwCOx+yT+hYnVFKcWDV0Uox9IBa
         eAk/QIIB7ypgUuMjQPcl3mgUEOQhVQ2AUbHgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cT4f2XhjXBJBHTSJpC4pdUChqVFRK77ChBprqcQ+BVU=;
        b=TNh9tctslBLgLZXKWsANjyGwNQpnok80XIRxrGpPsdNv/ubMHpWojJBRJDnPuYX81H
         zO8sBzBf59invgb770zYkR9PinQdtdRvJHOc/wmmr4XYBrgIM80WimX0jz55JWywdiBR
         dk/Mxij98oPTkjCSH2lcVpenLdDS6+sQY8TDmHdOzaAZOr+AGN9C6HJ1xEC2GH2qi3Rx
         we8a6gQr9rSamGboORMIMwxpibRI/OOpvsbDnFiVsgWyrZkI9Bt7+B1RavDlZ2xKPwo0
         yFkqzw9vTvTJDHIY5yBu0dD/PKdIY3E6rzCzUg31KhbTApP/9eFuqr6P6XEbIQSgS96u
         82RQ==
X-Gm-Message-State: ACgBeo27OjOHvDdZ0eK7USP3bT2tT+OHrnFDxiAPC+qItfzx+aYTYVBh
        Y6Pt15sdWLnz05vIniYad5iLZUwBgSRGRxg0
X-Google-Smtp-Source: AA6agR6VUFwKaaTjzCypNLy+zYaEAhFhiiyoI9sdL5Yaa/USzI4C6MhFafyDAylYu1JbNV8kh4XgqQ==
X-Received: by 2002:a05:620a:a95:b0:6ba:cf41:94fc with SMTP id v21-20020a05620a0a9500b006bacf4194fcmr989847qkg.671.1660802798562;
        Wed, 17 Aug 2022 23:06:38 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a430900b006af08c26774sm818362qko.47.2022.08.17.23.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 23:06:37 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31f445bd486so14636697b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:06:36 -0700 (PDT)
X-Received: by 2002:a25:a0c3:0:b0:68f:69c2:99ba with SMTP id
 i3-20020a25a0c3000000b0068f69c299bamr1428785ybm.575.1660802796196; Wed, 17
 Aug 2022 23:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220808162750.828001-1-randy.li@synaptics.com> <20220808162750.828001-3-randy.li@synaptics.com>
In-Reply-To: <20220808162750.828001-3-randy.li@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 18 Aug 2022 15:06:25 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AKjpJ+fPAeCqdNnJbS4R7SdaHkfyW4qG1xXr-sE801pQ@mail.gmail.com>
Message-ID: <CAAFQd5AKjpJ+fPAeCqdNnJbS4R7SdaHkfyW4qG1xXr-sE801pQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [WIP]: media: Add Synaptics compressed tiled format
To:     Hsia-Jun Li <randy.li@synaptics.com>
Cc:     dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.hesselbarth@gmail.com, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Aug 9, 2022 at 1:28 AM Hsia-Jun Li <randy.li@synaptics.com> wrote:
>
> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>
> The most of detail has been written in the drm.
> Please notice that the tiled formats here request
> one more plane for storing the motion vector metadata.
> This buffer won't be compressed, so you can't append
> it to luma or chroma plane.

Does the motion vector buffer need to be exposed to userspace? Is the
decoder stateless (requires userspace to specify the reference frames)
or stateful (manages the entire decoding process internally)?

Best regards,
Tomasz

>
> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> ---
>  drivers/media/v4l2-core/v4l2-common.c | 1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c  | 2 ++
>  include/uapi/linux/videodev2.h        | 2 ++
>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index e0fbe6ba4b6c..f645278b3055 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -314,6 +314,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>                 { .format = V4L2_PIX_FMT_SGBRG12,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>                 { .format = V4L2_PIX_FMT_SGRBG12,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>                 { .format = V4L2_PIX_FMT_SRGGB12,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> +               { .format = V4L2_PIX_FMT_NV12M_V4H1C, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 5, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2, .block_w = { 128, 128 }, .block_h = { 128, 128 } },
>         };
>         unsigned int i;
>
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index e6fd355a2e92..8f65964aff08 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1497,6 +1497,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>                 case V4L2_PIX_FMT_MT21C:        descr = "Mediatek Compressed Format"; break;
>                 case V4L2_PIX_FMT_QC08C:        descr = "QCOM Compressed 8-bit Format"; break;
>                 case V4L2_PIX_FMT_QC10C:        descr = "QCOM Compressed 10-bit Format"; break;
> +               case V4L2_PIX_FMT_NV12M_V4H1C:  descr = "Synaptics Compressed 8-bit tiled Format";break;
> +               case V4L2_PIX_FMT_NV12M_10_V4H3P8C:     descr = "Synaptics Compressed 10-bit tiled Format";break;
>                 default:
>                         if (fmt->description[0])
>                                 return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 01e630f2ec78..7e928cb69e7c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -661,6 +661,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
>  #define V4L2_PIX_FMT_NV12M_8L128      v4l2_fourcc('N', 'A', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
>  #define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> +#define V4L2_PIX_FMT_NV12M_V4H1C v4l2_fourcc('S', 'Y', '1', '2')   /* 12  Y/CbCr 4:2:0 tiles */
> +#define V4L2_PIX_FMT_NV12M_10_V4H3P8C v4l2_fourcc('S', 'Y', '1', '0')   /* 12  Y/CbCr 4:2:0 10-bits tiles */
>
>  /* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.htm */
>  #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8  BGBG.. GRGR.. */
> --
> 2.17.1
>
