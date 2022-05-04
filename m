Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4185199A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiEDIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiEDIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:25:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A041EC6D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:21:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so832095edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VDdx6SnTBc/x3hqSqeoZ0OfihXfqmRqnu+owhp1Pk7I=;
        b=kXpJCcqnJXYo6DFxpZt2zaSYdj84Z1DsaCnLwkmK08s6KqjJZdJtLXR3x8+xemf0rt
         kagg3meDbbs7FjgKS5jV/iwys9PwikMXkATlAt7yil8+zr6dSRgtgJjUq0rFTrtrT/fV
         IfB3lxf+nPGsdcygoRYzCtKb71OXk73EAk734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=VDdx6SnTBc/x3hqSqeoZ0OfihXfqmRqnu+owhp1Pk7I=;
        b=eZ/jDxxMehIo2no6WBQ6gCXChNXNg4g8v/eNQSSpXletsDjTjNv52CS2SHzaq16+cQ
         FJQIJnJ4D0KnSQWVAIF/XE1tOHmUpD/OSf2ZZjJ1mxi9V7gLRGnKz1x53/ekjmKJMxcv
         +a+w/+wX6pv+AMKQubufDHL7nl8YXpNSeNUGFhr/J1lX/fbOj5elmK4BUtFOpnRApgdn
         yN9YxeCiFdqS7ZiHSiCsTzQeSegQZfrusIuNNEOdRzQMmcoCgNLGnGLBwhanFQJODFuq
         Nr3HOWY3EKB8dNrwfTIwN/7QdQnH5aBMgUEQq2uDFHmdhU5fM0UyuMvclS12Do+SRzoD
         qo2w==
X-Gm-Message-State: AOAM533e/krxClU0H+ZXtR+STvZfpAQoG48v1vdV4t+4IYaMzLfwlhfR
        1k5y0UyCXKfc3vZLJIN8c65TwA==
X-Google-Smtp-Source: ABdhPJzDbGmxFILJU2oICyGZqcgGQFia6s4oybWBirwH1Joi8kUfhsVPZ4FaGStFNnYRj6Z0sKsRqg==
X-Received: by 2002:a05:6402:5205:b0:427:b431:e0ed with SMTP id s5-20020a056402520500b00427b431e0edmr18026088edd.186.1651652503231;
        Wed, 04 May 2022 01:21:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id cf4-20020a0564020b8400b00426488dce1dsm6209549edb.25.2022.05.04.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:21:42 -0700 (PDT)
Date:   Wed, 4 May 2022 10:21:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
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
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YnI3lE0TxLfZaQjE@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
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
 <20220417223707.157113-11-dmitry.osipenko@collabora.com>
 <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
 <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
 <YmlYHNlcmNMfOeyy@phenom.ffwll.local>
 <8f932ab0-bb72-8fea-4078-dc59e9164bd4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f932ab0-bb72-8fea-4078-dc59e9164bd4@collabora.com>
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

