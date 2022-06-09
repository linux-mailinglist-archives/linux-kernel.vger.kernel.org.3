Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10417544EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiFIOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiFIOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:20:35 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C8626A096;
        Thu,  9 Jun 2022 07:20:32 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id be4704fa09209c3c; Thu, 9 Jun 2022 16:20:30 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A406866C7D7;
        Thu,  9 Jun 2022 16:20:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH v1 15/16] ACPI / MMC: PM: Unify fixing up device power
Date:   Thu, 09 Jun 2022 16:18:40 +0200
Message-ID: <2159220.NgBsaNRSFp@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
 ihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce acpi_device_fix_up_power_extended() for fixing up power of
a device having an ACPI companion in a manner that takes the device's
children into account and make the MMC code use it in two places
instead of walking the list of the device ACPI companion's children
directly.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c          |   22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci-acpi.c     |    7 ++-----
 drivers/mmc/host/sdhci-pci-core.c |   11 +++--------
 include/acpi/acpi_bus.h           |    1 +
 4 files changed, 28 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/mmc/host/sdhci-acpi.c
===================================================================
--- linux-pm.orig/drivers/mmc/host/sdhci-acpi.c
+++ linux-pm/drivers/mmc/host/sdhci-acpi.c
@@ -775,8 +775,8 @@ static int sdhci_acpi_probe(struct platf
 {
 	struct device *dev = &pdev->dev;
 	const struct sdhci_acpi_slot *slot;
-	struct acpi_device *device, *child;
 	const struct dmi_system_id *id;
+	struct acpi_device *device;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
@@ -796,10 +796,7 @@ static int sdhci_acpi_probe(struct platf
 	slot = sdhci_acpi_get_slot(device);
 
 	/* Power on the SDHCI controller and its children */
-	acpi_device_fix_up_power(device);
-	list_for_each_entry(child, &device->children, node)
-		if (child->status.present && child->status.enabled)
-			acpi_device_fix_up_power(child);
+	acpi_device_fix_up_power_extended(device);
 
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -369,6 +369,28 @@ int acpi_device_fix_up_power(struct acpi
 }
 EXPORT_SYMBOL_GPL(acpi_device_fix_up_power);
 
+static int fix_up_power_if_applicable(struct acpi_device *adev, void *not_used)
+{
+	if (adev->status.present && adev->status.enabled)
+		acpi_device_fix_up_power(adev);
+
+	return 0;
+}
+
+/**
+ * acpi_device_fix_up_power_extended - Force device and its children into D0.
+ * @adev: Parent device object whose power state is to be fixed up.
+ *
+ * Call acpi_device_fix_up_power() for @adev and its children so long as they
+ * are reported as present and enabled.
+ */
+void acpi_device_fix_up_power_extended(struct acpi_device *adev)
+{
+	acpi_device_fix_up_power(adev);
+	acpi_dev_for_each_child(adev, fix_up_power_if_applicable, NULL);
+}
+EXPORT_SYMBOL_GPL(acpi_device_fix_up_power_extended);
+
 int acpi_device_update_power(struct acpi_device *device, int *state_p)
 {
 	int state;
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -524,6 +524,7 @@ const char *acpi_power_state_string(int
 int acpi_device_set_power(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
+void acpi_device_fix_up_power_extended(struct acpi_device *adev);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
Index: linux-pm/drivers/mmc/host/sdhci-pci-core.c
===================================================================
--- linux-pm.orig/drivers/mmc/host/sdhci-pci-core.c
+++ linux-pm/drivers/mmc/host/sdhci-pci-core.c
@@ -1240,16 +1240,11 @@ static const struct sdhci_pci_fixes sdhc
 #ifdef CONFIG_ACPI
 static void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot)
 {
-	struct acpi_device *device, *child;
+	struct acpi_device *device;
 
 	device = ACPI_COMPANION(&slot->chip->pdev->dev);
-	if (!device)
-		return;
-
-	acpi_device_fix_up_power(device);
-	list_for_each_entry(child, &device->children, node)
-		if (child->status.present && child->status.enabled)
-			acpi_device_fix_up_power(child);
+	if (device)
+		acpi_device_fix_up_power_extended(device);
 }
 #else
 static inline void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot) {}



