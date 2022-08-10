Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589358E6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiHJGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHJGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:00:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B93FE9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:00:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4450c963so118781907b3.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=yrSVoQ6qAYfctoHLwpmXbxKbM2DM2+R0yDzKfNT+j3U=;
        b=izJdAflNpJVWEHox4ERNJay3x/S/To+x9+9KV2R1NX8mVvLkWbAu6pJiC9H/0M2NLn
         ocfw4JmzrHQavKYT18YDK+gRqRMLcmdMUlfVbEdUf1j5kocdA8ySJfeFlofn11B2cfFz
         L++awHGTPcRZ7ppPUyPRLd9hJzIs+EpLqWOSJazPVt5H2lMeAtFzeElMKf++YUZJHiLb
         isRQVJNIFzGeSCHAvXXWt4EwTkNgXEVtj5u56DjinNjAVlJDGrYeypA2UodBtn4uxhAR
         g5j/JPv9wvCk1M9zcUEHPTHcUKe5W/ChBf53weBSEyaV0ZknXYDa9svnM+XwA9IPjEhH
         CkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=yrSVoQ6qAYfctoHLwpmXbxKbM2DM2+R0yDzKfNT+j3U=;
        b=HeZk4emfl4ahYhElJ6iVenfmybJdTZwe86I9lkpUqg204pLtr2b0fOwmQFw5idIyyR
         y7nXCkle+aw5Bl9o5gobmtZ5DmYjDNSgFpD7EiKGKT9cVcuEqRXSCSNxaHiNXrVIFLeL
         omXBgmEF6aqkZFVJ206kWXqyOIaj5iioRhxojOBrxxxV+U0yWAdVcfikBw2eAqNf79D4
         pg8GnQkMb3iQTufEPe0VjZH71MUox2d55XKp+Y4gnqP5ENK1WWJeT1OscnE1O6SuIBw1
         6tkjyYR1EvCDh70Q/rIB7gc5KrRBGmKWUvQ8Fup/plmgN++KVPA3DYHbQD5o5D4iSbA0
         28uA==
X-Gm-Message-State: ACgBeo0LLq8s6SE5FwGBghiYF/gSNeswqxfbb5JRXmu7StRgbIY2eDXf
        bq0KrkPHn6tC5Nymoh3yCbxxjUxULXkWKow=
X-Google-Smtp-Source: AA6agR6oBnWJI1pwT9B0nAdocGFOqlZelz8ZvTX+uF4itGLdhkdgHLvMyL5bD42EBVo8bfxVt++iHuhLW/lxloY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a25:8101:0:b0:676:c7fd:2143 with SMTP id
 o1-20020a258101000000b00676c7fd2143mr22340191ybk.364.1660111250277; Tue, 09
 Aug 2022 23:00:50 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:30 -0700
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
Message-Id: <20220810060040.321697-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 1/9] driver core: fw_devlink: Don't purge child fwnode's
 consumer links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device X is bound successfully to a driver, if it has a child
firmware node Y that doesn't have a struct device created by then, we
delete fwnode links where the child firmware node Y is the supplier. We
did this to avoid blocking the consumers of the child firmware node Y
from deferring probe indefinitely.

While that a step in the right direction, it's better to make the
consumers of the child firmware node Y to be consumers of the device X
because device X is probably implementing whatever functionality is
represented by child firmware node Y. By doing this, we capture the
device dependencies more accurately and ensure better
probe/suspend/resume ordering.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 91 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 17 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cca0f40..6f575c2a24ad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -53,11 +53,12 @@ static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
+static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
 
 /**
- * fwnode_link_add - Create a link between two fwnode_handles.
+ * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
  * @sup: Supplier end of the link.
  *
@@ -73,22 +74,18 @@ static bool fw_devlink_best_effort;
  * Attempts to create duplicate links between the same pair of fwnode handles
  * are ignored and there is no reference counting.
  */
