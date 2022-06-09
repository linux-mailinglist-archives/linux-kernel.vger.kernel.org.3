Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD8544EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245569AbiFIOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245655AbiFIOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:21:06 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7FC2E13D2;
        Thu,  9 Jun 2022 07:20:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id c3a7326d8af07279; Thu, 9 Jun 2022 16:20:58 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DC2F666C7CA;
        Thu,  9 Jun 2022 16:20:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 03/16] ACPI: glue: Introduce acpi_find_child_by_adr()
Date:   Thu, 09 Jun 2022 15:54:27 +0200
Message-ID: <21517452.EfDdHjke4D@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rearrange the ACPI device lookup code used internally by
acpi_find_child_device() so it can avoid extra checks after finding
one object with a matching _ADR and use it for defining
acpi_find_child_by_adr() that will allow the callers to find a given
ACPI device's child matching a given bus address without doing any
other checks in check_one_child().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c     |   28 ++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |    2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -622,6 +622,8 @@ static inline int acpi_dma_configure(str
 }
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children);
+struct acpi_device *acpi_find_child_by_adr(struct acpi_device *adev,
+					   acpi_bus_address adr);
 int acpi_is_root_bridge(acpi_handle);
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
 
Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -119,6 +119,7 @@ struct find_child_walk_data {
 	struct acpi_device *adev;
 	u64 address;
 	int score;
+	bool check_sta;
 	bool check_children;
 };
 
@@ -131,9 +132,13 @@ static int check_one_child(struct acpi_d
 		return 0;
 
 	if (!wd->adev) {
-		/* This is the first matching object.  Save it and continue. */
+		/*
+		 * This is the first matching object, so save it.  If it is not
+		 * necessary to look for any other matching objects, stop the
+		 * search.
+		 */
 		wd->adev = adev;
-		return 0;
+		return !(wd->check_sta || wd->check_children);
 	}
 
 	/*
@@ -169,12 +174,14 @@ static int check_one_child(struct acpi_d
 	return 0;
 }
 
-struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
-					   u64 address, bool check_children)
+static struct acpi_device *acpi_find_child(struct acpi_device *parent,
+					   u64 address, bool check_children,
+					   bool check_sta)
 {
 	struct find_child_walk_data wd = {
 		.address = address,
 		.check_children = check_children,
+		.check_sta = check_sta,
 		.adev = NULL,
 		.score = 0,
 	};
@@ -184,8 +191,21 @@ struct acpi_device *acpi_find_child_devi
 
 	return wd.adev;
 }
+
+struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
+					   u64 address, bool check_children)
+{
+	return acpi_find_child(parent, address, check_children, true);
+}
 EXPORT_SYMBOL_GPL(acpi_find_child_device);
 
+struct acpi_device *acpi_find_child_by_adr(struct acpi_device *adev,
+					   acpi_bus_address adr)
+{
+	return acpi_find_child(adev, adr, false, false);
+}
+EXPORT_SYMBOL_GPL(acpi_find_child_by_adr);
+
 static void acpi_physnode_link_name(char *buf, unsigned int node_id)
 {
 	if (node_id > 0)



