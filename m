Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA258F05A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiHJQYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiHJQX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:23:59 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE8792E7;
        Wed, 10 Aug 2022 09:23:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 2d7ae212334240e6; Wed, 10 Aug 2022 18:23:55 +0200
Received: from kreacher.localnet (unknown [213.134.187.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BD40B66CF1C;
        Wed, 10 Aug 2022 18:23:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 4/5] ACPI: scan: Eliminate __acpi_device_add()
Date:   Wed, 10 Aug 2022 18:17:23 +0200
Message-ID: <13078324.uLZWGnKmhe@kreacher>
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

Instead of having acpi_device_add() defined as a wrapper around
__acpi_device_add(), export acpi_tie_acpi_dev() so it can be called
directly by acpi_add_power_resource(), fold acpi_device_add() into the
latter and rename __acpi_device_add() to acpi_device_add().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/power.c    |    6 +++++-
 drivers/acpi/scan.c     |   17 +++--------------
 3 files changed, 9 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -104,6 +104,7 @@ struct acpi_device_bus_id {
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 			     int type, void (*release)(struct device *));
+int acpi_tie_acpi_dev(struct acpi_device *adev);
 int acpi_device_add(struct acpi_device *device);
 int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -643,7 +643,7 @@ static int acpi_device_set_name(struct a
 	return 0;
 }
 
-static int acpi_tie_acpi_dev(struct acpi_device *adev)
+int acpi_tie_acpi_dev(struct acpi_device *adev)
 {
 	acpi_handle handle = adev->handle;
 	acpi_status status;
@@ -673,7 +673,7 @@ static void acpi_store_pld_crc(struct ac
 	ACPI_FREE(pld);
 }
 
-static int __acpi_device_add(struct acpi_device *device)
+int acpi_device_add(struct acpi_device *device)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
 	int result;
@@ -755,17 +755,6 @@ err_unlock:
 	return result;
 }
 
-int acpi_device_add(struct acpi_device *adev)
-{
-	int ret;
-
-	ret = acpi_tie_acpi_dev(adev);
-	if (ret)
-		return ret;
-
-	return __acpi_device_add(adev);
-}
-
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
@@ -1866,7 +1855,7 @@ static int acpi_add_single_object(struct
 		mutex_unlock(&acpi_dep_list_lock);
 
 	if (!result)
-		result = __acpi_device_add(device);
+		result = acpi_device_add(device);
 
 	if (result) {
 		acpi_device_release(&device->dev);
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -952,6 +952,7 @@ struct acpi_device *acpi_add_power_resou
 	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;
+	device->flags.match_driver = true;
 
 	/* Evaluate the object to get the system level and resource order. */
 	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
@@ -968,7 +969,10 @@ struct acpi_device *acpi_add_power_resou
 
 	pr_info("%s [%s]\n", acpi_device_name(device), acpi_device_bid(device));
 
-	device->flags.match_driver = true;
+	result = acpi_tie_acpi_dev(device);
+	if (result)
+		goto err;
+
 	result = acpi_device_add(device);
 	if (result)
 		goto err;



