Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E05312E1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiEWPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiEWPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:52:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9204C26570
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:52:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 31D9D1F43999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653321153;
        bh=BRBPt5ET+rgbs/sHyY5rXpb/IZ19k3OSJSYokuIVcs0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jTvwol6+oz4NF7k2PhH1jAJ5jyaw5XwD8cy6AmK2OWiXXd/5G4WjhHoMCcKmuymX2
         L0oguiqyOdy498ZoipWwrSIXzQlIOoQe+17mZeIpkYVdRvhEjY4P1rWL8pAELoUggR
         K444h8gjnmfUFKV33eeO9cMhQ9MLR/Z0iRQ/wDEAN4jneEJPrXG8PYdPOOivurDvbT
         AizH9y/wmOmPDiGADNsIcUWxj20eQaSBG0z1p/bLEt2pREZCZRnvvVpezfChPosxZq
         GFGWA0t2kdCdYKGT4yjB6d4+uCuw5Yh2JHZn+O7lVdOXnVIoq6R3s5s02ffWJ4E0zg
         XrTU5+dJoSe8g==
Message-ID: <bafcfe8f-3a19-a01c-8b46-9f2a44b1553c@collabora.com>
Date:   Mon, 23 May 2022 16:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] drm/i915: add gen6 ppgtt dummy creation function
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
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
 <20220503191316.1145124-2-bob.beckett@collabora.com>
 <3d08eb595c4a4eff02be5385c82d1e1d0e781c98.camel@linux.intel.com>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <3d08eb595c4a4eff02be5385c82d1e1d0e781c98.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2022 11:13, Thomas Hellström wrote:
> Hi,
> 
> On Tue, 2022-05-03 at 19:13 +0000, Robert Beckett wrote:
>> Internal gem objects will soon just be volatile system memory region
>> objects.
>> To enable this, create a separate dummy object creation function
>> for gen6 ppgtt
> 
> 
> It's not clear from the commit message why we need a special case for
> this. Could you describe more in detail?

it always was a special case, that used the internal backend but 
provided it's own ops, so actually had no benefit from using the 
internal backend. See b0b0f2d225da6fe58417fae37e3f797e2db27b62

I'll add some further explanation in the commit message for v2.

> 
> Thanks,
> Thomas
> 
> 
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> ---
>>   drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 43
>> ++++++++++++++++++++++++++--
>>   1 file changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> index 1bb766c79dcb..f3b660cfeb7f 100644
>> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> @@ -372,6 +372,45 @@ static const struct drm_i915_gem_object_ops
>> pd_dummy_obj_ops = {
>>          .put_pages = pd_dummy_obj_put_pages,
>>   };
>>   
>> +static struct drm_i915_gem_object *
>> +i915_gem_object_create_dummy(struct drm_i915_private *i915,
>> phys_addr_t size)
>> +{
>> +       static struct lock_class_key lock_class;
>> +       struct drm_i915_gem_object *obj;
>> +       unsigned int cache_level;
>> +
>> +       GEM_BUG_ON(!size);
>> +       GEM_BUG_ON(!IS_ALIGNED(size, PAGE_SIZE));
>> +
>> +       if (overflows_type(size, obj->base.size))
>> +               return ERR_PTR(-E2BIG);
>> +
>> +       obj = i915_gem_object_alloc();
>> +       if (!obj)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       drm_gem_private_object_init(&i915->drm, &obj->base, size);
>> +       i915_gem_object_init(obj, &pd_dummy_obj_ops, &lock_class, 0);
>> +       obj->mem_flags |= I915_BO_FLAG_STRUCT_PAGE;
>> +
>> +       /*
>> +        * Mark the object as volatile, such that the pages are
>> marked as
>> +        * dontneed whilst they are still pinned. As soon as they are
>> unpinned
>> +        * they are allowed to be reaped by the shrinker, and the
>> caller is
>> +        * expected to repopulate - the contents of this object are
>> only valid
>> +        * whilst active and pinned.
>> +        */
>> +       i915_gem_object_set_volatile(obj);
>> +
>> +       obj->read_domains = I915_GEM_DOMAIN_CPU;
>> +       obj->write_domain = I915_GEM_DOMAIN_CPU;
>> +
>> +       cache_level = HAS_LLC(i915) ? I915_CACHE_LLC :
>> I915_CACHE_NONE;
>> +       i915_gem_object_set_cache_coherency(obj, cache_level);
>> +
>> +       return obj;
>> +}
>> +
>>   static struct i915_page_directory *
>>   gen6_alloc_top_pd(struct gen6_ppgtt *ppgtt)
>>   {
>> @@ -383,9 +422,7 @@ gen6_alloc_top_pd(struct gen6_ppgtt *ppgtt)
>>          if (unlikely(!pd))
>>                  return ERR_PTR(-ENOMEM);
>>   
>> -       pd->pt.base = __i915_gem_object_create_internal(ppgtt-
>>> base.vm.gt->i915,
>> -
>>                                                         &pd_dummy_obj_o
>> ps,
>> -                                                       I915_PDES *
>> SZ_4K);
>> +       pd->pt.base = i915_gem_object_create_dummy(ppgtt->base.vm.gt-
>>> i915, I915_PDES * SZ_4K);
>>          if (IS_ERR(pd->pt.base)) {
>>                  err = PTR_ERR(pd->pt.base);
>>                  pd->pt.base = NULL;
> 
> 
