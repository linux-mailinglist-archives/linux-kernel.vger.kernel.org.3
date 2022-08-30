Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5375A661B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiH3OUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiH3OUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:20:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46AB205CF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661869208; x=1693405208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q5CiVRTxmcdYwTAbxj4zEN5oFJVR+6F1H4CdYSPrAWk=;
  b=ly+Z6GLakLTB7/N/k2cb3DSDV87wueWWNmH0jj0fBTVhXxJr7peYQkly
   O+WzOlQBnKAq1awaTb1tjP6eC604Pj6c/Q4n54CO8jDIUqV/UJ048GwWk
   fjCn0oKn+4Vmefasw0wh0bSVnuxZyXqXd7GJJDGcFxfhAH61fOTkNHIk7
   WClzY+yjVvHMXjEPbvCl7H4ed86jRZo0eK3t2ACnmEWqbqM13E9PiZSdb
   khQ+Yu/QzEbIjDTtSLxkhXRrNGXq+cussZUgiVQG0JfUe/ez3R3uFi4av
   baO6v/NUB7Wj3T0v0ZnVIog8YqKv99N8UEC6/5k/lKAr3TOGLeLGQGm0k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="356901220"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="356901220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 07:19:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="641391538"
Received: from mkeane-mobl.ger.corp.intel.com (HELO [10.213.199.160]) ([10.213.199.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 07:19:36 -0700
Message-ID: <c72237bc-79e1-1341-2f3f-3ab6a871b8c6@linux.intel.com>
Date:   Tue, 30 Aug 2022 15:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] drm/i915: Fix random -ENOSPC eviction errors due to
 locked vma objects
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Sviatoslav Peleshko <sviatoslav.peleshko@globallogic.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220817065541.30101-1-sviatoslav.peleshko@globallogic.com>
 <49c1adc00bdd7aba3d3ffd1ed5e53de2d7d5f1a1.camel@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <49c1adc00bdd7aba3d3ffd1ed5e53de2d7d5f1a1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/08/2022 08:34, Thomas Hellström wrote:
> On Wed, 2022-08-17 at 09:55 +0300, Sviatoslav Peleshko wrote:
>> The i915_gem_object_trylock we had in the grab_vma() makes it return
>> false
>> when the vma->obj is already locked. In this case we'll skip this vma
>> during eviction, and eventually might be forced to return -ENOSPC
>> even
>> though we could've evicted this vma if we waited for the lock a bit.
>>
>> To fix this, replace the i915_gem_object_trylock with
>> i915_gem_object_lock.
>> And because we have to worry about the potential deadlock now,
>> bubble-up
>> the error code, so it will be correctly handled by the WW mechanism.
>>
>> This fixes the issue
>> https://gitlab.freedesktop.org/drm/intel/-/issues/6564
>>
>> Fixes: 7e00897be8bf ("drm/i915: Add object locking to
>> i915_gem_evict_for_node and i915_gem_evict_something, v2.")
>> Signed-off-by: Sviatoslav Peleshko
>> <sviatoslav.peleshko@globallogic.com>
>> ---
>>   drivers/gpu/drm/i915/i915_gem_evict.c | 69 ++++++++++++++++++-------
>> --
>>   1 file changed, 46 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_gem_evict.c
>> b/drivers/gpu/drm/i915/i915_gem_evict.c
>> index f025ee4fa526..9d43f213f68f 100644
>> --- a/drivers/gpu/drm/i915/i915_gem_evict.c
>> +++ b/drivers/gpu/drm/i915/i915_gem_evict.c
>> @@ -55,49 +55,58 @@ static int ggtt_flush(struct intel_gt *gt)
>>          return intel_gt_wait_for_idle(gt, MAX_SCHEDULE_TIMEOUT);
>>   }
>>   
>> -static bool grab_vma(struct i915_vma *vma, struct i915_gem_ww_ctx
>> *ww)
>> +static int grab_vma(struct i915_vma *vma, struct i915_gem_ww_ctx
>> *ww)
>>   {
>> +       int ret = 0;
>> +
>>          /*
>>           * We add the extra refcount so the object doesn't drop to
>> zero until
>>           * after ungrab_vma(), this way trylock is always paired with
>> unlock.
>>           */
>>          if (i915_gem_object_get_rcu(vma->obj)) {
>> -               if (!i915_gem_object_trylock(vma->obj, ww)) {
>> +               ret = i915_gem_object_lock(vma->obj, ww);
> 
> Isn't the vm->mutex held here? If so, then this would be a lockdep
> violation.

Hm.. could the trylock site use a comment exaplaining the reasoning? Ie. 
trylock not just skipping "busy" objects but truly unavoidable?

Regardless, is the analysis on the spot and are we working on fixing in 
somehow?

Regards,

Tvrtko

> 
> /Thomas
> 
> 
> 
> 
>> +               if (ret)
>>                          i915_gem_object_put(vma->obj);
>> -                       return false;
>> -               }
>>          } else {
>>                  /* Dead objects don't need pins */
>>                  atomic_and(~I915_VMA_PIN_MASK, &vma->flags);
>>          }
>>   
>> -       return true;
>> +       return ret;
>>   }
>>   
>> -static void ungrab_vma(struct i915_vma *vma)
>> +static void ungrab_vma(struct i915_vma *vma, struct i915_gem_ww_ctx
>> *ww)
>>   {
>>          if (dying_vma(vma))
>>                  return;
>>   
>> -       i915_gem_object_unlock(vma->obj);
>> +       if (!ww)
>> +               i915_gem_object_unlock(vma->obj);
>> +
>>          i915_gem_object_put(vma->obj);
>>   }
>>   
>> -static bool
>> +static int
>>   mark_free(struct drm_mm_scan *scan,
>>            struct i915_gem_ww_ctx *ww,
>>            struct i915_vma *vma,
>>            unsigned int flags,
>>            struct list_head *unwind)
>>   {
>> +       int err;
>> +
>>          if (i915_vma_is_pinned(vma))
>> -               return false;
>> +               return -ENOSPC;
>>   
>> -       if (!grab_vma(vma, ww))
>> -               return false;
>> +       err = grab_vma(vma, ww);
>> +       if (err)
>> +               return err;
>>   
>>          list_add(&vma->evict_link, unwind);
>> -       return drm_mm_scan_add_block(scan, &vma->node);
>> +       if (!drm_mm_scan_add_block(scan, &vma->node))
>> +               return -ENOSPC;
>> +
>> +       return 0;
>>   }
>>   
>>   static bool defer_evict(struct i915_vma *vma)
>> @@ -150,6 +159,7 @@ i915_gem_evict_something(struct
>> i915_address_space *vm,
>>          enum drm_mm_insert_mode mode;
>>          struct i915_vma *active;
>>          int ret;
>> +       int err = 0;
>>   
>>          lockdep_assert_held(&vm->mutex);
>>          trace_i915_gem_evict(vm, min_size, alignment, flags);
>> @@ -210,17 +220,23 @@ i915_gem_evict_something(struct
>> i915_address_space *vm,
>>                          continue;
>>                  }
>>   
>> -               if (mark_free(&scan, ww, vma, flags, &eviction_list))
>> +               err = mark_free(&scan, ww, vma, flags,
>> &eviction_list);
>> +               if (!err)
>>                          goto found;
>> +               if (err == -EDEADLK)
>> +                       break;
>>          }
>>   
>>          /* Nothing found, clean up and bail out! */
>>          list_for_each_entry_safe(vma, next, &eviction_list,
>> evict_link) {
>>                  ret = drm_mm_scan_remove_block(&scan, &vma->node);
>>                  BUG_ON(ret);
>> -               ungrab_vma(vma);
>> +               ungrab_vma(vma, ww);
>>          }
>>   
>> +       if (err == -EDEADLK)
>> +               return err;
>> +
>>          /*
>>           * Can we unpin some objects such as idle hw contents,
>>           * or pending flips? But since only the GGTT has global
>> entries
>> @@ -267,7 +283,7 @@ i915_gem_evict_something(struct
>> i915_address_space *vm,
>>                          __i915_vma_pin(vma);
>>                  } else {
>>                          list_del(&vma->evict_link);
>> -                       ungrab_vma(vma);
>> +                       ungrab_vma(vma, ww);
>>                  }
>>          }
>>   
>> @@ -277,17 +293,21 @@ i915_gem_evict_something(struct
>> i915_address_space *vm,
>>                  __i915_vma_unpin(vma);
>>                  if (ret == 0)
>>                          ret = __i915_vma_unbind(vma);
>> -               ungrab_vma(vma);
>> +               ungrab_vma(vma, ww);
>>          }
>>   
>>          while (ret == 0 && (node = drm_mm_scan_color_evict(&scan))) {
>>                  vma = container_of(node, struct i915_vma, node);
>>   
>>                  /* If we find any non-objects (!vma), we cannot evict
>> them */
>> -               if (vma->node.color != I915_COLOR_UNEVICTABLE &&
>> -                   grab_vma(vma, ww)) {
>> -                       ret = __i915_vma_unbind(vma);
>> -                       ungrab_vma(vma);
>> +               if (vma->node.color != I915_COLOR_UNEVICTABLE) {
>> +                       ret = grab_vma(vma, ww);
>> +                       if (!ret) {
>> +                               ret = __i915_vma_unbind(vma);
>> +                               ungrab_vma(vma, ww);
>> +                       } else if (ret != -EDEADLK) {
>> +                               ret = -ENOSPC;
>> +                       }
>>                  } else {
>>                          ret = -ENOSPC;
>>                  }
>> @@ -382,8 +402,11 @@ int i915_gem_evict_for_node(struct
>> i915_address_space *vm,
>>                          break;
>>                  }
>>   
>> -               if (!grab_vma(vma, ww)) {
>> -                       ret = -ENOSPC;
>> +               ret = grab_vma(vma, ww);
>> +               if (ret) {
>> +                       if (ret != -EDEADLK)
>> +                               ret = -ENOSPC;
>> +
>>                          break;
>>                  }
>>   
>> @@ -405,7 +428,7 @@ int i915_gem_evict_for_node(struct
>> i915_address_space *vm,
>>                  if (ret == 0)
>>                          ret = __i915_vma_unbind(vma);
>>   
>> -               ungrab_vma(vma);
>> +               ungrab_vma(vma, ww);
>>          }
>>   
>>          return ret;
> 
