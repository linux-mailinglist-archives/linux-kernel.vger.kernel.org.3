Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB054662E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347496AbiFJMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiFJMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:02:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3A3E0EA;
        Fri, 10 Jun 2022 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654862540; x=1686398540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cAnK+F86CV/moe3BVaa7l+Gx92UVQLrvBwjZH561G94=;
  b=W+uI3vh7CjD+Pg172FaBvAi3Omeg5peDjhpwJNKFRLSoEDWAI04QERqi
   4jIPTeL0L+BHG0KI0D3E6kOk18aA7LE8pHVssjiLJ0h8LpvHOXYZdunZr
   8Fc5DzPRLRNIkCjIOvYXPTegQE9sU+7W/v/gFk1BqUrE2pUQFLcfdkji+
   X+NSqh4RBkIYrcZikBQ2JTbBkQiddMgeo2EXG2XfLozDg1f5F2ykgvdaZ
   n7nFjJ1WFFjfxF7SVc1XzEI38FEeFcbMdddchI4rMRSmCbddamvPllFCZ
   cEgLGcFz+oMqTVVTLbTNQ4HHJO/tJjKdZFxR06EzSVuZU+0MGI6dPW9vn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266376380"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="266376380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="684508487"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2022 05:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01FDD18F; Fri, 10 Jun 2022 15:02:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] driver core: Introduce device_find_any_child() helper
Date:   Fri, 10 Jun 2022 15:02:18 +0300
Message-Id: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the kernel where this kind of functionality is
being used. Provide a generic helper for such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: renamed method (Greg), refactored it (Rafael)
 drivers/base/core.c    | 20 ++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7cd789c4985d..a519307fda60 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3832,6 +3832,26 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
+static int match_any(struct device *dev, void *unused)
+{
+	return 1;
+}
+
+/**
+ * device_find_any_child - device iterator for locating a child device, if any.
+ * @parent: parent struct device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to a child device, if any.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+struct device *device_find_any_child(struct device *parent)
+{
+	return device_find_child(parent, NULL, match_any);
+}
+EXPORT_SYMBOL_GPL(device_find_any_child);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index dc941997795c..424b55df0272 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -905,6 +905,8 @@ struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);
+struct device *device_find_any_child(struct device *parent);
+
 int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
-- 
2.35.1

