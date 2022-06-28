Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7789555E412
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbiF1NL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbiF1NLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:11:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD47645A;
        Tue, 28 Jun 2022 06:11:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 714326601856;
        Tue, 28 Jun 2022 14:11:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656421873;
        bh=KNSZUjyY4CuF71/A7Usafn7IJCqpjpqnNb+s/bjmhpM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JVdCL4pOrZRjPYlW1sSxr0ov8MYwr/h/jFUMEmO4yZZL0Thh0VqUNftTIaNvUwEmY
         myolbgF/rRAWBiGj8as5x4lXrPgfvowspQRix7IvWX3ujENW9n/A9RgofDbIFplpJ1
         XKBUEiGyhohLkxg095z15R9kLoSIzKX7UR4GwSE03H/Wl5+upu3XGKE9fggwC3rLAJ
         YwztUDyhr9vdUcLY8PyCIUcj0FTuvMwiQySOEZvk1YLzw5WODsuuCzO2945ZS6eOcK
         kbjoe/4U6aWPVrza0Q6OS9hOE9m0uzU59dItxkwobNx4NGuRgKEN7SpAkBhFBnLjES
         o9MoSYPi5XeiA==
Message-ID: <8c5d3cb0-70fa-81a7-33a2-50f45bf8f40e@collabora.com>
Date:   Tue, 28 Jun 2022 16:11:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 00/22] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
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
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kernel@collabora.com
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <49cc6f0c-e90e-8edd-52e7-4188620e2c28@arm.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <49cc6f0c-e90e-8edd-52e7-4188620e2c28@arm.com>
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

Hello Robin,

On 6/28/22 15:31, Robin Murphy wrote:
>> Hello,
>>
>> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver
>> and adds memory purging and eviction support to VirtIO-GPU driver.
>>
>> The new dma-buf locking convention is introduced here as well.
>>
>> During OOM, the shrinker will release BOs that are marked as "not needed"
>> by userspace using the new madvise IOCTL, it will also evict idling BOs
>> to SWAP. The userspace in this case is the Mesa VirGL driver, it will
>> mark
>> the cached BOs as "not needed", allowing kernel driver to release memory
>> of the cached shmem BOs on lowmem situations, preventing OOM kills.
>>
>> The Panfrost driver is switched to use generic memory shrinker.
> 
> I think we still have some outstanding issues here - Alyssa reported
> some weirdness yesterday, so I just tried provoking a low-memory
> condition locally with this series applied and a few debug options
> enabled, and the results as below were... interesting.

The warning and crash that you got actually are the minor issues.

Alyssa caught an interesting PREEMPT_DEBUG issue in the shrinker that I
haven't seen before.

She is also experiencing another problem in the Panfrost driver with a
bad shmem pages (I think). It is unrelated to this patchset and
apparently require an extra setup for the reproduction.

-- 
Best regards,
Dmitry
