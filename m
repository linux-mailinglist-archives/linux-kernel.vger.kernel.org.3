Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7450BB75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449313AbiDVPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448890AbiDVPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:16:46 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441785D674;
        Fri, 22 Apr 2022 08:13:51 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 036e7665410539f2; Fri, 22 Apr 2022 17:13:49 +0200
Received: from kreacher.localnet (unknown [213.134.161.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F381766BFEB;
        Fri, 22 Apr 2022 17:13:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: bus: Avoid non-ACPI device objects in walks over children
Date:   Fri, 22 Apr 2022 17:13:48 +0200
Message-ID: <11974495.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.204
X-CLIENT-HOSTNAME: 213.134.161.204
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeggdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduiedurddvtdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvddtgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgv
 lhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When walking the children of an ACPI device, take extra care to avoid
using to_acpi_device() on the ones that are not ACPI devices, because
that may lead to out-of-bounds access and memory corruption.

While at it, make the function passed to acpi_dev_for_each_child()
take a struct acpi_device pointer argument (instead of a struct device
one), so it is more straightforward to use.

Fixes: b7dd6298db81 ("ACPI: PM: Introduce acpi_dev_power_up_children_with_adr()")
Reported-by: kernel test robot <oliver.sang@intel.com>
BugLink: https://lore.kernel.org/lkml/20220420064725.GB16310@xsang-OptiPlex-9020/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The commit being fixed is present in linux-next.

---
 drivers/acpi/bus.c       |   24 ++++++++++++++++++++++--
 drivers/acpi/device_pm.c |    5 +----
 include/acpi/acpi_bus.h  |    2 +-
 3 files changed, 24 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -1070,10 +1070,30 @@ int acpi_bus_for_each_dev(int (*fn)(stru
 }
 EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
 
+struct acpi_dev_walk_context {
+	int (*fn)(struct acpi_device *, void *);
+	void *data;
+};
+
+static int acpi_dev_for_one_check(struct device *dev, void *context)
+{
+	struct acpi_dev_walk_context *adwc = context;
+
+	if (dev->bus != &acpi_bus_type)
+		return 0;
+
+	return adwc->fn(to_acpi_device(dev), adwc->data);
+}
+
 int acpi_dev_for_each_child(struct acpi_device *adev,
-			    int (*fn)(struct device *, void *), void *data)
+			    int (*fn)(struct acpi_device *, void *), void *data)
 {
-	return device_for_each_child(&adev->dev, data, fn);
+	struct acpi_dev_walk_context adwc = {
+		.fn = fn,
+		.data = data,
+	};
+
+	return device_for_each_child(&adev->dev, &adwc, acpi_dev_for_one_check);
 }
 
 /* --------------------------------------------------------------------------
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -482,7 +482,7 @@ extern struct bus_type acpi_bus_type;
 
 int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data);
 int acpi_dev_for_each_child(struct acpi_device *adev,
-			    int (*fn)(struct device *, void *), void *data);
+			    int (*fn)(struct acpi_device *, void *), void *data);
 
 /*
  * Events
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -429,11 +429,8 @@ bool acpi_bus_power_manageable(acpi_hand
 }
 EXPORT_SYMBOL(acpi_bus_power_manageable);
 
-static int acpi_power_up_if_adr_present(struct device *dev, void *not_used)
+static int acpi_power_up_if_adr_present(struct acpi_device *adev, void *not_used)
 {
-	struct acpi_device *adev;
-
-	adev = to_acpi_device(dev);
 	if (!(adev->flags.power_manageable && adev->pnp.type.bus_address))
 		return 0;
 



