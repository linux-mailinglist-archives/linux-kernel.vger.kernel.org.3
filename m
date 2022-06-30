Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED2E5621DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiF3SOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiF3SN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:13:59 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED2B3DDD0;
        Thu, 30 Jun 2022 11:13:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id ad8ed56b92f73f43; Thu, 30 Jun 2022 20:13:54 +0200
Received: from kreacher.localnet (unknown [213.134.175.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A4C8966CA52;
        Thu, 30 Jun 2022 20:13:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
Date:   Thu, 30 Jun 2022 20:13:52 +0200
Message-ID: <5606189.DvuYhMxLoT@kreacher>
In-Reply-To: <2657553.mvXUDI8C0e@kreacher>
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.198
X-CLIENT-HOSTNAME: 213.134.175.198
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudejhedrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduleekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhgrghrrhihsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhht
 vghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
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
Subject: [PATCH] hisi_lpc: Use acpi_dev_for_each_child()

Instead of walking the list of children of an ACPI device directly,
use acpi_dev_for_each_child() to carry out an action for all of
the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

While at it, simplify hisi_lpc_acpi_set_io_res() by making it accept
a struct acpi_device pointer from the caller, instead of going to
struct device and back to get the same result, and clean up confusion
regarding hostdev and its ACPI companion in that function.

Also remove a redundant check from it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 
v2 -> v3:
   * Also cover hisi_lpc_acpi_probe() which has triggered additional
     changes.
   * Drop the ACK as new material was added.

-> v2:
   * Drop unused local variable (John).
   * Add ACK from John.

---
 drivers/bus/hisi_lpc.c |  201 +++++++++++++++++++++++--------------------------
 1 file changed, 98 insertions(+), 103 deletions(-)

Index: linux-pm/drivers/bus/hisi_lpc.c
===================================================================
--- linux-pm.orig/drivers/bus/hisi_lpc.c
+++ linux-pm/drivers/bus/hisi_lpc.c
@@ -379,7 +379,7 @@ static void hisi_lpc_acpi_fixup_child_re
 
 /*
  * hisi_lpc_acpi_set_io_res - set the resources for a child
- * @child: the device node to be updated the I/O resource
+ * @adev: ACPI companion of the device node to be updated the I/O resource
  * @hostdev: the device node associated with host controller
  * @res: double pointer to be set to the address of translated resources
  * @num_res: pointer to variable to hold the number of translated resources
@@ -390,31 +390,24 @@ static void hisi_lpc_acpi_fixup_child_re
  * host-relative address resource.  This function will return the translated
  * logical PIO addresses for each child devices resources.
  */
-static int hisi_lpc_acpi_set_io_res(struct device *child,
+static int hisi_lpc_acpi_set_io_res(struct acpi_device *adev,
 				    struct device *hostdev,
 				    const struct resource **res, int *num_res)
 {
-	struct acpi_device *adev;
-	struct acpi_device *host;
+	struct acpi_device *host = to_acpi_device(adev->dev.parent);
 	struct resource_entry *rentry;
 	LIST_HEAD(resource_list);
 	struct resource *resources;
 	int count;
 	int i;
 
-	if (!child || !hostdev)
-		return -EINVAL;
-
-	host = to_acpi_device(hostdev);
-	adev = to_acpi_device(child);
-
 	if (!adev->status.present) {
-		dev_dbg(child, "device is not present\n");
+		dev_dbg(&adev->dev, "device is not present\n");
 		return -EIO;
 	}
 
 	if (acpi_device_enumerated(adev)) {
-		dev_dbg(child, "has been enumerated\n");
+		dev_dbg(&adev->dev, "has been enumerated\n");
 		return -EIO;
 	}
 
@@ -425,7 +418,7 @@ static int hisi_lpc_acpi_set_io_res(stru
 	 */
 	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
 	if (count <= 0) {
-		dev_dbg(child, "failed to get resources\n");
+		dev_dbg(&adev->dev, "failed to get resources\n");
 		return count ? count : -EIO;
 	}
 
@@ -454,7 +447,7 @@ static int hisi_lpc_acpi_set_io_res(stru
 			continue;
 		ret = hisi_lpc_acpi_xlat_io_res(adev, host, &resources[i]);
 		if (ret) {
-			dev_err(child, "translate IO range %pR failed (%d)\n",
+			dev_err(&adev->dev, "translate IO range %pR failed (%d)\n",
 				&resources[i], ret);
 			return ret;
 		}
@@ -471,6 +464,12 @@ static int hisi_lpc_acpi_remove_subdev(s
 	return 0;
 }
 
+static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_used)
+{
+	acpi_device_clear_enumerated(adev);
+	return 0;
+}
+
 struct hisi_lpc_acpi_cell {
 	const char *hid;
 	const char *name;
@@ -480,13 +479,89 @@ struct hisi_lpc_acpi_cell {
 
 static void hisi_lpc_acpi_remove(struct device *hostdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(hostdev);
-	struct acpi_device *child;
-
 	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
+	acpi_dev_for_each_child(ACPI_COMPANION(hostdev),
+				hisi_lpc_acpi_clear_enumerated, NULL);
+}
+
+static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
+{
+	const char *hid = acpi_device_hid(child);
+	struct device *hostdev = data;
+	const struct hisi_lpc_acpi_cell *cell;
+	struct platform_device *pdev;
+	const struct resource *res;
+	bool found = false;
+	int num_res;
+	int ret;
+
+	ret = hisi_lpc_acpi_set_io_res(child, hostdev, &res, &num_res);
+	if (ret) {
+		dev_warn(hostdev, "set resource fail (%d)\n", ret);
+		return ret;
+	}
+
+	cell = (struct hisi_lpc_acpi_cell []){
+		/* ipmi */
+		{
+			.hid = "IPI0001",
+			.name = "hisi-lpc-ipmi",
+		},
+		/* 8250-compatible uart */
+		{
+			.hid = "HISI1031",
+			.name = "serial8250",
+			.pdata = (struct plat_serial8250_port []) {
+				{
+					.iobase = res->start,
+					.uartclk = 1843200,
+					.iotype = UPIO_PORT,
+					.flags = UPF_BOOT_AUTOCONF,
+				},
+				{}
+			},
+			.pdata_size = 2 *
+				sizeof(struct plat_serial8250_port),
+		},
+		{}
+	};
+
+	for (; cell && cell->name; cell++) {
+		if (!strcmp(cell->hid, hid)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_warn(hostdev,
+			 "could not find cell for child device (%s), discarding\n",
+			 hid);
+		return 0;
+	}
+
+	pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = hostdev;
+	ACPI_COMPANION_SET(&pdev->dev, child);
+
+	ret = platform_device_add_resources(pdev, res, num_res);
+	if (ret)
+		return ret;
+
+	ret = platform_device_add_data(pdev, cell->pdata, cell->pdata_size);
+	if (ret)
+		return ret;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ret;
 
-	list_for_each_entry(child, &adev->children, node)
-		acpi_device_clear_enumerated(child);
+	acpi_device_set_enumerated(child);
+
+	return 0;
 }
 
 /*
@@ -501,94 +576,14 @@ static void hisi_lpc_acpi_remove(struct
  */
 static int hisi_lpc_acpi_probe(struct device *hostdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(hostdev);
-	struct acpi_device *child;
 	int ret;
 
 	/* Only consider the children of the host */
-	list_for_each_entry(child, &adev->children, node) {
-		const char *hid = acpi_device_hid(child);
-		const struct hisi_lpc_acpi_cell *cell;
-		struct platform_device *pdev;
-		const struct resource *res;
-		bool found = false;
-		int num_res;
-
-		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev, &res,
-					       &num_res);
-		if (ret) {
-			dev_warn(hostdev, "set resource fail (%d)\n", ret);
-			goto fail;
-		}
-
-		cell = (struct hisi_lpc_acpi_cell []){
-			/* ipmi */
-			{
-				.hid = "IPI0001",
-				.name = "hisi-lpc-ipmi",
-			},
-			/* 8250-compatible uart */
-			{
-				.hid = "HISI1031",
-				.name = "serial8250",
-				.pdata = (struct plat_serial8250_port []) {
-					{
-						.iobase = res->start,
-						.uartclk = 1843200,
-						.iotype = UPIO_PORT,
-						.flags = UPF_BOOT_AUTOCONF,
-					},
-					{}
-				},
-				.pdata_size = 2 *
-					sizeof(struct plat_serial8250_port),
-			},
-			{}
-		};
-
-		for (; cell && cell->name; cell++) {
-			if (!strcmp(cell->hid, hid)) {
-				found = true;
-				break;
-			}
-		}
-
-		if (!found) {
-			dev_warn(hostdev,
-				 "could not find cell for child device (%s), discarding\n",
-				 hid);
-			continue;
-		}
-
-		pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
-		if (!pdev) {
-			ret = -ENOMEM;
-			goto fail;
-		}
-
-		pdev->dev.parent = hostdev;
-		ACPI_COMPANION_SET(&pdev->dev, child);
-
-		ret = platform_device_add_resources(pdev, res, num_res);
-		if (ret)
-			goto fail;
-
-		ret = platform_device_add_data(pdev, cell->pdata,
-					       cell->pdata_size);
-		if (ret)
-			goto fail;
-
-		ret = platform_device_add(pdev);
-		if (ret)
-			goto fail;
-
-		acpi_device_set_enumerated(child);
-	}
-
-	return 0;
+	ret = acpi_dev_for_each_child(ACPI_COMPANION(hostdev),
+				      hisi_lpc_acpi_add_child, hostdev);
+	if (ret)
+		hisi_lpc_acpi_remove(hostdev);
 
-fail:
-	hisi_lpc_acpi_remove(hostdev);
 	return ret;
 }
 



