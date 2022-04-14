Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB4500E32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiDNNBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiDNNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:01:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C59284E;
        Thu, 14 Apr 2022 05:58:48 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 87cc61afc5c5b63a; Thu, 14 Apr 2022 14:58:46 +0200
Received: from kreacher.localnet (unknown [213.134.181.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D684B66BE14;
        Thu, 14 Apr 2022 14:58:43 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: PM: Always print final debug message in acpi_device_set_power()
Date:   Thu, 14 Apr 2022 14:58:42 +0200
Message-ID: <11985385.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.101
X-CLIENT-HOSTNAME: 213.134.181.101
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelfedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudekuddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddutddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_device_set_power() prints debug messages regarding its outcome
(whether or not the power state has been changed and how) in all
cases except when the device whose power state is being changed to D0
is in that power state already.

Make acpi_device_set_power() print a final debug message in that case
too and while at it, fix the indentation of the "end" label in this
function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -173,11 +173,8 @@ int acpi_device_set_power(struct acpi_de
 	/* Make sure this is a valid target state */
 
 	/* There is a special case for D0 addressed below. */
-	if (state > ACPI_STATE_D0 && state == device->power.state) {
-		acpi_handle_debug(device->handle, "Already in %s\n",
-				  acpi_power_state_string(state));
-		return 0;
-	}
+	if (state > ACPI_STATE_D0 && state == device->power.state)
+		goto no_change;
 
 	if (state == ACPI_STATE_D3_COLD) {
 		/*
@@ -249,7 +246,7 @@ int acpi_device_set_power(struct acpi_de
 
 			/* Nothing to do here if _PSC is not present. */
 			if (!device->power.flags.explicit_get)
-				return 0;
+				goto no_change;
 
 			/*
 			 * The power state of the device was set to D0 last
@@ -264,13 +261,13 @@ int acpi_device_set_power(struct acpi_de
 			 */
 			result = acpi_dev_pm_explicit_get(device, &psc);
 			if (result || psc == ACPI_STATE_D0)
-				return 0;
+				goto no_change;
 		}
 
 		result = acpi_dev_pm_explicit_set(device, ACPI_STATE_D0);
 	}
 
- end:
+end:
 	if (result) {
 		acpi_handle_debug(device->handle,
 				  "Failed to change power state to %s\n",
@@ -282,6 +279,11 @@ int acpi_device_set_power(struct acpi_de
 	}
 
 	return result;
+
+no_change:
+	acpi_handle_debug(device->handle, "Already in %s\n",
+			  acpi_power_state_string(state));
+	return 0;
 }
 EXPORT_SYMBOL(acpi_device_set_power);
 



