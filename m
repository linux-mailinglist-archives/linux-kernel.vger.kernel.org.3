Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF604D2A81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiCIIUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiCIIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:20:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605140E50;
        Wed,  9 Mar 2022 00:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646813973; x=1678349973;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hLBK1t/r9Z48f8dSRNwh+u136IQEg0xMqQ5EbEwvT7Y=;
  b=aKgwPTuRF6SheFFJ7QFMCagcyzgbcXxjIk4ILwmEGg/0JAI96rN/B/pM
   ssCkOjdqlEkc1AN4981wf83bBycCVle+fcTWXAtezCd1OD45R5GlL1Vzt
   8oB34dBAWdgXHB2r7RQjdPbNBm6xSGmKgRbQD9WsO3KznUVRUIjLzpU/k
   7IYoKT3DTs3d2iDXO9/T1EruotchsJZxxzQuaAAbRjvZg/26m0C2Qa1qU
   DIlmYkgsJ3wOVwiKtEMg6g2GkRgGjvqGDFeV7yewjEqJxpI0E07TAg1yi
   md3eV6oYTk3a1+kRfrGXWtdyb6ZxEdgRlHEBTObtqN9bhq1BXF8P7my98
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254649003"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254649003"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:19:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="711860724"
Received: from byrnec1x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.29.235])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:19:27 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     alexs@kernel.org, arnd@arndb.de, arnd@kernel.org, dsterba@suse.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        ndesaulniers@google.com, ojeda@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/4] [v4] Kbuild: add -Wno-shift-negative-value where
 -Wextra is used
In-Reply-To: <20220308215615.14183-2-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220308215615.14183-1-arnd@kernel.org>
 <20220308215615.14183-2-arnd@kernel.org>
Date:   Wed, 09 Mar 2022 10:19:25 +0200
Message-ID: <87ee3b1qsy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> As a preparation for moving to -std=gnu11, turn off the
> -Wshift-negative-value option. This warning is enabled by gcc when
> building with -Wextra for c99 or higher, but not for c89. Since
> the kernel already relies on well-defined overflow behavior,
> the warning is not helpful and can simply be disabled in
> all locations that use -Wextra.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
> [v4]
>   split into a separate patch
> ---
>  drivers/gpu/drm/i915/Makefile          | 1 +
>  drivers/staging/greybus/tools/Makefile | 3 ++-
>  fs/btrfs/Makefile                      | 1 +
>  scripts/Makefile.extrawarn             | 1 +
>  4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 1b62b9f65196..1618a6e0af4e 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -17,6 +17,7 @@ subdir-ccflags-y += -Wno-unused-parameter
>  subdir-ccflags-y += -Wno-type-limits
>  subdir-ccflags-y += -Wno-missing-field-initializers
>  subdir-ccflags-y += -Wno-sign-compare
> +subdir-ccflags-y += -Wno-shift-negative-value
>  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
>  subdir-ccflags-y += $(call cc-disable-warning, frame-address)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
> diff --git a/drivers/staging/greybus/tools/Makefile b/drivers/staging/greybus/tools/Makefile
> index ad0ae8053b79..a3bbd73171f2 100644
> --- a/drivers/staging/greybus/tools/Makefile
> +++ b/drivers/staging/greybus/tools/Makefile
> @@ -12,7 +12,8 @@ CFLAGS	+= -std=gnu99 -Wall -Wextra -g \
>  	    -Wredundant-decls \
>  	    -Wcast-align \
>  	    -Wsign-compare \
> -	    -Wno-missing-field-initializers
> +	    -Wno-missing-field-initializers \
> +	    -Wno-shift-negative-value
>  
>  CC	:= $(CROSS_COMPILE)gcc
>  
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 4188ba3fd8c3..99f9995670ea 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -17,6 +17,7 @@ subdir-ccflags-y += $(condflags)
>  subdir-ccflags-y += -Wno-missing-field-initializers
>  subdir-ccflags-y += -Wno-sign-compare
>  subdir-ccflags-y += -Wno-type-limits
> +subdir-ccflags-y += -Wno-shift-negative-value
>  
>  obj-$(CONFIG_BTRFS_FS) := btrfs.o
>  
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8be892887d71..650d0b8ceec3 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -36,6 +36,7 @@ KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
>  KBUILD_CFLAGS += -Wno-missing-field-initializers
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-type-limits
> +KBUILD_CFLAGS += -Wno-shift-negative-value
>  
>  KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1

-- 
Jani Nikula, Intel Open Source Graphics Center
