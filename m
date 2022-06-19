Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B24550AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiFSNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiFSNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:37:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9817C4D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655645876; x=1687181876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSmcXoZx1tsMcQcOYD1yikOteulbwH8GaQawx8yjFP0=;
  b=Erx6+bG1FwOFzdDKnBvZj+yaujIPziNypFg+YNHpjWTVmQqY+VKEZ1Db
   tc+hIymo9hp1+x9PpBtDV8ePwDUtbUP+W2+wwYxsouPyl5E6VNPeX2Yh0
   ylBa8IwXzc7/G72IYKAphNEGzoSmKWEoIKa5BobzNL2UtlGZoO6GUYGBf
   t7jw0AX9CqrJUnXbfJh/MpO+pCt+VggM5ZBaMcgBOtKCZP+FTd0rLQI6A
   uFUhTNjyLuoj1L1bkGOGGoMNjtSlLWF5ImWxbm0+T6k1dzgcSRIZmcnuO
   7rFuOSD5agbvde/9R2LaMIAlEbEQDiCvD3aibYHlCAM/z3AidVcbnVvq+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305164697"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305164697"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="676158509"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:37:45 -0700
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
Subject: [PATCH v3 04/14] drm/i915/gsc: add slow_fw flag to the gsc device definition
Date:   Sun, 19 Jun 2022 16:37:11 +0300
Message-Id: <20220619133721.523546-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220619133721.523546-1-alexander.usyskin@intel.com>
References: <20220619133721.523546-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_fw flag to the gsc device definition
and pass it to mei auxiliary device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index e0236ff1d072..f963c220bbff 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -41,6 +41,7 @@ struct gsc_def {
 	unsigned long bar;
 	size_t bar_size;
 	bool use_polling;
+	bool slow_fw;
 };
 
 /* gsc resources and definitions (HECI1 and HECI2) */
@@ -145,6 +146,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 	adev->bar.end = adev->bar.start + def->bar_size - 1;
 	adev->bar.flags = IORESOURCE_MEM;
 	adev->bar.desc = IORES_DESC_NONE;
+	adev->slow_fw = def->slow_fw;
 
 	aux_dev = &adev->aux_dev;
 	aux_dev->name = def->name;
-- 
2.32.0