-int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+static int __fwnode_link_add(struct fwnode_handle *con,
+			     struct fwnode_handle *sup)
 {
 	struct fwnode_link *link;
-	int ret = 0;
-
-	mutex_lock(&fwnode_link_lock);
 
 	list_for_each_entry(link, &sup->consumers, s_hook)
 		if (link->consumer == con)
-			goto out;
+			return 0;
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
-	if (!link) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!link)
+		return -ENOMEM;
 
 	link->supplier = sup;
 	INIT_LIST_HEAD(&link->s_hook);
@@ -99,9 +96,17 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 	list_add(&link->c_hook, &con->suppliers);
 	pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
 		 con, sup);
-out:
-	mutex_unlock(&fwnode_link_lock);
 
+	return 0;
+}
+
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+{
+	int ret = 0;
+
+	mutex_lock(&fwnode_link_lock);
+	ret = __fwnode_link_add(con, sup);
+	mutex_unlock(&fwnode_link_lock);
 	return ret;
 }
 
@@ -180,6 +185,51 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
 
+/**
+ * __fwnode_links_move_consumers - Move consumer from @from to @to fwnode_handle
+ * @from: move consumers away from this fwnode
+ * @to: move consumers to this fwnode
+ *
+ * Move all consumer links from @from fwnode to @to fwnode.
+ */
+static void __fwnode_links_move_consumers(struct fwnode_handle *from,
+					  struct fwnode_handle *to)
+{
+	struct fwnode_link *link, *tmp;
+
+	list_for_each_entry_safe(link, tmp, &from->consumers, s_hook) {
+		__fwnode_link_add(link->consumer, to);
+		__fwnode_link_del(link);
+	}
+}
+
+/**
+ * __fw_devlink_pickup_dangling_consumers - Pick up dangling consumers
+ * @fwnode: fwnode from which to pick up dangling consumers
+ * @new_sup: fwnode of new supplier
+ *
+ * If the @fwnode has a corresponding struct device and the device supports
+ * probing (that is, added to a bus), then we want to let fw_devlink create
+ * MANAGED device links to this device, so leave @fwnode and its descendant's
+ * fwnode links alone.
+ *
+ * Otherwise, move its consumers to the new supplier @new_sup.
+ */
+static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
+						   struct fwnode_handle *new_sup)
+{
+	struct fwnode_handle *child;
+
+	if (fwnode->dev && fwnode->dev->bus)
+		return;
+
+	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	__fwnode_links_move_consumers(fwnode, new_sup);
+
+	fwnode_for_each_available_child_node(fwnode, child)
+		__fw_devlink_pickup_dangling_consumers(child, new_sup);
+}
+
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
@@ -1266,16 +1316,23 @@ void device_links_driver_bound(struct device *dev)
 	 * them. So, fw_devlink no longer needs to create device links to any
 	 * of the device's suppliers.
 	 *
-	 * Also, if a child firmware node of this bound device is not added as
-	 * a device by now, assume it is never going to be added and make sure
-	 * other devices don't defer probe indefinitely by waiting for such a
-	 * child device.
+	 * Also, if a child firmware node of this bound device is not added as a
+	 * device by now, assume it is never going to be added. Make this bound
+	 * device the fallback supplier to the dangling consumers of the child
+	 * firmware node because this bound device is probably implementing the
+	 * child firmware node functionality and we don't want the dangling
+	 * consumers to defer probe indefinitely waiting for a device for the
+	 * child firmware node.
 	 */
 	if (dev->fwnode && dev->fwnode->dev == dev) {
 		struct fwnode_handle *child;
 		fwnode_links_purge_suppliers(dev->fwnode);
+		mutex_lock(&fwnode_link_lock);
 		fwnode_for_each_available_child_node(dev->fwnode, child)
-			fw_devlink_purge_absent_suppliers(child);
+			__fw_devlink_pickup_dangling_consumers(child,
+							       dev->fwnode);
+		__fw_devlink_link_to_consumers(dev);
+		mutex_unlock(&fwnode_link_lock);
 	}
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
-- 
2.37.1.559.g78731f0fdb-goog

