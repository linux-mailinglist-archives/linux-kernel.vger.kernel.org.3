Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97B49D396
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiAZUgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:36:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:9982 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbiAZUgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643229393; x=1674765393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6a7ksHqrFBRFuzuDvYBCJL8gq6YspyfPiiCWbUNdnw=;
  b=FeGoxmCIwdbQsyjBovX/jVsnADXq5WgfQzRF9f3Lkg9f/FWbh7xDTBZQ
   HcXbWqQd3GqzhV3hff32BZ2nWblMsYcvHjppj4Krdxtrk8ou97h8d5Azi
   o18MAMEp92qmjQ/9dKUogBvavkMN9pK6d75l431oC83sRgI4dWC4cTFhx
   6SpKVto/chapLcEYFEX2zRdsJaqkg09XZHj8A96ZDKkGTMZzZ1HW9t5ze
   0Jalp/E1OpC8jAT6HUQMLnoeKrzEpSIuE3aM2wP0Sa7sdbrv46A6dzR+m
   c/HTf68LCUUgmu/bYzd/CAaGAvJC9FerREWnXTAA460aLegYZqhPClXd1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271098460"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="271098460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="581221487"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:21 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Matt Roper <matthew.d.roper@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH 00/19] drm/i915/guc: Refactor ADS access to use dma_buf_map
Date:   Wed, 26 Jan 2022 12:36:43 -0800
Message-Id: <20220126203702.1784589-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While porting i915 to arm64 we noticed some issues accessing lmem.
Some writes were getting corrupted and the final state of the buffer
didn't have exactly what we wrote. This became evident when enabling
GuC submission: depending on the number of engines the ADS struct was
being corrupted and GuC would reject it, refusin to initialize.

From Documentation/core-api/bus-virt-phys-mapping.rst:

	This memory is called "PCI memory" or "shared memory" or "IO memory" or
	whatever, and there is only one way to access it: the readb/writeb and
	related functions. You should never take the address of such memory, because
	there is really nothing you can do with such an address: it's not
	conceptually in the same memory space as "real memory" at all, so you cannot
	just dereference a pointer. (Sadly, on x86 it **is** in the same memory space,
	so on x86 it actually works to just deference a pointer, but it's not
	portable).

When reading or writing words directly to IO memory, in order to be portable
the Linux kernel provides the abstraction detailed in section "Differences
between I/O access functions" of Documentation/driver-api/device-io.rst.

This limits our ability to simply overlay our structs on top a buffer
and directly access it since that buffer may come from IO memory rather than
system memory. Hence the approach taken in intel_guc_ads.c needs to be
refactored. This is not the only place in i915 that neeed to be changed, but
the one causing the most problems, with a real reproducer. This first set of
patch focuses on fixing the gem object to pass the ADS

After the addition of a few helpers in the dma_buf_map API, most of
intel_guc_ads.c can be converted to use it. The exception is the regset
initialization: we'd incur into a lot of extra indirection when
reading/writting each register. So the regset is converted to use a
temporary buffer allocated on probe, which is then copied to its
final location when finishing the initialization or on gt reset.

Testing on some discrete cards, after this change we can correctly pass the
ADS struct to GuC and have it initialized correctly.

thanks
Lucas De Marchi

Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>

Lucas De Marchi (19):
  dma-buf-map: Add read/write helpers
  dma-buf-map: Add helper to initialize second map
  drm/i915/gt: Add helper for shmem copy to dma_buf_map
  drm/i915/guc: Keep dma_buf_map of ads_blob around
  drm/i915/guc: Add read/write helpers for ADS blob
  drm/i915/guc: Convert golden context init to dma_buf_map
  drm/i915/guc: Convert policies update to dma_buf_map
  drm/i915/guc: Convert engine record to dma_buf_map
  dma-buf-map: Add wrapper over memset
  drm/i915/guc: Convert guc_ads_private_data_reset to dma_buf_map
  drm/i915/guc: Convert golden context prep to dma_buf_map
  drm/i915/guc: Replace check for golden context size
  drm/i915/guc: Convert mapping table to dma_buf_map
  drm/i915/guc: Convert capture list to dma_buf_map
  drm/i915/guc: Prepare for error propagation
  drm/i915/guc: Use a single pass to calculate regset
  drm/i915/guc: Convert guc_mmio_reg_state_init to dma_buf_map
  drm/i915/guc: Convert __guc_ads_init to dma_buf_map
  drm/i915/guc: Remove plain ads_blob pointer

 drivers/gpu/drm/i915/gt/shmem_utils.c         |  32 ++
 drivers/gpu/drm/i915/gt/shmem_utils.h         |   3 +
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |  14 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c    | 374 +++++++++++-------
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.h    |   3 +-
 .../gpu/drm/i915/gt/uc/intel_guc_submission.c |  11 +-
 include/linux/dma-buf-map.h                   | 127 ++++++
 7 files changed, 405 insertions(+), 159 deletions(-)

-- 
2.35.0

