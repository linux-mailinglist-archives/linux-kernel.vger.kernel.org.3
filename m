Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9569B4B85EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiBPKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:33:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPKdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:33:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83552B0B14;
        Wed, 16 Feb 2022 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645007619; x=1676543619;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=0EU2xKs5/be5ABCYsSQiiugsjJ0zBzNPzGsy9hvHN5k=;
  b=DzsbVIDBAlYKciujwIhe2+EilIPILebVDzsnb4+kwmSfzv5s2EVsxBh0
   nLP/M0EQI6HoPDaYTl9yOZx0HC4SgDIUMq6fEfQ1OdVHoQ4FeA+e0Fb43
   u3defYrG4RkTh3IwwLxEeJhUo+27FVMhK5EU+tHZAmAHVX2ZxYD+HzU1U
   5iKlRFDWMh7Zc3V8reUm1QmvWuJsnJtrIW2pRQrOAA+oL/Tq549obAv5H
   0S+AVyIjooY/s8w7++8pn8dwQks7NDTb5/PekBdLk1DyPIKQVU8+eixN+
   sKTT7SDso8zoaNjTdD599Y5kjXIvLkAkEUL9tkwJ/zKIc1Dyi3AG6dffg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275156373"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="275156373"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 02:33:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="502968616"
Received: from rbilei-mobl.ger.corp.intel.com (HELO localhost) ([10.252.13.113])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 02:33:35 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?utf-8?B?U3ly?= =?utf-8?B?asOkbMOk?= 
        <ville.syrjala@linux.intel.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        rodrigo.vivi@intel.com, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: fix unsigned integer to signed assignment
In-Reply-To: <9a7b0e48-b00f-be11-7fc7-bc26719cbc1e@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220216083849.91239-1-jiapeng.chong@linux.alibaba.com>
 <87h78z5gmp.fsf@intel.com> <YgzBpX2SKCh4cb19@intel.com>
 <9a7b0e48-b00f-be11-7fc7-bc26719cbc1e@linux.intel.com>
Date:   Wed, 16 Feb 2022 12:33:30 +0200
Message-ID: <87leyb3xtx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> On 16/02/2022 09:19, Ville Syrj=C3=A4l=C3=A4 wrote:
>> On Wed, Feb 16, 2022 at 11:02:06AM +0200, Jani Nikula wrote:
>>> On Wed, 16 Feb 2022, Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wr=
ote:
>>>> Eliminate the follow smatch warning:
>>>>
>>>> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4640
>>>> guc_create_virtual() warn: assigning (-2) to unsigned variable
>>>> 've->base.instance'.
>>>>
>>>> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4641
>>>> guc_create_virtual() warn: assigning (-2) to unsigned variable
>>>> 've->base.uabi_instance'.
>>>>
>>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>>
>>> The report seems to be valid, but I don't think this is the fix.
>>>
>>> Where do we even check for invalid instance/uabi_instance in code?
>>=20
>> The whole thing seems rather poorly documented as there's a matching
>> uabi struct with __u16's and the negative values are defined right
>> there in the uapi header as well.
>
> Negative ones are exception values to be used in conjunction with the vir=
tual engine uapi (see "DOC: Virtual Engine uAPI" and also comment next to I=
915_CONTEXT_PARAM_ENGINES).
>
> AFAIK assigning negative int to unsigned int is defined and fine.
>
> Compiler does warn on comparisons which is why we have:
>
> ./gem/i915_gem_busy.c:  if (id =3D=3D (u16)I915_ENGINE_CLASS_INVALID)
> ./gem/i915_gem_busy.c:  if (id =3D=3D (u16)I915_ENGINE_CLASS_INVALID)
> ./gem/i915_gem_context.c:               if (ci.engine_class =3D=3D (u16)I=
915_ENGINE_CLASS_INVALID &&
> ./gem/i915_gem_context.c:                   ci.engine_instance =3D=3D (u1=
6)I915_ENGINE_CLASS_INVALID_NONE)
>
> So I think no action needed here.

We never check instance or uabi_instance members against
I915_ENGINE_CLASS_INVALID_VIRTUAL anywhere.

BR,
Jani.

>
> Regards,
>
> Tvrtko
>=20=20=20
>>>
>>> BR,
>>> Jani.
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/i915/gt/intel_engine_types.h | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gp=
u/drm/i915/gt/intel_engine_types.h
>>>> index 36365bdbe1ee..dc7cc06c68e7 100644
>>>> --- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
>>>> +++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
>>>> @@ -328,10 +328,10 @@ struct intel_engine_cs {
>>>>   	intel_engine_mask_t logical_mask;
>>>>=20=20=20
>>>>   	u8 class;
>>>> -	u8 instance;
>>>> +	s8 instance;
>>>>=20=20=20
>>>>   	u16 uabi_class;
>>>> -	u16 uabi_instance;
>>>> +	s16 uabi_instance;
>>>>=20=20=20
>>>>   	u32 uabi_capabilities;
>>>>   	u32 context_size;
>>>
>>> --=20
>>> Jani Nikula, Intel Open Source Graphics Center
>>=20

--=20
Jani Nikula, Intel Open Source Graphics Center
