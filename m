Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7898858E710
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiHJGBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiHJGBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:01:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F171EAE7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:01:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r4-20020a259a44000000b006775138624fso11424161ybo.23
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=zsc6LReCkj1qjWFHoe9RU5QlsrwqzoWhqcv1gy5ixZY=;
        b=qAChj47DwLOrFVomS2lGpLSpKGvd1Ma7wbTL3BaBnyvNDdaT6wQcELiK3Z2S6rKmW6
         4RCg3rt6j2rD/dXyIpiJAt0rXCb4GtTf9uNP6hZi708k7YPc7ZxFVW1djWMkZKngZUyC
         9ZOMJL5O3k7bMThCT+oPldcDnUF4i0ommrfHppvhsYUq/eEQsh/fyoQBlUi7r5vctc/F
         9u/dHFrzIRRFZvBW99iEWRVEUfrxv+VRxXw6eyDf8bHeE9dwuyd1QG8zMM9IyxoXCqpp
         yxsC7TNyQiZWMwjfcKw173fewjgqVWZOvnFwQB5H8vymYFjevDNXEPOljd/VGIQLMaOQ
         7eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=zsc6LReCkj1qjWFHoe9RU5QlsrwqzoWhqcv1gy5ixZY=;
        b=JVbyc1g3oXTqFIH5OMwGSmMNQ56LhuGGlydab1Pv+b6dzA5wgHZGQDglixSWHfwOo3
         bV/mEuSv8hsPJ31VfiUsA7TwyTsNhUNWs/3nYjANTppn3WW+xR6HEYjiL3Jmss3jL1mw
         VeRIMN9USzX+LJFeIrreXrqF5Q0w7/gJmrqhM9lRzFRGtpxldsMhgSTiJH9BkPKElKvX
         4SmePXnV6ozA6B5eBhbC8w83bWdzyGegli1UJVEUmkyY9KKB+Tbgnta/VmK8We8JiFa6
         /W+/gSs3ZPjI/PpgzXbUOqr2JMu6AZLvNq5j+7vsTXVTNrGMXRAOZqc8x/mwSJpHvD4M
         opsA==
X-Gm-Message-State: ACgBeo0AI3UeBu6xP/yHohvSmdYc89HNBCgmDymDUYnzlK52gR7sghfA
        2P8rFfGBrw9jUODtQhaCQw8aEQwuYHXMHKQ=
X-Google-Smtp-Source: AA6agR7UHIfPmQyEJpTq1ANtIM/YpnjUfuF4LCqgIoVdmjpw9+J9eqTmKa2fu2A5mGFX/RbYZr7v9jvnFZ4Lhg0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a05:6902:100d:b0:67a:7141:a2bf with SMTP
 id w13-20020a056902100d00b0067a7141a2bfmr23586344ybt.54.1660111261905; Tue,
 09 Aug 2022 23:01:01 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:34 -0700
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
Message-Id: <20220810060040.321697-6-saravanak@google.com>
Mime-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 5/9] driver core: fw_devlink: Add DL_FLAG_CYCLE support to
 device links
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

fw_devlink uses DL_FLAG_SYNC_STATE_ONLY device link flag for two
purposes:

1. To allow a parent device to proxy its child device's dependency on a
   supplier so that the supplier doesn't get its sync_state() callback
   before the child device/consumer can be added and probed. In this
   usage scenario, we need to ignore cycles for ensure correctness of
   sync_state() callbacks.

2. When there are dependency cycles in firmware, we don't know which of
   those dependencies are valid. So, we have to ignore them all wrt
   probe ordering while still making sure the sync_state() callbacks
   come correctly.

However, when detecting dependency cycles, there can be multiple
dependency cycles between two devices that we need to detect. For
example:

A -> B -> A and A -> C -> B -> A.

To detect multiple cycles correct, we need to be able to differentiate
DL_FLAG_SYNC_STATE_ONLY device links used for (1) vs (2) above.

