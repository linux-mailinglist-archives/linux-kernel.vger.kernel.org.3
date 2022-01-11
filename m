Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92548B2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbiAKRGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:06:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55126 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244358AbiAKRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:06:40 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 8f130c71a8b5247a; Tue, 11 Jan 2022 18:06:38 +0100
Received: from kreacher.localnet (unknown [213.134.181.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 226FD66B10C;
        Tue, 11 Jan 2022 18:06:38 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 2/3] ACPI: scan: Simplify initialization of power and sleep buttons
Date:   Tue, 11 Jan 2022 17:52:00 +0100
Message-ID: <4683167.GXAFRqVoOG@kreacher>
In-Reply-To: <11903300.O9o76ZdvQC@kreacher>
References: <11903300.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.61
X-CLIENT-HOSTNAME: 213.134.181.61
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddriedunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddriedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
 pdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It should be perfectly fine to use ACPI if the "fixed" power or sleep
buttons cannot be initialized.  Moreover, running acpi_bus_scan()
successfully on ACPI_ROOT_OBJECT generally causes many devices to
be enumerated and probed, possibly including the entire PCI bus, so
unregistering acpi_root if the registration of the "fixed" buttons
fails is rather unhelpful.

For this reason, do not fail acpi_scan_init() when
acpi_bus_scan_fixed() fails and turn the latter into a void function.

While at it, drop the outdated and misleading comment from
acpi_bus_scan_fixed().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   58 ++++++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2457,42 +2457,33 @@ int acpi_bus_register_early_device(int t
 }
 EXPORT_SYMBOL_GPL(acpi_bus_register_early_device);
 
-static int acpi_bus_scan_fixed(void)
+static void acpi_bus_scan_fixed(void)
 {
-	int result = 0;
-
-	/*
-	 * Enumerate all fixed-feature devices.
-	 */
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
-		struct acpi_device *device = NULL;
+		struct acpi_device *adev = NULL;
 
-		result = acpi_add_single_object(&device, NULL,
-						ACPI_BUS_TYPE_POWER_BUTTON, false);
-		if (result)
-			return result;
-
-		device->flags.match_driver = true;
-		result = device_attach(&device->dev);
-		if (result < 0)
-			return result;
-
-		device_init_wakeup(&device->dev, true);
+		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_POWER_BUTTON,
+				       false);
+		if (adev) {
+			adev->flags.match_driver = true;
+			if (device_attach(&adev->dev) >= 0)
+				device_init_wakeup(&adev->dev, true);
+			else
+				dev_dbg(&adev->dev, "No driver\n");
+		}
 	}
 
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON)) {
-		struct acpi_device *device = NULL;
+		struct acpi_device *adev = NULL;
 
-		result = acpi_add_single_object(&device, NULL,
-						ACPI_BUS_TYPE_SLEEP_BUTTON, false);
-		if (result)
-			return result;
-
-		device->flags.match_driver = true;
-		result = device_attach(&device->dev);
+		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_SLEEP_BUTTON,
+				       false);
+		if (adev) {
+			adev->flags.match_driver = true;
+			if (device_attach(&adev->dev) < 0)
+				dev_dbg(&adev->dev, "No driver\n");
+		}
 	}
-
-	return result < 0 ? result : 0;
 }
 
 static void __init acpi_get_spcr_uart_addr(void)
@@ -2572,15 +2563,8 @@ void __init acpi_scan_init(void)
 		goto out;
 
 	/* Fixed feature devices do not exist on HW-reduced platform */
-	if (!acpi_gbl_reduced_hardware) {
-		if (acpi_bus_scan_fixed()) {
-			acpi_detach_data(acpi_root->handle,
-					 acpi_scan_drop_device);
-			acpi_device_del(acpi_root);
-			acpi_bus_put_acpi_device(acpi_root);
-			goto out;
-		}
-	}
+	if (!acpi_gbl_reduced_hardware)
+		acpi_bus_scan_fixed();
 
 	acpi_turn_off_unused_power_resources();
 



