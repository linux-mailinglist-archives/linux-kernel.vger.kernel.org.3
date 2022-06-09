Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDB544ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbiFIOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbiFIOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:21:06 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A112D517B;
        Thu,  9 Jun 2022 07:21:03 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id afc6eb5538d362a9; Thu, 9 Jun 2022 16:21:01 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0ADA866C7D8;
        Thu,  9 Jun 2022 16:21:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 01/16] ACPI: glue: Use acpi_dev_for_each_child()
Date:   Thu, 09 Jun 2022 15:47:54 +0200
Message-ID: <13056549.uLZWGnKmhe@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
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

Instead of walking the list of children of an ACPI device directly,
use acpi_dev_for_each_child() to carry out an action for all of
the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |  103 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 40 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -105,51 +105,74 @@ static int find_child_checks(struct acpi
 	return FIND_CHILD_MAX_SCORE;
 }
 
+struct find_child_walk_data {
+	struct acpi_device *adev;
+	u64 address;
+	int score;
+	bool check_children;
+};
+
+static int check_one_child(struct acpi_device *adev, void *data)
+{
+	struct find_child_walk_data *wd = data;
+	int score;
+
+	if (!adev->pnp.type.bus_address || acpi_device_adr(adev) != wd->address)
+		return 0;
+
+	if (!wd->adev) {
+		/* This is the first matching object.  Save it and continue. */
+		wd->adev = adev;
+		return 0;
+	}
+
+	/*
+	 * There is more than one matching device object with the same _ADR
+	 * value.  That really is unexpected, so we are kind of beyond the scope
+	 * of the spec here.  We have to choose which one to return, though.
+	 *
+	 * First, get the score for the previously found object and terminate
+	 * the walk if it is maximum.
+	*/
+	if (!wd->score) {
+		score = find_child_checks(wd->adev, wd->check_children);
+		if (score == FIND_CHILD_MAX_SCORE)
+			return 1;
+
+		wd->score = score;
+	}
+	/*
+	 * Second, if the object that has just been found has a better score,
+	 * replace the previously found one with it and terminate the walk if
+	 * the new score is maximum.
+	 */
+	score = find_child_checks(adev, wd->check_children);
+	if (score > wd->score) {
+		wd->adev = adev;
+		if (score == FIND_CHILD_MAX_SCORE)
+			return 1;
+
+		wd->score = score;
+	}
+
+	/* Continue, because there may be better matches. */
+	return 0;
+}
+
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children)
 {
-	struct acpi_device *adev, *ret = NULL;
-	int ret_score = 0;
+	struct find_child_walk_data wd = {
+		.address = address,
+		.check_children = check_children,
+		.adev = NULL,
+		.score = 0,
+	};
 
-	if (!parent)
-		return NULL;
+	if (parent)
+		acpi_dev_for_each_child(parent, check_one_child, &wd);
 
-	list_for_each_entry(adev, &parent->children, node) {
-		acpi_bus_address addr = acpi_device_adr(adev);
-		int score;
-
-		if (!adev->pnp.type.bus_address || addr != address)
-			continue;
-
-		if (!ret) {
-			/* This is the first matching object.  Save it. */
-			ret = adev;
-			continue;
-		}
-		/*
-		 * There is more than one matching device object with the same
-		 * _ADR value.  That really is unexpected, so we are kind of
-		 * beyond the scope of the spec here.  We have to choose which
-		 * one to return, though.
-		 *
-		 * First, check if the previously found object is good enough
-		 * and return it if so.  Second, do the same for the object that
-		 * we've just found.
-		 */
-		if (!ret_score) {
-			ret_score = find_child_checks(ret, check_children);
-			if (ret_score == FIND_CHILD_MAX_SCORE)
-				return ret;
-		}
-		score = find_child_checks(adev, check_children);
-		if (score == FIND_CHILD_MAX_SCORE) {
-			return adev;
-		} else if (score > ret_score) {
-			ret = adev;
-			ret_score = score;
-		}
-	}
-	return ret;
+	return wd.adev;
 }
 EXPORT_SYMBOL_GPL(acpi_find_child_device);
 



