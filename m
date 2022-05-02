Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B939B517315
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiEBPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385938AbiEBPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:45:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D75D6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651506105; x=1683042105;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9Es5XqFtpVE3LdYUHq79mdDv756yQwrZat3r/qgRHNc=;
  b=Wrls+B1BczEur3+ydRAQU3ZdMHzLc0KHTZBL0qbI4zxNur7RJMz1EzfF
   jRouvnsPiUXygcpteYB0mD35BSE/ax7Awg3XbFaJ9cUsYuF8y8pH+AUQm
   er6PWJNaEMa9s2idw2a1Y7XWU0EL9VzIF73hqd9LOQ7ELMSOZ536AiIu3
   jsQ9Nd6o92CHMK96YOpPalcOXhiyJLoCh/erCVqcZlPvaX2T9vSBe6cjJ
   JILqk6dTR+Wx+9vkoBR4vWa+if4wS1ZBLQ3wXAJPJ+XKGjebImOvFcE8j
   r0aRJBD7Zn/mQ+q2xM1C6JJHXJslkl+fFt5lwlAOvlW7/LcS3EteXa79F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247150718"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="247150718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:41:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583756662"
Received: from wagoleb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.155.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:41:42 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: drm_gem.h: Add explicit includes for
 DEFINE_DRM_GEM_FOPS
In-Reply-To: <1651262112-29664-1-git-send-email-quic_jhugo@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1651262112-29664-1-git-send-email-quic_jhugo@quicinc.com>
Date:   Mon, 02 May 2022 18:41:39 +0300
Message-ID: <87y1zkq6vg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
> DEFINE_DRM_GEM_FOPS() references drm functions from other headers.  For
> example drm_open() is defined in drm_file.h and drm_ioctl() is defined
> in drm_ioctl.h.  Since drm_gem.h doesn't include these headers, it
> relies on an implicit include from the .c file to have included these
> required headers before DEFINE_DRM_GEM_FOPS() gets used.  Relying on
> these implicit includes can cause build failures for new code that
> doesn't know about these requirements, and can lead to future problems
> if the headers ever get restructured as there will be a need to update
> every downstream file that includes drm_gem.h.
>
> Lets fix this explicitly including the required headers in drm_gem.h so
> that code that includes drm_gem.h does not need to worry about these
> implicit dependencies.

In the general case, I tend to agree, but in this specific instance I
think I'd err on the side of fewer includes. I think the more likely
outcome here is accumulating implicit dependencies on symbols from
drm_file.h and drm_ioctl.h by including drm_gem.h only!

I do think headers need to be self-contained, and we actually enforce
this in i915 (see HDRTEST in drivers/gpu/drm/i915/Makefile), but not to
the point of macro expansions.

BR,
Jani.



>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  include/drm/drm_gem.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 9d7c61a..1cbe3d8 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -37,6 +37,8 @@
>  #include <linux/kref.h>
>  #include <linux/dma-resv.h>
>  
> +#include <drm/drm_file.h>
> +#include <drm/drm_ioctl.h>
>  #include <drm/drm_vma_manager.h>
>  
>  struct iosys_map;

-- 
Jani Nikula, Intel Open Source Graphics Center
