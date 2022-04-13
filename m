Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2774A4FEF27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiDMGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiDMGEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:04:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36AF515AC;
        Tue, 12 Apr 2022 23:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829742; x=1681365742;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wYPZp09bL2aR6352eI2z1PZ2IcGJlP4QHePKX+aDpoc=;
  b=HL+vLX3ZizccylcbZcVfgT6Y+MPuUYsFXPh1UdzvDIH9mNS7SoA+YXpV
   pDca0B+cAzE5d9llCLoplbHPKch++kaLBW0m6oknyc9xR0vhVdAYdr34P
   +CmCU3ebPOIvjA6bCo1PwQT3AwNZclccjLUjHxcLUylRhdU1wwGYWcv7T
   riKqcOQLOwHpCBv1p9u80Har5wKRfPsps6mWN3fKWxu6oTliBghhzOXzP
   /8TrQ0lnJwKNKteK5UFCnVCLkuL7YSxuCQ9jmlMTs0pi+Mj+nPqA8QaPk
   wUYjOmR6MmjxKd20ZAB0nCf7EBTHqCkcsBwy3qMLRSLXtmBp/D/TtZy3M
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244469641"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="244469641"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="507854482"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:21 -0700
Subject: [PATCH v2 10/12] libnvdimm: Drop nd_device_lock()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, peterz@infradead.org,
        alison.schofield@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 12 Apr 2022 23:02:21 -0700
Message-ID: <164982974139.684294.10694905184257281907.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for switching to the core device_lock lockdep validation
scheme, convert nd_device_lock() calls back to device_lock().

