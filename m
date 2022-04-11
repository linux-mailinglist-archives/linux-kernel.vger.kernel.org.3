Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1292F4FC4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349496AbiDKTIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349499AbiDKTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:40 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942103467B;
        Mon, 11 Apr 2022 12:04:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 0df72b2669e94012; Mon, 11 Apr 2022 21:04:47 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B7DD166BDFC;
        Mon, 11 Apr 2022 21:04:46 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 01/20] ACPICA: Add support for the Windows 11 _OSI string
Date:   Mon, 11 Apr 2022 20:47:00 +0200
Message-ID: <4750716.31r3eYUQgx@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

ACPICA commit f2e9fb8345b9146a67f8c63474b65ccfc06d962a

See https://github.com/microsoft_docs/windows-driver-docs/commit/a061e31fd77c20cc8e6eb0234e5d3a83e417f48

Link: https://github.com/acpica/acpica/commit/f2e9fb83
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utosi.c |    1 +
 include/acpi/actypes.h      |    1 +
 2 files changed, 2 insertions(+)

Index: linux-pm/drivers/acpi/acpica/utosi.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utosi.c
+++ linux-pm/drivers/acpi/acpica/utosi.c
@@ -74,6 +74,7 @@ static struct acpi_interface_info acpi_d
 	{"Windows 2018.2", NULL, 0, ACPI_OSI_WIN_10_RS5},	/* Windows 10 version 1809 - Added 11/2018 */
 	{"Windows 2019", NULL, 0, ACPI_OSI_WIN_10_19H1},	/* Windows 10 version 1903 - Added 08/2019 */
 	{"Windows 2020", NULL, 0, ACPI_OSI_WIN_10_20H1},	/* Windows 10 version 2004 - Added 08/2021 */
+	{"Windows 2021", NULL, 0, ACPI_OSI_WIN_11},	/* Windows 11 - Added 01/2022 */
 
 	/* Feature Group Strings */
 
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -1303,6 +1303,7 @@ typedef enum {
 #define ACPI_OSI_WIN_10_RS5             0x13
 #define ACPI_OSI_WIN_10_19H1            0x14
 #define ACPI_OSI_WIN_10_20H1            0x15
+#define ACPI_OSI_WIN_11                 0x16
 
 /* Definitions of getopt */
 



