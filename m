Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181AC5A18FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbiHYSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbiHYSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:47:33 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A194B0FF;
        Thu, 25 Aug 2022 11:47:31 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id db5842b370c445d2; Thu, 25 Aug 2022 20:47:30 +0200
Received: from kreacher.localnet (unknown [213.134.169.168])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8BB1366D1DA;
        Thu, 25 Aug 2022 20:47:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
Date:   Thu, 25 Aug 2022 20:47:28 +0200
Message-ID: <12054041.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.168
X-CLIENT-HOSTNAME: 213.134.169.168
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejfedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudeiledrudeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduieekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepuggrmhhivghnrdhlvghmohgrlhesohhpvghnshhouhhrtggvrdifuggtrdgtohhmpdhrtghpthhtoheplhhinhhugidqihguvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
 nhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
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

The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
use low-power S0 idle on the given platform than S3 (provided that
the latter is supported) and it doesn't preclude using either of
them (which of them will be used depends on the choices made by user
space).

For this reason, there is no benefit from checking that flag in
ahci_update_initial_lpm_policy().

First off, it cannot be a bug to do S3 with policy set to either
ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
protect the S3-capable systems from failing.

Second, suspend-to-idle can be carried out on a system with
ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
needed to handle that case correctly, it should be done regardless of
the ACPI_FADT_LOW_POWER_S0 value.

Accordingly, replace the ACPI_FADT_LOW_POWER_S0 check in
ahci_update_initial_lpm_policy() with pm_suspend_default_s2idle()
which is more general and also takes the user's preference into
account and drop the CONFIG_ACPI #ifdef around it that is not necessary
any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Use pm_suspend_default_s2idle() instead of the check being dropped.
   * Update the changelog.

v1 -> v2:
   * Adjust subject (Damien).
   * Drop #ifdef CONFIG_ACPI that is not necessary any more (Mario).
   * Update the changelog.

---
 drivers/ata/ahci.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/ata/ahci.c
===================================================================
--- linux-pm.orig/drivers/ata/ahci.c
+++ linux-pm/drivers/ata/ahci.c
@@ -1609,15 +1609,12 @@ static void ahci_update_initial_lpm_poli
 		goto update_policy;
 	}
 
-#ifdef CONFIG_ACPI
-	if (policy > ATA_LPM_MED_POWER &&
-	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+	if (policy > ATA_LPM_MED_POWER && pm_suspend_default_s2idle()) {
 		if (hpriv->cap & HOST_CAP_PART)
 			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
 		else if (hpriv->cap & HOST_CAP_SSC)
 			policy = ATA_LPM_MIN_POWER;
 	}
-#endif
 
 update_policy:
 	if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)



