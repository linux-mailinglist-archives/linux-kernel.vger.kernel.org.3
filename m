Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA64A9DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377073AbiBDRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:43:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63862 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiBDRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:43:28 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 8aeaa2d0b173ffd4; Fri, 4 Feb 2022 18:43:27 +0100
Received: from kreacher.localnet (unknown [213.134.181.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1F25366B456;
        Fri,  4 Feb 2022 18:43:27 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] ACPI: EC: Do not return result from advance_transaction()
Date:   Fri, 04 Feb 2022 18:40:20 +0100
Message-ID: <10036455.nUPlyArG6x@kreacher>
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

Notice that the if the event state is EC_EVENT_READY, the event
handling work cannot be pending, so it is not necessary to check
the return value of queue_work() in acpi_ec_submit_event().
Moreover, whether or not there is any EC work pending at the
moment can always be checked by looking at the events_in_progress
and queries_in_progress counters, so acpi_ec_submit_event() and
consequently advance_transaction() need not return results.

Accordingly, make acpi_ec_dispatch_gpe() always use the counters
mentioned above (for first_ec) to check if there is any pending EC
work to flush and turn both acpi_ec_submit_event() and
advance_transaction() into void functions (again, because they were
void functions in the past).

While at it, add a clarifying comment about the acpi_ec_mask_events()
call in advance_transaction().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -168,7 +168,7 @@ struct acpi_ec_query {
 };
 
 static int acpi_ec_submit_query(struct acpi_ec *ec);
-static bool advance_transaction(struct acpi_ec *ec, bool interrupt);
+static void advance_transaction(struct acpi_ec *ec, bool interrupt);
 static void acpi_ec_event_handler(struct work_struct *work);
 
 struct acpi_ec *first_ec;
@@ -441,11 +441,15 @@ static bool acpi_ec_submit_flushable_req
 	return true;
 }
 
-static bool acpi_ec_submit_event(struct acpi_ec *ec)
+static void acpi_ec_submit_event(struct acpi_ec *ec)
 {
+	/*
+	 * It is safe to mask the events here, because acpi_ec_close_event()
+	 * will run at least once after this.
+	 */
 	acpi_ec_mask_events(ec);
 	if (!acpi_ec_event_enabled(ec))
-		return false;
+		return;
 
 	if (ec->event_state == EC_EVENT_READY) {
 		ec_dbg_evt("Command(%s) submitted/blocked",
@@ -460,17 +464,11 @@ static bool acpi_ec_submit_event(struct
 		 * queue up the event work to start the same loop again.
 		 */
 		if (ec->events_to_process++ > 0)
-			return true;
+			return;
 
 		ec->events_in_progress++;
-		return queue_work(ec_wq, &ec->work);
+		queue_work(ec_wq, &ec->work);
 	}
-
-	/*
-	 * The event handling work has not been completed yet, so it needs to be
-	 * flushed.
-	 */
-	return true;
 }
 
 static void acpi_ec_complete_event(struct acpi_ec *ec)
@@ -655,11 +653,10 @@ static void acpi_ec_spurious_interrupt(s
 		acpi_ec_mask_events(ec);
 }
 
-static bool advance_transaction(struct acpi_ec *ec, bool interrupt)
+static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 {
 	struct transaction *t = ec->curr;
 	bool wakeup = false;
-	bool ret = false;
 	u8 status;
 
 	ec_dbg_stm("%s (%d)", interrupt ? "IRQ" : "TASK", smp_processor_id());
@@ -724,12 +721,10 @@ static bool advance_transaction(struct a
 
 out:
 	if (status & ACPI_EC_FLAG_SCI)
-		ret = acpi_ec_submit_event(ec);
+		acpi_ec_submit_event(ec);
 
 	if (wakeup && interrupt)
 		wake_up(&ec->wait);
-
-	return ret;
 }
 
 static void start_transaction(struct acpi_ec *ec)
@@ -2051,6 +2046,11 @@ void acpi_ec_set_gpe_wake_mask(u8 action
 		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
 }
 
+static bool acpi_ec_work_in_progress(struct acpi_ec *ec)
+{
+	return ec->events_in_progress + ec->queries_in_progress > 0;
+}
+
 bool acpi_ec_dispatch_gpe(void)
 {
 	bool work_in_progress = false;
@@ -2084,7 +2084,8 @@ bool acpi_ec_dispatch_gpe(void)
 	if (acpi_ec_gpe_status_set(first_ec)) {
 		pm_pr_dbg("ACPI EC GPE status set\n");
 
-		work_in_progress = advance_transaction(first_ec, false);
+		advance_transaction(first_ec, false);
+		work_in_progress = acpi_ec_work_in_progress(first_ec);
 	}
 
 	spin_unlock_irq(&first_ec->lock);
@@ -2102,8 +2103,7 @@ bool acpi_ec_dispatch_gpe(void)
 
 		spin_lock_irq(&first_ec->lock);
 
-		work_in_progress = first_ec->events_in_progress +
-			first_ec->queries_in_progress > 0;
+		work_in_progress = acpi_ec_work_in_progress(first_ec);
 
 		spin_unlock_irq(&first_ec->lock);
 	} while (work_in_progress && !pm_wakeup_pending());



