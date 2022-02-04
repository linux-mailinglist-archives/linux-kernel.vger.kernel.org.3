Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F144A9DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiBDRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:43:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56566 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377030AbiBDRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:43:27 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 23f490b0ef483493; Fri, 4 Feb 2022 18:43:26 +0100
Received: from kreacher.localnet (unknown [213.134.181.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AE09E66B456;
        Fri,  4 Feb 2022 18:43:25 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] ACPI: EC: Reduce indentation level in acpi_ec_submit_event()
Date:   Fri, 04 Feb 2022 18:40:55 +0100
Message-ID: <2180947.iZASKD2KPV@kreacher>
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

The indentation level in acpi_ec_submit_event() can be reduced, so
do that and while at it fix a typo in the comment affected by that
change.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -451,24 +451,25 @@ static void acpi_ec_submit_event(struct
 	if (!acpi_ec_event_enabled(ec))
 		return;
 
-	if (ec->event_state == EC_EVENT_READY) {
-		ec_dbg_evt("Command(%s) submitted/blocked",
-			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
+	if (ec->event_state != EC_EVENT_READY)
+		return;
+
+	ec_dbg_evt("Command(%s) submitted/blocked",
+		   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
 
-		ec->event_state = EC_EVENT_IN_PROGRESS;
-		/*
-		 * If events_to_process is greqter than 0 at this point, the
-		 * while () loop in acpi_ec_event_handler() is still running
-		 * and incrementing events_to_process will cause it to invoke
-		 * acpi_ec_submit_query() once more, so it is not necessary to
-		 * queue up the event work to start the same loop again.
-		 */
-		if (ec->events_to_process++ > 0)
-			return;
+	ec->event_state = EC_EVENT_IN_PROGRESS;
+	/*
+	 * If events_to_process is greater than 0 at this point, the while ()
+	 * loop in acpi_ec_event_handler() is still running and incrementing
+	 * events_to_process will cause it to invoke acpi_ec_submit_query() once
+	 * more, so it is not necessary to queue up the event work to start the
+	 * same loop again.
+	 */
+	if (ec->events_to_process++ > 0)
+		return;
 
-		ec->events_in_progress++;
-		queue_work(ec_wq, &ec->work);
-	}
+	ec->events_in_progress++;
+	queue_work(ec_wq, &ec->work);
 }
 
 static void acpi_ec_complete_event(struct acpi_ec *ec)



