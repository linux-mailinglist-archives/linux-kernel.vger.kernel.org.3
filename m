Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E54D2E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiCIL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiCIL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:56:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E379A996D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:55:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 5D8B61F44A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646826940;
        bh=dJmw4zOrIHkURAmLQiTZMGndrEkge+z8fLKmyH944ng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lzcJwR+xt1Hi8zjGE4UgpY3rbII3w72kn/wdkoJY0oZKJ9pzvD/YNCuQY2JgOUcgu
         IIMJ4teyyYm+lIooNRL4ucJE4cCnUAK2tGNpc2vZqkp7yjbHxivzwLqJHF+wWk7bd7
         AbfK1dYuMW9v4Pj1MHR8nDciE0aJij8ookDYocuwVasuo8i42d6G+I6ORcCYE/rXBc
         HHpJ3VRi5ynK0kzALfafF87gYjdAAD1w4DzDqYd5MdOdL0Lv0Qg/lZXqz5TIh4xNRd
         F7qa8nuXGqfb6EFSdLlQt7VUaiqXMzPL7vK78nwEiPw/xoPmUxGl/7kaktl/W6ke/F
         P53OZjZwjW4zA==
Message-ID: <26ab770d-4b59-a25a-79ef-e43858e7b67b@collabora.com>
Date:   Wed, 9 Mar 2022 14:55:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 5/5] drm/virtio: Add memory shrinker
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <20220308131725.60607-6-dmitry.osipenko@collabora.com>
 <CAF6AEGvVmV4fesd0MsSo-4WxSVqOFN-U+p5HOE2job6CeYbqTA@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGvVmV4fesd0MsSo-4WxSVqOFN-U+p5HOE2job6CeYbqTA@mail.gmail.com>
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


On 3/9/22 04:12, Rob Clark wrote:
>> +static unsigned long
>> +virtio_gpu_gem_shrinker_count_objects(struct shrinker *shrinker,
>> +                                     struct shrink_control *sc)
>> +{
>> +       struct drm_gem_shmem_object *shmem;
>> +       struct virtio_gpu_device *vgdev;
>> +       unsigned long count = 0;
>> +       bool empty = true;
>> +
>> +       vgdev = container_of(shrinker, struct virtio_gpu_device,
>> +                            vgshrinker.shrinker);
>> +
>> +       if (!mutex_trylock(&vgdev->mm_lock))
>> +               return 0;
> One bit of advice from previously dealing with shrinker and heavy
> memory pressure situations (turns out 4GB chromebooks can be pretty
> much under *constant* memory pressure):
> 
> You *really* want to make shrinker->count_objects lockless.. and
> minimize the lock contention on shrinker->scan_objects (ie.  The
> problem is you can end up with shrinking going on on all CPU cores in
> parallel, you want to not funnel that thru one lock as much as
> possible.
> 
> See in particular:
> 
> 25ed38b3ed26 ("drm/msm: Drop mm_lock in scan loop")
> cc8a4d5a1bd8 ("drm/msm: Avoid mutex in shrinker_count()")

Thank you, I'll take that into account for v2.
