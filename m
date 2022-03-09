Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9E4D3CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbiCIW0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbiCIW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:26:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C9120F60
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:25:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 53FAF1F44EA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646864747;
        bh=AkGj7nTWMoomWRkdJCvTLzW+5BnCOQ1RLk59S45H2G8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bYtq1SvtGMZR3ZztKfmLLKr3S6w7A/3ieWCdJW6Hvi4gb7anwVpCJV+P2kKdLrSPP
         DtilhNyxqMiS43VK8FyDxExEbZb3GVpxppM8+ghaWBRlhywOvc+Bmtnzd+SSqCdPID
         HvJBrhazTBG12TNiMP4+qwwC8jvK/neSj6hl9+gbC+EQMKP5fVXKVfEXLZ/p69TksO
         6j6bgZ5CxWVGr+IKaYRnpXWTCymJeMzVPM2RES9Yp9dwFuPTVTAsW8oSQA4AIpA4AN
         wRc733Fi0sIBKLseZ5T9clbuDF7K2wYaQiyTFT/mDAo6eCtaz6V2OAc2XnomeoJwEv
         5Z6e+h1b42hZA==
Message-ID: <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
Date:   Thu, 10 Mar 2022 01:25:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
 <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
 <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 22:28, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.03.22 um 12:55 schrieb Dmitry Osipenko:
>> Hello,
>>
>> On 3/9/22 11:59, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 08.03.22 um 14:17 schrieb Dmitry Osipenko:
>>>> Hello,
>>>>
>>>> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
>>>> During OOM, the shrinker will release BOs that are marked as "not
>>>> needed"
>>>> by userspace using the new madvise IOCTL. The userspace in this case is
>>>> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
>>>> allowing kernel driver to release memory of the cached shmem BOs on
>>>> lowmem
>>>> situations, preventing OOM kills.
>>>
>>> Virtio-gpu is build on top of GEM shmem helpers. I have a prototype
>>> patchset that adds a shrinker to these helpers. If you want to go
>>> further, you could implement something like that instead. Panfrost and
>>> lima also have their own shrinker and could certainly be converted to
>>> the gem-shmem shrinker.
>>
>> I had a thought that it could be possible to unify shrinkers into a
>> common DRM framework. Could you please give me a link to yours prototype
>> patchset?
> 
> I uploaded the patches to
> 
> 
> https://gitlab.freedesktop.org/tzimmermann/linux/-/commits/gem-shmem-cached-mappings
> 
> 
> it's incomplete and un-debugged, but it shows what needs to be done. It
> has the infrastructure, but lacks the changes to the GEM shmem code.
> 
> The reason for this work is to keep GEM shmem pages mapped and allocated
> even while the BO is neither mapped nor pinned.  As it is now, GEM SHMEM
> creates and releases pages on each pin and unpin, and maps and unmaps
> memory ranges on each vmap and vunmap.  It's all wasteful. Only the
> first pin and vmap calls should establish pages and mappings and only
> the purge and free functions should release them.

Hm, aren't maps and pins already refcounted?

> The patchset adds new helpers for BO purging to struct
> drm_gem_object_funcs. With this, I think it might be possible to have
> one global DRM shrinker and let it handle all BOs; independent of each
> BO's memory manager.

Thank you, I'll give it a try.
