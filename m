Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653CD47D546
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhLVQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:43:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55534 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbhLVQnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:09 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 2488cfe23c08624f; Wed, 22 Dec 2021 17:43:08 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6CEBC66AE27;
        Wed, 22 Dec 2021 17:43:07 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 09/19] ACPICA: Executer: Fix the REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R()
Date:   Wed, 22 Dec 2021 17:31:05 +0100
Message-ID: <3081602.5fSG56mABF@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

ACPICA commit d984f12041392fa4156b52e2f7e5c5e7bc38ad9e

If Operand[0] is a reference of the ACPI_REFCLASS_REFOF class,
acpi_ex_opcode_1A_0T_1R () calls acpi_ns_get_attached_object () to
obtain return_desc which may require additional resolution with
the help of acpi_ex_read_data_from_field (). If the latter fails,
the reference counter of the original return_desc is decremented
which is incorrect, because acpi_ns_get_attached_object () does not
increment the reference counter of the object returned by it.

This issue may lead to premature deletion of the attached object
while it is still attached and a use-after-free and crash in the
host OS.  For example, this may happen when on evaluation of ref_of()
a local region field where there is no registered handler for the
given Operation Region.

Fix it by making acpi_ex_opcode_1A_0T_1R () return Status right away
after a acpi_ex_read_data_from_field () failure.

Link: https://github.com/acpica/acpica/commit/d984f120
Link: https://github.com/acpica/acpica/pull/685
Reported-by: Lenny Szubowicz <lszubowi@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exoparg1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index b639e930d642..44b7c350ed5c 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -1007,7 +1007,8 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 						    (walk_state, return_desc,
 						     &temp_desc);
 						if (ACPI_FAILURE(status)) {
-							goto cleanup;
+							return_ACPI_STATUS
+							    (status);
 						}
 
 						return_desc = temp_desc;
-- 
2.26.2




