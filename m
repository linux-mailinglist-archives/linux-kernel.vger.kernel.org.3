Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97194F4979
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389821AbiDEWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455533AbiDEQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D169CFE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:16:21 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A85A31EC04AD;
        Tue,  5 Apr 2022 17:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649171775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGJa0G6U1JecsWznE/utyL4y2G3RA/n/MPX3Y999g1s=;
        b=Vv89Iy1RDuMgx2vBuJ6aiufMexPWUh3MwGTqNBEOMUUhvHSB0y8l2i69tK9QwFOTtuNDJM
        YhHKXgrhnLfqWafTqbUHa+rJKTyO/uE+N20XydbXc8BMlMkux0OrZIvNSwNf7URINzmz/1
        0AGyqz6lX0GmQs7bIP+Sz5dGRRy6VmQ=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/11] drm/i915: Fix undefined behavior due to shift overflowing the constant
Date:   Tue,  5 Apr 2022 17:15:17 +0200
Message-Id: <20220405151517.29753-12-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405151517.29753-1-bp@alien8.de>
References: <20220405151517.29753-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix:

  In file included from <command-line>:0:0:
  drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function ‘intel_guc_send_mmio’:
  ././include/linux/compiler_types.h:352:38: error: call to ‘__compiletime_assert_1047’ \
  declared with attribute error: FIELD_PREP: mask is not constant
    _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

and other build errors due to shift overflowing values.

See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
details as to why it triggers with older gccs only.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 .../gpu/drm/i915/gt/uc/abi/guc_actions_abi.h   |  2 +-
 .../i915/gt/uc/abi/guc_communication_ctb_abi.h |  2 +-
 .../gpu/drm/i915/gt/uc/abi/guc_messages_abi.h  |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h     |  2 +-
 drivers/gpu/drm/i915/i915_reg.h                | 18 +++++++++---------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
index 7afdadc7656f..e835f28c0020 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
@@ -50,7 +50,7 @@
 
 #define HOST2GUC_SELF_CFG_REQUEST_MSG_LEN		(GUC_HXG_REQUEST_MSG_MIN_LEN + 3u)
 #define HOST2GUC_SELF_CFG_REQUEST_MSG_0_MBZ		GUC_HXG_REQUEST_MSG_0_DATA0
-#define HOST2GUC_SELF_CFG_REQUEST_MSG_1_KLV_KEY		(0xffff << 16)
+#define HOST2GUC_SELF_CFG_REQUEST_MSG_1_KLV_KEY		(0xffffU << 16)
 #define HOST2GUC_SELF_CFG_REQUEST_MSG_1_KLV_LEN		(0xffff << 0)
 #define HOST2GUC_SELF_CFG_REQUEST_MSG_2_VALUE32		GUC_HXG_REQUEST_MSG_n_DATAn
 #define HOST2GUC_SELF_CFG_REQUEST_MSG_3_VALUE64		GUC_HXG_REQUEST_MSG_n_DATAn
diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
index c9086a600bce..df83c1cc7c7a 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
@@ -82,7 +82,7 @@ static_assert(sizeof(struct guc_ct_buffer_desc) == 64);
 #define GUC_CTB_HDR_LEN				1u
 #define GUC_CTB_MSG_MIN_LEN			GUC_CTB_HDR_LEN
 #define GUC_CTB_MSG_MAX_LEN			256u
-#define GUC_CTB_MSG_0_FENCE			(0xffff << 16)
+#define GUC_CTB_MSG_0_FENCE			(0xffffU << 16)
 #define GUC_CTB_MSG_0_FORMAT			(0xf << 12)
 #define   GUC_CTB_FORMAT_HXG			0u
 #define GUC_CTB_MSG_0_RESERVED			(0xf << 8)
diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
index 29ac823acd4c..7d5ba4d97d70 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
@@ -40,7 +40,7 @@
  */
 
 #define GUC_HXG_MSG_MIN_LEN			1u
-#define GUC_HXG_MSG_0_ORIGIN			(0x1 << 31)
+#define GUC_HXG_MSG_0_ORIGIN			(0x1U << 31)
 #define   GUC_HXG_ORIGIN_HOST			0u
 #define   GUC_HXG_ORIGIN_GUC			1u
 #define GUC_HXG_MSG_0_TYPE			(0x7 << 28)
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h
index 66027a42cda9..ad570fa002a6 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h
@@ -28,7 +28,7 @@
 #define   GS_MIA_HALT_REQUESTED		  (0x02 << GS_MIA_SHIFT)
 #define   GS_MIA_ISR_ENTRY		  (0x04 << GS_MIA_SHIFT)
 #define   GS_AUTH_STATUS_SHIFT		30
-#define   GS_AUTH_STATUS_MASK		  (0x03 << GS_AUTH_STATUS_SHIFT)
+#define   GS_AUTH_STATUS_MASK		  (0x03U << GS_AUTH_STATUS_SHIFT)
 #define   GS_AUTH_STATUS_BAD		  (0x01 << GS_AUTH_STATUS_SHIFT)
 #define   GS_AUTH_STATUS_GOOD		  (0x02 << GS_AUTH_STATUS_SHIFT)
 
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 3c87d77d2cf6..f3ba3d0a430b 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7555,19 +7555,19 @@ enum skl_power_gate {
 #define  PORT_CLK_SEL_LCPLL_810		(2 << 29)
 #define  PORT_CLK_SEL_SPLL		(3 << 29)
 #define  PORT_CLK_SEL_WRPLL(pll)	(((pll) + 4) << 29)
-#define  PORT_CLK_SEL_WRPLL1		(4 << 29)
-#define  PORT_CLK_SEL_WRPLL2		(5 << 29)
-#define  PORT_CLK_SEL_NONE		(7 << 29)
-#define  PORT_CLK_SEL_MASK		(7 << 29)
+#define  PORT_CLK_SEL_WRPLL1		(4U << 29)
+#define  PORT_CLK_SEL_WRPLL2		(5U << 29)
+#define  PORT_CLK_SEL_NONE		(7U << 29)
+#define  PORT_CLK_SEL_MASK		(7U << 29)
 
 /* On ICL+ this is the same as PORT_CLK_SEL, but all bits change. */
 #define DDI_CLK_SEL(port)		PORT_CLK_SEL(port)
 #define  DDI_CLK_SEL_NONE		(0x0 << 28)
-#define  DDI_CLK_SEL_MG			(0x8 << 28)
-#define  DDI_CLK_SEL_TBT_162		(0xC << 28)
-#define  DDI_CLK_SEL_TBT_270		(0xD << 28)
-#define  DDI_CLK_SEL_TBT_540		(0xE << 28)
-#define  DDI_CLK_SEL_TBT_810		(0xF << 28)
+#define  DDI_CLK_SEL_MG			(0x8U << 28)
+#define  DDI_CLK_SEL_TBT_162		(0xCU << 28)
+#define  DDI_CLK_SEL_TBT_270		(0xDU << 28)
+#define  DDI_CLK_SEL_TBT_540		(0xEU << 28)
+#define  DDI_CLK_SEL_TBT_810		(0xFU << 28)
 #define  DDI_CLK_SEL_MASK		(0xF << 28)
 
 /* Transcoder clock selection */
-- 
2.35.1

