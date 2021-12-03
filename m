Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97AA4674E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbhLCKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379938AbhLCKdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xmiAVCHTpc3tneo3Cd+rX3PV2iLTm7XsCu2RahskpM=;
        b=RHoKoPqiQbpFoeb3rPn/kU4gwedQphcHMu7CEBYXmJlq3l62GI1L5betpAtrMyrgk3UzMm
        Tn88wKqkWvcnTgBs3BjB1uVnGu/gdoHlkgJuUgVqLlLWZf3q187j9gjhaFqFMvHv4IvXR1
        HcdtBFY14gnvA/mOmtqDmfdDQoXRq0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-Pw5Xfd3jMJyZlZWHFGbkLw-1; Fri, 03 Dec 2021 05:29:37 -0500
X-MC-Unique: Pw5Xfd3jMJyZlZWHFGbkLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EE981006AA2;
        Fri,  3 Dec 2021 10:29:35 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACDBA694BD;
        Fri,  3 Dec 2021 10:29:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v7 03/14] i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
Date:   Fri,  3 Dec 2021 11:28:46 +0100
Message-Id: <20211203102857.44539-4-hdegoede@redhat.com>
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change i2c_acpi_new_device() into i2c_acpi_new_device_by_fwnode() and
add a static inline wrapper providing the old i2c_acpi_new_device()
behavior.

This is necessary because in some cases we may only have access
to the fwnode / acpi_device and not to the matching physical-node
struct device *.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Minor tweak to stop spreading a comment over 2 lines

Changes in v6:
- New patch in v6 of this patch series
---
 drivers/i2c/i2c-core-acpi.c | 17 +++++++++++------
 include/linux/i2c.h         | 17 +++++++++++++----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 04338cbd08a9..c87ce2276007 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -476,8 +476,8 @@ struct notifier_block i2c_acpi_notifier = {
 };
 
 /**
- * i2c_acpi_new_device - Create i2c-client for the Nth I2cSerialBus resource
- * @dev:     Device owning the ACPI resources to get the client from
+ * i2c_acpi_new_device_by_fwnode - Create i2c-client for the Nth I2cSerialBus resource
+ * @fwnode:  fwnode with the ACPI resources to get the client from
  * @index:   Index of ACPI resource to get
  * @info:    describes the I2C device; note this is modified (addr gets set)
  * Context: can sleep
@@ -493,15 +493,20 @@ struct notifier_block i2c_acpi_notifier = {
  * Returns a pointer to the new i2c-client, or error pointer in case of failure.
  * Specifically, -EPROBE_DEFER is returned if the adapter is not found.
  */
-struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
-				       struct i2c_board_info *info)
+struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
+						 int index,
+						 struct i2c_board_info *info)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
 
+	adev = to_acpi_device_node(fwnode);
+	if (!adev)
+		return ERR_PTR(-ENODEV);
+
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
 	lookup.device_handle = acpi_device_handle(adev);
@@ -523,7 +528,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 
 	return i2c_new_client_device(adapter, info);
 }
-EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
+EXPORT_SYMBOL_GPL(i2c_acpi_new_device_by_fwnode);
 
 bool i2c_acpi_waive_d0_probe(struct device *dev)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 16119ac1aa97..7d4f52ceb7b5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -1025,8 +1025,9 @@ bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 			       struct acpi_resource_i2c_serialbus **i2c);
 int i2c_acpi_client_count(struct acpi_device *adev);
 u32 i2c_acpi_find_bus_speed(struct device *dev);
-struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
-				       struct i2c_board_info *info);
+struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
+						 int index,
+						 struct i2c_board_info *info);
 struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
 bool i2c_acpi_waive_d0_probe(struct device *dev);
 #else
@@ -1043,8 +1044,9 @@ static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
 {
 	return 0;
 }
-static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
-					int index, struct i2c_board_info *info)
+static inline struct i2c_client *i2c_acpi_new_device_by_fwnode(
+					struct fwnode_handle *fwnode, int index,
+					struct i2c_board_info *info)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -1058,4 +1060,11 @@ static inline bool i2c_acpi_waive_d0_probe(struct device *dev)
 }
 #endif /* CONFIG_ACPI */
 
+static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
+						     int index,
+						     struct i2c_board_info *info)
+{
+	return i2c_acpi_new_device_by_fwnode(dev_fwnode(dev), index, info);
+}
+
 #endif /* _LINUX_I2C_H */
-- 
2.33.1

