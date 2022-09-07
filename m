Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666045B01E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiIGKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiIGKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:25:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D15C958;
        Wed,  7 Sep 2022 03:25:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD57C6601F5A;
        Wed,  7 Sep 2022 11:25:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662546314;
        bh=dGTIe7ZAAKDcOJ9oH8UOqLoDDKuOUNjmja0Csb9f/Xk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YE1aXPGzXFYIYfGLRtolH893wbL41ZfPcqDcKR3SEZmKWM8UJTsqZYwnNdBm8i78V
         VaHph7aB9YaYXQet6chjjmqaFsIwnqICLTjn14qZlf8vfUQwielFkBD5LDKooM9JCc
         PJ1iofAlVyd5AkdKCHZO1Ra7GOLEiDr7zWAbkaKYbxTzDUuG4bWkr0vV0VbFrcWmU4
         2Uqs3QE3s/ipOV5oNccnUdzU1VaNLGjIi8ZpxFcEG9ED2QNcn2CIhibLQu0dr6eA5F
         DQU41PA2tFHDK4hA4kDbc0rD1RYdZi0injG3rf4D9fE2mXqZ47Sis97cOXmQ1h+gu/
         RmKW3kVP6c7KA==
Message-ID: <bab5a55b-cbd3-4119-af39-794e38f5a0ee@collabora.com>
Date:   Wed, 7 Sep 2022 13:25:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
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
 <cf8cd8da-08d2-5e70-a239-2a67da37c9ea@collabora.com>
 <e9bde303-6474-aa0b-7880-cf7d8b163983@collabora.com>
 <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com>
 <CAF6AEGvnqV4ySs6rNWu0pkeSNJMhgN1rvind8dC-nV1Sv3kk8g@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGvnqV4ySs6rNWu0pkeSNJMhgN1rvind8dC-nV1Sv3kk8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 19:47, Rob Clark wrote:
