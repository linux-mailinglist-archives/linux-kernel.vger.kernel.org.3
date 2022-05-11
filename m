Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8B523D28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiEKTJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbiEKTJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:09:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055436EC56
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:09:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so5979414ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2DykjHAMdlStYb5EmcYSUR1Pkzo63PzxwPMaZ8LvFo=;
        b=RyFGCFRtSxjZc9mIoytVCXq/YWGjqf+7X1f1onqM7tbKpLpI5ilS0HD3W+wryYO3eA
         OxxE2IpBo99CuN/f3UvdN2TyQdKnAWqhafI0mCX9WQ2GKArXjz3PpjvEofURYxNFo5Yb
         zCYHi0yxeD9Ub457ewESExxn2/2ovvErrm4A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=M2DykjHAMdlStYb5EmcYSUR1Pkzo63PzxwPMaZ8LvFo=;
        b=IWVY+SOHy8eQkFC+KrxjelW5bmA6A8uCfTJtdvBvhI6vBfBxocAPHGFI63NtpGenkX
         +OmVFhvmUXQWPWUrHawCMx8aNtTtPTLrJE1a/Zt5JuHEyR0FQtnbbpVzhpCF6SMRgPeh
         cKnmCQxkdxflX2KpenUdVoY6/RdoMZ/mXJ6VC7tzdYaRvmJmGrlODE/lshU3W1AibYNE
         l5mY+Av6lk5VZB6ynrFyeBdzbIr3fPI/ENLE5+xxaMUcgXaIwVcn2p4QlVepQV/VAP5H
         sqF/cD50wi9q2vOKkpRuB7dL2a20Usg9J6w1+1U0KHI31JCyBlav2R9UOqVnDS5I0btu
         chgw==
X-Gm-Message-State: AOAM532StfQHPGXg2JvPJd93VWtOOl16hJiKF6VRpbiV7EIRm/ZZBVl4
        1pUCD2wh1oZ6n4DPrDE4IPGsNA==
X-Google-Smtp-Source: ABdhPJw9Nd8vnPYqEL0MNAFmVh+U7IZ/wircjNLfEqm8Te3y/rY6G1oUIM7+PpLhbG8Z+WzygG5ebQ==
X-Received: by 2002:a17:907:2d07:b0:6f4:36fe:f1c with SMTP id gs7-20020a1709072d0700b006f436fe0f1cmr26449179ejc.383.1652296149389;
        Wed, 11 May 2022 12:09:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y13-20020a056402134d00b0042617ba63d6sm1528596edw.96.2022.05.11.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:09:08 -0700 (PDT)
Date:   Wed, 11 May 2022 21:09:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
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
Message-ID: <YnwJ0kLwLS7RxuwS@phenom.ffwll.local>
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
 <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
 <ff97790a-fb64-1e15-74b4-59c807bce0b9@collabora.com>
 <Ynkb1U2nNWYPML88@phenom.ffwll.local>
 <5fdf5232-e2b2-b444-5a41-f1db7e6a04da@collabora.com>
 <Ynu1k5lH+xvqtObG@phenom.ffwll.local>
 <3429a12f-9fbe-b66b-dbbd-94a1df54714e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3429a12f-9fbe-b66b-dbbd-94a1df54714e@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:06:18PM +0300, Dmitry Osipenko wrote:
> On 5/11/22 16:09, Daniel Vetter wrote:
> >>>>> I'd like to ask you to reduce the scope of the patchset and build the
> >>>>> shrinker only for virtio-gpu. I know that I first suggested to build
> >>>>> upon shmem helpers, but it seems that it's easier to do that in a later
> >>>>> patchset.
> >>>> The first version of the VirtIO shrinker didn't support memory eviction.
> >>>> Memory eviction support requires page fault handler to be aware of the
> >>>> evicted pages, what should we do about it? The page fault handling is a
> >>>> part of memory management, hence to me drm-shmem is already kinda a MM.
> >>> Hm I still don't get that part, why does that also not go through the
> >>> shmem helpers?
> >> The drm_gem_shmem_vm_ops includes the page faults handling, it's a
> >> helper by itself that is used by DRM drivers.
> >>
> >> I could try to move all the shrinker logic to the VirtIO and re-invent
> >> virtio_gem_shmem_vm_ops, but what is the point of doing this for each
> >> driver if we could have it once and for all in the common drm-shmem code?
> >>
> >> Maybe I should try to factor out all the shrinker logic from drm-shmem
> >> into a new drm-shmem-shrinker that could be shared by drivers? Will you
> >> be okay with this option?
> > I think we're talking past each another a bit. I'm only bringing up the
> > purge vs eviction topic we discussed in the other subthread again.
> 
> Thomas asked to move the whole shrinker code to the VirtIO driver and
> I's saying that this is not a great idea to me, or am I misunderstanding
> the Thomas' suggestion? Thomas?

I think it was just me creating a confusion here.

fwiw I do also think that shrinker in shmem helpers makes sense, just in
case that was also lost in confusion.

> >>> I'm still confused why drivers need to know the difference
> >>> between evition and purging. Or maybe I'm confused again.
> >> Example:
> >>
> >> If userspace uses IOV addresses, then these addresses must be kept
> >> reserved while buffer is evicted.
> >>
> >> If BO is purged, then we don't need to retain the IOV space allocated
> >> for the purged BO.
> > Yeah but is that actually needed by anyone? If userspace fails to allocate
> > another bo because of lack of gpu address space then it's very easy to
> > handle that:
> > 
> > 1. Make a rule that "out of gpu address space" gives you a special errno
> > code like ENOSPC
> > 
> > 2. If userspace gets that it walks the list of all buffers it marked as
> > purgeable and nukes them (whether they have been evicted or not). Then it
> > retries the bo allocation.
> > 
> > Alternatively you can do step 2 also directly from the bo alloc ioctl in
> > step 1. Either way you clean up va space, and actually a lot more (you
> > potentially nuke all buffers marked as purgeable, not just the ones that
> > have been purged already) and only when va cleanup is actually needed
> > 
> > Trying to solve this problem at eviction time otoh means:
> > - we have this difference between eviction and purging
> > - it's still not complete, you still need to glue step 2 above into your
> >   driver somehow, and once step 2 above is glued in doing additional
> >   cleanup in the purge function is just duplicated logic
> > 
> > So at least in my opinion this isn't the justification we need. And we
> > should definitely not just add that complication "in case, for the
> > future", if we don't have a real need right now. Adding it later on is
> > easy, removing it later on because it just gets in the way and confuses is
> > much harder.
> 
> The IOVA space is only one example.
> 
> In case of the VirtIO driver, we may have two memory allocation for a
> BO. One is the shmem allcation in guest and the other is in host's vram.
> If we will only release the guest's memory on purge, then the vram will
> remain allocated until BO is destroyed, which unnecessarily sub-optimal.

Hm but why don't you just nuke the memory on the host side too when you
evict? Allowing the guest memory to be swapped out while keeping the host
memory allocation alive also doesn't make a lot of sense for me. Both can
be recreated (I guess at least?) on swap-in.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
