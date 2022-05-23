Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38240531EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiEWWyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiEWWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:54:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB49BAC9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:54:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so523429pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I1qORWyPQI7jXQYKqrTLFexrH7TndgYx7v8bQkC3I1k=;
        b=MrVJTB5IfkuU2llfyGLxOVi1li3nVyFrD6vpdgLjU9bOE9pIZPkRUF3WzpG+oTmbPg
         turc8MPYaO8YL65bR88RnXdazD/OsqMmceQBh2LRlGPIrlRyORixeQ9HzCt3THi5OuEC
         RW2HcoAGAS/GGrdkWuwTRaRT+SZPeTV0soOtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I1qORWyPQI7jXQYKqrTLFexrH7TndgYx7v8bQkC3I1k=;
        b=TJdES7+oKzbeOdlqEMUpL6rWqUOBr1iiilHxNUMmwsDrk9agtfyfmFLnYUHMPRI15T
         SlrV2mGVKzGhFUlSVMmrio8pDJ8hIllJrgjnBB+IsyRAV3lyx5xPO9shfpOolu1D/pTp
         5eLK6TFDaWz5ZCGVRPcYkM6dvcXA63bkew1isU1G94ZXVNQ5vBMR9iQopFk7vEEx9Rpu
         c4xfX6S8jOvb1RvBJJLTvtpQFLIJhSQI7teQ6C9+Udt2XRLhfQ9gEV95YLbduGo4QniY
         7Pm5e9K6M4I/DlA2+MeVJocN9D4mDPRGVLjBROrhZW0C1xJHHmF0OgNsR0OLpP3bT+TN
         SCUg==
X-Gm-Message-State: AOAM533v4ygacHRsOvUEJqFBRp5d6A38noWJDvh+OZD7XSq5hbm5xx+p
        xfyRQOYQw3Qv77AojfG95fwEnoOKShcbQHRPp2PSFg==
X-Google-Smtp-Source: ABdhPJyB9/BoLZUXvgBg7syUvZffUWV7ljrppLmDTIS3IF6ZgIrSG+O04lBehFPP8YNY2XC9tOGhbg6iR39pwahkoSM=
X-Received: by 2002:a17:90a:468d:b0:1df:39da:322b with SMTP id
 z13-20020a17090a468d00b001df39da322bmr1284066pjf.137.1653346439805; Mon, 23
 May 2022 15:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210728010632.2633470-1-robdclark@gmail.com> <20210728010632.2633470-13-robdclark@gmail.com>
 <84e03c5f-a3af-6592-d19a-a2f5d20b92fb@linux.intel.com>
