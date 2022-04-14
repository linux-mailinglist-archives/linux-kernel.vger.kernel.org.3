Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D05018C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiDNQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiDNQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:37:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E5F9F9E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:07:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 682F01F47BE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649952448;
        bh=Iek+toYCvXLe1eOTOtIkFNeoWkFZlRKogy0n340asiA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H5sP3u2ittdXz4vA6z0mQpfkiKT5+a37TwykspSQgu3DZjC7Dv0Z2Pj7sq6X9TKbE
         +lzpdz21l0SSMTI/BpxhImBrAP3v+mByNlwS3onEqGLKtfheYXuWfUlzIC2Qt16HTQ
         MlqcifTu9Yz9KPYRKpvSBp/0iegrQrodj1RVfBtD6FwOv2klSE4MIAN8EdiefiEl2e
         AgbETo469gAbb2qXgkzGIqFHY1JZ1a7z+ehID6zhBoEpcn2b28BxqKuGv3VBXWWTSR
         wBABSvihWog65lHHGEczZnxNbJBvtkTxEu14zKnCSOtye5uYVogp13FtbVvBmwvQ/c
         XFHud1nzBDh1Q==
Message-ID: <cc56e644-f20f-27ae-7a21-e40c173dfe1e@collabora.com>
Date:   Thu, 14 Apr 2022 17:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/5] drm/i915: ttm backend dont provide mmap_offset for
 kernel buffers
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
References: <20220412151838.1298956-1-bob.beckett@collabora.com>
 <20220412151838.1298956-5-bob.beckett@collabora.com>
 <07e5b1dc442e0b318ee0314f90a433216ed38dcb.camel@linux.intel.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <07e5b1dc442e0b318ee0314f90a433216ed38dcb.camel@linux.intel.com>
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



On 14/04/2022 15:05, Thomas Hellström wrote:
> On Tue, 2022-04-12 at 15:18 +0000, Robert Beckett wrote:
>> stolen/kernel buffers should not be mmapable by userland.
>> do not provide callbacks to facilitate this for these buffers.
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 32 +++++++++++++++++++++--
>> --
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> index a878910a563c..b20f81836c54 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> @@ -1092,8 +1092,8 @@ static void i915_ttm_unmap_virtual(struct
>> drm_i915_gem_object *obj)
>>          ttm_bo_unmap_virtual(i915_gem_to_ttm(obj));
>>   }
>>   
>> -static const struct drm_i915_gem_object_ops i915_gem_ttm_obj_ops = {
>> -       .name = "i915_gem_object_ttm",
>> +static const struct drm_i915_gem_object_ops
>> i915_gem_ttm_user_obj_ops = {
>> +       .name = "i915_gem_object_ttm_user",
>>          .flags = I915_GEM_OBJECT_IS_SHRINKABLE |
>>                   I915_GEM_OBJECT_SELF_MANAGED_SHRINK_LIST,
>>   
>> @@ -1111,6 +1111,21 @@ static const struct drm_i915_gem_object_ops
>> i915_gem_ttm_obj_ops = {
>>          .mmap_ops = &vm_ops_ttm,
>>   };
>>   
>> +static const struct drm_i915_gem_object_ops
>> i915_gem_ttm_kern_obj_ops = {
>> +       .name = "i915_gem_object_ttm_kern",
>> +       .flags = I915_GEM_OBJECT_IS_SHRINKABLE |
>> +                I915_GEM_OBJECT_SELF_MANAGED_SHRINK_LIST,
>> +
>> +       .get_pages = i915_ttm_get_pages,
>> +       .put_pages = i915_ttm_put_pages,
>> +       .truncate = i915_ttm_truncate,
>> +       .shrink = i915_ttm_shrink,
>> +
>> +       .adjust_lru = i915_ttm_adjust_lru,
>> +       .delayed_free = i915_ttm_delayed_free,
>> +       .migrate = i915_ttm_migrate,
>> +};
> 
> Do we really need two different ops here?
> 
> Since if we don't have mmap ops, basically that tells GEM it should do
> the mmapping rather than TTM.
> 
> That might of course come in handy for the shmem backend, but I don't
> fully follow why we need this for stolen.

the main rationale for doing this was to avoid 
drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c:can_mmap() presuming 
that is can use I915_MMAP_TYPE_FIXED

As the original backend also did not have mmap_offset handlers for 
stolen, this seemed like a reasonable design.

If desired, we could add a special case for the testing logic, but those 
special cases have tendency to multiply.

> 
> Also for the framebuffer handed over from BIOS to fbdev, Does that need
> mmapping and if so, how do we handle that?
> 

I'm not sure of the usecase there. Do you know of any igt test that 
tests this? I can investigate further if you do not.

> 
> /Thomas
> 
> 
> 
> 
>> +
>>   void i915_ttm_bo_destroy(struct ttm_buffer_object *bo)
>>   {
>>          struct drm_i915_gem_object *obj = i915_ttm_to_gem(bo);
>> @@ -1165,10 +1180,19 @@ int __i915_gem_ttm_object_init(struct
>> intel_memory_region *mem,
>>                  .no_wait_gpu = false,
>>          };
>>          enum ttm_bo_type bo_type;
>> +       const struct drm_i915_gem_object_ops *ops;
>>          int ret;
>>   
>>          drm_gem_private_object_init(&i915->drm, &obj->base, size);
>> -       i915_gem_object_init(obj, &i915_gem_ttm_obj_ops, &lock_class,
>> flags);
>> +
>> +       if (flags & I915_BO_ALLOC_USER &&
>> intel_region_to_ttm_type(mem) != I915_PL_STOLEN) {
>> +               bo_type = ttm_bo_type_device;
>> +               ops = &i915_gem_ttm_user_obj_ops;
>> +       } else {
>> +               bo_type = ttm_bo_type_kernel;
>> +               ops = &i915_gem_ttm_kern_obj_ops;
>> +       }
>> +       i915_gem_object_init(obj, ops, &lock_class, flags);
>>   
>>          obj->bo_offset = offset;
>>   
>> @@ -1178,8 +1202,6 @@ int __i915_gem_ttm_object_init(struct
>> intel_memory_region *mem,
>>   
>>          INIT_RADIX_TREE(&obj->ttm.get_io_page.radix, GFP_KERNEL |
>> __GFP_NOWARN);
>>          mutex_init(&obj->ttm.get_io_page.lock);
>> -       bo_type = (obj->flags & I915_BO_ALLOC_USER) ?
>> ttm_bo_type_device :
>> -               ttm_bo_type_kernel;
>>   
>>          obj->base.vma_node.driver_private = i915_gem_to_ttm(obj);
>>   
> 
> 
