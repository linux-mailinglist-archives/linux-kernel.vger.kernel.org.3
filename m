Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5F24F17DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378140AbiDDPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiDDPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:05:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97A2F033;
        Mon,  4 Apr 2022 08:03:23 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id f4e84690400e722c; Mon, 4 Apr 2022 17:03:21 +0200
Received: from kreacher.localnet (unknown [213.134.181.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1E70D66BCD2;
        Mon,  4 Apr 2022 17:03:21 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 3/3] ACPI: PM: Unify debug messages in acpi_device_set_power()
Date:   Mon, 04 Apr 2022 17:03:11 +0200
Message-ID: <1833451.tdWV9SEqCh@kreacher>
In-Reply-To: <5575732.DvuYhMxLoT@kreacher>
References: <5575732.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.62
X-CLIENT-HOSTNAME: 213.134.181.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddriedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddriedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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

Convert all of the debug messages printed by acpi_device_set_power()
to acpi_handle_debug() and adjust them slightly for consistency with
acpi_device_get_power() and other acpi_device_set_power() debug
messages.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -174,8 +174,8 @@ int acpi_device_set_power(struct acpi_de
 
 	/* There is a special case for D0 addressed below. */
 	if (state > ACPI_STATE_D0 && state == device->power.state) {
-		dev_dbg(&device->dev, "Device already in %s\n",
-			acpi_power_state_string(state));
+		acpi_handle_debug(device->handle, "Already in %s\n",
+				  acpi_power_state_string(state));
 		return 0;
 	}
 
@@ -189,17 +189,17 @@ int acpi_device_set_power(struct acpi_de
 		if (!device->power.states[ACPI_STATE_D3_COLD].flags.valid)
 			target_state = state;
 	} else if (!device->power.states[state].flags.valid) {
-		dev_warn(&device->dev, "Power state %s not supported\n",
-			 acpi_power_state_string(state));
+		acpi_handle_debug(device->handle, "Power state %s not supported\n",
+				  acpi_power_state_string(state));
 		return -ENODEV;
 	}
 
-	if (!device->power.flags.ignore_parent &&
-	    device->parent && (state < device->parent->power.state)) {
-		dev_warn(&device->dev,
-			 "Cannot transition to power state %s for parent in %s\n",
-			 acpi_power_state_string(state),
-			 acpi_power_state_string(device->parent->power.state));
+	if (!device->power.flags.ignore_parent && device->parent &&
+	    state < device->parent->power.state) {
+		acpi_handle_debug(device->handle,
+				  "Cannot transition to %s for parent in %s\n",
+				  acpi_power_state_string(state),
+				  acpi_power_state_string(device->parent->power.state));
 		return -ENODEV;
 	}
 
@@ -216,9 +216,10 @@ int acpi_device_set_power(struct acpi_de
 		 * (deeper) states to higher-power (shallower) states.
 		 */
 		if (state < device->power.state) {
-			dev_warn(&device->dev, "Cannot transition from %s to %s\n",
-				 acpi_power_state_string(device->power.state),
-				 acpi_power_state_string(state));
+			acpi_handle_debug(device->handle,
+					  "Cannot transition from %s to %s\n",
+					  acpi_power_state_string(device->power.state),
+					  acpi_power_state_string(state));
 			return -ENODEV;
 		}
 
@@ -271,12 +272,13 @@ int acpi_device_set_power(struct acpi_de
 
  end:
 	if (result) {
-		dev_warn(&device->dev, "Failed to change power state to %s\n",
-			 acpi_power_state_string(target_state));
+		acpi_handle_debug(device->handle,
+				  "Failed to change power state to %s\n",
+				  acpi_power_state_string(target_state));
 	} else {
 		device->power.state = target_state;
-		dev_dbg(&device->dev, "Power state changed to %s\n",
-			acpi_power_state_string(target_state));
+		acpi_handle_debug(device->handle, "Power state changed to %s\n",
+				  acpi_power_state_string(target_state));
 	}
 
 	return result;



