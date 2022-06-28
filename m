Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075955F05E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiF1Vcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiF1Vci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:32:38 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 14:32:36 PDT
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A783AA7A;
        Tue, 28 Jun 2022 14:32:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 919EB3FD63;
        Tue, 28 Jun 2022 23:27:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.11
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dc2aFG-pVafs; Tue, 28 Jun 2022 23:27:02 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id AEB693FDAA;
        Tue, 28 Jun 2022 23:26:58 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9AA06360156;
        Tue, 28 Jun 2022 23:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1656451618; bh=ytcDsDZId1FXW7EIkS2vLuiS9VYbZskPayG7B85WlHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X+B+WnRob8hg5hOiIRj9AvbJ5diUA33ARcN993ZZQPEzHdlHsiKt8+qlYRCgjTyfG
         ps+3/ZqSvyJeQdOXk/lQcIjKzkTFOGguhtbYDHn/RqNQYZuDiHB+kWuEW/Pt1GiM1j
         Xu8V0jFNaU6WQL+FCf5BhdHiO2jnqOkkwTPYPEpw=
Message-ID: <90fe74f6-a622-e4ae-3004-6f1bc1790247@shipmail.org>
Date:   Tue, 28 Jun 2022 23:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 14/22] dma-buf: Introduce new locking convention
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, linux-media@vger.kernel.org
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-15-dmitry.osipenko@collabora.com>
 <0a02a31d-a256-4ca4-0e35-e2ea1868a8ae@amd.com>
 <e6e17c52-43c2-064b-500e-325bb3ba3b2c@collabora.com>
 <02e7946b-34ca-b48e-1ba6-e7b63740a2d9@amd.com>
 <7372dd1b-06f7-5336-4738-15f9b4d4d4b3@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
In-Reply-To: <7372dd1b-06f7-5336-4738-15f9b4d4d4b3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/22 15:57, Dmitry Osipenko wrote:
> On 5/30/22 16:41, Christian König wrote:
>> Hi Dmitry,
>>
>> Am 30.05.22 um 15:26 schrieb Dmitry Osipenko:
>>> Hello Christian,
>>>
>>> On 5/30/22 09:50, Christian König wrote:
>>>> Hi Dmitry,
>>>>
>>>> First of all please separate out this patch from the rest of the series,
>>>> since this is a complex separate structural change.
>>> I assume all the patches will go via the DRM tree in the end since the
>>> rest of the DRM patches in this series depend on this dma-buf change.
>>> But I see that separation may ease reviewing of the dma-buf changes, so
>>> let's try it.
>> That sounds like you are underestimating a bit how much trouble this
>> will be.
>>
>>>> I have tried this before and failed because catching all the locks in
>>>> the right code paths are very tricky. So expect some fallout from this
>>>> and make sure the kernel test robot and CI systems are clean.
>>> Sure, I'll fix up all the reported things in the next iteration.
>>>
>>> BTW, have you ever posted yours version of the patch? Will be great if
>>> we could compare the changed code paths.
>> No, I never even finished creating it after realizing how much work it
>> would be.
>>
>>>>> This patch introduces new locking convention for dma-buf users. From
>>>>> now
>>>>> on all dma-buf importers are responsible for holding dma-buf
>>>>> reservation
>>>>> lock around operations performed over dma-bufs.
>>>>>
>>>>> This patch implements the new dma-buf locking convention by:
>>>>>
>>>>>      1. Making dma-buf API functions to take the reservation lock.
>>>>>
>>>>>      2. Adding new locked variants of the dma-buf API functions for
>>>>> drivers
>>>>>         that need to manage imported dma-bufs under the held lock.
>>>> Instead of adding new locked variants please mark all variants which
>>>> expect to be called without a lock with an _unlocked postfix.
>>>>
>>>> This should make it easier to remove those in a follow up patch set and
>>>> then fully move the locking into the importer.
>>> Do we really want to move all the locks to the importers? Seems the
>>> majority of drivers should be happy with the dma-buf helpers handling
>>> the locking for them.
>> Yes, I clearly think so.
>>
>>>>>      3. Converting all drivers to the new locking scheme.
>>>> I have strong doubts that you got all of them. At least radeon and
>>>> nouveau should grab the reservation lock in their ->attach callbacks
>>>> somehow.
>>> Radeon and Nouveau use gem_prime_import_sg_table() and they take resv
>>> lock already, seems they should be okay (?)
>> You are looking at the wrong side. You need to fix the export code path,
>> not the import ones.
>>
>> See for example attach on radeon works like this
>> drm_gem_map_attach->drm_gem_pin->radeon_gem_prime_pin->radeon_bo_reserve->ttm_bo_reserve->dma_resv_lock.
> Yeah, I was looking at the both sides, but missed this one.

Also i915 will run into trouble with attach. In particular since i915 
starts a full ww transaction in its attach callback to be able to lock 
other objects if migration is needed. I think i915 CI would catch this 
in a selftest.

Perhaps it's worthwile to take a step back and figure out, if the 
importer is required to lock, which callbacks might need a ww acquire 
context?

(And off-topic, Since we do a lot of fancy stuff under dma-resv locks 
including waiting for fences and other locks, IMO taking these locks 
uninterruptible should ring a warning bell)

/Thomas

>
>> Same for nouveau and probably a few other exporters as well. That will
>> certainly cause a deadlock if you don't fix it.
>>
>> I strongly suggest to do this step by step, first attach/detach and then
>> the rest.
> Thank you very much for the suggestions. I'll implement them in the next
> version.
>
