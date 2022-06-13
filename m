Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA3549E88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350646AbiFMUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350353AbiFMUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:06:53 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F4BDA05;
        Mon, 13 Jun 2022 11:41:01 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 7b450178e79b911c; Mon, 13 Jun 2022 20:41:00 +0200
Received: from kreacher.localnet (unknown [213.134.187.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2C49666C81D;
        Mon, 13 Jun 2022 20:40:59 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 09/16] ACPI: video: Use acpi_dev_for_each_child()
Date:   Mon, 13 Jun 2022 20:26:28 +0200
Message-ID: <3636322.MHq7AAxBmi@kreacher>
In-Reply-To: <2653857.mvXUDI8C0e@kreacher>
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.64
X-CLIENT-HOSTNAME: 213.134.187.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddujedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekjedrieegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomh
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

Instead of walking the list of children of an ACPI device directly,
use acpi_dev_for_each_child() to carry out an action for all of
the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v1 -> v2:
   * Do not break the acpi_dev_for_each_child() call line (Andy).
   * Add R-by from Andy.

---
 drivers/acpi/acpi_video.c |   41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/acpi/acpi_video.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_video.c
+++ linux-pm/drivers/acpi/acpi_video.c
@@ -1149,24 +1149,25 @@ acpi_video_get_device_type(struct acpi_v
 	return 0;
 }
 
-static int
-acpi_video_bus_get_one_device(struct acpi_device *device,
-			      struct acpi_video_bus *video)
+static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 {
-	unsigned long long device_id;
-	int status, device_type;
-	struct acpi_video_device *data;
+	struct acpi_video_bus *video = arg;
 	struct acpi_video_device_attrib *attribute;
+	struct acpi_video_device *data;
+	unsigned long long device_id;
+	acpi_status status;
+	int device_type;
 
-	status =
-	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
-	/* Some device omits _ADR, we skip them instead of fail */
+	status = acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
+	/* Skip devices without _ADR instead of failing. */
 	if (ACPI_FAILURE(status))
-		return 0;
+		goto exit;
 
 	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		dev_dbg(&device->dev, "Cannot attach\n");
 		return -ENOMEM;
+	}
 
 	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
@@ -1226,7 +1227,9 @@ acpi_video_bus_get_one_device(struct acp
 	list_add_tail(&data->entry, &video->video_device_list);
 	mutex_unlock(&video->device_list_lock);
 
-	return status;
+exit:
+	video->child_count++;
+	return 0;
 }
 
 /*
@@ -1538,9 +1541,6 @@ static int
 acpi_video_bus_get_devices(struct acpi_video_bus *video,
 			   struct acpi_device *device)
 {
-	int status = 0;
-	struct acpi_device *dev;
-
 	/*
 	 * There are systems where video module known to work fine regardless
 	 * of broken _DOD and ignoring returned value here doesn't cause
@@ -1548,16 +1548,7 @@ acpi_video_bus_get_devices(struct acpi_v
 	 */
 	acpi_video_device_enumerate(video);
 
-	list_for_each_entry(dev, &device->children, node) {
-
-		status = acpi_video_bus_get_one_device(dev, video);
-		if (status) {
-			dev_err(&dev->dev, "Can't attach device\n");
-			break;
-		}
-		video->child_count++;
-	}
-	return status;
+	return acpi_dev_for_each_child(device, acpi_video_bus_get_one_device, video);
 }
 
 /* acpi_video interface */



