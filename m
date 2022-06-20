Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C73551F58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiFTOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbiFTOuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:50:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A63C731;
        Mon, 20 Jun 2022 07:09:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED33766016AA;
        Mon, 20 Jun 2022 15:08:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655734140;
        bh=BXU+ifI6vgvX2l7WRjph+CNUKyZnpbVEdIZ7RrhtSq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hbKEas/qwTrQOtYjHwF1kAp5bF+lx0c/HWQwXzlCDzigXVc6ThGjLuF3ZUDyYkTwz
         MouYrGpQnILP4PpIymmbBhVM9e1PASUWBFi+LgRwQKHtJaeCJSG55KGkiaLdAooRwx
         r2TI5GDTa0dTQ+8tpeAHv2LUf+jVTzvilnkf5MIXXOtgLhZavAyBeA5Coc+G+31H0n
         LqN5s7FdaPeYgtK9DeQIbTvs9nVBH3Vd5hMCs7Z3/RWoHnCkbvzEtAtefHevXEAM22
         OU+8g1IHrfEqrNowXyflyg+A+jrXLHwPj7JmxC/fo9Iq5iwKq0KsVJdcRE82IB0+gX
         J8VaycDtZEnTQ==
Message-ID: <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
Date:   Mon, 20 Jun 2022 17:08:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com>
 <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 20:53, Rob Clark wrote:
...
>> +static unsigned long
>> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
>> +                                    struct shrink_control *sc)
>> +{
>> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
>> +       struct drm_gem_shmem_object *shmem;
>> +       unsigned long count = 0;
>> +
>> +       if (!mutex_trylock(&gem_shrinker->lock))
>> +               return 0;
>> +
>> +       list_for_each_entry(shmem, &gem_shrinker->lru_evictable, madv_list) {
>> +               count += shmem->base.size;
>> +
>> +               if (count >= SHRINK_EMPTY)
>> +                       break;
>> +       }
>> +
>> +       mutex_unlock(&gem_shrinker->lock);
> 
> As I mentioned on other thread, count_objects, being approximate but
> lockless and fast is the important thing.  Otherwise when you start
> hitting the shrinker on many threads, you end up serializing them all,
> even if you have no pages to return to the system at that point.

Daniel's point for dropping the lockless variant was that we're already
in trouble if we're hitting shrinker too often and extra optimizations
won't bring much benefits to us.

Alright, I'll add back the lockless variant (or will use yours
drm_gem_lru) in the next revision. The code difference is very small
after all.

...
>> +               /* prevent racing with the dma-buf importing/exporting */
>> +               if (!mutex_trylock(&gem_shrinker->dev->object_name_lock)) {
>> +                       *lock_contention |= true;
>> +                       goto resv_unlock;
>> +               }
> 
> I'm not sure this is a good idea to serialize on object_name_lock.
> Purgeable buffers should never be shared (imported or exported).  So
> at best you are avoiding evicting and immediately swapping back in, in
> a rare case, at the cost of serializing multiple threads trying to
> reclaim pages in parallel.

The object_name_lock shouldn't cause contention in practice. But objects
are also pinned on attachment, hence maybe this lock is indeed
unnecessary.. I'll re-check it.

-- 
Best regards,
Dmitry
