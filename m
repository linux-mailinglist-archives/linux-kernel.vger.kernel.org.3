Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABA465D86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355599AbhLBErF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:24211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355539AbhLBEqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:46:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216640180"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="216640180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477788573"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:16 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/7] Documentation/auxiliary_bus: Clarify match_name
Date:   Wed,  1 Dec 2021 20:43:00 -0800
Message-Id: <20211202044305.4006853-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Provide example code for how the match name is formed and where it is
supposed to be set.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/driver-api/auxiliary_bus.rst | 33 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
index 7dbb4f16462a..b041a72dc322 100644
--- a/Documentation/driver-api/auxiliary_bus.rst
+++ b/Documentation/driver-api/auxiliary_bus.rst
@@ -78,6 +78,9 @@ An auxiliary_device represents a part of its parent device's functionality. It
 is given a name that, combined with the registering drivers KBUILD_MODNAME,
 creates a match_name that is used for driver binding, and an id that combined
 with the match_name provide a unique name to register with the bus subsystem.
+For example, a driver registering an auxiliary device is named 'foo_mod.ko' and
+the subdevice is named 'foo_dev'.  The match name is therefore
+'foo_mod.foo_dev'.
 
 .. code-block:: c
 
@@ -95,9 +98,9 @@ structure must be filled in as follows.
 
 The 'name' field is to be given a name that is recognized by the auxiliary
 driver.  If two auxiliary_devices with the same match_name, eg
-"mod.MY_DEVICE_NAME", are registered onto the bus, they must have unique id
-values (e.g. "x" and "y") so that the registered devices names are "mod.foo.x"
-and "mod.foo.y".  If match_name + id are not unique, then the device_add fails
+"foo_mod.foo_dev", are registered onto the bus, they must have unique id
+values (e.g. "x" and "y") so that the registered devices names are "foo_mod.foo_dev.x"
+and "foo_mod.foo_dev.y".  If match_name + id are not unique, then the device_add fails
 and generates an error message.
 
 The auxiliary_device.dev.type.release or auxiliary_device.dev.release must be
@@ -121,6 +124,10 @@ device to the bus.
 
 .. code-block:: c
 
+        #define MY_DEVICE_NAME "foo_dev"
+
+        ...
+
 	struct auxiliary_device *my_aux_dev = my_aux_dev_alloc(xxx);
 
         /* Step 1: */
@@ -139,6 +146,9 @@ device to the bus.
                 goto fail;
         }
 
+        ...
+
+
 Unregistering an auxiliary_device is a two-step process to mirror the register
 process.  First call auxiliary_device_delete(), then call
 auxiliary_device_uninit().
@@ -205,6 +215,23 @@ Auxiliary drivers register themselves with the bus by calling
 auxiliary_driver_register(). The id_table contains the match_names of auxiliary
 devices that a driver can bind with.
 
+.. code-block:: c
+
+        static const struct auxiliary_device_id my_auxiliary_id_table[] = {
+		{ .name = "foo_mod.foo_dev" },
+                {},
+        };
+
+        MODULE_DEVICE_TABLE(auxiliary, my_auxiliary_id_table);
+
+        struct auxiliary_driver my_drv = {
+                .name = "myauxiliarydrv",
+                .id_table = my_auxiliary_id_table,
+                .probe = my_drv_probe,
+                .remove = my_drv_remove
+        };
+
+
 Example Usage
 =============
 
-- 
2.31.1

