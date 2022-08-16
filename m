Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FF596360
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiHPT4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiHPT4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:56:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB6779604;
        Tue, 16 Aug 2022 12:56:00 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BC5C660037D;
        Tue, 16 Aug 2022 20:55:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660679758;
        bh=QUXUXYkhFymxKXOLeAezfOww+02sMdDSnE//u2RiUFM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CVM4id76n+RhaUefcyoNI4yah3kDGdYyN68LKYUcBxQy6kRNp16EuhrcSBTm7BxN/
         1okQMK8mg83NetPZXjRBPYQr5xe5pPctN7Tj8kWrJ0Ed8Jk6E8SEd1Y9qLJGJg6VMI
         ANvZj/dqHo84JivmR8Qr0MnboYLog7JlWO+nVEjy9HhMEBIF2XF8frWBlcS//ZuwCq
         dMbGTF2wy1/70Skx2C9muNyZTNkW95vijAHW4X7/8tzDHWiQj+b71rvCL+p7P/6BdL
         qNqkAVP0hp6clTF16+kJXWqby9L2e5++00yZavOGTJ8VEiQ383euMrJUgzyhkHSiII
         SDR3f8LvCxx0Q==
Message-ID: <cf8cd8da-08d2-5e70-a239-2a67da37c9ea@collabora.com>
Date:   Tue, 16 Aug 2022 22:55:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
 <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
 <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
 <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
 <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 15:03, Christian König wrote:
> Am 16.08.22 um 13:44 schrieb Dmitry Osipenko:
>> [SNIP]
>>> The other complication I noticed is that we don't seem to keep around
>>> the fd after importing to a GEM handle.  And I could imagine that
>>> doing so could cause issues with too many fd's.  So I guess the best
>>> thing is to keep the status quo and let drivers that cannot mmap
>>> imported buffers just fail mmap?
>> That actually should be all the drivers excluding those that use
>> DRM-SHMEM because only DRM-SHMEM uses dma_buf_mmap(), that's why it
>> works for Panfrost. I'm pretty sure mmaping of imported GEMs doesn't
>> work for the MSM driver, isn't it?
>>
>> Intel and AMD drivers don't allow to map the imported dma-bufs. Both
>> refuse to do the mapping.
>>
>> Although, AMDGPU "succeeds" to do the mapping using
>> AMDGPU_GEM_DOMAIN_GTT, but then touching the mapping causes bus fault,
>> hence mapping actually fails. I think it might be the AMDGPU
>> driver/libdrm bug, haven't checked yet.
> 
> That's then certainly broken somehow. Amdgpu should nerve ever have
> allowed to mmap() imported DMA-bufs and the last time I check it didn't.

I'll take a closer look. So far I can only tell that it's a kernel
driver issue because once I re-applied this "Don't map imported GEMs"
patch, AMDGPU began to refuse mapping AMDGPU_GEM_DOMAIN_GTT.

>> So we're back to the point that neither of DRM drivers need to map
>> imported dma-bufs and this was never tested. In this case this patch is
>> valid, IMO.

Actually, I'm now looking at Etnaviv and Nouveau and seems they should
map imported dma-buf properly. I know that people ran Android on
Etnaviv. So maybe devices with a separated GPU/display need to map
imported display BO for Android support. Wish somebody who ran Android
on one of these devices using upstream drivers could give a definitive
answer. I may try to test Nouveau later on.

-- 
Best regards,
Dmitry
