Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968059BE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiHVLCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHVLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:02:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D631DF2;
        Mon, 22 Aug 2022 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661166128; x=1692702128;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ZDyXoOKFLsJWDZrI4atkglbvrUUdtWkTh1x2BJ1kAgI=;
  b=cgjFHuUIhA+Ge5rLWhS++6HozXbx4k8D0O2DeY2XoTE4BxXAvtG78d9x
   nCZpPOTmXKg2JZJxuQBsXmkREpzXCl2gyOatcdTwSBfhNdieNZGdj1AZb
   jhsDKuHbIev4nN6Nic40meGw4fGJbE4rsqs+SkGJVClkHGto4dWcb74gd
   kuQ9nnmBmcOMl88KIRBl4fAmmknSQloKIk5TEZN3BYAL+aJ2U13sTz4+P
   +ZL1NEYbg0rGxbqsq6qaQc2eHvoRUSXMBz0kVX1oVshYOGLXIUJM3xV8I
   fjHXy7LxaMrp8TmESQLzPrui2bCMx5rqIhzfIQV1zLZmWv8komfrwEMJE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="280355115"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="280355115"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 04:02:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="669489583"
Received: from trangnek-mobl.gar.corp.intel.com (HELO localhost) ([10.252.50.159])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 04:02:03 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, nirmoy.das@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, andrzej.hajda@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/8] overflow: Move and add few utility macros into
 overflow
In-Reply-To: <202208171657.63AE7AC@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
 <20220816093525.184940-2-gwan-gyeong.mun@intel.com>
 <Yv10sQADwdZrIV42@alfio.lan> <202208171657.63AE7AC@keescook>
Date:   Mon, 22 Aug 2022 14:02:01 +0300
Message-ID: <87r118mthy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Aug 18, 2022 at 01:07:29AM +0200, Andi Shyti wrote:
>> Hi Kees,
>>=20
>> would you mind taking a look at this patch?
>
> Hi! Thanks for the heads-up!

Thanks for your review. This actually reaffirms my belief that we need
to get these macros out of i915_utils.h and into the common headers,
where we can get more eyes on them.

BR,
Jani.


>
>>=20
>> Thanks,
>> Andi
>>=20
>> On Tue, Aug 16, 2022 at 06:35:18PM +0900, Gwan-gyeong Mun wrote:
>> > It moves overflows_type utility macro into overflow header from i915_u=
tils
>> > header. The overflows_type can be used to catch the truncation between=
 data
