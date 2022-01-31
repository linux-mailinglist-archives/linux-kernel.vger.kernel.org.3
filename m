Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184614A4EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358905AbiAaSw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:52:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35798 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358413AbiAaSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:52:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id BB7781F436A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643655169;
        bh=wakhSFcVMZevZPcycdryY+hpEED54NWm/zeUvW6H0hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOPSbgjguKnZ8iFzvII5pfkX6yo/SJn8fiiFR1z7wNky9y3wcuLj4JOjvPuc0XH4W
         0XYhZxdYK7t/iZnV3fXhtiUB73nNWNmcce9frXA+KT3koQpGjfrEu/FxAL+/vVx4O8
         QMz4XIsalDBQ1ajo49uKIowBFNQ1t9OqYGI0wX6lDSiqVfDVrECTIvhQseX4c69Cbl
         nt5+TKGotF0OjKVxktFdTNzpekR0HUkOcrHQVax4u3pGkiMdohCbzN7+t/jqptCAWU
         H2I0Op521/0VvRygmKtQHxKekaP2pfiH33iH0Zqbb2XQADZyocVpuJLv0zOZDUBNWA
         bBgnjOpQvfHow==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Ramalingam C <ramalingam.c@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] drm/i915: add needs_compact_pt flag
Date:   Mon, 31 Jan 2022 18:52:27 +0000
Message-Id: <20220131185231.725346-2-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131185231.725346-1-bob.beckett@collabora.com>
References: <20220131185231.725346-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramalingam C <ramalingam.c@intel.com>

Add a new platform flag, needs_compact_pt, to mark the requirement of
compact pt layout support for the ppGTT when using 64K GTT pages.

With this flag has_64k_pages will only indicate requirement of 64K
GTT page sizes or larger for device local memory access.

v6:
	* minor doc formatting

Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h          | 11 ++++++++---
 drivers/gpu/drm/i915/i915_pci.c          |  2 ++
 drivers/gpu/drm/i915/intel_device_info.h |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 00e7594b59c9..4afdfa5fd3b3 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1512,12 +1512,17 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 
 /*
  * Set this flag, when platform requires 64K GTT page sizes or larger for
- * device local memory access. Also this flag implies that we require or
- * at least support the compact PT layout for the ppGTT when using the 64K
- * GTT pages.
+ * device local memory access.
  */
 #define HAS_64K_PAGES(dev_priv) (INTEL_INFO(dev_priv)->has_64k_pages)
 
+/*
+ * Set this flag when platform doesn't allow both 64k pages and 4k pages in
+ * the same PT. this flag means we need to support compact PT layout for the
+ * ppGTT when using the 64K GTT pages.
+ */
+#define NEEDS_COMPACT_PT(dev_priv) (INTEL_INFO(dev_priv)->needs_compact_pt)
+
 #define HAS_IPC(dev_priv)		 (INTEL_INFO(dev_priv)->display.has_ipc)
 
 #define HAS_REGION(i915, i) (INTEL_INFO(i915)->memory_regions & (i))
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 2df2db0a5d70..ce6ae6a3cbdf 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1028,6 +1028,7 @@ static const struct intel_device_info xehpsdv_info = {
 	PLATFORM(INTEL_XEHPSDV),
 	.display = { },
 	.has_64k_pages = 1,
+	.needs_compact_pt = 1,
 	.platform_engine_mask =
 		BIT(RCS0) | BIT(BCS0) |
 		BIT(VECS0) | BIT(VECS1) | BIT(VECS2) | BIT(VECS3) |
@@ -1046,6 +1047,7 @@ static const struct intel_device_info dg2_info = {
 	PLATFORM(INTEL_DG2),
 	.has_guc_deprivilege = 1,
 	.has_64k_pages = 1,
+	.needs_compact_pt = 1,
 	.platform_engine_mask =
 		BIT(RCS0) | BIT(BCS0) |
 		BIT(VECS0) | BIT(VECS1) |
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index abf1e103c558..d8da40d01dca 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -130,6 +130,7 @@ enum intel_ppgtt_type {
 	/* Keep has_* in alphabetical order */ \
 	func(has_64bit_reloc); \
 	func(has_64k_pages); \
+	func(needs_compact_pt); \
 	func(gpu_reset_clobbers_display); \
 	func(has_reset_engine); \
 	func(has_global_mocs); \
-- 
2.25.1

