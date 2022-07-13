Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA78B5732C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiGMJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiGMJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D546BEE1F8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7229861CAE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A02C341D9;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=numqK226xRmWDfGwHz4d5UBb1H2QKPgM+SkFWYMj/wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAbvoxeX0Ggt9W/GCv9SVYOeovlGpOZD7jsBImb7PhuMpPL2NV8AhwQ++WOQu4lrB
         SUFyClvGEs4Jh5lWKYfxQh10iKBOLOeePFezzCpaFRTjbNYFrfs1Hk1hfPScgpx01h
         U8CkhvAz/xu6hzblOMsgFz0qlGbul9WvQZjHYE3/1RpfcMB1Qlr+P02h3BFpKqcjHS
         sS20FeC369U3qu6cIZ6Dgj4d1dEaOEH60H2bj5eHrKshkRYqww6UBRRXQOn1GXeKyr
         Eyf4Z9cki4QvvUYKZtXqo8fxAGZXuhkmnP5p4jUvpuEuQAuv9m7PFCVY4bfaWGQw+k
         FPVMJi2zh3RpQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050Lg-PO;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] drm/i915/guc: document the TLB invalidation struct members
Date:   Wed, 13 Jul 2022 10:30:08 +0100
Message-Id: <b2475a1e10f643124c2bd60747051eb319fa15b4.1657703926.git.mchehab@kernel.org>
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

Add documentation for the 3 new members of struct intel_guc
that are used to handle TLB cache invalidation logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/uc/intel_guc.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
index f82a121b0838..73c46d405dc4 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -76,11 +76,23 @@ struct intel_guc {
 	 */
 	atomic_t outstanding_submission_g2h;
 
-	/** @interrupts: pointers to GuC interrupt-managing functions. */
+	/**
+	 * @tlb_lookup: TLB cache invalidation lookup table.
+	 */
 	struct xarray tlb_lookup;
+
+	/**
+	 * @serial_slot: index to the latest allocated element at the
+	 * @tlb_lookup xarray.
+	 */
 	u32 serial_slot;
+
+	/**
+	 * @next_seqno: next index to be allocated at the @tlb_lookup xarray.
+	 */
 	u32 next_seqno;
 
+	/** @interrupts: pointers to GuC interrupt-managing functions. */
 	struct {
 		void (*reset)(struct intel_guc *guc);
 		void (*enable)(struct intel_guc *guc);
-- 
2.36.1

