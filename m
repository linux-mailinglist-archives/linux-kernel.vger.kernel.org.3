Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB347D3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbhLVOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:33:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:11411 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241409AbhLVOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640183580; x=1671719580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMuI78KUbocQ1A8SQsjVQV3ZHOM5ecZjTBHhcTrKJLw=;
  b=AMf7JHf4/q/WoO596h/icoKZymxOhbs1G0fk7T2ixN6lGj7R3mLBMn0E
   KohttluU4A4cebmmdBtUR7bFmolwqyHt3Vk7PEywtzEKbgQCW9nyzkkdV
   L1fijq6NE3BWjQsHDl8jg8oEQQGavoU69ffF8IgJ+FahPDk4oZ2UjSCeO
   +N74YOgvY3TLIVbgnyAGRiCnFXIGsyx0q+abvrmkYh/NaU37RniynKey5
   bsUu0Nx5btuxzZKpV9HKu8911fyGYPYh9Wh1uICNvBeI+36x88O3h+QqN
   3wRPn66BS5gpV2afzLmLHlC8yJ4EhR8GMN+xSCLL35/1YskAEjPmVstHR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240580569"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240580569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 06:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664285150"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 06:32:57 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] usb: Link the ports to the connectors they are attached to
Date:   Wed, 22 Dec 2021 17:32:56 +0300
Message-Id: <20211222143258.82305-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating link to the USB Type-C connector for every new port
that is added when possible.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
 drivers/usb/core/port.c                 | 32 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 2ebe5708b4bc0..7efe31ed3a25c 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -244,6 +244,15 @@ Description:
 		is permitted, "u2" if only u2 is permitted, "u1_u2" if both u1 and
 		u2 are permitted.
 
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/connector
+Date:		December 2021
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Link to the USB Type-C connector when available. This link is
+		only created when USB Type-C Connector Class is enabled, and
+		only if the system firmware is capable of describing the
+		connection between a port and its connector.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index dfcca9c876c73..c2bbf97a79bec 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/component.h>
 
 #include "hub.h"
 
@@ -528,6 +529,32 @@ static void find_and_link_peer(struct usb_hub *hub, int port1)
 		link_peers_report(port_dev, peer);
 }
 
+static int connector_bind(struct device *dev, struct device *connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &connector->kobj, "connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&connector->kobj, &dev->kobj, dev_name(dev));
+	if (ret)
+		sysfs_remove_link(&dev->kobj, "connector");
+
+	return ret;
+}
+
+static void connector_unbind(struct device *dev, struct device *connector, void *data)
+{
+	sysfs_remove_link(&connector->kobj, dev_name(dev));
+	sysfs_remove_link(&dev->kobj, "connector");
+}
+
+static const struct component_ops connector_ops = {
+	.bind = connector_bind,
+	.unbind = connector_unbind,
+};
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -577,6 +604,10 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 
 	find_and_link_peer(hub, port1);
 
+	retval = component_add(&port_dev->dev, &connector_ops);
+	if (retval)
+		dev_warn(&port_dev->dev, "failed to add component\n");
+
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()
 	 * will drop once the PM_QOS_NO_POWER_OFF flag state has been set
@@ -619,5 +650,6 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	component_del(&port_dev->dev, &connector_ops);
 	device_unregister(&port_dev->dev);
 }
-- 
2.34.1

