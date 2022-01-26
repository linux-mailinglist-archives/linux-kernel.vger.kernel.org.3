Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF71749D074
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbiAZRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:11:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41766 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbiAZRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:11:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id CD96B1F44B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643217104;
        bh=RO++SZG6FjnkZBIG0jzGrluJ5I0kiY9znyoXgcB7fqk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AqkB0Dod17M21vPmHrIrzGXxjhqvbd6OV30vgiDjorsk3ivrJtn5M/iFxZrxbBkGo
         wYjnVxO3Sdg6J4K9nwsjjX/Mq2P/VQMRJlz2OK/QS8Zd6eDY9JyvVHz07rIo2E/vTp
         keZFV+v97/Pv/MlpzULngzqnVL3No56B0e2ooaPfihD+w8pgb3kbTqAfqWnGZTKl+W
         slrfBKhA7yO81dVI2ng44VnE1AFvkLUlmMj+9CvA8YaqETh2ixz+Y09hc/TuST7N2C
         ISo5p74M48l+WeqmX60tJxRpJbMhtL7Z4H79xQW5Jq8DT/xDse2M0477c7iZ0BhCdR
         RsCklmcRszlPw==
Message-ID: <19bf8290-9308-b5c6-eb73-4020fa81aa66@collabora.com>
Date:   Wed, 26 Jan 2022 17:11:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Intel-gfx] [PATCH v5 1/5] drm/i915: add needs_compact_pt flag
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Matthew Auld <matthew.auld@intel.com>
References: <20220125193530.3272386-1-bob.beckett@collabora.com>
 <20220125193530.3272386-2-bob.beckett@collabora.com>
 <6d0a57e7-daf7-6436-e806-7cc8794c2d50@shipmail.org>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <6d0a57e7-daf7-6436-e806-7cc8794c2d50@shipmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2022 13:49, Thomas Hellström (Intel) wrote:
> 
> On 1/25/22 20:35, Robert Beckett wrote:
>> From: Ramalingam C <ramalingam.c@intel.com>
>>
>> Add a new platform flag, needs_compact_pt, to mark the requirement of
>> compact pt layout support for the ppGTT when using 64K GTT pages.
>>
>> With this flag has_64k_pages will only indicate requirement of 64K
>> GTT page sizes or larger for device local memory access.
>>
>> Suggested-by: Matthew Auld <matthew.auld@intel.com>
>> Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> ---
>>   drivers/gpu/drm/i915/i915_drv.h          | 10 +++++++---
>>   drivers/gpu/drm/i915/i915_pci.c          |  2 ++
>>   drivers/gpu/drm/i915/intel_device_info.h |  1 +
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_drv.h 
>> b/drivers/gpu/drm/i915/i915_drv.h
>> index 44c1f98144b4..1258b7779705 100644
>> --- a/drivers/gpu/drm/i915/i915_drv.h
>> +++ b/drivers/gpu/drm/i915/i915_drv.h
>> @@ -1512,12 +1512,16 @@ IS_SUBPLATFORM(const struct drm_i915_private 
>> *i915,
>>   /*
>>    * Set this flag, when platform requires 64K GTT page sizes or 
>> larger for
>> - * device local memory access. Also this flag implies that we require or
>> - * at least support the compact PT layout for the ppGTT when using 
>> the 64K
>> - * GTT pages.
> 
> Why do we remove these comment lines?
Because HAS_64K_PAGES now means just 64K page, it no longer means also 
requires compact pt.
This is to support other products that will have 64K but not have the 
PDE non-sharing restriction in future.

Those lines moved to the next change NEEDS_COMPACT_PT, which is now 
separate.

> 
> 
>> + * device local memory access.
>>    */
>>   #define HAS_64K_PAGES(dev_priv) (INTEL_INFO(dev_priv)->has_64k_pages)
>> +/* Set this flag when platform doesn't allow both 64k pages and 4k 
>> pages in
> 
> First line of multi-line comments should be empty.
thanks. I'm surprised checkpatch didnt spot that.

> 
> 
>> + * the same PT. this flag means we need to support compact PT layout 
>> for the
>> + * ppGTT when using the 64K GTT pages.
>> + */
>> +#define NEEDS_COMPACT_PT(dev_priv) 
>> (INTEL_INFO(dev_priv)->needs_compact_pt)
>> +
>>   #define HAS_IPC(dev_priv)         
>> (INTEL_INFO(dev_priv)->display.has_ipc)
>>   #define HAS_REGION(i915, i) (INTEL_INFO(i915)->memory_regions & (i))
>> diff --git a/drivers/gpu/drm/i915/i915_pci.c 
>> b/drivers/gpu/drm/i915/i915_pci.c
>> index 4081fd50ba9d..799b56569ef5 100644
>> --- a/drivers/gpu/drm/i915/i915_pci.c
>> +++ b/drivers/gpu/drm/i915/i915_pci.c
>> @@ -1028,6 +1028,7 @@ static const struct intel_device_info 
>> xehpsdv_info = {
>>       PLATFORM(INTEL_XEHPSDV),
>>       .display = { },
>>       .has_64k_pages = 1,
>> +    .needs_compact_pt = 1,
>>       .platform_engine_mask =
>>           BIT(RCS0) | BIT(BCS0) |
>>           BIT(VECS0) | BIT(VECS1) | BIT(VECS2) | BIT(VECS3) |
>> @@ -1045,6 +1046,7 @@ static const struct intel_device_info dg2_info = {
>>       .media.rel = 55,
>>       PLATFORM(INTEL_DG2),
>>       .has_64k_pages = 1,
>> +    .needs_compact_pt = 1,
>>       .platform_engine_mask =
>>           BIT(RCS0) | BIT(BCS0) |
>>           BIT(VECS0) | BIT(VECS1) |
>> diff --git a/drivers/gpu/drm/i915/intel_device_info.h 
>> b/drivers/gpu/drm/i915/intel_device_info.h
>> index 3699b1c539ea..c8aaf646430c 100644
>> --- a/drivers/gpu/drm/i915/intel_device_info.h
>> +++ b/drivers/gpu/drm/i915/intel_device_info.h
>> @@ -130,6 +130,7 @@ enum intel_ppgtt_type {
>>       /* Keep has_* in alphabetical order */ \
>>       func(has_64bit_reloc); \
>>       func(has_64k_pages); \
>> +    func(needs_compact_pt); \
>>       func(gpu_reset_clobbers_display); \
>>       func(has_reset_engine); \
>>       func(has_global_mocs); \
