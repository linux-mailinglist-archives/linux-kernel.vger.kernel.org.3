Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02C4FEF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiDMGEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiDMGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:04:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824525C5A;
        Tue, 12 Apr 2022 23:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829710; x=1681365710;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8KRmXihZjR6F7KMu/IkyUTy0vLDDknlzWwTKsgw244=;
  b=PklpqsZtow600Q6w/Q0vN4CYhawJDCWEoXp8U/wtkF0J/juciqm9LXEi
   CPo4Qk3foieDr/6Vk1IgHgnQsHQi7OHJjVSx1YRkh7M6M1w0RLLenweF0
   yO1lJ8RZ+7yEJmoMq9qgx9OMEwyqMp+12FBs9dsJfHl9f2WoEoX6KVvGC
   xpCmhSQbGkIly1V/LIc7N2KS+ciQx02S2/EI3eruvhV4M21IOgSihZ9SM
   KF9CpEf/V351yodAhQeiNA6XSQe0sS373RL9JoOMvZe5zPg+t5A1QJa2e
   2leiAkIaI3u/COLk86H6OlaNvktxDTAAzJb9cKIAs84sJV3uRhDGbatE6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244469508"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="244469508"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:01:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="590632232"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:01:33 -0700
Subject: [PATCH v2 01/12] device-core: Move device_lock() lockdep init to a
 helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Tue, 12 Apr 2022 23:01:33 -0700
Message-ID: <164982969345.684294.10649947254613843363.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for new infrastructure to support lockdep validation of
device_lock() usage across driver subsystems, add a
device_lockdep_init() helper to contain those updates.

Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c    |    5 +----
 include/linux/device.h |   13 +++++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..cb782299ae44 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2864,10 +2864,7 @@ void device_initialize(struct device *dev)
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	mutex_init(&dev->mutex);
-#ifdef CONFIG_PROVE_LOCKING
-	mutex_init(&dev->lockdep_mutex);
-#endif
-	lockdep_set_novalidate_class(&dev->mutex);
+	device_lockdep_init(dev);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 93459724dcde..af2576ace130 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -762,6 +762,19 @@ static inline bool dev_pm_test_driver_flags(struct device *dev, u32 flags)
 	return !!(dev->power.driver_flags & flags);
 }
 
+#ifdef CONFIG_PROVE_LOCKING
+static inline void device_lockdep_init(struct device *dev)
+{
+	mutex_init(&dev->lockdep_mutex);
+	lockdep_set_novalidate_class(&dev->mutex);
+}
+#else
+static inline void device_lockdep_init(struct device *dev)
+{
+	lockdep_set_novalidate_class(&dev->mutex);
+}
+#endif
+
 static inline void device_lock(struct device *dev)
 {
 	mutex_lock(&dev->mutex);

