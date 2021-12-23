Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5187E47E062
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347273AbhLWIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:24:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:35809 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347187AbhLWIY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640247868; x=1671783868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r91At3LZD4Dka+efIxucm5+GDhsdmP3uafoJ8RM7pDw=;
  b=mFPbj99m6hDFdblry92xhJVS94IjywzvH53bpEvFnuslMgKKK0rkTdAs
   ATIXwk+67mXVMKR3TcH4q9X7q5J9S6xFjVFhCFnDS09Y7uFpu1SaMXW5P
   f8ToPuZo5Z7ePqfDzuVvhEI0hfgsRFbycOFIDa4foI49AqyYy2qdOy/CM
   Xq0Q2tYFrUvJ2QaWTGkTViE4lBX7QOSN8nRgpjU20xBARanpDkswz241t
   ixhPlOEwQ5bkrYmduvj/U1Vhrcdz+mM5u9BLptmj0JFQe6DW3YkpYFeey
   FFDthgir4QYqAJYr2jrs5gG82KtPNT06m5lIS2OH/dQoNbVg0/Zk+976i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240735641"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="240735641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="664517221"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 00:24:23 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] usb: Remove usb_for_each_port()
Date:   Thu, 23 Dec 2021 11:24:32 +0300
Message-Id: <20211223082432.45653-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
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

