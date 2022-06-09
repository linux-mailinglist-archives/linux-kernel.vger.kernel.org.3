Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319C0544EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244769AbiFIOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbiFIOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:20:42 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ACF268544;
        Thu,  9 Jun 2022 07:20:41 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id b3029114fcd8b89a; Thu, 9 Jun 2022 16:20:40 +0200
Received: from kreacher.localnet (unknown [213.134.186.232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4C1D766C7CA;
        Thu,  9 Jun 2022 16:20:39 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 10/16] ACPI: bus: Introduce acpi_dev_for_each_child_reverse()
Date:   Thu, 09 Jun 2022 16:06:21 +0200
Message-ID: <2137459.Mh6RI2rZIc@kreacher>
In-Reply-To: <1843211.tdWV9SEqCh@kreacher>
References: <1843211.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.186.232
X-CLIENT-HOSTNAME: 213.134.186.232
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekiedrvdefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make it possible to walk the children of an ACPI device in the revese
order by defining acpi_dev_for_each_child_reverse() in analogy with
acpi_dev_for_each_child().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c      |   13 +++++++++++++
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 16 insertions(+)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -1115,6 +1115,19 @@ int acpi_dev_for_each_child(struct acpi_
 	return device_for_each_child(&adev->dev, &adwc, acpi_dev_for_one_check);
 }
 
+int acpi_dev_for_each_child_reverse(struct acpi_device *adev,
+				    int (*fn)(struct acpi_device *, void *),
+				    void *data)
+{
+	struct acpi_dev_walk_context adwc = {
+		.fn = fn,
+		.data = data,
+	};
+
+	return device_for_each_child_reverse(&adev->dev, &adwc,
+					     acpi_dev_for_one_check);
+}
+
 /* --------------------------------------------------------------------------
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -483,6 +483,9 @@ extern struct bus_type acpi_bus_type;
 int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data);
 int acpi_dev_for_each_child(struct acpi_device *adev,
 			    int (*fn)(struct acpi_device *, void *), void *data);
+int acpi_dev_for_each_child_reverse(struct acpi_device *adev,
+				    int (*fn)(struct acpi_device *, void *),
+				    void *data);
 
 /*
  * Events



