Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55E84C026B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiBVTwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiBVTwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:52:16 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48CDBA773;
        Tue, 22 Feb 2022 11:51:47 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id cf53e28505fb3333; Tue, 22 Feb 2022 20:51:45 +0100
Received: from kreacher.localnet (unknown [213.134.162.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C49C666B786;
        Tue, 22 Feb 2022 20:51:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ACPI: bus: Introduce acpi_bus_for_each_dev()
Date:   Tue, 22 Feb 2022 20:51:42 +0100
Message-ID: <11943345.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.33
X-CLIENT-HOSTNAME: 213.134.162.33
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrkeekgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrfeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhg
 pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to avoid exposing acpi_bus_type to modules, introduce an
acpi_bus_for_each_dev() helper for iterating over all ACPI device
objects and make typec_link_ports() use it instead of the raw
bus_for_each_dev() along with acpi_bus_type.

Having done that, drop the acpi_bus_type export.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c              |    7 ++++++-
 drivers/usb/typec/port-mapper.c |    2 +-
 include/acpi/acpi_bus.h         |    2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -1043,7 +1043,12 @@ struct bus_type acpi_bus_type = {
 	.remove		= acpi_device_remove,
 	.uevent		= acpi_device_uevent,
 };
-EXPORT_SYMBOL_GPL(acpi_bus_type);
+
+int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data)
+{
+	return bus_for_each_dev(&acpi_bus_type, NULL, data, fn);
+}
+EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
 
 /* --------------------------------------------------------------------------
                              Initialization/Cleanup
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -480,6 +480,8 @@ void acpi_initialize_hp_context(struct a
 /* acpi_device.dev.bus == &acpi_bus_type */
 extern struct bus_type acpi_bus_type;
 
+int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data);
+
 /*
  * Events
  * ------
Index: linux-pm/drivers/usb/typec/port-mapper.c
===================================================================
--- linux-pm.orig/drivers/usb/typec/port-mapper.c
+++ linux-pm/drivers/usb/typec/port-mapper.c
@@ -59,7 +59,7 @@ int typec_link_ports(struct typec_port *
 	if (!has_acpi_companion(&con->dev))
 		return 0;
 
-	bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);
+	acpi_bus_for_each_dev(typec_port_match, &arg);
 	if (!arg.match)
 		return 0;
 



