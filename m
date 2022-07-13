Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997085732C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiGMJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiGMJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487CF2E20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E162A61CC0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5700FC341E1;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=Fkt5pO3rEYdJ3e4kKvqhVhroFKgVT0cB8fjVsWq7iJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtajU/xM0JkvFZqJ7Nf4uF2iZiE0nK5yPJQ8l7fIR1i/sE7K9j+uHglsYT5rjO/4G
         LUq9n3d3msgBx+dsGR28QhSXXaQtpSA05/M1Os/bRWtjpITdX33ms66GPMx4jjHfSp
         N/gyvlDR0Z0Sa9HGNzsrW7PFhaEJ6bXOnDiaqcc2bBz4qxnF5mDYFo4vIjLSdUIlYS
         hLuSWjCx7wYdmbuOVDuo4knHlVBqZ0X43uXNf6uBQwciTyK4rua1zJpO9VCAloIxjy
         CJB5s45etREBQlrAIYhFvuYZS2hrBrm2Uq66BCtgYkUmttfX0yqF2uyTksbIkjEW4G
         R7dBFJyiC/J7Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050Ll-Q7;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] drm/i915/guc: Introduce TLB_INVALIDATION_ALL action
Date:   Wed, 13 Jul 2022 10:30:09 +0100
Message-Id: <da6057ddd6b308f023434984e5e33f9e5f28432c.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657703926.git.mchehab@kernel.org>
References: <cover.1657703926.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

Add a new way to invalidate TLB via GuC using actions 0x7002
(TLB_INVALIDATION_ALL).

Those actions will be used on upcoming patches.

Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h |  1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc.c           | 14 ++++++++++++++
 drivers/gpu/drm/i915/gt/uc/intel_guc.h           |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
index 14e35a2f8306..fb0af33e43cc 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
@@ -138,6 +138,7 @@ enum intel_guc_action {
 	INTEL_GUC_ACTION_PAGE_FAULT_NOTIFICATION = 0x6001,
 	INTEL_GUC_ACTION_TLB_INVALIDATION = 0x7000,
 	INTEL_GUC_ACTION_TLB_INVALIDATION_DONE = 0x7001,
+	INTEL_GUC_ACTION_TLB_INVALIDATION_ALL = 0x7002,
 	INTEL_GUC_ACTION_STATE_CAPTURE_NOTIFICATION = 0x8002,
 	INTEL_GUC_ACTION_NOTIFY_FLUSH_LOG_BUFFER_TO_FILE = 0x8003,
 	INTEL_GUC_ACTION_NOTIFY_CRASH_DUMP_POSTED = 0x8004,
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
index 5c59f9b144a3..8a104a292598 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -945,6 +945,20 @@ int intel_guc_invalidate_tlb_guc(struct intel_guc *guc,
 	return guc_send_invalidate_tlb(guc, action, ARRAY_SIZE(action));
 }
 
+int intel_guc_invalidate_tlb_all(struct intel_guc *guc)
+{
+	u32 action[] = {
+		INTEL_GUC_ACTION_TLB_INVALIDATION_ALL,
+		0,
+		INTEL_GUC_TLB_INVAL_MODE_HEAVY << INTEL_GUC_TLB_INVAL_MODE_SHIFT |
+		INTEL_GUC_TLB_INVAL_FLUSH_CACHE,
+	};
+
+	GEM_BUG_ON(!INTEL_GUC_SUPPORTS_TLB_INVALIDATION(guc));
+
+	return guc_send_invalidate_tlb(guc, action, ARRAY_SIZE(action));
+}
+
 /**
  * intel_guc_load_status - dump information about GuC load status
  * @guc: the GuC
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
index 73c46d405dc4..01c6478451cc 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -386,6 +386,7 @@ int intel_guc_self_cfg64(struct intel_guc *guc, u16 key, u64 value);
 
 int intel_guc_invalidate_tlb_guc(struct intel_guc *guc,
 				 enum intel_guc_tlb_inval_mode mode);
+int intel_guc_invalidate_tlb_all(struct intel_guc *guc);
 
 static inline bool intel_guc_is_supported(struct intel_guc *guc)
 {
-- 
2.36.1

