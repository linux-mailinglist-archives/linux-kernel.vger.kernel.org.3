Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF3487624
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbiAGLER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiAGLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:04:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF213C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:04:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k18so10315135wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYdVfhrze3PmGoBWLbqEClWHtyMjN7/HGWigZUPvV3o=;
        b=BtLrZRY5x7D9+1KKbopGNR0c8VrIy+vWl9DZ8XWSAB8IjTaa5yKWJPgg5N2jJN6E0c
         kv6W68xgY3fSeLwqiHHlKd9jx+1QA9tvvmMneSXla7xZD/gxHUs4/9qaJGfdAnxyuxh6
         4S0lWmOLep3rdrKPKiM5P/S4RYTO1rErxa4CfplYbAJV6HT5FLJnLIQMF/jF0V9BzxdQ
         r6Lpv1MV9HcphTg5z2EO972wrcWOV6JL/1F6I/cMw3P51g1SDa1cd9em0LEq5AAkVV5c
         RTjsgn2lYl2zrlXZcjsHeRGzWpGrX6FysanjgaeFIDgnrfuHYAMT3gef0w6kcAdTlMzP
         Bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYdVfhrze3PmGoBWLbqEClWHtyMjN7/HGWigZUPvV3o=;
        b=70yUvgN/VPRVX7ZQ9TvrCe9dt94LDZEvojw/IIgQgqPf7ePfYbamDNvLHTPQbJeP8i
         SY1/XCoQk647hxna0KCqyudXHtRbjiwNeNYGDbhopaG632vkakZ2hWDK9R2uK8zRCBV4
         T5vmwf27N1W2rD1WwV7HK2rxK4qn3rfuLxPFv9d9MbyyoSlGAUwD5erukU00DTjBOAz/
         66snD4PDS25uQCrmpwhr86xUFnN+GM2CkLv13c2LOn6Oebk6La8GbQSrrTnsPyza8XVI
         kflj9bjiF8hP+FBuhfC+8V3goWX8JIFeTCSgaTsMz0vRsrg+uOs1PFJGobfjKvNWa10W
         xdig==
X-Gm-Message-State: AOAM5321ZB9hZVnGKkFWtzvTJSCaJw5CG2eB9IBEu1Q26iuKISAjbs9t
        Q02hl0P/ezdtVOPuPGd5KNsfWlbDw7KZA9E5Cgs8BbCBawo=
X-Google-Smtp-Source: ABdhPJx8MflMlhSiAKN9fYc6Bm7/OBTsbY5tB727sPzZjkNslEUMFA3YP9bUTlPTVwecDtRQGKmuc1jglGwB1zVEX0s=
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr54881538wrz.261.1641553454546;
 Fri, 07 Jan 2022 03:04:14 -0800 (PST)
MIME-Version: 1.0
References: <CAPY8ntAdknutH=OmV1dWPbez1ZqLgaOj-BoQQkZAu0WbhbE6nQ@mail.gmail.com>
 <20220106124657.32737-1-linmq006@gmail.com>
In-Reply-To: <20220106124657.32737-1-linmq006@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 7 Jan 2022 11:03:57 +0000
Message-ID: <CAPY8ntAz2V81gwO6O+KxLev38Dy8wKGKW_SWDnEo8CU66qpe0w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/v3d: Fix PM disable depth imbalance in v3d_platform_drm_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eric Anholt <emma@anholt.net>, Eric Anholt <eric@anholt.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 12:47, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
>
> Fixes: 57692c9 ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for the update - that looks good to me.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
> Changes in v2
> - put pm_runtime_disable before dma_free_wc
> - rename dma_free to pm_disable
> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index bd46396a1ae0..7d500dd5314e 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -282,7 +282,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>
>         ret = v3d_gem_init(drm);
>         if (ret)
> -               goto dma_free;
> +               goto pm_disable;
>
>         ret = v3d_irq_init(v3d);
>         if (ret)
> @@ -298,7 +298,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>         v3d_irq_disable(v3d);
>  gem_destroy:
>         v3d_gem_destroy(drm);
> -dma_free:
> +pm_disable:
> +       pm_runtime_disable(dev);
>         dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
>         return ret;
>  }
> --
> 2.17.1
>
