Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048354F469C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiDEUg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442020AbiDEPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:36:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03563A76F7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:50:23 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a11so11017016qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBw5C4mAzYHBqkIcJSiLqZdE6/dGN4RirBfflfNZeZw=;
        b=cwod/pqZb/ZZ50J1wzA7SUpmhcqJ/4OQWOhBMvOgpobzAzK96fSaGe5d+kvm2ZMQYX
         qbZ6Dy9RtuWeFQrkKYdrNG/Py4GeymojXrVYVNuGlvWGVjiJfefwCxoLF9mOUIeAG8R7
         VzI5xSlVBgs99NqOxcCMknPsb6fSsu4UGL8qG3Isb8QN/BRfT68nedIEImfnc3lImVEs
         zNBtLUyjF4/+15PtRVLawLIhI27HL7LT1TtIMIWP9m58z/ILmvarq4SjnRvuGECOHPPB
         rC1YmWIJz7KB+vpaaad4x/RYT37HH6tEbLFb3Q5qG6nUxliDEgehez27PMolJ2AxXHHi
         Z3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBw5C4mAzYHBqkIcJSiLqZdE6/dGN4RirBfflfNZeZw=;
        b=HSNj6p7KpF92t11WXeMaHbzNiedkPe4QYmsZWMEEYBh1Okav9P+dzVazQZrOf73Kuz
         GysRk79RA3uilSAOxH9XtYZhYJNH68lJyCwxgk03CtXpdxHywx/Io1itQ6azAR+Ia2cO
         0hNWH1q4MHsG1Ncd1ag2FiilrCERf2/rNB7x+8H/hXVyGi7Qn/cmQwgbixe2FSd2MoCG
         NMF6oIJ86j/UnuRdnHosVCmYYKXw6YezpnJimd+MyrdFbi/XY6B3Rmct8mu1GpYxxLEi
         V+TQWeWHRgMHiGtkBH86lC9VzAVWr88+l32ZcScRTpDXEg6gE/uz+0HNGMLFzFN06SLY
         WLrg==
X-Gm-Message-State: AOAM531biRnIPKXCmPLZzormSX3PzESbhckaJyPMWsrQCqvK7Qgg8UkE
        2zNRDp/a7J7GKLbJ3C6KFIjZQRt+oIXItgDd1/ohjw==
X-Google-Smtp-Source: ABdhPJx4nj8M6K2gqZ2dD5wk8/mQwDX1/nbJ753mxmKM2qXGWJofvIUyTWtEx4xZ45vVyB8zzm8S/EPG0Xnnxqt2c8I=
X-Received: by 2002:ac8:4e52:0:b0:2e1:dad8:5141 with SMTP id
 e18-20020ac84e52000000b002e1dad85141mr3024119qtw.62.1649166622826; Tue, 05
 Apr 2022 06:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <1649166091-18032-1-git-send-email-quic_vpolimer@quicinc.com> <1649166091-18032-2-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1649166091-18032-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Apr 2022 16:50:11 +0300
Message-ID: <CAA8EJpri3MdWjGJfhSLAQwKSF-iyT-XMTxen4iu_iM68Wxp=zw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] drm/msm/disp/dpu1: add inline function to validate
 format support
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 16:41, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
>
> Check if the dpu format is supported or not using dpu_find_format.
>
> Co-developed-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 10 +++-------
>  2 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
> index 418f5ae..84b8b32 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h
> @@ -21,6 +21,28 @@ const struct dpu_format *dpu_get_dpu_format_ext(
>  #define dpu_get_dpu_format(f) dpu_get_dpu_format_ext(f, 0)
>
>  /**
> + * dpu_find_format - validate if the pixel format is supported
> + * @format:            dpu format
> + * @supported_formats: supported formats by dpu HW
> + * @num_formatss:      total number of formats
> + *
> + * Return: false if not valid format, true on success
> + */
> +static inline bool dpu_find_format(u32 format, const u32 *supported_formats,
> +                                       size_t num_formats)
> +{
> +       int i;
> +
> +       for (i = 0; i < num_formats; i++) {
> +               /* check for valid formats supported */
> +               if (format == supported_formats[i])
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +/**
>   * dpu_get_msm_format - get an dpu_format by its msm_format base
>   *                     callback function registers with the msm_kms layer
>   * @kms:             kms driver
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 6565682..3216cda 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1411,13 +1411,9 @@ static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
>         if (modifier == DRM_FORMAT_MOD_LINEAR)
>                 return true;
>
> -       if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED) {
> -               int i;
> -               for (i = 0; i < ARRAY_SIZE(qcom_compressed_supported_formats); i++) {
> -                       if (format == qcom_compressed_supported_formats[i])
> -                               return true;
> -               }
> -       }
> +       if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED)
> +               return dpu_find_format(format, qcom_compressed_supported_formats,
> +                               ARRAY_SIZE(qcom_compressed_supported_formats));
>
>         return false;
>  }
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
