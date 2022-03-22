Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4E4E43D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiCVQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiCVQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:05:29 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B86F483;
        Tue, 22 Mar 2022 09:03:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id fd475ee49fd01f3e; Tue, 22 Mar 2022 17:03:57 +0100
Received: from kreacher.localnet (unknown [213.134.175.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 87B6666BA74;
        Tue, 22 Mar 2022 17:03:56 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH v1 2/2] ACPI: CPPC: Change default error code and clean up debug messages in probe
Date:   Tue, 22 Mar 2022 17:03:23 +0100
Message-ID: <2233747.ElGaqSPkdT@kreacher>
In-Reply-To: <5552457.DvuYhMxLoT@kreacher>
References: <5552457.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.187
X-CLIENT-HOSTNAME: 213.134.175.187
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddukeejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidr
 ihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepihhonhgvlhgrrdhvohhinhgvshgtuhesrghrmhdrtghomh
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

Change the default error code returned by acpi_cppc_processor_probe()
from -EFAULT (which is completely inadequate) to -ENODATA and change
the debug messages printed by it to contain more information and be
more consistent.

While at it, format some white space to follow the coding style.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -654,7 +654,7 @@ int acpi_cppc_processor_probe(struct acp
 	unsigned int num_ent, i, cpc_rev;
 	int pcc_subspace_id = -1;
 	acpi_status status;
-	int ret = -EFAULT;
+	int ret = -ENODATA;
 
 	if (osc_sb_cppc_not_supported)
 		return -ENODEV;
@@ -685,8 +685,8 @@ int acpi_cppc_processor_probe(struct acp
 			goto out_free;
 		}
 	} else {
-		pr_debug("Unexpected entry type(%d) for NumEntries\n",
-				cpc_obj->type);
+		pr_debug("Unexpected _CPC NumEntries entry type (%d) for CPU:%d\n",
+			 cpc_obj->type, pr->id);
 		goto out_free;
 	}
 	cpc_ptr->num_entries = num_ent;
@@ -696,8 +696,8 @@ int acpi_cppc_processor_probe(struct acp
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
 		cpc_rev = cpc_obj->integer.value;
 	} else {
-		pr_debug("Unexpected entry type(%d) for Revision\n",
-				cpc_obj->type);
+		pr_debug("Unexpected _CPC Revision entry type (%d) for CPU:%d\n",
+			 cpc_obj->type, pr->id);
 		goto out_free;
 	}
 	cpc_ptr->version = cpc_rev;
@@ -728,7 +728,8 @@ int acpi_cppc_processor_probe(struct acp
 					if (pcc_data_alloc(pcc_subspace_id))
 						goto out_free;
 				} else if (pcc_subspace_id != gas_t->access_width) {
-					pr_debug("Mismatched PCC ids.\n");
+					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
+						 pr->id);
 					goto out_free;
 				}
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
@@ -747,20 +748,21 @@ int acpi_cppc_processor_probe(struct acp
 					 * SystemIO doesn't implement 64-bit
 					 * registers.
 					 */
-					pr_debug("Invalid access width %d for SystemIO register\n",
-						gas_t->access_width);
+					pr_debug("Invalid access width %d for SystemIO register in _CPC\n",
+						 gas_t->access_width);
 					goto out_free;
 				}
 				if (gas_t->address & OVER_16BTS_MASK) {
 					/* SystemIO registers use 16-bit integer addresses */
-					pr_debug("Invalid IO port %llu for SystemIO register\n",
-						gas_t->address);
+					pr_debug("Invalid IO port %llu for SystemIO register in _CPC\n",
+						 gas_t->address);
 					goto out_free;
 				}
 			} else {
 				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
 					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
-					pr_debug("Unsupported register type: %d\n", gas_t->space_id);
+					pr_debug("Unsupported register type (%d) in _CPC\n",
+						 gas_t->space_id);
 					goto out_free;
 				}
 			}
@@ -768,7 +770,8 @@ int acpi_cppc_processor_probe(struct acp
 			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
 			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
 		} else {
-			pr_debug("Err in entry:%d in CPC table of CPU:%d\n", i, pr->id);
+			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
+				 i, pr->id);
 			goto out_free;
 		}
 	}



