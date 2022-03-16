Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB32C4DAFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355751AbiCPMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355713AbiCPMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:40:34 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4B5AEE5;
        Wed, 16 Mar 2022 05:39:18 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id e2f96ae570f65f18; Wed, 16 Mar 2022 13:39:17 +0100
Received: from kreacher.localnet (unknown [213.134.162.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F1B0066B8A9;
        Wed, 16 Mar 2022 13:39:15 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 2/2] ACPI: bus: Avoid using CPPC if not supported by firmware
Date:   Wed, 16 Mar 2022 13:39:03 +0100
Message-ID: <2107550.irdbgypaU6@kreacher>
In-Reply-To: <4734682.31r3eYUQgx@kreacher>
References: <4734682.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.1
X-CLIENT-HOSTNAME: 213.134.162.1
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudefvddggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduiedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddruddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghr
 sggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the platform firmware indicates that it does not support CPPC by
clearing the OSC_SB_CPC_SUPPORT and OSC_SB_CPCV2_SUPPORT bits in the
platform _OSC capabilities mask, avoid attempting to evaluate _CPC
which may fail in that case.

Because the OSC_SB_CPC_SUPPORT and OSC_SB_CPCV2_SUPPORT bits are only
added to the supported platform capabilities mask on x86, when
X86_FEATURE_HWP is supported, allow _CPC to be evaluated regardless
in the other cases.

Link: https://lore.kernel.org/linux-acpi/CAJZ5v0i=ecAksq0TV+iLVObm-=fUfdqPABzzkgm9K6KxO1ZCcg@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c       |    8 ++++++++
 drivers/acpi/cppc_acpi.c |    3 +++
 include/linux/acpi.h     |    1 +
 3 files changed, 12 insertions(+)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -284,6 +284,8 @@ EXPORT_SYMBOL_GPL(osc_pc_lpi_support_con
 bool osc_sb_native_usb4_support_confirmed;
 EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
+bool osc_sb_cppc_not_supported;
+
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
@@ -339,6 +341,12 @@ static void acpi_bus_osc_negotiate_platf
 		return;
 	}
 
+#ifdef CONFIG_X86
+	if (boot_cpu_has(X86_FEATURE_HWP))
+		osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
+				(OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));
+#endif
+
 	/*
 	 * Now run _OSC again with query flag clear and with the caps
 	 * supported by both the OS and the platform.
Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -656,6 +656,9 @@ int acpi_cppc_processor_probe(struct acp
 	acpi_status status;
 	int ret = -EFAULT;
 
+	if (osc_sb_cppc_not_supported)
+		return -ENODEV;
+
 	/* Parse the ACPI _CPC table for this CPU. */
 	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
 			ACPI_TYPE_PACKAGE);
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -580,6 +580,7 @@ acpi_status acpi_run_osc(acpi_handle han
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
 extern bool osc_sb_native_usb4_support_confirmed;
+extern bool osc_sb_cppc_not_supported;
 
 /* USB4 Capabilities */
 #define OSC_USB_USB3_TUNNELING			0x00000001



