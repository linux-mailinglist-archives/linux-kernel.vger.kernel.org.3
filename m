Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4294D4D2728
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiCIBU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiCIBUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:20:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEEB10A0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:13:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so668384wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 17:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpY2z4H34H3eyBeRRD+CGY7silW4WSqrGPqcmBECpU8=;
        b=OQR6wnO5d5c3LTMBJooNcShzMDnrZE0ChK/EkciE7eBjvAp9AaNTh8JGyr9hqlIe8o
         /uLpYB3Sz5zoaFGYFpt6ebZD8vcNRigI2VhxHWkHBGHeMI5X4yVN+av7yUE0A4dksIjT
         fz6/CovaYl8F+Gl4PS4wx725aQ2QwTOGvwK8bvceboZj1VlrJ6pLLMF2GFGLzX9QXTKt
         xCSafwiMNAidJBvjoxUwKtaQPB2Qs3FRt0A5UoEpCYNk8OZNYo29CazknewuE2JjVElV
         7cesBfsDlrU3roEDItdYH7xJ10SRqQ/6EvLmITBvheW5vavY0ObFtOFW2WTbvIZhGwT0
         tfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpY2z4H34H3eyBeRRD+CGY7silW4WSqrGPqcmBECpU8=;
        b=YwxGU2XlF+8PyqS+NDVjfWEqopBIEXrwkeZ9lM0l1//mw7v41UVKqUKMrBcL+jaa1j
         nViOSvPZyjV1PlBTvYUIbKGgh/5Ku5RneLBkcfpGPB5le0cfhBHDCQJzCa1Qh/nIkDRn
         aZ+fjf9X5WebepFjFqkFXKMLnajCaIL7qz8oDsHfv446NV6e/ftNbYeF6KPUYl91HrF/
         wV0U4Z1p8OiUS2cOZCrLB65CmneON5j9UXvX9O3pP6amgJNdjc8J16PEJWUewrxTg2IY
         XR2EzOY0O4Szit0DiWABPE36yC3qf4JB9czJr7kDQT44X/MpYUZz+kkeNUjXblsyvpz1
         CFFQ==
X-Gm-Message-State: AOAM5318TRvy8R5i4tSTkE9ekXt8oq+D52jSP1geYFQI9sO/h9JYC+mo
        F7rRTBRgyGRPFlwl6ZIYqmVU7Ia5/fTwOBm6VRU9ErKJwDY=
X-Google-Smtp-Source: ABdhPJxzYEf+xhzYvzLMbZ4CzUdlFlyPdwT3Ou9S7TZYGaRoHbCq8sPvHqx4BSkcicG04BJi2Bnpw9/xcgw7LbDC4hs=
X-Received: by 2002:a5d:6344:0:b0:1f0:21ee:9705 with SMTP id
 b4-20020a5d6344000000b001f021ee9705mr13967971wrw.93.1646788309356; Tue, 08
 Mar 2022 17:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com> <20220308131725.60607-6-dmitry.osipenko@collabora.com>
In-Reply-To: <20220308131725.60607-6-dmitry.osipenko@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 8 Mar 2022 17:12:18 -0800
Message-ID: <CAF6AEGvVmV4fesd0MsSo-4WxSVqOFN-U+p5HOE2job6CeYbqTA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm/virtio: Add memory shrinker
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>
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

On Tue, Mar 8, 2022 at 5:17 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add memory shrinker and new madvise IOCTL to the VirtIO-GPU driver.
> Userspace (BO cache manager of Mesa driver) will mark BOs as "don't need"
> using the new IOCTL to let shrinker purge the marked BOs on OOM, thus
> shrinker will lower memory pressure and prevent OOM kills.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/Makefile               |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h          |  26 +++-
>  drivers/gpu/drm/virtio/virtgpu_gem.c          |  84 ++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c | 124 ++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 ++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  10 ++
>  drivers/gpu/drm/virtio/virtgpu_object.c       |   7 +
>  drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 ++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c           |  15 +++
>  include/uapi/drm/virtgpu_drm.h                |  14 ++
>  10 files changed, 333 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
>

