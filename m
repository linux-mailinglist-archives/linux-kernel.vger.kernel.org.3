Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEAC493E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356205AbiASQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:54:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:27172 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243524AbiASQyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642611240; x=1674147240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pZSvEi9rquxwXrszIRf2gCK/ow/gOe+bkO+nvMwHiQ=;
  b=UnPNVfbUfcvyO0jjAqFjMiXhOFtlDYFBJK12m+i7/ex6e5enVto/VoU6
   s74uiKR5N3MHsS7OmMiA8G1f3yW10iCoGPNInAO5wZMks7TFwB+7S4LSy
   60QM8n0l8h5+iq012WNogOEqAEPIkjuiGJ6x9cGrXSR/s8kOmxxGKTikJ
   +4CRfjX+BY/ndIbNc5u9ol831wywT+P2mn5hdiY+t0dFJ+Dw7lZHClNLC
   qQPgtyuM1ESTLDMC2QsVgT1+e9I5agopRLUMO/KDgmhKV3LGl1nxjMuEI
   u/Fsye207JUmQArYmNKeepr1+Ai4z3FT1KkRo35xrcyiFXRTKG9Bnm6Tc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225784298"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="225784298"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:53:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="693843934"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:53:56 -0800
Date:   Wed, 19 Jan 2022 08:53:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/7] DRM kmap() fixes and kmap_local_page() conversions
Message-ID: <20220119165356.GD209936@iweiny-DESK2.sc.intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210232404.4098157-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:23:57PM -0800, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> This series starts by converting the last easy kmap() uses to
> kmap_local_page().
> 
> There is one more call to kmap() wrapped in ttm_bo_kmap_ttm().  Unfortunately,
> ttm_bo_kmap_ttm() is called in a number of different ways including some which
> are not thread local.  I have a patch to convert that call.  However, it is not
> straight forward so it is not included in this series.
> 
> The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
> conversion.

Gentile ping on this series?  Will it make this merge window?

Thanks,
Ira

> 
> 
> Ira Weiny (7):
> drm/i915: Replace kmap() with kmap_local_page()
> drm/amd: Replace kmap() with kmap_local_page()
> drm/gma: Remove calls to kmap()
> drm/radeon: Replace kmap() with kmap_local_page()
> drm/msm: Alter comment to use kmap_local_page()
> drm/amdgpu: Ensure kunmap is called on error
> drm/radeon: Ensure kunmap is called on error
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
> drivers/gpu/drm/gma500/gma_display.c | 6 ++----
> drivers/gpu/drm/gma500/mmu.c | 8 ++++----
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 ++--
> drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
> drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c | 4 ++--
> drivers/gpu/drm/i915/gt/shmem_utils.c | 4 ++--
> drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
> drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
> drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
> drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
> 13 files changed, 32 insertions(+), 32 deletions(-)
> 
> --
> 2.31.1
> 
