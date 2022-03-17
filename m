Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2184DBB88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiCQAOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCQAOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:14:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED179FE3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:13:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 8A4AF1F44B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647476012;
        bh=qqb77EVC3B9JYyS1YKV7QIqu1+OqFjfwTijVUTotVoc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I3Fk24cBg52mAc1VzRMFsOvIzJfXd1RYbdfxuozKWvCb0cAZuu2HRNIp6ilUC0RiW
         UDN5I7CzwmsnAcCuCfrNvHVvJExU81SVHT8xXcDEGI2LV9QyDeKEXNFLnkNVkIH2KD
         YWoYPMENCId3ituT8GFVwGAqai9xHYuejzOQpsroaN5fAyRR8ufZfp3snIDmvCleBd
         DNPHmLpawjgTQn6MM5r+UPymmeDYiLjZazqBv/P0ZpVCIHqcrBYTuG94TaygsWl5QN
         5M3BaoDFgqrPRQXLkOfRxwX0gUlsiAfDjdDiKX/0WfFKVYKiHNk5twDreM6fHrfMG4
         ypkFf9rRNqi+Q==
Message-ID: <be3b09ff-08ea-3e13-7d8c-06af6fffbd8f@collabora.com>
Date:   Thu, 17 Mar 2022 03:13:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 6/8] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-7-dmitry.osipenko@collabora.com>
 <CAF6AEGsmtM6rTJtOJwTA49cwW7wCjF53Devzodd_PzLO0EOkVw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGsmtM6rTJtOJwTA49cwW7wCjF53Devzodd_PzLO0EOkVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 23:00, Rob Clark wrote:
