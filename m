Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF73D521C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbiEJOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiEJOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:21:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A6250EA2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:47:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 03A6A1F43CEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652190476;
        bh=l5Lrq4cHZl4mOcc2stCOelqQQNk6Lfb+xA1W39NUa4Q=;
        h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
        b=H9Be4qKuRhictzXKD1LnPV6fJT9u8fZwg9ZK4k4zm0WLRTOwziqkkCS4M/2mD1RB9
         ntdJ9dm49lhBDGusChUwwO47REIMXxNX1HKr9hsQ3BNTUqZNzNHwVUHlQOYmxkmmpd
         OUctkj/4K9HvC6K3S8fLBFKUCUdrNqRhy7DxxwOBdm1GYnTsb+gkBhLJFHCgthSQvi
         edblz55gRtQ9HmY4MQfXmlRmmphoDi5NvTKPvXytFbDyJK831UBmTmGULIOmRdLzOJ
         d7WRSxdnrFDzE5P4sBq1tEDsyAGh8bulmSi8jla/DCjjA/rMJ4QhsmAHrxhVh5wJiC
         rV73Qm4RabMVw==
Message-ID: <5fdf5232-e2b2-b444-5a41-f1db7e6a04da@collabora.com>
Date:   Tue, 10 May 2022 16:47:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-12-dmitry.osipenko@collabora.com>
 <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
 <ff97790a-fb64-1e15-74b4-59c807bce0b9@collabora.com>
 <Ynkb1U2nNWYPML88@phenom.ffwll.local>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
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
In-Reply-To: <Ynkb1U2nNWYPML88@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 16:49, Daniel Vetter wrote:
> On Fri, May 06, 2022 at 03:10:43AM +0300, Dmitry Osipenko wrote:
>> On 5/5/22 11:34, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
>>>> Introduce a common DRM SHMEM shrinker. It allows to reduce code
>>>> duplication among DRM drivers that implement theirs own shrinkers.
>>>> This is initial version of the shrinker that covers basic needs of
>>>> GPU drivers, both purging and eviction of shmem objects are supported.
>>>>
>>>> This patch is based on a couple ideas borrowed from Rob's Clark MSM
>>>> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
>>>>
>>>> In order to start using DRM SHMEM shrinker drivers should:
>>>>
>>>> 1. Implement new purge(), evict() + swap_in() GEM callbacks.
>>>> 2. Register shrinker using drm_gem_shmem_shrinker_register(drm_device).
>>>> 3. Use drm_gem_shmem_set_purgeable_and_evictable(shmem) and alike API
>>>>     functions to activate shrinking of GEMs.
>>>
>>> Honestly speaking, after reading the patch and the discussion here I
>>> really don't like where all tis is going. The interfaces and
>>> implementation are overengineered.  Descisions about evicting and
>>> purging should be done by the memory manager. For the most part, it's
>>> none of the driver's business.
>>
>> Daniel mostly suggesting to make interface more flexible for future
>> drivers, so we won't need to re-do it later on. My version of the
>> interface is based on what drivers need today.
>>
>> Why do you think it's a problem to turn shmem helper into the simple
>> generic memory manager? I don't see how it's better to have drivers
>> duplicating the exactly same efforts and making different mistakes.
>>
>> The shmem shrinker implementation is mostly based on the freedreno's
>> shrinker and it's very easy to enable generic shrinker for VirtIO and
>> Panfrost drivers. I think in the future freedreno and other drivers
>> could switch to use drm shmem instead of open coding the memory management.
> 
> Yeah I think we have enough shrinkers all over drm to actually design
> something solid here.
> 
> There's also the i915 shrinker and some kinda shrinker in ttm too. So we
> are definitely past the "have 3 examples to make sure you design something
> solid" rule of thumb.
> 
> I also have a bit an idea that we could try to glue the shmem shrinker
> into ttm, at least at a very high level that's something that would make
> some sense.

Before gluing the shmem shrinker into ttm, the drivers should be
switched to ttm? Or do you mean something else by the gluing?

Perhaps it should be possible to have a common drm-shrinker helper that
will do the basic-common things like tracking the eviction size and
check whether BO is exported or locked, but we shouldn't consider doing
this for now. For the starter more reasonable should be to create a
common shrinker base for drivers that use drm-shmem, IMO.

>>> I'd like to ask you to reduce the scope of the patchset and build the
>>> shrinker only for virtio-gpu. I know that I first suggested to build
>>> upon shmem helpers, but it seems that it's easier to do that in a later
>>> patchset.
>>
>> The first version of the VirtIO shrinker didn't support memory eviction.
>> Memory eviction support requires page fault handler to be aware of the
>> evicted pages, what should we do about it? The page fault handling is a
>> part of memory management, hence to me drm-shmem is already kinda a MM.
> 
> Hm I still don't get that part, why does that also not go through the
> shmem helpers?

The drm_gem_shmem_vm_ops includes the page faults handling, it's a
helper by itself that is used by DRM drivers.

I could try to move all the shrinker logic to the VirtIO and re-invent
virtio_gem_shmem_vm_ops, but what is the point of doing this for each
driver if we could have it once and for all in the common drm-shmem code?

Maybe I should try to factor out all the shrinker logic from drm-shmem
into a new drm-shmem-shrinker that could be shared by drivers? Will you
be okay with this option?

> I'm still confused why drivers need to know the difference
> between evition and purging. Or maybe I'm confused again.

Example:

If userspace uses IOV addresses, then these addresses must be kept
reserved while buffer is evicted.

If BO is purged, then we don't need to retain the IOV space allocated
for the purged BO.

The drm-shmem only handles shmem pages, not the mappings of these pages.

-- 
Best regards,
Dmitry
