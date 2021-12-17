Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92984794AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhLQTQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:16:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59098 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbhLQTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:16:05 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id a2ec7d2482aa3855; Fri, 17 Dec 2021 20:16:04 +0100
Received: from kreacher.localnet (unknown [213.134.187.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8057D66AF13;
        Fri, 17 Dec 2021 20:16:03 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM: runtime: Simplify locking in pm_runtime_put_suppliers()
Date:   Fri, 17 Dec 2021 20:16:02 +0100
Message-ID: <5542600.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.104
X-CLIENT-HOSTNAME: 213.134.187.104
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudekjedruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddutdegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that pm_runtime_put_suppliers() cannot be called with
disabled interrupts, because it may sleep (due to the device
links read locking in the non-SRCU case), and so it can use
spin_lock_irq() and spin_unlock_irq() for the locking.

Update the function accordingly and while at it move the "put"
local variable in it into the inner block where it is used.

This change is not expected to have any visible functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1748,8 +1748,6 @@ void pm_runtime_get_suppliers(struct dev
 void pm_runtime_put_suppliers(struct device *dev)
 {
 	struct device_link *link;
-	unsigned long flags;
-	bool put;
 	int idx;
 
 	idx = device_links_read_lock();
@@ -1757,11 +1755,17 @@ void pm_runtime_put_suppliers(struct dev
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
+			bool put;
+
 			link->supplier_preactivated = false;
-			spin_lock_irqsave(&dev->power.lock, flags);
+
+			spin_lock_irq(&dev->power.lock);
+
 			put = pm_runtime_status_suspended(dev) &&
 			      refcount_dec_not_one(&link->rpm_active);
-			spin_unlock_irqrestore(&dev->power.lock, flags);
+
+			spin_unlock_irq(&dev->power.lock);
+
 			if (put)
 				pm_runtime_put(link->supplier);
 		}



