Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A994A53F186
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiFFVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiFFVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:20:08 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5962215
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:20:07 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2cd424b9cso20724855fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PcUJMsE22PYq+FyjhmAfpnSlrIsq/ysnRAwNN0aJxE=;
        b=cFIig+iuLezd7UpzZyzFTJMfFClnhdvrZy+bypNFh4PXyrr1gsDRcuefxKgXq3e9NJ
         0b8HdCqqgAKQkawwFKrCrUAiqW4yi+IDGbAohG78cei+TRymvdabboTzOHh7iLDXgTmV
         W/fLZr0IYhAeYFX7hXPHRcOSNl/liIEM9qIo4qh6EUG5hwmVFExNfUcuyj4rXw44wYpy
         maSuNlyvsiQM0CDlWDq0Bi9K0QrfOj1zkoJPjcZQ+TSKvR14s0rF/v56ZQz9emef+nyk
         hGNtRCWsPK4X4XmZxxdM49nzhLKYuDFuQ6+E+a/amc9fW9jlTls7M6x0bE3q6RN3QqD7
         cesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PcUJMsE22PYq+FyjhmAfpnSlrIsq/ysnRAwNN0aJxE=;
        b=XYZwGRTg81+cYxXtN/w8veNWPJ/d0VUOuttga+BfHPY4lyyKlFhkA/nGe9Ds1q+rXN
         KSwuy/Ww/Ak7MQfJKNQjp6ClhEtAGnVDsr0CsUnejdZwCZQlrSSazM7BhqEi8nnnwpTt
         4HAWKlXZpJ58LSE/UjprcxGYhz0yHZSmA8loPaV6AKut9TG7GfAMfxRqAXyw3723wmDM
         vjBY2su17/j+tNzXJwIO2C9JaU6gtkUveSokg4MugVQqND7D1DclGuGQLIV4HdFLRYts
         BsdOOmdW0uLbj4gdQ8dklu4AzF2O/gXtnpuSAtZhdNGFijwdn00OMUMPTGtd2N2AI5rZ
         3HgQ==
X-Gm-Message-State: AOAM530VP9OSzxwC5LLzXeKFAVde9X8BGJJtIjTHkQWV5vdaNX2cAKmF
        ddqLzNE5mOfdPMNUWXLvTfXKNnTiemWE8w==
X-Google-Smtp-Source: ABdhPJxSVw0Ka4pnnTRj95ab0a4BoYO4I+R34kBd+OcFd6uj/aq/Jl7ry5WyjAv2FpyNUdgfw/2ctQ==
X-Received: by 2002:a05:6870:7099:b0:f1:b164:59ee with SMTP id v25-20020a056870709900b000f1b16459eemr14842915oae.21.1654550406920;
        Mon, 06 Jun 2022 14:20:06 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bc32-20020a05682016a000b0035eb4e5a6dasm8361956oob.48.2022.06.06.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:20:06 -0700 (PDT)
Date:   Mon, 6 Jun 2022 14:22:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix double pm_runtime_disable() call
Message-ID: <Yp5wF2FJ0lCvkUGH@ripper>
References: <20220606211305.189585-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606211305.189585-1-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jun 14:13 PDT 2022, Maximilian Luz wrote:

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

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 4e665c806a14..f944b69e2a25 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1057,7 +1057,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>  	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>  		release_firmware(adreno_gpu->fw[i]);
>  
> -	pm_runtime_disable(&priv->gpu_pdev->dev);
> +	if (pm_runtime_enabled(&priv->gpu_pdev->dev))
> +		pm_runtime_disable(&priv->gpu_pdev->dev);
>  
>  	msm_gpu_cleanup(&adreno_gpu->base);
>  }
> -- 
> 2.36.1
> 