To allow this differentiation, add a DL_FLAG_CYCLE that can be use to
mark use case (2). We can then use the DL_FLAG_CYCLE to decide which
DL_FLAG_SYNC_STATE_ONLY device links to follow when looking for
dependency cycles.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 28 ++++++++++++++++++----------
 include/linux/device.h |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8ec2236b1f9c..afa660d14172 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -321,6 +321,12 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 	return false;
 }
 
+static inline bool device_link_flag_is_sync_state_only(u32 flags)
+{
+	return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE))
+		== (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);
+}
+
 /**
  * device_is_dependent - Check if one device depends on another one
  * @dev: Device to check dependencies for.
@@ -347,8 +353,7 @@ int device_is_dependent(struct device *dev, void *target)
 		return ret;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if ((link->flags & ~DL_FLAG_INFERRED) ==
-		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if (device_link_flag_is_sync_state_only(link->flags))
 			continue;
 
 		if (link->consumer == target)
@@ -421,8 +426,7 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 
 	device_for_each_child(dev, NULL, device_reorder_to_tail);
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if ((link->flags & ~DL_FLAG_INFERRED) ==
-		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if (device_link_flag_is_sync_state_only(link->flags))
 			continue;
 		device_reorder_to_tail(link->consumer, NULL);
 	}
@@ -683,7 +687,8 @@ postcore_initcall(devlink_class_init);
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER  | \
 			       DL_FLAG_SYNC_STATE_ONLY | \
-			       DL_FLAG_INFERRED)
+			       DL_FLAG_INFERRED | \
+			       DL_FLAG_CYCLE)
 
 #define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
 			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
@@ -752,8 +757,6 @@ struct device_link *device_link_add(struct device *consumer,
 	if (!consumer || !supplier || consumer == supplier ||
 	    flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
-	    (flags & DL_FLAG_SYNC_STATE_ONLY &&
-	     (flags & ~DL_FLAG_INFERRED) != DL_FLAG_SYNC_STATE_ONLY) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
 		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
@@ -769,6 +772,10 @@ struct device_link *device_link_add(struct device *consumer,
 	if (!(flags & DL_FLAG_STATELESS))
 		flags |= DL_FLAG_MANAGED;
 
+	if (flags & DL_FLAG_SYNC_STATE_ONLY &&
+	    !device_link_flag_is_sync_state_only(flags))
+		return NULL;
+
 	device_links_write_lock();
 	device_pm_lock();
 
@@ -1728,7 +1735,7 @@ static void fw_devlink_relax_link(struct device_link *link)
 	if (!(link->flags & DL_FLAG_INFERRED))
 		return;
 
-	if (link->flags == (DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE))
+	if (device_link_flag_is_sync_state_only(link->flags))
 		return;
 
 	pm_runtime_drop_link(link);
@@ -1852,8 +1859,8 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 		return ret;
 
 	list_for_each_entry(link, &con->links.consumers, s_node) {
-		if ((link->flags & ~DL_FLAG_INFERRED) ==
-		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+		if (!(link->flags & DL_FLAG_CYCLE) &&
+		    device_link_flag_is_sync_state_only(link->flags))
 			continue;
 
 		if (!fw_devlink_relax_cycle(link->consumer, sup))
@@ -1862,6 +1869,7 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 		ret = 1;
 
 		fw_devlink_relax_link(link);
+		link->flags |= DL_FLAG_CYCLE;
 	}
 	return ret;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..7cf24330d681 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -327,6 +327,7 @@ enum device_link_state {
 #define DL_FLAG_MANAGED			BIT(6)
 #define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
 #define DL_FLAG_INFERRED		BIT(8)
+#define DL_FLAG_CYCLE			BIT(9)
 
 /**
  * enum dl_dev_state - Device driver presence tracking information.
-- 
2.37.1.559.g78731f0fdb-goog

