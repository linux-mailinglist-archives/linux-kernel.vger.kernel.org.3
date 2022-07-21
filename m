Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC7557D116
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiGUQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiGUQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:13:52 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B788E28;
        Thu, 21 Jul 2022 09:13:42 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 391fc89340d9f6bb; Thu, 21 Jul 2022 18:13:32 +0200
Received: from kreacher.localnet (unknown [213.134.181.148])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 72E7866CD18;
        Thu, 21 Jul 2022 18:13:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: PM: x86: Print messages regarding LPS0 idle support
Date:   Thu, 21 Jul 2022 18:13:30 +0200
Message-ID: <12039470.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.148
X-CLIENT-HOSTNAME: 213.134.181.148
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudekuddrudegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddugeekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhi
 nhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because suspend-to-idle is always supported and on x86 it is the only
way to suspend the system if S3 is not supported by the platform, the
kernel attempts to enter low-power S0 idle in the suspend-to-idle flow
regardless of whether or not the ACPI_FADT_LOW_POWER_S0 flag is set in
the FADT.  However, if that flag is not set, residency counters
associated with low-power S0 idle may not count and the platform may
refuse to put the EC into a low-power mode, for example.

For this reason, print diagnostic messages when the platform should
achieve significant energy savings in low-power S0 idle (because the
ACPI_FADT_LOW_POWER_S0 flag is set in the FADT) and when
suspend-to-idle becomes the default suspend method (because low-power
S0 idle should be equally or more efficient than S3, if available).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c      |    3 +++
 drivers/acpi/x86/s2idle.c |    4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -824,6 +824,9 @@ static const struct platform_s2idle_ops
 
 void __weak acpi_s2idle_setup(void)
 {
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+		pr_info("Efficient low-power S0 idle declared\n");
+
 	s2idle_set_ops(&acpi_s2idle_ops);
 }
 
Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/x86/s2idle.c
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -423,8 +423,10 @@ static int lps0_device_attach(struct acp
 	 * line.
 	 */
 	if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
-	    mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
+	    mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3) {
 		mem_sleep_current = PM_SUSPEND_TO_IDLE;
+		pr_info("Low-power S0 idle used by default for system suspend\n");
+	}
 
 	/*
 	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the



