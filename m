Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA14FC498
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349410AbiDKTHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349370AbiDKTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:06:55 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73627B19;
        Mon, 11 Apr 2022 12:04:27 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id c82cba2810d760f0; Mon, 11 Apr 2022 21:04:25 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 116F066BDFD;
        Mon, 11 Apr 2022 21:04:25 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 13/20] ACPICA: Add support for ARM Performance Monitoring Unit Table.
Date:   Mon, 11 Apr 2022 20:58:04 +0200
Message-ID: <3370028.QJadu78ljV@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Besar Wicaksono <bwicaksono@nvidia.com>

ACPICA commit 002165ecc0a3dc703bb24c789aaa02fdada01675

The specification of this table is described in
"ARM Performance Monitoring Unit Architecture 1.0 Platform Design Document"
ARM DEN0117.

This patch adds the necessary types and support for
compiling/disassembling APMT.

Link: https://github.com/acpica/acpica/commit/002165ec
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 actbl2.h |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff -Nurp linux.before_name/include/acpi/actbl2.h linux.after_name/include/acpi/actbl2.h
--- linux.before_name/include/acpi/actbl2.h	2022-04-01 18:26:31.909335052 +0200
+++ linux.after_name/include/acpi/actbl2.h	2022-04-01 18:26:28.746374585 +0200
@@ -25,6 +25,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_AGDI           "AGDI"	/* Arm Generic Diagnostic Dump and Reset Device Interface */
+#define ACPI_SIG_APMT           "APMT"	/* Arm Performance Monitoring Unit table */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
@@ -260,6 +261,85 @@ struct acpi_table_agdi {
 
 /*******************************************************************************
  *
+ * APMT - ARM Performance Monitoring Unit Table
+ *
+ * Conforms to:
+ * ARM Performance Monitoring Unit Architecture 1.0 Platform Design Document
+ * ARM DEN0117 v1.0 November 25, 2021
+ *
+ ******************************************************************************/
+
+struct acpi_table_apmt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+#define ACPI_APMT_NODE_ID_LENGTH                4
+
+/*
+ * APMT subtables
+ */
+struct acpi_apmt_node {
+	u16 length;
+	u8 flags;
+	u8 type;
+	u32 id;
+	u64 inst_primary;
+	u32 inst_secondary;
+	u64 base_address0;
+	u64 base_address1;
+	u32 ovflw_irq;
+	u32 reserved;
+	u32 ovflw_irq_flags;
+	u32 proc_affinity;
+	u32 impl_id;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_APMT_FLAGS_DUAL_PAGE               (1<<0)
+#define ACPI_APMT_FLAGS_AFFINITY                (1<<1)
+#define ACPI_APMT_FLAGS_ATOMIC                  (1<<2)
+
+/* Values for Flags dual page field above */
+
+#define ACPI_APMT_FLAGS_DUAL_PAGE_NSUPP         (0<<0)
+#define ACPI_APMT_FLAGS_DUAL_PAGE_SUPP          (1<<0)
+
+/* Values for Flags processor affinity field above */
+#define ACPI_APMT_FLAGS_AFFINITY_PROC           (0<<1)
+#define ACPI_APMT_FLAGS_AFFINITY_PROC_CONTAINER (1<<1)
+
+/* Values for Flags 64-bit atomic field above */
+#define ACPI_APMT_FLAGS_ATOMIC_NSUPP            (0<<2)
+#define ACPI_APMT_FLAGS_ATOMIC_SUPP             (1<<2)
+
+/* Values for Type field above */
+
+enum acpi_apmt_node_type {
+	ACPI_APMT_NODE_TYPE_MC = 0x00,
+	ACPI_APMT_NODE_TYPE_SMMU = 0x01,
+	ACPI_APMT_NODE_TYPE_PCIE_ROOT = 0x02,
+	ACPI_APMT_NODE_TYPE_ACPI = 0x03,
+	ACPI_APMT_NODE_TYPE_CACHE = 0x04,
+	ACPI_APMT_NODE_TYPE_COUNT
+};
+
+/* Masks for ovflw_irq_flags field above */
+
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE          (1<<0)
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE          (1<<1)
+
+/* Values for ovflw_irq_flags mode field above */
+
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL    (0<<0)
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_EDGE     (1<<0)
+
+/* Values for ovflw_irq_flags type field above */
+
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE_WIRED    (0<<1)
+
+/*******************************************************************************
+ *
  * BDAT - BIOS Data ACPI Table
  *
  * Conforms to "BIOS Data ACPI Table", Interface Specification v4.0 Draft 5



