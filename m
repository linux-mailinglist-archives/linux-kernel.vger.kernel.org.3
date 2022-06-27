Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FE55CC72
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiF0SmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiF0SmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:42:23 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2ACB25;
        Mon, 27 Jun 2022 11:42:21 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 442d2d835d0f9fdd; Mon, 27 Jun 2022 20:42:20 +0200
Received: from kreacher.localnet (unknown [213.134.161.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9098466C986;
        Mon, 27 Jun 2022 20:42:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] PK: runtime: Redefine pm_runtime_release_supplier()
Date:   Mon, 27 Jun 2022 20:42:18 +0200
Message-ID: <2653259.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.240
X-CLIENT-HOSTNAME: 213.134.161.240
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudeiuddrvdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedurddvgedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of passing an extra bool argument to pm_runtime_release_supplier(),
make its callers take care of triggering a runtime-suspend of the
supplier device as needed.

No expected functional impact.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |    3 ++-
 drivers/base/power/runtime.c |   20 +++++++++-----------
 include/linux/pm_runtime.h   |    5 ++---
 3 files changed, 13 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -308,13 +308,10 @@ static int rpm_get_suppliers(struct devi
 /**
  * pm_runtime_release_supplier - Drop references to device link's supplier.
  * @link: Target device link.
- * @check_idle: Whether or not to check if the supplier device is idle.
  *
- * Drop all runtime PM references associated with @link to its supplier device
- * and if @check_idle is set, check if that device is idle (and so it can be
- * suspended).
+ * Drop all runtime PM references associated with @link to its supplier device.
  */
-void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
+void pm_runtime_release_supplier(struct device_link *link)
 {
 	struct device *supplier = link->supplier;
 
@@ -327,9 +324,6 @@ void pm_runtime_release_supplier(struct
 	while (refcount_dec_not_one(&link->rpm_active) &&
 	       atomic_read(&supplier->power.usage_count) > 0)
 		pm_runtime_put_noidle(supplier);
-
-	if (check_idle)
-		pm_request_idle(supplier);
 }
 
 static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
@@ -337,8 +331,11 @@ static void __rpm_put_suppliers(struct d
 	struct device_link *link;
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
-		pm_runtime_release_supplier(link, try_to_suspend);
+				device_links_read_lock_held()) {
+		pm_runtime_release_supplier(link);
+		if (try_to_suspend)
+			pm_request_idle(link->supplier);
+	}
 }
 
 static void rpm_put_suppliers(struct device *dev)
@@ -1838,7 +1835,8 @@ void pm_runtime_drop_link(struct device_
 		return;
 
 	pm_runtime_drop_link_count(link->consumer);
-	pm_runtime_release_supplier(link, true);
+	pm_runtime_release_supplier(link);
+	pm_request_idle(link->supplier);
 }
 
 static bool pm_runtime_need_not_resume(struct device *dev)
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -88,7 +88,7 @@ extern void pm_runtime_get_suppliers(str
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
-extern void pm_runtime_release_supplier(struct device_link *link, bool check_idle);
+extern void pm_runtime_release_supplier(struct device_link *link);
 
 extern int devm_pm_runtime_enable(struct device *dev);
 
@@ -314,8 +314,7 @@ static inline void pm_runtime_get_suppli
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
 static inline void pm_runtime_drop_link(struct device_link *link) {}
-static inline void pm_runtime_release_supplier(struct device_link *link,
-					       bool check_idle) {}
+static inline void pm_runtime_release_supplier(struct device_link *link) {}
 
 #endif /* !CONFIG_PM */
 
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -486,7 +486,8 @@ static void device_link_release_fn(struc
 	/* Ensure that all references to the link object have been dropped. */
 	device_link_synchronize_removal();
 
-	pm_runtime_release_supplier(link, true);
+	pm_runtime_release_supplier(link);
+	pm_request_idle(link->supplier);
 
 	put_device(link->consumer);
 	put_device(link->supplier);



