Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A84ADD0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381148AbiBHPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381168AbiBHPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:40:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124DC061576;
        Tue,  8 Feb 2022 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644334801; x=1675870801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5GHAP7ZVhH7jZoHSMyqPjbH7VLcG1Q34J+IofL1vuA=;
  b=T42RgmzK9au/bcPyawAhyl+/iTHF89h3+yhIQjzfh9HbaK18FF0MCbju
   ozYxZpAYVll4dfTTV6VnfMpg4Fj+XyR35XhG+gnhqOyS8WYJmaxoEN5FD
   t8MZltrcaa/GSSsaRMjHbLYNSqbKTMOj31n8jTrKc7VPv/GfKJuD9a6pm
   ftshx+W27ZB6u0ux7zP8+TkaYbYL7xhKKHL0NBt1GF48sDNtP+uUhc+Bd
   sQDI89axhklLTdX/eLmCg2mdvqncPuxtAXeJcRtsY+91XyaewTFU2pYKv
   ZGyapYBL83UaN62C9I4x9hIQsLNinBv/Ha8CxT0bpyhdyHSekv6nKVMzc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="247806259"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="247806259"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:40:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="621936501"
Received: from mgorzkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.139.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:39:54 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v8 07/13] peci: Add sysfs interface for PECI bus
Date:   Tue,  8 Feb 2022 16:36:33 +0100
Message-Id: <20220208153639.255278-8-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208153639.255278-1-iwona.winiarska@intel.com>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PECI devices may not be discoverable at the time when PECI controller is
being added (e.g. BMC can boot up when the Host system is still in S5).
Since we currently don't have the capabilities to figure out the Host
system state inside the PECI subsystem itself, we have to rely on
userspace to do it for us.

In the future, PECI subsystem may be expanded with mechanisms that allow
us to avoid depending on userspace interaction (e.g. CPU presence could
be detected using GPIO, and the information on whether it's discoverable
could be obtained over IPMI).
Unfortunately, those methods may ultimately not be available (support
will vary from platform to platform), which means that we still need
platform independent method triggered by userspace.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-peci | 16 +++++
 drivers/peci/Makefile                    |  2 +-
 drivers/peci/core.c                      |  3 +-
 drivers/peci/device.c                    |  1 +
 drivers/peci/internal.h                  |  5 ++
 drivers/peci/sysfs.c                     | 82 ++++++++++++++++++++++++
 6 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
 create mode 100644 drivers/peci/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-bus-peci b/Documentation/ABI/testing/sysfs-bus-peci
new file mode 100644
index 000000000000..87454ec5d981
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-peci
@@ -0,0 +1,16 @@
+What:		/sys/bus/peci/rescan
+Date:		July 2021
+KernelVersion:	5.18
+Contact:	Iwona Winiarska <iwona.winiarska@intel.com>
+Description:
+		Writing a non-zero value to this attribute will
+		initiate scan for PECI devices on all PECI controllers
+		in the system.
+
+What:		/sys/bus/peci/devices/<controller_id>-<device_addr>/remove
+Date:		July 2021
+KernelVersion:	5.18
+Contact:	Iwona Winiarska <iwona.winiarska@intel.com>
+Description:
+		Writing a non-zero value to this attribute will
+		remove the PECI device and any of its children.
diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
index c5f9d3fe21bb..917f689e147a 100644
--- a/drivers/peci/Makefile
+++ b/drivers/peci/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 # Core functionality
-peci-y := core.o request.o device.o
+peci-y := core.o request.o device.o sysfs.o
 obj-$(CONFIG_PECI) += peci.o
 
 # Hardware specific bus drivers
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index c3361e6e043a..e993615cf521 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -29,7 +29,7 @@ struct device_type peci_controller_type = {
 	.release	= peci_controller_dev_release,
 };
 
-static int peci_controller_scan_devices(struct peci_controller *controller)
+int peci_controller_scan_devices(struct peci_controller *controller)
 {
 	int ret;
 	u8 addr;
@@ -162,6 +162,7 @@ EXPORT_SYMBOL_NS_GPL(devm_peci_controller_add, PECI);
 
 struct bus_type peci_bus_type = {
 	.name		= "peci",
+	.bus_groups	= peci_bus_groups,
 };
 
 static int __init peci_init(void)
diff --git a/drivers/peci/device.c b/drivers/peci/device.c
index 2b3a2d893aaf..d10ed1cfcd48 100644
--- a/drivers/peci/device.c
+++ b/drivers/peci/device.c
@@ -116,5 +116,6 @@ static void peci_device_release(struct device *dev)
 }
 
 struct device_type peci_device_type = {
+	.groups		= peci_device_groups,
 	.release	= peci_device_release,
 };
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 57d11a902c5d..978e12c8e1d3 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 
 struct peci_controller;
+struct attribute_group;
 struct peci_device;
 struct peci_request;
 
@@ -19,12 +20,16 @@ struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u
 void peci_request_free(struct peci_request *req);
 
 extern struct device_type peci_device_type;
+extern const struct attribute_group *peci_device_groups[];
 
 int peci_device_create(struct peci_controller *controller, u8 addr);
 void peci_device_destroy(struct peci_device *device);
 
 extern struct bus_type peci_bus_type;
+extern const struct attribute_group *peci_bus_groups[];
 
 extern struct device_type peci_controller_type;
 
+int peci_controller_scan_devices(struct peci_controller *controller);
+
 #endif /* __PECI_INTERNAL_H */
diff --git a/drivers/peci/sysfs.c b/drivers/peci/sysfs.c
new file mode 100644
index 000000000000..db9ef05776e3
--- /dev/null
+++ b/drivers/peci/sysfs.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2021 Intel Corporation
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/peci.h>
+
+#include "internal.h"
+
+static int rescan_controller(struct device *dev, void *data)
+{
+	if (dev->type != &peci_controller_type)
+		return 0;
+
+	return peci_controller_scan_devices(to_peci_controller(dev));
+}
+
+static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
+{
+	bool res;
+	int ret;
+
+	ret = kstrtobool(buf, &res);
+	if (ret)
+		return ret;
+
+	if (!res)
+		return count;
+
+	ret = bus_for_each_dev(&peci_bus_type, NULL, NULL, rescan_controller);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static BUS_ATTR_WO(rescan);
+
+static struct attribute *peci_bus_attrs[] = {
+	&bus_attr_rescan.attr,
+	NULL
+};
+
+static const struct attribute_group peci_bus_group = {
+	.attrs = peci_bus_attrs,
+};
+
+const struct attribute_group *peci_bus_groups[] = {
+	&peci_bus_group,
+	NULL
+};
+
+static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct peci_device *device = to_peci_device(dev);
+	bool res;
+	int ret;
+
+	ret = kstrtobool(buf, &res);
+	if (ret)
+		return ret;
+
+	if (res && device_remove_file_self(dev, attr))
+		peci_device_destroy(device);
+
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0200, NULL, remove_store);
+
+static struct attribute *peci_device_attrs[] = {
+	&dev_attr_remove.attr,
+	NULL
+};
+
+static const struct attribute_group peci_device_group = {
+	.attrs = peci_device_attrs,
+};
+
+const struct attribute_group *peci_device_groups[] = {
+	&peci_device_group,
+	NULL
+};
-- 
2.34.1

