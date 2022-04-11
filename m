Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59D4FC4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349487AbiDKTHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiDKTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03D33E8B;
        Mon, 11 Apr 2022 12:04:38 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 7fc6e0c9697a215e; Mon, 11 Apr 2022 21:04:36 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 18D1E66BDFC;
        Mon, 11 Apr 2022 21:04:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 06/20] ACPICA: Add new ACPI 6.4 semantics to the Load() operator
Date:   Mon, 11 Apr 2022 20:51:27 +0200
Message-ID: <8071106.T7Z3S40VBb@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
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

ACPICA commit 84bf573ab7222c4e1c22167b22d29c4da1552b20

DDB_HANDLE is gone, now Load() returns a pass/fail integer, as well as
storing it in an optional 2nd argument.

Link: https://github.com/acpica/acpica/commit/84bf573a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 dswexec.c  |    2 +-
 exconfig.c |   34 ++++++++++++++++++----------------
 exoparg1.c |   21 +++++++++++++++++++++
 psopcode.c |    4 ++--
 4 files changed, 42 insertions(+), 19 deletions(-)

diff -Nurp linux.before_name/drivers/acpi/acpica/dswexec.c linux.after_name/drivers/acpi/acpica/dswexec.c
--- linux.before_name/drivers/acpi/acpica/dswexec.c	2022-04-01 18:23:47.839414977 +0200
+++ linux.after_name/drivers/acpi/acpica/dswexec.c	2022-04-01 18:23:43.861466024 +0200
@@ -30,7 +30,7 @@ static acpi_execute_op acpi_gbl_op_type_
 	acpi_ex_opcode_0A_0T_1R,
 	acpi_ex_opcode_1A_0T_0R,
 	acpi_ex_opcode_1A_0T_1R,
-	acpi_ex_opcode_1A_1T_0R,
+	NULL,			/* Was: acpi_ex_opcode_1A_0T_0R (Was for Load operator) */
 	acpi_ex_opcode_1A_1T_1R,
 	acpi_ex_opcode_2A_0T_0R,
 	acpi_ex_opcode_2A_0T_1R,
