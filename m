Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DA054028F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbiFGPeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiFGPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:34:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A135C038E;
        Tue,  7 Jun 2022 08:34:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-163.dynamic.spd-mgts.ru [109.252.138.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1DF06601A26;
        Tue,  7 Jun 2022 16:33:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654616040;
        bh=1OHF6wl6ehs/wRC7M/8ORoOFTl8MMQfJ9asXXd+gmRE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aEIUXUrg6wlcmhJWW9Dpq0CD51JiB4Gk+im588kYV1D7mO9ub6yKFVwNOXpZVJ2wM
         opGS/8b5tqT6A+Qs0IOWZkFwx79fas7g7J+6UFuPd62KDBH4Udp9hStEJ+Rda/cqwS
         /URMw8PUaP1oUBVHs2Yv4T39A3FIsYQBzAsp8bo0QFJ3mZ0J+ykNSYh0VcCXFnvq3G
         IOXQEb+tEfv6oiz2y9m8bvih3N0zkAqVp0jlIZFmtAilcr0aTfPA8jEpZx7IeH9ey7
         VUWWcHduvM3mB3xQmqfjKAk9sBAsGQj/TYmOnhe4+/BKszV79pAEu3Vi5r8hO/X1HA
         L4he4Zd+PxFGA==
Message-ID: <382d50a2-8e47-5e0f-726b-f077be5b8bc6@collabora.com>
Date:   Tue, 7 Jun 2022 18:33:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Steven Price <steven.price@arm.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        virtualization@lists.linux-foundation.org,
        Chia-I Wu <olvaffe@gmail.com>, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linaro-mm-sig@lists.linaro.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        amd-gfx@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com>
 <CAKMK7uHQ+iMkXtrsCWiJL9X1AM9Xkq-wNmj=hhfnenf0r9717g@mail.gmail.com>
 <2aedbd68-cb4b-157c-1ddb-dbdb9348d2fe@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2aedbd68-cb4b-157c-1ddb-dbdb9348d2fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 13:57, Christian König wrote:
> Am 05.06.22 um 18:47 schrieb Daniel Vetter:
>> On Fri, 27 May 2022 at 01:55, Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:
>>> Introduce a common DRM SHMEM shrinker framework that allows to reduce
>>> code duplication among DRM drivers by replacing theirs custom shrinker
>>> implementations with the generic shrinker.
>>>
>>> In order to start using DRM SHMEM shrinker drivers should:
>>>
>>> 1. Implement new evict() shmem object callback.
>>> 2. Register shrinker using drm_gem_shmem_shrinker_register(drm_device).
>>> 3. Use drm_gem_shmem_set_purgeable(shmem) and alike API functions to
>>>     activate shrinking of shmem GEMs.
>>>
>>> This patch is based on a ideas borrowed from Rob's Clark MSM shrinker,
>>> Thomas' Zimmermann variant of SHMEM shrinker and Intel's i915 shrinker.
>>>
>>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> So I guess I get a price for being blind since forever, because this
>> thing existed since at least 2013. I just stumbled over
>> llist_lru.[hc], a purpose built list helper for shrinkers. I think we
>> should try to adopt that so that our gpu shrinkers look more like
>> shrinkers for everything else.
> 
> What the heck are you talking about?
> 
> I can't find any llist_lru.[hc] in the linux kernel sources.

I think Daniel meant this:

https://elixir.bootlin.com/linux/v5.19-rc1/source/include/linux/list_lru.h

https://elixir.bootlin.com/linux/v5.19-rc1/source/mm/list_lru.c


-- 
Best regards,
Dmitry
