Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E159C4F6B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiDFUrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiDFUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:46:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B31B2555;
        Wed,  6 Apr 2022 12:03:17 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id ca9b22a3a51ca1e6; Wed, 6 Apr 2022 21:03:16 +0200
Received: from kreacher.localnet (unknown [213.134.186.238])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8272066BD16;
        Wed,  6 Apr 2022 21:03:15 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v1] PM: runtime: Avoid device usage count underflows
Date:   Wed, 06 Apr 2022 21:03:14 +0200
Message-ID: <1836398.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.238
X-CLIENT-HOSTNAME: 213.134.186.238
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddukeeirddvfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughu
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A PM-runtime device usage count underflow is potentially critical,
because it may cause a device to be suspended when it is expected to
be operational.

For this reason, (1) make rpm_check_suspend_allowed() return an error
when the device usage count is negative to prevent devices from being
suspended in that case, (2) introduce rpm_drop_usage_count() that will
detect device usage count underflows, warn about them and fix them up,
and (3) use it to drop the usage count in a few places instead of
atomic_dec_and_test().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
 		retval = -EINVAL;
 	else if (dev->power.disable_depth > 0)
 		retval = -EACCES;
-	else if (atomic_read(&dev->power.usage_count) > 0)
+	else if (atomic_read(&dev->power.usage_count))
 		retval = -EAGAIN;
 	else if (!dev->power.ignore_children &&
 			atomic_read(&dev->power.child_count))
@@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
 }
 EXPORT_SYMBOL_GPL(pm_schedule_suspend);
 
+static int rpm_drop_usage_count(struct device *dev)
+{
+	int ret;
+
+	ret = atomic_sub_return(1, &dev->power.usage_count);
+	if (ret >= 0)
+		return ret;
+
+	/*
+	 * Because rpm_resume() does not check the usage counter, it will resume
+	 * the device even if the usage counter is 0 or negative, so it is
+	 * sufficient to increment the usage counter here to reverse the change
+	 * made above.
+	 */
+	atomic_inc(&dev->power.usage_count);
+	dev_warn(dev, "Runtime PM usage count underflow!\n");
+	return -EINVAL;
+}
+
 /**
  * __pm_runtime_idle - Entry point for runtime idle operations.
  * @dev: Device to send idle notification for.
  * @rpmflags: Flag bits.
  *
  * If the RPM_GET_PUT flag is set, decrement the device's usage count and
- * return immediately if it is larger than zero.  Then carry out an idle
+ * return immediately if it is larger than zero (if it becomes negative, log a
+ * warning, increment it, and return an error).  Then carry out an idle
  * notification, either synchronous or asynchronous.
  *
  * This routine may be called in atomic context if the RPM_ASYNC flag is set,
@@ -1057,9 +1077,12 @@ int __pm_runtime_idle(struct device *dev
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
-		if (!atomic_dec_and_test(&dev->power.usage_count)) {
+		retval = rpm_drop_usage_count(dev);
+		if (retval > 0) {
 			trace_rpm_usage_rcuidle(dev, rpmflags);
 			return 0;
+		} else if (retval < 0) {
+			return retval;
 		}
 	}
 
@@ -1079,7 +1102,8 @@ EXPORT_SYMBOL_GPL(__pm_runtime_idle);
  * @rpmflags: Flag bits.
  *
  * If the RPM_GET_PUT flag is set, decrement the device's usage count and
- * return immediately if it is larger than zero.  Then carry out a suspend,
+ * return immediately if it is larger than zero (if it becomes negative, log a
+ * warning, increment it, and return an error).  Then carry out a suspend,
  * either synchronous or asynchronous.
  *
  * This routine may be called in atomic context if the RPM_ASYNC flag is set,
@@ -1091,9 +1115,12 @@ int __pm_runtime_suspend(struct device *
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
-		if (!atomic_dec_and_test(&dev->power.usage_count)) {
+		retval = rpm_drop_usage_count(dev);
+		if (retval > 0) {
 			trace_rpm_usage_rcuidle(dev, rpmflags);
 			return 0;
+		} else if (retval < 0) {
+			return retval;
 		}
 	}
 
@@ -1527,14 +1554,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
  */
 void pm_runtime_allow(struct device *dev)
 {
+	int ret;
+
 	spin_lock_irq(&dev->power.lock);
 	if (dev->power.runtime_auto)
 		goto out;
 
 	dev->power.runtime_auto = true;
-	if (atomic_dec_and_test(&dev->power.usage_count))
+	ret = rpm_drop_usage_count(dev);
+	if (ret == 0)
 		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
-	else
+	else if (ret > 0)
 		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
 
  out:



