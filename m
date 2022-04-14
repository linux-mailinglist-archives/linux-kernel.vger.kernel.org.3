Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AC5019F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbiDNRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbiDNRZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:25:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946A3BC862
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:23:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id B79D21F47BCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649956990;
        bh=D3Guilrkks6V/1hTwTRFRrqejHfbyPr22LWaBmWvToo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KhEWKrc5jpdpnlEan/SJ5+kGF26hEhzLFsX6DVMxJLGi7R7KpgAMDEYPQJotCaaWo
         uIjlI/MD0FDOyWmglK4Bi4Hy59l9zTdy1cPQZn9lA3euRlaRBBBQAzcuwPj+uUCCdw
         S3wAiqfaQoVYB0G2jzHVZ5llQJCLsva2bCHU/uetz5eis8/YZpOl0FiBd0Mxtdzd8G
         OTfzlMLHdHKlP/rKTgpr7UjcAZ+ni5VCtJPpJ+EjFEjRotb/AiwQHPMa0iVx0F1RsS
         /xWFCgcHZJa9aqNb64gZra/RxZ0455Ef4v8X+NMJyPmLSPY+4iPrhdDBnJXDBP2c7x
         ZrF4tqzg5GgHw==
Message-ID: <2f71160e-01cc-40a5-4661-b998b3acd153@collabora.com>
Date:   Thu, 14 Apr 2022 18:29:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] drm/i915: stolen memory use ttm backend
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthew Auld <matthew.auld@intel.com>, linux-kernel@vger.kernel.org
References: <20220412193817.2098308-1-bob.beckett@collabora.com>
 <20220412193817.2098308-6-bob.beckett@collabora.com>
 <94ddf51a-90ae-dee8-5d6a-45ee2cd1e584@linux.intel.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <94ddf51a-90ae-dee8-5d6a-45ee2cd1e584@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 14/04/2022 15:41, Thomas Hellström wrote:
> Hi,
> 
> 
> On 4/12/22 21:38, Robert Beckett wrote:
>> +struct ttm_resource *
>> +i915_gem_stolen_reserve_range(struct drm_i915_private *i915,
>> +                  resource_size_t size,
>> +                  u64 start, u64 end)
>>   {
>> -    int ret;
>> +    struct intel_memory_region *mem = i915->mm.stolen_region;
>> -    if (!drm_mm_initialized(&i915->mm.stolen))
>> -        return -ENODEV;
>> -
>> -    /* WaSkipStolenMemoryFirstPage:bdw+ */
>> -    if (GRAPHICS_VER(i915) >= 8 && start < 4096)
>> -        start = 4096;
> 
> Did we lose this Workaround?

woops, looks like we did. Nice catch.
I'll add a reservation at start of day if wa is needed when I issue v4.

> 
> Need to continue reviewing this patchnext week.
> 
> 
> Thx,
> 
> Thomas
> 
> 
> 
> 
>> -
>> -    mutex_lock(&i915->mm.stolen_lock);
>> -    ret = drm_mm_insert_node_in_range(&i915->mm.stolen, node,
>> -                      size, alignment, 0,
>> -                      start, end, DRM_MM_INSERT_BEST);
>> -    mutex_unlock(&i915->mm.stolen_lock);
>> +    if (!mem)
>> +        return ERR_PTR(-ENODEV);
>> +    return intel_region_ttm_resource_alloc(mem, size, start, end, 
>> I915_BO_ALLOC_CONTIGUOUS);
>> +}
>> -
