Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF96524BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiELLgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiELLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:36:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195941A833
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:36:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id DAB5E1F40E90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652355379;
        bh=JX/qP5OyDoZwg5HDDFDhOJw5JmEbwfk9L6npEO67n1s=;
        h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
        b=KKvpbIpATpvbGJVEa2xfixeWHk6VzvQvOlSfKZmVEzYhTI5tUlxYpPGPJmSMH5xxh
         TV/KL+5sXqLpE8Kp6YYpKKbkjw5dJVEbf/oLQMKLhhaK7Vt9oEWsO4ZWRvTHR5eM9o
         04woUcn4FKag7J3pTHSBt4tHOY+D6pmUDEo2h6J3U4bcv+cK1sU7y6w6CoeiJquQRS
         oYlyj4VbDhwpiwY7YbRHluUoS2TbaZfniIW2XI2S8iZ+5Stg7/ohb3ak37MM6DoxiX
         SiWU2CkOINKFIRmlmVF0yu7uo8YFX9H1+dazOJcjSbAV66DnQpp3H7a2SdhVB69HZA
         aWNSzM3y0pw+A==
Message-ID: <0ae6fed7-b166-d2b8-0e42-84b94b777c20@collabora.com>
Date:   Thu, 12 May 2022 14:36:14 +0300
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
 <5fdf5232-e2b2-b444-5a41-f1db7e6a04da@collabora.com>
 <Ynu1k5lH+xvqtObG@phenom.ffwll.local>
 <3429a12f-9fbe-b66b-dbbd-94a1df54714e@collabora.com>
 <YnwJ0kLwLS7RxuwS@phenom.ffwll.local>
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
In-Reply-To: <YnwJ0kLwLS7RxuwS@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 22:09, Daniel Vetter wrote:
> On Wed, May 11, 2022 at 07:06:18PM +0300, Dmitry Osipenko wrote:
>> On 5/11/22 16:09, Daniel Vetter wrote:
>>>>>>> I'd like to ask you to reduce the scope of the patchset and build the
>>>>>>> shrinker only for virtio-gpu. I know that I first suggested to build
>>>>>>> upon shmem helpers, but it seems that it's easier to do that in a later
>>>>>>> patchset.
>>>>>> The first version of the VirtIO shrinker didn't support memory eviction.
>>>>>> Memory eviction support requires page fault handler to be aware of the
>>>>>> evicted pages, what should we do about it? The page fault handling is a
>>>>>> part of memory management, hence to me drm-shmem is already kinda a MM.
>>>>> Hm I still don't get that part, why does that also not go through the
>>>>> shmem helpers?
>>>> The drm_gem_shmem_vm_ops includes the page faults handling, it's a
>>>> helper by itself that is used by DRM drivers.
>>>>
>>>> I could try to move all the shrinker logic to the VirtIO and re-invent
>>>> virtio_gem_shmem_vm_ops, but what is the point of doing this for each
>>>> driver if we could have it once and for all in the common drm-shmem code?
>>>>
>>>> Maybe I should try to factor out all the shrinker logic from drm-shmem
>>>> into a new drm-shmem-shrinker that could be shared by drivers? Will you
>>>> be okay with this option?
>>> I think we're talking past each another a bit. I'm only bringing up the
>>> purge vs eviction topic we discussed in the other subthread again.
>>
>> Thomas asked to move the whole shrinker code to the VirtIO driver and
>> I's saying that this is not a great idea to me, or am I misunderstanding
>> the Thomas' suggestion? Thomas?
> 
> I think it was just me creating a confusion here.
> 
> fwiw I do also think that shrinker in shmem helpers makes sense, just in
> case that was also lost in confusion.

Okay, good that we're on the same page now.

>>>>> I'm still confused why drivers need to know the difference
>>>>> between evition and purging. Or maybe I'm confused again.
>>>> Example:
>>>>
>>>> If userspace uses IOV addresses, then these addresses must be kept
>>>> reserved while buffer is evicted.
>>>>
>>>> If BO is purged, then we don't need to retain the IOV space allocated
>>>> for the purged BO.
>>> Yeah but is that actually needed by anyone? If userspace fails to allocate
>>> another bo because of lack of gpu address space then it's very easy to
>>> handle that:
>>>
>>> 1. Make a rule that "out of gpu address space" gives you a special errno
>>> code like ENOSPC
>>>
>>> 2. If userspace gets that it walks the list of all buffers it marked as
>>> purgeable and nukes them (whether they have been evicted or not). Then it
>>> retries the bo allocation.
>>>
>>> Alternatively you can do step 2 also directly from the bo alloc ioctl in
>>> step 1. Either way you clean up va space, and actually a lot more (you
>>> potentially nuke all buffers marked as purgeable, not just the ones that
>>> have been purged already) and only when va cleanup is actually needed
>>>
>>> Trying to solve this problem at eviction time otoh means:
>>> - we have this difference between eviction and purging
>>> - it's still not complete, you still need to glue step 2 above into your
>>>   driver somehow, and once step 2 above is glued in doing additional
>>>   cleanup in the purge function is just duplicated logic
>>>
>>> So at least in my opinion this isn't the justification we need. And we
>>> should definitely not just add that complication "in case, for the
>>> future", if we don't have a real need right now. Adding it later on is
>>> easy, removing it later on because it just gets in the way and confuses is
>>> much harder.
>>
>> The IOVA space is only one example.
>>
>> In case of the VirtIO driver, we may have two memory allocation for a
>> BO. One is the shmem allcation in guest and the other is in host's vram.
>> If we will only release the guest's memory on purge, then the vram will
>> remain allocated until BO is destroyed, which unnecessarily sub-optimal.
> 
> Hm but why don't you just nuke the memory on the host side too when you
> evict? Allowing the guest memory to be swapped out while keeping the host
> memory allocation alive also doesn't make a lot of sense for me. Both can
> be recreated (I guess at least?) on swap-in.

Shouldn't be very doable or at least worth the efforts. It's userspace
that manages data uploading, kernel only provides transport for the
virtio-gpu commands.

Drivers are free to use the same function for both purge() and evict()
callbacks if they want. Getting rid of the purge() callback creates more
problems than solves, IMO.

-- 
Best regards,
Dmitry
