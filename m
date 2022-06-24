Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38155A32A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiFXU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFXU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092A3057A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:58:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so2758850wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zz8FJhk/QZmPqWJEG0TaaXYtjxhBKjFwHOcMuQWmPb8=;
        b=LvoHRU1/bj9m5h/nkk9dlwDMS8axL/ZqAjUnMeFH8r0RCkkEINQEAz8if4C/gSX8Zu
         FvIOcrNK0j10Tu5IDD6FuUW/LakCK88zXE3LR3mGgtBnGfMCWgNcoilMQ8Ym2f9ozS6z
         MGHYc3EukulKbC3pUPAZ7Z0ING0yqNbUamx74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Zz8FJhk/QZmPqWJEG0TaaXYtjxhBKjFwHOcMuQWmPb8=;
        b=3tlkOI0Jbr2uDTF2bT5NEySr9Y71Rw+pdg5U/q9h5kM4hMrfGn5Fi3h/pDwdp8tMSk
         0gKCG4F8RLFJrmImPBLWjH0892K7OOpbbZ8uH/A9TCwl9ytt0PlAusO7YjTvp0g2NUXn
         w6tIMyZB66rW1KSl3uVZM5SZYAk4nORTH9XiWvt7Esp/0A0L6R5PvLwrT98qTUEbqNtr
         15mfBP1rwsoPHRk8iiSzsGvdKuVA2iOFqnhZsKpqCgs4rA+5amBkaLkBob82/y/rks8E
         49jgKPX57GB2ju+yzJRj/Paguj5bLb1ZVbPX8iTio5dS/akeOVF+M4kWhNQrNGxIZvhC
         Oysg==
X-Gm-Message-State: AJIora82BZ4+2nNeYyj3yuNtafxCpSrlxcsU3akhS+jAXLaZzj58QU26
        NDk7RX23Ax1pUq0l7Y/p3CFMzQ==
X-Google-Smtp-Source: AGRyM1vLYbsSFG8i7JcAkzwLOyS0AuQQUnRJ/S3EP09X0YokMBiBNYLiQ//0Sy6zxDxCP3l38yRhLQ==
X-Received: by 2002:a05:600c:4e53:b0:39e:e5c4:fe9b with SMTP id e19-20020a05600c4e5300b0039ee5c4fe9bmr5666834wmq.109.1656104324574;
        Fri, 24 Jun 2022 13:58:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003974a00697esm8980313wmq.38.2022.06.24.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:58:44 -0700 (PDT)
Date:   Fri, 24 Jun 2022 22:58:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/gem: Drop obj lock in msm_gem_free_object()
Message-ID: <YrYlgiQYSIoJFqwH@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20220613205032.2652374-1-robdclark@gmail.com>
 <CAE-0n51ADDijFnPwAQNwYE=62Rj4ZeQ38G7D=Xx3s5x7MRm18A@mail.gmail.com>
 <CAF6AEGtKiv+Y+BQSKvoydEN7W629_BRJR_sMEdFqsWCDRwsSQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGtKiv+Y+BQSKvoydEN7W629_BRJR_sMEdFqsWCDRwsSQQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 06:59:46AM -0700, Rob Clark wrote:
