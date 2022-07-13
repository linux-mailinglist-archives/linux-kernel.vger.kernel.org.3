Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D05732CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiGMJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiGMJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85977F32E1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1694C61CCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6567CC341E0;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=MTo5LFJQmGswJidJuW/ez8S5JqY/AKBuALalK+cXQ8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6VeyuVSXZZSy5+N68xJ7UWpZDSidffSrdw4xCYZWbZ1dHZz1Py5khbHhDZLWvr6O
         6DMNp8RJ0NKHZ3l9QN4O2WIrIduhDgmLtgo3Pag0KSkdB5kEU8k4bL1k/wmcZOxzTe
         GLQ94XCBNRELc17vCSdYPiiCLjHu5xHZCBalbCkPzC85Z13M3wXjxI7EE5bVJcMvzA
         kjCZJ2fK27RTma6tNZpFTPVrZrkPa4CtAiQ6tEQTXkDZYBI0qOiLTloF0VvkCEqF8o
         Lt6wZhCMdT8rzT1qmB25wyhWM2WY27BnZ0AhU/PA1zqnRRX7Hk7hSEs4Z/4p5XwvMU
         UQucqp0c2+uJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhI-0050MJ-0i;
        Wed, 13 Jul 2022 10:30:20 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/21] drm/i915/guc: document TLB cache invalidation functions
Date:   Wed, 13 Jul 2022 10:30:18 +0100
Message-Id: <51f5a4d4e209e27eaf82683d56e7747a183fb051.1657703926.git.mchehab@kernel.org>
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

Add documentation for the kAPI functions that do TLB cache
invalidation via GuC.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/uc/intel_guc.c | 52 ++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
index 98260a7bc90b..173833bc3a62 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -923,7 +923,14 @@ static int guc_send_invalidate_tlb(struct intel_guc *guc, u32 *action, u32 size)
 	return err;
 }
 
- /* Full TLB invalidation */
+/**
+ * intel_guc_invalidate_tlb_full - GuC full TLB invalidation
+ *
+ * @guc: the guc
+ * @mode: mode of TLB cache invalidation (heavy or lite)
+ *
+ * Use GuC to do a full TLB cache invalidation if supported.
+ */
 int intel_guc_invalidate_tlb_full(struct intel_guc *guc,
 				  enum intel_guc_tlb_inval_mode mode)
 {
@@ -943,8 +950,17 @@ int intel_guc_invalidate_tlb_full(struct intel_guc *guc,
 	return guc_send_invalidate_tlb(guc, action, ARRAY_SIZE(action));
 }
 
-/*
- * Selective TLB Invalidation for Address Range:
+/**
+ * intel_guc_invalidate_tlb_page_selective - GuC selective TLB invalidation
+ *	for an address range
+ *
+ * @guc: the guc
+ * @mode: mode of TLB cache invalidation (heavy or lite)
+ * @start: range start
+ * @length: range length
+ *
+ * Use GuC to do a selective TLB invalidation if supported.
+ *
  * TLB's in the Address Range is Invalidated across all engines.
  */
 int intel_guc_invalidate_tlb_page_selective(struct intel_guc *guc,
@@ -978,8 +994,18 @@ int intel_guc_invalidate_tlb_page_selective(struct intel_guc *guc,
 	return guc_send_invalidate_tlb(guc, action, ARRAY_SIZE(action));
 }
 
-/*
- * Selective TLB Invalidation for Context:
+/**
+ * intel_guc_invalidate_tlb_page_selective_ctx - GuC selective TLB
+ *	invalidation for a context
+ *
+ * @guc: the guc
+ * @mode: mode of TLB cache invalidation (heavy or lite)
+ * @start: range start
+ * @length: range length
+ * @ctxid: context ID
+ *
+ * Use GuC to do a selective TLB invalidation on a context if supported.
+ *
  * Invalidates all TLB's for a specific context across all engines.
  */
 int intel_guc_invalidate_tlb_page_selective_ctx(struct intel_guc *guc,
@@ -1013,8 +1039,13 @@ int intel_guc_invalidate_tlb_page_selective_ctx(struct intel_guc *guc,
 	return guc_send_invalidate_tlb(guc, action, ARRAY_SIZE(action));
 }
 
-/*
- * Guc TLB Invalidation: Invalidate the TLB's of GuC itself.
+/**
+ * intel_guc_invalidate_tlb_guc - GuC self TLB invalidation
+ *
+ * @guc: the guc
+ * @mode: mode of TLB cache invalidation (heavy or lite)
+ *
+ * Use GuC to invalidate the TLB's of GuC itself.
  */
 int intel_guc_invalidate_tlb_guc(struct intel_guc *guc,
 				 enum intel_guc_tlb_inval_mode mode)
@@ -1035,6 +1066,13 @@ int intel_guc_invalidate_tlb_guc(struct intel_guc *guc,
 	return guc_send_invalidate_tlb(guc, action, ARRAY_SIZE(action));
 }
 
+/**
+ * intel_guc_invalidate_tlb_all - GuC global TLB invalidation
+ *
+ * @guc: the guc
+ *
+ * Use GuC to do a complete TLB invalidation on all tables
+ */
 int intel_guc_invalidate_tlb_all(struct intel_guc *guc)
 {
 	u32 action[] = {
-- 
2.36.1

