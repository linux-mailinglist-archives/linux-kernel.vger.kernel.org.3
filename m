Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891D1465D81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355585AbhLBErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:24208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355554AbhLBEqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:46:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216640179"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="216640179"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477788570"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:16 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/7] Documentation/auxiliary_bus: Clarify auxiliary_device creation
Date:   Wed,  1 Dec 2021 20:42:59 -0800
Message-Id: <20211202044305.4006853-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The documentation for creating an auxiliary device is a 3 step not a 2
step process.  Specifically the requirements of setting the name, id,
dev.release, and dev.parent fields was not clear as a precursor to the '2
step' process documented.

Clarify by declaring this a 3 step process starting with setting the
fields of struct auxiliary_device correctly.

Also add some sample code and tie the change into the rest of the
documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	From Jonathan
		Fix auxiliary spelling
	Update auxiliary_device_init and auxiliary_device_add kernel
		docs as well
---
 Documentation/driver-api/auxiliary_bus.rst | 81 ++++++++++++++++------
 drivers/base/auxiliary.c                   |  4 +-
 2 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
index ef902daf0d68..7dbb4f16462a 100644
--- a/Documentation/driver-api/auxiliary_bus.rst
+++ b/Documentation/driver-api/auxiliary_bus.rst
@@ -71,26 +71,14 @@ they are not physical devices that are controlled by DT/ACPI.  The same
 argument applies for not using MFD in this scenario as MFD relies on individual
 function devices being physical devices.
 
-Auxiliary Device
-================
+Auxiliary Device Creation
+=========================
 
 An auxiliary_device represents a part of its parent device's functionality. It
 is given a name that, combined with the registering drivers KBUILD_MODNAME,
 creates a match_name that is used for driver binding, and an id that combined
 with the match_name provide a unique name to register with the bus subsystem.
 
-Registering an auxiliary_device is a two-step process.  First call
-auxiliary_device_init(), which checks several aspects of the auxiliary_device
-struct and performs a device_initialize().  After this step completes, any
-error state must have a call to auxiliary_device_uninit() in its resolution path.
-The second step in registering an auxiliary_device is to perform a call to
-auxiliary_device_add(), which sets the name of the device and add the device to
-the bus.
-
-Unregistering an auxiliary_device is also a two-step process to mirror the
-register process.  First call auxiliary_device_delete(), then call
-auxiliary_device_uninit().
-
 .. code-block:: c
 
 	struct auxiliary_device {
@@ -99,15 +87,68 @@ auxiliary_device_uninit().
 		u32 id;
 	};
 
-If two auxiliary_devices both with a match_name "mod.foo" are registered onto
-the bus, they must have unique id values (e.g. "x" and "y") so that the
-registered devices names are "mod.foo.x" and "mod.foo.y".  If match_name + id
-are not unique, then the device_add fails and generates an error message.
+Registering an auxiliary_device is a three-step process.
+
+First, a 'struct auxiliary_device' needs to be defined or allocated for each
+sub-device desired.  The name, id, dev.release, and dev.parent fields of this
+structure must be filled in as follows.
+
+The 'name' field is to be given a name that is recognized by the auxiliary
+driver.  If two auxiliary_devices with the same match_name, eg
+"mod.MY_DEVICE_NAME", are registered onto the bus, they must have unique id
+values (e.g. "x" and "y") so that the registered devices names are "mod.foo.x"
+and "mod.foo.y".  If match_name + id are not unique, then the device_add fails
+and generates an error message.
 
 The auxiliary_device.dev.type.release or auxiliary_device.dev.release must be
-populated with a non-NULL pointer to successfully register the auxiliary_device.
+populated with a non-NULL pointer to successfully register the
+auxiliary_device.  This release call is where resources associated with the
+auxiliary device must be free'ed.  Because once the device is placed on the bus
+the parent driver can not tell what other code may have a reference to this
+data.
+
+The auxiliary_device.dev.parent should be set.  Typically to the registering
+drivers device.
+
+Second, call auxiliary_device_init(), which checks several aspects of the
+auxiliary_device struct and performs a device_initialize().  After this step
+completes, any error state must have a call to auxiliary_device_uninit() in its
+resolution path.
+
+The third and final step in registering an auxiliary_device is to perform a
+call to auxiliary_device_add(), which sets the name of the device and adds the
+device to the bus.
+
+.. code-block:: c
+
+	struct auxiliary_device *my_aux_dev = my_aux_dev_alloc(xxx);
+
+        /* Step 1: */
+	my_aux_dev->name = MY_DEVICE_NAME;
+	my_aux_dev->id = my_unique_id_alloc(xxx);
+	my_aux_dev->dev.release = my_aux_dev_release;
+	my_aux_dev->dev.parent = my_dev;
+
+        /* Step 2: */
+        if (auxiliary_device_init(my_aux_dev))
+                goto fail;
+
+        /* Step 3: */
+        if (auxiliary_device_add(my_aux_dev)) {
+                auxiliary_device_uninit(my_aux_dev);
+                goto fail;
+        }
+
+Unregistering an auxiliary_device is a two-step process to mirror the register
+process.  First call auxiliary_device_delete(), then call
+auxiliary_device_uninit().
+
+
+.. code-block:: c
+
+        auxiliary_device_delete(my_dev->my_aux_dev);
+        auxiliary_device_uninit(my_dev->my_aux_dev);
 
-The auxiliary_device.dev.parent must also be populated.
 
 Auxiliary Device Memory Model and Lifespan
 ------------------------------------------
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 9230c9472bb0..70a8dbcd31b7 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -117,7 +117,7 @@ static struct bus_type auxiliary_bus_type = {
  * auxiliary_device_init - check auxiliary_device and initialize
  * @auxdev: auxiliary device struct
  *
- * This is the first step in the two-step process to register an
+ * This is the second step in the three-step process to register an
  * auxiliary_device.
  *
  * When this function returns an error code, then the device_initialize will
@@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
  *
- * This is the second step in the two-step process to register an
+ * This is the third step in the three-step process to register an
  * auxiliary_device.
  *
  * This function must be called after a successful call to
-- 
2.31.1

