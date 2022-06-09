Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CCD544EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbiFIOVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiFIOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:20:35 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B1274B60;
        Thu,  9 Jun 2022 07:20:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 7992ebb7b3e162f8; Thu, 9 Jun 2022 16:20:32 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 64B7B66C7CA;
        Thu,  9 Jun 2022 16:20:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v1 14/16] soundwire: Use acpi_dev_for_each_child()
Date:   Thu, 09 Jun 2022 16:16:03 +0200
Message-ID: <5296779.Sb9uPGUboI@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
 ihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihuhhnghdqtghhuhgrnhdrlhhirghosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhivghrrhgvqdhlohhuihhsrdgsohhsshgrrhhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshgrnhihohhgrdhrrdhkrghlvgesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of walking the list of children of an ACPI device directly,
use acpi_dev_for_each_child() to carry out an action for all of
the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/soundwire/slave.c |  115 ++++++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 48 deletions(-)

Index: linux-pm/drivers/soundwire/slave.c
===================================================================
--- linux-pm.orig/drivers/soundwire/slave.c
+++ linux-pm/drivers/soundwire/slave.c
@@ -127,6 +127,71 @@ static bool find_slave(struct sdw_bus *b
 	return true;
 }
 
+struct sdw_acpi_child_walk_data {
+	struct sdw_bus *bus;
+	struct acpi_device *adev;
+	struct sdw_slave_id id;
+	bool ignore_unique_id;
+};
+
+static int sdw_acpi_check_duplicate(struct acpi_device *adev, void *data)
+{
+	struct sdw_acpi_child_walk_data *cwd = data;
+	struct sdw_bus *bus = cwd->bus;
+	struct sdw_slave_id id;
+
+	if (adev == cwd->adev)
+		return 0;
+
+	if (!find_slave(bus, adev, &id))
+		return 0;
+
+	if (cwd->id.sdw_version != id.sdw_version || cwd->id.mfg_id != id.mfg_id ||
+	    cwd->id.part_id != id.part_id || cwd->id.class_id != id.class_id)
+		return 0;
+
+	if (cwd->id.unique_id != id.unique_id) {
+		dev_dbg(bus->dev,
+			"Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
+			cwd->id.unique_id, id.unique_id, cwd->id.mfg_id,
+			cwd->id.part_id);
+		cwd->ignore_unique_id = false;
+		return 0;
+	}
+
+	dev_err(bus->dev,
+		"Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
+		cwd->id.unique_id, id.unique_id, cwd->id.mfg_id, cwd->id.part_id);
+	return -ENODEV;
+}
+
+static int sdw_acpi_find_one(struct acpi_device *adev, void *data)
+{
+	struct sdw_bus *bus = data;
+	struct sdw_acpi_child_walk_data cwd = {
+		.bus = bus,
+		.adev = adev,
+		.ignore_unique_id = true,
+	};
+	int ret;
+
+	if (!find_slave(bus, adev, &cwd.id))
+		return 0;
+
+	/* Brute-force O(N^2) search for duplicates. */
+	ret = acpi_dev_for_each_child(ACPI_COMPANION(bus->dev),
+				      sdw_acpi_check_duplicate, &cwd);
+	if (ret)
+		return ret;
+
+	if (cwd.ignore_unique_id)
+		cwd.id.unique_id = SDW_IGNORED_UNIQUE_ID;
+
+	/* Ignore errors and continue. */
+	sdw_slave_add(bus, &cwd.id, acpi_fwnode_handle(adev));
+	return 0;
+}
+
 /*
  * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
  * @bus: SDW bus instance
@@ -135,8 +200,7 @@ static bool find_slave(struct sdw_bus *b
  */
 int sdw_acpi_find_slaves(struct sdw_bus *bus)
 {
-	struct acpi_device *adev, *parent;
-	struct acpi_device *adev2, *parent2;
+	struct acpi_device *parent;
 
 	parent = ACPI_COMPANION(bus->dev);
 	if (!parent) {
@@ -144,52 +208,7 @@ int sdw_acpi_find_slaves(struct sdw_bus
 		return -ENODEV;
 	}
 
-	list_for_each_entry(adev, &parent->children, node) {
-		struct sdw_slave_id id;
-		struct sdw_slave_id id2;
-		bool ignore_unique_id = true;
-
-		if (!find_slave(bus, adev, &id))
-			continue;
-
-		/* brute-force O(N^2) search for duplicates */
-		parent2 = parent;
-		list_for_each_entry(adev2, &parent2->children, node) {
-
-			if (adev == adev2)
-				continue;
-
-			if (!find_slave(bus, adev2, &id2))
-				continue;
-
-			if (id.sdw_version != id2.sdw_version ||
-			    id.mfg_id != id2.mfg_id ||
-			    id.part_id != id2.part_id ||
-			    id.class_id != id2.class_id)
-				continue;
-
-			if (id.unique_id != id2.unique_id) {
-				dev_dbg(bus->dev,
-					"Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
-					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
-				ignore_unique_id = false;
-			} else {
-				dev_err(bus->dev,
-					"Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
-					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
-				return -ENODEV;
-			}
-		}
-
-		if (ignore_unique_id)
-			id.unique_id = SDW_IGNORED_UNIQUE_ID;
-
-		/*
-		 * don't error check for sdw_slave_add as we want to continue
-		 * adding Slaves
-		 */
-		sdw_slave_add(bus, &id, acpi_fwnode_handle(adev));
-	}
+	acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);
 
 	return 0;
 }