> On Thu, Jun 16, 2022 at 1:28 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rob Clark (2022-06-13 13:50:32)
> > > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> > > index d608339c1643..432032ad4aed 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem.h
> > > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > > @@ -229,7 +229,19 @@ msm_gem_unlock(struct drm_gem_object *obj)
> > >  static inline bool
> > >  msm_gem_is_locked(struct drm_gem_object *obj)
> > >  {
> > > -       return dma_resv_is_locked(obj->resv);
> > > +       /*
> > > +        * Destroying the object is a special case.. msm_gem_free_object()
> > > +        * calls many things that WARN_ON if the obj lock is not held.  But
> > > +        * acquiring the obj lock in msm_gem_free_object() can cause a
> > > +        * locking order inversion between reservation_ww_class_mutex and
> > > +        * fs_reclaim.
> > > +        *
> > > +        * This deadlock is not actually possible, because no one should
> > > +        * be already holding the lock when msm_gem_free_object() is called.
> > > +        * Unfortunately lockdep is not aware of this detail.  So when the
> > > +        * refcount drops to zero, we pretend it is already locked.
> > > +        */
> > > +       return dma_resv_is_locked(obj->resv) || (kref_read(&obj->refcount) == 0);
> >
> > Instead of modifying this function can we push down the fact that this
> > function is being called from the free path and skip checking this
> > condition in that case? Or add some "_locked/free_path" wrappers that
> > skip the lock assertion? That would make it clearer to understand while
> > reading the code that it is locked when it is asserted to be locked, and
> > that we don't care when we're freeing because all references to the
> > object are gone.
> 
> that was my earlier attempt, and I wasn't too happy with the result.
> And then I realized if refcount==0 then by definition we aren't racing
> with anyone else ;-)

I think that's not entirely correct, at least not for fairly reasonable
shrinker designs:

If the shrinker trylocks for throwing stuff out it might race with a
concurrent finalization. Depends a bit upon your design, but usually
that's possible.

There won't be a problem since you'll serialize on a lock eventually. But
if you drop all your locking debug checks like this then it's very hard to
figure this out :-)

Ofc you can adjust your refcounting scheme to make this impossible, but
then there's also not really any need to call any functions which might
need some locking, since by that time all that stuff must have been
cleaned up already (or the refcount could not have dropped to zero). Like
if any iova mapping holds a reference you never have these problems.

Long story short, this kind of design freaks me out big time. Especially
when it involves both a cross-driver refcount like the gem_bo one and a
cross driver lock ...

The standard way to fix this is to trylock dma_resv on cleanup and push to
a worker if you can't get it. This is what ttm and i915 does. Might be
good to lift that into drm_gem.c helpers and just use it.
-Daniel

