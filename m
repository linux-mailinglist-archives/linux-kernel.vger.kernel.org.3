Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9147D539
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbhLVQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:43:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52066 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbhLVQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:42:56 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 5168d4bf93631b2c; Wed, 22 Dec 2021 17:42:55 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9C53D66AE27;
        Wed, 22 Dec 2021 17:42:54 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 17/19] ACPICA: iASL: Add suppport for AGDI table
Date:   Wed, 22 Dec 2021 17:37:21 +0100
Message-ID: <1779420.atdPhlSkOF@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

ACPICA commit cf36a6d658ca5aa8c329c2edfc3322c095ffd844

Add support for Arm Generic Diagnostic Dump and Reset Interface, which is
described by "ACPI for Arm Components 1.1 Platform Design Document"
ARM DEN0093.

Add the necessary types in the ACPICA header files and support for
compiling and decompiling the table.

Link: https://github.com/acpica/acpica/commit/cf36a6d6
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5ac6ed5696b6..5aba84a0d5dd 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -24,6 +24,7 @@
  * file. Useful because they make it more difficult to inadvertently type in
  * the wrong signature.
  */
+#define ACPI_SIG_AGDI           "AGDI"	/* Arm Generic Diagnostic Dump and Reset Device Interface */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
@@ -238,6 +239,25 @@ typedef struct acpi_aest_node_interrupt {
 #define ACPI_AEST_NODE_ERROR_RECOVERY       1
 #define ACPI_AEST_XRUPT_RESERVED            2	/* 2 and above are reserved */
 
+/*******************************************************************************
+ * AGDI - Arm Generic Diagnostic Dump and Reset Device Interface
+ *
+ * Conforms to "ACPI for Arm Components 1.1, Platform Design Document"
+ * ARM DEN0093 v1.1
+ *
+ ******************************************************************************/
+struct acpi_table_agdi {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 flags;
+	u8 reserved[3];
+	u32 sdei_event;
+	u32 gsiv;
+};
+
+/* Mask for Flags field above */
+
+#define ACPI_AGDI_SIGNALING_MODE (1)
+
 /*******************************************************************************
  *
  * BDAT - BIOS Data ACPI Table
-- 
2.26.2




