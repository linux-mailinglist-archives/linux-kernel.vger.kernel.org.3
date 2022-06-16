Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2254DCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiFPI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiFPI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:29:01 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287D5DA30
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:29:00 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-fe023ab520so1046684fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=0AalHbH5lNk201mZ98hB412vqqVqDD6OSz4kp0XaI6E=;
        b=DORHNi2iEHtlclkLAQZX/cSf3ItqnU9R+RT+8QZHLTApDHQO4QLd84/xxSUCpCqNuR
         9Rr6ePdkSrdUxed7grdE8AYhIWbYwkXrhfUVeXfM11odlC+BXoAjqSTyn+1KfNf52kis
         DAvOMzPboaHtVXDC2uLwsKeWcEhnRpMSWSNqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=0AalHbH5lNk201mZ98hB412vqqVqDD6OSz4kp0XaI6E=;
        b=wh5tE50+YIsH6yex6CkSzu506L9gETAfHrLkLhW+OBa5AM8P6M5yY6hnnYbIJT77aK
         0igCNBUJ97/i1cRUDqxVrmiTd/S6BFecaUjeVjkiCf+uVKll/KfteQ8r8uSC9n1C6eQ9
         K7SZ60ShthN0VRGzzgM8YW5rgvM5mPG+ftavtVXN/ntHX14h7R9tB6gaQOnw96VCuABG
         WqIwsupnn+yQXi/xJ4U8ZX631f5MFKJoPGvRTh32YwtNZCooW3bSgj2UF9/5oKTOYgO8
         CkTFao8tXT+6Yn2rFj1H4GxA2i6PtB+huE3Y+Ux31UtX5QEUPVemIZ53L+Br1mza+eho
         nrJA==
X-Gm-Message-State: AJIora+h1T1giDxFl2sVce0Hhi5xy9hgliP0W3M+/Lb0mSy+k/Q269U8
        QQDkSVQ65yRJ9fpfJ2yPqGNHS/Zk7wHrdJJAq6cRpQ==
X-Google-Smtp-Source: AGRyM1uXgNqoIVp4zh6blYrU2GpEEzoJ+XSdI2WTm44if1kvy/PfW44B2udC0Qj+WYiDz6t6gB3iSjNtvCg+Mvyc1Gc=
X-Received: by 2002:a05:6870:b48a:b0:101:40eb:63a3 with SMTP id
 y10-20020a056870b48a00b0010140eb63a3mr1935706oap.193.1655368138768; Thu, 16
 Jun 2022 01:28:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jun 2022 01:28:58 -0700
MIME-Version: 1.0
In-Reply-To: <20220613205032.2652374-1-robdclark@gmail.com>
References: <20220613205032.2652374-1-robdclark@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 16 Jun 2022 01:28:58 -0700
Message-ID: <CAE-0n51ADDijFnPwAQNwYE=62Rj4ZeQ38G7D=Xx3s5x7MRm18A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gem: Drop obj lock in msm_gem_free_object()
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2022-06-13 13:50:32)
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index d608339c1643..432032ad4aed 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -229,7 +229,19 @@ msm_gem_unlock(struct drm_gem_object *obj)
>  static inline bool
>  msm_gem_is_locked(struct drm_gem_object *obj)
>  {
> -       return dma_resv_is_locked(obj->resv);
> +       /*
> +        * Destroying the object is a special case.. msm_gem_free_object()
> +        * calls many things that WARN_ON if the obj lock is not held.  But
> +        * acquiring the obj lock in msm_gem_free_object() can cause a
> +        * locking order inversion between reservation_ww_class_mutex and
> +        * fs_reclaim.
> +        *
> +        * This deadlock is not actually possible, because no one should
> +        * be already holding the lock when msm_gem_free_object() is called.
> +        * Unfortunately lockdep is not aware of this detail.  So when the
> +        * refcount drops to zero, we pretend it is already locked.
> +        */
> +       return dma_resv_is_locked(obj->resv) || (kref_read(&obj->refcount) == 0);

Instead of modifying this function can we push down the fact that this
function is being called from the free path and skip checking this
condition in that case? Or add some "_locked/free_path" wrappers that
skip the lock assertion? That would make it clearer to understand while
reading the code that it is locked when it is asserted to be locked, and
that we don't care when we're freeing because all references to the
object are gone.

Here's a totally untested patch to show the idea. The comment about
pretending the lock is held can be put in msm_gem_free_object() to
clarify why it's OK to call the locked variants of the functions.

---8<---
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 97d5b4d8b9b0..01f19d37bfb6 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -346,13 +346,11 @@ static void del_vma(struct msm_gem_vma *vma)
  * mapping.
  */
 static void
-put_iova_spaces(struct drm_gem_object *obj, bool close)
+put_iova_spaces_locked(struct drm_gem_object *obj, bool close)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma;

-	GEM_WARN_ON(!msm_gem_is_locked(obj));
-
 	list_for_each_entry(vma, &msm_obj->vmas, list) {
 		if (vma->aspace) {
 			msm_gem_purge_vma(vma->aspace, vma);
@@ -362,18 +360,28 @@ put_iova_spaces(struct drm_gem_object *obj, bool close)
 	}
 }

-/* Called with msm_obj locked */
+static void put_iova_spaces(struct drm_gem_object *obj, bool close)
+{
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	put_iova_spaces_locked(obj, close);
+}
+
+/* Called with msm_obj locked or on the free path */
 static void
-put_iova_vmas(struct drm_gem_object *obj)
+put_iova_vmas_locked(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma, *tmp;

-	GEM_WARN_ON(!msm_gem_is_locked(obj));
-
-	list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list) {
+	list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list)
 		del_vma(vma);
-	}
+}
+
+static void
+put_iova_vmas(struct drm_gem_object *obj)
+{
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	put_iova_vmas_locked(obj);
 }

 static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
