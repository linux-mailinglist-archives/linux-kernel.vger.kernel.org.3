Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783455EA42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiF1Qu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbiF1Qtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:49:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5F237CC;
        Tue, 28 Jun 2022 09:47:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q9so18554206wrd.8;
        Tue, 28 Jun 2022 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3HZDcdfLwNiQ/tf7zCGAV+A8ooVMIqgPIQ28MjTeog=;
        b=e3zeLjiXoUYC1IVaQKWrsc2qKrKVYQG+FiwqsRzNz/YxbDT0nHSgZ8eR2tVfrLi0Hs
         5GLXKpxS/5dpbABkwwBi+kl4n0khKod1v0GPWJ89X1h3TNUjfC7RS4740ITfxK5/nbrh
         SHkGrTqHNILhXqHROw320nvIeM2Nre2164Aj2miAgQcaKDnte8RFr2pkEHfcg3h7Vbln
         87QzWotvsNkfT2Db3zhU9670nwzLrALbqwb/9ZXx2DFpvoAA8Xva7TAYCeAEhYv0BfZt
         Gn6YjailqEcJJ+mqGAUnmO0/+pJ+0fHuqqBi12yhe5oQnxR7ZUa+HprAzGiPrKPmAQgn
         fCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3HZDcdfLwNiQ/tf7zCGAV+A8ooVMIqgPIQ28MjTeog=;
        b=bvqv6H4UXkBG0ohPNWLl+sDnnFgqSW/Zgm2n6Vok9vlBA7elpiKyHgNQanm9WJaPdT
         fcCpN+FOoxBApgJCiXwIVrhyOy/UTvfstXHkc2gL5gxKegiUzRQqI+4QsWJp1KCUK7nj
         x6w8howNQW7n5QHU8+W/Mehwd29Y8zYb0TjhJkKpH8UI1AoqUI90ZD4fHACiQLAelqsz
         b9j3Dvu2/oTUvnNhvqe3PHmvvNuZHoYUv6Oc0u/vSMXHVLaZc1eTgrcWpH22x5ZEvk3i
         OAaiXTR8mwIxJG3dQGO70Y2HSLA2AElxb7b6EwMxLOjbTMhoWlta4CPib6vkz1cAymFN
         ORDw==
X-Gm-Message-State: AJIora/mdY2TxcSWGf/QFntd4VdLghBcpDHeymTzub8EloMoZtlYdxHS
        buUNrovENftHdUiY2HFJhmPU5XwgmFtzkBxo5QI=
X-Google-Smtp-Source: AGRyM1shfbz2wZj9C+y4AJcD4Xp16+D3E3FTqL5mLWkwiHI8GjKt117H2EdLaDQl5pCDFAKa86OSOaxFM0gmoOv0egA=
X-Received: by 2002:a5d:6d8b:0:b0:21b:9814:793d with SMTP id
 l11-20020a5d6d8b000000b0021b9814793dmr18409107wrs.344.1656434876256; Tue, 28
 Jun 2022 09:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <49cc6f0c-e90e-8edd-52e7-4188620e2c28@arm.com> <f77c1c2d-d9f9-db00-906a-ec10b535621d@collabora.com>
In-Reply-To: <f77c1c2d-d9f9-db00-906a-ec10b535621d@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Jun 2022 09:48:09 -0700
Message-ID: <CAF6AEGsQBcHbU6Ps5fp5v6ANaZwMAtig-3i-ekQzwG=7BBDNwA@mail.gmail.com>
Subject: Re: [PATCH v6 00/22] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Qiang Yu <yuq825@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel@collabora.com
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

