Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCD505E56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347616AbiDRTVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiDRTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:21:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1535249
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:19:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id B74B31F41A11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650309539;
        bh=DXTjFJyNxSnZP5FQNeR7bC9ax46RsLCVkvpOvafrTvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KnzK+b+LOu7t6pWuGFQqM8/EObJ8aHas6adce9N9mYR0CprHRljlJX/7Lkti6Jt1v
         /Cnm+z4+hgv/D+vM5fSmAJ6iM8Vh7272dpA+yP6XZyWOJIaMn3a96/1/IOXCW3+9oG
         S0b/staCNv/fpDFqTX9zZsTP9eWeSLuM78170x9fl5wI/0iZoWAvzD2zzKcLmIj44n
         TGpO7ABTXnUO+GV+CgrV23IP8G+tGRaZcL6uh9mX9Ahp24GqBLsrpLnYHuWr9hjagF
         Jo+SwCHjolDXqzj92B3iUUYyFnf6A6lhbujtaQV7V0xNro5YxQhgsu/ZXJc/H0J5bx
         G1l4hXXTZaloA==
Message-ID: <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
Date:   Mon, 18 Apr 2022 22:18:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
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
        Robin Murphy <robin.murphy@arm.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-11-dmitry.osipenko@collabora.com>
 <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 4/18/22 21:38, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
>> Replace drm_gem_shmem locks with the reservation lock to make GEM
>> lockings more consistent.
>>
>> Previously drm_gem_shmem_vmap() and drm_gem_shmem_get_pages() were
>> protected by separate locks, now it's the same lock, but it doesn't
>> make any difference for the current GEM SHMEM users. Only Panfrost
>> and Lima drivers use vmap() and they do it in the slow code paths,
>> hence there was no practical justification for the usage of separate
>> lock in the vmap().
>>
>> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
...
>>   @@ -310,7 +306,7 @@ static int drm_gem_shmem_vmap_locked(struct
>> drm_gem_shmem_object *shmem,
>>       } else {
>>           pgprot_t prot = PAGE_KERNEL;
>>   -        ret = drm_gem_shmem_get_pages(shmem);
>> +        ret = drm_gem_shmem_get_pages_locked(shmem);
>>           if (ret)
>>               goto err_zero_use;
>>   @@ -360,11 +356,11 @@ int drm_gem_shmem_vmap(struct
>> drm_gem_shmem_object *shmem,
>>   {
>>       int ret;
>>   -    ret = mutex_lock_interruptible(&shmem->vmap_lock);
>> +    ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
>>       if (ret)
>>           return ret;
>>       ret = drm_gem_shmem_vmap_locked(shmem, map);
> 
> Within drm_gem_shmem_vmap_locked(), there's a call to dma_buf_vmap() for
> imported pages. If the exporter side also holds/acquires the same
> reservation lock as our object, the whole thing can deadlock. We cannot
> move dma_buf_vmap() out of the CS, because we still need to increment
> the reference counter. I honestly don't know how to easily fix this
> problem. There's a TODO item about replacing these locks at [1]. As
> Daniel suggested this patch, we should talk to him about the issue.
> 
> Best regards
> Thomas
> 
> [1]
> https://www.kernel.org/doc/html/latest/gpu/todo.html#move-buffer-object-locking-to-dma-resv-lock

Indeed, good catch! Perhaps we could simply use a separate lock for the
vmapping of the *imported* GEMs? The vmap_use_count is used only by
vmap/vunmap, so it doesn't matter which lock is used by these functions
in the case of imported GEMs since we only need to protect the
vmap_use_count.
