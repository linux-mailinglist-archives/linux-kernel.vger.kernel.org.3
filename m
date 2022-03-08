Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE604D1D28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbiCHQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345048AbiCHQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:30:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E24A92C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:29:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q14so13858724wrc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYDOiiE/T/Y7VYsIB3p/zW4CbpW2wGMyym0vbgifcOE=;
        b=WNVHOSyNNfjEW9O3TED1BUUpsZlmtWZ5GMHSHHEVFGg7+rjPoN4aQMb1uneNNfYFmJ
         t6flvC3RMKFIUdsgeIjsapRQTl+EqkEfyUY61YObOG7prCe8glX8SziJdfhIhh9ntGtw
         5PYICSaCHkWCxD9iay5Qo/8n1YfjEmPAl5TY6IFLzCxewPS15FEJr6ImSYwI3RRgUul9
         d9JvnyrG3dWs1ImlSIkqz7bMqSZA+4UTu3JYiEOZaBJrz5b/y8MOqLgL3Glvr7MJ561P
         SaAw9NkYUHoo0W3dRhvxVTpr/NdQMotVJH1ht/KW0KosH4wu3toSK3wPypEvUgLGA8UK
         OAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYDOiiE/T/Y7VYsIB3p/zW4CbpW2wGMyym0vbgifcOE=;
        b=FMml7PWR/2K0+2wUG3z24pFDZ58n/Ndf8N5uVfjVZspvMKomPbfCWAvgzqoemIOJf5
         WDsUAE83H3ikXa7/zpu/2mNlht5MK9dzG46XD00bkLOTNskmhDXPbItsbezN45TAIcoQ
         wZ6krG83FKDWZwNIpVZB0t9bgtoIvaxjK+nnacAYDL7z78UpxxwRtcdEPlBmhKyrbl3r
         EycoM2DBBFRENHMmgDXnzXaojHWZnShn1IvZDvOz3I8fGmg/Urp0hrccjc34NUIsT7kw
         UelRm377ZLl90ceFAPyiqWkqpFJ5OyKRSi3GKQFP/bfKcz14TBW36l2LlS5uJuBl7jAy
         Zmnw==
X-Gm-Message-State: AOAM531f7wq988DplZfiMgV4hpBy+cNm663Vm8dHZUxuJEiGEBZqgHpH
        A60NKXPnuG/jCXBpggcd6VRk2XJQsGZ+BXRqOSc=
X-Google-Smtp-Source: ABdhPJyR74mrKbhqIZt8QWvM99w64IQ3UB0prHiSjO57e806D1kgvYf/kWL3XMCcUIHNTOXynsFWDPS+QJu3axJda3U=
X-Received: by 2002:a5d:5382:0:b0:1f0:2f64:5a5a with SMTP id
 d2-20020a5d5382000000b001f02f645a5amr12914704wrv.418.1646756943508; Tue, 08
 Mar 2022 08:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 8 Mar 2022 08:29:32 -0800
Message-ID: <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
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
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Clark <robdclark@chromium.org>
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
> Hello,
>
> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
> During OOM, the shrinker will release BOs that are marked as "not needed"
> by userspace using the new madvise IOCTL. The userspace in this case is
> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
> allowing kernel driver to release memory of the cached shmem BOs on lowmem
> situations, preventing OOM kills.

Will host memory pressure already trigger shrinker in guest?  This is
something I'm quite interested in for "virtgpu native contexts" (ie.
native guest driver with new context type sitting on top of virtgpu),
since that isn't using host storage

BR,
-R

> This patchset includes couple fixes for problems I found while was working
> on the shrinker, it also includes prerequisite DMA API usage improvement
> needed by the shrinker.
>
> The Mesa and IGT patches will be kept on hold until this kernel series
> will be approved and applied.
>
> This patchset was tested using Qemu and crosvm, including both cases of
> IOMMU off/on.
>
> Mesa: https://gitlab.freedesktop.org/digetx/mesa/-/commits/virgl-madvise
> IGT:  https://gitlab.freedesktop.org/digetx/igt-gpu-tools/-/tree/virtio-madvise
>
> Dmitry Osipenko (5):
>   drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
>   drm/virtio: Check whether transferred 2D BO is shmem
>   drm/virtio: Unlock GEM reservations in error code path
>   drm/virtio: Improve DMA API usage for shmem BOs
>   drm/virtio: Add memory shrinker
>
>  drivers/gpu/drm/virtio/Makefile               |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c          |  22 +++-
>  drivers/gpu/drm/virtio/virtgpu_drv.h          |  31 ++++-
>  drivers/gpu/drm/virtio/virtgpu_gem.c          |  84 ++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c | 124 ++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 ++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  17 ++-
>  drivers/gpu/drm/virtio/virtgpu_object.c       |  63 +++------
>  drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 ++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c           |  30 +++--
>  include/uapi/drm/virtgpu_drm.h                |  14 ++
>  11 files changed, 373 insertions(+), 69 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c
>
> --
> 2.35.1
>
