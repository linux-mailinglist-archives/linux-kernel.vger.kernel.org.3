Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305D50A469
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390221AbiDUPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390206AbiDUPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:39:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06CE47389;
        Thu, 21 Apr 2022 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555408; x=1682091408;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=udcQXIpUTvGfpi0zc+2wqYY4dI04cNNm7pAm9yzmW0o=;
  b=EoPAGGlGbAN7+W3mOpQvx/R9lhR1V0IvFEWpijauLmYSGvYIrbGdp7Km
   xWipJv9VBX5FexMBhTDEv1VzyfGOeaUBnusJfOwriGF9DmfVXSWqLhT5R
   kHa6T0WijmvoyAvjFZtfnyeWPW4mi6Lu+KZaqdlgpTVIDv4HesQ5g36mE
   OmObvVAMz/pkWD10DrldFkGwMUDTiCu9mqUcQRWl0fvFBLCEnN8hTY+VA
   NfPreLaVNlFTs9y4w+MfqiToTRZ4+Uui1sTU+7F6rb8IyO5WBa7fnhJHs
   DNXrEEy1CYs1uI9ONoK44kdAwMnA0/EE5kPY7rwrFn0sJ1cLMYII8fRG4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324837922"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="324837922"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="555834428"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:29 -0700
Subject: [PATCH v3 4/8] nvdimm: Replace lockdep_mutex with local lock classes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 08:33:29 -0700
Message-ID: <165055520896.3745911.8021255583475547548.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In response to an attempt to expand dev->lockdep_mutex for device_lock()
validation [1], Peter points out [2] that the lockdep API already has
the ability to assign a dedicated lock class per subsystem device-type.

Use lockdep_set_class() to override the default device_lock()
'__lockdep_no_validate__' class for each NVDIMM subsystem device-type. This
enables lockdep to detect deadlocks and recursive locking within the
device-driver core and the subsystem.

Link: https://lore.kernel.org/r/164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com [1]
Link: https://lore.kernel.org/r/Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net [2]
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/btt_devs.c       |    7 +++++--
 drivers/nvdimm/bus.c            |   14 +++++++-------
 drivers/nvdimm/dax_devs.c       |    4 ++--
 drivers/nvdimm/dimm_devs.c      |    4 ++++
 drivers/nvdimm/namespace_devs.c |   10 +++++++++-
 drivers/nvdimm/nd-core.h        |    2 +-
 drivers/nvdimm/pfn_devs.c       |    7 +++++--
 drivers/nvdimm/region_devs.c    |    4 ++++
 8 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index e5a58520d398..120821796668 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -178,6 +178,8 @@ bool is_nd_btt(struct device *dev)
 }
 EXPORT_SYMBOL(is_nd_btt);
 
+static struct lock_class_key nvdimm_btt_key;
+
 static struct device *__nd_btt_create(struct nd_region *nd_region,
 				      unsigned long lbasize, uuid_t *uuid,
 				      struct nd_namespace_common *ndns)
@@ -205,6 +207,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	dev->parent = &nd_region->dev;
 	dev->type = &nd_btt_device_type;
 	device_initialize(&nd_btt->dev);
+	lockdep_set_class(&nd_btt->dev.mutex, &nvdimm_btt_key);
 	if (ndns && !__nd_attach_ndns(&nd_btt->dev, ndns, &nd_btt->ndns)) {
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
 				dev_name(ndns->claim));
@@ -225,7 +228,7 @@ struct device *nd_btt_create(struct nd_region *nd_region)
 {
 	struct device *dev = __nd_btt_create(nd_region, 0, NULL, NULL);
 
-	__nd_device_register(dev);
+	nd_device_register(dev);
 	return dev;
 }
 
@@ -324,7 +327,7 @@ static int __nd_btt_probe(struct nd_btt *nd_btt,
 	if (!nd_btt->uuid)
 		return -ENOMEM;
 
-	__nd_device_register(&nd_btt->dev);
+	nd_device_register(&nd_btt->dev);
 
 	return 0;
 }
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7b0d1443217a..85ffa04e93c2 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -334,6 +334,8 @@ struct nvdimm_bus *nvdimm_to_bus(struct nvdimm *nvdimm)
 }
 EXPORT_SYMBOL_GPL(nvdimm_to_bus);
 
+static struct lock_class_key nvdimm_bus_key;
+
 struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 		struct nvdimm_bus_descriptor *nd_desc)
 {
@@ -360,6 +362,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	nvdimm_bus->dev.bus = &nvdimm_bus_type;
 	nvdimm_bus->dev.of_node = nd_desc->of_node;
 	device_initialize(&nvdimm_bus->dev);
+	lockdep_set_class(&nvdimm_bus->dev.mutex, &nvdimm_bus_key);
 	device_set_pm_not_required(&nvdimm_bus->dev);
 	rc = dev_set_name(&nvdimm_bus->dev, "ndbus%d", nvdimm_bus->id);
 	if (rc)
@@ -511,7 +514,7 @@ static void nd_async_device_unregister(void *d, async_cookie_t cookie)
 	put_device(dev);
 }
 
-void __nd_device_register(struct device *dev)
+void nd_device_register(struct device *dev)
 {
 	if (!dev)
 		return;
@@ -537,12 +540,6 @@ void __nd_device_register(struct device *dev)
 	async_schedule_dev_domain(nd_async_device_register, dev,
 				  &nd_async_domain);
 }
