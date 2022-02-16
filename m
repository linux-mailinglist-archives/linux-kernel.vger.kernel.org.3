Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06CE4B8516
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiBPJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:59:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBPJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:59:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A46271E25;
        Wed, 16 Feb 2022 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645005535; x=1676541535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Nl47R+l/Dyorm/plhVMc/vkL37v28gUnjuXNQsPVTw=;
  b=ZyMA/iOQcyX/YLLW5mFjvLJVUSuyvEjB7i6xZLMGD+OpsBnAfIk3logl
   7cfuUC7NSMX3FKCiPHm30t95S0I4hYBc3EY+valOzzlIMFalwKLtizF87
   Excrbz1L04TrDM+IeVCKIOESD5wA6zpQT1N5cVlgD6qpD7P3t7i8eNovr
   ZE5Fv+o7yMZ5rNG1k1Ld5GwR5/zEqCvOnlLy5b+jkh7cdoCJdV+1a2ZYU
   bkIVzedXsqVhwUpPSFabDah2PDWyva+21uSXGtgRwwAtHECO3qxz8XozH
   W7QRxBChc9H2G+yKbwK150uKvMHwqZeNKV3q2cpTA6nosjhV9LpY7MdPk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="237971896"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="237971896"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:57:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="502952891"
Received: from sphadnis-mobl1.amr.corp.intel.com (HELO [10.212.82.113]) ([10.212.82.113])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:57:52 -0800
Message-ID: <9a7b0e48-b00f-be11-7fc7-bc26719cbc1e@linux.intel.com>
Date:   Wed, 16 Feb 2022 09:57:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/i915/gt: fix unsigned integer to signed assignment
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        rodrigo.vivi@intel.com, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
References: <20220216083849.91239-1-jiapeng.chong@linux.alibaba.com>
 <87h78z5gmp.fsf@intel.com> <YgzBpX2SKCh4cb19@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <YgzBpX2SKCh4cb19@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/02/2022 09:19, Ville Syrjälä wrote:
> On Wed, Feb 16, 2022 at 11:02:06AM +0200, Jani Nikula wrote:
>> On Wed, 16 Feb 2022, Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
>>> Eliminate the follow smatch warning:
>>>
>>> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4640
>>> guc_create_virtual() warn: assigning (-2) to unsigned variable
>>> 've->base.instance'.
>>>
>>> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4641
>>> guc_create_virtual() warn: assigning (-2) to unsigned variable
>>> 've->base.uabi_instance'.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>
>> The report seems to be valid, but I don't think this is the fix.
>>
>> Where do we even check for invalid instance/uabi_instance in code?
> 
> The whole thing seems rather poorly documented as there's a matching
> uabi struct with __u16's and the negative values are defined right
> there in the uapi header as well.

Negative ones are exception values to be used in conjunction with the virtual engine uapi (see "DOC: Virtual Engine uAPI" and also comment next to I915_CONTEXT_PARAM_ENGINES).

AFAIK assigning negative int to unsigned int is defined and fine.

Compiler does warn on comparisons which is why we have:

./gem/i915_gem_busy.c:  if (id == (u16)I915_ENGINE_CLASS_INVALID)
./gem/i915_gem_busy.c:  if (id == (u16)I915_ENGINE_CLASS_INVALID)
./gem/i915_gem_context.c:               if (ci.engine_class == (u16)I915_ENGINE_CLASS_INVALID &&
./gem/i915_gem_context.c:                   ci.engine_instance == (u16)I915_ENGINE_CLASS_INVALID_NONE)

So I think no action needed here.

Regards,

Tvrtko
  
>>
>> BR,
>> Jani.
>>
>>
>>> ---
>>>   drivers/gpu/drm/i915/gt/intel_engine_types.h | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
>>> index 36365bdbe1ee..dc7cc06c68e7 100644
>>> --- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
>>> +++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
>>> @@ -328,10 +328,10 @@ struct intel_engine_cs {
>>>   	intel_engine_mask_t logical_mask;
>>>   
>>>   	u8 class;
>>> -	u8 instance;
>>> +	s8 instance;
>>>   
>>>   	u16 uabi_class;
>>> -	u16 uabi_instance;
>>> +	s16 uabi_instance;
>>>   
>>>   	u32 uabi_capabilities;
>>>   	u32 context_size;
>>
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center
> 
