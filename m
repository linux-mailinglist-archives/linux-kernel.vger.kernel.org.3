Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD75A501A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiH2PVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2PVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:21:49 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED356DAEA;
        Mon, 29 Aug 2022 08:21:47 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id d3c77fd95de3eca7; Mon, 29 Aug 2022 17:21:44 +0200
Received: from kreacher.localnet (public-gprs523165.centertel.pl [31.61.162.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D44B666D25B;
        Mon, 29 Aug 2022 17:21:43 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1] ACPI: PM: Fix NULL argument handling in acpi_device_get/set_power()
Date:   Mon, 29 Aug 2022 17:21:43 +0200
Message-ID: <12062887.O9o76ZdvQC@kreacher>
In-Reply-To: <12036348.O9o76ZdvQC@kreacher>
References: <12036348.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 31.61.162.222
X-CLIENT-HOSTNAME: public-gprs523165.centertel.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeefuddriedurdduiedvrddvvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdeiuddrudeivddrvddvvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghl
 rdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrhesohhrrggtlhgvrdgtohhm
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

In principle, it should be valid to pass NULL as the ACPI device
pointer to acpi_device_get_power() and acpi_device_set_power() and they
both are expected to return -EINVAL in that case, but that has been
broken recently by commit 62fcb99bdf10 ("ACPI: Drop parent field from
struct acpi_device") which has caused the ACPI device pointer to be
dereferenced in these functions before the NULL check.

Fix that and while at it make acpi_device_set_power() only use the
parent field if the target ACPI device object's ignore_parent flag
in not set.

Fixes: 62fcb99bdf10 ("ACPI: Drop parent field from struct acpi_device")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

linux-next material.

---
 drivers/acpi/device_pm.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -74,13 +74,15 @@ static int acpi_dev_pm_explicit_get(stru
  */
 int acpi_device_get_power(struct acpi_device *device, int *state)
 {
-	struct acpi_device *parent = acpi_dev_parent(device);
 	int result = ACPI_STATE_UNKNOWN;
+	struct acpi_device *parent;
 	int error;
 
 	if (!device || !state)
 		return -EINVAL;
 
+	parent = acpi_dev_parent(device);
+
 	if (!device->flags.power_manageable) {
 		/* TBD: Non-recursive algorithm for walking up hierarchy. */
 		*state = parent ? parent->power.state : ACPI_STATE_D0;
@@ -159,7 +161,6 @@ static int acpi_dev_pm_explicit_set(stru
  */
 int acpi_device_set_power(struct acpi_device *device, int state)
 {
-	struct acpi_device *parent = acpi_dev_parent(device);
 	int target_state = state;
 	int result = 0;
 
@@ -192,13 +193,17 @@ int acpi_device_set_power(struct acpi_de
 		return -ENODEV;
 	}
 
-	if (!device->power.flags.ignore_parent && parent &&
-	    state < parent->power.state) {
-		acpi_handle_debug(device->handle,
-				  "Cannot transition to %s for parent in %s\n",
-				  acpi_power_state_string(state),
-				  acpi_power_state_string(parent->power.state));
-		return -ENODEV;
+	if (!device->power.flags.ignore_parent) {
+		struct acpi_device *parent;
+
+		parent = acpi_dev_parent(device);
+		if (parent && state < parent->power.state) {
+			acpi_handle_debug(device->handle,
+					  "Cannot transition to %s for parent in %s\n",
+					  acpi_power_state_string(state),
+					  acpi_power_state_string(parent->power.state));
+			return -ENODEV;
+		}
 	}
 
 	/*



