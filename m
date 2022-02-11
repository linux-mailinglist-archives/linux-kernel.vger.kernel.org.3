Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FEA4B23E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiBKLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:04:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349322AbiBKLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:04:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD60E11;
        Fri, 11 Feb 2022 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644577453; x=1676113453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MHKXZJmYMntwsRzbjJcY0xT/mLqEkxYkEqdYsoH05/4=;
  b=CkUbLtyyIvZ4j8ThcIiFuAkeLfQ7xz+6Io63THIWg1aS0zN6kVyoRPUg
   J7bCZRGCTvF8igUNOXDA3ssl4uqQG6sSu/ztbqRQ7NTKpoJlAk8Cua1lz
   qO9l1jQr+Uio++lrh+eUfi4tSz70hwykQu1avjK+rcEaVin+pBf7Po9CA
   EhRlMkiDIXZ8vq7O03cvLblHKP+2iMKbg3oalg3eHtNgcs9TD1IkOj9uh
   c1K+XczskYec2uyVOP8k1BRxw6gsqXEieEBmjxpjEovQHkmSs1MIwIk2E
   5IRUOhsUphjsMo5TmmBD2qIush5UjCYNmWLNTwAGwbZWcvWuKhthuXKXU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247305355"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="247305355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:04:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="500749875"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 11 Feb 2022 03:04:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A804366; Fri, 11 Feb 2022 13:04:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v1 1/1] ACPI: Switch to use list_entry_is_head() helper
