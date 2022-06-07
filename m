Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270CC540366
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbiFGQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbiFGQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:08:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E52B313A0;
        Tue,  7 Jun 2022 09:08:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u8so20495192wrm.13;
        Tue, 07 Jun 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDS8tU0h4s3yW5j6fV9TQnuv3IMe+OJzI6nClBIWrgc=;
        b=f5QycvAE9/GN3fLlvBk052zqfvowX+k+EtYvzGWvolIaDhCirc8/ghAau8/q2KlZkR
         yaj2ux79heR4lx3e8oZU8vdeA9aDx/u3G3bUyAwv5Ea+RJunpt1NEb1a549KQ281eNrm
         sLOYz4bU/K9TF0amhnSiciFadostRYKcTFF5IQOLa1clC34bhQPzpKcDdYccumE5DPuL
         IpsCLHY/vYanHE3f1yQ5lx9qBlnhvVbPxomK996soNXJ435vzHINFXYoHiGqrRNs45YI
         7VvTEfHiumWqNeF4HEjVELXUyyMCxfuemkJjEVPRVjCGcMaN/UAwfg2faFTIiQ4F7qE2
         cWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDS8tU0h4s3yW5j6fV9TQnuv3IMe+OJzI6nClBIWrgc=;
        b=rj3mR6QJ1wdbrxhkB5Y3pdxhdyy9dySZu5bglKvTWGon/JF995dL93fDlaFUDK9+dJ
         gqWZNiDfb3xrlt5NCw+6YrxjUmVl3CGlZM/8nhewql+gnqz2bi63FcOAsxl0QtF+z2Gc
         +jdEBO7mX9tJV0TJRxieej1YCAxQXlzmUr3BZB6KpPteEA7oq7aLt9Me/IwQPvYKNBx7
         IMxG7xEattL2uxiT5CaBi2MFsr4xXSDEV6jg6f9a22i1VzNozwYOJ6KfS3tTw+9/w/yV
         v1wpyyTzZs0AaZoL4B3Q1zYR/JoxpDJEY90CiUTS2gnSiT+ngxQ658iA5qcsVeLYbh+x
         Qj7Q==
X-Gm-Message-State: AOAM533/IITJRcE7r6PaZ2OchYLohoYzYAWgArqsJuvMKCx9ebKKwnQL
        vwd5JIiEW69pqaccFnXSTsho4z1eR/Now2X4084=
X-Google-Smtp-Source: ABdhPJyhVOQalPR1VYkh20EuicoSw2FV0OUV+CgcCZamkVKxRQVY389JMV0vPwBeHNVIdbVwOAyBMFhqORk+lyhEo9U=
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id
 p18-20020a5d68d2000000b0021031cc64a6mr27734429wrw.679.1654618101647; Tue, 07
 Jun 2022 09:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220606195432.1888346-1-robdclark@gmail.com> <20220606195432.1888346-2-robdclark@gmail.com>
 <8559b6f0-0322-9232-7000-534087e786fe@linux.intel.com> <CAF6AEGv0heF1fj0W3XALtQwZBE0yJTszXisg2CQR+-hFOmHSng@mail.gmail.com>
In-Reply-To: <CAF6AEGv0heF1fj0W3XALtQwZBE0yJTszXisg2CQR+-hFOmHSng@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 7 Jun 2022 09:08:24 -0700
Message-ID: <CAF6AEGvMNhoMTV+z0svbeX2bLusp-Yed7p9Z6KYa__0ckvg2LQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm: Expose client engine utilization via fdinfo
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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