In-Reply-To: <84e03c5f-a3af-6592-d19a-a2f5d20b92fb@linux.intel.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Mon, 23 May 2022 15:53:58 -0700
Message-ID: <CAJs_Fx6Nc337LPNh=p2GT2d2yDTdLWH934o4Cof3urDGhUJB6A@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] drm/msm: Utilize gpu scheduler priorities
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, Sean Paul <sean@poorly.run>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 7:45 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> Hi Rob,
>
> On 28/07/2021 02:06, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The drm/scheduler provides additional prioritization on top of that
> > provided by however many number of ringbuffers (each with their own
> > priority level) is supported on a given generation.  Expose the
> > additional levels of priority to userspace and map the userspace
> > priority back to ring (first level of priority) and schedular priority
> > (additional priority levels within the ring).
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 +-
> >   drivers/gpu/drm/msm/msm_gem_submit.c    |  4 +-
> >   drivers/gpu/drm/msm/msm_gpu.h           | 58 ++++++++++++++++++++++++=
-
> >   drivers/gpu/drm/msm/msm_submitqueue.c   | 35 +++++++--------
> >   include/uapi/drm/msm_drm.h              | 14 +++++-
> >   5 files changed, 88 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.c
> > index bad4809b68ef..748665232d29 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -261,8 +261,8 @@ int adreno_get_param(struct msm_gpu *gpu, uint32_t =
param, uint64_t *value)
> >                       return ret;
> >               }
> >               return -EINVAL;
> > -     case MSM_PARAM_NR_RINGS:
> > -             *value =3D gpu->nr_rings;
> > +     case MSM_PARAM_PRIORITIES:
> > +             *value =3D gpu->nr_rings * NR_SCHED_PRIORITIES;
> >               return 0;
> >       case MSM_PARAM_PP_PGTABLE:
> >               *value =3D 0;
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm=
/msm_gem_submit.c
> > index 450efe59abb5..c2ecec5b11c4 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -59,7 +59,7 @@ static struct msm_gem_submit *submit_create(struct dr=
m_device *dev,
> >       submit->gpu =3D gpu;
> >       submit->cmd =3D (void *)&submit->bos[nr_bos];
> >       submit->queue =3D queue;
> > -     submit->ring =3D gpu->rb[queue->prio];
> > +     submit->ring =3D gpu->rb[queue->ring_nr];
> >       submit->fault_dumped =3D false;
> >
> >       INIT_LIST_HEAD(&submit->node);
> > @@ -749,7 +749,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, vo=
id *data,
> >       /* Get a unique identifier for the submission for logging purpose=
s */
> >       submitid =3D atomic_inc_return(&ident) - 1;
> >
> > -     ring =3D gpu->rb[queue->prio];
> > +     ring =3D gpu->rb[queue->ring_nr];
> >       trace_msm_gpu_submit(pid_nr(pid), ring->id, submitid,
> >               args->nr_bos, args->nr_cmds);
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gp=
u.h
> > index b912cacaecc0..0e4b45bff2e6 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -250,6 +250,59 @@ struct msm_gpu_perfcntr {
> >       const char *name;
> >   };
> >
> > +/*
> > + * The number of priority levels provided by drm gpu scheduler.  The
> > + * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in so=
me
> > + * cases, so we don't use it (no need for kernel generated jobs).
> > + */
> > +#define NR_SCHED_PRIORITIES (1 + DRM_SCHED_PRIORITY_HIGH - DRM_SCHED_P=
RIORITY_MIN)
> > +
> > +/**
> > + * msm_gpu_convert_priority - Map userspace priority to ring # and sch=
ed priority
> > + *
> > + * @gpu:        the gpu instance
> > + * @prio:       the userspace priority level
> > + * @ring_nr:    [out] the ringbuffer the userspace priority maps to
> > + * @sched_prio: [out] the gpu scheduler priority level which the users=
pace
> > + *              priority maps to
> > + *
> > + * With drm/scheduler providing it's own level of prioritization, our =
total
> > + * number of available priority levels is (nr_rings * NR_SCHED_PRIORIT=
IES).
> > + * Each ring is associated with it's own scheduler instance.  However,=
 our
> > + * UABI is that lower numerical values are higher priority.  So mappin=
g the
> > + * single userspace priority level into ring_nr and sched_prio takes s=
ome
> > + * care.  The userspace provided priority (when a submitqueue is creat=
ed)
> > + * is mapped to ring nr and scheduler priority as such:
> > + *
> > + *   ring_nr    =3D userspace_prio / NR_SCHED_PRIORITIES
> > + *   sched_prio =3D NR_SCHED_PRIORITIES -
> > + *                (userspace_prio % NR_SCHED_PRIORITIES) - 1
> > + *
> > + * This allows generations without preemption (nr_rings=3D=3D1) to hav=
e some
> > + * amount of prioritization, and provides more priority levels for gen=
s
> > + * that do have preemption.
>
> I am exploring how different drivers handle priority levels and this
> caught my eye.
>
> Is the implication of the last paragraphs that on hw with nr_rings > 1,
> ring + 1 preempts ring?

Other way around, at least from the uabi standpoint.  Ie. ring[0]
preempts ring[1]

> If so I am wondering does the "spreading" of
> user visible priorities by NR_SCHED_PRIORITIES creates a non-preemptable
> levels within every "bucket" or how does that work?

So, preemption is possible between any priority level before run_job()
gets called, which writes the job into the ringbuffer.  After that
point, you only have "bucket" level preemption, because
NR_SCHED_PRIORITIES levels of priority get mapped to a single FIFO
ringbuffer.

-----

btw, one fun (but unrelated) issue I'm hitting with scheduler... I'm
trying to add an igt test to stress shrinker/eviction, similar to the
existing tests/i915/gem_shrink.c.  But we hit an unfortunate
combination of circumstances:
1. Pinning memory happens in the synchronous part of the submit ioctl,
before enqueuing the job for the kthread to handle.
2. The first run_job() callback incurs a slight delay (~1.5ms) while
resuming the GPU
3. Because of that delay, userspace has a chance to queue up enough
more jobs to require locking/pinning more than the available system
RAM..

I'm not sure if we want a way to prevent userspace from getting *too*
far ahead of the kthread.  Or maybe at some point the shrinker should
sleep on non-idle buffers?

BR,
-R

>
> Regards,
>
> Tvrtko
>
> > + */
> > +static inline int msm_gpu_convert_priority(struct msm_gpu *gpu, int pr=
io,
> > +             unsigned *ring_nr, enum drm_sched_priority *sched_prio)
> > +{
> > +     unsigned rn, sp;
> > +
> > +     rn =3D div_u64_rem(prio, NR_SCHED_PRIORITIES, &sp);
> > +
> > +     /* invert sched priority to map to higher-numeric-is-higher-
> > +      * priority convention
> > +      */
> > +     sp =3D NR_SCHED_PRIORITIES - sp - 1;
> > +
> > +     if (rn >=3D gpu->nr_rings)
> > +             return -EINVAL;
> > +
> > +     *ring_nr =3D rn;
> > +     *sched_prio =3D sp;
> > +
> > +     return 0;
> > +}
> > +
> >   /**
> >    * A submitqueue is associated with a gl context or vk queue (or equi=
v)
> >    * in userspace.
> > @@ -257,7 +310,8 @@ struct msm_gpu_perfcntr {
> >    * @id:        userspace id for the submitqueue, unique within the dr=
m_file
> >    * @flags:     userspace flags for the submitqueue, specified at crea=
tion
> >    *             (currently unusued)
> > - * @prio:      the submitqueue priority
> > + * @ring_nr:   the ringbuffer used by this submitqueue, which is deter=
mined
> > + *             by the submitqueue's priority
> >    * @faults:    the number of GPU hangs associated with this submitque=
ue
> >    * @ctx:       the per-drm_file context associated with the submitque=
ue (ie.
> >    *             which set of pgtables do submits jobs associated with =
the
> > @@ -272,7 +326,7 @@ struct msm_gpu_perfcntr {
> >   struct msm_gpu_submitqueue {
> >       int id;
> >       u32 flags;
> > -     u32 prio;
> > +     u32 ring_nr;
> >       int faults;
> >       struct msm_file_private *ctx;
> >       struct list_head node;
> > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/ms=
m/msm_submitqueue.c
> > index 682ba2a7c0ec..32a55d81b58b 100644
> > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > @@ -68,6 +68,8 @@ int msm_submitqueue_create(struct drm_device *drm, st=
ruct msm_file_private *ctx,
> >       struct msm_gpu_submitqueue *queue;
> >       struct msm_ringbuffer *ring;
> >       struct drm_gpu_scheduler *sched;
> > +     enum drm_sched_priority sched_prio;
> > +     unsigned ring_nr;
> >       int ret;
> >
> >       if (!ctx)
> > @@ -76,8 +78,9 @@ int msm_submitqueue_create(struct drm_device *drm, st=
ruct msm_file_private *ctx,
> >       if (!priv->gpu)
> >               return -ENODEV;
> >
> > -     if (prio >=3D priv->gpu->nr_rings)
> > -             return -EINVAL;
> > +     ret =3D msm_gpu_convert_priority(priv->gpu, prio, &ring_nr, &sche=
d_prio);
> > +     if (ret)
> > +             return ret;
> >
> >       queue =3D kzalloc(sizeof(*queue), GFP_KERNEL);
> >
> > @@ -86,24 +89,13 @@ int msm_submitqueue_create(struct drm_device *drm, =
struct msm_file_private *ctx,
> >
> >       kref_init(&queue->ref);
> >       queue->flags =3D flags;
> > -     queue->prio =3D prio;
> > +     queue->ring_nr =3D ring_nr;
> >
> > -     ring =3D priv->gpu->rb[prio];
> > +     ring =3D priv->gpu->rb[ring_nr];
> >       sched =3D &ring->sched;
> >
> > -     /*
> > -      * TODO we can allow more priorities than we have ringbuffers by
> > -      * mapping:
> > -      *
> > -      *    ring =3D prio / 3;
> > -      *    ent_prio =3D DRM_SCHED_PRIORITY_MIN + (prio % 3);
> > -      *
> > -      * Probably avoid using DRM_SCHED_PRIORITY_KERNEL as that is
> > -      * treated specially in places.
> > -      */
> >       ret =3D drm_sched_entity_init(&queue->entity,
> > -                     DRM_SCHED_PRIORITY_NORMAL,
> > -                     &sched, 1, NULL);
> > +                     sched_prio, &sched, 1, NULL);
> >       if (ret) {
> >               kfree(queue);
> >               return ret;
> > @@ -134,16 +126,19 @@ int msm_submitqueue_create(struct drm_device *drm=
, struct msm_file_private *ctx,
> >   int msm_submitqueue_init(struct drm_device *drm, struct msm_file_priv=
ate *ctx)
> >   {
> >       struct msm_drm_private *priv =3D drm->dev_private;
> > -     int default_prio;
> > +     int default_prio, max_priority;
> >
> >       if (!priv->gpu)
> >               return -ENODEV;
> >
> > +     max_priority =3D (priv->gpu->nr_rings * NR_SCHED_PRIORITIES) - 1;
> > +
> >       /*
> > -      * Select priority 2 as the "default priority" unless nr_rings is=
 less
> > -      * than 2 and then pick the lowest priority
> > +      * Pick a medium priority level as default.  Lower numeric value =
is
> > +      * higher priority, so round-up to pick a priority that is not hi=
gher
> > +      * than the middle priority level.
> >        */
> > -     default_prio =3D clamp_t(uint32_t, 2, 0, priv->gpu->nr_rings - 1)=
;
> > +     default_prio =3D DIV_ROUND_UP(max_priority, 2);
> >
> >       INIT_LIST_HEAD(&ctx->submitqueues);
> >
> > diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> > index f075851021c3..6b8fffc28a50 100644
> > --- a/include/uapi/drm/msm_drm.h
> > +++ b/include/uapi/drm/msm_drm.h
> > @@ -73,11 +73,19 @@ struct drm_msm_timespec {
> >   #define MSM_PARAM_MAX_FREQ   0x04
> >   #define MSM_PARAM_TIMESTAMP  0x05
> >   #define MSM_PARAM_GMEM_BASE  0x06
> > -#define MSM_PARAM_NR_RINGS   0x07
> > +#define MSM_PARAM_PRIORITIES 0x07  /* The # of priority levels */
> >   #define MSM_PARAM_PP_PGTABLE 0x08  /* =3D> 1 for per-process pagetabl=
es, else 0 */
> >   #define MSM_PARAM_FAULTS     0x09
> >   #define MSM_PARAM_SUSPENDS   0x0a
> >
> > +/* For backwards compat.  The original support for preemption was base=
d on
> > + * a single ring per priority level so # of priority levels equals the=
 #
> > + * of rings.  With drm/scheduler providing additional levels of priori=
ty,
> > + * the number of priorities is greater than the # of rings.  The param=
 is
> > + * renamed to better reflect this.
> > + */
> > +#define MSM_PARAM_NR_RINGS   MSM_PARAM_PRIORITIES
> > +
> >   struct drm_msm_param {
> >       __u32 pipe;           /* in, MSM_PIPE_x */
> >       __u32 param;          /* in, MSM_PARAM_x */
> > @@ -304,6 +312,10 @@ struct drm_msm_gem_madvise {
> >
> >   #define MSM_SUBMITQUEUE_FLAGS (0)
> >
> > +/*
> > + * The submitqueue priority should be between 0 and MSM_PARAM_PRIORITI=
ES-1,
> > + * a lower numeric value is higher priority.
> > + */
> >   struct drm_msm_submitqueue {
> >       __u32 flags;   /* in, MSM_SUBMITQUEUE_x */
> >       __u32 prio;    /* in, Priority level */
