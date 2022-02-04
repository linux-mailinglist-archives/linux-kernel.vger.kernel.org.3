Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36D94A9DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377029AbiBDRn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:43:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42722 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiBDRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:43:26 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 2871c7bdf1ff5afe; Fri, 4 Feb 2022 18:43:24 +0100
Received: from kreacher.localnet (unknown [213.134.181.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4897866B456;
        Fri,  4 Feb 2022 18:43:24 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] ACPI: EC: Rearrange code in acpi_ec_submit_event()
Date:   Fri, 04 Feb 2022 18:43:14 +0100
Message-ID: <7351357.EvYhyI6sBW@kreacher>
In-Reply-To: <12956939.uLZWGnKmhe@kreacher>
References: <12956939.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.137
X-CLIENT-HOSTNAME: 213.134.181.137
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddrudefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddufeejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rearange acpi_ec_event_handler() so as to avoid releasing ec->lock
and acquiring it again right away in the case when ec_event_clearing
is not ACPI_EC_EVT_TIMING_EVENT.

This also reduces the number of checks done by acpi_ec_event_handler()
in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1238,6 +1238,7 @@ static void acpi_ec_event_handler(struct
 		acpi_ec_submit_query(ec);
 
 		spin_lock_irq(&ec->lock);
+
 		ec->events_to_process--;
 	}
 
@@ -1246,27 +1247,30 @@ static void acpi_ec_event_handler(struct
 	 * event handling work again regardless of whether or not the query
 	 * queued up above is processed successfully.
 	 */
-	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT)
+	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT) {
+		bool guard_timeout;
+
 		acpi_ec_complete_event(ec);
-	else
-		acpi_ec_close_event(ec);
 
-	spin_unlock_irq(&ec->lock);
+		ec_dbg_evt("Event stopped");
 
-	ec_dbg_evt("Event stopped");
+		spin_unlock_irq(&ec->lock);
+
+		guard_timeout = !!ec_guard(ec);
 
-	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT && ec_guard(ec)) {
 		spin_lock_irq(&ec->lock);
 
 		/* Take care of SCI_EVT unless someone else is doing that. */
-		if (!ec->curr)
+		if (guard_timeout && !ec->curr)
 			advance_transaction(ec, false);
+	} else {
+		acpi_ec_close_event(ec);
 
-		spin_unlock_irq(&ec->lock);
+		ec_dbg_evt("Event stopped");
 	}
 
-	spin_lock_irq(&ec->lock);
 	ec->events_in_progress--;
+
 	spin_unlock_irq(&ec->lock);
 }
 



