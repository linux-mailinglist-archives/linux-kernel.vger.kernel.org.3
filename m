Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF365732BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiGMJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiGMJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D542CEA14B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41D2161C5E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A05C341D3;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=d7Ye7f/yZMeD0fzLWJnDFqz2oIBKUGw1N39MIHO+bsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp/pZSEkoUvsGlC4rq7mlKo7cz2NpoAbkOwvGR8oKgWgtsy9Y0PYmJlYtjLh1w3iL
         Mh1wKOxxtP+OtWLAcjPRrPFjDKJDFr69KeSIN9wh+XG0JFNv66PSzS3wOZCNLYa2di
         hJ1AhfNhbgm2tMw5M4tBNjhTlL0b4LqziQhCSLpKcj68m9fshW+z26XHaSX0NWlr1z
         JY7+6wDu1u9TBhJwhEcBY+4W3w/BjiThWWS1FxilJIYUXJmyhNUr3T/hL3hZEuqCNr
         8jZvfKp22fAha3A/Q8/IXLsURheYzJs/LvP4XE6dpAMFOq7h3mUtmLUgzthQAii3a7
         e8v6uoFpP5ddA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050Lx-ST;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 15/21] drm/i915: Add platform macro for selective tlb flush
Date:   Wed, 13 Jul 2022 10:30:12 +0100
Message-Id: <62c27558f7add68cc60fcf765e591f8886a195f9.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657703926.git.mchehab@kernel.org>
References: <cover.1657703926.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>

Add support for selective TLB invalidation, which is a platform
feature supported on XeHP.

Signed-off-by: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_drv.h          | 3 +++
 drivers/gpu/drm/i915/i915_pci.c          | 1 +
 drivers/gpu/drm/i915/intel_device_info.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index f1f70257dbe0..73494960a3a8 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1312,6 +1312,9 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 
 #define HAS_GT_UC(dev_priv)	(INTEL_INFO(dev_priv)->has_gt_uc)
 
+#define HAS_SELECTIVE_TLB_INVALIDATION(dev_priv) \
+	(INTEL_INFO(dev_priv)->has_selective_tlb_invalidation)
+
 #define HAS_POOLED_EU(dev_priv)	(INTEL_INFO(dev_priv)->has_pooled_eu)
 
 #define HAS_GLOBAL_MOCS_REGISTERS(dev_priv)	(INTEL_INFO(dev_priv)->has_global_mocs)
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index aacc10f2e73f..30d945fe384b 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1022,6 +1022,7 @@ static const struct intel_device_info adl_p_info = {
 	.has_reset_engine = 1, \
 	.has_rps = 1, \
 	.has_runtime_pm = 1, \
+	.has_selective_tlb_invalidation = 1, \
 	.ppgtt_size = 48, \
 	.ppgtt_type = INTEL_PPGTT_FULL
 
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index 23bf230aa104..92a38b8f7c47 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -170,6 +170,7 @@ enum intel_ppgtt_type {
 	func(has_rc6p); \
 	func(has_rps); \
 	func(has_runtime_pm); \
+	func(has_selective_tlb_invalidation); \
 	func(has_snoop); \
 	func(has_coherent_ggtt); \
 	func(unfenced_needs_alignment); \
-- 
2.36.1

