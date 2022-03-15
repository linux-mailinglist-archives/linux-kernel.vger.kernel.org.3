Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2394DA1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbiCOSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350904AbiCOSGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:06:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CE4163A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:05:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 529E31F43052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647367510;
        bh=ToS8lMBol1VOlB+6o7QPgccbMJbV2qQuGt1LNM0xKzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mgkg5vPTu4489UhKxp8356PXehcPFvkKbjF4txpVFKtgjZcdn/BNH7T2RjOfcjs1x
         xAIph6X0fJLkVMe66iZV8BqufuSMIsd+7jeNY4dqCHVQFHqSvB/RvQ2l8Iz2Lu0Ra+
         JM1CxniNI6V+X3CHmiOTM9J18gmykw6nbqT3MEkhSyp7d/GyuWVdAQUFFpJJeZdY50
         IadRUhuf7ASVgfyWCLSOvg8cwvgw0VXhKdMXfqSTDTKkUq+GvxbO4/rSZXc2W46s1D
         M7QvkaLWvHwRBT4XU3ma1Rhf17am85K2T6T1kJPcezv5iauWB44jUt6nd5D18K1VK0
         klN+6aJcrNrtw==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] drm/i915: add range busy check for ttm region
Date:   Tue, 15 Mar 2022 18:04:43 +0000
Message-Id: <20220315180444.3327283-7-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315180444.3327283-1-bob.beckett@collabora.com>
References: <20220315180444.3327283-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC: should this become a generic interface in intel_memory_region_ops?

RFC: would we prefer an different interface? e.g. for_each_obj_in_range

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/intel_region_ttm.c | 19 +++++++++++++++++++
 drivers/gpu/drm/i915/intel_region_ttm.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index bb564b830c96..2ccefa76348f 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -256,3 +256,22 @@ void intel_region_ttm_resource_free(struct intel_memory_region *mem,
 
 	man->func->free(man, res);
 }
+
+/**
+ * intel_region_ttm_range_busy - check whether range has any allocations
+ * @mem: The region to check
+ * @start: the start of the range to check
+ * @end: the end of the range to check
+ *
+ * Return: true if something is alloceted within the region, false otherwise.
+ */
+bool intel_region_ttm_range_busy(struct intel_memory_region *mem,
+				 u64 start, u64 end)
+{
+	struct ttm_resource_manager *man = mem->region_private;
+
+	/* currently only supported for range allocator */
+	GEM_BUG_ON(!mem->is_range_manager);
+
+	return ttm_range_man_range_busy(man, PFN_DOWN(start), PFN_UP(end));
+}
diff --git a/drivers/gpu/drm/i915/intel_region_ttm.h b/drivers/gpu/drm/i915/intel_region_ttm.h
index fdee5e7bd46c..670ba9b618f7 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.h
+++ b/drivers/gpu/drm/i915/intel_region_ttm.h
@@ -29,6 +29,9 @@ intel_region_ttm_resource_to_rsgt(struct intel_memory_region *mem,
 void intel_region_ttm_resource_free(struct intel_memory_region *mem,
 				    struct ttm_resource *res);
 
+bool intel_region_ttm_range_busy(struct intel_memory_region *mem,
+				 u64 start, u64 end);
+
 int intel_region_to_ttm_type(const struct intel_memory_region *mem);
 
 struct ttm_device_funcs *i915_ttm_driver(void);
-- 
2.25.1

