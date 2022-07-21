Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC057D2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiGURlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGURlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:41:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C351804B1;
        Thu, 21 Jul 2022 10:41:13 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 57a2f1e4dff59ed9; Thu, 21 Jul 2022 19:41:12 +0200
Received: from kreacher.localnet (unknown [213.134.181.148])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7008866CD1E;
        Thu, 21 Jul 2022 19:41:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] ACPI: CPPC: Do not prevent CPPC from working in the future
Date:   Thu, 21 Jul 2022 19:41:10 +0200
Message-ID: <12041179.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.148
X-CLIENT-HOSTNAME: 213.134.181.148
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudekuddrudegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddugeekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhprhgrkhgrshhhsegtohguvggruhhrohhrrgdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a problem with the current revision checks in
is_cppc_supported() that they essentially prevent the CPPC support
from working if a new _CPC package format revision being a proper
superset of the v3 and only causing _CPC to return a package with more
entries (while retaining the types and meaning of the entries defined by
the v3) is introduced in the future and used by the platform firmware.

In that case, as long as the number of entries in the _CPC return
package is at least CPPC_V3_NUM_ENT, it should be perfectly fine to
use the v3 support code and disregard the additional package entries
added by the new package format revision.

For this reason, drop is_cppc_supported() altogether, put the revision
checks directly into acpi_cppc_processor_probe() so they are easier to
follow and rework them to take the case mentioned above into account.

Fixes: 4773e77cdc9b ("ACPI / CPPC: Add support for CPPC v3")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |   54 ++++++++++++++++++++---------------------------
 include/acpi/cppc_acpi.h |    2 -
 2 files changed, 25 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -618,33 +618,6 @@ static int pcc_data_alloc(int pcc_ss_id)
 	return 0;
 }
 
-/* Check if CPPC revision + num_ent combination is supported */
-static bool is_cppc_supported(int revision, int num_ent)
-{
-	int expected_num_ent;
-
-	switch (revision) {
-	case CPPC_V2_REV:
-		expected_num_ent = CPPC_V2_NUM_ENT;
-		break;
-	case CPPC_V3_REV:
-		expected_num_ent = CPPC_V3_NUM_ENT;
-		break;
-	default:
-		pr_debug("Firmware exports unsupported CPPC revision: %d\n",
-			revision);
-		return false;
-	}
-
-	if (expected_num_ent != num_ent) {
-		pr_debug("Firmware exports %d entries. Expected: %d for CPPC rev:%d\n",
-			num_ent, expected_num_ent, revision);
-		return false;
-	}
-
-	return true;
-}
-
 /*
  * An example CPC table looks like the following.
  *
@@ -733,7 +706,6 @@ int acpi_cppc_processor_probe(struct acp
 			 cpc_obj->type, pr->id);
 		goto out_free;
 	}
-	cpc_ptr->num_entries = num_ent;
 
 	/* Second entry should be revision. */
 	cpc_obj = &out_obj->package.elements[1];
@@ -744,10 +716,32 @@ int acpi_cppc_processor_probe(struct acp
 			 cpc_obj->type, pr->id);
 		goto out_free;
 	}
-	cpc_ptr->version = cpc_rev;
 
-	if (!is_cppc_supported(cpc_rev, num_ent))
+	if (cpc_rev < CPPC_V2_REV) {
+		pr_debug("Unsupported _CPC Revision (%d) for CPU:%d\n", cpc_rev,
+			 pr->id);
 		goto out_free;
+	}
+
+	/*
+	 * Disregard _CPC if the number of entries in the return pachage is not
+	 * as expected, but support future revisions being proper supersets of
+	 * the v3 and only causing more entries to be returned by _CPC.
+	 */
+	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
+	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
+	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
+		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
+			 num_ent, pr->id);
+		goto out_free;
+	}
+	if (cpc_rev > CPPC_V3_REV) {
+		num_ent = CPPC_V3_NUM_ENT;
+		cpc_rev = CPPC_V3_REV;
+	}
+
+	cpc_ptr->num_entries = num_ent;
+	cpc_ptr->version = cpc_rev;
 
 	/* Iterate through remaining entries in _CPC */
 	for (i = 2; i < num_ent; i++) {
Index: linux-pm/include/acpi/cppc_acpi.h
===================================================================
--- linux-pm.orig/include/acpi/cppc_acpi.h
+++ linux-pm/include/acpi/cppc_acpi.h
@@ -17,7 +17,7 @@
 #include <acpi/pcc.h>
 #include <acpi/processor.h>
 
-/* Support CPPCv2 and CPPCv3  */
+/* CPPCv2 and CPPCv3 support */
 #define CPPC_V2_REV	2
 #define CPPC_V3_REV	3
 #define CPPC_V2_NUM_ENT	21



