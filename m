Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96E14FBF3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiDKOgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347318AbiDKOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:36:18 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679437013;
        Mon, 11 Apr 2022 07:34:02 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 587ee8244673976b; Mon, 11 Apr 2022 16:34:01 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4E4F766BDED;
        Mon, 11 Apr 2022 16:34:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 8/9] PCI/PM: Avoid redundant current_state update
Date:   Mon, 11 Apr 2022 16:31:45 +0200
Message-ID: <8938882.CDJkKcVGEf@kreacher>
In-Reply-To: <11975904.O9o76ZdvQC@kreacher>
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
 ihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that if pci_power_up() returns success early, without updating
the given device's PCI_PM_CTRL register, because it has verified that
the power state of the device is D0 already at that point, the
pci_update_current_state() invocation in pci_pm_default_resume_early()
is redundant.

Avoid that redundant call by making pci_power_up() return 1 when it
has updated the device's PCI_PM_CTRL register and checking its return
value in pci_pm_default_resume_early().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/pci/pci-driver.c |    5 +++--
 drivers/pci/pci.c        |   10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -553,8 +553,9 @@ static void pci_pm_default_resume(struct
 
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
-	pci_power_up(pci_dev);
-	pci_update_current_state(pci_dev, PCI_D0);
+	if (pci_power_up(pci_dev))
+		pci_update_current_state(pci_dev, PCI_D0);
+
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 }
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1189,6 +1189,12 @@ static int pci_dev_wait(struct pci_dev *
 /**
  * pci_power_up - Put the given device into D0
  * @dev: PCI device to power up
+ *
+ * Use the platform firmware and the PCI_PM_CTRL register to put @dev into D0.
+ *
+ * Return 0 if invoking the platform firmware was sufficient to put @dev into D0
+ * (and so the PCI_PM_CTRL register was not updated), or 1 if it was necessary to
+ * update the PCI_PM_CTRL register, or -ENODEV if the device was not accessible.
  */
 int pci_power_up(struct pci_dev *dev)
 {
@@ -1235,7 +1241,7 @@ int pci_power_up(struct pci_dev *dev)
 		udelay(PCI_PM_D2_DELAY);
 
 	dev->current_state = PCI_D0;
-	return 0;
+	return 1;
 
 fail:
 	pci_err(dev, "Unable to change power state to D0, device inaccessible\n");
@@ -1273,7 +1279,7 @@ static int pci_set_full_power_state(stru
 	int ret;
 
 	ret = pci_power_up(dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (!dev->pm_cap)



