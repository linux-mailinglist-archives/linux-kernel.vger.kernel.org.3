Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6413648B2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbiAKRGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:06:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49352 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbiAKRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:06:42 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 05f254b4bae9469d; Tue, 11 Jan 2022 18:06:40 +0100
Received: from kreacher.localnet (unknown [213.134.181.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CBB1C66B10C;
        Tue, 11 Jan 2022 18:06:39 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1 1/3] ACPI: scan: Change acpi_scan_init() return value type to void
Date:   Tue, 11 Jan 2022 17:50:22 +0100
Message-ID: <4372141.LvFx2qVVIh@kreacher>
In-Reply-To: <11903300.O9o76ZdvQC@kreacher>
References: <11903300.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.61
X-CLIENT-HOSTNAME: 213.134.181.61
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukedurdeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdeiuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgs
 vghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrhesohhrrggtlhgvrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only caller of acpi_scan_init(), acpi_init(), doesn't check its
return value, so turn it into a void function.

This avoids complaints from the Smatch static checker that the
function should return a negative error code when it fails, which
is not really a problem in this particular case.

No intentional functional impact.

Link: https://lore.kernel.org/linux-acpi/20220106082317.GA9123@kili/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/scan.c     |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2513,9 +2513,8 @@ static void __init acpi_get_spcr_uart_ad
 
 static bool acpi_scan_initialized;
 
-int __init acpi_scan_init(void)
+void __init acpi_scan_init(void)
 {
-	int result;
 	acpi_status status;
 	struct acpi_table_stao *stao_ptr;
 
@@ -2565,8 +2564,7 @@ int __init acpi_scan_init(void)
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-	result = acpi_bus_scan(ACPI_ROOT_OBJECT);
-	if (result)
+	if (acpi_bus_scan(ACPI_ROOT_OBJECT))
 		goto out;
 
 	acpi_root = acpi_fetch_acpi_dev(ACPI_ROOT_OBJECT);
@@ -2575,8 +2573,7 @@ int __init acpi_scan_init(void)
 
 	/* Fixed feature devices do not exist on HW-reduced platform */
 	if (!acpi_gbl_reduced_hardware) {
-		result = acpi_bus_scan_fixed();
-		if (result) {
+		if (acpi_bus_scan_fixed()) {
 			acpi_detach_data(acpi_root->handle,
 					 acpi_scan_drop_device);
 			acpi_device_del(acpi_root);
@@ -2591,7 +2588,6 @@ int __init acpi_scan_init(void)
 
  out:
 	mutex_unlock(&acpi_scan_lock);
-	return result;
 }
 
 static struct acpi_probe_entry *ape;
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -14,7 +14,7 @@
 int early_acpi_osi_init(void);
 int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
-int acpi_scan_init(void);
+void acpi_scan_init(void);
 #ifdef CONFIG_PCI
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);



