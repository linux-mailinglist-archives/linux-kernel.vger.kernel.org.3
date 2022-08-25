Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA195A17DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiHYRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiHYRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:19:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF25BC117
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:19:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x23so19084051pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=mFe2KwaxwJR3NcWllcHwQ32yWI6VSKE/eyvGDoK+eaY=;
        b=STPuE0YM+J1mhoq+p8C0SKDm/3ws58TPBadqVU243954KOTgrrGPYBk4/2K9U0vix9
         w1CvpFgFzYGjOuSJLB1d/q3b+bC5a1lNHbcEzmWtGSHwvDbEIqzm+diiMXBMx8EM+Brn
         A61cQIAbd9avPqDfp0HQUMUGURidRWCskVpCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=mFe2KwaxwJR3NcWllcHwQ32yWI6VSKE/eyvGDoK+eaY=;
        b=1ApHm2WybZoRP6ggMtwHCTSXkyWwAtWzH5hYy4htJz4b8PsA7vqENFtMuYvkNxaD+G
         wiC9Lf1lMF8MQU1GYmKnRTOuqnrRjKl8gD+cL/wFgtOB5/wj3iJWXiqMiFYr5q0KkV6v
         3SuWo4H7wPXuTHACbgR0ufBXQHohkuEX/9l5S+kZdar/xfWyg2bmkVuYn0Wkmimqqe9W
         vKCe8NWo5PlJpsPVx1ZdNAqZXh01OrmVOEu/lH+iP3DAjnMnL0IR77P5yRqQaaF/tTpW
         wl3qr1ow5t9Ejnb5bRusGeOzQlKbDGtixXKacG41i69iNOBcvYfZM9EMcL5uS27x7DQ1
         bHiw==
X-Gm-Message-State: ACgBeo3p2Gb2YjWa6VgP2XTkS0UJikNEYChzF+gYYMTnVVNA6S2XaEya
        3pEZT+gMAsoyW1BZqQURm6gp/A==
X-Google-Smtp-Source: AA6agR6urHSapvKyqWO06hiE3FKMf29ktVS2o8CjEoA/nx0mmigoPwwQu+37kTHAhBnuGG3scX3Ukg==
X-Received: by 2002:a17:903:22c9:b0:173:11ec:61ff with SMTP id y9-20020a17090322c900b0017311ec61ffmr20058plg.23.1661447965612;
        Thu, 25 Aug 2022 10:19:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14-20020a65628e000000b0042b66abf05asm728863pgv.8.2022.08.25.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:19:24 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:19:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        mauro.chehab@linux.intel.com,
        intel-gfx-trybot@lists.freedesktop.org
Subject: Re: [PATCH v9 2/8] util_macros: Add exact_type macro to catch type
 mis-match while compiling
Message-ID: <202208250953.A71FEE45E@keescook>
References: <20220824084514.2261614-1-gwan-gyeong.mun@intel.com>
 <20220824084514.2261614-3-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220824084514.2261614-3-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:45:08PM +0900, Gwan-gyeong Mun wrote:
> It adds exact_type and exactly_pgoff_t macro to catch type mis-match while
> compiling. The existing typecheck() macro outputs build warnings, but the
> newly added exact_type() macro uses the BUILD_BUG_ON() macro to generate
> a build break when the types are different and can be used to detect
> explicit build errors.
> 
> v6: Move macro addition location so that it can be used by other than drm
>     subsystem (Jani, Mauro, Andi)
> 
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  include/linux/util_macros.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
> index 72299f261b25..b6624b275257 100644
> --- a/include/linux/util_macros.h
> +++ b/include/linux/util_macros.h
> @@ -2,6 +2,9 @@
>  #ifndef _LINUX_HELPER_MACROS_H_
>  #define _LINUX_HELPER_MACROS_H_
>  
> +#include <linux/types.h>
> +#include <linux/bug.h>
> +
>  #define __find_closest(x, a, as, op)					\
>  ({									\
>  	typeof(as) __fc_i, __fc_as = (as) - 1;				\
> @@ -38,4 +41,26 @@
>   */
>  #define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
>  
> +/**
> + * exact_type - break compile if source type and destination value's type are
> + * not the same
> + * @T: Source type
> + * @n: Destination value
> + *
> + * It is a helper macro for a poor man's -Wconversion: only allow variables of
> + * an exact type. It determines whether the source type and destination value's
> + * type are the same while compiling, and it breaks compile if two types are
> + * not the same
> + */
> +#define exact_type(T, n) \
> +	BUILD_BUG_ON(!__builtin_constant_p(n) && !__builtin_types_compatible_p(T, typeof(n)))

Maybe use __same_type() here instead of open-coded
__builtin_types_compatible_p()? Also, IIUC, currently coding style
advise is to use _Static_assert when possible over BUILD_BUG_ON for
error message readability.

This macro has a trap-door for literals, yes?
i.e.  exact_type(pgoff_t, 5) will pass?

I also note that this is very close to the really common (and open-coded)
test scattered around the kernel already (BUILD_BUG_ON(__same_type(a,
b))), so I think it's good to get a macro defined for it, though I'm not
sure about the trap door test. Regardless, I'd like to bikeshed the name
a bit; I think this should be named something a bit more clear about
what happens on failure. Perhaps: assert_type()? Or to capture the
trapdoor idea, assert_typable()?

#define assert_type(t1, t2)	_Static_assert(__same_type(t1, t2))
#define assert_typable(t, n)	_Static_assert(__builtin_constant_p(n) ||
					       __same_type(t, typeof(n))

> +
> +/**
> + * exactly_pgoff_t - helper to check if the type of a value is pgoff_t
> + * @n: value to compare pgoff_t type
> + *
> + * It breaks compile if the argument value's type is not pgoff_t type.
> + */
> +#define exactly_pgoff_t(n) exact_type(pgoff_t, n)

Why specialize this? Just use assert_typable(pgoff_t, n) in the other
patches? It's almost the same amount to write. :)

-- 
Kees Cook
