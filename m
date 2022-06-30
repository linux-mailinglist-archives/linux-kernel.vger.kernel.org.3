Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A65622ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiF3TQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiF3TQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:16:46 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78942A16;
        Thu, 30 Jun 2022 12:16:45 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 0ab7fcce5568376d; Thu, 30 Jun 2022 21:16:43 +0200
Received: from kreacher.localnet (unknown [213.134.175.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 23E2766CA52;
        Thu, 30 Jun 2022 21:16:42 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Wang <peter.wang@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] PM: runtime: Fix supplier device management during consumer probe
Date:   Thu, 30 Jun 2022 21:16:41 +0200
Message-ID: <4748074.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.198
X-CLIENT-HOSTNAME: 213.134.175.198
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudejhedrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduleekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghp
 thhtohepphgvthgvrhdrfigrnhhgsehmvgguihgrthgvkhdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because pm_runtime_get_suppliers() bumps up the rpm_active counter
of each device link to a supplier of the given device in addition
to bumping up the supplier's PM-runtime usage counter, a runtime
suspend of the consumer device may case the latter to go down to 0
when pm_runtime_put_suppliers() is running on a remote CPU.  If that
happens after pm_runtime_put_suppliers() has released power.lock for
the consumer device, and a runtime resume of that device takes place
immediately after it, before pm_runtime_put() is called for the
supplier, that pm_runtime_put() call may cause the supplier to be
suspended even though the consumer is active.

To prevent that from happening, modify pm_runtime_get_suppliers() to
call pm_runtime_get_sync() for the given device's suppliers without
touching the rpm_active counters of the involved device links
Accordingly, modify pm_runtime_put_suppliers() to call pm_runtime_put()
for the given device's suppliers without looking at the rpm_active
counters of the device links at hand.  [This is analogous to what
happened before commit 4c06c4e6cf63 ("driver core: Fix possible
supplier PM-usage counter imbalance").]

Since pm_runtime_get_suppliers() sets supplier_preactivated for each
device link where the supplier's PM-runtime usage counter has been
incremented and pm_runtime_put_suppliers() calls pm_runtime_put() for
the suppliers whose device links have supplier_preactivated set, the
PM-runtime usage counter is balanced for each supplier and this is
independent of the runtime suspend and resume of the consumer device.

However, in case a device link with DL_FLAG_PM_RUNTIME set is dropped
during the consumer device probe, so pm_runtime_get_suppliers() bumps
up the supplier's PM-runtime usage counter, but it cannot be dropped by
pm_runtime_put_suppliers(), make device_link_release_fn() take care of
that.

Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
Reported-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |   10 ++++++++++
 drivers/base/power/runtime.c |   14 +-------------
 2 files changed, 11 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1768,7 +1768,6 @@ void pm_runtime_get_suppliers(struct dev
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
 			link->supplier_preactivated = true;
 			pm_runtime_get_sync(link->supplier);
-			refcount_inc(&link->rpm_active);
 		}
 
 	device_links_read_unlock(idx);
@@ -1788,19 +1787,8 @@ void pm_runtime_put_suppliers(struct dev
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
-			bool put;
-
 			link->supplier_preactivated = false;
-
-			spin_lock_irq(&dev->power.lock);
-
-			put = pm_runtime_status_suspended(dev) &&
-			      refcount_dec_not_one(&link->rpm_active);
-
-			spin_unlock_irq(&dev->power.lock);
-
-			if (put)
-				pm_runtime_put(link->supplier);
+			pm_runtime_put(link->supplier);
 		}
 
 	device_links_read_unlock(idx);
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -487,6 +487,16 @@ static void device_link_release_fn(struc
 	device_link_synchronize_removal();
 
 	pm_runtime_release_supplier(link);
+	/*
+	 * If supplier_preactivated is set, the link has been dropped between
+	 * the pm_runtime_get_suppliers() and pm_runtime_put_suppliers() calls
+	 * in __driver_probe_device().  In that case, drop the supplier's
+	 * PM-runtime usage counter to remove the reference taken by
+	 * pm_runtime_get_suppliers().
+	 */
+	if (link->supplier_preactivated)
+		pm_runtime_put_noidle(link->supplier);
+
 	pm_request_idle(link->supplier);
 
 	put_device(link->consumer);