> On Tue, Aug 23, 2022 at 3:01 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Am 22.08.22 um 19:26 schrieb Dmitry Osipenko:
>>> On 8/16/22 22:55, Dmitry Osipenko wrote:
>>>> On 8/16/22 15:03, Christian König wrote:
>>>>> Am 16.08.22 um 13:44 schrieb Dmitry Osipenko:
>>>>>> [SNIP]
>>>>>>> The other complication I noticed is that we don't seem to keep around
>>>>>>> the fd after importing to a GEM handle.  And I could imagine that
>>>>>>> doing so could cause issues with too many fd's.  So I guess the best
>>>>>>> thing is to keep the status quo and let drivers that cannot mmap
>>>>>>> imported buffers just fail mmap?
>>>>>> That actually should be all the drivers excluding those that use
>>>>>> DRM-SHMEM because only DRM-SHMEM uses dma_buf_mmap(), that's why it
>>>>>> works for Panfrost. I'm pretty sure mmaping of imported GEMs doesn't
>>>>>> work for the MSM driver, isn't it?
>>>>>>
>>>>>> Intel and AMD drivers don't allow to map the imported dma-bufs. Both
>>>>>> refuse to do the mapping.
>>>>>>
>>>>>> Although, AMDGPU "succeeds" to do the mapping using
>>>>>> AMDGPU_GEM_DOMAIN_GTT, but then touching the mapping causes bus fault,
>>>>>> hence mapping actually fails. I think it might be the AMDGPU
>>>>>> driver/libdrm bug, haven't checked yet.
>>>>> That's then certainly broken somehow. Amdgpu should nerve ever have
>>>>> allowed to mmap() imported DMA-bufs and the last time I check it didn't.
>>>> I'll take a closer look. So far I can only tell that it's a kernel
>>>> driver issue because once I re-applied this "Don't map imported GEMs"
>>>> patch, AMDGPU began to refuse mapping AMDGPU_GEM_DOMAIN_GTT.
>>>>
>>>>>> So we're back to the point that neither of DRM drivers need to map
>>>>>> imported dma-bufs and this was never tested. In this case this patch is
>>>>>> valid, IMO.
>>>> Actually, I'm now looking at Etnaviv and Nouveau and seems they should
>>>> map imported dma-buf properly. I know that people ran Android on
>>>> Etnaviv. So maybe devices with a separated GPU/display need to map
>>>> imported display BO for Android support. Wish somebody who ran Android
>>>> on one of these devices using upstream drivers could give a definitive
>>>> answer. I may try to test Nouveau later on.
>>>>
>>> Nouveau+Intel combo doesn't work because of [1] that says:
>>>
>>> "Refuse to fault imported pages. This should be handled (if at all) by
>>> redirecting mmap to the exporter."
>>>
>>> [1]
>>> https://elixir.bootlin.com/linux/v5.19/source/drivers/gpu/drm/ttm/ttm_bo_vm.c#L154
>>>
>>> Interestingly, I noticed that there are IGT tests which check prime
>>> mmaping of Nouveau+Intel [2] (added 9 years ago), but they fail as well,
>>> as expected. The fact that IGT has such tests is interesting because it
>>> suggests that the mapping worked in the past. It's also surprising that
>>> nobody cared to fix the failing tests. For the reference, I checked
>>> v5.18 and today's linux-next.
>>>
>>> [2]
>>> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/prime_nv_test.c#L132
>>>
>>> Starting subtest: nv_write_i915_cpu_mmap_read
>>> Received signal SIGBUS.
>>> Stack trace:
>>>   #0 [fatal_sig_handler+0x163]
>>>   #1 [__sigaction+0x50]
>>>   #2 [__igt_unique____real_main354+0x406]
>>>   #3 [main+0x23]
>>>   #4 [__libc_start_call_main+0x80]
>>>   #5 [__libc_start_main+0x89]
>>>   #6 [_start+0x25]
>>> Subtest nv_write_i915_cpu_mmap_read: CRASH (0,005s)
>>>
>>> Starting subtest: nv_write_i915_gtt_mmap_read
>>> Received signal SIGBUS.
>>> Stack trace:
>>>   #0 [fatal_sig_handler+0x163]
>>>   #1 [__sigaction+0x50]
>>>   #2 [__igt_unique____real_main354+0x33d]
>>>   #3 [main+0x23]
>>>   #4 [__libc_start_call_main+0x80]
>>>   #5 [__libc_start_main+0x89]
>>>   #6 [_start+0x25]
>>> Subtest nv_write_i915_gtt_mmap_read: CRASH (0,004s)
>>>
>>> I'm curious about the Etnaviv driver because it uses own shmem
>>> implementation and maybe it has a working mmaping of imported GEMs since
>>> it imports the dma-buf pages into Entaviv BO. Although, it should be
>>> risking to map pages using a different caching attributes (WC) from the
>>> exporter, which is prohibited on ARM ad then one may try to map imported
>>> udmabuf.

I see now that Etnaviv uses dma_buf_mmap(), so it should be okay.

>>> Apparently, the Intel DG TTM driver should be able to map imported
>>> dma-buf because it sets TTM_TT_FLAG_EXTERNAL_MAPPABLE.
>>
>> Even with that flag set it is illegal to map the pages directly by an
>> importer.
>>
>> If that ever worked then the only real solution is to redirect mmap()
>> calls on importer BOs to dma_buf_mmap().
> 
> Yeah, I think this is the best option.  Forcing userspace to hang on
> to the fd just in case someone calls readpix would be pretty harsh.

Actually, I proposed this couple months ago [1].

[1] https://patchwork.freedesktop.org/patch/487481/

What's not clear to me is how userspace is supposed to sync CPU accesses
for imported GEMs. Either userspace need to use dma_buf_sync UAPI for
dmabuf of imported GEM or importer driver should do that, or there is
some other option?

-- 
Best regards,
Dmitry