On Tue, Jun 28, 2022 at 5:51 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 6/28/22 15:31, Robin Murphy wrote:
> > ----->8-----
> > [   68.295951] ======================================================
> > [   68.295956] WARNING: possible circular locking dependency detected
> > [   68.295963] 5.19.0-rc3+ #400 Not tainted
> > [   68.295972] ------------------------------------------------------
> > [   68.295977] cc1/295 is trying to acquire lock:
> > [   68.295986] ffff000008d7f1a0
> > (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_shmem_free+0x7c/0x198
> > [   68.296036]
> > [   68.296036] but task is already holding lock:
> > [   68.296041] ffff80000c14b820 (fs_reclaim){+.+.}-{0:0}, at:
> > __alloc_pages_slowpath.constprop.0+0x4d8/0x1470
> > [   68.296080]
> > [   68.296080] which lock already depends on the new lock.
> > [   68.296080]
> > [   68.296085]
> > [   68.296085] the existing dependency chain (in reverse order) is:
> > [   68.296090]
> > [   68.296090] -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [   68.296111]        fs_reclaim_acquire+0xb8/0x150
> > [   68.296130]        dma_resv_lockdep+0x298/0x3fc
> > [   68.296148]        do_one_initcall+0xe4/0x5f8
> > [   68.296163]        kernel_init_freeable+0x414/0x49c
> > [   68.296180]        kernel_init+0x2c/0x148
> > [   68.296195]        ret_from_fork+0x10/0x20
> > [   68.296207]
> > [   68.296207] -> #0 (reservation_ww_class_mutex){+.+.}-{3:3}:
> > [   68.296229]        __lock_acquire+0x1724/0x2398
> > [   68.296246]        lock_acquire+0x218/0x5b0
> > [   68.296260]        __ww_mutex_lock.constprop.0+0x158/0x2378
> > [   68.296277]        ww_mutex_lock+0x7c/0x4d8
> > [   68.296291]        drm_gem_shmem_free+0x7c/0x198
> > [   68.296304]        panfrost_gem_free_object+0x118/0x138
> > [   68.296318]        drm_gem_object_free+0x40/0x68
> > [   68.296334]        drm_gem_shmem_shrinker_run_objects_scan+0x42c/0x5b8
> > [   68.296352]        drm_gem_shmem_shrinker_scan_objects+0xa4/0x170
> > [   68.296368]        do_shrink_slab+0x220/0x808
> > [   68.296381]        shrink_slab+0x11c/0x408
> > [   68.296392]        shrink_node+0x6ac/0xb90
> > [   68.296403]        do_try_to_free_pages+0x1dc/0x8d0
> > [   68.296416]        try_to_free_pages+0x1ec/0x5b0
> > [   68.296429]        __alloc_pages_slowpath.constprop.0+0x528/0x1470
> > [   68.296444]        __alloc_pages+0x4e0/0x5b8
> > [   68.296455]        __folio_alloc+0x24/0x60
> > [   68.296467]        vma_alloc_folio+0xb8/0x2f8
> > [   68.296483]        alloc_zeroed_user_highpage_movable+0x58/0x68
> > [   68.296498]        __handle_mm_fault+0x918/0x12a8
> > [   68.296513]        handle_mm_fault+0x130/0x300
> > [   68.296527]        do_page_fault+0x1d0/0x568
> > [   68.296539]        do_translation_fault+0xa0/0xb8
> > [   68.296551]        do_mem_abort+0x68/0xf8
> > [   68.296562]        el0_da+0x74/0x100
> > [   68.296572]        el0t_64_sync_handler+0x68/0xc0
> > [   68.296585]        el0t_64_sync+0x18c/0x190
> > [   68.296596]
> > [   68.296596] other info that might help us debug this:
> > [   68.296596]
> > [   68.296601]  Possible unsafe locking scenario:
> > [   68.296601]
> > [   68.296604]        CPU0                    CPU1
> > [   68.296608]        ----                    ----
> > [   68.296612]   lock(fs_reclaim);
> > [   68.296622] lock(reservation_ww_class_mutex);
> > [   68.296633]                                lock(fs_reclaim);
> > [   68.296644]   lock(reservation_ww_class_mutex);
> > [   68.296654]
> > [   68.296654]  *** DEADLOCK ***
>
> This splat could be ignored for now. I'm aware about it, although
> haven't looked closely at how to fix it since it's a kind of a lockdep
> misreporting.

The lockdep splat could be fixed with something similar to what I've
done in msm, ie. basically just not acquire the lock in the finalizer:

https://patchwork.freedesktop.org/patch/489364/

There is one gotcha to watch for, as danvet pointed out
(scan_objects() could still see the obj in the LRU before the
finalizer removes it), but if scan_objects() does the
kref_get_unless_zero() trick, it is safe.

BR,
-R
