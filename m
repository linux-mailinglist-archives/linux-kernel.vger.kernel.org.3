Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9437D539807
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347771AbiEaUeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347764AbiEaUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:34:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70716994E9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:34:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 135so14075128qkm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fh41uCU0B0HjBQXprAp7krFBQPqgkjOy/nUjVHNbUw=;
        b=cg6LfZ2kXIK9pxClWtEHJwSucUWw4dIXpd5+sYRrz3pb5+GxzuJ1aq9JCx6TIF2m5p
         RT20SL65M2yezc64XYlLvzEI6Sd+Bqh79gRnc64JONcBV+aNMuQe1kq9bYba3YSI92Ys
         h8rpWCWKrdWsCeM0nM4YKH+YtLRPiu03o5n/B+IoT9qwKMDQl+nU6wZD+1GP6z5jVWoR
         r81DOxzJA3HGeAG1/CYbRaDkxQWHryEDJ7jXGekIyqbfTemiNu1CWtmckG5jr6iSU0uP
         mpK0G+BqvyyKnarnXuLVX6IMIK6AVtwYYWZceOyq5V2OVHA5C4V2p6DrK7Q0WYk+Jnb7
         uT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fh41uCU0B0HjBQXprAp7krFBQPqgkjOy/nUjVHNbUw=;
        b=vJ+PUyGE/Ev1gFVv83RGTzrAennJ5CMVfAUAEfnWeljBalBxXMtyPpDte4hUlqq1XM
         //baChd9hOpgweehDIq3ddjgWyD5NvVawwhlAaaIykFhLOu5y6JzYo3UZ5WROWfvpcA9
         lX//F2hzJ1GqzI3g/AWzVAAiR88aw+5015FS4vQvyzSmMmjLIDNIMi8IZsdwxuacGnlJ
         m5PDNRKA2maDQeBnf/Lw9KdFVTrRxupDHnu2xGyJxbrvdvf05adeLFmm+/VKg3p/khqP
         NHoPjP5BZjoBulk7++5IovyvmqplvaA1glDj1kvAym2mnivxkrG5piikUh5oU9p3jX7/
         srhg==
X-Gm-Message-State: AOAM531i0m7/YoRRTwbeQlH2Lx+iSEE6n2P/FQS8ZtG89x6O6FaBw8/t
        6zsTPVKX5UMzPzVbpZUDOt9eZ80PVvrhPPYNgXktzQ==
X-Google-Smtp-Source: ABdhPJz5IQSs0iubNWF0AHMHHE5gGY9ALKbjx1Exvbh1qJxPkgPlKRPWxj874jacm+IrqVX5a3l3Jg663f6Em2Lj6X0=
X-Received: by 2002:a05:620a:414e:b0:6a5:8dec:57bb with SMTP id
 k14-20020a05620a414e00b006a58dec57bbmr24700836qko.30.1654029285518; Tue, 31
 May 2022 13:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220531200857.136547-1-robdclark@gmail.com>
In-Reply-To: <20220531200857.136547-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 31 May 2022 23:34:34 +0300
Message-ID: <CAA8EJpouqO9KfhAQSqEHP8MUGTkntx7iARRRqrvx3uMFQd4-dQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Ensure mmap offset is initialized
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, 31 May 2022 at 23:08, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> If a GEM object is allocated, and then exported as a dma-buf fd which is
> mmap'd before or without the GEM buffer being directly mmap'd, the
> vma_node could be unitialized.  This leads to a situation where the CPU
> mapping is not correctly torn down in drm_vma_node_unmap().
>
> Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake offset")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c       |  2 +-
>  drivers/gpu/drm/msm/msm_drv.h       |  1 +
>  drivers/gpu/drm/msm/msm_gem_prime.c | 15 +++++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 44485363f37a..14ab9a627d8b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -964,7 +964,7 @@ static const struct drm_driver msm_driver = {
>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>         .gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
> -       .gem_prime_mmap     = drm_gem_prime_mmap,
> +       .gem_prime_mmap     = msm_gem_prime_mmap,
>  #ifdef CONFIG_DEBUG_FS
>         .debugfs_init       = msm_debugfs_init,
>  #endif
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index bb052071b16d..090b8074fec7 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -275,6 +275,7 @@ unsigned long msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_t
>  void msm_gem_shrinker_init(struct drm_device *dev);
>  void msm_gem_shrinker_cleanup(struct drm_device *dev);
>
> +int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj);
>  int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
>  void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
> diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
> index 94ab705e9b8a..dcc8a573bc76 100644
> --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> @@ -11,6 +11,21 @@
>  #include "msm_drv.h"
>  #include "msm_gem.h"
>
> +int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> +{
> +       int ret;
> +
> +       /* Ensure the mmap offset is initialized.  We lazily initialize it,
> +        * so if it has not been first mmap'd directly as a GEM object, the
> +        * mmap offset will not be already initialized.
> +        */
> +       ret = drm_gem_create_mmap_offset(obj);
> +       if (ret)
> +               return ret;

Wouldn't it be better to have this call directly in the
drm_gem_prime_mmap() ? This way all drivers can be lazy.


> +
> +       return drm_gem_prime_mmap(obj, vma);
> +}
> +
>  struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
