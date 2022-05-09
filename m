Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678051FECE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiEINxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiEINxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:53:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D1E15EE45
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:49:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so16372494edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pZA6yQRMN3Sqlm7PUtuAQxJKWhf1hQnaR/qZnuNhEi0=;
        b=RIPC3IRUZJgrvWiGdCKAmuBHUkZ0OBMzV6EDRcUlvXefj9BivRsw0ne+BTTqCHs9R2
         hwuUNmhb/NmvvoaxSwL1J/yqORK7t3Oqo4/Eyq2sx1Lw8D/KenocRGn5CWjgdy8wNq0x
         MjbCyvfJwjFJHBiPqltgSbkK5uR5Kcv2MiiCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=pZA6yQRMN3Sqlm7PUtuAQxJKWhf1hQnaR/qZnuNhEi0=;
        b=kxoz3Ny7D8zrFWBxfFYHHKjWflUtV5Rf/OpaDRRp/0x3/Enph71E7rKB0aPOMhC2Fd
         hVcDKdBrXx29h2GTbKKjqBrf7FDM1mYWIAnAqmLMcHrTyTi1TMAQYTU9mx7+MBDVOH5z
         LphR3arRliiIxrl8Nt5ovhtUlMWFexlLB68j7e4IdSOk3C0v0dENCm0gh0+SZ+DA24wg
         HG32kYf9SWWthGyLqoidQ5Qiew3vOv4jSZdU/qIoIqb8nZ6G1tkjYkmp7x9A1DFwAqTY
         os2FgJ6y2oOXujOkQ2a80KveZHDbOYadzsYc+jM62J6rqwUyfhMGa5pxtb3jzxO7MO11
         gTSQ==
X-Gm-Message-State: AOAM531zv8Nav08msR9r55Ajqg7yROs/kXBIXBE4KCENhFeZmIOcjGsv
        VhIOMds5MkA8lRB0TcNys8wE1Q==
X-Google-Smtp-Source: ABdhPJwN2FC/6D0Xgv+EcIAfaOL8WLCDlbLxuaFd6okSeiN7pvVZhHJiCjFLOMMadOc4aiUcFRPQBQ==
X-Received: by 2002:aa7:c403:0:b0:428:8741:63a2 with SMTP id j3-20020aa7c403000000b00428874163a2mr9798080edq.219.1652104151800;
        Mon, 09 May 2022 06:49:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090651cc00b006f3ef214e41sm3146579ejk.167.2022.05.09.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 06:49:11 -0700 (PDT)
Date:   Mon, 9 May 2022 15:49:09 +0200
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
Message-ID: <Ynkb1U2nNWYPML88@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff97790a-fb64-1e15-74b4-59c807bce0b9@collabora.com>
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

On Fri, May 06, 2022 at 03:10:43AM +0300, Dmitry Osipenko wrote:
> On 5/5/22 11:34, Thomas Zimmermann wrote:
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
> > 
> > Honestly speaking, after reading the patch and the discussion here I
> > really don't like where all tis is going. The interfaces and
> > implementation are overengineered.  Descisions about evicting and
> > purging should be done by the memory manager. For the most part, it's
> > none of the driver's business.
> 
> Daniel mostly suggesting to make interface more flexible for future
> drivers, so we won't need to re-do it later on. My version of the
> interface is based on what drivers need today.
> 
> Why do you think it's a problem to turn shmem helper into the simple
> generic memory manager? I don't see how it's better to have drivers
> duplicating the exactly same efforts and making different mistakes.
> 
> The shmem shrinker implementation is mostly based on the freedreno's
> shrinker and it's very easy to enable generic shrinker for VirtIO and
> Panfrost drivers. I think in the future freedreno and other drivers
> could switch to use drm shmem instead of open coding the memory management.

Yeah I think we have enough shrinkers all over drm to actually design
something solid here.

There's also the i915 shrinker and some kinda shrinker in ttm too. So we
are definitely past the "have 3 examples to make sure you design something
solid" rule of thumb.

I also have a bit an idea that we could try to glue the shmem shrinker
into ttm, at least at a very high level that's something that would make
some sense.
 
> > I'd like to ask you to reduce the scope of the patchset and build the
> > shrinker only for virtio-gpu. I know that I first suggested to build
> > upon shmem helpers, but it seems that it's easier to do that in a later
> > patchset.
> 
> The first version of the VirtIO shrinker didn't support memory eviction.
> Memory eviction support requires page fault handler to be aware of the
> evicted pages, what should we do about it? The page fault handling is a
> part of memory management, hence to me drm-shmem is already kinda a MM.

Hm I still don't get that part, why does that also not go through the
shmem helpers? I'm still confused why drivers need to know the difference
between evition and purging. Or maybe I'm confused again.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
