Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E701158AEDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiHER1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiHER1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:27:35 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7A186F7;
        Fri,  5 Aug 2022 10:27:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id de963a4a6f2d3e75; Fri, 5 Aug 2022 19:27:32 +0200
Received: from kreacher.localnet (public-gprs522492.centertel.pl [31.61.160.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C219866CECD;
        Fri,  5 Aug 2022 19:27:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-rtc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0
Date:   Fri, 05 Aug 2022 19:27:30 +0200
Message-ID: <4771532.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 31.61.160.61
X-CLIENT-HOSTNAME: public-gprs522492.centertel.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepfedurdeiuddrudeitddriedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdeiuddrudeitddriedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrrdiiuhhmmhhosehtohifvghrthgvtghhrdhithdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
 pehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
use low-power S0 idle on the given platform than S3 (provided that
the latter is supported) and it doesn't preclude using either of
them (which of them will be used depends on the choices made by user
space).

For this reason, there is no benefit from checking that flag in
use_acpi_alarm_quirks().

First off, it cannot be a bug to do S3 with use_acpi_alarm set,
because S3 can be used on systems with ACPI_FADT_LOW_POWER_S0 and it
must work if really supported, so the ACPI_FADT_LOW_POWER_S0 check is
not needed to protect the S3-capable systems from failing.

Second, suspend-to-idle can be carried out on a system with
ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
use_acpi_alarm is needed to handle that case correctly, it should be
set regardless of the ACPI_FADT_LOW_POWER_S0 value.

Accodringly, drop the ACPI_FADT_LOW_POWER_S0 check from
use_acpi_alarm_quirks().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/rtc/rtc-cmos.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-pm.orig/drivers/rtc/rtc-cmos.c
+++ linux-pm/drivers/rtc/rtc-cmos.c
@@ -1260,9 +1260,6 @@ static void use_acpi_alarm_quirks(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
-		return;
-
 	if (!is_hpet_enabled())
 		return;
 



