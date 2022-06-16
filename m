Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746FF54E2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbiFPOAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377456AbiFPOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:00:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE694D9CD;
        Thu, 16 Jun 2022 06:59:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z17so832097wmi.1;
        Thu, 16 Jun 2022 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQzR17EcSV5+QfevwFCQXoAuf0l0H9G0Mp7VxD4d3D0=;
        b=MsmS+QR6mcGQ+T2WYVLut2inRpy5LZHqrkFV1OvQcm53pFJE9OLXlNrWAf19yN2x+C
         2VVuMJBpNYTMyECP6atwy4fXRZC4AQ0yMcVN+YsStEM/Mz+kc4NIbEPK9uUTdeywPDGm
         DAbOeqW2tKrfRYsl6A04FPsueNdMB6duZEtOZiSDaqIrdxwxgyKW0g5krpl21anBOonn
         XbeXeWXLfriA10ZvSTLd98BhnMyn9U6ErXQYmbHuEcMaaLQWgGKcZClU+3uVyDrhSjTm
         B6BwpbuwAaHc7ceSDfSXEL5Q20i4pOhArooqDHrUn7ztny/ub4gwtWPhERo2cQLACJqs
         mDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQzR17EcSV5+QfevwFCQXoAuf0l0H9G0Mp7VxD4d3D0=;
        b=1UddHEjNbiVDh0y9b5Fa2qXtKtZd1yBovoK4eZppDeQiX5TttC9nZqiygAG4Uo+um/
         HCCuDs11Xfla0LisI/HlyYl+iINcDUfcvYPNXL5/ElnkRiOX2LyNMrptpslpMHffE4xU
         DQ6bvoAGFtoLEvJuhXX4TkbzvW67Kng3zQYDPtP/h2XT50x+o4sX0e8qwtmjSZUf31M8
         pEHsuimGCMdkR0hg9FXZSxK0FJDXLr/U1IJxvsvXQ0/f/xw+2okO5bKplS8IvOAvkwoc
         pmx0MhD7IVHoiHOPKf6hzRdl0UukKUfZao+dZuQxHIrNT/unxML+ekIgDQBEuAEgDbM8
         V4Pw==
X-Gm-Message-State: AOAM532iwJFnpf+3p9F5w+O9gYYfCnbFhchBMY+tjscZRu+x9wZlkigq
        jjFQTh0VBSfWGcvsqd7YbFWA6K2fr32c94MAuJw=
X-Google-Smtp-Source: ABdhPJzrw7LWnDPg6iiEqHxnnMTlbMyyhG3HnOp/WZcDjH/AFzwmJ/zYQmLsxzvA5bIs/tn/yndMky70SKTbT/9lCsU=
X-Received: by 2002:a05:600c:358c:b0:39c:97ed:baa5 with SMTP id
 p12-20020a05600c358c00b0039c97edbaa5mr15907718wmq.77.1655387981570; Thu, 16
 Jun 2022 06:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220613205032.2652374-1-robdclark@gmail.com> <CAE-0n51ADDijFnPwAQNwYE=62Rj4ZeQ38G7D=Xx3s5x7MRm18A@mail.gmail.com>
In-Reply-To: <CAE-0n51ADDijFnPwAQNwYE=62Rj4ZeQ38G7D=Xx3s5x7MRm18A@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 16 Jun 2022 06:59:46 -0700
Message-ID: <CAF6AEGtKiv+Y+BQSKvoydEN7W629_BRJR_sMEdFqsWCDRwsSQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gem: Drop obj lock in msm_gem_free_object()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
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

On Thu, Jun 16, 2022 at 1:28 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rob Clark (2022-06-13 13:50:32)
> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> > index d608339c1643..432032ad4aed 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > @@ -229,7 +229,19 @@ msm_gem_unlock(struct drm_gem_object *obj)
> >  static inline bool
> >  msm_gem_is_locked(struct drm_gem_object *obj)
> >  {
> > -       return dma_resv_is_locked(obj->resv);
> > +       /*
> > +        * Destroying the object is a special case.. msm_gem_free_object()
> > +        * calls many things that WARN_ON if the obj lock is not held.  But
> > +        * acquiring the obj lock in msm_gem_free_object() can cause a
> > +        * locking order inversion between reservation_ww_class_mutex and
> > +        * fs_reclaim.
> > +        *
> > +        * This deadlock is not actually possible, because no one should
> > +        * be already holding the lock when msm_gem_free_object() is called.
> > +        * Unfortunately lockdep is not aware of this detail.  So when the
> > +        * refcount drops to zero, we pretend it is already locked.
> > +        */
> > +       return dma_resv_is_locked(obj->resv) || (kref_read(&obj->refcount) == 0);
>
> Instead of modifying this function can we push down the fact that this
> function is being called from the free path and skip checking this
> condition in that case? Or add some "_locked/free_path" wrappers that
> skip the lock assertion? That would make it clearer to understand while
> reading the code that it is locked when it is asserted to be locked, and
> that we don't care when we're freeing because all references to the
> object are gone.

that was my earlier attempt, and I wasn't too happy with the result.
And then I realized if refcount==0 then by definition we aren't racing
with anyone else ;-)

