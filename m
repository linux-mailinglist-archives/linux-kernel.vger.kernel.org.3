Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47A4843BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiADOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiADOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:51:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA3C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:51:50 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3436852pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBOXIVJ/9ODRpWZ2t8YyvwewRSLcB73KHVDeto9Ufug=;
        b=KZJ4ya+ftRXuPa8G4YHTOBQ3griEfMcCR1C3oLa/22nrJthnlj/7JXl3kLymIfmE+Z
         8qXQD62z1VuPVf1sWJWl8zA7Cwl0jvEI0ouyM3m40IVAZyPpkvrf57JHPouEBZrDqsgs
         Flqt937S+Wo5YQaLzYlc18KL+HC2xiAc3oFVf4KWIReD8xEAm0PdfOvTXsDh1QajT4Lo
         WOjY6UI7aYFiAgES04j23tFHWH6QRnPszMnsXgs4hhvOZFIzAKDD2wENDtcyA+ExyBSN
         TvAjudH+SYU9oPFQ4AkKIxdjvgpbJF8TqS7XnVVfgOumqP3MsWDCE6xqWYB+WnqKye32
         T8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBOXIVJ/9ODRpWZ2t8YyvwewRSLcB73KHVDeto9Ufug=;
        b=s+jO9Z7MttHexx/YgVmVowGoNREPXzF0rwA0LZqJFKfDcQ5jskQXZrx7rBMtdijsua
         IjwgiAKpZqwyvIXf28Ubh4DDlr6WyGuYj2zNOxlkLnaWtXi8+QgAiZJVdf88X4RZSDDJ
         3OEJQjHZ04h/85P0dlrDVVPHp3qp0H0Hl6P/D2jqOz9lRuZV2d4xR1IPB0Tezu7n8VQ9
         +cRTGIC+umNAXUQZqKzvsJajXT2x0zuB/465yy8fFF5lkHfEn1DEjH/QfgeYAvXUqboo
         aTCIpNS2AGx1kiMh2zndI+/6UUOfOrrPHs9x3yCT5/vMyNdZztWg6slF0xfICvcaRpOO
         WY4w==
X-Gm-Message-State: AOAM531wO32AEG1ZUYPAGbLllZ2+KxKCcbB9ov99gNagp6BDRoq53Zgv
        ZsLSrEGJNVb4dInLUg+RZ98vubBg9d2f2b9/C8qOUg==
X-Google-Smtp-Source: ABdhPJz+zYhSn8IUBdNrZg8WUxNS8+LtGVq0PzMyiztWuIZnBFINgnSywxDOxIECCUvUP8a7Sa/6f5NhlXBuX8Pmvnk=
X-Received: by 2002:a17:902:b189:b0:149:6c45:24c with SMTP id
 s9-20020a170902b18900b001496c45024cmr42976481plr.21.1641307909619; Tue, 04
 Jan 2022 06:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20211109024237.3354741-1-xji@analogixsemi.com> <20211109024237.3354741-2-xji@analogixsemi.com>
In-Reply-To: <20211109024237.3354741-2-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 15:51:38 +0100
Message-ID: <CAG3jFyu-JtZRHod7fv_J7y5CrBo+2BMdOCLMnP2qEfP-kKLUPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: anx7625: add audio codec .get_eld support
To:     Xin Ji <xji@analogixsemi.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        dan.carpenter@oracle.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, sam@ravnborg.org, pihsun@chromium.org,
        tzungbi@google.com, maxime@cerno.tech, drinkcat@google.com,
        hsinyi@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 at 03:43, Xin Ji <xji@analogixsemi.com> wrote:
>
> Provide .get_eld interface in hdmi_codec_ops for hdmi-codec driver.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 6d93026c2999..67a87d21b0ba 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1821,9 +1821,27 @@ static int anx7625_audio_hook_plugged_cb(struct device *dev, void *data,
>         return 0;
>  }
>
> +static int anx7625_audio_get_eld(struct device *dev, void *data,
> +                                u8 *buf, size_t len)
> +{
> +       struct anx7625_data *ctx = dev_get_drvdata(dev);
> +
> +       if (!ctx->connector) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "connector not initial\n");
> +               return -EINVAL;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "audio copy eld\n");
> +       memcpy(buf, ctx->connector->eld,
> +              min(sizeof(ctx->connector->eld), len));
> +
> +       return 0;
> +}
> +
>  static const struct hdmi_codec_ops anx7625_codec_ops = {
>         .hw_params      = anx7625_audio_hw_params,
>         .audio_shutdown = anx7625_audio_shutdown,
> +       .get_eld        = anx7625_audio_get_eld,
>         .get_dai_id     = anx7625_hdmi_i2s_get_dai_id,
>         .hook_plugged_cb = anx7625_audio_hook_plugged_cb,
>  };
> --
> 2.25.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
