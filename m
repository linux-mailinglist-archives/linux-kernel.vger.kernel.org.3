Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF948CB06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbiALSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:31:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59570 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356231AbiALSbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:31:51 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id ff3f166587abe54b; Wed, 12 Jan 2022 19:31:49 +0100
Received: from kreacher.localnet (unknown [213.134.181.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3EDB766B132;
        Wed, 12 Jan 2022 19:31:49 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@gmail.com>
Subject: [PATCH] ACPI: OSL: Fix and clean up acpi_os_read/write_port()
Date:   Wed, 12 Jan 2022 19:31:48 +0100
Message-ID: <1809721.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.123
X-CLIENT-HOSTNAME: 213.134.181.123
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrtddugdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddukedurdduvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddruddvfedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehgmhgrihhlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

First, remove type casts that make acpi_os_read_port() only work on
little endian and are generally not needed.

Second, avoid clearing the memory pointed to by the value return
pointer in acpi_os_read_port() if it is the dummy on the stack (in
which case clearing it is not necessary).

Finally, prevent both acpi_os_read_port() and acpi_os_write_port()
from crashing the kernel when they receive an unsupported width
value and make them print a debug message and return an error instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -642,22 +642,24 @@ u64 acpi_os_get_timer(void)
 		(ACPI_100NSEC_PER_SEC / HZ);
 }
 
-acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)
+acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 width)
 {
 	u32 dummy;
 
-	if (!value)
+	if (value)
+		*value = 0;
+	else
 		value = &dummy;
 
-	*value = 0;
 	if (width <= 8) {
-		*(u8 *) value = inb(port);
+		*value = inb(port);
 	} else if (width <= 16) {
-		*(u16 *) value = inw(port);
+		*value = inw(port);
 	} else if (width <= 32) {
-		*(u32 *) value = inl(port);
+		*value = inl(port);
 	} else {
-		BUG();
+		pr_debug("%s: Access width %d not supported\n", __func__, width);
+		return AE_BAD_PARAMETER;
 	}
 
 	return AE_OK;
@@ -674,7 +676,8 @@ acpi_status acpi_os_write_port(acpi_io_a
 	} else if (width <= 32) {
 		outl(value, port);
 	} else {
-		BUG();
+		pr_debug("%s: Access width %d not supported\n", __func__, width);
+		return AE_BAD_PARAMETER;
 	}
 
 	return AE_OK;