> Here's a totally untested patch to show the idea. The comment about
> pretending the lock is held can be put in msm_gem_free_object() to
> clarify why it's OK to call the locked variants of the functions.
>
> ---8<---
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 97d5b4d8b9b0..01f19d37bfb6 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -346,13 +346,11 @@ static void del_vma(struct msm_gem_vma *vma)
>   * mapping.
>   */
>  static void
> -put_iova_spaces(struct drm_gem_object *obj, bool close)
> +put_iova_spaces_locked(struct drm_gem_object *obj, bool close)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
>         struct msm_gem_vma *vma;
>
> -       GEM_WARN_ON(!msm_gem_is_locked(obj));
> -
>         list_for_each_entry(vma, &msm_obj->vmas, list) {
>                 if (vma->aspace) {
>                         msm_gem_purge_vma(vma->aspace, vma);
> @@ -362,18 +360,28 @@ put_iova_spaces(struct drm_gem_object *obj, bool close)
>         }
>  }
>
> -/* Called with msm_obj locked */
> +static void put_iova_spaces(struct drm_gem_object *obj, bool close)
> +{
> +       GEM_WARN_ON(!msm_gem_is_locked(obj));
> +       put_iova_spaces_locked(obj, close);
> +}

they are both _locked paths ;-)

But in general I think the parallel code paths make things more
confusing about what is the right thing to call.  And I would like to
put more WARN_ON(!locked()) in the gem_vma code, to make it clear that
the obj lock is protecting things there as well.. which, with this
approach would turn into parallel code paths multiple levels deep

BR,
-R

> +
> +/* Called with msm_obj locked or on the free path */
>  static void
> -put_iova_vmas(struct drm_gem_object *obj)
> +put_iova_vmas_locked(struct drm_gem_object *obj)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
>         struct msm_gem_vma *vma, *tmp;
>
> -       GEM_WARN_ON(!msm_gem_is_locked(obj));
> -
> -       list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list) {
> +       list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list)
>                 del_vma(vma);
> -       }
> +}
> +
> +static void
> +put_iova_vmas(struct drm_gem_object *obj)
> +{
> +       GEM_WARN_ON(!msm_gem_is_locked(obj));
> +       put_iova_vmas_locked(obj);
>  }
>
>  static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
> @@ -795,12 +803,10 @@ void msm_gem_evict(struct drm_gem_object *obj)
>         update_inactive(msm_obj);
>  }
>
> -void msm_gem_vunmap(struct drm_gem_object *obj)
> +static void msm_gem_vunmap_locked(struct drm_gem_object *obj)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
>
> -       GEM_WARN_ON(!msm_gem_is_locked(obj));
> -
>         if (!msm_obj->vaddr || GEM_WARN_ON(!is_vunmapable(msm_obj)))
>                 return;
>
> @@ -808,6 +814,12 @@ void msm_gem_vunmap(struct drm_gem_object *obj)
>         msm_obj->vaddr = NULL;
>  }
>
> +void msm_gem_vunmap(struct drm_gem_object *obj)
> +{
> +       GEM_WARN_ON(!msm_gem_is_locked(obj));
> +       msm_gem_vunmap_locked(obj);
> +}
> +
>  void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
> @@ -1021,12 +1033,11 @@ void msm_gem_free_object(struct drm_gem_object *obj)
>         list_del(&msm_obj->mm_list);
>         mutex_unlock(&priv->mm_lock);
>
> -       msm_gem_lock(obj);
> -
>         /* object should not be on active list: */
>         GEM_WARN_ON(is_active(msm_obj));
>
> -       put_iova_spaces(obj, true);
> +       put_iova_spaces_locked(obj, true);
> +
>
>         if (obj->import_attach) {
>                 GEM_WARN_ON(msm_obj->vaddr);
> @@ -1036,19 +1047,13 @@ void msm_gem_free_object(struct drm_gem_object *obj)
>                  */
>                 kvfree(msm_obj->pages);
>
> -               put_iova_vmas(obj);
> -
> -               /* dma_buf_detach() grabs resv lock, so we need to unlock
> -                * prior to drm_prime_gem_destroy
> -                */
> -               msm_gem_unlock(obj);
> +               put_iova_vmas_locked(obj);
>
>                 drm_prime_gem_destroy(obj, msm_obj->sgt);
>         } else {
> -               msm_gem_vunmap(obj);
> +               msm_gem_vunmap_locked(obj);
>                 put_pages(obj);
> -               put_iova_vmas(obj);
> -               msm_gem_unlock(obj);
> +               put_iova_vmas_locked(obj);
>         }
>
>         drm_gem_object_release(obj);
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index c75d3b879a53..b2998a074de7 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -253,7 +253,6 @@ static inline bool is_purgeable(struct
> msm_gem_object *msm_obj)
>
>  static inline bool is_vunmapable(struct msm_gem_object *msm_obj)
>  {
> -       GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
>         return (msm_obj->vmap_count == 0) && msm_obj->vaddr;
>  }
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 086dacf2f26a..afff3a79e925 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -175,6 +175,7 @@ static const int vmap_shrink_limit = 15;
>  static bool
>  vmap_shrink(struct msm_gem_object *msm_obj)
>  {
> +       GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
>         if (!is_vunmapable(msm_obj))
>                 return false;
