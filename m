Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B14D1E22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348605AbiCHRGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347452AbiCHRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:06:36 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE752B2F;
        Tue,  8 Mar 2022 09:05:37 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 213F5C80062;
        Tue,  8 Mar 2022 18:05:36 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1646759135; x=1648573536; bh=v8
        Gafrob0/Kz/yI15NCg2/dUjPPAIoHTk3asLzSV18Y=; b=Dl0cAr3srcNpaN0dBg
        kGehFcvvfCL/Rpi2Z6BrsDOqRJe87lpDTRzQl7lmQ6wU/TnXOUbBT7D4rAKy7l2X
        kYCEV0JYv/W8Pj0MnIKZ7o7g8TWuqjrnwTdKxNgnSHw94hwj6RBChHY5PVpcrmaU
        C4uhWvm/oD8wTnr1t+9agylSg=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Jtbc-Hjy93Z3; Tue,  8 Mar 2022 18:05:35 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id B33A4C8007D;
        Tue,  8 Mar 2022 18:05:34 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] Input/i8042: Merge quirk tables
Date:   Tue,  8 Mar 2022 18:05:21 +0100
Message-Id: <20220308170523.783284-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308170523.783284-1-wse@tuxedocomputers.com>
References: <20220308170523.783284-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge i8042 quirk tables to reduce code duplication for devices that need
more than one quirk.

Also align quirkable options with command line parameters and make vendor
wide quirks per device overwriteable on a per device basis.

Some duplication on the ASUS devices is required to mirror the exact
behaviour of the previous code.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 1125 ++++++++++++++-----------
 1 file changed, 640 insertions(+), 485 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 148a7c5fd0e2..689b9ee3e742 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -67,675 +67,821 @@ static inline void i8042_write_command(int val)
 
 #include <linux/dmi.h>
 
