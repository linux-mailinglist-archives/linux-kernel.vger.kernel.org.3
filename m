Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0193E573C08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiGMRdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiGMRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:33:26 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2D275FA;
        Wed, 13 Jul 2022 10:33:25 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id dc50a12d4af63015; Wed, 13 Jul 2022 19:33:23 +0200
Received: from kreacher.localnet (unknown [213.134.162.15])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B540F66CC00;
        Wed, 13 Jul 2022 19:33:22 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] Revert "ACPI / PM: LPIT: Register sysfs attributes based on FADT"
Date:   Wed, 13 Jul 2022 19:33:22 +0200
Message-ID: <2658707.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.15
X-CLIENT-HOSTNAME: 213.134.162.15
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudeivddrudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrudehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Revert commit 1cdda9486f51 ("ACPI / PM: LPIT: Register sysfs attributes
based on FADT"), because what it did was more confusing than it would
be to allow the sysfs attributes in question to be created regardless
of whether or not the relevant flag was set in the FADT.

If ACPI_FADT_LOW_POWER_S0 is not set, it need not mean that LPIT is
invalid and low-power S0 idle is not usable.  It merely means that
using S3 on the given system is more beneficial from the energy
saving perspective than using low-power S0 idle.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 48e5059d67ca..50540d4d4948 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -109,17 +109,11 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 		if (!info->iomem_addr)
 			return;
 
-		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
-			return;
-
 		/* Silently fail, if cpuidle attribute group is not present */
 		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
 					&dev_attr_low_power_idle_system_residency_us.attr,
 					"cpuidle");
 	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
-			return;
-
 		/* Silently fail, if cpuidle attribute group is not present */
 		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
 					&dev_attr_low_power_idle_cpu_residency_us.attr,



