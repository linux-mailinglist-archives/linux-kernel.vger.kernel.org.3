Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1641511E61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiD0PHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiD0PHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:07:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DE3153F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:04:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i19so3954386eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9Itb0glNjLzsda2ha8Sg4vczWB8285tOkwDDoPJtWk8=;
        b=L0ydeR/2rcnWI7IC+FLalVfL5PrFO0wiIWSUmlTuFGoqbiX1PxEDzpqqF8NOitaTY6
         AJe7ePcHH60qzdiVbDk5gPhR2BTMdXJa4EMexGYPsLBdmg3Zf13+4BOSifpxn4jxBlhr
         UUzhzaqaeNoaNq7RaJ1t2XVN42jf1+tQKcmpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=9Itb0glNjLzsda2ha8Sg4vczWB8285tOkwDDoPJtWk8=;
        b=IttnFD4XgsmjS5rqeD5ES1A5BjIBGwNwQkVB7swXdTjU7iwRYvnttQNvU49tWT2FDu
         17ghIYrHpyMUb384tGeYD5UHLUg2mE6LTmwvo2WGpJj2bkMxeKAabm02JcZX7LKZM4Qd
         b9ZWOU4vo4t+Ymt6m5JfQo3QrGKhB7+dV6l6BmtR0BYEDkA4wfVIUWpC1X5PV/8KwDfb
         jsXzEdE5CGaoBHCd6LKzd7nUJYSpMT/Spl5qU3KmsJkgY9YAEV6OBoqo6e6lVPeBGan9
         fcspZJqcrYT/pxkDEA2xWyqOm/qmBqthXIz3GkZMuybuYOwy169eGHDLvm2aJlXe/a41
         ZGMA==
X-Gm-Message-State: AOAM530k6nHSyfPkO7SP6Ev59XgEb01LOlkQX5He3Cv7V+EcWQyQxRCW
        MEUctOQ/5OSnOvVYaVHPkGz0RA==
X-Google-Smtp-Source: ABdhPJxn3J1YOjf7N2ftgkiOzZwCbB1eDMKJ2IPMJQ0cUJ4r8LLbOyG5qJSje406PmcIBG+D3tyDog==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id gt42-20020a1709072daa00b006da924e0955mr26796476ejc.1.1651071841010;
        Wed, 27 Apr 2022 08:04:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906124600b006e843964f9asm6811575eja.55.2022.04.27.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:04:00 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:03:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <YmlbXoeaVds/bjYn@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-12-dmitry.osipenko@collabora.com>
 <ebe3dfdb-04ac-9ab1-64ff-9d54f96afe57@suse.de>
 <7f497f99-f4c1-33d6-46cf-95bd90188fe3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f497f99-f4c1-33d6-46cf-95bd90188fe3@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:40:41PM +0300, Dmitry Osipenko wrote:
