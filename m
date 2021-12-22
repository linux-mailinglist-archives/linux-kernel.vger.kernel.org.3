Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8622247D53B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbhLVQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:43:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50896 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbhLVQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:42:58 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 74105cbce4e00d1d; Wed, 22 Dec 2021 17:42:57 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 93C3F66AE27;
        Wed, 22 Dec 2021 17:42:56 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 16/19] ACPICA: iASL: Add TDEL table to both compiler/disassembler
Date:   Wed, 22 Dec 2021 17:36:30 +0100
Message-ID: <3585525.MHq7AAxBmi@kreacher>
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

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 403f9965aba7ff9d2ed5b41bbffdd2a1ed0f596f

Added struct acpi_pcc_info to acpi_src.

Link: https://github.com/acpica/acpica/commit/403f9965
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index db0074a3c193..5ac6ed5696b6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -48,6 +48,7 @@
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
+#define ACPI_SIG_TDEL           "TDEL"	/* TD Event Log Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -2487,6 +2488,22 @@ enum acpi_svkl_format {
 	ACPI_SVKL_FORMAT_RESERVED = 1	/* 1 and greater are reserved */
 };
 
+/*******************************************************************************
+ *
+ * TDEL - TD-Event Log
+ *        From: "Guest-Host-Communication Interface (GHCI) for Intel
+ *        Trust Domain Extensions (Intel TDX)".
+ *        September 2020
+ *
+ ******************************************************************************/
+
+struct acpi_table_tdel {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 reserved;
+	u64 log_area_minimum_length;
+	u64 log_area_start_address;
+};
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.26.2




