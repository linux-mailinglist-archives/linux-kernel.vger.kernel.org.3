Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9633568709
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiGFLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiGFLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:44:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0D2183
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657107842; x=1688643842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMJWfltOfFJMxVswzKOrQgNi1Q52cAI5noW02Iljmjk=;
  b=AO/eKxBDmrNXUu6QchsiGl/4OKVEJK/CvukKXqUTF1ZVBeEGesKJ9xUU
   QaJOtRpwVDoILzBvKoCEuLAtFp/C+0vYNo6bPC0yPZ4ln6/l0y8WhQ5dX
   uN2n4oXfKf8gwKpZVjSnjyrkjch1XeztV38Wxsk/rQx9RaznVYqvXEseQ
   jlF2bJcC0n5Kl5T/XqTvhfH+xcNhOxOHhUd4ZXBCCaDGPDW2dRRlMXzz6
   ycr9WMIe+RNf1ZUm/fVr0bIbYOm+vtVE0DL+snNjuZWl6PeRObvROUnLd
   PR0Wt+nAo8ZcvohnMhfyXob+iGRyHiEJt2BYb8s9W2wP598ZjpcZBCQT3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347707433"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="347707433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:44:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="650630092"
Received: from sannilnx.jer.intel.com ([10.12.26.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:43:59 -0700
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
Subject: [PATCH v5 01/14] drm/i915/gsc: skip irq initialization if using polling
Date:   Wed,  6 Jul 2022 14:43:32 +0300
Message-Id: <20220706114345.1128018-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706114345.1128018-1-alexander.usyskin@intel.com>
References: <20220706114345.1128018-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.34.1

