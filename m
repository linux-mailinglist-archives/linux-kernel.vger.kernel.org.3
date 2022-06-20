Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF005520A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbiFTPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiFTPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:22:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F3635B;
        Mon, 20 Jun 2022 08:18:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so15133269wrd.8;
        Mon, 20 Jun 2022 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLrdK2cHg8a+WfynFvGYZTk9JjHbb/Ti/PUAmWDEXmQ=;
        b=qK7K5LcM7dyr13i14ftD313nslG8YxjHQmfv8LjV7Tk1r8ybUhZ5AI0jn5rTqQhgmm
         i59iso5WlVRzUdhMyAPWt7eltJkNSfRGyu0jYjEV010WarFWgUS3zKaSaYaJfYgDz//T
         pid5V6gslaCrjWsjULnAXS530hiyltR47EnpCo8fvT4ma6uRB5F+KGSfmkgW+IZhEhRU
         OHPH8eR5Bncckxj2xyb0u6lbCoknZypydnAtyGNuGpMe8xIqnmVyJNbKWPMhsWl15p7Z
         MAziNE52C7w3j7WtmrVuXvwuEgzAYrB48BIKNyK7u2dralOWnRbA4it6ts7mRM3p0T0z
         PUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLrdK2cHg8a+WfynFvGYZTk9JjHbb/Ti/PUAmWDEXmQ=;
        b=uHSUtpnpJZlS/Io/BZSsWi+9vi95Lr7t1T8WwRuEjtDAz9Waq8Az/9BaKMp4Gjd9Ei
         7u1GVaGcml0XhTv5Xx+UdrwCp4UcvPu6G4aG6lwglN1zAWVyBaDYGmKo8mC/dtUhgeTs
         FRhXxWtNN0UmU5ICaVsCkpn/wh1g57vwpsdEILBuOviaGP/AwYizCIybCkRvSlOyBJee
         WwiEe9DUjclD956mSwt1bvqqHFrtPL+PPaLZqktJUkA/Kg5aMappsvTmaokcsjB02q10
         IgpZBGrb8sIaOOQsJlzQMz8jqcymk4m9yRf3GpNy+SH8TjtyooR2D0Ckiz6Ed4UXksRQ
         cnig==
X-Gm-Message-State: AJIora+ml+vXvRGeu1Nn7fb9+Y0azSIbZMqicjoEsngSl9kwMWmMQvEb
        9J89bG4GskYlrVz+ACgkbmmIQXo+myKalFwod2c=
X-Google-Smtp-Source: AGRyM1uYeX1HSZm/HHpeWSpFPQwaEg25u16yH1bR8gO/m6+hhlHkAUqlKQD3fntq2L6SbV4iQSzZCmeHt3/fGRnXHoE=
X-Received: by 2002:adf:eb45:0:b0:21a:efae:4b9f with SMTP id
 u5-20020adfeb45000000b0021aefae4b9fmr17379320wrn.585.1655738278721; Mon, 20
 Jun 2022 08:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com> <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
 <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
In-Reply-To: <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Jun 2022 08:18:04 -0700
Message-ID: <CAF6AEGus7R_i7RMWGmbawVi62xCk5mhLTWGq2QEkcWY+XaJBAQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
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
        Robin Murphy <robin.murphy@arm.com>,
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kernel@collabora.com
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

On Mon, Jun 20, 2022 at 7:09 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 6/19/22 20:53, Rob Clark wrote:
> ...
> >> +static unsigned long
> >> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
> >> +                                    struct shrink_control *sc)
> >> +{
> >> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
> >> +       struct drm_gem_shmem_object *shmem;
> >> +       unsigned long count = 0;
> >> +
> >> +       if (!mutex_trylock(&gem_shrinker->lock))
> >> +               return 0;
> >> +
> >> +       list_for_each_entry(shmem, &gem_shrinker->lru_evictable, madv_list) {
> >> +               count += shmem->base.size;
> >> +
> >> +               if (count >= SHRINK_EMPTY)
> >> +                       break;
> >> +       }
> >> +
> >> +       mutex_unlock(&gem_shrinker->lock);
> >
> > As I mentioned on other thread, count_objects, being approximate but
> > lockless and fast is the important thing.  Otherwise when you start
> > hitting the shrinker on many threads, you end up serializing them all,
> > even if you have no pages to return to the system at that point.
>
> Daniel's point for dropping the lockless variant was that we're already
> in trouble if we're hitting shrinker too often and extra optimizations
> won't bring much benefits to us.

At least with zram swap (which I highly recommend using even if you
are not using a physical swap file/partition), swapin/out is actually
quite fast.  And if you are leaning on zram swap to fit 8GB of chrome
browser on a 4GB device, the shrinker gets hit quite a lot.  Lower
spec (4GB RAM) chromebooks can be under constant memory pressure and
can quite easily get into a situation where you are hitting the
shrinker on many threads simultaneously.  So it is pretty important
for all shrinkers in the system (not just drm driver) to be as
concurrent as possible.  As long as you avoid serializing reclaim on
all the threads, performance can still be quite good, but if you don't
performance will fall off a cliff.

jfwiw, we are seeing pretty good results (iirc 40-70% increase in open
tab counts) with the combination of eviction + multigen LRU[1] +
sizing zram swap to be 2x physical RAM

[1] https://lwn.net/Articles/856931/

> Alright, I'll add back the lockless variant (or will use yours
> drm_gem_lru) in the next revision. The code difference is very small
> after all.
>
> ...
> >> +               /* prevent racing with the dma-buf importing/exporting */
> >> +               if (!mutex_trylock(&gem_shrinker->dev->object_name_lock)) {
> >> +                       *lock_contention |= true;
> >> +                       goto resv_unlock;
> >> +               }
> >
> > I'm not sure this is a good idea to serialize on object_name_lock.
> > Purgeable buffers should never be shared (imported or exported).  So
> > at best you are avoiding evicting and immediately swapping back in, in
> > a rare case, at the cost of serializing multiple threads trying to
> > reclaim pages in parallel.
>
> The object_name_lock shouldn't cause contention in practice. But objects
> are also pinned on attachment, hence maybe this lock is indeed
> unnecessary.. I'll re-check it.

I'm not worried about contention with export/import/etc, but
contention between multiple threads hitting the shrinker in parallel.
I guess since you are using trylock, it won't *block* the other
threads hitting shrinker, but they'll just end up looping in
do_shrink_slab() because they are hitting contention.

I'd have to do some experiments to see how it works out in practice,
but my gut feel is that it isn't a good idea

BR,
-R

> --
> Best regards,
> Dmitry
