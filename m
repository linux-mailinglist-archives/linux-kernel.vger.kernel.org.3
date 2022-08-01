Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0058722F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiHAUOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiHAUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:14:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE145053;
        Mon,  1 Aug 2022 13:13:50 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 442666601BA5;
        Mon,  1 Aug 2022 21:13:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659384828;
        bh=yGmTR0WRS4cY5SkMJUjWVnFZuaftF9fBXlpSnJkxHKQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LJIBXTcTJ6wF+CyRiW64eCeMjvLG1f/LVy3dN3YcE3edv1K6Vt+tUtaCaliRJDFuM
         Irk8MIC/lItFmNkVoAXLrGCjJ8Oyr75pv2TkGHiFOa9N6zCvIrrvvGtLjODLGMC4Sd
         MOzlQ7fiDJItjxzPnCRzSqusZYkNmWGXkTwLGlMrd3F2ANkxJ1kzQmEo6RnYa/RTiJ
         EQy7XmeaNFmt6XBCq/p4TqgXAfzNp8T7UkdfVzM+OIH9qI3ciICIBaVk0R4QfhzhiK
         AYryR8h1J4T4xdNtSgqT4kEMhQLRHYjFAMmetibz2ZXNN0W+6E558HIW6v5yyr57z/
         tiD0g3zzwf7cw==
Message-ID: <733f5d3f-293e-f951-a00b-fcd3052f68e7@collabora.com>
Date:   Mon, 1 Aug 2022 23:13:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 09/15] drm/gem: Add LRU/shrinker helper
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20220726175043.1027731-1-robdclark@gmail.com>
 <20220726175043.1027731-10-robdclark@gmail.com>
 <def8e47c-067e-0841-4ae4-1eb90244cd50@collabora.com>
 <CAF6AEGtV4GY6=PmQh0wrKxjxk_baRCzOo=s=Uz-uKBNEn7SBBg@mail.gmail.com>
 <6b35b912-68e5-e722-0b5a-0f7bd06c22c2@collabora.com>
In-Reply-To: <6b35b912-68e5-e722-0b5a-0f7bd06c22c2@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 23:11, Dmitry Osipenko wrote:
> On 8/1/22 23:00, Rob Clark wrote:
>> On Mon, Aug 1, 2022 at 12:41 PM Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:
>>>
>>> On 7/26/22 20:50, Rob Clark wrote:
>>>> +/**
>>>> + * drm_gem_lru_remove - remove object from whatever LRU it is in
>>>> + *
>>>> + * If the object is currently in any LRU, remove it.
>>>> + *
>>>> + * @obj: The GEM object to remove from current LRU
>>>> + */
>>>> +void
>>>> +drm_gem_lru_remove(struct drm_gem_object *obj)
>>>> +{
>>>> +     struct drm_gem_lru *lru = obj->lru;
>>>> +
>>>> +     if (!lru)
>>>> +             return;
>>>> +
>>>> +     mutex_lock(lru->lock);
>>>> +     lru_remove(obj);
>>>> +     mutex_unlock(lru->lock);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gem_lru_remove);
>>>
>>> I made a preliminary port of the DRM-SHMEM shrinker on top of the the
>>> latest version of dma-buf locking convention and yours LRU patches. It
>>> all works good, the only thing that is missing for the DRM-SHMEM
>>> shrinker is the drm_gem_lru_remove_locked().
>>>
>>> What about to add a locked variant of drm_gem_lru_remove()?
>>
>> Sounds fine to me.. the only reason it didn't exist yet was because it
>> wasn't needed yet..
> 
> There is no use for the drm_gem_lru_move_tail_locked() as well, you're
> not using it in the MSM driver. Hence I thought it might be good to add
> the drm_gem_lru_remove_locked(), or maybe the
> drm_gem_lru_move_tail_locked() should be dropped then?
> 
>> I can respin w/ an addition of a _locked() version, or you can add it
>> on top in your patchset.  Either is fine by me
> 
> The either option is fine by me too. If you'll keep the unused
> drm_gem_lru_move_tail_locked(), then will be nice to add
> drm_gem_lru_remove_locked().
> 

The drm_gem_lru_move_tail_locked() will be needed by DRM-SHMEM shrinker,
BTW.

-- 
Best regards,
Dmitry
