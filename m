Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0A4F4C46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577829AbiDEXRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457915AbiDEQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:59:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618B4A915;
        Tue,  5 Apr 2022 09:57:13 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 742f0ee565e3f865; Tue, 5 Apr 2022 18:57:12 +0200
Received: from kreacher.localnet (unknown [213.134.181.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8220B66BCB7;
        Tue,  5 Apr 2022 18:57:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH v1] ACPI: bus: Eliminate acpi_bus_get_device()
Date:   Tue, 05 Apr 2022 18:57:10 +0200
Message-ID: <5817980.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.136
X-CLIENT-HOSTNAME: 213.134.181.136
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddukedurddufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddrudefiedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the last instance of acpi_bus_get_device(), added recently
by commit 87e59b36e5e2 ("spi: Support selection of the index of the
ACPI Spi Resource before alloc"), with acpi_fetch_acpi_dev() and
finally drop acpi_bus_get_device() that has no more users.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     |   13 -------------
 drivers/spi/spi.c       |    3 ++-
 include/acpi/acpi_bus.h |    1 -
 3 files changed, 2 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/spi/spi.c
===================================================================
--- linux-pm.orig/drivers/spi/spi.c
+++ linux-pm/drivers/spi/spi.c
@@ -2406,7 +2406,8 @@ static int acpi_spi_add_resource(struct
 			} else {
 				struct acpi_device *adev;
 
-				if (acpi_bus_get_device(parent_handle, &adev))
+				adev = acpi_fetch_acpi_dev(parent_handle);
+				if (!adev)
 					return -ENODEV;
 
 				ctlr = acpi_spi_find_controller_by_adev(adev);
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -511,7 +511,6 @@ extern int unregister_acpi_notifier(stru
  * External Functions
  */
 
-int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device);
 struct acpi_device *acpi_fetch_acpi_dev(acpi_handle handle);
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 				       unsigned long long *sta);
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -588,19 +588,6 @@ static struct acpi_device *handle_to_dev
 	return adev;
 }
 
-int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
-{
-	if (!device)
-		return -EINVAL;
-
-	*device = handle_to_device(handle, NULL);
-	if (!*device)
-		return -ENODEV;
-
-	return 0;
-}
-EXPORT_SYMBOL(acpi_bus_get_device);
-
 /**
  * acpi_fetch_acpi_dev - Retrieve ACPI device object.
  * @handle: ACPI handle associated with the requested ACPI device object.