[snip]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c b/drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
> new file mode 100644
> index 000000000000..39eb9a3e7e4a
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Collabora Ltd.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/shmem_fs.h>
> +
> +#include "virtgpu_drv.h"
> +
> +static unsigned long
> +virtio_gpu_gem_shrinker_count_objects(struct shrinker *shrinker,
> +                                     struct shrink_control *sc)
> +{
> +       struct drm_gem_shmem_object *shmem;
> +       struct virtio_gpu_device *vgdev;
> +       unsigned long count = 0;
> +       bool empty = true;
> +
> +       vgdev = container_of(shrinker, struct virtio_gpu_device,
> +                            vgshrinker.shrinker);
> +
> +       if (!mutex_trylock(&vgdev->mm_lock))
> +               return 0;

One bit of advice from previously dealing with shrinker and heavy
memory pressure situations (turns out 4GB chromebooks can be pretty
much under *constant* memory pressure):

You *really* want to make shrinker->count_objects lockless.. and
minimize the lock contention on shrinker->scan_objects (ie.  The
problem is you can end up with shrinking going on on all CPU cores in
parallel, you want to not funnel that thru one lock as much as
possible.

See in particular:

25ed38b3ed26 ("drm/msm: Drop mm_lock in scan loop")
cc8a4d5a1bd8 ("drm/msm: Avoid mutex in shrinker_count()")

BR,
-R

> +       list_for_each_entry(shmem, &vgdev->vgshrinker.list, madv_list) {
> +               empty = false;
> +
> +               if (!mutex_trylock(&shmem->pages_lock))
> +                       continue;
> +
> +               if (drm_gem_shmem_is_purgeable(shmem))
> +                       count += shmem->base.size >> PAGE_SHIFT;
> +
> +               mutex_unlock(&shmem->pages_lock);
> +       }
> +
> +       mutex_unlock(&vgdev->mm_lock);
> +
> +       return empty ? SHRINK_EMPTY : count;
> +}
> +
> +static bool virtio_gpu_gem_shrinker_purge(struct virtio_gpu_device *vgdev,
> +                                         struct drm_gem_object *obj)
> +{
> +       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +       struct drm_gem_shmem_object *shmem = &bo->base;
> +       int err;
> +
> +       if (!dma_resv_test_signaled(obj->resv, true) ||
> +           !drm_gem_shmem_is_purgeable(shmem) ||
> +           refcount_read(&bo->pin_count))
> +               return false;
> +
> +       /*
> +        * Release host's memory before guest's memory is gone to ensure that
> +        * host won't touch released memory of the guest.
> +        */
> +       err = virtio_gpu_gem_host_mem_release(bo);
> +       if (err)
> +               return false;
> +
> +       list_del_init(&shmem->madv_list);
> +       drm_gem_shmem_purge_locked(shmem);
> +
> +       return true;
> +}
> +
> +static unsigned long
> +virtio_gpu_gem_shrinker_scan_objects(struct shrinker *shrinker,
> +                                    struct shrink_control *sc)
> +{
> +       struct drm_gem_shmem_object *shmem, *tmp;
> +       struct virtio_gpu_device *vgdev;
> +       unsigned long freed = 0;
> +
> +       vgdev = container_of(shrinker, struct virtio_gpu_device,
> +                            vgshrinker.shrinker);
> +
> +       if (!mutex_trylock(&vgdev->mm_lock))
> +               return SHRINK_STOP;
> +
> +       list_for_each_entry_safe(shmem, tmp, &vgdev->vgshrinker.list, madv_list) {
> +               if (freed >= sc->nr_to_scan)
> +                       break;
> +
> +               if (!dma_resv_trylock(shmem->base.resv))
> +                       continue;
> +
> +               if (!mutex_trylock(&shmem->pages_lock))
> +                       goto resv_unlock;
> +
> +               if (virtio_gpu_gem_shrinker_purge(vgdev, &shmem->base))
> +                       freed += shmem->base.size >> PAGE_SHIFT;
> +
> +               mutex_unlock(&shmem->pages_lock);
> +resv_unlock:
> +               dma_resv_unlock(shmem->base.resv);
> +       }
> +
> +       mutex_unlock(&vgdev->mm_lock);
> +
> +       return freed;
> +}
> +
> +int virtio_gpu_gem_shrinker_init(struct virtio_gpu_device *vgdev)
> +{
> +       struct shrinker *shrinker = &vgdev->vgshrinker.shrinker;
> +
> +       shrinker->count_objects = virtio_gpu_gem_shrinker_count_objects;
> +       shrinker->scan_objects = virtio_gpu_gem_shrinker_scan_objects;
> +       shrinker->seeks = DEFAULT_SEEKS;
> +
> +       INIT_LIST_HEAD(&vgdev->vgshrinker.list);
> +
> +       return register_shrinker(shrinker);
> +}
> +
> +void virtio_gpu_gem_shrinker_fini(struct virtio_gpu_device *vgdev)
> +{
> +       struct shrinker *shrinker = &vgdev->vgshrinker.shrinker;
> +
> +       unregister_shrinker(shrinker);
> +}
