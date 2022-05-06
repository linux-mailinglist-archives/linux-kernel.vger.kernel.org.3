Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456DE51CDA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387431AbiEFAOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiEFAOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:14:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE733A199
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:10:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id D9EA71F45E0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651795847;
        bh=8HWc5okoCATXQtSjnHcBZ94vd08tA8gZnAW7NIzIUzc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E69M8Dpbytxm+liBztEXWxOxgJF11w/CzN4vstE4Ks1/CK+R54ymWAG8WhQ11Z3it
         UTIE6yFWtxaLarXDEtc1FXzyvLjbznINeNlstPpA/8NTxjU+0cl6o7qv4HCz9h8i2o
         YM3d+HYGQ09TSTZDF+orUvlE6/iycVSKZ98/O8I54xjCdcd8/z5KAFanNwPBZIRDQq
         QDCWPKlrh/drnIXxITfMDB+g+ErN5tUhFyTcnvdRojYEy1/dguLfyKPtPIXA7ynU7a
         5af+OKmMvexH7qR6EjSif8Bdmzw4QMIXr7cl/RyeaX8mvcbPPS7sASgtcr6r7aQrRL
         bjxSeX9NGH/gQ==
Message-ID: <ff97790a-fb64-1e15-74b4-59c807bce0b9@collabora.com>
Date:   Fri, 6 May 2022 03:10:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
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
 <20220417223707.157113-12-dmitry.osipenko@collabora.com>
 <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 11:34, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
>> Introduce a common DRM SHMEM shrinker. It allows to reduce code
>> duplication among DRM drivers that implement theirs own shrinkers.
>> This is initial version of the shrinker that covers basic needs of
>> GPU drivers, both purging and eviction of shmem objects are supported.
>>
>> This patch is based on a couple ideas borrowed from Rob's Clark MSM
>> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
>>
>> In order to start using DRM SHMEM shrinker drivers should:
>>
>> 1. Implement new purge(), evict() + swap_in() GEM callbacks.
>> 2. Register shrinker using drm_gem_shmem_shrinker_register(drm_device).
>> 3. Use drm_gem_shmem_set_purgeable_and_evictable(shmem) and alike API
>>     functions to activate shrinking of GEMs.
> 
> Honestly speaking, after reading the patch and the discussion here I
> really don't like where all tis is going. The interfaces and
> implementation are overengineered.  Descisions about evicting and
> purging should be done by the memory manager. For the most part, it's
> none of the driver's business.

Daniel mostly suggesting to make interface more flexible for future
drivers, so we won't need to re-do it later on. My version of the
interface is based on what drivers need today.

Why do you think it's a problem to turn shmem helper into the simple
generic memory manager? I don't see how it's better to have drivers
duplicating the exactly same efforts and making different mistakes.

The shmem shrinker implementation is mostly based on the freedreno's
shrinker and it's very easy to enable generic shrinker for VirtIO and
Panfrost drivers. I think in the future freedreno and other drivers
could switch to use drm shmem instead of open coding the memory management.

> I'd like to ask you to reduce the scope of the patchset and build the
> shrinker only for virtio-gpu. I know that I first suggested to build
> upon shmem helpers, but it seems that it's easier to do that in a later
> patchset.

The first version of the VirtIO shrinker didn't support memory eviction.
Memory eviction support requires page fault handler to be aware of the
evicted pages, what should we do about it? The page fault handling is a
part of memory management, hence to me drm-shmem is already kinda a MM.
