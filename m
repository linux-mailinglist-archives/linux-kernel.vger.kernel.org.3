Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67847D458
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbhLVPlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:41:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:49612 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhLVPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640187664; x=1671723664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pNGGU5exxXmBba17iKeNMkYLms3huHnZB9vDNIxO3O8=;
  b=dksOyokONr3r0qRc2cKR0eOjvMFsDtxFEUZJBteiIn1gRIAgCcqRl5/Q
   JjwyLocUrAz7bgXR155OI1lQJ/xA+STAIwUf4bVcqBMCtUsCcbqGbQI1h
   hpBnuSyCPsA6qbhoFHNtbq2HmhEgxaF8CHFVS6j6jX1oC7MMTITy5ICu6
   68gjzc/eAgxzyP1DaAMWBd3WispnUL+KpIbfhQPjxMjpHXIVfskADzsPC
   8oMj4VSrW/57lw61IEyBdUh+sjqhfB5pHkM7HXAnZWTKSQIJeUek6LZ8Y
   Hm/YUt0mhyzlOw8vSibxSrs6OHglaWLg6Rj4VtFQdiNID0nGHLk5pvWhY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227493277"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="227493277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="484793202"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 07:40:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 371AEFE; Wed, 22 Dec 2021 17:40:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v2 1/1] drm/i915/dsi: Drop double check ACPI companion device for NULL
Date:   Wed, 22 Dec 2021 17:40:33 +0200
Message-Id: <20211222154033.6770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_dev_get_resources() does perform the NULL pointer check against
ACPI companion device which is given as function parameter. Thus,
there is no need to duplicate this check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used LIST_HEAD() (Ville), initialized lookup directly on stack (Ville)
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 28 +++++++-------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 0da91849efde..da0bd056f3d3 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -426,24 +426,16 @@ static void i2c_acpi_find_adapter(struct intel_dsi *intel_dsi,
 				  const u16 slave_addr)
 {
 	struct drm_device *drm_dev = intel_dsi->base.base.dev;
-	struct device *dev = drm_dev->dev;
-	struct acpi_device *acpi_dev;
-	struct list_head resource_list;
-	struct i2c_adapter_lookup lookup;
-
-	acpi_dev = ACPI_COMPANION(dev);
-	if (acpi_dev) {
-		memset(&lookup, 0, sizeof(lookup));
-		lookup.slave_addr = slave_addr;
-		lookup.intel_dsi = intel_dsi;
-		lookup.dev_handle = acpi_device_handle(acpi_dev);
-
-		INIT_LIST_HEAD(&resource_list);
-		acpi_dev_get_resources(acpi_dev, &resource_list,
-				       i2c_adapter_lookup,
-				       &lookup);
-		acpi_dev_free_resource_list(&resource_list);
-	}
+	struct acpi_device *adev = ACPI_COMPANION(drm_dev->dev);
+	struct i2c_adapter_lookup lookup = {
+		.slave_addr = slave_addr,
+		.intel_dsi = intel_dsi,
+		.dev_handle = acpi_device_handle(adev),
+	};
+	LIST_HEAD(resource_list);
+
+	acpi_dev_get_resources(adev, &resource_list, i2c_adapter_lookup, &lookup);
+	acpi_dev_free_resource_list(&resource_list);
 }
 #else
 static inline void i2c_acpi_find_adapter(struct intel_dsi *intel_dsi,
-- 
2.34.1

