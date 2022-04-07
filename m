Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23824F7FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbiDGNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245713AbiDGNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:02:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7176585
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336434; x=1680872434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7vYITy2pH3SdPsKSfw6JD5LUWFsWbb9ZTOwd08KSkM=;
  b=nGgheS8Eg+WDsC0wzrZumGh7RavSXrGo6UHy5Kz7O3ifkDmodioMqG8h
   xNawAnmc/mjbbfxFxG9MpDFiHoP9j9bXeUpCS+cK8938lEThwzalF+aBZ
   PN7MbxoVYUeZ5BLbTgIjSaPCP20+j45eAOTjZaSTx4ZLA+9J2ghFK7bFQ
   3OEDBUA/vnPSibhJgG4VeytKmzxn4SCRUFyLzwNyIDA9Ez5rTZYDODNP0
   jXmlpAZgFvQDu0UlkOaLXw/1S9ldMjCm/lu28OGkuW/03OaZpDEOaCko8
   4Bhw+uUx5b9cD/KgBqLWUPEIAXi+aMY4BS/XGcMn1c+6XTRdqkPLaqXBh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="286293644"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="286293644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571041197"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:17 -0700
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
Subject: [PATCH 14/20] drm/i915/dg2: add gsc with special gsc bar offsets
Date:   Thu,  7 Apr 2022 15:58:33 +0300
Message-Id: <20220407125839.1479249-15-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407125839.1479249-1-alexander.usyskin@intel.com>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

DG2 uses different GSC offsets on memory bar
and uses PXP head (HECI1).

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 15 +++++++++++++++
 drivers/gpu/drm/i915/i915_pci.c     |  1 +
 drivers/gpu/drm/i915/i915_reg.h     |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index ffe6716590f0..bfc307e49bf9 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -69,6 +69,19 @@ static const struct gsc_def gsc_def_xehpsdv[] = {
 	}
 };
 
+static const struct gsc_def gsc_def_dg2[] = {
+	{
+		.name = "mei-gsc",
+		.bar = DG2_GSC_HECI1_BASE,
+		.bar_size = GSC_BAR_LENGTH,
+	},
+	{
+		.name = "mei-gscfi",
+		.bar = DG2_GSC_HECI2_BASE,
+		.bar_size = GSC_BAR_LENGTH,
+	}
+};
+
 static void gsc_release_dev(struct device *dev)
 {
 	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
@@ -109,6 +122,8 @@ static void gsc_init_one(struct drm_i915_private *i915,
 		def = &gsc_def_dg1[intf_id];
 	} else if (IS_XEHPSDV(i915)) {
 		def = &gsc_def_xehpsdv[intf_id];
+	} else if (IS_DG2(i915)) {
+		def = &gsc_def_dg2[intf_id];
 	} else {
 		drm_warn_once(&i915->drm, "Unknown platform\n");
 		return;
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 06e6dad0d7f7..cb6dcc3f48f4 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1051,6 +1051,7 @@ static const struct intel_device_info xehpsdv_info = {
 	.has_4tile = 1, \
 	.has_64k_pages = 1, \
 	.has_guc_deprivilege = 1, \
+	.has_heci_pxp = 1, \
 	.needs_compact_pt = 1, \
 	.platform_engine_mask = \
 		BIT(RCS0) | BIT(BCS0) | \
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 1dd7b7de6002..efcfe32cd8eb 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -978,6 +978,8 @@
 #define BLT_RING_BASE		0x22000
 #define DG1_GSC_HECI1_BASE	0x00258000
 #define DG1_GSC_HECI2_BASE	0x00259000
+#define DG2_GSC_HECI1_BASE	0x00373000
+#define DG2_GSC_HECI2_BASE	0x00374000
 
 
 
-- 
2.32.0

