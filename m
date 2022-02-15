Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40144B7826
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbiBOSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:53:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiBOSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:53:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DF7C14E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:52:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83368B81B80
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E49FC340EB;
        Tue, 15 Feb 2022 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644951171;
        bh=DFG0pRgxAXggFuC5nOBdDvexAUqfQBkCU3iOcuBDTLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KD1kgcdAH5hIi1+tPUuj9hs1lQi/1mRkekyPB/HBDERBqSiPocLYx+7M+qFCRr1Nv
         82kimfILqAA5HyP4LXAoI1u6y7aKJriuVzXe0db2jwIz4FfIS2QUkAtBPyM4HMcsZx
         oYcxOeF2h1/9I52noM8DP7kJQ7hZnD4K613ltTs/egGEPU5xdWfD9gMkXa6mWBXsb/
         c2NOQcj+47/jdtoldgqMnRIu64DXzXzuhG6qEn5VHXsdU1U1qJRjitolMfLPTsFT6I
         9XVm7MPeOX/xaMSZ7Em4Gve1jd3myWH/D472ERvQsyHbTG2nieE9JZUzOPvrlLnVIQ
         J0gJ8+132x8kQ==
Date:   Tue, 15 Feb 2022 11:52:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] drm/i915: fix build issue when using clang
Message-ID: <Ygv2fvIKiM9w+aSb@dev-arch.archlinux-ax161>
References: <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
 <20220214195821.29809-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214195821.29809-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:58:20AM -0800, Tong Zhang wrote:
> drm/i915 adds some extra cflags, namely -Wall, which causes
> instances of -Wformat-security to appear when building with clang, even
> though this warning is turned off kernel-wide in the main Makefile:
> 
> > drivers/gpu/drm/i915/gt/intel_gt.c:983:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >         GEM_TRACE("ERROR\n");
> >         ^~~~~~~~~~~~~~~~~~~~
> > ./drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
> >  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
> >                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/kernel.h:369:3: note: expanded from macro 'trace_printk'
> >                 do_trace_printk(fmt, ##__VA_ARGS__);    \
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/kernel.h:383:30: note: expanded from macro 'do_trace_printk'
> >                 __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
> >                                           ^~~~~~~~~~~~~~~~
> >drivers/gpu/drm/i915/gt/intel_gt.c:983:2: note: treat the string as an argument to avoid this
> 
> This does not happen with GCC because it does not enable
> -Wformat-security with -Wall. Disable -Wformat-security within the i915
> Makefile so that these warnings do not show up with clang.
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Given this is not enabled for GCC and it is disabled in the main
Makefile:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Additionally, it seems like trace_printk() is designed to be able to
take a string literal without a format argument, so this should be fine.

> ---
> 
> v2: revise commit message
> 
>  drivers/gpu/drm/i915/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 1b62b9f65196..c04e05a3d39f 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -13,6 +13,7 @@
>  # will most likely get a sudden build breakage... Hopefully we will fix
>  # new warnings before CI updates!
>  subdir-ccflags-y := -Wall -Wextra
> +subdir-ccflags-y += -Wno-format-security
>  subdir-ccflags-y += -Wno-unused-parameter
>  subdir-ccflags-y += -Wno-type-limits
>  subdir-ccflags-y += -Wno-missing-field-initializers
> -- 
> 2.25.1
> 
> 