> On 4/19/22 10:22, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
> >> Introduce a common DRM SHMEM shrinker. It allows to reduce code
> >> duplication among DRM drivers that implement theirs own shrinkers.
> >> This is initial version of the shrinker that covers basic needs of
> >> GPU drivers, both purging and eviction of shmem objects are supported.
> >>
> >> This patch is based on a couple ideas borrowed from Rob's Clark MSM
> >> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
> >>
> >> In order to start using DRM SHMEM shrinker drivers should:
> >>
> >> 1. Implement new purge(), evict() + swap_in() GEM callbacks.
> >> 2. Register shrinker using drm_gem_shmem_shrinker_register(drm_device).
> >> 3. Use drm_gem_shmem_set_purgeable_and_evictable(shmem) and alike API
> >>     functions to activate shrinking of GEMs.
> >>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>   drivers/gpu/drm/drm_gem_shmem_helper.c | 765 ++++++++++++++++++++++++-
> >>   include/drm/drm_device.h               |   4 +
> >>   include/drm/drm_gem.h                  |  35 ++
> >>   include/drm/drm_gem_shmem_helper.h     | 105 +++-
> >>   4 files changed, 877 insertions(+), 32 deletions(-)
> ...
> >> @@ -172,6 +172,41 @@ struct drm_gem_object_funcs {
> >>        * This is optional but necessary for mmap support.
> >>        */
> >>       const struct vm_operations_struct *vm_ops;
> >> +
> >> +    /**
> >> +     * @purge:
> >> +     *
> >> +     * Releases the GEM object's allocated backing storage to the
> >> system.
> >> +     *
> >> +     * Returns the number of pages that have been freed by purging
> >> the GEM object.
> >> +     *
> >> +     * This callback is used by the GEM shrinker.
> >> +     */
> >> +    unsigned long (*purge)(struct drm_gem_object *obj);

Hm I feel like drivers shouldn't need to know the difference here?

Like shmem helpers can track what's purgeable, and for eviction/purging
the driver callback should do the same?

The only difference is when we try to re-reserve the backing storage. When
the object has been evicted that should suceed, but when the object is
purged that will fail.

That's the difference between evict and purge for drivers?

> >> +
> >> +    /**
> >> +     * @evict:
> >> +     *
> >> +     * Unpins the GEM object's allocated backing storage, allowing
> >> shmem pages
> >> +     * to be swapped out.
> > 
> > What's the difference to the existing unpin() callback?
> 
> Drivers need to do more than just unpinning pages when GEMs are evicted.
> Unpinning is only a part of the eviction process. I'll improve the
> doc-comment in v5.
> 
> For example, for VirtIO-GPU driver we need to to detach host from the
> guest's memory before pages are evicted [1].
> 
> [1]
> https://gitlab.collabora.com/dmitry.osipenko/linux-kernel-rd/-/blob/932eb03198bce3a21353b09ab71e95f1c19b84c2/drivers/gpu/drm/virtio/virtgpu_object.c#L145
> 
> In case of Panfrost driver, we will need to remove mappings before pages
> are evicted.

It might be good to align this with ttm, otoh that all works quite a bit
differently for ttm since ttm supports buffer moves and a lot more fancy
stuff.

I'm bringing this up since I have this fancy idea that eventually we could
glue shmem helpers into ttm in some cases for managing buffers when they
sit in system memory (as opposed to vram).

> >> +     *
> >> +     * Returns the number of pages that have been unpinned.
> >> +     *
> >> +     * This callback is used by the GEM shrinker.
> >> +     */
> >> +    unsigned long (*evict)(struct drm_gem_object *obj);
> >> +
> >> +    /**
> >> +     * @swap_in:
> >> +     *
> >> +     * Pins GEM object's allocated backing storage if it was
> >> previously evicted,
> >> +     * moving swapped out pages back to memory.
> >> +     *
> >> +     * Returns 0 on success, or -errno on error.
> >> +     *
> >> +     * This callback is used by the GEM shrinker.
> >> +     */
> >> +    int (*swap_in)(struct drm_gem_object *obj);
> > 
> > Why do you need swap_in()? This can be done on-demand as part of a pin
> > or vmap operation.
> 
> Similarly to the unpinning, the pining of pages is only a part of what
> needs to be done for GPU drivers. Besides of returning pages back to
> memory, we also need to make them accessible to GPU and this is a
> driver-specific process. This why we need the additional callbacks.

This is a bit much midlayer. The way this works in ttm is you reserve all
the objects you need (which makes sure they're physically available
again), and then the driver goes through and makes sure the page tables
are all set up again.

Once you get towards gpu vm that's really the only approach, since your
swap_in has no idea for which vm it needs to restore pagetables (and
restoring it for all is a bit meh).

If drivers want to optimize this they can adjust/set any tracking
information from their evict callback as needed.

> 
> >>   };
> >>     /**
> >> diff --git a/include/drm/drm_gem_shmem_helper.h
> >> b/include/drm/drm_gem_shmem_helper.h
> >> index 70889533962a..a65557b446e6 100644
> >> --- a/include/drm/drm_gem_shmem_helper.h
> >> +++ b/include/drm/drm_gem_shmem_helper.h
> >> @@ -6,6 +6,7 @@
> >>   #include <linux/fs.h>
> >>   #include <linux/mm.h>
> >>   #include <linux/mutex.h>
> >> +#include <linux/shrinker.h>
> >>     #include <drm/drm_file.h>
> >>   #include <drm/drm_gem.h>
> >> @@ -15,8 +16,18 @@
> >>   struct dma_buf_attachment;
> >>   struct drm_mode_create_dumb;
> >>   struct drm_printer;
> >> +struct drm_device;
> >>   struct sg_table;
> >>   +enum drm_gem_shmem_pages_state {
> >> +    DRM_GEM_SHMEM_PAGES_STATE_PURGED = -2,
> >> +    DRM_GEM_SHMEM_PAGES_STATE_EVICTED = -1,
> >> +    DRM_GEM_SHMEM_PAGES_STATE_UNPINNED = 0,
> >> +    DRM_GEM_SHMEM_PAGES_STATE_PINNED = 1,
> >> +    DRM_GEM_SHMEM_PAGES_STATE_EVICTABLE = 2,
> >> +    DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE = 3,
> >> +};
> > 
> > These states can be detected by looking at the vmap and pin refcounts.
> > No need to store them explicitly.
> 
> I'll try to revisit this, but I was finding that it's much more
> difficult to follow and debug code without the explicit states.

purgeable/purged needs some state, but pinned shouldn't be duplicated, so
I concur here a bit.

> > In your patch, they also come with a
> > big zoo of trivial helpers. None of that seems necessary AFAICT.
> 
> There are couple functions which could be squashed, although this may
> hurt readability of the code a tad. I'll try to take another look at
> this for v5.
> 
> > What's the difference between purge and evict BTW?
> 
> The evicted pages are moved out from memory to a SWAP partition or file.
> 
> The purged pages are destroyed permanently.
> 
> >> +
> >>   /**
> >>    * struct drm_gem_shmem_object - GEM object backed by shmem
> >>    */
> >> @@ -43,8 +54,8 @@ struct drm_gem_shmem_object {
> >>        * @madv: State for madvise
> >>        *
> >>        * 0 is active/inuse.
> >> +     * 1 is not-needed/can-be-purged
> >>        * A negative value is the object is purged.
> >> -     * Positive values are driver specific and not used by the helpers.
> >>        */
> >>       int madv;
> >>   @@ -91,6 +102,40 @@ struct drm_gem_shmem_object {
> >>        * @map_wc: map object write-combined (instead of using shmem
> >> defaults).
> >>        */
> >>       bool map_wc;
> >> +
> >> +    /**
> >> +     * @eviction_disable_count:
> >> +     *
> >> +     * The shmem pages are disallowed to be evicted by the memory
> >> shrinker
> >> +     * while count is non-zero. Used internally by memory shrinker.
> >> +     */
> >> +    unsigned int eviction_disable_count;
> >> +
> >> +    /**
> >> +     * @purging_disable_count:
> >> +     *
> >> +     * The shmem pages are disallowed to be purged by the memory
> >> shrinker
> >> +     * while count is non-zero. Used internally by memory shrinker.
> >> +     */
> >> +    unsigned int purging_disable_count;

What are these disable counts for?

The way purgeable works in other drivers is that userspace sets purgeable
or not, and it's up to userspace to not make a mess of this.

There's also some interactions, and I guess a bunch of drivers get this
wrong in funny ways. Not sure how to best clean this up.

- Once you have a shrinker/dynamic memory management you should _not_ pin
  pages, except when it's truly permanent like for scanout. Instead
  drivers should attach dma_fence to the dma_resv to denote in-flight
  access.

- A pinned buffer object is not allowed to be put into purgeable state,
  and a bo in purgeable state should not be allowed to be pinned.

- Drivers need to hold dma_resv_lock for long enough in their command
  submission, i.e. from the point where the reserve the buffers and make
  sure that mappings exists, to the point where the request is submitted
  to hw or drm/sched and fences are installed.

But I think a lot of current shmem users just pin as part of execbuf, so
this won't work quite so well right out of the box.

Anyway with that design I don't think there should ever be a need to
disable shrinking.

> >> +
> >> +    /**
> >> +     * @pages_state: Current state of shmem pages. Used internally by
> >> +     * memory shrinker.
> >> +     */
> >> +    enum drm_gem_shmem_pages_state pages_state;
> >> +
> >> +    /**
> >> +     * @evicted: True if shmem pages were evicted by the memory
> >> shrinker.
> >> +     * Used internally by memory shrinker.
> >> +     */
> >> +    bool evicted;
> >> +
> >> +    /**
> >> +     * @pages_shrinkable: True if shmem pages can be evicted or purged
> >> +     * by the memory shrinker. Used internally by memory shrinker.
> >> +     */
> >> +    bool pages_shrinkable;
> > 
> > As commented before, this state can be foundby looking at existing
> > fields. No need to store it separately.
> 
> When we're transitioning from "evictable" to a "purgeable" state, we
> must not add pages twice to the "shrinkable_count" variable. Hence this
> is not a state, but a variable which prevents the double accounting of
> the pages. Please see drm_gem_shmem_add_pages_to_shrinker() in this patch.
> 
> Perhaps something like "pages_accounted_by_shrinker" could be a better
> name for the variable. I'll revisit this for v5.

Hm not sure we need to account this? Usually the shrinker just counts when
it's asked to do so, not practively maintain that count. Once you start
shrinking burning cpu time is generally not too terrible.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
