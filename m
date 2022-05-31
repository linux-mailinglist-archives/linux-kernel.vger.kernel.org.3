Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9672A539810
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347790AbiEaUh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiEaUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:37:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C75FB0;
        Tue, 31 May 2022 13:37:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso1815810wmr.5;
        Tue, 31 May 2022 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ap8m9GW6rAa6FZVs5048yDYtztGlnW9Y5d2Yo2CbjgY=;
        b=MhMws38eXka+O52jLnLm8q+Wjy6g6ctFIJSRrS4P3fqNdLoGPTGyNWIGJBeVXhIXAS
         6q59iITeoE0wBzx4s0L08OnvWNsbxj11UyIKL0uy2EEVY4bVay9Ge3mccuiAwc4VFk0I
         dzq0OH22r01suBOytI2EPYFmaDuIDzlNfRvYPF8DdYzzoMuoxWBEcjpVukXydhYUGA4s
         YbxBFEcZ9SQkGdRRgIg1wzjB3YfGH6aoJ0IexUTqW3uI90Ua+iM5dc5mU40y+KpHsWh2
         AHImQtdgvgNMLWQeLUXRVEp72SPRpOUTZKkT3qwjhGUuBr2W9rms3b07CWz437/Gvxe0
         9XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ap8m9GW6rAa6FZVs5048yDYtztGlnW9Y5d2Yo2CbjgY=;
        b=Un1wG68bMPAX+d4MhfKmuedn944Ltlw8+92z+qk+S42ZrSggdlMuBRHdjVojNBAg+V
         8DIBWTfb4/rYc0MxS0Gws+qAXTI3rouLfblhV6iDYyptMqe3cdowNghqR0tQvdc/yXDV
         xRga0T7WAQ6GhwyN4/XvMkFe6iK42vTVq3FKOss+QvyHzWqam3jj27qgKpvYV7xeo4mW
         1LjmZXKxG0gkdagDIQ9otpNSuvVg+xK7txBE+PdS08L0KUnU7BH8sbrn6t5r28yPSPDZ
         U1Z4xsgo9EE6gEP5LHYTagr4sZ3NuE9jnIzloxFk7OLxahsseCcAREW29Ev/QTFwgZQi
         m3DA==
X-Gm-Message-State: AOAM5328fL3ENhozK/97SreGhqzsfFJUqactlOnYwP/iWJ4XGH3vkNJa
        n+7qGtd6S5VPImfpKFyUfPCzM597Aj9O4AyLxHk=
X-Google-Smtp-Source: ABdhPJza8TMPJl7YmHaRa8ELdim5OJhwHJcIXOn4Oa6n4zw0BF1RI6V8kAR6bGQG/etPfRXLzk9xEO6wXj4h6myFzZc=
X-Received: by 2002:a05:600c:4f95:b0:397:82a5:dcf8 with SMTP id
 n21-20020a05600c4f9500b0039782a5dcf8mr24907365wmq.84.1654029423839; Tue, 31
 May 2022 13:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220531200857.136547-1-robdclark@gmail.com> <CAA8EJpouqO9KfhAQSqEHP8MUGTkntx7iARRRqrvx3uMFQd4-dQ@mail.gmail.com>
In-Reply-To: <CAA8EJpouqO9KfhAQSqEHP8MUGTkntx7iARRRqrvx3uMFQd4-dQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 May 2022 13:37:04 -0700
Message-ID: <CAF6AEGtauTPR5Gp8Sjy1_W4yHfYgTahRzJU=9A8XkY1RMZBwyA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Ensure mmap offset is initialized
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
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

On Tue, May 31, 2022 at 1:34 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 31 May 2022 at 23:08, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If a GEM object is allocated, and then exported as a dma-buf fd which is
> > mmap'd before or without the GEM buffer being directly mmap'd, the
> > vma_node could be unitialized.  This leads to a situation where the CPU
> > mapping is not correctly torn down in drm_vma_node_unmap().
> >
> > Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake offset")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c       |  2 +-
> >  drivers/gpu/drm/msm/msm_drv.h       |  1 +
> >  drivers/gpu/drm/msm/msm_gem_prime.c | 15 +++++++++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 44485363f37a..14ab9a627d8b 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -964,7 +964,7 @@ static const struct drm_driver msm_driver = {
> >         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> >         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> >         .gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
> > -       .gem_prime_mmap     = drm_gem_prime_mmap,
> > +       .gem_prime_mmap     = msm_gem_prime_mmap,
> >  #ifdef CONFIG_DEBUG_FS
> >         .debugfs_init       = msm_debugfs_init,
> >  #endif
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> > index bb052071b16d..090b8074fec7 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -275,6 +275,7 @@ unsigned long msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_t
> >  void msm_gem_shrinker_init(struct drm_device *dev);
> >  void msm_gem_shrinker_cleanup(struct drm_device *dev);
> >
> > +int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
> >  struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj);
> >  int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
> >  void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
> > diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
> > index 94ab705e9b8a..dcc8a573bc76 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> > @@ -11,6 +11,21 @@
> >  #include "msm_drv.h"
> >  #include "msm_gem.h"
> >
> > +int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> > +{
> > +       int ret;
> > +
> > +       /* Ensure the mmap offset is initialized.  We lazily initialize it,
> > +        * so if it has not been first mmap'd directly as a GEM object, the
> > +        * mmap offset will not be already initialized.
> > +        */
> > +       ret = drm_gem_create_mmap_offset(obj);
> > +       if (ret)
> > +               return ret;
>
> Wouldn't it be better to have this call directly in the
> drm_gem_prime_mmap() ? This way all drivers can be lazy.
>

yes.. that was my first[1] proposal.  But there are differences of
opinion, and in the mean time I want to get this particular issue
fixed ;-)

BR,
-R

[1] https://patchwork.freedesktop.org/patch/487597/

>
> > +
> > +       return drm_gem_prime_mmap(obj, vma);
> > +}
> > +
> >  struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
> >  {
> >         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> > --
> > 2.36.1
> >
>
>
> --
> With best wishes
> Dmitry
