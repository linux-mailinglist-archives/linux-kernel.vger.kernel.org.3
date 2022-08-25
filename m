Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243B15A16D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbiHYQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiHYQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:41:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C6FB9F85;
        Thu, 25 Aug 2022 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661445662; x=1692981662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ipgmuE2YNebiTYyr6pNxvrRl4wbsFK6T5Vp+SAGbN4=;
  b=QjX5J3l7+u+bljJOJJuezvzgSlPWdgMvTO4+csQfNn7XFKsfz9f/FJe0
   FtS7Vc/U4rTzefRjY8R+Srk56N3sZgOjcAUGoKzCvTqJknApCF45LJkFw
   D5W25sJAk5Pc1PC3k7+UdwGvT0tLsGbiQxjqm6TgojW2iEbIISv/YzZT/
   yI1NcHhwQVdHocZKiuzri4meuPD7jlxZhIJfsrtGYfWiqrMv6zvIrVe+a
   okRDiY9rl4oQzqyqf+JC557HDzHJcVu0HyzrOb/AbPpFhwzCP+S8lTMhd
   aMefOIvYPydyUS2yqLhM7chb7UG7e93UQnXD+HCXTuXXBowcqeXEN6hEv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274046559"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="274046559"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="938403134"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2022 09:41:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4231C2E7; Thu, 25 Aug 2022 19:41:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/5] ACPI: bus: Move bus type operations upper in the code
Date:   Thu, 25 Aug 2022 19:41:02 +0300
Message-Id: <20220825164103.27694-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ACPI bus type operations upper in the code, it may be used later
by ACPI device matching code. No functional change intended.

While at it, provide dev_is_acpi() macro helper as it's done for some
other bus types.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 250 +++++++++++++++++++++++----------------------
 1 file changed, 126 insertions(+), 124 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 607e664b7976..3c0f2d050d47 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -647,6 +647,132 @@ static int __init acpi_setup_sb_notify_handler(void)
 	return 0;
 }
 
+/* --------------------------------------------------------------------------
+                              ACPI Bus operations
+   -------------------------------------------------------------------------- */
+
+static int acpi_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
+
+	return acpi_dev->flags.match_driver
+		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
+}
+
+static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
+}
+
+static int acpi_device_probe(struct device *dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
+	int ret;
+
+	if (acpi_dev->handler && !acpi_is_pnp_device(acpi_dev))
+		return -EINVAL;
+
+	if (!acpi_drv->ops.add)
+		return -ENOSYS;
+
+	ret = acpi_drv->ops.add(acpi_dev);
+	if (ret)
+		return ret;
+
+	pr_debug("Driver [%s] successfully bound to device [%s]\n",
+		 acpi_drv->name, acpi_dev->pnp.bus_id);
+
+	if (acpi_drv->ops.notify) {
+		ret = acpi_device_install_notify_handler(acpi_dev);
+		if (ret) {
+			if (acpi_drv->ops.remove)
+				acpi_drv->ops.remove(acpi_dev);
+
+			acpi_dev->driver_data = NULL;
+			return ret;
+		}
+	}
+
+	pr_debug("Found driver [%s] for device [%s]\n", acpi_drv->name,
+		 acpi_dev->pnp.bus_id);
+
+	get_device(dev);
+	return 0;
+}
+
+static void acpi_device_remove(struct device *dev)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
+
+	if (acpi_drv->ops.notify)
+		acpi_device_remove_notify_handler(acpi_dev);
+
+	if (acpi_drv->ops.remove)
+		acpi_drv->ops.remove(acpi_dev);
+
+	acpi_dev->driver_data = NULL;
+
+	put_device(dev);
+}
+
+struct bus_type acpi_bus_type = {
+	.name		= "acpi",
+	.match		= acpi_bus_match,
+	.probe		= acpi_device_probe,
+	.remove		= acpi_device_remove,
+	.uevent		= acpi_device_uevent,
+};
+
+#define dev_is_acpi(dev)	((dev)->bus == &acpi_bus_type)
+
+int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data)
+{
+	return bus_for_each_dev(&acpi_bus_type, NULL, data, fn);
+}
+EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
+
+struct acpi_dev_walk_context {
+	int (*fn)(struct acpi_device *, void *);
+	void *data;
+};
+
+static int acpi_dev_for_one_check(struct device *dev, void *context)
+{
+	struct acpi_dev_walk_context *adwc = context;
+
+	if (!dev_is_acpi(dev))
+		return 0;
+
+	return adwc->fn(to_acpi_device(dev), adwc->data);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_for_each_child);
+
+int acpi_dev_for_each_child(struct acpi_device *adev,
+			    int (*fn)(struct acpi_device *, void *), void *data)
+{
+	struct acpi_dev_walk_context adwc = {
+		.fn = fn,
+		.data = data,
+	};
+
+	return device_for_each_child(&adev->dev, &adwc, acpi_dev_for_one_check);
+}
+
+int acpi_dev_for_each_child_reverse(struct acpi_device *adev,
+				    int (*fn)(struct acpi_device *, void *),
+				    void *data)
+{
+	struct acpi_dev_walk_context adwc = {
+		.fn = fn,
+		.data = data,
+	};
+
+	return device_for_each_child_reverse(&adev->dev, &adwc, acpi_dev_for_one_check);
+}
+
 /* --------------------------------------------------------------------------
                              Device Matching
    -------------------------------------------------------------------------- */
