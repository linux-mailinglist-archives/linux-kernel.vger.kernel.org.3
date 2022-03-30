Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5384EBFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiC3L3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiC3L31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:29:27 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832715AAE5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:27:43 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id hu11so16574852qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/SsoG+PpKWZDfvPklFn/XSUiKVJSokW9Px0KF4dxFU=;
        b=TV8CO7mCsyY6rTwKULNk8AfGXiRuAD4fGxo59BLPKmCtSfDXZvxW+xYeEpyDsglta9
         VDZnSq8YJ6vq0bYLyG+g2ssJhSCd3a2TnzT3pNGfVekmcxdCqB2NEd89yuYfax/LVui2
         Adc1or8+g5aoNaVN9drL6wS0ov4T2gSddo4xlKagieGhP3WmFuBWv6PRrXJovbfh85q/
         C0HiIbZ13bM+1ya302EspQp/kTo3KNkATsar+r/gTtohvx+Oe7tBp1Tq+gd+whdrgqR4
         BHS8PR2/zSPrc6uir7hjx+KqchfemvvnGYQ1iI0zhxU9vGpVH2jFrsKPvokr1Hmq3suT
         P+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/SsoG+PpKWZDfvPklFn/XSUiKVJSokW9Px0KF4dxFU=;
        b=dbMrKi3qAnnFVwIbwW5p1SIA4gkAYecEndXv45u500I+hJ9O3FunD9UlIFlOV6DqFX
         laXRfIrQR8fAvrpPmStwNMAfmWT4VhY7X81DcuA0ffWiHXET6TxUBWbKvGS75rJ6lJ9a
         lg15uoeQ9irPvol82XHecGrtaoO+DBpViEPDGr0jOyBU7nwa8JpQMxl8rEQJPBxgAvVx
         WKAj+43nQw3QAmXT0TGlManXg1pd1S/6CF3rHa9HnaSVqIYmoHz4ehJj3/oTHzWoCAMY
         kIJbCM/w8npgj3ZKWOCKgP9dKcEf5KiuZkXbK0svH6uy65loG8sR0UVgSPJgGuTGfoMv
         cA+g==
X-Gm-Message-State: AOAM530CH5NtMcIrpK+09Q6+c9FB1M1KUNaLk2GoOf/o+0klAt66kc1a
        hqzn43lj2IyQlwBdrRjzk9EtfKd1a33RJcSBBf3sIw==
X-Google-Smtp-Source: ABdhPJzTEEZV6fvobIkqTMfmaHzhQtUGKCaL+0AzoovinKm6qsrtL+/TFRCKNZBGyqYJ8Lv2uyCxtK2GjxqQhWDJ+qQ=
X-Received: by 2002:a05:6214:27ec:b0:443:9153:23d0 with SMTP id
 jt12-20020a05621427ec00b00443915323d0mr720525qvb.122.1648639662175; Wed, 30
 Mar 2022 04:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220329230105.601666-1-robdclark@gmail.com> <20220329230105.601666-6-robdclark@gmail.com>
In-Reply-To: <20220329230105.601666-6-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Mar 2022 14:27:31 +0300
Message-ID: <CAA8EJprKZip_3W6OJZoFs2Zewtp4hqWyADfqG8ZPXcD8FCgXbQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/msm: Drop msm_gem_iova()
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, 30 Mar 2022 at 02:00, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> There was only a single user, which could just as easily stash the iova
> when pinning.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_fb.c  | 16 ++++++++++------
>  drivers/gpu/drm/msm/msm_gem.c | 16 ----------------
>  drivers/gpu/drm/msm/msm_gem.h |  2 --
>  3 files changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index 7137492fe78e..d4eef66e29dc 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -21,6 +21,9 @@ struct msm_framebuffer {
>
>         /* Count of # of attached planes which need dirtyfb: */
>         refcount_t dirtyfb;
> +
> +       /* Framebuffer per-plane address, if pinned, else zero: */
> +       uint64_t iova[DRM_FORMAT_MAX_PLANES];
>  };
>  #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
>
> @@ -76,14 +79,14 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
>  {
>         struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
>         int ret, i, n = fb->format->num_planes;
> -       uint64_t iova;
>
>         if (needs_dirtyfb)
>                 refcount_inc(&msm_fb->dirtyfb);
>
>         for (i = 0; i < n; i++) {
> -               ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &iova);
> -               drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)", fb->base.id, i, iova, ret);
> +               ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
> +               drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
> +                             fb->base.id, i, msm_fb->iova[i], ret);
>                 if (ret)
>                         return ret;
>         }
> @@ -103,14 +106,15 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb,
>
>         for (i = 0; i < n; i++)
>                 msm_gem_unpin_iova(fb->obj[i], aspace);
> +
> +       memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
>  }
>
>  uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb,
>                 struct msm_gem_address_space *aspace, int plane)
>  {
> -       if (!fb->obj[plane])
> -               return 0;
> -       return msm_gem_iova(fb->obj[plane], aspace) + fb->offsets[plane];
> +       struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
> +       return msm_fb->iova[plane];
>  }
>
>  struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane)
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index f4b68bb28a4d..deafae6feaa8 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -509,22 +509,6 @@ int msm_gem_get_iova(struct drm_gem_object *obj,
>         return ret;
>  }
>
> -/* get iova without taking a reference, used in places where you have
> - * already done a 'msm_gem_get_and_pin_iova' or 'msm_gem_get_iova'
> - */
> -uint64_t msm_gem_iova(struct drm_gem_object *obj,
> -               struct msm_gem_address_space *aspace)
> -{
> -       struct msm_gem_vma *vma;
> -
> -       msm_gem_lock(obj);
> -       vma = lookup_vma(obj, aspace);
> -       msm_gem_unlock(obj);
> -       GEM_WARN_ON(!vma);
> -
> -       return vma ? vma->iova : 0;
> -}
> -
>  /*
>   * Locked variant of msm_gem_unpin_iova()
>   */
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 090c3b1a6d9a..772de010a669 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -142,8 +142,6 @@ int msm_gem_get_and_pin_iova_locked(struct drm_gem_object *obj,
>                 struct msm_gem_address_space *aspace, uint64_t *iova);
>  int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
>                 struct msm_gem_address_space *aspace, uint64_t *iova);
> -uint64_t msm_gem_iova(struct drm_gem_object *obj,
> -               struct msm_gem_address_space *aspace);
>  void msm_gem_unpin_iova_locked(struct drm_gem_object *obj,
>                 struct msm_gem_address_space *aspace);
>  void msm_gem_unpin_iova(struct drm_gem_object *obj,
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
