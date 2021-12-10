Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38BD4708C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbhLJSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbhLJSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:34:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4639C061A72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:30:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id o14so6814365plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+APKFk652WdPwEN56X54HMQ+CeKhXmc/dvKAXru1Jw=;
        b=JMAXnxR0D6JYrOCtex3gnJ0Dh/UWnRvvRV+UOxXdVBxTHQXblAbrJuDf3MKLknNcP7
         AcCzfRbK7wk3rAR/wacyCTJD1k6pQPbeuyAz9xEHkC47mjkWtaRRFcPAIkmgsUpBLZLy
         GyyOmTav96dpwpnFM/D2IQ5VICtLuV49PHCyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+APKFk652WdPwEN56X54HMQ+CeKhXmc/dvKAXru1Jw=;
        b=CSUI53VMfvDefWzJSxiuO2IqB37FmFkSRByLYhaANpqDYjDacRye5mZaYEC3gAUn6g
         kjlcZaDcbaUWYh0aCXP8Y/fwIbos6430kkFAkOxfQW1JFfcTWQwTqJGtshDFnP+I7j+w
         flM9+Qbojs1a2yiZInl2FMJpbJSepF2sl8fiRBl790g+nwKhbDMxI0xx+OyWgyw3zyGB
         e4AVbn/k28ifZoQgkbpEqixJJTphPk+6QGJqZjKgAEm12D+VruA8lsHQhu/IecDd+2Ou
         SDXplMpBkCv0gvyNvg7T+3DMW7za1hr51PpUsODeNYH8meJdf+vflv18Pz4dJENzK/t8
         p3lQ==
X-Gm-Message-State: AOAM5336SdoDjcutvnZJbucWTwZCU0WGRF0WT4PXRiEKEw7ua02hN/OI
        F8hc9xabJ8uyRLhTmvqchE9quA==
X-Google-Smtp-Source: ABdhPJxVOqS6VUAUpt5Ex74kq4zFeMJqCNdCyUJtLgzBBQM3VQQODJvrQC19DNqnF9qduHtWCJjjGw==
X-Received: by 2002:a17:90a:9513:: with SMTP id t19mr8885159pjo.184.1639161035244;
        Fri, 10 Dec 2021 10:30:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:d386:8bb1:aaa7:a294])
        by smtp.gmail.com with UTF8SMTPSA id d195sm3400721pga.41.2021.12.10.10.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:30:35 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Peter Chen <peter.chen@kernel.org>, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Roger Quadros <rogerq@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v18 3/5] usb: misc: Add onboard_usb_hub driver
Date:   Fri, 10 Dec 2021 10:30:19 -0800
Message-Id: <20211210102923.v18.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211210183021.3500376-1-mka@chromium.org>
References: <20211210183021.3500376-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main issue this driver addresses is that a USB hub needs to be
powered before it can be discovered. For discrete onboard hubs (an
example for such a hub is the Realtek RTS5411) this is often solved
by supplying the hub with an 'always-on' regulator, which is kind
of a hack. Some onboard hubs may require further initialization
steps, like changing the state of a GPIO or enabling a clock, which
requires even more hacks. This driver creates a platform device
representing the hub which performs the necessary initialization.
Currently it only supports switching on a single regulator, support
for multiple regulators or other actions can be added as needed.
Different initialization sequences can be supported based on the
compatible string.

Besides performing the initialization the driver can be configured
to power the hub off during system suspend. This can help to extend
battery life on battery powered devices which have no requirements
to keep the hub powered during suspend. The driver can also be
configured to leave the hub powered when a wakeup capable USB device
is connected when suspending, and power it off otherwise.

Technically the driver consists of two drivers, the platform driver
described above and a very thin USB driver that subclasses the
generic driver. The purpose of this driver is to provide the platform
driver with the USB devices corresponding to the hub(s) (a hub
controller may provide multiple 'logical' hubs, e.g. one to support
USB 2.0 and another for USB 3.x).

