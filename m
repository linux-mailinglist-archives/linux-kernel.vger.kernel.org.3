Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F358F060
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiHJQYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiHJQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:24:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94D81B1A;
        Wed, 10 Aug 2022 09:23:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 2ced05b3971ab5bb; Wed, 10 Aug 2022 18:23:58 +0200
Received: from kreacher.localnet (unknown [213.134.187.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7C19566CF1C;
        Wed, 10 Aug 2022 18:23:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 2/5] ACPI: scan: Rename acpi_bus_get_parent() and rearrange it
Date:   Wed, 10 Aug 2022 18:15:24 +0200
Message-ID: <2252770.ElGaqSPkdT@kreacher>
In-Reply-To: <12036348.O9o76ZdvQC@kreacher>
References: <12036348.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.55
X-CLIENT-HOSTNAME: 213.134.187.55
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeejrdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrdehhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhn
 vghlrdhorhhg
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

The acpi_bus_get_parent() name doesn't really reflect the
purpose of the function so change it to a more accurate
acpi_find_parent_acpi_dev().

While at it, rearrange the code inside that function the make it
easier to read.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -816,10 +816,9 @@ static const char * const acpi_honor_dep
 	NULL
 };
 
-static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
+static struct acpi_device *acpi_find_parent_acpi_dev(acpi_handle handle)
 {
-	struct acpi_device *device;
-	acpi_status status;
+	struct acpi_device *adev;
 
 	/*
 	 * Fixed hardware devices do not appear in the namespace and do not
@@ -830,13 +829,18 @@ static struct acpi_device *acpi_bus_get_
 		return acpi_root;
 
 	do {
-		status = acpi_get_parent(handle, &handle);
-		if (ACPI_FAILURE(status))
-			return status == AE_NULL_ENTRY ? NULL : acpi_root;
+		acpi_status status;
 
-		device = acpi_fetch_acpi_dev(handle);
-	} while (!device);
-	return device;
+		status = acpi_get_parent(handle, &handle);
+		if (ACPI_FAILURE(status)) {
+			if (status != AE_NULL_ENTRY)
+				return acpi_root;
+
+			return NULL;
+		}
+		adev = acpi_fetch_acpi_dev(handle);
+	} while (!adev);
+	return adev;
 }
 
 acpi_status
@@ -1777,7 +1781,7 @@ void acpi_init_device_object(struct acpi
 	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
 	device->handle = handle;
-	device->parent = acpi_bus_get_parent(handle);
+	device->parent = acpi_find_parent_acpi_dev(handle);
 	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
 	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);



