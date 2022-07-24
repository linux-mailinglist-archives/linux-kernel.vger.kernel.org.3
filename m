Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68357F434
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGXIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:53:13 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5B1409C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:53:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id q3so5555876qvp.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgawh2EwihBd+a9lkA4EHRm1K3v8qTFFJ9wLspYH2QI=;
        b=oP/YYuYQKuwrP2KQvp7PfKrUV/SuFMxjgF33t+HQhvVrZfJyVUpj/50MmgMm8v2BAI
         GjdDidp2kaGGDpEzgAXB6DBoASTffUG+uNyjxPjxLPqzDSBLLEI+DcyyGN1RUBZDnCq3
         m1tYdtuTuICDz6KQbqTHBcwHG9rAMZHZ8yQwuktIHX3aGNwOZBVDiWhFt8/js4P0Qv67
         FMIoBDcgtBH+60ixxJ95O86+XJe16I1yce/1YetaVdKd/nYx9yGaHhdqk/sNsE00e40U
         eUWPeSWVBDQs6aHpI4oJo83TeHn2LSt7BxGrS6UaYPFkn1Ut1nvbWFrNG8COiGqVJKYm
         1/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgawh2EwihBd+a9lkA4EHRm1K3v8qTFFJ9wLspYH2QI=;
        b=OfahQMfFl3Gru1Y2zbWaDD1e0zZBkshokpIj6jcikLis6t5cL0z7CAmsuQR2q6F04e
         RUeFrBVkUKmAni+nPSvo1TOzGYb/OAlyGFh9hx6uJMRyaGhtIykur4hU9Uxc1ZFniK+m
         PS3sazevtd0Fkw2bbjSUFoLvvUl0cxM/598V73/j4ENAAPic9vVJJCe5f6WAhMiDAJI4
         l1FYL9ar2kuhl/Muq283uzjFV0XlPNHWHRplM6tNn4fOjBc/6Mx7SKHrgnoQ3muUWxIK
         h1MAKjdL8ORy/tsgaLDKDE/bunt4/jzJlXRENwsZrbYnJIbrNORFH8wvbsT1C4kH4/WG
         /oYg==
X-Gm-Message-State: AJIora8adnWlBOzaVkj0gJo1kpbC218oCp/WhrxpVLif3gh91ZewpqQC
        9OxdWhw7yQlzhwH0av2f19BsaC0dd9D3mX6JE64RSg==
X-Google-Smtp-Source: AGRyM1t7U0ON5sWUG5Mxe3T8h/XHO3G+sNbnQkI4I7EAIsSJAQKa4GMRQVwizRVbpFaMulRrYTFjUlTPMWsN9IOAQGI=
X-Received: by 2002:a0c:8ecc:0:b0:473:2fa4:df7c with SMTP id
 y12-20020a0c8ecc000000b004732fa4df7cmr6098115qvb.55.1658652791805; Sun, 24
 Jul 2022 01:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220723210825.564922-1-javierm@redhat.com>
In-Reply-To: <20220723210825.564922-1-javierm@redhat.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 24 Jul 2022 11:53:00 +0300
Message-ID: <CAA8EJpqr3GmQ3=p5_02dAnrK8HrUsf1yYxVKZL6g27eZXZ_U8w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Make .remove and .shutdown HW shutdown consistent
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 at 00:09, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Drivers' .remove and .shutdown callbacks are executed on different code
> paths. The former is called when a device is removed from the bus, while
> the latter is called at system shutdown time to quiesce the device.
>
> This means that some overlap exists between the two, because both have to
> take care of properly shutting down the hardware. But currently the logic
> used in these two callbacks isn't consistent in msm drivers, which could
> lead to kernel oops.
>
> For example, on .remove the component is deleted and its .unbind callback
> leads to the hardware being shutdown but only if the DRM device has been
> marked as registered.
>
> That check doesn't exist in the .shutdown logic and this can lead to the
> driver calling drm_atomic_helper_shutdown() for a DRM device that hasn't
> been properly initialized.
>
> A situation when this can happen is when a driver for an expected device
> fails to probe, since the .bind callback will never be executed.
>
> This bug was attempted to be fixed in commit 623f279c7781 ("drm/msm: fix
> shutdown hook in case GPU components failed to bind"), but unfortunately
> it still happens in some cases.
>
> Rather than trying to keep fixing in both places, let's unify in a single
> helper function that could be used for the two callbacks.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/gpu/drm/msm/msm_drv.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 1ed4cd09dbf8..669891bd6f09 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -190,14 +190,8 @@ static int vblank_ctrl_queue_work(struct msm_drm_private *priv,
>         return 0;
>  }
>
> -static int msm_drm_uninit(struct device *dev)
> +static void msm_shutdown_hw(struct drm_device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct msm_drm_private *priv = platform_get_drvdata(pdev);
> -       struct drm_device *ddev = priv->dev;
> -       struct msm_kms *kms = priv->kms;
> -       int i;
> -
>         /*
>          * Shutdown the hw if we're far enough along where things might be on.
>          * If we run this too early, we'll end up panicking in any variety of
> @@ -205,10 +199,21 @@ static int msm_drm_uninit(struct device *dev)
>          * msm_drm_init, drm_dev->registered is used as an indicator that the
>          * shutdown will be successful.
>          */
> -       if (ddev->registered) {
> +       if (dev->registered)
> +               drm_atomic_helper_shutdown(dev);
> +}
> +
> +static int msm_drm_uninit(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct msm_drm_private *priv = platform_get_drvdata(pdev);
> +       struct drm_device *ddev = priv->dev;
> +       struct msm_kms *kms = priv->kms;
> +       int i;
> +
> +       if (ddev->registered)
>                 drm_dev_unregister(ddev);

No. The drm_dev_unregister() should come before drm_atomic_helper_shutdown().

Also drm_dev_unregister() should not be a part of .shutdown callback.
See the documentation in the drm_drv.c

> -               drm_atomic_helper_shutdown(ddev);
> -       }
> +       msm_shutdown_hw(ddev);
>
>         /* We must cancel and cleanup any pending vblank enable/disable
>          * work before msm_irq_uninstall() to avoid work re-enabling an
> @@ -1242,10 +1247,8 @@ void msm_drv_shutdown(struct platform_device *pdev)
>         struct msm_drm_private *priv = platform_get_drvdata(pdev);
>         struct drm_device *drm = priv ? priv->dev : NULL;
>
> -       if (!priv || !priv->kms)
> -               return;
> -
> -       drm_atomic_helper_shutdown(drm);
> +       if (drm)
> +               msm_shutdown_hw(drm);
>  }
>
>  static struct platform_driver msm_platform_driver = {
> --
> 2.37.1
>


-- 
With best wishes
Dmitry