-static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
+#define SERIO_QUIRK_NOKBD		BIT(0)
+#define SERIO_QUIRK_NOAUX		BIT(1)
+#define SERIO_QUIRK_NOMUX		BIT(2)
+#define SERIO_QUIRK_FORCEMUX		BIT(3)
+#define SERIO_QUIRK_UNLOCK		BIT(4)
+#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
+#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
+#define SERIO_QUIRK_RESET_NEVER		BIT(7)
+#define SERIO_QUIRK_DIECT		BIT(8)
+#define SERIO_QUIRK_DUMBKBD		BIT(9)
+#define SERIO_QUIRK_NOLOOP		BIT(10)
+#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
+#define SERIO_QUIRK_KBDRESET		BIT(12)
+#define SERIO_QUIRK_DRITEK		BIT(13)
+#define SERIO_QUIRK_NOPNP		BIT(14)
+
+/* Quirk table for different mainboards. Options similar or identical to i8042
+ * module parameters.
+ * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
+ * This allows entries to overwrite vendor wide quirks on a per device basis.
+ * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
+ * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
+ */
+static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 	{
-		/*
-		 * Arima-Rioworks HDAMB -
-		 * AUX LOOP command does not raise AUX IRQ
-		 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "RIOWORKS"),
-			DMI_MATCH(DMI_BOARD_NAME, "HDAMB"),
-			DMI_MATCH(DMI_BOARD_VERSION, "Rev E"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* ASUS G1S */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER | SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* ASUS P65UP5 - AUX LOOP command does not raise AUX IRQ */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "P/I-P65UP5"),
-			DMI_MATCH(DMI_BOARD_VERSION, "REV 2.X"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER | SERIO_QUIRK_NOLOOP)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
 	},
 	{
+		/* Asus X450LCP */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
 	},
 	{
+		/* Asus X450LCP */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* Dell Embedded Box PC 3000 */
+		/* Asus X450LCP */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* OQO Model 01 */
+		/* ASUS ZenBook UX425UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* ULI EV4873 - AUX LOOP does not work properly */
+		/* ASUS ZenBook UX425UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ULI"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "EV4873"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* Microsoft Virtual Machine */
+		/* ASUS ZenBook UX425UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER)
 	},
 	{
-		/* Medion MAM 2070 */
+		/* ASUS ZenBook UM325UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "MAM 2070"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* Medion Akoya E7225 */
+		/* ASUS ZenBook UM325UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* Blue FB5601 */
+		/* ASUS ZenBook UM325UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER)
 	},
+	/*
+	 * On some Asus laptops, just running self tests cause problems.
+	 */
 	{
-		/* Gigabyte M912 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M912"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* Gigabyte M1022M netbook */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co.,Ltd."),
-			DMI_MATCH(DMI_BOARD_NAME, "M1022E"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.02"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
 	},
 	{
-		/* Gigabyte Spring Peak - defines wrong chassis type */
+		/* ASUS P65UP5 - AUX LOOP command does not raise AUX IRQ */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Spring Peak"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P/I-P65UP5"),
+			DMI_MATCH(DMI_BOARD_VERSION, "REV 2.X"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Gigabyte T1005 - defines wrong chassis type ("Other") */
+		/* ASUS G1S */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T1005"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Gigabyte T1005M/P - defines wrong chassis type ("Other") */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T1005M/P"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
+		/* Acer Aspire 5710 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv9700"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
+		/* Acer Aspire 7738 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
+		/* Acer Aspire 5536 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ByteSpeed LLC"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{ }
-};
-
-/*
- * Some Fujitsu notebooks are having trouble with touchpads if
- * active multiplexing mode is activated. Luckily they don't have
- * external PS/2 ports so we can safely disable it.
- * ... apparently some Toshibas don't like MUX mode either and
- * die horrible death on reboot.
- */
-static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 	{
-		/* Fujitsu Lifebook P7010/P7010D */
+		/*
+		 * Acer Aspire 5738z
+		 * Touchpad stops working in mux mode when dis- + re-enabled
+		 * with the touchpad enable/disable toggle hotkey
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Fujitsu Lifebook P7010 */
+		/* Acer Aspire One 150 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu Lifebook P5020D */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu Lifebook S2000 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu Lifebook S6230 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu Lifebook T725 laptop */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu Lifebook U745 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu T70H */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Fujitsu-Siemens Lifebook T3010 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
+	/*
+	 * Some Wistron based laptops need us to explicitly enable the 'Dritek
+	 * keyboard extension' to make their extra keys start generating scancodes.
+	 * Originally, this was just confined to older laptops, but a few Acer laptops
+	 * have turned up in 2007 that also need this again.
+	 */
 	{
-		/* Fujitsu-Siemens Lifebook E4010 */
+		/* Acer Aspire 5100 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
-		/* Fujitsu-Siemens Amilo Pro 2010 */
+		/* Acer Aspire 5610 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
-		/* Fujitsu-Siemens Amilo Pro 2030 */
+		/* Acer Aspire 5630 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
-		/*
-		 * No data is coming from the touchscreen unless KBC
-		 * is in legacy mode.
-		 */
-		/* Panasonic CF-29 */
+		/* Acer Aspire 5650 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
-		/*
-		 * HP Pavilion DV4017EA -
-		 * errors on MUX ports are reported without raising AUXDATA
-		 * causing "spurious NAK" messages.
-		 */
+		/* Acer Aspire 5680 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
-		/*
-		 * HP Pavilion ZT1000 -
-		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
-		 */
+		/* Acer Aspire 5720 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
-		/*
-		 * HP Pavilion DV4270ca -
-		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
-		 */
+		/* Acer Aspire 9110 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
+		/* Acer TravelMate 660 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
+		/* Acer TravelMate 2490 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
+		/* Acer TravelMate 4280 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
 	{
+		/* Amoi M636/A737 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Sharp Actius MM20 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ByteSpeed LLC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Sony Vaio FS-115b */
+		/* Compal HEL80I */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
+			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/*
-		 * Sony Vaio FZ-240E -
-		 * reset and GET ID commands issued via KBD port are
-		 * sometimes being delivered to AUX3.
-		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/*
-		 * Most (all?) VAIOs do not have external PS/2 ports nor
-		 * they implement active multiplexing properly, and
-		 * MUX discovery usually messes up keyboard/touchpad.
-		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Amoi M636/A737 */
+		/* Advent 4211 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
+			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Lenovo 3000 n100 */
+		/* Dell Embedded Box PC 3000 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Lenovo XiaoXin Air 12 */
+		/* Dell XPS M1530 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
+		/* Dell Vostro 1510 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 5710 */
+		/* Dell Vostro V13 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
 	},
 	{
-		/* Acer Aspire 7738 */
+		/* Dell Vostro 1320 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Gericom Bellagio */
+		/* Dell Vostro 1520 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* IBM 2656 */
+		/* Dell Vostro 1720 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Dell XPS M1530 */
+		/* Entroware Proteus */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS)
 	},
+	/*
+	 * Some Fujitsu notebooks are having trouble with touchpads if
+	 * active multiplexing mode is activated. Luckily they don't have
+	 * external PS/2 ports so we can safely disable it.
+	 * ... apparently some Toshibas don't like MUX mode either and
+	 * die horrible death on reboot.
+	 */
 	{
-		/* Compal HEL80I */
+		/* Fujitsu Lifebook P7010/P7010D */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Dell Vostro 1510 */
+		/* Fujitsu Lifebook P5020D */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 5536 */
+		/* Fujitsu Lifebook S2000 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Dell Vostro V13 */
+		/* Fujitsu Lifebook S6230 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Newer HP Pavilion dv4 models */
+		/* Fujitsu Lifebook T725 laptop */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
 	},
 	{
-		/* Asus X450LCP */
+		/* Fujitsu Lifebook U745 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Avatar AVIU-145A6 */
+		/* Fujitsu T70H */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* TUXEDO BU1406 */
+		/* Fujitsu A544 laptop */
+		/* https://bugzilla.redhat.com/show_bug.cgi?id=1111138 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK A544"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
 	},
 	{
-		/* Lenovo LaVie Z */
+		/* Fujitsu AH544 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
 	},
 	{
-		/*
-		 * Acer Aspire 5738z
-		 * Touchpad stops working in mux mode when dis- + re-enabled
-		 * with the touchpad enable/disable toggle hotkey
-		 */
+		/* Fujitsu U574 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
 	},
 	{
-		/* Entroware Proteus */
+		/* Fujitsu UH554 laptop */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
 	},
-	{ }
-};
-
-static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
 	{
-		/*
-		 * Sony Vaio VGN-CS series require MUX or the touch sensor
-		 * buttons will disturb touchpad operation
-		 */
+		/* Fujitsu Lifebook P7010 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{ }
-};
-
-/*
- * On some Asus laptops, just running self tests cause problems.
- */
-static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
 	{
+		/* Fujitsu-Siemens Lifebook T3010 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
 		},
-	}, {
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Lifebook E4010 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{ }
-};
-static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 	{
-		/* MSI Wind U-100 */
+		/* Fujitsu-Siemens Amilo Pro 2010 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* LG Electronics X110 */
+		/* Fujitsu-Siemens Amilo Pro 2030 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "X110"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire One 150 */
+		/* Gigabyte M912 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M912"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
+		/* Gigabyte Spring Peak - defines wrong chassis type */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Spring Peak"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
+		/* Gigabyte T1005 - defines wrong chassis type ("Other") */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T1005"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
+		/* Gigabyte T1005M/P - defines wrong chassis type ("Other") */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T1005M/P"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
+	/*
+	 * Some laptops need keyboard reset before probing for the trackpad to get
+	 * it detected, initialised & finally work.
+	 */
 	{
+		/* Gigabyte P35 v2 - Elantech touchpad */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+		{
+		/* Aorus branded Gigabyte X3 Plus - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
 	},
 	{
+		/* Gigabyte P34 - Elantech touchpad */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
 	},
 	{
+		/* Gigabyte P57 - Elantech touchpad */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
 	},
 	{
+		/* Gericom Bellagio */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Advent 4211 */
+		/* Gigabyte M1022M netbook */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co.,Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "M1022E"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.02"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Medion Akoya Mini E1210 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv9700"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Medion Akoya E1222 */
+		/*
+		 * HP Pavilion DV4017EA -
+		 * errors on MUX ports are reported without raising AUXDATA
+		 * causing "spurious NAK" messages.
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Mivvy M310 */
+		/*
+		 * HP Pavilion ZT1000 -
+		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Dell Vostro 1320 */
+		/*
+		 * HP Pavilion DV4270ca -
+		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Dell Vostro 1520 */
+		/* Newer HP Pavilion dv4 models */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
 	},
 	{
-		/* Dell Vostro 1720 */
+		/* IBM 2656 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Lenovo Ideapad U455 */
+		/* Avatar AVIU-145A6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Intel MBO Desktop D845PESV */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * Intel NUC D54250WYK - does not have i8042 controller but
+		 * declares PS/2 devices in DSDT.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Lenovo 3000 n100 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Lenovo ThinkPad L460 */
+		/* Lenovo XiaoXin Air 12 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
+		/* Lenovo LaVie Z */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo Ideapad U455 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
 		/* Lenovo ThinkPad Twist S230u */
@@ -743,275 +889,269 @@ static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Entroware Proteus */
+		/* LG Electronics X110 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "X110"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
-	{ }
-};
-
-#ifdef CONFIG_PNP
-static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
 	{
-		/* Intel MBO Desktop D845PESV */
+		/* Medion Akoya Mini E1210 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/*
-		 * Intel NUC D54250WYK - does not have i8042 controller but
-		 * declares PS/2 devices in DSDT.
-		 */
+		/* Medion Akoya E1222 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
 		/* MSI Wind U-100 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
 			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOPNP)
 	},
 	{
-		/* Acer Aspire 5 A515 */
+		/*
+		 * No data is coming from the touchscreen unless KBC
+		 * is in legacy mode.
+		 */
+		/* Panasonic CF-29 */
 		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{ }
-};
-
-static const struct dmi_system_id __initconst i8042_dmi_laptop_table[] = {
 	{
+		/* Medion Akoya E7225 */
 		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
+			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
+		/* Microsoft Virtual Machine */
 		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
+		/* Medion MAM 2070 */
 		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MAM 2070"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
+		/* TUXEDO BU1406 */
 		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{ }
-};
-#endif
-
-static const struct dmi_system_id __initconst i8042_dmi_notimeout_table[] = {
 	{
-		/* Dell Vostro V13 */
+		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
 	{
-		/* Newer HP Pavilion dv4 models */
+		/* OQO Model 01 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Fujitsu A544 laptop */
-		/* https://bugzilla.redhat.com/show_bug.cgi?id=1111138 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK A544"),
+			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Fujitsu AH544 laptop */
-		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		/* Acer Aspire 5 A515 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
+			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
 	},
 	{
-		/* Fujitsu Lifebook T725 laptop */
+		/* ULI EV4873 - AUX LOOP does not work properly */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ULI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EV4873"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Fujitsu U574 laptop */
-		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		/*
+		 * Arima-Rioworks HDAMB -
+		 * AUX LOOP command does not raise AUX IRQ
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "RIOWORKS"),
+			DMI_MATCH(DMI_BOARD_NAME, "HDAMB"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Rev E"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{
-		/* Fujitsu UH554 laptop */
+		/* Sharp Actius MM20 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
+			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{ }
-};
-
-/*
- * Some Wistron based laptops need us to explicitly enable the 'Dritek
- * keyboard extension' to make their extra keys start generating scancodes.
- * Originally, this was just confined to older laptops, but a few Acer laptops
- * have turned up in 2007 that also need this again.
- */
-static const struct dmi_system_id __initconst i8042_dmi_dritek_table[] = {
 	{
-		/* Acer Aspire 5100 */
+		/*
+		 * Sony Vaio FZ-240E -
+		 * reset and GET ID commands issued via KBD port are
+		 * sometimes being delivered to AUX3.
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 5610 */
+		/*
+		 * Most (all?) VAIOs do not have external PS/2 ports nor
+		 * they implement active multiplexing properly, and
+		 * MUX discovery usually messes up keyboard/touchpad.
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 5630 */
+		/* Sony Vaio FS-115b */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 5650 */
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCEMUX)
 	},
 	{
-		/* Acer Aspire 5680 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 5720 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer Aspire 9110 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
 	{
-		/* Acer TravelMate 660 */
+		/* Mivvy M310 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
+	/*
+	 * Some laptops need keyboard reset before probing for the trackpad to get
+	 * it detected, initialised & finally work.
+	 */
 	{
-		/* Acer TravelMate 2490 */
+		/* Schenker XMG C504 - Elantech touchpad */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
+			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
 	},
 	{
-		/* Acer TravelMate 4280 */
+		/* Blue FB5601 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
+			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
 		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	{ }
 };
 
-/*
- * Some laptops need keyboard reset before probing for the trackpad to get
- * it detected, initialised & finally work.
- */
-static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
-	{
-		/* Gigabyte P35 v2 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
-		},
-	},
-		{
-		/* Aorus branded Gigabyte X3 Plus - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
-		},
-	},
-	{
-		/* Gigabyte P34 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
-		},
-	},
+#ifdef CONFIG_PNP
+static const struct dmi_system_id __initconst i8042_dmi_laptop_table[] = {
 	{
-		/* Gigabyte P57 - Elantech touchpad */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
 		},
 	},
 	{
-		/* Schenker XMG C504 - Elantech touchpad */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
 		},
 	},
-	{ }
-};
-
-static const struct dmi_system_id i8042_dmi_probe_defer_table[] __initconst = {
 	{
-		/* ASUS ZenBook UX425UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
 		},
 	},
 	{
-		/* ASUS ZenBook UM325UA */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
 		},
 	},
 	{ }
 };
+#endif
 
 #endif /* CONFIG_X86 */
 
@@ -1167,11 +1307,6 @@ static int __init i8042_pnp_init(void)
 	bool pnp_data_busted = false;
 	int err;
 
-#ifdef CONFIG_X86
-	if (dmi_check_system(i8042_dmi_nopnp_table))
-		i8042_nopnp = true;
-#endif
-
 	if (i8042_nopnp) {
 		pr_info("PNP detection disabled\n");
 		return 0;
@@ -1277,6 +1412,9 @@ static inline void i8042_pnp_exit(void) { }
 
 static int __init i8042_platform_init(void)
 {
+	bool i8042_reset_always_quirk = false;
+	bool i8042_reset_never_quirk = false;
+	const struct dmi_system_id *device_quirk_info;
 	int retval;
 
 #ifdef CONFIG_X86
@@ -1297,6 +1435,44 @@ static int __init i8042_platform_init(void)
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
+#ifdef CONFIG_X86
+	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
+	if (device_quirk_info) {
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOKBD)
+			i8042_nokbd = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOAUX)
+			i8042_noaux = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOMUX)
+			i8042_nomux = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_FORCEMUX)
+			i8042_nomux = false;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_UNLOCK)
+			i8042_unlock = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_PROBE_DEFER)
+			i8042_probe_defer = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_RESET_ALWAYS)
+			i8042_reset_always_quirk = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_RESET_NEVER)
+			i8042_reset_never_quirk = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DIECT)
+			i8042_direct = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DUMBKBD)
+			i8042_dumbkbd = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOLOOP)
+			i8042_noloop = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOTIMEOUT)
+			i8042_notimeout = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_KBDRESET)
+			i8042_kbdreset = true;
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DRITEK)
+			i8042_dritek = true;
+#ifdef CONFIG_PNP
+		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOPNP)
+			i8042_nopnp = true;
+#endif
+	}
+#endif
+
 	retval = i8042_pnp_init();
 	if (retval)
 		return retval;
