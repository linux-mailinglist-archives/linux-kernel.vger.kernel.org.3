Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C575917F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiHMBJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiHMBJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:09:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27AA9269
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660352951; x=1691888951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iAHdiE53eJhFbUBHHSk44M7dSlJIiKyoBbOUgFS8F4=;
  b=MIcn1EKKP43ef5//8RHg79PiAiA5G6LZQP21rX0GV6hTVOUF9URBq27U
   D8krwkqo81vhjM+hVHqnerqAfULr2Vmd14xOABdE2qZD5dCKJCQR/9cv+
   koUZLqi6p0Bw3kQ+1xKW8sif+IsfHXJ2l4udt8bTd7i2zwFcrZu1Ylg9u
   /YZDvnGmpimqyA67FBo6ykPhIRRswlV2Q+MPq+lA8T0X8gfvHNA+JbKSZ
   jsIJEQuwfwggO533hR/qfSbRrFslgtt3vKPhvbURja62meaZ3b6xxEwqv
   2ZWojCWA5I9IbbpHjLEI5zUdje9L+oG5tUyUggP7Rex0Y8HIX7ynrhE8O
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="271488733"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="271488733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 18:09:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="666038376"
Received: from akoska-mobl1.ger.corp.intel.com (HELO hades.ger.corp.intel.com) ([10.252.36.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 18:09:08 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com
Subject: [PATCH v6 5/8] drm/i915: Check for integer truncation on the configuration of ttm place
Date:   Sat, 13 Aug 2022 04:08:54 +0300
Message-Id: <20220813010857.4043956-6-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220813010857.4043956-1-gwan-gyeong.mun@intel.com>
References: <20220813010857.4043956-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an impedance mismatch between the first/last valid page
frame number of ttm place in unsigned and our memory/page accounting in
unsigned long.
As the object size is under the control of userspace, we have to be prudent
and catch the conversion errors.
To catch the implicit truncation as we switch from unsigned long to
unsigned, we use overflows_type check and report E2BIG or overflow_type
prior to the operation.

v3: Not to change execution inside a macro. (Mauro)
    Add safe_conversion_gem_bug_on() macro and remove temporal
    SAFE_CONVERSION() macro.
v4: Fix unhandled GEM_BUG_ON() macro call from safe_conversion_gem_bug_on()
v6: Fix to follow general use case for GEM_BUG_ON(). (Jani)

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> (v2)
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v3)
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com> (v5)
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c |  6 +++---
 drivers/gpu/drm/i915/intel_region_ttm.c | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 9f2be1892b6c..30f488712abe 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -140,14 +140,14 @@ i915_ttm_place_from_region(const struct intel_memory_region *mr,
 	if (flags & I915_BO_ALLOC_CONTIGUOUS)
 		place->flags |= TTM_PL_FLAG_CONTIGUOUS;
 	if (offset != I915_BO_INVALID_OFFSET) {
-		place->fpfn = offset >> PAGE_SHIFT;
-		place->lpfn = place->fpfn + (size >> PAGE_SHIFT);
+		GEM_BUG_ON(!safe_conversion(&place->fpfn, offset >> PAGE_SHIFT));
+		GEM_BUG_ON(!safe_conversion(&place->lpfn, place->fpfn + (size >> PAGE_SHIFT)));
 	} else if (mr->io_size && mr->io_size < mr->total) {
 		if (flags & I915_BO_ALLOC_GPU_ONLY) {
 			place->flags |= TTM_PL_FLAG_TOPDOWN;
 		} else {
 			place->fpfn = 0;
-			place->lpfn = mr->io_size >> PAGE_SHIFT;
+			GEM_BUG_ON(!safe_conversion(&place->lpfn, mr->io_size >> PAGE_SHIFT));
 		}
 	}
 }
diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index 575d67bc6ffe..c480b0b50bcc 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -209,14 +209,28 @@ intel_region_ttm_resource_alloc(struct intel_memory_region *mem,
 	if (flags & I915_BO_ALLOC_CONTIGUOUS)
 		place.flags |= TTM_PL_FLAG_CONTIGUOUS;
 	if (offset != I915_BO_INVALID_OFFSET) {
-		place.fpfn = offset >> PAGE_SHIFT;
-		place.lpfn = place.fpfn + (size >> PAGE_SHIFT);
+		if (!safe_conversion(&place.fpfn, offset >> PAGE_SHIFT)) {
+			GEM_BUG_ON(!safe_conversion(&place.fpfn,offset >> PAGE_SHIFT));
+			ret = -E2BIG;
+			goto out;
+		}
+		if (!safe_conversion(&place.lpfn, place.fpfn + (size >> PAGE_SHIFT))) {
+			GEM_BUG_ON(!safe_conversion(&place.lpfn,
+						    place.fpfn + (size >> PAGE_SHIFT)));
+			ret = -E2BIG;
+			goto out;
+		}
 	} else if (mem->io_size && mem->io_size < mem->total) {
 		if (flags & I915_BO_ALLOC_GPU_ONLY) {
 			place.flags |= TTM_PL_FLAG_TOPDOWN;
 		} else {
 			place.fpfn = 0;
-			place.lpfn = mem->io_size >> PAGE_SHIFT;
+			if (!safe_conversion(&place.lpfn, mem->io_size >> PAGE_SHIFT)) {
+				GEM_BUG_ON(!safe_conversion(&place.lpfn,
+							    mem->io_size >> PAGE_SHIFT));
+				ret = -E2BIG;
+				goto out;
+			}
 		}
 	}
 
@@ -224,6 +238,8 @@ intel_region_ttm_resource_alloc(struct intel_memory_region *mem,
 	mock_bo.bdev = &mem->i915->bdev;
 
 	ret = man->func->alloc(man, &mock_bo, &place, &res);
+
+out:
 	if (ret == -ENOSPC)
 		ret = -ENXIO;
 	if (!ret)
-- 
2.34.1

