Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE9467B55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352996AbhLCQ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:28:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50918 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352974AbhLCQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:28:12 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 4b5d8ee7dd91bafc; Fri, 3 Dec 2021 17:24:47 +0100
Received: from kreacher.localnet (unknown [213.134.175.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D570966AD69;
        Fri,  3 Dec 2021 17:24:46 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: runtime: Capture device status before disabling runtime PM
Date:   Fri, 03 Dec 2021 17:24:45 +0100
Message-ID: <4723000.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.202
X-CLIENT-HOSTNAME: 213.134.175.202
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdevgfetueetheekudeuvdduteelvefftdfftdejjeeukeffteeikefgiefghedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudejhedrvddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvtddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhhihhlmhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhkshhhrghhsegtohguvggruhhrohhrrgdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdr
 hhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases (for example, during system-wide suspend and resume of
devices) it is useful to know whether or not runtime PM has ever been
enabled for a given device and, if so, what the runtime PM status of
it had been right before runtime PM was disabled for it last time.

For this reason, introduce a new struct dev_pm_info field called
last_status that will be used for capturing the runtime PM status of
the device when its power.disable_depth counter changes from 0 to 1.

The new field will be set to RPM_INVALID to start with and whenever
power.disable_depth changes from 1 to 0, so it will be valid only
when runtime PM of the device is currently disabled, but it has been
enabled at least once.

Immediately use power.last_status in rpm_resume() to make it handle
the case when PM runtime is disabled for the device, but its runtime
PM status is RPM_ACTIVE more consistently.  Namely, make it return 1
if power.last_status is also equal to RPM_ACTIVE in that case (the
idea being that if the status was RPM_ACTIVE last time when
power.disable_depth was changing from 0 to 1 and it is still
RPM_ACTIVE, it can be assumed to reflect what happened to the device
last time when it was using runtime PM) and -EACCES otherwise.

Update the documentation to provide a description of last_status and
change the description of pm_runtime_resume() in it to reflect the
new behavior of rpm_active().

While at it, rearrange the code in pm_runtime_enable() to be more
straightforward and replace the WARN() macro in it with a pr_warn()
invocation which is less disruptive.

Link: https://lore.kernel.org/linux-pm/20211026222626.39222-1-ulf.hansson@linaro.org/t/#u
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/runtime_pm.rst |   14 +++++++++----
 drivers/base/power/runtime.c       |   38 +++++++++++++++++++------------------
 include/linux/pm.h                 |    2 +
 3 files changed, 32 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -744,11 +744,10 @@ static int rpm_resume(struct device *dev
  repeat:
 	if (dev->power.runtime_error)
 		retval = -EINVAL;
-	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
-	    && dev->power.runtime_status == RPM_ACTIVE)
-		retval = 1;
 	else if (dev->power.disable_depth > 0)
-		retval = -EACCES;
+		retval = dev->power.runtime_status == RPM_ACTIVE &&
+			 dev->power.last_status == RPM_ACTIVE ? 1 : -EACCES;
+
 	if (retval)
 		goto out;
 
@@ -1410,8 +1409,10 @@ void __pm_runtime_disable(struct device
 	/* Update time accounting before disabling PM-runtime. */
 	update_pm_runtime_accounting(dev);
 
-	if (!dev->power.disable_depth++)
+	if (!dev->power.disable_depth++) {
 		__pm_runtime_barrier(dev);
+		dev->power.last_status = dev->power.runtime_status;
+	}
 
  out:
 	spin_unlock_irq(&dev->power.lock);
@@ -1428,23 +1429,23 @@ void pm_runtime_enable(struct device *de
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (dev->power.disable_depth > 0) {
-		dev->power.disable_depth--;
-
-		/* About to enable runtime pm, set accounting_timestamp to now */
-		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
-	} else {
+	if (!dev->power.disable_depth) {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
+		goto out;
 	}
 
-	WARN(!dev->power.disable_depth &&
-	     dev->power.runtime_status == RPM_SUSPENDED &&
-	     !dev->power.ignore_children &&
-	     atomic_read(&dev->power.child_count) > 0,
-	     "Enabling runtime PM for inactive device (%s) with active children\n",
-	     dev_name(dev));
+	if (--dev->power.disable_depth > 0)
+		goto out;
+
+	dev->power.last_status = RPM_INVALID;
+	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
+
+	if (dev->power.runtime_status == RPM_SUSPENDED &&
+	    !dev->power.ignore_children &&
+	    atomic_read(&dev->power.child_count) > 0)
+		dev_warn(dev, "Enabling runtime PM for inactive device with active children\n");
 
+out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
@@ -1640,6 +1641,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_use_autos
 void pm_runtime_init(struct device *dev)
 {
 	dev->power.runtime_status = RPM_SUSPENDED;
+	dev->power.last_status = RPM_INVALID;
 	dev->power.idle_notification = false;
 
 	dev->power.disable_depth = 1;
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -499,6 +499,7 @@ const struct dev_pm_ops __maybe_unused n
  */
 
 enum rpm_status {
+	RPM_INVALID = -1,
 	RPM_ACTIVE = 0,
 	RPM_RESUMING,
 	RPM_SUSPENDED,
@@ -612,6 +613,7 @@ struct dev_pm_info {
 	unsigned int		links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
+	enum rpm_status		last_status;
 	int			runtime_error;
 	int			autosuspend_delay;
 	u64			last_busy;
Index: linux-pm/Documentation/power/runtime_pm.rst
===================================================================
--- linux-pm.orig/Documentation/power/runtime_pm.rst
+++ linux-pm/Documentation/power/runtime_pm.rst
@@ -265,6 +265,10 @@ defined in include/linux/pm.h:
       RPM_SUSPENDED, which means that each device is initially regarded by the
       PM core as 'suspended', regardless of its real hardware status
 
+  `enum rpm_status last_status;`
+    - the last runtime PM status of the device captured before disabling runtime
+      PM for it (invalid initially and when disable_depth is 0)
+
   `unsigned int runtime_auto;`
     - if set, indicates that the user space has allowed the device driver to
       power manage the device at run time via the /sys/devices/.../power/control
@@ -333,10 +337,12 @@ drivers/base/power/runtime.c and include
 
   `int pm_runtime_resume(struct device *dev);`
     - execute the subsystem-level resume callback for the device; returns 0 on
-      success, 1 if the device's runtime PM status was already 'active' or
-      error code on failure, where -EAGAIN means it may be safe to attempt to
-      resume the device again in future, but 'power.runtime_error' should be
-      checked additionally, and -EACCES means that 'power.disable_depth' is
+      success, 1 if the device's runtime PM status is already 'active' (also if
+      'power.disable_depth' is nonzero, but the status was 'active' when it was
+      changing from 0 to 1) or error code on failure, where -EAGAIN means it may
+      be safe to attempt to resume the device again in future, but
+      'power.runtime_error' should be checked additionally, and -EACCES means
+      that the callback could not be run, because 'power.disable_depth' was
       different from 0
 
   `int pm_runtime_resume_and_get(struct device *dev);`



