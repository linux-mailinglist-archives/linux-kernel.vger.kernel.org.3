Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9483A5979FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbiHQXIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiHQXH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:07:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF6ABD73;
        Wed, 17 Aug 2022 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660777677; x=1692313677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B2ku+g2Lh8nIXn85bLhrd9BVVlmmBEonw0oahk7ctWU=;
  b=X3Fs0nY7PiTj/FitDd79mgJnHZRwzC14DCrZru3TVfOzPi9JCHfHSSsR
   Vm0s78MXrpbcz5E1g/Xi06+shylx+bqKzT4X/gPSlY+XGs/rPCQHNuLw5
   DSsZzDMolK6zoM2huGvQ/gtT6e3FilIew7otvfnrx0xvKvca3ZWoy/XTE
   6GXgl/LfpGyoEciQt9GG3Wi074GkQZWbSpZsmm1CF1x1bvj557cI4U2qM
   4Q7UcT2UcXcihzsB9VI3MJ9eOZwYm9yAylzzZg/uvFpBGToInpHC/1fMx
   TvOn6N8n5XyYvJ6PC/hApR9xxLwh4Vquhm4EWVAowNXS5yTaN5XmpjQ1F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279587741"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="279587741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:07:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="636570504"
Received: from zivlevy-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.51.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:07:53 -0700
Date:   Thu, 18 Aug 2022 01:07:29 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/8] overflow: Move and add few utility macros into
 overflow
Message-ID: <Yv10sQADwdZrIV42@alfio.lan>
References: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
 <20220816093525.184940-2-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220816093525.184940-2-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

would you mind taking a look at this patch?

Thanks,
Andi

On Tue, Aug 16, 2022 at 06:35:18PM +0900, Gwan-gyeong Mun wrote:
> It moves overflows_type utility macro into overflow header from i915_utils
> header. The overflows_type can be used to catch the truncation between data
> types. And it adds safe_conversion() macro which performs a type conversion
> (cast) of an source value into a new variable, checking that the
> destination is large enough to hold the source value. And the functionality
> of overflows_type has been improved to handle the signbit.
> The is_unsigned_type macro has been added to check the sign bit of the
> built-in type.
> 
> v3: Add is_type_unsigned() macro (Mauro)
>     Modify overflows_type() macro to consider signed data types (Mauro)
>     Fix the problem that safe_conversion() macro always returns true
> v4: Fix kernel-doc markups
> v6: Move macro addition location so that it can be used by other than drm
>     subsystem (Jani, Mauro, Andi)
>     Change is_type_unsigned to is_unsigned_type to have the same name form
>     as is_signed_type macro
> 
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
> ---
>  drivers/gpu/drm/i915/i915_utils.h |  5 +--
>  include/linux/overflow.h          | 54 +++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index c10d68cdc3ca..eb0ded23fa9c 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -32,6 +32,7 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <linux/sched/clock.h>
> +#include <linux/overflow.h>
>  
>  #ifdef CONFIG_X86
>  #include <asm/hypervisor.h>
> @@ -111,10 +112,6 @@ bool i915_error_injected(void);
>  #define range_overflows_end_t(type, start, size, max) \
>  	range_overflows_end((type)(start), (type)(size), (type)(max))
>  
> -/* Note we don't consider signbits :| */
> -#define overflows_type(x, T) \
> -	(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
> -
>  #define ptr_mask_bits(ptr, n) ({					\
>  	unsigned long __v = (unsigned long)(ptr);			\
>  	(typeof(ptr))(__v & -BIT(n));					\
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index f1221d11f8e5..462a03454377 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -35,6 +35,60 @@
>  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
>  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
>  
> +/**
> + * is_unsigned_type - helper for checking data type which is an unsigned data
> + * type or not
> + * @x: The data type to check
> + *
> + * Returns:
> + * True if the data type is an unsigned data type, false otherwise.
> + */
> +#define is_unsigned_type(x) ((typeof(x))-1 >= (typeof(x))0)
> +
> +/**
> + * overflows_type - helper for checking the truncation between data types
> + * @x: Source for overflow type comparison
> + * @T: Destination for overflow type comparison
> + *
> + * It compares the values and size of each data type between the first and
> + * second argument to check whether truncation can occur when assigning the
> + * first argument to the variable of the second argument.
> + * Source and Destination can be used with or without sign bit.
> + * Composite data structures such as union and structure are not considered.
> + * Enum data types are not considered.
> + * Floating point data types are not considered.
> + *
> + * Returns:
> + * True if truncation can occur, false otherwise.
> + */
> +#define overflows_type(x, T) \
> +	(is_unsigned_type(x) ? \
> +		is_unsigned_type(T) ? \
> +			(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> +			: (sizeof(x) >= sizeof(T) && (x) >> (BITS_PER_TYPE(T) - 1)) ? 1 : 0 \
> +	: is_unsigned_type(T) ? \
> +		((x) < 0) ? 1 : (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> +		: (sizeof(x) > sizeof(T)) ? \
> +			((x) < 0) ? (((x) * -1) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> +				: ((x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> +			: 0)
> +
> +/**
> + * safe_conversion - perform a type conversion (cast) of an source value into
> + * a new variable, checking that the destination is large enough to hold the
> + * source value.
> + * @ptr: Destination pointer address
> + * @value: Source value
> + *
> + * Returns:
> + * If the value would overflow the destination, it returns false.
> + */
> +#define safe_conversion(ptr, value) ({ \
> +	typeof(value) __v = (value); \
> +	typeof(ptr) __ptr = (ptr); \
> +	overflows_type(__v, *__ptr) ? 0 : ((*__ptr = (typeof(*__ptr))__v), 1); \
> +})
> +
>  /*
>   * Avoids triggering -Wtype-limits compilation warning,
>   * while using unsigned data types to check a < 0.
> -- 
> 2.37.1
