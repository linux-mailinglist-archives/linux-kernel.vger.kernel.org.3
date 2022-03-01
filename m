Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28414C8143
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiCACvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiCACux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:50:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34148385;
        Mon, 28 Feb 2022 18:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646103000; x=1677639000;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpyV9hsJHyJYFpBu6VWN90YcZLTsehIJAJjrttoPgSc=;
  b=KOcL0FSabpoeNUNpLIuKGe5JYANfz6bsWJ62Ba+Q1LUvn6X9DPV0R1ua
   OfQR17V5rpi/a4z08xBiDU8HXiYqPjwS8dF9h8fg3PfUyHpG5ELsjoXH7
   pXB9e4lyjHv+FOWcY86V8K0D3xr4CkEbX6Bw0RI+AG5VJxwCSxHYe/9vC
   Eg/bLGuT9RgmKYJ96jFdOYlz888yoDwyXEOfXsC0xPms258pPqL4VHRVp
   wOwBrWn5aDlFNGcqRSWx/Or+zntADOsvWGPZudtWeRASm4mHmEY1cljj6
   eltUG3cgETDodeWOZjnyL+iiOlYR+T0KaAXrTySif0+wbUmInBio65HHU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252968633"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252968633"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="507645901"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:37 -0800
Subject: [PATCH 09/11] libnvdimm: Drop nd_device_lock()
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:49:37 -0800
Message-ID: <164610297784.2682974.3916870850468901338.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for switching to the core device_lock lockdep validation
scheme, convert nd_device_lock() calls back to device_lock().

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/btt_devs.c       |   16 ++++++++--------
 drivers/nvdimm/bus.c            |   23 +++++++++-------------
 drivers/nvdimm/core.c           |   10 +++++-----
 drivers/nvdimm/dimm_devs.c      |    8 ++++----
 drivers/nvdimm/namespace_devs.c |   36 ++++++++++++++++++-----------------
 drivers/nvdimm/nd-core.h        |   40 ---------------------------------------
 drivers/nvdimm/pfn_devs.c       |   24 ++++++++++++-----------
 drivers/nvdimm/pmem.c           |    2 +-
 drivers/nvdimm/region.c         |    2 +-
 drivers/nvdimm/region_devs.c    |   16 ++++++++--------
 lib/Kconfig.debug               |    3 ++-
 11 files changed, 68 insertions(+), 112 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 8b52e5144f08..d4164b2cf22e 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -51,14 +51,14 @@ static ssize_t sector_size_store(struct device *dev,
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_btt->lbasize,
 			btt_lbasize_supported);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -80,11 +80,11 @@ static ssize_t uuid_store(struct device *dev,
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_btt->uuid, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -109,13 +109,13 @@ static ssize_t namespace_store(struct device *dev,
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_btt->ndns, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -127,14 +127,14 @@ static ssize_t size_show(struct device *dev,
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver)
 		rc = sprintf(buf, "%llu\n", nd_btt->size);
 	else {
 		/* no size to convey if the btt instance is disabled */
 		rc = -ENXIO;
 	}
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 9dc7f3edd42b..f481831929eb 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -91,9 +91,7 @@ static int nvdimm_bus_probe(struct device *dev)
 			dev->driver->name, dev_name(dev));
 
 	nvdimm_bus_probe_start(nvdimm_bus);
-	debug_nvdimm_lock(dev);
 	rc = nd_drv->probe(dev);
-	debug_nvdimm_unlock(dev);
 
 	if ((rc == 0 || rc == -EOPNOTSUPP) &&
 			dev->parent && is_nd_region(dev->parent))
@@ -114,11 +112,8 @@ static void nvdimm_bus_remove(struct device *dev)
 	struct module *provider = to_bus_provider(dev);
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 
-	if (nd_drv->remove) {
-		debug_nvdimm_lock(dev);
+	if (nd_drv->remove)
 		nd_drv->remove(dev);
-		debug_nvdimm_unlock(dev);
-	}
 
 	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s)\n", dev->driver->name,
 			dev_name(dev));
