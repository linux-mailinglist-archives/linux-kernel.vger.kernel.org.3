Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19047D543
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbhLVQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:43:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbhLVQnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:05 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 781c734b2d430045; Wed, 22 Dec 2021 17:43:04 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 67C4B66AE27;
        Wed, 22 Dec 2021 17:43:03 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 11/19] ACPICA: Add support for PCC Opregion special context data
Date:   Wed, 22 Dec 2021 17:32:54 +0100
Message-ID: <1900496.usQuhbGJ8B@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

ACPICA commit 55526e8a6133cbf5a9cc0fb75a95dbbac6eb98e6

PCC Opregion added in ACPIC 6.3 requires special context data similar
to GPIO and Generic Serial Bus as it needs to know the internal PCC
buffer and its length as well as the PCC channel index when the opregion
handler is being executed by the OSPM.

Lets add support for the special context data needed by PCC Opregion.

Link: https://github.com/acpica/acpica/commit/55526e8a
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evregion.c | 10 ++++++++++
 include/acpi/actypes.h         |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 4ef43c8ef5e7..80b68f216b46 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -162,6 +162,16 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
+		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			struct acpi_pcc_info *ctx =
+			    handler_desc->address_space.context;
+
+			ctx->internal_buffer =
+			    field_obj->field.internal_pcc_buffer;
+			ctx->length = region_obj->region.length;
+			ctx->subspace_id = region_obj->region.address;
+		}
+
 		/*
 		 * We must exit the interpreter because the region setup will
 		 * potentially execute control methods (for example, the _REG method
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 83a7ee1fbd7c..69e89d572b9e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1103,6 +1103,14 @@ struct acpi_connection_info {
 	u8 access_length;
 };
 
+/* Special Context data for PCC Opregion (ACPI 6.3) */
+
+struct acpi_pcc_info {
+	u8 subspace_id;
+	u16 length;
+	u8 *internal_buffer;
+};
+
 typedef
 acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
 				     u32 function,
-- 
2.26.2




