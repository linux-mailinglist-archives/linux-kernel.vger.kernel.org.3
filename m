Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC52A4B3CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiBMSji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:39:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiBMSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:39:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02EC57B1C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:39:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA23B80B3F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C04C004E1;
        Sun, 13 Feb 2022 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644777568;
        bh=vs/QifduZDoY/ETojuivPkDFpDkaCbp+mFAiQ9QKXeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=falLgcQBvsXbqD+5YLjI1r1ZMPrtOBpatRB1KWnuNJZdPpvjG+1glNvUecuPgKshv
         R0IeB2ewTJ5vBosdW21LO200CjQ0+kPkyfe+PBnE8gkyuD7YQPqrB1QLL6CBQfm1u+
         xdPlfnqACnviL311DuyenWWRaR5MYxaxx+bT8Pmlzy7sfsg15OlovsPIm1uBL4Mh4a
         +DqneNWYyE62qrT9xIzLdD5gEQoWkf/BfY6MTPQjyNcu9gRs/zgqO6J7BkBgxjSe/T
         q3lghfTp0GqoRrUzjNic75qgfEwCSMo6hzSznuEBYvjXt+RvYHlQd/dHwXMVp26zfV
         7l2HwQheFoJQA==
Date:   Sun, 13 Feb 2022 11:39:23 -0700
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
Subject: Re: [PATCH] drm/i915: fix build issue when using clang
Message-ID: <YglQW7gVNoRJ7QpQ@dev-arch.archlinux-ax161>
References: <20220213065106.48062-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213065106.48062-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 10:51:06PM -0800, Tong Zhang wrote:
> drm/i915 target adds some extra cflags, especially it does re-apply -Wall.
> In clang this will override -Wno-format-security and cause the build to
> fail when CONFIG_DRM_I915_WERROR=y. While with GCC this does not happen.
> We reapply -Wno-format-security here to get around this issue.

For what it's worth, GCC would warn in the exact same way if
-Wformat-security was included within -Wall like it is for clang:

drivers/gpu/drm/i915/gt/intel_gt.c: In function ‘intel_gt_invalidate_tlbs’:
drivers/gpu/drm/i915/gt/intel_gt.c:988:9: error: format not a string literal and no format arguments [-Werror=format-security]
  988 |         GEM_TRACE("\n");
      |         ^~~~~~~~~
cc1: all warnings being treated as errors

drivers/gpu/drm/i915/gt/selftest_execlists.c: In function ‘live_sanitycheck’:
drivers/gpu/drm/i915/gt/selftest_execlists.c:142:25: error: format not a string literal and no format arguments [-Werror=format-security]
  142 |                         GEM_TRACE("spinner failed to start\n");
      |                         ^~~~~~~~~
drivers/gpu/drm/i915/gt/selftest_execlists.c: In function ‘live_preempt’:
drivers/gpu/drm/i915/gt/selftest_execlists.c:1775:25: error: format not a string literal and no format arguments [-Werror=format-security]
 1775 |                         GEM_TRACE("lo spinner failed to start\n");
      |                         ^~~~~~~~~
drivers/gpu/drm/i915/gt/selftest_execlists.c:1792:25: error: format not a string literal and no format arguments [-Werror=format-security]
 1792 |                         GEM_TRACE("hi spinner failed to start\n");
      |                         ^~~~~~~~~
cc1: all warnings being treated as errors

If fixing these warnings instead of just disabling the warning is
undesirable (since I feel like the entire point of the i195 cflags
situation is to enable more warnings than the main Makefile), I think
the commit message should be rewritten to something along the lines of:

"drm/i915 adds some extra cflags, namely -Wall, which causes
instances of -Wformat-security to appear when building with clang, even
though this warning is turned off kernel-wide in the main Makefile:"

> drivers/gpu/drm/i915/gt/intel_gt.c:983:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>         GEM_TRACE("ERROR\n");
>         ^~~~~~~~~~~~~~~~~~~~
> ./drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
>  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/kernel.h:369:3: note: expanded from macro 'trace_printk'
>                 do_trace_printk(fmt, ##__VA_ARGS__);    \
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/kernel.h:383:30: note: expanded from macro 'do_trace_printk'
>                 __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
>                                            ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gt/intel_gt.c:983:2: note: treat the string as an argument to avoid this

"This does not happen with GCC because it does not enable
-Wformat-security with -Wall. Disable -Wformat-security within the i915
Makefile so that these warnings do not show up with clang."

The actual diff itself looks fine to me.

Cheers,
Nathan

> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
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
