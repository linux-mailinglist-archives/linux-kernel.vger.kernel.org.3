Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB204A9DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbiBDRfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:35:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53408 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiBDRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:35:41 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id a786794575b560a3; Fri, 4 Feb 2022 18:35:40 +0100
Received: from kreacher.localnet (unknown [213.134.181.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EA91766B456;
        Fri,  4 Feb 2022 18:35:38 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 2/2] PM: s2idle: ACPI: Fix wakeup interrupts handling
Date:   Fri, 04 Feb 2022 18:35:22 +0100
Message-ID: <4695836.GXAFRqVoOG@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race
related to the EC GPE") wakeup interrupts occurring immediately after
the one discarded by acpi_s2idle_wake() may be missed.  Moreover, if
the SCI triggers again immediately after the rearming in
acpi_s2idle_wake(), that wakeup may be missed too.

The problem is that pm_system_irq_wakeup() only calls pm_system_wakeup()
when pm_wakeup_irq is 0, but that's not the case any more after the
interrupt causing acpi_s2idle_wake() to run until pm_wakeup_irq is
cleared by the pm_wakeup_clear() call in s2idle_loop().  However,
there may be wakeup interrupts occurring in that time frame and if
that happens, they will be missed.

To address that issue first move the clearing of pm_wakeup_irq to
the point at which it is known that the interrupt causing
acpi_s2idle_wake() to tun will be discarded, before rearming the SCI
for wakeup.  Moreover, because that only reduces the size of the
time window in which the issue may manifest itself, allow
pm_system_irq_wakeup() to register two second wakeup interrupts in
a row and, when discarding the first one, replace it with the second
one.  [Of course, this assumes that only one wakeup interrupt can be
discarded in one go, but currently that is the case and I am not
aware of any plans to change that.]

Fixes: e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race related to the EC GPE")
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c        |    1 +
 drivers/base/power/wakeup.c |   41 ++++++++++++++++++++++++++++++++++-------
 include/linux/suspend.h     |    4 ++--
 kernel/power/main.c         |    5 ++++-
 kernel/power/process.c      |    2 +-
 kernel/power/suspend.c      |    2 --
 6 files changed, 42 insertions(+), 13 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -497,14 +497,14 @@ extern void ksys_sync_helper(void);
 
 /* drivers/base/power/wakeup.c */
 extern bool events_check_enabled;
-extern unsigned int pm_wakeup_irq;
 extern suspend_state_t pm_suspend_target_state;
 
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
 extern void pm_system_cancel_wakeup(void);
-extern void pm_wakeup_clear(bool reset);
+extern void pm_wakeup_clear(unsigned int irq_number);
 extern void pm_system_irq_wakeup(unsigned int irq_number);
+extern unsigned int pm_wakeup_irq(void);
 extern bool pm_get_wakeup_count(unsigned int *count, bool block);
 extern bool pm_save_wakeup_count(unsigned int count);
 extern void pm_wakep_autosleep_enabled(bool set);
Index: linux-pm/kernel/power/process.c
===================================================================
--- linux-pm.orig/kernel/power/process.c
+++ linux-pm/kernel/power/process.c
@@ -134,7 +134,7 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		atomic_inc(&system_freezing_cnt);
 
-	pm_wakeup_clear(true);
+	pm_wakeup_clear(0);
 	pr_info("Freezing user space processes ... ");
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -136,8 +136,6 @@ static void s2idle_loop(void)
 			break;
 		}
 
-		pm_wakeup_clear(false);
-
 		s2idle_enter();
 	}
 
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -34,7 +34,8 @@ suspend_state_t pm_suspend_target_state;
 bool events_check_enabled __read_mostly;
 
 /* First wakeup IRQ seen by the kernel in the last cycle. */
-unsigned int pm_wakeup_irq __read_mostly;
+static unsigned int wakeup_irq[2] __read_mostly;
+static DEFINE_RAW_SPINLOCK(wakeup_irq_lock);
 
 /* If greater than 0 and the system is suspending, terminate the suspend. */
 static atomic_t pm_abort_suspend __read_mostly;
@@ -942,19 +943,45 @@ void pm_system_cancel_wakeup(void)
 	atomic_dec_if_positive(&pm_abort_suspend);
 }
 
-void pm_wakeup_clear(bool reset)
+void pm_wakeup_clear(unsigned int irq_number)
 {
-	pm_wakeup_irq = 0;
-	if (reset)
+	raw_spin_lock_irq(&wakeup_irq_lock);
+
+	if (irq_number && wakeup_irq[0] == irq_number)
+		wakeup_irq[0] = wakeup_irq[1];
+	else
+		wakeup_irq[0] = 0;
+
+	wakeup_irq[1] = 0;
+
+	raw_spin_unlock_irq(&wakeup_irq_lock);
+
+	if (!irq_number)
 		atomic_set(&pm_abort_suspend, 0);
 }
 
 void pm_system_irq_wakeup(unsigned int irq_number)
 {
-	if (pm_wakeup_irq == 0) {
-		pm_wakeup_irq = irq_number;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&wakeup_irq_lock, flags);
+
+	if (wakeup_irq[0] == 0)
+		wakeup_irq[0] = irq_number;
+	else if (wakeup_irq[1] == 0)
+		wakeup_irq[1] = irq_number;
+	else
+		irq_number = 0;
+
+	raw_spin_unlock_irqrestore(&wakeup_irq_lock, flags);
+
+	if (irq_number)
 		pm_system_wakeup();
-	}
+}
+
+unsigned int pm_wakeup_irq(void)
+{
+	return wakeup_irq[0];
 }
 
 /**
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -504,7 +504,10 @@ static ssize_t pm_wakeup_irq_show(struct
 					struct kobj_attribute *attr,
 					char *buf)
 {
-	return pm_wakeup_irq ? sprintf(buf, "%u\n", pm_wakeup_irq) : -ENODATA;
+	if (!pm_wakeup_irq())
+		return -ENODATA;
+
+	return sprintf(buf, "%u\n", pm_wakeup_irq());
 }
 
 power_attr_ro(pm_wakeup_irq);
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -760,6 +760,7 @@ bool acpi_s2idle_wake(void)
 
 		pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
 
+		pm_wakeup_clear(acpi_sci_irq);
 		rearm_wake_irq(acpi_sci_irq);
 	}
 



