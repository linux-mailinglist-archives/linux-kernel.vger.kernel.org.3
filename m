Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8D4FC493
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349393AbiDKTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349356AbiDKTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:06:41 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EC622BCB;
        Mon, 11 Apr 2022 12:04:25 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 6a6057b4c9296088; Mon, 11 Apr 2022 21:04:24 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B483766BDFD;
        Mon, 11 Apr 2022 21:04:23 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 14/20] ACPICA: executer/exsystem: Inform users about ACPI spec violation
Date:   Mon, 11 Apr 2022 20:59:00 +0200
Message-ID: <22622452.6Emhk5qWAg@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Menzel <pmenzel@molgen.mpg.de>

ACPICA commit 05ba545ce7859392250b18c10081db25c90ed8d7

Values greater than 100 microseconds violate the ACPI specification, so
warn users about it.

From ACPI Specification version 6.2 Errata A, 19.6.128 *Stall (Stall for
a Short Time)*:

> The implementation of Stall is OS-specific, but must not relinquish
> control of the processor. Because of this, delays longer than 100
> microseconds must use Sleep instead of Stall.

Link: https://github.com/acpica/acpica/commit/05ba545c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 exsystem.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -Nurp linux.before_name/drivers/acpi/acpica/exsystem.c linux.after_name/drivers/acpi/acpica/exsystem.c
--- linux.before_name/drivers/acpi/acpica/exsystem.c	2022-04-01 18:26:39.407241333 +0200
+++ linux.after_name/drivers/acpi/acpica/exsystem.c	2022-04-01 18:26:35.905285106 +0200
@@ -137,6 +137,11 @@ acpi_status acpi_ex_system_do_stall(u32
 			    "Time parameter is too large (%u)", how_long_us));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
+		if (how_long_US > 100) {
+			ACPI_WARNING((AE_INFO,
+				      "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
+				      how_long_us));
+		}
 		acpi_os_stall(how_long_us);
 	}
 