Note: the current series only supports hubs connected directly to
a root hub, support for other configurations could be added if
needed.

Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---

Changes in v18:
- introduced hidden Kconfig option to align module vs. builtin
  choice with CONFIG_USB (thanks Doug!)
- refactored onboard_hub_create_pdevs()

Changes in v17:
- updated date and kernel version in ABI documentation for
  'always_powered_in_suspend' attribute
- removed obsolete .yaml entry from MAINTAINERS file
- added entry for ABI documentation to MAINTAINERS file
- renamed struct 'udev_node' to 'usbdev_node'
- changed return logic in onboard_hub_suspend/resume() to
  get rid of 'rc' variable
- added helper set_udev_link_name() to set link names for
  onboard hub USB devices
- use of_parse_phandle() instead of of_property_read_u32() +
  of_find_node_by_phandle() combo
- defer probing in _find_onboard_hub() if the platform device
  isn't bound yet
- initialize list head passed as parameter to
  onboard_hub_create_pdevs() instead of relying on the caller
  to do so
- don't require the 'companion-hub' property to be specified.
  This is needed to support hubs without companion hub
- use devm_kzalloc() to allocate platform device list entries
  and stop freeing them explicitly
- remove unnecessary INIT_LIST_HEAD() of platform device list
  entries
- use '%pOF' to print DT node name
- delete platform device list entries from the list of devices
  in onboard_hub_destroy_pdevs(). It shouldn't be strictly
  necessary, but better be on the safe side.

Changes in v16:
- none

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- none

Changes in v12:
- use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE) in onboard_hub.h to
  also check for the driver built as module
- include onboard_hub.h again from the driver to make sure there are
  prototype declarations for the public functions
- remove indentation from label in onboard_hub_create_pdevs()

Changes in v11:
- added onboard_hub_create/destroy_pdevs() helpers, to support multiple onboard
  hubs connected to the same parent hub
- don't include ‘onboard_hub.h’ from the onboard hub driver
- updated commit message
- added ‘Acked-by' from Alan

Changes in v10:
- always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m

Changes in v9:
- none

Changes in v8:
- none

Changes in v7:
- don't declare stub for of_is_onboard_usb_hub() when
  CONFIG_COMPILE_TEST is defined

Changes in v6:
- use 'companion-hub' to locate the platform device, instead of
  scanning through the nodes of the parent
- added ABI documentation for 'always_powered_in_suspend'
- sysfs_emit() instead of sprintf() in always_powered_in_suspend_show()
- register sysfs attribute through driver.dev_groups
- evaluate return value of driver_attach() in _probe()
- use dev_warn() instead of WARN_ON() in _probe()
- include 'onboard_hub.h'

Changes in v5:
- the platform device is now instantiated from the same DT node
  as the 'primary' USB hub device
  - use the USB compatible strings for the platform device
  - refactored _find_onboard_hub() to search the parents child
    nodes for a platform device with a matching compatible string
  - added exported function of_is_onboard_usb_hub() to allow other
    drivers (like xhci_plat) to check if one of their child DT nodes
    is a supported hub
- use late suspend to make sure info about wakeup enabled descendants
  is updated
- call driver_attach() for the USB driver in onboard_hub_probe() to
  make sure the driver is re-attached after the device_release_driver()
  calls in onboard_hub_remove()
- renamed sysfs attribute 'power_off_in_suspend' to
  'always_powered_in_suspend'
- added sysfs symlinks between platform device and USB devices
- marked 'onboard_hub_pm_ops' as __maybe_unused
- removed 'realtek' compatible string which is not needed at this
  point
- fix log for regulator_disable() failure

Changes in v4:
- updated Kconfig documentation
- changed the loop in onboard_hub_remove() to release the hub lock
  before unbinding the USB device and make self deadlock prevention
  less clunky
- fixed return value in onboard_hub_usbdev_probe()
- added entry to MAINTAINERS file

