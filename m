Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE237465D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355605AbhLBErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:24208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355575AbhLBEq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:46:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216640182"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="216640182"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477788576"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:16 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/7] Documentation/auxiliary_bus: Update Auxiliary device lifespan
Date:   Wed,  1 Dec 2021 20:43:01 -0800
Message-Id: <20211202044305.4006853-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

It was unclear when the auxiliary device objects were to be free'ed by
the parent (registering) driver.

Also there are some patterns like using devm_add_action_or_reset() which
are helpful to mention to those using the interface to ensure they don't
double free or miss freeing the auxiliary devices.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/driver-api/auxiliary_bus.rst | 32 ++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
index b041a72dc322..3786e4664a1e 100644
--- a/Documentation/driver-api/auxiliary_bus.rst
+++ b/Documentation/driver-api/auxiliary_bus.rst
@@ -164,9 +164,15 @@ Auxiliary Device Memory Model and Lifespan
 ------------------------------------------
 
 The registering driver is the entity that allocates memory for the
-auxiliary_device and register it on the auxiliary bus.  It is important to note
+auxiliary_device and registers it on the auxiliary bus.  It is important to note
 that, as opposed to the platform bus, the registering driver is wholly
-responsible for the management for the memory used for the driver object.
+responsible for the management of the memory used for the device object.
+
+To be clear the memory for the auxiliary_device is freed in the release()
+callback defined by the registering driver.  The registering driver should only
+call auxiliary_device_delete() and then auxiliary_device_uninit() when it is
+done with the device.  The release() function is then automatically called if
+and when other code releases their reference to the devices.
 
 A parent object, defined in the shared header file, contains the
 auxiliary_device.  It also contains a pointer to the shared object(s), which
@@ -177,18 +183,22 @@ from the pointer to the auxiliary_device, that is passed during the call to the
 auxiliary_driver's probe function, up to the parent object, and then have
 access to the shared object(s).
 
-The memory for the auxiliary_device is freed only in its release() callback
-flow as defined by its registering driver.
-
 The memory for the shared object(s) must have a lifespan equal to, or greater
-than, the lifespan of the memory for the auxiliary_device.  The auxiliary_driver
-should only consider that this shared object is valid as long as the
-auxiliary_device is still registered on the auxiliary bus.  It is up to the
-registering driver to manage (e.g. free or keep available) the memory for the
-shared object beyond the life of the auxiliary_device.
+than, the lifespan of the memory for the auxiliary_device.  The
+auxiliary_driver should only consider that the shared object is valid as long
+as the auxiliary_device is still registered on the auxiliary bus.  It is up to
+the registering driver to manage (e.g. free or keep available) the memory for
+the shared object beyond the life of the auxiliary_device.
 
 The registering driver must unregister all auxiliary devices before its own
-driver.remove() is completed.
+driver.remove() is completed.  An easy way to ensure this is to use the
+devm_add_action_or_reset() call to register a function against the parent device
+which unregisters the auxiliary device object(s).
+
+Finally, any operations which operate on the auxiliary devices must continue to
+function (if only to return an error) after the registering driver unregisters
+the auxiliary device.
+
 
 Auxiliary Drivers
 =================
-- 
2.31.1

