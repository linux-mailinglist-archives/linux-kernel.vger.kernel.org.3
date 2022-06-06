Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3A53F1AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiFFVXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiFFVXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:23:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E01CA3C3;
        Mon,  6 Jun 2022 14:23:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h5so21535943wrb.0;
        Mon, 06 Jun 2022 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfY6X4JVQBiL9H59caeTHODekDNJrKZ9yOY0lERy7u8=;
        b=hB1aabYJ45U2sFPdevy3YeJni7Yu6ezotGBopOjnkmWkjU/AuETPp+3LFizhsX6tq5
         3uP4UmZ7ADOQPWyeb31hAWbN5Ephl7ItZ0AHOP5RK8Hfzx2OlYj12cNBpwmDWOeuwcbE
         N7gDX4M415mCo4i9W3ZoTKZq8oUFaSTmCiee7LojVRUgclJ01SlozBSzzc/gZq6qMVtp
         XgwOAd2xdIZ5QCY8dxJ7V7yGiCYW3pJChjteIzbd+nNUfJLTrq8xxWcyEQQzvoqn2DrB
         L/UcIcEkGAYUOJKzxI5xCyJLJKBi3fu55DkkwqAorZhreHxkRBfn/R6NCpIFYHpJAjKs
         zYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfY6X4JVQBiL9H59caeTHODekDNJrKZ9yOY0lERy7u8=;
        b=A2dPmdxn8nl2RBTMzhJtkuiFGYqlnJaAOlosX/L1W3WcdVE1VSrivyYGIqPCmqLe9K
         5XxbZKCSDzKtSBEIaSTOm4NrBX0geUeW1rBh4ZJhyAyRbG3TdOXBJhGCsNR9z3Dz69x6
         pl4gbf7eIoelHk2W1b8bW8gUjAteJDz1fES9a9k5k/eVrHBIU5iAs3Ssn1RconiOAZWV
         o9g/VXg1FHzGVpo7MUdGE5NAc/wg5u+kRXuwG/g7eoaot9v9OiuhTreY8hRLtciW67za
         079ooDrrOQs5N+pGEtONn2jzCP2WWEtMDXWAXbY5fQXNXDEzlX3VaMakpitAFy0A25BV
         zEkw==
X-Gm-Message-State: AOAM531qcBHovQ/L9HrbE8M4xn3ENJ1NKRMoEZMEFOvshB2umSvYo/zl
        mjMQGx8XI8J4AbBL7x4C0Dvq77e92KbrFKYY7mQ=
X-Google-Smtp-Source: ABdhPJzFe0DtmvJNvXSibzfXuetpXq7Ja76dWcSijzRDnmzdipQLnwN4INHe/Cq5C9hjS/IYOl3FwnxWJFHSB1bzKdY=
X-Received: by 2002:a05:6000:547:b0:20f:ca41:cc51 with SMTP id
 b7-20020a056000054700b0020fca41cc51mr24126476wrf.221.1654550613305; Mon, 06
 Jun 2022 14:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220606211305.189585-1-luzmaximilian@gmail.com>
In-Reply-To: <20220606211305.189585-1-luzmaximilian@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 6 Jun 2022 14:23:34 -0700
Message-ID: <CAF6AEGuJQt9D1+Q6xcKw=AYMZUFPSUh-v2GonuahMpZ2wbx08g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix double pm_runtime_disable() call
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 2:13 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Following commit 17e822f7591f ("drm/msm: fix unbalanced
> pm_runtime_enable in adreno_gpu_{init, cleanup}"), any call to
> adreno_unbind() will disable runtime PM twice, as indicated by the call
> trees below:
>
>   adreno_unbind()
>    -> pm_runtime_force_suspend()
>    -> pm_runtime_disable()
>
>   adreno_unbind()
>    -> gpu->funcs->destroy() [= aNxx_destroy()]
>    -> adreno_gpu_cleanup()
>    -> pm_runtime_disable()
>
> Note that pm_runtime_force_suspend() is called right before
> gpu->funcs->destroy() and both functions are called unconditionally.
>
> With recent addition of the eDP AUX bus code, this problem manifests
> itself when the eDP panel cannot be found yet and probing is deferred.
> On the first probe attempt, we disable runtime PM twice as described
> above. This then causes any later probe attempt to fail with
>
>   [drm:adreno_load_gpu [msm]] *ERROR* Couldn't power up the GPU: -13
>
> preventing the driver from loading.
>
> As there seem to be scenarios where the aNxx_destroy() functions are not
> called from adreno_unbind(), simply removing pm_runtime_disable() from
> inside adreno_unbind() does not seem to be the proper fix. This is what
> commit 17e822f7591f ("drm/msm: fix unbalanced pm_runtime_enable in
> adreno_gpu_{init, cleanup}") intended to fix. Therefore, instead check
> whether runtime PM is still enabled, and only disable it in that case.
>
> Fixes: 17e822f7591f ("drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 4e665c806a14..f944b69e2a25 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1057,7 +1057,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>         for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>                 release_firmware(adreno_gpu->fw[i]);
>
> -       pm_runtime_disable(&priv->gpu_pdev->dev);
> +       if (pm_runtime_enabled(&priv->gpu_pdev->dev))
> +               pm_runtime_disable(&priv->gpu_pdev->dev);
>
>         msm_gpu_cleanup(&adreno_gpu->base);
>  }
> --
> 2.36.1
>
