Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8630568879
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGFMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiGFMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:37:55 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC71E3F0;
        Wed,  6 Jul 2022 05:37:53 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id ffb56cd6bc48098d; Wed, 6 Jul 2022 14:37:50 +0200
Received: from kreacher.localnet (unknown [213.134.187.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 44F5B66CAEB;
        Wed,  6 Jul 2022 14:37:50 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] ACPI: EC: Make evaluate acpi_ec_add() _REG for EC operation regions
Date:   Wed, 06 Jul 2022 14:37:49 +0200
Message-ID: <5592689.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.2
X-CLIENT-HOSTNAME: 213.134.187.2
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeifedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepudejvdevgfegkeffffduhfeuleejieeivdeitdektdeiiedtiedvjeejudduteeknecuffhomhgrihhnpehuvghfihdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukeejrddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_ec_ecdt_probe() is called between acpi_load_tables() and
acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
acpi_install_address_space_handler() via ec_install_handlers().

Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
which is passed to acpi_ev_install_space_handler() and the handler is
installed for acpi_gbl_root_node.

Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
namespace which should not be necessary, because the OS is expected to
make the ECDT operation regions available before evaluating any AML, so
in particular AML is not expected to check the evaluation of _REG before
it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
exception 2 [1]).  Doing that is also problematic, because the _REG
methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
they should be be evaluated before running acpi_initialize_objects() [2].

Address this problem by modifying acpi_install_address_space_handler()
to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
is installed for acpi_gbl_root_node which indicates the ECDT case.

However, this needs to be accompanied by an EC driver change to
actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
regions when it finds the EC object in the namespace.

Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
Link: https://github.com/acpica/acpica/pull/786 # [2]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This change doesn't make any practical difference on any of the systems
in my office.

---
 drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
 drivers/acpi/ec.c              |    7 +++++++
 2 files changed, 19 insertions(+)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
 			acpi_handle_debug(ec->handle, "duplicated.\n");
 			acpi_ec_free(ec);
 			ec = boot_ec;
+			/*
+			 * Uninstall the EC address space handler and let
+			 * acpi_ec_setup() install it again along with
+			 * evaluating _REG methogs associated with
+			 * ACPI_ADR_SPACE_EC operation regions.
+			 */
+			ec_remove_handlers(ec);
 		}
 	}
 
Index: linux-pm/drivers/acpi/acpica/evxfregn.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
+++ linux-pm/drivers/acpi/acpica/evxfregn.c
@@ -78,6 +78,18 @@ acpi_install_address_space_handler(acpi_
 		goto unlock_and_exit;
 	}
 
+	/*
+	 * Avoid evaluating _REG methods if an EC address space handler is
+	 * installed for acpi_gbl_root_node, because this is done in order to
+	 * make Embedded Controller operation regions, accessed via the Embedded
+	 * Controllers described in ECDT, available early (see ACPI 6.4, Section
+	 * 6.5.4, exception 2).
+	 */
+
+	if (node == acpi_gbl_root_node || space_id == ACPI_ADR_SPACE_EC) {
+		goto unlock_and_exit;
+	}
+
 	/* Run all _REG methods for this address space */
 
 	acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);