@@ -998,130 +1124,6 @@ void acpi_bus_unregister_driver(struct acpi_driver *driver)
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
-/* --------------------------------------------------------------------------
-                              ACPI Bus operations
-   -------------------------------------------------------------------------- */
-
-static int acpi_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
-
-	return acpi_dev->flags.match_driver
-		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
-}
-
-static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
-}
-
-static int acpi_device_probe(struct device *dev)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
-	int ret;
-
-	if (acpi_dev->handler && !acpi_is_pnp_device(acpi_dev))
-		return -EINVAL;
-
-	if (!acpi_drv->ops.add)
-		return -ENOSYS;
-
-	ret = acpi_drv->ops.add(acpi_dev);
-	if (ret)
-		return ret;
-
-	pr_debug("Driver [%s] successfully bound to device [%s]\n",
-		 acpi_drv->name, acpi_dev->pnp.bus_id);
-
-	if (acpi_drv->ops.notify) {
-		ret = acpi_device_install_notify_handler(acpi_dev);
-		if (ret) {
-			if (acpi_drv->ops.remove)
-				acpi_drv->ops.remove(acpi_dev);
-
-			acpi_dev->driver_data = NULL;
-			return ret;
-		}
-	}
-
-	pr_debug("Found driver [%s] for device [%s]\n", acpi_drv->name,
-		 acpi_dev->pnp.bus_id);
-
-	get_device(dev);
-	return 0;
-}
-
-static void acpi_device_remove(struct device *dev)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
-
-	if (acpi_drv->ops.notify)
-		acpi_device_remove_notify_handler(acpi_dev);
-
-	if (acpi_drv->ops.remove)
-		acpi_drv->ops.remove(acpi_dev);
-
-	acpi_dev->driver_data = NULL;
-
-	put_device(dev);
-}
-
-struct bus_type acpi_bus_type = {
-	.name		= "acpi",
-	.match		= acpi_bus_match,
-	.probe		= acpi_device_probe,
-	.remove		= acpi_device_remove,
-	.uevent		= acpi_device_uevent,
-};
-
-int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data)
-{
-	return bus_for_each_dev(&acpi_bus_type, NULL, data, fn);
-}
-EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
-
-struct acpi_dev_walk_context {
-	int (*fn)(struct acpi_device *, void *);
-	void *data;
-};
-
-static int acpi_dev_for_one_check(struct device *dev, void *context)
-{
-	struct acpi_dev_walk_context *adwc = context;
-
-	if (dev->bus != &acpi_bus_type)
-		return 0;
-
-	return adwc->fn(to_acpi_device(dev), adwc->data);
-}
-EXPORT_SYMBOL_GPL(acpi_dev_for_each_child);
-
-int acpi_dev_for_each_child(struct acpi_device *adev,
-			    int (*fn)(struct acpi_device *, void *), void *data)
-{
-	struct acpi_dev_walk_context adwc = {
-		.fn = fn,
-		.data = data,
-	};
-
-	return device_for_each_child(&adev->dev, &adwc, acpi_dev_for_one_check);
-}
-
-int acpi_dev_for_each_child_reverse(struct acpi_device *adev,
-				    int (*fn)(struct acpi_device *, void *),
-				    void *data)
-{
-	struct acpi_dev_walk_context adwc = {
-		.fn = fn,
-		.data = data,
-	};
-
-	return device_for_each_child_reverse(&adev->dev, &adwc, acpi_dev_for_one_check);
-}
-
 /* --------------------------------------------------------------------------
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
-- 
2.35.1

