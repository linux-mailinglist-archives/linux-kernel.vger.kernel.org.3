Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8F5601AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiF2Nrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiF2NrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:47:25 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD8167FB;
        Wed, 29 Jun 2022 06:47:24 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 882d24b02468b0e9; Wed, 29 Jun 2022 15:47:23 +0200
Received: from kreacher.localnet (unknown [213.134.175.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4DE9566C9DE;
        Wed, 29 Jun 2022 15:47:22 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        john.garry@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] hisi_lpc: Use acpi_dev_for_each_child()
Date:   Wed, 29 Jun 2022 15:47:21 +0200
Message-ID: <2657553.mvXUDI8C0e@kreacher>
In-Reply-To: <12026357.O9o76ZdvQC@kreacher>
References: <12026357.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.150
X-CLIENT-HOSTNAME: 213.134.175.150
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddujeehrdduhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudehtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhohhhnrdhgrghrrhihsehhuhgrfigv
 ihdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
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

Instead of walking the list of children of an ACPI device directly,
use acpi_dev_for_each_child() to carry out an action for all of
the given ACPI device's children.

This will help to eliminate the children list head from struct
acpi_device as it is redundant and it is used in questionable ways
in some places (in particular, locking is needed for walking the
list pointed to it safely, but it is often missing).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: John Garry <john.garry@huawei.com>
---

-> v2:
   * Drop unused local variable (John).
   * Add ACK from John.

---
 drivers/bus/hisi_lpc.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/bus/hisi_lpc.c
===================================================================
--- linux-pm.orig/drivers/bus/hisi_lpc.c
+++ linux-pm/drivers/bus/hisi_lpc.c
@@ -471,6 +471,12 @@ static int hisi_lpc_acpi_remove_subdev(s
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
@@ -480,13 +486,9 @@ struct hisi_lpc_acpi_cell {
 
 static void hisi_lpc_acpi_remove(struct device *hostdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(hostdev);
-	struct acpi_device *child;
-
 	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
-
-	list_for_each_entry(child, &adev->children, node)
-		acpi_device_clear_enumerated(child);
+	acpi_dev_for_each_child(ACPI_COMPANION(hostdev),
+				hisi_lpc_acpi_clear_enumerated, NULL);
 }
 
 /*



