Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1C549E96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbiFMUIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbiFMUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:07:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCD5BD1D;
        Mon, 13 Jun 2022 11:41:07 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id a4edbe782fab070e; Mon, 13 Jun 2022 20:41:06 +0200
Received: from kreacher.localnet (unknown [213.134.187.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0589866C81D;
        Mon, 13 Jun 2022 20:41:04 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port() with acpi_find_child_by_adr()
Date:   Mon, 13 Jun 2022 20:11:36 +0200
Message-ID: <2851774.e9J7NaK4W3@kreacher>
In-Reply-To: <2653857.mvXUDI8C0e@kreacher>
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.64
X-CLIENT-HOSTNAME: 213.134.187.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddujedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekjedrieegnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrvggrshdrnhhovghvvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlhdrtghomhdprhgtphhtthhopegjvghhvgiikhgvlhfuhheusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghikhhkihdrkhhrohhgvghruhhssehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use acpi_find_child_by_adr() to find the child matching a given bus
address instead of tb_acpi_find_port() that walks the list of children
of an ACPI device directly for this purpose and drop the latter.

Apart from simplifying the code, this will help to eliminate the
children list head from struct acpi_device as it is redundant and it
is used in questionable ways in some places (in particular, locking is
needed for walking the list pointed to it safely, but it is often
missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Drop tb_acpi_find_port() (Heikki, Andy).
   * Change the subject accordingly

---
 drivers/thunderbolt/acpi.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/thunderbolt/acpi.c
===================================================================
--- linux-pm.orig/drivers/thunderbolt/acpi.c
+++ linux-pm/drivers/thunderbolt/acpi.c
@@ -301,26 +301,6 @@ static bool tb_acpi_bus_match(struct dev
 	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
 }
 
-static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
-					     const struct tb_port *port)
-{
-	struct acpi_device *port_adev;
-
-	if (!adev)
-		return NULL;
-
-	/*
-	 * Device routers exists under the downstream facing USB4 port
-	 * of the parent router. Their _ADR is always 0.
-	 */
-	list_for_each_entry(port_adev, &adev->children, node) {
-		if (acpi_device_adr(port_adev) == port->port)
-			return port_adev;
-	}
-
-	return NULL;
-}
-
 static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
 {
 	struct acpi_device *adev = NULL;
@@ -331,7 +311,8 @@ static struct acpi_device *tb_acpi_switc
 		struct tb_port *port = tb_port_at(tb_route(sw), parent_sw);
 		struct acpi_device *port_adev;
 
-		port_adev = tb_acpi_find_port(ACPI_COMPANION(&parent_sw->dev), port);
+		port_adev = acpi_find_child_by_adr(ACPI_COMPANION(&parent_sw->dev),
+						   port->port);
 		if (port_adev)
 			adev = acpi_find_child_device(port_adev, 0, false);
 	} else {
@@ -364,8 +345,8 @@ static struct acpi_device *tb_acpi_find_
 	if (tb_is_switch(dev))
 		return tb_acpi_switch_find_companion(tb_to_switch(dev));
 	else if (tb_is_usb4_port_device(dev))
-		return tb_acpi_find_port(ACPI_COMPANION(dev->parent),
-					 tb_to_usb4_port_device(dev)->port);
+		return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
+					      tb_to_usb4_port_device(dev)->port->port);
 	return NULL;
 }
 