@@ -142,7 +137,7 @@ static void nvdimm_bus_shutdown(struct device *dev)
 
 void nd_device_notify(struct device *dev, enum nvdimm_event event)
 {
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver) {
 		struct nd_device_driver *nd_drv;
 
@@ -150,7 +145,7 @@ void nd_device_notify(struct device *dev, enum nvdimm_event event)
 		if (nd_drv->notify)
 			nd_drv->notify(dev, event);
 	}
-	nd_device_unlock(dev);
+	device_unlock(dev);
 }
 EXPORT_SYMBOL(nd_device_notify);
 
@@ -575,9 +570,9 @@ void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
 		 * or otherwise let the async path handle it if the
 		 * unregistration was already queued.
 		 */
-		nd_device_lock(dev);
+		device_lock(dev);
 		killed = kill_device(dev);
-		nd_device_unlock(dev);
+		device_unlock(dev);
 
 		if (!killed)
 			return;
@@ -933,10 +928,10 @@ void wait_nvdimm_bus_probe_idle(struct device *dev)
 		if (nvdimm_bus->probe_active == 0)
 			break;
 		nvdimm_bus_unlock(dev);
-		nd_device_unlock(dev);
+		device_unlock(dev);
 		wait_event(nvdimm_bus->wait,
 				nvdimm_bus->probe_active == 0);
-		nd_device_lock(dev);
+		device_lock(dev);
 		nvdimm_bus_lock(dev);
 	} while (true);
 }
@@ -1170,7 +1165,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		goto out;
 	}
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_cmd_clear_to_send(nvdimm_bus, nvdimm, func, buf);
 	if (rc)
@@ -1192,7 +1187,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
 out_unlock:
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 out:
 	kfree(in_env);
 	kfree(out_env);
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 69a03358817f..144926b7451c 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -215,7 +215,7 @@ EXPORT_SYMBOL_GPL(to_nvdimm_bus_dev);
  *
  * Enforce that uuids can only be changed while the device is disabled
  * (driver detached)
- * LOCKING: expects nd_device_lock() is held on entry
+ * LOCKING: expects device_lock() is held on entry
  */
 int nd_uuid_store(struct device *dev, uuid_t **uuid_out, const char *buf,
 		size_t len)