Changes in v3:
- updated the commit message
- updated description in Kconfig
- remove include of 'core/usb.h'
- use 'is_powered_on' flag instead of 'has_wakeup_capable_descendants'
- added 'going_away' flag to struct onboard_hub
  - don't allow adding new USB devices when the platform device is going away
  - don't bother with deleting the list item in onboard_hub_remove_usbdev()
    when the platform device is going away
- don't assume in onboard_hub_suspend() that all USB hub devices are
  connected to the same controller
- removed unnecessary devm_kfree() from onboard_hub_remove_usbdev()
- fixed error handling in onboard_hub_remove_usbdev()
- use kstrtobool() instead of strtobool() in power_off_in_suspend_store()
- unbind USB devices in onboard_hub_remove() to avoid dangling references
  to the platform device
- moved put_device() for platform device to _find_onboard_hub()
- changed return value of onboard_hub_remove_usbdev() to void
- evaluate return value of onboard_hub_add_usbdev()
- register 'power_off_in_suspend' as managed device attribute
- use USB_DEVICE macro instead manual initialization
- add unwinding to onboard_hub_init()
- updated MODULE_DESCRIPTION
- use module_init() instead of device_initcall()

Changes in v2:
- check wakeup enabled state of the USB controller instead of
  using 'wakeup-source' property
- use sysfs attribute instead of DT property to determine if
  the hub should be powered off at all during system suspend
- added missing brace in onboard_hub_suspend()
- updated commit message
- use pm_ptr for pm_ops as suggested by Alan

Changes in v1:
- renamed the driver to 'onboard_usb_hub'
- single file for platform and USB driver
- USB hub devices register with the platform device
  - the DT includes a phandle of the platform device
- the platform device now controls when power is turned off
- the USB driver became a very thin subclass of the generic USB
  driver
- enabled autosuspend support

 .../sysfs-bus-platform-onboard-usb-hub        |   8 +
 MAINTAINERS                                   |   7 +
 drivers/usb/misc/Kconfig                      |  23 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 490 ++++++++++++++++++
 include/linux/usb/onboard_hub.h               |  18 +
 6 files changed, 547 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 include/linux/usb/onboard_hub.h

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
new file mode 100644
index 000000000000..39fa2ed29fed
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
@@ -0,0 +1,8 @@
+What:		/sys/bus/platform/devices/<dev>/always_powered_in_suspend
+Date:		November 2021
+KernelVersion:	5.17
+Contact:	Matthias Kaehlcke <matthias@kaehlcke.net>
+		linux-usb@vger.kernel.org
+Description:
+		(RW) Controls whether the USB hub remains always powered
+		during system suspend or not.
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 43007f2d29e0..a7ceef1e4235 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14183,6 +14183,13 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov9734.c
 
+ONBOARD USB HUB DRIVER
+M:	Matthias Kaehlcke <mka@chromium.org>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
+F:	drivers/usb/misc/onboard_usb_hub.c
+
 ONENAND FLASH DRIVER
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 8f1144359012..bbced519499a 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -284,3 +284,26 @@ config BRCM_USB_PINMAP
 	  This option enables support for remapping some USB external
 	  signals, which are typically on dedicated pins on the chip,
 	  to any gpio.
+
+config USB_ONBOARD_HUB
+	bool "Onboard USB hub support"
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y here if you want to support discrete onboard USB hubs that
+	  don't require an additional control bus for initialization, but
+	  need some nontrivial form of initialization, such as enabling a
+	  power regulator. An example for such a hub is the Realtek
+	  RTS5411.
+
+	  This driver can be used as a module but its state (module vs
+	  builtin) must match the state of the USB subsystem. Enabling
+	  this config will enable the driver and it will automatically
+	  match the state of the USB subsystem. If this driver is a
+	  module it will be called onboard_usb_hub.
+
+if USB_ONBOARD_HUB
+config USB_ONBOARD_HUB_ACTUAL
+	tristate
+	default m if USB=m
+	default y if USB=y
+endif
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598573ab..9549b88c2cc1 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
 obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
