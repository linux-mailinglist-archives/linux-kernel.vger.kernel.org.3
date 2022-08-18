Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE407597A83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbiHRAMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiHRAMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:12:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB97A3D4E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:12:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso281825pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=youYpgIRDFxAeu4mwecp1uJBQGmjys1bezqPW12aWgE=;
        b=UCR5LbWjsytFslgCsE0jphSKIIfHXLrwqVIdtaHJDqbOgD76Dl4Wr+qhYX7/IvKijD
         4WoEsIzUrGO9kQPjVWIJsenuCTuX+zowr58KIuH8GsCEt2r1CYv4lazX3ywSlxgEYYul
         kdhWZJQ1Y8XGyCRBm1RimSxKT///eHxsN2DlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=youYpgIRDFxAeu4mwecp1uJBQGmjys1bezqPW12aWgE=;
        b=tMFNYV+xiHPQbgpcTKy7J49YjgsG8eY5JTPJXDT8b5OGfwjm36vxDq2M8bZb1f1Ikw
         KpX36LjuX90trMiWpSvWtsDFhmAyDQfv76160VDZzAltQzyq6QI2p/8g4FaxyTTtbjb4
         e3B7RBN3Vg6UmYwijcxqrax5FsGD1j4QsOUg1ah9TtY61ulWekeZK26uEFIEATSPTc+X
         z+x0uHa92zLmUaULG0ACOrJ2fOUNuO9rz+nRLfUmesg43pFcPVjt0VmaFIutu+EkRvqb
         +JMjmqCaLJxp+Ieg2uMhyLc5hYpG9+1Stm1v+6CSFpHDx5S6xOFQ0UTNS9JBv34aAex6
         SKow==
X-Gm-Message-State: ACgBeo1gPMzbmKVmsre7FkkRb4xMc2f3nL5dWyfDYjHZ+ObTB7YuRHGL
        kH0S7LYpi2b4pMEGs4hHXjI/ig==
X-Google-Smtp-Source: AA6agR5mRAF7yxfBbQaw/DoOtsDOwwfqBAVdzxdq+NcFYZRSYoRPkqalUG4Twt7hthHtdMe/eERHLg==
X-Received: by 2002:a17:902:7682:b0:170:a235:b5a2 with SMTP id m2-20020a170902768200b00170a235b5a2mr328051pll.113.1660781555349;
        Wed, 17 Aug 2022 17:12:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q28-20020a63f95c000000b00428c216467csm65439pgk.32.2022.08.17.17.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 17:12:34 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:12:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        andrzej.hajda@intel.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/8] overflow: Move and add few utility macros into
 overflow
Message-ID: <202208171657.63AE7AC@keescook>
References: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
 <20220816093525.184940-2-gwan-gyeong.mun@intel.com>
 <Yv10sQADwdZrIV42@alfio.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv10sQADwdZrIV42@alfio.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 01:07:29AM +0200, Andi Shyti wrote:
> Hi Kees,
> 
> would you mind taking a look at this patch?

Hi! Thanks for the heads-up!