>> > types. And it adds safe_conversion() macro which performs a type conve=
rsion
>> > (cast) of an source value into a new variable, checking that the
>> > destination is large enough to hold the source value. And the function=
ality
>> > of overflows_type has been improved to handle the signbit.
>> > The is_unsigned_type macro has been added to check the sign bit of the
>> > built-in type.
>> >=20
>> > v3: Add is_type_unsigned() macro (Mauro)
>> >     Modify overflows_type() macro to consider signed data types (Mauro)
>> >     Fix the problem that safe_conversion() macro always returns true
>> > v4: Fix kernel-doc markups
>> > v6: Move macro addition location so that it can be used by other than =
drm
>> >     subsystem (Jani, Mauro, Andi)
>> >     Change is_type_unsigned to is_unsigned_type to have the same name =
form
>> >     as is_signed_type macro
>> >=20
>> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
>> > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>> > Cc: Matthew Auld <matthew.auld@intel.com>
>> > Cc: Nirmoy Das <nirmoy.das@intel.com>
>> > Cc: Jani Nikula <jani.nikula@intel.com>
>> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
>> > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
>> > ---
>> >  drivers/gpu/drm/i915/i915_utils.h |  5 +--
>> >  include/linux/overflow.h          | 54 +++++++++++++++++++++++++++++++
>> >  2 files changed, 55 insertions(+), 4 deletions(-)
>> >=20
>> > diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/=
i915_utils.h
>> > index c10d68cdc3ca..eb0ded23fa9c 100644
>> > --- a/drivers/gpu/drm/i915/i915_utils.h
>> > +++ b/drivers/gpu/drm/i915/i915_utils.h
>> > @@ -32,6 +32,7 @@
>> >  #include <linux/types.h>
>> >  #include <linux/workqueue.h>
>> >  #include <linux/sched/clock.h>
>> > +#include <linux/overflow.h>
>> >=20=20
>> >  #ifdef CONFIG_X86
>> >  #include <asm/hypervisor.h>
>> > @@ -111,10 +112,6 @@ bool i915_error_injected(void);
>> >  #define range_overflows_end_t(type, start, size, max) \
>> >  	range_overflows_end((type)(start), (type)(size), (type)(max))
>> >=20=20
>> > -/* Note we don't consider signbits :| */
>> > -#define overflows_type(x, T) \
>> > -	(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
>> > -
>> >  #define ptr_mask_bits(ptr, n) ({					\
>> >  	unsigned long __v =3D (unsigned long)(ptr);			\
>> >  	(typeof(ptr))(__v & -BIT(n));					\
>> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> > index f1221d11f8e5..462a03454377 100644
>> > --- a/include/linux/overflow.h
>> > +++ b/include/linux/overflow.h
>> > @@ -35,6 +35,60 @@
>> >  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T=
)))
>> >  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
>> >=20=20
>> > +/**
>> > + * is_unsigned_type - helper for checking data type which is an unsig=
ned data
>> > + * type or not
>> > + * @x: The data type to check
>> > + *
>> > + * Returns:
>> > + * True if the data type is an unsigned data type, false otherwise.
>> > + */
>> > +#define is_unsigned_type(x) ((typeof(x))-1 >=3D (typeof(x))0)
>
> I'd rather not have separate logic for this. Instead, I'd like it to be:
>
> #define is_unsigned_type(x) (!is_signed_type(x))
>
>> > +
>> > +/**
>> > + * overflows_type - helper for checking the truncation between data t=
ypes
>> > + * @x: Source for overflow type comparison
>> > + * @T: Destination for overflow type comparison
>> > + *
>> > + * It compares the values and size of each data type between the firs=
t and
>> > + * second argument to check whether truncation can occur when assigni=
ng the
>> > + * first argument to the variable of the second argument.
>> > + * Source and Destination can be used with or without sign bit.
>> > + * Composite data structures such as union and structure are not cons=
idered.
>> > + * Enum data types are not considered.
>> > + * Floating point data types are not considered.
>> > + *
>> > + * Returns:
>> > + * True if truncation can occur, false otherwise.
>> > + */
>> > +#define overflows_type(x, T) \
>> > +	(is_unsigned_type(x) ? \
>> > +		is_unsigned_type(T) ? \
>> > +			(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
>> > +			: (sizeof(x) >=3D sizeof(T) && (x) >> (BITS_PER_TYPE(T) - 1)) ? 1 =
: 0 \
>> > +	: is_unsigned_type(T) ? \
>> > +		((x) < 0) ? 1 : (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) =
? 1 : 0 \
>> > +		: (sizeof(x) > sizeof(T)) ? \
>> > +			((x) < 0) ? (((x) * -1) >> BITS_PER_TYPE(T)) ? 1 : 0 \
>> > +				: ((x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
>> > +			: 0)
>
> Like the other, I'd much rather this was rephrased in terms of the
> existing macros (e.g. type_min()/type_max().)
>
>> > +
>> > +/**
>> > + * safe_conversion - perform a type conversion (cast) of an source va=
lue into
>> > + * a new variable, checking that the destination is large enough to h=
old the
>> > + * source value.
>> > + * @ptr: Destination pointer address
>> > + * @value: Source value
>> > + *
>> > + * Returns:
>> > + * If the value would overflow the destination, it returns false.
>> > + */
>> > +#define safe_conversion(ptr, value) ({ \
>> > +	typeof(value) __v =3D (value); \
>> > +	typeof(ptr) __ptr =3D (ptr); \
>> > +	overflows_type(__v, *__ptr) ? 0 : ((*__ptr =3D (typeof(*__ptr))__v),=
 1); \
>> > +})
>
> I try to avoid "safe" as an adjective for interface names, since it
> doesn't really answer "safe from what?" This looks more like "assign, but
> zero when out of bounds". And it can be built from existing macros here:
>
> 	if (check_add_overflow(0, value, ptr))
> 		*ptr =3D 0;
>
> I actually want to push back on this a bit, because there can still be
> logic bugs built around this kind of primitive. Shouldn't out-of-bounds
> assignments be seen as a direct failure? I would think this would be
> sufficient:
>
> #define check_assign(value, ptr)	check_add_overflow(0, value, ptr)
>
> And callers would do:
>
> 	if (check_assign(value, &var))
> 		return -EINVAL;
>
> etc.

--=20
Jani Nikula, Intel Open Source Graphics Center