@@ -795,12 +803,10 @@ void msm_gem_evict(struct drm_gem_object *obj)
 	update_inactive(msm_obj);
 }

-void msm_gem_vunmap(struct drm_gem_object *obj)
+static void msm_gem_vunmap_locked(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);

-	GEM_WARN_ON(!msm_gem_is_locked(obj));
-
 	if (!msm_obj->vaddr || GEM_WARN_ON(!is_vunmapable(msm_obj)))
 		return;

@@ -808,6 +814,12 @@ void msm_gem_vunmap(struct drm_gem_object *obj)
 	msm_obj->vaddr = NULL;
 }

+void msm_gem_vunmap(struct drm_gem_object *obj)
+{
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_vunmap_locked(obj);
+}
+
 void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
@@ -1021,12 +1033,11 @@ void msm_gem_free_object(struct drm_gem_object *obj)
 	list_del(&msm_obj->mm_list);
 	mutex_unlock(&priv->mm_lock);

-	msm_gem_lock(obj);
-
 	/* object should not be on active list: */
 	GEM_WARN_ON(is_active(msm_obj));

-	put_iova_spaces(obj, true);
+	put_iova_spaces_locked(obj, true);
+

 	if (obj->import_attach) {
 		GEM_WARN_ON(msm_obj->vaddr);
@@ -1036,19 +1047,13 @@ void msm_gem_free_object(struct drm_gem_object *obj)
 		 */
 		kvfree(msm_obj->pages);

-		put_iova_vmas(obj);
-
-		/* dma_buf_detach() grabs resv lock, so we need to unlock
-		 * prior to drm_prime_gem_destroy
-		 */
-		msm_gem_unlock(obj);
+		put_iova_vmas_locked(obj);

 		drm_prime_gem_destroy(obj, msm_obj->sgt);
 	} else {
-		msm_gem_vunmap(obj);
+		msm_gem_vunmap_locked(obj);
 		put_pages(obj);
-		put_iova_vmas(obj);
-		msm_gem_unlock(obj);
+		put_iova_vmas_locked(obj);
 	}

 	drm_gem_object_release(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c75d3b879a53..b2998a074de7 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -253,7 +253,6 @@ static inline bool is_purgeable(struct
msm_gem_object *msm_obj)

 static inline bool is_vunmapable(struct msm_gem_object *msm_obj)
 {
-	GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
 	return (msm_obj->vmap_count == 0) && msm_obj->vaddr;
 }

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c
b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 086dacf2f26a..afff3a79e925 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -175,6 +175,7 @@ static const int vmap_shrink_limit = 15;
 static bool
 vmap_shrink(struct msm_gem_object *msm_obj)
 {
+	GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
 	if (!is_vunmapable(msm_obj))
 		return false;
