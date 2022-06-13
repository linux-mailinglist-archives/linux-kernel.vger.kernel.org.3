Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B10549E62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbiFMUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbiFMUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:05:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC7BCE95;
        Mon, 13 Jun 2022 11:40:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id c96cbc3b82aed3ce; Mon, 13 Jun 2022 20:40:47 +0200
Received: from kreacher.localnet (unknown [213.134.187.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2CFBC66C81D;
        Mon, 13 Jun 2022 20:40:46 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 05/16] USB: ACPI: Replace usb_acpi_find_port() with acpi_find_child_by_adr()
Date:   Mon, 13 Jun 2022 20:39:37 +0200
Message-ID: <23334378.ouqheUzb2q@kreacher>
In-Reply-To: <2653857.mvXUDI8C0e@kreacher>
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.64
X-CLIENT-HOSTNAME: 213.134.187.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddujedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekjedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of walking the list of children of an ACPI device directly
in order to find the child matching a given bus address, use
acpi_find_child_by_adr() for this purpose.

Also notice that if acpi_find_child_by_adr() doesn't find a matching
child, acpi_find_child_device() will not find it too, so directly
replace usb_acpi_find_port() in usb_acpi_get_companion_for_port() with
acpi_find_child_by_adr() and drop it entirely.

Apart from simplifying the code, this will help to eliminate the
children list head from struct acpi_device as it is redundant and it
is used in questionable ways in some places (in particular, locking is
needed for walking the list pointed to it safely, but it is often
missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Drop usb_acpi_find_port() (Heikki, Andy).
   * Change the subject accordingly.

---
 drivers/usb/core/usb-acpi.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

Index: linux-pm/drivers/usb/core/usb-acpi.c
===================================================================
--- linux-pm.orig/drivers/usb/core/usb-acpi.c
+++ linux-pm/drivers/usb/core/usb-acpi.c
@@ -124,22 +124,6 @@ out:
  */
 #define USB_ACPI_LOCATION_VALID (1 << 31)
 
-static struct acpi_device *usb_acpi_find_port(struct acpi_device *parent,
-					      int raw)
-{
-	struct acpi_device *adev;
-
-	if (!parent)
-		return NULL;
-
-	list_for_each_entry(adev, &parent->children, node) {
-		if (acpi_device_adr(adev) == raw)
-			return adev;
-	}
-
-	return acpi_find_child_device(parent, raw, false);
-}
-
 static struct acpi_device *
 usb_acpi_get_companion_for_port(struct usb_port *port_dev)
 {
@@ -170,7 +154,7 @@ usb_acpi_get_companion_for_port(struct u
 		port1 = port_dev->portnum;
 	}
 
-	return usb_acpi_find_port(adev, port1);
+	return acpi_find_child_by_adr(adev, port1);
 }
 
 static struct acpi_device *



