Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832484C812A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiCACtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiCACtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:35 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767AB47072;
        Mon, 28 Feb 2022 18:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102935; x=1677638935;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5s4C1XoxbbWcTd1M501STQqQFqAZkTdnQMPZcJvB8f4=;
  b=fWGsMJCsANPrSCiuVce5fXp1pSpU/sP2qcEh1t9Rdhddbo3hEG/Y8Aw6
   7VBnkwui6rClZNDYje/IeWiuDCU8NKo2tEaOWTlGEKVXUrPHEpbpr0KMH
   3LeXT9Ln1n67slk2/h4hTZTUGog1BLvtdm8LWbSGtq8TCS1JgHGxyOZt5
   F93XHeQ6S8K1jlhaZV7QmCazagCM1QjoQD3cMnW0I4doxV26JaBAD+o/k
   vaBrOVXdKYreSUhHy6CoF8CLXO5viF5b1WLVaw7vuIw+C3Gli+r6LI0AN
   cQL6lh5rpv/2dWDgkbAMz/BAgLy9CEgyS5WrEOS9GFCnakIW+EfFJLOXH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253232806"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253232806"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:48:55 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="544942973"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:48:54 -0800
Subject: [PATCH 01/11] device-core: Enable lockdep validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:48:54 -0800
Message-ID: <164610293458.2682974.15975217569862336908.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @lockdep_mutex attribute of 'struct device' was introduced to allow
subsystems to wrap their usage of device_lock() with a local definition
that adds nested annotations and lockdep validation. However, that
approach leaves lockdep blind to the device_lock usage in the
device-core. Instead of requiring the subsystem to replace device_lock()
teach the core device_lock() to consider a subsystem specified lock
class.

While this enables increased coverage of the device_lock() it is still
limited to one subsystem at a time unless / until a unique
"lockdep_mutex" is added for each subsystem that wants a distinct lock
class number space.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c    |    1 +
 include/linux/device.h |   73 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bb957b11861..96430fa5152e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2866,6 +2866,7 @@ void device_initialize(struct device *dev)
 	mutex_init(&dev->mutex);
 #ifdef CONFIG_PROVE_LOCKING
 	mutex_init(&dev->lockdep_mutex);
+	dev->lock_class = -1;
 #endif
 	lockdep_set_novalidate_class(&dev->mutex);
 	spin_lock_init(&dev->devres_lock);
diff --git a/include/linux/device.h b/include/linux/device.h
index 93459724dcde..e313ff21d670 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -402,6 +402,7 @@ struct dev_msi_info {
  * @mutex:	Mutex to synchronize calls to its driver.
  * @lockdep_mutex: An optional debug lock that a subsystem can use as a
  * 		peer lock to gain localized lockdep coverage of the device_lock.
+ * @lock_class: per-subsystem annotated device lock class
  * @bus:	Type of bus device is on.
  * @driver:	Which driver has allocated this
  * @platform_data: Platform data specific to the device.
@@ -501,6 +502,7 @@ struct device {
 					   dev_set_drvdata/dev_get_drvdata */
 #ifdef CONFIG_PROVE_LOCKING
 	struct mutex		lockdep_mutex;
+	int			lock_class;
 #endif
 	struct mutex		mutex;	/* mutex to synchronize calls to
 					 * its driver.
@@ -762,6 +764,12 @@ static inline bool dev_pm_test_driver_flags(struct device *dev, u32 flags)
 	return !!(dev->power.driver_flags & flags);
 }
 
+static inline void device_lock_assert(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+}
+
+#ifndef CONFIG_PROVE_LOCKING
 static inline void device_lock(struct device *dev)
 {
 	mutex_lock(&dev->mutex);
@@ -782,10 +790,71 @@ static inline void device_unlock(struct device *dev)
 	mutex_unlock(&dev->mutex);
 }
 
-static inline void device_lock_assert(struct device *dev)
+static inline void device_set_lock_class(struct device *dev, int lock_class)
 {
-	lockdep_assert_held(&dev->mutex);
 }
+#else
+static inline void device_lock(struct device *dev)
+{
+	lockdep_assert_not_held(&dev->lockdep_mutex);
+
+	mutex_lock(&dev->mutex);
+	if (dev->lock_class >= 0)
+		mutex_lock_nested(&dev->lockdep_mutex, dev->lock_class);
+}
+
+static inline int device_lock_interruptible(struct device *dev)
+{
+	int rc = mutex_lock_interruptible(&dev->mutex);
+
+	if (rc || dev->lock_class < 0)
+		return rc;
+
+	return mutex_lock_interruptible_nested(&dev->lockdep_mutex,
+					       dev->lock_class);
+}
+
+static inline int device_trylock(struct device *dev)
+{
+	if (mutex_trylock(&dev->mutex)) {
+		if (dev->lock_class >= 0)
+			mutex_lock_nested(&dev->lockdep_mutex, dev->lock_class);
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline void device_unlock(struct device *dev)
+{
+	if (dev->lock_class >= 0)
+		mutex_unlock(&dev->lockdep_mutex);
+	mutex_unlock(&dev->mutex);
+}
+
+static inline void device_set_lock_class(struct device *dev, int lock_class)
+{
+	if (dev->lock_class < 0 && lock_class > 0) {
+		if (mutex_is_locked(&dev->mutex)) {
+			/*
+			 * device_unlock() will unlock lockdep_mutex now that
+			 * lock_class is set, so take the paired lock now
+			 */
+			mutex_lock_nested(&dev->lockdep_mutex, lock_class);
+		}
+	} else if (dev->lock_class >= 0 && lock_class < 0) {
+		if (mutex_is_locked(&dev->mutex)) {
+			/*
+			 * device_unlock() will no longer drop lockdep_mutex now
+			 * that lock_class is disabled, so drop the paired lock
+			 * now.
+			 */
+			mutex_unlock(&dev->lockdep_mutex);
+		}
+	}
+	dev->lock_class = lock_class;
+}
+#endif
 
 static inline struct device_node *dev_of_node(struct device *dev)
 {

