Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A096565F72
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 00:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGDWir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 18:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGDWip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:38:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D760F7;
        Mon,  4 Jul 2022 15:38:44 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AEB39660199B;
        Mon,  4 Jul 2022 23:38:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656974322;
        bh=VRx6udoXxSq0dZb7twvztDgIdzhjYZHCPJJRsM4dVqQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=KwvHGSsu2bJpgBrKrgPDv83tWaOdVmGMPR8xlDdCPLhk9xw7Ud+ZimwXxR2cr6Bmp
         u3TauupmhYOD/BkPc+8ksFovTJTbAcBpLSx299Nu/F9NLYkyvIwA7hazvWNS1Ox8iE
         oWyqhlB87oYwccFQeaom4XZ5SLTzFf4krAuEcymZX+yHDFAVa73And9pvwQQQaqVG0
         uVbLJZX3cSps+jjvkOrgPRu1fS1he6n4GOm4SrJjDL0Yuyb5LZkxCAnhCGLYb/AJAq
         YXka1J9BEeBH6cDYDCae5AG19iXh8wYiVOrUyqTONSTh6YULDs1xUwy4JXtD8NNKBR
         zdbCJFJEnjwYQ==
Message-ID: <fd026c44-b067-3537-3020-4ae8f24137ad@collabora.com>
Date:   Tue, 5 Jul 2022 01:38:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 14/22] dma-buf: Introduce new locking convention
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Qiang Yu <yuq825@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-15-dmitry.osipenko@collabora.com>
 <0a02a31d-a256-4ca4-0e35-e2ea1868a8ae@amd.com>
 <e6e17c52-43c2-064b-500e-325bb3ba3b2c@collabora.com>
 <02e7946b-34ca-b48e-1ba6-e7b63740a2d9@amd.com>
 <7372dd1b-06f7-5336-4738-15f9b4d4d4b3@collabora.com>
 <90fe74f6-a622-e4ae-3004-6f1bc1790247@shipmail.org>
 <0d88cf7c-61e5-d7a8-a6ba-83388114a1fa@collabora.com>
In-Reply-To: <0d88cf7c-61e5-d7a8-a6ba-83388114a1fa@collabora.com>
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

On 7/1/22 13:43, Dmitry Osipenko wrote:
> On 6/29/22 00:26, Thomas Hellström (Intel) wrote:
>> On 5/30/22 15:57, Dmitry Osipenko wrote:
>>> On 5/30/22 16:41, Christian König wrote:
>>>> Hi Dmitry,
>>>>
>>>> Am 30.05.22 um 15:26 schrieb Dmitry Osipenko:
>>>>> Hello Christian,
>>>>>
>>>>> On 5/30/22 09:50, Christian König wrote:
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> First of all please separate out this patch from the rest of the
>>>>>> series,
>>>>>> since this is a complex separate structural change.
>>>>> I assume all the patches will go via the DRM tree in the end since the
>>>>> rest of the DRM patches in this series depend on this dma-buf change.
>>>>> But I see that separation may ease reviewing of the dma-buf changes, so
>>>>> let's try it.
>>>> That sounds like you are underestimating a bit how much trouble this
>>>> will be.
>>>>
>>>>>> I have tried this before and failed because catching all the locks in
>>>>>> the right code paths are very tricky. So expect some fallout from this
>>>>>> and make sure the kernel test robot and CI systems are clean.
>>>>> Sure, I'll fix up all the reported things in the next iteration.
>>>>>
>>>>> BTW, have you ever posted yours version of the patch? Will be great if
>>>>> we could compare the changed code paths.
>>>> No, I never even finished creating it after realizing how much work it
>>>> would be.
>>>>
>>>>>>> This patch introduces new locking convention for dma-buf users. From
>>>>>>> now
>>>>>>> on all dma-buf importers are responsible for holding dma-buf
>>>>>>> reservation
>>>>>>> lock around operations performed over dma-bufs.
>>>>>>>
>>>>>>> This patch implements the new dma-buf locking convention by:
>>>>>>>
>>>>>>>      1. Making dma-buf API functions to take the reservation lock.
>>>>>>>
>>>>>>>      2. Adding new locked variants of the dma-buf API functions for
>>>>>>> drivers
>>>>>>>         that need to manage imported dma-bufs under the held lock.
>>>>>> Instead of adding new locked variants please mark all variants which
>>>>>> expect to be called without a lock with an _unlocked postfix.
>>>>>>
>>>>>> This should make it easier to remove those in a follow up patch set
>>>>>> and
>>>>>> then fully move the locking into the importer.
>>>>> Do we really want to move all the locks to the importers? Seems the
>>>>> majority of drivers should be happy with the dma-buf helpers handling
>>>>> the locking for them.
>>>> Yes, I clearly think so.
>>>>
>>>>>>>      3. Converting all drivers to the new locking scheme.
>>>>>> I have strong doubts that you got all of them. At least radeon and
>>>>>> nouveau should grab the reservation lock in their ->attach callbacks
>>>>>> somehow.
>>>>> Radeon and Nouveau use gem_prime_import_sg_table() and they take resv
>>>>> lock already, seems they should be okay (?)
>>>> You are looking at the wrong side. You need to fix the export code path,
>>>> not the import ones.
>>>>
>>>> See for example attach on radeon works like this
>>>> drm_gem_map_attach->drm_gem_pin->radeon_gem_prime_pin->radeon_bo_reserve->ttm_bo_reserve->dma_resv_lock.
>>>>
>>> Yeah, I was looking at the both sides, but missed this one.
>> Also i915 will run into trouble with attach. In particular since i915
>> starts a full ww transaction in its attach callback to be able to lock
>> other objects if migration is needed. I think i915 CI would catch this
>> in a selftest.
> Seems it indeed it should deadlock. But i915 selftests apparently
> should've caught it and they didn't, I'll re-check what happened.
> 

The i915 selftests use a separate mock_dmabuf_ops. That's why it works
for the selftests, i.e. there is no deadlock.

Thomas, would i915 CI run a different set of tests or will it be the
default i915 selftests ran by IGT?

-- 
Best regards,
Dmitry
