Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD381470E87
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbhLJX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:27:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:20016 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243479AbhLJX1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639178649; x=1670714649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=natZGEGnozpVjzH9/ll6pqbq/c60OeZZoFD4w7E24dY=;
  b=BvYpEj+o39G+e3kSZEr9oq9WQQgcU9EBnjLMRac+n5XN1v9wt1DKnrAT
   uc1QDkcoqmkShM8DYV7kVs1OUhsLvWGYG5yAncdAz7HfTuvGUe+pnhuf2
   saAsEtm0cN9ULK8gRGMCbmjGqnPxveP/O445YLWAg4zqQ7GeP3LLsZShN
   ZRncR3YA3VnKkZuKTFalatZYT8zaQDUX/RqucAfic53dEdvvcLufZT/44
   tD+Pd/H0dS1X//TlKMBWYUTh+6+QhKv3rtwnh86otYHXmU1IE2aLoUc0x
   7viAfW8haFesYCcl5B/uhldCrudOrjDi/bePXaKLbJO//muQ/nJ8XDT6D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="225751347"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225751347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:24:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="680925811"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:24:08 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/7] DRM kmap() fixes and kmap_local_page() conversions
Date:   Fri, 10 Dec 2021 15:23:57 -0800
Message-Id: <20211210232404.4098157-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This series starts by converting the last easy kmap() uses to
kmap_local_page().

There is one more call to kmap() wrapped in ttm_bo_kmap_ttm().  Unfortunately,
ttm_bo_kmap_ttm() is called in a number of different ways including some which
are not thread local.  I have a patch to convert that call.  However, it is not
straight forward so it is not included in this series.

The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
conversion.


Ira Weiny (7):
drm/i915: Replace kmap() with kmap_local_page()
drm/amd: Replace kmap() with kmap_local_page()
drm/gma: Remove calls to kmap()
drm/radeon: Replace kmap() with kmap_local_page()
drm/msm: Alter comment to use kmap_local_page()
drm/amdgpu: Ensure kunmap is called on error
drm/radeon: Ensure kunmap is called on error

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
drivers/gpu/drm/gma500/gma_display.c | 6 ++----
drivers/gpu/drm/gma500/mmu.c | 8 ++++----
drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 ++--
drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c | 4 ++--
drivers/gpu/drm/i915/gt/shmem_utils.c | 4 ++--
drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
13 files changed, 32 insertions(+), 32 deletions(-)

--
2.31.1

