Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30503511992
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiD0OxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbiD0OxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:53:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EF403CE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:50:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so2238590edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2ukhvq6UCkilr6qtjyCJGVeLtyAJOtLrDnxOLi9CaTw=;
        b=EVO0ouyrgiZootRwq5voIFao1mlr3tWZKAxywItZk5du+HZwD4P2s5o/P/joQkbtwK
         QooStUd0Yx0O2Z+XDGfydzdAP/FbPjNWO4WxY8O0nGE72bfq4ax7/ehYBzkWh7TclOP5
         VxcoSpLJg9f3J4Dh6xWwfRPO1gbuX/nryjY1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2ukhvq6UCkilr6qtjyCJGVeLtyAJOtLrDnxOLi9CaTw=;
        b=dqXI9UsD8zH/l4w21kkJIxxdQ/IK8/GKhVXQOd+/JMc+3nn3QeXa2yf6kCoSeeCsEt
         j4xQ7x0vZSl0AOJwOTNF60We7d8DK834L/jdWpMialrzl/a1moeheadTMz7No+/y+o9+
         JKDlqw2qQ3z8EX4Ykg7UQZNniZEh2odaQPEOS6jh5HdUTbrSZmEAV8t2ECKB2yASq7kZ
         lBW22zWXeRIYWac9ldbk3JinFIsjvdquozCPQCY3zBsfC9dFD/5oC5TiXE68voke1cyM
         kPcrrCFbqy6zVRVT3m1fe8EsGVipwcdW4REjgO+PoQZ+tnEQFxIa2RTjpOmCeahPdutt
         tNPQ==
X-Gm-Message-State: AOAM531DITIyd46bz72KXQCnSmduLCaRA1SQ7OvBVwYnbTL4IaziYaSJ
        VTVWzwxsKByonOTktE2m/tIx6A==
X-Google-Smtp-Source: ABdhPJxMlHpjWS0SulDJ6s+ciG4icei4dr6Xqjg815QsDmVCoJLzvCGXG89ebz4XatZjLaBdvYNUnQ==
X-Received: by 2002:a05:6402:34d2:b0:423:e6c4:3e9 with SMTP id w18-20020a05640234d200b00423e6c403e9mr31451583edc.372.1651071007653;
        Wed, 27 Apr 2022 07:50:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709066d1100b006f39b1d3addsm3963081ejr.196.2022.04.27.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:50:06 -0700 (PDT)
Date:   Wed, 27 Apr 2022 16:50:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>
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
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YmlYHNlcmNMfOeyy@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:18:54PM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> On 4/18/22 21:38, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
> >> Replace drm_gem_shmem locks with the reservation lock to make GEM
> >> lockings more consistent.
> >>
> >> Previously drm_gem_shmem_vmap() and drm_gem_shmem_get_pages() were
> >> protected by separate locks, now it's the same lock, but it doesn't
> >> make any difference for the current GEM SHMEM users. Only Panfrost
> >> and Lima drivers use vmap() and they do it in the slow code paths,
> >> hence there was no practical justification for the usage of separate
> >> lock in the vmap().
> >>
> >> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> ...
> >>   @@ -310,7 +306,7 @@ static int drm_gem_shmem_vmap_locked(struct
> >> drm_gem_shmem_object *shmem,
> >>       } else {
> >>           pgprot_t prot = PAGE_KERNEL;
> >>   -        ret = drm_gem_shmem_get_pages(shmem);
> >> +        ret = drm_gem_shmem_get_pages_locked(shmem);
> >>           if (ret)
> >>               goto err_zero_use;
> >>   @@ -360,11 +356,11 @@ int drm_gem_shmem_vmap(struct
> >> drm_gem_shmem_object *shmem,
> >>   {
> >>       int ret;
> >>   -    ret = mutex_lock_interruptible(&shmem->vmap_lock);
> >> +    ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
> >>       if (ret)
> >>           return ret;
> >>       ret = drm_gem_shmem_vmap_locked(shmem, map);
> > 
> > Within drm_gem_shmem_vmap_locked(), there's a call to dma_buf_vmap() for
> > imported pages. If the exporter side also holds/acquires the same
> > reservation lock as our object, the whole thing can deadlock. We cannot
> > move dma_buf_vmap() out of the CS, because we still need to increment
> > the reference counter. I honestly don't know how to easily fix this
> > problem. There's a TODO item about replacing these locks at [1]. As
> > Daniel suggested this patch, we should talk to him about the issue.
> > 
> > Best regards
> > Thomas
> > 
> > [1]
> > https://www.kernel.org/doc/html/latest/gpu/todo.html#move-buffer-object-locking-to-dma-resv-lock
> 
> Indeed, good catch! Perhaps we could simply use a separate lock for the
> vmapping of the *imported* GEMs? The vmap_use_count is used only by
> vmap/vunmap, so it doesn't matter which lock is used by these functions
> in the case of imported GEMs since we only need to protect the
> vmap_use_count.

Apologies for the late reply, I'm flooded.

I discussed this with Daniel Stone last week in a chat, roughly what we
need to do is:

1. Pick a function from shmem helpers.

2. Go through all drivers that call this, and make sure that we acquire
dma_resv_lock in the top level driver entry point for this.

3. Once all driver code paths are converted, add a dma_resv_assert_held()
call to that function to make sure you have it all correctly.

4. Repeate 1-3 until all shmem helper functions are converted over.

5. Ditch the 3 different shmem helper locks.

The trouble is that I forgot that vmap is a thing, so that needs more
work. I think there's two approaches here:
- Do the vmap at import time. This is the trick we used to untangle the
  dma_resv_lock issues around dma_buf_attachment_map()
- Change the dma_buf_vmap rules that callers must hold the dma_resv_lock.
- Maybe also do what you suggest and keep a separate lock for this, but
  the fundamental issue is that this doesn't really work - if you share
  buffers both ways with two drivers using shmem helpers, then the
  ordering of this vmap_count_mutex vs dma_resv_lock is inconsistent and
  you can get some nice deadlocks. So not a great approach (and also the
  reason why we really need to get everyone to move towards dma_resv_lock
  as _the_ buffer object lock, since otherwise we'll never get a
  consistent lock nesting hierarchy).

The trouble here is that trying to be clever and doing the conversion just
in shmem helpers wont work, because there's a lot of cases where the
drivers are all kinds of inconsistent with their locking.

Adding Daniel S, also maybe for questions it'd be fastest to chat on irc?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
