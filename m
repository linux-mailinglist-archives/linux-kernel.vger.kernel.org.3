Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361CD4976F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiAXByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:16811 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238668AbiAXByN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989253; x=1674525253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ngiBZ4miI2i9+e7eQ8QzZsVgrw+8WTFv/7YWGiVXsVM=;
  b=dbSgAmfaBp99HEcKeaCjAP3tUZPP4LaKY6z1QaaM36A09fmWs70TXQHK
   2bQvC0LK/898ZThWp9yMXUzqWRXUXRuzxEuQzGkSVTgo0JHzDzX8worIO
   7r2o0iZVYjamOCdmC8h8aXU95r3qwUEvC9cJzmVlkFrO3h2ToS3trDi+0
   kuzmBIERDwEasgP3K02jWisCO0KJMJxGUP9IFYrmVFKe7ZdqeZSmv8UBd
   3SjtKCbf1oiDCqKkcataCEokjYX1mEkeecaTOID/69jRspBAlagus3OAj
   MZ57NXSjWtLCchrLC5uHbj208iJlGyK1EvXYlIPyUOkAoex09WEAhcLNh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243536972"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243536972"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476550367"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:12 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 0/7] DRM kmap() fixes and kmap_local_page() conversions
Date:   Sun, 23 Jan 2022 17:54:02 -0800
Message-Id: <20220124015409.807587-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V1:
	Use memcpy_to_page() where appropriate
	Rebased to latest

The kmap() call may cause issues with work being done with persistent memory.
For this and other reasons it is being deprecated.

This series starts by converting the last easy kmap() uses in the drm tree to
kmap_local_page().

The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
conversion.  They are valid fixes but were found via code inspection not
because of any actual bug so don't require a stable tag.[1]

There is one more call to kmap() used in ttm_bo_kmap_ttm().  Unfortunately,
fixing this is not straight forward so it is left to future work.[2]

[1] https://lore.kernel.org/lkml/fb71af05-a889-8f6e-031b-426b58a64f00@amd.com/
[2] https://lore.kernel.org/lkml/20211215210949.GW3538886@iweiny-DESK2.sc.intel.com/


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
drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++----
drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c | 4 ++--
drivers/gpu/drm/i915/gt/shmem_utils.c | 7 ++-----
drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
13 files changed, 32 insertions(+), 37 deletions(-)

--
2.31.1

