Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15249544ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbiFIOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245384AbiFIOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:20:58 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619442DC23B;
        Thu,  9 Jun 2022 07:20:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 330dda50aaa89be6; Thu, 9 Jun 2022 16:20:53 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DA8F066C7CA;
        Thu,  9 Jun 2022 16:20:51 +0200 (CEST)
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
Subject: [PATCH v1 05/16] USB: ACPI: Use acpi_find_child_by_adr()
Date:   Thu, 09 Jun 2022 15:56:42 +0200
Message-ID: <3459925.iIbC2pHGDl@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
 ihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehhvghikhhkihdrkhhrohhgvghruhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

Apart from simplifying the code, this will help to eliminate the
children list head from struct acpi_device as it is redundant and it
is used in questionable ways in some places (in particular, locking is
needed for walking the list pointed to it safely, but it is often
missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/usb/core/usb-acpi.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux-pm/drivers/usb/core/usb-acpi.c
===================================================================
--- linux-pm.orig/drivers/usb/core/usb-acpi.c
+++ linux-pm/drivers/usb/core/usb-acpi.c
@@ -127,17 +127,10 @@ out:
 static struct acpi_device *usb_acpi_find_port(struct acpi_device *parent,
 					      int raw)
 {
-	struct acpi_device *adev;
-
 	if (!parent)
 		return NULL;
 
-	list_for_each_entry(adev, &parent->children, node) {
-		if (acpi_device_adr(adev) == raw)
-			return adev;
-	}
-
-	return acpi_find_child_device(parent, raw, false);
+	return acpi_find_child_by_adr(parent, raw);
 }
 
 static struct acpi_device *



