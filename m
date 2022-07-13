Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2476E573CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiGMSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGMSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:51:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8C27161;
        Wed, 13 Jul 2022 11:51:16 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 8ed8ddcc99617fa5; Wed, 13 Jul 2022 20:51:14 +0200
Received: from kreacher.localnet (unknown [213.134.162.15])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9A00D66CC02;
        Wed, 13 Jul 2022 20:51:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: PM: s2idle: Use LPS0 idle if ACPI_FADT_LOW_POWER_S0 is unset
Date:   Wed, 13 Jul 2022 20:51:13 +0200
Message-ID: <12037674.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.15
X-CLIENT-HOSTNAME: 213.134.162.15
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudeivddrudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrudehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the PNP0D80 device is present and its _DSM appears to be valid,
there is no reason to avoid using it even if ACPI_FADT_LOW_POWER_S0
is unset in the FADT, because suspend-to-idle may be the only way to
suspend the system if S3 is not supported by the platform, so do not
return early from lps0_device_attach() in that case.

However, still check ACPI_FADT_LOW_POWER_S0 when deciding whether or
not suspend-to-idle should be the default system suspend method.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/x86/s2idle.c
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -369,9 +369,6 @@ static int lps0_device_attach(struct acp
 	if (lps0_device_handle)
 		return 0;
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
-		return 0;
-
 	if (acpi_s2idle_vendor_amd()) {
 		/* AMD0004, AMD0005, AMDI0005:
 		 * - Should use rev_id 0x0
@@ -421,10 +418,12 @@ static int lps0_device_attach(struct acp
 		lpi_device_get_constraints();
 
 	/*
-	 * Use suspend-to-idle by default if the default suspend mode was not
-	 * set from the command line.
+	 * Use suspend-to-idle by default if ACPI_FADT_LOW_POWER_S0 is set in
+	 * the FADT and the default suspend mode was not set from the command
+	 * line.
 	 */
-	if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
+	    mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
 		mem_sleep_current = PM_SUSPEND_TO_IDLE;
 
 	/*



