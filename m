Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A147055A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhLJQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:13:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43522 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbhLJQNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:13:51 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 67377897416ad859; Fri, 10 Dec 2021 17:10:15 +0100
Received: from kreacher.localnet (unknown [213.134.162.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 78DEB66AD3B;
        Fri, 10 Dec 2021 17:10:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PM: runtime: Add safety net to supplier device release
Date:   Fri, 10 Dec 2021 17:10:13 +0100
Message-ID: <11889065.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.58
X-CLIENT-HOSTNAME: 213.134.162.58
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrkedvgdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrdduiedvrdehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedvrdehkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurght
 ihhonhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because refcount_dec_not_one() returns true if the target refcount
becomes saturated, it is generally unsafe to use its return value as
a loop termination condition, but that is what happens when a device
link's supplier device is released during runtime PM suspend
operations and on device link removal.

To address this, introduce pm_runtime_release_supplier() to be used
in the above cases which will check the supplier device's runtime
PM usage counter in addition to the refcount_dec_not_one() return
value, so the loop can be terminated in case the rpm_active refcount
value becomes invalid, and update the code in question to use it as
appropriate.

This change is not expected to have any visible functional impact.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |    3 +--
 drivers/base/power/runtime.c |   41 ++++++++++++++++++++++++++++++-----------
 include/linux/pm_runtime.h   |    3 +++
 3 files changed, 34 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -305,19 +305,40 @@ static int rpm_get_suppliers(struct devi
 	return 0;
 }
 
+/**
+ * pm_runtime_release_supplier - Drop references to device link's supplier.
+ * @link: Target device link.
+ * @check_idle: Whether or not to check if the supplier device is idle.
+ *
+ * Drop all runtime PM references associated with @link to its supplier device
+ * and if @check_idle is set, check if that device is idle (and so it can be
+ * suspended).
+ */
+void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
+{
+	struct device *supplier = link->supplier;
+
+	/*
+	 * The additional power.usage_count check is a safety net in case
+	 * the rpm_active refcount becomes saturated, in which case
+	 * refcount_dec_not_one() would return true forever, but it is not
+	 * strictly necessary.
+	 */
+	while (refcount_dec_not_one(&link->rpm_active) &&
+	       atomic_read(&supplier->power.usage_count) > 0)
+		pm_runtime_put_noidle(supplier);
+
+	if (check_idle)
+		pm_request_idle(supplier);
+}
+
 static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 {
 	struct device_link *link;
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held()) {
-
-		while (refcount_dec_not_one(&link->rpm_active))
-			pm_runtime_put_noidle(link->supplier);
-
-		if (try_to_suspend)
-			pm_request_idle(link->supplier);
-	}
+				device_links_read_lock_held())
+		pm_runtime_release_supplier(link, try_to_suspend);
 }
 
 static void rpm_put_suppliers(struct device *dev)
@@ -1777,9 +1798,7 @@ void pm_runtime_drop_link(struct device_
 		return;
 
 	pm_runtime_drop_link_count(link->consumer);
-
-	while (refcount_dec_not_one(&link->rpm_active))
-		pm_runtime_put(link->supplier);
+	pm_runtime_release_supplier(link, true);
 }
 
 static bool pm_runtime_need_not_resume(struct device *dev)
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -58,6 +58,7 @@ extern void pm_runtime_get_suppliers(str
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
+extern void pm_runtime_release_supplier(struct device_link *link, bool check_idle);
 
 extern int devm_pm_runtime_enable(struct device *dev);
 
@@ -283,6 +284,8 @@ static inline void pm_runtime_get_suppli
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
 static inline void pm_runtime_drop_link(struct device_link *link) {}
+static inline void pm_runtime_release_supplier(struct device_link *link,
+					       bool check_idle) {}
 
 #endif /* !CONFIG_PM */
 
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -485,8 +485,7 @@ static void device_link_release_fn(struc
 	/* Ensure that all references to the link object have been dropped. */
 	device_link_synchronize_removal();
 
-	while (refcount_dec_not_one(&link->rpm_active))
-		pm_runtime_put(link->supplier);
+	pm_runtime_release_supplier(link, true);
 
 	put_device(link->consumer);
 	put_device(link->supplier);