> 
> Thanks,
> Andi
> 
> On Tue, Aug 16, 2022 at 06:35:18PM +0900, Gwan-gyeong Mun wrote:
> > It moves overflows_type utility macro into overflow header from i915_utils
> > header. The overflows_type can be used to catch the truncation between data
> > types. And it adds safe_conversion() macro which performs a type conversion
> > (cast) of an source value into a new variable, checking that the
> > destination is large enough to hold the source value. And the functionality
> > of overflows_type has been improved to handle the signbit.
> > The is_unsigned_type macro has been added to check the sign bit of the
> > built-in type.
> > 
> > v3: Add is_type_unsigned() macro (Mauro)
> >     Modify overflows_type() macro to consider signed data types (Mauro)
> >     Fix the problem that safe_conversion() macro always returns true
> > v4: Fix kernel-doc markups
> > v6: Move macro addition location so that it can be used by other than drm
> >     subsystem (Jani, Mauro, Andi)
> >     Change is_type_unsigned to is_unsigned_type to have the same name form
> >     as is_signed_type macro
> > 
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Nirmoy Das <nirmoy.das@intel.com>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
> > ---
> >  drivers/gpu/drm/i915/i915_utils.h |  5 +--
> >  include/linux/overflow.h          | 54 +++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> > index c10d68cdc3ca..eb0ded23fa9c 100644
> > --- a/drivers/gpu/drm/i915/i915_utils.h
> > +++ b/drivers/gpu/drm/i915/i915_utils.h
> > @@ -32,6 +32,7 @@
> >  #include <linux/types.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/sched/clock.h>
> > +#include <linux/overflow.h>
> >  
> >  #ifdef CONFIG_X86
> >  #include <asm/hypervisor.h>
> > @@ -111,10 +112,6 @@ bool i915_error_injected(void);
> >  #define range_overflows_end_t(type, start, size, max) \
> >  	range_overflows_end((type)(start), (type)(size), (type)(max))
> >  
> > -/* Note we don't consider signbits :| */
> > -#define overflows_type(x, T) \
> > -	(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
> > -
> >  #define ptr_mask_bits(ptr, n) ({					\
> >  	unsigned long __v = (unsigned long)(ptr);			\
> >  	(typeof(ptr))(__v & -BIT(n));					\
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index f1221d11f8e5..462a03454377 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -35,6 +35,60 @@
> >  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
> >  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
> >  
> > +/**
> > + * is_unsigned_type - helper for checking data type which is an unsigned data
> > + * type or not
> > + * @x: The data type to check
> > + *
> > + * Returns:
> > + * True if the data type is an unsigned data type, false otherwise.
> > + */
> > +#define is_unsigned_type(x) ((typeof(x))-1 >= (typeof(x))0)

I'd rather not have separate logic for this. Instead, I'd like it to be:

#define is_unsigned_type(x) (!is_signed_type(x))

> > +
> > +/**
> > + * overflows_type - helper for checking the truncation between data types
> > + * @x: Source for overflow type comparison
> > + * @T: Destination for overflow type comparison
> > + *
> > + * It compares the values and size of each data type between the first and
> > + * second argument to check whether truncation can occur when assigning the
> > + * first argument to the variable of the second argument.
> > + * Source and Destination can be used with or without sign bit.
> > + * Composite data structures such as union and structure are not considered.
> > + * Enum data types are not considered.
> > + * Floating point data types are not considered.
> > + *
> > + * Returns:
> > + * True if truncation can occur, false otherwise.
> > + */
> > +#define overflows_type(x, T) \
> > +	(is_unsigned_type(x) ? \
> > +		is_unsigned_type(T) ? \
> > +			(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> > +			: (sizeof(x) >= sizeof(T) && (x) >> (BITS_PER_TYPE(T) - 1)) ? 1 : 0 \
> > +	: is_unsigned_type(T) ? \
> > +		((x) < 0) ? 1 : (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> > +		: (sizeof(x) > sizeof(T)) ? \
> > +			((x) < 0) ? (((x) * -1) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> > +				: ((x) >> BITS_PER_TYPE(T)) ? 1 : 0 \
> > +			: 0)

Like the other, I'd much rather this was rephrased in terms of the
existing macros (e.g. type_min()/type_max().)

> > +
> > +/**
> > + * safe_conversion - perform a type conversion (cast) of an source value into
> > + * a new variable, checking that the destination is large enough to hold the
> > + * source value.
> > + * @ptr: Destination pointer address
> > + * @value: Source value
> > + *
> > + * Returns:
> > + * If the value would overflow the destination, it returns false.
> > + */
> > +#define safe_conversion(ptr, value) ({ \
> > +	typeof(value) __v = (value); \
> > +	typeof(ptr) __ptr = (ptr); \
> > +	overflows_type(__v, *__ptr) ? 0 : ((*__ptr = (typeof(*__ptr))__v), 1); \
> > +})

I try to avoid "safe" as an adjective for interface names, since it
doesn't really answer "safe from what?" This looks more like "assign, but
zero when out of bounds". And it can be built from existing macros here:

	if (check_add_overflow(0, value, ptr))
		*ptr = 0;

I actually want to push back on this a bit, because there can still be
logic bugs built around this kind of primitive. Shouldn't out-of-bounds
assignments be seen as a direct failure? I would think this would be
sufficient:

#define check_assign(value, ptr)	check_add_overflow(0, value, ptr)

And callers would do:

	if (check_assign(value, &var))
		return -EINVAL;

etc.


-- 
Kees Cook
