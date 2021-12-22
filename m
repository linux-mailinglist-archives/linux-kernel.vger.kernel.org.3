Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D583047D556
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbhLVQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:44:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59848 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbhLVQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:27 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id dd4f28774a78a843; Wed, 22 Dec 2021 17:43:26 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B275E66AF2B;
        Wed, 22 Dec 2021 17:43:25 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 02/19] ACPICA: Use original data_table_region pointer for accesses
Date:   Wed, 22 Dec 2021 17:21:25 +0100
Message-ID: <1804750.tdWV9SEqCh@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Clarke <jrtc27@jrtc27.com>

ACPICA commit d9eb82bd7515989f0b29d79deeeb758db4d6529c

Currently the pointer to the table is cast to acpi_physical_address and
later cast back to a pointer to be dereferenced. Whether or not this is
supported is implementation-defined.

On CHERI, and thus Arm's experimental Morello prototype architecture,
pointers are represented as capabilities, which are unforgeable bounded
pointers, providing always-on fine-grained spatial memory safety. This
means that any pointer cast to a plain integer will lose all its
associated metadata, and when cast back to a pointer it will give a
null-derived pointer (one that has the same metadata as null but an
address equal to the integer) that will trap on any dereference. As a
result, this is an implementation where acpi_physical_address cannot be
used as a hack to store real pointers.

Thus, add a new field to struct acpi_object_region to store the pointer for
table regions, and propagate it to acpi_ex_data_table_space_handler via the
region context, to use a more portable implementation that supports
CHERI.

Link: https://github.com/acpica/acpica/commit/d9eb82bd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acevents.h  |  5 ++++
 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/dsopcode.c  |  1 +
 drivers/acpi/acpica/evhandler.c |  2 +-
 drivers/acpi/acpica/evrgnini.c  | 52 +++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/excreate.c  |  1 +
 drivers/acpi/acpica/exregion.c  | 15 +++++++---
 include/acpi/actypes.h          |  4 +++
 8 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 82a75964343b..b29ba436944a 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -223,6 +223,11 @@ acpi_ev_pci_bar_region_setup(acpi_handle handle,
 			     u32 function,
 			     void *handler_context, void **region_context);
 
+acpi_status
+acpi_ev_data_table_region_setup(acpi_handle handle,
+				u32 function,
+				void *handler_context, void **region_context);
+
 acpi_status
 acpi_ev_default_region_setup(acpi_handle handle,
 			     u32 function,
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 9db5ae0f79ea..0aa0d847cb25 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -138,6 +138,7 @@ struct acpi_object_region {
 	union acpi_operand_object *next;
 	acpi_physical_address address;
 	u32 length;
+	void *pointer;		/* Only for data table regions */
 };
 
 struct acpi_object_method {
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 639635291ab7..44c448269861 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -531,6 +531,7 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 
 	obj_desc->region.address = ACPI_PTR_TO_PHYSADDR(table);
 	obj_desc->region.length = table->length;
+	obj_desc->region.pointer = table;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "RgnObj %p Addr %8.8X%8.8X Len %X\n",
 			  obj_desc,
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index c0cd7147a5a3..8f43d38dc4ca 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -386,7 +386,7 @@ acpi_ev_install_space_handler(struct acpi_namespace_node *node,
 		case ACPI_ADR_SPACE_DATA_TABLE:
 
 			handler = acpi_ex_data_table_space_handler;
-			setup = NULL;
+			setup = acpi_ev_data_table_region_setup;
 			break;
 
 		default:
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 984c172453bf..d28dee929e61 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -406,6 +406,58 @@ acpi_ev_cmos_region_setup(acpi_handle handle,
 	return_ACPI_STATUS(AE_OK);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_data_table_region_setup
+ *
+ * PARAMETERS:  handle              - Region we are interested in
+ *              function            - Start or stop
+ *              handler_context     - Address space handler context
+ *              region_context      - Region specific context
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Setup a data_table_region
+ *
+ * MUTEX:       Assumes namespace is not locked
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ev_data_table_region_setup(acpi_handle handle,
+				u32 function,
+				void *handler_context, void **region_context)
+{
+	union acpi_operand_object *region_desc =
+	    (union acpi_operand_object *)handle;
+	struct acpi_data_table_space_context *local_region_context;
+
+	ACPI_FUNCTION_TRACE(ev_data_table_region_setup);
+
+	if (function == ACPI_REGION_DEACTIVATE) {
+		if (*region_context) {
+			ACPI_FREE(*region_context);
+			*region_context = NULL;
+		}
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Create a new context */
+
+	local_region_context =
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_data_table_space_context));
+	if (!(local_region_context)) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	/* Save the data table pointer for use in the handler */
+
+	local_region_context->pointer = region_desc->region.pointer;
+
+	*region_context = local_region_context;
+	return_ACPI_STATUS(AE_OK);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_default_region_setup
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 80b52ad55775..deb3674ae726 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -279,6 +279,7 @@ acpi_ex_create_region(u8 * aml_start,
 	obj_desc->region.space_id = space_id;
 	obj_desc->region.address = 0;
 	obj_desc->region.length = 0;
+	obj_desc->region.pointer = NULL;
 	obj_desc->region.node = node;
 	obj_desc->region.handler = NULL;
 	obj_desc->common.flags &=
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 82b713a9a193..48c19908fa4e 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -509,8 +509,15 @@ acpi_ex_data_table_space_handler(u32 function,
 				 u64 *value,
 				 void *handler_context, void *region_context)
 {
+	struct acpi_data_table_space_context *mapping;
+	char *pointer;
+
 	ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
 
+	mapping = (struct acpi_data_table_space_context *) region_context;
+	pointer = ACPI_CAST_PTR(char, mapping->pointer) +
+	    (address - ACPI_PTR_TO_PHYSADDR(mapping->pointer));
+
 	/*
 	 * Perform the memory read or write. The bit_width was already
 	 * validated.
@@ -518,14 +525,14 @@ acpi_ex_data_table_space_handler(u32 function,
 	switch (function) {
 	case ACPI_READ:
 
-		memcpy(ACPI_CAST_PTR(char, value),
-		       ACPI_PHYSADDR_TO_PTR(address), ACPI_DIV_8(bit_width));
+		memcpy(ACPI_CAST_PTR(char, value), pointer,
+		       ACPI_DIV_8(bit_width));
 		break;
 
 	case ACPI_WRITE:
 
-		memcpy(ACPI_PHYSADDR_TO_PTR(address),
-		       ACPI_CAST_PTR(char, value), ACPI_DIV_8(bit_width));
+		memcpy(pointer, ACPI_CAST_PTR(char, value),
+		       ACPI_DIV_8(bit_width));
 		break;
 
 	default:
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 248242dca28d..700c2449e85a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1221,6 +1221,10 @@ struct acpi_mem_space_context {
 	struct acpi_mem_mapping *first_mm;
 };
 
+struct acpi_data_table_space_context {
+	void *pointer;
+};
+
 /*
  * struct acpi_memory_list is used only if the ACPICA local cache is enabled
  */
-- 
2.26.2




