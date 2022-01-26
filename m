Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE849D29B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbiAZTle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:41:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43464 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiAZTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:41:32 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 9b1ad74b14709705; Wed, 26 Jan 2022 20:41:30 +0100
Received: from kreacher.localnet (unknown [213.134.162.63])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DFC2F66B311;
        Wed, 26 Jan 2022 20:41:28 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform: surface: Replace acpi_bus_get_device()
Date:   Wed, 26 Jan 2022 20:41:27 +0100
Message-ID: <5805278.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.63
X-CLIENT-HOSTNAME: 213.134.162.63
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
 tghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrkhhgrhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhiimhgrgihimhhilhhirghnsehgmhgrihhlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surface3-wmi.c        |   12 ++++--------
 drivers/platform/surface/surface_acpi_notify.c |    3 ++-
 2 files changed, 6 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/platform/surface/surface3-wmi.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface3-wmi.c
+++ linux-pm/drivers/platform/surface/surface3-wmi.c
@@ -116,15 +116,11 @@ static acpi_status s3_wmi_attach_spi_dev
 					    void *data,
 					    void **return_value)
 {
-	struct acpi_device *adev, **ts_adev;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	struct acpi_device **ts_adev = data;
 
-	if (acpi_bus_get_device(handle, &adev))
-		return AE_OK;
-
-	ts_adev = data;
-
-	if (strncmp(acpi_device_bid(adev), SPI_TS_OBJ_NAME,
-	    strlen(SPI_TS_OBJ_NAME)))
+	if (!adev || strncmp(acpi_device_bid(adev), SPI_TS_OBJ_NAME,
+			     strlen(SPI_TS_OBJ_NAME)))
 		return AE_OK;
 
 	if (*ts_adev) {
Index: linux-pm/drivers/platform/surface/surface_acpi_notify.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface_acpi_notify.c
+++ linux-pm/drivers/platform/surface/surface_acpi_notify.c
@@ -770,7 +770,8 @@ static acpi_status san_consumer_setup(ac
 		return AE_OK;
 
 	/* Ignore ACPI devices that are not present. */
-	if (acpi_bus_get_device(handle, &adev) != 0)
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
 		return AE_OK;
 
 	san_consumer_dbg(&pdev->dev, handle, "creating device link\n");



