Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3372F51B9C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbiEEIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346700AbiEEIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:16:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1D47AD2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:12:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so7212913ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HGg12g7rqV6st3fX8w/ctnDqBvDsC80/xO++kQycD7o=;
        b=W6QD2uraJIvioMM9fyC+0Oiy7cWSHGHMC5pGskeQFPUekBSjtiKm3A70QIEWNq7Sh5
         VHhAw8hpfYagzTcrcMnO/hTb04SOcTe5+Mfj4gD6ifM0bAYMuh0fCSo7taWQKTU+4m31
         dnKZxrmpJh8nR6mgozp6BQibK09vKIbIrpwKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=HGg12g7rqV6st3fX8w/ctnDqBvDsC80/xO++kQycD7o=;
        b=zCgseNqgaxyfpm4/2Q+IuLJC7fyqSuauhqjwALnsscZDFLdz6TSPSW+IUBqfog1GW+
         rRYUdf6U0RMAgOtrHUxLuGOQVHdDYGuCMfhJguS2fHLPaRGujDWd8aQtcXxA8fIGBNi/
         WpUs08cYcG8O7gusUIJHZXJ2bYmkTsnGQDfT4Wg8DoFuTdhtOA9oPb5LY2v0Rpe9qGiI
         XfbODvAcyF3fEKzrsrzEntWHDR1D3PrSaTKJsBMCD0zpYsLS/TOZFbUxakEbfTb0KXOw
         yZTeWZh5QDmQBCWluyzCPkXB13l9F/Dm+47kSYMoEcdv+ZUsc4Lg3TqubZN4UDKUiK82
         Zjbw==
X-Gm-Message-State: AOAM5322o03lxz/zt2j8tOprBPgn9bbTGXqjh8Kl+kZS13HtA/q28Brj
        redAZSVH3HmCrFAEEPpZoYsvGQ==
X-Google-Smtp-Source: ABdhPJy/OlYDHV4abt2gnWtLXTtgDhEwCbc9MHayNWwoiurjDqvY2ogAsYMRzgyNYsm6uejfvxCNrQ==
X-Received: by 2002:a17:907:2cc6:b0:6f0:2de3:9446 with SMTP id hg6-20020a1709072cc600b006f02de39446mr24511672ejc.690.1651738373298;
        Thu, 05 May 2022 01:12:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm447457ejc.200.2022.05.05.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:12:52 -0700 (PDT)
Date:   Thu, 5 May 2022 10:12:50 +0200
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
Message-ID: <YnOHAh9I1ds4+1J+@phenom.ffwll.local>
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
 <YnI3lE0TxLfZaQjE@phenom.ffwll.local>
 <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
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

On Wed, May 04, 2022 at 06:56:09PM +0300, Dmitry Osipenko wrote:
> On 5/4/22 11:21, Daniel Vetter wrote:
> ...
> >>> - Maybe also do what you suggest and keep a separate lock for this, but
> >>>   the fundamental issue is that this doesn't really work - if you share
> >>>   buffers both ways with two drivers using shmem helpers, then the
> >>>   ordering of this vmap_count_mutex vs dma_resv_lock is inconsistent and
> >>>   you can get some nice deadlocks. So not a great approach (and also the
> >>>   reason why we really need to get everyone to move towards dma_resv_lock
> >>>   as _the_ buffer object lock, since otherwise we'll never get a
> >>>   consistent lock nesting hierarchy).
> >>
> >> The separate locks should work okay because it will be always the
> >> exporter that takes the dma_resv_lock. But I agree that it's less ideal
> >> than defining the new rules for dma-bufs since sometime you will take
> >> the resv lock and sometime not, potentially hiding bugs related to lockings.
> > 
> > That's the issue, some importers need to take the dma_resv_lock for
> > dma_buf_vmap too (e.g. to first nail the buffer in place when it's a
> > dynamic memory manager). In practice it'll work as well as what we have
> > currently, which is similarly inconsistent, except with per-driver locks
> > instead of shared locks from shmem helpers or dma-buf, so less obvious
> > that things are inconsistent.
> > 
> > So yeah if it's too messy maybe the approach is to have a separate lock
> > for vmap for now, land things, and then fix up dma_buf_vmap in a follow up
> > series.
> 
> The amdgpu driver was the fist who introduced the concept of movable
> memory for dma-bufs. Now we want to support it for DRM SHMEM too. For
> both amdgpu ttm and shmem drivers we will want to hold the reservation
> lock when we're touching moveable buffers. The current way of denoting
> that dma-buf is movable is to implement the pin/unpin callbacks of the
> dma-buf ops, should be doable for shmem.

Hm that sounds like a bridge too far? I don't think we want to start
adding moveable dma-bufs for shmem, thus far at least no one asked for
that. Goal here is just to streamline the locking a bit and align across
all the different ways of doing buffers in drm.

Or do you mean something else and I'm just completely lost?

> A day ago I found that mapping of imported dma-bufs is broken at least
> for the Tegra DRM driver (and likely for others too) because driver
> doesn't assume that anyone will try to mmap imported buffer and just
> doesn't handle this case at all, so we're getting a hard lockup on
> touching mapped memory because we're mapping something else than the
> dma-buf.

Huh that sounds bad, how does this happen? Pretty much all pieces of
dma-buf (cpu vmap, userspace mmap, heck even dma_buf_attach) are optional
or at least can fail for various reasons. So exporters not providing mmap
support is fine, but importers then dying is not.

> My plan is to move the dma-buf management code to the level of DRM core
> and make it aware of the reservation locks for the dynamic dma-bufs.
> This way we will get the proper locking for dma-bufs and fix mapping of
> imported dma-bufs for Tegra and other drivers.

So maybe we're completely talking past each another, or coffee is not
working here on my end, but I've no idea what you mean.

We do have some helpers for taking care of the dma_resv_lock dance, and
Christian König has an rfc patch set to maybe unify this further. But that
should be fairly orthogonal to reworking shmem (it might help a bit with
reworking shmem though).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
