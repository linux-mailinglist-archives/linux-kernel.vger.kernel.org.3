Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7554B16AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiBJUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:05:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiBJUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:05:37 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14726F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:05:37 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id b2f2cd1e5498de8e; Thu, 10 Feb 2022 21:05:35 +0100
Received: from kreacher.localnet (unknown [213.134.175.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BBC2266B514;
        Thu, 10 Feb 2022 21:05:34 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.co>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI: scan: Use ida_alloc() instead of ida_simple_get()
Date:   Thu, 10 Feb 2022 21:05:33 +0100
Message-ID: <2645186.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.120
X-CLIENT-HOSTNAME: 213.134.175.120
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddriedugddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudejhedruddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduvddtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghl
 rdgtohhm
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

As recommended in include/linux/idr.h, use ida_alloc() instead of
ida_simple_get() for creating unique device object names and for
symmetry replace ida_simple_remove() with ida_free() (and fix up
the related overly long code line while at it).

Also drop the ACPI_MAX_DEVICE_INSTANCES limit that is not necessary
any more and may not be sufficient for future platforms.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    2 --
 drivers/acpi/scan.c     |    5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -96,8 +96,6 @@ void acpi_scan_table_notify(void);
 
 extern struct list_head acpi_bus_id_list;
 
-#define ACPI_MAX_DEVICE_INSTANCES	4096
-
 struct acpi_device_bus_id {
 	const char *bus_id;
 	struct ida instance_ida;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -477,7 +477,8 @@ static void acpi_device_del(struct acpi_
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
 		if (!strcmp(acpi_device_bus_id->bus_id,
 			    acpi_device_hid(device))) {
-			ida_simple_remove(&acpi_device_bus_id->instance_ida, device->pnp.instance_no);
+			ida_free(&acpi_device_bus_id->instance_ida,
+				 device->pnp.instance_no);
 			if (ida_is_empty(&acpi_device_bus_id->instance_ida)) {
 				list_del(&acpi_device_bus_id->node);
 				kfree_const(acpi_device_bus_id->bus_id);
@@ -642,7 +643,7 @@ static int acpi_device_set_name(struct a
 	struct ida *instance_ida = &acpi_device_bus_id->instance_ida;
 	int result;
 
-	result = ida_simple_get(instance_ida, 0, ACPI_MAX_DEVICE_INSTANCES, GFP_KERNEL);
+	result = ida_alloc(instance_ida, GFP_KERNEL);
 	if (result < 0)
 		return result;
 