Date:   Fri, 11 Feb 2022 13:04:23 +0200
Message-Id: <20220211110423.22733-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we got list_entry_is_head() helper in the generic header,
we may switch the ACPI modules to use it. This eliminates the
need in additional variable. In some cases it reduces critical
sections as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_ipmi.c | 16 ++++++----------
 drivers/acpi/glue.c      |  8 +++-----
 drivers/acpi/nfit/core.c | 12 +++---------
 drivers/acpi/nfit/mce.c  |  4 +---
 drivers/acpi/resource.c  |  9 +++------
 drivers/acpi/utils.c     |  7 ++-----
 6 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index a5fe2926bf50..f9e56138f8d1 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -354,27 +354,26 @@ static void ipmi_cancel_tx_msg(struct acpi_ipmi_device *ipmi,
 			       struct acpi_ipmi_msg *msg)
 {
 	struct acpi_ipmi_msg *tx_msg, *temp;
-	bool msg_found = false;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
 	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
 		if (msg == tx_msg) {
-			msg_found = true;
 			list_del(&tx_msg->head);
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
 
-	if (msg_found)
-		acpi_ipmi_msg_put(tx_msg);
+	if (list_entry_is_head(tx_msg, &ipmi->tx_msg_list, head)
+		return;
+
+	acpi_ipmi_msg_put(tx_msg);
 }
 
 static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 {
 	struct acpi_ipmi_device *ipmi_device = user_msg_data;
-	bool msg_found = false;
 	struct acpi_ipmi_msg *tx_msg, *temp;
 	struct device *dev = ipmi_device->dev;
 	unsigned long flags;
@@ -389,14 +388,13 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_for_each_entry_safe(tx_msg, temp, &ipmi_device->tx_msg_list, head) {
 		if (msg->msgid == tx_msg->tx_msgid) {
-			msg_found = true;
 			list_del(&tx_msg->head);
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 
-	if (!msg_found) {
+	if (list_entry_is_head(tx_msg, &ipmi_device->tx_msg_list, head)) {
 		dev_warn(dev,
 			 "Unexpected response (msg id %ld) is returned.\n",
 			 msg->msgid);
@@ -483,13 +481,11 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 static void ipmi_bmc_gone(int iface)
 {
 	struct acpi_ipmi_device *ipmi_device, *temp;
-	bool dev_found = false;
 
 	mutex_lock(&driver_data.ipmi_lock);
 	list_for_each_entry_safe(ipmi_device, temp,
 				 &driver_data.ipmi_devices, head) {
 		if (ipmi_device->ipmi_ifnum != iface) {
-			dev_found = true;
 			__ipmi_dev_kill(ipmi_device);
 			break;
 		}
@@ -500,7 +496,7 @@ static void ipmi_bmc_gone(int iface)
 					struct acpi_ipmi_device, head);
 	mutex_unlock(&driver_data.ipmi_lock);
 
-	if (dev_found) {
+	if (!list_entry_is_head(ipmi_device, &driver_data.ipmi_devices, head)) {
 		ipmi_flush_tx_msg(ipmi_device);
 		acpi_ipmi_dev_put(ipmi_device);
 	}
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index ef104809f27b..ffc0b3ee190b 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -61,17 +61,15 @@ EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
 static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
 {
-	struct acpi_bus_type *tmp, *ret = NULL;
+	struct acpi_bus_type *tmp;
 
 	down_read(&bus_type_sem);
 	list_for_each_entry(tmp, &bus_type_list, list) {
-		if (tmp->match(dev)) {
-			ret = tmp;
+		if (tmp->match(dev))
 			break;
-		}
 	}
 	up_read(&bus_type_sem);
-	return ret;
+	return list_entry_is_head(tmp, &bus_type_list, list) ? NULL : tmp;
 }
 
 #define FIND_CHILD_MIN_SCORE	1
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e5d7f2bda13f..b31c16e5e42c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1076,8 +1076,8 @@ static void nfit_mem_init_bdw(struct acpi_nfit_desc *acpi_desc,
 static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 		struct acpi_nfit_system_address *spa)
 {
-	struct nfit_mem *nfit_mem, *found;
 	struct nfit_memdev *nfit_memdev;
+	struct nfit_mem *nfit_mem;
 	int type = spa ? nfit_spa_type(spa) : 0;
 
 	switch (type) {
@@ -1106,19 +1106,13 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 			continue;
 		if (!spa && nfit_memdev->memdev->range_index)
 			continue;
-		found = NULL;
 		dcr = nfit_memdev->memdev->region_index;
 		device_handle = nfit_memdev->memdev->device_handle;
 		list_for_each_entry(nfit_mem, &acpi_desc->dimms, list)
-			if (__to_nfit_memdev(nfit_mem)->device_handle
-					== device_handle) {
-				found = nfit_mem;
+			if (__to_nfit_memdev(nfit_mem)->device_handle == device_handle)
 				break;
-			}
 
-		if (found)
-			nfit_mem = found;
-		else {
+		if (list_entry_is_head(nfit_mem, &acpi_desc->dimms, list)) {
 			nfit_mem = devm_kzalloc(acpi_desc->dev,
 					sizeof(*nfit_mem), GFP_KERNEL);
 			if (!nfit_mem)
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index ee8d9973f60b..dbe70ebdfc79 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -33,7 +33,6 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
 		struct device *dev = acpi_desc->dev;
-		int found_match = 0;
 
 		mutex_lock(&acpi_desc->init_mutex);
 		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
@@ -46,7 +45,6 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 				continue;
 			if ((spa->address + spa->length - 1) < mce->addr)
 				continue;
-			found_match = 1;
 			dev_dbg(dev, "addr in SPA %d (0x%llx, 0x%llx)\n",
 				spa->range_index, spa->address, spa->length);
 			/*
@@ -58,7 +56,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 		}
 		mutex_unlock(&acpi_desc->init_mutex);
 
-		if (!found_match)
+		if (list_entry_is_head(nfit_spa, &acpi_desc->spas, list))
 			continue;
 
 		/* If this fails due to an -ENOMEM, there is little we can do */
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c2d494784425..90ef0629737d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -767,7 +767,7 @@ static int acpi_dev_consumes_res(struct acpi_device *adev, struct resource *res)
 {
 	struct list_head resource_list;
 	struct resource_entry *rentry;
-	int ret, found = 0;
+	int ret;
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
@@ -775,15 +775,12 @@ static int acpi_dev_consumes_res(struct acpi_device *adev, struct resource *res)
 		return 0;
 
 	list_for_each_entry(rentry, &resource_list, node) {
-		if (resource_contains(rentry->res, res)) {
-			found = 1;
+		if (resource_contains(rentry->res, res))
 			break;
-		}
-
 	}
 
 	acpi_dev_free_resource_list(&resource_list);
-	return found;
+	return !list_entry_is_head(rentry, &resource_list, node);
 }
 
 static acpi_status acpi_res_consumer_cb(acpi_handle handle, u32 depth,
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d5cedffeeff9..9dcebb4421a0 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -771,17 +771,14 @@ EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 bool acpi_dev_found(const char *hid)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
-	bool found = false;
 
 	mutex_lock(&acpi_device_lock);
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
-		if (!strcmp(acpi_device_bus_id->bus_id, hid)) {
-			found = true;
+		if (!strcmp(acpi_device_bus_id->bus_id, hid))
 			break;
-		}
 	mutex_unlock(&acpi_device_lock);
 
-	return found;
+	return !list_entry_is_head(acpi_device_bus_id, &acpi_bus_id_list, node);
 }
 EXPORT_SYMBOL(acpi_dev_found);
 
-- 
2.34.1