> On Mon, Mar 14, 2022 at 3:44 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Introduce a common DRM SHMEM shrinker. It allows to reduce code
>> duplication among DRM drivers, it also handles complicated lockings
>> for the drivers. This is initial version of the shrinker that covers
>> basic needs of GPU drivers.
>>
>> This patch is based on a couple ideas borrowed from Rob's Clark MSM
>> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
>>
>> GPU drivers that want to use generic DRM memory shrinker must support
>> generic GEM reservations.
>>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 194 +++++++++++++++++++++++++
>>  include/drm/drm_device.h               |   4 +
>>  include/drm/drm_gem.h                  |  11 ++
>>  include/drm/drm_gem_shmem_helper.h     |  25 ++++
>>  4 files changed, 234 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 37009418cd28..35be2ee98f11 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -139,6 +139,9 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>  {
>>         struct drm_gem_object *obj = &shmem->base;
>>
>> +       /* take out shmem GEM object from the memory shrinker */
>> +       drm_gem_shmem_madvise(shmem, 0);
>> +
>>         WARN_ON(shmem->vmap_use_count);
>>
>>         if (obj->import_attach) {
>> @@ -163,6 +166,42 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>  }
>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
>>
>> +static void drm_gem_shmem_update_purgeable_status(struct drm_gem_shmem_object *shmem)
>> +{
>> +       struct drm_gem_object *obj = &shmem->base;
>> +       struct drm_gem_shmem_shrinker *gem_shrinker = obj->dev->shmem_shrinker;
>> +       size_t page_count = obj->size >> PAGE_SHIFT;
>> +
>> +       if (!gem_shrinker || obj->import_attach || !obj->funcs->purge)
>> +               return;
>> +
>> +       mutex_lock(&shmem->vmap_lock);
>> +       mutex_lock(&shmem->pages_lock);
>> +       mutex_lock(&gem_shrinker->lock);
>> +
>> +       if (shmem->madv < 0) {
>> +               list_del_init(&shmem->madv_list);
>> +               goto unlock;
>> +       } else if (shmem->madv > 0) {
>> +               if (!list_empty(&shmem->madv_list))
>> +                       goto unlock;
>> +
>> +               WARN_ON(gem_shrinker->shrinkable_count + page_count < page_count);
>> +               gem_shrinker->shrinkable_count += page_count;
>> +
>> +               list_add_tail(&shmem->madv_list, &gem_shrinker->lru);
>> +       } else if (!list_empty(&shmem->madv_list)) {
>> +               list_del_init(&shmem->madv_list);
>> +
>> +               WARN_ON(gem_shrinker->shrinkable_count < page_count);
>> +               gem_shrinker->shrinkable_count -= page_count;
>> +       }
>> +unlock:
>> +       mutex_unlock(&gem_shrinker->lock);
>> +       mutex_unlock(&shmem->pages_lock);
>> +       mutex_unlock(&shmem->vmap_lock);
>> +}
>> +
>>  static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>>  {
>>         struct drm_gem_object *obj = &shmem->base;
>> @@ -366,6 +405,8 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
>>         ret = drm_gem_shmem_vmap_locked(shmem, map);
>>         mutex_unlock(&shmem->vmap_lock);
>>
>> +       drm_gem_shmem_update_purgeable_status(shmem);
>> +
>>         return ret;
>>  }
>>  EXPORT_SYMBOL(drm_gem_shmem_vmap);
>> @@ -409,6 +450,8 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
>>         mutex_lock(&shmem->vmap_lock);
>>         drm_gem_shmem_vunmap_locked(shmem, map);
>>         mutex_unlock(&shmem->vmap_lock);
>> +
>> +       drm_gem_shmem_update_purgeable_status(shmem);
>>  }
>>  EXPORT_SYMBOL(drm_gem_shmem_vunmap);
>>
>> @@ -451,6 +494,8 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
>>
>>         mutex_unlock(&shmem->pages_lock);
>>
>> +       drm_gem_shmem_update_purgeable_status(shmem);
>> +
>>         return (madv >= 0);
>>  }
>>  EXPORT_SYMBOL(drm_gem_shmem_madvise);
>> @@ -763,6 +808,155 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
>>
>> +static struct drm_gem_shmem_shrinker *
>> +to_drm_shrinker(struct shrinker *shrinker)
>> +{
>> +       return container_of(shrinker, struct drm_gem_shmem_shrinker, base);
>> +}
>> +
>> +static unsigned long
>> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
>> +                                    struct shrink_control *sc)
>> +{
>> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
>> +       u64 count = gem_shrinker->shrinkable_count;
>> +
>> +       if (count >= SHRINK_EMPTY)
>> +               return SHRINK_EMPTY - 1;
>> +
>> +       return count ?: SHRINK_EMPTY;
>> +}
>> +
>> +static unsigned long
>> +drm_gem_shmem_shrinker_scan_objects(struct shrinker *shrinker,
>> +                                   struct shrink_control *sc)
>> +{
>> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
>> +       struct drm_gem_shmem_object *shmem;
>> +       struct list_head still_in_list;
>> +       bool lock_contention = true;
>> +       struct drm_gem_object *obj;
>> +       unsigned long freed = 0;
>> +
>> +       INIT_LIST_HEAD(&still_in_list);
>> +
>> +       mutex_lock(&gem_shrinker->lock);
>> +
>> +       while (freed < sc->nr_to_scan) {
>> +               shmem = list_first_entry_or_null(&gem_shrinker->lru,
>> +                                                typeof(*shmem), madv_list);
>> +               if (!shmem)
>> +                       break;
>> +
>> +               obj = &shmem->base;
>> +               list_move_tail(&shmem->madv_list, &still_in_list);
>> +
>> +               /*
>> +                * If it's in the process of being freed, gem_object->free()
>> +                * may be blocked on lock waiting to remove it.  So just
>> +                * skip it.
>> +                */
>> +               if (!kref_get_unless_zero(&obj->refcount))
>> +                       continue;
>> +
>> +               mutex_unlock(&gem_shrinker->lock);
>> +
>> +               /* prevent racing with job submission code paths */
>> +               if (!dma_resv_trylock(obj->resv))
>> +                       goto shrinker_lock;
> 
> jfwiw, the trylock here is in the msm code isn't so much for madvise
> (it is an error to submit jobs that reference DONTNEED objects), but
> instead for the case of evicting WILLNEED but inactive objects to
> swap.  Ie. in the case that we need to move bo's back in to memory, we
> don't want to unpin/evict a buffer that is later on the list for the
> same job.. msm shrinker re-uses the same scan loop for both
> inactive_dontneed (purge) and inactive_willneed (evict)

I don't see connection between the objects on the shrinker's list and
the job's BOs. Jobs indeed must not have any objects marked as DONTNEED,
this case should never happen in practice, but we still need to protect
from it.

> I suppose using trylock is not technically wrong, and it would be a
> good idea if the shmem helpers supported eviction as well.  But I
> think in the madvise/purge case if you lose the trylock then there is
> something else bad going on.

This trylock is intended for protecting job's submission path from
racing with madvise ioctl invocation followed by immediate purging of
BOs while job is in a process of submission, i.e. it protects from a
use-after-free.

If you'll lose this trylock, then shrinker can't use
dma_resv_test_signaled() reliably anymore and shrinker may purge BO
before job had a chance to add fence to the BO's reservation.

> Anyways, from the PoV of minimizing lock contention when under memory
> pressure, this all looks good to me.

Thank you. I may try to add generic eviction support to the v3.
