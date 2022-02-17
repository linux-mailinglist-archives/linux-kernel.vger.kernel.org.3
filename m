Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF654B9A09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiBQHs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:48:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiBQHsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:48:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2424523A1BC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645084092; x=1676620092;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=99+dhgli+TBsASZWY8Mrl5qU4Lz7MyY/5DzeBpVia5E=;
  b=evx+9DmKQConkhRgTM5wiRPj4U6ymAwK3G6SvzhJMgGAMu07pnTHXGWs
   qYYVIwDFk0bQ9N+ezerLKLhb6Eq/83HXLAKypOmLuOnX5NwQ1sZlOkK7K
   oxWbjiylGxJ2O+QKrn3WG8Y7lODkrGgIDMXVIQ4SrVMW+KQbx9vwxRb+y
   9sWpRLOj0AzL7oYqYnXz12wagItn3kH/6cnRunpSbNtVFkfSc3ixPnoCO
   EQdKugIBBibCoV4yYsqG7PvBPxgP+UModkS/uUPCVPOCpQgTef74Nu91O
   vGr4/MNEAN6gFr10gmsNdQYdigllVIY7VlyfADaxyUXIMlSK/KB8bahk9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249652808"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="249652808"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:48:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="636953141"
Received: from acushion-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.21.45])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 23:48:07 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] drm/i915: fix build issue when using clang
In-Reply-To: <Ygv2fvIKiM9w+aSb@dev-arch.archlinux-ax161>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
 <20220214195821.29809-1-ztong0001@gmail.com>
 <Ygv2fvIKiM9w+aSb@dev-arch.archlinux-ax161>
Date:   Thu, 17 Feb 2022 09:48:04 +0200
Message-ID: <877d9u3pe3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Nathan Chancellor <nathan@kernel.org> wrote:
> On Mon, Feb 14, 2022 at 11:58:20AM -0800, Tong Zhang wrote:
>> drm/i915 adds some extra cflags, namely -Wall, which causes
>> instances of -Wformat-security to appear when building with clang, even
>> though this warning is turned off kernel-wide in the main Makefile:
>> 
>> > drivers/gpu/drm/i915/gt/intel_gt.c:983:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>> >         GEM_TRACE("ERROR\n");
>> >         ^~~~~~~~~~~~~~~~~~~~
>> > ./drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
>> >  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
>> >                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>> > ./include/linux/kernel.h:369:3: note: expanded from macro 'trace_printk'
>> >                 do_trace_printk(fmt, ##__VA_ARGS__);    \
>> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > ./include/linux/kernel.h:383:30: note: expanded from macro 'do_trace_printk'
>> >                 __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
>> >                                           ^~~~~~~~~~~~~~~~
>> >drivers/gpu/drm/i915/gt/intel_gt.c:983:2: note: treat the string as an argument to avoid this
>> 
>> This does not happen with GCC because it does not enable
>> -Wformat-security with -Wall. Disable -Wformat-security within the i915
>> Makefile so that these warnings do not show up with clang.
>> 
>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>
> Given this is not enabled for GCC and it is disabled in the main
> Makefile:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Additionally, it seems like trace_printk() is designed to be able to
> take a string literal without a format argument, so this should be fine.

Thanks for the patch and review, pushed to drm-intel-next. I appreciate
the support in maintaining fairly strict warning levels in i915.

BR,
Jani.

>
>> ---
>> 
>> v2: revise commit message
>> 
>>  drivers/gpu/drm/i915/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
>> index 1b62b9f65196..c04e05a3d39f 100644
>> --- a/drivers/gpu/drm/i915/Makefile
>> +++ b/drivers/gpu/drm/i915/Makefile
>> @@ -13,6 +13,7 @@
>>  # will most likely get a sudden build breakage... Hopefully we will fix
>>  # new warnings before CI updates!
>>  subdir-ccflags-y := -Wall -Wextra
>> +subdir-ccflags-y += -Wno-format-security
>>  subdir-ccflags-y += -Wno-unused-parameter
>>  subdir-ccflags-y += -Wno-type-limits
>>  subdir-ccflags-y += -Wno-missing-field-initializers
>> -- 
>> 2.25.1
>> 
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