> 
> > Here's a totally untested patch to show the idea. The comment about
> > pretending the lock is held can be put in msm_gem_free_object() to
> > clarify why it's OK to call the locked variants of the functions.
> >
> > ---8<---
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> > index 97d5b4d8b9b0..01f19d37bfb6 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > @@ -346,13 +346,11 @@ static void del_vma(struct msm_gem_vma *vma)
> >   * mapping.
> >   */
> >  static void
> > -put_iova_spaces(struct drm_gem_object *obj, bool close)
> > +put_iova_spaces_locked(struct drm_gem_object *obj, bool close)
> >  {
> >         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> >         struct msm_gem_vma *vma;
> >
> > -       GEM_WARN_ON(!msm_gem_is_locked(obj));
> > -
> >         list_for_each_entry(vma, &msm_obj->vmas, list) {
> >                 if (vma->aspace) {
> >                         msm_gem_purge_vma(vma->aspace, vma);
> > @@ -362,18 +360,28 @@ put_iova_spaces(struct drm_gem_object *obj, bool close)
> >         }
> >  }
> >
> > -/* Called with msm_obj locked */
> > +static void put_iova_spaces(struct drm_gem_object *obj, bool close)
> > +{
> > +       GEM_WARN_ON(!msm_gem_is_locked(obj));
> > +       put_iova_spaces_locked(obj, close);
> > +}
> 
> they are both _locked paths ;-)
> 
> But in general I think the parallel code paths make things more
> confusing about what is the right thing to call.  And I would like to
> put more WARN_ON(!locked()) in the gem_vma code, to make it clear that
> the obj lock is protecting things there as well.. which, with this
> approach would turn into parallel code paths multiple levels deep
> 
> BR,
> -R
> 
> > +
> > +/* Called with msm_obj locked or on the free path */
> >  static void
> > -put_iova_vmas(struct drm_gem_object *obj)
> > +put_iova_vmas_locked(struct drm_gem_object *obj)
> >  {
> >         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> >         struct msm_gem_vma *vma, *tmp;
> >
> > -       GEM_WARN_ON(!msm_gem_is_locked(obj));
> > -
> > -       list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list) {
> > +       list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list)
> >                 del_vma(vma);
> > -       }
> > +}
> > +
> > +static void
> > +put_iova_vmas(struct drm_gem_object *obj)
> > +{
> > +       GEM_WARN_ON(!msm_gem_is_locked(obj));
> > +       put_iova_vmas_locked(obj);
> >  }
> >
> >  static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
> > @@ -795,12 +803,10 @@ void msm_gem_evict(struct drm_gem_object *obj)
> >         update_inactive(msm_obj);
> >  }
> >
> > -void msm_gem_vunmap(struct drm_gem_object *obj)
> > +static void msm_gem_vunmap_locked(struct drm_gem_object *obj)
> >  {
> >         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> >
> > -       GEM_WARN_ON(!msm_gem_is_locked(obj));
> > -
> >         if (!msm_obj->vaddr || GEM_WARN_ON(!is_vunmapable(msm_obj)))
> >                 return;
> >
> > @@ -808,6 +814,12 @@ void msm_gem_vunmap(struct drm_gem_object *obj)
> >         msm_obj->vaddr = NULL;
> >  }
> >
> > +void msm_gem_vunmap(struct drm_gem_object *obj)
> > +{
> > +       GEM_WARN_ON(!msm_gem_is_locked(obj));
> > +       msm_gem_vunmap_locked(obj);
> > +}
> > +
> >  void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu)
> >  {
> >         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> > @@ -1021,12 +1033,11 @@ void msm_gem_free_object(struct drm_gem_object *obj)
> >         list_del(&msm_obj->mm_list);
> >         mutex_unlock(&priv->mm_lock);
> >
> > -       msm_gem_lock(obj);
> > -
> >         /* object should not be on active list: */
> >         GEM_WARN_ON(is_active(msm_obj));
> >
> > -       put_iova_spaces(obj, true);
> > +       put_iova_spaces_locked(obj, true);
> > +
> >
> >         if (obj->import_attach) {
> >                 GEM_WARN_ON(msm_obj->vaddr);
> > @@ -1036,19 +1047,13 @@ void msm_gem_free_object(struct drm_gem_object *obj)
> >                  */
> >                 kvfree(msm_obj->pages);
> >
> > -               put_iova_vmas(obj);
> > -
> > -               /* dma_buf_detach() grabs resv lock, so we need to unlock
> > -                * prior to drm_prime_gem_destroy
> > -                */
> > -               msm_gem_unlock(obj);
> > +               put_iova_vmas_locked(obj);
> >
> >                 drm_prime_gem_destroy(obj, msm_obj->sgt);
> >         } else {
> > -               msm_gem_vunmap(obj);
> > +               msm_gem_vunmap_locked(obj);
> >                 put_pages(obj);
> > -               put_iova_vmas(obj);
> > -               msm_gem_unlock(obj);
> > +               put_iova_vmas_locked(obj);
> >         }
> >
> >         drm_gem_object_release(obj);
> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> > index c75d3b879a53..b2998a074de7 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > @@ -253,7 +253,6 @@ static inline bool is_purgeable(struct
> > msm_gem_object *msm_obj)
> >
> >  static inline bool is_vunmapable(struct msm_gem_object *msm_obj)
> >  {
> > -       GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
> >         return (msm_obj->vmap_count == 0) && msm_obj->vaddr;
> >  }
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> > b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> > index 086dacf2f26a..afff3a79e925 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> > @@ -175,6 +175,7 @@ static const int vmap_shrink_limit = 15;
> >  static bool
> >  vmap_shrink(struct msm_gem_object *msm_obj)
> >  {
> > +       GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
> >         if (!is_vunmapable(msm_obj))
> >                 return false;

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
