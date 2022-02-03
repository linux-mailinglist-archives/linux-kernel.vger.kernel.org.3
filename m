Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E64A842A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350660AbiBCM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:56:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:10602 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238237AbiBCM4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643892966; x=1675428966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lUFSsWWoUW0jcKH9PYBjci9zHnRVUYMyEJB78lDXxOA=;
  b=c2mFJZi7NLuJR/X766RIVPKwZGsoOmrGI14LPfWeuwGF7I/bMHPxLesV
   BX52ldX5R0sk+AfDnqgS0/W4mfkdMiNhMJ/45qlea/qt9q/Zyfe2iskkr
   6YCym2sk4FH/N4qYSA3QkwYinwunHvJCQzKAYj3aVAX+BpthSK4V/ieSz
   liCO80sOA2anWTJhr7Lgw7u5x1vc6H1UexGhENX1pCIO0VXelP4C3S4Nq
   tdobGEGwidaFsFImmxesKjNREyzVUDIbMHPtJA6uee1YfhEgXmjVKF+0t
   MS2uqoTlYtSyafPFAbtf3zQreANc89SYToQqw3k9TQB7QRQB29ldggLls
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272632200"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272632200"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 04:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535192768"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2022 04:56:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 263ED30A; Thu,  3 Feb 2022 14:56:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v1 1/1] device property: Don't split fwnode_get_irq*() APIs in the code
Date:   Thu,  3 Feb 2022 14:56:13 +0200
Message-Id: <20220203125613.1166-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New fwnode_get_irq_byname() landed after an unrelated function
by ordering. Move fwnode_iomap(), so fwnode_get_irq*() APIs will
go together.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Since the original code is piped via I2C tree, this one keeps the same route.

 drivers/base/property.c  | 32 ++++++++++++++++----------------
 include/linux/property.h |  6 +++---
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index fc59e0f7f9cc..c0e94cce9c29 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -895,6 +895,22 @@ int device_get_phy_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_phy_mode);
 
+/**
+ * fwnode_iomap - Maps the memory mapped IO for a given fwnode
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Index of the IO range
+ *
+ * Returns a pointer to the mapped memory.
+ */
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
+{
+	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
+		return of_iomap(to_of_node(fwnode), index);
+
+	return NULL;
+}
+EXPORT_SYMBOL(fwnode_iomap);
+
 /**
  * fwnode_irq_get - Get IRQ directly from a fwnode
  * @fwnode:	Pointer to the firmware node
@@ -919,22 +935,6 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
-/**
- * fwnode_iomap - Maps the memory mapped IO for a given fwnode
- * @fwnode:	Pointer to the firmware node
- * @index:	Index of the IO range
- *
- * Returns a pointer to the mapped memory.
- */
-void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
-{
-	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
-		return of_iomap(to_of_node(fwnode), index);
-
-	return NULL;
-}
-EXPORT_SYMBOL(fwnode_iomap);
-
 /**
  * fwnode_irq_get_byname - Get IRQ from a fwnode using its name
  * @fwnode:	Pointer to the firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 95d56a562b6a..4cd4b326941f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -123,8 +123,6 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
-
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
@@ -388,8 +386,10 @@ enum dev_dma_attr device_get_dma_attr(struct device *dev);
 const void *device_get_match_data(struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
-
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
+
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
+
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.34.1

