Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696845AFC35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIGGNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIGGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:13:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F895E47
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:13:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s11so18114532edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=654Mx5KNflErskpZWsH78GwciP3JIpFtIohp9Xrffk8=;
        b=kTVxUA3e9XBedEkDMGUk5JWQTnlJeSjnLmlcU4pG1ZFUTA8PEjcLC2U6LgGg5ayxqm
         Zgz1xqYKHghLFxYUSQU/hJzNPVChEdbcp9aR9WcLZjA4/4dQYwSGSW6NVmg8GwpJgZiX
         NUpxPYYLtJzbT8z5kLMYvf8Iw/hk/fojCH37A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=654Mx5KNflErskpZWsH78GwciP3JIpFtIohp9Xrffk8=;
        b=0KdQLj3nX+8oooLO1nmc7f+tW7f8KZtfvg4oBZxt7XN6aQchAMIPuXDjtFqzdod2kk
         aqT/LI5ogVbL/x5eybbXjhCx66pebxaHr9TbZ2XHxwb7u3zBBt46sC1JTKOrzQ0oGKkI
         CXyCJbd9/HBqMLI7b26cNq6071/khNWQGaVAhSra3+WqQt3zzmt/R2Eyi18NEKCDyXUv
         +zj+O/o5ARGPlSRD2Lhbuy0JYYKYC1Vo8qa78+xbojyYZ9kFXqu6h59PQqbDGvV29E65
         huurifq9iYvtGeMmXUYF4hZ1309afi7bPycO/M1FnxC0LxbF4LuhgArMm7ds5RNJtirs
         7COQ==
X-Gm-Message-State: ACgBeo388rqRPwDANySR5+B8Z2aX2KRFZeg4KEbfyDVoPuYitnWWHe7Y
        IoTsVBfuAvx8nn9xLrQ+1Jj+aQ==
X-Google-Smtp-Source: AA6agR7EC4O8cL4v8Kr/JZ/weO0LUmT/WoVmEM5JZHGy6WvE2zVf2us/qRdDMvqkQPCJFFq2EBqEtg==
X-Received: by 2002:a05:6402:3507:b0:448:b672:55ee with SMTP id b7-20020a056402350700b00448b67255eemr1752029edd.107.1662531185647;
        Tue, 06 Sep 2022 23:13:05 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id kz16-20020a17090777d000b0073c8d4c9f38sm7935402ejc.177.2022.09.06.23.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:13:05 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:13:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH v6 23/57] drm: POC drm on dyndbg - use in core, 2
 helpers, 3 drivers.
Message-ID: <Yxg2b2stA27B6B0t@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
References: <20220904214134.408619-1-jim.cromie@gmail.com>
 <20220904214134.408619-24-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904214134.408619-24-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 03:41:00PM -0600, Jim Cromie wrote:
