Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77A4FC49F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349474AbiDKTHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349416AbiDKTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EF33E25;
        Mon, 11 Apr 2022 12:04:36 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 985912d5c9d862fb; Mon, 11 Apr 2022 21:04:35 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7A3E966BDFC;
        Mon, 11 Apr 2022 21:04:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 07/20] ACPICA: Add new ACPI 6.4 semantics for LoadTable() operator
Date:   Mon, 11 Apr 2022 20:52:26 +0200
Message-ID: <2200163.iZASKD2KPV@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b32dde35e26a63a85d78d4dc0a7260b61e626ac1

DDB_HANDLE is gone, now LoadTable() returns a pass/fail integer.

Link: https://github.com/acpica/acpica/commit/b32dde35
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 exconfig.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff -Nurp linux.before_name/drivers/acpi/acpica/exconfig.c linux.after_name/drivers/acpi/acpica/exconfig.c
--- linux.before_name/drivers/acpi/acpica/exconfig.c	2022-04-01 18:23:55.873311880 +0200
+++ linux.after_name/drivers/acpi/acpica/exconfig.c	2022-04-01 18:23:52.190359143 +0200
@@ -87,11 +87,21 @@ acpi_ex_load_table_op(struct acpi_walk_s
 	struct acpi_namespace_node *parent_node;
 	struct acpi_namespace_node *start_node;
 	struct acpi_namespace_node *parameter_node = NULL;
+	union acpi_operand_object *return_obj;
 	union acpi_operand_object *ddb_handle;
 	u32 table_index;
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
+	/* Create the return object */
+
+	return_obj = acpi_ut_create_integer_object((u64)0);
+	if (!return_obj) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	*return_desc = return_obj;
+
 	/* Find the ACPI table in the RSDT/XSDT */
 
 	acpi_ex_exit_interpreter();
@@ -106,12 +116,6 @@ acpi_ex_load_table_op(struct acpi_walk_s
 
 		/* Table not found, return an Integer=0 and AE_OK */
 
-		ddb_handle = acpi_ut_create_integer_object((u64) 0);
-		if (!ddb_handle) {
-			return_ACPI_STATUS(AE_NO_MEMORY);
-		}
-
-		*return_desc = ddb_handle;
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -198,7 +202,13 @@ acpi_ex_load_table_op(struct acpi_walk_s
 		}
 	}
 
-	*return_desc = ddb_handle;
+	/* Remove the reference to ddb_handle created by acpi_ex_add_table above */
+
+	acpi_ut_remove_reference(ddb_handle);
+
+	/* Return -1 (non-zero) indicates success */
+
+	return_obj->integer.value = 0xFFFFFFFFFFFFFFFF;
 	return_ACPI_STATUS(status);
 }
 