@@ -1308,34 +1484,13 @@ static int __init i8042_platform_init(void)
 #ifdef CONFIG_X86
 	/* Honor module parameter when value is not default */
 	if (i8042_reset == I8042_RESET_DEFAULT) {
-		if (dmi_check_system(i8042_dmi_reset_table))
+		if (i8042_reset_always_quirk)
 			i8042_reset = I8042_RESET_ALWAYS;
 
-		if (dmi_check_system(i8042_dmi_noselftest_table))
+		if (i8042_reset_never_quirk)
 			i8042_reset = I8042_RESET_NEVER;
 	}
 
-	if (dmi_check_system(i8042_dmi_noloop_table))
-		i8042_noloop = true;
-
-	if (dmi_check_system(i8042_dmi_nomux_table))
-		i8042_nomux = true;
-
-	if (dmi_check_system(i8042_dmi_forcemux_table))
-		i8042_nomux = false;
-
-	if (dmi_check_system(i8042_dmi_notimeout_table))
-		i8042_notimeout = true;
-
-	if (dmi_check_system(i8042_dmi_dritek_table))
-		i8042_dritek = true;
-
-	if (dmi_check_system(i8042_dmi_kbdreset_table))
-		i8042_kbdreset = true;
-
-	if (dmi_check_system(i8042_dmi_probe_defer_table))
-		i8042_probe_defer = true;
-
 	/*
 	 * A20 was already enabled during early kernel init. But some buggy
 	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
-- 
2.25.1