Note that this temporarily reverts the code back to the typical no
validation of device_lock() until a follow-on patch to set
dev->lock_class.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index e5a58520d398..60c19b988bc4 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -50,14 +50,14 @@ static ssize_t sector_size_store(struct device *dev,
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
@@ -79,11 +79,11 @@ static ssize_t uuid_store(struct device *dev,
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
@@ -108,13 +108,13 @@ static ssize_t namespace_store(struct device *dev,
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
@@ -126,14 +126,14 @@ static ssize_t size_show(struct device *dev,
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
index 7b0d1443217a..b5a1317c30dd 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -88,9 +88,7 @@ static int nvdimm_bus_probe(struct device *dev)
 			dev->driver->name, dev_name(dev));
 
 	nvdimm_bus_probe_start(nvdimm_bus);
-	debug_nvdimm_lock(dev);
 	rc = nd_drv->probe(dev);
-	debug_nvdimm_unlock(dev);
 
 	if ((rc == 0 || rc == -EOPNOTSUPP) &&
 			dev->parent && is_nd_region(dev->parent))
@@ -111,11 +109,8 @@ static void nvdimm_bus_remove(struct device *dev)
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
@@ -139,7 +134,7 @@ static void nvdimm_bus_shutdown(struct device *dev)
 
 void nd_device_notify(struct device *dev, enum nvdimm_event event)
 {
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver) {
 		struct nd_device_driver *nd_drv;
 
@@ -147,7 +142,7 @@ void nd_device_notify(struct device *dev, enum nvdimm_event event)
 		if (nd_drv->notify)
 			nd_drv->notify(dev, event);
 	}
-	nd_device_unlock(dev);
+	device_unlock(dev);
 }
 EXPORT_SYMBOL(nd_device_notify);
 
@@ -572,9 +567,9 @@ void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
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
@@ -930,10 +925,10 @@ void wait_nvdimm_bus_probe_idle(struct device *dev)
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
@@ -1167,7 +1162,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		goto out;
 	}
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_cmd_clear_to_send(nvdimm_bus, nvdimm, func, buf);
 	if (rc)
@@ -1189,7 +1184,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
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
index ee507eed42b5..93113c0c4dc8 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -341,9 +341,9 @@ static ssize_t available_slots_show(struct device *dev,
 {
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	rc = __available_slots_show(dev_get_drvdata(dev), buf);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -386,12 +386,12 @@ static ssize_t security_store(struct device *dev,
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
index 62b83b2e26e3..bc578dbea472 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -264,7 +264,7 @@ static ssize_t alt_name_store(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = __alt_name_store(dev, buf, len);
@@ -272,7 +272,7 @@ static ssize_t alt_name_store(struct device *dev,
 		rc = nd_namespace_label_update(nd_region, dev);
 	dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -846,7 +846,7 @@ static ssize_t size_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = __size_store(dev, val);
@@ -868,7 +868,7 @@ static ssize_t size_store(struct device *dev,
 	dev_dbg(dev, "%llx %s (%d)\n", val, rc < 0 ? "fail" : "success", rc);
 
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1043,7 +1043,7 @@ static ssize_t uuid_store(struct device *dev,
 	} else
 		return -ENXIO;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	if (to_ndns(dev)->claim)
@@ -1059,7 +1059,7 @@ static ssize_t uuid_store(struct device *dev,
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1118,7 +1118,7 @@ static ssize_t sector_size_store(struct device *dev,
 	} else
 		return -ENXIO;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	if (to_ndns(dev)->claim)
 		rc = -EBUSY;
@@ -1129,7 +1129,7 @@ static ssize_t sector_size_store(struct device *dev,
 	dev_dbg(dev, "result: %zd %s: %s%s", rc, rc < 0 ? "tried" : "wrote",
 			buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -1239,9 +1239,9 @@ static ssize_t holder_show(struct device *dev,
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	rc = sprintf(buf, "%s\n", ndns->claim ? dev_name(ndns->claim) : "");
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -1278,7 +1278,7 @@ static ssize_t holder_class_store(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	rc = __holder_class_store(dev, buf);
@@ -1286,7 +1286,7 @@ static ssize_t holder_class_store(struct device *dev,
 		rc = nd_namespace_label_update(nd_region, dev);
 	dev_dbg(dev, "%s(%d)\n", rc < 0 ? "fail " : "", rc);
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc < 0 ? rc : len;
 }
@@ -1297,7 +1297,7 @@ static ssize_t holder_class_show(struct device *dev,
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (ndns->claim_class == NVDIMM_CCLASS_NONE)
 		rc = sprintf(buf, "\n");
 	else if ((ndns->claim_class == NVDIMM_CCLASS_BTT) ||
@@ -1309,7 +1309,7 @@ static ssize_t holder_class_show(struct device *dev,
 		rc = sprintf(buf, "dax\n");
 	else
 		rc = sprintf(buf, "<unknown>\n");
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -1323,7 +1323,7 @@ static ssize_t mode_show(struct device *dev,
 	char *mode;
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	claim = ndns->claim;
 	if (claim && is_nd_btt(claim))
 		mode = "safe";
@@ -1336,7 +1336,7 @@ static ssize_t mode_show(struct device *dev,
 	else
 		mode = "raw";
 	rc = sprintf(buf, "%s\n", mode);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -1456,8 +1456,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
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
index deb3d047571e..1668a10e41ba 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -191,45 +191,5 @@ static inline int nvdimm_lock_class(struct device *dev)
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
index c31e184bfa45..1672d139f708 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -55,7 +55,7 @@ static ssize_t mode_store(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc = 0;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	if (dev->driver)
 		rc = -EBUSY;
@@ -77,7 +77,7 @@ static ssize_t mode_store(struct device *dev,
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc ? rc : len;
 }
@@ -123,14 +123,14 @@ static ssize_t align_store(struct device *dev,
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
@@ -152,11 +152,11 @@ static ssize_t uuid_store(struct device *dev,
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
@@ -181,13 +181,13 @@ static ssize_t namespace_store(struct device *dev,
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
@@ -199,7 +199,7 @@ static ssize_t resource_show(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver) {
 		struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 		u64 offset = __le64_to_cpu(pfn_sb->dataoff);
@@ -213,7 +213,7 @@ static ssize_t resource_show(struct device *dev,
 		/* no address to convey if the pfn instance is disabled */
 		rc = -ENXIO;
 	}
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	return rc;
 }
@@ -225,7 +225,7 @@ static ssize_t size_show(struct device *dev,
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
-	nd_device_lock(dev);
+	device_lock(dev);
 	if (dev->driver) {
 		struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 		u64 offset = __le64_to_cpu(pfn_sb->dataoff);
@@ -241,7 +241,7 @@ static ssize_t size_show(struct device *dev,
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
index 188560b1c110..390123d293ea 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -95,7 +95,7 @@ static void nd_region_remove(struct device *dev)
 	nvdimm_bus_unlock(dev);
 
 	/*
-	 * Note, this assumes nd_device_lock() context to not race
+	 * Note, this assumes device_lock() context to not race
 	 * nd_region_notify()
 	 */
 	sysfs_put(nd_region->bb_state);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0cb274c2b508..83c1ce7f26a6 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -279,7 +279,7 @@ static ssize_t set_cookie_show(struct device *dev,
 	 * the v1.1 namespace label cookie definition. To read all this
 	 * data we need to wait for probing to settle.
 	 */
-	nd_device_lock(dev);
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	if (nd_region->ndr_mappings) {
@@ -296,7 +296,7 @@ static ssize_t set_cookie_show(struct device *dev,
 		}
 	}
 	nvdimm_bus_unlock(dev);
-	nd_device_unlock(dev);
+	device_unlock(dev);
 
 	if (rc)
 		return rc;
@@ -353,12 +353,12 @@ static ssize_t available_size_show(struct device *dev,
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
@@ -370,12 +370,12 @@ static ssize_t max_available_extent_show(struct device *dev,
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
@@ -549,12 +549,12 @@ static ssize_t region_badblocks_show(struct device *dev,
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
index 333d41da7621..1f8db59bdddd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1557,7 +1557,8 @@ config PROVE_NVDIMM_LOCKING
 	bool "NVDIMM"
 	depends on LIBNVDIMM
 	help
-	  Enable lockdep to validate nd_device_lock() usage.
+	  Enable lockdep to validate libnvdimm subsystem usage of the
+	  device lock.
 
 config PROVE_CXL_LOCKING
 	bool "CXL"

