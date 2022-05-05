Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453CA51CA61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385734AbiEEUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358520AbiEEUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:16:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876075F8F4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:13:13 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f16645872fso61032177b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVqW2r817uPdyNOCQzeSiykNQjBLZlqnmk0ukNpPY5o=;
        b=E5wY6c/SFZLim2rQeH/a8VUk6EdKPIBUURuTtKw7BHXP1jFDY5UIAzlTQtI1qVbWwp
         1TtneR4ofbLPzOV23mcuTHYzkt2UxGZFrIyEfzQP41pBl25bvny2a3m38v2RaLFUwwkR
         P/Xj3JtZfXn0w8YIHqoTVF6tspAscE7PylOsrrZhOT6KM6FnjR0g9RXsWFndASM8mwJh
         pJ1nT0qM9ym9SnCWi0+OHpK1O8zAFr5o4Yslyy9xKLWVTK0Iv31JWSH7fcEkUYBIWfAK
         6YI2jKFEh0PFBl1iJ0MfeRz8pv3oCxULbpVVIhDiQZ8KLIvrBwmcUmzQoQzy+EjjVzxZ
         chCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVqW2r817uPdyNOCQzeSiykNQjBLZlqnmk0ukNpPY5o=;
        b=EiW6dgUTWegZZ3HBb+YuhaSztCW6Q+xToWvzgAI2bskzzMBnKDDMY9VJ3jhM1UlQCO
         q4dDzwoDjK7xh3ETfDphV7CqhTE0Abg5LjP0cBHnT49Qt48yfXiSpu7OEZh8OiLQUNGw
         nSLWyYWhjUCtXssBkGyhRQ3a7y7mBUMmQv+l+VaCaAPZ+tufZrscKv1YQCYqFyW2nwB+
         SRQCTdk1JchUOWkcRb6hUuUOxcnUmC7YXNunGp+7FctH1IDp+jdZ3ZLY8rq4QdXmVt75
         apblV/nIl7REqkaoi0C0Wah+aYbGUKiar2ySeEJMWK3DnfS0rLaaQ8NtK/7Z11lvTU25
         fc1Q==
X-Gm-Message-State: AOAM533HUdfQbLgOnSK6brmuciLIs9/8+YW0bp7Bjba5m7LN3RiqCKCH
        Gfq3198boQAAanbg9Eu5LHGq0/CMlRyhwvKvPNurqQ==
X-Google-Smtp-Source: ABdhPJxf6nt+/EPv5i5GoqZUPOyGE8JNHP3FJpP1Kj8fRbhVGGUVCIy2/Y2XWpd0NXo6ce1nLL2xuCYGi5cYN+Yb1zc=
X-Received: by 2002:a81:3252:0:b0:2f6:b826:2286 with SMTP id
 y79-20020a813252000000b002f6b8262286mr25248076ywy.289.1651781592767; Thu, 05
 May 2022 13:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220426114627.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
 <20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
In-Reply-To: <20220426114627.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 5 May 2022 23:13:01 +0300
Message-ID: <CAA8EJprWzJmVshrYCJXPnm9dFFCkyefOEo2z_cJdeiSj3zFaGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/probe-helper: For DP, add 640x480 if all other
 modes are bad
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, swboyd@chromium.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        robdclark@gmail.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_sbillaka@quicinc.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 21:47, Douglas Anderson <dianders@chromium.org> wrote:
>
> As per Displayport spec section 5.2.1.2 ("Video Timing Format") says
> that all detachable sinks shall support 640x480 @60Hz as a fail safe
> mode.
>
> A DP compliance test expected us to utilize the above fact when all
> modes it presented to the DP source were not achievable. It presented
> only modes that would be achievable with more lanes and/or higher
> speeds than we had available and expected that when we couldn't do
> that then we'd fall back to 640x480 even though it didn't advertise
> this size.
>
> In order to pass the compliance test (and also support any users who
> might fall into a similar situation with their display), we need to
> add 640x480 into the list of modes. However, we don't want to add
> 640x480 all the time. Despite the fact that the DP spec says all sinks
> _shall support_ 640x480, they're not guaranteed to support it
> _well_. Continuing to read the spec you can see that the display is
> not required to really treat 640x480 equal to all the other modes. It
> doesn't need to scale or anything--just display the pixels somehow for
> failsafe purposes. It should also be noted that it's not hard to find
> a display hooked up via DisplayPort that _doesn't_ support 640x480 at
> all. The HP ZR30w screen I'm sitting in front of has a native DP port
> and doesn't work at 640x480. I also plugged in a tiny 800x480 HDMI
> display via a DP to HDMI adapter and that screen definitely doesn't
> support 640x480.
>
> As a compromise solution, let's only add the 640x480 mode if:
> * We're on DP.
> * All other modes have been pruned.
>
> This acknowledges that 640x480 might not be the best mode to use but,
> since sinks are _supposed_ to support it, we will at least fall back
> to it if there's nothing else.
>
> Note that we _don't_ add higher resolution modes like 1024x768 in this
> case. We only add those modes for a failed EDID read where we have no
> idea what's going on. In the case where we've pruned all modes then
> instead we only want 640x480 which is the only defined "Fail Safe"
> resolution.
>
> This patch originated in response to Kuogee Hsieh's patch [1].
>
> [1] https://lore.kernel.org/r/1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
>  drivers/gpu/drm/drm_probe_helper.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 819225629010..90cd46cbfec1 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -476,7 +476,6 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>         const struct drm_connector_helper_funcs *connector_funcs =
>                 connector->helper_private;
>         int count = 0, ret;
> -       bool verbose_prune = true;
>         enum drm_connector_status old_status;
>         struct drm_modeset_acquire_ctx ctx;
>
> @@ -556,8 +555,8 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>                 DRM_DEBUG_KMS("[CONNECTOR:%d:%s] disconnected\n",
>                         connector->base.id, connector->name);
>                 drm_connector_update_edid_property(connector, NULL);
> -               verbose_prune = false;
> -               goto prune;
> +               drm_mode_prune_invalid(dev, &connector->modes, false);
> +               goto exit;
>         }
>
>         count = (*connector_funcs->get_modes)(connector);
> @@ -580,9 +579,26 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>                 }
>         }
>
> -prune:
> -       drm_mode_prune_invalid(dev, &connector->modes, verbose_prune);
> +       drm_mode_prune_invalid(dev, &connector->modes, true);
>
> +       /*
> +        * Displayport spec section 5.2.1.2 ("Video Timing Format") says that
> +        * all detachable sinks shall support 640x480 @60Hz as a fail safe
> +        * mode. If all modes were pruned, perhaps because they need more
> +        * lanes or a higher pixel clock than available, at least try to add
> +        * in 640x480.
> +        */
> +       if (list_empty(&connector->modes) &&
> +           connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
> +               count = drm_add_modes_noedid(connector, 640, 480);
> +               if (_drm_helper_update_and_validate(connector, maxX, maxY, &ctx)) {
> +                       drm_modeset_backoff(&ctx);
> +                       goto retry;
> +               }
> +               drm_mode_prune_invalid(dev, &connector->modes, true);
> +       }
> +
> +exit:
>         drm_modeset_drop_locks(&ctx);
>         drm_modeset_acquire_fini(&ctx);
>
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>


-- 
With best wishes
Dmitry
