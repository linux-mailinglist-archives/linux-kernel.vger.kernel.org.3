Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5FF58E711
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiHJGBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiHJGBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:01:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E315FE8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:01:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f58599ad3so119784027b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=fFDScMpOoLwobJ0B+gx6h8x63gnncNppR9XtZLm6ulE=;
        b=oKH1GriWJVrABfs62WEip/+gg6Dy4kEs7RfdBPtZv1dDVp8IM8ot+pJYb0FYC/j+dW
         Jmct5LS3sgXZwdmnm2b/XxlhH1LoIyQ0qPOCXNhwwxH+wse2QMfHhqHGs/zhkg4RSn4D
         g1/uaVkRiojaOGGVwYog0xljtT9cpl4VQHiuhxaZrs5KGEF9koqVuHd1InJ75qg7O6Yo
         UzvrcZg7E0hHEIPRlyq+1T8XU9GcavBPIWNzQ8biwtu3oLc/cA4w7xVUya1qG9ZCvGlY
         c3HHAhKT9W4/Jp/npKG8Ei+2a9D86hwmHHvF5aX70NJY8d3uWZXJnFQQeGMksKOP8dTI
         m+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=fFDScMpOoLwobJ0B+gx6h8x63gnncNppR9XtZLm6ulE=;
        b=lsa84hdBDPQc6NCQ+NEOKNaPVHj1dzpcm185tRb2VXx3cOYmfuOEs5sgD1EcuZe4S6
         pA8OW+wHj/PorWF3T+vpCmagwRGiTPfUio4T+YOV5cQhyzr+ccu/baF9V/yqhltTV/OA
         VdjgT7/nb230lTxDL2FpEcjZ5a20WGfn/mLt8ye/HU9IstaM4U8mfw7nnwQaTLjhHfPk
         EM2Zqo1MEg4Acf2NqbtH8t5r9a9tfi+Y/L/1iU91FBSoV5DxM7EE2QZ/Gmm1frvMUU4Z
         KfKsbEJ6FfjuLAYy9Ve1vnB/FJr6cquFaW2yPvW+Uf6rqXBiZCEoEnyTkexn+XjO/i+z
         lOPA==
X-Gm-Message-State: ACgBeo2JGcBiIuJgoKPBVecftugUid+S08Wt+1GFjJyeKy5R4SMbfwxf
        3HBr3np2ZIUyCm1yAaSRp/n66+SkLUZg420=
X-Google-Smtp-Source: AA6agR7Ig43NfwU15CHf57OeGOFh7gsI84hi8fC26IKcScIBv/6FfxWUkEv3BAnHx8V4jzQ/X/BwXiqy9EgrIBc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a25:fc0f:0:b0:67b:b846:4db2 with SMTP id
 v15-20020a25fc0f000000b0067bb8464db2mr15311111ybd.566.1660111265238; Tue, 09
 Aug 2022 23:01:05 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:35 -0700
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
Message-Id: <20220810060040.321697-7-saravanak@google.com>
Mime-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 6/9] driver core: fw_devlink: Allow marking a fwnode link
 as being part of a cycle
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve detection and handling of dependency cycles, we need to be
able to mark fwnode links as being part of cycles. fwnode links marked
as being part of a cycle should not block their consumers from probing.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 41 +++++++++++++++++++++++++++++++++++------
 include/linux/fwnode.h | 11 ++++++++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index afa660d14172..0ec2c4d5ffaa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -125,6 +125,19 @@ static void __fwnode_link_del(struct fwnode_link *link)
 	kfree(link);
 }
 
+/**
+ * __fwnode_link_cycle - Mark a fwnode link as being part of a cycle.
+ * @link: the fwnode_link to be marked
+ *
+ * The fwnode_link_lock needs to be held when this function is called.
+ */
+static void __fwnode_link_cycle(struct fwnode_link *link)
+{
+	pr_debug("%pfwf: Relaxing link with %pfwf\n",
+		 link->consumer, link->supplier);
+	link->flags |= FWLINK_FLAG_CYCLE;
+}
+
 /**
  * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
  * @fwnode: fwnode whose supplier links need to be deleted
@@ -1040,6 +1053,23 @@ static bool dev_is_best_effort(struct device *dev)
 		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
 }
 
+static struct fwnode_handle *fwnode_links_check_suppliers(
+						struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link;
+
+	if (!fwnode || fw_devlink_is_permissive())
+		return NULL;
+
+	list_for_each_entry(link, &fwnode->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_CYCLE)
+			continue;
+		return link->supplier;
+	}
+
+	return NULL;
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -1067,11 +1097,8 @@ int device_links_check_suppliers(struct device *dev)
 	 * probe.
 	 */
 	mutex_lock(&fwnode_link_lock);
-	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
-	    !fw_devlink_is_permissive()) {
-		sup_fw = list_first_entry(&dev->fwnode->suppliers,
-					  struct fwnode_link,
-					  c_hook)->supplier;
+	sup_fw = fwnode_links_check_suppliers(dev->fwnode);
+	if (sup_fw) {
 		if (!dev_is_best_effort(dev)) {
 			fwnode_ret = -EPROBE_DEFER;
 			dev_err_probe(dev, -EPROBE_DEFER,
@@ -1260,7 +1287,9 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	bool val;
 
 	device_lock(dev);
-	val = !list_empty(&dev->fwnode->suppliers);
+	mutex_lock(&fwnode_link_lock);
+	val = !!fwnode_links_check_suppliers(dev->fwnode);
+	mutex_unlock(&fwnode_link_lock);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 89b9bdfca925..fdf2ee0285b7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -18,7 +18,7 @@ struct fwnode_operations;
 struct device;
 
 /*
- * fwnode link flags
+ * fwnode flags
  *
  * LINKS_ADDED:	The fwnode has already be parsed to add fwnode links.
  * NOT_DEVICE:	The fwnode will never be populated as a struct device.
@@ -36,6 +36,7 @@ struct device;
 #define FWNODE_FLAG_INITIALIZED			BIT(2)
 #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
 #define FWNODE_FLAG_BEST_EFFORT			BIT(4)
+#define FWNODE_FLAG_VISITED			BIT(5)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -46,11 +47,19 @@ struct fwnode_handle {
 	u8 flags;
 };
 
+/*
+ * fwnode link flags
+ *
+ * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ */
+#define FWLINK_FLAG_CYCLE			BIT(0)
+
 struct fwnode_link {
 	struct fwnode_handle *supplier;
 	struct list_head s_hook;
 	struct fwnode_handle *consumer;
 	struct list_head c_hook;
+	u8 flags;
 };
 
 /**
-- 
2.37.1.559.g78731f0fdb-goog

