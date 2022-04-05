Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B44F50D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843588AbiDFBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573097AbiDER7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:59:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B48E7F47
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:57:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so28323755ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWlXCTkYGyXzOu6P6awXX/6nfl84WYIZI9g+WSGOyw0=;
        b=jwx0XQUGCaRHrpcErZBCsWMj23/VXGgzoKqDbPSw2f+7F8N/d9igo6HIZ+sSRTWP9a
         hqVlvkcMJHhbv8xYnDkM7bGSTq93zYJVCDN/0Uym3PloU+pHINLS9cTw6XdP9ouh17le
         it2++ow9VO0gUkSzqvwdCeMBzqbqoP5MRFjfawj+UxJefktYATV0WZknO8TYNGxTGfMQ
         A4SEg3p8c2YD/MFhBiOnIcKNUo84CMezQUHC+Em+oj9ZjR24dmD358+boudl6sT0Vpem
         JS1XGjGYbGqUCc76nIevCdXkQ4b19TaL0abiCBotNqqN7PtVcy3R/zqZT3DhISco56Xk
         7VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWlXCTkYGyXzOu6P6awXX/6nfl84WYIZI9g+WSGOyw0=;
        b=G9iMyqI/e/iqin9Jtu8sd14qGrmjdaUeLWFUgDRUzh1typilbXJJ4MX4qQcS2ruVGL
         AMN8kuVGCDjulpnrSHEkGMRfp1sIX0vHETg8GZAcNcIrGfpwbDaV7DMJUxYe2Q1RRrcO
         YD4KF1IGxxRWg1b97Xpl3e98sdhhvlmDYd3ZqaIVpZ8qONq4lDl6f8zX7BWdAR7LAhPk
         BenR0QJKk6M8kKEwIM8CimBSwgt1NPDc1fBdiPfUDao+U3/3ZOvl/ZGngsZJjT9Npbqx
         zSWGpggrEKYjgYtv5SJisVf3snjErJyIPAoZEZkZxMoNDt4rIaBqwsk6g3ygUa3u3UFE
         vTOw==
X-Gm-Message-State: AOAM531Ke9Bbn7/OQmgP4Yi5m7MKbNdiTPzlVU+wxOn4W2RB2sPhFsZj
        GCZ8c1DpiWLNFCaoAXtFhQnqj+OHBbilCnLboUI=
X-Google-Smtp-Source: ABdhPJzNwJLndNEvf8of6myr8gcbYVYJMmeilk2VVKShekHBfh+c8nN7LVIdcrL0bjowhSiwuKS+l8gYahoKhGqXbFU=
X-Received: by 2002:a17:906:d10c:b0:6cd:4aa2:cd62 with SMTP id
 b12-20020a170906d10c00b006cd4aa2cd62mr4684858ejz.229.1649181422577; Tue, 05
 Apr 2022 10:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220405173918.1000846-1-robdclark@gmail.com>
In-Reply-To: <20220405173918.1000846-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Tue, 5 Apr 2022 10:56:51 -0700
Message-ID: <CAPaKu7Tur-_Kf3Lb9U=98Yr_08onxPHNKTPh2anHU6zLPhr5ZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add execbuf flag to request no fence-event
To:     Rob Clark <robdclark@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, Apr 5, 2022 at 10:38 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> It would have been cleaner to have a flag to *request* the fence event.
> But that ship has sailed.  So add a flag so that userspace which doesn't
> care about the events can opt-out.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

Might want to wait for Gurchetan to chime in as he added the mechanism.

> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 8 +++++---
>  include/uapi/drm/virtgpu_drm.h         | 2 ++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 3a8078f2ee27..09f1aa263f91 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -225,9 +225,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 goto out_unresv;
>         }
>
> -       ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> -       if (ret)
> -               goto out_unresv;
> +       if (!(exbuf->flags & VIRTGPU_EXECBUF_NO_EVENT)) {
> +               ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> +               if (ret)
> +                       goto out_unresv;
> +       }
>
>         if (out_fence_fd >= 0) {
>                 sync_file = sync_file_create(&out_fence->f);
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 0512fde5e697..d06cac3407cc 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -52,10 +52,12 @@ extern "C" {
>  #define VIRTGPU_EXECBUF_FENCE_FD_IN    0x01
>  #define VIRTGPU_EXECBUF_FENCE_FD_OUT   0x02
>  #define VIRTGPU_EXECBUF_RING_IDX       0x04
> +#define VIRTGPU_EXECBUF_NO_EVENT       0x08
>  #define VIRTGPU_EXECBUF_FLAGS  (\
>                 VIRTGPU_EXECBUF_FENCE_FD_IN |\
>                 VIRTGPU_EXECBUF_FENCE_FD_OUT |\
>                 VIRTGPU_EXECBUF_RING_IDX |\
> +               VIRTGPU_EXECBUF_NO_EVENT |\
>                 0)
>
>  struct drm_virtgpu_map {
> --
> 2.35.1
>
