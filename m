Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645DF51B3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiEDXs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380985AbiEDXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:33:01 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAF84EA0A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:29:23 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s30so4986086ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqX+L5cVy9yuijOOGbq7nlWB+gmtg3F+IWXWN44DMBE=;
        b=QsvQ5T9IwqqH17femP+peY5sAMty2MPUZRAw/FLwMCzKzi7C0jhCBphfokWbOeiHnc
         dl8jszpvhrnPwuF0BWqovYx/GrhaeL4vE807HEsC56BVp68TRsa3ZNILYAl71f7GbDJH
         7nBCrpxtmhjlcc2/J7wVUULquRxvoN3KRr7Nz774xzdz0f0OWHdDqgfSBcwNKdFyXWMV
         4zP8jOr7/ppH4N0JKI5dwLRkJo9mTy6rnRZzcvM661wwPckNhaYTXz1DePts+/Rq3WKr
         UU1knId8aEnkIr1vSO33NLwk45xH3GGyzthL4/JkHzfvj05kWApqJmF7nwjX8FyjWd+q
         ckUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqX+L5cVy9yuijOOGbq7nlWB+gmtg3F+IWXWN44DMBE=;
        b=WaYVmh9bZgcs2WQnjFhanaQJcFDBoCVJGvEUXZDxQh2BUECpcL+z0m+/We6sxQGWAl
         gMjKQAilECQNArd+YqbMdn8eY9Z+qpisEYIR4e6lMpCR82HSF20iVteSzD4sCNvzlA/K
         LoEzf7K8U+tqKtYyJ2sxLQccpDjXZI36fzUCFBbx/m4vmUXYZ4Vb3BPN4NnWXkcJTbFx
         zWZSKsW6RxZ6KkX6ZA7AFfrowDsBPwKz1L982xZfK32aM3CB7q7kkJjbfx+imuYS4fcu
         DHyyvkWOj0XqPh0OQyUihpLkSy6HNwX7Y18ycWTv3mr91B1b9faKLRaP/13FJbpbfu7k
         CpuA==
X-Gm-Message-State: AOAM530L+Id1tvuCNJJkSNWLkyqO9Gdb5VYKAdXkul69PBlVQIyh0TOr
        QdEVtpT769kDk1D7trylUIVONym5AVHZVoYfFgmMZg==
X-Google-Smtp-Source: ABdhPJzHBdF1qHog06CxD1COyrSa67chWC4xlJIq7rwwRB+cyMCW7wqHzEZ/msxnTR9oNX17rUaPC8UqRu5tr/HXluA=
X-Received: by 2002:a25:b1a5:0:b0:648:e230:aef with SMTP id
 h37-20020a25b1a5000000b00648e2300aefmr20592121ybj.175.1651706963203; Wed, 04
 May 2022 16:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220504154909.1.Iaebd35e60160fc0f2a50fac3a0bf3b298c0637c8@changeid>
In-Reply-To: <20220504154909.1.Iaebd35e60160fc0f2a50fac3a0bf3b298c0637c8@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 5 May 2022 02:29:12 +0300
Message-ID: <CAA8EJpqfKKELrkRS89ssDU_bP67_sJ06B6VGGSmR_=D4bV-wZg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix shutdown
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Sean Paul <sean@poorly.run>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Xu Wang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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

On Thu, 5 May 2022 at 01:49, Douglas Anderson <dianders@chromium.org> wrote:
>
> When rebooting on my sc7280-herobrine based device, I got a
> crash. Upon debugging, I found that I was in msm_drv_shutdown() and my
> "pdev" was the one associated with mdss_probe().
>
> From source, I found that mdss_probe() has the line:
>   platform_set_drvdata(pdev, mdss);
> ...where "mdss" is of type "struct msm_mdss *".
>
> Also from source, I saw that in msm_drv_shutdown() we have the line:
>   struct msm_drm_private *priv = platform_get_drvdata(pdev);
>
> This is a mismatch and is the root of the problem.
>
> Further digging made it apparent that msm_drv_shutdown() is only
> supposed to be used for parts of the msm display framework that also
> call msm_drv_probe() but mdss_probe() doesn't call
> msm_drv_probe(). Let's remove the shutdown functon from msm_mdss.c.
>
> Digging a little further, code inspection found that two drivers that
> use msm_drv_probe() weren't calling msm_drv_shutdown(). Let's add it
> to them.
>
> Fixes: ecb23f2e3009 ("drm/msm: split the main platform driver")

More likely:
Fixes: 6874f48bb8b0 ("drm/msm: make mdp5/dpu devices master components")

With that fixed:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 1 +
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 1 +
>  drivers/gpu/drm/msm/msm_mdss.c           | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 143d6643be53..2b9d931474e0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1350,6 +1350,7 @@ MODULE_DEVICE_TABLE(of, dpu_dt_match);
>  static struct platform_driver dpu_driver = {
>         .probe = dpu_dev_probe,
>         .remove = dpu_dev_remove,
> +       .shutdown = msm_drv_shutdown,
>         .driver = {
>                 .name = "msm_dpu",
>                 .of_match_table = dpu_dt_match,
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 9b7bbc3adb97..3d5621a68f85 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -1009,6 +1009,7 @@ MODULE_DEVICE_TABLE(of, mdp5_dt_match);
>  static struct platform_driver mdp5_driver = {
>         .probe = mdp5_dev_probe,
>         .remove = mdp5_dev_remove,
> +       .shutdown = msm_drv_shutdown,
>         .driver = {
>                 .name = "msm_mdp",
>                 .of_match_table = mdp5_dt_match,
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 20f154dda9cf..0454a571adf7 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -397,7 +397,6 @@ MODULE_DEVICE_TABLE(of, mdss_dt_match);
>  static struct platform_driver mdss_platform_driver = {
>         .probe      = mdss_probe,
>         .remove     = mdss_remove,
> -       .shutdown   = msm_drv_shutdown,
>         .driver     = {
>                 .name   = "msm-mdss",
>                 .of_match_table = mdss_dt_match,
> --
> 2.36.0.464.gb9c8b46e94-goog
>


-- 
With best wishes
Dmitry
