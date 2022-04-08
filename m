Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757A4F9590
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiDHMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiDHMX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:23:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235F633D0F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:21:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j21so10580185qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/BWz3Pk8r30Gfc4qGV4ZOyYfEY0sq1wDYCw1e9kQ38=;
        b=K+SFu/xAxfSv8ptmfSt0vivA6W2FAX95a45VvUQlpVTHnKOdxmllKplZItjMf+HOQC
         9DYIktpng9TB25OnHxCrL64xd6fagaJZqoStF5Wx0Hy3ikDlXsYpsImSLq3jJX7NTozr
         jtJAtIG8hw7MQ1aH37SBKuyIZgS9cGBl6TipnChp/SytE1xsSgwhG4Uzcr65ZrCPcP+H
         sAhYViuQqi8e3dsmU1FBooELOGstjUC1c8KwpSr76ErlET7J3vbBGnI1/nfA4XuHLqHU
         HNG9mVm9fFu/DvOkx0m06XL6cqKui8Sturp1GWXhuphbUv9x0d4AJRfHRzn1njbuw5PG
         NScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/BWz3Pk8r30Gfc4qGV4ZOyYfEY0sq1wDYCw1e9kQ38=;
        b=VXFG7lelbxlWZdxPISR9e4Y7xpWUiI8MMy820l1fp4c5+RGcnkR5aASaT+I0CeHbhR
         G675rlw9G82dInzV/BJ3v4ByUFi24IyCTZmDmcUHEn5jXMz02wyHCye47UVoUY71p0Hq
         q2PnZ4JYCXyjBPG69yKj43zJmA6WjOQcGbWJW7lsb6Yi6fonfhN3UADBjVxTiG7ZcELr
         5d3rupysiU/19IG/O4BfT9i4HOdbG6CywEzoTqJjgPkHfB8cDsNSL/Lvb/rs1Dy0QVdZ
         hshfook1+FrOorglRQD/mYKCCwPXtosPSjLHOrVo3GWr2MkfzPA1MRzjlq3AHvYjIZGi
         aS0Q==
X-Gm-Message-State: AOAM5324fVRKy6Y3GzRyJZU+B894k5wr23gi5ZAgH0eLWxGKPhmw9emG
        /4GFtig+gkTfY+aoQKhMf9JCYVQVmUHjYLRZ3UkNuw==
X-Google-Smtp-Source: ABdhPJwFncjOacPlNFbEfJskgVWNz1y73VUg9c9DTYFByySPmUZZzySIYxy5P7V4YxD2DiJx66tjsu6VB/xf/JxBQmg=
X-Received: by 2002:ac8:7dd1:0:b0:2e0:6fe1:189b with SMTP id
 c17-20020ac87dd1000000b002e06fe1189bmr16058848qte.629.1649420512329; Fri, 08
 Apr 2022 05:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_8E2A1C78140EE1784AB2FF4B2088CC0AB908@qq.com>
In-Reply-To: <tencent_8E2A1C78140EE1784AB2FF4B2088CC0AB908@qq.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Apr 2022 15:21:42 +0300
Message-ID: <CAA8EJprFBJeQQo79LOdJR0pA75wbzM64KRnPLHqLOGJ2KpJkEg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/mdp5: check the return of kzalloc()
To:     xkernel.wang@foxmail.com
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 05:33, <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
>
> Besides, since mdp5_plane_reset() is void type, so we should better
> set `plane-state` to NULL after releasing it.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> ChangeLog:
> v1->v2 simplify the patch and update the description.
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index c6b69af..50e8542 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -90,7 +90,10 @@ static void mdp5_plane_reset(struct drm_plane *plane)
>                 __drm_atomic_helper_plane_destroy_state(plane->state);
>
>         kfree(to_mdp5_plane_state(plane->state));
> +       plane->state = NULL;
>         mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
> +       if (!mdp5_state)
> +               return;
>
>         if (plane->type == DRM_PLANE_TYPE_PRIMARY)
>                 mdp5_state->base.zpos = STAGE_BASE;
> --



-- 
With best wishes
Dmitry