On Thu, Apr 28, 2022 at 09:31:00PM +0300, Dmitry Osipenko wrote:
> Hello Daniel,
> 
> 27.04.2022 17:50, Daniel Vetter пишет:
> > On Mon, Apr 18, 2022 at 10:18:54PM +0300, Dmitry Osipenko wrote:
> >> Hello,
> >>
> >> On 4/18/22 21:38, Thomas Zimmermann wrote:
> >>> Hi
> >>>
> >>> Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
> >>>> Replace drm_gem_shmem locks with the reservation lock to make GEM
> >>>> lockings more consistent.
> >>>>
> >>>> Previously drm_gem_shmem_vmap() and drm_gem_shmem_get_pages() were
> >>>> protected by separate locks, now it's the same lock, but it doesn't
> >>>> make any difference for the current GEM SHMEM users. Only Panfrost
> >>>> and Lima drivers use vmap() and they do it in the slow code paths,
> >>>> hence there was no practical justification for the usage of separate
> >>>> lock in the vmap().
> >>>>
> >>>> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> >>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>> ---
> >> ...
> >>>>   @@ -310,7 +306,7 @@ static int drm_gem_shmem_vmap_locked(struct
> >>>> drm_gem_shmem_object *shmem,
> >>>>       } else {
> >>>>           pgprot_t prot = PAGE_KERNEL;
> >>>>   -        ret = drm_gem_shmem_get_pages(shmem);
> >>>> +        ret = drm_gem_shmem_get_pages_locked(shmem);
> >>>>           if (ret)
> >>>>               goto err_zero_use;
> >>>>   @@ -360,11 +356,11 @@ int drm_gem_shmem_vmap(struct
> >>>> drm_gem_shmem_object *shmem,
> >>>>   {
> >>>>       int ret;
> >>>>   -    ret = mutex_lock_interruptible(&shmem->vmap_lock);
> >>>> +    ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
> >>>>       if (ret)
> >>>>           return ret;
> >>>>       ret = drm_gem_shmem_vmap_locked(shmem, map);
> >>>
> >>> Within drm_gem_shmem_vmap_locked(), there's a call to dma_buf_vmap() for
> >>> imported pages. If the exporter side also holds/acquires the same
> >>> reservation lock as our object, the whole thing can deadlock. We cannot
> >>> move dma_buf_vmap() out of the CS, because we still need to increment
> >>> the reference counter. I honestly don't know how to easily fix this
> >>> problem. There's a TODO item about replacing these locks at [1]. As
> >>> Daniel suggested this patch, we should talk to him about the issue.
> >>>
> >>> Best regards
> >>> Thomas
> >>>
> >>> [1]
> >>> https://www.kernel.org/doc/html/latest/gpu/todo.html#move-buffer-object-locking-to-dma-resv-lock
> >>
> >> Indeed, good catch! Perhaps we could simply use a separate lock for the
> >> vmapping of the *imported* GEMs? The vmap_use_count is used only by
> >> vmap/vunmap, so it doesn't matter which lock is used by these functions
> >> in the case of imported GEMs since we only need to protect the
> >> vmap_use_count.
> > 
> > Apologies for the late reply, I'm flooded.
> > 
> > I discussed this with Daniel Stone last week in a chat, roughly what we
> > need to do is:
> > 
> > 1. Pick a function from shmem helpers.
> > 
> > 2. Go through all drivers that call this, and make sure that we acquire
> > dma_resv_lock in the top level driver entry point for this.
> > 
> > 3. Once all driver code paths are converted, add a dma_resv_assert_held()
> > call to that function to make sure you have it all correctly.
> > 4. Repeate 1-3 until all shmem helper functions are converted over.
> Somehow I didn't notice the existence of dma_resv_assert_held(), thank
> you for the suggestion :)
> 
> > 
> > 5. Ditch the 3 different shmem helper locks.
> > 
> > The trouble is that I forgot that vmap is a thing, so that needs more
> > work. I think there's two approaches here:
> > - Do the vmap at import time. This is the trick we used to untangle the
> >   dma_resv_lock issues around dma_buf_attachment_map()
> 
> > - Change the dma_buf_vmap rules that callers must hold the dma_resv_lock.
> 
> I'll consider this option for v6, thank you.
> 
> I see now that you actually want to define the new rules for the
> dma-bufs in general and not only in the context of the DRM code, this
> now makes much more sense to me.

Yeah dma-buf is a cross driver interface, so we should try to be
consistent here. We didn't do this in the past, where the only reason you
didn't get lockdep splats was because you normally didn't run all possible
combinations of drivers and importer/exporter relationships in one system.
But that means it becomes very tricky to reason about how dma-buf really
works.

> > - Maybe also do what you suggest and keep a separate lock for this, but
> >   the fundamental issue is that this doesn't really work - if you share
> >   buffers both ways with two drivers using shmem helpers, then the
> >   ordering of this vmap_count_mutex vs dma_resv_lock is inconsistent and
> >   you can get some nice deadlocks. So not a great approach (and also the
> >   reason why we really need to get everyone to move towards dma_resv_lock
> >   as _the_ buffer object lock, since otherwise we'll never get a
> >   consistent lock nesting hierarchy).
> 
> The separate locks should work okay because it will be always the
> exporter that takes the dma_resv_lock. But I agree that it's less ideal
> than defining the new rules for dma-bufs since sometime you will take
> the resv lock and sometime not, potentially hiding bugs related to lockings.

That's the issue, some importers need to take the dma_resv_lock for
dma_buf_vmap too (e.g. to first nail the buffer in place when it's a
dynamic memory manager). In practice it'll work as well as what we have
currently, which is similarly inconsistent, except with per-driver locks
instead of shared locks from shmem helpers or dma-buf, so less obvious
that things are inconsistent.

So yeah if it's too messy maybe the approach is to have a separate lock
for vmap for now, land things, and then fix up dma_buf_vmap in a follow up
series.
-Daniel

> > The trouble here is that trying to be clever and doing the conversion just
> > in shmem helpers wont work, because there's a lot of cases where the
> > drivers are all kinds of inconsistent with their locking.
> > 
> > Adding Daniel S, also maybe for questions it'd be fastest to chat on irc?
> 
> My nickname is digetx on the #dri-devel channel, feel free to ping me if
> needed. Right now yours suggestions are clear to me, hence no extra
> questions.
> 
> Thank you for the review.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
