Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C550A470
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390171AbiDUPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351142AbiDUPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:40:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5E473B8;
        Thu, 21 Apr 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555460; x=1682091460;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Go/sFTHzlF+LBzGN1k0aVVd0/qVHc6/DPcmOivDF7zQ=;
  b=BWOGif9rR70SiRnxmx5gdZq3rjKGLb5+LPAws2vTH5OSnoWmGCQdMxb+
   aNuXJPcWs07UN7iTihJRfSxKeY/ZW61w+DQG1Rjo61N65uvFJNs1vG32T
   zZctZtjs+81rtqztEcm3gH4w+gkf2uVtDbF6vaz+rTyT2IhXFpnXoYLxv
   tjLV3MQkF6DJtpDNFIriNY2lt9pcllDMXboodvZDGouGYinAtY6CXajNV
   ZKvtLoKPaO+hemf+bUUuJbN8jK1SDa0l00tPmJkQAyehyoBPUsOmddr4S
   H/9tSr55a2EeDxne2+o6x3ygZB65fdtjLPsC+V19KwLIVtQo54MFKRksX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="251710818"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="251710818"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="805559718"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:34 -0700
Subject: [PATCH v3 5/8] ACPI: NFIT: Drop nfit_device_lock()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, peterz@infradead.org,
        alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 08:33:34 -0700
Message-ID: <165055521409.3745911.8085645201146909612.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nfit_device_lock() helper was added to provide lockdep coverage for
the NFIT driver's usage of device_lock() on the nvdimm_bus object. Now
that nvdimm_bus objects have their own lock class this wrapper can be
dropped.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   30 +++++++++++++++---------------
 drivers/acpi/nfit/nfit.h |   24 ------------------------
 2 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index fe61f617a943..ae5f4acf2675 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1230,7 +1230,7 @@ static ssize_t hw_error_scrub_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	nfit_device_lock(dev);
+	device_lock(dev);
 	nd_desc = dev_get_drvdata(dev);
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
@@ -1247,7 +1247,7 @@ static ssize_t hw_error_scrub_store(struct device *dev,
 			break;
 		}
 	}
-	nfit_device_unlock(dev);
+	device_unlock(dev);
 	if (rc)
 		return rc;
 	return size;
@@ -1267,10 +1267,10 @@ static ssize_t scrub_show(struct device *dev,
 	ssize_t rc = -ENXIO;
 	bool busy;
 
-	nfit_device_lock(dev);
+	device_lock(dev);
 	nd_desc = dev_get_drvdata(dev);
 	if (!nd_desc) {
-		nfit_device_unlock(dev);
+		device_unlock(dev);
 		return rc;
 	}
 	acpi_desc = to_acpi_desc(nd_desc);
@@ -1287,7 +1287,7 @@ static ssize_t scrub_show(struct device *dev,
 	}
 
 	mutex_unlock(&acpi_desc->init_mutex);
-	nfit_device_unlock(dev);
+	device_unlock(dev);
 	return rc;
 }
 
@@ -1304,14 +1304,14 @@ static ssize_t scrub_store(struct device *dev,
 	if (val != 1)
 		return -EINVAL;
 
-	nfit_device_lock(dev);
+	device_lock(dev);
 	nd_desc = dev_get_drvdata(dev);
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
 		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
 	}
-	nfit_device_unlock(dev);
+	device_unlock(dev);
 	if (rc)
 		return rc;
 	return size;
@@ -1697,9 +1697,9 @@ static void acpi_nvdimm_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_device *adev = data;
 	struct device *dev = &adev->dev;
 
-	nfit_device_lock(dev->parent);
+	device_lock(dev->parent);
 	__acpi_nvdimm_notify(dev, event);
-	nfit_device_unlock(dev->parent);
+	device_unlock(dev->parent);
 }
 
 static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
@@ -3152,8 +3152,8 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 	struct device *dev = acpi_desc->dev;
 
 	/* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
-	nfit_device_lock(dev);
-	nfit_device_unlock(dev);
+	device_lock(dev);
+	device_unlock(dev);
 
 	/* Bounce the init_mutex to complete initial registration */
 	mutex_lock(&acpi_desc->init_mutex);
@@ -3305,8 +3305,8 @@ void acpi_nfit_shutdown(void *data)
 	 * acpi_nfit_ars_rescan() submissions have had a chance to
 	 * either submit or see ->cancel set.
 	 */
-	nfit_device_lock(bus_dev);
-	nfit_device_unlock(bus_dev);
+	device_lock(bus_dev);
+	device_unlock(bus_dev);
 
 	flush_workqueue(nfit_wq);
 }
@@ -3449,9 +3449,9 @@ EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
 
 static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 {
-	nfit_device_lock(&adev->dev);
+	device_lock(&adev->dev);
 	__acpi_nfit_notify(&adev->dev, adev->handle, event);
-	nfit_device_unlock(&adev->dev);
+	device_unlock(&adev->dev);
 }
 
 static const struct acpi_device_id acpi_nfit_ids[] = {
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 50882bdbeb96..6023ad61831a 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -337,30 +337,6 @@ static inline struct acpi_nfit_desc *to_acpi_desc(
 	return container_of(nd_desc, struct acpi_nfit_desc, nd_desc);
 }
 
-#ifdef CONFIG_PROVE_LOCKING
-static inline void nfit_device_lock(struct device *dev)
-{
-	device_lock(dev);
-	mutex_lock(&dev->lockdep_mutex);
-}
-
-static inline void nfit_device_unlock(struct device *dev)
-{
-	mutex_unlock(&dev->lockdep_mutex);
-	device_unlock(dev);
-}
-#else
-static inline void nfit_device_lock(struct device *dev)
-{
-	device_lock(dev);
-}
-
-static inline void nfit_device_unlock(struct device *dev)
-{
-	device_unlock(dev);
-}
-#endif
-
 const guid_t *to_nfit_uuid(enum nfit_uuids id);
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *nfit, acpi_size sz);
 void acpi_nfit_shutdown(void *data);