diff -Nurp linux.before_name/drivers/acpi/acpica/exconfig.c linux.after_name/drivers/acpi/acpica/exconfig.c
--- linux.before_name/drivers/acpi/acpica/exconfig.c	2022-04-01 18:23:47.805415413 +0200
+++ linux.after_name/drivers/acpi/acpica/exconfig.c	2022-04-01 18:23:43.827466461 +0200
@@ -249,7 +249,7 @@ acpi_ex_region_read(union acpi_operand_o
  *
  * PARAMETERS:  obj_desc        - Region or Buffer/Field where the table will be
  *                                obtained
- *              target          - Where a handle to the table will be stored
+ *              target          - Where the status of the load will be stored
  *              walk_state      - Current state
  *
  * RETURN:      Status
@@ -278,6 +278,20 @@ acpi_ex_load_op(union acpi_operand_objec
 
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
+	if (target->common.descriptor_type == ACPI_DESC_TYPE_NAMED) {
+		target =
+		    acpi_ns_get_attached_object(ACPI_CAST_PTR
+						(struct acpi_namespace_node,
+						 target));
+	}
+	if (target->common.type != ACPI_TYPE_INTEGER) {
+		ACPI_EXCEPTION((AE_INFO, AE_TYPE,
+				"Type not integer: %X\n", target->common.type));
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
+	target->integer.value = 0;
+
 	/* Source Object can be either an op_region or a Buffer/Field */
 
 	switch (obj_desc->common.type) {
@@ -430,9 +443,6 @@ acpi_ex_load_op(union acpi_operand_objec
 	 */
 	status = acpi_ex_add_table(table_index, &ddb_handle);
 	if (ACPI_FAILURE(status)) {
-
-		/* On error, table_ptr was deallocated above */
-
 		return_ACPI_STATUS(status);
 	}
 
@@ -442,21 +452,13 @@ acpi_ex_load_op(union acpi_operand_objec
 	acpi_ns_initialize_objects();
 	acpi_ex_enter_interpreter();
 
-	/* Store the ddb_handle into the Target operand */
+	/* Remove the reference to ddb_handle created by acpi_ex_add_table above */
 
-	status = acpi_ex_store(ddb_handle, target, walk_state);
-	if (ACPI_FAILURE(status)) {
-		(void)acpi_ex_unload_table(ddb_handle);
-
-		/* table_ptr was deallocated above */
-
-		acpi_ut_remove_reference(ddb_handle);
-		return_ACPI_STATUS(status);
-	}
+	acpi_ut_remove_reference(ddb_handle);
 
-	/* Remove the reference by added by acpi_ex_store above */
+	/* Return -1 (non-zero) indicates success */
 
-	acpi_ut_remove_reference(ddb_handle);
+	target->integer.value = 0xFFFFFFFFFFFFFFFF;
 	return_ACPI_STATUS(status);
 }
 
diff -Nurp linux.before_name/drivers/acpi/acpica/exoparg1.c linux.after_name/drivers/acpi/acpica/exoparg1.c
--- linux.before_name/drivers/acpi/acpica/exoparg1.c	2022-04-01 18:23:47.812415323 +0200
+++ linux.after_name/drivers/acpi/acpica/exoparg1.c	2022-04-01 18:23:43.835466358 +0200
@@ -163,6 +163,7 @@ acpi_status acpi_ex_opcode_1A_0T_0R(stru
 	return_ACPI_STATUS(status);
 }
 
+#ifdef _OBSOLETE_CODE		/* Was originally used for Load() operator */
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_opcode_1A_1T_0R
@@ -187,10 +188,12 @@ acpi_status acpi_ex_opcode_1A_1T_0R(stru
 	/* Examine the AML opcode */
 
 	switch (walk_state->opcode) {
+#ifdef _OBSOLETE_CODE
 	case AML_LOAD_OP:
 
 		status = acpi_ex_load_op(operand[0], operand[1], walk_state);
 		break;
+#endif
 
 	default:		/* Unknown opcode */
 
@@ -204,6 +207,7 @@ cleanup:
 
 	return_ACPI_STATUS(status);
 }
+#endif
 
 /*******************************************************************************
  *
@@ -215,6 +219,8 @@ cleanup:
  *
  * DESCRIPTION: Execute opcode with one argument, one target, and a
  *              return value.
+ *              January 2022: Added Load operator, with new ACPI 6.4
+ *              semantics.
  *
  ******************************************************************************/
 
@@ -239,6 +245,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(stru
 	case AML_FIND_SET_LEFT_BIT_OP:
 	case AML_FIND_SET_RIGHT_BIT_OP:
 	case AML_FROM_BCD_OP:
+	case AML_LOAD_OP:
 	case AML_TO_BCD_OP:
 	case AML_CONDITIONAL_REF_OF_OP:
 
@@ -338,6 +345,20 @@ acpi_status acpi_ex_opcode_1A_1T_1R(stru
 			}
 			break;
 
+		case AML_LOAD_OP:	/* Result1 = Load (Operand[0], Result1) */
+
+			return_desc->integer.value = 0;
+			status =
+			    acpi_ex_load_op(operand[0], return_desc,
+					    walk_state);
+			if (ACPI_SUCCESS(status)) {
+
+				/* Return -1 (non-zero) indicates success */
+
+				return_desc->integer.value = 0xFFFFFFFFFFFFFFFF;
+			}
+			break;
+
 		case AML_TO_BCD_OP:	/* to_bcd (Operand, Result) */
 
 			return_desc->integer.value = 0;
diff -Nurp linux.before_name/drivers/acpi/acpica/psopcode.c linux.after_name/drivers/acpi/acpica/psopcode.c
--- linux.before_name/drivers/acpi/acpica/psopcode.c	2022-04-01 18:23:47.815415284 +0200
+++ linux.after_name/drivers/acpi/acpica/psopcode.c	2022-04-01 18:23:43.838466319 +0200
@@ -408,8 +408,8 @@ const struct acpi_opcode_info acpi_gbl_a
 			 AML_HAS_ARGS | AML_NSOBJECT | AML_NSNODE |
 			 AML_DEFER | AML_FIELD | AML_CREATE),
 /* 4A */ ACPI_OP("Load", ARGP_LOAD_OP, ARGI_LOAD_OP, ACPI_TYPE_ANY,
-			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_1A_1T_0R,
-			 AML_FLAGS_EXEC_1A_1T_0R),
+			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_1A_1T_1R,
+			 AML_FLAGS_EXEC_1A_1T_1R),
 /* 4B */ ACPI_OP("Stall", ARGP_STALL_OP, ARGI_STALL_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_1A_0T_0R,
 			 AML_FLAGS_EXEC_1A_0T_0R),