On Tue, Jun 7, 2022 at 9:02 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Jun 7, 2022 at 1:56 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> >
> >
> > On 06/06/2022 20:54, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Similar to AMD commit
> > > 874442541133 ("drm/amdgpu: Add show_fdinfo() interface"), using the
> > > infrastructure added in previous patches, we add basic client info
> > > and GPU engine utilisation for msm.
> > >
> > > Example output:
> > >
> > >       # cat /proc/`pgrep glmark2`/fdinfo/6
> > >       pos:    0
> > >       flags:  02400002
> > >       mnt_id: 21
> > >       ino:    162
> > >       drm-driver:     msm
> > >       drm-client-id:  7
> > >       drm-engine-gpu: 1734371319 ns
> > >       drm-cycles-gpu: 1153645024
> > >       drm-maxfreq-gpu:        800000000 Hz
> > >
> > > See also: https://patchwork.freedesktop.org/patch/468505/
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >   Documentation/gpu/drm-usage-stats.rst | 21 +++++++++++++++++++++
> > >   drivers/gpu/drm/msm/msm_drv.c         | 19 ++++++++++++++++++-
> > >   drivers/gpu/drm/msm/msm_gpu.c         | 21 +++++++++++++++++++--
> > >   drivers/gpu/drm/msm/msm_gpu.h         | 19 +++++++++++++++++++
> > >   4 files changed, 77 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> > > index 6c9f166a8d6f..60e5cc9c13ad 100644
> > > --- a/Documentation/gpu/drm-usage-stats.rst
> > > +++ b/Documentation/gpu/drm-usage-stats.rst
> > > @@ -105,6 +105,27 @@ object belong to this client, in the respective memory region.
> > >   Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
> > >   indicating kibi- or mebi-bytes.
> > >
> > > +- drm-cycles-<str> <uint>
> > > +
> > > +Engine identifier string must be the same as the one specified in the
> > > +drm-engine-<str> tag and shall contain the number of busy cycles for the given
> > > +engine.
> > > +
> > > +Values are not required to be constantly monotonic if it makes the driver
> > > +implementation easier, but are required to catch up with the previously reported
> > > +larger value within a reasonable period. Upon observing a value lower than what
> > > +was previously read, userspace is expected to stay with that larger previous
> > > +value until a monotonic update is seen.
> > > +
> > > +- drm-maxfreq-<str> <uint> [Hz|MHz|KHz]
> > > +
> > > +Engine identifier string must be the same as the one specified in the
> > > +drm-engine-<str> tag and shall contain the maxium frequence for the given
> >
> > maximum frequency
> >
> > > +engine.  Taken together with drm-cycles-<str>, this can be used to calculate
> > > +percentage utilization of the engine, whereas drm-engine-<str> only refects
> >
> > reflects
> >
> > > +time active without considering what frequency the engine is operating as a
> > > +percentage of it's maximum frequency.
> >
> > Cycles vs max freq sounds very useful. My reservations is that how come
> > the idea hasn't happened in the CPU world. Or maybe it has and I am
> > un-informed?
>
> I do often pay attention to both where tasks get scheduled, and the
> individual CPU freq when I'm profiling CPU side stuff (eg. in
> perfetto)
>
> I could also report "always-count" cycles, I think, which could be
> used by gputop to derive freq.  I'd have to think about that a bit,
> since keeping the result monotinic(ish) might be a bit tricky (the hw
> counter loses state across runtime suspend)
>
> > In any case, if going with this I think we need to clarify the text that
> > the value should reflect the current soft limit, where the driver
> > supports that, in case it has been set to lower than the maximum
> > frequency hardware can support. I am thinking about avoiding "my gpu
> > cannot hit 100%" support incidents in cases when user/admin lowered the
> > soft limit for some reason. Possibly does not apply to msm but can apply
> > to i915, if we decided to export the same data.
>
> Yes, with pm-qos thermal or userspace could limit the max freq.. but
> we also internally use a pm-qos constraint to reduce freq when the GPU
> is idle, and I don't think there is a good way to differentiate
> *which* constraint is which.  I'll add something involving the word
> "recommended" ;-)

Hmm, or on second thought, maybe it would be better to, for drivers
that can, just report the soft limit separately?

BR,
-R

