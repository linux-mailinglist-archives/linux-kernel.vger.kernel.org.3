Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE6519F07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349340AbiEDMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbiEDMPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:15:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903A18359
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651666305; x=1683202305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C+h/rftgRKdb1i6UwOq/0z1PcO5ClpbUoFCjucqM6iM=;
  b=b9vyzU702BQBjYGPYhR78vS9scTbj85n06nPWMXMP8FNFDEE7WiedUcp
   PCI6qDMezGOzvqoY4eg/LZMsDNJoHDDgHR229jyHL/lwqYGWZdl8QUSoa
   /TV4pXcz0ruMS55TY7cOz6I7m8lxeVNDzQ6aH2mygEPH9FODHPBro8mxu
   tXRYWuXhZiVL69m07ZeH3esJ3PVk0nyTIYj66cNZLGOBku9BC8cM6AmEF
   q7i5cS2f3BklGYr0tZTDNLqLckoLOgrAVbvUxen3QUpo8EbId7Qmq2PXf
   ZkrhIoDvUWk3lmdnzAB81pns6sc1vJtGoX17leX4DJuaHKBGgsGX/QRtW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354184868"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="354184868"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:11:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="664444001"
Received: from gidaly-mobl1.ger.corp.intel.com (HELO [10.213.236.183]) ([10.213.236.183])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:11:43 -0700
Message-ID: <ab578c17-faa6-222f-f37e-d5cd4f45dfd0@linux.intel.com>
Date:   Wed, 4 May 2022 13:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/i915: use IOMEM_ERR_PTR() directly
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220502034328.78486-1-wangkefeng.wang@huawei.com>
 <87h768s5f5.fsf@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <87h768s5f5.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/05/2022 09:30, Jani Nikula wrote:
> On Mon, 02 May 2022, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Use IOMEM_ERR_PTR() instead of self defined IO_ERR_PTR().
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Pushed to drm-intel-gt-next, thanks for the patch and review!

Regards,

Tvrtko

> 
>> ---
>>   drivers/gpu/drm/i915/i915_vma.c | 4 ++--
>>   drivers/gpu/drm/i915/i915_vma.h | 1 -
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
>> index 94fcdb7bd21d..639605c89b7b 100644
>> --- a/drivers/gpu/drm/i915/i915_vma.c
>> +++ b/drivers/gpu/drm/i915/i915_vma.c
>> @@ -541,7 +541,7 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
>>   	int err;
>>   
>>   	if (WARN_ON_ONCE(vma->obj->flags & I915_BO_ALLOC_GPU_ONLY))
>> -		return IO_ERR_PTR(-EINVAL);
>> +		return IOMEM_ERR_PTR(-EINVAL);
>>   
>>   	if (!i915_gem_object_is_lmem(vma->obj)) {
>>   		if (GEM_WARN_ON(!i915_vma_is_map_and_fenceable(vma))) {
>> @@ -594,7 +594,7 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
>>   err_unpin:
>>   	__i915_vma_unpin(vma);
>>   err:
>> -	return IO_ERR_PTR(err);
>> +	return IOMEM_ERR_PTR(err);
>>   }
>>   
>>   void i915_vma_flush_writes(struct i915_vma *vma)
>> diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
>> index 67ae7341c7e0..8e74972fdca3 100644
>> --- a/drivers/gpu/drm/i915/i915_vma.h
>> +++ b/drivers/gpu/drm/i915/i915_vma.h
>> @@ -331,7 +331,6 @@ static inline bool i915_node_color_differs(const struct drm_mm_node *node,
>>    * Returns a valid iomapped pointer or ERR_PTR.
>>    */
>>   void __iomem *i915_vma_pin_iomap(struct i915_vma *vma);
>> -#define IO_ERR_PTR(x) ((void __iomem *)ERR_PTR(x))
>>   
>>   /**
>>    * i915_vma_unpin_iomap - unpins the mapping returned from i915_vma_iomap
> 
