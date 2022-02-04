Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CC34A9DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376903AbiBDRfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:35:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63674 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376885AbiBDRfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:35:43 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 3cf6cf3a52c3a6f5; Fri, 4 Feb 2022 18:35:42 +0100
Received: from kreacher.localnet (unknown [213.134.181.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3503266B456;
        Fri,  4 Feb 2022 18:35:41 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE
Date:   Fri, 04 Feb 2022 18:31:02 +0100
Message-ID: <5800804.lOV4Wx5bFT@kreacher>
In-Reply-To: <11925099.O9o76ZdvQC@kreacher>
References: <11925099.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.137
X-CLIENT-HOSTNAME: 213.134.181.137
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddrudefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddufeejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthho
 pegurghvihgurdgvrdgsohigsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 4a9af6cac050 ("ACPI: EC: Rework flushing of EC work while
suspended to idle") made acpi_ec_dispatch_gpe() check
pm_wakeup_pending(), but that is before canceling the SCI wakeup,
so pm_wakeup_pending() is always true.  This causes the loop in
acpi_ec_dispatch_gpe() to always terminate after one iteration which
may not be correct.

Address this issue by canceling the SCI wakeup earlier, from
acpi_ec_dispatch_gpe() itself.

Fixes: 4a9af6cac050 ("ACPI: EC: Rework flushing of EC work while suspended to idle")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c    |   10 ++++++++++
 drivers/acpi/sleep.c |   15 +++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -2066,6 +2066,16 @@ bool acpi_ec_dispatch_gpe(void)
 		return true;
 
 	/*
+	 * Cancel the SCI wakeup and process all pending events in case there
+	 * are any wakeup ones in there.
+	 *
+	 * Note that if any non-EC GPEs are active at this point, the SCI will
+	 * retrigger after the rearming in acpi_s2idle_wake(), so no events
+	 * should be missed by canceling the wakeup here.
+	 */
+	pm_system_cancel_wakeup();
+
+	/*
 	 * Dispatch the EC GPE in-band, but do not report wakeup in any case
 	 * to allow the caller to process events properly after that.
 	 */
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -736,21 +736,15 @@ bool acpi_s2idle_wake(void)
 			return true;
 		}
 
-		/* Check non-EC GPE wakeups and dispatch the EC GPE. */
+		/*
+		 * Check non-EC GPE wakeups and if there are none, cancel the
+		 * SCI-related wakeup and dispatch the EC GPE.
+		 */
 		if (acpi_ec_dispatch_gpe()) {
 			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
 			return true;
 		}
 
-		/*
-		 * Cancel the SCI wakeup and process all pending events in case
-		 * there are any wakeup ones in there.
-		 *
-		 * Note that if any non-EC GPEs are active at this point, the
-		 * SCI will retrigger after the rearming below, so no events
-		 * should be missed by canceling the wakeup here.
-		 */
-		pm_system_cancel_wakeup();
 		acpi_os_wait_events_complete();
 
 		/*