> Use DECLARE_DYNDBG_CLASSMAP across DRM:
> 
>  - in .c files, since macro defines/initializes a record
> 
>  - in drivers, $mod_{drv,drm,param}.c
>    ie where param setup is done, since a classmap is param related
> 
>  - in drm/drm_print.c
>    since existing __drm_debug param is defined there,
>    and we ifdef it, and provide an elaborated alternative.
> 
>  - in drm_*_helper modules:
>    dp/drm_dp - 1st item in makefile target
>    drivers/gpu/drm/drm_crtc_helper.c - random pick iirc.
> 
> Since these modules all use identical CLASSMAP declarations (ie: names
> and .class_id's) they will all respond together to "class DRM_UT_*"
> query-commands:
> 
>   :#> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control
> 
> NOTES:
> 
> This changes __drm_debug from int to ulong, so BIT() is usable on it.
> 
> DRM's enum drm_debug_category values need to sync with the index of
> their respective class-names here.  Then .class_id == category, and
> dyndbg's class FOO mechanisms will enable drm_dbg(DRM_UT_KMS, ...).
> 
> Though DRM needs consistent categories across all modules, thats not
> generally needed; modules X and Y could define FOO differently (ie a
> different NAME => class_id mapping), changes are made according to
> each module's private class-map.
> 
> No callsites are actually selected by this patch, since none are
> class'd yet.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

So maybe I should just try, but what happens if a drm module doesn't have
these classbits declared? You simply have to use the raw number instead?

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++++
>  drivers/gpu/drm/display/drm_dp_helper.c | 13 ++++++++++++
>  drivers/gpu/drm/drm_crtc_helper.c       | 13 ++++++++++++
>  drivers/gpu/drm/drm_print.c             | 27 +++++++++++++++++++++++--
>  drivers/gpu/drm/i915/i915_params.c      | 12 +++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drm.c   | 13 ++++++++++++
>  include/drm/drm_print.h                 |  3 ++-
>  7 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index de7144b06e93..97e184f44a52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -38,6 +38,8 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/suspend.h>
>  #include <linux/cc_platform.h>
> +#include <linux/fb.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_irq.h"
> @@ -185,6 +187,18 @@ int amdgpu_vcnfw_log;
>  
>  static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,

Iirc we've talked about maybe some kbuild trickery so that any module
under drivers/gpu/drm gets these by default. I don't think we need to have
this for the first cut, but a macro to avoid the copypaste mistakes would
be really good here.

> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  struct amdgpu_mgpu_info mgpu_info = {
>  	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>  	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 92990a3d577a..cbb9c4d6d8f2 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -30,6 +30,7 @@
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/string_helpers.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> @@ -40,6 +41,18 @@
>  
>  #include "drm_dp_helper_internal.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  struct dp_aux_backlight {
>  	struct backlight_device *base;
>  	struct drm_dp_aux *aux;
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 457448cc60f7..7d86020b5244 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -32,6 +32,7 @@
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -50,6 +51,18 @@
>  
>  #include "drm_crtc_helper_internal.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  /**
>   * DOC: overview
>   *
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index f783d4963d4b..ec32df35a3e3 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -40,7 +40,7 @@
>   * __drm_debug: Enable debug output.
>   * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
>   */
> -unsigned int __drm_debug;
> +unsigned long __drm_debug;
>  EXPORT_SYMBOL(__drm_debug);
>  
>  MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
> @@ -52,7 +52,30 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
>  "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
>  "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
>  "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
> -module_param_named(debug, __drm_debug, int, 0600);
> +
> +#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> +module_param_named(debug, __drm_debug, ulong, 0600);
> +#else
> +/* classnames must match vals of enum drm_debug_category */
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
> +static struct ddebug_class_param drm_debug_bitmap = {
> +	.bits = &__drm_debug,
> +	.flags = "p",
> +	.map = &drm_debug_classes,
> +};
> +module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
> +#endif
>  
>  void __drm_puts_coredump(struct drm_printer *p, const char *str)
>  {
> diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> index 6fc475a5db61..d1e4d528cb17 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -29,6 +29,18 @@
>  #include "i915_params.h"
>  #include "i915_drv.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  #define i915_param_named(name, T, perm, desc) \
>  	module_param_named(name, i915_modparams.name, T, perm); \
>  	MODULE_PARM_DESC(name, desc)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 561309d447e0..fd99ec0f4257 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -70,6 +71,18 @@
>  #include "nouveau_svm.h"
>  #include "nouveau_dmem.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  MODULE_PARM_DESC(config, "option string to pass to driver core");
>  static char *nouveau_config;
>  module_param_named(config, nouveau_config, charp, 0400);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index b3b470440e46..668273e36c2c 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -35,7 +35,7 @@
>  #include <drm/drm.h>
>  
>  /* Do *not* use outside of drm_print.[ch]! */
> -extern unsigned int __drm_debug;
> +extern unsigned long __drm_debug;
>  
>  /**
>   * DOC: print
> @@ -275,6 +275,7 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
>   *
>   */
>  enum drm_debug_category {
> +	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */

I'd just put this into the kerneldoc, then you can also link to the
DRM_PRINT_DECLARE_DEBUG_CLASSBITS macro or whatever you'll call the thing
so drivers don't have to copypaste it all.
-Daniel

>  	/**
>  	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
>  	 * drm_memory.c, ...
> -- 
> 2.37.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