@@ -316,15 +316,15 @@ static DEVICE_ATTR_RO(provider);
 
 static int flush_namespaces(struct device *dev, void *data)
 {
-	nd_device_lock(dev);
-	nd_device_unlock(dev);
+	device_lock(dev);
+	device_unlock(dev);
 	return 0;
 }
 
 static int flush_regions_dimms(struct device *dev, void *data)
 {
-	nd_device_lock(dev);
-	nd_device_unlock(dev);
+	device_lock(dev);
+	device_unlock(dev);
 	device_for_each_child(dev, NULL, flush_namespaces);
 	return 0;
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index dc7449a40003..00001024d0b2 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -362,9 +362,9 @@ static ssize_t available_slots_show(struct device *dev,
 {
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	rc = __available_slots_show(dev_get_drvdata(dev), buf);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -407,12 +407,12 @@ static ssize_t security_store(struct device *dev,
 	 * done while probing is idle and the DIMM is not in active use
 	 * in any region.
 	 */
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = nvdimm_security_store(dev, buf, len);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index b57a2d36c517..16cedd854fa8 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -383,7 +383,7 @@ static ssize_t alt_name_store(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = __alt_name_store(dev, buf, len);
@@ -391,7 +391,7 @@ static ssize_t alt_name_store(struct device *dev,
 		rc = nd_namespace_label_update(nd_region, dev);
 	dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1056,7 +1056,7 @@ static ssize_t size_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = __size_store(dev, val);
@@ -1082,7 +1082,7 @@ static ssize_t size_store(struct device *dev,
 	dev_dbg(dev, "%llx %s (%d)\n", val, rc < 0 ? "fail" : "success", rc);
 
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1268,7 +1268,7 @@ static ssize_t uuid_store(struct device *dev,
 	} else
 		return -ENXIO;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	if (to_ndns(dev)->claim)
@@ -1284,7 +1284,7 @@ static ssize_t uuid_store(struct device *dev,
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1358,7 +1358,7 @@ static ssize_t sector_size_store(struct device *dev,
 	} else
 		return -ENXIO;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	if (to_ndns(dev)->claim)
 		rc = -EBUSY;
@@ -1369,7 +1369,7 @@ static ssize_t sector_size_store(struct device *dev,
 	dev_dbg(dev, "result: %zd %s: %s%s", rc, rc < 0 ? "tried" : "wrote",
 			buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -1484,9 +1484,9 @@ static ssize_t holder_show(struct device *dev,
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	rc = sprintf(buf, "%s\n", ndns->claim ? dev_name(ndns->claim) : "");
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -1523,7 +1523,7 @@ static ssize_t holder_class_store(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = __holder_class_store(dev, buf);
@@ -1531,7 +1531,7 @@ static ssize_t holder_class_store(struct device *dev,
 		rc = nd_namespace_label_update(nd_region, dev);
 	dev_dbg(dev, "%s(%d)\n", rc < 0 ? "fail " : "", rc);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1542,7 +1542,7 @@ static ssize_t holder_class_show(struct device *dev,
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (ndns->claim_class == NVDIMM_CCLASS_NONE)
 		rc = sprintf(buf, "\n");
 	else if ((ndns->claim_class == NVDIMM_CCLASS_BTT) ||
@@ -1554,7 +1554,7 @@ static ssize_t holder_class_show(struct device *dev,
 		rc = sprintf(buf, "dax\n");
 	else
 		rc = sprintf(buf, "<unknown>\n");
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -1568,7 +1568,7 @@ static ssize_t mode_show(struct device *dev,
 	char *mode;
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	claim = ndns->claim;
 	if (claim && is_nd_btt(claim))
 		mode = "safe";
@@ -1581,7 +1581,7 @@ static ssize_t mode_show(struct device *dev,
 	else
 		mode = "raw";
 	rc = sprintf(buf, "%s\n", mode);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -1715,8 +1715,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		 * Flush any in-progess probes / removals in the driver
 		 * for the raw personality of this namespace.
 		 */
-		nd_device_lock(&ndns->dev);
-		nd_device_unlock(&ndns->dev);
+		device_lock(&ndns->dev);
+		device_unlock(&ndns->dev);
 		if (ndns->dev.driver) {
 			dev_dbg(&ndns->dev, "is active, can't bind %s\n",
 					dev_name(dev));
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 772568ffb9d6..90c4029c87d2 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -214,45 +214,5 @@ static inline int nvdimm_lock_class(struct device *dev)
 	else
 		return -1;
 }
-
-static inline void debug_nvdimm_lock(struct device *dev)
-{
-	mutex_lock_nested(&dev->lockdep_mutex, nvdimm_lock_class(dev));
-}
-
-static inline void debug_nvdimm_unlock(struct device *dev)
-{
-	mutex_unlock(&dev->lockdep_mutex);
-}
-
-static inline void nd_device_lock(struct device *dev)
-{
-	device_lock(dev);
-	debug_nvdimm_lock(dev);
-}
-
-static inline void nd_device_unlock(struct device *dev)
-{
-	debug_nvdimm_unlock(dev);
-	device_unlock(dev);
-}
-#else
-static inline void nd_device_lock(struct device *dev)
-{
-	device_lock(dev);
-}
-
-static inline void nd_device_unlock(struct device *dev)
-{
-	device_unlock(dev);
-}
-
-static inline void debug_nvdimm_lock(struct device *dev)
-{
-}
-
-static inline void debug_nvdimm_unlock(struct device *dev)
-{
-}
 #endif
 #endif /* __ND_CORE_H__ */
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 58eda16f5c53..ee357401fdd1 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -56,7 +56,7 @@ static ssize_t mode_store(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc = 0;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	if (dev->driver)
 		rc = -EBUSY;
@@ -78,7 +78,7 @@ static ssize_t mode_store(struct device *dev,
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -124,14 +124,14 @@ static ssize_t align_store(struct device *dev,
 	unsigned long aligns[MAX_NVDIMM_ALIGN] = { [0] = 0, };
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_pfn->align,
 			nd_pfn_supported_alignments(aligns));
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -153,11 +153,11 @@ static ssize_t uuid_store(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_pfn->uuid, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -182,13 +182,13 @@ static ssize_t namespace_store(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_pfn->ndns, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -200,7 +200,7 @@ static ssize_t resource_show(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver) {
 		struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 		u64 offset = __le64_to_cpu(pfn_sb->dataoff);
@@ -214,7 +214,7 @@ static ssize_t resource_show(struct device *dev,
 		/* no address to convey if the pfn instance is disabled */
 		rc = -ENXIO;
 	}
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -226,7 +226,7 @@ static ssize_t size_show(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver) {
 		struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 		u64 offset = __le64_to_cpu(pfn_sb->dataoff);
@@ -242,7 +242,7 @@ static ssize_t size_show(struct device *dev,
 		/* no size to convey if the pfn instance is disabled */
 		rc = -ENXIO;
 	}
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..3992521c151f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -573,7 +573,7 @@ static void nd_pmem_remove(struct device *dev)
 		nvdimm_namespace_detach_btt(to_nd_btt(dev));
 	else {
 		/*
-		 * Note, this assumes nd_device_lock() context to not
+		 * Note, this assumes device_lock() context to not
 		 * race nd_pmem_notify()
 		 */
 		sysfs_put(pmem->bb_state);
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index e0c34120df37..466b3e9247b6 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -103,7 +103,7 @@ static void nd_region_remove(struct device *dev)
 	nvdimm_bus_unlock(dev);
 
 	/*
-	 * Note, this assumes nd_device_lock() context to not race
+	 * Note, this assumes device_lock() context to not race
 	 * nd_region_notify()
 	 */
 	sysfs_put(nd_region->bb_state);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 9ccf3d608799..0f6c85b45df3 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -305,7 +305,7 @@ static ssize_t set_cookie_show(struct device *dev,
 	 * the v1.1 namespace label cookie definition. To read all this
 	 * data we need to wait for probing to settle.
 	 */
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	if (nd_region->ndr_mappings) {
@@ -322,7 +322,7 @@ static ssize_t set_cookie_show(struct device *dev,
 		}
 	}
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	if (rc)
 		return rc;
@@ -398,12 +398,12 @@ static ssize_t available_size_show(struct device *dev,
 	 * memory nvdimm_bus_lock() is dropped, but that's userspace's
 	 * problem to not race itself.
 	 */
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	available = nd_region_available_dpa(nd_region);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return sprintf(buf, "%llu\n", available);
 }
@@ -415,12 +415,12 @@ static ssize_t max_available_extent_show(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long available = 0;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	available = nd_region_allocatable_dpa(nd_region);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return sprintf(buf, "%llu\n", available);
 }
@@ -594,12 +594,12 @@ static ssize_t region_badblocks_show(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver)
 		rc = badblocks_show(&nd_region->bb, buf, 0);
 	else
 		rc = -ENXIO;
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5942b22d7f1b..a4bd109f6178 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1529,7 +1529,8 @@ config PROVE_NVDIMM_LOCKING
 	bool "NVDIMM"
 	depends on LIBNVDIMM
 	help
-	  Enable lockdep to validate nd_device_lock() usage.
+	  Enable lockdep to validate libnvdimm subsystem usage of the
+	  device lock.
 
 config PROVE_CXL_LOCKING
 	bool "CXL"