+obj-$(CONFIG_USB_ONBOARD_HUB_ACTUAL)	+= onboard_usb_hub.o
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
new file mode 100644
index 000000000000..dea75bb4dcad
--- /dev/null
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Driver for onboard USB hubs
+ *
+ * Copyright (c) 2020, Google LLC
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/of.h>
+#include <linux/usb/onboard_hub.h>
+
+static struct usb_device_driver onboard_hub_usbdev_driver;
+
+/************************** Platform driver **************************/
+
+struct usbdev_node {
+	struct usb_device *udev;
+	struct list_head list;
+};
+
+struct onboard_hub {
+	struct regulator *vdd;
+	struct device *dev;
+	bool always_powered_in_suspend;
+	bool is_powered_on;
+	bool going_away;
+	struct list_head udev_list;
+	struct mutex lock;
+};
+
+static int onboard_hub_power_on(struct onboard_hub *hub)
+{
+	int err;
+
+	err = regulator_enable(hub->vdd);
+	if (err) {
+		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	hub->is_powered_on = true;
+
+	return 0;
+}
+
+static int onboard_hub_power_off(struct onboard_hub *hub)
+{
+	int err;
+
+	err = regulator_disable(hub->vdd);
+	if (err) {
+		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
+		return err;
+	}
+
+	hub->is_powered_on = false;
+
+	return 0;
+}
+
+static int __maybe_unused onboard_hub_suspend(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	struct usbdev_node *node;
+	bool power_off;
+
+	if (hub->always_powered_in_suspend)
+		return 0;
+
+	power_off = true;
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (!device_may_wakeup(node->udev->bus->controller))
+			continue;
+
+		if (usb_wakeup_enabled_descendants(node->udev)) {
+			power_off = false;
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+
+	if (!power_off)
+		return 0;
+
+	return onboard_hub_power_off(hub);
+}
+
+static int __maybe_unused onboard_hub_resume(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+
+	if (hub->is_powered_on)
+		return 0;
+
+	return onboard_hub_power_on(hub);
+}
+
+static inline void set_udev_link_name(struct usb_device *udev, char *buf, size_t size)
+{
+	snprintf(buf, size, "usb_dev.%s", dev_name(&udev->dev));
+}
+
+static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct usbdev_node *node;
+	char link_name[64];
+	int ret = 0;
+
+	mutex_lock(&hub->lock);
+
+	if (hub->going_away) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	node->udev = udev;
+
+	list_add(&node->list, &hub->udev_list);
+
+	set_udev_link_name(udev, link_name, sizeof(link_name));
+	WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));
+
+unlock:
+	mutex_unlock(&hub->lock);
+
+	return ret;
+}
+
+static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct usbdev_node *node;
+	char link_name[64];
+
+	set_udev_link_name(udev, link_name, sizeof(link_name));
+	sysfs_remove_link(&hub->dev->kobj, link_name);
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (node->udev == udev) {
+			list_del(&node->list);
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+}
+
+static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hub->always_powered_in_suspend);
+}
+
+static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	hub->always_powered_in_suspend = val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(always_powered_in_suspend);
+
+static struct attribute *onboard_hub_attrs[] = {
+	&dev_attr_always_powered_in_suspend.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(onboard_hub);
+
+static int onboard_hub_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onboard_hub *hub;
+	int err;
+
+	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	hub->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(hub->vdd))
+		return PTR_ERR(hub->vdd);
+
+	hub->dev = dev;
+	mutex_init(&hub->lock);
+	INIT_LIST_HEAD(&hub->udev_list);
+
+	dev_set_drvdata(dev, hub);
+
+	err = onboard_hub_power_on(hub);
+	if (err)
+		return err;
+
+	/*
+	 * The USB driver might have been detached from the USB devices by
+	 * onboard_hub_remove(), make sure to re-attach it if needed.
+	 */
+	err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
+	if (err) {
+		onboard_hub_power_off(hub);
+		return err;
+	}
+
+	return 0;
+}
+
+static int onboard_hub_remove(struct platform_device *pdev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+	struct usbdev_node *node;
+	struct usb_device *udev;
+
+	hub->going_away = true;
+
+	mutex_lock(&hub->lock);
+
+	/* unbind the USB devices to avoid dangling references to this device */
+	while (!list_empty(&hub->udev_list)) {
+		node = list_first_entry(&hub->udev_list, struct usbdev_node, list);
+		udev = node->udev;
+
+		/*
+		 * Unbinding the driver will call onboard_hub_remove_usbdev(),
+		 * which acquires hub->lock.  We must release the lock first.
+		 */
+		get_device(&udev->dev);
+		mutex_unlock(&hub->lock);
+		device_release_driver(&udev->dev);
+		put_device(&udev->dev);
+		mutex_lock(&hub->lock);
+	}
+
+	mutex_unlock(&hub->lock);
+
+	return onboard_hub_power_off(hub);
+}
+
+static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "usbbda,411" },
+	{ .compatible = "usbbda,5411" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, onboard_hub_match);
+
+static bool of_is_onboard_usb_hub(const struct device_node *np)
+{
+	return !!of_match_node(onboard_hub_match, np);
+}
+
+static const struct dev_pm_ops __maybe_unused onboard_hub_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(onboard_hub_suspend, onboard_hub_resume)
+};
+
+static struct platform_driver onboard_hub_driver = {
+	.probe = onboard_hub_probe,
+	.remove = onboard_hub_remove,
+
+	.driver = {
+		.name = "onboard-usb-hub",
+		.of_match_table = onboard_hub_match,
+		.pm = pm_ptr(&onboard_hub_pm_ops),
+		.dev_groups = onboard_hub_groups,
+	},
+};
+
+/************************** USB driver **************************/
+
+#define VENDOR_ID_REALTEK	0x0bda
+
+/*
+ * Returns the onboard_hub platform device that is associated with the USB
+ * device passed as parameter.
+ */
+static struct onboard_hub *_find_onboard_hub(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	pdev = of_find_device_by_node(dev->of_node);
+	if (!pdev) {
+		np = of_parse_phandle(dev->of_node, "companion-hub", 0);
+		if (!np) {
+			dev_err(dev, "failed to find device node for companion hub\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+
+		if (!pdev || !device_is_bound(&pdev->dev))
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	put_device(&pdev->dev);
+
+	return dev_get_drvdata(&pdev->dev);
+}
+
+static int onboard_hub_usbdev_probe(struct usb_device *udev)
+{
+	struct device *dev = &udev->dev;
+	struct onboard_hub *hub;
+	int err;
+
+	/* ignore supported hubs without device tree node */
+	if (!dev->of_node)
+		return -ENODEV;
+
+	hub = _find_onboard_hub(dev);
+	if (IS_ERR(hub))
+		return PTR_ERR(hub);
+
+	dev_set_drvdata(dev, hub);
+
+	err = onboard_hub_add_usbdev(hub, udev);
+	if (err)
+		return err;
+
+	err = sysfs_create_link(&udev->dev.kobj, &hub->dev->kobj, "onboard_hub_dev");
+	if (err)
+		dev_warn(&udev->dev, "failed to create symlink to platform device: %d\n", err);
+
+	return 0;
+}
+
+static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
+
+	sysfs_remove_link(&udev->dev.kobj, "onboard_hub_dev");
+
+	onboard_hub_remove_usbdev(hub, udev);
+}
+
+static const struct usb_device_id onboard_hub_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.0 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.0 */
+	{},
+};
+
+MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
+
+static struct usb_device_driver onboard_hub_usbdev_driver = {
+	.name = "onboard-usb-hub",
+	.probe = onboard_hub_usbdev_probe,
+	.disconnect = onboard_hub_usbdev_disconnect,
+	.generic_subclass = 1,
+	.supports_autosuspend =	1,
+	.id_table = onboard_hub_id_table,
+};
+
+/*** Helpers for creating/destroying platform devices for onboard hubs ***/
+
+struct pdev_list_entry {
+	struct platform_device *pdev;
+	struct list_head node;
+};
+
+/*
+ * Creates a platform device for each supported onboard hub that is connected to
+ * the given parent hub. To keep track of the platform devices they are added to
+ * a list that is owned by the parent hub.
+ */
+void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
+{
+	int i;
+	struct device_node *np, *npc;
+	struct platform_device *pdev = NULL;
+	struct pdev_list_entry *pdle;
+
+	INIT_LIST_HEAD(pdev_list);
+
+	for (i = 1; i <= parent_hub->maxchild; i++) {
+		np = usb_of_get_device_node(parent_hub, i);
+		if (!np)
+			continue;
+
+		if (!of_is_onboard_usb_hub(np))
+			goto node_put;
+
+		npc = of_parse_phandle(np, "companion-hub", 0);
+		if (npc) {
+			pdev = of_find_device_by_node(npc);
+			of_node_put(npc);
+		}
+
+		if (pdev) {
+			/* the companion hub already has a platform device, nothing to do here */
+			put_device(&pdev->dev);
+			goto node_put;
+		}
+
+		pdev = of_platform_device_create(np, NULL, &parent_hub->dev);
+		if (!pdev) {
+			dev_err(&parent_hub->dev,
+				"failed to create platform device for onboard hub '%pOF'\n", np);
+			goto node_put;
+		}
+
+		pdle = devm_kzalloc(&pdev->dev, sizeof(*pdle), GFP_KERNEL);
+		if (!pdle) {
+			of_platform_device_destroy(&pdev->dev, NULL);
+			goto node_put;
+		}
+
+		pdle->pdev = pdev;
+		list_add(&pdle->node, pdev_list);
+
+node_put:
+		of_node_put(np);
+	}
+}
+EXPORT_SYMBOL_GPL(onboard_hub_create_pdevs);
+
+/*
+ * Destroys the platform devices in the given list and frees the memory associated
+ * with the list entry.
+ */
+void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
+{
+	struct pdev_list_entry *pdle, *tmp;
+
+	list_for_each_entry_safe(pdle, tmp, pdev_list, node) {
+		list_del(&pdle->node);
+		of_platform_device_destroy(&pdle->pdev->dev, NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(onboard_hub_destroy_pdevs);
+
+/************************** Driver (de)registration **************************/
+
+static int __init onboard_hub_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&onboard_hub_driver);
+	if (ret)
+		return ret;
+
+	ret = usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
+	if (ret)
+		platform_driver_unregister(&onboard_hub_driver);
+
+	return ret;
+}
+module_init(onboard_hub_init);
+
+static void __exit onboard_hub_exit(void)
+{
+	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
+	platform_driver_unregister(&onboard_hub_driver);
+}
+module_exit(onboard_hub_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Driver for discrete onboard USB hubs");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/usb/onboard_hub.h b/include/linux/usb/onboard_hub.h
new file mode 100644
index 000000000000..d9373230556e
--- /dev/null
+++ b/include/linux/usb/onboard_hub.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_USB_ONBOARD_HUB_H
+#define __LINUX_USB_ONBOARD_HUB_H
+
+struct usb_device;
+struct list_head;
+
+#if IS_ENABLED(CONFIG_USB_ONBOARD_HUB)
+void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list);
+void onboard_hub_destroy_pdevs(struct list_head *pdev_list);
+#else
+static inline void onboard_hub_create_pdevs(struct usb_device *parent_hub,
+					    struct list_head *pdev_list) {}
+static inline void onboard_hub_destroy_pdevs(struct list_head *pdev_list) {}
+#endif
+
+#endif /* __LINUX_USB_ONBOARD_HUB_H */
-- 
2.34.1.173.g76aa8bc2d0-goog

