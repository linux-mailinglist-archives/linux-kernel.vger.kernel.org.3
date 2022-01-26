Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4927F49D2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiAZTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:45:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61494 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiAZTpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:45:20 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 8e44157e9f18981b; Wed, 26 Jan 2022 20:45:19 +0100
Received: from kreacher.localnet (unknown [213.134.162.63])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1CFEE66B311;
        Wed, 26 Jan 2022 20:45:18 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] thermal: Replace acpi_bus_get_device()
Date:   Wed, 26 Jan 2022 20:45:17 +0100
Message-ID: <2107233.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.63
X-CLIENT-HOSTNAME: 213.134.162.63
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c |   23 ++++-----------
 1 file changed, 7 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -72,7 +72,6 @@ int acpi_parse_trt(acpi_handle handle, i
 	int i;
 	int nr_bad_entries = 0;
 	struct trt *trts;
-	struct acpi_device *adev;
 	union acpi_object *p;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer element = { 0, NULL };
@@ -112,12 +111,10 @@ int acpi_parse_trt(acpi_handle handle, i
 		if (!create_dev)
 			continue;
 
-		result = acpi_bus_get_device(trt->source, &adev);
-		if (result)
+		if (!acpi_fetch_acpi_dev(trt->source))
 			pr_warn("Failed to get source ACPI device\n");
 
-		result = acpi_bus_get_device(trt->target, &adev);
-		if (result)
+		if (!acpi_fetch_acpi_dev(trt->target))
 			pr_warn("Failed to get target ACPI device\n");
 	}
 
@@ -149,7 +146,6 @@ int acpi_parse_art(acpi_handle handle, i
 	int i;
 	int nr_bad_entries = 0;
 	struct art *arts;
-	struct acpi_device *adev;
 	union acpi_object *p;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer element = { 0, NULL };
@@ -191,16 +187,11 @@ int acpi_parse_art(acpi_handle handle, i
 		if (!create_dev)
 			continue;
 
-		if (art->source) {
-			result = acpi_bus_get_device(art->source, &adev);
-			if (result)
-				pr_warn("Failed to get source ACPI device\n");
-		}
-		if (art->target) {
-			result = acpi_bus_get_device(art->target, &adev);
-			if (result)
-				pr_warn("Failed to get target ACPI device\n");
-		}
+		if (!acpi_fetch_acpi_dev(art->source))
+			pr_warn("Failed to get source ACPI device\n");
+
+		if (!acpi_fetch_acpi_dev(art->target))
+			pr_warn("Failed to get target ACPI device\n");
 	}
 
 	*artp = arts;



