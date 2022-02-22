Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97AA4BF691
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiBVKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiBVKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:49:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B1156943
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645526962; x=1677062962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SsYyexNSuf2/lu44Z54F2/PLKKOWl5dU819XF1DWoKM=;
  b=EyCT1t2783ZdhYg/gp8WXCBzpui327GgxNrcJ/gsZrDmpqT5PlwYiEZb
   RY8RdipqVhi6CXQVmD6kNHYKSdefHGVoE1NBIm15AYgEpvBcgNuiiF5jU
   LMCFvtTJIJKQ2i05uPPYO1NIspY4fzP/vNq1CVTffUsKJfqFFFpzpxckB
   UQCp1q+3yf2U3JSIi0/JsvRF0ho0lTQuGJqXBhECTyp3S8aHSPog0T4xn
   xy7qP0HP3DAKYK3fk5blG5VQwyUHlF1Z7dvPam71kx1vDOypxvedn/ijO
   B604xAHXQIh4jp7FVeCHpbK4hIVG8ZdKWvLWyeznScTtNMvY7E/mYYgJx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232288536"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232288536"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:49:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706569547"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:49:17 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drm/i915/gsc: skip irq initialization if using polling
Date:   Tue, 22 Feb 2022 12:48:48 +0200
Message-Id: <20220222104854.3188643-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222104854.3188643-1-alexander.usyskin@intel.com>
References: <20220222104854.3188643-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

If we use polling instead of interrupts,
irq initialization should be skipped.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 152804e7c41a..db01cfda78f1 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -40,6 +40,7 @@ struct intel_gsc_def {
 	const char *name;
 	unsigned long bar;
 	size_t bar_size;
+	bool use_polling;
 };
 
 /* gscfi (graphics system controller firmware interface) resources */
@@ -97,6 +98,10 @@ static void intel_gsc_init_one(struct drm_i915_private *i915,
 		return;
 	}
 
+	/* skip irq initialization */
+	if (def->use_polling)
+		goto add_device;
+
 	intf->irq = irq_alloc_desc(0);
 	if (intf->irq < 0) {
 		drm_err(&i915->drm, "gsc irq error %d\n", intf->irq);
@@ -109,6 +114,7 @@ static void intel_gsc_init_one(struct drm_i915_private *i915,
 		goto fail;
 	}
 
+add_device:
 	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
 	if (!adev)
 		goto fail;
@@ -162,10 +168,8 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 		return;
 	}
 
-	if (gt->gsc.intf[intf_id].irq < 0) {
-		drm_err_ratelimited(&gt->i915->drm, "GSC irq: irq not set");
+	if (gt->gsc.intf[intf_id].irq < 0)
 		return;
-	}
 
 	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
 	if (ret)
-- 
2.32.0