> BR,
> -R
>
> >
> > No other gotchas come to mind at the moment.
> >
> > Regards,
> >
> > Tvrtko
> >
> > > +
> > >   ===============================
> > >   Driver specific implementations
> > >   ===============================
> > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > > index 14ab9a627d8b..57a66093e671 100644
> > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > @@ -948,7 +948,24 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
> > >       DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
> > >   };
> > >
> > > -DEFINE_DRM_GEM_FOPS(fops);
> > > +static void msm_fop_show_fdinfo(struct seq_file *m, struct file *f)
> > > +{
> > > +     struct drm_file *file = f->private_data;
> > > +     struct drm_device *dev = file->minor->dev;
> > > +     struct msm_drm_private *priv = dev->dev_private;
> > > +     struct drm_printer p = drm_seq_file_printer(m);
> > > +
> > > +     if (!priv->gpu)
> > > +             return;
> > > +
> > > +     msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, &p);
> > > +}
> > > +
> > > +static const struct file_operations fops = {
> > > +     .owner = THIS_MODULE,
> > > +     DRM_GEM_FOPS,
> > > +     .show_fdinfo = msm_fop_show_fdinfo,
> > > +};
> > >
> > >   static const struct drm_driver msm_driver = {
> > >       .driver_features    = DRIVER_GEM |
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > > index eb8a6663f309..333a9a299b41 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > > @@ -4,6 +4,8 @@
> > >    * Author: Rob Clark <robdclark@gmail.com>
> > >    */
> > >
> > > +#include "drm/drm_drv.h"
> > > +
> > >   #include "msm_gpu.h"
> > >   #include "msm_gem.h"
> > >   #include "msm_mmu.h"
> > > @@ -146,6 +148,16 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
> > >       return 0;
> > >   }
> > >
> > > +void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
> > > +                      struct drm_printer *p)
> > > +{
> > > +     drm_printf(p, "drm-driver:\t%s\n", gpu->dev->driver->name);
> > > +     drm_printf(p, "drm-client-id:\t%u\n", ctx->seqno);
> > > +     drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
> > > +     drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
> > > +     drm_printf(p, "drm-maxfreq-gpu:\t%lu Hz\n", gpu->fast_rate);
> > > +}
> > > +
> > >   int msm_gpu_hw_init(struct msm_gpu *gpu)
> > >   {
> > >       int ret;
> > > @@ -652,7 +664,7 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> > >   {
> > >       int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
> > >       volatile struct msm_gpu_submit_stats *stats;
> > > -     u64 elapsed, clock = 0;
> > > +     u64 elapsed, clock = 0, cycles;
> > >       unsigned long flags;
> > >
> > >       stats = &ring->memptrs->stats[index];
> > > @@ -660,12 +672,17 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> > >       elapsed = (stats->alwayson_end - stats->alwayson_start) * 10000;
> > >       do_div(elapsed, 192);
> > >
> > > +     cycles = stats->cpcycles_end - stats->cpcycles_start;
> > > +
> > >       /* Calculate the clock frequency from the number of CP cycles */
> > >       if (elapsed) {
> > > -             clock = (stats->cpcycles_end - stats->cpcycles_start) * 1000;
> > > +             clock = cycles * 1000;
> > >               do_div(clock, elapsed);
> > >       }
> > >
> > > +     submit->queue->ctx->elapsed_ns += elapsed;
> > > +     submit->queue->ctx->cycles     += cycles;
> > > +
> > >       trace_msm_gpu_submit_retired(submit, elapsed, clock,
> > >               stats->alwayson_start, stats->alwayson_end);
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > > index 6def00883046..4911943ba53b 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > > @@ -361,6 +361,22 @@ struct msm_file_private {
> > >       /** cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE */
> > >       char *cmdline;
> > >
> > > +     /**
> > > +      * elapsed:
> > > +      *
> > > +      * The total (cumulative) elapsed time GPU was busy with rendering
> > > +      * from this context in ns.
> > > +      */
> > > +     uint64_t elapsed_ns;
> > > +
> > > +     /**
> > > +      * cycles:
> > > +      *
> > > +      * The total (cumulative) GPU cycles elapsed attributed to this
> > > +      * context.
> > > +      */
> > > +     uint64_t cycles;
> > > +
> > >       /**
> > >        * entities:
> > >        *
> > > @@ -544,6 +560,9 @@ static inline void gpu_write64(struct msm_gpu *gpu, u32 lo, u32 hi, u64 val)
> > >   int msm_gpu_pm_suspend(struct msm_gpu *gpu);
> > >   int msm_gpu_pm_resume(struct msm_gpu *gpu);
> > >
> > > +void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
> > > +                      struct drm_printer *p);
> > > +
> > >   int msm_submitqueue_init(struct drm_device *drm, struct msm_file_private *ctx);
> > >   struct msm_gpu_submitqueue *msm_submitqueue_get(struct msm_file_private *ctx,
> > >               u32 id);
