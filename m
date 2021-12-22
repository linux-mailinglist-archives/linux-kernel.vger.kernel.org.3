Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D798E47D3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbhLVOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:33:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:11411 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245734AbhLVOdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640183586; x=1671719586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r91At3LZD4Dka+efIxucm5+GDhsdmP3uafoJ8RM7pDw=;
  b=m+3TQ32MGsq+LhqloxWyk/BXHAmwLZG1+RaDrmWTvMZnpw1QNP/elUbF
   CWPO0kx6qeW0i6TjaXmShTgc3JnBMbQaYYVDXdQCBdi+IX+tUKIw0HwTA
   poCHoqIP1OT6sE1ymBZ4WnSTs4XbF/4/6oqiwdoXJE7svmxAPOUtoOnRW
   2YdQPhK6gDViULB25VWIEBvJHiPFrtz9N7vu483wtSOF8HVSeLz635j/H
   2sQnEa86OMVP6HhLZFx4s4UdG47iQQMcCq3TpFRWDPkOIX4P/QDfbwUoy
   iDyUaL4ngxKFqQE6WfJKJxuARbKZTq3Vd2EX8IhRAW5Q07bUCrHE0mwrc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240580589"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240580589"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 06:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664285228"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 06:33:03 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] usb: Remove usb_for_each_port()
Date:   Wed, 22 Dec 2021 17:32:58 +0300
Message-Id: <20211222143258.82305-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users for the function.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb.c | 46 ------------------------------------------
 include/linux/usb.h    |  9 ---------
 2 files changed, 55 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 62368c4ed37af..2ce3667ec6fae 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -398,52 +398,6 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
 }
 EXPORT_SYMBOL_GPL(usb_for_each_dev);
 
-struct each_hub_arg {
-	void *data;
-	int (*fn)(struct device *, void *);
-};
-
-static int __each_hub(struct usb_device *hdev, void *data)
-{
-	struct each_hub_arg *arg = (struct each_hub_arg *)data;
-	struct usb_hub *hub;
-	int ret = 0;
-	int i;
-
-	hub = usb_hub_to_struct_hub(hdev);
-	if (!hub)
-		return 0;
-
-	mutex_lock(&usb_port_peer_mutex);
-
-	for (i = 0; i < hdev->maxchild; i++) {
-		ret = arg->fn(&hub->ports[i]->dev, arg->data);
-		if (ret)
-			break;
-	}
-
-	mutex_unlock(&usb_port_peer_mutex);
-
-	return ret;
-}
-
-/**
- * usb_for_each_port - interate over all USB ports in the system
- * @data: data pointer that will be handed to the callback function
- * @fn: callback function to be called for each USB port
- *
- * Iterate over all USB ports and call @fn for each, passing it @data. If it
- * returns anything other than 0, we break the iteration prematurely and return
- * that value.
- */
-int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
-{
-	struct each_hub_arg arg = {data, fn};
-
-	return usb_for_each_dev(&arg, __each_hub);
-}
-EXPORT_SYMBOL_GPL(usb_for_each_port);
-
 /**
  * usb_release_dev - free a usb device structure when all users of it are finished.
  * @dev: device that's been disconnected
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7ccaa76a9a968..200b7b79acb56 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -875,15 +875,6 @@ extern struct usb_host_interface *usb_find_alt_setting(
 		unsigned int iface_num,
 		unsigned int alt_num);
 
-#if IS_REACHABLE(CONFIG_USB)
-int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
-#else
-static inline int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
-{
-	return 0;
-}
-#endif
-
 /* port claiming functions */
 int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
 		struct usb_dev_state *owner);
-- 
2.34.1