-
-void nd_device_register(struct device *dev)
-{
-	device_initialize(dev);
-	__nd_device_register(dev);
-}
 EXPORT_SYMBOL(nd_device_register);
 
 void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
@@ -724,6 +721,8 @@ static void ndctl_release(struct device *dev)
 	kfree(dev);
 }
 
+static struct lock_class_key nvdimm_ndctl_key;
+
 int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 {
 	dev_t devt = MKDEV(nvdimm_bus_major, nvdimm_bus->id);
@@ -734,6 +733,7 @@ int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 	if (!dev)
 		return -ENOMEM;
 	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &nvdimm_ndctl_key);
 	device_set_pm_not_required(dev);
 	dev->class = nd_class;
 	dev->parent = &nvdimm_bus->dev;
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 99965077bac4..7f4a9d28b670 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -80,7 +80,7 @@ struct device *nd_dax_create(struct nd_region *nd_region)
 	nd_dax = nd_dax_alloc(nd_region);
 	if (nd_dax)
 		dev = nd_pfn_devinit(&nd_dax->nd_pfn, NULL);
-	__nd_device_register(dev);
+	nd_device_register(dev);
 	return dev;
 }
 
@@ -119,7 +119,7 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 		nd_detach_ndns(dax_dev, &nd_pfn->ndns);
 		put_device(dax_dev);
 	} else
-		__nd_device_register(dax_dev);
+		nd_device_register(dax_dev);
 
 	return rc;
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index ee507eed42b5..27b8f8cd1b48 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -570,6 +570,8 @@ bool is_nvdimm(struct device *dev)
 	return dev->type == &nvdimm_device_type;
 }
 
+static struct lock_class_key nvdimm_key;
+
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
@@ -613,6 +615,8 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 	/* get security state and extended (master) state */
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &nvdimm_key);
 	nd_device_register(dev);
 
 	return nvdimm;
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 62b83b2e26e3..5197a813849d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1830,6 +1830,8 @@ static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
 	return dev;
 }
 
+static struct lock_class_key nvdimm_namespace_key;
+
 void nd_region_create_ns_seed(struct nd_region *nd_region)
 {
 	WARN_ON(!is_nvdimm_bus_locked(&nd_region->dev));
@@ -1845,8 +1847,12 @@ void nd_region_create_ns_seed(struct nd_region *nd_region)
 	 */
 	if (!nd_region->ns_seed)
 		dev_err(&nd_region->dev, "failed to create namespace\n");
-	else
+	else {
+		device_initialize(nd_region->ns_seed);
+		lockdep_set_class(&nd_region->ns_seed->mutex,
+				  &nvdimm_namespace_key);
 		nd_device_register(nd_region->ns_seed);
+	}
 }
 
 void nd_region_create_dax_seed(struct nd_region *nd_region)
@@ -2200,6 +2206,8 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 		if (id < 0)
 			break;
 		dev_set_name(dev, "namespace%d.%d", nd_region->id, id);
+		device_initialize(dev);
+		lockdep_set_class(&dev->mutex, &nvdimm_namespace_key);
 		nd_device_register(dev);
 	}
 	if (i)
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 448f9dcb4bb7..99b04106434b 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -106,7 +106,7 @@ void nd_region_create_dax_seed(struct nd_region *nd_region);
 int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus);
 void nvdimm_bus_destroy_ndctl(struct nvdimm_bus *nvdimm_bus);
 void nd_synchronize(void);
-void __nd_device_register(struct device *dev);
+void nd_device_register(struct device *dev);
 struct nd_label_id;
 char *nd_label_gen_id(struct nd_label_id *label_id, const uuid_t *uuid,
 		      u32 flags);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index c31e184bfa45..0cd396d0024c 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -291,6 +291,8 @@ bool is_nd_pfn(struct device *dev)
 }
 EXPORT_SYMBOL(is_nd_pfn);
 
+static struct lock_class_key nvdimm_pfn_key;
+
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		struct nd_namespace_common *ndns)
 {
@@ -303,6 +305,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 	nd_pfn->align = nd_pfn_default_alignment();
 	dev = &nd_pfn->dev;
 	device_initialize(&nd_pfn->dev);
+	lockdep_set_class(&nd_pfn->dev.mutex, &nvdimm_pfn_key);
 	if (ndns && !__nd_attach_ndns(&nd_pfn->dev, ndns, &nd_pfn->ndns)) {
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
 				dev_name(ndns->claim));
@@ -346,7 +349,7 @@ struct device *nd_pfn_create(struct nd_region *nd_region)
 	nd_pfn = nd_pfn_alloc(nd_region);
 	dev = nd_pfn_devinit(nd_pfn, NULL);
 
-	__nd_device_register(dev);
+	nd_device_register(dev);
 	return dev;
 }
 
@@ -643,7 +646,7 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 		nd_detach_ndns(pfn_dev, &nd_pfn->ndns);
 		put_device(pfn_dev);
 	} else
-		__nd_device_register(pfn_dev);
+		nd_device_register(pfn_dev);
 
 	return rc;
 }
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0cb274c2b508..8650e8d39c89 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -949,6 +949,8 @@ static unsigned long default_align(struct nd_region *nd_region)
 	return align;
 }
 
+static struct lock_class_key nvdimm_region_key;
+
 static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_region_desc *ndr_desc,
 		const struct device_type *dev_type, const char *caller)
@@ -1035,6 +1037,8 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	else
 		nd_region->flush = NULL;
 
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &nvdimm_region_key);
 	nd_device_register(dev);
 
 	return nd_region;

