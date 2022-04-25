Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5B50DA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbiDYHwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiDYHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519F2E3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872960; x=1682408960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hK7yiUXp498V4zt6tzB6Sd6pGY/AmK3IGLLegWnAMsM=;
  b=aAeb9PyNURD86uau0XLsJHb2Rd+OjzuqRpRgweszAhHUj3ntTy+pJsZO
   tF1Iuwi0dqifQ1KXpwmIS56RWp5Tn7grXMpN4ZEfDmFI9kUThTQU6a0Eg
   N1TONp5Gcq1+6rtdsrVmeGy7wJI8pn+t5VsTYX6WdOC/sJx0xJ31zUhHe
   6xyll94UwrgKaKRQ3IOKmlip7QtRaXdc+9wCLbl4lt3kyv+ImiuDGeHiv
   B7F8fsfSWB14w/7V/2KpT+OeQ9S0lbE4tjeDVYe7g/pF43YA2CbHuGFV7
   aTIu5Fv2gjc91sEAdj3TOw3W+GrIb1w35l5mJPkBWCGP71y8qqlUS7BE5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264973648"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264973648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557599878"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:16 -0700
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
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v2 02/14] drm/i915/gsc: skip irq initialization if using polling
Date:   Mon, 25 Apr 2022 10:48:49 +0300
Message-Id: <20220425074901.3991274-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425074901.3991274-1-alexander.usyskin@intel.com>
References: <20220425074901.3991274-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Some platforms require the host to poll on the
GSC registers instead of relaying on the interrupts.
For those platforms, irq initialization should be skipped

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 0e494028b81d..e0236ff1d072 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -40,6 +40,7 @@ struct gsc_def {
 	const char *name;
 	unsigned long bar;
 	size_t bar_size;
+	bool use_polling;
 };
 
 /* gsc resources and definitions (HECI1 and HECI2) */
@@ -117,6 +118,10 @@ static void gsc_init_one(struct drm_i915_private *i915,
 		return;
 	}
 
+	/* skip irq initialization */
+	if (def->use_polling)
+		goto add_device;
+
 	intf->irq = irq_alloc_desc(0);
 	if (intf->irq < 0) {
 		drm_err(&i915->drm, "gsc irq error %d\n", intf->irq);
@@ -129,6 +134,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 		goto fail;
 	}
 
+add_device:
 	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
 	if (!adev)
 		goto fail;
@@ -182,10 +188,8 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
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

